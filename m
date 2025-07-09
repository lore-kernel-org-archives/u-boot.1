Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D59C83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 22:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AABA83642;
	Thu, 10 Jul 2025 00:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nh9yW4oY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0704835EA; Thu, 10 Jul 2025 00:29:37 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FACC835CE
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-61208b86d75so205897eaf.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752100173; x=1752704973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aF7xLW0cz5h5Gcr5cxQdwrNngvodbKf4utMSqfHv0K8=;
 b=Nh9yW4oYYbGn8mdgpg2+Z9Bzogp/BMOLFG9jTYYsYJaGKmnCIm9N0xz6TAzS1U8KEo
 aYsLH3MJqY55HKW36/vbjIMZSV/yooAWehVlkY+T+ZOOerE0ELyWbG4EEgphN2B3QF6x
 SdNqk5m380XTswKoHvFbKN8AtQ9RPyk8JcXfE3WfCSiHdGPr9bMROkJnBusQppqn7FZz
 YORar/vZWDv+pAUE704UnDv13fZacBSo6i0KBbJpUJjOozAH3Gfgzt4/YCQVxI5lYPYT
 8fhhCkTeXk1S5u80Dup6o6dIjafoHqb2+atFbd2J4+w/nh1M40IBTcrFHcFUdWk3aywV
 NQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752100173; x=1752704973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aF7xLW0cz5h5Gcr5cxQdwrNngvodbKf4utMSqfHv0K8=;
 b=u0XM1KsX6q/KAhSsSYawXS8ly5ODJHJYx349tdnosfQ5L+56OzJ9WHvw5ZLMHueyL8
 PPfXc+g/DUgQxv52E6TQ4Bb3WBNh1ueAi8z1MVMzbIkJ1lYvR+71vyx0dFy4CQr0Tgoh
 ysSHdSF9dYaapGFlL3lwH5+uwpfhP22iksl5sK9a5wtIRElCfh0eyUE1Vpb8TA/4A7bj
 vSrKdA7Npc2M4CS7k9X9ptYr/xhtaPjDxkPAU0gEeCTB6jhnL97Q5UHUfHHDGAYHI7cY
 CKinx2PmRxqsgPvZ3z+gv4B+StqjfE0/STXH6WErVJSec4B/qAHVvSqD2pKwEXAkdZ9G
 OgUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxUMu5wl1BTcv3Os938dO6O+y1QjHu7B4Q3C4AaQ9Vjn9pLL2vbdVT85xYcxQrHVL4e2B68sg=@lists.denx.de
X-Gm-Message-State: AOJu0YyCCzXtH/8ofDEb4OeMhCj8kOjMxMRqcpCUrZlM/zrnhRXcxdO0
 OL9ku0LqmEvHF4BpU37x7mZ4u+BEGw45GrzyhBeAUSomxJ78sm+oqBCdI4PzjnwBW6E=
X-Gm-Gg: ASbGnctUIFuAsypwO/5u8qbcjNOUp0I+48/42VjIWbDBy9P8/Qimdm5zMHphEFCymsw
 v9zYLGO1q/4IYEC0ZmEea+gjALn5dGJuiH1f0acv/vpxYjICK9Le4iujLgBD/kS9Wl+MraT9tvp
 /rwc2RL5rrCUM6e1XB1FFnuX8ebY7tg44R2tHkYdsxHSqBlDxqhRDRD/c5q+SlB7izSpm0JmzaJ
 a4er+njrD/Dm1smfNKqqKWiVnHQQ8oSnFRYcv3hAsjvod1O8KcmWOIJ0MQmOFdq63iBzvcqEJPN
 J5fQhugF8AJU4NlX9Jv9aghG2152FrLipXm7EZ6crQcfw/BJ5SD6Y/p/EivpdqOyP8JyxTlb/U1
 nmqTr85M=
X-Google-Smtp-Source: AGHT+IHwR8UYgJDI5DtOKuZlA6SSbEa1Yghlqf/OpgfMzZxyb3AIlfVVL3Ke1G0f6iq7KoR/KripNw==
X-Received: by 2002:a05:6870:8dca:b0:2c1:461f:309a with SMTP id
 586e51a60fabf-2ff107e9039mr281912fac.8.1752100173222; 
 Wed, 09 Jul 2025 15:29:33 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff1123b8ddsm46974fac.15.2025.07.09.15.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 15:29:32 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 7/9] configs: e850-96: Enable USB gadget and fastboot
Date: Wed,  9 Jul 2025 17:29:24 -0500
Message-Id: <20250709222926.24671-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709222926.24671-1-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
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

Now that USB phy and dwc3 glue layer was added for Exynos850, USB gadget
is functional on E850-96 board. Enable next features to make it useful:

  - Exynos850 USB PHY driver (needed for all USB functions)
  - dwc3 generic driver
  - USB gadget
  - CONFIG_DM_USB_GADGET: needed for DWC3 glue layer to instantiate the
    peripheral driver, i.e. dwc3_generic_peripheral_probe()
  - USB VID and PID
  - DFU
  - Fastboot (including flashing to eMMC boot partitions)

As all Exynos firmware binaries (including U-Boot) are contained in eMMC
boot partition A (mmc0boot0), because that's where Boot ROM code jumps,
it might be useful to be able to flash that area with fastboot. Other
more fine grained choices for updating the firmware would be DFU and EFI
Capsule Update mechanism.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 375805b3e5ca..96e91959f16c 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -15,7 +15,6 @@ CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_ENV_OFFSET_REDUND=0x10000
 # CONFIG_PSCI_RESET is not set
 CONFIG_EFI_SET_TIME=y
-CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="exynos850-e850-96.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -24,6 +23,7 @@ CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ABOOTIMG=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_EFIDEBUG=y
@@ -39,8 +39,18 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
 CONFIG_NO_NET=y
 CONFIG_CLK_EXYNOS850=y
+CONFIG_DFU_MMC=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x8a000000
+CONFIG_FASTBOOT_BUF_SIZE=0x30000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
+CONFIG_PHY=y
+CONFIG_PHY_EXYNOS_USBDRD=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
 CONFIG_SOC_SAMSUNG=y
@@ -48,3 +58,11 @@ CONFIG_EXYNOS_PMU=y
 CONFIG_EXYNOS_USI=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_SYSCON=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Samsung"
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0002
-- 
2.39.5

