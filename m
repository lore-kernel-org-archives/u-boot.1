Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9D5CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2429183835;
	Fri, 29 Aug 2025 16:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EH03h3U7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BFC5834AD; Fri, 29 Aug 2025 08:47:12 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE2283447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-61c51f57224so2555082a12.2
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 23:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756450029; x=1757054829; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WajDkOhraTUlQnlRA0tcn3M0TZSAYLWGQOjpBf79nis=;
 b=EH03h3U7HDDANf2QnJZ2RcT8uDvifVL6DlBxzuLh8RlUtEZL2zuVlBE8ueE1sDsd6L
 M8te9luAKUb62pJ1kV7kwFSDgtaj73M7WW1kLcwbKcl9X/IBNX5ew2D+MdZk/3bZ0Sx3
 VpPsmBnrZa/jAuzUgautg1LiMNN7rpt5mCYR07GaN9BzRfQzYAC0TtmNqtA/QV/OHwXA
 4xxukqTDEiXL+Qy2OZITyV5CpeAUHEQtup9z2eeN3NtBUpINwNEvkD6q7yPVl8xq2vcd
 hylgcBLYpNscPxRN5skp1puzrO/PTpNBps6xzXn08ADQy1lNdrjR/Um5BjpBnCgOZOt9
 Z/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756450029; x=1757054829;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WajDkOhraTUlQnlRA0tcn3M0TZSAYLWGQOjpBf79nis=;
 b=bjoBLkAhGzbFKh/qbN6mqSxpUjcSxsVSiSRA/sW7rv7JL8OkEG4I2GXl0ezbanpK/e
 D0ZAr3jJfCd0ygsbgjQC27SnQxGsY7aaA+FuVt7WJfhoPPE/En2oeI9/DL+dVACzaPAz
 TzryYgots0xQwZJCv+aIEBaDT7ulUPoerMaIu4psPK0rRskJMqz+m0gpzUruUN+h9dhB
 Ux5THgjfX15Bm1+CjbqgOQDiToZ2ohBUEw0VpRA/buYt3qAqxLj9rBP2V4ecbMhULg5y
 zN2onZDsm+aPHtKPMhcpIb7OfKhshNeORG3zvYRH1H0wsH/Tgz6VUh/egYzip8DLJs4c
 EhgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3k9KXUy/GBb+rM6+5A4VEib6PKpfvX18WU+fGZUj5nDYPDtcaXNa/X2D/iA4KCTA9OSDmKjQ=@lists.denx.de
X-Gm-Message-State: AOJu0YydPB+trWAltvvEj7gkYRjHoTIj6hxovYLFsX8WZn+5hUaXCCBp
 xfOnYEAtiRZkpmfTDX/WgAkB27KHekZYdeY3SDtWTDOa2JynPiTJeVANIy09EbMHbg9VYXutKU2
 vJiV5km/lnEcaopv4TMtcdoL7ed7mo55z5JSvrqg=
X-Gm-Gg: ASbGncvlja9TDOrLdn3tw+1WjoMyPV4yxe2RfKRcDARXQXCjZkRFQ8NSrcVxDC6Dfv0
 909Q4RXKhuEtZxHrJciF2uvzlHLBZIDrqOR2TYvtFKi193TZXx/+cOs87SwxZYeuTRpD5kscxxi
 uReXWFyHIS+ILznLIsFen1ksz9xjgbgF0wTATlJAxerXYgtEndkHW7+KMZQSOxA3b5nGbkrPPY+
 7EL5c5OYiovFL7tOw==
X-Google-Smtp-Source: AGHT+IFfjTmN8PPc/0464BayeZUy0J5RSbBqE0yJqvL2FL98e00oJUw71t7DzV4LfQ9GAypJM5hNsdONNdKzb7HhqAU=
X-Received: by 2002:a05:6402:5208:b0:61c:78dc:9fc6 with SMTP id
 4fb4d7f45d1cf-61c78dcb23cmr12375692a12.4.1756450029116; Thu, 28 Aug 2025
 23:47:09 -0700 (PDT)
MIME-Version: 1.0
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Fri, 29 Aug 2025 12:16:57 +0530
X-Gm-Features: Ac12FXyGA1nPWJJbcoDMAQztR6rEo5EBvXA6_7jTMoLC4dXWQ9YPKqCfK0DVqC8
Message-ID: <CAJE-K+AQucBKAUODYnw1xQkOKcXU17VgDVrGtzOEjTRtSTsmaw@mail.gmail.com>
Subject: Falcon on bb-black: SPL jumps to 'u-boot.img',
 although 'args' file exists.
To: "trini@konsulko.com" <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

Greetings Tom,
Requesting a tiny help.
A have read u-boots documentation on FALCON, and also consulted
doc/board/ti/am335x_evm.rst and some examples from bootlin doc on falcon[1].

I am unable to understand why falcon_image_file and
falcon_args_file are not being loaded, I have boot_os=yes. I have followed the
FAT SD cards section of your Documentation, yet I am finding that SPL is
loading u-boot.img from SD-card.

