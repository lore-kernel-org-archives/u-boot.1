Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFD0C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0667874AC;
	Sun, 21 Jul 2024 17:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XC5WXpm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33CBC8752A; Sun, 21 Jul 2024 17:26:18 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003DA83989
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso25981255e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575575; x=1722180375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6sM93EQrZUhMZvvzojoxivuhR42cbiO3Gw7b6UDkZIY=;
 b=XC5WXpm8/1ITibr79v4ZrbZvK55eLLnd/J/NidKYZt1RimWP5lNa5mOiE/15H2EDEf
 uaa0v/loXoTcDnln2G3O+Kql1V298chp1wl+UF5J7Q009vrnFr5X7+hhlJG06clbh7ac
 raF2xEvtB61Zbt1OxZXM/JsjhXk0Nl00h9vXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575575; x=1722180375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6sM93EQrZUhMZvvzojoxivuhR42cbiO3Gw7b6UDkZIY=;
 b=lMKv/y9qeDwwQSerTS369QoNrfHaz9sPR4hNfT/jxHx9QbVL2jgqfwrWg+0K85y6k/
 GO2VBw+PctsI+b8UdAKuc7bFnvbKV0IJLy1d63Q/081VKZYj5vSc/luODCfzrpdBuK43
 pNkhToi9aMYxwAWzzowHjc3EpwSEJMQcCA9cSGtDD0t/pkG2dyLyYIl2ILSTSjCdSCh+
 tXXGK++kThZ8nAFjec6eQSTcth4C1IGOu3TqWGQXhINU2a2kJeZotyZN0KUvbjcFvhQ9
 h9IXWgZp3J62EgCqkhw43krlFdtts3akRqxDzVDAT04kbDCusQb8yzTonxTgZhrbqfnk
 7SfA==
X-Gm-Message-State: AOJu0Yz2BiHfRi+z8XB35Z7UQn27iAls/RrXdX6+kPgzBMny+VDF9M6R
 K4zMJa/qjrQ9HLfcBLWr9v5pQUHSlMqmZgHpRJLPxp5Rv5TGFJBXP5Gq0IRrmtsBz6ZxLfwY8a0
 =
X-Google-Smtp-Source: AGHT+IFRD+ZAkFShDW86h9oyaozSkCQxXjoZqQOK1u3WfGuQo8XnEjAYzbktgFHcZ8S48rkfkprOyg==
X-Received: by 2002:a05:600c:4f90:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-427dc531d3cmr31002745e9.22.1721575570986; 
 Sun, 21 Jul 2024 08:26:10 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v2 00/14] spl: mmc: Some tweaks for SPL, particularly with MMC
Date: Sun, 21 Jul 2024 16:25:45 +0100
Message-Id: <20240721152600.3212917-1-sjg@chromium.org>
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

Changes in v2:
- Avoid changing comment
- Various updates to log messages
- Drop an unnecessary cast
- Update commit message to mention the runtime impact
- Leave assert() alone since it is only compiled in with LOG_DEBUG
- Update 'return ret' to 'return 0' when ret is known to be 0
- Use uint for arg to spl_mmc_get_device_index()

Simon Glass (14):
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
 arch/arm/mach-rockchip/spl.c                  |  21 +--
 arch/arm/mach-rockchip/spl_common.c           |  36 ++++
 arch/arm/mach-rockchip/tpl.c                  |  30 +---
 arch/arm/mach-sunxi/spl_spi_sunxi.c           |   3 +-
 .../imx8mp_rsb3720a1/imx8mp_rsb3720a1.c       |   4 +-
 common/log_console.c                          |   4 +-
 common/spl/Kconfig                            |  52 +++---
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
 configs/am62px_evm_a53_defconfig              |   1 +
 configs/am62px_evm_r5_defconfig               |   1 +
 configs/am62x_beagleplay_a53_defconfig        |   1 +
 configs/am62x_beagleplay_r5_defconfig         |   1 +
 configs/am62x_evm_a53_defconfig               |   1 +
 configs/am62x_evm_r5_defconfig                |   1 +
 configs/am64x_evm_a53_defconfig               |   1 +
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
 configs/j721e_beagleboneai64_a72_defconfig    |   1 +
 configs/j721e_beagleboneai64_r5_defconfig     |   1 +
 configs/j721e_evm_a72_defconfig               |   1 +
 configs/j721e_evm_r5_defconfig                |   1 +
 configs/j721s2_evm_a72_defconfig              |   1 +
 configs/j721s2_evm_r5_defconfig               |   1 +
 configs/j722s_evm_a53_defconfig               |   1 +
 configs/j722s_evm_r5_defconfig                |   1 +
 configs/j784s4_evm_a72_defconfig              |   1 +
 configs/j784s4_evm_r5_defconfig               |   1 +
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
 configs/phycore-imx8mm_defconfig              |   1 +
 configs/phycore-imx8mp_defconfig              |   1 +
 configs/phycore_am62x_a53_defconfig           |   1 +
 configs/phycore_am62x_r5_defconfig            |   1 +
 configs/phycore_am64x_a53_defconfig           |   1 +
 configs/phycore_am64x_r5_defconfig            |   1 +
 configs/pico-imx8mq_defconfig                 |   1 +
 configs/sama5d27_wlsom1_ek_mmc_defconfig      |   2 +-
 .../sama5d27_wlsom1_ek_qspiflash_defconfig    |   2 +-
 configs/sama5d2_icp_mmc_defconfig             |   2 +-
 configs/sandbox_defconfig                     |   1 +
 configs/sandbox_noinst_defconfig              |   1 +
 configs/sniper_defconfig                      |   2 +-
 configs/socfpga_secu1_defconfig               |   2 +-
 configs/verdin-am62_a53_defconfig             |   1 +
 configs/verdin-am62_r5_defconfig              |   1 +
 configs/verdin-imx8mm_defconfig               |   1 +
 configs/verdin-imx8mp_defconfig               |   1 +
 drivers/mmc/mmc.c                             |  49 +++---
 drivers/mmc/sdhci.c                           |  46 +++--
 drivers/usb/gadget/f_sdp.c                    |   8 +-
 include/blk.h                                 |   4 +-
 include/log.h                                 |  16 +-
 include/spl.h                                 |  60 ++++---
 test/cmd/pinmux.c                             |   8 +-
 test/image/spl_load.c                         |   4 +-
 test/image/spl_load_os.c                      |   6 +-
 test/log/log_test.c                           |   4 +-
 163 files changed, 429 insertions(+), 358 deletions(-)
 create mode 100644 arch/arm/mach-rockchip/spl_common.c

-- 
2.34.1

