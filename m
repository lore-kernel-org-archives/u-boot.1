Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15559C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DCDB88581;
	Sun, 11 Aug 2024 14:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E2VNB6So";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419AE88247; Sun, 11 Aug 2024 14:29:37 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FAF88247
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81fd925287eso135819439f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379373; x=1723984173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P2Keq315OsLMaqqPozdTtikMCrhXKHSvHPrh56RyXoA=;
 b=E2VNB6SoztrPBMqnVtM0isX+FTe2kwDE+RPyNsYm3wej9t2LcfrCrJlOm8RK5dUv24
 2FfUjSbd++BJfNymXQmzRNHb3/l/roI7zSThzKvJMjSFAwOk/5zuX6MAlP0B3wfPBeVj
 RtwJiRTjAo5i5b4E6L8GvrIpDTRJkO1611gKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379373; x=1723984173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2Keq315OsLMaqqPozdTtikMCrhXKHSvHPrh56RyXoA=;
 b=dg+WTzzPvFUURLTylc3VyDPLVinJRDgxLLWL/gFpXOA2j6MMYGh3Kx/0LtjwU/UWNu
 3Z1EUGqEZuc+wxR2PeZilAlA+MwbDq977FY6+k3/jalpaocfK23EJ7amlVbqGux8R7a6
 xm/Irmh4C7Rk8mQei0IugGnH8q298bvUsXJSKrXJXzpPGQL6B7AP9w5wiU1ETAYd3T+8
 hbU0rDccDze2wG1pxKAvew5LZk2XjDDWSL+dlhkTemVPzwjU6eIYjtPi7dim8+YCVs2Y
 wn1JUG1FSvay9rKq3vx2DeqIF7PIUah1UQ+fBIwVaoky0xynKRCWPQfpZRhr4Aa//M6E
 jgVw==
X-Gm-Message-State: AOJu0Yz+iYTvppQeZ/ZO/H72g6WNgJbjhraWzykQW4TYx7hpMwv6c64D
 qCI576qeQoJu1XI/EnlrKEX8a9pKDb17O+m22IR/0dYptaXRbBucUo8Co3yRoucUvAwi4IDWWF8
 =
X-Google-Smtp-Source: AGHT+IFm+V0hqEFSoFFCc98t/L0FJvuZexWrJx6qTuNtwhKKYkFJI2sCwcNBK0d2lh1OuAg80q+BLQ==
X-Received: by 2002:a05:6602:13d2:b0:81f:94cd:7600 with SMTP id
 ca18e2360f4ac-8225eec5836mr994676939f.13.1723379373415; 
 Sun, 11 Aug 2024 05:29:33 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 00/15] spl: mmc: Some tweaks for SPL, particularly with MMC
Date: Sun, 11 Aug 2024 06:29:09 -0600
Message-Id: <20240811122924.4035982-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This series includes various minor fixes and tweaks found when trying
to reduce the size of MMC code in SPL.

Changes in v3:
- Keep hex prefix on values which currently have it
- Fix up the second parts of the 'mmc%d busy' log_warning()
- Restore the original error message for configuring DLL
- Fix 'enver' typo while we are here
- Put enhanced size back to decimal
- Drop unnecessary braces around 'Card did not respond' message
- Drop conditions on SPL_LOAD_BLOCK
- Drop bad condition on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
- Rebase on -next
- Rebase to -next

Changes in v2:
- Drop unused constants from spl.c file
- Avoid changing comment
- Various updates to log messages
- Drop an unnecessary cast
- Fix up log_syslog.c too
- Update commit message to mention the runtime impact
- Leave assert() alone since it is only compiled in with LOG_DEBUG
- Update 'return ret' to 'return 0' when ret is known to be 0
- Use uint for arg to spl_mmc_get_device_index()

