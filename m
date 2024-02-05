Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC15C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 18:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E3787B93;
	Mon,  5 Feb 2024 19:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bF/aqgJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D983B879AF; Mon,  5 Feb 2024 19:59:06 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F076A87AEC
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 19:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bbc649c275so2733623b6e.0
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 10:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707159542; x=1707764342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3YSUuKc2DNP0IOZyD969wN0ZrzsqCUADR9i/3+p7z4=;
 b=bF/aqgJWtkQKWTEWEQAln0dFSkLU4rn/lbNVNp3Dxu+G9O5VpXGyljuRwceAPwlqtH
 sHVWn95SmTX2481fJLkSC/0rw38wU6Jyq0r7UUv+fSDkTbfRLtK3Zkbpp1PKx7H2+OCz
 gPTvIxyCzXsPuDM4akHob+28j4Dl4eiLti2oQxOwvfq/X8IxUsN+yBOXHwRJQEBOJivn
 G8gBhBAuiKMvgDL1HYZ2bgccAhFE77n+9vAbktBfeqO/Up7Wa6bQmZ1Qa3TDnmvj6zFz
 1kt7YUbftER5dc8H+LX91K+c+1f/4bICled6j1qi55CIX7Am1VhLWbNDwK8gVR59b39x
 QJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707159542; x=1707764342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3YSUuKc2DNP0IOZyD969wN0ZrzsqCUADR9i/3+p7z4=;
 b=GQKz+WwcvNJtChi7sVFkAA7t6kInwqgJui73nCKO0o9xzO0Z95QxpRPuHebaatvtJx
 2+I5eGASruhRT+XYcB7ui+HZiTdvADStFOOii534qppgdm0lCDoVlOWv9Ue6jl3RYaG6
 iGWJpzjD/uRs2AeID+iWFmg0IdTN+c57+khrA4rZPAF0kZempM7RKoLwtDxJR088Q/U/
 6ExLpSn0WsrwYwmY7BEgZL8XUIZuLnnUcsQ8maugdwuMpwBLXcOLTwKNsRI8YTniFZ+w
 qGjmueUdRg9zC/tmAFWFh2lRGniaz04RhKxVQdgOn+KPGabctcsXsiXjSF0CwH19zMsN
 RQwQ==
X-Gm-Message-State: AOJu0YzmEstMOHJVApUrh8tbgyry/s1s3l8WTsnC8w4Yog/TUzAbC6iz
 VOGxxgjJWhAuByTgnt+3Dj/nz7WU8zEVVsS5oroBi3Q7weNxs+5qVwu5kjWC
X-Google-Smtp-Source: AGHT+IFbMrzOrA14gh/eRCXGIyLVSVa027eoWywD03srIm+FfZvgZF1e3MpJ41ovf21+PFCb0FBFTQ==
X-Received: by 2002:a05:6808:4487:b0:3bd:a4f3:a3 with SMTP id
 eq7-20020a056808448700b003bda4f300a3mr609581oib.36.1707159541804; 
 Mon, 05 Feb 2024 10:59:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVzd8TUk0XOZIKKpMQa0AUM59rgTqSGVXxatijAGTXt1Io/n43hQmRTgO3WkipqV5CHoij97qOyZGuMhP6ecuVmvTKHnkHHlB+EPsR4/40Te5BViVhtKd1lcd+3DbABBCEdPc7PVoopglfCma/kvWn56oupwAQZ53KIC1t7kHfxYRUY1k5EJk6nU/C6B1RwzqXYDf7cuVN8O1UCiZa8xZbL
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 cn22-20020a056808351600b003bfdfc7e5d6sm65692oib.42.2024.02.05.10.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 10:59:01 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jonas@kwiboo.se, jagan@amarulasolutions.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/4] configs: Remove unnecessary options from RGxx3 config
Date: Mon,  5 Feb 2024 12:58:54 -0600
Message-Id: <20240205185855.21508-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205185855.21508-1-macroalpha82@gmail.com>
References: <20240205185855.21508-1-macroalpha82@gmail.com>
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

Based on feedback from the mailing list while adding support for a new
device (the Powkiddy X55), correct the config options for the RGxx3
as well to remove unnecessary drivers and increase the SPL stack size.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 configs/anbernic-rgxx3-rk3566_defconfig | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index ed6643d9d4..d52a0d48f2 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -3,6 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
+CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
@@ -24,7 +25,9 @@ CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rgxx3.dtb"
@@ -32,7 +35,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rgxx3.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_RNG_SEED=y
-CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x4000000
@@ -41,6 +44,7 @@ CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
+CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
 CONFIG_CMD_PWM=y
 CONFIG_CMD_GPT=y
@@ -50,8 +54,10 @@ CONFIG_CMD_MMC=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 # CONFIG_NET is not set
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
@@ -67,13 +73,13 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_FAN53555=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
-CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
-CONFIG_DM_REGULATOR_SCMI=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
@@ -89,5 +95,6 @@ CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
 CONFIG_VIDEO_BRIDGE=y
 CONFIG_REGEX=y
+# CONFIG_RSA is not set
 CONFIG_ERRNO_STR=y
 # CONFIG_EFI_LOADER is not set
-- 
2.34.1

