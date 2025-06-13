Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9DEC71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B06882D5E;
	Fri, 13 Jun 2025 15:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tUqkR+CD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C1B682D09; Fri, 13 Jun 2025 15:22:02 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5AA82C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ade5ca8bc69so307875966b.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820920; x=1750425720;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9itjDF6cQawQt59GAIrLxI8NX0vSob/S1mtSUzVzebo=;
 b=tUqkR+CD81NV2vgAmHgO/IhIPUeRV/d/aGDM/WMDElk/sp9Eb2F2anuiNUcWN0gZBZ
 W6B6I7l2uXjS5QE/9njMizBCkn0hDmpmGZ6U38K7KS4ndclS4JEgtbilJ6QkYhXnlwCR
 2r49F5Oc9GJ/k8pcVJOJwNjWphpj3XNA1oIlkUN/iZBGk62WYjCRsuo3l9GwEuP4wJu+
 EgPVI7DBH2sb5nyps/0m8QJ3RKD1Oc4UgRrvt4mh7kOb3QZeMkQLDe7uDI5HBlGF0HVO
 kx0yiXdydd6OsGlq7t4RAHsoVIeIqfC7rcNkWLdO45/Oy8IJWmLxl3IudKBg/E7M8nYu
 f0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820920; x=1750425720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9itjDF6cQawQt59GAIrLxI8NX0vSob/S1mtSUzVzebo=;
 b=SvsVSzytiWeekOscxbtimxYlDIDHNbNEvpsnXLelut+VeuiGAMuwMW5Yp/KImq3yvZ
 eGH/3ar9dkDJ07XtvkukMmpo4vLA/vvdrXFeekZ8NDaTZeyyeQvaDuXCm1UNKnDt8zSS
 OLYXClo1DLj3O1IeXCaxKoGGAhKHdfZS4smF8kGuDf6P8ruxXxJ/l4TG7msIKfP2b0qG
 OQrntPrTyiMwm2VVGG3DWXDCrXbtzrKfBtNrzg7RUKgZAgR1lEg+svdMYz7zglHyWZnP
 UVEg8Qbv36E7FIuj8GZ/dAYxPQI4GUqs63yg7NldY4LUaud2HgRo8BuVfeYPR2Cn/otx
 1HEQ==
X-Gm-Message-State: AOJu0YwyHNr7NBf8w+Iig5WAVlWS17bI2err2/z2C5INFmzuUKGWjg1R
 huZE7jW2YLVK99P2+PCw834eNBAa4nFOsi6jgBD8FPYreNQMDWxd7UF+vf3i4bLbgVwQU4wFU+g
 hi+/t
X-Gm-Gg: ASbGncsQxXuLWDBsZHDvEdalMSzM8SYPjQ/8U52lYuOUGeKz9A/LhxuIdIDfo3tLdqj
 pCxqMbjUFdYaQqfDj/3GdaJ7W/d1A2EC6wY4/6QSPZ5zAG4JsUoB1hXxQDobSDwkIKCyzU49a84
 /pJvlkfLLpHLOwsspAdwFapzTWYEoRt5cs+TxvZwXupiuv4V7PCXIMhm1uOc7l4axScfgAbLXyu
 UmHVNxPGLd8GBV2nDcZ4bws7WXrsIxUF+Oqw6KXQkE2Lu2zU/4d1W2FY2uVb41VN/B/m6izn/lm
 E8MvP/1O7Hscs75SDmRYX6NrsBgu3sdpKzVzX43SsJYYt/XN7RYfA4aiQjs=
X-Google-Smtp-Source: AGHT+IHhANLOYhwJlNdg+otcFP0gMDSxjNiZAi28r5svlYEX+S5o/CWAGyA9Z9Bjoj/y8lE8FveUzA==
X-Received: by 2002:a17:907:3e0b:b0:ad5:5b2e:655b with SMTP id
 a640c23a62f3a-adec5bc4c00mr307222566b.25.1749820919609; 
 Fri, 13 Jun 2025 06:21:59 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec88ff430sm127574066b.105.2025.06.13.06.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:21:59 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:25 +0200
Subject: [PATCH v2 05/22] arm: mach-k3: common: Add CANUART wakeup check
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-5-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3218; i=msp@baylibre.com;
 h=from:subject:message-id; bh=I5fwC4JEssVMDFB/cDZ7o23ns8Z1itUwQ/13Q3AW1gc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1d4t+RFnj8x5uvVY/aU+15M12V0Hlt95yrKp+OPq2
 IDIwt4bHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARwQ5GhudewW9S82/w9rt/
 K076vcvmdPCD6vXan36s+dLQY/EvLZmRYa5ouebLp207W9Sfdv/w03ResHTu1eNf8vWre/fPfM2
 wmRkA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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

Add dedicated helper functions to check CANUART wake registers and magic
word. This helps determining if we are in a wakeup or if CAN IO
isolation has to be removed.

Also add a helper to detect a low power mode exit/resume.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c                | 22 ++++++++++++++++++++--
 arch/arm/mach-k3/common.h                |  1 +
 arch/arm/mach-k3/include/mach/hardware.h |  3 +++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 517065bd3a18a5d28270e9cf2f552afa8acb1ed6..9ee47732929dd08f77aefb2f0d65ac93c79d25a2 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -127,13 +127,31 @@ static void wkup_ctrl_remove_can_io_isolation(void)
 	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_GLB);
 }
 
+static bool wkup_ctrl_canuart_wakeup_active(void)
+{
+	return !!(readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
+		WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool wkup_ctrl_canuart_magic_word_set(void)
+{
+	return readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT) ==
+		WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
+}
+
 void wkup_ctrl_remove_can_io_isolation_if_set(void)
 {
-	if (readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
-	    WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE)
+	if (wkup_ctrl_canuart_wakeup_active() && !wkup_ctrl_canuart_magic_word_set())
 		wkup_ctrl_remove_can_io_isolation();
 }
 
+bool wkup_ctrl_is_lpm_exit(void)
+{
+	return IS_ENABLED(CONFIG_K3_IODDR) &&
+		wkup_ctrl_canuart_wakeup_active() &&
+		wkup_ctrl_canuart_magic_word_set();
+}
+
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data)
 {
 	if (strncmp(data->header, K3_ROM_BOOT_HEADER_MAGIC, 7))
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 390a6fd41f6a30c9e7837342deb000d308fd802d..b3c1702b8125d0c8248ac15dee4387a807b516d6 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -50,6 +50,7 @@ struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
+bool wkup_ctrl_is_lpm_exit(void);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index d7c759420524faf48ea26c66607c6a899d1321b3..e4e7dd61c0689db11083b81f2e74ba8bea74577e 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -128,6 +128,9 @@ K3_SOC_ID(j722s, J722S)
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
 #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
 
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
+#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
 #define WKUP_CTRL_MMR_PMCTRL_IO_0				0x18084
 #define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0			BIT(0)
 #define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0		BIT(4)

-- 
2.49.0

