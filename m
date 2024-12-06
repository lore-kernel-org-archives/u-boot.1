Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CABE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E0D389620;
	Fri,  6 Dec 2024 16:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZ7slZoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46F98964E; Fri,  6 Dec 2024 16:41:21 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 599768962F
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53dd57589c8so3597489e87.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733499679; x=1734104479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rU8/tP36VcgHAd3jM8zKuCejK5M7FnlI/7SA5C7uPvg=;
 b=ZZ7slZoFSZf+vL6nSmC+WrknSyZU8QsHrGjlLG16/quvmPRTJ1aMjVGetJU02RtoVS
 z0Gd4CCH7L7s+djSAX1pTTcA6Yw6gelGNWV6wno9l1EQQrNyB+uEHlWuSBz1dlvamIlq
 wSfYAuPEOsadQ/t7xwqLbsyLCWSZQtU6Qof3OlshnBqlme+sUImHhyiDeyDjxHJYlcsy
 MTkFZs3yysuoMH0FhBcvxjTadbFn8YU1HpoT3Y0/SNfs+ZxTSZSpkLcfNmgNq/Pxz+O9
 t7SuSKhADzlnRzVQzFYngXMlVIg6Ng+VNGf1UTZY8Ja8lJR7nBtjT6A0tTj8F64Yt3gO
 sGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499679; x=1734104479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rU8/tP36VcgHAd3jM8zKuCejK5M7FnlI/7SA5C7uPvg=;
 b=fQOmmhiIOGWZqUY4JXwt2axN9XpgX6iXJU6pnqpyjVU0RLtvRpXytVBeSbW02mHuz8
 gtWvymRhTHr6+Vh3/tQ3j1gYyGsFqV2KeAVAC0+lggn2AVwO6wWSOSpmSDVdu2sYJRX2
 jgP/mO71vc+Ci+DklSrjZZhNWjUGH71B+VY9Znjhq8tEsBrJyb1Ofmb75mtzp8HXjshT
 ob/8+sh2zexzLsRhTnx2IAAR1NcTF9yayRJDlj1alRvPWKBEhFm2rb9t5tXkLF9hn0BY
 I234d+kUMyEHihEjvQUHh6RYPryJLBAP2NIpPx+a2zAO0VPp+dyq5A0SaoLrc1eLfyFf
 +Udw==
X-Gm-Message-State: AOJu0Yxlx5iGKdwOP55Y1/t/J7/oz76R2iwxQDJ5WkTxkAzDlTgrMh+c
 uFkR/CGpjYdTu5b9BApab5COHtnK8uTjjRFUv/LAyKM0DCozExOg
X-Gm-Gg: ASbGncu3cfyVsMW9HCAXVOjjG5A/1xFrl+lENi9FqoviAt95OXyYgvtY3DqGwZZ1A2J
 xzxQiJw5BL/Xz/OhApiu3Y33oBzNAdBmJsHQOuyzbJ8NjpgDbR2xioQWuUPqBPSriqCdOYf9wOn
 OHdWaeitBNdUzmPKTdDqUN1DiyRuWe7KrJnZCXRY5GXmLYcdhC6TYmOg7w+iTNZ9IaF5YcE2iDu
 BGiDM35l6EwMEycMt5uBt/q1sKMeaZrSFC85bDG
X-Google-Smtp-Source: AGHT+IEA1ZPDFqR27C3215V3XSVYl1OWastIdzdLI48wnq4R4KcYGwZXDfSEXTdj1rwPJK7dOEvshw==
X-Received: by 2002:ac2:5ed1:0:b0:53e:2bdf:4f6c with SMTP id
 2adb3069b0e04-53e2bdf5878mr1038139e87.16.1733499678439; 
 Fri, 06 Dec 2024 07:41:18 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e34a49561sm154154e87.83.2024.12.06.07.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 07:41:17 -0800 (PST)
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
Subject: [PATCH v1 1/2] gpio: add PMIC_GPIO Kconfig option
Date: Fri,  6 Dec 2024 17:40:49 +0200
Message-ID: <20241206154050.48353-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206154050.48353-1-clamor95@gmail.com>
References: <20241206154050.48353-1-clamor95@gmail.com>
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
index 92a8597420a..b7a3dd7b221 100644
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
+	bool "PMIC without exposed GPIO node"
+	depends on DM_GPIO
+	help
+	  Choose this option if your PMIC does not have dedicated GPIO node
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

