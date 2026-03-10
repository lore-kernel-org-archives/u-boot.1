Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F62DFD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF3F84106;
	Tue, 10 Mar 2026 14:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ro5/rR0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B46583981; Tue, 10 Mar 2026 12:44:14 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5386583FC0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3RD9iLzfnTY43WplOYj/jkJErkckAPh3iIiADjcYXQmkfkjWSsX9yzY70UW2BSvG7WRp3fhxlxpUkoyLCIbCyqguRmdmuHKSa9GGb/nlu1dO/pvW8mKvva8zjHEXxWlGXZeGnOmVA0F4NSglwKLI+72NxmT79+OkjqJcax6HzFTTVzYNvAwQSBIpR+WFg5w7uPVz7S04S6SkMJH0UdT95rh038qvHpgQAPWue7e9A4QtPf8PIFWXS+CrUFxPtaq4NIGn9pySB2rf2sKLI2FKmpcLcQ34TI7Inrj6oM/roAJahkD7uxqkwhUpcf9aFHUab4hbrQaj+9VyC39giVOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0/PsFLW4jz3o2pLbW4cZkI9PxdssMSq2zHzttWkBg0=;
 b=VMxBspn79IG6JwSZBpbmBKvwOtkvpUk8o/pEKirNVb3+XrE10Io8cjaa8gDR+KlItogS41k9G2HmC5B5f+O+Np8Xif4K3QBP9DP4uTZc1h6SiQIRevnfRkLGG17+gBmVC0MeSy0qMIg1IuNnN4ZV6HGhAAAjIXSQLB2FREwxZHBqQ1aAjtMuy37ZV6WE0yXlYPxuYliq2MhOP7vDY5f+o4XSpod4I2Vq1EHzzip5tsp5puk59K8SaoMoe3EeYnVylaOLBrCZjaf7gTSLWqxIU6ikdiDBlZFu2p4pF9K28Qadt0A23RrCJJndYBmoi/JFSxJEZvOKfYAzVvsENpRhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0/PsFLW4jz3o2pLbW4cZkI9PxdssMSq2zHzttWkBg0=;
 b=ro5/rR0HHa297vwPo1H7zvAy5kVH9yWJOpMeTk65T7IsqlEaGXbuxHVLL9U9Q+zAahtNHkWv0vyGl1eECNQzT4Zd15mqoVnuv1ARFOmdAHg6xTWkPnppc8GrfKeOpffydTWXREC5l4qXoe+XcAtlbSg2hzzGPrP+1vX1J2heqOKN9P+zxATlFpYO8Jl0XCtVUfTXtw/69B1o4NmlfUxWiJp1HcRCvhWHGtP6ZHi2L1dixciZkukJynaGMNltXWFwYio7zXDstKP/73Q5hGt59Ew1HEYSghsXgqq53Pzuv2bX5QgDWipXgJzkYVMjaziqZwOFauvMA4hqbWFoGzlMpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 11:44:09 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 11:44:09 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, marex@nabladev.com, ravi@prevas.dk,
 fedor.ross@ifm.com, sebastien.szymanski@armadeus.com,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 sjg@chromium.org, tharvey@gateworks.com, ping.bai@nxp.com,
 qijian.guo@nxp.com
