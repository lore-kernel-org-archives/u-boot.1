Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE6EFF886F
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE783846DD;
	Wed, 29 Apr 2026 04:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=axiado.com header.i=@axiado.com header.b="ZXaMvPBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80339846BD; Wed, 29 Apr 2026 04:32:51 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91967846DF
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kmitran@axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQMvGyATaY6MfwvWsoQM0QK9P27tl2cfPUVV2rKnS9rWI0kSuanlMS1yY+wRS919fKKVY//BA/cESXSnpFWOhGgmC/rFjMhVS7eLLyPLBklyaN4kclLaiQcwA18t1sPjR1hVehqN92auDMRI+8gJawJs9M1LgGvwI0dTVdFCrfa/gjSiIEvVCcrSUzGFr8yhYTSu/drI06NQu38bdYE20QluEgAw5JUo94bmmRM1Namvl6K2O5EKt2K0bwRGFf4JTDBJ65AbTcsynJnEhO4azgddUZT367zkDB5hhY45uusiYT3UyMdesGZ0tleu5n/GsLh+9jX46WFn1RrsdICEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HMunb9rEUToMnwSMyvq7x6SMZi0ULIVR+t5g2/pYt4=;
 b=LaQ397Qxq/GVtQpO4vYe5qsOBfO+K3Rv/WpBtNaVOr/I+1FJnY97kJZtUEQ/pYMD9T1i/bcD52Bf902Z/3h2MwuZhTHu2JP5E/gTbzaElV9YcjEAIgwfxvJ3OZMmsosuOrtiGvJ1wWTs9/LjrAX1RZmX29caE10aC1Gft7m5WK8rn8PTJsIHY/1sp9z8Mfj9fr3G1CSOHjtRVkAHO5tI5zjI38OU5AZ4ulKRAPQw2nz213pYWhSp2nFMZtYgC5RQ3c2UwI+FZJoFAWr4HWf1qK8cTqYvKdD/FY85r9gpUlVZMlrgIbG7YCKbt0vSW4IkhjyTp/SJ9K939Mh4JSEMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HMunb9rEUToMnwSMyvq7x6SMZi0ULIVR+t5g2/pYt4=;
 b=ZXaMvPBac6Qk+MjpUt9Xy0EvLUfNfOF8G8GfSrohzB0DKWAJ6k7OrYTHfu0+y5w2Gl867HXsqMKiZaGr+1+If4X3R2ByB++Px3+CYuXGn7094EUxODkTvVF+SYc98MBVo5cMfb1v3x4mDG/F7YCW19gJffRCaH0p0fdpNcwe7nd0Tl0sy4Q/2lJMvNZ9tf7QVAcDXyBXguxVNViDK5w3vQdajkz8tj4O3icvI0zvffIeoNA6I55IxfUua29A14reLGBQDBDs70NGHOsAVsgESyMeC4gS9PADzjhVnBEg9EtQ3W0Fa2UqUNdQ0U2W195RI2wJjAyPsfUS4fiEu+JUEw==
