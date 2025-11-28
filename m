Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4841D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22071845C1;
	Fri, 28 Nov 2025 15:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XT4Rn9HZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C00D844E3; Fri, 28 Nov 2025 11:17:27 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A43283B9B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so10161085e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 02:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764325044; x=1764929844;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pauWcz+YTm+QT6ZFu/bhMyIAi6K0AgoeZJcJY5Stacs=;
 b=XT4Rn9HZNuwqau6lbvzDMUE8M4TEyTvKLGCvBH+M9Q29g4reN3zrl5yvN7uRz4RkhX
 bk0RbrMwlbikd/h5ikuB6ibWFKMqDf+4ZsmSX+wt0JqtncJWip9oIJVp62vc/noNM3fC
 NiTQVIP2FLT/dWG0HPRIAJR0QVYUvzHswk9CYjcWA6wRYY/ytm5RwQhruSkGsZK4V2DV
 QGhUt/UXYMgTHPRYYLJRN6lL+MxixC9S55w+OwA5WWSxjTrl6HsfOu6NiRX29uK6fVaw
 +SM4kRJJiMjk05Zns3DtK3wdwIMUt2YIMywJUW0/mNgwjp4kbeZhmqsfWDDq4lxeFVhP
 Qo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764325044; x=1764929844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pauWcz+YTm+QT6ZFu/bhMyIAi6K0AgoeZJcJY5Stacs=;
 b=OCY3RwWQL1OFo4kGE7hQFWvvv8EdrJE1qCERDZbHRCCkO468c+AN+J+H098DgVrVxH
 /Q7qtIfjmveRU17dYbKHEu10GQljSydNcytY2MA+NfAudSbNjWbIvUbnAbV97qi6rQXE
 fzJqIV83cbWEVe+1q9TqwHvnSSQ506/TH2CvCu9kxYm8+rgcFRwVwm3SETcdy7yJGrr7
 TvqxEmO6P6/wC7pYYF3hgbzZFgLbLWsbklsY+UMp7Mrbsa6gpnJipJd/GQTthXvtomah
 2cZWBHLbFv6I6TPDYAzi5EZi23wZ6eV6THA1spaAy0HhYh3rxPHLimK7KtucRZ9Nx6Ui
 XR8g==
X-Gm-Message-State: AOJu0Yw2f3xsZiRBIjDJV6Br1Pip6wFR6ZWlUAoedNebNxkLYVwTcpJT
 U5IFwxjBQ60XZPJiBLq/aGFrbxwigndE3N1xzR3QrjnthBSrrKs+N0sILmjFIkfbWDE=
X-Gm-Gg: ASbGncu9rvu37Au05YHyDpwl1bRv5WD2mL4zefFT+2BcRJfVNkzY1LLzF4De36L2b4Q
 Ge/wPlOT48qqUE0b/njXud1CSQW3CHpU79ZeUh2yRo7dcnQHL8Q9nRsF3UnbxhBj3YwIVNKG6RY
 du0M8lhAaTXYBmO/pg+xQRjsD7ULLeRf3tKmfgHPFLFZzVaAHiqntUWEZAd6K6B/R95a7U9ZCrN
 AG+JDX53+5uIu4rlk9ErX3MWkVMMvjr+QnvK0N0DFQCMy8MSirrvcW3zJNV5LsPjjMATsT+Hl6K
 QrCjThA+gevxFMFXjdhFDHfpI2eVFW1SnBJeBZg/zmhpnEIGWUP/8KWNXR9tjIuFVQHBzN7q7W7
 cZhIrl65wElDNWDO9PlZIk3glcC2eK35936Opwj7BaYVTEUgUf3Xcod8N33bjv6vGC5X4ykLc0I
 F3GWpiCZs=
X-Google-Smtp-Source: AGHT+IH1XhzwgmQXLbZ+5duZikTKlBvCHvA318avleOOiar4msskeqoPu/HzaUs0awxSqPIxebuEbw==
X-Received: by 2002:a05:600c:a08:b0:477:7b16:5fa6 with SMTP id
 5b1f17b1804b1-477c0162e8emr265722405e9.3.1764325043985; 
 Fri, 28 Nov 2025 02:17:23 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4790add4b46sm151215505e9.4.2025.11.28.02.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 02:17:23 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 11:17:00 +0100
