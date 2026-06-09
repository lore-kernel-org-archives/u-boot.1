Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09801CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 284E88489F;
	Tue,  9 Jun 2026 09:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WeoOZnHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ADD984851; Tue,  9 Jun 2026 09:19:31 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A0E80087
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWpTn+36v7LyX0tYvwlGKKau0uz37oEIhSgAjf0b5jYoM+Rlgza7bGcgWYbsKBHlu7cNpgs7/2/XRZDANOz7P3aCoGN4lWOidGKUkMPOqqurk1ccPEcJ+iNJnnu0BqV2hvxzcJc/gvOSCgndLA2fjzT4eTNIMrElv7vrXHMqYP72R9EMvcfr7YDvza3xjon5/WCOkUOQ/nZTU2rR53ooeQ2pIbhgJ8RKbtgLXZxuikGivetuDgwKkAGK6r0dfhBEA5xSoN5IWUnjpUyM5Ja1ry0dvd/qUewHQa+q72IZ7SrPxtWOw6kHlhPUP+FEw7mJHZLBo7ChHfwBeRhq/5/oqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSlp9U5er80igDsOi1rmBbSZIZSV0KFnXGfTBS4v8X4=;
 b=otrNg1/S6Hy8gqDzmOC1E81S8U5RxXGjWymCtrS9FEOw2hU6GTHVGyG9P8rmYXjFK8a5+lPFjr4CHIP80yG5ncdryU2LtX3GELP4q7LLQ+X7x4wvpTJCZIcH/mLRNPyo1wP85/8i1wVsZQU46FzdjHf15muKBOlG8qmVPanxv3Kc7X6PNBbfaWwVeuPW0IVed831RvccFG2luJFbiPriLyv6y/yCBbfPltQgDKOZW2MoGj3BanFIDeEpBz2B1lOeVanpQenqvjc+DS1o20IO0YQLsD543VpR0xKcSGDIcQp0F/iqz3gjgjhZroY/bV59DCNn9x5xOTs2S8rji7wUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSlp9U5er80igDsOi1rmBbSZIZSV0KFnXGfTBS4v8X4=;
 b=WeoOZnHOF5uI3svZt9ETiKR8+fXx24MRxyzRXa+1KIysdggWw7gZa4AtuKbDY3Nsf0FGC+H8F5p1bv+lN0kQK8xZjtkIMJn+DfcNq0npt4CYfeHQALsbItuDHQlvDYkOdBa0VJWuLLEIO1EcoEE/VueluWDAklODaAtPpA2luycx5B2HSJEofL6BXaptiJHr/pCSiNmTqUalwZpC2mbhLDqdfhzyGFQoVQ6oP/xGG1d4xdVsQxV3p1hMz5o2GPu3mKXj7/dA0sCzB+aJl4EUEgC5BacYCXcBOzcUQbP951a5XiXJuTRJ4rwjkvGXBMbkTKBgFJziHPqBBMKx/1cahQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB11546.eurprd04.prod.outlook.com (2603:10a6:800:301::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:27 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:24 +0800
Subject: [PATCH v2 07/13] imx8m: dts: Update ddr firmware name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-7-58e1665d55ae@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5ccfa24-7bdd-4a23-1caf-08dec5f770d7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 6IJwHNHcD1j1FJKP/4FkmsvzGtCZ3fViIUezVtKQEMg8y5NgGQZBf8vBrIf1xiCowOzFILIl0S4KhI15bh5taaIy/p5tKvmY33x7sM7MlRGtExiRiFJP0XN0gPllBDqzmNQjUVhSUwSsV8R+nfCmiTMe0NKRtAZrPG8cyIjGUKXXCWD+RLMTSaYJAM6Q1/Vhna9KQrzEz56GFRa//QGCmYp4sjH1PwmkzcmO4697JXE5F38vabL0AKQvxJUPk+Aae6ep6aaL9HpgCJLXqO07lFCCnBA9FU+9+jS+vW+HyW0q2AeHyql5QnPdnD71Y1/opqm3sgLeoy1WT3LrolIZzXlPPQiO9OfuzIlF4WXI2pMBHzpYk90TOVM+FtDugSD328v3/osVKm4kKqBn8XxDoh72/rPQSPPZlRT80mdsFr0+PISFDM39Mag5SFbsIICuewOBxR9VkdotbXMv3zWpDh/fjopSz0QH2Oia9frZpLW4ONR8Oa6glIC8sXWKc2rUGnkzOIklCoCivYo55V6HIp/lOK+hrj3SqqtAfY/nCnCSugaFGjzr4aDuUa+wc+3VVQzgEGXf6dVz7Kx2upcFEgchIiUFiJC4/h3A0UODJK9BEM2DTnVJA3zocoD2zTrHF0A+EV5kLHt3Vh1K+ifpk+OpPgK6L140G494Jum025rIC8a/XCuMUSKj7jcA0zsUJaU+X+EoQ04loQAPXoFY1ca+buQKB545o4wLPOk5nHYQuAScdYLYzqf2Y85+qMce
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skx4K2k5QmduNXV2N0ZiUjZRSWtuaHdVTmtkSmc2MTNhaERWcTlTTm9HYzBj?=
 =?utf-8?B?cjlBRDA4Q2lZZWhKYzdkRTJaL0RsQWtYNUNLdTRLS3BKQ29MblBWaDVkdmlB?=
 =?utf-8?B?QTllYWcwNldWMXh6M3QyWER1RmtybHR2QTNkYmNlZTllZTBTTWpZdGdGR1cr?=
 =?utf-8?B?eFluRjBFMlJ6eHVUQmtrYVdZZndQODZaN0V0eC91Q1ZLNmhqZmdXVFp1NlJt?=
 =?utf-8?B?NTNWclByMmRaY1V5UlpsQ0o4TkdPWFdaMHJlbGVLdURyQmhtT1hMQm5zaVZl?=
 =?utf-8?B?cjNtWHErUWZ4TVJuVnd0UFFRamRldlMrRDFTWTNiWjNtUVBmd2lEdnRmTWNX?=
 =?utf-8?B?N0lNR3hPeURyQjRQSnptM2QxVFVOR0hDR1ZRUTVmdit6R3NIZEpZR29TOGRW?=
 =?utf-8?B?a240alZiSThmdzl1aGQvN2M5TjhiQ0Q3Ym1Jbm5yTEJMekR6TFI2bjNIRVBV?=
 =?utf-8?B?d043MTUzQnZoVFFwZ0FwSWJQNE9DOTlQem1jcE02cUliM0FVaGtjSjlvVTRE?=
 =?utf-8?B?ZCtvb09wbngwQ2JseGl2b2FNSnh4a1ZPdjhXa3Rna0Ureld1a2R6bzI1QmZY?=
 =?utf-8?B?cEQ0WXo3ZnZUeUVyVWIwcFZ0OGhwS0pkZHg4RkZIeGNFWUNaY0V0bVptREpw?=
 =?utf-8?B?UlBLaUpremhoQXRMRnBJRVk5Rlo0OEVaTXVLb2k2SEVsZVVrNFVMbzFKOWFP?=
 =?utf-8?B?ZUlNbkZ3MXlkY211OUdWZElZdFRjTHN4aUMwZ05qUW5VMTc1WDBLR1kzZkM2?=
 =?utf-8?B?cVl2N3B2NFBQanJvVVpzRzE3ZW5aRTVtY0RXQ04yYU1mcGFsdzJFTTZyaVZI?=
 =?utf-8?B?YzEwak56Q1FXLzNPN2tOV1AzeXI3Rmg1ZUxsRDMyTjlpZ3p5Q2drS2pQNFVH?=
 =?utf-8?B?V2V5dVprcDZ5MGhDWDJHNzNtMGIyd0VqemtkckF5YW1WcGFSc0l1cUZRZS9k?=
 =?utf-8?B?Sm9QcmFuUmZCRlJoYjhWbWJQZjVONzBHQ3dEam84MmgvZEhNZGxQdmdyTzls?=
 =?utf-8?B?clJsVmZYemh4OHhkcWVoMXh0TWh4UUZmTG14TDdsY0FWbTVDWXNHMDd4dHFP?=
 =?utf-8?B?WXdTMVFKT2s4dU53NTNCYk9kQ3hXMkxCNWZaMXFtY1JjMGVja3U5SXZaNElR?=
 =?utf-8?B?ZU5GcjczUFFKVTIzaEU0TDhLWnA3NkpqOU51Z0VLTWVEci9wa3lYejJVemJo?=
 =?utf-8?B?S3UrdUoxVE8rZk1ZaHZJTDRkTUJmQk04SlJlQVBEazluYVpZNnV5L0owN0VM?=
 =?utf-8?B?MXBGVkZIbWsvUVpOZytROFBuZnlyOVhLcThDaDQ2L2JMY0lnbmxlVFJUaFQr?=
 =?utf-8?B?WHZ2WlRuU0MweWEvODF6dko5bWRqVjljRVB1bFR0UHhWOGc3S2Y4cHN3Yjgv?=
 =?utf-8?B?Rzc5VDlPeStnSy9ZK25JZ3FrS3ZIWWJPeXR5YkFNdEdwRGRrVkJid1BWZDlT?=
 =?utf-8?B?V0czQ0JDbW5qWjhkaW5tVk00ZWtKV0F0MExNQVpRZW5xUlYyeHY0ZjZxd1Ex?=
 =?utf-8?B?VkV5aExEMWpYWlBpbmFJSmpPT0hyQnJvSWRtZ0xlUlVTNGNSckZMajk2Z0g3?=
 =?utf-8?B?cTNCdm1GY3JKL3kvRTlnbC95UE5CN1ZJMDZtSlhiNXc5QmYxK01BNkZYbFdz?=
 =?utf-8?B?ZXZ2MW5DLzFOQk93RUpsS2tzT1R1N1pXOGdVQkR3OGZnK1FGK3d3emJ0Yk1L?=
 =?utf-8?B?a1Vjckh5WmZKTlFScXpZYTBUMmE2aHd4bkk3UVJHWVlTYnFSaDY1N1ArdS9B?=
 =?utf-8?B?QmFlYmVGUlo0L2ZFSHA0Q0xEd29id1BaRnpiTXNCMGk3bUEyVUl1Y29saGRt?=
 =?utf-8?B?a3k1NldHdFlpTDJFREdNZ1plM3NRaUdob0xZL240MHFJRGZiZG9FVXh5cXpq?=
 =?utf-8?B?Wk5QZk1iOUxjYlF6WGJXM0crM1RXNlJlVHZtRUNIek43dnh3ZFM4Wnk4cGdr?=
 =?utf-8?B?SWlrVzdXbHh1UEE0WDJONi9FSXZsczdaV0RTdzhwdVNCa3V1Z3RqN21XQ2l6?=
 =?utf-8?B?SFo4T09Ka2NubU12VTVwUkZvYlBkaHVpcDNEc1diNGhLc09NTDJZK01MaS9p?=
 =?utf-8?B?OUJuV2pjVXNmTElxSUNmY013VTVYZ3RxaDh4TmxVMi9EZ3I1MitVWDlDTm9a?=
 =?utf-8?B?eE5QRXRJYmNnOG04TklrNmNDVUttZ0w0VGY5bENxQk9CclNRNzE0SlN1TUFi?=
 =?utf-8?B?RjhJeHVCMExITHYvRHRWZW94MWFNK1dEODhHZ1BzV2JCNWE0WDk2clkxMUh6?=
 =?utf-8?B?N3NnU2VldWRXeUxWd0VWbHJvcDQzaytzVTdPQUlzeGJKZVlkbUFiU0xIVk4x?=
 =?utf-8?B?NG1RRXpYRUVaUTlkdVY3Q3ZtOEd5SVhYRDk1UmVHc1NHMVZybmVFQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ccfa24-7bdd-4a23-1caf-08dec5f770d7
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:27.4599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3OXVzs1mzitetaGUB1QHe4QNOOtgoi1ZhETBLn2y/YZoUm6mabzKqdZnRPUvZW1/LccKgqoGnxk/RP7clMLHA==
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

Update to latest ddr firmware name, otherwise user may use legacy ddr
firmware from linux-firmware-imx release.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 8 ++++----
 arch/arm/dts/imx8mn-u-boot.dtsi | 8 ++++----
 arch/arm/dts/imx8mq-u-boot.dtsi | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index d891e8062fe..3d1850d4ea4 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -85,25 +85,25 @@
 					};
 
 					ddr-1d-imem-fw {
-						filename = "lpddr4_pmu_train_1d_imem.bin";
+						filename = "lpddr4_pmu_train_1d_imem_202006.bin";
 						align-end = <4>;
 						type = "blob-ext";
 					};
 
 					ddr-1d-dmem-fw {
-						filename = "lpddr4_pmu_train_1d_dmem.bin";
+						filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
 						align-end = <4>;
 						type = "blob-ext";
 					};
 
 					ddr-2d-imem-fw {
-						filename = "lpddr4_pmu_train_2d_imem.bin";
+						filename = "lpddr4_pmu_train_2d_imem_202006.bin";
 						align-end = <4>;
 						type = "blob-ext";
 					};
 
 					ddr-2d-dmem-fw {
-						filename = "lpddr4_pmu_train_2d_dmem.bin";
+						filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
 						align-end = <4>;
 						type = "blob-ext";
 					};
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 29eecd6d70d..d59b0030d6f 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -140,7 +140,7 @@
 
 					ddr-1d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_1d_imem.bin";
