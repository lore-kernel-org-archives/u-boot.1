Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B15DCD5BC9
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 03:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCC3848E3;
	Thu, 28 May 2026 05:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=axiado.com header.i=@axiado.com header.b="S2L29BJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40FFC84839; Thu, 28 May 2026 04:38:59 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 577D7848A1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 04:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=smtong@axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wf10n3M9H8KqCqGqMuempLlB83i9ysp2j29pyJhl41sqFB0qlHuxKieH3c94di34OByp3ndxr13SL3CuuwOG8pX6N2cHv0zCL4t6BoFPXXRev9i3TUpiINmWkWi+9ekqZ4GuBl4JcWJQkpF/bywmpQcYbYCwubhIk04xjw/XkH/fsM7UWlQNmKiGFa7xO2dF+N/SH8L6pRYQLk+to8h8ax45BG674r21trO63aJEgMSvqeKhk3OQJ4nKEkWv0aGZ+DtdXJ3qfMNu+6n4bYjWx22zmBYqftanQzNrHBhv61EDt5+Hb+cTsnhgdRTnKeJULmsDh93olqLyy3CdyjfBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ocuoDK5c6IZd8nuHg1HkH7NpmSZOKVg0fZYGeD5eaU=;
 b=ra69kzmZUxo3EHS2Azn91CPTVj8ew50OmSOUzsjF0OeMcagkrUz5+Ve2FFrbEuHkX915NjSf1uR8Aw1glEU4nOkbYrMl145s7bomG9CvaVAoKcU7dsJjB7kFmlPZmEgP+HO8lE1SPKKhPqkSIhmfZCBWSXGxnjTkhrThVu3hb/TYlZvJOUXfpe60Um83L86qF5fX1Oec3uuROB3iR0icdYt6ch9cb7rzwXcxEkUqIe3rEokEbjiUYkSEMvmYkRLnaMlImJhiDfekACIcrRPO4UtLjUXBJM5/XuENWjA9CulUYJxJrXhBOOMtwPFyDuY30XGJjiprRe2GX5a/M9zZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ocuoDK5c6IZd8nuHg1HkH7NpmSZOKVg0fZYGeD5eaU=;
 b=S2L29BJ0JUYnn9BMR4red50/dhW8MvJZrMgQNRRoGg0drNdiijzqUe/axVbH/KgFgQQpk/BPPbMEfNTiSodOASVYpY/7IOcIXEHDjoTTXClZNG52WM17yiGtBtHRJhkhIRkem9Z+WKZfx3mUMjHNZdS3YgT+GAAEVbCrk4xWXPvhg+F99Z/TYWEwnzByvm0jM7/X4EDS9NK/5//hYdmY9Vdtvd0vdbltLz4kbP+V6m9Ry+Du8ihrvPeS3sSt+gN3cvvYcLPP+FCtttd8gojY+6bowqGwblxJO5hdSQ19UqjXIRBzgZF1lcDBAeFEZEa+xOJ6zgrREABtqVRtMyH01g==
