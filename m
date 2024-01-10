Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C13DC47073
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 18:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E495D87AE6;
	Wed, 10 Jan 2024 19:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KiIpvEzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401D3876F3; Wed, 10 Jan 2024 19:46:25 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F4B87AD6
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-680b1956ca4so30518606d6.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704912376; x=1705517176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cTXzmFo0MUQMZBp22U19Loh1UWocelWU5zB4pHiItVY=;
 b=KiIpvEzl//FnA6w4GIof35ZAtJbgW8kn6Bp0PNBAyMj7pTBuftPDW2KZxhB+vHFeBU
 pEQoYa71JLiNTC93t76BFntht79f435EjeAQHKkTz3UE3VmumLiu1nV7JOcCUxIwsuHF
 2/Mg3CcEfSKRkAcJ8raTXUK2gOgfCbvuIXKjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704912376; x=1705517176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTXzmFo0MUQMZBp22U19Loh1UWocelWU5zB4pHiItVY=;
 b=K6+0MzcIcTmmiuz7wFf1HvUZso9bmIgZ9hjBreZsMRUzSTwl5SeiaIHrDSjM7fYTir
 26THCuEsA7UHtMNqCRLg0CfaRpIeXQpN99K+dZNCB03esx+Ls+f3fqxcgRWFqY+lQci+
 M8j/z1XKiPWvFYn+z0FKq+0qjKbN3Xo8waBcQRAQuNrLTKzy1VIV7xu9MP7DYRzjpzIe
 FW8EOZvSEMLtC7q/PsrU2O7euNLS0ugPmr7Krqs65Kt3zWBwmZPDSnEvYsxO2vZLDs+j
 idCdJOr+xoTB1WlXd7hmb8Ixp2fn8qqIyuvkBIqUZM9ywU3G4eDuqpRXdXFEABuD7nQq
 ccVw==
X-Gm-Message-State: AOJu0Yx1OtpUk+YLd6czUWEd0q6D5yzUzz0JU+VrcRQlKlAW8Ho+DRNF
 6YQxc4nkYoedmxp7xBd/zLNjSoZusjiQxee5GRCFEoz9ZO0=
X-Google-Smtp-Source: AGHT+IFrjso7kAhKulxHM8Pu9tATiXum+Wf22S/o2a49ilkb0KZMHkv5iBZSX4KyAqoZGIkVBwl2Gg==
X-Received: by 2002:a05:6214:3018:b0:67f:ad06:4868 with SMTP id
 ke24-20020a056214301800b0067fad064868mr1962009qvb.81.1704912374691; 
 Wed, 10 Jan 2024 10:46:14 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 v12-20020a0cc60c000000b0067aab230ed9sm1887979qvi.21.2024.01.10.10.46.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 10:46:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 5/5] mtd: Make CONFIG_MTD be the gate symbol for the menu
Date: Wed, 10 Jan 2024 13:46:10 -0500
Message-Id: <20240110184610.3909763-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110184610.3909763-1-trini@konsulko.com>
References: <20240110184610.3909763-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Jan 2024 19:46:37 +0100
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

The help for CONFIG_MTD explains that it needs to be enabled for various
things like NAND, etc to be available. It however then doesn't enforce
this dependency and so if you have none of these systems present you
still need to disable a number of options. Fix this by making places
that select/imply one type of flash, but did not do the same, also do
this for "MTD". Make boards which hadn't been enabling MTD already but
need it now, do so. In a few places, disable CONFIG_CMD_MTDPARTS as it
wasn't previously enabled but was now being implied.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/Kconfig                                     |  2 ++
 arch/arm/Kconfig                                 | 11 ++++++++++-
 arch/arm/mach-at91/Kconfig                       |  3 +++
 arch/arm/mach-imx/mx6/Kconfig                    |  3 +++
 arch/arm/mach-omap2/am33xx/Kconfig               |  1 +
 arch/arm/mach-tegra/Kconfig                      |  1 +
 arch/microblaze/Kconfig                          |  1 +
 arch/mips/Kconfig                                |  2 ++
 board/microchip/mpfs_icicle/Kconfig              |  1 +
 configs/3c120_defconfig                          |  1 +
 configs/A20-OLinuXino-Lime2-eMMC_defconfig       |  1 +
 configs/M5208EVBE_defconfig                      |  1 +
 configs/M5235EVB_Flash32_defconfig               |  1 +
 configs/M5235EVB_defconfig                       |  1 +
 configs/M5249EVB_defconfig                       |  1 +
 configs/M5253DEMO_defconfig                      |  1 +
 configs/M5272C3_defconfig                        |  1 +
 configs/M5275EVB_defconfig                       |  1 +
 configs/M5282EVB_defconfig                       |  1 +
 configs/M53017EVB_defconfig                      |  1 +
 configs/MPC837XERDB_defconfig                    |  1 +
 configs/MPC8548CDS_36BIT_defconfig               |  1 +
 configs/MPC8548CDS_defconfig                     |  1 +
 configs/MPC8548CDS_legacy_defconfig              |  1 +
 configs/am43xx_evm_defconfig                     |  1 -
 configs/am43xx_evm_rtconly_defconfig             |  1 -
 configs/am43xx_evm_usbhost_boot_defconfig        |  1 -
 configs/am43xx_hs_evm_defconfig                  |  1 -
 configs/am62ax_evm_r5_defconfig                  |  1 +
 configs/am62x_evm_a53_defconfig                  |  1 +
 configs/am62x_evm_r5_defconfig                   |  1 +
 configs/am64x_evm_a53_defconfig                  |  1 +
 configs/am64x_evm_r5_defconfig                   |  1 +
 configs/am65x_evm_r5_defconfig                   |  1 +
 configs/amcore_defconfig                         |  1 +
 configs/arbel_evb_defconfig                      |  1 +
 configs/arndale_defconfig                        |  1 -
 configs/astro_mcf5373l_defconfig                 |  1 +
 configs/axm_defconfig                            |  1 -
 configs/bitmain_antminer_s9_defconfig            |  1 -
 configs/chromebit_mickey_defconfig               |  1 -
 configs/chromebook_jerry_defconfig               |  1 -
 configs/chromebook_minnie_defconfig              |  1 -
 configs/chromebook_speedy_defconfig              |  1 -
 configs/clearfog_defconfig                       |  1 -
 configs/clearfog_sata_defconfig                  |  1 -
 configs/clearfog_spi_defconfig                   |  1 -
 configs/cobra5272_defconfig                      |  1 +
 configs/colibri_t20_defconfig                    |  1 -
 configs/comtrend_ct5361_ram_defconfig            |  1 +
 configs/comtrend_wap5813n_ram_defconfig          |  1 +
 configs/corstone1000_defconfig                   |  1 +
 configs/crs305-1g-4s-bit_defconfig               |  1 -
 configs/crs305-1g-4s_defconfig                   |  1 -
 configs/crs326-24g-2s-bit_defconfig              |  1 -
 configs/crs326-24g-2s_defconfig                  |  1 -
 configs/crs328-4c-20s-4s-bit_defconfig           |  1 -
 configs/crs328-4c-20s-4s_defconfig               |  1 -
 configs/d2net_v2_defconfig                       |  1 +
 configs/db-88f6820-amc_defconfig                 |  1 -
 configs/db-88f6820-amc_nand_defconfig            |  1 -
 configs/db-mv784mp-gp_defconfig                  |  1 -
 configs/db-xc3-24g4xg_defconfig                  |  1 -
 configs/display5_defconfig                       |  1 -
 configs/display5_factory_defconfig               |  1 -
 configs/ds116_defconfig                          |  1 -
 configs/ds414_defconfig                          |  1 -
 configs/eDPU_defconfig                           |  1 -
 configs/eb_cpu5282_defconfig                     |  1 +
 configs/eb_cpu5282_internal_defconfig            |  1 +
 configs/evb-ast2500_defconfig                    |  1 +
 configs/evb-ast2600_defconfig                    |  1 +
 configs/evb-rk3036_defconfig                     |  1 -
 configs/evb-rk3128_defconfig                     |  1 -
 configs/evb-rk3229_defconfig                     |  1 -
 configs/evb-rk3288_defconfig                     |  1 -
 configs/evb-rv1108_defconfig                     |  1 -
 configs/firefly-rk3288_defconfig                 |  1 -
 configs/gardena-smart-gateway-mt7688_defconfig   |  1 -
 configs/gazerbeam_defconfig                      |  1 +
 configs/ge_b1x5v2_defconfig                      |  1 +
 configs/gurnard_defconfig                        |  1 -
 configs/gxp_defconfig                            |  1 +
 configs/harmony_defconfig                        |  1 -
 configs/helios4_defconfig                        |  1 -
 configs/hihope_rzg2_defconfig                    |  1 +
 configs/huawei_hg556a_ram_defconfig              |  1 +
 configs/imx8mm-cl-iot-gate-optee_defconfig       |  1 +
 configs/imx8mm-cl-iot-gate_defconfig             |  1 +
 configs/imx8mm_evk_fspi_defconfig                |  1 +
 configs/imx8mn_beacon_2g_defconfig               |  1 +
 configs/imx8mp_rsb3720a1_4G_defconfig            |  1 +
 configs/imx8mp_rsb3720a1_6G_defconfig            |  1 +
 configs/imx8ulp_evk_defconfig                    |  1 +
 configs/inetspace_v2_defconfig                   |  1 +
 configs/integratorap_cm720t_defconfig            |  1 +
 configs/integratorap_cm920t_defconfig            |  1 +
 configs/integratorap_cm926ejs_defconfig          |  1 +
 configs/integratorap_cm946es_defconfig           |  1 +
 configs/integratorcp_cm1136_defconfig            |  1 +
 configs/integratorcp_cm920t_defconfig            |  1 +
 configs/integratorcp_cm926ejs_defconfig          |  1 +
 configs/integratorcp_cm946es_defconfig           |  1 +
 configs/iot2050_defconfig                        |  1 +
 configs/j721e_beagleboneai64_a72_defconfig       |  1 -
 configs/jethub_j100_defconfig                    |  1 -
 configs/jethub_j80_defconfig                     |  1 -
 configs/kylin-rk3036_defconfig                   |  1 -
 configs/lctech_pi_f1c200s_defconfig              |  1 +
 configs/librem5_defconfig                        |  1 +
 configs/libretech_all_h3_it_h5_defconfig         |  1 +
 configs/libretech_all_h5_cc_h5_defconfig         |  1 +
 configs/licheepi_nano_defconfig                  |  1 +
 configs/linkit-smart-7688_defconfig              |  1 -
 configs/lion-rk3368_defconfig                    |  1 -
 configs/malta64_defconfig                        |  1 +
 configs/malta64el_defconfig                      |  1 +
 configs/malta_defconfig                          |  1 +
 configs/maltael_defconfig                        |  1 +
 configs/marsboard_defconfig                      |  1 +
 configs/mccmon6_nor_defconfig                    |  1 -
 configs/mccmon6_sd_defconfig                     |  1 -
 configs/medcom-wide_defconfig                    |  1 -
 configs/microblaze-generic_defconfig             |  1 -
 configs/miqi-rk3288_defconfig                    |  1 -
 configs/mt7621_nand_rfb_defconfig                |  1 -
 configs/mt7622_rfb_defconfig                     |  1 +
 configs/mvebu_ac5_rd_defconfig                   |  1 -
 configs/mvebu_crb_cn9130_defconfig               |  1 -
 configs/mvebu_db-88f3720_defconfig               |  1 -
 configs/mvebu_db_cn9130_defconfig                |  1 -
 configs/mvebu_espressobin-88f3720_defconfig      |  1 -
 configs/mx7ulp_com_defconfig                     |  1 +
 configs/n2350_defconfig                          |  1 -
 configs/net2big_v2_defconfig                     |  1 +
 configs/netspace_lite_v2_defconfig               |  1 +
 configs/netspace_max_v2_defconfig                |  1 +
 configs/netspace_mini_v2_defconfig               |  1 +
 configs/netspace_v2_defconfig                    |  1 +
 configs/oceanic_5205_5inmfd_defconfig            |  1 +
 configs/octeon_ebb7304_defconfig                 |  1 -
 configs/octeon_nic23_defconfig                   |  1 -
 configs/odroid-m1-rk3568_defconfig               |  1 -
 configs/odroid-xu3_defconfig                     |  1 -
 configs/odroid_defconfig                         |  1 -
 configs/orangepi_pc2_defconfig                   |  1 +
 configs/orangepi_r1_defconfig                    |  1 +
 configs/orangepi_win_defconfig                   |  1 +
 configs/orangepi_zero2_defconfig                 |  1 +
 configs/orangepi_zero3_defconfig                 |  1 +
 configs/orangepi_zero_defconfig                  |  1 +
 configs/origen_defconfig                         |  1 -
 configs/pcm051_rev3_defconfig                    |  1 +
 configs/peach-pi_defconfig                       |  1 -
 configs/peach-pit_defconfig                      |  1 -
 configs/phycore-rk3288_defconfig                 |  1 -
 configs/pine64-lts_defconfig                     |  1 +
 configs/pine_h64_defconfig                       |  1 +
 configs/pinecube_defconfig                       |  1 +
 configs/plutux_defconfig                         |  1 -
 configs/poleg_evb_defconfig                      |  1 +
 configs/popmetal-rk3288_defconfig                |  1 -
 configs/r2dplus_defconfig                        |  1 +
 configs/riotboard_defconfig                      |  1 +
 configs/rock2_defconfig                          |  1 -
 configs/rock_defconfig                           |  1 -
 configs/s5pc210_universal_defconfig              |  1 -
 configs/sama5d27_giantboard_defconfig            |  1 +
 configs/sama5d2_icp_mmc_defconfig                |  1 +
 configs/sandbox64_defconfig                      |  1 -
 configs/sandbox_defconfig                        |  1 -
 configs/sandbox_noinst_defconfig                 |  1 -
 configs/seaboard_defconfig                       |  1 -
 configs/sfr_nb4-ser_ram_defconfig                |  1 +
 configs/silinux_ek874_defconfig                  |  1 +
 configs/smdk5250_defconfig                       |  1 -
 configs/smdk5420_defconfig                       |  1 -
 configs/smdkv310_defconfig                       |  1 -
 configs/snow_defconfig                           |  1 -
 configs/socfpga_agilex_atf_defconfig             |  1 -
 configs/socfpga_agilex_defconfig                 |  1 +
 configs/socfpga_agilex_vab_defconfig             |  1 -
 configs/socfpga_arria10_defconfig                |  1 -
 configs/socfpga_arria5_defconfig                 |  1 -
 configs/socfpga_chameleonv3_defconfig            |  1 +
 configs/socfpga_cyclone5_defconfig               |  1 -
 configs/socfpga_dbm_soc1_defconfig               |  1 -
 configs/socfpga_de0_nano_soc_defconfig           |  1 -
 configs/socfpga_de10_nano_defconfig              |  1 -
 configs/socfpga_de10_standard_defconfig          |  1 -
 configs/socfpga_de1_soc_defconfig                |  1 -
 configs/socfpga_is1_defconfig                    |  1 -
 configs/socfpga_mcvevk_defconfig                 |  1 -
 configs/socfpga_n5x_atf_defconfig                |  1 -
 configs/socfpga_n5x_defconfig                    |  1 +
 configs/socfpga_n5x_vab_defconfig                |  1 -
 configs/socfpga_secu1_defconfig                  |  1 -
 configs/socfpga_sockit_defconfig                 |  1 -
 configs/socfpga_socrates_defconfig               |  1 -
 configs/socfpga_sr1500_defconfig                 |  1 -
 configs/socfpga_stratix10_atf_defconfig          |  1 -
 configs/socfpga_stratix10_defconfig              |  1 -
 configs/socfpga_vining_fpga_defconfig            |  1 -
 configs/sopine_baseboard_defconfig               |  1 +
 configs/spring_defconfig                         |  1 -
 configs/stm32f429-discovery_defconfig            |  1 +
 configs/stm32f429-evaluation_defconfig           |  1 +
 configs/taurus_defconfig                         |  1 -
 configs/tec_defconfig                            |  1 -
 configs/tinker-rk3288_defconfig                  |  1 -
 configs/trats2_defconfig                         |  1 -
 configs/trats_defconfig                          |  1 -
 configs/turris_mox_defconfig                     |  1 -
 configs/turris_omnia_defconfig                   |  1 -
 configs/uDPU_defconfig                           |  1 -
 configs/vocore2_defconfig                        |  1 -
 configs/vyasa-rk3288_defconfig                   |  1 -
 configs/x240_defconfig                           |  1 -
 configs/x530_defconfig                           |  1 -
 configs/xilinx_versal_mini_ospi_defconfig        |  1 +
 configs/xilinx_versal_mini_qspi_defconfig        |  1 +
 configs/xilinx_versal_net_mini_ospi_defconfig    |  1 +
 configs/xilinx_versal_net_mini_qspi_defconfig    |  1 +
 configs/xilinx_zynq_virt_defconfig               |  1 -
 configs/xilinx_zynqmp_kria_defconfig             |  1 -
 configs/xilinx_zynqmp_mini_nand_defconfig        |  1 -
 configs/xilinx_zynqmp_mini_nand_single_defconfig |  1 -
 configs/xilinx_zynqmp_virt_defconfig             |  1 -
 configs/xtfpga_defconfig                         |  1 +
 configs/zynq_cse_nand_defconfig                  |  1 -
 configs/zynq_cse_nor_defconfig                   |  1 -
 drivers/mtd/Kconfig                              |  6 ++++--
 232 files changed, 129 insertions(+), 124 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c23d57e4c49e..b6fb9e927337 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -149,6 +149,7 @@ config SANDBOX
 	select GZIP_COMPRESSED
 	select IO_TRACE
 	select LZO
