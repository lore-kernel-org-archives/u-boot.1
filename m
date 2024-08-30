Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30326CA1008
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197B988CCE;
	Fri, 30 Aug 2024 17:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TFCLG/u8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B456E88C75; Fri, 30 Aug 2024 17:57:49 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1859388CD1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-26fda13f898so1199089fac.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033465; x=1725638265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3FW+I+lePMlHT5ixc8Sbpd6OJIkdW5ZAfASeRacnPw=;
 b=TFCLG/u8O6WbhwcuMBf1UjuNgIFxJkrDhYsMKgFL2D4eWtFFK0IMbMljrGOEZQHWYN
 c4vQhGAP6nIQGky4WSwJeU5JuUXDSC8ZSzstFw1zgBkA5lEhHamxaHzl7ljSpIPaebVr
 27lFyAzgOCxm1Aztc0i2y2hhlp9UsmYBVNqRBLgOMV20M02TaB6XQ+rZCjKv3az80jK0
 W9fIktXIHnDJfWf72D2o/2EhM3CyL2FL/lFZCMHTV3sVolFhSEI9N1Ztu6HZeGT5Eidf
 copnaVBVASflb+mLfrAgJe4/Gsl3ExIo+bLFxYAQtiVqBV1tNcBhPycDtJugCGJaS6Lc
 tYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033465; x=1725638265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3FW+I+lePMlHT5ixc8Sbpd6OJIkdW5ZAfASeRacnPw=;
 b=C8g1dgb1HWEc5vdGA1voIw+6WnEIRpBmK56l+Rll4yMRmrS0SaSPZyoDmuh2yGaPwr
 6AaKQ3eZi+pvZnY224wVYysbtNSyjIdO4/QpRoVTr4+fA5mqwxT4HFhSL+wfZsEetbnM
 3kHVda3BaNo90KVISsFI98mv3i6g3Yqj3DPHmOzTe7AcIVySqB0nm/yK7ebVS2FxtHt1
 Tf+YsKTPzncsakrctDkxi6zKh6OH9irwKzYwgSs9wpg9x6kHytG0kuyoYDXWN3Az3X5j
 6566kWdZLUnt65cXOIS0Ra+TtGz2rR70wdLNU00w17W1iWG7M6MMGts9eqsEUj8cXNXF
 N1Aw==
X-Gm-Message-State: AOJu0Yx5RsJjV5t7nNkTbDJTeQRKM9O9GtGuqdI8Q7HhfEjsvbSpGfNN
 yjBCOLbx+p8EhiQIJpviBbskmeevgK9KTKRnvm1XTvU3tNjPvhO3gi6vJw==
X-Google-Smtp-Source: AGHT+IFAS3TphuUTkO57Y8Q9Qh5aVD0ymKbJbH03pUd+zrglZbMaT/dPs1OgHiurMjbYJ0HHZ9WrTg==
X-Received: by 2002:a05:6870:6594:b0:261:9fc:16b9 with SMTP id
 586e51a60fabf-277902b4b75mr8030788fac.33.1725033464704; 
 Fri, 30 Aug 2024 08:57:44 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:44 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 9/9] sunxi: Add support for Anbernic RG35XX-2024
Date: Fri, 30 Aug 2024 10:55:14 -0500
Message-Id: <20240830155514.481410-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830155514.481410-1-macroalpha82@gmail.com>
References: <20240830155514.481410-1-macroalpha82@gmail.com>
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
 board/sunxi/MAINTAINERS                |  5 +++++
 configs/anbernic_rg35xx_h700_defconfig | 28 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
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
index 0000000000..57112f7d70
--- /dev/null
+++ b/configs/anbernic_rg35xx_h700_defconfig
@@ -0,0 +1,28 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun50i-h700-anbernic-rg35xx-2024"
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
+CONFIG_DRAM_SUN50I_H616_PHY_ADDR_MAP_1=y
+CONFIG_MACH_SUN50I_H616=y
+CONFIG_SUNXI_DRAM_H616_LPDDR4=y
+CONFIG_DRAM_CLK=672
+CONFIG_R_I2C_ENABLE=y
+CONFIG_DEFAULT_FDT_FILE="sun50i-h700-anbernic-rg35xx-2024.dtb"
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_REGULATOR_AXP=y
+CONFIG_AXP717_POWER=y
+CONFIG_AXP_DCDC2_VOLT=940
+CONFIG_AXP_DCDC3_VOLT=1100
-- 
2.34.1