Subject: [PATCH 2/2] clk: ti: omap4-cm: Add Kconfig symbol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-2-d722c79506b2@baylibre.com>
References: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-0-d722c79506b2@baylibre.com>
In-Reply-To: <20251128-topic-am33-clk-regmap-dep-v2026-01-v1-0-d722c79506b2@baylibre.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>, 
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>, 
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>, 
 "Andrew F. Davis" <afd@ti.com>, 
 =?utf-8?q?Javier_Mart=C3=ADnez_Canillas?= <javier@dowhile0.org>, 
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@nabladev.com>, 
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, 
 Adam Ford <aford173@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Marcin Niestroj <m.niestroj@grinn-global.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Thomas Weber <weber@corscience.de>, 
 Enrico Leto <enrico.leto@siemens.com>, 
 "Derald D. Woods" <woods.technical@gmail.com>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Tomas Peterka <atheiste@seznam.cz>, Anurag Dutta <a-dutta@ti.com>, 
 Fabio Estevam <festevam@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=26003; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+pXEhw0In7X16wtFE0yrRBoxQvNkDm0abxRYq0g8rLc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzNspW345nX53f234l8mZfe+6k/UXe58AKZwzN/8tq0K
 z3ek/Kno5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaiupHhv5tawxOPLVqOb/2c
 X+c2/ebd5GjUfSBUwn/6FGbxjxYR4Qz/Iz02RERx1nueyrQO+VUm7n9eQes3V9jJDyc+v+s9d4e
 fBQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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

Add a Kconfig symbol for this stub driver to avoid clock dependencies on
an architecture symbol. I added the new symbol to all defconfigs that
would need it.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am335x_baltos_defconfig           | 1 +
 configs/am335x_evm_defconfig              | 1 +
 configs/am335x_evm_spiboot_defconfig      | 1 +
 configs/am335x_guardian_defconfig         | 1 +
 configs/am335x_hs_evm_defconfig           | 1 +
 configs/am335x_hs_evm_uart_defconfig      | 1 +
 configs/am335x_igep003x_defconfig         | 1 +
 configs/am335x_pdu001_defconfig           | 1 +
 configs/am335x_shc_defconfig              | 1 +
 configs/am335x_shc_ict_defconfig          | 1 +
 configs/am335x_shc_netboot_defconfig      | 1 +
 configs/am335x_shc_sdboot_defconfig       | 1 +
 configs/am335x_sl50_defconfig             | 1 +
 configs/am3517_evm_defconfig              | 1 +
 configs/am43xx_evm_defconfig              | 1 +
 configs/am43xx_evm_qspiboot_defconfig     | 1 +
 configs/am43xx_evm_rtconly_defconfig      | 1 +
 configs/am43xx_evm_usbhost_boot_defconfig | 1 +
 configs/am43xx_hs_evm_defconfig           | 1 +
 configs/am43xx_hs_evm_qspi_defconfig      | 1 +
 configs/am57xx_evm_defconfig              | 1 +
 configs/am57xx_hs_evm_defconfig           | 1 +
 configs/am57xx_hs_evm_usb_defconfig       | 1 +
 configs/brppt1_mmc_defconfig              | 1 +
 configs/brsmarc1_defconfig                | 1 +
 configs/brxre1_defconfig                  | 1 +
 configs/chiliboard_defconfig              | 1 +
 configs/cm_t43_defconfig                  | 1 +
 configs/devkit8000_defconfig              | 1 +
 configs/dra7xx_evm_defconfig              | 1 +
 configs/dra7xx_hs_evm_defconfig           | 1 +
 configs/dra7xx_hs_evm_usb_defconfig       | 1 +
 configs/draco-etamin_defconfig            | 1 +
 configs/draco-rastaban_defconfig          | 1 +
 configs/draco-thuban_defconfig            | 1 +
 configs/igep00x0_defconfig                | 1 +
 configs/omap35_logic_defconfig            | 1 +
 configs/omap35_logic_somlv_defconfig      | 1 +
 configs/omap3_evm_defconfig               | 1 +
 configs/omap3_logic_defconfig             | 1 +
 configs/omap3_logic_somlv_defconfig       | 1 +
 configs/pcm051_rev3_defconfig             | 1 +
 configs/phycore-am335x-r2-regor_defconfig | 1 +
 configs/phycore-am335x-r2-wega_defconfig  | 1 +
 configs/pxm2_defconfig                    | 1 +
 configs/rut_defconfig                     | 1 +
 configs/sniper_defconfig                  | 1 +
 drivers/clk/ti/Kconfig                    | 6 ++++++
 drivers/clk/ti/Makefile                   | 3 +--
 49 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defconfig
