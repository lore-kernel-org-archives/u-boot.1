Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61690C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C3182F28;
	Wed,  2 Jul 2025 03:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BPR3JriO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3BF88309C; Wed,  2 Jul 2025 03:05:42 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C7C682F03
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-408d14c7e92so3068109b6e.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418339; x=1752023139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydodWZGaHf8o15vTFyPDEiaMc+5rXjyr3s10hGVPLEo=;
 b=BPR3JriOphHEO+3kc0gJL32b0zPdsi8moac4XLgtMZelUK+/h9BQAEyM9ofDRDgpHs
 Wsok6NeQzcf3Qq+JzY8T2lphAez6dG3RSVgzK3qAOKn4hHGAaSaKKpdkk7Ea68dCsDVz
 AANMecQ7x1xYXUjMLTmM+aLScyJjzmJ2NOIas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418339; x=1752023139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydodWZGaHf8o15vTFyPDEiaMc+5rXjyr3s10hGVPLEo=;
 b=ZiV5NDUfbRQUgbogot1ssfuTfXyqMTy7RQ6fBHhzVD7wjn+zyM/mTa8heYtmNmJq8Z
 +/Sg4FVfDgoHOayKzHN7reP+hSRvgkFfjjQJG6O7xwbxfMPY9x6Q2pUSVHJ/BO4IybrW
 crX4uwo1BiGE6cG81T54MKGQEDP1mB1DHug3L4yE3v4+49sQ2Sp/jlYJaxaHxLIkyrtm
 wW4fa2hKfJc7hOaoRF3lsoxStuhv3x+AB92W4xK2CnpmAl1RJ8STV4SxB0NZqC8Lh68n
 1WzHV2zrfiEZKdeJp1qNuON0+4RYzgBsRLVzf5gN4GvlgotmtOC1dQSfuHjgcv/BhTTN
 pMLw==
X-Gm-Message-State: AOJu0Yy37wVX9fWOlcQ1jYKMSARNL2Z7Y7gGUVSFFBtqGWGekuj9TdmD
 l1F7i3YEN3GwBrlSu7PyhPKYv8vlNEHLYilA9wL5azlsqJ1v0IlgJUMyKdhkbX7/dSdRA74OBes
 Rx4Os1yM=
X-Gm-Gg: ASbGncunNxB7pJjie/3XkZxEKxzXoXgOtgUzvbHn71pMOV/ZnvtVhhkGw8UvtklEhEZ
 vnNOnN20ZZ7p8ikpkXqtTmkcLUOapqH0ncuc7cy+c4rMUrRGjIVHInUiLGlF//nfQZ3QtlbhNGt
 XEKNhO45llfj618D0yGPtJbx6LYVK+N7HenKoUP4z7LXQwIcB6kzUeiXhJcrgYS1N8/cIBK374I
 RuuRfu+TwrfnFXkOdchsjbOKR/mrMPk1N6nLlngjV6mXO2xjoSzH5YbVhovQpqxx+pSj+rFqaxg
 EZ0oBLmjUTgyLPIla5OidD44jN0QUvDfwOWCULTTM2vKpLtkyEulo7wIZUi++G0t+sakhYibwbS
 pL6NEfbvSNzcGtvM2RQhIuxS2x9WoLh4j5A==
X-Google-Smtp-Source: AGHT+IEyrw0U7X7MDGOAsBmxElltKEmuucx0y7XicTRcamDxVcnwJje89S3ZdY03XbzCym46EycDZQ==
X-Received: by 2002:a05:6808:1887:b0:3fa:82f6:f74d with SMTP id
 5614622812f47-40b88e07fa0mr697751b6e.23.1751418339324; 
 Tue, 01 Jul 2025 18:05:39 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b324054a2sm2377372b6e.31.2025.07.01.18.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 3/3] clk: Tighten some clock driver dependencies
Date: Tue,  1 Jul 2025 19:05:35 -0600
Message-ID: <20250702010535.19250-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702010535.19250-1-trini@konsulko.com>
References: <20250702010535.19250-1-trini@konsulko.com>
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

A few clock drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
---
 drivers/clk/Kconfig        | 2 +-
 drivers/clk/at91/Kconfig   | 2 +-
 drivers/clk/sifive/Kconfig | 2 +-
 drivers/clk/ti/Kconfig     | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ef1e5355be87..83f06f50478b 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -169,7 +169,7 @@ config CLK_K210_SET_RATE
 
 config CLK_MPC83XX
 	bool "Enable MPC83xx clock driver"
-	depends on CLK
+	depends on CLK && MPC83xx
 	help
 	  Support for the clock driver of the MPC83xx series of SoCs.
 
diff --git a/drivers/clk/at91/Kconfig b/drivers/clk/at91/Kconfig
index 4563892647be..faeaa2808b03 100644
--- a/drivers/clk/at91/Kconfig
+++ b/drivers/clk/at91/Kconfig
@@ -1,6 +1,6 @@
 config CLK_AT91
 	bool "AT91 clock drivers"
-	depends on CLK
+	depends on CLK && ARCH_AT91
 	select MISC
 	help
 	  This option is used to enable the AT91 clock driver.
diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index 20fc004b59e9..01e4f33415e1 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -2,7 +2,7 @@
 
 config CLK_SIFIVE
 	bool "SiFive SoC driver support"
-	depends on CLK
+	depends on CLK && RISCV
 	help
 	  SoC drivers for SiFive Linux-capable SoCs.
 
diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index fbcdefd889ae..e0f15f57f826 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -5,14 +5,14 @@
 
 config CLK_TI_AM3_DPLL
 	bool "TI AM33XX Digital Phase-Locked Loop (DPLL) clock drivers"
-	depends on CLK && OF_CONTROL
+	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
 	help
 	  This enables the DPLL clock drivers support on AM33XX SoCs. The DPLL
 	  provides all interface clocks and functional clocks to the processor.
 
 config CLK_TI_CTRL
 	bool "TI OMAP4 clock controller"
-	depends on CLK && OF_CONTROL
+	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
 	help
 	  This enables the clock controller driver support on TI's SoCs.
 
-- 
2.43.0

