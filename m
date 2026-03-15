Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93B7F30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D34184488;
	Mon, 16 Mar 2026 00:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n6t7dOh1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Mly/j2vP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD7984488; Mon, 16 Mar 2026 00:55:24 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E969784485
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fYw8B18R9z9ttW;
 Mon, 16 Mar 2026 00:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3D7v/mJFOImovPCET2kaqw/HF4zTQDd0IhFgB728e9A=;
 b=n6t7dOh18sU4luRPS+oRf53g4y8bASQnoaTTQazBLD/Cnht2nnFpTH88Dw+VxJ1WF1bkN1
 DdCYDMvlJ2ZH57Jv5mSrtWPvX1IuV5Hx/TqCNCxNiKPCVM8zfGiaLUMMaSAQ5emev2p0Jv
 aWGThzdRvI7yKwA1uy1OHEyn0rooh57ouPGswH+bvHIY/T8NGDlevPyXoouVQ1RtNJ5q5/
 /B2gHKR0VrGCi6WJyJvyU+O4aN2thcGu4XxYKsxbpJCeVMpp9PN/EXSCNfE7VGcfvVSVCa
 zPeI19aDfp7eUYs20zenUN/hhRjlXDgbGgnTUzNWYz/rJqn4AEfBVw8YRemo9A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3D7v/mJFOImovPCET2kaqw/HF4zTQDd0IhFgB728e9A=;
 b=Mly/j2vPG2VYM1EQZrb3aCtFGhJhK86a2TEdjBQk+L1vJU8dKlppEvn17jBkmcUCayt1r+
 khgFY6Qh/EbIEviiG3RoNR4hRfsxxyTCHyX0tBnzXyCpZLyiKu+k1BgqhZ8h+PqpWIXJce
 mbmRE34UyCNQBnLREISH1SJ5/P688H8C2AIWpcZqjSIfei/RM93RdXZaHLgZfheN6LzJ5H
 7pytIyA1BabEUTWim8C3XY/ws5oMJ8pI7YHNNBHFY49E0E8jQ3gR1jL+h2ips5XpiXH6P3
 X9FRdNmHrgtSZh5zPkWLQCVH/FkJyq5DwKGeU/Gc0y8v018Pt8L2J0vsDd++fQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] arm: relocate: Introduce data-only relocation mode
Date: Mon, 16 Mar 2026 00:54:05 +0100
Message-ID: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a3c7c91b37fc5a14549
X-MBO-RS-META: r961bmqtyingquikewfg45gb4ej5k47j
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

Introduce new mode of relocation which relocates only data, not code.
This is mainly meant to relocate data to read-write portion of the RAM,
while the code remains in read-only portion of the RAM from which it is
allowed to execute. This split configuration is present on various secure
cores.

The result of the relocation is U-Boot running at its original address,
data relocated to the end of DRAM, but with added read-write area offset.
The U-Boot binary area is not reserved from the end of the DRAM in this
relocation mode, because U-Boot itself is not relocated.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
Cc: Jesse Taube <mr.bossman075@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.denx.de
---
 Kconfig                 | 17 +++++++++++++++++
 arch/arm/lib/crt0.S     |  4 ++++
 arch/arm/lib/relocate.S | 25 +++++++++++++++++++++++++
 common/board_f.c        |  2 +-
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index ce25ea24a60..575ee3b574f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -474,6 +474,23 @@ config SKIP_RELOCATE
 	  Skips relocation of U-Boot allowing for systems that have extremely
 	  limited RAM to run U-Boot.
 
+config SKIP_RELOCATE_CODE
+	bool "Skips relocation of U-Boot code to end of RAM"
+	help
+	  Skips relocation of U-Boot code to the end of RAM, but still does
+	  relocate data to the end of RAM. This is mainly meant to relocate
+	  data to read-write portion of the RAM, while the code remains in
+	  read-only portion of the RAM from which it is allowed to execute.
+	  This split configuration is present on various secure cores.
+
+config SKIP_RELOCATE_CODE_DATA_OFFSET
+	hex "Offset of read-write data memory from read-only text memory"
+	default 0x0
+	depends on SKIP_RELOCATE_CODE
+	help
+	  Offset of the read-write memory which contains data, from read-only
+	  memory which contains executable text.
+
 endif # EXPERT
 
 config PHYS_64BIT
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index d10c129705d..f2c5aa37a8f 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -157,7 +157,11 @@ ENTRY(_main)
 	orr	lr, #1				/* As required by Thumb-only */
 #endif
 	ldr	r0, [r9, #GD_RELOCADDR]		/* r0 = gd->relocaddr */
+#if defined(CONFIG_SKIP_RELOCATE_CODE)
+	bl	relocate_code
+#else
 	b	relocate_code
+#endif
 here:
 /*
  * now relocate vectors
diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
index 6ee58f4edfe..b6a648708f4 100644
--- a/arch/arm/lib/relocate.S
+++ b/arch/arm/lib/relocate.S
@@ -79,6 +79,15 @@ ENDPROC(relocate_vectors)
 ENTRY(relocate_code)
 relocate_base:
 	adr	r3, relocate_base
+
+#ifdef CONFIG_SKIP_RELOCATE_CODE
+	mov r4,	#CONFIG_SKIP_RELOCATE_CODE_DATA_OFFSET
+
+	ldr	r1, _data_start_ofs
+	add	r5, r1, r3		/* r5 <- Run &__data_start */
+	ldr	r1, _data_end_ofs
+	add	r6, r1, r3		/* r6 <- Run &__data_end */
+#else
 	ldr	r1, _image_copy_start_ofs
 	add	r1, r3			/* r1 <- Run &__image_copy_start */
 	subs	r4, r0, r1		/* r4 <- Run to copy offset      */
@@ -90,6 +99,7 @@ copy_loop:
 	stmia	r0!, {r10-r11}		/* copy to   target address [r0] */
 	cmp	r1, r2			/* until source end address [r2] */
 	blo	copy_loop
+#endif
 
 	/*
 	 * fix .rel.dyn relocations
@@ -107,6 +117,15 @@ fixloop:
 	/* relative fix: increase location by offset */
 	add	r0, r0, r4
 	ldr	r1, [r0]
+
+#ifdef CONFIG_SKIP_RELOCATE_CODE
+	/* Test whether this is data, if not, do not relocate. */
+	cmp	r1, r5
+	blt	fixnext
+	cmp	r1, r6
+	bgt	fixnext
+#endif
+
 	add	r1, r1, r4
 	str	r1, [r0]
 fixnext:
@@ -126,3 +145,9 @@ _rel_dyn_start_ofs:
 	.word	__rel_dyn_start - relocate_code
 _rel_dyn_end_ofs:
 	.word	__rel_dyn_end - relocate_code
+#ifdef CONFIG_SKIP_RELOCATE_CODE
+_data_start_ofs:
+	.word	__data_start - relocate_code
+_data_end_ofs:
+	.word	__data_end - relocate_code
+#endif
diff --git a/common/board_f.c b/common/board_f.c
index df2b0dc899b..bd45669aef5 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -463,7 +463,7 @@ static int reserve_uboot(void)
 	if (CONFIG_IS_ENABLED(SKIP_RELOCATE))
 		gd->flags |= GD_FLG_SKIP_RELOC;
 
-	if (!(gd->flags & GD_FLG_SKIP_RELOC)) {
+	if (!(gd->flags & GD_FLG_SKIP_RELOC) && !CONFIG_IS_ENABLED(SKIP_RELOCATE_CODE)) {
 		/*
 		 * reserve memory for U-Boot code, data & bss
 		 * round down to next 4 kB limit
-- 
2.51.0

