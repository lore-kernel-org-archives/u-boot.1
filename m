Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAABCF887E
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 15:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0C0889BD;
	Sat,  5 Oct 2024 17:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="krttoq0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A7E8891B; Sat,  5 Oct 2024 17:16:48 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C300B889BD
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 17:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c8a2579d94so3624781a12.0
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728141406; x=1728746206;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpPNn9sHNkI1XmDeuApKVgBa8iDkqlxS7GeJEGagHgc=;
 b=krttoq0/MZl6CEcXEiwHQ4ybBec0/hrfI+LR6xq/hzjEVN+eS+1ROu8S8KOkviCeBy
 2zzw70geigEh7nFjk6Ot6y+UBZS5rFHZQIh7tS77rGfIeT8LjBkeAtIxk6dIsqUe+uTN
 1ZNFgYJehtvyPgKzERqLarpKzDgcy1lzzXBHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141406; x=1728746206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpPNn9sHNkI1XmDeuApKVgBa8iDkqlxS7GeJEGagHgc=;
 b=RQ2UB+iUghUpye9OMuzZz3+Ynmw+6+Hx2GfGaS3W5hYawX3QDQjhS2io/bn8cLqUkq
 OXjk5a1z/Ukj456RdwomFrhc+4s0svdPz1K87S6dRK5hMKrkTib+fQx4/+J5n1CxEpO6
 G2RmMZDbySNdiIZ6egKM6IwktV6Lrum4UzTqXGVVf3VS6UyyubVuS5hd6R+MbL3IsE2N
 mATr0oxQc00/M1GHd2UjbU5NOi1wl782PxxSBY7e4DqlzUlNEcz3bJvZAy3PyJ2HthrQ
 XCC64F3wKiQ6cXs1t6b3ps6FdY+n58tZ7zoQjtfDfnhkXZXS79Aitnz0lViTOO9HfFy0
 FB4A==
X-Gm-Message-State: AOJu0YxEZ2WEfdjgV5EBK6u+fpUaeebxDwzTo3o+7YIAkc/BHE2LOCxG
 WaYHCLccfR1bmEJJGJg9bcpMMrphirYh2jHyFX4qbFN6Q8qtXMPzbvj9qHLJ99JDKYJZM7TxXvb
 KFkkJO4zs0okBJ5odX+t7fJnEKa8jQLRMZ6qYDw==
X-Google-Smtp-Source: AGHT+IHBt1R7QRv6yTUBDZCop0M0syeTEnGPJo65Nj8kpFbWibY9Drb0V9Z//VDmeOt+fL5RrhG8r+SnEbj6NadnN8g=
X-Received: by 2002:a05:6402:4490:b0:5c7:1922:d774 with SMTP id
 4fb4d7f45d1cf-5c8d2e87687mr4989105a12.25.1728141406212; Sat, 05 Oct 2024
 08:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
 <20240919035512.13854-15-dinesh.maniyam@intel.com>
In-Reply-To: <20240919035512.13854-15-dinesh.maniyam@intel.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 5 Oct 2024 17:16:33 +0200
Message-ID: <CAOf5uwmWNC+eMYHu0M1aMjFS9hQMAH=4DE4Ht3jkwmHm9aB2rA@mail.gmail.com>
Subject: Re: [PATCH 14/19] configs: nand2_defconfig: Enable configs for nand
 boot
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Alexander Dahl <ada@thorsis.com>, William Zhang <william.zhang@broadcom.com>, 
 Igor Prusov <ivprusov@salutedevices.com>, Tien Fong <tien.fong.chee@intel.com>,
 Kok Kiang <kok.kiang.hea@intel.com>, Boon Khai <boon.khai.ng@intel.com>, 
 Alif <alif.zakuan.yuslaimi@intel.com>, Teik Heng <teik.heng.chong@intel.com>, 
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Tingting Meng <tingting.meng@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