Received: from CH2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:610:4e::38)
 by DM3PPF516449E88.namprd18.prod.outlook.com (2603:10b6:f:fc00::6a5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 29 Apr
 2026 02:32:41 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::10) by CH2PR02CA0028.outlook.office365.com
 (2603:10b6:610:4e::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 02:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Wed, 29 Apr 2026 02:32:41 +0000
Received: from sw-build-jenkins04.axiadord (sw-build-jenkins04.axiadoRD
 [10.4.1.35])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 966C34186B5B;
 Tue, 28 Apr 2026 19:30:49 -0700 (PDT)
From: Karthikeyan Mitran <kmitran@axiado.com>
Date: Tue, 28 Apr 2026 19:32:37 -0700
Subject: [PATCH 2/2] arm: axiado: Add AX3005 based SCM3005 board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-ax3005_scm3005-v1-2-7fed19ee6fe0@axiado.com>
References: <20260428-ax3005_scm3005-v1-0-7fed19ee6fe0@axiado.com>
In-Reply-To: <20260428-ax3005_scm3005-v1-0-7fed19ee6fe0@axiado.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Siu Ming Tong <smtong@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14949; i=kmitran@axiado.com;
 h=from:subject:message-id; bh=gipHSuVyqRYZlDNKetsyonb3SOV6EBjWXVJyMBcr3B4=;
 b=owEBbQKS/ZANAwAKAfykr3bAxbrPAcsmYgBp8W3I3TD/2XoXUvRhEWaARlddTXBDYQWseMtfJ
 QgwEFVloB+JAjMEAAEKAB0WIQQykBiJeI5kfMQLrdj8pK92wMW6zwUCafFtyAAKCRD8pK92wMW6
 zxgFEACYbUnLYpL+WsRqi41bm0pkqU3rP+URpe4QPkyMKRaY85zXbp9s07ZN+HD6omFyhexxQU5
 1dWp5N699ZI3PkVU5tcrOmkT99G0ISs/PXa5hN8twfz5fk5GzoPQ6mxY4X4YLf8FduiJMfzaTqi
 dHSarlq6HHiyOjEt/Mlec9L4iMCkEc/in3G9g/vsAnpS/JCdzkxgWgqvg9JGe0Rh9AIwHcQfAq3
 SiwoPmVVrlXsW9cC8K2ia5nX/7j7grR0Q4pkXy9p9jObbWhco/oNRRsqtiLFz4ZP0EhX1om7Af+
 NRP+u1YHJK2WHOofm+CSS9l0qM/EZUs3TZ0JdjLt6Kc0gGDZKZ5/Msujw09RT6zpJoOl3/ybCT6
 5Y5YzJFe9TQ81vGyxXl3n/sNCwzdHgU8Y0Kkx7l7c/3rRfRYQo0lyG19ZQxAO+5DLH5hnGE/uci
 TOlnhc11eNIo8va93wQjT0jEtpwXfOcjWE+paMY77ZRxdpe/CdU9Q7mf1BE/az8A5rdYfTp9W15
 TXi7dIeitHgWK2Vc40U1tH1vRwevJcllrGptmih/guKZY5AzFs1DD5ugQy4yt6gv0SqL1bHQHUs
 UZczdcOxaX6/JmOThsPAcNnnaDV9JHVya3zMlGO9oInU+d/NcGfXyMT6GCu0tFToHQ7uGPm5G46
 cTLKDXRp0wq0mZA==
X-Developer-Key: i=kmitran@axiado.com; a=openpgp;
 fpr=32901889788E647CC40BADD8FCA4AF76C0C5BACF
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DM3PPF516449E88:EE_
X-MS-Office365-Filtering-Correlation-Id: 11eb139d-a8c7-401e-6928-08dea597964c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|34070700014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MWguUK5Q4sE8pQcD0b43xu10ul2jGt5p1f5Bf9LSnpwLzr4sMWK7jY9XXnzNJ2zEKQZ0eSgGJci/M2A6mOZmr2Li9/hgIBxpGMI1MV1yDIWNliSqaql1Xl4opNNsPUnMqQVPOQUgRlUZKpa7RObQXEmiuq9Ij+x7DHyF9CgUEHzCQQVtmaIYcDW6a3tdcySY0zwIueDr97SCGpkjCCdht6iwJt4sDXQwF68e2R06W2hYKLz+YppfWAqYWePoKgF7DvrFc5JYDNXV1m0NZEjmkxzQBUkUN7y6V8uohme6qco4NpIvLcdqJ0Ql3HKVLIKx/f3BNulEv/FxfMp+HOvkq937Acr7na6GDBe59lhOrYDcU23UnnkepsnCr795uinioxJjIelBQpJdgJaullvDo3P6GHAXtGhfFYam1DFR5g2+uaEDW6DHdPZoUuC6jURYPgb6RoZmDhm0p/GFjm2P6lLTu43uYk6zohN3st8OAUhNYQhliHEeY0epuegFm5a+BBlT/JN4RiE2VRjnGGQ6DRbt8V9TElLwI7l17oq9UqlnK72iTqg7vAxRO1RD+2f8BaM3dlyGIKrgkMolar60clMxGKuduFC+HP1F+b/e2Pih3ugZZ5C5ybQnqH4M0f8JVs0u9srcPUv5HJTjbMeSIa4GrGaoPnh9JbyocHGpubFe6Vbh0p1Ec4QEJbAWolU+9EaIA7q0y7tEFWt2RN1u++erNU4X0NDNsECg0ZnKKI4L9uOMNhvaWykK0dlrB5dIHVFqUJJvLgsh/h+72RZRMQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(34070700014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Rfvs1I5LFVn9kUfgzEqWX6iUrvUrD+jXf9h2vsuB62i7/mE4hBbGPXUF4ZLFKAsWCfu2HluUkBz+wTbKeTD0BVMSj95k2Gqz8Zclk3M7Au7je9btpd0GVsF63gnyZNwj6wdsy6nhPGeZA3vW4rT48NNRDxS/87HtcsPciDZYMHih/m4k49nraUt7D/2GsX0Icm34MfW44UuHbxNwnM5A0s6cfCocvDwPhWbOX/MZ+HHENoecBjavoN0dkW1b4tEUwiNLGXV4doMWv6gmDX7hlShDFNNp1C05/qJD6X/pxTKoOMrkO9czmsxh3lqN0accCgl4vsvdCTd/QsMTm+VLWoCaRGq8BWqTb/+te/PmdxNBVis0BOWG3SfM8Lxklboc9t9bKhyladw7iEgPg0VLojItb4JjNb9YwC1rkcANZAbsMKkBdltkkhEGtYcXYF+
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:32:41.2028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eb139d-a8c7-401e-6928-08dea597964c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF516449E88
X-Mailman-Approved-At: Wed, 29 Apr 2026 04:43:59 +0200
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

From: Siu Ming Tong <smtong@axiado.com>

Add U-Boot board support for the Axiado AX3005 based targets, a quad-core
ARM Cortex-A53 (ARMv8) platform.

Board Kconfig introduces ARCH_AX3005, which selects ARM64, driver
model, GIC-v3, and Zynq UART. TARGET_SCM3005 selects ARCH_AX3005,
allowing future SoC variants to share the platform configuration.

Secondary cores use spin-table boot. ft_board_setup() corrects
the cpu-release-addr in the FDT, which arch_fixup_fdt() overwrites
with the post-relocation address. The board linker script pins
spin_table_v8.o at offset 0x2fa0 from text base to match the
address declared in the device tree.

Tested-by: Siu Ming Tong <smtong@axiado.com>
Signed-off-by: Siu Ming Tong <smtong@axiado.com>
Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
Signed-off-by: Karthikeyan Mitran <kmitran@axiado.com>
---
 MAINTAINERS                      |  10 +++
 arch/arm/Kconfig                 |  17 ++++
 board/axiado/scm3005/Kconfig     |  15 ++++
 board/axiado/scm3005/Makefile    |   5 ++
 board/axiado/scm3005/scm3005.c   | 128 +++++++++++++++++++++++++++
 board/axiado/scm3005/u-boot.lds  | 183 +++++++++++++++++++++++++++++++++++++++
 configs/ax3005_scm3005_defconfig |  73 ++++++++++++++++
 include/configs/ax3005-scm3005.h |  29 +++++++
 8 files changed, 460 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 056902f6ef2..b8ca2c39a8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,6 +213,16 @@ F:	drivers/reset/reset-ast2500.c
 F:	drivers/watchdog/ast_wdt.c
 N:	aspeed
 
+ARM AXIADO AX3005 SCM3005
+M:	Siu Ming Tong <smtong@axiado.com>
+M:	Karthikeyan Mitran <kmitran@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+S:	Maintained
+F:	arch/arm/dts/ax3005*
+F:	board/axiado/scm3005/
+F:	configs/ax3005_scm3005_defconfig
+F:	include/configs/ax3005-scm3005.h
+
 ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
 M:	Peter Robinson <pbrobinson@gmail.com>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f624675eadf..c22bba24db0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1941,6 +1941,13 @@ config ARCH_SC5XX
 	select SUPPORT_SPL
 	select TIMER
 
+config TARGET_SCM3005
+	bool "Support Axiado AX3005 SCM3005"
+	select ARCH_AX3005
+	help
+	  Support for the Axiado AX3005 SCM3005 board.
+	  Based on the Axiado AX3005 quad-core ARMv8 Cortex-A53 SoC.
+
 config TARGET_SL28
 	bool "Support sl28"
 	select ARCH_LS1028A
@@ -2203,6 +2210,15 @@ config ARCH_GXP
 
 endchoice
 
+config ARCH_AX3005
+	bool
+	select ARM64
+	select ARMV8_SWITCH_TO_EL1
+	select DM
+	select DM_SERIAL
+	select GICV3
+	select ZYNQ_SERIAL
+
 config SUPPORT_PASSING_ATAGS
 	bool "Support pre-devicetree ATAG-based booting"
 	depends on !ARM64
@@ -2421,6 +2437,7 @@ source "board/Marvell/octeontx/Kconfig"
 source "board/Marvell/octeontx2/Kconfig"
 source "board/armltd/vexpress/Kconfig"
 source "board/armltd/vexpress64/Kconfig"
+source "board/axiado/scm3005/Kconfig"
 source "board/cortina/presidio-asic/Kconfig"
 source "board/broadcom/bcmns/Kconfig"
 source "board/broadcom/bcmns3/Kconfig"
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
diff --git a/board/axiado/scm3005/u-boot.lds b/board/axiado/scm3005/u-boot.lds
new file mode 100644
index 00000000000..8e56535fdf9
--- /dev/null
+++ b/board/axiado/scm3005/u-boot.lds
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation (or its affiliates).
+ *
+ * Based on arch/arm/cpu/armv8/u-boot.lds
+ */
+
+#include <config.h>
+#include <asm/psci.h>
+
+OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
+OUTPUT_ARCH(aarch64)
+ENTRY(_start)
+SECTIONS
+{
+#ifdef CONFIG_ARMV8_SECURE_BASE
+	/DISCARD/ : { *(.rela._secure*) }
+#endif
+	. = 0x00000000;
+
+	. = ALIGN(8);
+	__image_copy_start = ADDR(.text);
+	.text :
+	{
+		CPUDIR/start.o (.text*)
+		. = ALIGN(0x2000);
+		. = . + 3984;
+		KEEP(*spin_table_v8.o(.text*))
+	}
+
+	__text_section_end = ABSOLUTE(.);
+
+	/* This needs to come before *(.text*) */
+	.efi_runtime : {
+		__efi_runtime_start = .;
+		*(.text.efi_runtime*)
+		*(.rodata.efi_runtime*)
+		*(.data.efi_runtime*)
+		__efi_runtime_stop = .;
+	}
+
+#ifdef CONFIG_MMU_PGPROT
+	.text_rest ALIGN(CONSTANT(COMMONPAGESIZE)) :
+#else
+	.text_rest :
+#endif
+	{
+		__text_start = .;
+		*(.text*)
+#ifdef CONFIG_MMU_PGPROT
+		. = ALIGN(CONSTANT(COMMONPAGESIZE));
+#endif
+		__text_end = .;
+	}
+
+#ifdef CONFIG_ARMV8_PSCI
+	.__secure_start :
+#ifndef CONFIG_ARMV8_SECURE_BASE
+		ALIGN(CONSTANT(COMMONPAGESIZE))
+#endif
+	{
+		KEEP(*(.__secure_start))
+	}
+
+#ifndef CONFIG_ARMV8_SECURE_BASE
+#define __ARMV8_SECURE_BASE
+#define __ARMV8_PSCI_STACK_IN_RAM
+#else
+#define __ARMV8_SECURE_BASE	CONFIG_ARMV8_SECURE_BASE
+#endif
+	.secure_text __ARMV8_SECURE_BASE :
+		AT(ADDR(.__secure_start) + SIZEOF(.__secure_start))
+	{
+		*(._secure.text)
+		. = ALIGN(8);
+		__secure_svc_tbl_start = .;
+		KEEP(*(._secure_svc_tbl_entries))
+		__secure_svc_tbl_end = .;
+	}
+
+	.secure_data : AT(LOADADDR(.secure_text) + SIZEOF(.secure_text))
+	{
+		*(._secure.data)
+	}
+
+	.secure_stack ALIGN(ADDR(.secure_data) + SIZEOF(.secure_data),
+			    CONSTANT(COMMONPAGESIZE)) (NOLOAD) :
+#ifdef __ARMV8_PSCI_STACK_IN_RAM
+		AT(ADDR(.secure_stack))
+#else
+		AT(LOADADDR(.secure_data) + SIZEOF(.secure_data))
+#endif
+	{
+		KEEP(*(.__secure_stack_start))
+
+		. = . + CONFIG_ARMV8_PSCI_NR_CPUS * ARM_PSCI_STACK_SIZE;
+
+		. = ALIGN(CONSTANT(COMMONPAGESIZE));
+
+		KEEP(*(.__secure_stack_end))
+	}
+
+#ifndef __ARMV8_PSCI_STACK_IN_RAM
+	. = LOADADDR(.secure_stack);
+#endif
+
+	.__secure_end : AT(ADDR(.__secure_end)) {
+		KEEP(*(.__secure_end))
+		LONG(0x1d1071c);	/* Must output something to reset LMA */
+	}
+#endif
+	.efi_runtime_rel : {
+		__efi_runtime_rel_start = .;
+		*(.rel*.efi_runtime)
+		*(.rel*.efi_runtime.*)
+		__efi_runtime_rel_stop = .;
+	}
+
+#ifdef CONFIG_MMU_PGPROT
+	.rodata ALIGN(CONSTANT(COMMONPAGESIZE)): {
+#else
+	.rodata ALIGN(8) : {
+#endif
+		__start_rodata = .;
+		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
+	}
+
+	__u_boot_list ALIGN(8) : {
+		KEEP(*(SORT(__u_boot_list*)));
+#ifdef CONFIG_MMU_PGPROT
+		. = ALIGN(CONSTANT(COMMONPAGESIZE));
+#endif
+		__end_rodata = .;
+	}
+
+#ifdef CONFIG_MMU_PGPROT
+	.data ALIGN(CONSTANT(COMMONPAGESIZE)) : {
+#else
+	.data ALIGN(8) : {
+#endif
+		__start_data = .;
+		*(.data*)
+	}
+
+	. = ALIGN(8);
+	__image_copy_end = .;
+
+	.rela.dyn ALIGN(8) : {
+		__rel_dyn_start = .;
+		*(.rela*)
+		__rel_dyn_end = .;
+		. = ALIGN(8);
+	}
+
+	_end = .;
+
+	/*
+	 * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
+	 */
+	.bss ADDR(.rela.dyn) (OVERLAY) : {
+		__bss_start = .;
+		*(.bss*)
+		. = ALIGN(8);
+		__bss_end = .;
+#ifdef CONFIG_MMU_PGPROT
+		. = ALIGN(CONSTANT(COMMONPAGESIZE));
+#endif
+		__end_data = .;
+	}
+
+	/DISCARD/ : { *(.dynsym) }
+	/DISCARD/ : { *(.dynstr*) }
+	/DISCARD/ : { *(.dynamic*) }
+	/DISCARD/ : { *(.plt*) }
+	/DISCARD/ : { *(.interp*) }
+	/DISCARD/ : { *(.gnu*) }
+
+#ifdef CONFIG_LINUX_KERNEL_IMAGE_HEADER
+#include "linux-kernel-image-header-vars.h"
+#endif
+}
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
diff --git a/configs/ax3005_scm3005_defconfig b/configs/ax3005_scm3005_defconfig
new file mode 100644
index 00000000000..447151522c1
--- /dev/null
+++ b/configs/ax3005_scm3005_defconfig
@@ -0,0 +1,73 @@
+CONFIG_ARM=y
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
+CONFIG_SYS_LDSCRIPT="board/axiado/scm3005/u-boot.lds"
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

