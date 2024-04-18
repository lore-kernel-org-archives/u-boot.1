Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D83AC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B288D8868B;
	Thu, 18 Apr 2024 19:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wOugneI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504DC88695; Thu, 18 Apr 2024 19:24:32 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F9E88648
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-418effbc70cso5551815e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461068; x=1714065868; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NCv69hjOiyf3kF7VwxE17UXnNC3z7hoovbBkUt6q+w8=;
 b=wOugneI8gAfC8LvGJAlJgWQTvR9J3S63wSXqobpx0OjN6Lktw+7raTTgyI8k9zArXS
 V0lTBzusL/kYBnKN4RMqoiM1WwytCvu6WNQ6fuIkq9BL75DGep3OjRodNhq+lO86Lnsy
 JGPEfUuXpIlAwVSFHw4iTUdqpYIRBgk2ZJSxXH6YgnwaAxJlhlsY5JN+GzsruEAxU7k2
 2S82mgJ75vuF1B5fdAn1fhg0zsbnVNc/977RQ9KGdasyUjzv5Kq5QzGlGpBF6EdG8xo9
 G+V6yRVIKR3YbgnjzEA4cGE38/tj8QOsI4///OLYclvFkItEA8NDXcOYF1QGNSXyTyKH
 /Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461068; x=1714065868;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCv69hjOiyf3kF7VwxE17UXnNC3z7hoovbBkUt6q+w8=;
 b=D9GF/MKKk2o3j6eh6KxQBGazut0TjcjZxqmVrrVZsHYgA3MDm1aruvYGpOCkZPhDXt
 wdrnyqPnc5Cx1Qnq2GpJ4D+eCeEQ+vDrzLujvT4CwWRi9F3o6ddjFrSJ3eN3wZpYHWZ+
 WB5zVINpa4XL+NUtfBMFLBt7COx4uK34P7p610RMSlXpz1sbKd3Af2qYb3l+4nOg7hf2
 AXjQ5PIFgNK0bFrltpk6e5Du6al0Due54NGt2Rj2IoWsxwd5nVTPVMllHUl2eywiv/zO
 DK+Z9ubvKrcXrZg6ZYG6kXKk0pc0+NpXuBIy2/cvI6YevkObdlHtaUNQq4bB/fmuhr7y
 Mw+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXThAFxeHnm8Zl8BJ++FSjQfeU+fbSOpspNmXT7LTFl7YWEX6XIHcmiz/AktFFZ6pd9GPfbnfKud3q9QSuguPIGVBSkrw==
X-Gm-Message-State: AOJu0Yyz9isgEIBGACX/92jpCnC+0tI/f2gng85NTC6hpJ1PcTaVcEwS
 u8Lsyku8TUZGTzoJ8OxPFIsgwi+SMe3edB/Hr8AWmeSsiUVxmwYkMWTxWe3jeu4=
X-Google-Smtp-Source: AGHT+IEcN+nhl9KvpmvKq3pkrHOHsqOj5jnQixJ2hk4C2RRIo9rQNYSdaENPD8R6POrDC7gJK1HzvA==
X-Received: by 2002:adf:e40e:0:b0:34a:3eec:c379 with SMTP id
 g14-20020adfe40e000000b0034a3eecc379mr450197wrm.67.1713461068531; 
 Thu, 18 Apr 2024 10:24:28 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e32-20020a5d5960000000b0033ec9ddc638sm2301799wri.31.2024.04.18.10.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:24:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:24:09 +0100
Subject: [PATCH 1/3] mach-snapdragon: use OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-1-e524eb29ae86@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3079;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WF+sZc5b4ZbL2H6/0LLnd6+9nclokPuGKq4/bLJMi70=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTFcK81JVUnp81xnXG/rDF3Uf6LsPaM8oL1Z/891Obxv
 iSz7lpSRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiIrjEjw7yc8ulKBXZv1/Ut
 7bqg6yxjUXGsOtni8zZJrYn987O0pjL8d2Iu97kmkFoR0//Xam7QD7mDITkPtSKKG1a/UOB9e0r
 /EgA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Switch to using upstream DT from dts/upstream.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS                       | 4 ----
 arch/arm/Kconfig                  | 1 +
 configs/dragonboard410c_defconfig | 2 +-
 configs/dragonboard820c_defconfig | 2 +-
 configs/qcom_defconfig            | 2 +-
 5 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0d2b5138fca..d0a4a28b401d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -605,12 +605,8 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
 L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
-F:	arch/arm/dts/msm8*.dtsi
-F:	arch/arm/dts/pm8???.dtsi
-F:	arch/arm/dts/pms405.dtsi
-F:	arch/arm/dts/sdm845.dtsi
 F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 23ee25269a24..2931c82eb11f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1088,8 +1088,9 @@ config ARCH_SNAPDRAGON
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
 	select LINUX_KERNEL_IMAGE_HEADER
+	imply OF_UPSTREAM
 	imply CMD_DM
 
 config ARCH_SOCFPGA
 	bool "Altera SOCFPGA family"
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 260a8349d3b2..9ef04fd45546 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -8,9 +8,9 @@ CONFIG_SYS_MALLOC_LEN=0x802000
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x0
-CONFIG_DEFAULT_DEVICE_TREE="apq8016-sbc"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/apq8016-sbc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_REMAKE_ELF=y
diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
index ebc80eb2a464..f6b2cb09ba31 100644
--- a/configs/dragonboard820c_defconfig
+++ b/configs/dragonboard820c_defconfig
@@ -6,9 +6,9 @@ CONFIG_TEXT_BASE=0x80080000
 CONFIG_SYS_MALLOC_LEN=0x804000
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
 CONFIG_ENV_SIZE=0x4000
-CONFIG_DEFAULT_DEVICE_TREE="apq8096-db820c"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/apq8096-db820c"
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 820C"
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_BOOTARGS=y
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ee3ed89cbc8a..218a9a769682 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -1,9 +1,9 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_SNAPDRAGON=y
-CONFIG_DEFAULT_DEVICE_TREE="sdm845-db845c"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y

-- 
2.44.0