Simon Glass (15):
  configs: Resync with savedefconfig
  rockchip: Move the default timer init to a common file
  spl: Correct use of CMD_BOOTI and CMD_BOOTZ
  spl: Remove some #ifdefs in spl_parse_image_header()
  spl: Remove remaining #ifdef in spl_parse_image_header()
  mmc: Use logging instead of printf()
  mmc: Use logging instead of pr_err()
  log: Avoid including function names by default
  spl: mmc: Drop checks for CONFIG_SPL_LIBCOMMON_SUPPORT
  spl: mmc: Handle error codes consistently
  spl: mmc: Adjust args of spl_mmc_find_device()
  spl: mmc: Try to clean up raw-mode options
  spl: Use unified inline functions for spl_load_info
  spl: Create a function to init spl_load_info
  blk: Correct comment for blk_get_devnum_by_uclass_idname()

 arch/arm/include/asm/arch-rockchip/timer.h    |   3 +
 arch/arm/mach-imx/imx8m/soc.c                 |   2 +
 arch/arm/mach-imx/spl_imx_romapi.c            |  27 +--
 arch/arm/mach-rockchip/Makefile               |   4 +-
 arch/arm/mach-rockchip/spl.c                  |  28 +--
 arch/arm/mach-rockchip/spl_common.c           |  36 ++++
 arch/arm/mach-rockchip/tpl.c                  |  30 +---
 arch/arm/mach-sunxi/spl_spi_sunxi.c           |   3 +-
 arch/sandbox/cpu/spl.c                        |   5 +-
 .../imx8mp_rsb3720a1/imx8mp_rsb3720a1.c       |   4 +-
 common/log_console.c                          |   4 +-
 common/log_syslog.c                           |   2 +-
 common/spl/Kconfig                            |  54 +++---
 common/spl/spl.c                              |  30 ++--
 common/spl/spl_blk_fs.c                       |   9 +-
 common/spl/spl_ext.c                          |   3 +-
 common/spl/spl_fat.c                          |  10 +-
 common/spl/spl_mmc.c                          | 159 ++++++++----------
 common/spl/spl_nand.c                         |   4 +-
 common/spl/spl_net.c                          |   3 +-
 common/spl/spl_nor.c                          |   6 +-
 common/spl/spl_ram.c                          |   3 +-
 common/spl/spl_semihosting.c                  |   4 +-
 common/spl/spl_spi.c                          |   4 +-
 common/spl/spl_ymodem.c                       |   4 +-
 configs/am335x_guardian_defconfig             |   2 +-
 configs/am335x_pdu001_defconfig               |   2 +-
 configs/am3517_evm_defconfig                  |   2 +-
 configs/am62ax_evm_a53_defconfig              |   1 +
 configs/am62ax_evm_r5_defconfig               |   1 +
 configs/am62px_evm_a53_defconfig              |   5 +-
 configs/am62px_evm_r5_defconfig               |   1 +
 configs/am62x_beagleplay_a53_defconfig        |   1 +
 configs/am62x_beagleplay_r5_defconfig         |   1 +
 configs/am62x_evm_a53_defconfig               |   1 +
 configs/am62x_evm_r5_defconfig                |   1 +
 configs/am64x_evm_a53_defconfig               |   7 +-
 configs/am64x_evm_r5_defconfig                |   1 +
 configs/am65x_evm_a53_defconfig               |   1 +
 configs/am65x_evm_r5_defconfig                |   1 +
 configs/brppt2_defconfig                      |   2 +-
 configs/brsmarc1_defconfig                    |   2 +-
 configs/cgtqmx8_defconfig                     |   1 +
 configs/chromebit_mickey_defconfig            |   2 +-
 configs/chromebook_jerry_defconfig            |   2 +-
 configs/chromebook_minnie_defconfig           |   2 +-
 configs/chromebook_speedy_defconfig           |   2 +-
 configs/ci20_mmc_defconfig                    |   1 +
 configs/da850evm_defconfig                    |   2 +-
 configs/da850evm_nand_defconfig               |   2 +-
 configs/deneb_defconfig                       |   1 +
 configs/display5_defconfig                    |   2 +-
 configs/display5_factory_defconfig            |   2 +-
 configs/draco-rastaban_defconfig              |   2 +-
 configs/draco-thuban_defconfig                |   2 +-
 .../gardena-smart-gateway-at91sam_defconfig   |   2 +-
 configs/giedi_defconfig                       |   1 +
 configs/imx28_xea_defconfig                   |   1 +
 configs/imx28_xea_sb_defconfig                |   1 +
 configs/imx6q_logic_defconfig                 |   2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig    |   1 +
 configs/imx8mm-cl-iot-gate_defconfig          |   1 +
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |   1 +
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |   1 +
 configs/imx8mm-mx8menlo_defconfig             |   1 +
 configs/imx8mm-phygate-tauri-l_defconfig      |   1 +
 configs/imx8mm_beacon_defconfig               |   1 +
 configs/imx8mm_beacon_fspi_defconfig          |   1 +
 configs/imx8mm_data_modul_edm_sbc_defconfig   |   1 +
 configs/imx8mm_evk_defconfig                  |   1 +
 configs/imx8mm_evk_fspi_defconfig             |   1 +
 configs/imx8mm_phg_defconfig                  |   1 +
 configs/imx8mm_venice_defconfig               |   1 +
 configs/imx8mn_beacon_2g_defconfig            |   1 +
 configs/imx8mn_beacon_defconfig               |   1 +
 configs/imx8mn_beacon_fspi_defconfig          |   1 +
 configs/imx8mn_bsh_smm_s2_defconfig           |   1 +
 configs/imx8mn_bsh_smm_s2pro_defconfig        |   1 +
 configs/imx8mn_ddr4_evk_defconfig             |   1 +
 configs/imx8mn_evk_defconfig                  |   1 +
 configs/imx8mn_var_som_defconfig              |   1 +
 configs/imx8mn_venice_defconfig               |   1 +
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |   1 +
 configs/imx8mp_beacon_defconfig               |   1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig   |   1 +
 configs/imx8mp_debix_model_a_defconfig        |   1 +
 configs/imx8mp_dhcom_pdk2_defconfig           |   1 +
 configs/imx8mp_dhcom_pdk3_defconfig           |   1 +
 configs/imx8mp_evk_defconfig                  |   1 +
 configs/imx8mp_rsb3720a1_4G_defconfig         |   2 +
 configs/imx8mp_rsb3720a1_6G_defconfig         |   1 +
 configs/imx8mp_venice_defconfig               |   1 +
 configs/imx8mq_cm_defconfig                   |   1 +
 configs/imx8mq_evk_defconfig                  |   1 +
 configs/imx8mq_phanbell_defconfig             |   1 +
 configs/imx8mq_reform2_defconfig              |   1 +
 configs/imx8qm_mek_defconfig                  |   1 +
 configs/imx8qxp_mek_defconfig                 |   1 +
 configs/imx8ulp_evk_defconfig                 |   1 +
 configs/imx93-phyboard-segin_defconfig        |   1 +
 configs/imx93_11x11_evk_defconfig             |   1 +
 configs/imx93_11x11_evk_ld_defconfig          |   1 +
 configs/imx93_var_som_defconfig               |   1 +
 configs/imxrt1020-evk_defconfig               |   1 +
 configs/imxrt1050-evk_defconfig               |   1 +
 configs/imxrt1050-evk_fspi_defconfig          |   1 +
 configs/imxrt1170-evk_defconfig               |   1 +
 configs/iot2050_defconfig                     |   1 +
 configs/j7200_evm_a72_defconfig               |   1 +
 configs/j7200_evm_r5_defconfig                |   1 +
 configs/j721e_beagleboneai64_a72_defconfig    |   5 +-
 configs/j721e_beagleboneai64_r5_defconfig     |   1 +
 configs/j721e_evm_a72_defconfig               |   8 +-
 configs/j721e_evm_r5_defconfig                |   1 +
 configs/j721s2_evm_a72_defconfig              |   1 +
 configs/j721s2_evm_r5_defconfig               |   1 +
 configs/j722s_evm_a53_defconfig               |   1 +
 configs/j722s_evm_r5_defconfig                |   1 +
 configs/j784s4_evm_a72_defconfig              |   5 +-
 configs/j784s4_evm_r5_defconfig               |   1 +
 configs/kmcent2_defconfig                     |   1 -
 configs/kmcoge5ne_defconfig                   |   1 -
 configs/kmeter1_defconfig                     |   1 -
 configs/kmopti2_defconfig                     |   1 -
 configs/kmsupx5_defconfig                     |   1 -
 configs/kmtepr2_defconfig                     |   1 -
 configs/kontron-sl-mx8mm_defconfig            |   1 +
 configs/kontron_pitx_imx8m_defconfig          |   1 +
 configs/kontron_sl28_defconfig                |   1 +
 configs/librem5_defconfig                     |   1 +
 configs/ls1021aiot_sdcard_defconfig           |   1 +
 configs/ls1021aqds_nand_defconfig             |   1 +
 configs/ls1021aqds_sdcard_ifc_defconfig       |   1 +
 configs/ls1021aqds_sdcard_qspi_defconfig      |   1 +
 configs/ls1021atsn_sdcard_defconfig           |   1 +
 ...s1021atwr_sdcard_ifc_SECURE_BOOT_defconfig |   1 +
 configs/ls1021atwr_sdcard_ifc_defconfig       |   1 +
 configs/ls1021atwr_sdcard_qspi_defconfig      |   1 +
 configs/msc_sm2s_imx8mp_defconfig             |   1 +
 configs/omap35_logic_defconfig                |   2 +-
 configs/omap35_logic_somlv_defconfig          |   2 +-
 configs/omap3_logic_defconfig                 |   2 +-
 configs/omap3_logic_somlv_defconfig           |   2 +-
 configs/pg_wcom_expu1_defconfig               |   1 -
 configs/pg_wcom_expu1_update_defconfig        |   1 -
 configs/pg_wcom_seli8_defconfig               |   1 -
 configs/pg_wcom_seli8_update_defconfig        |   1 -
 configs/phycore-imx8mm_defconfig              |   1 +
 configs/phycore-imx8mp_defconfig              |   1 +
 configs/phycore_am62x_a53_defconfig           |   1 +
 configs/phycore_am62x_r5_defconfig            |   1 +
 configs/phycore_am64x_a53_defconfig           |   1 +
 configs/phycore_am64x_r5_defconfig            |   1 +
 configs/pico-imx8mq_defconfig                 |   1 +
 configs/qemu-xtensa-dc233c_defconfig          |   1 -
 configs/sama5d27_wlsom1_ek_mmc_defconfig      |   2 +-
 .../sama5d27_wlsom1_ek_qspiflash_defconfig    |   2 +-
 configs/sama5d2_icp_mmc_defconfig             |   2 +-
 configs/sandbox_defconfig                     |   1 +
 configs/sandbox_noinst_defconfig              |   1 +
 configs/sniper_defconfig                      |   2 +-
 configs/socfpga_secu1_defconfig               |   3 +-
 configs/tuge1_defconfig                       |   1 -
 configs/tuxx1_defconfig                       |   1 -
 configs/verdin-am62_a53_defconfig             |   1 +
 configs/verdin-am62_r5_defconfig              |   1 +
 configs/verdin-imx8mm_defconfig               |   1 +
 configs/verdin-imx8mp_defconfig               |   1 +
 drivers/mmc/mmc.c                             |  46 ++---
 drivers/mmc/sdhci.c                           |  52 +++---
 drivers/usb/gadget/f_sdp.c                    |   8 +-
 include/blk.h                                 |   4 +-
 include/log.h                                 |  16 +-
 include/spl.h                                 |  60 ++++---
 test/cmd/pinmux.c                             |   8 +-
 test/image/spl_load.c                         |   4 +-
 test/image/spl_load_os.c                      |   1 +
 test/log/log_test.c                           |   6 +-
 178 files changed, 448 insertions(+), 394 deletions(-)
 create mode 100644 arch/arm/mach-rockchip/spl_common.c

-- 
2.34.1

