view: order_items {
  sql_table_name: demo_db.order_items ;;


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }
  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }


  measure: active_orders_users {
    type: count

  }
  parameter: client_cohort_selection {
    label: "Client Cohort Selection"
    view_label: "Client"
    description: "Choose which cohort you would like to break out the metrics by."
    type: string
    default_value: "User Name"
    allowed_value: {value: "User Name"}
    allowed_value: {value: "User City"}
    allowed_value: {value: "User Zipcode"}
    allowed_value: {value: "User Country"}
    allowed_value: {value: "User Gender"}
  }

  dimension: client_cohort_display{
    label: "Client Cohort Display"
    view_label: "Client"
    label_from_parameter: client_cohort_selection
    type: string
    sql:
    CASE WHEN ({% parameter client_cohort_selection %} = 'User Name') THEN ${users.first_name}
         WHEN ({% parameter client_cohort_selection %} = 'User City') THEN ${users.city}
         WHEN ({% parameter client_cohort_selection %} = 'User Zipcode') THEN ${users.zip}
         WHEN ({% parameter client_cohort_selection %} = 'User Country') THEN ${users.country}
         WHEN ({% parameter client_cohort_selection %} = 'User Gender') THEN ${users.gender}
    END;;
  }
}
