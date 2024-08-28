Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257D4C54ED0
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 11:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6777D88847;
	Wed, 28 Aug 2024 13:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y0i1ZlMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E3D588875; Wed, 28 Aug 2024 13:05:48 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1961C885C5
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 13:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so7245299a12.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 04:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724843145; x=1725447945; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YcC4UIMpgdJDZ9BtGTSSCOQP+q48sAFb3GZxkxuriY0=;
 b=Y0i1ZlMWhzoaPJ3zMXCuXEfEwrrhRQQzjNG4fXe3RCoY1XKGC3UVyoWm5Q41EDHSFP
 v5DCAyhXbeLa285znpAoay5BzIYS3eLYu70P2KpzlULl2Z9t5MB3FyK3leHaF7W1U2Ty
 FTpYQuf2x07xMcoRZlSTrVIOvj057Y+bZAQXfd5IFm2NOu/6YhHN3bHhjXL43L4oON25
 McNHm31BzJT8rPkAO5OJ9hvnbDBdGj9CU/ABGd+n8fY8b+d5mPRsl6U5RTIC+3kM++T2
 mEfjSMrrEeAa6tgqcFryQ2fSEmvOSfguFIoCMiL4tWqh4pQF0KxQfdX/CYw2PjrY0yzL
 HMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724843145; x=1725447945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YcC4UIMpgdJDZ9BtGTSSCOQP+q48sAFb3GZxkxuriY0=;
 b=GR8VKsrE+ayqZVaIEtV9YSAZf0K3Bhu+Cv3RhBlVNYNqrF7S0XioEyuSMCgHA4OBbj
 JzoxDPG8c+C1pX6XTXPdKiYCIA9EmCwS9ttQowILu0Fd7qcpeX0VMZrSZyESIt4Rv0Wr
 NJqodrxK2esrIYU1AyjX/UQmvPWRhUh3MGFlaWqYTyJ88K1wKUoyZJH91jWd+84HdbzR
 ayg3C0PnHFh+FIJyDJnZkBmqDv2Ne2jnF5MwsUapBVAkceLF5SjMWHLAKzj3/2K8ddqT
 jumvzCOCToEPbD303NCBQfsiwWfEsVdiNGHm+7gEHt2g0W2rsT3+ASIss/rD9HrAnHbu
 j91g==
X-Gm-Message-State: AOJu0YzvDqQ6SZGfBD0TqlHdO1Lmm9bnB+B1d43Bbt+HFl7bHPhWkWJb
 2gmNoNTyd5/iCrvycoBqjiA95rnteIlYDU6gBUcDlyIFwUcYCu2M8aKSg3FhosTj9SZ/l3wREL/
 e4OMx0MlQ2nHcZJyDA4mN/phMcfs=
X-Google-Smtp-Source: AGHT+IGWyVIw0n6xZIgQrvEJypm65pXLhO0p+GwPxjTYAl9HRgO3IhNliioNSumKEMIgDzqixMi7wEKSyhDGkzJH08s=
X-Received: by 2002:a05:6402:3585:b0:5c0:a8f1:121d with SMTP id
 4fb4d7f45d1cf-5c213dbd85bmr983318a12.10.1724843144654; Wed, 28 Aug 2024
 04:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724419624.git.jerome.forissier@linaro.org>
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 Aug 2024 12:05:33 +0100
Message-ID: <CALeDE9MkmOXQw0PM54v=-jHki1MYdSrdpb3dSvHZ0d6VgKzTpg@mail.gmail.com>
Subject: Re: [PATCH v9 00/23] Introduce the lwIP network stack
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>
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

Hi Jerome,

>
> Jerome Forissier (36):
>   Makefile: detect HOST_ARCH properly when CROSS_COMPILE is multi-word
>   flash: prefix error codes with FL_
>   at91: rename mem_init() to at91_mem_init()
>   arm: omap2: add missing #include <netdev.h>
>   net: fm: call dtsec_init_phy() only when it is defined
>   net: wget: removed unused function wget_success()
>   net: phy: ncsi: depend on NET
>   net: ftgmac100: depend on NET
>   net: wget: allow EFI boot
>   net: fec_mxc_init(): do not ignore return status of fec_open()
>   test/py: net_boot: fix comment
>   test/py: test_efi_loader: add missing dependency on cmd_tftpboot
>   test/py: test_efi_loader: add HTTP (wget) test for the EFI loader

