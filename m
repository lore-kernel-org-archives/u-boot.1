Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A248CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 03:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C7B1846D5;
	Sun, 17 May 2026 05:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="bXIBZzSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271798469D; Sat, 16 May 2026 20:21:29 +0200 (CEST)
Received: from mxd-2-a08.seznam.cz (mxd-2-a08.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CB884693
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 20:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-f659df87d-k746b
 (smtpc-mxd-f659df87d-k746b [2a02:598:64:8a00::1000:a08])
 id 0b1ab5a45014e1cd0ab379fa; Sat, 16 May 2026 20:20:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778955636; bh=9lkBtIqinfofPMN2YgYbkPt6fycz0zthLlobIW5gTbc=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=bXIBZzSjuW0pjapg+WOs0OYBLEcwdwb4siCkjUcpIlheb7nVwr4YEJ6bcZgTtRJ07
 gSeEp68GGh+b7kIrzlPK4KugFo+r23KIh6CP5mSraVVsiliyrY9DOHAEBFeGG7WrwE
 6EwL+yGPauL4McbXdshPLZGPv5s/JwZIKg09CGPczIScy3Ig+DzN0E7ai/HKgHJT0P
 x4GVi7UPf52VaYitio2Ls1+xIomneRTmydKACrqRObxH+AffM5PfWgSQIICxXOHmA1
 BroJkYXgPzG7dLX7WGrFOT91EZv0pARWWYCUQ8MGxrOX31/CTzgKQ8qWs6TK0wBj2W
 hv3Ni1+6zml3A==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-745c4d9bbb-4gnxc (szn-email-smtpd/2.0.73) with ESMTPA
 id 46c42803-ddd9-43d5-be07-44fc01034dd4;
 Sat, 16 May 2026 20:20:32 +0200
From: michael.srba@seznam.cz
Date: Sat, 16 May 2026 20:19:53 +0200
Subject: [PATCH v8 04/12] mach-snapdragon: boot0.h: split out msm8916_boot0.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-qcom_spl-v8-4-69b55c9abffe@seznam.cz>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
In-Reply-To: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 17 May 2026 05:15:41 +0200
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

From: Michael Srba <Michael.Srba@seznam.cz>

Prepare for supporting alternative boot0.h per-SoC by splitting out
the existing msm8916-specific code.

There is now a selection mechanism to choose a specific boot0.h
in the Kconfig. BOOT0_MSM8916_PSCI_WORKAROUND is the only option
right now, but more can be added. The toplevel boot0.h additionally
enables conditionally performing the include only in u-boot proper,
or only in SPL.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-snapdragon/Kconfig                   | 16 ++++++
 arch/arm/mach-snapdragon/include/mach/boot0.h      | 60 +++-------------------
 .../mach-snapdragon/include/mach/msm8916_boot0.h   | 54 +++++++++++++++++++
 configs/dragonboard410c_defconfig                  |  1 +
 configs/hmibsc_defconfig                           |  1 +
 5 files changed, 80 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index d3de8693b5a..f863daf6bb9 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -42,4 +42,20 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+choice
+	prompt "Qualcomm boot0.h workaround"
+	optional
+	help
+	  While U-Boot on Qualcomm platforms doesn't generally need compile-time
+	  adjustments based on the target SoC, workarounds in boot0.h can't
+	  practically detect the SoC at runtime. Enable one of these workarounds
+	  if you know you need it.
+
+config BOOT0_MSM8916_PSCI_WORKAROUND
+	bool "boot0.h workaround for buggy PSCI on the msm8916 SoC"
+	help
+	  Select this if you are building U-Boot proper for an msm8916 board that
+	  uses the buggy PSCI implementation.
+endchoice
+
 endif
diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index 953cccad790..b3c76d6d97d 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -1,54 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Workaround for "PSCI bug" on DragonBoard 410c
- * Copyright (C) 2021 Stephan Gerhold <stephan@gerhold.net>
- *
- * Syscall parameters taken from Qualcomm's LK fork (scm.h):
- * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
- *
- * The PSCI implementation in the TrustZone/tz firmware on DragonBoard 410c has
- * a bug that starts all other CPU cores in 32-bit mode unless the TZ syscall
- * that switches from 32-bit to 64-bit mode is executed at least once.
- *
- * Normally this happens inside Qualcomm's LK bootloader which runs in 32-bit
- * mode and uses the TZ syscall to boot a kernel in 64-bit mode. However, if
- * U-Boot is installed to the "aboot" partition (replacing LK) the switch to
- * 64-bit mode never happens since U-Boot is already running in 64-bit mode.
- *
- * A workaround for this "PSCI bug" is to execute the TZ syscall when entering
- * U-Boot. That way PSCI is made aware of the 64-bit switch and starts all other
- * CPU cores in 64-bit mode as well.
- */
-#include <linux/arm-smccc.h>
-
-#define ARM_SMCCC_SIP32_FAST_CALL \
-	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, ARM_SMCCC_OWNER_SIP, 0)
-
-	/*
-	 * U-Boot might be started in EL2 or EL3 with custom firmware.
-	 * In that case, we assume that the workaround is not necessary or is
-	 * handled already by the alternative firmware. Using the syscall in EL2
-	 * would demote U-Boot to EL1; in EL3 it would probably just crash.
-	 */
-	mrs	x0, CurrentEL
-	cmp	x0, #(1 << 2)	/* EL1 */
-	bne	reset
-
-	/* Prepare TZ syscall parameters */
-	mov	x0, #ARM_SMCCC_SIP32_FAST_CALL
-	movk	x0, #0x10f	/* SCM_SVC_MILESTONE_CMD_ID */
-	mov	x1, #0x12	/* MAKE_SCM_ARGS(0x2, SMC_PARAM_TYPE_BUFFER_READ) */
-	adr	x2, el1_system_param
-	mov	x3, el1_system_param_end - el1_system_param
-
-	/* Switch PSCI to 64-bit mode. Resets CPU and returns at el1_elr */
-	smc	#0
-
-	/* Something went wrong, perhaps PSCI is already in 64-bit mode? */
+#if defined(CONFIG_SPL_BUILD)
 	b	reset
