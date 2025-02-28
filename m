Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B3DC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF638121A;
	Fri, 28 Feb 2025 13:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hi7COOAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9F8810ED; Fri, 28 Feb 2025 13:20:57 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AFA809D4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3cfeff44d94so7491445ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740745252; x=1741350052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2GoxqxtCuZRmtiICuwEhfPo0QeOt1slFmUh8lx6Wydk=;
 b=Hi7COOAIYzpycPTsubFG4V+sEgPfCKn4AzI+O5wRDqpGqOdSjGMWK9Ofl6OEPy0Hbk
 GmPYJ/ZwmzxyJY/PjnBWn3RKFiYfH5zRYm3qKMU8Qorujbl4FYAoAGmSVSg9PB+SjhEZ
 ImZv+/zWBZK8QDn53fUmWJNtct2Jc5t/Odve4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740745252; x=1741350052;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2GoxqxtCuZRmtiICuwEhfPo0QeOt1slFmUh8lx6Wydk=;
 b=llDpOFyforbtX4WwreTU1YYMGUdI6o5qI91S+qerSA+DLufv0w84XU5KG969z8Gn6C
 eUy4uY8YpB6UcywZm/fXzRAcDzGftz75WUoPr9BcW0b+0/OU7dnbnrt1ZWsi82mSDNut
 g2esEQfdo0OlQ2JSrlBIVMtqUBapIM8iQZUFF9aNT9pm+O9XnmkyNV8OGFq/5AKUs/Ob
 Ev4ksL7JsDdIK5V+0NsELYm2TuzlhbffhOVQZ9e42053K5o/xwUHMx9XiM2tSlzKaubL
 InHDSRtQZmvvLC6vjgHRa9cWp3oP0TFwe92csMcvXdAaZnxqcU35dsE2T0haDOREVv87
 /xbw==
X-Gm-Message-State: AOJu0YwAYf1UEbMFI3hKA6drEuC986F8fx6mAo9LqLuujGozB+mLwSgj
 qpwfCM6kY+aJQkI2PLdxzxnjIumF1n28W1L31TegTzGuqUpmZVMz68oD3ueBqm5XKpZSZ/6Inso
 =
X-Gm-Gg: ASbGncsOiAUbsJwwfpx4uiofM0VGJAphhRD+KVCclkbtinQHBOt0mYCJW9iAcg5ozwX
 lDhCN4MikFeuqWkhEuFe2ntYlRHxYqQf6Wr1G636l3Euux+o0D3T6PkFmRmht96ac2F1YJ2pt/S
 GdGYNlx3zVExU/qdFG8XnWxAtZEYPP0foCnbYdQ5a0HFmLZXCyBlOINZaZVZFNNWCgyYdxDAYk+
 2jNWWdBolnRPlNX0MhC1OQWVY3AHxgUppS9AkuRMnyq+MzWM5F33m7XixGx9F+LY9X+Q5sKcS+B
 mn2rkgvA6+AlDXigGWYs08znnEZDtYKc+Ljeqci0h8JO2i66Wub+96NAD41crYM=
X-Google-Smtp-Source: AGHT+IGgDowRkCzyDJUvIALflZRcwX/70ehFfRV1OxIvg1DeGrpvjgRqE1H3YkJaQnvn9LZWFRpwLQ==
X-Received: by 2002:a05:6e02:1565:b0:3d2:1206:cabe with SMTP id
 e9e14a558f8ab-3d3e6f56bf2mr27834425ab.22.1740745252549; 
 Fri, 28 Feb 2025 04:20:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061fa91e3sm863801173.138.2025.02.28.04.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 04:20:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Alison Wang <alison.wang@nxp.com>, Anatolij Gustschin <agust@denx.de>,
 Chee Hong Ang <chee.hong.ang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Gary Bisson <bisson.gary@gmail.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wasim Khan <wasim.khan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Ye Li <ye.li@nxp.com>, u-boot@dh-electronics.com
Subject: [PATCH v4 0/4] xPL-stack cleanup
Date: Fri, 28 Feb 2025 05:20:22 -0700
Message-ID: <20250228122042.1277079-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Feb 2025 13:45:41 +0100
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

This series was split from the VBE part H series. It adjusts the logic
for selecting the top of the stack so that it is more consistent across
xPL phases.

