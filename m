Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147CDCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566D18486B;
	Tue,  9 Jun 2026 09:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W7TLDSyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54F1838BB; Tue,  9 Jun 2026 09:19:26 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B9480087
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1tEpL2QlOsR9sIPIgX4dbdGiQ175+9Ol9luGRmZPCOc10mQXkAbE13LoLaZ9LqxBcxpvU4yHHAVhGnYrK0Zj16rEITsrzFwBcrRY0IU+knEGcO+kexh9XLrBS9pFRa91yhaPAHn3ite3V3PNox8ZoXx0SXcILPPTZcvued/VFqHaWMnzEkqpE4NVTdrXoLGsjjNwKb5hNESIXOijrfWOvHIZ5Dw7nNtykZvFJ4akX/t68tr2LbUyk9uqgvEN7l4jPx7MepNdHTloHCZXTSU/Of/iHlVHmk7YeoBqJB481BmwX7hv6rn2dttfBijKZML5AVFReXfpBK5Rdodh7CHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pvV9STKjZ6I2UGgJJngz2DIoLDhE0y8nU+HNzx5L+U=;
 b=OJpoLQgzSmFIqXefo3Ze2lGPyxll3t2ycFrxBykx19Kh6J6QvIfT0BQHdA45rbfc1dZAIfi5JzkEBK58qombe0D4I5jUyZ5B80Ody6fRYhj/jKcTvuMSDGQoGcFok00XdkmM5dLKN/xW4AJZAVqU1vrmd4zDElL/7t/p+rhUkhHzB1SPZk6l77sm5IAQl6sp0sxYIJufZICZ8pUYOzD7otLJsrcp3Ugh3RD1/TpRPmXZVNofdYa7fOun7W519KjjSbP/O7CB8i3rIoDbwdttk4lP9oQvcvBmu7SdQEgfz9wHmplDcopLXJTLnfLdpQ1Q/R3m5nqsP4ZBSTUQltA6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pvV9STKjZ6I2UGgJJngz2DIoLDhE0y8nU+HNzx5L+U=;
 b=W7TLDSybYCBrN1d8Vw2+yZZk0urt9qsaKlucj1FtWPdNoBaqRQTA4wKZvd7H6RWjYfDrqXCyMWLpG6f5yjHN/gcjSTQrU0Mdr097kn9uK2bX1JNFAqywyKae0IVT9Aqb0uavRTteT6/ejIGQGo68pY5AZpSRZAkavHOZkD23jB3f8BZiu1dsV6NrFN5yjV4YM5zDhk2R/oMO8ist+30DIq7OmPv1L2ALLPP3JyASMtbeAN6hvEtBXHPVIjL4y7Y99wljYvfCFziJHei9Au1MTuIaedaJwIkSK5/VlmlIlStYxkfBYskP4jEv9PtWnFXEqKNrPpiVCrcuy7mqHOV9vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB11546.eurprd04.prod.outlook.com (2603:10a6:800:301::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:19 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:20 +0800
Subject: [PATCH v2 03/13] imx9: scmi: Drop get_imx_type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-3-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB11546:EE_
X-MS-Office365-Filtering-Correlation-Id: a090a757-03ed-4194-1763-08dec5f76c00
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3IciZ6Xn/zzRmDX+jems6HHYqVsLqDTgEEjQpZ0EudAnOSpwyKWPvata4Ij/9/COSLll9RcbClC5doLrIz4BeEED1KW4jWI10KxHSF1+RUe4pUXj/e6uluRoV3sGmzpnquaDRF4A1WWreY+BUk6JjlqCc6B3001tWJ2wVJnAb3ghb4xPcUx8v244PFIidiJsmYASCYZJ60jjWenYdw7cqe/nt7/vEWoKKEK0yXdfnRp6g30u2f97Fe6JyupdYWY9GctV7r4xVDagCfF5HLfmoJ6wffx2IEP9HB0ZTuD1DmBTRYIEv7Y1DdvhBvFeiC9ACNGgTyDkEFGN7i1ktn1PBVcubqfRjMdD/NydWs+xnozmqQDff8/J5CqRw2MX6o+pBUC4pyPwB+YC/oU7v48LKU/PWXgk1l/z8HnCmtPXJMV930DrUPRPIERk6fSV4FFDcy401adGTwU62es1IEv2ty8a0YRMponOotYFewLsQiQ7zjbSe3VwzEexLtVFDo7cO6Id4ON99hU47URGJxY0MqLZ7YbUJyWp6aaSy6ukbDNC5QkidUEjBkzLJSEVd0aPUBbwl6pHJCX/CnflN3yW+7ptLi4OZXJE2h8/QZGVNMRYTAvi/pJGdaCQ9lMy6jP/WN1TdcjXOYVqjkkpnjNjKXYzgcalgGPOwbGhDRYu7xlw2FwZ/WhNJM5zNv0oMk8gdOrr5mgBZTWmLu+BMNBVrv2M53XfVVijlQp3t6frd/1waGNhpoVP9gOA0K1MVUcR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SStiNThnbVRua3JTU2hDZ3RPMlhmMHNKcUN0MHRHL1hMeDdQUVV2aE0vTnJw?=
 =?utf-8?B?ZVllZTI2VlNkQm1vNm02S2pLZUFTWkJvd2JwV2ppRHlqaE8yR0VnU0tDVVRv?=
 =?utf-8?B?U3AvMFp1ZEN5N3QyMHlsUVJxdGc5RzAxa3pEYU8xRFBPRHVZdEJwa2RjaGRn?=
 =?utf-8?B?YkxRaVlncnhmR2VHZUVKbUx4UllFQ1dZc0tPRHo1Q3lBNnNFVVZ6UjhuWUY1?=
 =?utf-8?B?ckpXUVo4aWt2Tnh6V2YxOFhNckNwQzJXSEt5VXJMek9BaCtudFJ2cEhRVC9H?=
 =?utf-8?B?NldtVlJrV0MyNjBtb1R2bFdXTjdxMmtLcWVWWFFkRjFMYlBpRmJ4ZDhBaE9L?=
 =?utf-8?B?UFdjLzRMdUMyeWRtQThTaGNSM3c2RGc4WkxkWDlhdkxHWmJZdktBdzVya2c3?=
 =?utf-8?B?bWdRdnhWL1QzdDQ0L3NwV0V0eFNkMTVERDVxRjJMcHNZS09DUU1qL0R6T090?=
 =?utf-8?B?dUtiWi80bE4yOFZpdHVBMTAwSDlSam13ay82TmJtYk9heUhORVg2SWc0dUR2?=
 =?utf-8?B?QTcwZEpzeVBlQWN3YU1FMmdqOWNoZzRYTURwdUZnbXAxUWFVUmpxUlllZ2Ex?=
 =?utf-8?B?MUY1UW1OUTVEMHk0clZwdTlIaEwwbFJWSEFDdWh3QjF2VmI3U2h5OUZJYlJt?=
 =?utf-8?B?WkdtZStTQm9wb0h5TTVETW9EVHRUOVBRZXFtdCtwbFZ3RG5sa3dlcHBySE0x?=
 =?utf-8?B?bGF6dHI0RzlYcFBpV1Z3bysxbmhpSHBxc2t4U3AxWVZOeGlYMmJiVDJXVGRv?=
 =?utf-8?B?MHZabkRUODFCSW1Ia0pBUGtwcWZpb2VVdWV4WnRzamlueVJUNFdjSlJKbGJm?=
 =?utf-8?B?aldIQ1BQdnNoeDZxc2QyWGpMUVBySGdlRzVteHM0VXZzSjFidVl2dVVZSnl1?=
 =?utf-8?B?anlKTE9FRmwreFo0elRPTSs4dnlFdXBaa20rbUQwMUE2b1RwTE9UYkpkYkE0?=
 =?utf-8?B?bGJiUnc4SEsrekxvU0hhaWlKVlAvKzl6eXVUNC9icnZucjlKUXdkaG9rcGQv?=
 =?utf-8?B?V1N2ZkZpUkovVmc1a1c1bHhVMzNoaXdWS1pkMndSbkR2VlBpSXJlM0hrVXdU?=
 =?utf-8?B?ZTFGMmtNMHlSa3FOSG5hZW8rd3lnR1FLVEYyWmh5empqaU5OMlpzK0NVQkdY?=
 =?utf-8?B?UHRmSjE1SzE2aG9jeUdnUHc1R1NTSnVNZ3VuUUNJZDN4Z1UwTG54UUxpbXNY?=
 =?utf-8?B?QWZFUXNiamduSm9PVVYxa2NlK2V3NnNIWFlVUDRYS2l1Sm5RTDRtNXl5c1dk?=
 =?utf-8?B?R3I2blB1Y0tqTVgvaGJ0UXdENm0vMjJrZGI2UERUZGE2TW1wT3VaNnpPZ29V?=
 =?utf-8?B?ZlNobi94Z2tYZlUzOUZqajcxU1M0ZmQ4c2ZKUnkzVVlLRDY5ZURkcXBoelQ5?=
 =?utf-8?B?akF0clBjT1JsUUFBR054TkZzT1ZDNStpdENIMzkyTEZ6cUdndnArbnZXTE4v?=
 =?utf-8?B?YjZRdTFnK3llT2Vha2dxbzlIZ0NFdjdQUXlVNjZsK2Nva3ZVazcrTzhqcnUw?=
 =?utf-8?B?TDFVQk8zWFhHbnVXNWE0cVU2YkFhN1JESW01cU9ISWpLNDkraDhCY21ReU56?=
 =?utf-8?B?L2pWUk5Nc1dlWlB1SitNbzVqRWFkYk1BSHNDczltUDVMelNLME5yVHRPSzNr?=
 =?utf-8?B?REdhNzhvcTBldmtoREs1ejdqQng1cDlRc3lKU2luTStNenFNQlhiOVF4TnIy?=
 =?utf-8?B?MW9waEtKR1hyVTkya25nWGh0anJuTW1UUzFIVE9PUkVrWUJjRFlDdUwwbGhw?=
 =?utf-8?B?MlpBZElVQlMxTG9keFNlSUJxTU1oMWxVb2RCWUJQWXh2RkErNGl4SXNTTmJR?=
 =?utf-8?B?SVhBMDR0L084Nm43ZXZaQk9YaXpROFF3azM3V2oxZzh6REx3R29XeE1qRUY1?=
 =?utf-8?B?c3VHdDg0MzFwN2FXZFZEWjN2WXVWZkhJVVBoc2h2SWs1Snd1OUFTdWdOOTFu?=
 =?utf-8?B?SFJiZmtySit4M0dQVjVBR05DRTE4cnNxR1RUems0S0M4SWFUWEx1aG9jamUv?=
 =?utf-8?B?NTUwS3FGdm41dnBTYk5DN1lZaHUwbEoxcHZEUEJOMWlnVXRSNzFsNGZXcG1R?=
 =?utf-8?B?eXlLQ3hEQnhwOUV2bUlOYmxia3JVWnU1OGhUVnltS25nQUM0ZXppWWNDQktl?=
 =?utf-8?B?UGdGZTZ3QnVncC9zVTB1YU1wVXhHZnlrbmNLYUFhT0NBR0piU0lSaUVjbFRp?=
 =?utf-8?B?c1ZiSWxEcGFqMmxmWTErOVFlaDViV0g5WkNxYlBzaUM1MXhkQk1IVEEwSVRC?=
 =?utf-8?B?Z3RIQWtmRGR6a01WdDh5NDR1cjBrb2VqKytTdUFVN3FXVi85Vm1WbTJKMmFj?=
 =?utf-8?B?MkR6TWpOMnRtZi96M0dydmpiWlVySC9BQzRTNVEwQjJNZFBkZWp5UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a090a757-03ed-4194-1763-08dec5f76c00
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:19.3483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tq/aA3Mx6XzFSMCCoo8jh8dc0HWb4g/VnywKkcn1ZXgNZy93apoKPGcGJS+biEllsn37rh6/hhTlEsFcC5gO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11546
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

There is no user of get_imx_type() for i.MX9 SCMI platform, and cpu
information is handled by cpu driver, so drop get_imx_type().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/common.h |  4 ----
 arch/arm/mach-imx/imx9/scmi/soc.c    | 10 ----------
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/common.h b/arch/arm/mach-imx/imx9/scmi/common.h
index c3610127dce..0cf7f3e4439 100644
--- a/arch/arm/mach-imx/imx9/scmi/common.h
+++ b/arch/arm/mach-imx/imx9/scmi/common.h
@@ -32,10 +32,6 @@
 #define IMX952_CLK_24M IMX952_CLK_OSC24M
 #endif
 
-#define IMX_PLAT_STR__(plat) # plat
-#define IMX_PLAT_STR_(IMX_PLAT) IMX_PLAT_STR__(IMX_PLAT)
-#define IMX_PLAT_STR IMX_PLAT_STR_(IMX_PLAT)
-
 #define SCMI_CLK__(plat, clk) IMX ## plat ## _CLK_ ## clk
 #define SCMI_CLK_(plat, clk) SCMI_CLK__(plat, clk)
 #define SCMI_CLK(clk) SCMI_CLK_(IMX_PLAT, clk)
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 8a295baf5a2..3f71f0ee6e9 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -715,16 +715,6 @@ int get_reset_reason(bool sys, bool lm)
 	return 0;
 }
 
-const char *get_imx_type(u32 imxtype)
-{
-	switch (imxtype) {
-	case SCMI_CPU:
-		return IMX_PLAT_STR;
-	default:
-		return "??";
-	}
-}
-
 void build_info(void)
 {
 	u32 fw_version, sha1, res = 0, status;

-- 
2.51.0