+	select MTD
 	select OF_BOARD_SETUP
 	select PCI_ENDPOINT
 	select SPI
@@ -254,6 +255,7 @@ config X86
 	imply DM_RTC
 	imply SCSI
 	imply DM_SERIAL
+	imply MTD
 	imply DM_SPI
 	imply DM_SPI_FLASH
 	imply DM_USB
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1fd7aacc3804..9ebadc3ceaa7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -605,6 +605,7 @@ config ARCH_MVEBU
 	select DM_SPI
 	select DM_SPI_FLASH
 	select GPIO_EXTRA_HEADER
+	select MTD
 	select SPL_DM_SPI if SPL
 	select SPL_DM_SPI_FLASH if SPL
 	select SPL_TIMER if SPL
@@ -630,6 +631,7 @@ config TARGET_STV0991
 	select DM_SPI_FLASH
 	select GPIO_EXTRA_HEADER
 	select PL01X_SERIAL
+	select MTD
 	select SPI
 	select SPI_FLASH
 	imply CMD_DM
@@ -715,6 +717,7 @@ config ARCH_EXYNOS
 	select DM_SERIAL
 	select DM_SPI
 	select DM_SPI_FLASH
+	select MTD
 	select SPI
 	select GPIO_EXTRA_HEADER
 	imply SYS_THUMB_BUILD
@@ -997,6 +1000,7 @@ config ARCH_APPLE
 	select VIDEO
 	select IOMMU
 	select LINUX_KERNEL_IMAGE_HEADER
+	select MTD
 	select OF_BOARD_SETUP
 	select OF_CONTROL
 	select PCI
@@ -1108,6 +1112,7 @@ config ARCH_SOCFPGA
 	imply DM_SPI
 	imply DM_SPI_FLASH
 	imply FAT_WRITE
+	imply MTD
 	imply SPL
 	imply SPL_DM
 	imply SPL_DM_SPI
@@ -1131,7 +1136,7 @@ config ARCH_SUNXI
 	select DM_GPIO
 	select DM_I2C if I2C
 	select DM_SPI if SPI
-	select DM_SPI_FLASH if SPI
+	select DM_SPI_FLASH if SPI && MTD
 	select DM_KEYBOARD
 	select DM_MMC if MMC
 	select DM_SERIAL
@@ -1249,6 +1254,7 @@ config ARCH_ZYNQ
 	select DM_SPI
 	select DM_SPI_FLASH
 	select OF_CONTROL
+	select MTD
 	select SPI
 	select SPL_BOARD_INIT if SPL
 	select SPL_CLK if SPL
@@ -1287,6 +1293,7 @@ config ARCH_ZYNQMP
 	imply DM_MAILBOX
 	select DM_MMC if MMC
 	select DM_SERIAL
+	select MTD
 	select DM_SPI if SPI
 	select DM_SPI_FLASH if DM_SPI
 	imply FIRMWARE
@@ -1833,6 +1840,7 @@ config TARGET_SL28
 	select DM_GPIO
 	select DM_I2C
 	select DM_MMC
+	select MTD
 	select DM_SPI_FLASH
 	select DM_MDIO
 	select PCI
@@ -1976,6 +1984,7 @@ config ARCH_ROCKCHIP
 	select DM_SPI_FLASH
 	select ENABLE_ARM_SOC_BOOT0_HOOK
 	select OF_CONTROL
+	select MTD
 	select SPI
 	select SPL_DM if SPL
 	select SPL_DM_SPI if SPL
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 37ef2d691d65..c5fd86927214 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -88,6 +88,7 @@ config TARGET_GURNARD
 	select DM_GPIO
 	select DM_SERIAL
 	select DM_SPI
+	select MTD
 	select SPI
 	imply CMD_DM
 
@@ -294,6 +295,7 @@ config TARGET_TAURUS
 	select DM_GPIO
 	select DM_SERIAL
 	select DM_SPI
+	select MTD
 	select SPI
 	select SUPPORT_SPL
 	imply CMD_DM
@@ -312,6 +314,7 @@ config TARGET_VINCO
 	bool "Support VINCO"
 	select DM
 	select DM_SPI
+	select MTD
 	select SAMA5D4
 	select SPI
 	select SUPPORT_SPL
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 50a9c3e4203d..114cce4d9b9f 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -201,6 +201,7 @@ config TARGET_DISPLAY5
 	select DM_SPI
 	select DM_GPIO
 	select DM_SERIAL
