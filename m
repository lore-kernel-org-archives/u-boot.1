Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C51CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E99583BB5;
	Thu,  6 Nov 2025 14:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="K+vAZsOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C441883B4E; Thu,  6 Nov 2025 08:46:41 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD10083B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 08:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b727f330dd2so109499566b.2
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 23:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762415199; x=1763019999;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcS16YEE1OZVnadKqhultAPwuSd1BAnq50io3W/3h7M=;
 b=K+vAZsOiN4ZLQJWX1/qyFQtb/M2bEbw2utKJFYn0I6k+Oa5J37mPcvaq2fauuWqxBs
 DLHu55T2m3nKFJt0+LN2rwHZG+DnVxGmFsidbWDQ+q/2JEV8XVqEtO0vzoDl2t9g6S+f
 ss2GPzlqtaesQK7g+kN2AWsxLGjMiA3hcTc+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762415199; x=1763019999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZcS16YEE1OZVnadKqhultAPwuSd1BAnq50io3W/3h7M=;
 b=ZdVUaRpJ/Vyvn++MFGymIcoGh966ToXINvICugtj7AvoHgUERzGRo4YOjCEvDqd1+Q
 gZ1wjOj32mppX/9rP0nBgO/C+nZgs+MIzjXufI6VdP1/r7ZL+5wACzXueKY2VEitvwVH
 yMRHF7aPNW2LrBx1ZvgTVg8v1qssH3h/4g59+dTbfQmiV6BFmEdk1RMwWbaWpP31qV3N
 2ANVwoJiApsIKXhBNeJ9HS9rwVyNBLZWJscxxiCa2eeHFoTTjlNimlqPrLr42D/6dQvE
 YChDZgYRuJC0ne50L0UFEtr2Gs/sGilxTXaweQk01rDWMJRtxLMv7/9SuF0Xg58G1aEH
 PYYw==
X-Gm-Message-State: AOJu0Yz90enVL69ox34JICJIzDK6YMsr/1LGix7WeJvqjmFWI9KILypf
 9dgXZnBGBs4/HcqykM53JGDJ4BJw1ZWkhygPaL0g4y4HMrOeeZMUp/Ak4gF27LLtOObT5OB51yD
 sK4Dj0467pw==
X-Gm-Gg: ASbGnctEIY/6mwWPsFORJS8TMudL7ywjhxmSfmFK/gDTRzmtoLW0QAQsXvg1jXyIrlS
 lMjHwl1Xpj0wJ1i5n5/CB24ABhrPaUM8TU8zcU40QdaSTzrVhK8MaZ7Au/qlUrey5RuqNkEaIWf
 ykEY+N7QKqzezjmlZWH5u13ITguzekepAcVBUGxLpr8gTZjiEs9Pz5wbwiGmTzi6L/+mbbZXkEB
 dtU9Fyw3CgrdNl6zy6m88+kI9v2ioEk43+ANGkdnoB2NNFMTrfOsQxMLJaMTbHsEfPBdoQU68XY
 Y3NhSPVDD9HQKy9iYoFLXwjoSUEH5C7hYYT6nGWwTgh68kJ+mh6y7pVYrFnKsQ04vHWRWUx7d00
 o9OWqzIN+tz1sJZgUv8+sWaxINOeMUEVuyiAJ36G0ICz2+JK08bofke8yLJOf56s6eBRbrza8ig
 iD8SFxqNQ5sk0EyFY0FUOApob8fiF0z5i5R1Gl0zv1Mupk96Q11blw6kGsMM37YKcvnpI=
X-Google-Smtp-Source: AGHT+IFAuVsg4+mIvNmsrVryD8tuWGNWwlW0VaFMjznUPeThQerYDtNLAjSUZCmdz4jvidxVjekgPw==
X-Received: by 2002:a17:907:3c93:b0:b72:5819:7f64 with SMTP id
 a640c23a62f3a-b72655abdfdmr711862366b.52.1762415198911; 
 Wed, 05 Nov 2025 23:46:38 -0800 (PST)
