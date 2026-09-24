Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206F7C98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9C9581DEE;
	Thu, 24 Sep 2026 12:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TIo2dQDDj72W; Thu, 24 Sep 2026 12:36:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E736981DF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253400;
	b=qWubF4loZhG17/hPSIqONWohJz7xdBHjajYOr0snSdwonUv727R8t3SA3sh/v7u33zc9
	 MsRspcZUeU8rHFYEBh7aDjsLyJz9oJE4ydWp9KFmcpFNjteKdoF+LwWf7oZBaIaU9C925
	 3kpGyGepug7nSHbst+LbE4xxU7wL3Vn56cyBiJAEAV8Eq5+qJxZKoytyRQDYRTFXm17f4
	 12+8K/OxmMrBx1ADXpmtR0oEAx00D3NisHFKSfoQ3njHhzauzqj5u+DVzvlOTYrT6Pve1
	 RfiDAZ8+/YqghyPHOFIn1/mnylLnKVzYv06UapKsb7G6kpshwGDKYjLdyEcceztkO2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ILuVtz1Gjnsmszft4HZVhSu6bdhHWiunNWggVg7IeUg=;
	b=YZeFVkLCJf/NnYXne6WeW4KXX6hERZkJUspmXXpbpWMkuJWeCL3joLfjMUNDRx5oC4uH
	 EWRy1h3DJvTzZvcQZzTjilG0en3vDe8+SHsbaJDdXMpxgGXkMxEQNMrOsmQB2T+wsGCey
	 M+y989qjId/1NiN/ZudIskbAyd2ANhGuP5SIGpsHO+ohHwpe3peSct9b3pyUZV10NmVnA
	 3AaTYx23OYQBejRis7Q/m14xBAifPYmo6Ppw6zBuFKzO8kX8J9iQpxFk/K8S3yQ1OzOYQ
	 wNMWEJy4Qxems8B6TChKqe8GeDGQ3jGYK/Me5Ha2kh0xpezM13F79KLVGCnMP8xziIw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253400;
	bh=ILuVtz1Gjnsmszft4HZVhSu6bdhHWiunNWggVg7IeUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H54IbFuZSN/RvO3aAph3alH8uVIWBEbYY598VLG52pFb3C2WTDT3EcIq9juIFkWlX
	 YQO37bbplsavjZcakBCeOYM8xl+i4e/wEN3ygduuL2lP4rw9AUcnXF7+f+pQJ5QR1+
	 mzL3n9uBxii8FlIsA2qLZbNC5t61eKQOm3fLoYnXn3c+iSVapz4hURr7TUl/qg1Ren
	 4mXjCp6ZLKtvh26iKkBtrBCkSoLtLzC0T0KQ01qKbHFYqOWfehdHwq212IvrynEfIY
	 rSnKjEMM+8vmln2EgSray7KDOPobQUZ2YV6m6QxBeV4uzaJBDe7IugEtv9458JxwX0
	 40ou8XIQTvW4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E736981DF0;
	Thu, 24 Sep 2026 12:36:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 94B83392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85E7040473
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNeyNF-uFuVq for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 92A1B400FB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253398;
 b=YDafB5yLWxDjq5Si3J1H+O95VXMzZ0lmP6rgsZGEvFcvlj/qPY2elMj21ZucyW3TEse9
 JZM+fVBiTmX0qtouV/uXhk6NuzjJJCRfGK0RRvMvfQtCfuv8KmvXGrLoFBzBZcitm8a2h
 uMjCMp3rei6JbGLtUvToFA4AgLi0uBS2OxQqSALox+qRQjs063rH7+i7It1E7vPCm/Kni
 Nxd3xhEddjjaK3wWoPgNTZLgAWmdj1LAO5I/lc0j7L4VmJqzv2p3DLXmDia50ZxDMUQVj
 FMtOk6h4hTgznFnLKy2WPKcfwFw5nYmRiqPpVUntFgx9YZKaP/vTTVaB7hPFhE4rW+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253398;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=ILuVtz1Gjnsmszft4HZVhSu6bdhHWiunNWggVg7IeUg=;
 b=Zk7M1cjAdmqtKuA/wpILmMNHiaQa3Xl1wWke48Is9ztEJQSHOAPzVJdAK2rMTc5cs/qR
 e9iQigAqe/00TzHbrAhHcnuBmoIIisdFQILh6R0ekn8BEe7chhUfip2dr5584DyEYtEyZ
 c0mN2NGRw08fvEL8cuQ9Dw/G4o5slYPx2nNbejdE+pTTiCZlLUhejvD41q4lkxaazpRKN
 upnvrfe/NK85QbEPIrPegn+WY3KLDdjmC800P28UplOyBuTPHmf9q+5TR6Tw5H8cZFWXO
 ooTDjAs51iR4KkKQtLls1b2tdOQAlx+1WtBmnLb1hrDpu6c9slCZHBhNvzGClTcgnDA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=icMWgbeH; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=icMWgbeH
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92A1B400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 43C3CC211C1;
 Thu, 24 Sep 2026 12:37:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B4F7260341;
 Thu, 24 Sep 2026 12:36:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D01410329463; 
 Thu, 24 Sep 2026 14:36:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253394; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ILuVtz1Gjnsmszft4HZVhSu6bdhHWiunNWggVg7IeUg=;
 b=icMWgbeHXhsHf6IupCm65IhKdfuA8huPAadW1lGxp0B6J3jShXD+gc2rJCbGPoH+LYtsoZ
 7AUMbBgTQ81c8Q3CVHKcOY8B5gJRUfvH50GMSC68Y5i1y/EwrWWMJO8UZpJfsEsk+d9n5d
 dRvbmi/ob4Whv7pXurGw3luVmoJVC4C5d8KZHDLkYKysffrxrMgriIvys+FuyPB0WufR1b
 mGXVldVBKIGM8CEv2kYD1JyOVjieSkGIhxe3DnzAbqFgo6fJfVL1HOM6z5M9G+486aeRBP
 c9B4a6M+FlGxMNG6xEiNmOKnk2Sjy29ob+ccvcmSibCLuzDjcXmk6GcwWv4fZA==
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
Subject: [PATCH v6 10/22] board: mach-k3: r5: common: Store wakeup reason on
 scratchpad memory
Date: Thu, 24 Sep 2026 14:35:21 +0200
Message-ID: <20260924123533.2599438-11-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
index a32ed3a9683f..bbb62fa617fc 100644
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
-- 
2.55.0

