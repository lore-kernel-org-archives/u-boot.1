Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A632EA8128
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1694D83DA9;
	Tue, 10 Feb 2026 16:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BT0ox0le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F6C83D9F; Tue, 10 Feb 2026 16:15:26 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D5383CF2
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8954c181830so37397136d6.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736523; x=1771341323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZV/BhhLI5JPybX5GYaA/r6ogdk290irrIQHF+qAJrwA=;
 b=BT0ox0leG6b+jmj/V6egYL+8pQwLYLNbjz2o87AD4vMnGxe/FzHAEWmerUEogjxeLE
 kQmlB8yP4iQ0VeAmQoZ14rrJ2VYjnygFADUTI1VONtiqjg6AWPLVleAm0TnZtnBNf8tA
 z4Z5HbcXK5FGwZIfs82ynPYSoKVwTsOeG4OPSk2A3bur5f3NERVcdo/OoWnHXy98vDEb
 QvkGA9l6MLC42BD+Hx28ZLFMrEfXPfxPa6YoAP5NyToYlunl4b5gdtJ7lTdyT5djcxeB
 rDqdKuURvlFmftfhezXIU9kP4Xc5h0FsvOjiKSEIgovxhHpbNl1hWJjiuetqaeEGouIj
 BxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736523; x=1771341323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZV/BhhLI5JPybX5GYaA/r6ogdk290irrIQHF+qAJrwA=;
 b=SZZdyaWhHweMKU0iR8somBpLb0NhZh/MEPNgcm5WnwZU5eoYsSpUKZyQLJR7SUBawv
 88qHfgSCz7oEMGJCLYDr4SCt1TRaeVyiTmuPx6hgmWvt/4+EzkK1mLwKdGXSC7826Qe2
 KFThdgzaWrLR0QJ7pj2BdvZbz0+yKgWVhwHKndryN9UzF6d3Ne4kxiqkZv/jNCXueQRi
 l+cboh4qJGjMPHhz7GsNI80tZaHnIdjUqYDH7Np5D/tcugN6vEbz7f7ebUCEdJqv9E1f
 Z/EisTb/mOtN5Y/5RbXeCdVrHneo738KOU5m/TP+KIxlYMZPxzPlLTUtCvOM3YQQQ4XO
 mr4g==
X-Gm-Message-State: AOJu0YzWqwpP+M7VEy2PBwlww9r3FyLTnfvApZ3nmKrvLMooh7zTLoBq
 NRUzwJkCAHIsyxlhdy3yGIHLg/y2gFvmtYNT8w2T0cgxAsxC95p2G2fP41MKjA==
X-Gm-Gg: AZuq6aLryZz4OqDeHxc/qmQjWaVg4fw1bYVdBugZA7U6WltLr9wMC/6Wxvg0g/i/PYG
 JjbVgY0Mxwni12SVF8f9JA0UKBd9UYE2FY2IP1TepfMHD4s1zjfHmfEDVVLa1KeiXCgmehOhBwj
 CpLjHLD+hZ3eSIeqJfmrZeLm/iyCj2sTD1MI/9cymnSC5V65J93aAKKimwsA6D7CbGiOKEhT4Bg
 nkU08Iz7MMQ53fkNksiSTdty5vqudgpRTLD+jaxJ2k8+C84F/o/f1wluKYkpYAoBMSrXpEFLbAV
 i5Mn9b0KHI/FBfyvnEBlIPMlMkrYP+8HQwyIQQRN3piEBgPfhGMABuKJ9raZBYiCq8cCJV/biTJ
 SK+E48K0mli4K4sjSTWOWq9Pcm2v2nyE7nh/ZRyFHu8s6ybaTW+IRewh5TpRTWArB3xVxToNsOd
 brZkuZEN1tRdh9n1Y8PIIYgD9VULjru+fxNmNqMGVwZlqL6UaM0fBjgrOukCQZkzDKiQdOBb+ri
 jrih7PeRiY=
X-Received: by 2002:a05:6214:21a8:b0:894:687e:3fce with SMTP id
 6a1803df08f44-8953c7b0b17mr206882716d6.3.1770736523110; 
 Tue, 10 Feb 2026 07:15:23 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:22 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 04/16] reset: k1: add SPL support and enable TWSI8 reset
Date: Tue, 10 Feb 2026 10:14:47 -0500
Message-Id: <20260210151459.2348758-5-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

This commit enhances the K1 reset controller driver:

1. Enable SPL support
   - Select CONFIG_SPL_RESET_SPACEMIT_K1 for SPL builds
   - Reset controller is required during early boot for
     proper hardware initialization sequence

2. Remove TWSI8 (I2C8) reset restriction
   - TWSI8 is now fully controllable by reset controller

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 drivers/reset/Kconfig             | 7 +++++++
 drivers/reset/Makefile            | 2 +-
 drivers/reset/reset-spacemit-k1.c | 4 ----
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 74c267dfc4e..1e69024ce74 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -252,5 +252,12 @@ config RESET_SPACEMIT_K1
 	  Support for SPACEMIT's K1 Reset system. Basic Assert/Deassert
 	  is supported.
 
+config SPL_RESET_SPACEMIT_K1
+	bool "SPL Reset driver for Spacemit K1 SoC"
+	depends on SPL && RESET_SPACEMIT_K1
+	default y
+	help
+	  Support for reset controller on Spacemit K1 SoCs in SPL.
+
 source "drivers/reset/stm32/Kconfig"
 endmenu
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index ee5b009d134..ec6893b1c45 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -33,8 +33,8 @@ obj-$(CONFIG_RESET_ZYNQMP) += reset-zynqmp.o
 obj-$(CONFIG_RESET_DRA7) += reset-dra7.o
 obj-$(CONFIG_RESET_AT91) += reset-at91.o
 obj-$(CONFIG_$(PHASE_)RESET_JH7110) += reset-jh7110.o
+obj-$(CONFIG_$(PHASE_)RESET_SPACEMIT_K1) += reset-spacemit-k1.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
-obj-$(CONFIG_RESET_SPACEMIT_K1) += reset-spacemit-k1.o
 
 obj-$(CONFIG_ARCH_STM32) += stm32/
 obj-$(CONFIG_ARCH_STM32MP) += stm32/
diff --git a/drivers/reset/reset-spacemit-k1.c b/drivers/reset/reset-spacemit-k1.c
index 613e002fc4f..99dce90b4c4 100644
--- a/drivers/reset/reset-spacemit-k1.c
+++ b/drivers/reset/reset-spacemit-k1.c
@@ -452,10 +452,6 @@ static int spacemit_reset_update(struct reset_ctl *rst, bool assert)
 	if (rst->id < RESET_UART1 || rst->id >= RESET_NUMBER)
 		return 0;
 
-	/* can not write to twsi8 */
-	if (rst->id == RESET_TWSI8)
-		return 0;
-
 	spacemit_reset_set(rst, rst->id, assert);
 	return 0;
 }
-- 
2.25.1

