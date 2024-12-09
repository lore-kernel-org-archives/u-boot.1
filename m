Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22FCE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 06:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7210B8939E;
	Mon,  9 Dec 2024 07:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J5iK4L0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072E1893A2; Mon,  9 Dec 2024 07:44:38 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81FCB893ED
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 07:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53df19bf6a9so4640192e87.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 22:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733726675; x=1734331475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02ykoA1CHSp+J1dasYCFNY3hEXkRu0aL/GnCzNF9r+0=;
 b=J5iK4L0f9zgg4Cczp3CoVDAk/JbVCGnaLvTaG2mVXJ0hr9p86M7LahFrPXCdjeFN2M
 Yb+sOGtZByllFMipAtvYXtQS6dJaiCdgjweTe9LYQd6BBvrZ/Hbh0VeUVRYY9hgf9+9u
 7efGx5n0pP7WZc7FHrGNmAERo1Dj1tsznGUTtTx2Nx5kH62imuvdzwdw5NR0ysGSDDn/
 5G6o+tLirgOT88paIpMsSIGbAiXzN6BRTnnNzuaEiE3NFKmx+PAFD4pR4Up6Uq9lEM+J
 eVthxwk0CJTizra2Eei3YMVkb+20JuAW9J/gDdDCHxB/f2ZtmaVTneqQD1hHRFyFdioX
 id9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733726675; x=1734331475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02ykoA1CHSp+J1dasYCFNY3hEXkRu0aL/GnCzNF9r+0=;
 b=fAusm7X+Wmo41fqS14lZ8th4gTMKYtnFZA+b9xJHW8CWFxVwYrh0PwjKkYSiiXwTwU
 92Ab4BPJZPjIEz8OLptvMfpkFsXHnIRFsy/QWhX+KO6+PaWIXRUhwOsrNIGA9DYuvSz+
 WqrCnOdgdGyFm0ujMODL0OHtaIgPBezr6h1tsSkhUXhHgZ4g8W13/BWEliBgNyHglgzc
 M0Sjnj6PNInYqvj0USADx1GEmwBordQ47oICKg00B+SYPz9C+BFfQPPF0AegzGyCzKwl
 okFdxpUZmmWyh0wRgZQXvWxzG9O2NBzg+jfe4mgR7u4qGkbUP4EIrM9IS1DIiC/EoUhh
 0neA==
X-Gm-Message-State: AOJu0YwWJBoh46vQPzImBSVTWU6HvrAoGRXt6PHTzTk9Paat6FDInbV7
 NYVVHUFbWnuIMEVCrfvLl51gcIjuC1gV/4YTcgMWgAjZ5T6Q31AW
X-Gm-Gg: ASbGncsoVXYW23ZR3qVenmZJrS3VoKQzzDMk1VDj1Rb4BtbyZipfc5muTf/9JZL22BF
 svyYCLHV31J+MencDy/7dLkM0SsOXaZZJKRW2aY4nJWuQk6NRLZqZvWEtB2Smgntt62mf/m80IA
 Bmy3bDTMUyAwX/Y76YAfXzfKzVlffHMc4DNlNPgsb20xhV+JNmPVgwTeuSQCCD+JxpanGa86LlK
 wxeWQeWdwf4PijTexeh+HLIfgUHIiFbTiw4vfc/
X-Google-Smtp-Source: AGHT+IFRlObjvcRYPQsPfqiej/QH6IdGgOtg/YakvtYoTAF8dXlMdCEQDS+kwvUPnWx04gXpFkiW2g==
X-Received: by 2002:a05:6512:124f:b0:540:1e75:4be5 with SMTP id
 2adb3069b0e04-5401e754cb9mr1030394e87.46.1733726674624; 
 Sun, 08 Dec 2024 22:44:34 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e313bfb40sm951527e87.222.2024.12.08.22.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 22:44:34 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Ye Li <ye.li@nxp.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Jim Liu <jim.t90615@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/2] gpio: add PMIC_GPIO Kconfig option
Date: Mon,  9 Dec 2024 08:44:11 +0200
Message-ID: <20241209064413.6282-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209064413.6282-1-clamor95@gmail.com>
References: <20241209064413.6282-1-clamor95@gmail.com>
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

Add more generic Kconfig option to be enabled by the PMIC drivers
which do not have dedicated GPIO node and use same phandle to refer
to both core driver and GPIO child.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/Kconfig       | 8 ++++++++
 drivers/gpio/gpio-uclass.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 92a8597420a..13b7e9a53dd 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -255,6 +255,7 @@ config MAX7320_GPIO
 config MAX77663_GPIO
 	bool "MAX77663 GPIO cell of PMIC driver"
 	depends on DM_GPIO && DM_PMIC_MAX77663
+	select PMIC_GPIO
 	help
 	  GPIO driver for MAX77663 PMIC from Maxim Semiconductor.
 	  MAX77663 PMIC has 8 pins that can be configured as GPIOs
@@ -474,6 +475,13 @@ config PIC32_GPIO
 	help
 	  Say yes here to support Microchip PIC32 GPIOs.
 
+config PMIC_GPIO
+	bool
+	depends on DM_GPIO
+	help
+	  Select this option if your PMIC does not have dedicated GPIO node
+	  and phandle of the PMIC itself is used as a GPIO phandle.
+
 config OCTEON_GPIO
 	bool "Octeon II/III/TX/TX2 GPIO driver"
 	depends on DM_GPIO && PCI && (ARCH_OCTEON || ARCH_OCTEONTX || ARCH_OCTEONTX2)
diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 0213271e3a6..e776906fe73 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1142,7 +1142,7 @@ static int gpio_request_tail(int ret, const char *nodename,
 		ret = uclass_get_device_by_ofnode(UCLASS_GPIO, args->node,
 						  &desc->dev);
 		if (ret) {
-#if CONFIG_IS_ENABLED(MAX77663_GPIO) || CONFIG_IS_ENABLED(PALMAS_GPIO)
+#if CONFIG_IS_ENABLED(PMIC_GPIO)
 			struct udevice *pmic;
 			ret = uclass_get_device_by_ofnode(UCLASS_PMIC, args->node,
 							  &pmic);
-- 
2.43.0

