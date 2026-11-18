Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OQpPm2DW;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x3csmqLs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFA3A40A1C;
	Wed, 18 Nov 2026 13:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6N3cfrhqsAxl; Wed, 18 Nov 2026 13:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 10A9140A00
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007937;
	b=rbBSK28U2eAFnQ+EKLEzIqg1zhMGQBqpwC4gmNLETB3kvhClXyL2SBX1GA6/5QDRFETP
	 qr1AURf//bKbDt240mXiCnO5QeUOtQYhAc2DbJjNHOQDifPwQQtiskDFPS/kmflqJ+zoe
	 kR5cvkdSwafAWbFJum+JmjwB6qy5UJqWGZaok9VXfiFjkDiHs3KwaaF5UVtOmE1ZbPbeo
	 Y2+x7kV1t6q6oCA64p7Jc3a7aWzNYwxoeex4l9h2zJFl93G1+wC2ojFI23DQcFssP7BxJ
	 UQ3KSq5S+e6xE210t+GzShEi7Qg3UygmzySVu/OzBy9S+/ouEKpTRI31cszbYnU8WfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3Lx7G6P40WOvrst4t3HnxilrF/BYhXe2bvYw6yl00oc=;
	b=L+va6+PGo8iwXoD1KnrEkvLpkaK5ZQoGUPWeZGtuthHif5WPFdsmiC9L8Oh9obb8ao4J
	 mUO1zrpzEXrxi95YViMfDjBqQMpVFmKCoLSWD0B1fEYR3LGvmTena1R3bWxSNPaPQ0ccX
	 DXGa3795yEJwriZBqu1M/tSiG4RI2mAjXxs4pk83aC+X4iRJ4BLFmzs4+DW9zaOf2Chhc
	 HKU1OyVhOJnuVlpKY4fxzZa90uvpMq4CAXQfv66h1V5fHAYEFUWAOMcrOpcT3QGvxRvDB
	 nVxbQ/At8waE0HeoIZaQ1V5WjH+eNA+W73EAdx7iamqRCp/4C6I44NvnBqL7ywEA16g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007937;
	bh=3Lx7G6P40WOvrst4t3HnxilrF/BYhXe2bvYw6yl00oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OQpPm2DWw/3eA9eXCHEYa8DRQJqW+JF7e1Cu95ZgHWTAWKOldcriMz/CkSqMpT29O
	 Ilt2tcQzuZXMW7O4Cl28AFDqQs1VXL3W0l85exHOLTGBJtRraqP3WDjRbR0FLVR0wl
	 /oY+qrqUMuajpVvfLUbVzmtS8ilu4xWvNC3xWSGMfhs08g1VIYji4Tdb0XOoEbUijt
	 aF89YL2BtaHGQhDspQD17ORNIsSaYnek1ydBpHMFHmcy5YomfyA2jRoPzBCBGgsSaH
	 l25eNQEYtjRtWvHCaoirlxDOPlT1af+CAJIC0fDPhdqwebotJHSrBpDCjJ3wT5l7c+
	 Mac1c5/8Z2rIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10A9140A00;
	Wed, 18 Nov 2026 13:18:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A13F861
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 933BD60A6B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqEwZ7zdntVK for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B75AD60A51
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=x3csmqLs
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B75AD60A51
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 832E3C4CBDA;
 Wed, 18 Nov 2026 13:18:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AF1695FE9B;
 Wed, 18 Nov 2026 13:18:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DFEC611BC1E63; Wed, 18 Nov 2026 14:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007930; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=3Lx7G6P40WOvrst4t3HnxilrF/BYhXe2bvYw6yl00oc=;
 b=x3csmqLsKr2YnO8YuQ22Sd5attjHs5tGK5Y+k+8CGD+fer0tbf+R4PekGnpKPxtAtim/AR
 YNuMUqoYqNyaaWgUsUvqpokyPBt1zAZMyrQLWDuKKM+drJ0Jki+SDsenvhctqANoE96CNe
 +HXegDWenoioSOPBdKIARcWmD8aibWfgWxRmP427Szf2y+tF/E1DqLD2jTidYDRPWQK50h
 +cn2kY/rMeqgnT0bJVF8X4ssb03vq+M0449c/ojLdgoxRLQLKfu+PXIX+NIJXlfrXu54pW
 dkpkbzcnaR84eDr9ehUINLA1nfNlsoHSwjaBUZGJwgGg3lFlPRoAyKJ1jGMKXQ==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 08/20] board: mach-k3: r5: common: Store wakeup reason on
 scratchpad memory
