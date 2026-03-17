Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B402CF3380D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 07:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 180C2840B5;
	Tue, 17 Mar 2026 08:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="sY5fnmDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AFA1840C1; Tue, 17 Mar 2026 08:40:48 +0100 (CET)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE50840B0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=06fT9k5xSFncv7ySDY6c8t5QgyOgg4vga4QnDITCb6s=;
 b=sY5fnmDXcMI9HatnOSkOcSrHmG4FXKDON61ULw1P1PRvEY5y7FLuZWeKnhj0+xAWk18g3kwN/vP4Zii/sE3wQoXNB+b7AaPb2RwmIWKzgtiLBxZGudqE4Sv/QtUJGgso5j0UH/jJKZZadk9D3n2ahCjDs/OHYUuOq9cgiYFo2hUpDeP0sQNoGNWWSPoizp9278fovRpc18tRKuQaxVZvJvz+Q6r3+06ZJdXeK7OXx361E9g8EOwFGC5lwO
 K4K9KwYjLnAJahvnmWKZi04mZGwBe4iFY1VqArOUMPa+IbKs2EDG5Sq7hK2A+VuQjUP7Ek+cw36ES5CWsA5zQGwJkyBw==
Received: from GRAPHRT (188-24-192-137.rdsnet.ro [188.24.192.137])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Tue, 17 Mar 2026 07:37:33 +0000
Date: Tue, 17 Mar 2026 09:37:35 +0200
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] USB: dwc2: allow usb start even if usbphy is not found
Message-ID: <abkEvwF8sSFyn+El@GRAPHRT>
References: <20260316092639.2377-1-m95d+git@psihoexpert.ro>
 <942c0020-e43d-4d86-b8c0-ccc8f7ed2b2c@kwiboo.se>
 <abgd9BByMlS6khBT@GRAPHRT>
 <822b68b9-e0a8-401f-a0b2-f4c66d1084d0@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822b68b9-e0a8-401f-a0b2-f4c66d1084d0@kwiboo.se>
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

On Mon, 2026-03-16 22.41.08 ++0100, Jonas Karlman wrote:
> I did a new runtime test on a Tinker Board R2.0 using master with
> tinker-rk3288_defconfig and I am not able to reproduce any issue. Maybe
> your config changes introduce a condition that causes an issue? Please
> share your savedefconfig.
> 
>
> I have re-run some tests with different Kconfig options related to
> GADGET and DWC2 and are not able to reproduce your issue.
> 
> As mentioned above, please share your config changes compared to tinker
> defconfig, maybe you have some Kconfig option enabled that make DWC2
> work differently?
> 
> 
>   U-Boot SPL 2026.04-rc4-00007-g010855c5005e (Mar 16 2026 - 21:33:53 +0000)
>   Trying to boot from RAM
>   ## Checking hash(es) for config conf-1 ... OK
>   ## Checking hash(es) for Image firmware-1 ... crc32+ OK
>   ## Checking hash(es) for Image fdt-1 ... crc32+ OK
>   spl_perform_arch_fixups: could not map BootROM boot device to ofpath
>   
>   
>   U-Boot 2026.04-rc4-00007-g010855c5005e (Mar 16 2026 - 21:33:53 +0000)
>   
>   SoC: Rockchip rk3288
>   Reset cause: POR
>   Model: Rockchip RK3288 Asus Tinker Board
>   DRAM:  2 GiB
>   PMIC:  RK808
>   Core:  221 devices, 27 uclasses, devicetree: separate
>   MMC:   mmc@ff0c0000: 1, mmc@ff0d0000: 2
>   Loading Environment from MMC... Card did not respond to voltage select! : -110
>   *** Warning - No block device, using default environment
>   
>   In:    serial,usbkbd
>   Out:   serial,vidconsole
>   Err:   serial,vidconsole
>   Net:   eth0: ethernet@ff290000
>   
>   Hit any key to stop autoboot: 0
>   => usb start
>   starting USB...
>   USB DWC2
>   USB DWC2
>   Bus usb@ff540000: 2 USB Device(s) found
>   Bus usb@ff580000: 1 USB Device(s) found
>          scanning usb for storage devices... 0 Storage Device(s) found
>   => usb tree
>   USB device tree:
>     1  Hub (480 Mb/s, 0mA)
>     |   U-Boot Root Hub
>     |
>     +-2  Hub (480 Mb/s, 100mA)
>           USB2.0 Hub
>   
>     1  Hub (480 Mb/s, 0mA)
>         U-Boot Root Hub
>   
>   => dm tree -e usb
>    Class     Seq    Probed  Driver                Name
>   -----------------------------------------------------------
>    usb           0  [ + ]   dwc2_usb              usb@ff540000
>    usb_hub       0  [ + ]   usb_hub               `-- usb_hub
>    usb_hub       1  [ + ]   usb_hub                   `-- usb_hub
>    usb           1  [ + ]   dwc2_usb              usb@ff580000
>    usb_hub       2  [ + ]   usb_hub               `-- usb_hub
>    pinconfig   130  [   ]   pinconfig             usb
>    pinconfig   131  [   ]   pinconfig             |-- host-vbus-drv
>    pinconfig   132  [   ]   pinconfig             `-- pwr-3g
>   =>
> 
> Regards,
> Jonas

