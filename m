Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAF7CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 05:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF6A84895;
	Wed,  3 Jun 2026 07:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="msEGvZlh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2D4848A1; Wed,  3 Jun 2026 07:50:06 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A5AB84881
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 07:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJDYcS0avzOEaFMqdn9x191rvBNCa7Yn4Uc9Z/pl/LG/q69oBuFNc8dA9iu/1n3m4EJTPhwulmGFxiKLEggo2c3WeA8seOlnI9Nm7XkKth4LQleMguUZIEUlK+4WlbSjWTlZolP5RWhpPlZouAdaWTZoW33F/29liTUQUoKQcxYNxQCM6jiqil+tCVBX9mEqtkikCpVoSS0E/R6IM5etJPUyMNBqnzklsY0J2Ki6aVOYTRT5KFldKNqUL6BELZtaXYGMPl305g0frgbNmixC/epbV1S3RLKI3MrhG1jq5lg9OE8aJK/Q+ojhq2MyxzygyVWZhr3uNQxk1mhUccLu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkXIlFKTUAsfjMcqJZzGkfoFQnphpZXkFFCDizQ0Xm4=;
 b=bU6HLedoOcKgN6+MvlbjC+K+6mmr87Q61p6JzUpunGT/KKRIL59DyDzqJ2GXAg63I1h5xN1wYF+RbQtx8JPA3jPaGbSnm6l7hAg1CLUKJqeJEtj4kPUA0BVjC1QYOyOwoWwfAqfrTo5oFaX7jWMNiD18vjFk/vlJ7MDlARwnQd0IP+pipNjaftYZmPudEyvpyfgGLoJYZhC3WvQUxMYofI/2E42Lrlyiu4XKalREEDN+DK9giMuxWt5rO8x0CknW/Z5q/63REhfxKYn94FSfcJeDiJgjR3z162CSy7g7DCGw8TsJdULr334WWTOzTSlKHw5Bdn2U/0/MzNcZssFAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkXIlFKTUAsfjMcqJZzGkfoFQnphpZXkFFCDizQ0Xm4=;
 b=msEGvZlh4ejQoOoUxtoTMcgeuvkP57fguGtiwacKdohGMFxPZXlQcsVZadRyOoRm9+fMD26jIXpt4Pv/Z3gEyhtamk8mcaNrjaQEzGlD5FuucrXI+fCO0ugPe7hgjC7/OEoYF8lKgFfOpCs/2OBlJum10tGwHvtGKxqqUEZIIJSMN3m+A1r7UQ8ojb8xyaHA4ja+d8o6ESY4p+f9ZnTEKP/0yPxg8nGmaeeVNKG+ZSssf1PhZKu27BLfjKIs1iBCA5i12aSToBCG8TMi2uAFzm2gBD1Yq1bvLL5h0Q8o97Y3E22VRAtc/+3iFix2N6UR1jd9H5llJIxYQo1tqcj6nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by VI0PR04MB10370.eurprd04.prod.outlook.com (2603:10a6:800:214::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 05:49:57 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 05:49:57 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH 4/4] nxp: imx[95,94,952]_evk: Implement board_fix_fdt
