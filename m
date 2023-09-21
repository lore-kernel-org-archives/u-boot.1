Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC372E7071E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F86F864EE;
	Thu, 21 Sep 2023 13:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bYpt2v9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7DDB86CF6; Thu, 21 Sep 2023 03:57:45 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A4686C23
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-795547f055fso21306339f.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261457; x=1695866257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ScT0OuXfjeBFKs1pNbRCq0lp7LZwzSgmB6W8sR3hLik=;
 b=bYpt2v9rVL3mSllMQbgkD7sqvxV8MY0K5UDLxoYKOYE0WdEz/kn8yC4xbH+4s61Zj8
 eZ0rSH/Ni9dqbfVo1suvaIMZx7jlkE4k3NWFk49QSh93jkk4LEBnGzcy3AR1/MRDCtcq
 zu+YrrNGTf4f6NXK5ScwOZ+HPlge8qu4ZpPx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261457; x=1695866257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ScT0OuXfjeBFKs1pNbRCq0lp7LZwzSgmB6W8sR3hLik=;
 b=lYGQ2CdxE8PNkWSaIwA0/be8/YUGPph90wypra+bwRtyRWRNdSEYHzjnic088CpOBe
 1BMJcNbfaSpRMd2N86sk+7OQwY1u8AqzPnlaa/aBp19NVAsmpEv1Cif+lp4GApnMgrqU
 wL/PFxnkC+732G369Vo5d26xkORJl7YRm/d9m7Ik17dlhrq1phGwhcM5C2ISUw77e7fA
 25QoPxG5lsgWzXDjMdGQA3Rm/u2nwmD8rTutb2YKyILLZK1CaNsJUd2HV+oUwXAG08lV
 4TaNAppnfHF46lc3WIb/WfRYSjauLaOR9NacicB8b+4ybSLm83d177P2Op/o4ajeRas2
 +h+A==
X-Gm-Message-State: AOJu0YxcxPmO2HzGkyxyADpbdi2tky31hbWR2WEFeC3eVIwsRwq0D/EK
 OzMVadU+oxsCzANMfXDpeW2WZ7leS+xsQOSW6mo=
X-Google-Smtp-Source: AGHT+IGbUlCvQptaPYlF8FnuAHNnJj8AjwKorxSLQq6VpCESD2EKu4CQ0FQvy5sxhubeZQPczXifow==
X-Received: by 2002:a05:6e02:de1:b0:34d:ec9c:7321 with SMTP id
 m1-20020a056e020de100b0034dec9c7321mr4328113ilj.3.1695261457493; 
 Wed, 20 Sep 2023 18:57:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Angus Ainslie <angus@akkea.ca>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Chin-Liang See <clsee@altera.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Elena Popa <elena.popa@nxp.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, Mingkai Hu <mingkai.hu@nxp.com>,
 Niel Fourie <lusus@denx.de>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Peter.Chubb@data61.csiro.au, Roger Quadros <rogerq@kernel.org>,
 Siew Chin Lim <elly.siew.chin.lim@intel.com>,
 Silvio Fricke <open-source@softing.de>,
 Udit Agarwal <udit.agarwal@nxp.com>, kernel@puri.sm
Subject: [PATCH v2 00/32] spl: Preparation for Universal Payload
Date: Wed, 20 Sep 2023 19:56:49 -0600
Message-ID: <20230921015730.1511373-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:25:12 +0200
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

This series tidies up SPL a little and adds some core ofnode functions
needed to support Universal Payload. It also includes a few minor fix-ups
for sandbox.

For SPL the changes include CONFIG naming, removing various #ifdefs and
tidying up the FIT code.

One notable piece of the ofnode improvements is support for flattening
a livetree. This should be useful in future as we move FDT fixups to use
the ofnode API.

Changes in v2:
- Rename based on Tom's feedback
- Improve readability by moving the size part to the header file
- Explicitly copy two maintainers as it seems only Mario was auto-cc'd
- Change the approach to use the header file
- Use the same condition for both pieces to avoid possible problems
- No changes as it still seems unclear what should be done

Michal Simek (1):
  dm: core: support reading a single indexed u64 value