+	select MTD
 	select SUPPORT_SPL
 	imply CMD_DM
 
@@ -261,6 +262,7 @@ config TARGET_MCCMON6
 	select DM_SERIAL
 	select DM_I2C
 	select DM_SPI
+	select MTD
 	imply CMD_DM
 
 config TARGET_MX6CUBOXI
@@ -602,6 +604,7 @@ config TARGET_TQMA6
 	imply DM
 	imply DM_GPIO
 	imply DM_MMC
+	imply MTD
 	imply DM_SPI
 	imply DM_SPI_FLASH
 	imply DM_I2C
diff --git a/arch/arm/mach-omap2/am33xx/Kconfig b/arch/arm/mach-omap2/am33xx/Kconfig
index bd5129b04e0b..46abf070f9d5 100644
--- a/arch/arm/mach-omap2/am33xx/Kconfig
+++ b/arch/arm/mach-omap2/am33xx/Kconfig
@@ -204,6 +204,7 @@ config TARGET_AM43XX_EVM
 	imply DM_I2C
 	imply DM_SPI
 	imply DM_SPI_FLASH
+	imply MTD
 	imply SPL_ENV_SUPPORT
 	imply SPL_FS_EXT4
 	imply SPL_FS_FAT
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index c8907bccec5d..05e194de0820 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -55,6 +55,7 @@ config TEGRA_COMMON
 	select DM_SPI
 	select DM_SPI_FLASH
 	select MISC
+	select MTD
 	select OF_CONTROL
 	select SPI
 	select SYSRESET
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index e38c9f6d7117..4261e5009fdc 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -23,6 +23,7 @@ config TARGET_MICROBLAZE_GENERIC
 	select SYSRESET
 	select DM_SPI
 	select DM_SPI_FLASH
+	select MTD
 	select SPI
 	imply CMD_DM
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 569f5f48bc6c..f0704d97f79b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -77,6 +77,7 @@ config ARCH_MTMIPS
 	select PINMUX
 	select PINCONF
 	select RESET_MTMIPS
+	imply MTD
 	imply DM_SPI
 	imply DM_SPI_FLASH
 	select LAST_STAGE_INIT
@@ -109,6 +110,7 @@ config ARCH_OCTEON
 	select MIPS_L2_CACHE
 	select MIPS_MACH_EARLY_INIT
 	select MIPS_TUNE_OCTEON3
+	select MTD
 	select ROM_EXCEPTION_VECTORS
 	select SUPPORTS_BIG_ENDIAN
 	select SUPPORTS_CPU_MIPS64_OCTEON
diff --git a/board/microchip/mpfs_icicle/Kconfig b/board/microchip/mpfs_icicle/Kconfig
index ce510e22e81a..4309f7528bb0 100644
--- a/board/microchip/mpfs_icicle/Kconfig
+++ b/board/microchip/mpfs_icicle/Kconfig
@@ -50,6 +50,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply CMD_I2C
 	imply DM_I2C
 	imply SYS_I2C_MICROCHIP
+	imply MTD
 	imply SPI
 	imply DM_SPI
 	imply MICROCHIP_COREQSPI
diff --git a/configs/3c120_defconfig b/configs/3c120_defconfig
index 10948971bcfb..077506e99653 100644
--- a/configs/3c120_defconfig
+++ b/configs/3c120_defconfig
@@ -37,6 +37,7 @@ CONFIG_SYS_RX_ETH_BUFFER=0
 CONFIG_ALTERA_PIO=y
 CONFIG_MISC=y
 CONFIG_ALTERA_SYSID=y
+CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/A20-OLinuXino-Lime2-eMMC_defconfig b/configs/A20-OLinuXino-Lime2-eMMC_defconfig
index 44770ffb048f..22d80ca2c9c1 100644
--- a/configs/A20-OLinuXino-Lime2-eMMC_defconfig
+++ b/configs/A20-OLinuXino-Lime2-eMMC_defconfig
@@ -21,6 +21,7 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_MTD=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/M5208EVBE_defconfig b/configs/M5208EVBE_defconfig
index fd44fa198664..ed146628918a 100644
--- a/configs/M5208EVBE_defconfig
+++ b/configs/M5208EVBE_defconfig
@@ -39,6 +39,7 @@ CONFIG_SERVERIP="192.162.1.1"
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
diff --git a/configs/M5235EVB_Flash32_defconfig b/configs/M5235EVB_Flash32_defconfig
index 810cde48ff11..45e046017e2b 100644
--- a/configs/M5235EVB_Flash32_defconfig
+++ b/configs/M5235EVB_Flash32_defconfig
@@ -47,6 +47,7 @@ CONFIG_SERVERIP="192.162.1.1"
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_32BIT=y
diff --git a/configs/M5235EVB_defconfig b/configs/M5235EVB_defconfig
index 11fe3ba73da8..719a43540536 100644
--- a/configs/M5235EVB_defconfig
+++ b/configs/M5235EVB_defconfig
@@ -46,6 +46,7 @@ CONFIG_SERVERIP="192.162.1.1"
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
diff --git a/configs/M5249EVB_defconfig b/configs/M5249EVB_defconfig
index 30c3e42cbb25..eac85b9c2d51 100644
--- a/configs/M5249EVB_defconfig
+++ b/configs/M5249EVB_defconfig
@@ -23,6 +23,7 @@ CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_CACHE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_NET is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
diff --git a/configs/M5253DEMO_defconfig b/configs/M5253DEMO_defconfig
index de631aed9bc8..14a3d9d8879e 100644
--- a/configs/M5253DEMO_defconfig
+++ b/configs/M5253DEMO_defconfig
@@ -39,6 +39,7 @@ CONFIG_ATAPI=y
 CONFIG_IDE_RESET=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_SYS_MAX_FLASH_SECT=2048
 CONFIG_USE_SYS_MAX_FLASH_BANKS=y
diff --git a/configs/M5272C3_defconfig b/configs/M5272C3_defconfig
index a760734adff0..ccb756ede7c4 100644
--- a/configs/M5272C3_defconfig
+++ b/configs/M5272C3_defconfig
@@ -61,6 +61,7 @@ CONFIG_SYS_OR6_PRELIM=0x0
 CONFIG_SYS_BR7_PRELIM_BOOL=y
 CONFIG_SYS_BR7_PRELIM=0x701
 CONFIG_SYS_OR7_PRELIM=0xFFC0007C
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
diff --git a/configs/M5275EVB_defconfig b/configs/M5275EVB_defconfig
index 8d677f900ab7..4400075d0e2c 100644
--- a/configs/M5275EVB_defconfig
+++ b/configs/M5275EVB_defconfig
@@ -35,6 +35,7 @@ CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/M5282EVB_defconfig b/configs/M5282EVB_defconfig
index ec2b9db63979..2786c673fb99 100644
--- a/configs/M5282EVB_defconfig
+++ b/configs/M5282EVB_defconfig
@@ -37,6 +37,7 @@ CONFIG_NETMASK="255.255.255.0"
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.162.1.1"
 CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
diff --git a/configs/M53017EVB_defconfig b/configs/M53017EVB_defconfig
index ecaed559fc1a..f0a7b1c2b6c9 100644
--- a/configs/M53017EVB_defconfig
+++ b/configs/M53017EVB_defconfig
@@ -40,6 +40,7 @@ CONFIG_SERVERIP="192.162.1.1"
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
diff --git a/configs/MPC837XERDB_defconfig b/configs/MPC837XERDB_defconfig
index 04c0ec280678..9eac43a0fcb1 100644
--- a/configs/MPC837XERDB_defconfig
+++ b/configs/MPC837XERDB_defconfig
@@ -170,6 +170,7 @@ CONFIG_SYS_I2C_SLAVE=0x7F
 CONFIG_SYS_I2C_SPEED=400000
 CONFIG_FSL_ESDHC=y
 CONFIG_FSL_ESDHC_PIN_MUX=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/MPC8548CDS_36BIT_defconfig b/configs/MPC8548CDS_36BIT_defconfig
index 728aae5ad388..8670712ff4e2 100644
--- a/configs/MPC8548CDS_36BIT_defconfig
+++ b/configs/MPC8548CDS_36BIT_defconfig
@@ -80,6 +80,7 @@ CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_FSL=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x57
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/MPC8548CDS_defconfig b/configs/MPC8548CDS_defconfig
index a680a318bec4..e10e61a022bf 100644
--- a/configs/MPC8548CDS_defconfig
+++ b/configs/MPC8548CDS_defconfig
@@ -79,6 +79,7 @@ CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_FSL=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x57
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/MPC8548CDS_legacy_defconfig b/configs/MPC8548CDS_legacy_defconfig
index 09a452a21730..6fcc7271d97e 100644
--- a/configs/MPC8548CDS_legacy_defconfig
+++ b/configs/MPC8548CDS_legacy_defconfig
@@ -79,6 +79,7 @@ CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_FSL=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x57
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index d5ce2995548d..58e5f65a5d24 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -67,7 +67,6 @@ CONFIG_DFU_SF=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index a0a9e8ac5849..8f33fc2cd2c6 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -57,7 +57,6 @@ CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index cd47806204e8..d875560616cc 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -70,7 +70,6 @@ CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_MISC=y
 CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index d721664ecb10..fd1e0c8f3243 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -63,7 +63,6 @@ CONFIG_DFU_SF=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 40704151255f..8dd8f0823eb0 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -89,6 +89,7 @@ CONFIG_K3_SEC_PROXY=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_SPL_PINCTRL=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index aa96c1b3125c..457931faf210 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -75,6 +75,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 9ec3d562e719..3e4d3a766288 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -96,6 +96,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 05e35a8db656..6711e691ca45 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -107,6 +107,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 0f9757b52e67..56df6a4a19c8 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -115,6 +115,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 476c9312c7e8..194bd1f59089 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -105,6 +105,7 @@ CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/amcore_defconfig b/configs/amcore_defconfig
index 8c5c0998f01c..f1f5201b30a6 100644
--- a/configs/amcore_defconfig
+++ b/configs/amcore_defconfig
@@ -34,6 +34,7 @@ CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="AMCORE"
 # CONFIG_NET is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index ac4fa7169035..45fafe790cef 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -63,6 +63,7 @@ CONFIG_NPCM_HOST=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_NPCM=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/arndale_defconfig b/configs/arndale_defconfig
index d322dd3593be..b664ad587734 100644
--- a/configs/arndale_defconfig
+++ b/configs/arndale_defconfig
@@ -46,7 +46,6 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_SMC911X=y
 CONFIG_SOUND=y
 CONFIG_I2S=y
diff --git a/configs/astro_mcf5373l_defconfig b/configs/astro_mcf5373l_defconfig
index 2550bf502e7d..d1942c289716 100644
--- a/configs/astro_mcf5373l_defconfig
+++ b/configs/astro_mcf5373l_defconfig
@@ -35,6 +35,7 @@ CONFIG_FPGA_SPARTAN3=y
 CONFIG_SYS_FPGA_PROG_FEEDBACK=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/axm_defconfig b/configs/axm_defconfig
index 86add8f4202a..1a892a9bc18f 100644
--- a/configs/axm_defconfig
+++ b/configs/axm_defconfig
@@ -81,7 +81,6 @@ CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
 CONFIG_NAND_ATMEL=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
