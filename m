Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31277CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C3083966;
	Thu, 30 Oct 2025 14:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gQnR1Oj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E447800B1; Thu, 30 Oct 2025 11:01:36 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 569558394A
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475d9de970eso6001885e9.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818494; x=1762423294;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6e0rvUi28lAVZt+mOqv0GqCQ1sydQkJc2CFpDaElLuU=;
 b=gQnR1Oj1ylK//vkZSsO/MMu8hnNixtS8+lz2PmW5SHFU/hDUAa/MHReLl4n4DG+pgy
 t+FM5xPr1VxBwjH2UQOSo7uJ3aaNB18nSJ/0EUMRSxMK46X2ef/bwcsmbKqwzC3bF/Vf
 t/htlE4X8+TVagagkmx3IMJuudYumTxzuo/t573D323DaLlc5O0BNdXtU1Mnnvx37jt5
 VRBQkTMqRoImtOIKyJkFV5xa2vtbC6quA6uJjM06WZKY/j33XuJZ97bK45lh/iwi2HBH
 y1SwH2qfOnmexrjN6MQaY/QDX7J/pKZuOjhv50h+Eo9EHjUusgmo+DqziBf2jYD4f7Ik
 e1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818494; x=1762423294;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6e0rvUi28lAVZt+mOqv0GqCQ1sydQkJc2CFpDaElLuU=;
 b=iC5VsDjoNrZejP5agW+KKu/BZvC+gFQD+IdZ8TApH2jcJrScKPGWi3R3sAErpYg6AH
 7DHJBn/3k90hUMY5E5RIxVCuv9VU7gV/fZIRCJwlqQq5aYWpvh7LMrb/P1FEdRmbuVJK
 1DaJ/IMewiFvZjudLa/hsGv3/GHFMAVr45aUCJA1FVHAn+/hoR+4fhDfixHz5kDmzKwW
 rVcCMv+7h9zHLFN5is+AK5EEI0TOy9AtGr/P2UaE1ZMsb6Sk0OezYT1zwrzf+yws7iv9
 yCuuQouP3iqpsF3FId1UywqQuks+fj/syLjplf7X/45b0OLxFbeRMC+RnHD1CYqYGpak
 x5ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwXt0u7/dQkWVnPnV2BP8vnRNI4M6gPi/Uk4q034kjavTntq+1YrHYEFjPCswcFBWPw4rKL5E=@lists.denx.de
X-Gm-Message-State: AOJu0YznLGe8kkcDa5afZA+Ccv/4rKBzhI4piHXCJqO3RLMCwb0If0BV
 GfE85Mx/w1J48gSOcGWMipA/vTWXxofKAiykyArLd5OAcRpQeJpmnm4P4+ONZBpTWQg=
X-Gm-Gg: ASbGncvNfOE7ReYzAp4gv8oURWYJJgL6Nv9RgN/QQZGuCtFrgj4UYMPg+SnA5zX8nVw
 1vDLIoUl84ISqLIz7XSFg6qxMkm/7J7mt+TR68B2Qd6IUzSSNMGoG77YJzpB2BM/GsvrqvD8PzE
 wuSVnxgA5TsXuQlu2IAtxBg4hOC10CVB0beurrMDmJom0id/AnUD+JHe3bGC4RAnbtvJGPrV6To
 twtl1lpuEp2dZ1E8NlUiijwGbUEBnPdl+HiyjJ0B31ToSW0jY7ow580R7uC1fhanRW7uWwWJcEL
 9ZPWCSeU0/RTUDNUN6FxRw07VbQ8ppwX5XLYXxpriBCgL/8k+YlJxRCnmVoBS/fkEA6pZ1RIl8q
 zWRfKfVhHYY/3/lUTL2py9aKRjN9KIH3aU3UP6a7yNhYuOqD4fxnU2mqkH5gpgUmVA7C7NnfHUX
 hCBPQ3RNgI
X-Google-Smtp-Source: AGHT+IHIqK2BHjsirtBIefcO2NRxpxVyodsCia89P22FjNNQdlMqj/OPPQiqOlmgN+qczuPpZ5wFIA==
X-Received: by 2002:a05:600c:5187:b0:471:747:2116 with SMTP id
 5b1f17b1804b1-4772ca96f7cmr7706965e9.41.1761818493662; 
 Thu, 30 Oct 2025 03:01:33 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47728999a4bsm30166735e9.2.2025.10.30.03.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:33 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:23 +0100
Subject: [PATCH v4 05/13] arm: mach-k3: common: Add CANUART wakeup check
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-5-4cef18af0226@baylibre.com>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3213; i=msp@baylibre.com;
 h=from:subject:message-id; bh=VnwBRk5RMCA+hpg3h7PhAsvgtoMrLVb73bQZgjxA1hc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmc/mOkL5VGVc6tn3ottxwVDZGZx5PavNu3m88FcVBx
 m/ObT7UUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABNJD2X4n5XMIeVUV6W/qsZ7
 8TrB7J2/ozqsWvR+dRZLvb9X488+mZHh5sXgtAmlbwWe8N1PKdhymMenjfXT3Vxzhmm8zY9V+O7
 yAQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c                | 22 ++++++++++++++++++++--
 arch/arm/mach-k3/common.h                |  1 +
 arch/arm/mach-k3/include/mach/hardware.h |  3 +++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index b4a605503d27b29d0fb962fbe4c94650a1f6c54f..10964417295c1b3b1e0a36e03617cf1b32d09b97 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -164,13 +164,31 @@ static void wkup_ctrl_remove_can_io_isolation(void)
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
index 49417679e2ec7210d5c95540f476a5d8ee548617..b7dd52fd1792cb6e3eab5c9f3863f983a8ac08df 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -52,6 +52,7 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
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
2.51.0

