Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C1C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7AF68657F;
	Wed, 30 Aug 2023 20:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JArcNHy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1622386525; Wed, 30 Aug 2023 20:05:36 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C048652E
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34cafafa50eso73095ab.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418731; x=1694023531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pH/0DWQc6/TdpNGPPXvKwpP46tB8TVQ3Me22DteSQBg=;
 b=JArcNHy7blWPCZTLfKuFC7UOyLla8cqiUEWoCUUI8wBB9bK2LC45Fwr+Eo65fAmURm
 ggyKuspVolYAodmN6zlEwmeCavEYm2wLmFyL5jer9c6GLz0q2YlvpLy9MSD4iR3uvQKI
 GUYyKWWrLc6q+T/kqQwrxRZMBSTVuaLUeD6AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418731; x=1694023531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pH/0DWQc6/TdpNGPPXvKwpP46tB8TVQ3Me22DteSQBg=;
 b=UrXRH+VtMh2gY5o2NS/44mVwxnTORpkWTHv6FnVsWGu8EOkG4A2ZMBzk4bSQ2okmNp
 pfEqTlkqI+1jkuURTeJvaQikuftreaumLVkmRCIyMjIr6+UZczuHkCHpWiFSJ9UgZ5rB
 zFwJd2ONlboFRchmEunlKmiqVq6nD2dwmf5fxHO/Q206shjdFOHX3cvJOWNHENya2sj4
 2SvA8ko7Vr6Ri4neUXgUD2B2vYrQ96C7diPetSu9VCHf6c8xfeUPxwRdSx/2hcW9Smfk
 Zbk/1DCjF4ZOAgYdnKtq7bhjf/w+xqPJpLaMsH6k0qw23Zi8J6BNI0zQt/gBoYurUWjN
 HWqw==
X-Gm-Message-State: AOJu0YxZ/oMz2OSSgOUzSlaX/qpYNt8YoI8aVOh4cHwQgvH/0XCmmYFj
 Pt/rEqKpU4FzPwNTmvzWGN5T0NJSALm7V/r9HW8=
X-Google-Smtp-Source: AGHT+IHHR0h/kBb0E1PNC8okY4EJoHldWUx+7hd6G1hG7ETHHxuNFJy734o4ajcl7nFvaqKfj3oViA==
X-Received: by 2002:a05:6e02:d42:b0:348:cd93:8c85 with SMTP id
 h2-20020a056e020d4200b00348cd938c85mr2865723ilj.9.1693418731157; 
 Wed, 30 Aug 2023 11:05:31 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 "Andrew F. Davis" <afd@ti.com>, Aswath Govindraju <a-govindraju@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Breno Lima <breno.lima@nxp.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Dave Gerlach <d-gerlach@ti.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Green Wan <green.wan@sifive.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 Le Jin <le.jin@siemens.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Mario Kicherer <dev@kicherer.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michael Walle <michael@walle.cc>, Michal Simek <michal.simek@amd.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Navin Sankar Velliangiri <navin@linumiz.com>, Niel Fourie <lusus@denx.de>,
 =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
 Peng Fan <peng.fan@nxp.com>, Silvio Fricke <open-source@softing.de>,
 Stefan Roese <sr@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Udit Agarwal <udit.agarwal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 00/32] spl: Preparation for Universal Payload
Date: Wed, 30 Aug 2023 12:04:31 -0600
Message-ID: <20230830180524.315916-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Aug 2023 20:15:48 +0200
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


Michal Simek (1):
  dm: core: support reading a single indexed u64 value

Simon Glass (31):
  spl: Use CONFIG_SPL... instead of CONFIG_..._SPL_...
  spl: Rename SYS_SPL_ARGS_ADDR to SPL_SYS_ARGS_ADDR
  spl: Avoid #ifdef with CONFIG_SPL_SYS_MALLOC
  spl: mx6: powerpc: Drop the condition on timer_init()
  spl: Drop #ifdefs for BOARD_INIT and watchdog
  spl: Avoid #ifdef with CONFIG_SPL_SYS_ARGS_ADDR
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
 common/spl/Kconfig                            |  17 +-
 common/spl/Kconfig.nxp                        |   2 +-
 common/spl/spl.c                              | 234 ++++-----------
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
 include/system-constants.h                    |  11 +-
 lib/fdtdec.c                                  |  44 ++-
 lib/of_live.c                                 | 141 ++++++++++
 test/dm/ofnode.c                              | 266 ++++++++++++++++--
 test/dm/pci.c                                 |  14 +-
 test/lib/kconfig.c                            |   4 +-
 371 files changed, 2071 insertions(+), 1138 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