That's strage and unexpected... I'll try to start again from defconfig.

My current config:

CONFIG_ARM=y
CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=y
CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
CONFIG_DRIVER_GICV2=y
CONFIG_ARCH_CPU_INIT=y
CONFIG_SYS_ARCH_TIMER=y
CONFIG_ARCH_ROCKCHIP=y
CONFIG_TEXT_BASE=0x01000000
CONFIG_SYS_MALLOC_F_LEN=0x4000
CONFIG_SPL_GPIO=y
CONFIG_NR_DRAM_BANKS=1
CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
CONFIG_ENV_SIZE=0x4000
# CONFIG_SPL_DM_SPI is not set
CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-tinker-s"
CONFIG_OF_LIBFDT_OVERLAY=y
CONFIG_DM_RESET=y
CONFIG_SYS_MONITOR_LEN=614400
CONFIG_ROCKCHIP_RK3288=y
CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0
# CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG is not set
CONFIG_TPL_LDSCRIPT="arch/arm/mach-rockchip/u-boot-tpl.lds"
CONFIG_TPL_SYS_MALLOC_F_LEN=0x4000
CONFIG_TARGET_TINKER_RK3288=y
# CONFIG_SPL_DRIVERS_MISC is not set
CONFIG_BOOTCOUNT_BOOTLIMIT=3
CONFIG_SPL_TEXT_BASE=0x0
CONFIG_SYS_BOOTM_LEN=0x4000000
CONFIG_SYS_LOAD_ADDR=0x800800
CONFIG_WATCHDOG_TIMEOUT_MSECS=120000
CONFIG_SPL_SIZE_LIMIT=0x4b000
CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0
CONFIG_PRE_CON_BUF_SZ=65536
CONFIG_DEBUG_UART_BASE=0xff690000
CONFIG_DEBUG_UART_CLOCK=24000000
CONFIG_IDENT_STRING="-M95D"
CONFIG_DEBUG_UART=y
CONFIG_LOCALVERSION="-M95D"
CONFIG_CC_OPTIMIZE_FOR_SPEED=y
CONFIG_HAS_BOARD_SIZE_LIMIT=y
CONFIG_BOARD_SIZE_LIMIT=12582912
CONFIG_DYNAMIC_SYS_CLK_FREQ=y
# CONFIG_EFI_LOADER is not set
CONFIG_TIMESTAMP=y
# CONFIG_BOOTSTD_DEFAULTS is not set
# CONFIG_BOOTSTD_BOOTCOMMAND is not set
# CONFIG_TPL_BOOTMETH_VBE is not set
CONFIG_BOOTDELAY=3
CONFIG_OF_ENV_SETUP=y
# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
CONFIG_USE_BOOTARGS=y
CONFIG_BOOTARGS="earlyprintk console=ttyS2,115200 rootwait root=PARTUUID=3c6300ea-04"
CONFIG_BOOTARGS_SUBST=y
CONFIG_USE_BOOTCOMMAND=y
CONFIG_BOOTCOMMAND="sysboot mmc 1:3 any 0x02000000 /extlinux/extlinux.conf"
CONFIG_USE_PREBOOT=y
CONFIG_PREBOOT=""
CONFIG_DEFAULT_FDT_FILE="rk3288-tinker-s.dtb"
CONFIG_LOGLEVEL=6
CONFIG_CONSOLE_FLUSH_ON_NEWLINE=y
# CONFIG_SYS_DEVICE_NULLDEV is not set
CONFIG_LOGF_FILE=y
CONFIG_LOGF_LINE=y
CONFIG_LOGF_FUNC=y
CONFIG_DISPLAY_BOARDINFO_LATE=y
CONFIG_MISC_INIT_R=y
CONFIG_SPL_NO_BSS_LIMIT=y
CONFIG_SPL_SHOW_ERRORS=y
# CONFIG_SPL_BINMAN_SYMBOLS is not set
CONFIG_SPL_I2C=y
# CONFIG_SYS_MMCSD_FS_BOOT is not set
CONFIG_SPL_POWER=y
# CONFIG_TPL_BINMAN_SYMBOLS is not set
# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
# CONFIG_TPL_DRIVERS_MISC is not set
CONFIG_HUSH_PARSER=y
CONFIG_SYS_MAXARGS=16
CONFIG_CMD_BDINFO_EXTRA=y
CONFIG_CMD_CONFIG=y
CONFIG_CMD_UFETCH=y
CONFIG_CMD_HISTORY=y
# CONFIG_CMD_HISTORY_USE_CALLOC is not set
CONFIG_CMD_BOOTDEV=y
CONFIG_CMD_BOOTMETH=y
CONFIG_CMD_BOOTSTD=y
CONFIG_CMD_BOOTZ=y
# CONFIG_BOOTM_NETBSD is not set
# CONFIG_BOOTM_PLAN9 is not set
# CONFIG_BOOTM_RTEMS is not set
# CONFIG_BOOTM_VXWORKS is not set
CONFIG_CMD_BOOTMENU=y
CONFIG_CMD_ADTIMG=y
# CONFIG_CMD_ELF is not set
# CONFIG_CMD_GO is not set
# CONFIG_CMD_XIMG is not set
CONFIG_CMD_ASKENV=y
CONFIG_CMD_GREPENV=y
CONFIG_CMD_ERASEENV=y
CONFIG_CMD_ENV_FLAGS=y
CONFIG_CMD_NVEDIT_INDIRECT=y
CONFIG_CMD_NVEDIT_INFO=y
CONFIG_CMD_NVEDIT_LOAD=y
CONFIG_CRC32_VERIFY=y
CONFIG_CMD_EEPROM=y
CONFIG_CMD_EEPROM_LAYOUT=y
CONFIG_SYS_I2C_EEPROM_BUS=2
CONFIG_CMD_MEMINFO=y
CONFIG_CMD_MEMINFO_MAP=y
# CONFIG_CMD_RANDOM is not set
CONFIG_CMD_CLK=y
CONFIG_CMD_GPIO=y
CONFIG_CMD_GPIO_READ=y
CONFIG_CMD_I2C=y
# CONFIG_CMD_LOADB is not set
# CONFIG_CMD_LOADS is not set
CONFIG_CMD_LSBLK=y
CONFIG_CMD_MISC=y
CONFIG_CMD_MMC=y
CONFIG_MMC_SPEED_MODE_SET=y
CONFIG_CMD_PART=y
# CONFIG_CMD_PINMUX is not set
CONFIG_CMD_POWEROFF=y
CONFIG_CMD_SDRAM=y
CONFIG_CMD_USB=y
CONFIG_CMD_WDT=y
CONFIG_CMD_CAT=y
# CONFIG_CMD_SETEXPR is not set
CONFIG_BOOTP_MAY_FAIL=y
# CONFIG_BOOTP_DNS is not set
# CONFIG_BOOTP_GATEWAY is not set
# CONFIG_BOOTP_HOSTNAME is not set
# CONFIG_BOOTP_PXE_DHCP_OPTION is not set
CONFIG_CMD_TFTPPUT=y
CONFIG_CMD_TFTPSRV=y
CONFIG_CMD_NFS=y
CONFIG_CMD_DHCP=y
CONFIG_CMD_PING=y
CONFIG_CMD_PXE=y
CONFIG_CMD_BOOTCOUNT=y
# CONFIG_CMD_BLOCK_CACHE is not set
CONFIG_CMD_TIMER=y
CONFIG_CMD_SYSBOOT=y
CONFIG_CMD_PMIC=y
CONFIG_CMD_REGULATOR=y
CONFIG_CMD_EXT2=y
CONFIG_CMD_EXT4=y
CONFIG_CMD_EXT4_WRITE=y
CONFIG_CMD_FAT=y
CONFIG_CMD_FS_GENERIC=y
# CONFIG_CMD_CYCLIC is not set
CONFIG_CMD_LOG=y
# CONFIG_SPL_DOS_PARTITION is not set
CONFIG_SPL_OF_CONTROL=y
CONFIG_OF_LIVE=y
CONFIG_OF_UPSTREAM=y
CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
CONFIG_OF_DTB_PROPS_REMOVE=y
CONFIG_ENV_OVERWRITE=y
CONFIG_ENV_IS_IN_EXT4=y
CONFIG_ENV_EXT4_INTERFACE="mmc"
CONFIG_ENV_EXT4_DEVICE_AND_PART=":3"
CONFIG_ENV_MMC_DEVICE_INDEX=1
CONFIG_USE_HOSTNAME=y
CONFIG_HOSTNAME="TkB"
CONFIG_NET_RETRY_COUNT=3
CONFIG_TFTP_TSIZE=y
CONFIG_UDP_CHECKSUM=y
CONFIG_BOOTP_SERVERIP=y
CONFIG_USE_IPADDR=y
CONFIG_IPADDR="172.27.143.5"
CONFIG_USE_NETMASK=y
CONFIG_NETMASK="255.255.255.0"
CONFIG_NET_RANDOM_ETHADDR=y
CONFIG_SYS_RX_ETH_BUFFER=8
CONFIG_REGMAP=y
CONFIG_SPL_REGMAP=y
CONFIG_SYSCON=y
CONFIG_SPL_SYSCON=y
# CONFIG_SIMPLE_BUS is not set
# CONFIG_SPL_SIMPLE_BUS is not set
# CONFIG_OF_TRANSLATE is not set
# CONFIG_ADC is not set
CONFIG_BOOTCOUNT_LIMIT=y
CONFIG_BOOTCOUNT_ENV=y
CONFIG_BOOTCOUNT_ALTBOOTCMD="ext2load mmc 1:3 $kernel_addr_r vmlinuz.failsafe; ext2load mmc 1:3 $fdt_addr_r $fdtfile.failsafe; bootz $kernel_addr_r - $fdt_addr_r"
CONFIG_SYS_BOOTCOUNT_MAGIC=0xB007C047
CONFIG_BUTTON=y
CONFIG_BUTTON_GPIO=y
CONFIG_CLK=y
CONFIG_SPL_CLK=y
CONFIG_EXTCON=y
CONFIG_ROCKCHIP_GPIO=y
CONFIG_SYS_I2C_ROCKCHIP=y
CONFIG_LED=y
CONFIG_LED_BOOT=y
CONFIG_LED_ACTIVITY=y
CONFIG_LED_SW_BLINK=y
CONFIG_LED_GPIO=y
CONFIG_MEMORY=y
CONFIG_MISC=y
# CONFIG_SPL_MISC is not set
# CONFIG_TPL_MISC is not set
CONFIG_ROCKCHIP_EFUSE=y
CONFIG_PWRSEQ=y
CONFIG_I2C_EEPROM=y
CONFIG_MMC_PWRSEQ=y
CONFIG_MMC_BROKEN_CD=y
CONFIG_SUPPORT_EMMC_BOOT=y
CONFIG_MMC_IO_VOLTAGE=y
CONFIG_MMC_UHS_SUPPORT=y
CONFIG_MMC_HS400_ES_SUPPORT=y
CONFIG_MMC_HS400_SUPPORT=y
CONFIG_MMC_DW=y
CONFIG_MMC_DW_ROCKCHIP=y
# CONFIG_MTD is not set
CONFIG_PHY_GIGE=y
CONFIG_ETH_DESIGNWARE=y
CONFIG_GMAC_ROCKCHIP=y
CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
CONFIG_PINCTRL=y
# CONFIG_PINMUX is not set
CONFIG_PINCONF=y
CONFIG_SPL_PINCTRL=y
# CONFIG_SPL_PINCTRL_FULL is not set
CONFIG_DM_PMIC=y
CONFIG_PMIC_RK8XX=y
CONFIG_SPL_PMIC_RK8XX=y
CONFIG_SPL_DM_REGULATOR=y
CONFIG_DM_REGULATOR_FIXED=y
CONFIG_SPL_DM_REGULATOR_FIXED=y
CONFIG_REGULATOR_RK8XX=y
# CONFIG_DM_PWM is not set
CONFIG_RAM=y
CONFIG_SPL_RAM=y
# CONFIG_RAM_ROCKCHIP_DEBUG is not set
CONFIG_SERIAL_PUTS=y
CONFIG_DEBUG_UART_SHIFT=2
CONFIG_DEBUG_UART_ANNOUNCE=y
CONFIG_SYS_NS16550_MEM32=y
# CONFIG_SPI is not set
CONFIG_SYSRESET=y
CONFIG_USB=y
# CONFIG_SPL_DM_USB is not set
CONFIG_USB_DWC2=y
CONFIG_ROCKCHIP_USB2_PHY=y
CONFIG_USB_STORAGE=y
CONFIG_USB_KEYBOARD=y
CONFIG_USB_KEYBOARD_FN_KEYS=y
CONFIG_VIDEO=y
CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE=0x1FA4000
CONFIG_VIDEO_COPY=y
CONFIG_VIDEO_ANSI=y
CONFIG_I2C_EDID_STANDARD=y
CONFIG_DISPLAY=y
CONFIG_VIDEO_ROCKCHIP=y
CONFIG_DISPLAY_ROCKCHIP_LVDS=y
CONFIG_DISPLAY_ROCKCHIP_HDMI=y
CONFIG_DISPLAY_ROCKCHIP_MIPI=y
CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
CONFIG_VIDEO_BRIDGE=y
CONFIG_VIDEO_BRIDGE_LVDS_CODEC=y
CONFIG_CONSOLE_SCROLL_LINES=8
CONFIG_DESIGNWARE_WATCHDOG=y
CONFIG_WDT=y
CONFIG_FAT_RENAME=y
# CONFIG_BINMAN_FDT is not set
CONFIG_CC_OPTIMIZE_LIBS_FOR_SPEED=y
# CONFIG_REGEX is not set
# CONFIG_SPL_SHA1 is not set
CONFIG_ERRNO_STR=y
CONFIG_OF_LIBFDT_ASSUME_MASK=0
# CONFIG_TPL_OF_LIBFDT is not set
# CONFIG_TOOLS_LIBCRYPTO is not set
# CONFIG_TOOLS_KWBIMAGE is not set

Marius

