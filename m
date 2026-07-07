Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D0C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 03:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593C684994;
	Tue,  7 Jul 2026 05:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MOQKxKVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 891AA8490A; Tue,  7 Jul 2026 05:30:47 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E0A84994
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 05:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkLKWbnBvT9dPemnvxHTMkAwch4kC+diO4t4fsj/czAXNVqROaOXsaecD7m4pReCDl2NIjDkl8tUVudSVfLChYt2eFqKCFl+wS/T0+75SdNhrfJV6BnN+KHZ65N+1tqJbF7R6yi3XFAC3tAHPycSjVjcjVDlvBZ8mCqrNqTrH2LvVOYA9pzIXP/3yC8pIzE+BmZ40gu5PQhow69ZndWCT8YD20IyHFi6fGooMTTl9R9EOoivJFCvfhM9+x04OzrNrLc1jRoD2o/+ltv5r89Y5rRT59fzuwb+dN267iLYf9pe0J1YxTOrWSTWkf2dOMGS0RX5xvdcaNpK98RpqMy6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/BIE2VSxoMROgMuQMHDjCCJxX3DdVbvfvWFvXS27M0=;
 b=lsWIycGnXNk/RcXQNB6r1gHhjpJjsYH5DAhQO5sK/jqxhzqEl96h09RSdJYjx44zdshu/63RfGBpwqMZbyq6xyZsGiNXiu8YeVwsv7oXrD/Ed+knXqJ57Z63j4D7LYK3x7+DVyNiYqIycuw6T63lzk3NmyPZMLUofSaKxegf4dWrNuCCmA5CCbgrN0tGS5ouArvkYV1LaKEysuA8eRbA+OSRXGNCClUohqBc124xvEBMBbCgWONFJaGn0vMhM2IhFeQyVuGVpLa69ZbDgBNI3hS4nqJWJ7X3gATPuWFXf3TV0qsxGiMjEdeI4hjIL+7y1Wj/Lh/uf0Y0NxeXKwER1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/BIE2VSxoMROgMuQMHDjCCJxX3DdVbvfvWFvXS27M0=;
 b=MOQKxKVKRFUXD1x4KMOelDEsJdDFnppd0JUW5mElMgT0UFEyUVtBWhKFmqqwWzutZD2oDpxkBYGoUF2tZZ/iqViz/dkpvqvyzeE9Rop+Za1Owo6lGxdy8og/cI02dDh4xIjAXp8Ah7CvHHa0hUVnA676UE/YxEDeWYYfUULCVjnGxz81i+VDZvoimKiCJbNPNzsT5VqbT92V1/ZrgG+zKJmJSqsA8MUqDz7ygtUgfk+gZx+FJvdqMSLSjZGPhrNndCnX6h6Ko/ZRD+9sJFjjXz3IQWl76Jm35gakEA0fbG9VQXKm3tF/fzjiMHmzy26TB3mXUcEfkFAM5PbZ5o+W1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 03:30:44 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 03:30:44 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 07 Jul 2026 11:33:51 +0800
