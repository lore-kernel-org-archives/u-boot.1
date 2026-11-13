Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12688606A335
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lmesw8B8;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=Dzpjq8Ob
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E277160E9A;
	Fri, 13 Nov 2026 02:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBfkx9FwCgzq; Fri, 13 Nov 2026 02:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D20960E39
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537231;
	b=MTYlwqHK5j4N4FR9kjaayw0Zv3lyJl/O3KgM/K5YqIvi48fdTS/T7ZH/JnZNuHK5V9GE
	 GFtT1br61eMyYJOk/EZnGn5QNC0Us3Fowy8YHPu/MmGJ+vzFUW7h8KOnh08CujLQLILJU
	 ewS5JX4WJ0aTQZCFT5AoZXxMCyoXgMLjYQdC5DEfoZ/LdeALhCY5+AkUwNx55MBGyaY8u
	 q0Rn6j01PEwT7NPDU8oTnbtavIF7+N24tdwXPzOeZf8Fdr3oXsrl3qS5w7DLvWXzMcgAb
	 C6noFTiXuuQ7kBbDh5K+2sZ40qJDR09IQr9TnHqMufxAO7kUid7RfY9g0ps8Dt/HSAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=so9onVI3SP6pb7+jC5LL53SaL6NsRNeakG8QoV3sRkk=;
	b=LMaBewFatAu77+zGK8ylUU+7U2ptUnBNelQM4sSVDZa1eqzvDcBiC9/epq1tmR+NoNgB
	 sRpyIK7HZHSeG/ll7L6z2FuaykvTycuvj/04SmoOdQ7QVgCNV5fVoXsc9mpirlMGG3rEB
	 b70pySIBicurXYwCvSepfNCMtCeTSWmEkszDhEN5inL6MN4noe6g9sQSIJ8TMT+lam0g1
	 0gCe//x+iRE/7esObCYfTafuqEBuCKOBocKl5mG9FfFR4l0AaHKm/s32NuL0Cye1LeWQg
	 waLkBSyd6zvMOspytjcMxFyk7+aiovSZrkQEqZlz2cuYpJ4rVHl9pAeHm02XWNjcaMw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537231;
	bh=so9onVI3SP6pb7+jC5LL53SaL6NsRNeakG8QoV3sRkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lmesw8B8k0CzgL90IltM7FZkp7fSYgtmv1lW/uVJBNiCJiTT+Np3wzBcB6RVAHRlx
	 NYO6KF56jWLfVAB+D9+f4cu/kMpENeJDPtAa+VJgWtnb3hvvPxUi9ZMcRLnLDaOk0F
	 VUOQa6le654r3CAlpzt8HY1CBGxDAfSwJQ1LU8hvVin40CwNgHrbYqHjEeVj75GolC
	 +HLyH+V49wlwk4/FtXzsc3MzP+dOZ7HIzj7WJh++dXKGaXxABBzcogfOR5YwqT8aum
	 bPDkD6KY8ZB8ssFcLOccjlser9X3tuHUK7iFfd6xKg63IQztkghKpJZZbMaeukYoAT
	 3ja2EpAybcBTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D20960E39;
	Fri, 13 Nov 2026 02:33:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DEF01790
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FC79400E6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqn8fcGMj662 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 319B540082
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=Dzpjq8Ob
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 319B540082
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:48 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 19B044C8BE;
 Fri, 13 Nov 2026 13:33:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=so9onVI3SP6pb7+jC5LL53SaL6NsRNeakG8QoV3sRkk=;
 b=Dzpjq8ObXrwlcPbzt9Zbu4fRmWCtutD70Q00HHz4r/4HbVs/75cmkxfkNjWTVh9aeXXuMR
 9uwr2CMGA51CABs0JsagVmBYf/BxYVJRZTPfXPREGTOxfwk1okU/fZWkcT+9DW+jh8bYGC
 cblF7N4F/th77SbD/oGQT3OnQohu0PJ+KFvCi5DjBbo0UIvGsQLjm2+eVIM6S1kFgWUMyB
 uUYrZOLd8NuERxCNV52OLL/w0ZTk8ZbE04A+09kDUeTLprUf30rlGcGTz6aZ/gMVDItxg9
 PxyEyaXSsR4GeI9fScVjx1nVaLog7z2PSjhxHzaoXq78cPeeb8Lmjc8/IMoGzQ==