Date: Wed,  3 Jun 2026 13:51:59 +0800
Message-ID: <20260603055159.414338-4-ye.li@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603055159.414338-1-ye.li@nxp.com>
References: <20260603055159.414338-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0165.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::7) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|VI0PR04MB10370:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f711c59-dadb-4a4f-6e6c-08dec133f1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|42112799006|366016|1800799024|38350700014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MNRs8x8/3bJAvxjOJnS7sQA2/S20uGIsTLNzLShcTxQSpMuiHxahj3K8hCz9ijCBuNJVGIdy1h3Eb4n6x4MkRH4CCnNd0mRJrgs0PC9qJU1lGlpfiSEFyiXgNIoAOpdKTlw41JFmIk5FAHxWDoOaIcEgfVgNkgH0IRhKktxLN6fFS4dRV6mcAsMhkBML5XKUQ9OcFHUtS6bwhrbJuuV6MG170F9JXpcHD4gB3cZmMWjYYiDBdpN22ToTVd5yoazfpajVM2CjUjHFeLmbi1KkRaqSkIUUthS/XWnLXJ3uV0tXcw0NQTrTnM06trcZDsvlhMA1IgLMHDxzM9vgNwJk6MJMcNg6O7Cx2vZy6ycZaSreD/fjqXgC7IjPBj0ySbjymy3G7GCnfRE+NJ32tFws5YleodqV/y9yIxeT5cz8L8TFtIB1QDp1lZk1h+pvXYm6H+CECpusRfSkofwJmhscyNonoSfKeOem5pe7x/J4p3TDEpSkwqQpfZHsO3zp0IibWwEAU7rJuBGNYiBzAEXzBGtGuzf9b994QIMT+ApJksDihEgpAh/R3QN1XwTBu2LLq9/G7LTDc44McMaxZtab5CTlmUjaq03touAalBzs6BWV06moqQLshe1DS0WauxtZvUaTnjJZ6uOwus6NZ1Qf8nszjiNMzlyaO+B860POIMip7I0BlwDrWruxDCm9vjfqYSihixyMXPyOAfwaVlXqMiM2ucrIaFWlEsEODVlbizD+LiF2/pXloeEzpl4H0dk8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(42112799006)(366016)(1800799024)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DlZwvNcagqn91dGZ2rctYjCeRdl/K05sQlSAkP4rXWCYCcGZN0AqniWT5IyV?=
 =?us-ascii?Q?1SM65z2eCs/DY+MapwgMft8OzPRLvnsJ2D+ip7MKVUNCpKiwvJYeyjwYrLF+?=
 =?us-ascii?Q?4fL0coMsv9znynet7JbmPkk9ql6P0yJyzPuJ029BrwECjoKpm11JsnImPGAM?=
 =?us-ascii?Q?KmHHyUh2yyAm4tZEPWYu2d5payac3P4/ubmpsrZD9dDfH/5NyjzQUgVA8gSU?=
 =?us-ascii?Q?qj72wmeW9H4wUl3qINXtYCeJnG2VCdPzybkXbAAK8pkbVHoEBlsq4fabvmAX?=
 =?us-ascii?Q?rDUqpWM3T2njBjYIlCEgpEkfAMtJQLJX3iN2oXvM2OZFYaeBqJxgHLpGr18b?=
 =?us-ascii?Q?9lYDfyObu6m1WAdgeUp9ahOdp+gqE+Xo0Q/A6Pw7erMZoDdhmADlPRczIiZ9?=
 =?us-ascii?Q?mOoUg3wCbQbcZEO4mOjGcaQak4AY10sn8YCrHqJu/akkHJXHn7EvPVfA3TW5?=
 =?us-ascii?Q?QIAuMoSz7dRclv/bLDD4OwSwmCyu/2/l2S+EFtVdS3//XW7SJHCQ9Me496la?=
 =?us-ascii?Q?5nHrFE/ev4bWvsBoa22PhiroMSZNZZBW/LlpoY0HM3oeoQX9g45TkarUxwyL?=
 =?us-ascii?Q?xJEVf8Ysos0WCW0ZyPtKMzZjG46+vWiJmMHPkAQkChny61SEhjlX6vaugBpr?=
 =?us-ascii?Q?TJIJ6/DNDjDHB2+f1OBNYChcYKzGZ31b1KWAb4ifTnYbmC5/f/wy6fb3FAyM?=
 =?us-ascii?Q?/0BM9r1QoBkjMOdYmD8+mjE23+Cl2uj8AxaL5Lj5UzdA/kQuAWzBRsQJBz+N?=
 =?us-ascii?Q?NjnDLcYJo0vDIv7Nq8ZbJeQZ4YmO8FkL/K5P4Ix0onF6kC39pJiL3u5DOOBf?=
 =?us-ascii?Q?FYBzVG4rDt/R5wPRCESAczIbFiJ/3xq+f/vIWbUscrommq16vcOuPnOxWqz+?=
 =?us-ascii?Q?ftQR9kL4RjK7cZdxV8CWUfa0iswino48b/LR/CcNypyInHsEholgKua837I+?=
 =?us-ascii?Q?h+AUHmgzhMFh8HspmwCJQq3aCWEp51fGS13qA4RlhLoQM+7KRbRetJOjftAc?=
 =?us-ascii?Q?D1A+aAvXRCHDAIV1ldyo+kcVPUByvIMO7rqIIrvt3IbGcWAVLmuGyH1sSwL5?=
 =?us-ascii?Q?9MaKNG3xa1zbLeQxA22Vyxh/gnafDX83ue+Cy1ml7D13rnjHyy0uwANwo2N9?=
 =?us-ascii?Q?C9XPqwUJHT+a4SCp88sN/m+7AQc3offj7CI2JAFxFmKCJD2zdi7VmSQgPL11?=
 =?us-ascii?Q?ggz2VMAPik1l2wXKL4a78Yfh2kwWB0Gvw86di7srjmVG6NNezAgRnoAzvHvJ?=
 =?us-ascii?Q?lEHAhDFhH1PgNYF/CMixZCw6slIgZlLtwocBOAondq4FV9O60I4tB9AHW9qx?=
 =?us-ascii?Q?ZdE5QEp7Cr9nzhC1SyO22E1GMy8xsMO/JmiL1hFnbRj7U36YpRlekkw32BdP?=
 =?us-ascii?Q?Fe+Xn1a/BiYlhABq1vHAgdNGmaFVxiDIg+kJVM9eK7f1RYREvqnmPTfp7/w/?=
 =?us-ascii?Q?CIwYsA0qct+QZSB8FIMIz82u/ggdx5QI8psop61IUTrVlCfK1QD57NcPY9O5?=
 =?us-ascii?Q?MwH+ecHlhPljJrfvLEOAnmEKoGriYblXs//XvgGbXTkaX2ekd79/sHq4iN1A?=
 =?us-ascii?Q?difRqnqdJOHQ0HYDBZX3A1KmSXt+2E0hLSXp7ipMvS8yhGizTFGbeHIV6nsh?=
 =?us-ascii?Q?RpE+KHaFcFopSVo7Vm17nKr3OD4BlqFt123ksSWw1PN8/KbPBX9w3pBmL4YD?=
 =?us-ascii?Q?3pPY1fyp+YMi+hHx99RqEUJhONk+Rr8hLrUd8eGW1c61Aoqf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f711c59-dadb-4a4f-6e6c-08dec133f1b5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 05:49:57.7005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJg3BDxJY+5pwx89Xlt6gFm9o/HgtchzUqHkFU5ckK06XE6TsXg+Tz/CaTspP6bE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10370
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

