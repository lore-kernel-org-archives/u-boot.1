Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3CAF94CA9
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 20:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D0084286;
	Tue, 21 Apr 2026 22:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="ozrvfaqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626FC8412A; Tue, 21 Apr 2026 21:45:05 +0200 (CEST)
Received: from mxd-3-71a.seznam.cz (mxd-3-71a.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 329C884258
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 21:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-fd5c5cd95-mftfr
 (smtpc-mxd-fd5c5cd95-mftfr [2a02:598:96:8a00::1200:71a])
 id 6f6fd69f346182f66ec61ac1; Tue, 21 Apr 2026 21:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1776800651; bh=aEF5FbSYSnG7y0MWgHIDXXIz1pWozGv8EYenxGusINU=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=ozrvfaqXCx0tULazLhrwOX9DBBALUhGHFqnnhCdKUPmyhpljrRY99MJnK5uGGmJmS
 EUClb/eyF1EEQHUpOkwZMoYeUQ1dFRYzBcYfXfBH90TCdx/PM3npiYR7jwlg2S/CG5
 LpJv9gRswhrUQFEMOcULaZ+L1unCZIwwkGazw0DFCMfSyJHPYmUtBGo9ntRS7BO1Kc
 WffS73lxic+Ghb1HE5Jad6P9RjkPVdJwLr6wXzveX9kzfQ9cKmhUuLkSaZKDi7St3y
 q9X5gFU1Bohog4hq+deKm7Qcx1sidVeZ7MOTDeGHrakfsZT1Bfvnw+1nrPTm9PbVcv
 0lb5CyB09SELA==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-7c7c659656-cskk5 (szn-email-smtpd/2.0.72) with ESMTPA
 id 082e4f52-1243-432f-86f0-985bc2b79b89;
 Tue, 21 Apr 2026 21:44:06 +0200
From: michael.srba@seznam.cz
Date: Tue, 21 Apr 2026 21:43:47 +0200
Subject: [PATCH v3 04/11] mach-snapdragon: boot0.h: split out msm8916_boot0.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-qcom_spl-v3-4-efee3f76754d@seznam.cz>
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
In-Reply-To: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
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
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 21 Apr 2026 22:07:20 +0200
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

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-snapdragon/include/mach/boot0.h      | 57 ++--------------------
 .../mach-snapdragon/include/mach/msm8916_boot0.h   | 54 ++++++++++++++++++++
 2 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index 953cccad790..44a764788de 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -1,54 +1,7 @@
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
+/* currently only db410c enables boot0.h in u-boot proper */
+#include "msm8916_boot0.h"
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

-- 
2.53.0

