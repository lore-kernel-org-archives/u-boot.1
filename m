Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5D2C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0DE81E6C;
	Tue,  1 Apr 2025 17:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aOHjuXzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A150C80584; Tue,  1 Apr 2025 17:38:26 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC318171B
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so953826266b.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743521904; x=1744126704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63hxl15TVAnOhFLx1d6QCYyuDDOhaDcUc895SzJw6Rc=;
 b=aOHjuXzJpjCdKaO0ROetnAfKpSlXdECdXu23uWakOUCRngCbMcXKSDlkB4gYsfcpNz
 SzhIbiC1QlTDifz+ZrrtX60AzGyM6LISENylLxAq4f2kZsHWLU2VhSlcrg/bn+N4mS08
 1JL2sUJJNW5hziVTakSGzeSJYeT3qYcg21R9xYwhIyA+RFYB0YMP4YvQhQtNcPnYFDSU
 kmTC0llgGc3wWp+GErC9VtGrE/9k86Za/mgDdWdUgh9ARcCd/3FMnwtso2GJHqHSDrUa
 Kkn2mqAT4FJSSk0e+GqMd0X9tikr7RDITzPVeRHBJLfoj0VkpxmRNQJAkBhEjcG+jKJR
 c2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743521904; x=1744126704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63hxl15TVAnOhFLx1d6QCYyuDDOhaDcUc895SzJw6Rc=;
 b=iiyDESiGSWCIimCRiIKIoTzgW0BVErZTHS48FNxPvQjfzh0W8RALRU1jUxZyaj456b
 xufETa7d2DXuA65aiyWh3f+ArEoqmFnjzWsMWRT78Zo4CE6AiugkdliZp6cwyhW9hTF1
 0Yo9rwbRI0NcOIsgNBHqRl1qQuK6GdspTb5k9hOAut37yCtiY8PiJnuPKmbOS55o+GfY
 kyQp8ZehCTozMz6Pi3gIWgDPBBkAt7D1IoIR6UTaEPFdsgRiT1mez05C8QMTbTykJsKS
 +L2urB4AT5Srdk+MXcnhpvAAJqCavospI/8KbZrT2muuPv3lcwiWibf9K1vBz11v+gry
 ek9g==
X-Gm-Message-State: AOJu0Yx89927n9E0e/mtsWfu3O3uGmneWA1q15qYODTMct5KMKwU4BrD
 IspGLr9/59ylRV0f2eY38kTfzyMmwpVvT8QEBJRbdv72fDTzxtNMWb4ZPLE/
X-Gm-Gg: ASbGnctl39AGK3p68ziRTkG7rbGT8rZ9b5pfcVBNbPZ5iPbnG/VWAnDCr4qZVXu57nU
 2UlsBmbztkUwuFBz2cEIgXFYdjavDyr4Wb3rosZfX5SQUIQ5buMr6kbts6OGemKtRA2uPCATFFi
 5Y3IBwylpqQ2FYl7DC3fOyKFXtGFoAnTwrKSp5UdkBM8zP10nwISbQTT75S0xFwiM3R0YqvHPs6
 cJPUir59xi7n0mW50ZvaNRVpptIjZ2FjKu6CENV0tA4GtQvceoljuAGCU9MLCGN+h1tD6ag6OTS
 ArAO4emktOaydd8f9npxH0qVoCeqWRk1KUlW
X-Google-Smtp-Source: AGHT+IHLp8120eDa6z0+V5pJXr1R0LW2Wfc9c216WeEG42rXUhnZdD9X1Et5F/otBKrynV758mVP0Q==
X-Received: by 2002:a17:906:7955:b0:ac2:758f:9814 with SMTP id
 a640c23a62f3a-ac738a50849mr1331562466b.23.1743521903772; 
 Tue, 01 Apr 2025 08:38:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71f9316a1sm732784866b.82.2025.04.01.08.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 08:38:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] sysreset: diverge GPIO reset and poweroff configs
 per-phase
Date: Tue,  1 Apr 2025 18:37:58 +0300
Message-ID: <20250401153758.40088-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401153758.40088-1-clamor95@gmail.com>
References: <20250401153758.40088-1-clamor95@gmail.com>
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

GPIO reset and power-off functionality depends on device tree data, which
is often absent in SPL or TPL. To address this, incorporate PHASE_ into the
config and add Kconfig option for each phase.

Adjust SYSRESET_GPIO and POWEROFF_GPIO uses to address possible
regressions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/sifive/unleashed/Kconfig       |  1 +
 board/sifive/unmatched/Kconfig       |  1 +
 configs/ge_b1x5v2_defconfig          |  1 +
 configs/microblaze-generic_defconfig |  1 +
 drivers/sysreset/Kconfig             | 45 ++++++++++++++++++++++++++++
 drivers/sysreset/Makefile            |  4 +--
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/board/sifive/unleashed/Kconfig b/board/sifive/unleashed/Kconfig
index 5d842c36cfc..bf4a00d6f7f 100644
--- a/board/sifive/unleashed/Kconfig
+++ b/board/sifive/unleashed/Kconfig
@@ -49,6 +49,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply SPI_FLASH_ISSI
 	imply SYSRESET
 	imply SYSRESET_GPIO