index e72a2ac2867751bb82e824eb453aba578be2ae86..6d5ce078595a3677e9ff81f9325cf78ee97b7aa9 100644
--- a/configs/am335x_baltos_defconfig
+++ b/configs/am335x_baltos_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_DEFAULT_DEVICE_TREE="am335x-baltos"
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 5a3e0530a31663faf565e0afeede5765be16985b..3df44d0d0bb5a37b0b79e769e56d43097995b363 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index 97f56f36aa6c5912bbd5fec7580cd1cd204bec2f..de397866488994d4ec169f0c67730c9551685ebf 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_OFFSET=0x100000
diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index 2cb73cdbb1d57e5c57de7a72977da4b84a5c0821..b4fe566fbbd3b8db8d78093378d231acb5c8432d 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x40000
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index e4eedd439c8a26052f57764059d660fbfabcb15b..42b74d6a9e42a5a57c01eec9037984d96a925f75 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=24000000
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index f60f63f87d7018e10840b27ee9c5afc179c1e167..53ed0cccf9d2d3d0b2e23d144d618e8d942391be 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=24000000
diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index c36658a1cfefb2189b78fecd6c70aef38580724f..0c3d436dbed18697b4c5b0e1e0ca2b7a32aec0e9 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/am335x_pdu001_defconfig b/configs/am335x_pdu001_defconfig
index 79101f7e6e4426e9791dcddb095b13fbf1b0b4e7..9c2f7954ed3a462ca3dab139ed14a3ec1dec7d42 100644
--- a/configs/am335x_pdu001_defconfig
+++ b/configs/am335x_pdu001_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SYS_MALLOC_F_LEN=0x1200
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/am335x_shc_defconfig b/configs/am335x_shc_defconfig
index 0e1fef8b72238ecb95d95473cca971abdcb76cac..5d8d19bdd4be50f3d3716b99ebb46fe9531eb4f4 100644
--- a/configs/am335x_shc_defconfig
+++ b/configs/am335x_shc_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/am335x_shc_ict_defconfig b/configs/am335x_shc_ict_defconfig
index 65d17598a02402fe3115ba8a15db75db356476dd..51ea07542b09ab99247322e8ed444545bf983a80 100644
--- a/configs/am335x_shc_ict_defconfig
+++ b/configs/am335x_shc_ict_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/am335x_shc_netboot_defconfig b/configs/am335x_shc_netboot_defconfig
index 1fb1518b4c35555d3a1a7dc30ea17287cbe0478b..1c5369944da739b4bc376f04c5076147cb1fb939 100644
--- a/configs/am335x_shc_netboot_defconfig
+++ b/configs/am335x_shc_netboot_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/am335x_shc_sdboot_defconfig b/configs/am335x_shc_sdboot_defconfig
index 05a371e92adc5457e6f3effa03f097c9eaf1d428..17a1928dd8552ccd0ab5c197d58d52779fd63ffb 100644
--- a/configs/am335x_shc_sdboot_defconfig
+++ b/configs/am335x_shc_sdboot_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 32c8e9bd39fbedd31e117096ed41b40c8ff17d17..cfd9f30b8265fa655de00aa4d65b56b87ed2da2a 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index 3980036659915ae70d25b8d75cfb51bd2f658f3d..0007f41867f76993e35022c66c1ab6b03e6e2783 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index e2a39eaa5b44961428ca45588a3e5368225b0b3b..46856855a0ac55d7f8626380ae7401fd1f4bea39 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index 7da9241aaa5e80996ad4dcde23751011a2f899e1..2c33968b7526cb9d364b45a0357984796fa87c7f 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 # CONFIG_SYS_THUMB_BUILD is not set
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x30000000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_SF_DEFAULT_SPEED=48000000
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index bd7631dd7824cd509676b6c64430a2c380700d1f..e08723981607ffaac6e3797899361b965ff4ae62 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index 3ae06f25c3c3b8830471bca14cd292f77198ab75..50c00bfcd7200a6155895a36eab2f16377457809 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index c95fc0886bf05ede276c4d4f42dcab76b658bdcf..5b706560e2048e2884358cc50ba2bd1438a2f220 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index cc444ac2817bafea7c4c15b5e02d96b8d5fc4a97..0ba81a5613cd87b451ae29e7f2654fc4c93ec701 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 # CONFIG_SYS_THUMB_BUILD is not set
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 629697ad757db16a364c95b7d4f1a776a00a5f9e..18a9a983ed6ef9175d84e1dd8536e3e4a51bbc24 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 6e4704470e849dad3ed2c0d08916c44691379bc2..c572ff40a007f4956cb88eb11e5f31984e715996 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=76800000
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index c3b6eb8c8976f93be5f99d1801fe29db19065726..069a004d7b941f487e57ee4aa3a87ca94726ae28 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=76800000
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index 309c26b21afec952ffc1674f9f743f4f4c9f09ef..e2eae765ebc10efc53b1e933513a3dc5c6ada28c 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_GPIO=y
diff --git a/configs/brsmarc1_defconfig b/configs/brsmarc1_defconfig
index c336b1f81f98ec24a3c65145a6ac4f69d56a8391..cb3a5bdc3db2c5fdd798e91dbf4a9c4208d3b00d 100644
--- a/configs/brsmarc1_defconfig
+++ b/configs/brsmarc1_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index c340b1a9083be0a3e103641987b52d316453d2f9..98851a02ebab9f5664e509c3099345020dcc4124 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconfig
index 46f31bf21ca279deed42a84fbbf77f72007e14e7..78ce3359753c79516e9e88802369b23591dbcddf 100644
--- a/configs/chiliboard_defconfig
+++ b/configs/chiliboard_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x2000
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index 471d6bd3f497e8661cb6bb34ada62414a00ca0f4..434051ca3283bf66cef6cd5ee07f81e887b188ed 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/devkit8000_defconfig b/configs/devkit8000_defconfig
index 90076485527a6afd9912ee90b05f3d0e8f90bb6c..afd5ea9e7cc932701bf4a296ba32a6813a640571 100644
--- a/configs/devkit8000_defconfig
+++ b/configs/devkit8000_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index 6dde2b484b805647633dee9d4a844d240c0dcd4c..dbcf1e1495539cf078af0d1a114e5382997578cb 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=76800000
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index 9b3085489519d24c0410ec8ca9f40fe4b02d8309..60d2751a869a3aa9f74be7d15c8e8bc2bd0e1d64 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index f80cfde75ab9d839579219d8326285f66c8a3a91..eed3bab82ceda2f5f5a47ecb71f97f554a476e2d 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index 6ead27127d6903186ea7232e0df06e35903b4373..08d45ccd275d92a097d7953b9ecdf80baa7d630b 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 4f31233f0462c2bab44f4b5671643143c53dd8ff..53ff6016878526b491cbd5852362bfc65bfd135b 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index 0fcd54cea746cc796543b1156a8ae046b589f259..ef1b26a94ec17a26cb5617afa3643287839215c5 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 682da1e1e2432159225a3d38562c0494173e0761..940004288d5695cf3d0b0070d1a3b16c445224ef 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_ENV_SIZE=0x8000
diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defconfig
index 61d8003af665ee80af26f2010e76e8d927fad718..e2a8c6543d68fe7cbac2e396054ce1e9fde5c1e7 100644
--- a/configs/omap35_logic_defconfig
+++ b/configs/omap35_logic_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
index ac792437a280827ed29dcf4354a318af66a9e21b..882d9602a8c9bc39f3bb2f9c700e43527bfd75a0 100644
--- a/configs/omap35_logic_somlv_defconfig
+++ b/configs/omap35_logic_somlv_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index f99798ac1a573c891cc323ac665caa929883a52c..19e745f1cf05a20f701d5777377780c229225aa3 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-evm"
 CONFIG_TARGET_OMAP3_EVM=y
diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfig
index 6eebb9cc4e14a3c752b1fa15a04fb80759cc67c7..6c8c90eef75432eda546cbce05fef52fe609c30c 100644
--- a/configs/omap3_logic_defconfig
+++ b/configs/omap3_logic_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
index f2b4f83ff19299268cc45a40561c163a69114b2d..989749c37af27731f465ae8a144f3a8cb844d971 100644
--- a/configs/omap3_logic_somlv_defconfig
+++ b/configs/omap3_logic_somlv_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/pcm051_rev3_defconfig b/configs/pcm051_rev3_defconfig
index 23d24cde086c851f179030b128937e5d7205ec1e..b834625a2a87c22da10bb11b399da1a749f30c21 100644
--- a/configs/pcm051_rev3_defconfig
+++ b/configs/pcm051_rev3_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_SF_DEFAULT_SPEED=24000000
diff --git a/configs/phycore-am335x-r2-regor_defconfig b/configs/phycore-am335x-r2-regor_defconfig
index 6e90318db862378b38abc1d6171819b2dfba1279..6a30899cd767d1c1c2aae6f59f85829c447bb5be 100644
--- a/configs/phycore-am335x-r2-regor_defconfig
+++ b/configs/phycore-am335x-r2-regor_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/phycore-am335x-r2-wega_defconfig b/configs/phycore-am335x-r2-wega_defconfig
index cb406bdca852d44708beff1726c830819c75af71..28a3e5d53d5d508758d857df90618ba0e68dc718 100644
--- a/configs/phycore-am335x-r2-wega_defconfig
+++ b/configs/phycore-am335x-r2-wega_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
diff --git a/configs/pxm2_defconfig b/configs/pxm2_defconfig
index 45d9813950c0af1c2c7f2c8f2f58cb38ede32570..a664d9a412a551334658da4c240fd393399bcf9c 100644
--- a/configs/pxm2_defconfig
+++ b/configs/pxm2_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_GPIO=y
diff --git a/configs/rut_defconfig b/configs/rut_defconfig
index 9e15fa00768775dfe6c8d32af7a42e57d768529f..537936247fe9cdd9ba7d7f2987448f2402c5c430 100644
--- a/configs/rut_defconfig
+++ b/configs/rut_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_GPIO=y
diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
index 3d0f555c63cc15d882285fa94bde92876581d6bb..5cb86df978614bbb7ad1e26141b66ea617f44ddf 100644
--- a/configs/sniper_defconfig
+++ b/configs/sniper_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_CLK_TI_OMAP4_CM=y
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-sniper"
 CONFIG_TARGET_SNIPER=y
diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index 7b8da69712e4fa61c15f3fb0cbdc9f3fd8de31bb..9b6829793fa87c91db3aefac8ea9cea8180c2ad3 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -10,6 +10,12 @@ config CLK_TI_OMAP2PLUS
 	help
 	  Common clock functions used in some TI clock drivers.
 
+config CLK_TI_OMAP4_CM
+	bool "TI OMAP4 clock manager driver"
+	depends on CLK && ARCH_OMAP2PLUS
+	help
+	  This enables the OMAP4 clock manager (CM) stub driver.
+
 config CLK_TI_AM3_DPLL
 	bool "TI AM33XX Digital Phase-Locked Loop (DPLL) clock drivers"
 	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 329fae67889b11a9ef3c646b166243abcb956144..74e4329a3430d66c11a3c034f1938c0804f4c918 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -3,14 +3,13 @@
 # Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
 #
 
-obj-$(CONFIG_ARCH_OMAP2PLUS) += omap4-cm.o
-
 obj-$(CONFIG_CLK_TI_AM3_DPLL) += clk-am3-dpll.o clk-am3-dpll-x2.o
 obj-$(CONFIG_CLK_TI_CTRL) += clk-ctrl.o
 obj-$(CONFIG_CLK_TI_DIVIDER) += clk-divider.o
 obj-$(CONFIG_CLK_TI_GATE) += clk-gate.o
 obj-$(CONFIG_CLK_TI_MUX) += clk-mux.o
 obj-$(CONFIG_CLK_TI_OMAP2PLUS) += clk.o
+obj-$(CONFIG_CLK_TI_OMAP4_CM) += omap4-cm.o
 obj-$(CONFIG_CLK_TI_SCI) += clk-sci.o
 obj-$(CONFIG_$(PHASE_)CLK_K3_PLL) += clk-k3-pll.o
 obj-$(CONFIG_$(PHASE_)CLK_K3) += clk-k3.o

-- 
2.51.0

