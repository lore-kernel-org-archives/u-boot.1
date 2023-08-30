Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10190C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100248658B;
	Wed, 30 Aug 2023 20:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oL0bQ/oC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2A886537; Wed, 30 Aug 2023 20:05:48 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1636B86535
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34ccc0fca24so149575ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418738; x=1694023538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70NTCT7/2b44vhBMANOLfD5EN+cCbTCDvPuB116VISs=;
 b=oL0bQ/oC2ZF2EXSLjK5qgovDqYQYmIr3XqRuL12BnX42udI5s+67yS/mhxSJwdHzUq
 OK+xT2AzDZ5lK20sw8VRk2s/iazo0qzKuyTSbicXIf6610cKPKdB8HN9kNqVRhcZJ6kw
 4lfC6v48oZt+olm/SVzGQh7hwScQAl5SsWX20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418738; x=1694023538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70NTCT7/2b44vhBMANOLfD5EN+cCbTCDvPuB116VISs=;
 b=Ul59eBM9ywuWmq4bOI5YPMfHxadB3P08a+/MbWRMumfDcO6bYomZO1tsAL0+dfFSJb
 o6hM0cX+GRVhajBpOMgKjl5JK15LmLLoLtFq8kF8Mpfws/Ms8xSM4ctuhXOhPbym+FLK
 Z0U0crlHNwf/h4wIoznneOVz9sCk+JIqlKNSQccq24orGULG1FwPtI4j4V9crwswoUZf
 jGYapvDGSfXtmFdsy5TEXYk6JrMk60Mwfj5UFhfIpMFEqywazMeLqLn2Ya7BLkgh2SRr
 32ImsHyvYcE6l5nvGzPAbkKj/qmzSyqD0Y8jFiwjZtOITlBIygNBuEWZ13VLLBUD8lJU
 jf3A==
X-Gm-Message-State: AOJu0YxhGy7WfXX7oIj9CLmhYeRKY/O7GaFMLKTUpq7pH9SvKyHpYnRJ
 vd6NCog5+omjtjvFS7rGlB6oEzTUI3d0bhUiVEQ=
X-Google-Smtp-Source: AGHT+IHek1XfS3oNNNbT3Uj2RWmGlblj8hFilT2A8GQ/qUVghbapkY1HOt+k5trExpW8ej2PG7QCBg==
X-Received: by 2002:a05:6e02:1284:b0:345:a6c5:1ce8 with SMTP id
 y4-20020a056e02128400b00345a6c51ce8mr3190939ilq.14.1693418737381; 
 Wed, 30 Aug 2023 11:05:37 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Anatolij Gustschin <agust@denx.de>, "Andrew F. Davis" <afd@ti.com>,
 Aswath Govindraju <a-govindraju@ti.com>, Breno Lima <breno.lima@nxp.com>,
 Dave Gerlach <d-gerlach@ti.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Green Wan <green.wan@sifive.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 Le Jin <le.jin@siemens.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michael Walle <michael@walle.cc>, Michal Simek <michal.simek@amd.com>,
 Navin Sankar Velliangiri <navin@linumiz.com>, Niel Fourie <lusus@denx.de>,
 Patrick Wildt <patrick@blueri.se>,
 =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
 Peng Fan <peng.fan@nxp.com>, Siew Chin Lim <elly.siew.chin.lim@intel.com>,
 Silvio Fricke <open-source@softing.de>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 02/32] spl: Use CONFIG_SPL... instead of CONFIG_..._SPL_...
Date: Wed, 30 Aug 2023 12:04:33 -0600
Message-ID: <20230830180524.315916-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

