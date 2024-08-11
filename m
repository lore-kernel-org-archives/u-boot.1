Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6BBC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15146888C2;
	Sun, 11 Aug 2024 16:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Go9fnQL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF6888892; Sun, 11 Aug 2024 16:50:29 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A3988876
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b7a4668f1fso24833396d6.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387826; x=1723992626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ztd065o/XaORyhqK39PehWRN0rSSX8CIyK4XB9BqfI=;
 b=Go9fnQL6PEJACpJQZ746nW6dU0XnCKIWC7Qg+Er0gpX/IScOngLY9aRbpIEmWwNKtQ
 PFr3xmuu8QSHa1mQn1e2sybYA6mk49+tQ+4bqc3f0tKEkvdzIqPi6QZFXEJYPY2FUuNX
 mPYO012AzWOMVKT/vwOlD8OXbY1Ibm87UCV08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387826; x=1723992626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ztd065o/XaORyhqK39PehWRN0rSSX8CIyK4XB9BqfI=;
 b=JFs9ehlwJSyDoli6H/VGZlCd9Uj8LgT6mBhtjZYq4Gh474/Nnwi1hpVu1JqWBBX/IF
 VlUOfwszwnguDlK0l754u+VUFBokER6Ig30msIrKxu8ra87Q3kZlbxMfQKXrVbbIKa4z
 HwFvX5MsjzyUBUKLkVzAUmLpwmlVd5FSYCYU8gPaVd+5EiQGazHmLO1rhEYhqvlLy/pM
 DEdb3QbUHMYF0gzqKC3cwPjXyoTxgRTHtTHxEmTGtvM/8A2eUSTqTdf1pdstUy9qFj51
 AUeVeZ40Bj/A3as3dz+vslqhdrzzNBylyHH7kLlieI5vncTxT+mf8QcXF72A6SIys2ZB
 yQSQ==
X-Gm-Message-State: AOJu0Yz6GM54JYwykOxucq/YIsfduddIAO2K5UC82oBn5D7QtjXvsS7i
 Y5BU1EcGQwfqfqD5Sbt/UKosn8ow5tDE9YsQ8Nnisk30PZO2xudNUxvSHOnuaNe+692bSbGYGoG
 cR+SxArF2HUvRCZ8/HxWrqAF4ADJB2hhylFpG
X-Google-Smtp-Source: AGHT+IHrYWgLqX/ebrGzPByyGmXqkhGGSGtL332XADOnK/yxC9AYRl3yEb8NXMQFej4REwJtLjHXljFnVGCLF2OSPDU=
X-Received: by 2002:a05:6214:2f81:b0:6bb:b21b:d158 with SMTP id
 6a1803df08f44-6bd78ef3735mr88942736d6.45.1723387826131; Sun, 11 Aug 2024
 07:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-12-sjg@chromium.org>
 <8a2ec8f9-7226-4728-ae03-ba434f18c1f3@cherry.de>