X-GPT-Reason: The email is classified as legitimate personal/professional
 correspondence. The content describes a technical kernel or firmware
 patch related to "sunxi" and "Allwinner A733" hardware, which aligns
 perfectly with the sender's identity (Alastair D'Silva) and the
 mailbox (alastair@d-silva.org). There are no phishing indicators,
 no urgency/fear tactics, and the From domain matches the sender's
 signature and the recipient's domain, indicating a consistent and
 trusted communication flow.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 13/26] sunxi: fel: Add Allwinner A733 ERET FEL return support
Date: Fri, 13 Nov 2026 13:32:23 +1100
Message-ID: <20261113023236.569054-14-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the Allwinner A733, boot0.h latches CLU0_CPU0_CTRL_REG to AArch64
and sunxi-fel uses SRAM swap buffers across 0x47000. Rather than arming
R_CPUCFG hotplug magic and warm-resetting through BROM, drop directly
to Secure AArch32 SVC via ERET after draining UART0 TX, and install an
EL3 SMC vector in SH_SRAM (0x00080000) so sunxi-fel can re-enter AArch64
EL3 for BL31.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/cpu/armv8/fel_utils.S | 113 ++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/fel_utils.S b/arch/arm/cpu/armv8/fel_utils.S
index ccddfaaf04c..fc0e0b93c37 100644
--- a/arch/arm/cpu/armv8/fel_utils.S
+++ b/arch/arm/cpu/armv8/fel_utils.S
@@ -11,6 +11,30 @@
 #include <asm/system.h>
 #include <linux/linkage.h>
 #include <asm/arch/cpu.h>