We like to put the SPL first so it is clear that it relates to SPL. Rename
various malloc-related options which have crept in, to stick to this
convention.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Kconfig                                            |  2 +-
 README                                             |  2 +-
 arch/arm/cpu/armv7/ls102xa/fdt.c                   |  2 +-
 common/spl/Kconfig                                 | 14 +++++++-------
 common/spl/Kconfig.nxp                             |  2 +-
 common/spl/spl.c                                   |  6 +++---
 common/spl/spl_fit.c                               |  2 +-
 configs/am335x_baltos_defconfig                    |  4 ++--
 configs/am335x_boneblack_vboot_defconfig           |  4 ++--
 configs/am335x_evm_defconfig                       |  4 ++--
 configs/am335x_evm_spiboot_defconfig               |  4 ++--
 configs/am335x_guardian_defconfig                  |  4 ++--
 configs/am335x_hs_evm_defconfig                    |  4 ++--
 configs/am335x_hs_evm_uart_defconfig               |  4 ++--
 configs/am335x_igep003x_defconfig                  |  4 ++--
 configs/am335x_pdu001_defconfig                    |  4 ++--
 configs/am335x_shc_defconfig                       |  4 ++--
 configs/am335x_shc_ict_defconfig                   |  4 ++--
 configs/am335x_shc_netboot_defconfig               |  4 ++--
 configs/am335x_shc_sdboot_defconfig                |  4 ++--
 configs/am335x_sl50_defconfig                      |  4 ++--
 configs/am3517_evm_defconfig                       |  4 ++--
 configs/am43xx_evm_defconfig                       |  4 ++--
 configs/am43xx_evm_rtconly_defconfig               |  4 ++--
 configs/am43xx_evm_usbhost_boot_defconfig          |  4 ++--
 configs/am43xx_hs_evm_defconfig                    |  4 ++--
 configs/am57xx_evm_defconfig                       |  4 ++--
 configs/am57xx_hs_evm_defconfig                    |  4 ++--
 configs/am57xx_hs_evm_usb_defconfig                |  4 ++--
 configs/am62ax_evm_r5_defconfig                    |  6 +++---
 configs/am62x_evm_r5_defconfig                     |  8 ++++----
 configs/am64x_evm_a53_defconfig                    |  4 ++--
 configs/am64x_evm_r5_defconfig                     |  8 ++++----
 configs/am65x_evm_a53_defconfig                    |  4 ++--
 configs/am65x_evm_r5_defconfig                     |  8 ++++----
 configs/am65x_evm_r5_usbdfu_defconfig              |  8 ++++----
 configs/am65x_evm_r5_usbmsc_defconfig              |  8 ++++----
 configs/am65x_hs_evm_a53_defconfig                 |  4 ++--
 configs/am65x_hs_evm_r5_defconfig                  |  8 ++++----
 configs/apalis-tk1_defconfig                       |  8 ++++----
 configs/apalis_imx6_defconfig                      |  2 +-
 configs/apalis_t30_defconfig                       |  8 ++++----
 configs/axm_defconfig                              |  8 ++++----
 configs/beaver_defconfig                           |  8 ++++----
 configs/bitmain_antminer_s9_defconfig              |  4 ++--
 configs/brppt1_mmc_defconfig                       |  4 ++--
 configs/brppt2_defconfig                           |  2 +-
 configs/brsmarc1_defconfig                         |  4 ++--
 configs/brxre1_defconfig                           |  4 ++--
 configs/cardhu_defconfig                           |  8 ++++----
 configs/cei-tk1-som_defconfig                      |  8 ++++----
 configs/cgtqmx8_defconfig                          |  8 ++++----
 configs/chiliboard_defconfig                       |  4 ++--
 configs/cl-som-imx7_defconfig                      |  2 +-
 configs/cm_fx6_defconfig                           |  2 +-
 configs/cm_t43_defconfig                           |  4 ++--
 configs/colibri_imx6_defconfig                     |  2 +-
 configs/colibri_t20_defconfig                      |  8 ++++----
 configs/colibri_t30_defconfig                      |  8 ++++----
 configs/da850evm_defconfig                         |  8 ++++----
 configs/da850evm_nand_defconfig                    |  8 ++++----
 configs/dalmore_defconfig                          |  8 ++++----
 configs/deneb_defconfig                            |  8 ++++----
 configs/devkit8000_defconfig                       |  6 +++---
 configs/dh_imx6_defconfig                          |  2 +-
 configs/display5_defconfig                         |  2 +-
 configs/display5_factory_defconfig                 |  2 +-
 configs/dra7xx_evm_defconfig                       |  4 ++--
 configs/dra7xx_hs_evm_defconfig                    |  4 ++--
 configs/dra7xx_hs_evm_usb_defconfig                |  4 ++--
 configs/draco_defconfig                            |  6 +++---
 configs/endeavoru_defconfig                        |  8 ++++----
 configs/etamin_defconfig                           |  6 +++---
 configs/gardena-smart-gateway-at91sam_defconfig    |  4 ++--
 configs/ge_b1x5v2_defconfig                        |  2 +-
 configs/giedi_defconfig                            |  8 ++++----
 configs/grouper_common_defconfig                   |  8 ++++----
 configs/gwventana_emmc_defconfig                   |  2 +-
 configs/gwventana_nand_defconfig                   |  2 +-
 configs/harmony_defconfig                          |  8 ++++----
 configs/igep00x0_defconfig                         |  4 ++--
 configs/imx6dl_icore_nand_defconfig                |  2 +-
 configs/imx6dl_mamoj_defconfig                     |  2 +-
 configs/imx6q_bosch_acc_defconfig                  |  2 +-
 configs/imx6q_icore_nand_defconfig                 |  2 +-
 configs/imx6q_logic_defconfig                      |  2 +-
 configs/imx6qdl_icore_mipi_defconfig               |  2 +-
 configs/imx6qdl_icore_mmc_defconfig                |  2 +-
 configs/imx6qdl_icore_nand_defconfig               |  2 +-
 configs/imx6qdl_icore_rqs_defconfig                |  2 +-
 configs/imx6ul_geam_mmc_defconfig                  |  2 +-
 configs/imx6ul_geam_nand_defconfig                 |  2 +-
 configs/imx6ul_isiot_emmc_defconfig                |  2 +-
 configs/imx6ul_isiot_nand_defconfig                |  2 +-
 configs/imx6ulz_smm_m2_defconfig                   |  2 +-
 configs/imx7_cm_defconfig                          |  2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig         |  8 ++++----
 configs/imx8mm-cl-iot-gate_defconfig               |  8 ++++----
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig       |  8 ++++----
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig      |  8 ++++----
 configs/imx8mm-mx8menlo_defconfig                  |  8 ++++----
 configs/imx8mm_beacon_defconfig                    |  8 ++++----
 configs/imx8mm_beacon_fspi_defconfig               |  8 ++++----
 configs/imx8mm_data_modul_edm_sbc_defconfig        |  8 ++++----
 configs/imx8mm_evk_defconfig                       |  8 ++++----
 configs/imx8mm_evk_fspi_defconfig                  |  8 ++++----
 configs/imx8mm_phg_defconfig                       |  8 ++++----
 configs/imx8mm_venice_defconfig                    |  6 +++---
 configs/imx8mn_beacon_2g_defconfig                 |  8 ++++----
 configs/imx8mn_beacon_defconfig                    |  8 ++++----
 configs/imx8mn_beacon_fspi_defconfig               |  8 ++++----
 configs/imx8mn_bsh_smm_s2_defconfig                |  8 ++++----
 configs/imx8mn_bsh_smm_s2pro_defconfig             |  8 ++++----
 configs/imx8mn_ddr4_evk_defconfig                  |  8 ++++----
 configs/imx8mn_evk_defconfig                       |  8 ++++----
 configs/imx8mn_var_som_defconfig                   |  8 ++++----
 configs/imx8mn_venice_defconfig                    |  8 ++++----
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      |  8 ++++----
 configs/imx8mp_beacon_defconfig                    |  8 ++++----
 configs/imx8mp_data_modul_edm_sbc_defconfig        |  8 ++++----
 configs/imx8mp_dhcom_pdk2_defconfig                |  8 ++++----
 configs/imx8mp_dhcom_pdk3_defconfig                |  8 ++++----
 configs/imx8mp_evk_defconfig                       |  8 ++++----
 configs/imx8mp_rsb3720a1_4G_defconfig              |  8 ++++----
 configs/imx8mp_rsb3720a1_6G_defconfig              |  8 ++++----
 configs/imx8mp_venice_defconfig                    |  8 ++++----
 configs/imx8mq_cm_defconfig                        |  8 ++++----
 configs/imx8mq_evk_defconfig                       |  8 ++++----
 configs/imx8mq_phanbell_defconfig                  |  8 ++++----
 configs/imx8mq_reform2_defconfig                   |  8 ++++----
 configs/imx8qm_mek_defconfig                       |  8 ++++----
 configs/imx8qxp_mek_defconfig                      |  8 ++++----
 configs/imx8ulp_evk_defconfig                      |  8 ++++----
 configs/imx93_11x11_evk_defconfig                  |  8 ++++----
 configs/imx93_11x11_evk_ld_defconfig               |  8 ++++----
 configs/iot2050_defconfig                          |  4 ++--
 configs/j7200_evm_a72_defconfig                    |  4 ++--
 configs/j7200_evm_r5_defconfig                     |  8 ++++----
 configs/j721e_evm_a72_defconfig                    |  4 ++--
 configs/j721e_evm_r5_defconfig                     |  8 ++++----
 configs/j721s2_evm_a72_defconfig                   |  4 ++--
 configs/j721s2_evm_r5_defconfig                    |  8 ++++----
 configs/jetson-tk1_defconfig                       |  8 ++++----
 configs/k2e_evm_defconfig                          |  4 ++--
 configs/k2g_evm_defconfig                          |  4 ++--
 configs/k2hk_evm_defconfig                         |  4 ++--
 configs/k2l_evm_defconfig                          |  4 ++--
 configs/kontron-sl-mx6ul_defconfig                 |  2 +-
 configs/kontron-sl-mx8mm_defconfig                 |  8 ++++----
 configs/kontron_pitx_imx8m_defconfig               |  8 ++++----
 configs/kontron_sl28_defconfig                     |  2 +-
 configs/kp_imx6q_tpc_defconfig                     |  2 +-
 configs/librem5_defconfig                          |  8 ++++----
 configs/liteboard_defconfig                        |  2 +-
 configs/ls1021aiot_sdcard_defconfig                |  6 +++---
 configs/ls1021aqds_nand_defconfig                  |  6 +++---
 configs/ls1021aqds_sdcard_ifc_defconfig            |  6 +++---
 configs/ls1021aqds_sdcard_qspi_defconfig           |  6 +++---
 configs/ls1021atsn_sdcard_defconfig                |  6 +++---
 .../ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig    |  6 +++---
 configs/ls1021atwr_sdcard_ifc_defconfig            |  6 +++---
 configs/ls1021atwr_sdcard_qspi_defconfig           |  6 +++---
 configs/ls1043aqds_nand_defconfig                  |  6 +++---
 configs/ls1043aqds_sdcard_ifc_defconfig            |  2 +-
 configs/ls1043aqds_sdcard_qspi_defconfig           |  2 +-
 configs/ls1043ardb_nand_SECURE_BOOT_defconfig      |  6 +++---
 configs/ls1043ardb_nand_defconfig                  |  6 +++---
 configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig    |  2 +-
 configs/ls1043ardb_sdcard_defconfig                |  2 +-
 configs/ls1046aqds_nand_defconfig                  |  2 +-
 configs/ls1046aqds_sdcard_ifc_defconfig            |  2 +-
 configs/ls1046aqds_sdcard_qspi_defconfig           |  2 +-
 configs/ls1046ardb_emmc_defconfig                  |  2 +-
 configs/ls1046ardb_qspi_spl_defconfig              |  2 +-
 configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig    |  2 +-
 configs/ls1046ardb_sdcard_defconfig                |  2 +-
 configs/ls1088aqds_sdcard_ifc_defconfig            |  2 +-
 configs/ls1088aqds_sdcard_qspi_defconfig           |  2 +-
 .../ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig   |  2 +-
 configs/ls1088ardb_sdcard_qspi_defconfig           |  2 +-
 configs/ls2080aqds_nand_defconfig                  |  2 +-
 configs/ls2080aqds_sdcard_defconfig                |  2 +-
 configs/ls2080ardb_nand_defconfig                  |  2 +-
 configs/mccmon6_nor_defconfig                      |  2 +-
 configs/mccmon6_sd_defconfig                       |  2 +-
 configs/medcom-wide_defconfig                      |  8 ++++----
 configs/msc_sm2s_imx8mp_defconfig                  |  8 ++++----
 configs/mx6cuboxi_defconfig                        |  2 +-
 configs/mx6memcal_defconfig                        |  2 +-
 configs/mx6sabreauto_defconfig                     |  2 +-
 configs/mx6sabresd_defconfig                       |  2 +-
 configs/mx6slevk_spl_defconfig                     |  2 +-
 configs/mx6ul_14x14_evk_defconfig                  |  2 +-
 configs/mx6ul_9x9_evk_defconfig                    |  2 +-
 configs/myir_mys_6ulx_defconfig                    |  2 +-
 configs/novena_defconfig                           |  2 +-
 configs/nyan-big_defconfig                         |  8 ++++----
 configs/omap35_logic_defconfig                     |  4 ++--
 configs/omap35_logic_somlv_defconfig               |  4 ++--
 configs/omap3_beagle_defconfig                     |  4 ++--
 configs/omap3_evm_defconfig                        |  4 ++--
 configs/omap3_logic_defconfig                      |  4 ++--
 configs/omap3_logic_somlv_defconfig                |  4 ++--
 configs/omap4_panda_defconfig                      |  4 ++--
 configs/omap4_sdp4430_defconfig                    |  4 ++--
 configs/omapl138_lcdk_defconfig                    |  8 ++++----
 configs/openpiton_riscv64_spl_defconfig            |  2 +-
 configs/opos6uldev_defconfig                       |  2 +-
 configs/paz00_defconfig                            |  8 ++++----
 configs/pcm058_defconfig                           |  2 +-
 configs/phycore-am335x-r2-regor_defconfig          |  4 ++--
 configs/phycore-am335x-r2-wega_defconfig           |  4 ++--
 configs/phycore-imx8mm_defconfig                   |  8 ++++----
 configs/phycore-imx8mp_defconfig                   |  8 ++++----
 configs/phycore_pcl063_defconfig                   |  2 +-
 configs/phycore_pcl063_ull_defconfig               |  2 +-
 configs/pico-dwarf-imx6ul_defconfig                |  2 +-
 configs/pico-dwarf-imx7d_defconfig                 |  2 +-
 configs/pico-hobbit-imx6ul_defconfig               |  2 +-
 configs/pico-hobbit-imx7d_defconfig                |  2 +-
 configs/pico-imx6_defconfig                        |  2 +-
 configs/pico-imx6ul_defconfig                      |  2 +-
 configs/pico-imx7d_bl33_defconfig                  |  2 +-
 configs/pico-imx7d_defconfig                       |  2 +-
 configs/pico-imx8mq_defconfig                      |  8 ++++----
 configs/pico-nymph-imx7d_defconfig                 |  2 +-
 configs/pico-pi-imx6ul_defconfig                   |  2 +-
 configs/pico-pi-imx7d_defconfig                    |  2 +-
 configs/plutux_defconfig                           |  8 ++++----
 configs/pxm2_defconfig                             |  6 +++---
 configs/qemu-riscv32_spl_defconfig                 |  2 +-
 configs/qemu-riscv64_spl_defconfig                 |  2 +-
 configs/rastaban_defconfig                         |  6 +++---
 configs/ringneck-px30_defconfig                    |  2 +-
 configs/riotboard_defconfig                        |  2 +-
 configs/rut_defconfig                              |  6 +++---
 configs/sama5d27_giantboard_defconfig              |  4 ++--
 configs/sama5d27_som1_ek_mmc1_defconfig            |  4 ++--
 configs/sama5d27_som1_ek_mmc_defconfig             |  4 ++--
 configs/sama5d27_som1_ek_qspiflash_defconfig       |  4 ++--
 configs/sama5d27_wlsom1_ek_mmc_defconfig           |  4 ++--
 configs/sama5d27_wlsom1_ek_qspiflash_defconfig     |  4 ++--
 configs/sama5d2_icp_mmc_defconfig                  |  4 ++--
 configs/sama5d2_xplained_emmc_defconfig            |  4 ++--
 configs/sama5d2_xplained_mmc_defconfig             |  4 ++--
 configs/sama5d2_xplained_qspiflash_defconfig       |  4 ++--
 configs/sama5d2_xplained_spiflash_defconfig        |  4 ++--
 configs/sama5d3_xplained_mmc_defconfig             |  4 ++--
 configs/sama5d3_xplained_nandflash_defconfig       |  4 ++--
 configs/sama5d3xek_mmc_defconfig                   |  4 ++--
 configs/sama5d3xek_nandflash_defconfig             |  4 ++--
 configs/sama5d3xek_spiflash_defconfig              |  4 ++--
 configs/sama5d4_xplained_mmc_defconfig             |  4 ++--
 configs/sama5d4_xplained_nandflash_defconfig       |  4 ++--
 configs/sama5d4_xplained_spiflash_defconfig        |  4 ++--
 configs/sama5d4ek_mmc_defconfig                    |  4 ++--
 configs/sama5d4ek_nandflash_defconfig              |  4 ++--
 configs/sama5d4ek_spiflash_defconfig               |  4 ++--
 configs/seaboard_defconfig                         |  8 ++++----
 configs/seeed_npi_imx6ull_defconfig                |  2 +-
 configs/sifive_unleashed_defconfig                 |  2 +-
 configs/sifive_unmatched_defconfig                 |  2 +-
 configs/smartweb_defconfig                         |  4 ++--
 configs/sniper_defconfig                           |  6 +++---
 configs/socfpga_agilex_atf_defconfig               |  8 ++++----
 configs/socfpga_agilex_defconfig                   |  8 ++++----
 configs/socfpga_agilex_vab_defconfig               |  8 ++++----
 configs/socfpga_arria10_defconfig                  |  8 ++++----
 configs/socfpga_chameleonv3_defconfig              |  8 ++++----
 configs/socfpga_n5x_atf_defconfig                  |  8 ++++----
 configs/socfpga_n5x_defconfig                      |  8 ++++----
 configs/socfpga_n5x_vab_defconfig                  |  8 ++++----
 configs/socfpga_stratix10_atf_defconfig            |  8 ++++----
 configs/socfpga_stratix10_defconfig                |  8 ++++----
 configs/starfive_visionfive2_defconfig             |  8 ++++----
 configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig |  8 ++++----
 .../stm32mp15-icore-stm32mp1-edimm2.2_defconfig    |  8 ++++----
 ...2mp15-microgea-stm32mp1-microdev2-of7_defconfig |  8 ++++----
 ...stm32mp15-microgea-stm32mp1-microdev2_defconfig |  8 ++++----
 configs/stm32mp15_basic_defconfig                  |  8 ++++----
 configs/stm32mp15_dhcom_basic_defconfig            |  8 ++++----
 configs/stm32mp15_dhcor_basic_defconfig            |  8 ++++----
 configs/syzygy_hub_defconfig                       |  4 ++--
 configs/taurus_defconfig                           |  8 ++++----
 configs/tec-ng_defconfig                           |  8 ++++----
 configs/tec_defconfig                              |  8 ++++----
 configs/thuban_defconfig                           |  6 +++---
 configs/topic_miami_defconfig                      |  4 ++--
 configs/topic_miamilite_defconfig                  |  4 ++--
 configs/topic_miamiplus_defconfig                  |  4 ++--
 configs/transformer_t30_defconfig                  |  8 ++++----
 configs/trimslice_defconfig                        |  8 ++++----
 configs/udoo_defconfig                             |  2 +-
 configs/udoo_neo_defconfig                         |  2 +-
 configs/variscite_dart6ul_defconfig                |  2 +-
 configs/venice2_defconfig                          |  8 ++++----
 configs/ventana_defconfig                          |  8 ++++----
 configs/verdin-am62_r5_defconfig                   |  8 ++++----
 configs/verdin-imx8mm_defconfig                    |  8 ++++----
 configs/verdin-imx8mp_defconfig                    |  8 ++++----
 configs/vining_2000_defconfig                      |  2 +-
 configs/wandboard_defconfig                        |  2 +-
 configs/x3_t30_defconfig                           |  8 ++++----
 configs/xilinx_zynq_virt_defconfig                 |  4 ++--
 configs/xilinx_zynqmp_mini_emmc0_defconfig         |  8 ++++----
 configs/xilinx_zynqmp_mini_emmc1_defconfig         |  8 ++++----
 configs/xilinx_zynqmp_mini_qspi_defconfig          |  8 ++++----
 configs/xilinx_zynqmp_virt_defconfig               |  8 ++++----
 configs/zynq_cse_nand_defconfig                    |  8 ++++----
 configs/zynq_cse_nor_defconfig                     |  8 ++++----
 configs/zynq_cse_qspi_defconfig                    |  8 ++++----
 drivers/core/Kconfig                               |  6 +++---
 drivers/serial/Kconfig                             |  2 +-
 include/configs/socfpga_common.h                   |  2 +-
 include/configs/socfpga_soc64_common.h             |  2 +-
 include/system-constants.h                         |  6 +++---
 316 files changed, 794 insertions(+), 794 deletions(-)

diff --git a/Kconfig b/Kconfig
index 91170bf8d22..1460f8aa849 100644
--- a/Kconfig
+++ b/Kconfig
@@ -308,7 +308,7 @@ config SPL_SYS_MALLOC_F_LEN
 	  particular needs this to operate, so that it can allocate the
 	  initial serial device and any others that are needed.
 
-	  It is possible to enable CFG_SYS_SPL_MALLOC_START to start a new
+	  It is possible to enable CFG_SPL_SYS_MALLOC_START to start a new
 	  malloc() region in SDRAM once it is inited.
 
 config TPL_SYS_MALLOC_F_LEN
diff --git a/README b/README
index 15a19caf740..a1f90642274 100644
--- a/README
+++ b/README
@@ -1297,7 +1297,7 @@ Configuration Settings:
 - CONFIG_SYS_MALLOC_SIMPLE
 		Provides a simple and small malloc() and calloc() for those
 		boards which do not use the full malloc in SPL (which is
-		enabled with CONFIG_SYS_SPL_MALLOC).
+		enabled with CONFIG_SPL_SYS_MALLOC).
 
 - CFG_SYS_BOOTMAPSZ:
 		Maximum size of memory mapped by the startup code of
diff --git a/arch/arm/cpu/armv7/ls102xa/fdt.c b/arch/arm/cpu/armv7/ls102xa/fdt.c
index a5c5c780ae8..1c3d24bcad9 100644
--- a/arch/arm/cpu/armv7/ls102xa/fdt.c
+++ b/arch/arm/cpu/armv7/ls102xa/fdt.c
@@ -136,7 +136,7 @@ void ft_cpu_setup(void *blob, struct bd_info *bd)
 	 */
 	off = fdt_add_mem_rsv(blob, CONFIG_TEXT_BASE - UBOOT_HEAD_LEN,
 			      CONFIG_SYS_MONITOR_LEN +
-			      CONFIG_SYS_SPL_MALLOC_SIZE + UBOOT_HEAD_LEN);
+			      CONFIG_SPL_SYS_MALLOC_SIZE + UBOOT_HEAD_LEN);
 	if (off < 0)
 		printf("Failed to reserve memory for SD boot deep sleep: %s\n",
 		       fdt_strerror(off));
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 1c2fe78e3e0..b9d96fbe135 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -402,21 +402,21 @@ config SPL_SEPARATE_BSS
 	  location is used. Normally we put the device tree at the end of BSS
 	  but with this option enabled, it goes at _image_binary_end.
 
-config SYS_SPL_MALLOC
+config SPL_SYS_MALLOC
 	bool "Enable malloc pool in SPL"
 	depends on SPL_FRAMEWORK
 
-config HAS_CUSTOM_SPL_MALLOC_START
+config SPL_HAS_CUSTOM_MALLOC_START
 	bool "For the SPL malloc pool, define a custom starting address"
-	depends on SYS_SPL_MALLOC
+	depends on SPL_SYS_MALLOC
 
-config CUSTOM_SYS_SPL_MALLOC_ADDR
+config SPL_CUSTOM_SYS_MALLOC_ADDR
 	hex "SPL malloc addr"
-	depends on HAS_CUSTOM_SPL_MALLOC_START
+	depends on SPL_HAS_CUSTOM_MALLOC_START
 
-config SYS_SPL_MALLOC_SIZE
+config SPL_SYS_MALLOC_SIZE
 	hex "Size of the SPL malloc pool"
