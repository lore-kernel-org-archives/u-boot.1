Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3110C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 15:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1720587927;
	Tue,  2 Jan 2024 16:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DxvZmX6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC157878F9; Tue,  2 Jan 2024 16:47:07 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0576876C0
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 16:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-59505095b0dso687637eaf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 07:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704210424; x=1704815224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HF8fBHR/6AzEi0G7QM1eJ1umr8wAFHQApw15e/f+Vfk=;
 b=DxvZmX6Re1pMfTxWR1LmecK//HcGJY2cSTa24FF0kHkYzMRm1TrJ2fZb4tGdul4j3Y
 i3R5tHAivtDDGCCAO+CeXemIr3ehmN8Rw92H89ZZdcNmmF2q6pjyYzsqg1Pvh+kdvgMa
 3Lka7Q1TAWOWClZcbkF2N6edlo9UrAs8sEsdMYrEhQbMypMgXIvzWurZ740wiV7mIM1O
 JoDh/WWicfK43xNvWHeb4vRGR71Wati/YUHMcGosZduX/bczqeC95MWm6c5R1avewdcO
 N0+bwnqtp6CQfZ1UhP85FNpIek3xH389qxt3/SeCZnYAW2XvPjK2Tb9BWmIm0YjVrlH+
 U3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704210424; x=1704815224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HF8fBHR/6AzEi0G7QM1eJ1umr8wAFHQApw15e/f+Vfk=;
 b=R2V/iD6jTNir+rQyOlTz7RIbwG8xda4XTWhOwzHqAAaNLaqhQjudb4LpAvUkjt6xSv
 Pz+PugzT84OHVU32ouGlpwhlntRVFXxMRKAy1qJUpH5z4kuV6hRyl3GiTctJUHfnzGOO
 Ro/08vTPmkUdHb6DwanmXVvMQVS+Tcycp3ajUWKqBhSE8LK5ptoEgBLh2rs+mzjH+YTu
 Yzg7zFE3HNMQCgxJQqdbMvGD0+l9/5gVYkjkIUHvcBRWP5LSE0dcMvEPnr6cwqkM0YJC
 cyjmGULm8r9fVhH//NEapCJhzC6kue2xD8IBnUm+Z6OnA/XuQS9chXTkuInwtOaK0y9p
 u91w==
X-Gm-Message-State: AOJu0YxoSTRro0uefrQbhcTVzs0NaflgTgqRPMg15epkukwQO+QeWdWy
 qQxQgl+pmUcxn+Zj+wQdvPxS0HB6fkOCrw==
X-Google-Smtp-Source: AGHT+IFvEGDxr9ThaqurZsbH8Y1KGLptXfQlaojS6Js9ZmSEkEhUC5xkw/rWMwGikV0WRziX8RGg2w==
X-Received: by 2002:a4a:988e:0:b0:595:c337:6f with SMTP id
 a14-20020a4a988e000000b00595c337006fmr645054ooj.12.1704210424070; 
 Tue, 02 Jan 2024 07:47:04 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 127-20020a4a0d85000000b005958af24e84sm843197oob.42.2024.01.02.07.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 07:47:03 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, jagan@edgeble.ai,
 jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 3/7] rockchip: boot_mode: Allow rockchip_dnl_key_pressed()
 in SPL
Date: Tue,  2 Jan 2024 09:46:50 -0600
Message-Id: <20240102154654.191055-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102154654.191055-1-macroalpha82@gmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
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