In-Reply-To: <8a2ec8f9-7226-4728-ae03-ba434f18c1f3@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:15 -0600
Message-ID: <CAFLszTjVs_oKv3LOZkbxS7NhZdphK_3_Y-CZtbZNZZzwUFCsgA@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] spl: mmc: Try to clean up raw-mode options
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On Tue, 6 Aug 2024 at 08:53, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 7/21/24 5:25 PM, Simon Glass wrote:
> > Make the raw-mode options depend on SPL_SYS_MMCSD_RAW_MODE in a more
> > direct way. This makes it easier to understand the options with
> > 'make menuconfig'.
> >
> > There are three different ways of specifying the offset:
> >
> > - sector offset
> > - partition number
> > - partition type
> >
> > So make these a choice, so it is more obvious what is going on.
> >
> > Update existing boards to enable SPL_SYS_MMCSD_RAW_MODE where needed.
> >
> > Reviewed-by: Sean Anderson <seanga2@gmail.com>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   arch/arm/mach-imx/imx8m/soc.c                 |  2 +
> >   arch/arm/mach-imx/spl_imx_romapi.c            | 13 ++++-
> >   .../imx8mp_rsb3720a1/imx8mp_rsb3720a1.c       |  4 +-
> >   common/spl/Kconfig                            | 52 +++++++++++--------
> >   configs/am335x_guardian_defconfig             |  2 +-
> >   configs/am335x_pdu001_defconfig               |  2 +-
> >   configs/am3517_evm_defconfig                  |  2 +-
> >   configs/am62ax_evm_a53_defconfig              |  1 +
> >   configs/am62ax_evm_r5_defconfig               |  1 +
> >   configs/am62px_evm_a53_defconfig              |  1 +
> >   configs/am62px_evm_r5_defconfig               |  1 +
> >   configs/am62x_beagleplay_a53_defconfig        |  1 +
> >   configs/am62x_beagleplay_r5_defconfig         |  1 +
> >   configs/am62x_evm_a53_defconfig               |  1 +
> >   configs/am62x_evm_r5_defconfig                |  1 +
> >   configs/am64x_evm_a53_defconfig               |  1 +
> >   configs/am64x_evm_r5_defconfig                |  1 +
> >   configs/am65x_evm_a53_defconfig               |  1 +
> >   configs/am65x_evm_r5_defconfig                |  1 +
> >   configs/brppt2_defconfig                      |  2 +-
> >   configs/brsmarc1_defconfig                    |  2 +-
> >   configs/cgtqmx8_defconfig                     |  1 +
> >   configs/chromebit_mickey_defconfig            |  2 +-
> >   configs/chromebook_jerry_defconfig            |  2 +-
> >   configs/chromebook_minnie_defconfig           |  2 +-
> >   configs/chromebook_speedy_defconfig           |  2 +-
> >   configs/ci20_mmc_defconfig                    |  1 +
> >   configs/da850evm_defconfig                    |  2 +-
> >   configs/da850evm_nand_defconfig               |  2 +-
> >   configs/deneb_defconfig                       |  1 +
> >   configs/display5_defconfig                    |  2 +-
> >   configs/display5_factory_defconfig            |  2 +-
> >   configs/draco-rastaban_defconfig              |  2 +-
> >   configs/draco-thuban_defconfig                |  2 +-
> >   .../gardena-smart-gateway-at91sam_defconfig   |  2 +-
> >   configs/giedi_defconfig                       |  1 +
> >   configs/imx28_xea_defconfig                   |  1 +
> >   configs/imx28_xea_sb_defconfig                |  1 +
> >   configs/imx6q_logic_defconfig                 |  2 +-
> >   configs/imx8mm-cl-iot-gate-optee_defconfig    |  1 +
> >   configs/imx8mm-cl-iot-gate_defconfig          |  1 +
> >   configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |  1 +
> >   configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |  1 +
> >   configs/imx8mm-mx8menlo_defconfig             |  1 +
> >   configs/imx8mm-phygate-tauri-l_defconfig      |  1 +
> >   configs/imx8mm_beacon_defconfig               |  1 +
> >   configs/imx8mm_beacon_fspi_defconfig          |  1 +
> >   configs/imx8mm_data_modul_edm_sbc_defconfig   |  1 +
> >   configs/imx8mm_evk_defconfig                  |  1 +
> >   configs/imx8mm_evk_fspi_defconfig             |  1 +
> >   configs/imx8mm_phg_defconfig                  |  1 +
> >   configs/imx8mm_venice_defconfig               |  1 +
> >   configs/imx8mn_beacon_2g_defconfig            |  1 +
> >   configs/imx8mn_beacon_defconfig               |  1 +
> >   configs/imx8mn_beacon_fspi_defconfig          |  1 +
> >   configs/imx8mn_bsh_smm_s2_defconfig           |  1 +
> >   configs/imx8mn_bsh_smm_s2pro_defconfig        |  1 +
> >   configs/imx8mn_ddr4_evk_defconfig             |  1 +
> >   configs/imx8mn_evk_defconfig                  |  1 +
> >   configs/imx8mn_var_som_defconfig              |  1 +
> >   configs/imx8mn_venice_defconfig               |  1 +
> >   configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |  1 +
> >   configs/imx8mp_beacon_defconfig               |  1 +
> >   configs/imx8mp_data_modul_edm_sbc_defconfig   |  1 +
> >   configs/imx8mp_debix_model_a_defconfig        |  1 +
> >   configs/imx8mp_dhcom_pdk2_defconfig           |  1 +
> >   configs/imx8mp_dhcom_pdk3_defconfig           |  1 +
> >   configs/imx8mp_evk_defconfig                  |  1 +
> >   configs/imx8mp_rsb3720a1_4G_defconfig         |  2 +
> >   configs/imx8mp_rsb3720a1_6G_defconfig         |  1 +
> >   configs/imx8mp_venice_defconfig               |  1 +
> >   configs/imx8mq_cm_defconfig                   |  1 +
> >   configs/imx8mq_evk_defconfig                  |  1 +
> >   configs/imx8mq_phanbell_defconfig             |  1 +
> >   configs/imx8mq_reform2_defconfig              |  1 +
> >   configs/imx8qm_mek_defconfig                  |  1 +
> >   configs/imx8qxp_mek_defconfig                 |  1 +
> >   configs/imx8ulp_evk_defconfig                 |  1 +
> >   configs/imx93-phyboard-segin_defconfig        |  1 +
> >   configs/imx93_11x11_evk_defconfig             |  1 +
> >   configs/imx93_11x11_evk_ld_defconfig          |  1 +
> >   configs/imx93_var_som_defconfig               |  1 +
> >   configs/imxrt1020-evk_defconfig               |  1 +
> >   configs/imxrt1050-evk_defconfig               |  1 +
> >   configs/imxrt1050-evk_fspi_defconfig          |  1 +
> >   configs/imxrt1170-evk_defconfig               |  1 +
> >   configs/iot2050_defconfig                     |  1 +
> >   configs/j7200_evm_a72_defconfig               |  1 +
> >   configs/j7200_evm_r5_defconfig                |  1 +
> >   configs/j721e_beagleboneai64_a72_defconfig    |  1 +
> >   configs/j721e_beagleboneai64_r5_defconfig     |  1 +
> >   configs/j721e_evm_a72_defconfig               |  1 +
> >   configs/j721e_evm_r5_defconfig                |  1 +
> >   configs/j721s2_evm_a72_defconfig              |  1 +
> >   configs/j721s2_evm_r5_defconfig               |  1 +
> >   configs/j722s_evm_a53_defconfig               |  1 +
> >   configs/j722s_evm_r5_defconfig                |  1 +
> >   configs/j784s4_evm_a72_defconfig              |  1 +
> >   configs/j784s4_evm_r5_defconfig               |  1 +
> >   configs/kontron-sl-mx8mm_defconfig            |  1 +
> >   configs/kontron_pitx_imx8m_defconfig          |  1 +
> >   configs/kontron_sl28_defconfig                |  1 +
> >   configs/librem5_defconfig                     |  1 +
> >   configs/ls1021aiot_sdcard_defconfig           |  1 +
> >   configs/ls1021aqds_nand_defconfig             |  1 +
> >   configs/ls1021aqds_sdcard_ifc_defconfig       |  1 +
> >   configs/ls1021aqds_sdcard_qspi_defconfig      |  1 +
> >   configs/ls1021atsn_sdcard_defconfig           |  1 +
> >   ...s1021atwr_sdcard_ifc_SECURE_BOOT_defconfig |  1 +
> >   configs/ls1021atwr_sdcard_ifc_defconfig       |  1 +
> >   configs/ls1021atwr_sdcard_qspi_defconfig      |  1 +
> >   configs/msc_sm2s_imx8mp_defconfig             |  1 +
> >   configs/omap35_logic_defconfig                |  2 +-
> >   configs/omap35_logic_somlv_defconfig          |  2 +-
> >   configs/omap3_logic_defconfig                 |  2 +-
> >   configs/omap3_logic_somlv_defconfig           |  2 +-
> >   configs/phycore-imx8mm_defconfig              |  1 +
> >   configs/phycore-imx8mp_defconfig              |  1 +
> >   configs/phycore_am62x_a53_defconfig           |  1 +
> >   configs/phycore_am62x_r5_defconfig            |  1 +
> >   configs/phycore_am64x_a53_defconfig           |  1 +
> >   configs/phycore_am64x_r5_defconfig            |  1 +
> >   configs/pico-imx8mq_defconfig                 |  1 +
> >   configs/sama5d27_wlsom1_ek_mmc_defconfig      |  2 +-
> >   .../sama5d27_wlsom1_ek_qspiflash_defconfig    |  2 +-
> >   configs/sama5d2_icp_mmc_defconfig             |  2 +-
> >   configs/sandbox_noinst_defconfig              |  1 +
> >   configs/sniper_defconfig                      |  2 +-
> >   configs/socfpga_secu1_defconfig               |  2 +-
> >   configs/verdin-am62_a53_defconfig             |  1 +
> >   configs/verdin-am62_r5_defconfig              |  1 +
> >   configs/verdin-imx8mm_defconfig               |  1 +
> >   configs/verdin-imx8mp_defconfig               |  1 +
> >   133 files changed, 175 insertions(+), 52 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
> > index be38ca52885..f30178ae213 100644
> > --- a/arch/arm/mach-imx/imx8m/soc.c
> > +++ b/arch/arm/mach-imx/imx8m/soc.c
> > @@ -735,6 +735,7 @@ int boot_mode_getprisec(void)
> >   #endif
> >
> >   #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
> > +#ifdef SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> >   #define IMG_CNTN_SET1_OFFSET        GENMASK(22, 19)
> >   unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> >                                               unsigned long raw_sect)
> > @@ -769,6 +770,7 @@ unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> >
> >       return raw_sect;
> >   }
> > +#endif /* SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION */
> >   #endif
> >
> >   bool is_usb_boot(void)
> > diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
> > index 9a86f5c133f..bdaea439d7f 100644
> > --- a/arch/arm/mach-imx/spl_imx_romapi.c
> > +++ b/arch/arm/mach-imx/spl_imx_romapi.c
> > @@ -33,8 +33,17 @@ ulong spl_romapi_raw_seekable_read(u32 offset, u32 size, void *buf)
> >
> >   ulong __weak spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev)
> >   {
> > -     return image_offset +
> > -             (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512 - 0x8000);
> > +     u32 sector = 0;
> > +
> > +     /*
> > +      * Some boards use this value even though MMC is not enabled in SPL, for
> > +      * example imx8mn_bsh_smm_s2
> > +      */
> > +#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> > +     sector = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR;
> > +#endif
> > +
> > +     return image_offset + sector * 512 - 0x8000;
> >   }
> >
> >   static int is_boot_from_stream_device(u32 boot)
> > diff --git a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
> > index 070933fb54b..af083c3c38f 100644
> > --- a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
> > +++ b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
> > @@ -190,7 +190,7 @@ int board_late_init(void)
> >       return 0;
> >   }
> >
> > -#ifdef CONFIG_SPL_MMC
> > +#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> >   #define UBOOT_RAW_SECTOR_OFFSET 0x40
> >   unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> >                                          unsigned long raw_sector)
> > @@ -204,4 +204,4 @@ unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> >               return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR;
> >       }
> >   }
> > -#endif /* CONFIG_SPL_MMC */
> > +#endif /* CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR */
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index af43b5f5d3c..55a42a3a7c7 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -490,24 +490,45 @@ config SPL_DISPLAY_PRINT
> >         the board.
> >
> >   config SPL_SYS_MMCSD_RAW_MODE
> > -     bool
> > -     help
> > -       Support booting from an MMC without a filesystem.
> > -
> > -config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> > -     bool "MMC raw mode: by sector"
> > +     bool "Use raw reads to locate the next boot phase"
> > +     depends on SPL_DM_MMC || SPL_MMC
>
> This one is a weird one to me, we can have DM_MMC without MMC? Shouldn't
> we fix it?