My config is as follows:
CONFIG_ARM=y
CONFIG_ARCH_CPU_INIT=y
CONFIG_ARCH_OMAP2PLUS=y
CONFIG_TI_COMMON_CMD_OPTIONS=y
CONFIG_SF_DEFAULT_SPEED=24000000
CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
CONFIG_AM33XX=y
CONFIG_CLOCK_SYNTHESIZER=y
CONFIG_AM335X_USB0=y
CONFIG_AM335X_USB0_PERIPHERAL=y
CONFIG_AM335X_USB1=y
CONFIG_SYS_BOOTM_LEN=0x1000000
CONFIG_SPL=y
CONFIG_TIMESTAMP=y
CONFIG_FIT_SIGNATURE=y
CONFIG_FIT_VERBOSE=y
CONFIG_SPL_LOAD_FIT=y
CONFIG_DISTRO_DEFAULTS=y
CONFIG_OF_BOARD_SETUP=y
CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run
distro_bootcmd"
CONFIG_LOGLEVEL=3
CONFIG_SYS_CONSOLE_INFO_QUIET=y
CONFIG_SPL_SYS_MALLOC=y
CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
CONFIG_SPL_FIT_IMAGE_TINY=y
CONFIG_SPL_ETH=y
# CONFIG_SPL_FS_EXT4 is not set
CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
CONFIG_SPL_MTD=y
CONFIG_SPL_MUSB_NEW=y
CONFIG_SPL_NAND_DRIVERS=y
CONFIG_SPL_NAND_ECC=y
CONFIG_SPL_NAND_BASE=y
CONFIG_SPL_NET=y
CONFIG_SPL_NET_VCI_STRING="AM335x U-Boot SPL"
CONFIG_SPL_OS_BOOT=y
CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x200000
CONFIG_SPL_FALCON_BOOT_MMCSD=y
CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
CONFIG_CMD_EXTENSION=y
CONFIG_CMD_SPL=y
CONFIG_CMD_SPL_NAND_OFS=0x00080000
CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
CONFIG_CMD_NAND=y
# CONFIG_CMD_SETEXPR is not set
CONFIG_BOOTP_DNS2=y
CONFIG_CMD_MTDPARTS=y
CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
# CONFIG_SPL_EFI_PARTITION is not set
CONFIG_OF_CONTROL=y
CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe
am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi
am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2
am335x-pocketbeagle am335x-bonegreen-eco"
CONFIG_ENV_OVERWRITE=y
CONFIG_ENV_RELOC_GD_ENV_ADDR=y
CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
CONFIG_SPL_ENV_IS_NOWHERE=y
CONFIG_VERSION_VARIABLE=y
CONFIG_NET_RETRY_COUNT=10
CONFIG_BOOTP_SEND_HOSTNAME=y
CONFIG_BOOTCOUNT_LIMIT=y
CONFIG_SYS_BOOTCOUNT_BE=y
CONFIG_CLK=y
CONFIG_CLK_CDCE9XX=y
CONFIG_CLK_TI_CTRL=y
CONFIG_DFU_TFTP=y
CONFIG_DFU_MMC=y
CONFIG_DFU_NAND=y
CONFIG_DFU_RAM=y
CONFIG_USB_FUNCTION_FASTBOOT=y
CONFIG_FASTBOOT_FLASH=y
CONFIG_FASTBOOT_FLASH_MMC_DEV=1
CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
CONFIG_DM_I2C=y
CONFIG_MISC=y
CONFIG_SYS_I2C_EEPROM_ADDR=0x50
# CONFIG_MMC_HW_PARTITIONING is not set
CONFIG_MMC_OMAP_HS=y
CONFIG_MTD=y
CONFIG_MTD_RAW_NAND=y
CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
CONFIG_SYS_NAND_ONFI_DETECTION=y
CONFIG_SYS_NAND_PAGE_SIZE=0x800
CONFIG_SYS_NAND_OOBSIZE=0x40
CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
CONFIG_DM_SPI_FLASH=y
CONFIG_SPI_FLASH_STMICRO=y
CONFIG_SPI_FLASH_WINBOND=y
CONFIG_PHY_ATHEROS=y
CONFIG_PHY_SMSC=y
CONFIG_PHY_TI_DP83867=y
CONFIG_PHY_GIGE=y
CONFIG_MII=y
CONFIG_DRIVER_TI_CPSW=y
CONFIG_DM_PMIC=y
# CONFIG_SPL_DM_PMIC is not set
CONFIG_PMIC_TPS65217=y
CONFIG_SPL_POWER_TPS65910=y
CONFIG_SPI=y
CONFIG_DM_SPI=y
CONFIG_OMAP3_SPI=y
CONFIG_TIMER=y
CONFIG_OMAP_TIMER=y
CONFIG_USB=y
CONFIG_DM_USB_GADGET=y
CONFIG_SPL_DM_USB_GADGET=y
CONFIG_USB_MUSB_HOST=y
CONFIG_USB_MUSB_GADGET=y
CONFIG_USB_MUSB_TI=y
CONFIG_USB_GADGET=y
CONFIG_SPL_USB_GADGET=y
CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
CONFIG_USB_GADGET_VENDOR_NUM=0x0451
CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
CONFIG_USB_ETHER=y
CONFIG_SPL_USB_ETHER=y
CONFIG_WDT=y
# CONFIG_SPL_WDT is not set
CONFIG_DYNAMIC_CRC_TABLE=y
CONFIG_LZO=y

Refs:
[1] https://bootlin.com/pub/conferences/2021/lee/opdenacker-understanding-u-boot-falcon-mode/opdenacker-understanding-u-boot-falcon-mode.pdf
-- 
Thanks,
Sidharth Seela