diff --git a/configs/bitmain_antminer_s9_defconfig b/configs/bitmain_antminer_s9_defconfig
index 858b07a495bc..fffa9cbe3432 100644
--- a/configs/bitmain_antminer_s9_defconfig
+++ b/configs/bitmain_antminer_s9_defconfig
@@ -84,7 +84,6 @@ CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_ZYNQPL=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ZYNQ=y
 CONFIG_NAND_ZYNQ_USE_BOOTLOADER1_TIMINGS=y
diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index 1ec1a262351a..c4136477c264 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -80,7 +80,6 @@ CONFIG_MMC_PWRSEQ=y
 # CONFIG_SPL_DM_MMC is not set
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_SF_DEFAULT_BUS=2
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index a3d272213431..4b80d6a8051e 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -80,7 +80,6 @@ CONFIG_MMC_PWRSEQ=y
 # CONFIG_SPL_DM_MMC is not set
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_SF_DEFAULT_BUS=2
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 332ebdd6deb6..126b8ce41cef 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -81,7 +81,6 @@ CONFIG_MMC_PWRSEQ=y
 # CONFIG_SPL_DM_MMC is not set
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_SF_DEFAULT_BUS=2
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index 87876e2b732e..2346c83aab4c 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -81,7 +81,6 @@ CONFIG_MMC_PWRSEQ=y
 # CONFIG_SPL_DM_MMC is not set
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_SF_DEFAULT_BUS=2
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
index 05e7751352cd..368c81c2a579 100644
--- a/configs/clearfog_defconfig
+++ b/configs/clearfog_defconfig
@@ -62,7 +62,6 @@ CONFIG_SPL_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
-CONFIG_MTD=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/clearfog_sata_defconfig b/configs/clearfog_sata_defconfig
index 4f11ea1307ca..c38d5ccf07d5 100644
--- a/configs/clearfog_sata_defconfig
+++ b/configs/clearfog_sata_defconfig
@@ -63,7 +63,6 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
-CONFIG_MTD=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/clearfog_spi_defconfig b/configs/clearfog_spi_defconfig
index 418c4cbf65e9..ccdcf09756b4 100644
--- a/configs/clearfog_spi_defconfig
+++ b/configs/clearfog_spi_defconfig
@@ -63,7 +63,6 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
-CONFIG_MTD=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/cobra5272_defconfig b/configs/cobra5272_defconfig
index e4e13db93f43..d7ce71925e91 100644
--- a/configs/cobra5272_defconfig
+++ b/configs/cobra5272_defconfig
@@ -53,6 +53,7 @@ CONFIG_SYS_OR6_PRELIM=0x0
 CONFIG_SYS_BR7_PRELIM_BOOL=y
 CONFIG_SYS_BR7_PRELIM=0x701
 CONFIG_SYS_OR7_PRELIM=0xFF00007C
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_SYS_MAX_FLASH_SECT=11
 CONFIG_USE_SYS_MAX_FLASH_BANKS=y
diff --git a/configs/colibri_t20_defconfig b/configs/colibri_t20_defconfig
index b91900999533..3c506ffb6877 100644
--- a/configs/colibri_t20_defconfig
+++ b/configs/colibri_t20_defconfig
@@ -54,7 +54,6 @@ CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=1536
 CONFIG_TFTP_TSIZE=y
 CONFIG_SYS_I2C_TEGRA=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
diff --git a/configs/comtrend_ct5361_ram_defconfig b/configs/comtrend_ct5361_ram_defconfig
index 4a5d1b7fabb1..49b353542b5c 100644
--- a/configs/comtrend_ct5361_ram_defconfig
+++ b/configs/comtrend_ct5361_ram_defconfig
@@ -50,6 +50,7 @@ CONFIG_BCM6348_IUDMA=y
 CONFIG_BCM6345_GPIO=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/comtrend_wap5813n_ram_defconfig b/configs/comtrend_wap5813n_ram_defconfig
index 20f477b2d453..60f8f3f707e9 100644
--- a/configs/comtrend_wap5813n_ram_defconfig
+++ b/configs/comtrend_wap5813n_ram_defconfig
@@ -50,6 +50,7 @@ CONFIG_BCM6348_IUDMA=y
 CONFIG_BCM6345_GPIO=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index e45415b90c3e..a86ac1273280 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -44,6 +44,7 @@ CONFIG_REGMAP=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_MISC=y
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_NVMXIP_QSPI=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_SMSC=y
diff --git a/configs/crs305-1g-4s-bit_defconfig b/configs/crs305-1g-4s-bit_defconfig
index fff81dca0fbd..b3eaec873f02 100644
--- a/configs/crs305-1g-4s-bit_defconfig
+++ b/configs/crs305-1g-4s-bit_defconfig
@@ -40,7 +40,6 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/crs305-1g-4s_defconfig b/configs/crs305-1g-4s_defconfig
index da77a78aa8fd..cc3dea698719 100644
--- a/configs/crs305-1g-4s_defconfig
+++ b/configs/crs305-1g-4s_defconfig
@@ -41,7 +41,6 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/crs326-24g-2s-bit_defconfig b/configs/crs326-24g-2s-bit_defconfig
index 975674081d53..5dad70dfd640 100644
--- a/configs/crs326-24g-2s-bit_defconfig
+++ b/configs/crs326-24g-2s-bit_defconfig
@@ -40,7 +40,6 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/crs326-24g-2s_defconfig b/configs/crs326-24g-2s_defconfig
index d62fd2efdd96..462588a52582 100644
--- a/configs/crs326-24g-2s_defconfig
+++ b/configs/crs326-24g-2s_defconfig
@@ -40,7 +40,6 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/crs328-4c-20s-4s-bit_defconfig b/configs/crs328-4c-20s-4s-bit_defconfig
index 0729baeb7f27..9e1474aae9d3 100644
--- a/configs/crs328-4c-20s-4s-bit_defconfig
+++ b/configs/crs328-4c-20s-4s-bit_defconfig
@@ -40,7 +40,6 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/crs328-4c-20s-4s_defconfig b/configs/crs328-4c-20s-4s_defconfig
index f317b97bdf86..afa4c52207a0 100644
--- a/configs/crs328-4c-20s-4s_defconfig
+++ b/configs/crs328-4c-20s-4s_defconfig
@@ -40,7 +40,6 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/d2net_v2_defconfig b/configs/d2net_v2_defconfig
index 5fcac2c239f1..bb1bcb0aa303 100644
--- a/configs/d2net_v2_defconfig
+++ b/configs/d2net_v2_defconfig
@@ -61,6 +61,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x0
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
diff --git a/configs/db-88f6820-amc_defconfig b/configs/db-88f6820-amc_defconfig
index 71af33cb9961..8919f17885a6 100644
--- a/configs/db-88f6820-amc_defconfig
+++ b/configs/db-88f6820-amc_defconfig
@@ -64,7 +64,6 @@ CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_PXA3XX=y
diff --git a/configs/db-88f6820-amc_nand_defconfig b/configs/db-88f6820-amc_nand_defconfig
index f5659720dcf4..76d8d34753b0 100644
--- a/configs/db-88f6820-amc_nand_defconfig
+++ b/configs/db-88f6820-amc_nand_defconfig
@@ -67,7 +67,6 @@ CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_PXA3XX=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
diff --git a/configs/db-mv784mp-gp_defconfig b/configs/db-mv784mp-gp_defconfig
index 6ebf4126e97e..ea72fb9b849c 100644
--- a/configs/db-mv784mp-gp_defconfig
+++ b/configs/db-mv784mp-gp_defconfig
@@ -65,7 +65,6 @@ CONFIG_LBA48=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_PXA3XX=y
diff --git a/configs/db-xc3-24g4xg_defconfig b/configs/db-xc3-24g4xg_defconfig
index c5f60e432d23..61ce6e7e5ce5 100644
--- a/configs/db-xc3-24g4xg_defconfig
+++ b/configs/db-xc3-24g4xg_defconfig
@@ -46,7 +46,6 @@ CONFIG_NET_RETRY_COUNT=50
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_PXA3XX=y
diff --git a/configs/display5_defconfig b/configs/display5_defconfig
index ab1eefe0c14a..7707b327a937 100644
--- a/configs/display5_defconfig
+++ b/configs/display5_defconfig
@@ -106,7 +106,6 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
diff --git a/configs/display5_factory_defconfig b/configs/display5_factory_defconfig
index f3e419d8ae3b..58f47512136b 100644
--- a/configs/display5_factory_defconfig
+++ b/configs/display5_factory_defconfig
@@ -105,7 +105,6 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
index 8fb14bb0dcc6..02ddc0e79186 100644
--- a/configs/ds116_defconfig
+++ b/configs/ds116_defconfig
@@ -70,7 +70,6 @@ CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_MARVELL=y
diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
index 3929ea91fa9e..07c7456c5cd3 100644
--- a/configs/ds414_defconfig
+++ b/configs/ds414_defconfig
@@ -67,7 +67,6 @@ CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_ADDR_ENABLE=y
 CONFIG_PHY_MARVELL=y
diff --git a/configs/eDPU_defconfig b/configs/eDPU_defconfig
index 545fd4356a7d..c1f8505bf8fa 100644
--- a/configs/eDPU_defconfig
+++ b/configs/eDPU_defconfig
@@ -61,7 +61,6 @@ CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_XENON=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/eb_cpu5282_defconfig b/configs/eb_cpu5282_defconfig
index 7578e0ede17e..271dbdf4dbbf 100644
--- a/configs/eb_cpu5282_defconfig
+++ b/configs/eb_cpu5282_defconfig
@@ -41,6 +41,7 @@ CONFIG_LED_STATUS_BIT=8
 CONFIG_LED_STATUS_BOOT_ENABLE=y
 CONFIG_LED_STATUS_BOOT=0
 CONFIG_LED_STATUS_CMD=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
diff --git a/configs/eb_cpu5282_internal_defconfig b/configs/eb_cpu5282_internal_defconfig
index 6595f9c1ae08..89a7925dffaa 100644
--- a/configs/eb_cpu5282_internal_defconfig
+++ b/configs/eb_cpu5282_internal_defconfig
@@ -39,6 +39,7 @@ CONFIG_LED_STATUS_BIT=8
 CONFIG_LED_STATUS_BOOT_ENABLE=y
 CONFIG_LED_STATUS_BOOT=0
 CONFIG_LED_STATUS_CMD=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
diff --git a/configs/evb-ast2500_defconfig b/configs/evb-ast2500_defconfig
index ab60d699a351..6685f37e3f58 100644
--- a/configs/evb-ast2500_defconfig
+++ b/configs/evb-ast2500_defconfig
@@ -42,6 +42,7 @@ CONFIG_ASPEED_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_ASPEED=y
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
diff --git a/configs/evb-ast2600_defconfig b/configs/evb-ast2600_defconfig
index 23f15b72a45d..314d5d3e5b22 100644
--- a/configs/evb-ast2600_defconfig
+++ b/configs/evb-ast2600_defconfig
@@ -91,6 +91,7 @@ CONFIG_SYS_I2C_ASPEED=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ASPEED=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
diff --git a/configs/evb-rk3036_defconfig b/configs/evb-rk3036_defconfig
index 21c657a441c2..a5a4e3621135 100644
--- a/configs/evb-rk3036_defconfig
+++ b/configs/evb-rk3036_defconfig
@@ -48,7 +48,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_PINCTRL=y
 # CONFIG_SPL_DM_SERIAL is not set