On Thu, Sep 19, 2024 at 5:56=E2=80=AFAM <dinesh.maniyam@intel.com> wrote:
>
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> This patch is to enable configs for nand boot.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  configs/socfpga_agilex5_nand2_defconfig | 169 ++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 configs/socfpga_agilex5_nand2_defconfig
>
> diff --git a/configs/socfpga_agilex5_nand2_defconfig b/configs/socfpga_ag=
ilex5_nand2_defconfig
> new file mode 100644
> index 0000000000..9e5a75194a
> --- /dev/null
> +++ b/configs/socfpga_agilex5_nand2_defconfig
> @@ -0,0 +1,169 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SPL_LDSCRIPT=3D"arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
> +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x04000000
> +CONFIG_ARCH_SOCFPGA=3Dy
> +CONFIG_TEXT_BASE=3D0x80200000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x4000
> +CONFIG_NR_DRAM_BANKS=3D2
> +CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_ENV_OFFSET=3D0x04100000
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
> +CONFIG_SPL_MMC=3Dy
> +CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=3Dy
> +CONFIG_TARGET_SOCFPGA_AGILEX5_NAND2=3Dy
> +CONFIG_QPDS_HPS_HANDOFF=3Dy
> +CONFIG_IDENT_STRING=3D"socfpga_agilex5"
> +CONFIG_SPL_FS_FAT=3Dy
> +CONFIG_DISTRO_DEFAULTS=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
> +CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x82000000
> +# CONFIG_USE_SPL_FIT_GENERATOR is not set
> +CONFIG_QSPI_BOOT=3Dy
> +CONFIG_BOOTDELAY=3D5
> +CONFIG_USE_BOOTARGS=3Dy
> +CONFIG_BOOTARGS=3D"earlycon panic=3D-1 root=3D${nandroot} rw rootwait ro=
otfstype=3Dubifs ubi.mtd=3D1"
> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_CRC32=3Dy
> +CONFIG_SPL_CACHE=3Dy
> +CONFIG_SPL_ATF=3Dy
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> +CONFIG_SYS_PROMPT=3D"SOCFPGA_AGILEX5 # "
> +CONFIG_CMD_NVEDIT_SELECT=3Dy
> +CONFIG_CMD_MEMTEST=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dn
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_SF=3Dy
> +CONFIG_PHY=3Dy
> +CONFIG_SPL_PHY=3Dy
> +CONFIG_NOP_PHY=3Dy
> +CONFIG_SPL_NOP_PHY=3Dy
> +CONFIG_PHY_CADENCE_COMBOPHY=3Dn
> +CONFIG_SPL_PHY_CADENCE_COMBOPHY=3Dn
> +CONFIG_MMC=3Dy
> +CONFIG_MMC_WRITE=3Dy
> +# CONFIG_MMC_BROKEN_CD is not set
> +CONFIG_DM_MMC=3Dy
> +CONFIG_SPL_DM_MMC=3Dy
> +CONFIG_MMC_SDHCI_ADMA_HELPERS=3Dy
> +# CONFIG_ARM_PL180_MMCI is not set
> +CONFIG_MMC_QUIRKS=3Dy
> +CONFIG_SYS_MMC_MAX_BLK_COUNT=3D65535
> +CONFIG_MMC_HW_PARTITIONING=3Dy
> +# CONFIG_SUPPORT_EMMC_RPMB is not set
> +# CONFIG_SUPPORT_EMMC_BOOT is not set
> +# CONFIG_MMC_IO_VOLTAGE is not set
> +# CONFIG_MMC_HS400_ES_SUPPORT is not set
> +# CONFIG_MMC_HS400_SUPPORT is not set
> +# CONFIG_MMC_HS200_SUPPORT is not set
> +CONFIG_MMC_VERBOSE=3Dn
> +CONFIG_MMC_TRACE=3Dn
> +# CONFIG_MMC_DW is not set
> +# CONFIG_MMC_MXC is not set
> +# CONFIG_MMC_PCI is not set
> +# CONFIG_MMC_OMAP_HS is not set
> +CONFIG_MMC_SDHCI=3Dy
> +# CONFIG_MMC_SDHCI_SDMA is not set
> +CONFIG_MMC_SDHCI_ADMA=3Dy
> +CONFIG_SPL_MMC_SDHCI_ADMA=3Dy
> +# CONFIG_MMC_SDHCI_BCMSTB is not set
> +CONFIG_MMC_SDHCI_CADENCE=3Dy
> +CONFIG_CMD_FAT=3Dy
> +CONFIG_DOS_PARTITION=3Dy
> +CONFIG_SPL_DOS_PARTITION=3Dy
> +CONFIG_SPL_SYS_DISABLE_DCACHE_OPS=3Dy
> +CONFIG_CMD_MTD=3Dy
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_CMD_NAND_TRIMFFS=3Dy
> +CONFIG_CMD_NAND_LOCK_UNLOCK=3Dy
> +CONFIG_CMD_SPI=3Dy
> +CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_CACHE=3Dy
> +CONFIG_SPL_SPI_FLASH_MTD=3Dy
> +CONFIG_SPI_FLASH_MTD=3Dy
> +CONFIG_SPL_MTD_SUPPORT=3Dy
> +CONFIG_MTDIDS_DEFAULT=3D"nand0=3D10b80000.nand.0"
> +CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3D10b80000.nand.0:2m(u-boot),-(root)=
"
> +CONFIG_CMD_UBI=3Dy
> +CONFIG_CMD_UBIFS=3Dy
> +CONFIG_MTD_UBI=3Dy
> +CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> +CONFIG_MTD_UBI_BEB_LIMIT=3D20
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +CONFIG_OF_LIST=3D""
> +CONFIG_ENV_IS_IN_UBI=3Dy
> +CONFIG_ENV_UBI_PART=3D"root"
> +CONFIG_ENV_UBI_VOLUME=3D"env"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> +CONFIG_SPL_ALTERA_SDRAM=3Dy
> +CONFIG_FPGA_INTEL_PR=3Dy
> +CONFIG_DWAPB_GPIO=3Dy
> +CONFIG_DM_I2C=3Dn
> +CONFIG_SYS_I2C_DW=3Dn
> +CONFIG_MISC=3Dy
> +CONFIG_MISC_INIT_R=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> +CONFIG_SYS_NAND_U_BOOT_OFFS=3D0x0
> +CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=3D0x100000
> +CONFIG_SF_DEFAULT_MODE=3D0x2003
> +CONFIG_SPI_FLASH_SPANSION=3Dy
> +CONFIG_SPI_FLASH_STMICRO=3Dy
> +CONFIG_UBI_SILENCE_MSG=3Dy
> +CONFIG_PHY_MARVELL=3Dy
> +CONFIG_DM_ETH=3Dy
> +CONFIG_DWC_ETH_XGMAC=3Dy
> +CONFIG_RGMII=3Dy
> +CONFIG_DM_RESET=3Dy
> +CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_CADENCE_QSPI=3Dy
> +CONFIG_DESIGNWARE_SPI=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_USB_DWC2=3Dn
> +CONFIG_USB_DWC3=3Dy
> +CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_XHCI_DWC3=3Dy
> +CONFIG_UBIFS_SILENCE_MSG=3Dy
> +# CONFIG_SPL_USE_TINY_PRINTF is not set
> +CONFIG_PANIC_HANG=3Dy
> +CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SYS_LOAD_ADDR=3D0x82000000
> +CONFIG_WDT=3Dn
> +CONFIG_CMD_WDT=3Dn
> +CONFIG_DESIGNWARE_WATCHDOG=3Dn
> +CONFIG_SPL_WDT=3Dn
> +CONFIG_WATCHDOG_AUTOSTART=3Dn
> +CONFIG_TIMER=3Dn
> +CONFIG_DESIGNWARE_APB_TIMER=3Dn
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80300000
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> +CONFIG_SPL_BSS_START_ADDR=3D0xbff00000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x73000
> +CONFIG_SYS_SPL_MALLOC=3Dy
> +CONFIG_HAS_CUSTOM_SPL_MALLOC_START=3Dy
> +CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=3D0xbfa00000
> +CONFIG_SYS_SPL_MALLOC_SIZE=3D0x500000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_EFI_LOADER is not set
> +CONFIG_I3C=3Dn
> +CONFIG_DW_I3C_MASTER=3Dn
> +CONFIG_CMD_I3C=3Dn
> +CONFIG_MTD_RAW_NAND=3Dy
> +CONFIG_NAND_CADENCE=3Dy
> +CONFIG_SPL_NAND_SUPPORT=3Dy
> +CONFIG_SPL_NAND_FRAMEWORK=3Dy
> +CONFIG_SPL_NAND_CADENCE=3Dy
> +CONFIG_SYS_MAXARGS=3D32
> +CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> --
> 2.26.2
>

Please add Manteiner support for this board

Michael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
