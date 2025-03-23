Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC16EC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 22:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2DB81DAB;
	Sun, 23 Mar 2025 23:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nQfYqPbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8A681D6A; Sun, 23 Mar 2025 23:51:49 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1033581D6A
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 23:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224341bbc1dso67406325ad.3
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742770305; x=1743375105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2sXulyxPB3N4fjpa93jo8vCrrmK5e0u/suSilYXl8E=;
 b=nQfYqPbEkcamttL6Jt09IbUkaklpmS5/r3AStkPHRnPYwXbMYll2pT7KpewbtK2GTK
 JZ7u8L+sI+OaFSPeBZb++a4dAyc7nSpIw+Hjc7iFNA36cLfuNpH5w+Efj0kj4cZ3g59Q
 g30b/55FfSkhRqOg0kkXsOAW7u5u+yhhp3T3KTmwioj/WM+/xnFpjmAOKRxqppXs2ypE
 MhdYNX5EJm8vOOXvpR9CqTYSxbqXFc68vj/cfeoVEvmflN0mTdfVr+FxfuiPuxrL+2/c
 PuCBnjq/NFyqKSYnfrvqC8wksHJEaXlP/hUUwDqX4B4W3yTHEmT72PO6ldLF6RkZ8scC
 6ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742770305; x=1743375105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2sXulyxPB3N4fjpa93jo8vCrrmK5e0u/suSilYXl8E=;
 b=ZfM/iUE/ejiW3bSCqalU68KRwmSWPf1SOJ+L2djlkfEGB9DWJsKAiZC67TQEa5VQ0g
 I6O26ldTonKwctfBwbcZpbI4u7+wSy4NO3tBEzC60DClVkAh69CdUZPdfqrXCOKKQFij
 SjmgjqZUT6I7rh9/qUrEQEPiWs1bEjhKWgrf/cLhkfUl1VcC01DCCyYDemtwwAUfZM2Z
 +L43AbH+TWZliC6bAczwEzEHMqxv+mXhybMXCbhG+lFTGR6aZHTJiQx2FTzQcWFhR/fk
 1Z2BKPVlMl6PCwNOSIOU+rYFXS40Q7C8r8E7XJX+kHA4r8Sojg7a6TR7qnliSW+2XQnn
 YwTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuVYkKL8ZCuvS1vI6tNN77XZVbx4cd6khGqRGMQkVod8liVuWTc8iNISQZhMbWhRTWBh75d6U=@lists.denx.de
X-Gm-Message-State: AOJu0YxcKeSEQ+bwGDbbUxjjAxvkXwEZD/zLUaLvDjToT5fPbIRCaFty
 M/YfWOV+dxFk9Iile7+TZq3A4srZlvF+TL3DRZiC4V/kXTC2nYbn
X-Gm-Gg: ASbGncuGqMi/NvZnKaVyU3pbBujl1eZ3lv/AesdF1BjIZCfEC35Y1o6yb21kSHtkogo
 1t9WTCeF3CvZhNuLDK955cqQhrsiosbs7FZrUA4Cj5y+VCkNeni/UIdEBRPFPw4a4VvW1B+USX8
 jYU+jTCAg8GmHixCYv0pfOj+Fmc7kCpiX8GE5q1isfJE1D/FXkyRiUo2P7MNbi8PockUoWEKtVd
 cNyScb0hJ8z26VXuMakxMN5lUkwfEHipsXnrXJeACe+/A2dBYu2j2cFqKrZakKWlyNGklpD1lnP
 /3OniJi3ihVQXXucR7+Z+MnI9ZJEliQz7JIQ
X-Google-Smtp-Source: AGHT+IHNGY/jGOnCM9U6iP7bWBkgu+/gAr7yHkBpAl2gosQSGMJWf3NUwZ0VQK0CpRyAzxIZN2vSVg==
X-Received: by 2002:aa7:8883:0:b0:736:3be3:3d77 with SMTP id
 d2e1a72fcca58-73905a276a9mr16719082b3a.16.1742770305487; 
 Sun, 23 Mar 2025 15:51:45 -0700 (PDT)
Received: from anarsoul-xps15.lan ([2001:569:7d4f:2900::398])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fab628sm6368536b3a.6.2025.03.23.15.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 15:51:44 -0700 (PDT)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Jagan Teki <jagan@edgeble.ai>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 3/3] rockchip: rock64-rk3328_defconfig: enable HDMI output
 and USB keyboard
Date: Sun, 23 Mar 2025 15:50:58 -0700
Message-ID: <20250323225134.2369473-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323225134.2369473-1-anarsoul@gmail.com>
References: <20250323225134.2369473-1-anarsoul@gmail.com>
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

Enable HDMI output and USB keyboard on Rock64 board

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
v2: no change

 configs/rock64-rk3328_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 6d00b52e62f..ae3512625cf 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -21,7 +21,9 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
+# CONFIG_SYS_DEVICE_NULLDEV is not set
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
@@ -72,6 +74,7 @@ CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
@@ -80,6 +83,8 @@ CONFIG_PMIC_RK8XX=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
@@ -104,6 +109,11 @@ CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
-- 
2.49.0