All of the above look like they should be sent as a separate fixes
series which the following can depend on, they all look like fixes
that are separate to the rest and likely are useful on their own. It
would have the advantage of slimming down the series.

>   net: introduce alternative implementation as net-lwip/
>   configs: replace '# CONFIG_NET is not set' with CONFIG_NO_NET=y
>   net: split include/net.h into net{,-common,-legacy,-lwip}.h
>   net: move copy_filename() to new file net/net-common.c
>   net: eth-uclass: add function eth_start_udev()
>   net-lwip: build lwIP
>   net-lwip: add DHCP support and dhcp commmand
>   net-lwip: add TFTP support and tftpboot command
>   net-lwip: add ping command
>   net-lwip: add dns command
>   net: split cmd/net.c into cmd/net.c and cmd/net-common.c
>   net-lwip: add wget command
>   cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
>   configs: add qemu_arm64_lwip_defconfig
>   lwip: tftp: add support of blksize option to client
>   net-lwip: add TFTP_BLOCKSIZE
>   CI: add qemu_arm64_lwip to the test matrix
>   MAINTAINERS: net-lwip: add myself as a maintainer
>   Kconfig: fix undefined symbols (g_dnl*) when NET_LWIP is default
>     enabled
>   configs: use syntax CONFIG_FOO=n in tools-only_defconfig
>   [TESTING] Kconfig: enable NET_LWIP by default except for SANDBOX
>   [TESTING] configs: set CONFIG_NET=y for FTGMAC100
>   [TESTING] configs: set CONFIG_NET=y when PXE is enabled
>
> Jonathan Humphreys (1):
>   net-lwip: lwIP wget supports user defined port in the uri, so allow
>     it.
>
>  .azure-pipelines.yml                          |   7 +
>  Kconfig                                       |  31 +
>  MAINTAINERS                                   |  11 +
>  Makefile                                      |   6 +-
>  arch/arm/mach-at91/include/mach/at91_common.h |   2 +-
>  arch/arm/mach-at91/spl_at91.c                 |   2 +-
>  arch/arm/mach-at91/spl_atmel.c                |   2 +-
>  arch/arm/mach-omap2/omap3/emac.c              |   1 +
>  .../atmel/at91sam9m10g45ek/at91sam9m10g45ek.c |   2 +-
>  board/atmel/at91sam9n12ek/at91sam9n12ek.c     |   2 +-
>  board/atmel/at91sam9x5ek/at91sam9x5ek.c       |   2 +-
>  .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |   2 +-
>  .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |   2 +-
>  board/atmel/sama5d2_icp/sama5d2_icp.c         |   2 +-
>  .../atmel/sama5d2_xplained/sama5d2_xplained.c |   2 +-
>  .../atmel/sama5d3_xplained/sama5d3_xplained.c |   2 +-
>  board/atmel/sama5d3xek/sama5d3xek.c           |   2 +-
>  .../atmel/sama5d4_xplained/sama5d4_xplained.c |   2 +-
>  board/atmel/sama5d4ek/sama5d4ek.c             |   2 +-
>  board/cobra5272/flash.c                       |  26 +-
>  .../conclusive/kstr-sama5d27/kstr-sama5d27.c  |   2 +-
>  board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
>  board/freescale/m5253demo/flash.c             |   6 +-
>  board/gardena/smart-gateway-at91sam/spl.c     |   2 +-
>  .../imx8mp_debix_model_a.c                    |   2 +-
>  board/siemens/corvus/board.c                  |   2 +-
>  board/siemens/smartweb/smartweb.c             |   2 +-
>  board/siemens/taurus/taurus.c                 |   2 +-
>  board/ti/am335x/board.c                       |   3 +-
>  board/xilinx/common/board.c                   |   3 +-
>  boot/Kconfig                                  |   4 +-
>  cmd/Kconfig                                   | 129 ++-
>  cmd/Makefile                                  |   9 +-
>  cmd/bdinfo.c                                  |   5 +-
>  cmd/elf.c                                     |   2 +-
>  cmd/net-common.c                              | 109 ++
>  cmd/net-lwip.c                                |  45 +
>  cmd/net.c                                     | 115 ---
>  common/Kconfig                                |   2 +-
>  common/board_r.c                              |   4 +-
>  common/flash.c                                |  44 +-
>  common/spl/Kconfig                            |   1 +
>  common/usb_kbd.c                              |   2 +-
>  configs/LicheePi_Zero_defconfig               |   2 +-
>  configs/M5249EVB_defconfig                    |   2 +-
>  configs/ad401_defconfig                       |   1 +
>  configs/am335x_pdu001_defconfig               |   2 +-
>  configs/am43xx_evm_defconfig                  |   1 +
>  configs/am43xx_evm_qspiboot_defconfig         |   1 +
>  configs/am43xx_evm_rtconly_defconfig          |   1 +
>  configs/am43xx_evm_usbhost_boot_defconfig     |   1 +
>  configs/am43xx_hs_evm_defconfig               |   1 +
>  configs/am43xx_hs_evm_qspi_defconfig          |   1 +
>  configs/am57xx_evm_defconfig                  |   1 +
>  configs/am57xx_hs_evm_defconfig               |   1 +
>  configs/am57xx_hs_evm_usb_defconfig           |   1 +
>  configs/am62ax_evm_r5_defconfig               |   2 +-
>  configs/am62px_evm_r5_defconfig               |   2 +-
>  configs/am62x_beagleplay_r5_defconfig         |   2 +-
>  configs/amcore_defconfig                      |   2 +-
>  configs/anbernic-rgxx3-rk3566_defconfig       |   2 +-
>  configs/ap143_defconfig                       |   2 +-
>  configs/ap152_defconfig                       |   2 +-
>  configs/apple_m1_defconfig                    |   2 +-
>  configs/arndale_defconfig                     |   1 +
>  configs/astro_mcf5373l_defconfig              |   2 +-
>  configs/at91sam9rlek_dataflash_defconfig      |   2 +-
>  configs/at91sam9rlek_mmc_defconfig            |   2 +-
>  configs/at91sam9rlek_nandflash_defconfig      |   2 +-
>  configs/bananapi-cm4-cm4io_defconfig          |   1 +
>  configs/bananapi-m2-pro_defconfig             |   1 +
>  configs/bananapi-m2s_defconfig                |   1 +
>  configs/bananapi-m5_defconfig                 |   1 +
>  configs/bcm7260_defconfig                     |   2 +-
>  configs/bcm7445_defconfig                     |   2 +-
>  configs/bcm968380gerg_ram_defconfig           |   2 +-
>  configs/bcmns_defconfig                       |   2 +-
>  configs/beelink-gsking-x_defconfig            |   1 +
>  configs/beelink-gt1-ultimate_defconfig        |   1 +
>  configs/beelink-gtking_defconfig              |   1 +
>  configs/beelink-gtkingpro_defconfig           |   1 +
>  configs/chromebook_samus_tpl_defconfig        |   2 +-
>  configs/clearfog_defconfig                    |   1 +
>  configs/clearfog_gt_8k_defconfig              |   1 +
>  configs/clearfog_sata_defconfig               |   1 +
>  configs/clearfog_spi_defconfig                |   1 +
>  configs/cortina_presidio-asic-base_defconfig  |   2 +-
>  configs/cortina_presidio-asic-pnand_defconfig |   2 +-
>  configs/dra7xx_evm_defconfig                  |   1 +
>  configs/dra7xx_hs_evm_defconfig               |   1 +
>  configs/dra7xx_hs_evm_usb_defconfig           |   1 +
>  configs/durian_defconfig                      |   2 +-
>  configs/e850-96_defconfig                     |   2 +-
>  configs/ea-lpc3250devkitv2_defconfig          |   2 +-
>  configs/efi-x86_app32_defconfig               |   2 +-
>  configs/efi-x86_app64_defconfig               |   2 +-
>  configs/emsdp_defconfig                       |   2 +-
>  configs/evb-ast2500_defconfig                 |   1 +
>  configs/evb-ast2600_defconfig                 |   1 +
>  configs/evb-px5_defconfig                     |   2 +-
>  configs/generic-rk3568_defconfig              |   2 +-
>  configs/generic-rk3588_defconfig              |   2 +-
>  configs/hc2910_2aghd05_defconfig              |   2 +-
>  configs/helios4_defconfig                     |   1 +
>  configs/igep00x0_defconfig                    |   2 +-
>  configs/imx6q_bosch_acc_defconfig             |   2 +-
>  configs/imx6ulz_smm_m2_defconfig              |   2 +-
>  configs/imx8mn_var_som_defconfig              |   1 +
>  configs/iot_devkit_defconfig                  |   2 +-
>  configs/jethub_j100_defconfig                 |   1 +
>  configs/jethub_j80_defconfig                  |   1 +
>  configs/khadas-vim2_defconfig                 |   1 +
>  configs/khadas-vim3_defconfig                 |   1 +
>  configs/khadas-vim3l_defconfig                |   1 +
>  configs/khadas-vim_defconfig                  |   1 +
>  configs/kontron-sl-mx6ul_defconfig            |   1 +
>  configs/kontron-sl-mx8mm_defconfig            |   1 +
>  configs/kontron_pitx_imx8m_defconfig          |   1 +
>  configs/kontron_sl28_defconfig                |   1 +
>  configs/legoev3_defconfig                     |   2 +-
>  configs/libretech-ac_defconfig                |   1 +
>  configs/libretech-cc_defconfig                |   1 +
>  configs/libretech-cc_v2_defconfig             |   1 +
>  configs/libretech-s905d-pc_defconfig          |   1 +
>  configs/libretech-s912-pc_defconfig           |   1 +
>  configs/marsboard_defconfig                   |   1 +
>  configs/mk808_defconfig                       |   2 +-
>  configs/mvebu_crb_cn9130_defconfig            |   1 +
>  configs/mvebu_db_armada8k_defconfig           |   1 +
>  configs/mvebu_db_cn9130_defconfig             |   1 +
>  configs/mvebu_mcbin-88f8040_defconfig         |   1 +
>  configs/mvebu_puzzle-m801-88f8040_defconfig   |   1 +
>  configs/mx23evk_defconfig                     |   2 +-
>  configs/mx28evk_defconfig                     |   2 +-
>  configs/mx53cx9020_defconfig                  |   1 +
>  configs/mx6cuboxi_defconfig                   |   1 +
>  configs/mx6memcal_defconfig                   |   2 +-
>  configs/mx6ulz_14x14_evk_defconfig            |   2 +-
>  configs/mx7dsabresd_defconfig                 |   1 +
>  configs/mx7dsabresd_qspi_defconfig            |   1 +
>  configs/mx7ulp_com_defconfig                  |   2 +-
>  configs/mx7ulp_evk_defconfig                  |   2 +-
>  configs/mx7ulp_evk_plugin_defconfig           |   2 +-
>  configs/myir_mys_6ulx_defconfig               |   1 +
>  configs/nanopi-k2_defconfig                   |   1 +
>  configs/netgear_cg3100d_ram_defconfig         |   2 +-
>  configs/novena_defconfig                      |   1 +
>  configs/nsim_700_defconfig                    |   2 +-
>  configs/nsim_700be_defconfig                  |   2 +-
>  configs/nsim_hs38be_defconfig                 |   2 +-
>  configs/odroid-c2_defconfig                   |   1 +
>  configs/odroid-c4_defconfig                   |   1 +
>  configs/odroid-go-ultra_defconfig             |   1 +
>  configs/odroid-hc4_defconfig                  |   1 +
>  configs/odroid-n2_defconfig                   |   1 +
>  configs/odroid-n2l_defconfig                  |   1 +
>  configs/odroid-xu3_defconfig                  |   1 +
>  configs/openpiton_riscv64_defconfig           |   2 +-
>  configs/openpiton_riscv64_spl_defconfig       |   2 +-
>  configs/origen_defconfig                      |   2 +-
>  configs/p200_defconfig                        |   1 +
>  configs/p201_defconfig                        |   1 +
>  configs/p212_defconfig                        |   1 +
>  configs/pe2201_defconfig                      |   2 +-
>  configs/peach-pi_defconfig                    |   1 +
>  configs/peach-pit_defconfig                   |   1 +
>  configs/phycore_pcl063_defconfig              |   1 +
>  configs/pico-dwarf-imx6ul_defconfig           |   1 +
>  configs/pico-dwarf-imx7d_defconfig            |   1 +
>  configs/pico-hobbit-imx6ul_defconfig          |   1 +
>  configs/pico-hobbit-imx7d_defconfig           |   1 +
>  configs/pico-imx6ul_defconfig                 |   1 +
>  configs/pico-imx7d_bl33_defconfig             |   1 +
>  configs/pico-imx7d_defconfig                  |   1 +
>  configs/pico-nymph-imx7d_defconfig            |   1 +
>  configs/pico-pi-imx6ul_defconfig              |   1 +
>  configs/pico-pi-imx7d_defconfig               |   1 +
>  configs/pinecube_defconfig                    |   2 +-
>  configs/pm9261_defconfig                      |   2 +-
>  configs/qemu_arm64_lwip_defconfig             |  10 +
>  configs/radxa-zero2_defconfig                 |   1 +
>  configs/radxa-zero_defconfig                  |   1 +
>  configs/riotboard_defconfig                   |   1 +
>  configs/s400_defconfig                        |   1 +
>  configs/s5p4418_nanopi2_defconfig             |   2 +-
>  configs/s5p_goni_defconfig                    |   2 +-
>  configs/s5pc210_universal_defconfig           |   2 +-
>  configs/sama5d27_giantboard_defconfig         |   2 +-
>  configs/sama5d29_curiosity_mmc1_defconfig     |   2 +-
>  configs/sama5d29_curiosity_mmc_defconfig      |   2 +-
>  .../sama5d29_curiosity_qspiflash_defconfig    |   2 +-
>  configs/sama7g54_curiosity_mmc_defconfig      |   2 +-
>  .../sama7g54_curiosity_nandflash_defconfig    |   2 +-
>  .../sama7g54_curiosity_qspiflash_defconfig    |   2 +-
>  configs/seeed_npi_imx6ull_defconfig           |   1 +
>  configs/sipeed_maix_bitm_defconfig            |   2 +-
>  configs/sipeed_maix_smode_defconfig           |   2 +-
>  configs/smdk5250_defconfig                    |   1 +
>  configs/smdk5420_defconfig                    |   1 +
>  configs/snow_defconfig                        |   1 +
>  configs/spring_defconfig                      |   1 +
>  configs/stemmy_defconfig                      |   2 +-
>  configs/stm32f429-discovery_defconfig         |   2 +-
>  configs/stm32f429-evaluation_defconfig        |   2 +-
>  configs/stm32f469-discovery_defconfig         |   2 +-
>  configs/stm32h743-disco_defconfig             |   2 +-
>  configs/stm32h743-eval_defconfig              |   2 +-
>  configs/stm32h750-art-pi_defconfig            |   2 +-
>  configs/stm32mp25_defconfig                   |   2 +-
>  configs/stmark2_defconfig                     |   2 +-
>  configs/ten64_tfa_defconfig                   |   1 +
>  configs/th1520_lpi4a_defconfig                |   2 +-
>  configs/thunderx_88xx_defconfig               |   2 +-
>  configs/tools-only_defconfig                  |  34 +-
>  configs/topic_miami_defconfig                 |   2 +-
>  configs/topic_miamilite_defconfig             |   2 +-
>  configs/topic_miamiplus_defconfig             |   2 +-
>  configs/total_compute_defconfig               |   2 +-
>  configs/trats2_defconfig                      |   2 +-
>  configs/trats_defconfig                       |   2 +-
>  configs/turris_mox_defconfig                  |   1 +
>  configs/turris_omnia_defconfig                |   1 +
>  configs/u200_defconfig                        |   1 +
>  configs/vexpress_aemv8a_juno_defconfig        |   1 +
>  configs/vexpress_aemv8a_semi_defconfig        |   1 +
>  configs/vexpress_aemv8r_defconfig             |   1 +
>  configs/vexpress_ca9x4_defconfig              |   1 +
>  configs/vexpress_fvp_defconfig                |   1 +
>  configs/videostrong-kii-pro_defconfig         |   1 +
>  configs/wandboard_defconfig                   |   1 +
>  configs/wetek-core2_defconfig                 |   1 +
>  configs/wetek-hub_defconfig                   |   1 +
>  configs/wetek-play2_defconfig                 |   1 +
>  configs/xenguest_arm64_defconfig              |   2 +-
>  configs/xenguest_arm64_virtio_defconfig       |   2 +-
>  configs/xilinx_versal_mini_defconfig          |   2 +-
>  configs/xilinx_versal_mini_emmc0_defconfig    |   2 +-
>  configs/xilinx_versal_mini_emmc1_defconfig    |   2 +-
>  configs/xilinx_versal_mini_ospi_defconfig     |   2 +-
>  configs/xilinx_versal_mini_qspi_defconfig     |   2 +-
>  configs/xilinx_versal_net_mini_defconfig      |   2 +-
>  configs/xilinx_versal_net_mini_emmc_defconfig |   2 +-
>  configs/xilinx_versal_net_mini_ospi_defconfig |   2 +-
>  configs/xilinx_versal_net_mini_qspi_defconfig |   2 +-
>  configs/xilinx_zynqmp_mini_defconfig          |   2 +-
>  configs/xilinx_zynqmp_mini_emmc0_defconfig    |   2 +-
>  configs/xilinx_zynqmp_mini_emmc1_defconfig    |   2 +-
>  configs/xilinx_zynqmp_mini_nand_defconfig     |   2 +-
>  .../xilinx_zynqmp_mini_nand_single_defconfig  |   2 +-
>  configs/xilinx_zynqmp_mini_qspi_defconfig     |   2 +-
>  configs/zynq_cse_nand_defconfig               |   2 +-
>  configs/zynq_cse_nor_defconfig                |   2 +-
>  configs/zynq_cse_qspi_defconfig               |   2 +-
>  drivers/dfu/Kconfig                           |   2 +
>  drivers/fastboot/Kconfig                      |   1 +
>  drivers/mtd/altera_qspi.c                     |   4 +-
>  drivers/mtd/cfi_flash.c                       |  36 +-
>  drivers/net/Kconfig                           |   4 +-
>  drivers/net/fec_mxc.c                         |   3 +-
>  drivers/net/fm/eth.c                          |   2 +
>  drivers/net/phy/Kconfig                       |   3 +-
>  drivers/usb/gadget/Kconfig                    |   3 +-
>  include/flash.h                               |  20 +-
>  include/net-common.h                          | 490 +++++++++
>  include/net-legacy.h                          | 560 +++++++++++
>  include/net-lwip.h                            |  41 +
>  include/net.h                                 | 943 +-----------------
>  lib/Makefile                                  |   2 +
>  lib/lwip/Makefile                             |  55 +
>  lib/lwip/lwip/src/apps/tftp/tftp.c            |  94 +-
>  .../lwip/src/include/lwip/apps/tftp_client.h  |   1 +
>  lib/lwip/u-boot/arch/cc.h                     |  45 +
>  lib/lwip/u-boot/arch/sys_arch.h               |   0
>  lib/lwip/u-boot/limits.h                      |   0
>  lib/lwip/u-boot/lwipopts.h                    | 157 +++
>  lib/tiny-printf.c                             |   3 +-
>  net/Kconfig                                   |  81 +-
>  net/Makefile                                  |  20 +-
>  net/eth-uclass.c                              |  38 +-
>  net/lwip/Kconfig                              |  44 +
>  net/lwip/Makefile                             |   8 +
>  net/lwip/dhcp.c                               | 134 +++
>  net/lwip/dns.c                                | 127 +++
>  net/lwip/eth_internal.h                       |  35 +
>  net/lwip/net-lwip.c                           | 302 ++++++
>  net/lwip/ping.c                               | 177 ++++
>  net/lwip/tftp.c                               | 286 ++++++
>  net/lwip/wget.c                               | 357 +++++++
>  net/net-common.c                              |  13 +
>  net/net.c                                     |  12 -
>  net/wget.c                                    |  11 +-
>  test/py/tests/test_efi_loader.py              |  62 +-
>  test/py/tests/test_net_boot.py                |   2 +-
>  293 files changed, 3704 insertions(+), 1437 deletions(-)
>  create mode 100644 cmd/net-common.c
>  create mode 100644 cmd/net-lwip.c
>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>  create mode 100644 include/net-common.h
>  create mode 100644 include/net-legacy.h
>  create mode 100644 include/net-lwip.h
>  create mode 100644 lib/lwip/Makefile
>  create mode 100644 lib/lwip/u-boot/arch/cc.h
>  create mode 100644 lib/lwip/u-boot/arch/sys_arch.h
>  create mode 100644 lib/lwip/u-boot/limits.h
>  create mode 100644 lib/lwip/u-boot/lwipopts.h
>  create mode 100644 net/lwip/Kconfig
>  create mode 100644 net/lwip/Makefile
>  create mode 100644 net/lwip/dhcp.c
>  create mode 100644 net/lwip/dns.c
>  create mode 100644 net/lwip/eth_internal.h
>  create mode 100644 net/lwip/net-lwip.c
>  create mode 100644 net/lwip/ping.c
>  create mode 100644 net/lwip/tftp.c
>  create mode 100644 net/lwip/wget.c
>  create mode 100644 net/net-common.c
>
> --
> 2.40.1
>