+	imply SPL_SYSRESET_GPIO if SPL
 	imply CMD_I2C
 
 endif
diff --git a/board/sifive/unmatched/Kconfig b/board/sifive/unmatched/Kconfig
index bc1f33bde30..991dd23f1d4 100644
--- a/board/sifive/unmatched/Kconfig
+++ b/board/sifive/unmatched/Kconfig
@@ -48,6 +48,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply PHY_MSCC
 	imply SYSRESET
 	imply SYSRESET_GPIO
+	imply SPL_SYSRESET_GPIO if SPL
 	imply CMD_I2C
 
 endif
diff --git a/configs/ge_b1x5v2_defconfig b/configs/ge_b1x5v2_defconfig
index fec4b67aee2..b8cca3c74df 100644
--- a/configs/ge_b1x5v2_defconfig
+++ b/configs/ge_b1x5v2_defconfig
@@ -116,6 +116,7 @@ CONFIG_MXC_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_POWEROFF_GPIO=y
+CONFIG_SPL_POWEROFF_GPIO=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index 08f8bdb4240..7497d20ee64 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -97,6 +97,7 @@ CONFIG_SYS_NS16550=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_XILINX_SPI=y
 CONFIG_SYSRESET_GPIO=y
+CONFIG_SPL_SYSRESET_GPIO=y
 CONFIG_SYSRESET_MICROBLAZE=y
 CONFIG_WDT=y
 CONFIG_XILINX_TB_WATCHDOG=y
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 475540ffac7..4972905482a 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -71,6 +71,27 @@ config POWEROFF_GPIO
 	  Support for system poweroff using a GPIO pin. This can be used
 	  for systems having a single GPIO to trigger a system poweroff.
 
+config SPL_POWEROFF_GPIO
+	bool "Enable support for GPIO poweroff driver in SPL"
+	depends on DM_GPIO && SPL
+	help
+	  Support for system poweroff using a GPIO pin in SPL. This can be used
+	  for systems having a single GPIO to trigger a system poweroff.
+
+config TPL_POWEROFF_GPIO
+	bool "Enable support for GPIO poweroff driver in TPL"
+	depends on DM_GPIO && TPL
+	help
+	  Support for system poweroff using a GPIO pin in TPL. This can be used
+	  for systems having a single GPIO to trigger a system poweroff.
+
+config VPL_POWEROFF_GPIO
+	bool "Enable support for GPIO poweroff driver in VPL"
+	depends on DM_GPIO && VPL
+	help
+	  Support for system poweroff using a GPIO pin in VPL. This can be used
+	  for systems having a single GPIO to trigger a system poweroff.
+
 config SYSRESET_GPIO
 	bool "Enable support for GPIO reset driver"
 	depends on DM_GPIO
@@ -79,6 +100,30 @@ config SYSRESET_GPIO
 	  example on Microblaze where reset logic can be controlled via GPIO
 	  pin which triggers cpu reset.
 
+config SPL_SYSRESET_GPIO
+	bool "Enable support for GPIO reset driver in SPL"
+	depends on DM_GPIO && SPL
+	help
+	  Reset support via GPIO pin connected reset logic in SPL. This is used
+	  for example on Microblaze where reset logic can be controlled via
+	  GPIO pin which triggers cpu reset.
+
+config TPL_SYSRESET_GPIO
+	bool "Enable support for GPIO reset driver in TPL"
+	depends on DM_GPIO && TPL
+	help
+	  Reset support via GPIO pin connected reset logic in TPL. This is used
+	  for example on Microblaze where reset logic can be controlled via
+	  GPIO pin which triggers cpu reset.
+
+config VPL_SYSRESET_GPIO
+	bool "Enable support for GPIO reset driver in VPL"
+	depends on DM_GPIO && VPL
+	help
+	  Reset support via GPIO pin connected reset logic in VPL. This is used
+	  for example on Microblaze where reset logic can be controlled via
+	  GPIO pin which triggers cpu reset.
+
 config SYSRESET_MAX77663
 	bool "Enable support for MAX77663 PMIC System Reset"
 	depends on DM_PMIC_MAX77663
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index 796fc9effa5..ded91a4d325 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -8,8 +8,8 @@ obj-$(CONFIG_ARCH_ROCKCHIP) += sysreset_rockchip.o
 obj-$(CONFIG_ARCH_STI) += sysreset_sti.o
 obj-$(CONFIG_SANDBOX) += sysreset_sandbox.o
 obj-$(CONFIG_SYSRESET_CV1800B) += sysreset_cv1800b.o
-obj-$(CONFIG_POWEROFF_GPIO) += poweroff_gpio.o
-obj-$(CONFIG_SYSRESET_GPIO) += sysreset_gpio.o
+obj-$(CONFIG_$(PHASE_)POWEROFF_GPIO) += poweroff_gpio.o
+obj-$(CONFIG_$(PHASE_)SYSRESET_GPIO) += sysreset_gpio.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_MAX77663) += sysreset_max77663.o
 obj-$(CONFIG_SYSRESET_MPC83XX) += sysreset_mpc83xx.o
 obj-$(CONFIG_SYSRESET_MICROBLAZE) += sysreset_microblaze.o
-- 
2.43.0

