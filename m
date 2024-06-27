Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD38CC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67402885A4;
	Thu, 27 Jun 2024 10:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eBeqPDHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1768B88569; Thu, 27 Jun 2024 10:30:06 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC4D388572
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3608e6d14b6so4836477f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477002; x=1720081802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmoXNBYVFrospD2TCLEmd7FUTXRsZen2gmLgiCnYL2w=;
 b=eBeqPDHsg3y7/B2z65ItTieMww05dDfKoqsHchIAQopMebTLE9llbP55St7ombG0eH
 Oq192v732iRKh8YqpgKWTIY0ktMGaOqQaYPMA9CwGFkAIO4IN1o6QbvjmRk2XiTkPyBt
 nFlipLXz81pzO8oiw4E5ViDBXBuMG5AHemyxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477002; x=1720081802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmoXNBYVFrospD2TCLEmd7FUTXRsZen2gmLgiCnYL2w=;
 b=hggT3qoKHO6A/hGiQS6Pt+L5RrSwkEuu7Umr/bv7GzdPR/YxNC5Bbh3rJNXdskNpFH
 PQ+6lIZZmJLPTt91zIbEe5+eaa26K8lrSyyFuXaqtB0SX0yLIGNhy4XCuwFglKdNBCTu
 upB86ku2PYQgIBoUIf+NEpnw7D74Q+DUsKQVrQyFE1NnIkO6Ijo5922QBlaSTVeuJfHs
 ASCE8r8SgLBpcp8VI3OvNM0jeRkhQOp4vqXAq21JL2LnsrNPNnxw/zhUPHA3yQn3ls0R
 Zli2DoD9gUNagODRGFulgGTaZne1ddvM6HaT5iR44j7C3dip+rlZu+kXBHQieomv7cm1
 CSNA==
X-Gm-Message-State: AOJu0YxB07RHe4uFbexH7vXXMt4QFbU5diIhXi6ohmi2Y9nGsqMZO9Ll
 /eM+Ur3YpzPfT3VUhD5so9FL83XYmTr+z2Vi53w/+bdCnts3DFHLKHBfH2lW3pGquWJW7r5mkGy
 maw==
X-Google-Smtp-Source: AGHT+IFDM8LfhvCOdGqnq7qcfj2a4qOJM70FHlESfszUH2RpqptPSr8jwSGXPG6HjzS0/IAg1g5xPw==
X-Received: by 2002:adf:9b0a:0:b0:35f:2b1d:433 with SMTP id
 ffacd0b85a97d-366e94948dbmr7022765f8f.26.1719477002172; 
 Thu, 27 Jun 2024 01:30:02 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm1106534f8f.9.2024.06.27.01.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:30:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 8/8] Drop the special am335x_boneblack_vboot target
Date: Thu, 27 Jun 2024 09:29:49 +0100
Message-Id: <20240627082949.357089-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082949.357089-1-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
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

Now that am335x_evm boots OK on the Beaglebone black, drop the latter
and update the docs to cover the change.

Also add a few updates about 'make fit' and drop the note about the
security review, as U-Boot's verified boot has had quite extensive
review now.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v4)

Changes in v4:
- Fix 'stating' typo
- Move Binman size feature to a separate series

Changes in v2:
- Drop patch "regulator: rk8xx: Fix incorrect parameter"
- Rewrite boneblack patch to onstead drop the target and update docs

 board/ti/am335x/MAINTAINERS              |  1 -
 configs/am335x_boneblack_vboot_defconfig | 94 ------------------------
 configs/am335x_evm_defconfig             |  3 +-
 doc/usage/fit/beaglebone_vboot.rst       | 21 +++---
 4 files changed, 12 insertions(+), 107 deletions(-)
 delete mode 100644 configs/am335x_boneblack_vboot_defconfig

diff --git a/board/ti/am335x/MAINTAINERS b/board/ti/am335x/MAINTAINERS
index 219c8715bf1..ed8800a2663 100644
--- a/board/ti/am335x/MAINTAINERS
+++ b/board/ti/am335x/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am335x/
 F:	include/configs/am335x_evm.h
-F:	configs/am335x_boneblack_vboot_defconfig
 F:	configs/am335x_evm_defconfig
 F:	configs/am335x_evm_spiboot_defconfig
diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/am335x_boneblack_vboot_defconfig
deleted file mode 100644
index d473a1a793b..00000000000
--- a/configs/am335x_boneblack_vboot_defconfig
+++ /dev/null
@@ -1,94 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-# CONFIG_SPL_USE_ARCH_MEMCPY is not set
-# CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
-CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-boneblack"
-CONFIG_AM33XX=y
-CONFIG_CLOCK_SYNTHESIZER=y
-CONFIG_SPL=y
-CONFIG_ENV_OFFSET_REDUND=0x280000
-CONFIG_TIMESTAMP=y
-CONFIG_FIT_SIGNATURE=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SYS_BOOTM_LEN=0x1000000
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
-CONFIG_AUTOBOOT_DELAY_STR="d"
-CONFIG_AUTOBOOT_STOP_STR=" "
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_ARCH_MISC_INIT=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-CONFIG_SPL_MUSB_NEW=y
-# CONFIG_SPL_NAND_SUPPORT is not set
-CONFIG_SPL_NET=y
-CONFIG_SPL_NET_VCI_STRING="AM33xx U-Boot SPL"
-CONFIG_SPL_OS_BOOT=y
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
-CONFIG_CMD_SPL=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-# CONFIG_SPL_BLK is not set
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_RAM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_DM_I2C=y
-CONFIG_MISC=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-# CONFIG_SPL_DM_MMC is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_GIGE=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_DM_PMIC is not set
-CONFIG_PMIC_TPS65217=y
-CONFIG_SPL_POWER_TPS65910=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_TIMER=y
-CONFIG_OMAP_TIMER=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_SPL_DM_USB_GADGET=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_TI=y
-CONFIG_USB_GADGET=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
-CONFIG_USB_ETHER=y
-CONFIG_SPL_USB_ETHER=y
-CONFIG_LZO=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index d243cb16e72..cabc181460a 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -13,6 +13,8 @@ CONFIG_AM335X_USB0_PERIPHERAL=y
 CONFIG_AM335X_USB1=y
 CONFIG_SPL=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
 CONFIG_DISTRO_DEFAULTS=y
@@ -119,5 +121,4 @@ CONFIG_SPL_USB_ETHER=y
 CONFIG_WDT=y
 # CONFIG_SPL_WDT is not set
 CONFIG_DYNAMIC_CRC_TABLE=y
-CONFIG_RSA=y
 CONFIG_LZO=y
diff --git a/doc/usage/fit/beaglebone_vboot.rst b/doc/usage/fit/beaglebone_vboot.rst
index cd6bb141910..1298ba1ae08 100644
--- a/doc/usage/fit/beaglebone_vboot.rst
+++ b/doc/usage/fit/beaglebone_vboot.rst
@@ -67,18 +67,20 @@ a. Set up the environment variable to point to your toolchain. You will need
 
        export CROSS_COMPILE=arm-linux-gnueabi-
 
-b. Configure and build U-Boot with verified boot enabled::
+b. Configure and build U-Boot with verified boot enabled. Note that we use the
+am335x_evm target since it covers all boards based on the AM335x evaluation
+board::
 
     export UBOOT=/path/to/u-boot
     cd $UBOOT
     # You can add -j10 if you have 10 CPUs to make it faster
-    make O=b/am335x_boneblack_vboot am335x_boneblack_vboot_config all
-    export UOUT=$UBOOT/b/am335x_boneblack_vboot
+    make O=b/am335x_evm am335x_evm_config all
+    export UOUT=$UBOOT/b/am335x_evm
 
 c. You will now have a U-Boot image::
 
-    file b/am335x_boneblack_vboot/u-boot-dtb.img
-    b/am335x_boneblack_vboot/u-boot-dtb.img: u-boot legacy uImage,
+    file b/am335x_evm/u-boot-dtb.img
+    b/am335x_evm/u-boot-dtb.img: u-boot legacy uImage,
       U-Boot 2014.07-rc2-00065-g2f69f8, Firmware/ARM, Firmware Image
       (Not compressed), 395375 bytes, Sat May 31 16:19:04 2014,
       Load Address: 0x80800000, Entry Point: 0x00000000,
@@ -466,7 +468,7 @@ the private key that you signed with so that it can verify any kernels that
 you sign::
 
     cd $UBOOT
-    make O=b/am335x_boneblack_vboot EXT_DTB=${WORK}/am335x-boneblack-pubkey.dtb
+    make O=b/am335x_evm EXT_DTB=${WORK}/am335x-boneblack-pubkey.dtb
 
 Here we are overriding the normal device tree file with our one, which
 contains the public key.
@@ -597,14 +599,11 @@ Further Improvements
 
 Several of the steps here can be easily automated. In particular it would be
 capital if signing and packaging a kernel were easy, perhaps a simple make
-target in the kernel.
+target in the kernel. A starting point for this is the 'make image.fit' target
+for ARM64 in Linux from v6.9 onwards.
 
 Some mention of how to use multiple .dtb files in a FIT might be useful.
 
-U-Boot's verified boot mechanism has not had a robust and independent security
-review. Such a review should look at the implementation and its resistance to
-attacks.
-
 Perhaps the verified boot feature could be integrated into the Amstrom
 distribution.
 
-- 
2.34.1