Received: from andrea-amarula.home (98-215-98-95.ftth.glasoperator.nl.
 [95.98.215.98]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72896837fesm149465966b.62.2025.11.05.23.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 23:46:38 -0800 (PST)
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
To: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, trini@konsulko.com, festevam@gmail.com
Cc: andrea.calabrese@amarulasolutions.com
Subject: [PATCH 1/2] bsh: make common configuration for m2
Date: Thu,  6 Nov 2025 08:46:31 +0100
Message-ID: <20251106074632.244150-1-andrea.calabrese@amarulasolutions.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Nov 2025 14:09:26 +0100
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

Since M2 and M2B share the same defconfig aside from one parameter, we
have a common configuration that also allows us to support addition of
new boards based on the M2 hardware.

Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>

diff --git a/configs/imx6ulz_smm_m2.config b/configs/imx6ulz_smm_m2.config
new file mode 100644
index 00000000000..67c1ca33074
--- /dev/null
+++ b/configs/imx6ulz_smm_m2.config
@@ -0,0 +1,81 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MX6=y
+CONFIG_TEXT_BASE=0x87800000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x18000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x400000
+CONFIG_MX6ULL=y
+CONFIG_TARGET_MX6ULZ_SMM_M2=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ulz-bsh-smm-m2"
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_BSS_START_ADDR=0x84100000
+CONFIG_SPL=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_NAND_SUPPORT=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nand0=gpmi-nand"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:4m(nandboot),1m(env),8m(kernel),1m(nanddtb),-(rootfs)"
+CONFIG_CMD_UBI=y
+# CONFIG_ISO_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_NAND=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_NO_NET=y
+CONFIG_BOUNCE_BUFFER=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_IMX6UL=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x82000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_SYS_I2C_MXC=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_NAND_USE_FLASH_BBT=y
+CONFIG_NAND_MXS=y
+CONFIG_NAND_MXS_DT=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x111400
+CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x291400
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_IMX_THERMAL=y
+CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="BSH"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x877fffc0
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 67c1ca33074..50dafd887f2 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -1,81 +1 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x87800000
-CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_SYS_MALLOC_F_LEN=0x18000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x400000
-CONFIG_MX6ULL=y
-CONFIG_TARGET_MX6ULZ_SMM_M2=y
-CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ulz-bsh-smm-m2"
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_BSS_START_ADDR=0x84100000
-CONFIG_SPL=y
-CONFIG_FIT=y
-CONFIG_FIT_SIGNATURE=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=3
-CONFIG_BOARD_LATE_INIT=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_DMA=y
-CONFIG_SPL_MTD=y
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_SDP=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=gpmi-nand"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:4m(nandboot),1m(env),8m(kernel),1m(nanddtb),-(rootfs)"
-CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_NO_NET=y
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_CLK_COMPOSITE_CCF=y
-CONFIG_CLK_IMX6UL=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x82000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_UUU_SUPPORT=y
-CONFIG_SYS_I2C_MXC=y
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_USE_FLASH_BBT=y
-CONFIG_NAND_MXS=y
-CONFIG_NAND_MXS_DT=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x111400
-CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x291400
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_IMX6=y
-CONFIG_DM_PMIC=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_MXC_UART=y
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_IMX_THERMAL=y
-CONFIG_USB=y
-CONFIG_SPL_USB_HOST=y
-CONFIG_USB_GADGET=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="BSH"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
-CONFIG_CI_UDC=y
-CONFIG_SDP_LOADADDR=0x877fffc0
-CONFIG_SPL_USB_SDP_SUPPORT=y
-CONFIG_IMX_WATCHDOG=y
+#include <configs/imx6ulz_smm_m2.config>
diff --git a/configs/imx6ulz_smm_m2b_defconfig b/configs/imx6ulz_smm_m2b_defconfig
index 3bd89206c5c..65802ae8f34 100644
--- a/configs/imx6ulz_smm_m2b_defconfig
+++ b/configs/imx6ulz_smm_m2b_defconfig
@@ -1,82 +1,2 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x87800000
-CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_SYS_MALLOC_F_LEN=0x18000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x400000
-CONFIG_MX6ULL=y
-CONFIG_TARGET_MX6ULZ_SMM_M2=y
+#include <configs/imx6ulz_smm_m2.config>
 CONFIG_BSH_M2B_MEMORY=y
-CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ulz-bsh-smm-m2"
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_BSS_START_ADDR=0x84100000
-CONFIG_SPL=y
-CONFIG_FIT=y
-CONFIG_FIT_SIGNATURE=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=3
-CONFIG_BOARD_LATE_INIT=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_DMA=y
-CONFIG_SPL_MTD=y
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_SDP=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=gpmi-nand"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:4m(nandboot),1m(env),8m(kernel),1m(nanddtb),-(rootfs)"
-CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_NO_NET=y
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_CLK_COMPOSITE_CCF=y
-CONFIG_CLK_IMX6UL=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x82000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_UUU_SUPPORT=y
-CONFIG_SYS_I2C_MXC=y
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_USE_FLASH_BBT=y
-CONFIG_NAND_MXS=y
-CONFIG_NAND_MXS_DT=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x111400
-CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x291400
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_IMX6=y
-CONFIG_DM_PMIC=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_MXC_UART=y
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_IMX_THERMAL=y
-CONFIG_USB=y
-CONFIG_SPL_USB_HOST=y
-CONFIG_USB_GADGET=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="BSH"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
-CONFIG_CI_UDC=y
-CONFIG_SDP_LOADADDR=0x877fffc0
-CONFIG_SPL_USB_SDP_SUPPORT=y
-CONFIG_IMX_WATCHDOG=y
-- 
2.48.1