My understanding is that MMC means it supports mmc without driver model.

./tools/qconfig.py -f ~SPL_MMC SPL_DM_MMC
93 matches
./tools/qconfig.py -f SPL_MMC ~SPL_DM_MMC
254 matches

so there are cases on both sides...so it looks like we need it as I have it?

>
> >       default y if ARCH_SUNXI || ARCH_DAVINCI || ARCH_UNIPHIER || \
> >                    ARCH_MX6 || ARCH_MX7 || \
> >                    ARCH_ROCKCHIP || ARCH_MVEBU ||  ARCH_SOCFPGA || \
> >                    ARCH_AT91 || ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
> >                    OMAP44XX || OMAP54XX || AM33XX || AM43XX || \
> >                    TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
> > +     help
> > +       Support booting from an MMC without a filesystem.
> > +
> > +if SPL_SYS_MMCSD_RAW_MODE
> > +
> > +choice
> > +     prompt "Method for locating next phase of boot (e.g. U-Boot)"
> > +
> > +config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> > +     bool "MMC raw mode: by sector"
> >       select SPL_LOAD_BLOCK if SPL_MMC
>
> We can remove the if SPL_MMC here as SPL_SYS_MMCSD_RAW_MODE already
> depends on it and this choice is guarded by it.

Oh that's interesting...will fix. it makes me wonder what happens with
this mode with SPL_DM_MMC??


>
> > -     select SPL_SYS_MMCSD_RAW_MODE if SPL_MMC
> >       help
> >         Use sector number for specifying U-Boot location on MMC/SD in
> >         raw mode.
> >
> > +config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> > +     bool "MMC Raw mode: by partition"
>
> Lower case "raw" here to match the two other choices?
>
> > +     select SPL_LOAD_BLOCK if SPL_MMC
>
> Ditto wrt SPL_MMC that I brought up earlier.
>
> > +     help
> > +       Use a partition for loading U-Boot when using MMC/SD in raw mode.
> > +
> > +config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
> > +     bool "MMC raw mode: by partition type"
> > +     depends on DOS_PARTITION && SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>
> This can never be met, as SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is
> another option in the same choice.
>
> Cheers,
> Quentin