+						filename = "lpddr4_pmu_train_1d_imem_202006.bin";
 #elif CONFIG_IMX8M_DDR4
 						filename = "ddr4_imem_1d_201810.bin";
 #else
@@ -152,7 +152,7 @@
 
 					ddr-1d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_1d_dmem.bin";
+						filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
 #elif CONFIG_IMX8M_DDR4
 						filename = "ddr4_dmem_1d_201810.bin";
 #else
@@ -165,7 +165,7 @@
 #if defined(CONFIG_IMX8M_LPDDR4) || defined(CONFIG_IMX8M_DDR4)
 					ddr-2d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_2d_imem.bin";
+						filename = "lpddr4_pmu_train_2d_imem_202006.bin";
 #else
 						filename = "ddr4_imem_2d_201810.bin";
 #endif
@@ -175,7 +175,7 @@
 
 					ddr-2d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_2d_dmem.bin";
+						filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
 #else
 						filename = "ddr4_dmem_2d_201810.bin";
 #endif
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index ed2c704f2e5..b4deaa92160 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -96,25 +96,25 @@
 				};
 
 				ddr-1d-imem-fw {
-					filename = "lpddr4_pmu_train_1d_imem.bin";
+					filename = "lpddr4_pmu_train_1d_imem_202006.bin";
 					align-end = <4>;
 					type = "blob-ext";
 				};
 
 				ddr-1d-dmem-fw {
-					filename = "lpddr4_pmu_train_1d_dmem.bin";
+					filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
 					align-end = <4>;
 					type = "blob-ext";
 				};
 
 				ddr-2d-imem-fw {
-					filename = "lpddr4_pmu_train_2d_imem.bin";
+					filename = "lpddr4_pmu_train_2d_imem_202006.bin";
 					align-end = <4>;
 					type = "blob-ext";
 				};
 
 				ddr-2d-dmem-fw {
-					filename = "lpddr4_pmu_train_2d_dmem.bin";
+					filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
 					align-end = <4>;
 					type = "blob-ext";
 				};

-- 
2.51.0

