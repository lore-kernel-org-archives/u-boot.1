Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E60CCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B28383923;
	Thu, 30 Oct 2025 06:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eex/cT6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C057838FA; Thu, 30 Oct 2025 06:19:55 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 441CC838C8
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXzPVrbvLEgM0bWHvSj19hb82XgcggGw+JKCrotGpxDCnctf9psQzKXahlBG/yingU2PTqTla7VE9fV0INfuauuI5OjAbsgHlKNsgYtRn1cAtVgKYx9Q4MyrL/+77hAUMKERpgalkdn46LUVbtE5jN8/ebRC1oLLdJhXYlJUEeA+neVq5tiNUtNH21MulRCm/LsXpNE5aBLi9zSq05frwdZXYh1VpZalb1tI3Deg4j0wh9/0lAKQobMpDrl6JMvTFYLUIO6v7pSm3a5xnIV5lg8efe+VSzbjiapNVSV+bW/jvuTCK0qZDL1EwBi3eBJiyJHUYpqWs4LhWqOmgdgW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=809ssjUS0VNpbxzWq3d5KFjUgw4h0R3sHxn31nefYec=;
 b=qR4exUMcsOLwljTdUOItlRccg+vYj/0uaG3JxvD3q+lkAklEpDtwtWfLEqc+x7r3VW5OqJvsUOqWmS9vHGj3BTL4oBndPwE5haV4upEyQwk4PVHkkIgk1nyLBwEoTcpzoM26AnsdduJv3pKvPAyO/tw/xjjS8zM36GUDtFVesOh7ypy3V66hCwjxhmgDRP4J0Mh81OZ+wNgRGyocWM2WsGOSNhQAokpjmpfYS5tu+PbkzyueMlkKXYnAL4cX1JzbLF7rdSWqdavM0hsVoM/o8noPIuYBZDx54BTjYYLzA7vkfQcuGyd7BBGDcwMkmLcICVMQ3Q7pxxhDdNjt8szVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=809ssjUS0VNpbxzWq3d5KFjUgw4h0R3sHxn31nefYec=;
 b=eex/cT6pfng3fYwXrhVfoIqDcfJ2QkPiLMHSbC3rY6lDBr1F/HwCaPiBtRQlWVI0oojPawZdEu3HWHg8sqCH38zFydurgpd/bfwXg/zxxSZcOGujYzs/YcixYRQ2nqyReszDcE/1qPJ0QbQ5djnGVqW8xcsRa2aOD/O9G6gwd9s=
Received: from CH2PR17CA0020.namprd17.prod.outlook.com (2603:10b6:610:53::30)
 by SA1PR10MB997556.namprd10.prod.outlook.com (2603:10b6:806:4b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 05:19:49 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::4b) by CH2PR17CA0020.outlook.office365.com
 (2603:10b6:610:53::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 05:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:19:48 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:46 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:19:45 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U5Jiqi1446164;
 Thu, 30 Oct 2025 00:19:45 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v9 3/8] mach-k3: common: enable falcon mode from R5 SPL
