Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4FDC52D6F
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8342C88CFB;
	Mon, 19 Aug 2024 17:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ef/RIwob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1727388CE8; Mon, 19 Aug 2024 17:02:14 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E5F871C7
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-70930972e19so1398296a34.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079730; x=1724684530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCw5MPcxcWw0TZEM4gndlYGDMLadeweGjwzY42FV5nY=;
 b=Ef/RIwobzah2HKVBqSXfUZ+CBvLj9eXZpAd9SuD0o9DGt6AumxZ5ichirpF7S7649l
 cmv22AplU/SHzh6hnwCbHlxC+mOGeFsM7Zf8ihKOtrFoUrbkGvU4I94ZoVw77WHxSiRp
 apvHiEAhy/RxcX42OvGUJIJYq1Qg8VO+y3DBVvXcgYfUrQvuawfSicA9iSje8gs2FNiH
 QJ+yOHWwWlD4Yzttduen5U7zvHY+wROrlGMmcT/k1Llkhdwnc3Je/OI7pT50RX/SZAUr
 bvuBsN8BlvkZZuQVC4Vea7nZ7VbBqhfKCYNXcokxLc1Ws+zSxjIO0sezuJDl9euO0EB/
 nFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079730; x=1724684530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCw5MPcxcWw0TZEM4gndlYGDMLadeweGjwzY42FV5nY=;
 b=iVTA7wiLIoKPXCoaF9AdUePQA/0iMMxDlTPT/s5TGKJT5lKqpc/DAYK/lxAi/Na26f
 4C21c1XRvmHksBidZzHEHgdLxSg3BIM3qm1HAGLSAFOOR3409lmQtjAzGtNwZ5Y/PIMH
 60ocJuFYfZN9ytLWgkUmm9n81lTaZHaRMAMEP/s5y3us81rCgFip38H1k/aNmJeMKXDa
 DlJJEoYFXYF2kMjGZontMw/wveAb6Si22LPRajDJqkGs/zOfu2XfvKe+EluTxvBrp6HH
 gSckvQ2yJ5uT+klRx6aWaBllKflzew0RUQV0HjOeGpigdJj5rq0lJMNun7Vivpq5LJep
 Qzyg==
X-Gm-Message-State: AOJu0Yzcg6tKSF37lgysvUtCCrGUC+tqygK6EDqz1OgksDL3HzdTKyIs
 NGwxOO6Os+riP1ba2KC254K8snHiCbutoSPtbz20gIJ6y2HEyFqHqW2Tzw==
X-Google-Smtp-Source: AGHT+IEH+ruuVKkA8iT6/E82AGwwd2EomO1XBLJ7JHUuhvoF4PutUeN0Pb51cqxhR/LZmlq4b0O+rQ==
X-Received: by 2002:a05:6870:a688:b0:25d:fb57:db43 with SMTP id
 586e51a60fabf-27033fb8dc1mr8505844fac.12.1724079729537; 
 Mon, 19 Aug 2024 08:02:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27004432d18sm2945189fac.7.2024.08.19.08.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:02:09 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 9/9] sunxi: Add support for Anbernic RG35XX-2024
Date: Mon, 19 Aug 2024 09:59:38 -0500
Message-Id: <20240819145938.503221-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819145938.503221-1-macroalpha82@gmail.com>
References: <20240819145938.503221-1-macroalpha82@gmail.com>
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

The Anbernic RG35XX series of devices are based around an Allwinner
H700 SoC with 1GB of RAM, 2 SD cards, and multiple input buttons.

This bootloader has been tested on the Anbernic RG35XX-2024 and
RG35XX-H, but should be suitable for the entire lineup of H700 based
devices.

A future series of updates will add board selection logic to identify
and load the correct device tree automatically.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/sunxi/MAINTAINERS                |  5 +++
 configs/anbernic_rg35xx_h700_defconfig | 52 ++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 configs/anbernic_rg35xx_h700_defconfig

diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 4ad77c75f5..84799879e8 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -132,6 +132,11 @@ M:	Paul Kocialkowski <contact@paulk.fr>
 S:	Maintained
 F:	configs/Ampe_A76_defconfig
 
+ANBERNIC RG35XX-2024
+M:	Chris Morgan <macromorgan@hotmail.com>
+S:	Maintained
+F:	configs/anbernic_rg35xx_h700_defconfig
+
 BANANAPI M1 PLUS
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
diff --git a/configs/anbernic_rg35xx_h700_defconfig b/configs/anbernic_rg35xx_h700_defconfig
new file mode 100644
index 0000000000..6ea2f45d2f
--- /dev/null
+++ b/configs/anbernic_rg35xx_h700_defconfig
@@ -0,0 +1,52 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h700-anbernic-rg35xx-2024"
+CONFIG_SPL=y
+CONFIG_DRAM_SUN50I_H616_DX_ODT=0x08080808
+CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
+CONFIG_DRAM_SUN50I_H616_ODT_EN=0x7887bbbb
+CONFIG_DRAM_SUN50I_H616_TPR2=0x1
+CONFIG_DRAM_SUN50I_H616_TPR6=0x40808080
+CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6633
+CONFIG_DRAM_SUN50I_H616_TPR11=0x1b1f1e1c
+CONFIG_DRAM_SUN50I_H616_TPR12=0x06060606
+CONFIG_MACH_SUN50I_H616=y
+CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=y
+CONFIG_SUNXI_DRAM_H616_LPDDR4=y
+CONFIG_DRAM_CLK=672
+CONFIG_R_I2C_ENABLE=y
+CONFIG_DEFAULT_FDT_FILE="sun50i-h700-anbernic-rg35xx-2024.dtb"
+CONFIG_LAST_STAGE_INIT=y
+CONFIG_SPL_I2C=y
+CONFIG_CMD_BDINFO_EXTRA=y
+CONFIG_CMD_BOOTDEV=y
+CONFIG_CMD_BOOTMETH=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_BOOTM_OPENRTOS=y
+CONFIG_BOOTM_OSE=y
+CONFIG_CMD_ADTIMG=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_CLK=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_BKOPS_ENABLE=y
+CONFIG_CMD_MMC_REG=y
+CONFIG_CMD_MMC_SWRITE=y
+CONFIG_CMD_SDRAM=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_UPSTREAM=y
+# CONFIG_NET is not set
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_REGULATOR_AXP=y
+CONFIG_AXP717_POWER=y
+CONFIG_AXP_DCDC2_VOLT=940
+CONFIG_AXP_DCDC3_VOLT=1100
+CONFIG_REGEX=y
+# CONFIG_EFI_LOADER is not set
-- 
2.34.1