Simon Glass (31):
  spl: Use CONFIG_SPL... instead of CONFIG_..._SPL_...
  spl: Rename SYS_SPL_ARGS_ADDR to SPL_PAYLOAD_ARGS_ADDR
  spl: Avoid #ifdef with CONFIG_SPL_SYS_MALLOC
  spl: mx6: powerpc: Drop the condition on timer_init()
  spl: Drop #ifdefs for BOARD_INIT and watchdog
  spl: Avoid #ifdef with CONFIG_SPL_PAYLOAD_ARGS_ADDR
  spl: Drop the switch() statement for OS selection
  spl: Avoid an #ifdef when printing gd->malloc_ptr
  spl: Remove #ifdefs with BOOTSTAGE
  spl: Rename spl_load_fit_image() to load_simple_fit()
  spl: Move the full FIT code to spl_fit.c
  spl: Use the correct FIT_..._PROP constants
  spl: Move bloblist writing until the image is known
  dm: core: Reverse the argument order in ofnode_copy_props()
  dm: core: Ensure we run flattree tests on ofnode
  dm: core: Tidy up comments in the ofnode tests
  dm: core: Add a function to create an empty tree
  dm: core: Add a way to copy a node
  dm: core: Add a way to delete a node
  dm: core: Add a way to convert a devicetree to a dtb
  dm: core: Support writing a boolean
  dm: core: Support writing a 64-bit value
  dm: core: Add tests for oftree_path()
  sandbox: Move reading the RAM buffer into a better place
  sandbox: Init the EC properly even if no state file is available
  sandbox: Only read the state if we have a state file
  sandbox: Move the bloblist down a little in memory
  bloblist: Support initing from multiple places
  fdt: Allow the devicetree to come from a bloblist
  command: Include a required header in command.h
  pci: serial: Support reading PCI-register size with base

 Kconfig                                       |   2 +-
 README                                        |   2 +-
 arch/arm/cpu/armv7/ls102xa/fdt.c              |   2 +-
 .../armv8/fsl-layerscape/doc/README.falcon    |   2 +-
 arch/sandbox/cpu/start.c                      |  27 +-
 arch/sandbox/cpu/state.c                      |   2 +
 arch/sandbox/dts/test.dts                     |   7 +-
 boot/vbe_request.c                            |   2 +-
 boot/vbe_simple_os.c                          |   2 +-
 common/Kconfig                                |   2 +-
 common/bloblist.c                             |  15 +-
 common/board_f.c                              |   4 +-
 common/spl/Kconfig                            |  16 +-
 common/spl/Kconfig.nxp                        |   2 +-
 common/spl/spl.c                              | 222 ++++-----------
 common/spl/spl_ext.c                          |   4 +-
 common/spl/spl_fat.c                          |   4 +-
 common/spl/spl_fit.c                          | 127 +++++++--
 common/spl/spl_mmc.c                          |   2 +-
 common/spl/spl_nand.c                         |  10 +-
 common/spl/spl_nor.c                          |   8 +-
 common/spl/spl_spi.c                          |   2 +-
 common/spl/spl_ubi.c                          |   2 +-
 common/spl/spl_xip.c                          |   2 +-
 configs/am335x_baltos_defconfig               |   4 +-
 configs/am335x_boneblack_vboot_defconfig      |   4 +-
 configs/am335x_evm_defconfig                  |   4 +-
 configs/am335x_evm_spiboot_defconfig          |   4 +-
 configs/am335x_guardian_defconfig             |   4 +-
 configs/am335x_hs_evm_defconfig               |   4 +-
 configs/am335x_hs_evm_uart_defconfig          |   4 +-
 configs/am335x_igep003x_defconfig             |   4 +-
 configs/am335x_pdu001_defconfig               |   4 +-
 configs/am335x_shc_defconfig                  |   4 +-
 configs/am335x_shc_ict_defconfig              |   4 +-
 configs/am335x_shc_netboot_defconfig          |   4 +-
 configs/am335x_shc_sdboot_defconfig           |   4 +-
 configs/am335x_sl50_defconfig                 |   4 +-
 configs/am3517_evm_defconfig                  |   6 +-
 configs/am43xx_evm_defconfig                  |   4 +-
 configs/am43xx_evm_rtconly_defconfig          |   4 +-
 configs/am43xx_evm_usbhost_boot_defconfig     |   4 +-
 configs/am43xx_hs_evm_defconfig               |   4 +-
 configs/am57xx_evm_defconfig                  |   4 +-
 configs/am57xx_hs_evm_defconfig               |   4 +-
 configs/am57xx_hs_evm_usb_defconfig           |   4 +-
 configs/am62ax_evm_r5_defconfig               |   6 +-
 configs/am62x_evm_r5_defconfig                |   8 +-
 configs/am64x_evm_a53_defconfig               |   4 +-
 configs/am64x_evm_r5_defconfig                |   8 +-
 configs/am65x_evm_a53_defconfig               |   4 +-
 configs/am65x_evm_r5_defconfig                |   8 +-
 configs/am65x_evm_r5_usbdfu_defconfig         |   8 +-
 configs/am65x_evm_r5_usbmsc_defconfig         |   8 +-
 configs/am65x_hs_evm_a53_defconfig            |   4 +-
 configs/am65x_hs_evm_r5_defconfig             |   8 +-
 configs/apalis-tk1_defconfig                  |   8 +-
 configs/apalis_imx6_defconfig                 |   2 +-
 configs/apalis_t30_defconfig                  |   8 +-
 configs/axm_defconfig                         |   8 +-
 configs/beaver_defconfig                      |   8 +-
 configs/bitmain_antminer_s9_defconfig         |   4 +-
 configs/brppt1_mmc_defconfig                  |   4 +-
 configs/brppt2_defconfig                      |   2 +-
 configs/brsmarc1_defconfig                    |   4 +-
 configs/brxre1_defconfig                      |   4 +-
 configs/cardhu_defconfig                      |   8 +-
 configs/cei-tk1-som_defconfig                 |   8 +-
 configs/cgtqmx8_defconfig                     |   8 +-
 configs/chiliboard_defconfig                  |   4 +-
 configs/cl-som-imx7_defconfig                 |   2 +-
 configs/cm_fx6_defconfig                      |   2 +-
 configs/cm_t43_defconfig                      |   4 +-
 configs/colibri_imx6_defconfig                |   2 +-
 configs/colibri_t20_defconfig                 |   8 +-
 configs/colibri_t30_defconfig                 |   8 +-
 configs/da850evm_defconfig                    |   8 +-
 configs/da850evm_nand_defconfig               |   8 +-
 configs/dalmore_defconfig                     |   8 +-
 configs/deneb_defconfig                       |   8 +-
 configs/devkit8000_defconfig                  |   8 +-
 configs/dh_imx6_defconfig                     |   2 +-
 configs/display5_defconfig                    |   4 +-
 configs/display5_factory_defconfig            |   4 +-
 configs/dra7xx_evm_defconfig                  |   4 +-
 configs/dra7xx_hs_evm_defconfig               |   4 +-
 configs/dra7xx_hs_evm_usb_defconfig           |   4 +-
 configs/draco_defconfig                       |   6 +-
 configs/endeavoru_defconfig                   |   8 +-
 configs/etamin_defconfig                      |   6 +-
 .../gardena-smart-gateway-at91sam_defconfig   |   4 +-
 configs/ge_b1x5v2_defconfig                   |   2 +-
 configs/giedi_defconfig                       |   8 +-
 configs/grouper_common_defconfig              |   8 +-
 configs/gwventana_emmc_defconfig              |   4 +-
 configs/gwventana_nand_defconfig              |   4 +-
 configs/harmony_defconfig                     |   8 +-
 configs/igep00x0_defconfig                    |   6 +-
 configs/imx28_xea_defconfig                   |   2 +-
 configs/imx6dl_icore_nand_defconfig           |   2 +-
 configs/imx6dl_mamoj_defconfig                |   4 +-
 configs/imx6q_bosch_acc_defconfig             |   2 +-
 configs/imx6q_icore_nand_defconfig            |   2 +-
 configs/imx6q_logic_defconfig                 |   4 +-
 configs/imx6qdl_icore_mipi_defconfig          |   4 +-
 configs/imx6qdl_icore_mmc_defconfig           |   4 +-
 configs/imx6qdl_icore_nand_defconfig          |   2 +-
 configs/imx6qdl_icore_rqs_defconfig           |   4 +-
 configs/imx6ul_geam_mmc_defconfig             |   2 +-
 configs/imx6ul_geam_nand_defconfig            |   2 +-
 configs/imx6ul_isiot_emmc_defconfig           |   2 +-
 configs/imx6ul_isiot_nand_defconfig           |   2 +-
 configs/imx6ulz_smm_m2_defconfig              |   2 +-
 configs/imx7_cm_defconfig                     |   2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig    |   8 +-
 configs/imx8mm-cl-iot-gate_defconfig          |   8 +-
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |   8 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |   8 +-
 configs/imx8mm-mx8menlo_defconfig             |   8 +-
 configs/imx8mm_beacon_defconfig               |   8 +-
 configs/imx8mm_beacon_fspi_defconfig          |   8 +-
 configs/imx8mm_data_modul_edm_sbc_defconfig   |   8 +-
 configs/imx8mm_evk_defconfig                  |   8 +-
 configs/imx8mm_evk_fspi_defconfig             |   8 +-
 configs/imx8mm_phg_defconfig                  |   8 +-
 configs/imx8mm_venice_defconfig               |   6 +-
 configs/imx8mn_beacon_2g_defconfig            |   8 +-
 configs/imx8mn_beacon_defconfig               |   8 +-
 configs/imx8mn_beacon_fspi_defconfig          |   8 +-
 configs/imx8mn_bsh_smm_s2_defconfig           |   8 +-
 configs/imx8mn_bsh_smm_s2pro_defconfig        |   8 +-
 configs/imx8mn_ddr4_evk_defconfig             |   8 +-
 configs/imx8mn_evk_defconfig                  |   8 +-
 configs/imx8mn_var_som_defconfig              |   8 +-
 configs/imx8mn_venice_defconfig               |   8 +-
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |   8 +-
 configs/imx8mp_beacon_defconfig               |   8 +-
 configs/imx8mp_data_modul_edm_sbc_defconfig   |   8 +-
 configs/imx8mp_dhcom_pdk2_defconfig           |   8 +-
 configs/imx8mp_dhcom_pdk3_defconfig           |   8 +-
 configs/imx8mp_evk_defconfig                  |   8 +-
 configs/imx8mp_rsb3720a1_4G_defconfig         |   8 +-
 configs/imx8mp_rsb3720a1_6G_defconfig         |   8 +-
 configs/imx8mp_venice_defconfig               |   8 +-
 configs/imx8mq_cm_defconfig                   |   8 +-
 configs/imx8mq_evk_defconfig                  |   8 +-
 configs/imx8mq_phanbell_defconfig             |   8 +-
 configs/imx8mq_reform2_defconfig              |   8 +-
 configs/imx8qm_mek_defconfig                  |   8 +-
 configs/imx8qxp_mek_defconfig                 |   8 +-
 configs/imx8ulp_evk_defconfig                 |   8 +-
 configs/imx93_11x11_evk_defconfig             |   8 +-
 configs/imx93_11x11_evk_ld_defconfig          |   8 +-
 configs/iot2050_defconfig                     |   4 +-
 configs/j7200_evm_a72_defconfig               |   4 +-
 configs/j7200_evm_r5_defconfig                |   8 +-
 configs/j721e_evm_a72_defconfig               |   4 +-
 configs/j721e_evm_r5_defconfig                |   8 +-
 configs/j721s2_evm_a72_defconfig              |   4 +-
 configs/j721s2_evm_r5_defconfig               |   8 +-
 configs/jetson-tk1_defconfig                  |   8 +-
 configs/k2e_evm_defconfig                     |   4 +-
 configs/k2g_evm_defconfig                     |   4 +-
 configs/k2hk_evm_defconfig                    |   4 +-
 configs/k2l_evm_defconfig                     |   4 +-
 configs/kontron-sl-mx6ul_defconfig            |   2 +-
 configs/kontron-sl-mx8mm_defconfig            |   8 +-
 configs/kontron_pitx_imx8m_defconfig          |   8 +-
 configs/kontron_sl28_defconfig                |   2 +-
 configs/kp_imx6q_tpc_defconfig                |   2 +-
 configs/librem5_defconfig                     |   8 +-
 configs/liteboard_defconfig                   |   2 +-
 configs/ls1021aiot_sdcard_defconfig           |   6 +-
 configs/ls1021aqds_nand_defconfig             |   6 +-
 configs/ls1021aqds_sdcard_ifc_defconfig       |   6 +-
 configs/ls1021aqds_sdcard_qspi_defconfig      |   6 +-
 configs/ls1021atsn_sdcard_defconfig           |   6 +-
 ...s1021atwr_sdcard_ifc_SECURE_BOOT_defconfig |   6 +-
 configs/ls1021atwr_sdcard_ifc_defconfig       |   6 +-
 configs/ls1021atwr_sdcard_qspi_defconfig      |   6 +-
 configs/ls1043aqds_nand_defconfig             |   6 +-
 configs/ls1043aqds_sdcard_ifc_defconfig       |   2 +-
 configs/ls1043aqds_sdcard_qspi_defconfig      |   2 +-
 configs/ls1043ardb_nand_SECURE_BOOT_defconfig |   6 +-
 configs/ls1043ardb_nand_defconfig             |   6 +-
 .../ls1043ardb_sdcard_SECURE_BOOT_defconfig   |   2 +-
 configs/ls1043ardb_sdcard_defconfig           |   2 +-
 configs/ls1046aqds_nand_defconfig             |   2 +-
 configs/ls1046aqds_sdcard_ifc_defconfig       |   2 +-
 configs/ls1046aqds_sdcard_qspi_defconfig      |   2 +-
 configs/ls1046ardb_emmc_defconfig             |   2 +-
 configs/ls1046ardb_qspi_spl_defconfig         |   4 +-
 .../ls1046ardb_sdcard_SECURE_BOOT_defconfig   |   2 +-
 configs/ls1046ardb_sdcard_defconfig           |   2 +-
 configs/ls1088aqds_sdcard_ifc_defconfig       |   2 +-
 configs/ls1088aqds_sdcard_qspi_defconfig      |   2 +-
 ...1088ardb_sdcard_qspi_SECURE_BOOT_defconfig |   2 +-
 configs/ls1088ardb_sdcard_qspi_defconfig      |   2 +-
 configs/ls2080aqds_nand_defconfig             |   2 +-
 configs/ls2080aqds_sdcard_defconfig           |   2 +-
 configs/ls2080ardb_nand_defconfig             |   2 +-
 configs/mccmon6_nor_defconfig                 |   4 +-
 configs/mccmon6_sd_defconfig                  |   2 +-
 configs/medcom-wide_defconfig                 |   8 +-
 configs/msc_sm2s_imx8mp_defconfig             |   8 +-
 configs/mx6cuboxi_defconfig                   |   2 +-
 configs/mx6memcal_defconfig                   |   2 +-
 configs/mx6sabreauto_defconfig                |   2 +-
 configs/mx6sabresd_defconfig                  |   2 +-
 configs/mx6slevk_spl_defconfig                |   2 +-
 configs/mx6ul_14x14_evk_defconfig             |   2 +-
 configs/mx6ul_9x9_evk_defconfig               |   2 +-
 configs/myir_mys_6ulx_defconfig               |   2 +-
 configs/novena_defconfig                      |   2 +-
 configs/nyan-big_defconfig                    |   8 +-
 configs/omap35_logic_defconfig                |   6 +-
 configs/omap35_logic_somlv_defconfig          |   6 +-
 configs/omap3_beagle_defconfig                |   4 +-
 configs/omap3_evm_defconfig                   |   4 +-
 configs/omap3_logic_defconfig                 |   6 +-
 configs/omap3_logic_somlv_defconfig           |   6 +-
 configs/omap4_panda_defconfig                 |   4 +-
 configs/omap4_sdp4430_defconfig               |   4 +-
 configs/omapl138_lcdk_defconfig               |   8 +-
 configs/openpiton_riscv64_spl_defconfig       |   2 +-
 configs/opos6uldev_defconfig                  |   2 +-
 configs/paz00_defconfig                       |   8 +-
 configs/pcm058_defconfig                      |   2 +-
 configs/phycore-am335x-r2-regor_defconfig     |   4 +-
 configs/phycore-am335x-r2-wega_defconfig      |   4 +-
 configs/phycore-imx8mm_defconfig              |   8 +-
 configs/phycore-imx8mp_defconfig              |   8 +-
 configs/phycore_pcl063_defconfig              |   2 +-
 configs/phycore_pcl063_ull_defconfig          |   2 +-
 configs/pico-dwarf-imx6ul_defconfig           |   2 +-
 configs/pico-dwarf-imx7d_defconfig            |   2 +-
 configs/pico-hobbit-imx6ul_defconfig          |   2 +-
 configs/pico-hobbit-imx7d_defconfig           |   2 +-
 configs/pico-imx6_defconfig                   |   2 +-
 configs/pico-imx6ul_defconfig                 |   2 +-
 configs/pico-imx7d_bl33_defconfig             |   2 +-
 configs/pico-imx7d_defconfig                  |   2 +-
 configs/pico-imx8mq_defconfig                 |   8 +-
 configs/pico-nymph-imx7d_defconfig            |   2 +-
 configs/pico-pi-imx6ul_defconfig              |   2 +-
 configs/pico-pi-imx7d_defconfig               |   2 +-
 configs/plutux_defconfig                      |   8 +-
 configs/pxm2_defconfig                        |   6 +-
 configs/qemu-riscv32_spl_defconfig            |   2 +-
 configs/qemu-riscv64_spl_defconfig            |   2 +-
 configs/rastaban_defconfig                    |   6 +-
 configs/ringneck-px30_defconfig               |   2 +-
 configs/riotboard_defconfig                   |   4 +-
 configs/rut_defconfig                         |   6 +-
 configs/sama5d27_giantboard_defconfig         |   4 +-
 configs/sama5d27_som1_ek_mmc1_defconfig       |   4 +-
 configs/sama5d27_som1_ek_mmc_defconfig        |   4 +-
 configs/sama5d27_som1_ek_qspiflash_defconfig  |   4 +-
 configs/sama5d27_wlsom1_ek_mmc_defconfig      |   4 +-
 .../sama5d27_wlsom1_ek_qspiflash_defconfig    |   4 +-
 configs/sama5d2_icp_mmc_defconfig             |   4 +-
 configs/sama5d2_xplained_emmc_defconfig       |   4 +-
 configs/sama5d2_xplained_mmc_defconfig        |   4 +-
 configs/sama5d2_xplained_qspiflash_defconfig  |   4 +-
 configs/sama5d2_xplained_spiflash_defconfig   |   4 +-
 configs/sama5d3_xplained_mmc_defconfig        |   4 +-
 configs/sama5d3_xplained_nandflash_defconfig  |   4 +-
 configs/sama5d3xek_mmc_defconfig              |   4 +-
 configs/sama5d3xek_nandflash_defconfig        |   4 +-
 configs/sama5d3xek_spiflash_defconfig         |   4 +-
 configs/sama5d4_xplained_mmc_defconfig        |   4 +-
 configs/sama5d4_xplained_nandflash_defconfig  |   4 +-
 configs/sama5d4_xplained_spiflash_defconfig   |   4 +-
 configs/sama5d4ek_mmc_defconfig               |   4 +-
 configs/sama5d4ek_nandflash_defconfig         |   4 +-
 configs/sama5d4ek_spiflash_defconfig          |   4 +-
 configs/seaboard_defconfig                    |   8 +-
 configs/seeed_npi_imx6ull_defconfig           |   2 +-
 configs/sifive_unleashed_defconfig            |   2 +-
 configs/sifive_unmatched_defconfig            |   2 +-
 configs/smartweb_defconfig                    |   4 +-
 configs/sniper_defconfig                      |   6 +-
 configs/socfpga_agilex_atf_defconfig          |   8 +-
 configs/socfpga_agilex_defconfig              |   8 +-
 configs/socfpga_agilex_vab_defconfig          |   8 +-
 configs/socfpga_arria10_defconfig             |   8 +-
 configs/socfpga_chameleonv3_defconfig         |   8 +-
 configs/socfpga_n5x_atf_defconfig             |   8 +-
 configs/socfpga_n5x_defconfig                 |   8 +-
 configs/socfpga_n5x_vab_defconfig             |   8 +-
 configs/socfpga_stratix10_atf_defconfig       |   8 +-
 configs/socfpga_stratix10_defconfig           |   8 +-
 configs/starfive_visionfive2_defconfig        |   8 +-
 configs/stm32746g-eval_spl_defconfig          |   2 +-
 configs/stm32f746-disco_spl_defconfig         |   2 +-
 configs/stm32f769-disco_spl_defconfig         |   2 +-
 ...stm32mp15-icore-stm32mp1-ctouch2_defconfig |   8 +-
 ...tm32mp15-icore-stm32mp1-edimm2.2_defconfig |   8 +-
 ...-microgea-stm32mp1-microdev2-of7_defconfig |   8 +-
 ...mp15-microgea-stm32mp1-microdev2_defconfig |   8 +-
 configs/stm32mp15_basic_defconfig             |   8 +-
 configs/stm32mp15_dhcom_basic_defconfig       |   8 +-
 configs/stm32mp15_dhcor_basic_defconfig       |   8 +-
 configs/syzygy_hub_defconfig                  |   6 +-
 configs/taurus_defconfig                      |   8 +-
 configs/tec-ng_defconfig                      |   8 +-
 configs/tec_defconfig                         |   8 +-
 configs/thuban_defconfig                      |   6 +-
 configs/topic_miami_defconfig                 |   4 +-
 configs/topic_miamilite_defconfig             |   4 +-
 configs/topic_miamiplus_defconfig             |   4 +-
 configs/transformer_t30_defconfig             |   8 +-
 configs/trimslice_defconfig                   |   8 +-
 configs/udoo_defconfig                        |   2 +-
 configs/udoo_neo_defconfig                    |   2 +-
 configs/variscite_dart6ul_defconfig           |   2 +-
 configs/venice2_defconfig                     |   8 +-
 configs/ventana_defconfig                     |   8 +-
 configs/verdin-am62_r5_defconfig              |   8 +-
 configs/verdin-imx8mm_defconfig               |   8 +-
 configs/verdin-imx8mp_defconfig               |   8 +-
 configs/vining_2000_defconfig                 |   2 +-
 configs/vyasa-rk3288_defconfig                |   2 +-
 configs/wandboard_defconfig                   |   2 +-
 configs/x3_t30_defconfig                      |   8 +-
 configs/xilinx_zynq_virt_defconfig            |   6 +-
 configs/xilinx_zynqmp_mini_emmc0_defconfig    |   8 +-
 configs/xilinx_zynqmp_mini_emmc1_defconfig    |   8 +-
 configs/xilinx_zynqmp_mini_qspi_defconfig     |   8 +-
 configs/xilinx_zynqmp_virt_defconfig          |  10 +-
 configs/zynq_cse_nand_defconfig               |   8 +-
 configs/zynq_cse_nor_defconfig                |   8 +-
 configs/zynq_cse_qspi_defconfig               |   8 +-
 doc/arch/sandbox/sandbox.rst                  |   4 +-
 doc/develop/devicetree/control.rst            |   3 +
 doc/develop/falcon.rst                        |   2 +-
 drivers/core/Kconfig                          |   6 +-
 drivers/core/fdtaddr.c                        |   6 +-
 drivers/core/of_access.c                      |  81 +++++-
 drivers/core/ofnode.c                         | 213 +++++++++++++-
 drivers/core/read.c                           |   6 +-
 drivers/core/util.c                           |   2 +-
 drivers/misc/cros_ec_sandbox.c                |   9 +-
 drivers/pci/pci-uclass.c                      |   2 +-
 drivers/pci/pci_mvebu.c                       |   3 +-
 drivers/pci/pci_tegra.c                       |   2 +-
 drivers/pci/pcie_mediatek.c                   |   4 +-
 drivers/serial/Kconfig                        |   2 +-
 drivers/serial/ns16550.c                      |  15 +-
 dts/Kconfig                                   |   8 +
 include/asm-generic/global_data.h             |  11 +
 include/bloblist.h                            |  23 ++
 include/bootstage.h                           |  26 ++
 include/command.h                             |   3 +
 include/configs/socfpga_common.h              |   2 +-
 include/configs/socfpga_soc64_common.h        |   2 +-
 include/dm/fdtaddr.h                          |   3 +-
 include/dm/of_access.h                        |  37 +++
 include/dm/ofnode.h                           | 114 +++++++-
 include/dm/read.h                             |   8 +-
 include/fdtdec.h                              |   3 +-
 include/ns16550.h                             |   4 +-
 include/of_live.h                             |  18 ++
 include/serial.h                              |   2 +
 include/spl.h                                 |  28 +-
 include/system-constants.h                    |  20 +-
 lib/fdtdec.c                                  |  44 ++-
 lib/of_live.c                                 | 141 ++++++++++
 test/dm/ofnode.c                              | 266 ++++++++++++++++--
 test/dm/pci.c                                 |  14 +-
 test/lib/kconfig.c                            |   4 +-
 371 files changed, 2067 insertions(+), 1138 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