Date: Wed, 18 Nov 2026 14:17:55 +0100
Message-ID: <20261118131807.135859-9-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abhash Kumar Jha <a-kumar2@ti.com>

While resuming from suspend, the wakeup reason need to be stored
and this will be used by the Linux kernel once its up.

Use the 32 bytes of MCU_PSRAM0_RAM area (addr = 0x40280000) to
store the wakeup reason.

Read the value as soon as it starts and store it internally.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/Kconfig         | 10 ++++++++++
 arch/arm/mach-k3/r5/lpm-common.c | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 14366c23d106..e9a0510c3227 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -101,6 +101,16 @@ config SYS_K3_BOOT_CORE_ID
 	int
 	default 16
 
+config SYS_K3_SCRATCH_LPM_ADDR
+	hex
+	default 0x40280000 if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J784S4
+	default 0x0
+	help
+	  Address where the wake-up reason is stored at resume (32 bits).
+	  It will be read by the Linux kernel once its up.
+	  On J7200/J784s4 the MCU_PSRAM0_RAM is used by default.
+	  Set it to 0 if unused.
+
 config K3_EARLY_CONS
 	bool "Activate to allow for an early console during SPL"
 	depends on SPL
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 96306f307973..6595f0caebcf 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -27,6 +27,11 @@
 /* PMIC register where the magic value resides */
 #define K3_LPM_SCRATCH_PAD_REG_3 0xcb
 
+/* Wake-up source IDs */
+#define K3_LPM_WAKE_SOURCE_MAIN_IO 0x80
+#define K3_LPM_WAKE_SOURCE_MCU_IO 0x81
+#define K3_LPM_WAKE_SOURCE_PMIC_GPIO 0xB0
+
 #define IO_ISO_STATUS BIT(25)
 
 #define CONTEXT_SAVE_SZ	0x80000
@@ -49,6 +54,11 @@ enum k3_resume_state {
 	K3_RESUME_STATE_RESUMING
 };
 
+struct lpm_scratch_space {
+	u16 wake_src;
+	u16 reserved;
+} __packed;
+
 __weak void clear_isolation(void) { }
 
 #define GPIO_OUT_1 0x3D
@@ -81,6 +91,7 @@ void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
 bool j7xx_board_is_resuming(void)
 {
 	static enum k3_resume_state k3_resuming;
+	struct lpm_scratch_space *lpm_scratch;
 	struct udevice *pmic;
 	u32 pmctrl_val = 0;
 	int ret, magic;
@@ -91,7 +102,18 @@ bool j7xx_board_is_resuming(void)
 #ifdef PMCTRL_IO_LPM
 	pmctrl_val = readl(PMCTRL_IO_LPM);
 #endif
+	lpm_scratch = (struct lpm_scratch_space *)CONFIG_SYS_K3_SCRATCH_LPM_ADDR;
+	if (lpm_scratch) {
+		lpm_scratch->wake_src = 0;
+		lpm_scratch->reserved = 0;
+	}
 	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		if (lpm_scratch) {
+			if (IS_ENABLED(CONFIG_SOC_K3_J784S4))
+				lpm_scratch->wake_src = K3_LPM_WAKE_SOURCE_MCU_IO;
+			else
+				lpm_scratch->wake_src = K3_LPM_WAKE_SOURCE_MAIN_IO;
+		}
 		clear_isolation();
 		k3_resuming = K3_RESUME_STATE_RESUMING;
 		debug("board is resuming from IO_DDR mode\n");
@@ -110,6 +132,9 @@ bool j7xx_board_is_resuming(void)
 
 	if (magic == K3_LPM_MAGIC_SUSPEND) {
 		debug("%s: board is resuming\n", __func__);
+		if (lpm_scratch)
+			lpm_scratch->wake_src = K3_LPM_WAKE_SOURCE_PMIC_GPIO;
+
 		k3_resuming = K3_RESUME_STATE_RESUMING;
 
 		/* clean magic suspend */