Date: Thu, 30 Oct 2025 10:49:27 +0530
Message-ID: <20251030051937.3659010-4-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030051937.3659010-1-anshuld@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SA1PR10MB997556:EE_
X-MS-Office365-Filtering-Correlation-Id: bbfee5df-b71b-4c05-52ec-08de1773f255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kshFTomLux/toCIk/2iilYDXDf/GWHRFsmhs8sMs1akPFyX0efjyYcS7Udj3?=
 =?us-ascii?Q?590YLqe25MbwU8rCaCAwZd4B/v5U9mjU0/kpiwPTW09e8a+vhzzAPl8pXRMm?=
 =?us-ascii?Q?lbW1BRkwrYnuxpLpMdwW1JHFdIT6Q45LJ+/hdxDmrCnMKLPKTb/k7BlZLVW1?=
 =?us-ascii?Q?N2YVS7AjbX009+BnDjnVdyQIRjY5FLAZAo/DwLAkVcXIaMycHiAHYPE96ekU?=
 =?us-ascii?Q?ER5TkzosQ5qkGovwpGsOHkCUPgzHL0N9ZMBm7IGs+S+yF9GPq9Ghsn9fye6V?=
 =?us-ascii?Q?GoMp3Q/9KXCzit+BLO7SUG0ruCeE15jOCSkWZulDXT7pCI199KtOHUXT4TzZ?=
 =?us-ascii?Q?CXyJQFGLowcrwUS9rc4GHIZ8/TFVryIQRzUHpwzpFymV7/8deEwmTi0I1Q5W?=
 =?us-ascii?Q?zNmV7V2tFLXHoXUFV3WA36jTuZ21YJv8k5Vr3kPS72rdU7o0vCj33i58gj3A?=
 =?us-ascii?Q?vuPLUr653CCpqxLmk2XNLe3REC88HqgKpHhHwegEygCA/rHOUBnOcIsV5+xA?=
 =?us-ascii?Q?iX92N/1zIm2/a4pLfqke6Whz4yrJjEIDoI4HKH4sc7x7WOKMQ2YC3XJsSkWC?=
 =?us-ascii?Q?0JYe0k6VOEV50GueoZZiAqlWzjgZWOOa3iTnOlnt3ANcxL5ru1iYnhSsYdiL?=
 =?us-ascii?Q?JoBNg7u9S4w6mry0KrgVVc0Bc88EaaNcUp7oF2bWnuIpb5IMU18Eb8kI/hEQ?=
 =?us-ascii?Q?4GpiP0hyKCzCa7Je4ukwQjvllQHl4OZ0fpUn5IB311MINRETgA6VfmUPq57W?=
 =?us-ascii?Q?EL5kFzYioakel41MawP3B7gCIegaN3h7K8zUkLiRgpNOJtgA5RI9qXMUh84J?=
 =?us-ascii?Q?z56pAIk2tshzxfE69di9YCgJmYkk6Y/paTYWmbOefbO95qg2JtxadzgydZ9c?=
 =?us-ascii?Q?a0HnPMGxn3cX6czY0poNwipCF69B6RxYp/0kUUoS47u4vvzO1TshtkV2MSHE?=
 =?us-ascii?Q?1cAqOmTyT7DkqqSofVujyCYpu+oVw/MdC7YJzWw6aBgxGQsQ+/U9cnBSpFdO?=
 =?us-ascii?Q?UnDpyzdTSXomuJ1hGVJwpAHreaSKvyAjMLiRvz2PcmrjR+isSyhzpizD8b12?=
 =?us-ascii?Q?Z9BjGo8n24nc1YGM5GlhFmChBs/GGoH113EtCC6mRWWmZLyveRq7BRKUL6eR?=
 =?us-ascii?Q?MzBMa32QQTUGWi3OTTZ+guXSLZ8fpATNBmGR9Hnbaw2C3DLr1mK7xjek/Gd+?=
 =?us-ascii?Q?zPRn/ECn6Cv5+zIOd9Du5oQpfiHQ/nbWvtd7m1SfcIpcqSNwOrwE3PY0MH7W?=
 =?us-ascii?Q?mRa9CUZjbg9RmTjOU1EuMa5+PZUllFb4/I0h9NBibDfxDa8oEQFEPh2GDHzl?=
 =?us-ascii?Q?IsD44OtfFksxn3Nm+wxYZt7SIZ+Yj1SEqtpMa2+6geB8yj9Vx0KMQMj8tVKQ?=
 =?us-ascii?Q?+53Vuk7yk9GrTu/ZwNEqS3ttbxrgRorIApeqOWQzQxgBgjNFVCGQtyzLtCx7?=
 =?us-ascii?Q?kZQ/EaagJvnWPgA+KDE/IDmzlUFdOvbiCazsinSoIjrAeKeNqYZqHhtGxZxY?=
 =?us-ascii?Q?+H61Sq3JocqSaahblYtjLIJtO+8bUGxt0k3pM7d/53gzqOshYnq9dZVsPw8l?=
 =?us-ascii?Q?gn2R6Z1kSxzX3lZf16o=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:19:48.7013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfee5df-b71b-4c05-52ec-08de1773f255
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997556
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

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c    |  8 +++++++
 arch/arm/mach-k3/common.h    |  4 ++++
 arch/arm/mach-k3/r5/common.c | 45 ++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

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
index 6269b33f66b..439dd92ef54 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -376,3 +376,48 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	}
 }
 #endif
+
+#ifdef CONFIG_SPL_OS_BOOT_SECURE
+
+static bool tifalcon_loaded;
+
+int spl_start_uboot(void)
+{
+	/* If tifalcon.bin is not loaded, proceed to regular boot */
+	if (!tifalcon_loaded)
+		return 1;
+
+	/* Boot to linux on R5 SPL with tifalcon.bin loaded */
+		return 0;
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
+		if (bootdev.boot_device != loader->boot_device)
+			continue;
+		if (loader) {
+			printf("Loading falcon payload from %s\n",
+			       spl_loader_name(loader));
+			ret = loader->load_image(&kernel_image, &bootdev);
+			if (ret)
+				continue;
+
+			return 0;
+		}
+	}
+
+	return ret;
+}
+#endif
-- 
2.51.0

