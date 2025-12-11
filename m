Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B98D41C09
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A589683CBD;
	Thu, 11 Dec 2025 11:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PDKNI+aw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F71807C0; Thu, 11 Dec 2025 08:18:37 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712B183B48
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDT6acAQ61MFsvokwpxg03LqIYGh9GUteRxG/dHEnFdKx53Jeso8XOE+y1huRelrMQr22cuKnYA00E1mGwvd4saM0v/+Lqq2kzYQ43xsVw3tWeaxWP2xoEAdTPpN68xIkLO2PA7/FeFuE4tZnpYy8DFYU+/VtFmT8qejVHYa2TxS/A6OmlsB8dG8hnppxbxEy+k0TKijJON0WvoWbJSy4tHArkwbWVjhrI9Derrghc1cWgEJR+4Med0ZAKUMKtBnxikUBwHcT4F3e2aiMF9kGy2yfH0mzdtlWUren/xztggcQlOdePWHsZnfovVohSxJxpZJJdxhzHqA85E19vEHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ROQOv6/su+A6tqHKhMJljwCQHbOt5tWqTbAhrWxxyM=;
 b=gaMsobNJiD5wvKD0V5KCTHkkHRtOi5+s2WJLKGVwJT6hr98n9O4HuTS5myuCMk216+JmimbstuxtWGs23YgYixt+i+0c4TqYoCy5Hdh7pNyBUZ+/z2tIvoRxuU7SW0fRgHD6zi7A1+PI/SUUp8RhNtEwuD2BwRdkbSQduG7U83chpXvIEZJerf3rqaBbTQULea6v08a7gT5TI9PvGoDeTM4QRtgaQzWBF4ILocW/z4XI41lIsUXUv3F2fY4t/+n7H0FlRjVUh+wcGm/YiuBBXjIBr+wDstYoLwIvpLvPGKkH3I6P+nZHAGhShdJqcvAASZoennm98w2uN6x+mXEF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ROQOv6/su+A6tqHKhMJljwCQHbOt5tWqTbAhrWxxyM=;
 b=PDKNI+aw2uORfW4ZSEjYB6Gxaq/csNvjG/uKJZ0BayfSxIjq1R75nS8ksbCkxrqrlZNFA5ql9pEr+03lyyyAKlTtdLOu29t7Egyzr7ucNiHv5GLE1OgwGd3WvP23zsNOEggjPnn7zGF7IjZXZ06XqXwFGARp0VUMaOLiVRI3frxXHcoivQ0PLq0tTHRYMjQcdhAxT0nf+kiG4dYhhvZchrRAz1ull/t9/hc1Fpe9od6uUFivXfauxRVFASUxc8UG8VDKk3KpSKVmlKTcijJR17qgMfJ1RBIyNMH33+OzHTG2ru9dB9hia2uL7uX1xuaBhPAKlQfsYJlQQwxZWWRBgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB9920.eurprd04.prod.outlook.com (2603:10a6:10:4dd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 07:18:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 07:18:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 11 Dec 2025 16:31:44 +0800
Subject: [PATCH 2/2] clk: imx95-blk-ctrl: Resolve scmi clk before using it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-clk-scmi-imx-fix-v1-2-9579567da829@nxp.com>
References: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
In-Reply-To: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUZPR04MB9920:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cecade-7fa2-4e1f-d542-08de38857e0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2FnU2RmSWdwb2ZhVmNKU3JEUndnSjh5RG9sY3BlNzdUc2ErN1FHRlBKNFRl?=
 =?utf-8?B?alozelIwVTlySktRQUlOM05SalpNSWdvVGZEa2JWeHlkUUp4eUhkclNSOEVT?=
 =?utf-8?B?Um8rTENFYzljbE5vY2pqcGsyTDBCeVhURWFXV0J5YnZMbFpEeW1tbmxHcXNo?=
 =?utf-8?B?MlAzR2xJTGxsS0xEQmh6eEFnQnR5cWpBNitaZFpMcUFsUFBjeHpLbGtQVlFz?=
 =?utf-8?B?RFdXS1pOUThqcDNEeFNtVFZsZXdqVW9kVjdsT0pENW03b2ZuNVFlUUIweHVq?=
 =?utf-8?B?QWpTa2RnYVFhWEV2VzJzMVhpbEV2dEg3cmVtM1RLUFdXQmxERWFudFB4S0dh?=
 =?utf-8?B?b3RPS0U1Z1J1QURDUnV6R0ZucXM0Zks3ekNuUUZOVXhXWE0zbUdLT2lwQ3lX?=
 =?utf-8?B?bjhTQUFJa0RqTWlXeFBXbWZSM0tpMmhMNElPdTZnejRKTUpEVTlMY3k0TGt2?=
 =?utf-8?B?Q1RuUTdIRWhQV3MzUWdJMjIvYTN3eHJZSjFXbkM5V1JEY2RCb0FuV1Vwc2ls?=
 =?utf-8?B?UW9JaDJGTmRWTksvbC9LNVV6TU5vdEtIaHFPWDlOZXZDWXJuVjN2YXRmcjJ3?=
 =?utf-8?B?NGxQakkxdDlMZmNvSkFkVjRzZjZJQjdTYWpRQjhyNkF5SXpGb0pOSStlaUh6?=
 =?utf-8?B?NW91V3VqU2N6cmczc1pkTTdoUWJNb3Z4S3ZjbVJWSGhPZWlaZlVVRTBzNlp4?=
 =?utf-8?B?RGZla3VLeFY0ZWVrdlJSREp6R1A5RS8vSnBhdnNmaEF3anVxdHNYeW9XVzJp?=
 =?utf-8?B?YnZHQjZQdUZEUER6UG8zb0tSaExtandLZGhaa2lYQTZBQTk0VXFQZUFKdzFv?=
 =?utf-8?B?dFFpZlVIcUwwamZkcW9LQ2RESmFFZlhOVzVzSTFDcHpuanFScHRQakhTM2Ft?=
 =?utf-8?B?dWM5VjRNZFd2MWlPWnV3TnFYb3l1d2V2WGhIeUtlZk9YN1ZtRC9NbHJlMW9t?=
 =?utf-8?B?Y0F2Z2d0YVpuK3NEUnp4Y2JvaHlocVB1QnU1SXBONkUvNjE1VDY4MlhKMzlP?=
 =?utf-8?B?QUFvZ2FmVjZNcXNYSEYxYjdnc0s0d2tPQmgvdG1VTEhETzhQTldBMkZXdnNU?=
 =?utf-8?B?N3hVUE1QbVF4bnZKTGcrdkQ0aFRzRFR5V2hzYUEvd2hvS3FxVHExcFJId3pY?=
 =?utf-8?B?L1dxckxHZHROZGVaYklSSDdWV1pXOUVaTFpsMDRUeW5Ra0tUUWg1RkZ4T0ow?=
 =?utf-8?B?Y253S1NtT1JhSE8rUTZGbldxOHo0eElQY2dmOStBUnhlcmpuSGh6UWhIWVk3?=
 =?utf-8?B?UDU5UmxIYTU4aU1NV1BKL2FndHlxaCs1UjdGaGZsWG1yUDZUQVJhRXJJVHpT?=
 =?utf-8?B?RCtqSUc3VmVQRFlIMVh2VHlyU0Fhd3BCVWJncFE4cnA2VmNOSXgyeGpxNTEr?=
 =?utf-8?B?d205OWRtNGwvZHNDOEVxV1dMb1UxMzhyMVpJMk4yWEVubkFBSmJ5d051MXlQ?=
 =?utf-8?B?RWcvNXJwa0ZIMDRJb1QxR2kyVDhwZTdrUHh0dmZzMTBDUXRpNEpqQlNhTmts?=
 =?utf-8?B?VmZ1aGdYWUFMMVpRVzVhTFpsKzJjb3JtNWFRYXcyRHRLVmgxa3Z6UVhuNXFl?=
 =?utf-8?B?Q1EzZGtPck1idjZ1WkxoR0EyeGppajdDNnBEdVZ2enlUOVlFTGVlanpwYTgv?=
 =?utf-8?B?a2F5alRlRmpoQkQzZXpsRlpCVDBTQzFmY293N3VZZzV5aHhWc2ZjWTdQVmtm?=
 =?utf-8?B?MGRreU8wU1NxNmZUTFlLdDdqZFhyWjVqSHlMN2tHL3A5SThVY2sxdjJVTzMy?=
 =?utf-8?B?enkxeDF2YStTVFFwbml4L1ZJT3lFbnRWdUdqYnpLZzd3by9GWTh0bEJ2NnFy?=
 =?utf-8?B?UzRSc2dHdWdDcEpSV0pNb2FibWYyaTZkeGNRRlR6YlhINWZyclRPRlJ4ZWpB?=
 =?utf-8?B?aG5pbEdiSk9uSnVNSGVUNk4vMG1VUWVhS0VOTDVtTnV5UDhpRTJXektVcmYx?=
 =?utf-8?B?THFvaTNlRUMvZkt4QkNsbUlhcGprbGV3QVNSQkJUcjg1Q2lzWlRBN3AxUGY5?=
 =?utf-8?B?dFJFQTd0RHcwVTJIZjZaUlV1NFZkODhkUmtmK0hKUGF0WlRzN1lOVTEwWFpi?=
 =?utf-8?Q?k3LBvl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjRJQ3NCZ21nNW9qeG5VWXlYeGUwaE9iM1JvNS8xOWsyUGp0V2dvQVFRdGtw?=
 =?utf-8?B?Mlh4ZmVNWCtmRnBrUDUveXMyTmloUXZ3anBjZ3J6THg0Zjh2TEVBemkvSGVo?=
 =?utf-8?B?V1Vwd2wzMDVZY1pHOHRhUEFhbnMwWEJqYzZ0ajNLTytuaHdYOWhicUYzM0Er?=
 =?utf-8?B?Zm9JVWpmSnRlSHZ5cTQzc01tUXlZUTh2Q2JpZEMvVjJNMXdJVmovZ0V3bC9m?=
 =?utf-8?B?cDN4cHdvQk9xVlE5ellTRUNEeTR6aUpWYlFjd1kwS2VUYi9BSkVjZzZmWGsw?=
 =?utf-8?B?YlpCOWVhTHcvbWhuQVlpL2FpNmRRZ2tHaEp3V3pWRWxVaXRQUzRpa3RNcGVQ?=
 =?utf-8?B?cWpxd3pFMlBFdm14OXdZY2FHbzRzd0s3R0IvQ0k4VGRnQnl6ZDVjQmoyUDA0?=
 =?utf-8?B?S0YrTHdwcVlaY1BQZmVmMWVYWHhiajZjcDY2VXROQkZObWRFeFlqVTZCZk9s?=
 =?utf-8?B?OSsxQTV0Z1ppSnpsdUxNZmRzS3lidWV5WkF4WHZtYjBHcThmbGVyakdydjQ3?=
 =?utf-8?B?ZHRtSjZxY05UZXZUYjhZYTd6YTR3QU5tSkpib2NndTVkRmlUeFo3WHl4YXFu?=
 =?utf-8?B?c1ZOWnM5YVNmM1F4YlFMaVpmaWR1RDIwN2l6TElORHluRlA4ZnhjWkVSaWI3?=
 =?utf-8?B?MXVUSytFd0xtNlhZQjVuaGJkZnNwY1I4eEJ2ZXU4cU4zUEtBVTl2b0cvdDZL?=
 =?utf-8?B?Sm05bW1RNjlsWWMzUnBEWHhLR2NDVVQ4R01Sb01va282M0VpRVAyVkxJWjdI?=
 =?utf-8?B?OGd6ZHVzb3k5Z2VySmREK3Q4QkppWjRTa3cxd21jUzQ1aWpWYlhZb0Z4T2RN?=
 =?utf-8?B?Sno4aGNSR0liRzdwTUhDallQeU1jQUNpWEh5ZXQ3bG44WWRmZ1o4NTNnM1RU?=
 =?utf-8?B?ME00MmRzK2NneERnazdVejQ1OUF6Z3hkUU85djF4ZU91aDBMUnB4TlQ0L1Qv?=
 =?utf-8?B?c0kwL0NQOTducHhodXBvOWlGK2lKdGdBQThtRnZ5NkhkMFJFSHlXOW5NeWNi?=
 =?utf-8?B?bzRpYlgvSkpsZWhZT3REQkxtZkxSTW9vRjlGeG5NNnNhanNZNmF0eXh5Ym8x?=
 =?utf-8?B?VDczUE4xQ2NJRjlEN1RUaDRlaXNUSzVCOC81Nk9tWHZ1OW1LVXRUY0NEV2Zh?=
 =?utf-8?B?YzQ3MzgrZHYxcFpSbmZpWCtJTkFzME5QRzNleDNTUFVWaUI1Y0RiVmEwdGxF?=
 =?utf-8?B?NzdkSTlmY1BaaEZwckxDSVg2b3F6VGt0dThnekVJUkJRZlJlaWJVQWRrdEFC?=
 =?utf-8?B?bFF5aHJKQ0dIV0pQVTNicUVFZkgwZTkydUttZjJ3dDY4aEVRbG9HUG9wYU9E?=
 =?utf-8?B?TzI1enlQa1NWVmNNa0NQRnhFWjR2U3NmU1lBRnowYUp4d1BvZTdLOWNybDkx?=
 =?utf-8?B?VFVuYnZDV0htSy9jL2tBUHJkcmdsK28yRXhmNU0xTkpJejFhM3ZlUVN1eUZD?=
 =?utf-8?B?N2tWeVRGY0thTzR5NEw3dDRQVmJ4YW14RnB6NXdWUW9vdFFDQW9ialhNYXNq?=
 =?utf-8?B?VDhwdkVRa2hDc3VJQlJuRzRRUko1NG01a2t6UUQzVlZYRHJhdDYySjJwVEpL?=
 =?utf-8?B?MHJtY3Z2eU40N2NSWEpyTTEwRFp4RWZNdEJSUXVSeE5kZ2ZpL293TU0xVHBm?=
 =?utf-8?B?UjM4ZzJZUER6UGpyRldsWWRTNE5DdDlHc2pDTVFmUWJKVm1Pdkl1U010RFhF?=
 =?utf-8?B?dmxnVHdvblU4VHlQMGZxOEpkQ0syY2dyV09mSy9tb3VhdnhxMTJ0MHlkaCtp?=
 =?utf-8?B?eUZCaUFDVG1naUtCSnNUNzN1SWZBR0RCdEU3ZWViR3NrWG9DNHpEeGFweng0?=
 =?utf-8?B?d3BMSlgyQVVpR0RYRURYbXJqSWd4U3RiQk1MeDlMNFg2R1pJLzNOWW1HWHpM?=
 =?utf-8?B?Sm5WZ1JGUDVISkFNWEFjaC80ZlZxRDQxUUU1NFdKelJqWXJMZUlxK0Jlby9Z?=
 =?utf-8?B?c2MxQjR4RnUraERzMVpYYXNyclpRWkxIMDFaYzRIUm0yUTFHRitRWG1NbXg5?=
 =?utf-8?B?d3ozdVh1TERJcjZ3S3M1alBXQThBMkI4eDBaTHFMaXNhbG1qWGxncU12SmQ5?=
 =?utf-8?B?djR5dDRLSDlGN3BYV3VJeklFZ2tJQXpSSXBzQUJFUXFMUlYzTjhBMStLK3V3?=
 =?utf-8?Q?lYSu7SU2Hp+fMC1fRmqUc4GSK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cecade-7fa2-4e1f-d542-08de38857e0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 07:18:33.2119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GidNsVTpV3qCqmNY0GmuO7/QX97qYNr6yu1qu7/Eq2w2qG4jjFIZ4fVZs2Rnky5ppdMzpW28EC3WUUGzXnnJtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9920
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Peng Fan <peng.fan@nxp.com>

With commit 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES"),
there is error log:
imx95_blkctrl_clk syscon@4c0100c0: Failed to resolve clk hsiopll

clk_register use parent name "hsiopll", however this name does not
exist. The valid name at the moment is "scmi-[0-9*]". So need to first
resolve the scmi clk before using it.

Fixes: 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Makefile            |  6 ++++-
 drivers/clk/imx/clk-imx95-blkctrl.c | 48 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index f2fd6ff8ca0..619a523cf96 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -25,4 +25,8 @@ obj-$(CONFIG_$(PHASE_)CLK_IMX93) += clk-imx93.o clk-fracn-gppll.o \
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1020) += clk-imxrt1020.o
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1050) += clk-imxrt1050.o
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1170) += clk-imxrt1170.o
-obj-$(CONFIG_CLK_IMX95_BLKCTRL) += clk-imx95-blkctrl.o
+
+ifdef CONFIG_CLK_IMX95_BLKCTRL
+ccflags-y += -I$(srctree)/dts/upstream/src/arm64/freescale/
+obj-y += clk-imx95-blkctrl.o
+endif
diff --git a/drivers/clk/imx/clk-imx95-blkctrl.c b/drivers/clk/imx/clk-imx95-blkctrl.c
index 3e6f53b4a16..f6563539402 100644
--- a/drivers/clk/imx/clk-imx95-blkctrl.c
+++ b/drivers/clk/imx/clk-imx95-blkctrl.c
@@ -6,9 +6,11 @@
 
 #include <asm/io.h>
 #include <clk-uclass.h>