Changes in v4:
- Rebase to -next

Changes in v3:
- Reword the Kconfig help for TPL_HAVE_INIT_STACK
- Rebase to -next
- Fixed 'VPL' typo
- Update commit message to mention the behaviour change
- Update TPL_HAVE_INIT_STACK to drop the SPL fallback
- Use 'phase' instead of 'stage' in VPL_STACK
- Split off into its own 'vbh' series

Changes in v2:
- Add new patch to rename TPL_NEEDS_SEPARATE_STACK
- Add new patch with an SPL_HAVE_INIT_STACK option
- Add new patch to use CONFIG_VAL() to obtain the SPL stack
- Reply on existing CONFIG_VAL() to select the VPL stack
- Correct reference to TPL when VPL was intended

Simon Glass (4):
  tpl: Rename TPL_NEEDS_SEPARATE_STACK to TPL_HAVE_INIT_STACK
  spl: Add an SPL_HAVE_INIT_STACK option
  spl: Use CONFIG_VAL() to obtain the SPL stack
  arm: Support a separate stack for VPL

 arch/arm/cpu/armv7/lowlevel_init.S            |  4 +--
 arch/arm/cpu/armv7/start.S                    |  4 +--
 arch/arm/lib/crt0.S                           |  6 ++--
 arch/arm/lib/crt0_64.S                        |  6 ++--
 arch/arm/mach-rockchip/Kconfig                | 14 +++++-----
 arch/riscv/cpu/start.S                        |  4 +--
 common/spl/Kconfig                            | 28 +++++++++++++++----
 common/spl/Kconfig.tpl                        | 19 +++++++------
 common/spl/Kconfig.vpl                        | 14 ++++++++++
 configs/alt_defconfig                         |  1 +
 configs/apalis-tk1_defconfig                  |  1 +
 configs/apalis_t30_defconfig                  |  1 +
 configs/axm_defconfig                         |  1 +
 configs/beaver_defconfig                      |  1 +
 configs/bitmain_antminer_s9_defconfig         |  1 +
 configs/capricorn_cxg3_defconfig              |  1 +
 configs/cardhu_defconfig                      |  1 +
 configs/cei-tk1-som_defconfig                 |  1 +
 configs/cgtqmx8_defconfig                     |  1 +
 configs/chromebit_mickey_defconfig            |  1 +
 configs/chromebook_jerry_defconfig            |  1 +
 configs/chromebook_minnie_defconfig           |  1 +
 configs/chromebook_speedy_defconfig           |  1 +
 configs/ci20_mmc_defconfig                    |  1 +
 configs/clearfog_defconfig                    |  1 +
 configs/clearfog_sata_defconfig               |  1 +
 configs/clearfog_spi_defconfig                |  1 +
 configs/colibri_t20_defconfig                 |  1 +
 configs/colibri_t30_defconfig                 |  1 +
 configs/controlcenterdc_defconfig             |  1 +
 configs/corvus_defconfig                      |  1 +
 configs/da850evm_defconfig                    |  1 +
 configs/da850evm_nand_defconfig               |  1 +
 configs/dalmore_defconfig                     |  1 +
 configs/db-88f6720_defconfig                  |  1 +
 configs/db-88f6820-amc_defconfig              |  1 +
 configs/db-88f6820-amc_nand_defconfig         |  1 +
 configs/db-88f6820-gp_defconfig               |  1 +
 configs/db-mv784mp-gp_defconfig               |  1 +
 configs/ds116_defconfig                       |  1 +
 configs/ds414_defconfig                       |  1 +
 configs/endeavoru_defconfig                   |  1 +
 configs/evb-px5_defconfig                     |  1 +
 configs/evb-rk3036_defconfig                  |  1 +
 configs/evb-rk3288_defconfig                  |  1 +
 .../gardena-smart-gateway-at91sam_defconfig   |  1 +
 configs/gose_defconfig                        |  1 +
 configs/grouper_defconfig                     |  1 +
 configs/harmony_defconfig                     |  1 +
 configs/helios4_defconfig                     |  1 +
 configs/ideapad-yoga-11_defconfig             |  1 +
 configs/imx28_xea_defconfig                   |  1 +
 configs/imx8mm-cl-iot-gate-optee_defconfig    |  1 +
 configs/imx8mm-cl-iot-gate_defconfig          |  1 +
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |  1 +
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |  1 +
 configs/imx8mm-mx8menlo_defconfig             |  1 +
 configs/imx8mm-phygate-tauri-l_defconfig      |  1 +
 configs/imx8mm_beacon_defconfig               |  1 +
 configs/imx8mm_beacon_fspi_defconfig          |  1 +
 configs/imx8mm_data_modul_edm_sbc_defconfig   |  1 +
 configs/imx8mm_evk_defconfig                  |  1 +
 configs/imx8mm_evk_fspi_defconfig             |  1 +
 configs/imx8mm_phg_defconfig                  |  1 +
 configs/imx8mm_venice_defconfig               |  1 +
 configs/imx8mn_beacon_2g_defconfig            |  1 +
 configs/imx8mn_beacon_defconfig               |  1 +
 configs/imx8mn_beacon_fspi_defconfig          |  1 +
 configs/imx8mn_bsh_smm_s2_defconfig           |  1 +
 configs/imx8mn_bsh_smm_s2pro_defconfig        |  1 +
 configs/imx8mn_ddr4_evk_defconfig             |  1 +
 configs/imx8mn_evk_defconfig                  |  1 +
 configs/imx8mn_var_som_defconfig              |  1 +
 configs/imx8mn_venice_defconfig               |  1 +
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |  1 +
 configs/imx8mp_beacon_defconfig               |  1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig   |  1 +
 configs/imx8mp_debix_model_a_defconfig        |  1 +
 configs/imx8mp_dhsom.config                   |  1 +
 configs/imx8mp_evk_defconfig                  |  1 +
 configs/imx8mp_navqp_defconfig                |  1 +
 configs/imx8mp_rsb3720a1_4G_defconfig         |  1 +
 configs/imx8mp_rsb3720a1_6G_defconfig         |  1 +
 configs/imx8mp_venice_defconfig               |  1 +
 configs/imx8mq_cm_defconfig                   |  1 +
 configs/imx8mq_evk_defconfig                  |  1 +
 configs/imx8mq_phanbell_defconfig             |  1 +
 configs/imx8mq_reform2_defconfig              |  1 +
 configs/imx8qm_dmsse20a1_defconfig            |  1 +
 configs/imx8qm_mek_defconfig                  |  1 +
 configs/imx8qxp_mek_defconfig                 |  1 +
 configs/imx8ulp_evk_defconfig                 |  1 +
 configs/imx91_11x11_evk_defconfig             |  1 +
 configs/imx91_11x11_evk_inline_ecc_defconfig  |  1 +
 configs/imx93-phycore_defconfig               |  1 +
 configs/imx93_11x11_evk_defconfig             |  1 +
 configs/imx93_9x9_qsb_defconfig               |  1 +
 configs/imx93_9x9_qsb_inline_ecc_defconfig    |  1 +
 configs/imx93_var_som_defconfig               |  1 +
 configs/jetson-tk1_defconfig                  |  1 +
 configs/k2e_evm_defconfig                     |  1 +
 configs/k2g_evm_defconfig                     |  1 +
 configs/k2hk_evm_defconfig                    |  1 +
 configs/k2l_evm_defconfig                     |  1 +
 configs/koelsch_defconfig                     |  1 +
 configs/kontron-sl-mx8mm_defconfig            |  1 +
 configs/kontron_pitx_imx8m_defconfig          |  1 +
 configs/kontron_sl28_defconfig                |  1 +
 configs/kylin-rk3036_defconfig                |  1 +
 configs/lager_defconfig                       |  1 +
 configs/librem5_defconfig                     |  1 +
 configs/ls1021aiot_sdcard_defconfig           |  1 +
 configs/ls1021aqds_nand_defconfig             |  1 +
 configs/ls1021aqds_sdcard_ifc_defconfig       |  1 +
 configs/ls1021aqds_sdcard_qspi_defconfig      |  1 +
 configs/ls1021atsn_sdcard_defconfig           |  1 +
 ...s1021atwr_sdcard_ifc_SECURE_BOOT_defconfig |  1 +
 configs/ls1021atwr_sdcard_ifc_defconfig       |  1 +
 configs/ls1021atwr_sdcard_qspi_defconfig      |  1 +
 configs/ls2080aqds_nand_defconfig             |  1 +
 configs/ls2080ardb_nand_defconfig             |  1 +
 configs/m53menlo_defconfig                    |  1 +
 configs/maxbcm_defconfig                      |  1 +
 configs/medcom-wide_defconfig                 |  1 +
 configs/microblaze-generic_defconfig          |  1 +
 configs/mk808_defconfig                       |  3 +-
 configs/msc_sm2s_imx8mp_defconfig             |  1 +
 configs/mt7629_rfb_defconfig                  |  1 +
 configs/n2350_defconfig                       |  1 +
 configs/nyan-big_defconfig                    |  1 +
 configs/omapl138_lcdk_defconfig               |  1 +
 configs/openpiton_riscv64_spl_defconfig       |  1 +
 configs/paz00_defconfig                       |  1 +
 configs/phycore-imx8mm_defconfig              |  1 +
 configs/phycore-imx8mp_defconfig              |  1 +
 configs/phycore-rk3288_defconfig              |  1 +
 configs/picasso_defconfig                     |  1 +
 configs/pico-imx8mq_defconfig                 |  1 +
 configs/plutux_defconfig                      |  1 +
 configs/popmetal-rk3288_defconfig             |  1 +
 configs/porter_defconfig                      |  1 +
 configs/qc750_defconfig                       |  1 +
 configs/r8a77970_eagle_defconfig              |  1 +
 configs/r8a77970_v3msk_defconfig              |  1 +
 configs/r8a77980_condor_defconfig             |  1 +
 configs/r8a77980_v3hsk_defconfig              |  1 +
 configs/r8a77990_ebisu_defconfig              |  1 +
 configs/r8a77995_draak_defconfig              |  1 +
 configs/rcar3_salvator-x_defconfig            |  1 +
 configs/rcar3_ulcb_defconfig                  |  1 +
 configs/rock-pi-n8-rk3288_defconfig           |  1 +
 configs/rock2_defconfig                       |  1 +
 configs/rock_defconfig                        |  1 +
 configs/sama5d27_giantboard_defconfig         |  1 +
 configs/sama5d27_som1_ek_mmc1_defconfig       |  1 +
 configs/sama5d27_som1_ek_mmc_defconfig        |  1 +
 configs/sama5d27_som1_ek_qspiflash_defconfig  |  1 +
 configs/sama5d27_wlsom1_ek_mmc_defconfig      |  1 +
 .../sama5d27_wlsom1_ek_qspiflash_defconfig    |  1 +
 configs/sama5d2_icp_mmc_defconfig             |  1 +
 configs/sama5d2_xplained_emmc_defconfig       |  1 +
 configs/sama5d2_xplained_mmc_defconfig        |  1 +
 configs/sama5d2_xplained_qspiflash_defconfig  |  1 +
 configs/sama5d2_xplained_spiflash_defconfig   |  1 +
 configs/sama5d3_xplained_mmc_defconfig        |  1 +
 configs/sama5d3_xplained_nandflash_defconfig  |  1 +
 configs/sama5d3xek_mmc_defconfig              |  1 +
 configs/sama5d3xek_nandflash_defconfig        |  1 +
 configs/sama5d3xek_spiflash_defconfig         |  1 +
 configs/sama5d4_xplained_mmc_defconfig        |  1 +
 configs/sama5d4_xplained_nandflash_defconfig  |  1 +
 configs/sama5d4_xplained_spiflash_defconfig   |  1 +
 configs/sama5d4ek_mmc_defconfig               |  1 +
 configs/sama5d4ek_nandflash_defconfig         |  1 +
 configs/sama5d4ek_spiflash_defconfig          |  1 +
 configs/seaboard_defconfig                    |  1 +
 configs/sifive_unleashed_defconfig            |  1 +
 configs/sifive_unmatched_defconfig            |  1 +
 configs/silinux_ek874_defconfig               |  1 +
 configs/silk_defconfig                        |  1 +
 configs/smartweb_defconfig                    |  1 +
 configs/socfpga_agilex5_defconfig             |  1 +
 configs/socfpga_agilex_atf_defconfig          |  1 +
 configs/socfpga_agilex_defconfig              |  1 +
 configs/socfpga_agilex_vab_defconfig          |  1 +
 configs/socfpga_arria10_defconfig             |  1 +
 configs/socfpga_arria5_defconfig              |  1 +
 configs/socfpga_cyclone5_defconfig            |  1 +
 configs/socfpga_dbm_soc1_defconfig            |  1 +
 configs/socfpga_de0_nano_soc_defconfig        |  1 +
 configs/socfpga_de10_nano_defconfig           |  1 +
 configs/socfpga_de10_standard_defconfig       |  1 +
 configs/socfpga_de1_soc_defconfig             |  1 +
 configs/socfpga_is1_defconfig                 |  1 +
 configs/socfpga_mcvevk_defconfig              |  1 +
 configs/socfpga_n5x_atf_defconfig             |  1 +
 configs/socfpga_n5x_defconfig                 |  1 +
 configs/socfpga_n5x_vab_defconfig             |  1 +
 configs/socfpga_secu1_defconfig               |  1 +
 configs/socfpga_sockit_defconfig              |  1 +
 configs/socfpga_socrates_defconfig            |  1 +
 configs/socfpga_sr1500_defconfig              |  1 +
 configs/socfpga_stratix10_atf_defconfig       |  1 +
 configs/socfpga_stratix10_defconfig           |  1 +
 configs/socfpga_vining_fpga_defconfig         |  1 +
 configs/starfive_visionfive2_defconfig        |  1 +
 ...stm32mp15-icore-stm32mp1-ctouch2_defconfig |  1 +
 ...tm32mp15-icore-stm32mp1-edimm2.2_defconfig |  1 +
 ...-microgea-stm32mp1-microdev2-of7_defconfig |  1 +
 ...mp15-microgea-stm32mp1-microdev2_defconfig |  1 +
 configs/stm32mp15_basic_defconfig             |  1 +
 configs/stm32mp15_dhsom.config                |  1 +
 configs/stout_defconfig                       |  1 +
 configs/surface-rt_defconfig                  |  1 +
 configs/syzygy_hub_defconfig                  |  1 +
 configs/taurus_defconfig                      |  1 +
 configs/tec-ng_defconfig                      |  1 +
 configs/tec_defconfig                         |  1 +
 configs/theadorable_debug_defconfig           |  1 +
 configs/topic_miami_defconfig                 |  1 +
 configs/topic_miamilite_defconfig             |  1 +
 configs/topic_miamiplus_defconfig             |  1 +
 configs/transformer_t20_defconfig             |  1 +
 configs/transformer_t30_defconfig             |  1 +
 configs/trimslice_defconfig                   |  1 +
 configs/turris_omnia_defconfig                |  1 +
 configs/uniphier_ld4_sld8_defconfig           |  1 +
 configs/uniphier_v7_defconfig                 |  1 +
 configs/venice2_defconfig                     |  1 +
 configs/ventana_defconfig                     |  1 +
 configs/verdin-imx8mm_defconfig               |  1 +
 configs/verdin-imx8mp_defconfig               |  1 +
 configs/vyasa-rk3288_defconfig                |  1 +
 configs/work_92105_defconfig                  |  1 +
 configs/x3_t30_defconfig                      |  1 +
 configs/x530_defconfig                        |  1 +
 configs/xilinx_mbv32_defconfig                |  1 +
 configs/xilinx_mbv32_smode_defconfig          |  1 +
 configs/xilinx_mbv64_defconfig                |  1 +
 configs/xilinx_mbv64_smode_defconfig          |  1 +
 configs/xilinx_zynq_virt_defconfig            |  1 +
 configs/xilinx_zynqmp_kria_defconfig          |  1 +
 configs/xilinx_zynqmp_mini_emmc0_defconfig    |  1 +
 configs/xilinx_zynqmp_mini_emmc1_defconfig    |  1 +
 configs/xilinx_zynqmp_mini_qspi_defconfig     |  1 +
 configs/xilinx_zynqmp_virt_defconfig          |  1 +
 configs/zynq_cse_nand_defconfig               |  1 +
 configs/zynq_cse_nor_defconfig                |  1 +
 configs/zynq_cse_qspi_defconfig               |  1 +
 249 files changed, 305 insertions(+), 36 deletions(-)

-- 
2.43.0

base-commit: 87f00c3ba5993e40fdbe1fadcfe69191e4cacd33
branch: vbh4-us
