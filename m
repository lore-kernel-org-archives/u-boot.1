Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B01C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5775580FD4;
	Wed, 26 Feb 2025 12:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WjiLZdp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43FA80F3F; Wed, 26 Feb 2025 12:54:11 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA96180977
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e04f87584dso10257719a12.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570849; x=1741175649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhowHUeT/5LhDHKoQ+5wxstPgZDhJA8I1NnUSkErjrE=;
 b=WjiLZdp8f1j2UGNpxsp09M43hf6VvYxfm9FdyYmQvFOmaS9p4+DoWrQVS1AHERw5BR
 VsMJUzDUs/VcDwq0LG4qqUF6xTzTAS9q2eTFvdBRxOKSCczFAcnK51h07hCFXR+xcumJ
 hWD/LiQGXI0Np7Vhn824UPUY5XtNV3jc9HAyG0ZROir6blDXIKB2Fho9t2PFF9tJXgIX
 CetkG6jTrn0RVaxxEYx9OsAWFiW77PCwzJn2cwJolLWQP+61gYCNY6kkJ7A77bX5rX0L
 tw4WSRYOA5tkD5DWT0qsVk7ao6/Ma/zMKsgCVW4dEl4L9fTvrV521OczuJfGirG/sie3
 hixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570849; x=1741175649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhowHUeT/5LhDHKoQ+5wxstPgZDhJA8I1NnUSkErjrE=;
 b=b+0t13wPdT1b/72CyWL9MSrY/A1W3VbD7ce+mULzm+1fy10QFxCC7sK9hOVM2SEoqQ
 /3kgVRWC+MVQhp78pyAPFQzeAgyYdbQ1xQ+CZ+q4p4rgPCidzGvUL33fq6zh1OQ+zk1x
 ETzg8Gm4R+TXuX1WXJfIU6SMeBE7CsrJQ+inifm5jQBG1ZJBU6H8VnFQBED0c5PXOZXN
 859k/jOni/8KWHW4skVtg0quCwo1ohJfM8a4H+Oj2aGF86skm9gGpZBNKt5yziSxIz+m
 ilACvHqWEkX304rFftrGepk9D/h3fMh+E7uKWvWXYEiZwdQSBYh9Zoqt2QZP9oJvatIL
 0fRg==
X-Gm-Message-State: AOJu0YzzfrwKortTmugjO6N1hQ2tUc1F8kkRHDV+rS8sky3m9fgT6H0I
 DuR+9zgkTog9i46MJ0oxIYQXVZpAO4O4IDpyj1LFiV90Pjz0BguS
X-Gm-Gg: ASbGncu3XG4Y/r4Ed99OJjVJKoYRXt2g3BAJarALXLwJNdK7nemy3mLQgVJdy/CcQeJ
 eKL48hkgWgCpbqO9F4VkbGJBMx05iDTXOFFOvN4a9b8Mi3Ej+nZqmolvsNAkqtPCINmrUrDKsAZ
 VrdM/DY7bec0tr525nIc6qc4KBGUhpsaps4ZeKVBQW3Y1lk6NvmRfXFACUa1kT/IacGkG/HfNUJ
 VFPJSoa7af2fmlD1H/tlnmiBPzDO4KJt7+CoyUN75lwE0xbYlFmSr2omyjH15RyzaBllzW9Z2es
 cmY50nMaN4s6l7NKNw==
X-Google-Smtp-Source: AGHT+IFQyJLBB17+k5ZHYuIwwUoO50AtJ+VuugRWMXYtVl7+Bs0g+KQHEpYkhZTjFQrDEDuuEQWAfg==
X-Received: by 2002:a17:907:c407:b0:abc:4b7:e3d3 with SMTP id
 a640c23a62f3a-abeeedcfecbmr353872866b.27.1740570849134; 
 Wed, 26 Feb 2025 03:54:09 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:08 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 02/12] video: tegra20: dc: remove hardcoded Tegra 2
 specific parts
Date: Wed, 26 Feb 2025 13:53:28 +0200
Message-ID: <20250226115338.42832-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115338.42832-1-clamor95@gmail.com>
References: <20250226115338.42832-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Since pinmux driver now is available for Tegra 2, these parts may
be removed from here and defined either in device tree or in
the device board files.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../include/asm/arch-tegra20/clock-tables.h    |  2 ++
 drivers/video/tegra20/tegra-dc.c               | 18 ++----------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra20/clock-tables.h b/arch/arm/include/asm/arch-tegra20/clock-tables.h
index 861b3d5d07c..82685353bd1 100644
--- a/arch/arm/include/asm/arch-tegra20/clock-tables.h
+++ b/arch/arm/include/asm/arch-tegra20/clock-tables.h
@@ -32,6 +32,7 @@ enum clock_id {
 
 	CLOCK_ID_COUNT,	/* number of clocks */
 	CLOCK_ID_NONE = -1,
+	CLOCK_ID_DISPLAY2 = CLOCK_ID_NONE, /* for compatibility */
 };
 
 /* The clocks supported by the hardware */
@@ -159,6 +160,7 @@ enum periph_id {
 
 	PERIPH_ID_COUNT,
 	PERIPH_ID_NONE = -1,
+	PERIPH_ID_DSIB = CLOCK_ID_NONE, /* for compatibility */
 };
 
 enum pll_out_id {
diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index bd0d8ca7b8f..d54279ebda1 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -311,15 +311,10 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 	 * We halve the rate if DISP1 parent is PLLD, since actual parent
 	 * is plld_out0 which is PLLD divided by 2.
 	 */
-	if (priv->clk_parent->id == CLOCK_ID_DISPLAY)
+	if (priv->clk_parent->id == CLOCK_ID_DISPLAY ||
+	    priv->clk_parent->id == CLOCK_ID_DISPLAY2)
 		rate /= 2;
 
-#ifndef CONFIG_TEGRA20
-	/* PLLD2 obeys same rules as PLLD but it is present only on T30+ */
-	if (priv->clk_parent->id == CLOCK_ID_DISPLAY2)
-		rate /= 2;
-#endif
-
 	/*
 	 * The pixel clock divider is in 7.1 format (where the bottom bit
 	 * represents 0.5). Here we calculate the divider needed to get from
@@ -366,10 +361,6 @@ static int tegra_lcd_probe(struct udevice *dev)
 	int ret;
 
 	/* Initialize the Tegra display controller */
-#ifdef CONFIG_TEGRA20
-	funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
-#endif
-
 	if (priv->soc->has_pgate) {
 		uint powergate;
 
@@ -409,11 +400,6 @@ static int tegra_lcd_probe(struct udevice *dev)
 		return -1;
 	}
 
-#ifdef CONFIG_TEGRA20
-	pinmux_set_func(PMUX_PINGRP_GPU, PMUX_FUNC_PWM);
-	pinmux_tristate_disable(PMUX_PINGRP_GPU);
-#endif
-
 	ret = panel_enable_backlight(priv->panel);
 	if (ret) {
 		debug("%s: Cannot enable backlight, ret=%d\n", __func__, ret);
-- 
2.43.0