Subject: [PATCH 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in SPL
Date: Tue, 10 Mar 2026 13:54:23 +0200
Message-ID: <bd23b79dc06f39a9f19ee3da956de450aad03aaf.1773137310.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773137310.git.simona.toaca@nxp.com>
References: <cover.1773137310.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 332712d1-8c7c-4ff6-2087-08de7e9a575a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: ulSKQQieJl2hAFogop0UXTI4RPVX3/roRWQJy3OhGiSPEzxhJ9ANlwMoMMx8v2vcaqTwqDZsziRUMtFl6tr8jFS6f2pcguy2MC42WG2DMUC2lViUysHnF+yQqsSEzle5EouE/RqDsTK8x17JoE2h1Tlar/ku2if0RluyZoftbKyzdHwZfFbeu6TWNqF8OByIfE8KMT2yG46IezeAObHHpfcniXHQ0T2+3nobmG2BWALnqkfP4w1k2HObkRc41fr3ZAeMN5lGWMUIXXuMSpYOw9h0pUP6bA/PEvj02VTaqNVyKowl4BCNkF586PjgKLqXwc4RCaKwdiuJPx6Hts/w4MrjhGop11wgnQnPLAelHlwq8qGZGjKDll5GjTCbJn7hR7VAZPIlFrSkQ3TkqyLET4KzJvs+TzyK9pr4+Q5LEBde8Sh1tSiIRnmcbKZfnmxosxhIByqp9Acp2SUUZCRt6PpL04tFMYtqDLrpRp2KwF7kMGK/qi8rNQJGLKyMwRk0JaQuq4ad/1RG18OQu0xDFv297CbfeQQvw9helM8MhBHp6dGqzanBipqxl6mU5AEYJGBG9oYvbFbI1c5sbUOAvK3dR8rWA/Q2QjQ0fSPzIzHIyCRMyaHon3AAJfjRI1hc4sbXQOamUBTT/z+Y1eHfBJlBVueEz8aj9V6TCpAbqIHTDtT6LHOkz3jRBqTAl8dujartREfXZw8nBmf9vf6MfdC5bqixFn1RudpQe1+7fDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/a2gkOxV+SWD9kw9QjfHGrUxGA/++I+FxUxUymCeAoSNtHh5YINytQkNlvSH?=
 =?us-ascii?Q?LSI6wCwNeScd5YXpy8JZS3ed13HhVNQIJTU/+SPQ659+gYCx9RiqjL14HcQ/?=
 =?us-ascii?Q?xCBmGJIxvp+AmcClMkUtUl32dLvsGLghIGQlsX9gQAg8Yv19VvrV+sfQyAAp?=
 =?us-ascii?Q?Wizaml4HHiuIg1mcZxLCcwVlHoD2FfKsBdnCrURl4VhHamC9kwjslU8Gjv4k?=
 =?us-ascii?Q?GSq4v0NmlgE8wW0gHLGTA2qSb8//vyRhA5OerKAwwzM1YG3P8JAT2tsJb5mr?=
 =?us-ascii?Q?7Q+CZZGBfov/gM4PfC+ghmBwcK2pB/C79YSCIQU7Hoe9/WdgxomJEIqRW2kQ?=
 =?us-ascii?Q?KasDXf+grLjt7vE7HSXTp3sYxjT9edeieVPFNPzXEf55OOfJOhgYF7oDIjMD?=
 =?us-ascii?Q?7voyFkgOuBiZ/oUfd/BHky+LxxM6+9zG2tOXXVrzn09XH+ZPcewk1XsVYJxl?=
 =?us-ascii?Q?YRWB4H4D7TiVxpVITAVBNkYxMXNUA+HNAaDmo5iejpPBQNBmkm0ylWzGVpEb?=
 =?us-ascii?Q?87wNWnPylxzcEIDbiXvTFtKVgkoUVxrnlo2lihwbUlOszs5neteb9YZSTiG4?=
 =?us-ascii?Q?naUB+G/E4q22LYN1xSZhiE4zUSWc7L7t2C5g0LBGoHaxhZabD+KhhEn9jzG9?=
 =?us-ascii?Q?jFA2e8VLuR5OS/C/wl3rpoQ9EjBIgTFdcnxwIrqLkcNSioRDFGk6/LKTWU79?=
 =?us-ascii?Q?sbf1Ga+rkhRyGjU4WOGAaD+0d9UNbgUnRgRQrCj2i8ESJxhsGCtj3xTAjdZ0?=
 =?us-ascii?Q?20lJ+k9XwAopkgPgwb9jepEUqPZ9iGcyY2FyLIkx0r317TcpaOLSb+v+un5g?=
 =?us-ascii?Q?x5GCMAKybPgUZeRKxZ5mhN8asb+zdsRqdHqz/DavO3I6O9cJ6mbOgs3ZHs3l?=
 =?us-ascii?Q?zti0X8Dup/D5vDwx9fpW1yAEDwMYdIVrZV4OSOWRo1ozuKZODdRCF1tgN1CE?=
 =?us-ascii?Q?fMahxbJQQb6/yGoUQeRntGi3hsDKC+q8Ym3O55cdLnASp2Ut8eUo2TLhhCU7?=
 =?us-ascii?Q?sKAM27zGBz7+kqT18tUeLYTNEnPJFRNy20/9NLNsEg+a3mL2DM/5671F85SC?=
 =?us-ascii?Q?Bgzxhc/x1gUSIs8DCvtKuf0LL3vEeLRupy8CRZ3uKq+CiiIY7ibrHJ+OIKID?=
 =?us-ascii?Q?xVm3Rt1KPtVy1yFFyj4iJNgbljOUWNNd4mJWg8GTpbA0C862hH4+bZjr9NvT?=
 =?us-ascii?Q?0uLpSiQzu+xlJ0jX3ExCRNiI2Zr2Od2X+aSFHOHAEacmNB/huaEUBCA/kICl?=
 =?us-ascii?Q?fnuMEmU/JsUjZwb8HIbyEciWWE08nOEJKOwcG+DO2oKOp9sxtZz8Df1RxNHV?=
 =?us-ascii?Q?nb7ZO9s2gWr2ZH0Npyef3Se4NmRbjAaaMnOD79oDoys9izoqhI+D8lkdoVnZ?=
 =?us-ascii?Q?6XDPNdL2OVtmBe+sn3ekhnxp5SmRmSl3dE7HmbQhe0nydUY2UAYPusvTdxXa?=
 =?us-ascii?Q?6UsipD1LP8URGqDKO6FsTy8ek0AtlponoLjLRHJA+XUqpwY2G8Ws9a92Pbcp?=
 =?us-ascii?Q?PAfTSTtrVmJMYapUQXpVZyjcyqgmoYkutoCpp0oaJXD5B86jdMQTgPnshkT+?=
 =?us-ascii?Q?Cv2V3AQCWOTPTlaXlovL1NETiV9Do3DemzrIrRU3ninppjQKATDAohiBfQ8D?=
 =?us-ascii?Q?XjEmZ2PuWVWSOZTJ4okbtxEB9xeUkB1mYdklphhLRCHVSYa9iiDKJw/w1plk?=
 =?us-ascii?Q?MWnInvzEsM4vJ3giI3ktnb9DsmiaL9hxSig8HlcLN+ChY+QqIECwKnPMxhMu?=
 =?us-ascii?Q?DyLiU5gDhA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332712d1-8c7c-4ff6-2087-08de7e9a575a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:44:09.0724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeSELWrm/6sqCC3bg7Zx+Q7LyUG9++brh8WzOOxgReWmm6R82p02TD8OGCbUCr1JaHRsWcgxB++7POMxyokf9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:35 +0100
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

From: Simona Toaca <simona.toaca@nxp.com>

Call qb save automatically in the board-specific
spl_board_init(), if SPL_QB option is enabled. This
makes sure qb_save is called before any image loading
is done by the SPL.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 arch/arm/include/asm/mach-imx/qb.h | 2 ++
 arch/arm/mach-imx/Kconfig          | 7 +++++++
 arch/arm/mach-imx/imx9/Makefile    | 4 +++-
 arch/arm/mach-imx/imx9/qb.c        | 9 +++++++++
 board/nxp/imx94_evk/spl.c          | 6 +++++-
 board/nxp/imx95_evk/spl.c          | 6 +++++-
 6 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/qb.h b/arch/arm/include/asm/mach-imx/qb.h
index 5efe68f0a60..4f923d79e7a 100644
--- a/arch/arm/include/asm/mach-imx/qb.h
+++ b/arch/arm/include/asm/mach-imx/qb.h
@@ -10,4 +10,6 @@
 
 bool qb_check(void);
 int  qb(int qb_dev, int qb_bootdev, bool save);
+void spl_qb_save(void);
+
 #endif
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 17aad696648..069b25c6241 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,6 +71,13 @@ config CSF_SIZE
 	  Define the maximum size for Command Sequence File (CSF) binary
 	  this information is used to define the image boot data.
 
+config SPL_IMX_QB
+	bool "Run qb save during SPL"
+	default n
+	depends on SPL && IMX_SNPS_DDR_PHY_QB_GEN && (IMX95 || IMX94)
+	help
+	  Run qb save on bootdev automatically during SPL.
+
 config CMD_IMX_QB
 	bool "Support the 'qb' command"
 	default y
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 7dee144e0f4..3207013812a 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -15,7 +15,9 @@ obj-y += imx_bootaux.o
 endif
 
 ifeq ($(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN),y)
-ifneq ($(CONFIG_XPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
+obj-$(CONFIG_SPL_IMX_QB) += qb.o
+else
 obj-$(CONFIG_CMD_IMX_QB) += qb.o
 endif
 endif
diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
index fc01d8e22e9..79573741d39 100644
--- a/arch/arm/mach-imx/imx9/qb.c
+++ b/arch/arm/mach-imx/imx9/qb.c
@@ -428,3 +428,12 @@ int qb(int qb_dev, int qb_bootdev, bool save)
 
 	return 0;
 }
+
+void spl_qb_save(void)
+{
+	int dev = spl_boot_device();
+
+	/** Save QB data on current boot device */
+	if (qb(dev, dev, true))
+		printf("QB save failed\n");
+}
diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
index cc5b7f9ef0f..1d25795eb17 100644
--- a/board/nxp/imx94_evk/spl.c
+++ b/board/nxp/imx94_evk/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <hang.h>
@@ -14,6 +14,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -44,6 +45,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_qb_save();
 }
 
 /* SCMI support by default */
diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
index 761a1a4a0f6..35e4458f2b7 100644
--- a/board/nxp/imx95_evk/spl.c
+++ b/board/nxp/imx95_evk/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <hang.h>
@@ -13,6 +13,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -41,6 +42,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_qb_save();
 }
 
 void board_init_f(ulong dummy)
-- 
2.43.0

