Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDD6E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC5F80224;
	Thu, 12 Dec 2024 11:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mOAaQmIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8D3280214; Thu, 12 Dec 2024 11:21:32 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3B1801EB
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa69077b93fso56778366b.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998890; x=1734603690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhowHUeT/5LhDHKoQ+5wxstPgZDhJA8I1NnUSkErjrE=;
 b=mOAaQmIVRQ8YTX5q3eTJCkCQq4oPkFhnXcCOghAlcQDANB5ivN7BbVyfDbV2vC0cJe
 u0zH8kTpmBwF2WCCFeiIcZHcOznMOfsslOplpfA5E5Ed0Bd8UbjgFkdpGVLCsPSPDmay
 Ap2x/WG7y+CO8KeG+hhnWmCs2Ws6Fhn4QNZWfXdIs/BqvEAVID3ov3iP4Uf3WOIBJtV6
 ysfhwm31AnZM85kgZ23uieqBRD/MO9N90btWG3LsB7Sn7O0a9yiKiqfYhRsOaP7uFgE/
 gZB023wW30c5vCIk+GnOxYTuTwYORgnPMwMwB1TrT6iX/v5s7+Ac3QG5izXOK405Si/M
 +7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998890; x=1734603690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhowHUeT/5LhDHKoQ+5wxstPgZDhJA8I1NnUSkErjrE=;
 b=OCCB26xqTEqwuQRQ9Sk6BFRJUI9I7wVCSnq67OVGRid0vlM1lJm9ZU518sVXOKIVyB
 DnesCX5IWXQoAF9bcA8v8xlAkZLG0VqlWauo/Dasa4CdPIfRH/GQX+AWro2DcyRJiLqh
 7sLmNHlr3xRgE/pqVJmtGU8tR4ZhiqJZ0Cqoy0Pzw7ZIWmBD47StV/1uCDu5FBrBvHva
 XUutOgls/IICtBparasYoLb0YnG7q6sVETDPbeWMxmyPM1W4GionsMgNL7WxcA/1S34X
 uAUdhXl8giFyIPi9WZ4sQaSrPZSrTN1Iqk+5+UVJCvmKBETFZqQFr34UfMWivuNXaDBs
 FSyg==
X-Gm-Message-State: AOJu0YzR2DIfpO7WQBwIVMfxvA1iCz/LwGQPFzh05HtjDhfGnykTF0QA
 +OvbbeBzkakNhjLmBAzwMChcNQ4/Osqztb5xU+IDxI3p27ecwni/
X-Gm-Gg: ASbGncuKFoalTgLPCPKMuRZ1R3AvakrvgtW1VuxawEBTrrp01S9rV0gIbnQEIqlIydS
 EZ5n6WNDRITSOe+6oAngVev91tG+h1pNpBIi2y2TZ7I3zmVIdQFbhRbMh/byAa0Wp4eyxGRYl1p
 0Zxi3dvSzCCbkLwAZfJx16qt4y+Fu2GIg9gZSYT11EttNsXNqo1mP8bcTBIJC/Es7rYJOI/X5ik
 XCuAW69jREiJvjX+OoERNV7N2NI4XvWA27OjiDpyZWVWb5g
X-Google-Smtp-Source: AGHT+IGbPB0vUCF4G4Vn0NxjzltSg334CFlIK7pBktQA5FeIeRhknBfVtezH+jyc7Ug0TnCkbMiyrQ==
X-Received: by 2002:a17:906:2922:b0:aa6:abb0:747d with SMTP id
 a640c23a62f3a-aa6c1cf067cmr281813466b.47.1733998889757; 
 Thu, 12 Dec 2024 02:21:29 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 02/12] video: tegra20: dc: remove hardcoded Tegra 2
 specific parts
Date: Thu, 12 Dec 2024 12:21:09 +0200
Message-ID: <20241212102119.6466-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
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