+#include <clk/scmi.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dt-bindings/clock/nxp,imx95-clock.h>
+#include <imx95-clock.h>
 #include <linux/clk-provider.h>
 
 #include "clk.h"
@@ -19,9 +21,11 @@ enum {
 	CLK_MUX,
 };
 
+#define MAX_NUM_PARENTS 4
 struct imx95_blk_ctl_clk_dev_data {
 	const char *name;
 	const char * const *parent_names;
+	u32 clk_parent_ids[4];
 	u32 num_parents;
 	u32 reg;
 	u32 bit_idx;
@@ -41,6 +45,7 @@ static const struct imx95_blk_ctl_clk_dev_data hsio_blk_ctl_clk_dev_data[] = {
 	[0] = {
 		.name = "hsio_blk_ctl_clk",
 		.parent_names = (const char *[]){ "hsiopll", },
+		.clk_parent_ids = { IMX95_CLK_HSIOPLL, },
 		.num_parents = 1,
 		.reg = 0,
 		.bit_idx = 6,
@@ -59,6 +64,7 @@ static const struct imx95_blk_ctl_clk_dev_data imx95_lvds_clk_dev_data[] = {
 	[IMX95_CLK_DISPMIX_LVDS_PHY_DIV] = {
 		.name = "ldb_phy_div",
 		.parent_names = (const char *[]){ "ldbpll", },
+		.clk_parent_ids = { IMX95_CLK_LDBPLL, },
 		.num_parents = 1,
 		.reg = 0,
 		.bit_idx = 0,
@@ -69,6 +75,7 @@ static const struct imx95_blk_ctl_clk_dev_data imx95_lvds_clk_dev_data[] = {
 	[IMX95_CLK_DISPMIX_LVDS_CH0_GATE] = {
 		.name = "lvds_ch0_gate",
 		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.clk_parent_ids = { ~0U, },
 		.num_parents = 1,
 		.reg = 0,
 		.bit_idx = 1,
@@ -79,6 +86,7 @@ static const struct imx95_blk_ctl_clk_dev_data imx95_lvds_clk_dev_data[] = {
 	[IMX95_CLK_DISPMIX_LVDS_CH1_GATE] = {
 		.name = "lvds_ch1_gate",
 		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.clk_parent_ids = { ~0U, },
 		.num_parents = 1,
 		.reg = 0,
 		.bit_idx = 2,
@@ -89,6 +97,7 @@ static const struct imx95_blk_ctl_clk_dev_data imx95_lvds_clk_dev_data[] = {
 	[IMX95_CLK_DISPMIX_PIX_DI0_GATE] = {
 		.name = "lvds_di0_gate",
 		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.clk_parent_ids = { ~0U, },
 		.num_parents = 1,
 		.reg = 0,
 		.bit_idx = 3,
@@ -99,6 +108,7 @@ static const struct imx95_blk_ctl_clk_dev_data imx95_lvds_clk_dev_data[] = {
 	[IMX95_CLK_DISPMIX_PIX_DI1_GATE] = {
 		.name = "lvds_di1_gate",
 		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.clk_parent_ids = { ~0U, },
 		.num_parents = 1,
 		.reg = 0,
 		.bit_idx = 4,
@@ -116,10 +126,11 @@ static const struct imx95_blk_ctl_dev_data imx95_lvds_csr_dev_data = {
 
 static int imx95_blkctrl_clk_probe(struct udevice *dev)
 {
-	int i;
+	int i, j, ret;
 	void __iomem *addr;
 	struct imx95_blk_ctl_dev_data *dev_data = (void *)dev_get_driver_data(dev);
 	const struct imx95_blk_ctl_clk_dev_data *clk_dev_data;
+	struct udevice *scmi_clk_dev;
 
 	addr = dev_read_addr_ptr(dev);
 	if (addr == (void *)FDT_ADDR_T_NONE) {
@@ -132,7 +143,42 @@ static int imx95_blkctrl_clk_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &scmi_clk_dev);
+	if (ret) {
+		dev_err(dev, "Failed to find procotol@14\n");
+		return ret;
+	}
+
 	clk_dev_data = dev_data->clk_dev_data;
+	for (i = 0; i < dev_data->num_clks; i++) {
+		ulong id;
+		if (clk_dev_data[i].clk_type == CLK_GATE ||
+		    clk_dev_data[i].clk_type == CLK_DIVIDER) {
+			if (clk_dev_data[i].clk_parent_ids[0] == ~0U)
+				continue;
+
+			id = CLK_ID(scmi_clk_dev, clk_dev_data[i].clk_parent_ids[0]);
+			ret = scmi_clk_resolve_attr(id, NULL);
+			if (ret) {
+				dev_err(dev, "Failed to resolve clk %s\n",
+					clk_dev_data[i].parent_names[0]);
+				return ret;
+			}
+		} else if (clk_dev_data[i].clk_type == CLK_MUX) {
+			for (j = 0; j < clk_dev_data[i].num_parents; j++) {
+				if (clk_dev_data[i].clk_parent_ids[j] == ~0U)
+					continue;
+				id = CLK_ID(scmi_clk_dev, clk_dev_data[i].clk_parent_ids[j]);
+				ret = scmi_clk_resolve_attr(id, NULL);
+				if (ret) {
+					dev_err(dev, "Failed to resolve clk %s\n",
+						clk_dev_data[i].parent_names[0]);
+					return ret;
+				}
+			}
+		}
+	}
+
 	for (i = 0; i < dev_data->num_clks; i++) {
 		if (clk_dev_data[i].clk_type == CLK_GATE) {
 			dev_clk_dm(dev, i,

-- 
2.51.0