-	depends on SYS_SPL_MALLOC
+	depends on SPL_SYS_MALLOC
 	default 0x100000
 
 config SPL_READ_ONLY
diff --git a/common/spl/Kconfig.nxp b/common/spl/Kconfig.nxp
index fc696cf0cee..53e9b9f8d34 100644
--- a/common/spl/Kconfig.nxp
+++ b/common/spl/Kconfig.nxp
@@ -59,7 +59,7 @@ config SPL_RELOC_TEXT_BASE
 config SPL_RELOC_STACK
 	hex "Address of the start of the stack SPL will use after relocation."
 	help
-	  If unspecified, this is equal to CFG_SYS_SPL_MALLOC_START.  Starting
+	  If unspecified, this is equal to CFG_SPL_SYS_MALLOC_START.  Starting
 	  address of the malloc pool used in SPL.  When this option is set the full
 	  malloc is used in SPL and it is set up by spl_init() and before that, the
 	  simple malloc() can be used if CONFIG_SYS_MALLOC_F is defined.
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 0062f3f45d9..1e50043cf77 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -754,8 +754,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 
 	spl_set_bd();
 
-#if defined(CONFIG_SYS_SPL_MALLOC)
-	mem_malloc_init(SYS_SPL_MALLOC_START, CONFIG_SYS_SPL_MALLOC_SIZE);
+#if defined(CONFIG_SPL_SYS_MALLOC)
+	mem_malloc_init(SPL_SYS_MALLOC_START, CONFIG_SPL_SYS_MALLOC_SIZE);
 	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 #endif
 	if (!(gd->flags & GD_FLG_SPL_INIT)) {
@@ -886,7 +886,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	default:
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
 	}
-#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SYS_SPL_MALLOC_SIZE)
+#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
 	debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
 	      gd->malloc_ptr / 1024);
 #endif
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 730639f7562..1bfdc0af496 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -530,7 +530,7 @@ static void *spl_get_fit_load_buffer(size_t size)
 	buf = malloc_cache_aligned(size);
 	if (!buf) {
 		pr_err("Could not get FIT buffer of %lu bytes\n", (ulong)size);
-		pr_err("\tcheck CONFIG_SYS_SPL_MALLOC_SIZE\n");
+		pr_err("\tcheck CONFIG_SPL_SYS_MALLOC_SIZE\n");
 		buf = spl_get_load_buffer(0, size);
 	}
 	return buf;
diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defconfig
index 6ef3c78390a..c4b8e6785eb 100644
--- a/configs/am335x_baltos_defconfig
+++ b/configs/am335x_baltos_defconfig
@@ -18,8 +18,8 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run usbboot;run mmcboot;setenv mmcdev 1; setenv bootpart 1:2; run mmcboot;run nandboot;"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MTD_SUPPORT=y
diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/am335x_boneblack_vboot_defconfig
index e581accc217..531703010ab 100644
--- a/configs/am335x_boneblack_vboot_defconfig
+++ b/configs/am335x_boneblack_vboot_defconfig
@@ -23,8 +23,8 @@ CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_MUSB_NEW=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_NET=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index a179f1ed5f2..08e3f22b1fe 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -20,8 +20,8 @@ CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_boot
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_ETH=y
 # CONFIG_SPL_FS_EXT4 is not set
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index 09d5e803a3e..e72a936983b 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -23,8 +23,8 @@ CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_boot
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index 7c4085d0849..01d848ceede 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -31,8 +31,8 @@ CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_ETH=y
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index a3a4ab361c3..4f5e2088c56 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -21,8 +21,8 @@ CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_MAX_SIZE=0xb0b0
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
 # CONFIG_SPL_ENV_SUPPORT is not set
 # CONFIG_SPL_FS_EXT4 is not set
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index 6e4d327880c..dc7fc4b0aa4 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -24,8 +24,8 @@ CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_MAX_SIZE=0x9ab0
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
 # CONFIG_SPL_ENV_SUPPORT is not set
 # CONFIG_SPL_FS_EXT4 is not set
diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index 37e1259a8b1..04ddba706ba 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -19,8 +19,8 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt;run mmcboot;run nandboot;run netboot;"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MTD_SUPPORT=y
diff --git a/configs/am335x_pdu001_defconfig b/configs/am335x_pdu001_defconfig
index e68efde33b6..557949c651e 100644
--- a/configs/am335x_pdu001_defconfig
+++ b/configs/am335x_pdu001_defconfig
@@ -24,8 +24,8 @@ CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_BOOTCOMMAND="run eval_boot_device;part uuid mmc ${mmc_boot}:${root_fs_partition} root_fs_partuuid;setenv bootargs console=${console} vt.global_cursor_default=0 root=PARTUUID=${root_fs_partuuid} rootfstype=ext4 rootwait rootdelay=1;fatload mmc ${mmc_boot} ${fdtaddr} ${fdtfile};fatload mmc ${mmc_boot} ${loadaddr} ${bootfile};bootz ${loadaddr} - ${fdtaddr}"
 CONFIG_BOARD_LATE_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_I2C=y
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/am335x_shc_defconfig b/configs/am335x_shc_defconfig
index 51b25fda643..c902354863b 100644
--- a/configs/am335x_shc_defconfig
+++ b/configs/am335x_shc_defconfig
@@ -33,8 +33,8 @@ CONFIG_BOOTCOMMAND="if mmc dev 1; mmc rescan; then run emmc_setup; else echo ERR
 CONFIG_DEFAULT_FDT_FILE="am335x-shc"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/am335x_shc_ict_defconfig b/configs/am335x_shc_ict_defconfig
index 5766f71c1c8..1cbb57fb529 100644
--- a/configs/am335x_shc_ict_defconfig
+++ b/configs/am335x_shc_ict_defconfig
@@ -31,8 +31,8 @@ CONFIG_BOOTCOMMAND="if mmc dev 0; mmc rescan; then run sd_setup; else echo ERROR
 CONFIG_DEFAULT_FDT_FILE="am335x-shc"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/am335x_shc_netboot_defconfig b/configs/am335x_shc_netboot_defconfig
index 5073efa01ab..7ac1ef81870 100644
--- a/configs/am335x_shc_netboot_defconfig
+++ b/configs/am335x_shc_netboot_defconfig
@@ -34,8 +34,8 @@ CONFIG_BOOTCOMMAND="run fusecmd; if run netboot; then echo Booting from network;
 CONFIG_DEFAULT_FDT_FILE="am335x-shc"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
diff --git a/configs/am335x_shc_sdboot_defconfig b/configs/am335x_shc_sdboot_defconfig
index f35df6c23c6..127f095c02a 100644
--- a/configs/am335x_shc_sdboot_defconfig
+++ b/configs/am335x_shc_sdboot_defconfig
@@ -34,8 +34,8 @@ CONFIG_BOOTCOMMAND="if mmc dev 0; mmc rescan; then run sd_setup; else echo ERROR
 CONFIG_DEFAULT_FDT_FILE="am335x-shc"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 44c23019e49..9ba376feda8 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -23,8 +23,8 @@ CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
 CONFIG_AUTOBOOT_DELAY_STR="d"
 CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index fcb0b3d32bc..dda23549278 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -22,8 +22,8 @@ CONFIG_BOOTDELAY=10
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then echo SD/MMC found on device $mmcdev; if run loadbootenv; then run importbootenv; fi; echo Checking if uenvcmd is set ...; if test -n $uenvcmd; then echo Running uenvcmd ...; run uenvcmd; fi; echo Running default loadimage ...; setenv bootfile zImage; if run loadimage; then run loadfdt; run mmcboot; fi; else run nandboot; fi"
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index 323862009fc..6571afd345e 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -18,8 +18,8 @@ CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_MISC_INIT_R is not set
 CONFIG_SPL_MAX_SIZE=0x439e0
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_ETH=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_MTD_SUPPORT=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index 9cafe9c10c8..e84aed4d54d 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -18,8 +18,8 @@ CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_MISC_INIT_R is not set
 CONFIG_SPL_MAX_SIZE=0x439e0
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index 406c0fc2d7c..0cae3242b04 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -17,8 +17,8 @@ CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_MISC_INIT_R is not set
 CONFIG_SPL_MAX_SIZE=0x37690
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index 01428ac7aa7..115ce68d680 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -24,8 +24,8 @@ CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_MISC_INIT_R is not set
 CONFIG_SPL_MAX_SIZE=0x36100
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_ETH=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_MTD_SUPPORT=y
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 6db59225c28..b4c04acec79 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -30,8 +30,8 @@ CONFIG_AVB_VERIFY=y
 CONFIG_ANDROID_AB=y
 CONFIG_SPL_MAX_SIZE=0x7bc00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_DMA=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 94ffce1a998..d137cc3c57b 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -33,8 +33,8 @@ CONFIG_AVB_VERIFY=y
 CONFIG_ANDROID_AB=y
 CONFIG_SPL_MAX_SIZE=0x7a8b0
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_DMA=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 404e714d4f0..b12f262ff57 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -35,8 +35,8 @@ CONFIG_AVB_VERIFY=y
 CONFIG_ANDROID_AB=y
 CONFIG_SPL_MAX_SIZE=0x74eb0
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_DMA=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 05c30cbba19..2c53673debb 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -36,9 +36,9 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 3c5f3672984..b85da381bed 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -43,10 +43,10 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 718ad176cb3..9c41055b1e9 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -41,8 +41,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DMA=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index b501c17b87a..ddc41480583 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -44,10 +44,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index 4301553af8d..c3b44488492 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -43,8 +43,8 @@ CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DMA=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index d5196c2024e..b2f1e721b36 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -40,10 +40,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0xc00
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index 88f68aa70e4..f610b2dd94e 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -37,10 +37,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0xc00
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index 8da49c78c82..70ba50083b8 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -36,10 +36,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0xc00
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/am65x_hs_evm_a53_defconfig b/configs/am65x_hs_evm_a53_defconfig
index 3f9626e4550..ca90eea421a 100644
--- a/configs/am65x_hs_evm_a53_defconfig
+++ b/configs/am65x_hs_evm_a53_defconfig
@@ -43,8 +43,8 @@ CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DMA=y
diff --git a/configs/am65x_hs_evm_r5_defconfig b/configs/am65x_hs_evm_r5_defconfig
index 0c7b53ca2c0..8b3b3fcb136 100644
--- a/configs/am65x_hs_evm_r5_defconfig
+++ b/configs/am65x_hs_evm_r5_defconfig
@@ -36,10 +36,10 @@ CONFIG_SPL_BSS_START_ADDR=0x41c7effc
 CONFIG_SPL_BSS_MAX_SIZE=0xc00
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
index fda85c2d6ae..59bca77cc65 100644
--- a/configs/apalis-tk1_defconfig
+++ b/configs/apalis-tk1_defconfig
@@ -29,10 +29,10 @@ CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1054
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index 5f0f78191c4..f3062b360a6 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -40,7 +40,7 @@ CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_MISC_INIT_R=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_I2C=y
 CONFIG_SYS_MAXARGS=48
diff --git a/configs/apalis_t30_defconfig b/configs/apalis_t30_defconfig
index 83aab2450be..b7e87de62e4 100644
--- a/configs/apalis_t30_defconfig
+++ b/configs/apalis_t30_defconfig
@@ -24,10 +24,10 @@ CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1054
diff --git a/configs/axm_defconfig b/configs/axm_defconfig
index 5d6dd2ae913..00e02e02374 100644
--- a/configs/axm_defconfig
+++ b/configs/axm_defconfig
@@ -45,10 +45,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x600
 # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x20ba0000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x460000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x20ba0000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x460000
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_RAW_ONLY=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/beaver_defconfig b/configs/beaver_defconfig
index 0d8a74be7aa..b1fbe55b072 100644
--- a/configs/beaver_defconfig
+++ b/configs/beaver_defconfig
@@ -22,10 +22,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2084
 # CONFIG_CMD_IMI is not set
diff --git a/configs/bitmain_antminer_s9_defconfig b/configs/bitmain_antminer_s9_defconfig
index 3995d41ce1b..8893358a884 100644
--- a/configs/bitmain_antminer_s9_defconfig
+++ b/configs/bitmain_antminer_s9_defconfig
@@ -34,8 +34,8 @@ CONFIG_SPL_BSS_START_ADDR=0x100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x2000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=2075
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index 653620263cd..165e4d91fcc 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -37,8 +37,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_I2C=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_POWER=y
diff --git a/configs/brppt2_defconfig b/configs/brppt2_defconfig
index 05ee4c5797e..73bc6240068 100644
--- a/configs/brppt2_defconfig
+++ b/configs/brppt2_defconfig
@@ -32,7 +32,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run b_default"
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
diff --git a/configs/brsmarc1_defconfig b/configs/brsmarc1_defconfig
index 94943fccf1a..419fe4529de 100644
--- a/configs/brsmarc1_defconfig
+++ b/configs/brsmarc1_defconfig
@@ -38,8 +38,8 @@ CONFIG_BOARD_TYPES=y
 CONFIG_ARCH_MISC_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_I2C=y
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index b50aef0aad9..3ef35f0a675 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -34,8 +34,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_I2C=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_POWER=y
diff --git a/configs/cardhu_defconfig b/configs/cardhu_defconfig
index 4fe4621f037..e076215f28d 100644
--- a/configs/cardhu_defconfig
+++ b/configs/cardhu_defconfig
@@ -21,10 +21,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2084
 # CONFIG_CMD_IMI is not set
diff --git a/configs/cei-tk1-som_defconfig b/configs/cei-tk1-som_defconfig
index b920ac2ae40..e7221678dd8 100644
--- a/configs/cei-tk1-som_defconfig
+++ b/configs/cei-tk1-som_defconfig
@@ -25,10 +25,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2086
 # CONFIG_CMD_IMI is not set
diff --git a/configs/cgtqmx8_defconfig b/configs/cgtqmx8_defconfig
index 32e0647c93c..e699430bf9f 100644
--- a/configs/cgtqmx8_defconfig
+++ b/configs/cgtqmx8_defconfig
@@ -36,10 +36,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 # CONFIG_SPL_BINMAN_UBOOT_SYMBOLS is not set
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x120000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x3000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x120000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x3000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
 CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=0
diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconfig
index 0c3fd428407..06642d282d1 100644
--- a/configs/chiliboard_defconfig
+++ b/configs/chiliboard_defconfig
@@ -24,8 +24,8 @@ CONFIG_BOOTCOMMAND="run mmcboot; run nandboot; run netboot"
 CONFIG_DEFAULT_FDT_FILE="am335x-chiliboard.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/cl-som-imx7_defconfig b/configs/cl-som-imx7_defconfig
index 2277d19a2d8..69eba97f4e6 100644
--- a/configs/cl-som-imx7_defconfig
+++ b/configs/cl-som-imx7_defconfig
@@ -32,7 +32,7 @@ CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x80
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/cm_fx6_defconfig b/configs/cm_fx6_defconfig
index 56527dadd0d..c20e0fb8942 100644
--- a/configs/cm_fx6_defconfig
+++ b/configs/cm_fx6_defconfig
@@ -33,7 +33,7 @@ CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run legacy_bootcmd"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="usb start;sf probe"
 CONFIG_MISC_INIT_R=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x80
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index 12d010ab64b..32c4ec45d4b 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -33,8 +33,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 # CONFIG_MISC_INIT_R is not set
 CONFIG_SPL_MAX_SIZE=0x37690
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x480
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index be1037b6cbb..f41895ce704 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -39,7 +39,7 @@ CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_MISC_INIT_R=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_I2C=y
 CONFIG_SYS_MAXARGS=48
diff --git a/configs/colibri_t20_defconfig b/configs/colibri_t20_defconfig
index eb2e202f6f2..f6ac66456a0 100644
--- a/configs/colibri_t20_defconfig
+++ b/configs/colibri_t20_defconfig
@@ -22,10 +22,10 @@ CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x90000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1055
diff --git a/configs/colibri_t30_defconfig b/configs/colibri_t30_defconfig
index 8098ff7abc1..31b3ee84a3e 100644
--- a/configs/colibri_t30_defconfig
+++ b/configs/colibri_t30_defconfig
@@ -23,10 +23,10 @@ CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1055
diff --git a/configs/da850evm_defconfig b/configs/da850evm_defconfig
index 2001327ab08..91f2370a236 100644
--- a/configs/da850evm_defconfig
+++ b/configs/da850evm_defconfig
@@ -46,10 +46,10 @@ CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0f70000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x110000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0f70000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x110000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/da850evm_nand_defconfig b/configs/da850evm_nand_defconfig
index eddaa49f0f2..5fd0bd13c92 100644
--- a/configs/da850evm_nand_defconfig
+++ b/configs/da850evm_nand_defconfig
@@ -42,10 +42,10 @@ CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0f70000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x110000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0f70000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x110000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/dalmore_defconfig b/configs/dalmore_defconfig
index 92f4436eebd..5ef9b358673 100644
--- a/configs/dalmore_defconfig
+++ b/configs/dalmore_defconfig
@@ -21,10 +21,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2086
 # CONFIG_CMD_IMI is not set
diff --git a/configs/deneb_defconfig b/configs/deneb_defconfig
index 0d714bd313b..051de7b5c58 100644
--- a/configs/deneb_defconfig
+++ b/configs/deneb_defconfig
@@ -47,10 +47,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x120000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x3000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x120000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x3000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
 CONFIG_SPL_POWER_DOMAIN=y
diff --git a/configs/devkit8000_defconfig b/configs/devkit8000_defconfig
index caeb0094cda..1431e54dc95 100644
--- a/configs/devkit8000_defconfig
+++ b/configs/devkit8000_defconfig
@@ -19,9 +19,9 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_BSS_START_ADDR=0x80000500
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80208000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/dh_imx6_defconfig b/configs/dh_imx6_defconfig
index c1094b4eda9..e01776c7796 100644
--- a/configs/dh_imx6_defconfig
+++ b/configs/dh_imx6_defconfig
@@ -39,7 +39,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/display5_defconfig b/configs/display5_defconfig
index 551e2a97a33..9c4334af15c 100644
--- a/configs/display5_defconfig
+++ b/configs/display5_defconfig
@@ -39,7 +39,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="if run check_em_pad; then run recovery;else if test ${BOOT_FROM} = FACTORY; then run factory_nfs;else run boot_mmc;fi;fi"
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/display5_factory_defconfig b/configs/display5_factory_defconfig
index a5396f7e54c..67ba7658861 100644
--- a/configs/display5_factory_defconfig
+++ b/configs/display5_factory_defconfig
@@ -36,7 +36,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="echo SDP Display5 recovery"
 CONFIG_MISC_INIT_R=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_DMA=y
 CONFIG_SPL_I2C=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index 14dff632215..b61c311d803 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -30,8 +30,8 @@ CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_MISC_INIT_R is not set
 CONFIG_SPL_MAX_SIZE=0x7bc00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_DMA=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index 0d6d9efd4e2..d5da5923bba 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -33,8 +33,8 @@ CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_MISC_INIT_R is not set
 CONFIG_SPL_MAX_SIZE=0x7a8b0
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_DMA=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 506a65aac3d..4acb392f0de 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -34,8 +34,8 @@ CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_MISC_INIT_R is not set
 CONFIG_SPL_MAX_SIZE=0x74eb0
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_DMA=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/draco_defconfig b/configs/draco_defconfig
index b71b23faac7..4966ffd2a04 100644
--- a/configs/draco_defconfig
+++ b/configs/draco_defconfig
@@ -38,9 +38,9 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x80000000
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80208000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index 38f26f2dcc5..baaa28aac3d 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -26,10 +26,10 @@ CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; po
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2084
 CONFIG_CMD_BOOTMENU=y
diff --git a/configs/etamin_defconfig b/configs/etamin_defconfig
index 43cfed9fb34..f3a9f712508 100644
--- a/configs/etamin_defconfig
+++ b/configs/etamin_defconfig
@@ -39,9 +39,9 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x80000000
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80208000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/gardena-smart-gateway-at91sam_defconfig b/configs/gardena-smart-gateway-at91sam_defconfig
index f6a67401867..439fcc05753 100644
--- a/configs/gardena-smart-gateway-at91sam_defconfig
+++ b/configs/gardena-smart-gateway-at91sam_defconfig
@@ -43,8 +43,8 @@ CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_RAW_ONLY=y
diff --git a/configs/ge_b1x5v2_defconfig b/configs/ge_b1x5v2_defconfig
index b3b69a642a4..8f58454175f 100644
--- a/configs/ge_b1x5v2_defconfig
+++ b/configs/ge_b1x5v2_defconfig
@@ -39,7 +39,7 @@ CONFIG_LOG_MAX_LEVEL=8
 CONFIG_LOG_DEFAULT_LEVEL=4
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_MISC_INIT_R=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
 CONFIG_HUSH_PARSER=y
diff --git a/configs/giedi_defconfig b/configs/giedi_defconfig
index 75d5d89823f..8b2f7c23e59 100644
--- a/configs/giedi_defconfig
+++ b/configs/giedi_defconfig
@@ -47,10 +47,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x120000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x3000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x120000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x3000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
 CONFIG_SPL_POWER_DOMAIN=y
diff --git a/configs/grouper_common_defconfig b/configs/grouper_common_defconfig
index 8dc88851f5a..e445e64931d 100644
--- a/configs/grouper_common_defconfig
+++ b/configs/grouper_common_defconfig
@@ -26,10 +26,10 @@ CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; po
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2084
 CONFIG_CMD_BOOTMENU=y
diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_defconfig
index 3c558ba7f92..eb29268c6fa 100644
--- a/configs/gwventana_emmc_defconfig
+++ b/configs/gwventana_emmc_defconfig
@@ -44,7 +44,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_PCI_INIT_R=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_I2C=y
diff --git a/configs/gwventana_nand_defconfig b/configs/gwventana_nand_defconfig
index a41a8924871..17a86d6447d 100644
--- a/configs/gwventana_nand_defconfig
+++ b/configs/gwventana_nand_defconfig
@@ -44,7 +44,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_PCI_INIT_R=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_I2C=y
diff --git a/configs/harmony_defconfig b/configs/harmony_defconfig
index 8b49505a650..a1dfc0a738f 100644
--- a/configs/harmony_defconfig
+++ b/configs/harmony_defconfig
@@ -19,10 +19,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x90000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2085
 # CONFIG_CMD_IMI is not set
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index a0078e15ef4..e0cc3995966 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -20,8 +20,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/imx6dl_icore_nand_defconfig b/configs/imx6dl_icore_nand_defconfig
index f4adda5b6d4..856123dc34a 100644
--- a/configs/imx6dl_icore_nand_defconfig
+++ b/configs/imx6dl_icore_nand_defconfig
@@ -25,7 +25,7 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/imx6dl_mamoj_defconfig b/configs/imx6dl_mamoj_defconfig
index 8c7c13ebc88..933a9d83f34 100644
--- a/configs/imx6dl_mamoj_defconfig
+++ b/configs/imx6dl_mamoj_defconfig
@@ -18,7 +18,7 @@ CONFIG_SYS_MEMTEST_END=0x88000000
 CONFIG_LTO=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_OS_BOOT=y
 CONFIG_SYS_SPL_ARGS_ADDR=0x13000000
 CONFIG_SPL_FALCON_BOOT_MMCSD=y
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index c44d43aacaf..05bab034e0f 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -35,7 +35,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run mmc_mmc_fit"
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xaa
 # CONFIG_SPL_CRYPTO is not set
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/imx6q_icore_nand_defconfig b/configs/imx6q_icore_nand_defconfig
index 3b579bac460..8e53700e836 100644
--- a/configs/imx6q_icore_nand_defconfig
+++ b/configs/imx6q_icore_nand_defconfig
@@ -26,7 +26,7 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/imx6q_logic_defconfig b/configs/imx6q_logic_defconfig
index 74733c4de32..b307fea5f25 100644
--- a/configs/imx6q_logic_defconfig
+++ b/configs/imx6q_logic_defconfig
@@ -29,7 +29,7 @@ CONFIG_BOOTCOMMAND="run autoboot"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_DMA=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
diff --git a/configs/imx6qdl_icore_mipi_defconfig b/configs/imx6qdl_icore_mipi_defconfig
index 4fdd891cc3e..ecb8fb2ba57 100644
--- a/configs/imx6qdl_icore_mipi_defconfig
+++ b/configs/imx6qdl_icore_mipi_defconfig
@@ -34,7 +34,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_OS_BOOT=y
 CONFIG_SYS_SPL_ARGS_ADDR=0x18000000
 CONFIG_SPL_FALCON_BOOT_MMCSD=y
diff --git a/configs/imx6qdl_icore_mmc_defconfig b/configs/imx6qdl_icore_mmc_defconfig
index 319e808e469..42889188cc3 100644
--- a/configs/imx6qdl_icore_mmc_defconfig
+++ b/configs/imx6qdl_icore_mmc_defconfig
@@ -37,7 +37,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_OS_BOOT=y
 CONFIG_SYS_SPL_ARGS_ADDR=0x18000000
 CONFIG_SPL_FALCON_BOOT_MMCSD=y
diff --git a/configs/imx6qdl_icore_nand_defconfig b/configs/imx6qdl_icore_nand_defconfig
index 3b579bac460..8e53700e836 100644
--- a/configs/imx6qdl_icore_nand_defconfig
+++ b/configs/imx6qdl_icore_nand_defconfig
@@ -26,7 +26,7 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/imx6qdl_icore_rqs_defconfig b/configs/imx6qdl_icore_rqs_defconfig
index 697e4c28803..2ab42979fa6 100644
--- a/configs/imx6qdl_icore_rqs_defconfig
+++ b/configs/imx6qdl_icore_rqs_defconfig
@@ -31,7 +31,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_OS_BOOT=y
 CONFIG_SYS_SPL_ARGS_ADDR=0x18000000
 CONFIG_SPL_FALCON_BOOT_MMCSD=y
