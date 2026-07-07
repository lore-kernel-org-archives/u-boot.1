Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E30C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 03:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1805284942;
	Tue,  7 Jul 2026 05:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DaOhq7fF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D3B84942; Tue,  7 Jul 2026 05:30:42 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468DF801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 05:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDiGz/l+VdIZZsZyaO2tiZeC5MpXhVklq+Q7nWIxqCsSEKZfL2YZ+1ULsLtc+p328TFjOu+94S6mrh3ew3eBSNWPNxzQCG89xDGUPd6ufk3aN2CWtuhBxeiZQMSFfN+6SrAbEOSWB8qYjToSbE8keyT4FThwpqcv8eWRNPpeoxJGrNsVyE7Y+ms4z16Q+mPQK+cTU1uUGqq4ng+SEt5IiT9ki8PtcmIc+zM6xeONwAY8MdVrFKWefxDiVz970/6XpzwHpCOcOJTgo51MOHXafjdS7b8csnseND8sg4G0hUk2Gmf0tpV1fxPfCn5MeIz9wwZz3OGqmPzXLlwoWc/YQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32jE8pB7nHNlM7oNY09uOntbHHbB7ffFMEwWo5WTfKA=;
 b=GHKyrvcP2WZXOq+3amN6jWxfQEL2RzFZ0g2UW13O4PoCPzPXrkAmKYFamoI23WbBe2DzVphbqG/tJXKtIbe4+S8t40jSJKh617E5AIhmsoyb5LgTgFhkx46hAosuP88jNbdiVy/nKfMXHoHWhPAvkbN8ZKqQNN4sLWBuYwdgUPkKxCX0Pg4x2oSJZk97N7ejxY1ZTRdZKz7enDX//JbYvyVcaMhLu/2p7ZZh4VAo+5dgxjgHFobtNHj73F0a7pPzYV0qo+PJJUu8yv/3ldGdhQsmfbzpMagfqkGkwdsC2BYuHjiDN+Y3sB7GKCIdm6WdT+9JGiKsmeAQ8sgqy7ClgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32jE8pB7nHNlM7oNY09uOntbHHbB7ffFMEwWo5WTfKA=;
 b=DaOhq7fFUSaT5L1P9ZK4cGMZac5tcgu6Tlu9BpkPGbcnR1GER6ZxrXn3FEH3m62HjJdu2K6bEzAcS3QPTBbOKoq9+P1+MotGFtkAPyfq/VUSS7dK49wXCIIWSngwQwEa1H3Jm+oo376uxX6ExGm6y3rvy9OR0pgS8h2Ph4n0EGvUPEqxZIUXMUUh8CZlahXtvTcAxIjktl6b/HKwbNM/TvvzCQcJ1yEII9dErxJjM7i0hcvGS1he2tQ8NTOWabyWQUMgBD/vu9inkrgCM71MbJShAC4xJIcBXNiMBTPmmIqnXVYc6FyiWQs5dUhn/xaBGIX5w+fdTjCLggQ3BlCJKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 03:30:37 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 03:30:37 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 07 Jul 2026 11:33:50 +0800
Subject: [PATCH v2 2/3] net: fsl_enetc_xpcs_phy: Add SGMII 1G support for
 i.MX95 Ethernet PHY Wrapper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-imx95-v1-2-5b4b0f03d5e3@nxp.com>
