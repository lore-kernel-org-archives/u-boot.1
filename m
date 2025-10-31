Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50200CCF9EB
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F0A838EE;
	Fri, 31 Oct 2025 08:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i5p7/4L3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5429C83914; Fri, 31 Oct 2025 08:38:24 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E518331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/O/o/cr2gBhwnQWUNcGwg4q8jnM9V1lvJ/v9tFbrdvXehjat9n+2JaXoq62GGyDuzx72Df1Xr7vOanpnY18C1WP9Hc08evCCuRYjdtCdSPZl1NMLhmb//wwnqm5dGcGmovK8Vk6iUJM96kGeZEmu43pzkW/sSJIOoOAoGXTZO4aWzDwS5rDqs3Gn3VkXN6fUrX0ShzpraANx40XtibIOK1muAZ6bMQxG4UXmmK5wkkx/vcEPgev4NpyXjg39MZqIzBCLACmaq1vy5UMYjvlB7AIFl5ZX8RBWsa2fPziuXRAZD4aMBK+dwx1WPMfAQkYv0jNsC6oCVgDrt3haXqPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev1C7e1CtTEg2gWZZ5xpl93P3on9jjAOuShAQ7FreZU=;
 b=O7MOyaDPKlTdClVsqYuQMhRG9yyjGFExVb91hO05QDxxQ1A5AV6ZU++Fw8JRPo40+iwPCcBNV/O7cESQdKF1j8oNnS4um7arXfuZ6VDLfHro6QVS8xwl+mQfy50LPIFuVPDvZaLiXPqNo41/peud8mXChhXA/B1hf+DZhObecv7YMplSIXTh75Xc6FI2iifWcPvlhGFv3Ed9GcO591E1DCm888bd1I+wg1X1ihXN3sY2iYkCxoffvSaejQoW5XUtA6u05WjL8JTKAmE/359CTrnyrIhnbEym7A4ktb7IKC0LqBFgLkSfPpaYIrs/2717+xkvRbnuXro4xKSHTBvgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev1C7e1CtTEg2gWZZ5xpl93P3on9jjAOuShAQ7FreZU=;
 b=i5p7/4L3Emt8VSr5n3vG3Gp6ju6Q+ytSWU8khPVobOMBktJAZhBiXvURnF8ZPvH2Ycem2Cys0jueb+1H3x+hwrVu4CWeA4fMUsomjsgmSsL456ygtTNTIMweW7JJqvqLt5j0Tv+J3EBuCuttgxC7ttOM7HLB/s9gYxeB+iL21hI=
Received: from CYZPR17CA0004.namprd17.prod.outlook.com (2603:10b6:930:8c::19)
 by DS4PPF20A8CDC0B.namprd10.prod.outlook.com (2603:10b6:f:fc00::d10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 07:38:19 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::2d) by CYZPR17CA0004.outlook.office365.com
 (2603:10b6:930:8c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:38:18 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:12 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 02:38:11 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V7cA1G3539956;
 Fri, 31 Oct 2025 02:38:11 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v10 3/7] mach-k3: common: enable falcon mode from R5 SPL
Date: Fri, 31 Oct 2025 13:07:53 +0530
Message-ID: <20251031073800.344500-4-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031073800.344500-1-anshuld@ti.com>
References: <20251031073800.344500-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DS4PPF20A8CDC0B:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d2f28a-31f7-439d-24a7-08de185075a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V+LZ/gM0YBOpmhvnI4yPD1QNuzqIhjEVbO+eoX9WwxPiys6BeL5pmTDrrDMP?=
 =?us-ascii?Q?dG8B/NiwLTZIDqmZTKHktzLpyFgcMPFdCAN3ycZJJknoHou5eZzrY6QqLuN/?=
 =?us-ascii?Q?SctWlgW4llUuA010hGuEMEMynOQ3KyzW7zpMXBxo6knCpp9M9HErp1Bdm27M?=
 =?us-ascii?Q?HS8+PXxh5p031ulLkq3zyDPgqo/X6mfui3uhO+hzn61Tv7GthpC41A3/UKOL?=
 =?us-ascii?Q?CjFL+aRiqiTnsBbER9PuritjCEgPFybeD8WEFtcbj5D37YPsdFDuKlC9L06h?=
 =?us-ascii?Q?HXpfCFCsMsCqy4/hAGG+3jlLd08uq3RLbV1YGAEge1q3Rg1a6osLZTHdykPK?=
 =?us-ascii?Q?oz3aFmqn21CvgRbCHoly70yss6PygBaG7QSxzoiiaNjfH/dCXfNcOT8ESwZZ?=
 =?us-ascii?Q?TUfTmkTA6n7GwoorscyNAvWqWeXZpSFDWBL6ruwMTq4bKeeVeM7iQiv1Fe82?=
 =?us-ascii?Q?GKISKLkeNQ5Z8eC0Hpwg5BhY2wW/eo0vHhbH/Ew9r1OW8c5i4enIsf4D7Xjo?=
 =?us-ascii?Q?1Y9+5EC3totGq0vn6JGxAyDGnuaIpP/DUfKQczbDBn7+7KEVIwqfFbdwEnVc?=
 =?us-ascii?Q?IkokN8RmNUQ4YEQxjSBPZMcwr4DUn9t9wXdDXu5RRT7I7RVbmISPhnRmTfPA?=
 =?us-ascii?Q?QWcVogAPUyyhCgiN00a30UKY/bNwsMw79hk0uJW7TXGlJRLP9LNGqTcfSL7z?=
 =?us-ascii?Q?9J4Kfb6iZaHNnHXILzOKfnXH9tipied/FQ8hhqMYkoYGuGrKb7fUz7XuJunj?=
 =?us-ascii?Q?4b8BEw3C+vhoWh30bU6HCfRCBKw/rLSkZs0n16i/b+8mRwwmFt2P6IcLIiTv?=
 =?us-ascii?Q?wqOdTTRu1k4ChkonJEK4OU6bZUiJN8g8knRwawidu1W4Oa5pyB8uw7SbXaw7?=
 =?us-ascii?Q?bnXMs5ucdjNZ4PLAMqZA0+E2+6kDomN3oz/PUcT3ihLh44Se25uBOs9FKMub?=
 =?us-ascii?Q?j9GAinCLfkJCglDIOb4yUpOtH5639dtq7vzN0jk49S4APiNG3y+M5ExcD6Is?=
 =?us-ascii?Q?C/imO4AA9FBMSEFyX1wC0HQ0k6H2D5pI3igO2ScrzOuR5+hj6ZMBcZ+7q0K1?=
 =?us-ascii?Q?XW1uooHLk8P+uRjQngUeJREB/MitqbRgIA62rMmE1q8xiyTktxBCeAR2Olkd?=
 =?us-ascii?Q?4NJzIakhwHdhMzqbRqSSLqgiqa85GUC6iYM3tccilMQpyAWTqFs+vffCZs/m?=
 =?us-ascii?Q?hpY3LFBZxXOB8Nu1ei8EAh96N+kSVrxkdCr3bXiou3nVe/8U5B8QelHyEwjP?=
 =?us-ascii?Q?/xm57uYc79WQ1xkNAQpojOyHY+bqlc2aEphNulS4e24sdqCTYdE4iv7vLAlw?=
 =?us-ascii?Q?VCffaXMXf7Vkzu13nOF0QMTvO5Fec5HAii/oFk6eO22macW5gJEQsiXmVFdf?=
 =?us-ascii?Q?PjQA553QXXEjoIY3DPpfN3mzQ6O320l921wDntEFnLZux+V5yqRlr5W0kN16?=
 =?us-ascii?Q?JL3j5+3UUr7zKS4407OiVaSRGJxJn2TjY5scb/aD/dG9hvDiVdFT0IyJLT/h?=
 =?us-ascii?Q?WoMShXM4BjXLuLyFDNmxaENPTwLRWwR0INysN+w1TLHNhjcL2Jr4YMXgdy6D?=
 =?us-ascii?Q?k6H7Xpa3Et5nHh6gda8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:38:18.2481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d2f28a-31f7-439d-24a7-08de185075a5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF20A8CDC0B
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