Select the OF_BOARD_FIXUP and implement board_fix_fdt in board codes of
iMX95/952/94 EVK to handle fuse setting on various part numbers.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig    |  4 ++++
 board/nxp/imx94_evk/imx94_evk.c   | 10 +++++++++-
 board/nxp/imx952_evk/imx952_evk.c |  8 ++++++++
 board/nxp/imx95_evk/imx95_evk.c   | 10 +++++++++-
 configs/imx943_evk_defconfig      |  1 -
 configs/imx952_evk_defconfig      |  1 -
 6 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f072e6a9e3d..1e7245c74e0 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -146,6 +146,7 @@ config TARGET_PHYCORE_IMX93
 
 config TARGET_IMX95_19X19_EVK
 	bool "imx95_19x19_evk"
+	select OF_BOARD_FIXUP
 	select IMX95
 	imply BOOTSTD_BOOTCOMMAND
 	imply BOOTSTD_FULL
@@ -153,6 +154,7 @@ config TARGET_IMX95_19X19_EVK
 
 config TARGET_IMX95_15X15_EVK
 	bool "imx95_15x15_evk"
+	select OF_BOARD_FIXUP
 	select IMX95
 	imply BOOTSTD_BOOTCOMMAND
 	imply BOOTSTD_FULL