-
-	.align	3
-el1_system_param:
-	.quad	0, 0, 0, 0, 0, 0, 0, 0, 0	/* el1_x0-x8 */
-	.quad	reset				/* el1_elr */
-el1_system_param_end:
+#else
+#if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
+#include "msm8916_boot0.h"
+#else
+	b	reset
+#endif
+#endif
diff --git a/arch/arm/mach-snapdragon/include/mach/msm8916_boot0.h b/arch/arm/mach-snapdragon/include/mach/msm8916_boot0.h
new file mode 100644
index 00000000000..953cccad790
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/msm8916_boot0.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Workaround for "PSCI bug" on DragonBoard 410c
+ * Copyright (C) 2021 Stephan Gerhold <stephan@gerhold.net>
+ *
+ * Syscall parameters taken from Qualcomm's LK fork (scm.h):
+ * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
+ *
+ * The PSCI implementation in the TrustZone/tz firmware on DragonBoard 410c has
+ * a bug that starts all other CPU cores in 32-bit mode unless the TZ syscall
+ * that switches from 32-bit to 64-bit mode is executed at least once.
+ *
+ * Normally this happens inside Qualcomm's LK bootloader which runs in 32-bit
+ * mode and uses the TZ syscall to boot a kernel in 64-bit mode. However, if
+ * U-Boot is installed to the "aboot" partition (replacing LK) the switch to
+ * 64-bit mode never happens since U-Boot is already running in 64-bit mode.
+ *
+ * A workaround for this "PSCI bug" is to execute the TZ syscall when entering
+ * U-Boot. That way PSCI is made aware of the 64-bit switch and starts all other
+ * CPU cores in 64-bit mode as well.
+ */
+#include <linux/arm-smccc.h>
+
+#define ARM_SMCCC_SIP32_FAST_CALL \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, ARM_SMCCC_OWNER_SIP, 0)
+
+	/*
+	 * U-Boot might be started in EL2 or EL3 with custom firmware.
+	 * In that case, we assume that the workaround is not necessary or is
+	 * handled already by the alternative firmware. Using the syscall in EL2
+	 * would demote U-Boot to EL1; in EL3 it would probably just crash.
+	 */
+	mrs	x0, CurrentEL
+	cmp	x0, #(1 << 2)	/* EL1 */
+	bne	reset
+
+	/* Prepare TZ syscall parameters */
+	mov	x0, #ARM_SMCCC_SIP32_FAST_CALL
+	movk	x0, #0x10f	/* SCM_SVC_MILESTONE_CMD_ID */
+	mov	x1, #0x12	/* MAKE_SCM_ARGS(0x2, SMC_PARAM_TYPE_BUFFER_READ) */
+	adr	x2, el1_system_param
+	mov	x3, el1_system_param_end - el1_system_param
+
+	/* Switch PSCI to 64-bit mode. Resets CPU and returns at el1_elr */
+	smc	#0
+
+	/* Something went wrong, perhaps PSCI is already in 64-bit mode? */
+	b	reset
+
+	.align	3
+el1_system_param:
+	.quad	0, 0, 0, 0, 0, 0, 0, 0, 0	/* el1_x0-x8 */
+	.quad	reset				/* el1_elr */
+el1_system_param_end:
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 51ad265688c..645f0816701 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -11,6 +11,7 @@ CONFIG_ENV_OFFSET=0x0
 CONFIG_DEFAULT_DEVICE_TREE="qcom/apq8016-sbc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND=y
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
 CONFIG_REMAKE_ELF=y
 CONFIG_BUTTON_CMD=y
diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
index 1e3d744193d..358b13aac77 100644
--- a/configs/hmibsc_defconfig
+++ b/configs/hmibsc_defconfig
@@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0x0
 CONFIG_DEFAULT_DEVICE_TREE="apq8016-schneider-hmibsc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND=y
 CONFIG_IDENT_STRING="\nSchneider Electric-HMIBSC"
 CONFIG_REMAKE_ELF=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set

-- 
2.54.0