Received: from SJ0PR03CA0289.namprd03.prod.outlook.com (2603:10b6:a03:39e::24)
 by PH3PPF9936212C8.namprd18.prod.outlook.com (2603:10b6:518:1::cb7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Thu, 28 May
 2026 02:38:50 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::23) by SJ0PR03CA0289.outlook.office365.com
 (2603:10b6:a03:39e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 02:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 02:38:50 +0000
Received: from [127.0.1.1] (super-compute03.axiadoRD [10.4.1.87])
 by smtp.corp.axiado.com (Postfix) with ESMTP id A87394186B5B;
 Wed, 27 May 2026 19:36:30 -0700 (PDT)
From: Siu Ming Tong <smtong@axiado.com>
Date: Wed, 27 May 2026 19:38:37 -0700
Subject: [PATCH v2 2/2] grm: axiado: Add AX3005 based SCM3005 board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-review-v2-2-10daefddf47d@axiado.com>
References: <20260527-review-v2-0-10daefddf47d@axiado.com>
In-Reply-To: <20260527-review-v2-0-10daefddf47d@axiado.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Siu Ming Tong <smtong@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11857; i=smtong@axiado.com;
 h=from:subject:message-id; bh=+Xde41PEs/hw1Qx8Xg3+yOTuDhvznPWNsikQaUPzUKg=;
 b=owEB7QES/pANAwAKAXwcqHIUQvOOAcsmYgBqF6q5ClpcQeUK5csEqCnaYMfwcaPAFIJ14MMtR
 RUHxfkb+s6JAbMEAAEKAB0WIQR3Lze7GwS3XzAkT0h8HKhyFELzjgUCahequQAKCRB8HKhyFELz
 jo/PDACTkvEyH9bWSD4ycgk2Q7Y7PCAJmTlcYCPAuCVYkLrmAKZevvSWCbv9vxlsNgkRDqO9e0R
 30DZgcMfCj7IGfI/5U/v2TMFIXO8btrNIBr4w0ITBH+YQCZMH3iYXquxycItxXrX4N5Tkyl2T2b
 b6SOi1kAuWR3qz/fRca/KX3ZDT+BtMjA39yEP0rXKosJFCeVA3hS4HjJcbV5QCJspLEVSyy7V8k
 D/0vCqE7H6SqtfYGDDipbTpQkjPGc3MgzGzBVBFm3eEx5VtLNHy9km2ivRtkNwfuZJ4FkpaXgkF
 NzG04uDNBXZh0aYhgLK4pHXg/p586w95+CIE6M+Hy9eAyBSyvqbR0nivKTkFl+lXbM5T7/oy4N2
 X+ssL2NZTrRc81KYkxNeJBmzI3YYC4mv3H9UhN1S9jKPtMotCT6ojid3xnJYLLvJMDKSzzKCRTG
 rXDDw2FTktXIZV006gXoj2DuRfDV/pZVqwZjZBpP94yj2Ufsum37QfxZw5VkDYUuJCyKY=
X-Developer-Key: i=smtong@axiado.com; a=openpgp;
 fpr=772F37BB1B04B75F30244F487C1CA8721442F38E
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH3PPF9936212C8:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffa68dd-1041-4122-a3c8-08debc624011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: XdJqNt6urRI0FRuxG2V8qTkL5bcxAbZ7gEckOIHJ7z7b3pS/5ieryu+0yBpaxZ7KaegrgzdlA5nbQRsZVt22ROtijzEE1HSrCe89SdgfXJvEk4MeJbY/qzwRJlKQvLFYeI3VwLUax0/M0M3/lwzCXU2cEqDopLwPO0IH/bPBqK0Pi2a4klr9HslkzlszyNCZwWyAk8KrS2xSVaioFUkhOZ+18WAPIyelT+hjHtb/66lz3TIxw0jUQUeumIiLBCwkDSLjcY1qY/0wGTzzBt5jW88cscCy0aU9lPuVfPt43QlXaTdTUFqnzEP+FH26UWFEXTYVpga0QqJB5sKUzSM2u+4Tl0rXgCXMO9zPZn8bKGQF7CCJFPcRosRwVsfv/pCqgsQUDGjLFPIKepM28CllvY5YbE4mQsCmwE+UclsyUs9iI+iRl/w13lrHJZzu7wPaPVEOgh6bCcA9StpyXBPCVM+HptYxJwQoGHtt1kAimLvKa6k8Rp/vR1blQbZFLBhViq+gjjHF66eOD5suRG+SdZHTkoC0wscft0VoPkHqJlkxmAjHtnwnfQBcfpvrfq33s9ptebP3wic1QC8fV2SD6BPxNOIbiifKVNskJbk+0ZztfWPQZDOdAuianxs4jZqp8hBY7uV7t6jvECzF8I06kwNsxUCIVl6QU6AB2UyFOHIW/x2SGD3+Wa/MKWmxY388LzwqsT6LCeuN1+/R6DYh6kGG/Bd4ZhyMF4gwTe3vphQ=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MBXnv0o6+uw4JiOUVgio2KvXsVsKy+9jDCiA2fsf9NCNk9J4dtzY+ECAssIwHc18Ob1ONTR/7PyAcLwFpBU564XVWpv1yJTqAbHbORYYEkmQc3wf4IBYzWYpr96mAXAQ8yFc7GyDoy0MiFz3R8BivN0pPX5+2kzMXQUrjp5Xu1zs7Bf8BgbQD347mTcOgi2jpR8c2rlfSYXU4vOs29FdZEPlgJvyi3NrlpTtpvVkpVW18UhdBiqP4gbb9mo11FmHpShIRCSly05A/A0/s7VK2YAGlZ3bPw5VQ3pnnfj6hZ9OvuREcnBrYWhj1ov5ulIlvP+v+gG0BBAR1/TFYTdENSnIY6rlsLviP6Tk6/9/ftbeXGPpiJ/BvWx3hMW5i/MHlHuG802f+DwQm/8G+g4qPgaNfgIxXHbmIRPpoKg2pkBSiP3/jFPDpOptiol4seW3
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 02:38:50.0447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffa68dd-1041-4122-a3c8-08debc624011
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9936212C8
X-Mailman-Approved-At: Thu, 28 May 2026 05:00:39 +0200
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

Introduce mach-axiado to support Axiado SoC-based boards. This adds
the platform Kconfig and build infrastructure, along with initial
SCM3005 board support using the AX3005 SoC.

Introduces AXIADO_AX3005, which selects ARM64, driver
model, GIC-v3, and Zynq UART. TARGET_SCM3005 selects ARCH_AXIADO,
allowing future SoC variants to share the platform configuration.
Secondary cores use spin-table boot. ft_board_setup() corrects
the cpu-release-addr in the FDT, which arch_fixup_fdt() overwrites
with the post-relocation address.
Add U-Boot board support for the Axiado AX3005 based targets, a quad-core
ARM Cortex-A53 (ARMv8) platform.

Tested-by: Siu Ming Tong <smtong@axiado.com>
Signed-off-by: Karthikeyan Mitran <kmitran@axiado.com>
Signed-off-by: Siu Ming Tong <smtong@axiado.com>
---
 MAINTAINERS                          |  11 +++
 arch/arm/Kconfig                     |   9 +++
 arch/arm/mach-axiado/Kconfig         |  22 ++++++
 arch/arm/mach-axiado/Makefile        |   6 ++
 arch/arm/mach-axiado/scm3005/Kconfig |  11 +++
 board/axiado/scm3005/Kconfig         |  15 ++++
 board/axiado/scm3005/Makefile        |   5 ++
 board/axiado/scm3005/scm3005.c       | 128 +++++++++++++++++++++++++++++++++++
 configs/ax3005_scm3005_defconfig     |  74 ++++++++++++++++++++
 include/configs/ax3005-scm3005.h     |  29 ++++++++
 10 files changed, 310 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 056902f6ef2..0659d299fde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,6 +213,17 @@ F:	drivers/reset/reset-ast2500.c
 F:	drivers/watchdog/ast_wdt.c
 N:	aspeed
 
+ARM AXIADO AX3005 SCM3005
+M:	Siu Ming Tong <smtong@axiado.com>
+M:	Karthikeyan Mitran <kmitran@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+S:	Maintained
+F:	arch/arm/dts/ax3005*
+F:	arch/arm/mach-axiado/
+F:	board/axiado/scm3005/
+F:	configs/ax3005_scm3005_defconfig
+F:	include/configs/ax3005-scm3005.h
+
 ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
 M:	Peter Robinson <pbrobinson@gmail.com>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f624675eadf..3fcedee739f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2152,6 +2152,13 @@ config ARCH_ASPEED
 	select OF_CONTROL
 	imply CMD_DM
 
+config ARCH_AXIADO
+	bool "Support Axiado SoCs"
+	select AXIADO_AX3005
+	help
+	  Support for Axiado AX-series SoCs such as the AX3005.
+	  These ARM64 SoCs are used in BMC and security applications.
+
 config TARGET_DURIAN
 	bool "Support Phytium Durian Platform"
 	select ARM64
@@ -2293,6 +2300,8 @@ source "arch/arm/mach-aspeed/Kconfig"
 
 source "arch/arm/mach-at91/Kconfig"
 
+source "arch/arm/mach-axiado/Kconfig"
+
 source "arch/arm/mach-bcm283x/Kconfig"
 
 source "arch/arm/mach-bcmbca/Kconfig"
diff --git a/arch/arm/mach-axiado/Kconfig b/arch/arm/mach-axiado/Kconfig
new file mode 100644
index 00000000000..12ad44070eb
--- /dev/null
+++ b/arch/arm/mach-axiado/Kconfig
@@ -0,0 +1,22 @@
+if ARCH_AXIADO
+
+config SYS_ARCH
+	default "arm"
+
+config SYS_SOC
+	default "axiado"
+
+config AXIADO_AX3005
+	bool
+	select ARM64
+	select ARMV8_SWITCH_TO_EL1
+	select DM
+	select DM_SERIAL
+	select GICV3
+	select ZYNQ_SERIAL
+	select MMC_SDHCI_AXIADO
+	select PHY_AXIADO_EMMC
+
+source "arch/arm/mach-axiado/scm3005/Kconfig"
+
+endif
diff --git a/arch/arm/mach-axiado/Makefile b/arch/arm/mach-axiado/Makefile
new file mode 100644
index 00000000000..2acd5466dd9
--- /dev/null
+++ b/arch/arm/mach-axiado/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2021-2026 Axiado Corporation (or its affiliates).
+#
+
+obj-$(CONFIG_AXIADO_AX3005) += scm3005/
diff --git a/arch/arm/mach-axiado/scm3005/Kconfig b/arch/arm/mach-axiado/scm3005/Kconfig
new file mode 100644
index 00000000000..fc74aa0871b
--- /dev/null
+++ b/arch/arm/mach-axiado/scm3005/Kconfig
@@ -0,0 +1,11 @@
+if AXIADO_AX3005
+
+config TARGET_SCM3005
+	bool "Support Axiado AX3005 SCM3005"
+	help
+	  Support for the Axiado AX3005 SCM3005 board.
+	  Based on the Axiado AX3005 quad-core ARMv8 Cortex-A53 SoC.
+
+source "board/axiado/scm3005/Kconfig"
+
+endif
diff --git a/board/axiado/scm3005/Kconfig b/board/axiado/scm3005/Kconfig
new file mode 100644
index 00000000000..d6f4f311f55
--- /dev/null
+++ b/board/axiado/scm3005/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_SCM3005
+
+config SYS_BOARD
+	string
+	default "scm3005"
+
+config SYS_VENDOR
+	string
+	default "axiado"
+
+config SYS_CONFIG_NAME
+	string
+	default "ax3005-scm3005"
+
+endif
diff --git a/board/axiado/scm3005/Makefile b/board/axiado/scm3005/Makefile
new file mode 100644
index 00000000000..3d35713bab9
--- /dev/null
+++ b/board/axiado/scm3005/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2021-2026 Axiado Corporation (or its affiliates).
+
+obj-y := scm3005.o
diff --git a/board/axiado/scm3005/scm3005.c b/board/axiado/scm3005/scm3005.c
new file mode 100644
index 00000000000..4643ba4a55c
--- /dev/null
+++ b/board/axiado/scm3005/scm3005.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation (or its affiliates).
+ */
+
+#include <config.h>
+#include <dm.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/armv8/mmu.h>
+#include <asm/io.h>
+#include <asm/spin_table.h>
+#include <asm/system.h>
+#include <fdt_support.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static struct mm_region axiado_ax3005_mem_map[] = {
+	{ /* Peripherals including UART */
+	  .virt = 0x00000000UL,
+	  .phys = 0x00000000UL,
+	  .size = 0x4A000000UL, /* 0 to 0x4A000000: peripherals */
+	  .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) | PTE_BLOCK_NON_SHARE |
+		   PTE_BLOCK_PXN | PTE_BLOCK_UXN },
+	{ .virt = 0x80000000UL,
+	  .phys = 0x80000000UL,
+	  .size = 0x80000000UL,
+	  .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE },
+	{
+		0,
+	}
+};
+
+struct mm_region *mem_map = axiado_ax3005_mem_map;
+
+/*
+ * Accept any FIT configuration name - the board loads a single FIT image
+ * and the first matching config is used.
+ */
+int board_fit_config_name_match(const char *name)
+{
+	return 0;
+}
+
+/*
+ * ft_board_setup - restore cpu-release-addr after relocation
+ *
+ * arch_fixup_fdt() / spin_table_update_dt() overwrites cpu-release-addr
+ * with U-Boot's relocated address.  Restore the pre-relocation physical
+ * address so secondary cores spin on the correct location.
+ */
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	int cpus_offset, offset;
+	const char *prop;
+	int ret;
+	u64 cpu_release_addr = (u64)&spin_table_cpu_release_addr - gd->reloc_off;
+
+	cpus_offset = fdt_path_offset(blob, "/cpus");
+	if (cpus_offset < 0)
+		return 0;
+
+	for (offset = fdt_first_subnode(blob, cpus_offset); offset >= 0;
+	     offset = fdt_next_subnode(blob, offset)) {
+		prop = fdt_getprop(blob, offset, "device_type", NULL);
+		if (!prop || strcmp(prop, "cpu"))
+			continue;
+
+		prop = fdt_getprop(blob, offset, "enable-method", NULL);
+		if (!prop || strcmp(prop, "spin-table"))
+			continue;
+
+		ret = fdt_setprop_u64(blob, offset, "cpu-release-addr",
+				      cpu_release_addr);
+		if (ret) {
+			printf("WARNING: Failed to restore cpu-release-addr\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * dram_init - DDR is initialized by firmware, just setting size
+ */
+int dram_init(void)
+{
+	gd->ram_size = get_ram_size((void *)CFG_SYS_SDRAM_BASE,
+				    CFG_SYS_SDRAM_SIZE);
+	return 0;
+}
+
+/*
+ * the SOC uses single bank, non-interleaving
+ */
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bd->bi_dram[0].size = CFG_SYS_SDRAM_SIZE;
+	return 0;
+}
+
+/*
+ * timer_init - enable the AX3005 platform system timer
+ *
+ * CNTFRQ_EL0 is already set by arch/arm/cpu/armv8/start.S using
+ * CONFIG_COUNTER_FREQUENCY from the defconfig.
+ *
+ * SYS_TIMER_CTRL (0x48016000) is the AX3005 system timer control
+ * register — writing SYS_TIMER_ENABLE starts the counter that feeds
+ * the ARM generic timer.
+ */
+int timer_init(void)
+{
+	writel(SYS_TIMER_ENABLE, SYS_TIMER_CTRL);
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+void reset_cpu(void)
+{
+	/* For later ARM_PSCI_FW or watchdog reset */
+}
diff --git a/configs/ax3005_scm3005_defconfig b/configs/ax3005_scm3005_defconfig
new file mode 100644
index 00000000000..5dd72d87220
--- /dev/null
+++ b/configs/ax3005_scm3005_defconfig
@@ -0,0 +1,74 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AXIADO=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_TEXT_BASE=0x80000000
+CONFIG_SYS_MONITOR_BASE=0x80000000
+CONFIG_SYS_LOAD_ADDR=0x80100000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SYS_MALLOC_LEN=0x20000
+CONFIG_SYS_BOOTM_LEN=0x20000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x5000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_COUNTER_FREQUENCY=1000000000
+CONFIG_ARMV8_MULTIENTRY=y
+CONFIG_ARMV8_SET_SMPEN=y
+CONFIG_ARMV8_SPIN_TABLE=y
+CONFIG_SYS_CUSTOM_LDSCRIPT=y
+CONFIG_SYS_LDSCRIPT="arch/arm/cpu/armv8/u-boot.lds"
+CONFIG_BOOTDELAY=5
+CONFIG_FIT=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_DEFAULT_FDT_FILE="ax3005-scm3005.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="Axiado> "
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Press \"<Esc><Esc>\" to stop autobooting in %d seconds\n"
+CONFIG_AUTOBOOT_STOP_STR="\x1b\x1b"
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyPS3,115200 maxcpus=4 nr_cpus=4 earlycon hugepages=16 root=/dev/ram rw phram.phram=ramrofs,0x80B00000,0x6400000"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="bootm ${loadaddr}"
+CONFIG_SYS_VENDOR="axiado"
+CONFIG_SYS_BOARD="scm3005"
+CONFIG_SYS_CONFIG_NAME="ax3005-scm3005"
+# CONFIG_CMD_BOOTEFI is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_GO is not set
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_GPT_RENAME=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_SEPARATE=y
+CONFIG_DEFAULT_DEVICE_TREE="ax3005-scm3005"
+CONFIG_MULTI_DTB_FIT=y
+# CONFIG_ENV_IS_IN_MMC is not set
+CONFIG_DM_MMC=y
+# CONFIG_SUPPORT_EMMC_BOOT is not set
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_TARGET_SCM3005=y
+CONFIG_CLK=y
+CONFIG_LZMA=y
+CONFIG_XZ=y
+CONFIG_ZYNQ_SERIAL=y
+# CONFIG_AUTO_COMPLETE is not set
+# CONFIG_SYS_LONGHELP is not set
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/include/configs/ax3005-scm3005.h b/include/configs/ax3005-scm3005.h
new file mode 100644
index 00000000000..4eead2910c8
--- /dev/null
+++ b/include/configs/ax3005-scm3005.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation (or its affiliates).
+ */
+
+#ifndef __AX3005_SCM3005_H
+#define __AX3005_SCM3005_H
+
+#include <linux/sizes.h>
+
+#define GICD_BASE		0x40400000
+#define GICR_BASE		0x40500000
+
+#define SYS_TIMER_CTRL		0x48016000
+#define SYS_TIMER_ENABLE	0x1
+#define SYS_TIMER_DISABLE	0x0
+
+/* DRAM: 2 GB at 0x80000000 */
+#define CFG_SYS_SDRAM_BASE	0x80000000
+#define CFG_SYS_SDRAM_SIZE	SZ_2G
+#define CFG_SYS_INIT_SP_ADDR	(CFG_SYS_SDRAM_BASE + SZ_1M)
+
+#define CFG_SYS_MAXARGS		64
+#define CFG_SYS_BARGSIZE	CFG_SYS_CBSIZE
+
+#define CFG_SYS_BAUDRATE_TABLE	\
+	{ 4800, 9600, 19200, 38400, 57600, 115200 }
+
+#endif /* __AX3005_SCM3005_H */

-- 
2.34.1

