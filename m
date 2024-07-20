Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76A8C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 07:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14EE2885F6;
	Sat, 20 Jul 2024 09:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tmp+X4Lh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B743788648; Sat, 20 Jul 2024 08:20:44 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF4AD88AAA
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so19817325e9.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456442; x=1722061242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oihKxm7SOAHPgg8+n9KjKN8qzSxcVvEPIeQXgqHwq0k=;
 b=Tmp+X4LhJYr+PDKLpk2BBxbiz+is+5U2U9CvMzQXV9xQWEjsfJVvIICUT+lBM4RCw+
 jUiUkLzCu0XaPXN8ZXPyNQ7cOK2V8kKJv5as7Yh2BNQQTVhZn+UJaIBWhWDk0N1RKfRD
 hMVzBsr7xwZe9DgcTirRRuXpzHyss34PWiWS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456442; x=1722061242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oihKxm7SOAHPgg8+n9KjKN8qzSxcVvEPIeQXgqHwq0k=;
 b=qmGWDA63p2lT/KELl7RIgqZaZLJ9PHNbwI6GRsCQYVN5j/cXHeb/TCEnFoZEgNfrMP
 /eiBgkhqVJ/tFdX9dNu2saSqFyFCfaQwpQbuvVTUltuDauon24ZLq1MxXhpijjKoY4gR
 EJMBkgZjkHnGfLgrB/iOoBi3e7wqWl9KC7MWsIN/wlzkp9KxW8rZ34TmOfr2YvDfLb2Q
 ZSf+qtiRdCI2TLMO6bsYKdKX5UmkLUfTLNE+Hqou1TYVxhgYlz2X3mUJkbIWtFaM9Nqb
 qqhUzu2svVnaeoZh77ij7lyrNKvA8o/Whwg4uCaju4s4Jq7QtN8XmeA1/ckOxW8uAkmE
 gjJA==
X-Gm-Message-State: AOJu0YwI8VS/9ZAA5KHjl6s59knXdoLFC+kdSxtnrUQEeUqIxrALyHMB
 cY0lZC9NLuoTidHan0klgHgir50Mk1x/nPpgiqRa8qTaV3Jlu9nukmcF9fvbCw7ao0v3KSHrapw
 =
X-Google-Smtp-Source: AGHT+IHib0eYVnMTYeCdzA7iHJRucxjEFUTr3wwi9XX2Ofa2wEDDJQ2//LcPMIYsPVPH3XW6Y8fYBQ==
X-Received: by 2002:a05:600c:1d18:b0:426:6ee7:d594 with SMTP id
 5b1f17b1804b1-427dc515c07mr3842005e9.7.1721456441767; 
 Fri, 19 Jul 2024 23:20:41 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>,
 Alifer Moraes <alifer.wsdm@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Anatolij Gustschin <agust@denx.de>,
 Andre Przywara <andre.przywara@arm.com>, Angus Ainslie <angus@akkea.ca>,
 Benjamin Hahn <B.Hahn@phytec.de>, Dragan Simic <dsimic@manjaro.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Hari Nagalla <hnagalla@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Massimo Pegorer <massimo.pegorer@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Nikhil M Jain <n-jain1@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>, Teresa Remmet <t.remmet@phytec.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>,
 cmachida <curtis.machida@intel.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH 00/14] spl: mmc: Some tweaks for SPL, particularly with MMC
Date: Sat, 20 Jul 2024 07:16:52 +0100
Message-Id: <20240720061706.2644229-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jul 2024 09:31:48 +0200
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
 common/spl/spl.c                              |  35 ++--
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
 include/log.h                                 |  18 +-
 include/spl.h                                 |  60 ++++---
 test/cmd/pinmux.c                             |   8 +-
 test/image/spl_load.c                         |   4 +-
 test/image/spl_load_os.c                      |   6 +-
 test/log/log_test.c                           |   4 +-
 163 files changed, 434 insertions(+), 360 deletions(-)
 create mode 100644 arch/arm/mach-rockchip/spl_common.c

-- 
2.34.1