diff --git a/configs/imx6ul_geam_mmc_defconfig b/configs/imx6ul_geam_mmc_defconfig
index 87d693cff54..857569f99ee 100644
--- a/configs/imx6ul_geam_mmc_defconfig
+++ b/configs/imx6ul_geam_mmc_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/imx6ul_geam_nand_defconfig b/configs/imx6ul_geam_nand_defconfig
index 0b989e64847..3bf99aedc08 100644
--- a/configs/imx6ul_geam_nand_defconfig
+++ b/configs/imx6ul_geam_nand_defconfig
@@ -26,7 +26,7 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/imx6ul_isiot_emmc_defconfig b/configs/imx6ul_isiot_emmc_defconfig
index e7242cad981..73caf9a552c 100644
--- a/configs/imx6ul_isiot_emmc_defconfig
+++ b/configs/imx6ul_isiot_emmc_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/imx6ul_isiot_nand_defconfig b/configs/imx6ul_isiot_nand_defconfig
index 8318197fdef..68a716ce8e4 100644
--- a/configs/imx6ul_isiot_nand_defconfig
+++ b/configs/imx6ul_isiot_nand_defconfig
@@ -26,7 +26,7 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run $modeboot"
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index f3da19deb07..d6edc719004 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -23,7 +23,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x84100000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_NAND_SUPPORT=y
diff --git a/configs/imx7_cm_defconfig b/configs/imx7_cm_defconfig
index c43aed4a94c..30bf4eb3b0c 100644
--- a/configs/imx7_cm_defconfig
+++ b/configs/imx7_cm_defconfig
@@ -28,7 +28,7 @@ CONFIG_DEFAULT_FDT_FILE="ask"
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_I2C=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-cl-iot-gate-optee_defconfig
index 11fdc7ffe81..f94be32cf0a 100644
--- a/configs/imx8mm-cl-iot-gate-optee_defconfig
+++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
@@ -31,10 +31,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index bdabb80edbb..92c9b90c2a4 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -33,10 +33,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
index 6d283ec562c..523224820de 100644
--- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
@@ -30,10 +30,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_POWER=y
diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
index 38c0c87b22f..19160437f14 100644
--- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
@@ -30,10 +30,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_POWER=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index 13bd1951512..6dff20e739d 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -43,10 +43,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 52edb2ed19d..de4ea8496f7 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -33,10 +33,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
index e1b75d6416f..a3cdd069db7 100644
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ b/configs/imx8mm_beacon_fspi_defconfig
@@ -36,10 +36,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index e2bca406113..b201d833e5d 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -54,10 +54,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index ac9810fe1b7..361e8144140 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -31,10 +31,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 75f0a950289..2308022053d 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -34,10 +34,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index 9fdce5c8b52..23e2c116312 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -31,10 +31,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index a485910a529..c584294c07d 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -38,9 +38,9 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index 975fcc2481a..3508bd88146 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -43,10 +43,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index f4ecdc88f39..c3263f96d0f 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -42,10 +42,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
index f5e57fb50bc..26db542d3be 100644
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ b/configs/imx8mn_beacon_fspi_defconfig
@@ -42,10 +42,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index f356b9cc466..735cc5d1044 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -36,10 +36,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_DMA=y
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index 57d11310284..96f752b7fea 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -37,10 +37,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 4faeb473fa7..9f1670bf6bc 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -35,10 +35,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 230ce6be374..535129bb679 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index b346b14ebdd..9ae0902c69a 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -40,10 +40,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 39f930ae2ca..ff016373f75 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -41,10 +41,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index 494be362172..1642ad1eb31 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index c6a3e35e73a..5c9de2e0026 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -52,10 +52,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index d3b629caf5c..fa8c2ff6e2a 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -60,10 +60,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x4c000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x4c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index 24c87aae781..e30bb437cb0 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -58,10 +58,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x4c000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x4c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 3e89e0f8293..c955ef64091 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -59,10 +59,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x4c000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x4c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 73e30db4eed..9596b11d90c 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb3720a1_4G_defconfig
index 02ce80c7832..e6a1cc09eca 100644
--- a/configs/imx8mp_rsb3720a1_4G_defconfig
+++ b/configs/imx8mp_rsb3720a1_4G_defconfig
@@ -47,10 +47,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb3720a1_6G_defconfig
index d0bf25a6f5f..8838936e124 100644
--- a/configs/imx8mp_rsb3720a1_6G_defconfig
+++ b/configs/imx8mp_rsb3720a1_6G_defconfig
@@ -47,10 +47,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 294206ba8b2..82485529ae0 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -41,10 +41,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mq_cm_defconfig b/configs/imx8mq_cm_defconfig
index 89a7485bd1d..fd08e35f079 100644
--- a/configs/imx8mq_cm_defconfig
+++ b/configs/imx8mq_cm_defconfig
@@ -35,10 +35,10 @@ CONFIG_SPL_BSS_START_ADDR=0x180000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 7b135bf9fad..674d15c5bf6 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_BSS_START_ADDR=0x180000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index 114ddab10b4..875cf54925b 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_BSS_START_ADDR=0x180000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index a17a180d433..da0d424f2ad 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -41,10 +41,10 @@ CONFIG_SPL_BSS_START_ADDR=0x180000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
index 7f7a20e5a2f..0336b96b000 100644
--- a/configs/imx8qm_mek_defconfig
+++ b/configs/imx8qm_mek_defconfig
@@ -40,10 +40,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x120000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x3000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x120000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x3000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
 CONFIG_SPL_POWER_DOMAIN=y
diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconfig
index f34b988c2e1..2c83e97bbf4 100644
--- a/configs/imx8qxp_mek_defconfig
+++ b/configs/imx8qxp_mek_defconfig
@@ -40,10 +40,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x120000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x3000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x120000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x3000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
 CONFIG_SPL_POWER_DOMAIN=y
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index c08db70b96f..40a4dca250c 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -37,10 +37,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x22040000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x8000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x22040000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x8000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 65f473885c6..2de5ee4e9b4 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -35,10 +35,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x83200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x83200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
 CONFIG_SPL_I2C=y
diff --git a/configs/imx93_11x11_evk_ld_defconfig b/configs/imx93_11x11_evk_ld_defconfig
index 27165da8b97..08975151620 100644
--- a/configs/imx93_11x11_evk_ld_defconfig
+++ b/configs/imx93_11x11_evk_ld_defconfig
@@ -36,10 +36,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x83200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x83200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
 CONFIG_SPL_I2C=y
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index bcbaa92ee89..bdd85d43824 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -50,8 +50,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DM_MAILBOX=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index ba5914d3b60..e392553a7ee 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -42,8 +42,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1800
 CONFIG_SPL_DMA=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index c4dd33627bd..42ff450aa08 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -37,10 +37,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 214fa8b2f35..3f36d655a9e 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -42,8 +42,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DMA=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index cf7bc872b5f..803b38bd39b 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -42,10 +42,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 09addcbb25d..df7f6b0f07a 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -41,8 +41,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DMA=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 1e66ac23d05..6fd90defd59 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -43,10 +43,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/jetson-tk1_defconfig b/configs/jetson-tk1_defconfig
index d8086281582..01f84c4ef2b 100644
--- a/configs/jetson-tk1_defconfig
+++ b/configs/jetson-tk1_defconfig
@@ -24,10 +24,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2089
 # CONFIG_CMD_IMI is not set
diff --git a/configs/k2e_evm_defconfig b/configs/k2e_evm_defconfig
index 44bed00ec97..7eea78d000d 100644
--- a/configs/k2e_evm_defconfig
+++ b/configs/k2e_evm_defconfig
@@ -36,8 +36,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xc10fff8
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x8000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x8000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/k2g_evm_defconfig b/configs/k2g_evm_defconfig
index 45c7fade320..98b9dcb6999 100644
--- a/configs/k2g_evm_defconfig
+++ b/configs/k2g_evm_defconfig
@@ -35,8 +35,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xc0afff8
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x8000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x8000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/k2hk_evm_defconfig b/configs/k2hk_evm_defconfig
index a2651780484..21aa3943132 100644
--- a/configs/k2hk_evm_defconfig
+++ b/configs/k2hk_evm_defconfig
@@ -36,8 +36,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xc20fff8
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x8000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x8000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/k2l_evm_defconfig b/configs/k2l_evm_defconfig
index 55ddd3cce96..4c9e79c1a8d 100644
--- a/configs/k2l_evm_defconfig
+++ b/configs/k2l_evm_defconfig
@@ -36,8 +36,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xc10fff8
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x8000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x8000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index d54e60395d2..3e38b4978a4 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -33,7 +33,7 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 9558cf1a2d1..3d7d3c2fa59 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index 295cc51c4fd..01c54e7d233 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -37,10 +37,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x180000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index 21a397933e7..c5c95d11c36 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -47,7 +47,7 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x900
 CONFIG_SPL_MPC8XXX_INIT_DDR=y
diff --git a/configs/kp_imx6q_tpc_defconfig b/configs/kp_imx6q_tpc_defconfig
index dbfb0bafec1..3a7763c4435 100644
--- a/configs/kp_imx6q_tpc_defconfig
+++ b/configs/kp_imx6q_tpc_defconfig
@@ -28,7 +28,7 @@ CONFIG_AUTOBOOT_STOP_STR="."
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index 973b2ea20c4..21b84e4be80 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -42,10 +42,10 @@ CONFIG_SPL_BSS_START_ADDR=0x180000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/liteboard_defconfig b/configs/liteboard_defconfig
index 83be20fb907..1ff5b3c0cbe 100644
--- a/configs/liteboard_defconfig
+++ b/configs/liteboard_defconfig
@@ -25,7 +25,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev};if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_DEFAULT_FDT_FILE="imx6ul-liteboard.dtb"
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index b271792570e..22b861584a3 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -44,9 +44,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x82080000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x82080000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1021aqds_nand_defconfig b/configs/ls1021aqds_nand_defconfig
index ee569eaac6c..b9636d3140a 100644
--- a/configs/ls1021aqds_nand_defconfig
+++ b/configs/ls1021aqds_nand_defconfig
@@ -54,9 +54,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80200000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80200000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1021aqds_sdcard_ifc_defconfig b/configs/ls1021aqds_sdcard_ifc_defconfig
index 25bd6c72a55..c5d01354af1 100644
--- a/configs/ls1021aqds_sdcard_ifc_defconfig
+++ b/configs/ls1021aqds_sdcard_ifc_defconfig
@@ -53,9 +53,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x820c0000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x820c0000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1021aqds_sdcard_qspi_defconfig b/configs/ls1021aqds_sdcard_qspi_defconfig
index 2845386007f..8e4b2183612 100644
--- a/configs/ls1021aqds_sdcard_qspi_defconfig
+++ b/configs/ls1021aqds_sdcard_qspi_defconfig
@@ -52,9 +52,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x820c0000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x820c0000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1021atsn_sdcard_defconfig b/configs/ls1021atsn_sdcard_defconfig
index 7a8b157926b..d10482705ab 100644
--- a/configs/ls1021atsn_sdcard_defconfig
+++ b/configs/ls1021atsn_sdcard_defconfig
@@ -46,9 +46,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x82100000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x82100000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
index 4a42427b001..0b895747ce4 100644
--- a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
@@ -54,9 +54,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x82104000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x82104000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1021atwr_sdcard_ifc_defconfig b/configs/ls1021atwr_sdcard_ifc_defconfig
index 34b229e6f23..52712bb390e 100644
--- a/configs/ls1021atwr_sdcard_ifc_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_defconfig
@@ -55,9 +55,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x82100000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x82100000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1021atwr_sdcard_qspi_defconfig b/configs/ls1021atwr_sdcard_qspi_defconfig
index 3738107321f..51c4c7ac6f8 100644
--- a/configs/ls1021atwr_sdcard_qspi_defconfig
+++ b/configs/ls1021atwr_sdcard_qspi_defconfig
@@ -56,9 +56,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x82100000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x82100000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1043aqds_nand_defconfig b/configs/ls1043aqds_nand_defconfig
index e5f570a3b3c..e62261d4809 100644
--- a/configs/ls1043aqds_nand_defconfig
+++ b/configs/ls1043aqds_nand_defconfig
@@ -61,9 +61,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80200000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80200000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xf0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1043aqds_sdcard_ifc_defconfig b/configs/ls1043aqds_sdcard_ifc_defconfig
index 6cb961d33dc..12ad4ce08ca 100644
--- a/configs/ls1043aqds_sdcard_ifc_defconfig
+++ b/configs/ls1043aqds_sdcard_ifc_defconfig
@@ -62,7 +62,7 @@ CONFIG_SPL_BSS_START_ADDR=0x8f000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xf0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1043aqds_sdcard_qspi_defconfig b/configs/ls1043aqds_sdcard_qspi_defconfig
index 4e41508251d..813a147f810 100644
--- a/configs/ls1043aqds_sdcard_qspi_defconfig
+++ b/configs/ls1043aqds_sdcard_qspi_defconfig
@@ -62,7 +62,7 @@ CONFIG_SPL_BSS_START_ADDR=0x8f000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xf0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1043ardb_nand_SECURE_BOOT_defconfig b/configs/ls1043ardb_nand_SECURE_BOOT_defconfig
index d9ff0fd16a5..316716e5421 100644
--- a/configs/ls1043ardb_nand_SECURE_BOOT_defconfig
+++ b/configs/ls1043ardb_nand_SECURE_BOOT_defconfig
@@ -46,9 +46,9 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80200000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80200000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xf0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1043ardb_nand_defconfig b/configs/ls1043ardb_nand_defconfig
index ad118187432..9754c56e1d8 100644
--- a/configs/ls1043ardb_nand_defconfig
+++ b/configs/ls1043ardb_nand_defconfig
@@ -52,9 +52,9 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80200000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80200000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xf0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig b/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
index fe0dd04f1f9..bb4d03dcea6 100644
--- a/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
+++ b/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
@@ -47,7 +47,7 @@ CONFIG_SPL_BSS_START_ADDR=0x8f000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x110
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1043ardb_sdcard_defconfig b/configs/ls1043ardb_sdcard_defconfig
index aa5404cbb50..c9db9e30d22 100644
--- a/configs/ls1043ardb_sdcard_defconfig
+++ b/configs/ls1043ardb_sdcard_defconfig
@@ -53,7 +53,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xf0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1046aqds_nand_defconfig b/configs/ls1046aqds_nand_defconfig
index 95616f97054..78b94adb24e 100644
--- a/configs/ls1046aqds_nand_defconfig
+++ b/configs/ls1046aqds_nand_defconfig
@@ -62,7 +62,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x110
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1046aqds_sdcard_ifc_defconfig b/configs/ls1046aqds_sdcard_ifc_defconfig
index 179fa70f4ee..75255492e82 100644
--- a/configs/ls1046aqds_sdcard_ifc_defconfig
+++ b/configs/ls1046aqds_sdcard_ifc_defconfig
@@ -63,7 +63,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x110
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1046aqds_sdcard_qspi_defconfig b/configs/ls1046aqds_sdcard_qspi_defconfig
index b571eaadf62..6e353a1db1e 100644
--- a/configs/ls1046aqds_sdcard_qspi_defconfig
+++ b/configs/ls1046aqds_sdcard_qspi_defconfig
@@ -63,7 +63,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x110
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1046ardb_emmc_defconfig b/configs/ls1046ardb_emmc_defconfig
index 924ff78b459..c265040df6d 100644
--- a/configs/ls1046ardb_emmc_defconfig
+++ b/configs/ls1046ardb_emmc_defconfig
@@ -53,7 +53,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x110
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1046ardb_qspi_spl_defconfig b/configs/ls1046ardb_qspi_spl_defconfig
index eb0184c5927..e11a90f09b2 100644
--- a/configs/ls1046ardb_qspi_spl_defconfig
+++ b/configs/ls1046ardb_qspi_spl_defconfig
@@ -55,7 +55,7 @@ CONFIG_SPL_BSS_START_ADDR=0x8f000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MPC8XXX_INIT_DDR=y
diff --git a/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig b/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
index 2813c79f597..589117434e6 100644
--- a/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
+++ b/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
@@ -50,7 +50,7 @@ CONFIG_SPL_BSS_START_ADDR=0x8f000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x110
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1046ardb_sdcard_defconfig b/configs/ls1046ardb_sdcard_defconfig
index a621859aa79..8e1061fbc5d 100644
--- a/configs/ls1046ardb_sdcard_defconfig
+++ b/configs/ls1046ardb_sdcard_defconfig
@@ -53,7 +53,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_FSL_PBL=y
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x110
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1088aqds_sdcard_ifc_defconfig b/configs/ls1088aqds_sdcard_ifc_defconfig
index 1f52769ac21..735449a718a 100644
--- a/configs/ls1088aqds_sdcard_ifc_defconfig
+++ b/configs/ls1088aqds_sdcard_ifc_defconfig
@@ -50,7 +50,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x8b0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1088aqds_sdcard_qspi_defconfig b/configs/ls1088aqds_sdcard_qspi_defconfig
index 93d07829b4b..52d7f94ea5d 100644
--- a/configs/ls1088aqds_sdcard_qspi_defconfig
+++ b/configs/ls1088aqds_sdcard_qspi_defconfig
@@ -51,7 +51,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x8b0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig b/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
index c0812a983d5..8c6a8105d9a 100644
--- a/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
+++ b/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
@@ -51,7 +51,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x8b0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls1088ardb_sdcard_qspi_defconfig b/configs/ls1088ardb_sdcard_qspi_defconfig
index b98825cdb92..699678f3526 100644
--- a/configs/ls1088ardb_sdcard_qspi_defconfig
+++ b/configs/ls1088ardb_sdcard_qspi_defconfig
@@ -52,7 +52,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x8b0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index 1afaac2686d..6920eefb4ae 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -42,7 +42,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MPC8XXX_INIT_DDR=y
diff --git a/configs/ls2080aqds_sdcard_defconfig b/configs/ls2080aqds_sdcard_defconfig
index b45819f87b3..4965b4a4951 100644
--- a/configs/ls2080aqds_sdcard_defconfig
+++ b/configs/ls2080aqds_sdcard_defconfig
@@ -42,7 +42,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x8b0
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_defconfig
index a406bae1ec7..acc8c031d7b 100644
--- a/configs/ls2080ardb_nand_defconfig
+++ b/configs/ls2080ardb_nand_defconfig
@@ -48,7 +48,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MPC8XXX_INIT_DDR=y
diff --git a/configs/mccmon6_nor_defconfig b/configs/mccmon6_nor_defconfig
index 6afddd2356e..88a72b39299 100644
--- a/configs/mccmon6_nor_defconfig
+++ b/configs/mccmon6_nor_defconfig
@@ -24,7 +24,7 @@ CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_NOR_SUPPORT=y
diff --git a/configs/mccmon6_sd_defconfig b/configs/mccmon6_sd_defconfig
index c95ee252428..83f2b1a42db 100644
--- a/configs/mccmon6_sd_defconfig
+++ b/configs/mccmon6_sd_defconfig
@@ -26,7 +26,7 @@ CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/medcom-wide_defconfig b/configs/medcom-wide_defconfig
index e99bb8f5b52..3492c9d2d54 100644
--- a/configs/medcom-wide_defconfig
+++ b/configs/medcom-wide_defconfig
@@ -19,10 +19,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x90000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2089
 # CONFIG_CMD_IMI is not set
diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index 323a7040261..ad12a69e324 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -35,10 +35,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
index b23c78984d1..a1ab269b37d 100644
--- a/configs/mx6cuboxi_defconfig
+++ b/configs/mx6cuboxi_defconfig
@@ -28,7 +28,7 @@ CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="if hdmidet; then usb start; setenv stdin  serial,usbkbd; setenv stdout serial,vidconsole; setenv stderr serial,vidconsole; else setenv stdin  serial; setenv stdout serial; setenv stderr serial; fi;"
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
 CONFIG_SPL_I2C=y
diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
index a488ce41fb8..6dd64b6da1b 100644
--- a/configs/mx6memcal_defconfig
+++ b/configs/mx6memcal_defconfig
@@ -15,7 +15,7 @@ CONFIG_SPL=y
 CONFIG_SYS_MEMTEST_START=0x10000000
 CONFIG_SYS_MEMTEST_END=0x20000000
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/mx6sabreauto_defconfig b/configs/mx6sabreauto_defconfig
index ee518cab6dc..deb0b655356 100644
--- a/configs/mx6sabreauto_defconfig
+++ b/configs/mx6sabreauto_defconfig
@@ -31,7 +31,7 @@ CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};if mmc rescan; then if run loa
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index 0a8b0477b48..edc92f804da 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -31,7 +31,7 @@ CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};if mmc rescan; then if run loa
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
diff --git a/configs/mx6slevk_spl_defconfig b/configs/mx6slevk_spl_defconfig
index fee3c6fc950..8db45764d5d 100644
--- a/configs/mx6slevk_spl_defconfig
+++ b/configs/mx6slevk_spl_defconfig
@@ -27,7 +27,7 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
 CONFIG_SPL_I2C=y
diff --git a/configs/mx6ul_14x14_evk_defconfig b/configs/mx6ul_14x14_evk_defconfig
index 0e036606c1b..f727423a38b 100644
--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -29,7 +29,7 @@ CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};mmc dev ${mmcdev}; if mmc resc
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
 CONFIG_SPL_I2C=y
diff --git a/configs/mx6ul_9x9_evk_defconfig b/configs/mx6ul_9x9_evk_defconfig
index 740968d98e4..1e4ec0b017a 100644
--- a/configs/mx6ul_9x9_evk_defconfig
+++ b/configs/mx6ul_9x9_evk_defconfig
@@ -29,7 +29,7 @@ CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};mmc dev ${mmcdev}; if mmc resc
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
 CONFIG_SPL_I2C=y
diff --git a/configs/myir_mys_6ulx_defconfig b/configs/myir_mys_6ulx_defconfig
index 8e3938dcaa8..456d1b86541 100644
--- a/configs/myir_mys_6ulx_defconfig
+++ b/configs/myir_mys_6ulx_defconfig
@@ -20,7 +20,7 @@ CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index 3cb0cb8712e..278e3fd8adb 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -32,7 +32,7 @@ CONFIG_BOOTARGS="console=ttymxc1,115200 "
 CONFIG_BOOTCOMMAND="run distro_bootcmd ; run net_nfs"
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_MISC_INIT_R=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
 CONFIG_SPL_I2C=y
diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index cc64facd5f2..bc1b2e35b10 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -30,10 +30,10 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0xef8100
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2087
 # CONFIG_CMD_IMI is not set
diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defconfig
index b8c48e6bf50..3534753dd3e 100644
--- a/configs/omap35_logic_defconfig
+++ b/configs/omap35_logic_defconfig
@@ -26,8 +26,8 @@ CONFIG_DEFAULT_FDT_FILE="logicpd-torpedo-35xx-devkit.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
index d9b7e0de5d5..835252acc9b 100644
--- a/configs/omap35_logic_somlv_defconfig
+++ b/configs/omap35_logic_somlv_defconfig
@@ -27,8 +27,8 @@ CONFIG_DEFAULT_FDT_FILE="logicpd-som-lv-35xx-devkit.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
diff --git a/configs/omap3_beagle_defconfig b/configs/omap3_beagle_defconfig
index a1d43018aa1..1b9adcff893 100644
--- a/configs/omap3_beagle_defconfig
+++ b/configs/omap3_beagle_defconfig
@@ -20,8 +20,8 @@ CONFIG_DEFAULT_FDT_FILE="omap3-beagle.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index 34f7d8c8c41..fa2b84a500b 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -20,8 +20,8 @@ CONFIG_DEFAULT_FDT_FILE="omap3-evm.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfig
index 90c1b6cabff..e747a0c1e93 100644
--- a/configs/omap3_logic_defconfig
+++ b/configs/omap3_logic_defconfig
@@ -25,8 +25,8 @@ CONFIG_PREBOOT="setenv preboot;saveenv;"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
index 17fda31a1e7..b9d6284faad 100644
--- a/configs/omap3_logic_somlv_defconfig
+++ b/configs/omap3_logic_somlv_defconfig
@@ -27,8 +27,8 @@ CONFIG_DEFAULT_FDT_FILE="logicpd-som-lv-37xx-devkit.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
diff --git a/configs/omap4_panda_defconfig b/configs/omap4_panda_defconfig
index 5571722ea6d..d126d2c07b0 100644
--- a/configs/omap4_panda_defconfig
+++ b/configs/omap4_panda_defconfig
@@ -15,8 +15,8 @@ CONFIG_DEFAULT_FDT_FILE="omap4-panda.dtb"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xbc00
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
 # CONFIG_SPL_NAND_SUPPORT is not set
diff --git a/configs/omap4_sdp4430_defconfig b/configs/omap4_sdp4430_defconfig
index 0a8a1c77ea4..53710351d04 100644
--- a/configs/omap4_sdp4430_defconfig
+++ b/configs/omap4_sdp4430_defconfig
@@ -19,8 +19,8 @@ CONFIG_DEFAULT_FDT_FILE="omap4-sdp.dtb"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xbc00
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SPL_I2C is not set
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SYS_MAXARGS=64
diff --git a/configs/omapl138_lcdk_defconfig b/configs/omapl138_lcdk_defconfig
index dec7a4bf317..47feff21bd4 100644
--- a/configs/omapl138_lcdk_defconfig
+++ b/configs/omapl138_lcdk_defconfig
@@ -41,10 +41,10 @@ CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0f70000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x110000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0f70000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x110000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xb5
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/openpiton_riscv64_spl_defconfig b/configs/openpiton_riscv64_spl_defconfig
index b7696d7cf30..4371c0350a5 100644
--- a/configs/openpiton_riscv64_spl_defconfig
+++ b/configs/openpiton_riscv64_spl_defconfig
@@ -30,7 +30,7 @@ CONFIG_SPL_BSS_START_ADDR=0x82000000
 # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_SPL_BANNER_PRINT is not set
 CONFIG_SPL_CPU=y
 CONFIG_SPL_FS_EXT4=y
diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
index c4d738af3fc..068928ffa98 100644
--- a/configs/opos6uldev_defconfig
+++ b/configs/opos6uldev_defconfig
@@ -34,7 +34,7 @@ CONFIG_DEFAULT_FDT_FILE="imx6ul-opos6uldev.dtb"
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SPL_YMODEM_SUPPORT=y
diff --git a/configs/paz00_defconfig b/configs/paz00_defconfig
index 8c125c39b2f..cc2ef1ed528 100644
--- a/configs/paz00_defconfig
+++ b/configs/paz00_defconfig
@@ -17,10 +17,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x90000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2087
 # CONFIG_CMD_IMI is not set
diff --git a/configs/pcm058_defconfig b/configs/pcm058_defconfig
index f8b587275f8..15ae95e8943 100644
--- a/configs/pcm058_defconfig
+++ b/configs/pcm058_defconfig
@@ -32,7 +32,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_BOOTCOMMAND="run mmcboot;run nandboot"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x18a
 CONFIG_SPL_DMA=y
 CONFIG_SPL_FS_EXT4=y
diff --git a/configs/phycore-am335x-r2-regor_defconfig b/configs/phycore-am335x-r2-regor_defconfig
index d74078c7bed..e37fd1bfab9 100644
--- a/configs/phycore-am335x-r2-regor_defconfig
+++ b/configs/phycore-am335x-r2-regor_defconfig
@@ -24,8 +24,8 @@ CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="am335x-regor-rdk.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/phycore-am335x-r2-wega_defconfig b/configs/phycore-am335x-r2-wega_defconfig
index 0f75d56c881..08b857ea9c0 100644
--- a/configs/phycore-am335x-r2-wega_defconfig
+++ b/configs/phycore-am335x-r2-wega_defconfig
@@ -24,8 +24,8 @@ CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="am335x-wega-rdk.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 4a27d15cb11..10fd667722f 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -34,10 +34,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 7bf404be860..2ba91563d39 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/phycore_pcl063_defconfig b/configs/phycore_pcl063_defconfig
index 2d06621963c..11db9681a8c 100644
--- a/configs/phycore_pcl063_defconfig
+++ b/configs/phycore_pcl063_defconfig
@@ -19,7 +19,7 @@ CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/phycore_pcl063_ull_defconfig b/configs/phycore_pcl063_ull_defconfig
index 327ea56cb8a..f0a2398ebdb 100644
--- a/configs/phycore_pcl063_ull_defconfig
+++ b/configs/phycore_pcl063_ull_defconfig
@@ -19,7 +19,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_BOOTCOMMAND="run mmc_mmc_fit"
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/pico-dwarf-imx6ul_defconfig b/configs/pico-dwarf-imx6ul_defconfig
index 4fd588051cd..e9a5302cb7d 100644
--- a/configs/pico-dwarf-imx6ul_defconfig
+++ b/configs/pico-dwarf-imx6ul_defconfig
@@ -26,7 +26,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx6ul-pico-dwarf.dtb"
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTMENU=y
diff --git a/configs/pico-dwarf-imx7d_defconfig b/configs/pico-dwarf-imx7d_defconfig
index 2cd906a63da..613ed6cc94a 100644
--- a/configs/pico-dwarf-imx7d_defconfig
+++ b/configs/pico-dwarf-imx7d_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="imx7d-pico-dwarf.dtb"
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
 # CONFIG_CMD_BOOTD is not set
diff --git a/configs/pico-hobbit-imx6ul_defconfig b/configs/pico-hobbit-imx6ul_defconfig
index c430b4d6222..b3a1023271c 100644
--- a/configs/pico-hobbit-imx6ul_defconfig
+++ b/configs/pico-hobbit-imx6ul_defconfig
@@ -27,7 +27,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx6ul-pico-hobbit.dtb"
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTMENU=y
diff --git a/configs/pico-hobbit-imx7d_defconfig b/configs/pico-hobbit-imx7d_defconfig
index b63281e5332..82d70c7f37a 100644
--- a/configs/pico-hobbit-imx7d_defconfig
+++ b/configs/pico-hobbit-imx7d_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="imx7d-pico-hobbit.dtb"
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
 # CONFIG_CMD_BOOTD is not set