+#include <asm/arch/serial.h>
+
+#ifdef CONFIG_MACH_SUN60I_A733
+#define A733_FEL_EL3_VBAR		SUNXI_FEL_EL3_VBAR
+#define A733_FEL_EL3_A32_SYNC_OFF	0x600
+#define UART_LSR_OFFSET			0x14
+#define UART_LSR_TEMT_BIT		6
+#define SCR_EL3_IRQ_EN			(1 << 1)
+#define SCR_EL3_FIQ_EN			(1 << 2)
+#define SCR_EL3_FEL_A32_CLEAR		(SCR_EL3_RW_AARCH64 | \
+					 SCR_EL3_SMD_DIS | \
+					 SCR_EL3_EA_EN | \
+					 SCR_EL3_FIQ_EN | \
+					 SCR_EL3_IRQ_EN | \
+					 SCR_EL3_NS_EN)
+#define ICC_SRE_EL3_ENABLE_ALL		0xf
+#define ICC_SRE_EL1_ENABLE_ALL		0x7
+#define ICC_IGRPEN1_EL3_ENABLE_ALL	0x3
+#define SPSR_EL3_A32_SVC_MASKED		(SPSR_EL_ASYN_MASK | \
+					 SPSR_EL_IRQ_MASK | \
+					 SPSR_EL_FIQ_MASK | \
+					 SPSR_EL_M_AARCH32 | \
+					 SPSR_EL_M_SVC)
+#endif
 
 /*
  * We don't overwrite save_boot_params() here, to save the FEL state upon
@@ -40,6 +64,89 @@ ENTRY(return_to_fel)
 	adr	x1, fel_stash_addr	// to find the fel_stash address in AA32
 	str	w2, [x1]
 
+#if defined(CONFIG_MACH_SUN60I_A733)
+#if CONFIG_IS_ENABLED(SERIAL)
+	/* Drain UART0 TX FIFO before dropping to AArch32 */
+	ldr	x2, =SUNXI_UART0_BASE
+	mov	w1, #0x10000
+2:	ldr	w0, [x2, #UART_LSR_OFFSET]
+	tbnz	w0, #UART_LSR_TEMT_BIT, 3f
+	subs	w1, w1, #1
+	b.ne	2b
+3:
+#endif
+
+	/*
+	 * On A733, boot0.h latches CLU0_CPU0_CTRL_REG to AArch64 and FEL uses
+	 * SRAM swap buffers across 0x47000. Rather than warm-resetting through
+	 * the BROM hotplug path, drop directly to Secure AArch32 SVC via ERET
+	 * and install an EL3 SMC vector in SH_SRAM outside the FEL swap buffer
+	 * so sunxi-fel can re-enter AArch64 EL3 for BL31.
+	 */
+	adr	x4, el3_a32_sync
+	adr	x5, el3_a32_sync_end
+	ldr	x6, =(A733_FEL_EL3_VBAR + A733_FEL_EL3_A32_SYNC_OFF)
+	mov	x8, x6
+4:	ldr	w7, [x4], #4
+	str	w7, [x6], #4
+	cmp	x4, x5
+	b.lo	4b
+
+5:	dc	cvau, x8
+	add	x8, x8, #64
+	cmp	x8, x6
+	b.lo	5b
+	dsb	ish
+	ic	iallu
+	dsb	ish
+	isb
+
+	ldr	x0, =A733_FEL_EL3_VBAR
+	msr	vbar_el3, x0
+
+	mrs	x1, ICC_SRE_EL3
+	orr	x1, x1, #ICC_SRE_EL3_ENABLE_ALL
+	msr	ICC_SRE_EL3, x1
+	isb
+
+	mrs	x1, ICC_SRE_EL1
+	orr	x1, x1, #ICC_SRE_EL1_ENABLE_ALL
+	msr	ICC_SRE_EL1, x1
+	mov	x1, #ICC_IGRPEN1_EL3_ENABLE_ALL
+	msr	ICC_IGRPEN1_EL3, x1
+
+	mrs	x0, scr_el3
+	mov	x1, #SCR_EL3_FEL_A32_CLEAR
+	bic	x0, x0, x1
+	msr	scr_el3, x0
+
+	mov	x0, #SPSR_EL3_A32_SVC_MASKED
+	msr	spsr_el3, x0
+
+	adr	x0, back_in_32
+	msr	elr_el3, x0
+
+	dsb	sy
+	isb
+	eret
+
+	.align	2
+el3_a32_sync:
+	mrs	x9, scr_el3
+	mov	x10, #SCR_EL3_RW_AARCH64
+	orr	x9, x9, x10
+	msr	scr_el3, x9
+	isb
+	cbnz	w0, 6f
+	movz	w0, #(CONFIG_SUNXI_BL31_BASE & 0xffff)
+	movk	w0, #(CONFIG_SUNXI_BL31_BASE >> 16), lsl #16
+6:	uxtw	x0, w0
+	ic	iallu
+	dsb	sy
+	isb
+	br	x0
+el3_a32_sync_end:
+#else
 	ldr	w0, =0xfa50392f		// CPU hotplug magic
 #if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_A133) || \
     defined(CONFIG_MACH_SUN55I_A523)
@@ -63,6 +170,7 @@ ENTRY(return_to_fel)
 	isb	sy
 1:	wfi
 	b	1b
+#endif
 
 fel_stash_addr:			// must immediately precede back_in_32:
 	.word   0x00000000	// receives fel_stash addr, by AA64 code above
@@ -71,6 +179,9 @@ fel_stash_addr:			// must immediately precede back_in_32:
 back_in_32:
 	.word	0xe51f000c	// ldr	r0, [pc, #-12]  ; load fel_stash address
 	.word	0xe5901008	// ldr	r1, [r0, #8]
+#ifdef CONFIG_MACH_SUN60I_A733
+	.word	0xe38110c0	// orr	r1, r1, #0xc0   ; mask IRQ/FIQ in thunk
+#endif
 	.word	0xe129f001	// msr	CPSR_fc, r1
 	.word	0xf57ff06f	// isb
 	.word	0xe590d000	// ldr	sp, [r0]
@@ -82,7 +193,7 @@ back_in_32:
 	.word	0xe590100c	// ldr	r1, [r0, #12]
 	.word	0xee011f10	// mcr	15, 0, r1, cr1, cr0, {0}  ; SCTLR
 	.word	0xf57ff06f	// isb
-#ifdef CONFIG_MACH_SUN55I_A523
+#if defined(CONFIG_MACH_SUN55I_A523) || defined(CONFIG_MACH_SUN60I_A733)
 	.word	0xe5901018	// ldr  r1, [r0, #24]
 	.word	0xee041f16	// mcr  15, 0, r1, cr4, cr6, {0}; ICC_PMR
 	.word	0xe590101c	// ldr  r1, [r0, #28]
-- 
2.53.0