diff --git a/configs/evb-rk3128_defconfig b/configs/evb-rk3128_defconfig
index f15969546e29..ffff062af32a 100644
--- a/configs/evb-rk3128_defconfig
+++ b/configs/evb-rk3128_defconfig
@@ -39,7 +39,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_REGULATOR_PWM=y
diff --git a/configs/evb-rk3229_defconfig b/configs/evb-rk3229_defconfig
index 98489706d47e..d632fd7b5efe 100644
--- a/configs/evb-rk3229_defconfig
+++ b/configs/evb-rk3229_defconfig
@@ -57,7 +57,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY=y
diff --git a/configs/evb-rk3288_defconfig b/configs/evb-rk3288_defconfig
index fb747411c0c6..31dad12f49d4 100644
--- a/configs/evb-rk3288_defconfig
+++ b/configs/evb-rk3288_defconfig
@@ -69,7 +69,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/evb-rv1108_defconfig b/configs/evb-rv1108_defconfig
index 2b456c2ff7e8..1c62149a9b57 100644
--- a/configs/evb-rv1108_defconfig
+++ b/configs/evb-rv1108_defconfig
@@ -31,7 +31,6 @@ CONFIG_FASTBOOT_BUF_SIZE=0x08000000
 CONFIG_FASTBOOT_FLASH_MMC_DEV=1
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index aede3e12c409..4860298003c7 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -65,7 +65,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index 0b60cae27eb0..3b2d27b37cf1 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -83,7 +83,6 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_LED=y
 CONFIG_LED_BLINK=y
 CONFIG_LED_GPIO=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_SPI_NAND=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
diff --git a/configs/gazerbeam_defconfig b/configs/gazerbeam_defconfig
index e02138b2a1de..9765c435d3c3 100644
--- a/configs/gazerbeam_defconfig
+++ b/configs/gazerbeam_defconfig
@@ -168,6 +168,7 @@ CONFIG_MPC83XX_SERDES=y
 CONFIG_GDSYS_SOC=y
 CONFIG_IHS_FPGA=y
 CONFIG_FSL_ESDHC=y
+CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/ge_b1x5v2_defconfig b/configs/ge_b1x5v2_defconfig
index 5644e7ab6450..20384bcca64e 100644
--- a/configs/ge_b1x5v2_defconfig
+++ b/configs/ge_b1x5v2_defconfig
@@ -87,6 +87,7 @@ CONFIG_I2C_MUX_GPIO=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/gurnard_defconfig b/configs/gurnard_defconfig
index 5cf5eaaebdff..a649bda2c168 100644
--- a/configs/gurnard_defconfig
+++ b/configs/gurnard_defconfig
@@ -47,7 +47,6 @@ CONFIG_TFTP_PORT=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_AT91_GPIO=y
 CONFIG_GENERIC_ATMEL_MCI=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
 CONFIG_NAND_ATMEL=y
diff --git a/configs/gxp_defconfig b/configs/gxp_defconfig
index 1b40aacc41ba..00a9211fb052 100644
--- a/configs/gxp_defconfig
+++ b/configs/gxp_defconfig
@@ -41,6 +41,7 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_NETCONSOLE=y
 CONFIG_MISC=y
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/harmony_defconfig b/configs/harmony_defconfig
index 0689c7e43d2a..70bd454405f8 100644
--- a/configs/harmony_defconfig
+++ b/configs/harmony_defconfig
@@ -44,7 +44,6 @@ CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index 1d8d374fe270..04194004f0bb 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -63,7 +63,6 @@ CONFIG_SPL_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
-CONFIG_MTD=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index ad61151980b5..cad490eb240f 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -64,6 +64,7 @@ CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_RENESAS_SDHI=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_BITBANGMII=y
diff --git a/configs/huawei_hg556a_ram_defconfig b/configs/huawei_hg556a_ram_defconfig
index 77dd33db937f..17d1c1020314 100644
--- a/configs/huawei_hg556a_ram_defconfig
+++ b/configs/huawei_hg556a_ram_defconfig
@@ -50,6 +50,7 @@ CONFIG_BCM6348_IUDMA=y
 CONFIG_BCM6345_GPIO=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-cl-iot-gate-optee_defconfig
index 8adc1808e025..4568c9c12059 100644
--- a/configs/imx8mm-cl-iot-gate-optee_defconfig
+++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
@@ -101,6 +101,7 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_ATHEROS=y
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index 63d61dec03f6..54ad6564af4c 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -104,6 +104,7 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_ATHEROS=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 6feeae92c89c..b689c7a871bd 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -80,6 +80,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index 8042c2151853..0c63192a9f1c 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -109,6 +109,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb3720a1_4G_defconfig
index c53e8fdc08e0..019bbcc7154e 100644
--- a/configs/imx8mp_rsb3720a1_4G_defconfig
+++ b/configs/imx8mp_rsb3720a1_4G_defconfig
@@ -123,6 +123,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb3720a1_6G_defconfig
index 652c5db8d6c2..efd69f2e123a 100644
--- a/configs/imx8mp_rsb3720a1_6G_defconfig
+++ b/configs/imx8mp_rsb3720a1_6G_defconfig
@@ -123,6 +123,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index 17ffa4aa7fa0..836a79773831 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -71,6 +71,7 @@ CONFIG_SYS_I2C_IMX_LPI2C=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_PHYLIB=y
diff --git a/configs/inetspace_v2_defconfig b/configs/inetspace_v2_defconfig
index 09b2f7b681a6..2e8e3f3928c4 100644
--- a/configs/inetspace_v2_defconfig
+++ b/configs/inetspace_v2_defconfig
@@ -61,6 +61,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x0
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
diff --git a/configs/integratorap_cm720t_defconfig b/configs/integratorap_cm720t_defconfig
index 779385b81086..bd0a7bf1c4d1 100644
--- a/configs/integratorap_cm720t_defconfig
+++ b/configs/integratorap_cm720t_defconfig
@@ -28,6 +28,7 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/integratorap_cm920t_defconfig b/configs/integratorap_cm920t_defconfig
index 358a860af123..aae5512a5faa 100644
--- a/configs/integratorap_cm920t_defconfig
+++ b/configs/integratorap_cm920t_defconfig
@@ -28,6 +28,7 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/integratorap_cm926ejs_defconfig b/configs/integratorap_cm926ejs_defconfig
index 9e5bf8e0bdc0..7aaec71a9775 100644
--- a/configs/integratorap_cm926ejs_defconfig
+++ b/configs/integratorap_cm926ejs_defconfig
@@ -28,6 +28,7 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/integratorap_cm946es_defconfig b/configs/integratorap_cm946es_defconfig
index 2260e554cd18..05fa604368ca 100644
--- a/configs/integratorap_cm946es_defconfig
+++ b/configs/integratorap_cm946es_defconfig
@@ -28,6 +28,7 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/integratorcp_cm1136_defconfig b/configs/integratorcp_cm1136_defconfig
index ed4573f52e6c..f3e640bd9fdf 100644
--- a/configs/integratorcp_cm1136_defconfig
+++ b/configs/integratorcp_cm1136_defconfig
@@ -36,6 +36,7 @@ CONFIG_IPADDR="192.168.1.104"
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.1.100"
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/integratorcp_cm920t_defconfig b/configs/integratorcp_cm920t_defconfig
index 2289ad9b3ae8..1a03b570e36f 100644
--- a/configs/integratorcp_cm920t_defconfig
+++ b/configs/integratorcp_cm920t_defconfig
@@ -36,6 +36,7 @@ CONFIG_IPADDR="192.168.1.104"
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.1.100"
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/integratorcp_cm926ejs_defconfig b/configs/integratorcp_cm926ejs_defconfig
index 9d99866c84c3..1eb1c1aa1e10 100644
--- a/configs/integratorcp_cm926ejs_defconfig
+++ b/configs/integratorcp_cm926ejs_defconfig
@@ -36,6 +36,7 @@ CONFIG_IPADDR="192.168.1.104"
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.1.100"
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/integratorcp_cm946es_defconfig b/configs/integratorcp_cm946es_defconfig
index 6a1629d568ae..ee1191aaf607 100644
--- a/configs/integratorcp_cm946es_defconfig
+++ b/configs/integratorcp_cm946es_defconfig
@@ -36,6 +36,7 @@ CONFIG_IPADDR="192.168.1.104"
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.1.100"
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index c69e1d819c1e..576105a218ad 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -111,6 +111,7 @@ CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index 959f86844d32..4a866a02cf04 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -120,7 +120,6 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
-CONFIG_MTD_UBI=y
 CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83867=y
diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
index f52df1dc91cb..863245430a97 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -47,7 +47,6 @@ CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_MMC_MESON_GX=y
-CONFIG_MTD_UBI=y
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE_MESON8B=y
 CONFIG_MESON_GXL_USB_PHY=y
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index d32d74b5942a..ca0808f7121d 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -48,7 +48,6 @@ CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_MMC_MESON_GX=y
-CONFIG_MTD_UBI=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_MDIO_MUX=y
diff --git a/configs/kylin-rk3036_defconfig b/configs/kylin-rk3036_defconfig
index 8d3f1a7b0983..cb313a10a412 100644
--- a/configs/kylin-rk3036_defconfig
+++ b/configs/kylin-rk3036_defconfig
@@ -52,7 +52,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_PINCTRL=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/lctech_pi_f1c200s_defconfig b/configs/lctech_pi_f1c200s_defconfig
index 310719cf9158..e1e8d3aaaa3a 100644
--- a/configs/lctech_pi_f1c200s_defconfig
+++ b/configs/lctech_pi_f1c200s_defconfig
@@ -7,5 +7,6 @@ CONFIG_DRAM_CLK=156
 CONFIG_DRAM_ZQ=0
 CONFIG_SUNXI_MINIMUM_DRAM_MB=64
 # CONFIG_VIDEO_SUNXI is not set
+CONFIG_MTD=y
 CONFIG_CONS_INDEX=2
 CONFIG_SPI=y
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index 70b4d7c59021..91ead3feed4a 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -115,6 +115,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/libretech_all_h3_it_h5_defconfig b/configs/libretech_all_h3_it_h5_defconfig
index cb7ffb4d7daa..f751c4f57650 100644
--- a/configs/libretech_all_h3_it_h5_defconfig
+++ b/configs/libretech_all_h3_it_h5_defconfig
@@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=672
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_SPI=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/libretech_all_h5_cc_h5_defconfig b/configs/libretech_all_h5_cc_h5_defconfig
index c3aa4b10617f..c1761b432980 100644
--- a/configs/libretech_all_h5_cc_h5_defconfig
+++ b/configs/libretech_all_h5_cc_h5_defconfig
@@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=672
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_SPI=y
diff --git a/configs/licheepi_nano_defconfig b/configs/licheepi_nano_defconfig
index b25c9ba77cc7..d59affb0d9ce 100644
--- a/configs/licheepi_nano_defconfig
+++ b/configs/licheepi_nano_defconfig
@@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=156
 CONFIG_DRAM_ZQ=0
 # CONFIG_VIDEO_SUNXI is not set
 CONFIG_SPL_SPI_SUNXI=y
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_XTX=y
 CONFIG_SPI=y
