Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD9DC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 23:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E0E877C7;
	Tue, 12 Dec 2023 00:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZXBi1EnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973BD877C8; Tue, 12 Dec 2023 00:21:47 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F94877A9
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 00:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b9e2d50e61so3306717b6e.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702336893; x=1702941693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HF8fBHR/6AzEi0G7QM1eJ1umr8wAFHQApw15e/f+Vfk=;
 b=ZXBi1EnL9ye6YvzY40znXrC+U8x+xyhxAb3JN8ioKO6xDeoO0wEot0vTr9ICg1UeOu
 cngAe1XmJKeYntapAsgD2xC8nFeYNGZ9zsLOBRzn49pmDyoAtDF6tMy7s3RFrhHxmi92
 cHIsShr9gXGD0GgMuGBG5tFWG8qifLHtkI1B55FHBdnF3qk2CmOeqFSB89MTIRZdrtB1
 SO+EFyT1j646gehEKrj77wRxc0+75fxd10PWV+14wqcNwyctIDvJc0xlFf16SBWHrZOk
 t8W8g/xJpOQc4ovFAS3Fgx2AcsKet+S/NCnit1jDLFWJv15HlP6qHr305iiJqQKr14uU
 sLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336893; x=1702941693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HF8fBHR/6AzEi0G7QM1eJ1umr8wAFHQApw15e/f+Vfk=;
 b=GoADNUWRVMZYQ2XkMCSpI3h9137iZ/ajyQWEXsPx9Wma52+hklbCoWY/N62nv4qj4N
 s1ug1Z8kxgDKNkqWxajyvWhP9xfqD5i/mfGw3bMWJroa7j/CWIFKWRyPRK6TdSIy+zNj
 7RKyYsIvU1wGji6sZgHRkTawypq4txCxT5bvqBp9m6w4nBuBbADHTM7iUi+YuaXXQ4S/
 QNv6elw/8vhpw7bIlkK+jgDyWH18p0rUfpwZb1XCp5f/uEJBKmzufurTLTEdvkty+BWz
 ulawN9Ro0jDk1hkbwQ0oWOfqVGC/YaCPP1d6U5vTwCHFHIDUs2XokRa8ETEjxGaEkHQ6
 pIsw==
X-Gm-Message-State: AOJu0Yw4V3sglxzhcJD376MnmO4AckjUl4Xm9M5/OhzT4CFr3Dp/soOy
 Z5erNDDlpby4AzrrEw3289j0kPGvV1U=
X-Google-Smtp-Source: AGHT+IFTIcXE2/6xS1qfHEANus+tAeXJp8aRsX56EIS8sO8BUtqdSCMx/qyfr1sJjI7GlY+NHgzboQ==
X-Received: by 2002:a05:6808:1188:b0:3b9:d863:50ec with SMTP id
 j8-20020a056808118800b003b9d86350ecmr6926886oil.15.1702336893722; 
 Mon, 11 Dec 2023 15:21:33 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bl11-20020a056808308b00b003b9d0371517sm2059617oib.28.2023.12.11.15.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 15:21:33 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 3/7] rockchip: boot_mode: Allow rockchip_dnl_key_pressed()
 in SPL
Date: Mon, 11 Dec 2023 17:21:21 -0600
Message-Id: <20231211232125.171438-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211232125.171438-1-macroalpha82@gmail.com>
References: <20231211232125.171438-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Update the rockchip_dnl_key_pressed() so that it can run in
SPL. Also change the ADC channel to a define that can be
overridden by a board specific option.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-rockchip/Makefile    |  4 ++--
 arch/arm/mach-rockchip/boot_mode.c | 11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 1dc92066bb..ff089ae949 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -15,13 +15,13 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
 
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
 
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
-
 # Always include boot_mode.o, as we bypass it (i.e. turn it off)
 # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
 # we can have the preprocessor correctly recognise both 0x0 and 0
 # meaning "turn it off".
 obj-y += boot_mode.o
+
+ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
 obj-$(CONFIG_MISC_INIT_R) += misc.o
 endif
diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
index eb8f65ae4e..d2308768be 100644
--- a/arch/arm/mach-rockchip/boot_mode.c
+++ b/arch/arm/mach-rockchip/boot_mode.c
@@ -38,6 +38,10 @@ void set_back_to_bootrom_dnl_flag(void)
 #define KEY_DOWN_MIN_VAL	0
 #define KEY_DOWN_MAX_VAL	30
 
+#ifndef RK_DNL_ADC_CHAN
+#define RK_DNL_ADC_CHAN		1
+#endif
+
 __weak int rockchip_dnl_key_pressed(void)
 {
 	unsigned int val;
@@ -52,7 +56,8 @@ __weak int rockchip_dnl_key_pressed(void)
 	ret = -ENODEV;
 	uclass_foreach_dev(dev, uc) {
 		if (!strncmp(dev->name, "saradc", 6)) {
-			ret = adc_channel_single_shot(dev->name, 1, &val);
+			ret = adc_channel_single_shot(dev->name,
+						      RK_DNL_ADC_CHAN, &val);
 			break;
 		}
 	}
@@ -73,11 +78,13 @@ __weak int rockchip_dnl_key_pressed(void)
 
 void rockchip_dnl_mode_check(void)
 {
+#if CONFIG_IS_ENABLED(ADC)
 	if (rockchip_dnl_key_pressed()) {
 		printf("download key pressed, entering download mode...");
 		set_back_to_bootrom_dnl_flag();
 		do_reset(NULL, 0, 0, NULL);
 	}
+#endif
 }
 
 int setup_boot_mode(void)
@@ -90,6 +97,7 @@ int setup_boot_mode(void)
 	boot_mode = readl(reg);
 	debug("%s: boot mode 0x%08x\n", __func__, boot_mode);
 
+#if !defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
 	/* Clear boot mode */
 	writel(BOOT_NORMAL, reg);
 
@@ -103,6 +111,7 @@ int setup_boot_mode(void)
 		env_set("preboot", "setenv preboot; ums mmc 0");
 		break;
 	}
+#endif
 
 	return 0;
 }
-- 
2.34.1