diff --git a/configs/pico-imx6_defconfig b/configs/pico-imx6_defconfig
index be7b119ba78..39aa63c1aaa 100644
--- a/configs/pico-imx6_defconfig
+++ b/configs/pico-imx6_defconfig
@@ -27,7 +27,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run default_boot"
 CONFIG_DEFAULT_FDT_FILE="ask"
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
diff --git a/configs/pico-imx6ul_defconfig b/configs/pico-imx6ul_defconfig
index a6cbc513317..6f84b6aeb49 100644
--- a/configs/pico-imx6ul_defconfig
+++ b/configs/pico-imx6ul_defconfig
@@ -27,7 +27,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="ask"
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTMENU=y
diff --git a/configs/pico-imx7d_bl33_defconfig b/configs/pico-imx7d_bl33_defconfig
index 546e1e6545d..289cf6ba7c1 100644
--- a/configs/pico-imx7d_bl33_defconfig
+++ b/configs/pico-imx7d_bl33_defconfig
@@ -27,7 +27,7 @@ CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/pico-imx7d_defconfig b/configs/pico-imx7d_defconfig
index f11e1f4ef41..dbe4c5245b4 100644
--- a/configs/pico-imx7d_defconfig
+++ b/configs/pico-imx7d_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="ask"
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
 # CONFIG_CMD_BOOTD is not set
diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfig
index 4ee9b88c32b..f2c342eb8f3 100644
--- a/configs/pico-imx8mq_defconfig
+++ b/configs/pico-imx8mq_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_BSS_START_ADDR=0x180000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/pico-nymph-imx7d_defconfig b/configs/pico-nymph-imx7d_defconfig
index 2cd906a63da..613ed6cc94a 100644
--- a/configs/pico-nymph-imx7d_defconfig
+++ b/configs/pico-nymph-imx7d_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="imx7d-pico-dwarf.dtb"
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
 # CONFIG_CMD_BOOTD is not set
diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_defconfig
index 3c822d10a4f..1eee1e6c2ff 100644
--- a/configs/pico-pi-imx6ul_defconfig
+++ b/configs/pico-pi-imx6ul_defconfig
@@ -27,7 +27,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx6ul-pico-pi.dtb"
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTMENU=y
diff --git a/configs/pico-pi-imx7d_defconfig b/configs/pico-pi-imx7d_defconfig
index 3e26aae4005..c5e34219ece 100644
--- a/configs/pico-pi-imx7d_defconfig
+++ b/configs/pico-pi-imx7d_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="imx7d-pico-pi.dtb"
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
 # CONFIG_CMD_BOOTD is not set
diff --git a/configs/plutux_defconfig b/configs/plutux_defconfig
index ab9aef5e478..4a4816874bf 100644
--- a/configs/plutux_defconfig
+++ b/configs/plutux_defconfig
@@ -20,10 +20,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x90000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2084
 # CONFIG_CMD_IMI is not set
diff --git a/configs/pxm2_defconfig b/configs/pxm2_defconfig
index 88a6dbd7db0..4697959b860 100644
--- a/configs/pxm2_defconfig
+++ b/configs/pxm2_defconfig
@@ -38,9 +38,9 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x80000000
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80208000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/qemu-riscv32_spl_defconfig b/configs/qemu-riscv32_spl_defconfig
index 9a81bdd767d..e63d6fd9346 100644
--- a/configs/qemu-riscv32_spl_defconfig
+++ b/configs/qemu-riscv32_spl_defconfig
@@ -18,7 +18,7 @@ CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index bb10145e6e7..b048bb8aed0 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -17,7 +17,7 @@ CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/rastaban_defconfig b/configs/rastaban_defconfig
index 7e4580f2cc7..7c443d518ed 100644
--- a/configs/rastaban_defconfig
+++ b/configs/rastaban_defconfig
@@ -38,9 +38,9 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x80000000
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80208000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index cdec0c52e6a..b4666d0e90f 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -42,7 +42,7 @@ CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
diff --git a/configs/riotboard_defconfig b/configs/riotboard_defconfig
index 98fef09e18c..f8bc8c63969 100644
--- a/configs/riotboard_defconfig
+++ b/configs/riotboard_defconfig
@@ -30,7 +30,7 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
 CONFIG_SPL_FS_LOAD_ARGS_NAME="imx6dl-riotboard.dtb"
diff --git a/configs/rut_defconfig b/configs/rut_defconfig
index ba89b4d24cd..40c17a58882 100644
--- a/configs/rut_defconfig
+++ b/configs/rut_defconfig
@@ -38,9 +38,9 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x80000000
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80208000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/sama5d27_giantboard_defconfig b/configs/sama5d27_giantboard_defconfig
index e58b4542509..677658dca13 100644
--- a/configs/sama5d27_giantboard_defconfig
+++ b/configs/sama5d27_giantboard_defconfig
@@ -46,8 +46,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d27_som1_ek_mmc1_defconfig b/configs/sama5d27_som1_ek_mmc1_defconfig
index 65466ebb5c6..ec82311b16c 100644
--- a/configs/sama5d27_som1_ek_mmc1_defconfig
+++ b/configs/sama5d27_som1_ek_mmc1_defconfig
@@ -43,8 +43,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d27_som1_ek_mmc_defconfig b/configs/sama5d27_som1_ek_mmc_defconfig
index cb47dc6baa6..f3037445149 100644
--- a/configs/sama5d27_som1_ek_mmc_defconfig
+++ b/configs/sama5d27_som1_ek_mmc_defconfig
@@ -44,8 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d27_som1_ek_qspiflash_defconfig b/configs/sama5d27_som1_ek_qspiflash_defconfig
index 702495e1c91..eed190d2ef4 100644
--- a/configs/sama5d27_som1_ek_qspiflash_defconfig
+++ b/configs/sama5d27_som1_ek_qspiflash_defconfig
@@ -42,8 +42,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d27_wlsom1_ek_mmc_defconfig b/configs/sama5d27_wlsom1_ek_mmc_defconfig
index 79210090122..2b8461da1c2 100644
--- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
+++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
@@ -43,8 +43,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_DISPLAY_PRINT=y
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_AT91_MCK_BYPASS=y
diff --git a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
index a7c84746e3e..f47183ae5c9 100644
--- a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
+++ b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
@@ -43,8 +43,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_DISPLAY_PRINT=y
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_DM_SPI_FLASH=y
diff --git a/configs/sama5d2_icp_mmc_defconfig b/configs/sama5d2_icp_mmc_defconfig
index 9456b9e1e13..7ad94ecbdee 100644
--- a/configs/sama5d2_icp_mmc_defconfig
+++ b/configs/sama5d2_icp_mmc_defconfig
@@ -44,8 +44,8 @@ CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_DISPLAY_PRINT=y
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_RAM_SUPPORT=y
diff --git a/configs/sama5d2_xplained_emmc_defconfig b/configs/sama5d2_xplained_emmc_defconfig
index 9ef0ff4aa9a..7c373360a9b 100644
--- a/configs/sama5d2_xplained_emmc_defconfig
+++ b/configs/sama5d2_xplained_emmc_defconfig
@@ -43,8 +43,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d2_xplained_mmc_defconfig b/configs/sama5d2_xplained_mmc_defconfig
index aed9edafdf7..26b281f7085 100644
--- a/configs/sama5d2_xplained_mmc_defconfig
+++ b/configs/sama5d2_xplained_mmc_defconfig
@@ -45,8 +45,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d2_xplained_qspiflash_defconfig b/configs/sama5d2_xplained_qspiflash_defconfig
index c9a20723f5a..9ed35e3113e 100644
--- a/configs/sama5d2_xplained_qspiflash_defconfig
+++ b/configs/sama5d2_xplained_qspiflash_defconfig
@@ -46,8 +46,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d2_xplained_spiflash_defconfig b/configs/sama5d2_xplained_spiflash_defconfig
index c01a0c4cc7c..b87a63f2d23 100644
--- a/configs/sama5d2_xplained_spiflash_defconfig
+++ b/configs/sama5d2_xplained_spiflash_defconfig
@@ -47,8 +47,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x10000
diff --git a/configs/sama5d3_xplained_mmc_defconfig b/configs/sama5d3_xplained_mmc_defconfig
index 9b4affe1c49..fc0de8c3e83 100644
--- a/configs/sama5d3_xplained_mmc_defconfig
+++ b/configs/sama5d3_xplained_mmc_defconfig
@@ -42,8 +42,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d3_xplained_nandflash_defconfig b/configs/sama5d3_xplained_nandflash_defconfig
index 2fcb2b75e80..a1b6122f8eb 100644
--- a/configs/sama5d3_xplained_nandflash_defconfig
+++ b/configs/sama5d3_xplained_nandflash_defconfig
@@ -39,8 +39,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/sama5d3xek_mmc_defconfig b/configs/sama5d3xek_mmc_defconfig
index bfe19e0169f..631e85ea059 100644
--- a/configs/sama5d3xek_mmc_defconfig
+++ b/configs/sama5d3xek_mmc_defconfig
@@ -44,8 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d3xek_nandflash_defconfig b/configs/sama5d3xek_nandflash_defconfig
index 2978a7e2d7d..6278a6c68a7 100644
--- a/configs/sama5d3xek_nandflash_defconfig
+++ b/configs/sama5d3xek_nandflash_defconfig
@@ -41,8 +41,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/sama5d3xek_spiflash_defconfig b/configs/sama5d3xek_spiflash_defconfig
index 1d30843e08b..5f47f8b6ba9 100644
--- a/configs/sama5d3xek_spiflash_defconfig
+++ b/configs/sama5d3xek_spiflash_defconfig
@@ -44,8 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x10000
diff --git a/configs/sama5d4_xplained_mmc_defconfig b/configs/sama5d4_xplained_mmc_defconfig
index befe26b18e9..9f0349e7f58 100644
--- a/configs/sama5d4_xplained_mmc_defconfig
+++ b/configs/sama5d4_xplained_mmc_defconfig
@@ -44,8 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d4_xplained_nandflash_defconfig b/configs/sama5d4_xplained_nandflash_defconfig
index 749c8ba30e6..d12f749d7f4 100644
--- a/configs/sama5d4_xplained_nandflash_defconfig
+++ b/configs/sama5d4_xplained_nandflash_defconfig
@@ -41,8 +41,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/sama5d4_xplained_spiflash_defconfig b/configs/sama5d4_xplained_spiflash_defconfig
index 02a0de3ed27..0d239ef0008 100644
--- a/configs/sama5d4_xplained_spiflash_defconfig
+++ b/configs/sama5d4_xplained_spiflash_defconfig
@@ -46,8 +46,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x10000
diff --git a/configs/sama5d4ek_mmc_defconfig b/configs/sama5d4ek_mmc_defconfig
index 48607e1ca43..4139fcfadb2 100644
--- a/configs/sama5d4ek_mmc_defconfig
+++ b/configs/sama5d4ek_mmc_defconfig
@@ -44,8 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/sama5d4ek_nandflash_defconfig b/configs/sama5d4ek_nandflash_defconfig
index 60c936b0479..27bfcdf0084 100644
--- a/configs/sama5d4ek_nandflash_defconfig
+++ b/configs/sama5d4ek_nandflash_defconfig
@@ -41,8 +41,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/sama5d4ek_spiflash_defconfig b/configs/sama5d4ek_spiflash_defconfig
index aee8169fdc0..f41c4e9eddb 100644
--- a/configs/sama5d4ek_spiflash_defconfig
+++ b/configs/sama5d4ek_spiflash_defconfig
@@ -44,8 +44,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x10000
diff --git a/configs/seaboard_defconfig b/configs/seaboard_defconfig
index f8759f25546..2d9b7955273 100644
--- a/configs/seaboard_defconfig
+++ b/configs/seaboard_defconfig
@@ -18,10 +18,10 @@ CONFIG_USE_PREBOOT=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x90000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2086
 # CONFIG_CMD_IMI is not set
diff --git a/configs/seeed_npi_imx6ull_defconfig b/configs/seeed_npi_imx6ull_defconfig
index 9dec10ef392..d4f2a88ee46 100644
--- a/configs/seeed_npi_imx6ull_defconfig
+++ b/configs/seeed_npi_imx6ull_defconfig
@@ -21,7 +21,7 @@ CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_WATCHDOG=y
diff --git a/configs/sifive_unleashed_defconfig b/configs/sifive_unleashed_defconfig
index f9f03463ee7..f99ce30b910 100644
--- a/configs/sifive_unleashed_defconfig
+++ b/configs/sifive_unleashed_defconfig
@@ -29,7 +29,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_BSS_START_ADDR=0x85000000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 867611b6b4e..826cf977c34 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -35,7 +35,7 @@ CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_BSS_START_ADDR=0x85000000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/smartweb_defconfig b/configs/smartweb_defconfig
index 836e0c002de..21c9c39be49 100644
--- a/configs/smartweb_defconfig
+++ b/configs/smartweb_defconfig
@@ -41,8 +41,8 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
 CONFIG_SPL_BSS_MAX_SIZE=0x4000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x460000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x460000
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_RAW_ONLY=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
index c762d75aec1..703805916f9 100644
--- a/configs/sniper_defconfig
+++ b/configs/sniper_defconfig
@@ -18,9 +18,9 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_BSS_START_ADDR=0x80000000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80208000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=2
diff --git a/configs/socfpga_agilex_atf_defconfig b/configs/socfpga_agilex_atf_defconfig
index ba0dbb8496b..453010076ca 100644
--- a/configs/socfpga_agilex_atf_defconfig
+++ b/configs/socfpga_agilex_atf_defconfig
@@ -35,10 +35,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x3fa00000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index 406fe712fe4..bddfd4b20ce 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -33,10 +33,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x3fa00000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x3c00000
diff --git a/configs/socfpga_agilex_vab_defconfig b/configs/socfpga_agilex_vab_defconfig
index 7c83ec971ac..e5f32c055c0 100644
--- a/configs/socfpga_agilex_vab_defconfig
+++ b/configs/socfpga_agilex_vab_defconfig
@@ -36,10 +36,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x3fa00000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index 82b16418a6f..30d28e19588 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -30,10 +30,10 @@ CONFIG_CLOCKS=y
 CONFIG_SPL_PAD_TO=0x40000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xffe2b000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x15000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xffe2b000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x15000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FPGA=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/socfpga_chameleonv3_defconfig b/configs/socfpga_chameleonv3_defconfig