diff --git a/configs/linkit-smart-7688_defconfig b/configs/linkit-smart-7688_defconfig
index f592f2124987..fd11f08529d8 100644
--- a/configs/linkit-smart-7688_defconfig
+++ b/configs/linkit-smart-7688_defconfig
@@ -65,7 +65,6 @@ CONFIG_SPL_DM=y
 CONFIG_LED=y
 CONFIG_LED_BLINK=y
 CONFIG_LED_GPIO=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/lion-rk3368_defconfig b/configs/lion-rk3368_defconfig
index 9c29eb6fed37..32d34bc20a1c 100644
--- a/configs/lion-rk3368_defconfig
+++ b/configs/lion-rk3368_defconfig
@@ -75,7 +75,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_MSCC=y
diff --git a/configs/malta64_defconfig b/configs/malta64_defconfig
index bbb5c55d6d6a..ff371daaa0db 100644
--- a/configs/malta64_defconfig
+++ b/configs/malta64_defconfig
@@ -34,6 +34,7 @@ CONFIG_SYS_IDE_MAXBUS=1
 CONFIG_SYS_ATA_DATA_OFFSET=0
 CONFIG_SYS_ATA_REG_OFFSET=0
 CONFIG_SYS_ATA_IDE0_OFFSET=0x01f0
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/malta64el_defconfig b/configs/malta64el_defconfig
index d5db5a22f79b..5b130bcde9b6 100644
--- a/configs/malta64el_defconfig
+++ b/configs/malta64el_defconfig
@@ -36,6 +36,7 @@ CONFIG_SYS_IDE_MAXBUS=1
 CONFIG_SYS_ATA_DATA_OFFSET=0
 CONFIG_SYS_ATA_REG_OFFSET=0
 CONFIG_SYS_ATA_IDE0_OFFSET=0x01f0
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/malta_defconfig b/configs/malta_defconfig
index 2c32fe71549e..ce917a69de5f 100644
--- a/configs/malta_defconfig
+++ b/configs/malta_defconfig
@@ -33,6 +33,7 @@ CONFIG_SYS_IDE_MAXBUS=1
 CONFIG_SYS_ATA_DATA_OFFSET=0
 CONFIG_SYS_ATA_REG_OFFSET=0
 CONFIG_SYS_ATA_IDE0_OFFSET=0x01f0
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/maltael_defconfig b/configs/maltael_defconfig
index 88318cb791e0..de29a7a3a5bd 100644
--- a/configs/maltael_defconfig
+++ b/configs/maltael_defconfig
@@ -35,6 +35,7 @@ CONFIG_SYS_IDE_MAXBUS=1
 CONFIG_SYS_ATA_DATA_OFFSET=0
 CONFIG_SYS_ATA_REG_OFFSET=0
 CONFIG_SYS_ATA_IDE0_OFFSET=0x01f0
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/marsboard_defconfig b/configs/marsboard_defconfig
index 9f1f79680d4c..8325aaa1c9d6 100644
--- a/configs/marsboard_defconfig
+++ b/configs/marsboard_defconfig
@@ -41,6 +41,7 @@ CONFIG_SYS_I2C_LEGACY=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_PHYLIB=y
diff --git a/configs/mccmon6_nor_defconfig b/configs/mccmon6_nor_defconfig
index c0dd2da39a4f..8edc461088ca 100644
--- a/configs/mccmon6_nor_defconfig
+++ b/configs/mccmon6_nor_defconfig
@@ -58,7 +58,6 @@ CONFIG_BOUNCE_BUFFER=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/configs/mccmon6_sd_defconfig b/configs/mccmon6_sd_defconfig
index e780591f09f5..6088d08a87e6 100644
--- a/configs/mccmon6_sd_defconfig
+++ b/configs/mccmon6_sd_defconfig
@@ -56,7 +56,6 @@ CONFIG_BOUNCE_BUFFER=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/configs/medcom-wide_defconfig b/configs/medcom-wide_defconfig
index d8dc5dd6e0e7..9ed75ba86080 100644
--- a/configs/medcom-wide_defconfig
+++ b/configs/medcom-wide_defconfig
@@ -39,7 +39,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index 4346507b1db1..34e914e4dc3a 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -61,7 +61,6 @@ CONFIG_XILINX_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index d8c82a607da2..374d21e36555 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -63,7 +63,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/mt7621_nand_rfb_defconfig b/configs/mt7621_nand_rfb_defconfig
index 4289f88897b8..1acd9e5006ee 100644
--- a/configs/mt7621_nand_rfb_defconfig
+++ b/configs/mt7621_nand_rfb_defconfig
@@ -64,7 +64,6 @@ CONFIG_MMC=y
 # CONFIG_MMC_QUIRKS is not set
 # CONFIG_MMC_HW_PARTITIONING is not set
 CONFIG_MMC_MTK=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_MT7621=y
diff --git a/configs/mt7622_rfb_defconfig b/configs/mt7622_rfb_defconfig
index b015f89f4fad..0bda8cdb8fc3 100644
--- a/configs/mt7622_rfb_defconfig
+++ b/configs/mt7622_rfb_defconfig
@@ -36,6 +36,7 @@ CONFIG_SYSCON=y
 CONFIG_CLK=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_EON=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
diff --git a/configs/mvebu_ac5_rd_defconfig b/configs/mvebu_ac5_rd_defconfig
index 0a9adcc03999..677b2113b383 100644
--- a/configs/mvebu_ac5_rd_defconfig
+++ b/configs/mvebu_ac5_rd_defconfig
@@ -58,7 +58,6 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_MISC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_XENON=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/mvebu_crb_cn9130_defconfig b/configs/mvebu_crb_cn9130_defconfig
index 38f95790668b..4d5f575b0381 100644
--- a/configs/mvebu_crb_cn9130_defconfig
+++ b/configs/mvebu_crb_cn9130_defconfig
@@ -56,7 +56,6 @@ CONFIG_MMC_BROKEN_CD=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_XENON=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/mvebu_db-88f3720_defconfig b/configs/mvebu_db-88f3720_defconfig
index 51518cf8e364..372a660e4f78 100644
--- a/configs/mvebu_db-88f3720_defconfig
+++ b/configs/mvebu_db-88f3720_defconfig
@@ -56,7 +56,6 @@ CONFIG_MISC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_XENON=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/mvebu_db_cn9130_defconfig b/configs/mvebu_db_cn9130_defconfig
index f3f00197ee3e..9133e25b2418 100644
--- a/configs/mvebu_db_cn9130_defconfig
+++ b/configs/mvebu_db_cn9130_defconfig
@@ -58,7 +58,6 @@ CONFIG_MMC_BROKEN_CD=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_XENON=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_PXA3XX=y
diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_espressobin-88f3720_defconfig
index 227607acbce8..0cebebcdbc5d 100644
--- a/configs/mvebu_espressobin-88f3720_defconfig
+++ b/configs/mvebu_espressobin-88f3720_defconfig
@@ -66,7 +66,6 @@ CONFIG_MISC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_XENON=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
diff --git a/configs/mx7ulp_com_defconfig b/configs/mx7ulp_com_defconfig
index 74dfc8ab5889..f8dcc0abef56 100644
--- a/configs/mx7ulp_com_defconfig
+++ b/configs/mx7ulp_com_defconfig
@@ -40,6 +40,7 @@ CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_IMX_LPI2C=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_ATMEL=y
 CONFIG_PINCTRL=y
diff --git a/configs/n2350_defconfig b/configs/n2350_defconfig
index 696206cdbf26..26895e908f29 100644
--- a/configs/n2350_defconfig
+++ b/configs/n2350_defconfig
@@ -71,7 +71,6 @@ CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_PXA3XX=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/net2big_v2_defconfig b/configs/net2big_v2_defconfig
index aeb62fb0211a..dda627aac668 100644
--- a/configs/net2big_v2_defconfig
+++ b/configs/net2big_v2_defconfig
@@ -62,6 +62,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x0
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
diff --git a/configs/netspace_lite_v2_defconfig b/configs/netspace_lite_v2_defconfig
index a0685aab95c3..742e6205d893 100644
--- a/configs/netspace_lite_v2_defconfig
+++ b/configs/netspace_lite_v2_defconfig
@@ -62,6 +62,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x0
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
diff --git a/configs/netspace_max_v2_defconfig b/configs/netspace_max_v2_defconfig
index eb14471696f4..7779e6815e2b 100644
--- a/configs/netspace_max_v2_defconfig
+++ b/configs/netspace_max_v2_defconfig
@@ -62,6 +62,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x0
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
diff --git a/configs/netspace_mini_v2_defconfig b/configs/netspace_mini_v2_defconfig
index b594a88332ea..9e3614bb4462 100644
--- a/configs/netspace_mini_v2_defconfig
+++ b/configs/netspace_mini_v2_defconfig
@@ -60,6 +60,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x0
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
diff --git a/configs/netspace_v2_defconfig b/configs/netspace_v2_defconfig
index f7ee93efd673..1583a0adb3a2 100644
--- a/configs/netspace_v2_defconfig
+++ b/configs/netspace_v2_defconfig
@@ -62,6 +62,7 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x0
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
diff --git a/configs/oceanic_5205_5inmfd_defconfig b/configs/oceanic_5205_5inmfd_defconfig
index 6cdcf782bee2..2e62f8ed4ccc 100644
--- a/configs/oceanic_5205_5inmfd_defconfig
+++ b/configs/oceanic_5205_5inmfd_defconfig
@@ -8,6 +8,7 @@ CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=3881949
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_MTD=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_SPI=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/octeon_ebb7304_defconfig b/configs/octeon_ebb7304_defconfig
index 90e3408ae91a..00fcd57f929d 100644
--- a/configs/octeon_ebb7304_defconfig
+++ b/configs/octeon_ebb7304_defconfig
@@ -48,7 +48,6 @@ CONFIG_CLK=y
 CONFIG_MISC=y
 CONFIG_MMC=y
 CONFIG_MMC_OCTEONTX=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/octeon_nic23_defconfig b/configs/octeon_nic23_defconfig
