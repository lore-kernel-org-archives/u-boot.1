Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7759CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0403B84E7D;
	Sat,  9 May 2026 02:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="Qg4jbuDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C26584CE5; Fri,  8 May 2026 23:46:25 +0200 (CEST)
Received: from mxd-3-701.seznam.cz (mxd-3-701.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA9584D1B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 23:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-gj4cr
 (smtpc-mxd-5f4d8d5f6f-gj4cr [2a02:598:96:8a00::1200:701])
 id 3efec01165f094783f570c4f; Fri, 08 May 2026 23:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778276750; bh=YxVwDAmeQdmABRn982IeBAwp3G1oh+IpdKbmfEQ3vOE=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=Qg4jbuDGjA8ky/1fgMqIv5bc5jZMhRMiTypae3GX5ms1pk/frJisgufox8wa3i3eW
 TUXfAFeUqSFSsCj7jFsfQQGkAbQfWGF28uS817gEDUw383Z7QdV7Dy0eTNt+9NJztX
 LoF4hQOz9y2h5M8GQaz29zjzN3ZizGtIrjVFVKPxNzBnXDj/F4/e3niBun1yp7J8Na
 rdEi7WXp5GhWllt57zS7eBpPzit8DhxV+x7rFlahkvm0iUWDvDVP8FKF6cy62bEDvC
 DlZ03lrYePvVGgPTI5GVSLb/bl+5dymaAYAWfV1CMK4TlPxNdTbyNeuMcLz/l/SfzS
 3kWvWMsX4TxkA==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-jn5pf (szn-email-smtpd/2.0.72) with ESMTPA
 id 01308299-9c65-463b-8554-1b0dc9c23a24;
 Fri, 08 May 2026 23:45:43 +0200
From: michael.srba@seznam.cz
Date: Fri, 08 May 2026 23:45:32 +0200
Subject: [PATCH v7 08/11] mach-snapdragon: boot0.h: add sdm845_spl_boot0.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-qcom_spl-v7-8-7d0e22aaaa8f@seznam.cz>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
In-Reply-To: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
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
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:31 +0200
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

On sdm845, running u-boot SPL in EL3 requires escalting by using
an unintentional feature in old builds of xbl_sec.elf. We do this
in boot0.h so the rest of U-Boot can stay blissfully unaware
of XBL_SEC. If we are already in EL3 for whatever reason, the
code is skipped.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-snapdragon/Kconfig                   |   6 +
 arch/arm/mach-snapdragon/include/mach/boot0.h      |   4 +
 .../include/mach/sdm845_spl_boot0.h                | 121 +++++++++++++++++++++
 3 files changed, 131 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index a2228e217af..aa7273f6095 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -63,6 +63,12 @@ config BOOT0_MSM8916_PSCI_WORKAROUND
 	help
 	  Select this if you are building U-Boot proper for an msm8916 board that
 	  uses the buggy PSCI implementation.
+
+config BOOT0_SDM845_WORKAROUND
+	bool "boot0.h workaround for SPL on the sdm845 SoC"
+	depends on SPL
+	help
+	  Select this if you are building U-Boot SPL for sdm845.
 endchoice
 
 endif
diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index b3c76d6d97d..b71aab37f44 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -1,6 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 #if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_BOOT0_SDM845_WORKAROUND)
+#include "sdm845_spl_boot0.h"
+#else
 	b	reset
+#endif
 #else
 #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
 #include "msm8916_boot0.h"
diff --git a/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h b/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
new file mode 100644
index 00000000000..11fe229ef56
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Workaround for non-qcom-signed code being entered in EL1 on sdm845
+ * Copyright (C) 2026 Michael Srba <Michael.Srba@seznam.cz>
+ *
+ * This code uses an unintentional ownership enhancing feature in older builds of XBL_SEC
+ * in order to elevate our privileges to EL3 as soon as possible after a system reset.
+ * This allows for a very close approximation of a clean state.
+ *
+ * Do note that you still need to own the device in the sense that you control the code that
+ * XBL_SEC jumps to in EL1, which is sadly not a level of ownership commonly afforded to you
+ * by the device manufacturer. On such devices, CVE-2021-30327 could help, but it's not documented
+ * and there is no PoC available utilizing it
+ *
+ */
+#include <linux/arm-smccc.h>
+
+#define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
+
+#define ARM_SMCCC_SIP32_FAST_CALL \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, ARM_SMCCC_OWNER_SIP, 0)
+
+/* same as with qcom's TZ */
+#define QCOM_SCM_SVC_MEM_DUMP 0x03
+/* unlike the TZ counterpart, in XBL_SEC this simply unlocks the XPUs */
+#define QCOM_SCM_MEM_DUMP_UNLOCK_SECURE_REGIONS 0x10
+
+/*
+ * We put our payload in place of some SCM call, the important thing is that it's hopefully
+ * in a memory region that is not in cache.
+ *
+ * It would be cleaner to just put our code at the scm entry point in the vector table,
+ * however it seems that we can't force cache coherency from EL1 if EL3 doesn't have
+ * any reason to care about that.
+ */
+#define QCOM_SCM_SVC_DONOR 0x01
+#define QCOM_SCM_DONOR 0x16
+/* we replace the instructions at this address with a jump to the start of u-boot */
+/* NOTE: this address is specific to a particular XBL_SEC elf */
+#define XBL_SEC_DONOR_SCM_ADDR 0x146a0ce0
+
+/* gnu as doesn't implement these useful pseudoinstructions */
+.macro movq Xn, imm
+	movz    \Xn,  \imm & 0xFFFF
+	movk    \Xn, (\imm >> 16) & 0xFFFF, lsl 16
+	movk    \Xn, (\imm >> 32) & 0xFFFF, lsl 32
+	movk    \Xn, (\imm >> 48) & 0xFFFF, lsl 48
+.endm
+
+.macro movl Wn, imm
+	movz    \Wn,  \imm & 0xFFFF
+	movk    \Wn, (\imm >> 16) & 0xFFFF, lsl 16
+.endm
+
+/* copy 32 bits to an address from a label */
+.macro copy32 addr, text_base, addrofval, offset
+	movl	x0, \addr
+	add	x0, x0, \offset
+	movq	x1, \text_base
+	add	x1, x1, \addrofval
+	add	x1, x1, \offset
+	ldr	w2, [x1]
+	str	w2, [x0]
+	dc	cvau, x0 // flush cache to RAM straight away, we need to do it by address anyway
+.endm
+
+.macro copy_instructions addr, text_base, start_addr, num_bytes // num_bytes must be a multiple of 4
+	mov x3,	#0x0 // x0, x1 and w2 used by copy32
+1:
+	copy32	\addr, \text_base, \start_addr, x3
+	add	x3, x3, #0x4 // i+=4
+	cmp	x3, \num_bytes
+	blo	1b
+.endm
+
+	/*  If we're already in EL3 for some reason,  skip this whole thing */
+	mrs	x0, CurrentEL
+	cmp	x0, #(3 << 2)	/* EL3 */
+	beq	reset
+
+	/* disable the mmu */
+	mrs	x0, sctlr_el1
+	and     x0, x0, #~(1 << 0) // CTRL_M
+	msr	sctlr_el1, x0
+
+	mov	x0, #ARM_SMCCC_SIP32_FAST_CALL
+	movk	x0, #SCM_SMC_FNID(QCOM_SCM_SVC_MEM_DUMP, QCOM_SCM_MEM_DUMP_UNLOCK_SECURE_REGIONS)
+	mov	x1, #0x0	/* no params */
+	mov	x6, #0x0
+
+	smc	#0 /* unlock XBL_SEC code area for writing (assuming old enough XBL_SEC build) */
+
+	/* this will also flush the writes from cache */
+	copy_instructions XBL_SEC_DONOR_SCM_ADDR, CONFIG_SPL_TEXT_BASE, el3_payload, #((el3_payload_end - el3_payload))
+
+	/* this probably doesn't affect EL3, but it doesn't hurt */
+	dsb	ish	/* block until cache is flushed */
+	ic	iallu	/* force re-fetch of our shiny new instructions */
+	dsb	ish	/* block until invalidation is finished */
+	isb	sy	/* unify here ? */
+
+	mov	x0, #ARM_SMCCC_SIP32_FAST_CALL
+	movk	x0, #SCM_SMC_FNID(QCOM_SCM_SVC_DONOR, QCOM_SCM_DONOR)
+	mov	x1, #0x0	/* no params */
+	smc	#0	/* call the payload */
+
+el3_ret_point:
+	b	reset
+
+el3_payload:
+	/* disable the mmu for EL3 too */
+	mrs	x0, sctlr_el3
+	and     x0, x0, #~(1 << 0) // CTRL_M
+	msr	sctlr_el3, x0
+	isb
+
+	/* jump back to our code, but now in EL3 */
+	movl	x0, CONFIG_SPL_TEXT_BASE
+	add	x0, x0, (el3_ret_point - _start)
+	br	x0
+el3_payload_end:

-- 
2.53.0