index 441942c2f2b..457ad4b2977 100644
--- a/configs/socfpga_chameleonv3_defconfig
+++ b/configs/socfpga_chameleonv3_defconfig
@@ -14,10 +14,10 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_NO_BSS_LIMIT=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xffe2b000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x15000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xffe2b000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x15000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FPGA=y
diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
index 78595c5d9ec..bd4a8b84af7 100644
--- a/configs/socfpga_n5x_atf_defconfig
+++ b/configs/socfpga_n5x_atf_defconfig
@@ -34,10 +34,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x3fa00000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 99a12df91ac..745f4ed59d7 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -30,10 +30,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x3fa00000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x3c00000
diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
index e8c62d0575f..86429bf6ec2 100644
--- a/configs/socfpga_n5x_vab_defconfig
+++ b/configs/socfpga_n5x_vab_defconfig
@@ -35,10 +35,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x3fa00000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
index 2d4f70592d2..0ca1da96510 100644
--- a/configs/socfpga_stratix10_atf_defconfig
+++ b/configs/socfpga_stratix10_atf_defconfig
@@ -35,10 +35,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x3fa00000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
 CONFIG_SPL_ATF=y
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 7d078dd18e0..add3d15c858 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -35,10 +35,10 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x3fa00000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x3C00000
 CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e9b63e5b847..586f2929851 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -54,10 +54,10 @@ CONFIG_SPL_PAD_TO=0x0
 CONFIG_SPL_BSS_START_ADDR=0x8040000
 CONFIG_SPL_BSS_MAX_SIZE=0x10000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x400000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x400000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2
 CONFIG_SPL_I2C=y
diff --git a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
index e01745498c0..189703fee07 100644
--- a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
@@ -22,10 +22,10 @@ CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x3db00
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0300000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1d00000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
index e72684683e7..6e8fc2f5cda 100644
--- a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
@@ -22,10 +22,10 @@ CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x3db00
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0300000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1d00000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
index b910d474ca7..d6cb330bae1 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
@@ -22,10 +22,10 @@ CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x3db00
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0300000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1d00000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
index 5007e6246d4..a99fc89be31 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
@@ -22,10 +22,10 @@ CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x3db00
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0300000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1d00000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index 9ea5aaa7145..2cb2ad64b27 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -32,10 +32,10 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x3db00
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0300000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1d00000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index af7416659c1..289040e011a 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -40,10 +40,10 @@ CONFIG_SPL_MAX_FOOTPRINT=0x3db00
 CONFIG_SPL_BOOTCOUNT_LIMIT=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0300000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1d00000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index b7f372f9e4d..fe45e2b7d51 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_MAX_FOOTPRINT=0x3db00
 CONFIG_SPL_BOOTCOUNT_LIMIT=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xc0300000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1d00000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/syzygy_hub_defconfig b/configs/syzygy_hub_defconfig
index bf234548253..7bcb3191000 100644
--- a/configs/syzygy_hub_defconfig
+++ b/configs/syzygy_hub_defconfig
@@ -28,8 +28,8 @@ CONFIG_SPL_BSS_START_ADDR=0x100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x2000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 CONFIG_SPL_FS_LOAD_ARGS_NAME="system.dtb"
 CONFIG_SPL_OS_BOOT=y
 CONFIG_SYS_SPL_ARGS_ADDR=0x10000000
diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
index 81a83771cde..0db0a75cbb8 100644
--- a/configs/taurus_defconfig
+++ b/configs/taurus_defconfig
@@ -49,10 +49,10 @@ CONFIG_SPL_BSS_MAX_SIZE=0x600
 # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x20ba0000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x460000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x20ba0000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x460000
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_RAW_ONLY=y
 CONFIG_SPL_NAND_DRIVERS=y
diff --git a/configs/tec-ng_defconfig b/configs/tec-ng_defconfig
index 4776e92683d..607112c2cb2 100644
--- a/configs/tec-ng_defconfig
+++ b/configs/tec-ng_defconfig
@@ -21,10 +21,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2084
 # CONFIG_CMD_IMI is not set
diff --git a/configs/tec_defconfig b/configs/tec_defconfig
index 8a5d959a5c0..de76f1a39e6 100644
--- a/configs/tec_defconfig
+++ b/configs/tec_defconfig
@@ -19,10 +19,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x90000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2081
 # CONFIG_CMD_IMI is not set
diff --git a/configs/thuban_defconfig b/configs/thuban_defconfig
index 6302c1a4151..a1370bd2b9d 100644
--- a/configs/thuban_defconfig
+++ b/configs/thuban_defconfig
@@ -38,9 +38,9 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x80000000
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80208000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/topic_miami_defconfig b/configs/topic_miami_defconfig
index ef1b66e9069..5c845592f3d 100644
--- a/configs/topic_miami_defconfig
+++ b/configs/topic_miami_defconfig
@@ -33,8 +33,8 @@ CONFIG_SPL_BSS_START_ADDR=0x100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x2000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/topic_miamilite_defconfig b/configs/topic_miamilite_defconfig
index af829ac15b8..3a464a52483 100644
--- a/configs/topic_miamilite_defconfig
+++ b/configs/topic_miamilite_defconfig
@@ -33,8 +33,8 @@ CONFIG_SPL_BSS_START_ADDR=0x100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x2000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/topic_miamiplus_defconfig b/configs/topic_miamiplus_defconfig
index 9287b1d79aa..6e66081bf3b 100644
--- a/configs/topic_miamiplus_defconfig
+++ b/configs/topic_miamiplus_defconfig
@@ -33,8 +33,8 @@ CONFIG_SPL_BSS_START_ADDR=0x100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x2000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 6fe6f2548dc..a46dfed74ae 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -26,10 +26,10 @@ CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff;
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2084
 CONFIG_CMD_BOOTMENU=y
diff --git a/configs/trimslice_defconfig b/configs/trimslice_defconfig
index 9ec08bda883..0e49272a80d 100644
--- a/configs/trimslice_defconfig
+++ b/configs/trimslice_defconfig
@@ -21,10 +21,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x90000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2087
 # CONFIG_CMD_IMI is not set
diff --git a/configs/udoo_defconfig b/configs/udoo_defconfig
index ab8cb489db7..e128a62cd00 100644
--- a/configs/udoo_defconfig
+++ b/configs/udoo_defconfig
@@ -23,7 +23,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
 CONFIG_SPL_I2C=y
diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index e06de7be682..853472f4f49 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -21,7 +21,7 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_CMD_BMODE is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
diff --git a/configs/variscite_dart6ul_defconfig b/configs/variscite_dart6ul_defconfig
index 1cfa3421fd1..1cf4a8fe56a 100644
--- a/configs/variscite_dart6ul_defconfig
+++ b/configs/variscite_dart6ul_defconfig
@@ -19,7 +19,7 @@ CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_BOOTCOMMAND="run mmc_mmc_fit"
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/venice2_defconfig b/configs/venice2_defconfig
index ebd1754fc8b..77e6ffeb945 100644
--- a/configs/venice2_defconfig
+++ b/configs/venice2_defconfig
@@ -21,10 +21,10 @@ CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2086
 # CONFIG_CMD_IMI is not set
diff --git a/configs/ventana_defconfig b/configs/ventana_defconfig
index 2da8ba94d62..0524758b056 100644
--- a/configs/ventana_defconfig
+++ b/configs/ventana_defconfig
@@ -18,10 +18,10 @@ CONFIG_USE_PREBOOT=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x90000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2085
 # CONFIG_CMD_IMI is not set
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index 878195a61ac..794b6216b90 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -38,10 +38,10 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x140000
 CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 09e14c6f8c4..3e3848085c3 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -43,10 +43,10 @@ CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 2df0f4f3443..e499ed851c4 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -53,10 +53,10 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
diff --git a/configs/vining_2000_defconfig b/configs/vining_2000_defconfig
index cbb82593d09..e5d34959fca 100644
--- a/configs/vining_2000_defconfig
+++ b/configs/vining_2000_defconfig
@@ -33,7 +33,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
 CONFIG_SPL_I2C=y
diff --git a/configs/wandboard_defconfig b/configs/wandboard_defconfig
index 0493ef2f67c..7c1727f8b12 100644
--- a/configs/wandboard_defconfig
+++ b/configs/wandboard_defconfig
@@ -33,7 +33,7 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SYS_SPL_MALLOC=y
+CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index 540c43096d8..6fbb9d6481c 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -27,10 +27,10 @@ CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc1; ru
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=2084
 CONFIG_CMD_BOOTMENU=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 99005773459..4ea5caff547 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -37,8 +37,8 @@ CONFIG_SPL_BSS_START_ADDR=0x100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_SYS_SPL_MALLOC_SIZE=0x2000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_FS_LOAD_ARGS_NAME="system.dtb"
 CONFIG_SPL_FPGA=y
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index cf7c7eda8c9..72b1ad4660a 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -26,10 +26,10 @@ CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x20000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x20000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 CONFIG_SYS_MAXARGS=64
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index a4a43b58a85..310aad445a5 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -26,10 +26,10 @@ CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x20000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x20000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 CONFIG_SYS_MAXARGS=64
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index e6a9dd31a57..4c732398fc5 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -27,10 +27,10 @@ CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x20000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x20000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 26260841c59..59be5f42493 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -36,10 +36,10 @@ CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x20000000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x20000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_FS_LOAD_KERNEL_NAME="atf-uboot.ub"
 CONFIG_SPL_FS_LOAD_ARGS_NAME="u-boot.bin"
 CONFIG_SPL_FPGA=y
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index 64cdffbb9a4..19f653f40d0 100644
--- a/configs/zynq_cse_nand_defconfig
+++ b/configs/zynq_cse_nand_defconfig
@@ -28,10 +28,10 @@ CONFIG_SPL_BSS_START_ADDR=0x20000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x2000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index 54620b2382e..64df1f0b83e 100644
--- a/configs/zynq_cse_nor_defconfig
+++ b/configs/zynq_cse_nor_defconfig
@@ -28,10 +28,10 @@ CONFIG_SPL_BSS_START_ADDR=0x20000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x2000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index 08c500930fd..8c75b3233d7 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -35,10 +35,10 @@ CONFIG_SPL_BSS_START_ADDR=0x20000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_SPL_MALLOC=y
-CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x200000
-CONFIG_SYS_SPL_MALLOC_SIZE=0x2000000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x2000000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
 # CONFIG_CMDLINE_EDITING is not set
diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index f0d848f45d8..4c5a00f6f9c 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -14,7 +14,7 @@ config SPL_DM
 	help
 	  Enable driver model in SPL. You will need to provide a
 	  suitable malloc() implementation. If you are not using the
-	  full malloc() enabled by CFG_SYS_SPL_MALLOC_START,
+	  full malloc() enabled by CFG_SPL_SYS_MALLOC_START,
 	  consider using CONFIG_SPL_SYS_MALLOC_SIMPLE. In that case you
 	  must provide CONFIG_SPL_SYS_MALLOC_F_LEN to set the size.
 	  In most cases driver model will only allocate a few uclasses
@@ -27,7 +27,7 @@ config TPL_DM
 	help
 	  Enable driver model in TPL. You will need to provide a
 	  suitable malloc() implementation. If you are not using the
-	  full malloc() enabled by CFG_SYS_SPL_MALLOC_START,
+	  full malloc() enabled by CFG_SPL_SYS_MALLOC_START,
 	  consider using CONFIG_TPL_SYS_MALLOC_SIMPLE. In that case you
 	  must provide CONFIG_SPL_SYS_MALLOC_F_LEN to set the size.
 	  In most cases driver model will only allocate a few uclasses
@@ -42,7 +42,7 @@ config VPL_DM
 	help
 	  Enable driver model in VPL. You will need to provide a
 	  suitable malloc() implementation. If you are not using the
-	  full malloc() enabled by CFG_SYS_SPL_MALLOC_START,
+	  full malloc() enabled by CFG_SPL_SYS_MALLOC_START,
 	  consider using CONFIG_SPL_SYS_MALLOC_SIMPLE.
 
 config DM_WARN
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 7ca42df6a7e..f5478a9ccd0 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -160,7 +160,7 @@ config SERIAL_PROBE_ALL
 config SPL_DM_SERIAL
 	bool "Enable Driver Model for serial drivers in SPL"
 	depends on DM_SERIAL && SPL_DM
-	select SYS_SPL_MALLOC_F
+	select SPL_SYS_MALLOC_F
 	default y
 	help
 	  Enable driver model for serial in SPL. This replaces
diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
index 0c96c9c24fe..4838bfd4f13 100644
--- a/include/configs/socfpga_common.h
+++ b/include/configs/socfpga_common.h
@@ -18,7 +18,7 @@
 #define CFG_SYS_INIT_RAM_ADDR	0xFFE00000
 /* SPL memory allocation configuration, this is for FAT implementation */
 #define CFG_SYS_INIT_RAM_SIZE	(SOCFPGA_PHYS_OCRAM_SIZE - \
-					 CONFIG_SYS_SPL_MALLOC_SIZE)
+					 CONFIG_SPL_SYS_MALLOC_SIZE)
 #endif
 
 /*
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 66ecb168a0a..820372c28b3 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -112,7 +112,7 @@ unsigned int cm_get_l4_sys_free_clk_hz(void);
  * SDRAM
  * 0x0000_0000 ...... Start of SDRAM_1
  * unused / empty space for image loading
- * Size 64MB   ...... MALLOC (size CONFIG_SYS_SPL_MALLOC_SIZE)
+ * Size 64MB   ...... MALLOC (size CONFIG_SPL_SYS_MALLOC_SIZE)
  * Size 1MB    ...... BSS (size CONFIG_SPL_BSS_MAX_SIZE)
  * 0x8000_0000 ...... End of SDRAM_1 (assume 2GB)
  *
diff --git a/include/system-constants.h b/include/system-constants.h
index 0d6b71b35a0..f0a191be590 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -22,10 +22,10 @@
 /*
  * Typically, we have the SPL malloc pool at the end of the BSS area.
  */
-#ifdef CONFIG_HAS_CUSTOM_SPL_MALLOC_START
-#define SYS_SPL_MALLOC_START		CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR
+#ifdef CONFIG_SPL_HAS_CUSTOM_MALLOC_START
+#define SPL_SYS_MALLOC_START		CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR
 #else
-#define SYS_SPL_MALLOC_START		(CONFIG_SPL_BSS_START_ADDR + \
+#define SPL_SYS_MALLOC_START		(CONFIG_SPL_BSS_START_ADDR + \
 					 CONFIG_SPL_BSS_MAX_SIZE)
 #endif
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