index 80b20204af9c..8bf25200776b 100644
--- a/configs/octeon_nic23_defconfig
+++ b/configs/octeon_nic23_defconfig
@@ -56,7 +56,6 @@ CONFIG_CLK=y
 CONFIG_MISC=y
 CONFIG_MMC=y
 CONFIG_MMC_OCTEONTX=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index 67812c9851b7..3130e341e776 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -77,7 +77,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_SF_DEFAULT_BUS=4
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/odroid-xu3_defconfig b/configs/odroid-xu3_defconfig
index e3ac4d258c17..c80900e2cc5f 100644
--- a/configs/odroid-xu3_defconfig
+++ b/configs/odroid-xu3_defconfig
@@ -54,7 +54,6 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_SYS_I2C_S3C24X0=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SMC911X=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_S2MPS11=y
diff --git a/configs/odroid_defconfig b/configs/odroid_defconfig
index 2c8676886f56..fab41bd88f84 100644
--- a/configs/odroid_defconfig
+++ b/configs/odroid_defconfig
@@ -58,7 +58,6 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MAX77686=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/orangepi_pc2_defconfig b/configs/orangepi_pc2_defconfig
index fb6fbaf787a6..24ab0a0a422f 100644
--- a/configs/orangepi_pc2_defconfig
+++ b/configs/orangepi_pc2_defconfig
@@ -10,6 +10,7 @@ CONFIG_SPL_SPI_SUNXI=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_SY8106A_POWER=y
diff --git a/configs/orangepi_r1_defconfig b/configs/orangepi_r1_defconfig
index 4496aa4a45c7..2d8a52555bf1 100644
--- a/configs/orangepi_r1_defconfig
+++ b/configs/orangepi_r1_defconfig
@@ -8,6 +8,7 @@ CONFIG_DRAM_CLK=624
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_SPI=y
diff --git a/configs/orangepi_win_defconfig b/configs/orangepi_win_defconfig
index 3ddaf050a481..4ce36cbab346 100644
--- a/configs/orangepi_win_defconfig
+++ b/configs/orangepi_win_defconfig
@@ -5,6 +5,7 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN50I=y
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/orangepi_zero2_defconfig b/configs/orangepi_zero2_defconfig
index 98aed846f1f6..c4e4f8bda53b 100644
--- a/configs/orangepi_zero2_defconfig
+++ b/configs/orangepi_zero2_defconfig
@@ -17,6 +17,7 @@ CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/orangepi_zero3_defconfig b/configs/orangepi_zero3_defconfig
index 5a019fed84b7..44b7ec7887d2 100644
--- a/configs/orangepi_zero3_defconfig
+++ b/configs/orangepi_zero3_defconfig
@@ -22,6 +22,7 @@ CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_ZBIT=y
 CONFIG_PHY_MOTORCOMM=y
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/orangepi_zero_defconfig b/configs/orangepi_zero_defconfig
index f7f3bfbcc410..abdf9a939668 100644
--- a/configs/orangepi_zero_defconfig
+++ b/configs/orangepi_zero_defconfig
@@ -8,6 +8,7 @@ CONFIG_DRAM_CLK=624
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CONSOLE_MUX=y
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/origen_defconfig b/configs/origen_defconfig
index f06d7c600996..dc9285d4e99a 100644
--- a/configs/origen_defconfig
+++ b/configs/origen_defconfig
@@ -48,7 +48,6 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_USB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Samsung"
diff --git a/configs/pcm051_rev3_defconfig b/configs/pcm051_rev3_defconfig
index 831a14666fec..78469814af39 100644
--- a/configs/pcm051_rev3_defconfig
+++ b/configs/pcm051_rev3_defconfig
@@ -50,6 +50,7 @@ CONFIG_CLK_TI_CTRL=y
 CONFIG_DM_I2C=y
 CONFIG_MISC=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/peach-pi_defconfig b/configs/peach-pi_defconfig
index fd76b5b7c73f..27d438efb79c 100644
--- a/configs/peach-pi_defconfig
+++ b/configs/peach-pi_defconfig
@@ -58,7 +58,6 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SMC911X=y
diff --git a/configs/peach-pit_defconfig b/configs/peach-pit_defconfig
index 3ed17ba342ee..1c7e0114a853 100644
--- a/configs/peach-pit_defconfig
+++ b/configs/peach-pit_defconfig
@@ -57,7 +57,6 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SMC911X=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index ce770566a85f..ce999e48df27 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -66,7 +66,6 @@ CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/pine64-lts_defconfig b/configs/pine64-lts_defconfig
index 9583d293c87f..78f65c580bec 100644
--- a/configs/pine64-lts_defconfig
+++ b/configs/pine64-lts_defconfig
@@ -10,6 +10,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_SPI=y
diff --git a/configs/pine_h64_defconfig b/configs/pine_h64_defconfig
index 4712b8e46946..20a4a0a437a2 100644
--- a/configs/pine_h64_defconfig
+++ b/configs/pine_h64_defconfig
@@ -10,6 +10,7 @@ CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_PHY_SUN50I_USB3=y
diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index 1551cf18dea6..7cc0a862949d 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -14,6 +14,7 @@ CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_AXP209_POWER=y
 CONFIG_AXP_DCDC2_VOLT=1250
diff --git a/configs/plutux_defconfig b/configs/plutux_defconfig
index ab33ac7f4397..13543b3af88b 100644
--- a/configs/plutux_defconfig
+++ b/configs/plutux_defconfig
@@ -38,7 +38,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/poleg_evb_defconfig b/configs/poleg_evb_defconfig
index 6ec44df46e10..99c6d69d6b74 100644
--- a/configs/poleg_evb_defconfig
+++ b/configs/poleg_evb_defconfig
@@ -60,6 +60,7 @@ CONFIG_MISC=y
 CONFIG_NPCM_HOST=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_NPCM=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index 481549a30900..09af09ea6ee7 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -62,7 +62,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/r2dplus_defconfig b/configs/r2dplus_defconfig
index dd7d2b75a337..1c876133c274 100644
--- a/configs/r2dplus_defconfig
+++ b/configs/r2dplus_defconfig
@@ -43,6 +43,7 @@ CONFIG_SYS_ATA_REG_OFFSET=0x1000
 CONFIG_SYS_ATA_ALT_OFFSET=0x800
 CONFIG_IDE_RESET=y
 CONFIG_CLK=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/riotboard_defconfig b/configs/riotboard_defconfig
index aa8c41013be8..1b303e738bbf 100644
--- a/configs/riotboard_defconfig
+++ b/configs/riotboard_defconfig
@@ -58,6 +58,7 @@ CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_PHYLIB=y
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index 1e5559a6b9e8..3ebfb4ed4365 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -63,7 +63,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/rock_defconfig b/configs/rock_defconfig
index 94c4945fd012..b3fa76feb6b9 100644
--- a/configs/rock_defconfig
+++ b/configs/rock_defconfig
@@ -53,7 +53,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
diff --git a/configs/s5pc210_universal_defconfig b/configs/s5pc210_universal_defconfig
index 56a55f0073d6..67959ad79cdb 100644
--- a/configs/s5pc210_universal_defconfig
+++ b/configs/s5pc210_universal_defconfig
@@ -49,7 +49,6 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_SAMSUNG_ONENAND=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MAX8998=y
diff --git a/configs/sama5d27_giantboard_defconfig b/configs/sama5d27_giantboard_defconfig
index 6a205e791c52..6637d1582482 100644
--- a/configs/sama5d27_giantboard_defconfig
+++ b/configs/sama5d27_giantboard_defconfig
@@ -78,6 +78,7 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_AT91=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
diff --git a/configs/sama5d2_icp_mmc_defconfig b/configs/sama5d2_icp_mmc_defconfig
index f20b2501f14a..faf1f4315bbd 100644
--- a/configs/sama5d2_icp_mmc_defconfig
+++ b/configs/sama5d2_icp_mmc_defconfig
@@ -88,6 +88,7 @@ CONFIG_SYS_I2C_AT91=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SF_DEFAULT_BUS=2
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 996bb7aa4f10..d101cca6a738 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -167,7 +167,6 @@ CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SANDBOX=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index de06295aecd4..ea4e2c1ec394 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -217,7 +217,6 @@ CONFIG_I2C_EEPROM=y
 CONFIG_MMC_PCI=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 8f3684fb38a5..137b3c6b82c5 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -187,7 +187,6 @@ CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
 CONFIG_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_RAW_NAND=y
diff --git a/configs/seaboard_defconfig b/configs/seaboard_defconfig
index 013e1ceaafa8..bb5a4f047d7d 100644
--- a/configs/seaboard_defconfig
+++ b/configs/seaboard_defconfig
@@ -42,7 +42,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA_KEYBOARD=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/sfr_nb4-ser_ram_defconfig b/configs/sfr_nb4-ser_ram_defconfig
index b58873e19e66..7125d4953765 100644
--- a/configs/sfr_nb4-ser_ram_defconfig
+++ b/configs/sfr_nb4-ser_ram_defconfig
@@ -52,6 +52,7 @@ CONFIG_BCM6345_GPIO=y
 CONFIG_LED=y
 CONFIG_LED_BCM6358=y
 CONFIG_LED_GPIO=y
+CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=0
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index 32370be91d60..e74fbb892c89 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -64,6 +64,7 @@ CONFIG_SYS_I2C_RCAR_IIC=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_RENESAS_SDHI=y
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_BITBANGMII=y
diff --git a/configs/smdk5250_defconfig b/configs/smdk5250_defconfig
index 709aaf1642b1..8b42c8bdb324 100644
--- a/configs/smdk5250_defconfig
+++ b/configs/smdk5250_defconfig
@@ -53,7 +53,6 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SMC911X=y
diff --git a/configs/smdk5420_defconfig b/configs/smdk5420_defconfig
index c181082e3dc5..55a53178f9cf 100644
--- a/configs/smdk5420_defconfig
+++ b/configs/smdk5420_defconfig
@@ -48,7 +48,6 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SMC911X=y
diff --git a/configs/smdkv310_defconfig b/configs/smdkv310_defconfig
index 4025f80fbaf5..7a0f6f89bc98 100644
--- a/configs/smdkv310_defconfig
+++ b/configs/smdkv310_defconfig
@@ -36,6 +36,5 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_SMC911X=y
 CONFIG_USB=y