References: <20260707-imx95-v1-0-5b4b0f03d5e3@nxp.com>
In-Reply-To: <20260707-imx95-v1-0-5b4b0f03d5e3@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA0PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::19) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|AS8PR04MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 70908a93-dfa4-481f-b1a5-08dedbd81c77
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|19092799006|366016|22082099003|56012099006|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: lTv3o/pSrtVy8LNEsnT9xRD8uuBVsqCHgtG+yNls5WUSZaCWNqLo5+F7fw8efjlTLs2x/S9X2e9i7JpG5kCk7FlqeuIHAeNJHQ+YTrkbkHeCPFg5pBsnnsqOrvAcp1es+InSP23GP0meF2wyrpbnCmyOyy2Rz09dgmY9GAEgIGGq4Tt/oRbwIyW/RzkwTpyIthMmW3aJvxzBeTr0PCae56d3vLyCghQcFZy6yUNZM/8L0nA8si4a4doFXGl86nwMvF/qvgfsUhaGq6bE+8iKpVP37MvVaE6/W5xRaAmoPk8y1yLOxWpdEokTzVRVn2dCul0PI2Q7VcPJKqTVoS9eiQfP9yMpTRratpLO1UUhdMdvfN5+I3iKXKCT2hAZ3nqws1QBQWpuZKqfDEbhVa0DRKMX76MeTckXlSn+7zxZuGjWoZ71Q3ZrRhnS0L6ivvaqaJ/q0cXyh9TVlbY5obgib8dq9T2YxjTeYXUh8WI2+wOqyLMTwktNUkTAJnisLrV6neUsMBN6ZlJSyeUAqOAU7OT1PYHZeIFoNgnNgQ2n/bURpNY7wh8lQ/UZujS52b2nxK5qoCERS3xF9bP57jhb7B6VAkjiiVYSG4W5fjq4TFlkypSyD7DrxHvASn9ZA6hXlQ3H3gX1aV4+N09ytA252Y6X/v6Nd5WEqlCu5I0/X78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(22082099003)(56012099006)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUF5bWlkTkRNMTllSXZzSEVoN0lLN0c1cnBMbmtmYXJaK0dmK1hKeDVaeG1w?=
 =?utf-8?B?TTJIQW13OEpzT3d4R0FZOTVGUDNROVJXSGFiTWtoNmY2UnRiZ2E1TGZScjVy?=
 =?utf-8?B?LzhZWXZOWERxdDZNLytsY054eDYvYzg3VHZPaVhiR1pvUzVhVE45eXd3WnVR?=
 =?utf-8?B?b1VqMmpYdHUzempyVWpNZDNCMUhEdzR2b21hNGJTY0pxbjRwaEQxZmhRbWtU?=
 =?utf-8?B?VjZlUnM4V2pwY1l1TlNScXRYcjJYemxqTEovUXQyeEl0cWE4VTYvVUdWOEtL?=
 =?utf-8?B?UE1HZTJUQ2YzWWlZd3hIZXVZeWRZK3Y3Z29ad282OXNmNWk5bzVpM3BBSDRq?=
 =?utf-8?B?dEJvRm1YakdJTHNjTkg0RnFiOXdGZ0RmWG4xb3V3TkhxcTFadVBpWnV1Mjdj?=
 =?utf-8?B?SVZwY1Q5YzhpbjJBQ0JHNUFOd2RhL0VidG9RK2o3YlY0alRMNGtsQUtrRFgy?=
 =?utf-8?B?cWo5NTQxa0VMZm5EL3RiN0U2QkxYSnRuM0tqaXdPajJuc1BMYVkvQWdkVTBS?=
 =?utf-8?B?WStxdEM0RzNITWlzVm44VU1GNjBEVzdHUHJhRXFKc294Sm80R1pwQmd1SW1x?=
 =?utf-8?B?OWRiZEFUaHNNMmFoYkNpUEFzalNLU2k4b2JJbzlIZjhNWTlPSVZFNUVNSTlh?=
 =?utf-8?B?YzV3VEozYkNVcUhTaG5RMXdDVVA2U05palFuV3gwWnFWOXJ2ZkozU1hFZ0NW?=
 =?utf-8?B?K1hSQkozMGJZRUFiSDZsWk5jKzNFOWtWSm5YaGI2bHZmT3pVRmpnSjFHdGlE?=
 =?utf-8?B?bDVabEJMRnJrUGN4OUtBaDhBMnZhYW94WFd0bUlpR29HTFcvRDZSaENaUkQx?=
 =?utf-8?B?R3kyL3VwWlFlakFlZEhOTDlJTVVoU3hYcU9QZUFnUHJqN25CZ1RMYjJETGho?=
 =?utf-8?B?UjRhcWIyZ3FjZGdaRXQzS1ZNbXY1bDhVU2hDNVFEQWtvWFFaV2lJTDZiRkYz?=
 =?utf-8?B?bFIwYmhENGdxR0NtdHR3WU1RZU1iVnFEbTdhdkFndGtnVHB6M2FDWm5JeWJi?=
 =?utf-8?B?VG53d3ZuV2RKYU9VTkU5SXhlMG9MaHR4Tk15RWk1K0sxUmpQT1VnYlJmNjhu?=
 =?utf-8?B?UnV0TGJxS3o3VE5xRm55QWJEQjU2Q2NJY3N1ZzhpeEVqSEg1VnhXbHh3VSty?=
 =?utf-8?B?N0p4RE9jM1N6YjYydzVCcHREUUF4TGdkNGxrZ2FDSkQyNnpxYy9SUm11bDFF?=
 =?utf-8?B?QVpjR3o2WmtUUkxsNWZCbzBGZ0NJS3VaWUJDVDJrTzRyOHFhWTdjb0lkWUt3?=
 =?utf-8?B?cHJFZHBIVVE3L1BQUmVZTTZ0aVJzd3BsR3hkckpzVk9wQkxDL0pYbS9pSlhu?=
 =?utf-8?B?RCt5RUpTQkpFZzM4QmJ2aVc0ZFN1Z010aEQ5MnNHZGVTTVJFbE1Qa2JTMzZZ?=
 =?utf-8?B?Q2hxT2haRklwTjdOVkJkVkg2RllKL05jOXE2bFJxL2k4aGVyUFQwUXluQUNB?=
 =?utf-8?B?UE1FUDBGbGo2ODd2QkRqRmpCVzJ2bWlaaHJXeWN2L3M5VlpQbUZWQWNLTXph?=
 =?utf-8?B?cHRKanEwOWZvQTdrNHNsK0hxVmVNSlJzd2RIUis2M2g1K1ZMMk8vK0lkNmJl?=
 =?utf-8?B?UjZYSExSUWhLaGY3aEpyYmplMjdqbDFpTno0T1Q5S1g1S044UDRoRC9PM1Na?=
 =?utf-8?B?c0ZCZEFNaDhPT2tQNzdzeUI4U2dJMjlJL2JTcWRMa3lXYy9wcUdYZWR3Q2RD?=
 =?utf-8?B?SDlSZ25teVhqVktkTFFtcmtKSmJ0N3hFVGdhQ2gzdlUwSEVlQWx5eTNVUWxM?=
 =?utf-8?B?QkZuaDNxYTlDTkNEL0ZiNE1PbU5BdnRQWHRlREVnbDdnbU9xTWc4OEw4djBP?=
 =?utf-8?B?YUJVeWs1S3NhU0dDYVR1eW9ib21YNUZ6dThQelo1MjI5SW1OaDFDMmNzTUN5?=
 =?utf-8?B?Sm8xV0t1ZzBwblkzTlZ0NFBKRzBsWWVkRGgxRmxGMG1LU3VuSGhSczNEbVBj?=
 =?utf-8?B?WktmZnlBbXU2VWxtZkQyb1M5NmJvOERORmc3ZmtoY1ZnNS8ySlpBSEd3cDFX?=
 =?utf-8?B?S3hIOTZhTUljUGxXckx1RDkxKyswNWM1NWJYcGd0WHkwS1B1V2ZYWVpNakQy?=
 =?utf-8?B?UG5WODVSczdVbktUS21FeE5zV09sQWtZd3FPV0Y3Mk1Jay90aGlQRkdLMVI0?=
 =?utf-8?B?MFJVY2h3TEc5c0JrYU9IeUIveGkreExMUzFkYmtwZldwRVIzZ0Q0eFFqdnhn?=
 =?utf-8?B?WHFuQ1dYTlNKdUZFbHRtaXpnWW9iQllyOElzZ3QyOGg0Z25HMjFvQldENUJY?=
 =?utf-8?B?MW9TU1ZGclRGcytxNVl5YVloWkVBRU1QakZaUEliakh2TGFZWWtxUDloeWtS?=
 =?utf-8?B?Ky9PQzM1WlNFS2JDSnl2ZjZiZm9YTzZFMFQrQ0RaRnZLNzZwOE8xNW1zelk1?=
 =?utf-8?Q?WAs5eRh3ScuWy9E3XpBga3FSLplPJ1vVCLRWr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70908a93-dfa4-481f-b1a5-08dedbd81c77
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:30:37.2667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwiuMQK/Dyr4yOuVKElbXhXw36GxS5plNIPWZeY9jSVKYe6fyk+gh3jP2O6Ma2TprefXK72hEU7vcoRpb4QbX3hdnuAQUR6uHP8xNSgzgROzdEYrW0I13WAI+0ataxMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8008
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