Subject: [PATCH v2 3/3] net: fsl_enetc: Add SGMII mode support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-imx95-v1-3-5b4b0f03d5e3@nxp.com>
References: <20260707-imx95-v1-0-5b4b0f03d5e3@nxp.com>
In-Reply-To: <20260707-imx95-v1-0-5b4b0f03d5e3@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::16) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|AS8PR04MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 183551e2-2074-4e4c-e72e-08dedbd8209b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|19092799006|366016|22082099003|56012099006|18002099003|11063799006|18092099006|6133799003;
X-Microsoft-Antispam-Message-Info: TI+/QWf1lrnNh69tzczcv7hPWp2CZZoCs0RCAqpROWgv1D9d4A3wkLpPR6A2PvbvmczS5mkmCCuE1is3cGVTYrGmXfQztJ4zhlT4cvVRjT1FwoEhqCq5b721kfvDb2qw8kRW3Tjd7fLx58r9EIzogPes6tuRO8h4ZNsNA9FppIdWgOn0+oSoDZC4DGSff3sqKX3I8z6TZtAf6gkzEJaVxieVF3R3jG9Hax3CoYzqct7bKYRQJgF5+xTaPZt6FcauP50V/qDOaVo26FVXF46ZhJALXfsib0Q6kud8OcNFYlUpr39XQ64TFGlnqSBE0eyKmHaSWnHnaTinRcEZ2odxOIY+l33vR1Z5RKKqAn3nu53C4Jvi4CozeQmDN3vnBzzGVCzUoLYMc/RcEsf6t9ltDyvaG68VGlO6lzbygFVN6/Ud4iUb2uxmc66I/jgF/zmka/qE5hu/SpJT9z+yYs3XuRQSYE1QuTNRQAIX1J8eu0jkRIB0Oac7tviYBAToUgw4/I8TzJCXowUWz3x/f5yJN2MncIh1ZBBGiHO7QfMtTBP6fncpxZcpOLk8bbkSCcd0DGGw3nJqtjQl/+FcCh5VEGHb0YAKKNl1piTxuGueLAQKRO3FftFH4/W8sNibgHataFYWvb3pY1OLuITFNQiQ2120xvVc9p1VCmaWgQ3BoqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(22082099003)(56012099006)(18002099003)(11063799006)(18092099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VkRGVCcDhZMTVKRjVWMkJXOTdkUGd5U3J3QzhCUVdzcFMvbFVXeXg0aFZ5?=
 =?utf-8?B?ZjhHdnlFS1hiMFNTUU02M3hVMkZ2U2VIaCtWdTM0a2xDclJGTEExTXlJSUxW?=
 =?utf-8?B?T01oMkpaUXozUUEvU09xZE1PUHd2ajZ0ZDd4Rk40RUo3UVY3bFVwQUpnZ2Nm?=
 =?utf-8?B?WGtGdjJNVEZBVXpFRjFRajhjdmdDdVIvSW85dWFXQ2MyUHEzZWxNNFlvbCtL?=
 =?utf-8?B?emVUelFBcjVyN285blVwMnJqS1lZUjE2ZkJ3S2dLZktBcVM1YXpGMjdSdmlh?=
 =?utf-8?B?NkdGSUtqZnhYQ1duSEtmb2NNbisrejk5MUxPSXJ6TzB5UVd4b3NwWGtHUjAw?=
 =?utf-8?B?MXRXNjlqT3Q4TjQ0MGlBOUF1cDVPL2ozdUxXdEFPdE5rU1Y3bEY5bGNHTVdy?=
 =?utf-8?B?SVZKcEdJOEM0eDJuTEcxQjdFNlEyUnR0ODk2RTBtR3lacGpPV3kwMk5OTmZm?=
 =?utf-8?B?YlI4alpueFVhcXI2UUViVWRUVU1RanlBWUduZmhEcGs2R2R0T2xERXB4bWZ0?=
 =?utf-8?B?NkU4Y2h4dW0zQjA0ckoxbS9yYWkvMTRXdzNna3Q2dlpnQ3F3VjdGRWtkMDlN?=
 =?utf-8?B?YzhLR21SOGorbzNCc3VyZzJURGt3Y3FqQlRVQ0UrOHhJcDUzY0R4QkpKQi8z?=
 =?utf-8?B?WkNTZzdSYnRiZDdFdk1XOVFHcjd5RGNRSWdtSnhJMk9vcXIwZkF5SExucjNN?=
 =?utf-8?B?RXU0cUFueFQ4NkJGOTl1aGFDWmFCL29CQU5CUlZyWUV2UGtZS2NUV3NzMjBk?=
 =?utf-8?B?OU84YmRDU2xnRTBsNTdXOXFMdU01L0Y5dkcyRnVZcjJac0RjcEhaMzBOdmRS?=
 =?utf-8?B?SGk2aEdiMHBkOWphS2dIMlFFckQza0VjR1N4bUtqK0ExanpOOVNUZGYvWENP?=
 =?utf-8?B?ck43TzFOT3FXajZNdlBlZ0E0NjVQWVVwNHJkZkF0anhRVFE3R09BSEpXREUz?=
 =?utf-8?B?b1B5YWtXaW9EWXJOWlZtRTJ2eE1EeDZhcUdDRjN4RjdXdzE2N2dFQVhxZDIy?=
 =?utf-8?B?RHF6dU5tTktEam9nb1ZUNFV3RGhIanBaM093WDEvZWE5ZlczQzdiR0paRUJw?=
 =?utf-8?B?Ukl2K0xEaW82cDVoSEFlL0p2aGp5UGRaMEZubit3Y0lycWhDVjUrNDkraXVN?=
 =?utf-8?B?RldhSE5wYWdRR09DL3l2RmtHbEFuZUEzV2NZb1dMVVNtdTI4NFI0dW1Zazhl?=
 =?utf-8?B?OTI3U2FhUklLbjhIQkdGYlIvbFlUYUdrQVJ3ekM0S3JGWHA1b1VXeEVxUnJK?=
 =?utf-8?B?ZGI1Nml0YWxleWFwUXU0VHlSdjB1eUZGRFErVHl0bDRXUEpBWjlObVNOSWtZ?=
 =?utf-8?B?U0EwaVNQY3lEYjlEVlFETDB3NWNiMXMxSEhMQ1pLSWFrSzdhSS8vL0kzajBK?=
 =?utf-8?B?SzJHUi84NVhic2lmb3VtdEFLK3hBTWpjRkZiQWNMMm5LUVp3TDZOZzZ1TDM3?=
 =?utf-8?B?YXVNRmx4YmRHT2xZTC9iODRJUzZpbGZGUGI0STBBOVlHYUU4di9FdlErcG5T?=
 =?utf-8?B?aG9NN1BFeGhXNGlWRVh4WEdEbUtZWVFGR0RjTFRJWnovTHM5YkRwSlNYWWtj?=
 =?utf-8?B?MFkyRHNxRUVpcTBrS0phRGlpUnhEdHdJQnBUeTNUbk1rR29FbDB3bHZ0ZnFa?=
 =?utf-8?B?cFhFRG1zM1ZaakNPaXdkTmhnKzk4S0dsVEJVRkY4TTFxbVlQT0ZMUjdJZGtK?=
 =?utf-8?B?WUpkdFEwQjdUQWdkRDczRnVWTnlQQjNHMDV0aGFBTnVwenVUVkRIK2xjK3BR?=
 =?utf-8?B?QUx0cElLMWJudHU1cUliMm5ENSthWHE1K1pnYXlEWHpBS1RIdmNhVWg5ay9U?=
 =?utf-8?B?QXI4Q1hJNHA1SUxzTzZjRUE4c1hXRUVkTlRxanc5RHJndjRRKy9wdTlQSHd5?=
 =?utf-8?B?eW5BYWhxQ3NGdjVYbUowSEdobGdRRzNNZDRFNzBKMGNvbWhmWUgrUEVIWVZ0?=
 =?utf-8?B?aXVMQnJTWnkvUDI3OHViWjQzWWwxU1lEQnlTS1hCNXpIS0dHdG91cWs3bmFR?=
 =?utf-8?B?NU5VbHhOdTQzS0hGbG1XRzBIV3NxbzU0ZnFoYnpJeXBDTVpmS0hPTlRNSWRl?=
 =?utf-8?B?TktlWHNOSmE5bWlyaS9qVEJYQmk4eW5MelRjQ3ArQ1N5R3JaWmUxWFFHQjBK?=
 =?utf-8?B?UVl3cFNlNGtZUWt2SWZUV1RNVno1TVpCS2F2SVo2ZlJYM3J1bGdmMFVXVENw?=
 =?utf-8?B?VkVQVDdXWFlpMXdEamQ5ZU9wZ2RaSitFSmNRN1FjYnAvVkFOaXNMbWtCWXBU?=
 =?utf-8?B?ZWpEbk42N05yQldmUkNGVzE4U1VSWFV1RkxyVmxXa0owYTB1ZU5NRjZKTita?=
 =?utf-8?B?SlQvUjVWamt0VlVIRVRZUWRWcnhEWmZ4ajE2cUJtSFA3NThzYVZBdDRROXFj?=
 =?utf-8?Q?DcB7zBBcCVlx7j5Qxc9s+Y4nqb8hAhDwAxmkz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183551e2-2074-4e4c-e72e-08dedbd8209b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:30:44.2236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJVVvEZguCTOYBbY1r+IGy9wckhd+6bx4LbCbaUmgWMzE+6jkfDp6XRmKP45taI8mqHnUEaiTjosUih6Y8kefIpZub7WCom0vivOLAUSFuJYh1DFS3mmCd/NPQKARuOi
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

Add SGMII mode configuration for i.MX95 platform in ENETC driver.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.c | 12 ++++++++++++
 drivers/net/fsl_enetc.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index f393af40e27..cce1c5ef2a7 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -389,6 +389,10 @@ static int enetc_init_sgmii(struct udevice *dev)
 
 	if (priv->uclass_id == PHY_INTERFACE_MODE_2500BASEX)
 		is2500 = true;
+#if IS_ENABLED(CONFIG_ARCH_IMX9)
+	else if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && is_imx95())
+		return imx95_xpcs_phy_sgmii_1g_config(dev);
+#endif
 
 	/*
 	 * Set to SGMII mode, for 1Gbps enable AN, for 2.5Gbps set fixed speed.
@@ -482,6 +486,14 @@ static void enetc_setup_mac_iface(struct udevice *dev,
 			if_mode &= ~ENETC_PM_IF_IFMODE_MASK_LS;
 		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
 		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		if_mode = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
+		if (enetc_is_imx95(dev)) {
+			if_mode &= ~(ENETC_PM_IF_IFMODE_MASK_IMX | ENETC_PM_IF_MODE_AN_ENA);
+			if_mode |= IFMODE_SGMII;
+		}
+		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
+		break;
 	};
 }
 
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index 6d868e82f8c..bcab6f252a0 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -104,6 +104,7 @@ enum enetc_bdr_type {TX, RX};
 #define  ENETC_PM_IFM_FULL_DPX_IMX	BIT(6)
 #define  ENETC_PM_IFM_FULL_DPX_LS	BIT(12)
 #define  ENETC_PM_IF_IFMODE_MASK_IMX	GENMASK(2, 0)
+#define  IFMODE_SGMII			5
 #define  ENETC_PM_IF_IFMODE_MASK_LS	GENMASK(1, 0)
 
 /* i.MX95 specific registers */

-- 
2.34.1