diff --git a/configs/snow_defconfig b/configs/snow_defconfig
index 6bcf47fec7a1..3a617c6cf40d 100644
--- a/configs/snow_defconfig
+++ b/configs/snow_defconfig
@@ -68,7 +68,6 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SMC911X=y
diff --git a/configs/socfpga_agilex_atf_defconfig b/configs/socfpga_agilex_atf_defconfig
index 6f8c1ee57ed3..704a9aad5f22 100644
--- a/configs/socfpga_agilex_atf_defconfig
+++ b/configs/socfpga_agilex_atf_defconfig
@@ -73,7 +73,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_MICREL=y
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index b90e5cd539e0..67a466954799 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -58,6 +58,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
+# CONFIG_CMD_MTDPARTS is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="Image"
diff --git a/configs/socfpga_agilex_vab_defconfig b/configs/socfpga_agilex_vab_defconfig
index c8433644c1bc..a907fe50c09a 100644
--- a/configs/socfpga_agilex_vab_defconfig
+++ b/configs/socfpga_agilex_vab_defconfig
@@ -74,7 +74,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_MICREL=y
diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index c35a360a557b..5c7ef4ff1b46 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -56,7 +56,6 @@ CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_defconfig
index 8980a6546899..eb7d3d2e6424 100644
--- a/configs/socfpga_arria5_defconfig
+++ b/configs/socfpga_arria5_defconfig
@@ -57,7 +57,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
diff --git a/configs/socfpga_chameleonv3_defconfig b/configs/socfpga_chameleonv3_defconfig
index fedf396b5048..6ea61ca6ea96 100644
--- a/configs/socfpga_chameleonv3_defconfig
+++ b/configs/socfpga_chameleonv3_defconfig
@@ -22,6 +22,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x15000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FPGA=y
+# CONFIG_CMD_MTDPARTS is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_MISC=y
diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index 0d744f427d9c..cdf3308370b4 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -57,7 +57,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/socfpga_dbm_soc1_defconfig b/configs/socfpga_dbm_soc1_defconfig
index 2087b6e61f16..342cfba54fd6 100644
--- a/configs/socfpga_dbm_soc1_defconfig
+++ b/configs/socfpga_dbm_soc1_defconfig
@@ -66,7 +66,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
index 646552cce652..aada30ddc5a2 100644
--- a/configs/socfpga_de0_nano_soc_defconfig
+++ b/configs/socfpga_de0_nano_soc_defconfig
@@ -57,7 +57,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_nano_defconfig
index 3ae28e745ca9..d71074e76376 100644
--- a/configs/socfpga_de10_nano_defconfig
+++ b/configs/socfpga_de10_nano_defconfig
@@ -54,7 +54,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
index f3d86bcf5262..9c5780ea22fe 100644
--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -54,7 +54,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_defconfig
index cc3038e0b25c..a7e527688c66 100644
--- a/configs/socfpga_de1_soc_defconfig
+++ b/configs/socfpga_de1_soc_defconfig
@@ -51,7 +51,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
index 05518525a464..844f6600c85c 100644
--- a/configs/socfpga_is1_defconfig
+++ b/configs/socfpga_is1_defconfig
@@ -59,7 +59,6 @@ CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_MICREL=y
diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_defconfig
index 23ea23d867ad..e5e193679815 100644
--- a/configs/socfpga_mcvevk_defconfig
+++ b/configs/socfpga_mcvevk_defconfig
@@ -57,7 +57,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
index 5856fc772e64..05b7604fb667 100644
--- a/configs/socfpga_n5x_atf_defconfig
+++ b/configs/socfpga_n5x_atf_defconfig
@@ -72,7 +72,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_MICREL=y
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index e6e9940ce99a..0cb859283d94 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -56,6 +56,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
+# CONFIG_CMD_MTDPARTS is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="Image"
diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
index 4511962aff5f..dd33210a5fe2 100644
--- a/configs/socfpga_n5x_vab_defconfig
+++ b/configs/socfpga_n5x_vab_defconfig
@@ -73,7 +73,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_MICREL=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index 67513d32c890..d9ac7208aa0f 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -86,7 +86,6 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_defconfig
index 33b0c795f73b..26547cb4262c 100644
--- a/configs/socfpga_sockit_defconfig
+++ b/configs/socfpga_sockit_defconfig
@@ -57,7 +57,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/socfpga_socrates_defconfig b/configs/socfpga_socrates_defconfig
index 9f5dc701dbe4..24d56cb4272b 100644
--- a/configs/socfpga_socrates_defconfig
+++ b/configs/socfpga_socrates_defconfig
@@ -57,7 +57,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
index dc88606daeff..325dfc59372f 100644
--- a/configs/socfpga_sr1500_defconfig
+++ b/configs/socfpga_sr1500_defconfig
@@ -65,7 +65,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_STMICRO=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
index 404b0d838088..6166a5df897c 100644
--- a/configs/socfpga_stratix10_atf_defconfig
+++ b/configs/socfpga_stratix10_atf_defconfig
@@ -74,7 +74,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_MICREL=y
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 811183b86c3f..2c3800688a8f 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -73,7 +73,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_MICREL=y
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index 0edab55ddf59..e5f7283ac6b7 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -94,7 +94,6 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/sopine_baseboard_defconfig b/configs/sopine_baseboard_defconfig
index d9b0eb37c548..6d9d71f135a1 100644
--- a/configs/sopine_baseboard_defconfig
+++ b/configs/sopine_baseboard_defconfig
@@ -10,6 +10,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_SPI=y
diff --git a/configs/spring_defconfig b/configs/spring_defconfig
index 5e791b7ddafa..2bd45cb9d60b 100644
--- a/configs/spring_defconfig
+++ b/configs/spring_defconfig
@@ -63,7 +63,6 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SMC911X=y
diff --git a/configs/stm32f429-discovery_defconfig b/configs/stm32f429-discovery_defconfig
index aae6cebd40d9..5d59edb73813 100644
--- a/configs/stm32f429-discovery_defconfig
+++ b/configs/stm32f429-discovery_defconfig
@@ -29,6 +29,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
 # CONFIG_NET is not set
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_STM32_FLASH=y
 CONFIG_SYS_MAX_FLASH_SECT=12
diff --git a/configs/stm32f429-evaluation_defconfig b/configs/stm32f429-evaluation_defconfig
index 75f6a4d0ba87..3e220d739843 100644
--- a/configs/stm32f429-evaluation_defconfig
+++ b/configs/stm32f429-evaluation_defconfig
@@ -27,6 +27,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_NET is not set
 CONFIG_ARM_PL180_MMCI=y
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_STM32_FLASH=y
 CONFIG_SYS_MAX_FLASH_SECT=12
diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
index 8f8742864f5f..8679b905415d 100644
--- a/configs/taurus_defconfig
+++ b/configs/taurus_defconfig
@@ -89,7 +89,6 @@ CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_AT91_GPIO=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
 CONFIG_NAND_ATMEL=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
diff --git a/configs/tec_defconfig b/configs/tec_defconfig
index 61b9b59820d9..4dba10683df6 100644
--- a/configs/tec_defconfig
+++ b/configs/tec_defconfig
@@ -39,7 +39,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 5059c175f508..edb62945a9ea 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -68,7 +68,6 @@ CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/trats2_defconfig b/configs/trats2_defconfig
index e663aeaa9240..67561368128c 100644
--- a/configs/trats2_defconfig
+++ b/configs/trats2_defconfig
@@ -52,7 +52,6 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MAX77686=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/trats_defconfig b/configs/trats_defconfig
index 1ceea53078f6..98925243bf44 100644
--- a/configs/trats_defconfig
+++ b/configs/trats_defconfig
@@ -51,7 +51,6 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_S5P=y
-CONFIG_MTD=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_MAX8997=y
 CONFIG_USB=y
diff --git a/configs/turris_mox_defconfig b/configs/turris_mox_defconfig
index a6fbc790eda6..a6f3fc9d70a2 100644
--- a/configs/turris_mox_defconfig
+++ b/configs/turris_mox_defconfig
@@ -74,7 +74,6 @@ CONFIG_MISC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_XENON=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 5f9a0580979a..f045dd743097 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -88,7 +88,6 @@ CONFIG_AHCI_MVEBU=y
 CONFIG_DM_PCA953X=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MV=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/uDPU_defconfig b/configs/uDPU_defconfig
index 6395609923a2..bb1c6ef6c864 100644
--- a/configs/uDPU_defconfig
+++ b/configs/uDPU_defconfig
@@ -60,7 +60,6 @@ CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_XENON=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/vocore2_defconfig b/configs/vocore2_defconfig
index 966ae6983870..0e07d04e8955 100644
--- a/configs/vocore2_defconfig
+++ b/configs/vocore2_defconfig
@@ -85,7 +85,6 @@ CONFIG_LED_GPIO=y
 CONFIG_MMC=y
 # CONFIG_MMC_HW_PARTITIONING is not set
 CONFIG_MMC_MTK=y
-CONFIG_MTD=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index 516cf04b7010..02f2d74141fe 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -70,7 +70,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/x240_defconfig b/configs/x240_defconfig
index 152413de0e50..fc0c9a7beec6 100644
--- a/configs/x240_defconfig
+++ b/configs/x240_defconfig
@@ -50,7 +50,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_PXA3XX=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/x530_defconfig b/configs/x530_defconfig
index 11210ba27b38..207748e53c04 100644
--- a/configs/x530_defconfig
+++ b/configs/x530_defconfig
@@ -71,7 +71,6 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_PXA3XX=y
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index 96be5b92b903..72a123d9654f 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -53,6 +53,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_NET is not set
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 7181b89a6519..d9fbac986c89 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -58,6 +58,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 # CONFIG_SPI_FLASH_LOCK is not set
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index 1ba6e0871bf1..5f42243d22b8 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -52,6 +52,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_NET is not set
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index c9497bb6c2af..4fa83faa4012 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -57,6 +57,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
 # CONFIG_MMC is not set
+CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 # CONFIG_SPI_FLASH_LOCK is not set
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 36c59aeea895..93973fc218d5 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -109,7 +109,6 @@ CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
-CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=10
 CONFIG_CFI_FLASH=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index a65a59c1ae11..a1d8a0d6b24d 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -154,7 +154,6 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index 8bf30ed3f8be..670add9928a6 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -54,7 +54,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ARASAN=y
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index a2984aee06c9..7763050a84a6 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -54,7 +54,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ARASAN=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 169dd4b360eb..e67136be590f 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -154,7 +154,6 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ARASAN=y
diff --git a/configs/xtfpga_defconfig b/configs/xtfpga_defconfig
index 2e742c28866b..b96dc10d85be 100644
--- a/configs/xtfpga_defconfig
+++ b/configs/xtfpga_defconfig
@@ -35,6 +35,7 @@ CONFIG_VERSION_VARIABLE=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_STDIO is not set
 # CONFIG_DM_SEQ_ALIAS is not set
+CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index f9a850ad02fb..b6b12e33d4e7 100644
--- a/configs/zynq_cse_nand_defconfig
+++ b/configs/zynq_cse_nand_defconfig
@@ -74,7 +74,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ZYNQ=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index 0aa9a8ea473e..d95f7602d685 100644
--- a/configs/zynq_cse_nor_defconfig
+++ b/configs/zynq_cse_nor_defconfig
@@ -73,7 +73,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_SHOW_PROGRESS=10
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index c56840c84975..4fdc9645d084 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -9,6 +9,8 @@ config MTD
 	  Enable the MTD stack, necessary to interact with NAND, NOR,
 	  SPI-NOR, SPI-NAND, OneNAND, etc.
 
+if MTD
+
 config DM_MTD
 	bool "Enable Driver Model for MTD drivers"
 	depends on DM
@@ -24,7 +26,6 @@ config MTD_NOR_FLASH
 
 config MTD_CONCAT
 	bool "Enable MTD device concatenation"
-	depends on MTD
 	help
 	  Enable support for concatenating multiple physical MTD devices
 	  into a single logical device. The larger logical device can then
@@ -32,7 +33,6 @@ config MTD_CONCAT
 
 config SYS_MTDPARTS_RUNTIME
 	bool "Allow MTDPARTS to be configured at runtime"
-	depends on MTD
 	help
 	  This option allows to call the function board_mtdparts_default to
 	  dynamically build the variables mtdids and mtdparts at runtime.
@@ -272,4 +272,6 @@ source "drivers/mtd/ubi/Kconfig"
 
 source "drivers/mtd/nvmxip/Kconfig"
 
+endif
+
 endmenu
-- 
2.34.1