From: Alice Guo <alice.guo@nxp.com>

Add support for initializing the i.MX95 ENET_PHY to 1G SGMII mode. The
initialization sequence is implemented according to i.MX95 Reference
Manual Revision: 5 (2026-03-30).

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 512 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 512 insertions(+)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 006a2bd2238..6414324e7d2 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -57,6 +57,8 @@
 #define PMA_MP_16G_25G_TX_MISC_CTRL0			0x1007C
 #define PMA_TX_MISC_CTRL0_TX0_MISC_MASK		GENMASK(7, 0)
 #define PMA_TX_MISC_CTRL0_TX0_MISC(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_12G_16G_25G_TX_STS		0x10080
+#define PMA_TX_STS_TX_ACK_0			BIT(0)
 #define PMA_MP_12G_16G_25G_RX_GENCTRL0			0x100A0
 #define PMA_RX_GENCTRL0_RX_DT_EN_0		BIT(8)
 #define PMA_MP_12G_16G_25G_RX_GENCTRL1			0x100A2
@@ -102,6 +104,8 @@
 #define PMA_MP_12G_16G_25G_DFE_TAP_CTRL0		0x100BC
 #define PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK	GENMASK(7, 0)
 #define PMA_DFE_TAP_CTRL0_DFE_TAP1_0(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_12G_16G_25G_RX_STS		0x100C0