We use the spl_board_prepare_for_boot hook to call k3_r5_falcon_prep
which is ran after tispl is loaded but before jump_to_image.

In k3_r5_falcon_prep, we find the boot media and load the kernel FIT
just as standard secure falcon mode (since spl_start_uboot returns 0
now). Once the kernel and args are loaded.

Now when the flow goes to jump_to_image, we do the regular pre-jump
procedure and jump to TFA which jumps to the kernel directly since we
have already loaded the kernel and dtb at their respective addresses
(PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE).

Overall execution for the R5 SPL after this patch:

  board_init_r
  |-> boot_from_devices
  |   +-> load_image (we load tifalcon.bin here since spl_start_uboot
  |                   returns 1)
  |
  +-> spl_prepare_for_boot
  |   +-> k3_falcon_prep
  |       +-> load_image (we load fitImage here since spl_start_uboot
  |                       returns 0 now)
  |
  +-> jump_to_image

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c    |  8 +++++++
 arch/arm/mach-k3/common.h    |  4 ++++
 arch/arm/mach-k3/r5/common.c | 46 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 04a0f232d84..c446d1c47fd 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -360,6 +360,14 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 
 void spl_board_prepare_for_boot(void)
 {
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+	int ret;
+
+	ret = k3_r5_falcon_prep();
+	if (ret)
+		panic("%s: Failed to boot in falcon mode: %d\n", __func__, ret);
+#endif /* falcon mode on R5 SPL */
+
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
 	dcache_disable();
 #endif
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 52d3faaab5c..5807d358464 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -52,6 +52,10 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+int k3_r5_falcon_bootmode(void);
+#endif
+
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);
 #else
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 6269b33f66b..f0654102737 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -376,3 +376,49 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	}
 }
 #endif
+
+#ifdef CONFIG_SPL_OS_BOOT_SECURE
+
+static bool tifalcon_loaded = false;
+
+int spl_start_uboot(void)
+{
+	/* If tifalcon.bin is not loaded, proceed to regular boot */
+	if (!tifalcon_loaded)
+		return 1;
+
+	/* Boot to linux on R5 SPL with tifalcon.bin loaded */
+	return 0;
+}
+
+int k3_r5_falcon_prep(void)
+{
+	struct spl_image_loader *loader, *drv;
+	struct spl_image_info kernel_image;
+	struct spl_boot_device bootdev;
+	int ret = -ENXIO, n_ents;
+
+	tifalcon_loaded = true;
+	memset(&kernel_image, '\0', sizeof(kernel_image));
+	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
+	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
+	bootdev.boot_device = spl_boot_device();
+
+	for (loader = drv; loader != drv + n_ents; loader++) {
+		if (loader && bootdev.boot_device != loader->boot_device)
+			continue;
+
+		printf("Load falcon from %s\n", spl_loader_name(loader));
+		ret = loader->load_image(&kernel_image, &bootdev);
+		if (ret)
+			continue;
+
+		return 0;
+	}
+
+	printf("%s: ERROR: No supported loader for boot dev '%d'\n", __func__,
+	       bootdev.boot_device);
+
+	return ret;
+}
+#endif
-- 
2.51.0