@@ -160,6 +162,7 @@ config TARGET_IMX95_15X15_EVK
 
 config TARGET_IMX943_EVK
 	bool "imx943_evk"
+	select OF_BOARD_FIXUP
 	select IMX94
 	imply BOOTSTD_BOOTCOMMAND
 	imply BOOTSTD_FULL
@@ -176,6 +179,7 @@ config TARGET_VERDIN_IMX95
 
 config TARGET_IMX952_EVK
 	bool "imx952_evk"
+	select OF_BOARD_FIXUP
 	select IMX_SM_CPU
 	select IMX_SM_LMM
 	select IMX952
diff --git a/board/nxp/imx94_evk/imx94_evk.c b/board/nxp/imx94_evk/imx94_evk.c
index 4731b79b55d..02149afae87 100644
--- a/board/nxp/imx94_evk/imx94_evk.c
+++ b/board/nxp/imx94_evk/imx94_evk.c
@@ -7,7 +7,7 @@
 #include <fdt_support.h>
 #include <asm/gpio.h>
 #include <asm/arch/clock.h>
-#include <asm/mach-imx/sys_proto.h>
+#include <asm/arch/sys_proto.h>
 
 int board_init(void)
 {
@@ -26,3 +26,11 @@ int board_late_init(void)
 
 	return 0;
 }
+
+#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
+int board_fix_fdt(void *fdt)
+{
+	/* Remove nodes based on fuses. */
+	return imx9_uboot_fixup_by_fuse(fdt);
+}
+#endif
diff --git a/board/nxp/imx952_evk/imx952_evk.c b/board/nxp/imx952_evk/imx952_evk.c
index 2a61817939e..b5c2da032a8 100644
--- a/board/nxp/imx952_evk/imx952_evk.c
+++ b/board/nxp/imx952_evk/imx952_evk.c
@@ -24,3 +24,11 @@ int board_late_init(void)
 
 	return 0;
 }
+
+#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
+int board_fix_fdt(void *fdt)
+{
+	/* Remove nodes based on fuses. */
+	return imx9_uboot_fixup_by_fuse(fdt);
+}
+#endif
diff --git a/board/nxp/imx95_evk/imx95_evk.c b/board/nxp/imx95_evk/imx95_evk.c
index 99a37e0593f..394d6fd459c 100644
--- a/board/nxp/imx95_evk/imx95_evk.c
+++ b/board/nxp/imx95_evk/imx95_evk.c
@@ -5,7 +5,7 @@
 
 #include <asm/gpio.h>
 #include <asm/arch/clock.h>
-#include <asm/mach-imx/sys_proto.h>
+#include <asm/arch/sys_proto.h>
 
 int board_late_init(void)
 {
@@ -14,3 +14,11 @@ int board_late_init(void)
 
 	return 0;
 }
+
+#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
+int board_fix_fdt(void *fdt)
+{
+	/* Remove nodes based on fuses. */
+	return imx9_uboot_fixup_by_fuse(fdt);
+}
+#endif
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 70265f13bba..6fca85a3242 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -26,7 +26,6 @@ CONFIG_SYS_LOAD_ADDR=0x90400000
 CONFIG_SPL=y
 CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_PCI=y
-CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x90000000
 CONFIG_SYS_MEMTEST_END=0xA0000000
 CONFIG_REMAKE_ELF=y
diff --git a/configs/imx952_evk_defconfig b/configs/imx952_evk_defconfig
index 66a56ddb879..b74df3a5d5f 100644
--- a/configs/imx952_evk_defconfig
+++ b/configs/imx952_evk_defconfig
@@ -28,7 +28,6 @@ CONFIG_SPL_OF_LIBFDT_ASSUME_MASK=0x0
 CONFIG_SPL=y
 CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_PCI=y
-CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x90000000
 CONFIG_SYS_MEMTEST_END=0xA0000000
 CONFIG_REMAKE_ELF=y
-- 
2.50.1