+#define PMA_RX_STS_RX_ACK_0			BIT(0)
 #define PMA_MP_16G_RX_CDR_CTRL1				0x100C8
 #define PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0	BIT(0)
 #define PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0	BIT(4)
@@ -198,6 +202,7 @@
 #define MII_CTRL_AN_ENABLE			BIT(12)
 #define MII_CTRL_SS13				BIT(13)
 #define MII_DIG_CTRL1					0x10000
+#define MII_DIG_CTRL1_EN_2_5G_MODE		BIT(2)
 #define MII_DIG_CTRL1_CL37_TMR_OVR_RIDE		BIT(3)
 #define MII_AN_CTRL					0x10002
 #define MII_AN_CTRL_MII_AN_INTR_EN		BIT(0)
@@ -959,6 +964,513 @@ timeout:
 	return -ETIMEDOUT;
 }
 
+static int imx95_xpcs_phy_mplla_configuration_sgmii(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* 2 Config MPLL for SGMII */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val = u16_replace_bits(val, 0x6, PMA_REF_CLK_CTRL_REF_RANGE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val &= ~PMA_REF_CLK_CTRL_REF_CLK_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val |= PMA_REF_CLK_CTRL_REF_MPLLA_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV8_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV10_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV16P5_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val = u16_replace_bits(val, 0, PMA_MPLLA_CTRL2_MPLLA_TX_CLK_DIV_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val = u16_replace_bits(val, 0x14, PMA_MPLLA_CTRL2_MPLLA_DIV_MULT_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_CLK_SEL;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val = u16_replace_bits(val, 0, PMA_MPLLA_CTRL5_MPLLA_SSC_FRQ_CNT_PK_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL4, 0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val &= ~PMA_MPLLA_CTRL5_MPLLA_SSC_SPD_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_FRACN_CTRL_MASK;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0);
+	val = u16_replace_bits(val, 0x20, PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val = u16_replace_bits(val, 0x5, PMA_TX_GENCTRL1_VBOOST_LVL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH(0xA035);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0);
+	val = u16_replace_bits(val, 0x11, PMA_MISC_CTRL0_RX_VREF_CTRL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0, val);
+
+	val = PMA_MISC_CTRL2_SUP_MISC(1);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_MISC_CTRL2, val);
+
+	val = PMA_VCO_CAL_REF0_VCO_REF_LD_0(0x2a);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_VCO_CAL_REF0, val);
+
+	val = PMA_VCO_CAL_LD0_VCO_LD_VAL_0(0x540);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_VCO_CAL_LD0, val);
+
+	val = PMA_RX_PPM_CTRL0_RX0_CDR_PPM_MAX(0x12);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_PPM_CTRL0, val);
+
+	/* 3 Configure LANE0 for SGMII */
+	val = PMA_TX_MISC_CTRL0_TX0_MISC(0x0);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_TX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL);
+	val = u16_replace_bits(val, 0x3, PMA_TX_RATE_CTRL_TX0_RATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLLB_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val = u16_replace_bits(val, 0x1, PMA_TX_GENCTRL2_TX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_VBOOST_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_TX_BOOST_CTRL_TX0_IBOOST(0xf);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_BOOST_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x28, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL);
+	val = u16_replace_bits(val, 0x3, PMA_RX_RATE_CTRL_RX0_RATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0, PMA_RX_EQ_CTRL0_CTLE_POLE_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x12, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL3_LOS_TRSHLD_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x16);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL2_RX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_DIV16P5_CLK_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_CDR_CTRL);
+	val &= ~PMA_RX_CDR_CTRL_CDR_SSC_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_CDR_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val &= ~PMA_RX_GENCTRL3_LOS_LFPS_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4);
+	val |= PMA_RX_GENCTRL4_RX_DFE_BYP_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_ATTN_CTRL);
+	val = u16_replace_bits(val, 0x0, PMA_RX_ATTN_CTRL_RX0_EQ_ATT_LVL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_ATTN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x4, PMA_RX_EQ_CTRL0_VGA1_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x4, PMA_RX_EQ_CTRL0_VGA2_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_DFE_TAP_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_DFE_TAP_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val = u16_replace_bits(val, 0x1, PMA_RX_CDR_CTRL1_VCO_FRQBAND_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_TERM_ACDC_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_RX_IQ_CTRL0_RX0_DELTA_IQ_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val &= ~PMA_RX_EQ_CTRL5_RX_ADPT_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x3, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	/* 4 Configure XPCS for 1G SGMII */
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_CTRL2),
+		   PCS_CTRL2_PCS_TYPE_SEL(0x1));
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_SS13;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val |= MII_CTRL_SS6;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4);
+	val &= ~PMA_RX_EQ_CTRL4_CONT_ADAPT_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x6, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x6);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x0, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val &= ~PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	/* 4.1 Assert soft reset */
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+	val |= PCS_DIG_CTRL1_VR_RST;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1), val);
+
+	/* 4.2 Poll for SRAM initialization done */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_SRAM);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_SRAM_INIT_DN));
+
+	/* Assert SRAM external loading done */
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0),
+		       GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS);
+
+	/* 4.3 Poll for vendor-specific soft reset */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PCS_DIG_CTRL1_VR_RST);
+
+	/* 4.4 Assert TX0 clock is active and stable */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x28, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1, val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val &= ~PCS_DEBUG_CTRL_SUPRESS_LOS_DET;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val &= ~PCS_DEBUG_CTRL_RX_DT_EN_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+static int xpcs_phy_common_init_seq_2(struct udevice *dev, bool an)
+{
+	ulong begin;
+	u16 val;
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	if (an)
+		val |= MII_CTRL_AN_ENABLE;
+	else
+		val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val |= PCS_DEBUG_CTRL_TX_PMBL_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 2, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val &= ~PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val &= ~PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_STS_TX_ACK_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_STS_RX_ACK_0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 0, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val &= ~PMA_POWER_STATE_CTRL_TX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 0, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val |= PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val &= ~PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val &= ~PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_STS_TX_ACK_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_STS_RX_ACK_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+int imx95_xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	int ret;
+
+	xpcs_phy_reg_lock(dev);
+
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		return ret;
+
+	ret = imx95_xpcs_phy_mplla_configuration_sgmii(dev);
+	if (ret)
+		return ret;
+
+	ret = xpcs_phy_common_init_seq_2(dev, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 u32 xpcs_phy_get_id(struct udevice *dev)
 {
 	int ret;

-- 
2.34.1

