Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D03FC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 662FF81273;
	Fri, 28 Feb 2025 13:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gNAPTOtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 965358120C; Fri, 28 Feb 2025 13:21:08 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F3B810F6
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-855a54f83fdso136046139f.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740745261; x=1741350061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OE2ZmBcKGhDPvbGo+Ddg32ArowIoLVngY08eXjLe7FE=;
 b=gNAPTOtxp4hAvEqMHJDdQYKRsvjIQDcf71pcXr696xwWiwj7p8K2TFEsOwRYiRbdQH
 ri0vI0LntElWL3mam0wDPR1sWS8sP8PzQLu2OyTT+gw9CRAd1HfGyGrofARtgLOzbSxZ
 K0LUc3t0j4zWco9yp8VI/qcyUF/ij7hy38acY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740745261; x=1741350061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OE2ZmBcKGhDPvbGo+Ddg32ArowIoLVngY08eXjLe7FE=;
 b=dV3UYarVb9D61ddpkJuBEee+mY7WZatCbIBQ3C4R5yIBivT/iVUuERJEOsw9MsO8uR
 g5FRxquSJLsZCYHBLpPgFiWsWyrM9NvoZ78pzteRIhvzkdeYt3+FkPpkIx0asopQXKPu
 IqyvxgUIfgVw52grONVVrmjeBX3C0xEzjHCMN2ytMJ6WK2Xy9klsQvZ4Q8fMyfiXOxCk
 VXyoIEOswNUjxSfmT4xKgwuoyTXEGZhQNO8soC/uPOgJUGFfJk+DB6b6zyiDZztCykqF
 hr/YnCXsfs3hER+jalaza/ZSudVh3ILgNp8407uTOSZ5VhrHRKpsx79RANp8QigniVGR
 iQpQ==
X-Gm-Message-State: AOJu0YwTbOBLnVtiFc5rNG5URdtqq5yIv2zNdA/1Mx+h+1+Kl7BJf7Zq
 02zl6hsScSQxsCYOjVs+5oXnnnyhjdRjjQssVjTMlWWJbqYN3mygk8OFVI/kqFVjUw2QmDc4JQU
 =
X-Gm-Gg: ASbGncugbzLqQQfCidRxE2JGXHRVe4Am49v+JGaKTgHeoX5KitJYkBtZO9ZLiF3jyvM
 +IHzRSQY45n30pdWQjVTnkNPZy2fN0DJT0nQ2uhwTX99jaOyOEP/+mRs8/GxDo57zIAPyR1/YN6
 9NlicNrkSMMR6lXzpoGixfwGNQFJqggHg2vDdZKZwaSaAiuXYDj6TsubjmuN6N78NhT03GP4++v
 2P8T+525CIiwWZVle2fSZj1fNDGBveIJi3JEnyOtdtlesRpvesSFVbN1PGayZWr//Kwq62fFvUx
 eaI8WjFYGDOqItvmFgjMUrHOF/ju0WSW2jzrTleaBvdb30gN6krUeY+JsfIz0b8=
X-Google-Smtp-Source: AGHT+IEPHaMqAoAhhC8SpbQn3ePR6jDu8WDrVdwcPlxd4Nqjxqv5Xw40FuLci3X8ooRu/hveVFQmtQ==
X-Received: by 2002:a05:6602:1501:b0:855:9c88:787d with SMTP id
 ca18e2360f4ac-85881e02ed6mr288069739f.0.1740745260427; 
 Fri, 28 Feb 2025 04:21:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061fa91e3sm863801173.138.2025.02.28.04.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 04:20:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Alison Wang <alison.wang@nxp.com>, Anatolij Gustschin <agust@denx.de>,
 Chee Hong Ang <chee.hong.ang@intel.com>, Chin-Liang See <clsee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Johan Jonker <jbx6244@gmail.com>, Josua Mayer <josua@solid-run.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Neha Malcom Francis <n-francis@ti.com>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Rick Chen <rick@andestech.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Tingting Meng <tingting.meng@altera.com>, Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wasim Khan <wasim.khan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Ye Li <ye.li@nxp.com>, huang lin <hl@rock-chips.com>,
 u-boot@dh-electronics.com
Subject: [PATCH v4 2/4] spl: Add an SPL_HAVE_INIT_STACK option
Date: Fri, 28 Feb 2025 05:20:24 -0700
Message-ID: <20250228122042.1277079-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228122042.1277079-1-sjg@chromium.org>
References: <20250228122042.1277079-1-sjg@chromium.org>
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

At present there is a hex value SPL_STACK which both determines whether
SPL has its own initial stack and the hex value of that stack.

Split off the former into SPL_HAVE_INIT_STACK with SPL_STACK depending
on that and only providing the latter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Rebase to -next

Changes in v2:
- Add new patch with an SPL_HAVE_INIT_STACK option

 arch/arm/cpu/armv7/lowlevel_init.S            |  2 +-
 arch/arm/cpu/armv7/start.S                    |  2 +-
 arch/arm/lib/crt0.S                           |  2 +-
 arch/arm/lib/crt0_64.S                        |  2 +-
 arch/riscv/cpu/start.S                        |  2 +-
 common/spl/Kconfig                            | 28 +++++++++++++++----
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
 configs/mk808_defconfig                       |  1 +
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
 246 files changed, 268 insertions(+), 10 deletions(-)

diff --git a/arch/arm/cpu/armv7/lowlevel_init.S b/arch/arm/cpu/armv7/lowlevel_init.S
index a6c844b7e3d..c2a0fe061a3 100644
--- a/arch/arm/cpu/armv7/lowlevel_init.S
+++ b/arch/arm/cpu/armv7/lowlevel_init.S
@@ -26,7 +26,7 @@ WEAK(lowlevel_init)
 	/*
 	 * Setup a temporary stack. Global data is not available yet.
 	 */
-#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
 	ldr	sp, =CONFIG_SPL_STACK
 #else
 	ldr	sp, =SYS_INIT_SP_ADDR
diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index b63481b43ca..3394db46953 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -279,7 +279,7 @@ ENTRY(cpu_init_cp15)
 	orr	r2, r4, r2		@ r2 has combined CPU variant + revision
 
 /* Early stack for ERRATA that needs into call C code */
-#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
 	ldr	r0, =(CONFIG_SPL_STACK)
 #else
 	ldr	r0, =(SYS_INIT_SP_ADDR)
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index aca5b865680..0248606906a 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -102,7 +102,7 @@ ENTRY(_main)
 
 #if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
 	ldr	r0, =(CONFIG_TPL_STACK)
-#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
+#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
 	ldr	r0, =(CONFIG_SPL_STACK)
 #else
 	ldr	r0, =(SYS_INIT_SP_ADDR)
diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index 62a0abe1fed..1b6782b06ed 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -71,7 +71,7 @@ ENTRY(_main)
  */
 #if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
 	ldr	x0, =(CONFIG_TPL_STACK)
-#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
+#elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
 	ldr	x0, =(CONFIG_SPL_STACK)
 #elif defined(CONFIG_INIT_SP_RELATIVE)
 #if CONFIG_POSITION_INDEPENDENT
diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 3f78932aa9d..c8526dd82fd 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -90,7 +90,7 @@ _start:
  * Set stackpointer in internal/ex RAM to call board_init_f
  */
 call_board_init_f:
-#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_HAVE_INIT_STACK)
 	li	t0, CONFIG_SPL_STACK
 #else
 	li	t0, SYS_INIT_SP_ADDR
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 7d6780936d1..97f542fcc8a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -387,11 +387,29 @@ config SPL_SHARES_INIT_SP_ADDR
 	  both SPL and U-Boot itself.  If you need to specify a different address
 	  however, say N here and then set a different value in CONFIG_SPL_STACK.
 
-config SPL_STACK
-	hex "Initial stack pointer location"
+config SPL_HAVE_INIT_STACK
+	bool "SPL requires a initial, fixed, stack-pointer location"
 	depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && \
 		SPL_FRAMEWORK || ROCKCHIP_RK3036
 	depends on !SPL_SHARES_INIT_SP_ADDR
+	default y if ARCH_MX7
+	default y if ARCH_MX6 && MX6_OCRAM_256KB
+	default y if ARCH_MX6 && !MX6_OCRAM_256KB
+	default y if MACH_SUN50I_H6 || MACH_SUN50I_H616 || MACH_SUN8I_R528
+	default y if MACH_SUN50I || MACH_SUN50I_H5
+	default y if MACH_SUN9I
+	default y if ARCH_SUNXI
+	default y if ARCH_SC5XX && (SC59X_64 || SC59X)
+	default y if ARCH_SC5XX && SC58X
+	default y if ARCH_SC5XX && SC57X
+	help
+	  Enable if the SPL phase should not use inherit its initial
+	  stack-pointer from the settings for U-Boot proper, but should set
+	  its own value.
+
+config SPL_STACK
+	hex "Address of the initial stack-pointer for the SPL phase"
+	depends on SPL_HAVE_INIT_STACK
 	default 0x946bb8 if ARCH_MX7
 	default 0x93ffb8 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x91ffb8 if ARCH_MX6 && !MX6_OCRAM_256KB
@@ -401,9 +419,9 @@ config SPL_STACK
 	default 0x54000 if MACH_SUN50I || MACH_SUN50I_H5
 	default 0x18000 if MACH_SUN9I
 	default 0x8000 if ARCH_SUNXI
-	default 0x200E4000 if ARCH_SC5XX && (SC59X_64 || SC59X)
-	default 0x200B0000 if ARCH_SC5XX && SC58X
-	default 0x200D0000 if ARCH_SC5XX && SC57X
+	default 0x200e4000 if ARCH_SC5XX && (SC59X_64 || SC59X)
+	default 0x200b0000 if ARCH_SC5XX && SC58X
+	default 0x200d0000 if ARCH_SC5XX && SC57X
 	help
 	  Address of the start of the stack SPL will use before SDRAM is
 	  initialized.
diff --git a/configs/alt_defconfig b/configs/alt_defconfig
index 7b16923e34d..29b98f1b7bc 100644
--- a/configs/alt_defconfig
+++ b/configs/alt_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARCH_RENESAS_BOARD_STRING="Alt"
 CONFIG_R8A7794=y
 CONFIG_TARGET_ALT=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6340000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL=y
diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
index ef982f70193..3012ec2d888 100644
--- a/configs/apalis-tk1_defconfig
+++ b/configs/apalis-tk1_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DEFAULT_DEVICE_TREE="tegra124-apalis"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/apalis_t30_defconfig b/configs/apalis_t30_defconfig
index 3143566c2c7..521f5fecda2 100644
--- a/configs/apalis_t30_defconfig
+++ b/configs/apalis_t30_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-apalis"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/axm_defconfig b/configs/axm_defconfig
index 7fd9e4046f2..d0b5830f81f 100644
--- a/configs/axm_defconfig
+++ b/configs/axm_defconfig
@@ -19,6 +19,7 @@ CONFIG_SPL_LDSCRIPT="arch/arm/cpu/u-boot-spl.lds"
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="at91sam9g20-taurus"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x304000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/beaver_defconfig b/configs/beaver_defconfig
index 71037ee7474..3e944e8aec3 100644
--- a/configs/beaver_defconfig
+++ b/configs/beaver_defconfig
@@ -9,6 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-beaver"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/bitmain_antminer_s9_defconfig b/configs/bitmain_antminer_s9_defconfig
index edb49de207c..d863781566f 100644
--- a/configs/bitmain_antminer_s9_defconfig
+++ b/configs/bitmain_antminer_s9_defconfig
@@ -11,6 +11,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="bitmain-antminer-s9"
 CONFIG_SPL_STACK_R_ADDR=0x200000
 CONFIG_SYS_BOOTCOUNT_ADDR=0xEFFFFF0
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x100000
diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index 10e0cbd9ad2..ef96c7b4df5 100644
--- a/configs/capricorn_cxg3_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -17,6 +17,7 @@ CONFIG_TARGET_CAPRICORN=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x13e000
 CONFIG_SPL_TEXT_BASE=0x100000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/cardhu_defconfig b/configs/cardhu_defconfig
index 57978de66e1..c3434648688 100644
--- a/configs/cardhu_defconfig
+++ b/configs/cardhu_defconfig
@@ -9,6 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-cardhu"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/cei-tk1-som_defconfig b/configs/cei-tk1-som_defconfig
index d2778fbcd03..5e2c0f9e32f 100644
--- a/configs/cei-tk1-som_defconfig
+++ b/configs/cei-tk1-som_defconfig
@@ -9,6 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra124-cei-tk1-som"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/cgtqmx8_defconfig b/configs/cgtqmx8_defconfig
index 37ae957db03..73c6f986d48 100644
--- a/configs/cgtqmx8_defconfig
+++ b/configs/cgtqmx8_defconfig
@@ -16,6 +16,7 @@ CONFIG_TARGET_CONGA_QMX8=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x13e000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x128000
diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index 874f266dad1..d834c1886a5 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -15,6 +15,7 @@ CONFIG_ROCKCHIP_RK3288=y
 # CONFIG_SPL_MMC is not set
 CONFIG_TARGET_CHROMEBIT_MICKEY=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_TEXT_BASE=0xff704000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index f40b8e84e39..f4b9caeb34f 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 # CONFIG_SPL_MMC is not set
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_TEXT_BASE=0xff704000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 2f125ba12ad..3a0be3078ab 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -15,6 +15,7 @@ CONFIG_ROCKCHIP_RK3288=y
 # CONFIG_SPL_MMC is not set
 CONFIG_TARGET_CHROMEBOOK_MINNIE=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_TEXT_BASE=0xff704000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index c19b0905d5c..78ab62c3392 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -15,6 +15,7 @@ CONFIG_ROCKCHIP_RK3288=y
 # CONFIG_SPL_MMC is not set
 CONFIG_TARGET_CHROMEBOOK_SPEEDY=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_TEXT_BASE=0xff704000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/ci20_mmc_defconfig b/configs/ci20_mmc_defconfig
index 2d094bd6e90..eeb430eb80a 100644
--- a/configs/ci20_mmc_defconfig
+++ b/configs/ci20_mmc_defconfig
@@ -10,6 +10,7 @@ CONFIG_ENV_OFFSET=0x83800
 CONFIG_DEFAULT_DEVICE_TREE="ci20"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xf4008000
 CONFIG_SPL_TEXT_BASE=0xf4000a00
 CONFIG_SPL_BSS_START_ADDR=0xf4004000
diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
index 6f6597c5331..c4a7ad66d69 100644
--- a/configs/clearfog_defconfig
+++ b/configs/clearfog_defconfig
@@ -12,6 +12,7 @@ CONFIG_TARGET_CLEARFOG=y
 CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
 CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/clearfog_sata_defconfig b/configs/clearfog_sata_defconfig
index 491a27321f9..b6ad150cb82 100644
--- a/configs/clearfog_sata_defconfig
+++ b/configs/clearfog_sata_defconfig
@@ -12,6 +12,7 @@ CONFIG_TARGET_CLEARFOG=y
 CONFIG_MVEBU_SPL_BOOT_DEVICE_SATA=y
 CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/clearfog_spi_defconfig b/configs/clearfog_spi_defconfig
index d3de1657c09..7c7294ec080 100644
--- a/configs/clearfog_spi_defconfig
+++ b/configs/clearfog_spi_defconfig
@@ -12,6 +12,7 @@ CONFIG_TARGET_CLEARFOG=y
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DEFAULT_DEVICE_TREE="armada-388-clearfog"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/colibri_t20_defconfig b/configs/colibri_t20_defconfig
index 6c5c1a92712..26729b33c59 100644
--- a/configs/colibri_t20_defconfig
+++ b/configs/colibri_t20_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x200000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-colibri"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x1000000
diff --git a/configs/colibri_t30_defconfig b/configs/colibri_t30_defconfig
index 4f2dde6d84a..3c747238f4a 100644
--- a/configs/colibri_t30_defconfig
+++ b/configs/colibri_t30_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-colibri"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/controlcenterdc_defconfig b/configs/controlcenterdc_defconfig
index e6242e22509..2d1c978f8db 100644
--- a/configs/controlcenterdc_defconfig
+++ b/configs/controlcenterdc_defconfig
@@ -15,6 +15,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="armada-38x-controlcenterdc"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x40031000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/corvus_defconfig b/configs/corvus_defconfig
index ce2f4f7d91e..a8d61f3b45a 100644
--- a/configs/corvus_defconfig
+++ b/configs/corvus_defconfig
@@ -19,6 +19,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x70007f00
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="at91sam9g45-corvus"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4000
 CONFIG_SPL_TEXT_BASE=0x300000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/da850evm_defconfig b/configs/da850evm_defconfig
index 4cddc7f5836..8f3a3f971ed 100644
--- a/configs/da850evm_defconfig
+++ b/configs/da850evm_defconfig
@@ -20,6 +20,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/davinci/da850-evm"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x8001ff00
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/da850evm_nand_defconfig b/configs/da850evm_nand_defconfig
index b8b1a96c16a..4827c0665fc 100644
--- a/configs/da850evm_nand_defconfig
+++ b/configs/da850evm_nand_defconfig
@@ -17,6 +17,7 @@ CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/davinci/da850-evm"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x8001ff00
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/dalmore_defconfig b/configs/dalmore_defconfig
index 4dba3717abb..52a947868a0 100644
--- a/configs/dalmore_defconfig
+++ b/configs/dalmore_defconfig
@@ -8,6 +8,7 @@ CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra114-dalmore"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/db-88f6720_defconfig b/configs/db-88f6720_defconfig
index d2f400dae8d..c82c247bb07 100644
--- a/configs/db-88f6720_defconfig
+++ b/configs/db-88f6720_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DEFAULT_DEVICE_TREE="armada-375-db"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/db-88f6820-amc_defconfig b/configs/db-88f6820-amc_defconfig
index 23fe44faf51..d4a1ddddc79 100644
--- a/configs/db-88f6820-amc_defconfig
+++ b/configs/db-88f6820-amc_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="armada-385-db-88f6820-amc"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/db-88f6820-amc_nand_defconfig b/configs/db-88f6820-amc_nand_defconfig
index f0dd977748b..f357e262126 100644
--- a/configs/db-88f6820-amc_nand_defconfig
+++ b/configs/db-88f6820-amc_nand_defconfig
@@ -15,6 +15,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="armada-385-db-88f6820-amc"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/db-88f6820-gp_defconfig b/configs/db-88f6820-gp_defconfig
index cb017a72551..17a0f668bff 100644
--- a/configs/db-88f6820-gp_defconfig
+++ b/configs/db-88f6820-gp_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="armada-388-gp"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/db-mv784mp-gp_defconfig b/configs/db-mv784mp-gp_defconfig
index a417c944b0f..5b9efeab98f 100644
--- a/configs/db-mv784mp-gp_defconfig
+++ b/configs/db-mv784mp-gp_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DEFAULT_DEVICE_TREE="armada-xp-gp"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40004030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
index 8562874ecde..67bcc15bccf 100644
--- a/configs/ds116_defconfig
+++ b/configs/ds116_defconfig
@@ -18,6 +18,7 @@ CONFIG_ENV_OFFSET=0x7E0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/armada-385-synology-ds116"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
index 44e9b176827..0cbb0cdcc10 100644
--- a/configs/ds414_defconfig
+++ b/configs/ds414_defconfig
@@ -18,6 +18,7 @@ CONFIG_ENV_OFFSET=0x7E0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DEFAULT_DEVICE_TREE="armada-xp-synology-ds414"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40004030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index 1d1f1042291..a54becfe6ed 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SOURCE_FILE="endeavoru"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-htc-endeavoru"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x82000000
diff --git a/configs/evb-px5_defconfig b/configs/evb-px5_defconfig
index b08714437fd..c9262417139 100644
--- a/configs/evb-px5_defconfig
+++ b/configs/evb-px5_defconfig
@@ -16,6 +16,7 @@ CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_PX5=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x188000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x400000
diff --git a/configs/evb-rk3036_defconfig b/configs/evb-rk3036_defconfig
index d215af0c046..d620fac8fd9 100644
--- a/configs/evb-rk3036_defconfig
+++ b/configs/evb-rk3036_defconfig
@@ -14,6 +14,7 @@ CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3036-evb"
 CONFIG_ROCKCHIP_RK3036=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x10081fff
 CONFIG_SPL_TEXT_BASE=0x10081000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/evb-rk3288_defconfig b/configs/evb-rk3288_defconfig
index ae79efebf57..f6b72a2b7a0 100644
--- a/configs/evb-rk3288_defconfig
+++ b/configs/evb-rk3288_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_EVB_RK3288=y
 CONFIG_SPL_STACK_R_ADDR=0x04000000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
diff --git a/configs/gardena-smart-gateway-at91sam_defconfig b/configs/gardena-smart-gateway-at91sam_defconfig
index c9eb661aab0..ecb451f07f9 100644
--- a/configs/gardena-smart-gateway-at91sam_defconfig
+++ b/configs/gardena-smart-gateway-at91sam_defconfig
@@ -17,6 +17,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="at91sam9g25-gardena-smart-gateway"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x308000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SPL_TEXT_BASE=0x300000
diff --git a/configs/gose_defconfig b/configs/gose_defconfig
index b53f2f37409..b604647c8e4 100644
--- a/configs/gose_defconfig
+++ b/configs/gose_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARCH_RENESAS_BOARD_STRING="Gose"
 CONFIG_R8A7793=y
 CONFIG_TARGET_GOSE=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6340000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL=y
diff --git a/configs/grouper_defconfig b/configs/grouper_defconfig
index 9221ffb46a3..e0708a45abf 100644
--- a/configs/grouper_defconfig
+++ b/configs/grouper_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SOURCE_FILE="grouper"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-nexus7-grouper-E1565"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x82000000
diff --git a/configs/harmony_defconfig b/configs/harmony_defconfig
index d8cc8451bac..b21ba903a43 100644
--- a/configs/harmony_defconfig
+++ b/configs/harmony_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x1FFE0000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-harmony"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x1000000
diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index 2778cb7dc86..08a46936ce8 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -12,6 +12,7 @@ CONFIG_TARGET_HELIOS4=y
 CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
 CONFIG_DEFAULT_DEVICE_TREE="armada-388-helios4"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ideapad-yoga-11_defconfig b/configs/ideapad-yoga-11_defconfig
index 3c152cbfb98..2db116afe14 100644
--- a/configs/ideapad-yoga-11_defconfig
+++ b/configs/ideapad-yoga-11_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SOURCE_FILE="ideapad-yoga-11"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-lenovo-ideapad-yoga-11"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x82000000
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 38282e6ea92..785c11f5093 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -18,6 +18,7 @@ CONFIG_SPL_MXS_PMU_DISABLE_BATT_CHARGE=y
 # CONFIG_SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR is not set
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x20000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SPL_TEXT_BASE=0x1000
diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-cl-iot-gate-optee_defconfig
index 722a5969732..c0c87da386b 100644
--- a/configs/imx8mm-cl-iot-gate-optee_defconfig
+++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index 1aa42efe5ef..2dcf4aacb9b 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
index db44145f650..330d73f05dd 100644
--- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
index 94b4a9552cf..c2ffce47271 100644
--- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index ad310750c77..f10d0fada98 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -17,6 +17,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
 CONFIG_SYS_BOOTCOUNT_ADDR=0x30370090
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index c7582843421..22d186c77d4 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 56e18893b77..e3f29ddf2e5 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -16,6 +16,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
index 2a8bd2df940..3d1630a8750 100644
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ b/configs/imx8mm_beacon_fspi_defconfig
@@ -16,6 +16,7 @@ CONFIG_TARGET_IMX8MM_BEACON=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E2000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index 66cb1331ded..47f0d3cc050 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -30,6 +30,7 @@ CONFIG_SPL_DM_USB=y
 CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_TEXT_BASE=0x7E1000
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 659fc9ec039..6aa3134649a 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 4a8d4994b80..bdf28836669 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E2000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index 384f2cc7b76..55639d6ea8f 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index 2e1c7a9f08a..f659e589a84 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -16,6 +16,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index b72fa93f90e..bb61f6b9b96 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -19,6 +19,7 @@ CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x980000
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index 69af7cee092..5de3a79fc80 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -18,6 +18,7 @@ CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x980000
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
index b90cb9002bd..b02ee69a375 100644
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ b/configs/imx8mn_beacon_fspi_defconfig
@@ -18,6 +18,7 @@ CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x980000
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index f4a04744667..51aebc31dcb 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -14,6 +14,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x980000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL_TEXT_BASE=0x912000
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index 9ca96a7f66f..52e6a358549 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x980000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL_TEXT_BASE=0x912000
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 3eb58d61c83..8e4289869f8 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x980000
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 967eeea4051..849f41bf8c2 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x980000
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index 9016c404017..b655aa77090 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -16,6 +16,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x980000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL_TEXT_BASE=0x912000
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 44af3e61d5d..99a8f83a773 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x980000
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index d7d5df77c5a..2a97af69a29 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index f39e4f5dd28..33fc0b8aa70 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index ea8109bf049..a30aaa57109 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -37,6 +37,7 @@ CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x96fc00
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_TEXT_BASE=0x920000
diff --git a/configs/imx8mp_debix_model_a_defconfig b/configs/imx8mp_debix_model_a_defconfig
index 560ac12b10d..14f62fbccb2 100644
--- a/configs/imx8mp_debix_model_a_defconfig
+++ b/configs/imx8mp_debix_model_a_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mp_dhsom.config b/configs/imx8mp_dhsom.config
index 7adbb9a84de..226c58c0277 100644
--- a/configs/imx8mp_dhsom.config
+++ b/configs/imx8mp_dhsom.config
@@ -41,6 +41,7 @@ CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
 CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
 CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x96fc00
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SPL_TEXT_BASE=0x920000
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 2438ab5d26a..ce920cee57b 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mp_navqp_defconfig b/configs/imx8mp_navqp_defconfig
index 6c7eb330b70..bdb9d14b36e 100644
--- a/configs/imx8mp_navqp_defconfig
+++ b/configs/imx8mp_navqp_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb3720a1_4G_defconfig
index bfcda77b37e..3d7432a0af4 100644
--- a/configs/imx8mp_rsb3720a1_4G_defconfig
+++ b/configs/imx8mp_rsb3720a1_4G_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb3720a1_6G_defconfig
index 69e67bcd498..553b2504390 100644
--- a/configs/imx8mp_rsb3720a1_6G_defconfig
+++ b/configs/imx8mp_rsb3720a1_6G_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 708412e3875..82d491aac11 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -16,6 +16,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mq_cm_defconfig b/configs/imx8mq_cm_defconfig
index 7444b642aa5..2d4ca5a798c 100644
--- a/configs/imx8mq_cm_defconfig
+++ b/configs/imx8mq_cm_defconfig
@@ -16,6 +16,7 @@ CONFIG_TARGET_IMX8MQ_CM=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x187ff0
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 97ef352dfb8..785efcb8771 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x187ff0
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index a3727390dc7..19ec1d27c84 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x187ff0
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index 1a6d6dcb8be..c6423c8ac61 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x187ff0
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8qm_dmsse20a1_defconfig b/configs/imx8qm_dmsse20a1_defconfig
index 9f2a6d78cee..83ac175c2fc 100644
--- a/configs/imx8qm_dmsse20a1_defconfig
+++ b/configs/imx8qm_dmsse20a1_defconfig
@@ -20,6 +20,7 @@ CONFIG_TARGET_IMX8QM_DMSSE20_A1=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x13e000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x128000
diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
index 9bbbc6a4912..dd1d6ebd95a 100644
--- a/configs/imx8qm_mek_defconfig
+++ b/configs/imx8qm_mek_defconfig
@@ -17,6 +17,7 @@ CONFIG_TARGET_IMX8QM_MEK=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x13e000
 CONFIG_SPL_TEXT_BASE=0x100000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconfig
index dfb288b9861..e5079751040 100644
--- a/configs/imx8qxp_mek_defconfig
+++ b/configs/imx8qxp_mek_defconfig
@@ -17,6 +17,7 @@ CONFIG_TARGET_IMX8QXP_MEK=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x13e000
 CONFIG_SPL_TEXT_BASE=0x100000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index cccc3153f50..06523f88746 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -15,6 +15,7 @@ CONFIG_TARGET_IMX8ULP_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x22050000
 CONFIG_SPL_TEXT_BASE=0x22020000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx91_11x11_evk_defconfig b/configs/imx91_11x11_evk_defconfig
index 1f711f2d051..cefaf68fa6c 100644
--- a/configs/imx91_11x11_evk_defconfig
+++ b/configs/imx91_11x11_evk_defconfig
@@ -17,6 +17,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x204E0000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL_TEXT_BASE=0x204A0000
diff --git a/configs/imx91_11x11_evk_inline_ecc_defconfig b/configs/imx91_11x11_evk_inline_ecc_defconfig
index 14aee2c5b27..2a64f153a65 100644
--- a/configs/imx91_11x11_evk_inline_ecc_defconfig
+++ b/configs/imx91_11x11_evk_inline_ecc_defconfig
@@ -17,6 +17,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x204E0000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL_TEXT_BASE=0x204A0000
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index cf9800118ac..1f75b7cfdef 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -19,6 +19,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x20519dd0
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 43a67232d04..b4b3aa8f8f9 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -15,6 +15,7 @@ CONFIG_TARGET_IMX93_11X11_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x20519dd0
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx93_9x9_qsb_defconfig b/configs/imx93_9x9_qsb_defconfig
index 8bd2ddda7da..02d66b243b0 100644
--- a/configs/imx93_9x9_qsb_defconfig
+++ b/configs/imx93_9x9_qsb_defconfig
@@ -16,6 +16,7 @@ CONFIG_TARGET_IMX93_9X9_QSB=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x20519dd0
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x18000
 CONFIG_SPL_TEXT_BASE=0x2049A000
diff --git a/configs/imx93_9x9_qsb_inline_ecc_defconfig b/configs/imx93_9x9_qsb_inline_ecc_defconfig
index 3d07dfb0029..f77f0fbc4c0 100644
--- a/configs/imx93_9x9_qsb_inline_ecc_defconfig
+++ b/configs/imx93_9x9_qsb_inline_ecc_defconfig
@@ -16,6 +16,7 @@ CONFIG_TARGET_IMX93_9X9_QSB=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x20519dd0
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x18000
 CONFIG_SPL_TEXT_BASE=0x2049A000
diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index 96cd8622e90..a6649126989 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -16,6 +16,7 @@ CONFIG_TARGET_IMX93_VAR_SOM=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x20519dd0
 CONFIG_SPL_TEXT_BASE=0x2049A000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/jetson-tk1_defconfig b/configs/jetson-tk1_defconfig
index b92590eb5fd..d8a0f1f56d9 100644
--- a/configs/jetson-tk1_defconfig
+++ b/configs/jetson-tk1_defconfig
@@ -9,6 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra124-jetson-tk1"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/k2e_evm_defconfig b/configs/k2e_evm_defconfig
index c2073096b6e..2b60d1fbd84 100644
--- a/configs/k2e_evm_defconfig
+++ b/configs/k2e_evm_defconfig
@@ -20,6 +20,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2e-evm"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xc1223f4
 CONFIG_SPL_TEXT_BASE=0xC100000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/k2g_evm_defconfig b/configs/k2g_evm_defconfig
index c93e82a7c59..2256c7143cd 100644
--- a/configs/k2g_evm_defconfig
+++ b/configs/k2g_evm_defconfig
@@ -19,6 +19,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2g-evm"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xc0c23f4
 CONFIG_SPL_TEXT_BASE=0xC0A0000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/k2hk_evm_defconfig b/configs/k2hk_evm_defconfig
index 7ae7a3ba83c..cf387901eb9 100644
--- a/configs/k2hk_evm_defconfig
+++ b/configs/k2hk_evm_defconfig
@@ -20,6 +20,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2hk-evm"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xc2223f4
 CONFIG_SPL_TEXT_BASE=0xC200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/k2l_evm_defconfig b/configs/k2l_evm_defconfig
index 9f08e9d7995..4a1aa6018e0 100644
--- a/configs/k2l_evm_defconfig
+++ b/configs/k2l_evm_defconfig
@@ -20,6 +20,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2l-evm"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xc1223f4
 CONFIG_SPL_TEXT_BASE=0xC100000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
index eeb97474b2a..209a71c9c4c 100644
--- a/configs/koelsch_defconfig
+++ b/configs/koelsch_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARCH_RENESAS_BOARD_STRING="Koelsch"
 CONFIG_R8A7791=y
 CONFIG_TARGET_KOELSCH=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6340000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL=y
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index f2d5bc1e7ab..ac146e83e71 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -18,6 +18,7 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x91fff0
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index 6e21870f006..6206f418519 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x187ff0
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index 1f684093252..e992add5273 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -17,6 +17,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x18009ff0
 CONFIG_SPL_TEXT_BASE=0x18010000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/kylin-rk3036_defconfig b/configs/kylin-rk3036_defconfig
index bc60bc57075..edcbeb4e6ce 100644
--- a/configs/kylin-rk3036_defconfig
+++ b/configs/kylin-rk3036_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3036-kylin"
 CONFIG_ROCKCHIP_RK3036=y
 CONFIG_TARGET_KYLIN_RK3036=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x10081fff
 CONFIG_SPL_TEXT_BASE=0x10081000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/lager_defconfig b/configs/lager_defconfig
index b5682526c8c..b57f1ee1978 100644
--- a/configs/lager_defconfig
+++ b/configs/lager_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARCH_RENESAS_BOARD_STRING="Lager"
 CONFIG_R8A7790=y
 CONFIG_TARGET_LAGER=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6340000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL=y
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index f81e828e4de..b39f9592d1e 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x187ff0
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index f195d077687..46018e6429a 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ls1021a-iot-duart"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x1001d000
 CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls1021aqds_nand_defconfig b/configs/ls1021aqds_nand_defconfig
index 97d01225389..bbad2cd2df7 100644
--- a/configs/ls1021aqds_nand_defconfig
+++ b/configs/ls1021aqds_nand_defconfig
@@ -18,6 +18,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ls1021a-qds-duart"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x1001d000
 CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls1021aqds_sdcard_ifc_defconfig b/configs/ls1021aqds_sdcard_ifc_defconfig
index 96314d542df..932edd0f81a 100644
--- a/configs/ls1021aqds_sdcard_ifc_defconfig
+++ b/configs/ls1021aqds_sdcard_ifc_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x1001d000
 CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls1021aqds_sdcard_qspi_defconfig b/configs/ls1021aqds_sdcard_qspi_defconfig
index e466c3df145..a9ce741eb2a 100644
--- a/configs/ls1021aqds_sdcard_qspi_defconfig
+++ b/configs/ls1021aqds_sdcard_qspi_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x1001d000
 CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls1021atsn_sdcard_defconfig b/configs/ls1021atsn_sdcard_defconfig
index 86ee5315b42..eb57f8b099c 100644
--- a/configs/ls1021atsn_sdcard_defconfig
+++ b/configs/ls1021atsn_sdcard_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ls1021a-tsn"
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x1001d000
 CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
index 7dc3241124f..c5623d98962 100644
--- a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=1064960
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x1001d000
 CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls1021atwr_sdcard_ifc_defconfig b/configs/ls1021atwr_sdcard_ifc_defconfig
index d62126274e5..d635e8851ac 100644
--- a/configs/ls1021atwr_sdcard_ifc_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_defconfig
@@ -18,6 +18,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ls1021a-twr-duart"
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x1001d000
 CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls1021atwr_sdcard_qspi_defconfig b/configs/ls1021atwr_sdcard_qspi_defconfig
index 53f487da198..df4cc77fbae 100644
--- a/configs/ls1021atwr_sdcard_qspi_defconfig
+++ b/configs/ls1021atwr_sdcard_qspi_defconfig
@@ -18,6 +18,7 @@ CONFIG_DEFAULT_DEVICE_TREE="ls1021a-twr-duart"
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x1001d000
 CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index 755411ed853..6442ecff509 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="fsl-ls2080a-qds"
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x18009ff0
 CONFIG_SPL_TEXT_BASE=0x1800a000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_defconfig
index 1be0b4e88cb..10d195ffd44 100644
--- a/configs/ls2080ardb_nand_defconfig
+++ b/configs/ls2080ardb_nand_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="fsl-ls2080a-rdb"
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x18009ff0
 CONFIG_SPL_TEXT_BASE=0x1800a000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
index ccd1cb7475b..cf47426ae33 100644
--- a/configs/m53menlo_defconfig
+++ b/configs/m53menlo_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="imx53-m53menlo"
 CONFIG_SPL_SERIAL=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
 CONFIG_SYS_BOOTCOUNT_ADDR=0x53FA401C
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x70004000
 CONFIG_SPL_TEXT_BASE=0x70008000
 CONFIG_SYS_LOAD_ADDR=0x70800000
diff --git a/configs/maxbcm_defconfig b/configs/maxbcm_defconfig
index a3558c395b5..b67ece9865e 100644
--- a/configs/maxbcm_defconfig
+++ b/configs/maxbcm_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DEFAULT_DEVICE_TREE="armada-xp-maxbcm"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40004030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/medcom-wide_defconfig b/configs/medcom-wide_defconfig
index def3f98bd72..f8dca06ab45 100644
--- a/configs/medcom-wide_defconfig
+++ b/configs/medcom-wide_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x1FFE0000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-medcom-wide"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x1000000
diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index 87756cb26df..dbea3f8bdee 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -7,6 +7,7 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="microblaze-generic"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x100000
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x0
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index a1f089a23ea..8c7f4deb843 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -22,6 +22,7 @@ CONFIG_TPL_TEXT_BASE=0x10080c00
 CONFIG_TPL_STACK=0x1008FFFF
 CONFIG_TARGET_MK808=y
 CONFIG_SPL_STACK_R_ADDR=0x70000000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x1008ffff
 CONFIG_SPL_TEXT_BASE=0x60000000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index def90d470b1..387fb06460c 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/mt7629_rfb_defconfig b/configs/mt7629_rfb_defconfig
index f69be08cc3f..9cc23e9613b 100644
--- a/configs/mt7629_rfb_defconfig
+++ b/configs/mt7629_rfb_defconfig
@@ -14,6 +14,7 @@ CONFIG_TARGET_MT7629=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x40800000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x106000
 CONFIG_SPL_TEXT_BASE=0x201000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/n2350_defconfig b/configs/n2350_defconfig
index 9fb84c3b946..34646a4025f 100644
--- a/configs/n2350_defconfig
+++ b/configs/n2350_defconfig
@@ -18,6 +18,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="armada-385-thecus-n2350"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index 9054ec54ff9..a3ce34376b1 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -8,6 +8,7 @@ CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra124-nyan-big"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x82408000
diff --git a/configs/omapl138_lcdk_defconfig b/configs/omapl138_lcdk_defconfig
index b9ea355151e..fb0a482d411 100644
--- a/configs/omapl138_lcdk_defconfig
+++ b/configs/omapl138_lcdk_defconfig
@@ -21,6 +21,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="da850-lcdk"
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x8001ff00
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/openpiton_riscv64_spl_defconfig b/configs/openpiton_riscv64_spl_defconfig
index 09054d93047..b0e8ad11a8b 100644
--- a/configs/openpiton_riscv64_spl_defconfig
+++ b/configs/openpiton_riscv64_spl_defconfig
@@ -6,6 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82000000
 CONFIG_DEFAULT_DEVICE_TREE="openpiton-riscv64"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x83fffe80
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
 CONFIG_SPL_BSS_START_ADDR=0x82000000
diff --git a/configs/paz00_defconfig b/configs/paz00_defconfig
index e93fa1c003a..c2cd73d3e8e 100644
--- a/configs/paz00_defconfig
+++ b/configs/paz00_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-paz00"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x1000000
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index a7555fdabc7..4a534da6e95 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 58981e79a11..ba0bfe74f1a 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index 0f8e999ee3f..ff03a59b48d 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -14,6 +14,7 @@ CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 CONFIG_TARGET_PHYCORE_RK3288=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_TEXT_BASE=0xff704000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/picasso_defconfig b/configs/picasso_defconfig
index 994951bb81e..888d4fa30e2 100644
--- a/configs/picasso_defconfig
+++ b/configs/picasso_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SOURCE_FILE="picasso"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-acer-a500-picasso"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x2000000
diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfig
index e9ba2a6bf42..7245e54fa4d 100644
--- a/configs/pico-imx8mq_defconfig
+++ b/configs/pico-imx8mq_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x187ff0
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/plutux_defconfig b/configs/plutux_defconfig
index 1f2889ea8b1..43a3c8e04ee 100644
--- a/configs/plutux_defconfig
+++ b/configs/plutux_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x1FFE0000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-plutux"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x1000000
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index 1b2fb4a38cd..ae7869ae5fa 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -14,6 +14,7 @@ CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 CONFIG_TARGET_POPMETAL_RK3288=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_TEXT_BASE=0xff704000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/porter_defconfig b/configs/porter_defconfig
index cb18024da12..ea894b09e39 100644
--- a/configs/porter_defconfig
+++ b/configs/porter_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARCH_RENESAS_BOARD_STRING="Porter"
 CONFIG_R8A7791=y
 CONFIG_TARGET_PORTER=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6340000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL=y
diff --git a/configs/qc750_defconfig b/configs/qc750_defconfig
index 2485e64a2f0..4f830bea20e 100644
--- a/configs/qc750_defconfig
+++ b/configs/qc750_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SOURCE_FILE="qc750"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-wexler-qc750"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x82000000
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 4534b17adc1..0a03e6d0d9d 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77970-eagle"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_TARGET_EAGLE=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xe631f000
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index 4a146e1c859..96a5b81ed20 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -14,6 +14,7 @@ CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77970-v3msk"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_R8A77970=y
 CONFIG_TARGET_V3MSK=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xe631f000
diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_defconfig
index 9cf93d7dab2..d46548256d7 100644
--- a/configs/r8a77980_condor_defconfig
+++ b/configs/r8a77980_condor_defconfig
@@ -12,6 +12,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77980-condor"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_TARGET_CONDOR=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xe631f000
diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_defconfig
index d17720789e7..51e8d2bd368 100644
--- a/configs/r8a77980_v3hsk_defconfig
+++ b/configs/r8a77980_v3hsk_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77980-v3hsk"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_R8A77980=y
 CONFIG_TARGET_V3HSK=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xe631f000
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index da93d442532..e7f63110420 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77990-ebisu"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_TARGET_EBISU=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xe631f000
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index 0fe5be6b723..afabe788c45 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77995-draak"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_TARGET_DRAAK=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xe631f000
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 6b095f63549..adfe4e9490f 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -10,6 +10,7 @@ CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77951-salvator-x"
 CONFIG_SPL_TEXT_BASE=0xe6338000
 CONFIG_TARGET_SALVATOR_X=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xe633f000
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index 7ffa115cc76..52f7d8701dd 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -11,6 +11,7 @@ CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77951-ulcb"
 CONFIG_SPL_TEXT_BASE=0xe6338000
 CONFIG_TARGET_ULCB=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xe633f000
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index dde0b81eee4..92ffc72cd7a 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -16,6 +16,7 @@ CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_EVB_RK3288=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index bff65d1fc41..b356df23ec6 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -14,6 +14,7 @@ CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 CONFIG_TARGET_ROCK2=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_TEXT_BASE=0xff704000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/rock_defconfig b/configs/rock_defconfig
index 9c05bf45146..d2a84710cb0 100644
--- a/configs/rock_defconfig
+++ b/configs/rock_defconfig
@@ -16,6 +16,7 @@ CONFIG_ROCKCHIP_RK3188=y
 # CONFIG_ROCKCHIP_STIMER is not set
 CONFIG_TARGET_ROCK=y
 CONFIG_SPL_STACK_R_ADDR=0x60080000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x10087fff
 CONFIG_SPL_TEXT_BASE=0x10080800
 CONFIG_SPL_STACK_R=y
diff --git a/configs/sama5d27_giantboard_defconfig b/configs/sama5d27_giantboard_defconfig
index 70e3ea10dbe..e7fb2c40b9e 100644
--- a/configs/sama5d27_giantboard_defconfig
+++ b/configs/sama5d27_giantboard_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d27_som1_ek_mmc1_defconfig b/configs/sama5d27_som1_ek_mmc1_defconfig
index 9246ede4ef2..c590331b7fe 100644
--- a/configs/sama5d27_som1_ek_mmc1_defconfig
+++ b/configs/sama5d27_som1_ek_mmc1_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d27_som1_ek_mmc_defconfig b/configs/sama5d27_som1_ek_mmc_defconfig
index 4be4245e1f7..74cc6c91aaa 100644
--- a/configs/sama5d27_som1_ek_mmc_defconfig
+++ b/configs/sama5d27_som1_ek_mmc_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d27_som1_ek_qspiflash_defconfig b/configs/sama5d27_som1_ek_qspiflash_defconfig
index cdd10608e79..c169b5bbf5b 100644
--- a/configs/sama5d27_som1_ek_qspiflash_defconfig
+++ b/configs/sama5d27_som1_ek_qspiflash_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d27_wlsom1_ek_mmc_defconfig b/configs/sama5d27_wlsom1_ek_mmc_defconfig
index cc69a41f64c..770f56959b3 100644
--- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
+++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
index beab5d09db3..41effc845b4 100644
--- a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
+++ b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
@@ -17,6 +17,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d2_icp_mmc_defconfig b/configs/sama5d2_icp_mmc_defconfig
index 5e8b9b975e4..840c65d7c02 100644
--- a/configs/sama5d2_icp_mmc_defconfig
+++ b/configs/sama5d2_icp_mmc_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000000
diff --git a/configs/sama5d2_xplained_emmc_defconfig b/configs/sama5d2_xplained_emmc_defconfig
index 736a6eeaf87..4f0425a8224 100644
--- a/configs/sama5d2_xplained_emmc_defconfig
+++ b/configs/sama5d2_xplained_emmc_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d2_xplained_mmc_defconfig b/configs/sama5d2_xplained_mmc_defconfig
index 6fd1075ebdc..893f88c9e09 100644
--- a/configs/sama5d2_xplained_mmc_defconfig
+++ b/configs/sama5d2_xplained_mmc_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d2_xplained_qspiflash_defconfig b/configs/sama5d2_xplained_qspiflash_defconfig
index 4c30e9daa40..36d5e260243 100644
--- a/configs/sama5d2_xplained_qspiflash_defconfig
+++ b/configs/sama5d2_xplained_qspiflash_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d2_xplained_spiflash_defconfig b/configs/sama5d2_xplained_spiflash_defconfig
index 9431ff1caac..7fc2ee8be33 100644
--- a/configs/sama5d2_xplained_spiflash_defconfig
+++ b/configs/sama5d2_xplained_spiflash_defconfig
@@ -21,6 +21,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d3_xplained_mmc_defconfig b/configs/sama5d3_xplained_mmc_defconfig
index 0050d95188e..c0a3b0fbcc5 100644
--- a/configs/sama5d3_xplained_mmc_defconfig
+++ b/configs/sama5d3_xplained_mmc_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x318000
 CONFIG_SPL_TEXT_BASE=0x300000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d3_xplained_nandflash_defconfig b/configs/sama5d3_xplained_nandflash_defconfig
index 6a66637a9dc..6092b1458f2 100644
--- a/configs/sama5d3_xplained_nandflash_defconfig
+++ b/configs/sama5d3_xplained_nandflash_defconfig
@@ -16,6 +16,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x318000
 CONFIG_SPL_TEXT_BASE=0x300000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d3xek_mmc_defconfig b/configs/sama5d3xek_mmc_defconfig
index 4c7914673bf..677211ac8f0 100644
--- a/configs/sama5d3xek_mmc_defconfig
+++ b/configs/sama5d3xek_mmc_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x318000
 CONFIG_SPL_TEXT_BASE=0x300000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d3xek_nandflash_defconfig b/configs/sama5d3xek_nandflash_defconfig
index 985a152ea42..f724ad054e5 100644
--- a/configs/sama5d3xek_nandflash_defconfig
+++ b/configs/sama5d3xek_nandflash_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="sama5d36ek"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x318000
 CONFIG_SPL_TEXT_BASE=0x300000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d3xek_spiflash_defconfig b/configs/sama5d3xek_spiflash_defconfig
index 3f2bd734638..f0ac8014b74 100644
--- a/configs/sama5d3xek_spiflash_defconfig
+++ b/configs/sama5d3xek_spiflash_defconfig
@@ -20,6 +20,7 @@ CONFIG_DEFAULT_DEVICE_TREE="sama5d36ek"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x318000
 CONFIG_SPL_TEXT_BASE=0x300000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d4_xplained_mmc_defconfig b/configs/sama5d4_xplained_mmc_defconfig
index f0c4356cc9e..d08154fcd1c 100644
--- a/configs/sama5d4_xplained_mmc_defconfig
+++ b/configs/sama5d4_xplained_mmc_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d4_xplained_nandflash_defconfig b/configs/sama5d4_xplained_nandflash_defconfig
index 4d6ca43a6cb..20b6fec563d 100644
--- a/configs/sama5d4_xplained_nandflash_defconfig
+++ b/configs/sama5d4_xplained_nandflash_defconfig
@@ -17,6 +17,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d4_xplained_spiflash_defconfig b/configs/sama5d4_xplained_spiflash_defconfig
index c0680fbcb0d..5bb74238a54 100644
--- a/configs/sama5d4_xplained_spiflash_defconfig
+++ b/configs/sama5d4_xplained_spiflash_defconfig
@@ -21,6 +21,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d4ek_mmc_defconfig b/configs/sama5d4ek_mmc_defconfig
index 347ccb47c89..5668982ae85 100644
--- a/configs/sama5d4ek_mmc_defconfig
+++ b/configs/sama5d4ek_mmc_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d4ek_nandflash_defconfig b/configs/sama5d4ek_nandflash_defconfig
index b309b87dc6b..6ac5a5d7659 100644
--- a/configs/sama5d4ek_nandflash_defconfig
+++ b/configs/sama5d4ek_nandflash_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d4ek"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/sama5d4ek_spiflash_defconfig b/configs/sama5d4ek_spiflash_defconfig
index 38edafc1879..1c76f1a4aa3 100644
--- a/configs/sama5d4ek_spiflash_defconfig
+++ b/configs/sama5d4ek_spiflash_defconfig
@@ -20,6 +20,7 @@ CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d4ek"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x218000
 CONFIG_SPL_TEXT_BASE=0x200000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/seaboard_defconfig b/configs/seaboard_defconfig
index 090dc04112a..597f8760188 100644
--- a/configs/seaboard_defconfig
+++ b/configs/seaboard_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-seaboard"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x1000000
diff --git a/configs/sifive_unleashed_defconfig b/configs/sifive_unleashed_defconfig
index 96b6f482c4f..04c1ae7d83f 100644
--- a/configs/sifive_unleashed_defconfig
+++ b/configs/sifive_unleashed_defconfig
@@ -9,6 +9,7 @@ CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="hifive-unleashed-a00"
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x81cfe70
 CONFIG_SPL_BSS_START_ADDR=0x85000000
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 4fed7eda948..524aabaa9d9 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -10,6 +10,7 @@ CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="hifive-unmatched-a00"
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x81cfe60
 CONFIG_SPL_BSS_START_ADDR=0x85000000
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index 031fdc02691..c9a44247a86 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774c0-ek874"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_TARGET_SILINUX_EK874=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xe631f000
diff --git a/configs/silk_defconfig b/configs/silk_defconfig
index 1c70a16bf5b..7a4b147b030 100644
--- a/configs/silk_defconfig
+++ b/configs/silk_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARCH_RENESAS_BOARD_STRING="Silk"
 CONFIG_R8A7794=y
 CONFIG_TARGET_SILK=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6340000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL=y
diff --git a/configs/smartweb_defconfig b/configs/smartweb_defconfig
index aa8adf51181..e765d77cabe 100644
--- a/configs/smartweb_defconfig
+++ b/configs/smartweb_defconfig
@@ -17,6 +17,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="at91sam9260-smartweb"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x301000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index ca3ec23acfe..e56110da876 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x7d000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xbff00000
diff --git a/configs/socfpga_agilex_atf_defconfig b/configs/socfpga_agilex_atf_defconfig
index 8c4f7072aa8..26f2fa2fa8e 100644
--- a/configs/socfpga_agilex_atf_defconfig
+++ b/configs/socfpga_agilex_atf_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index eaa2161a2f7..65f3f44845d 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/socfpga_agilex_vab_defconfig b/configs/socfpga_agilex_vab_defconfig
index 2883480b30b..b4cfbb0b8a6 100644
--- a/configs/socfpga_agilex_vab_defconfig
+++ b/configs/socfpga_agilex_vab_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index 7b3b022d202..71d55e7ede9 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_arria10_socdk_sdmmc"
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffe2b000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_TARGET_SOCFPGA_ARRIA10_SOCDK=y
diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_defconfig
index 9185af22c61..817452d0873 100644
--- a/configs/socfpga_arria5_defconfig
+++ b/configs/socfpga_arria5_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_arria5_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_ARRIA5_SOCDK=y
diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index 69a9909aa63..c7b9971615d 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
diff --git a/configs/socfpga_dbm_soc1_defconfig b/configs/socfpga_dbm_soc1_defconfig
index 5b320e06b4b..68fd6871b76 100644
--- a/configs/socfpga_dbm_soc1_defconfig
+++ b/configs/socfpga_dbm_soc1_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_dbm_soc1"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_DEVBOARDS_DBM_SOC1=y
diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
index 04b051cea9a..cfc0f7d3f70 100644
--- a/configs/socfpga_de0_nano_soc_defconfig
+++ b/configs/socfpga_de0_nano_soc_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_de0_nano_soc"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_TERASIC_DE0_NANO=y
diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_nano_defconfig
index 703af3f9c21..3205d60a67a 100644
--- a/configs/socfpga_de10_nano_defconfig
+++ b/configs/socfpga_de10_nano_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_de10_nano"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_TERASIC_DE10_NANO=y
diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
index 76c41b21cec..97322a7dc5c 100644
--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_de10_standard"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_TERASIC_DE10_STANDARD=y
diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_defconfig
index 8cb158a0150..949c75236ba 100644
--- a/configs/socfpga_de1_soc_defconfig
+++ b/configs/socfpga_de1_soc_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_de1_soc"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_TERASIC_DE1_SOC=y
diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
index bc40e4f3d21..fadaa6157d3 100644
--- a/configs/socfpga_is1_defconfig
+++ b/configs/socfpga_is1_defconfig
@@ -11,6 +11,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_is1"
 CONFIG_DM_RESET=y
 CONFIG_SYS_BOOTCOUNT_ADDR=0xfffffff8
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffff8
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_IS1=y
diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_defconfig
index 7aa2db6def0..24ce3f29854 100644
--- a/configs/socfpga_mcvevk_defconfig
+++ b/configs/socfpga_mcvevk_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_mcvevk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_ARIES_MCVEVK=y
diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
index 5e927170f21..d7915af4605 100644
--- a/configs/socfpga_n5x_atf_defconfig
+++ b/configs/socfpga_n5x_atf_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 593325c25c3..ba78c343dfe 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
index e3d52fe02e6..487aa95b6fd 100644
--- a/configs/socfpga_n5x_vab_defconfig
+++ b/configs/socfpga_n5x_vab_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index 84badec60aa..92bed0a86ac 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_arria5_secu1"
 CONFIG_DM_RESET=y
 # CONFIG_SPL_MMC is not set
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_defconfig
index 869ba3d8b79..1ad5162c9e8 100644
--- a/configs/socfpga_sockit_defconfig
+++ b/configs/socfpga_sockit_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_sockit"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_TERASIC_SOCKIT=y
diff --git a/configs/socfpga_socrates_defconfig b/configs/socfpga_socrates_defconfig
index 31b406461e8..0a36e60f61f 100644
--- a/configs/socfpga_socrates_defconfig
+++ b/configs/socfpga_socrates_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x4400
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_socrates"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_EBV_SOCRATES=y
diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
index cade0d427cd..5e2906a2a16 100644
--- a/configs/socfpga_sr1500_defconfig
+++ b/configs/socfpga_sr1500_defconfig
@@ -12,6 +12,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_sr1500"
 CONFIG_DM_RESET=y
 CONFIG_SYS_BOOTCOUNT_ADDR=0xfffffff8
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffff8
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_SR1500=y
diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
index d3a358c029a..adfdbbbbcc7 100644
--- a/configs/socfpga_stratix10_atf_defconfig
+++ b/configs/socfpga_stratix10_atf_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_stratix10_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 3ea82598472..4004b01dcb8 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0x200
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_stratix10_socdk"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index df8391dc214..e7a2ab8530f 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -11,6 +11,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_cyclone5_vining_fpga"
 CONFIG_DM_RESET=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_SYS_BOOTM_LEN=0x2000000
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 1e0a99ed17b..3f0f1c383f0 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -14,6 +14,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x8180000
 CONFIG_SPL_TEXT_BASE=0x8000000
 CONFIG_SPL_BSS_START_ADDR=0x8040000
diff --git a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
index 00c475307c9..3ae5adb253f 100644
--- a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
@@ -6,6 +6,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0100000
 CONFIG_ENV_OFFSET=0x280000
 CONFIG_DEFAULT_DEVICE_TREE="stm32mp157a-icore-stm32mp1-ctouch2"
 CONFIG_SPL_MMC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x30000000
 CONFIG_SPL_TEXT_BASE=0x2FFC2500
 CONFIG_SYS_BOOTM_LEN=0x2000000
diff --git a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
index b733913be01..abc8c020221 100644
--- a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
@@ -6,6 +6,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0100000
 CONFIG_ENV_OFFSET=0x280000
 CONFIG_DEFAULT_DEVICE_TREE="stm32mp157a-icore-stm32mp1-edimm2.2"
 CONFIG_SPL_MMC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x30000000
 CONFIG_SPL_TEXT_BASE=0x2FFC2500
 CONFIG_SYS_BOOTM_LEN=0x2000000
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
index 35df3ea809d..75b3b1c3c06 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
@@ -6,6 +6,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0100000
 CONFIG_ENV_OFFSET=0x280000
 CONFIG_DEFAULT_DEVICE_TREE="stm32mp157a-microgea-stm32mp1-microdev2.0-of7"
 CONFIG_SPL_MMC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x30000000
 CONFIG_SPL_TEXT_BASE=0x2FFC2500
 CONFIG_SYS_BOOTM_LEN=0x2000000
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
index d1a92cbfbaa..1d1b2d9d4e4 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
@@ -6,6 +6,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0100000
 CONFIG_ENV_OFFSET=0x280000
 CONFIG_DEFAULT_DEVICE_TREE="stm32mp157a-microgea-stm32mp1-microdev2.0"
 CONFIG_SPL_MMC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x30000000
 CONFIG_SPL_TEXT_BASE=0x2FFC2500
 CONFIG_SYS_BOOTM_LEN=0x2000000
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index b0dc944a247..c5c94a953d9 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="stm32mp157c-ev1"
 CONFIG_SPL_MMC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x30000000
 CONFIG_SPL_TEXT_BASE=0x2FFC2500
 CONFIG_SYS_BOOTM_LEN=0x2000000
diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
index ac3ae82cda9..7e5b5aa67ef 100644
--- a/configs/stm32mp15_dhsom.config
+++ b/configs/stm32mp15_dhsom.config
@@ -55,6 +55,7 @@ CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x30000000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
diff --git a/configs/stout_defconfig b/configs/stout_defconfig
index 59bb7075013..2100fbd0805 100644
--- a/configs/stout_defconfig
+++ b/configs/stout_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARCH_RENESAS_BOARD_STRING="Stout"
 CONFIG_R8A7790=y
 CONFIG_TARGET_STOUT=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xe6340000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL=y
diff --git a/configs/surface-rt_defconfig b/configs/surface-rt_defconfig
index b5c84b4f003..e8d3df73996 100644
--- a/configs/surface-rt_defconfig
+++ b/configs/surface-rt_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SOURCE_FILE="surface-rt"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-microsoft-surface-rt"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x82000000
diff --git a/configs/syzygy_hub_defconfig b/configs/syzygy_hub_defconfig
index 27ff3915050..7869f30eab3 100644
--- a/configs/syzygy_hub_defconfig
+++ b/configs/syzygy_hub_defconfig
@@ -8,6 +8,7 @@ CONFIG_TEXT_BASE=0x4000000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="zynq-syzygy-hub"
 CONFIG_SPL_STACK_R_ADDR=0x200000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x100000
diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
index b60dfc6cd6f..e6f5dc49b20 100644
--- a/configs/taurus_defconfig
+++ b/configs/taurus_defconfig
@@ -21,6 +21,7 @@ CONFIG_SPL_LDSCRIPT="arch/arm/cpu/u-boot-spl.lds"
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="at91sam9g20-taurus"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x304000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/tec-ng_defconfig b/configs/tec-ng_defconfig
index 5e840ffcf2c..098532a200f 100644
--- a/configs/tec-ng_defconfig
+++ b/configs/tec-ng_defconfig
@@ -7,6 +7,7 @@ CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-tec-ng"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/tec_defconfig b/configs/tec_defconfig
index 3d46c9e57e3..0bfaa8d8d15 100644
--- a/configs/tec_defconfig
+++ b/configs/tec_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x1FFE0000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-tec"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x1000000
diff --git a/configs/theadorable_debug_defconfig b/configs/theadorable_debug_defconfig
index f957167f0ad..5f5f518a8f2 100644
--- a/configs/theadorable_debug_defconfig
+++ b/configs/theadorable_debug_defconfig
@@ -14,6 +14,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="armada-xp-theadorable"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40004030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/topic_miami_defconfig b/configs/topic_miami_defconfig
index 039ac710b38..84158c3d3b8 100644
--- a/configs/topic_miami_defconfig
+++ b/configs/topic_miami_defconfig
@@ -10,6 +10,7 @@ CONFIG_ENV_SIZE=0x8000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="zynq-topic-miami"
 CONFIG_SPL_STACK_R_ADDR=0x200000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x100000
diff --git a/configs/topic_miamilite_defconfig b/configs/topic_miamilite_defconfig
index b53f3a7150e..7d6d949183e 100644
--- a/configs/topic_miamilite_defconfig
+++ b/configs/topic_miamilite_defconfig
@@ -10,6 +10,7 @@ CONFIG_ENV_SIZE=0x8000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="zynq-topic-miamilite"
 CONFIG_SPL_STACK_R_ADDR=0x200000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x100000
diff --git a/configs/topic_miamiplus_defconfig b/configs/topic_miamiplus_defconfig
index ba7f248db3b..171c718c3d2 100644
--- a/configs/topic_miamiplus_defconfig
+++ b/configs/topic_miamiplus_defconfig
@@ -10,6 +10,7 @@ CONFIG_ENV_SIZE=0x8000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="zynq-topic-miamiplus"
 CONFIG_SPL_STACK_R_ADDR=0x200000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x100000
diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
index b69366581a4..e3e771e774c 100644
--- a/configs/transformer_t20_defconfig
+++ b/configs/transformer_t20_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SOURCE_FILE="transformer-t20"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-asus-tf101"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x2000000
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index c5f0bc2a613..105b9eab43f 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SOURCE_FILE="transformer-t30"
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf201"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x82000000
diff --git a/configs/trimslice_defconfig b/configs/trimslice_defconfig
index c04fc1a7752..c81bdd5f057 100644
--- a/configs/trimslice_defconfig
+++ b/configs/trimslice_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFE000
 CONFIG_ENV_SECT_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-trimslice"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x1000000
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index bdcc7407143..d70a1f38873 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -20,6 +20,7 @@ CONFIG_ENV_OFFSET=0xF0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DEFAULT_DEVICE_TREE="armada-385-turris-omnia"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/uniphier_ld4_sld8_defconfig b/configs/uniphier_ld4_sld8_defconfig
index a0fea87dafd..b9c3a2872ac 100644
--- a/configs/uniphier_ld4_sld8_defconfig
+++ b/configs/uniphier_ld4_sld8_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="uniphier-ld4-ref"
 CONFIG_SYS_MONITOR_LEN=2097152
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x100000
 CONFIG_SPL_TEXT_BASE=0x00040000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
diff --git a/configs/uniphier_v7_defconfig b/configs/uniphier_v7_defconfig
index 12647bb8ce1..af762523c46 100644
--- a/configs/uniphier_v7_defconfig
+++ b/configs/uniphier_v7_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="uniphier-pxs2-vodka"
 CONFIG_SYS_MONITOR_LEN=2097152
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x100000
 CONFIG_SPL_TEXT_BASE=0x00100000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
diff --git a/configs/venice2_defconfig b/configs/venice2_defconfig
index dfe821b3674..2da6f97b00b 100644
--- a/configs/venice2_defconfig
+++ b/configs/venice2_defconfig
@@ -8,6 +8,7 @@ CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra124-venice2"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x81000000
diff --git a/configs/ventana_defconfig b/configs/ventana_defconfig
index 1357f5faf26..dbfadae492c 100644
--- a/configs/ventana_defconfig
+++ b/configs/ventana_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-ventana"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xffffc
 CONFIG_SPL_TEXT_BASE=0x00108000
 CONFIG_SYS_LOAD_ADDR=0x1000000
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index b54028f3b60..205cca4e27d 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index ec76cff4dbe..3458f54adb1 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_TEXT_BASE=0x920000
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index e75466c1cad..3b4dc5b5699 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_VYASA_RK3288=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xff718000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000
diff --git a/configs/work_92105_defconfig b/configs/work_92105_defconfig
index 0b5ad853241..68eeefdf35e 100644
--- a/configs/work_92105_defconfig
+++ b/configs/work_92105_defconfig
@@ -18,6 +18,7 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfff8
 CONFIG_SPL_TEXT_BASE=0x00000000
 CONFIG_SYS_LOAD_ADDR=0x80008000
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index c8da5b4ce35..25b74e9b48e 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -8,6 +8,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x3000
 CONFIG_ENV_OFFSET=0xFFFFD000
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-lg-p880"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_LOAD_ADDR=0x82000000
diff --git a/configs/x530_defconfig b/configs/x530_defconfig
index 815370c90ec..1007785a182 100644
--- a/configs/x530_defconfig
+++ b/configs/x530_defconfig
@@ -14,6 +14,7 @@ CONFIG_ENV_OFFSET=0x100000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="armada-385-atl-x530"
 CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 7333413267e..ee7e809946e 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -5,6 +5,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index 820681d505b..dcadf33dbbf 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -5,6 +5,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index aad9c3f140b..766c55ceed9 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -5,6 +5,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index 628e0ed5be2..a5f8076bf4d 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -5,6 +5,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 9196a95e88a..3a204c1f8ca 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -9,6 +9,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="zynq-zc706"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SPL_STACK_R_ADDR=0x200000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x100000
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 1a6bd67afb8..ea780fb0c88 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -14,6 +14,7 @@ CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK_R_ADDR=0x18000000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffffc
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index c19f79f4d1d..6ea7f5c86d1 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -10,6 +10,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-emmc0"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffffc
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index 459e0294715..1207bd5ce81 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -10,6 +10,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-emmc1"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffffc
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index bb855f3b372..fa0ec48f9ba 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -9,6 +9,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe0000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-qspi"
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffffc
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_LOAD_ADDR=0x8000000
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index e5e56babf4c..fb4eb876642 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="zynqmp-zcu100-revC"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK_R_ADDR=0x18000000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffffc
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index 972e78fbe52..7b9e88b1d72 100644
--- a/configs/zynq_cse_nand_defconfig
+++ b/configs/zynq_cse_nand_defconfig
@@ -11,6 +11,7 @@ CONFIG_SYS_MALLOC_LEN=0x8000
 CONFIG_ENV_SIZE=0x190
 CONFIG_DEFAULT_DEVICE_TREE="zynq-cse-nand"
 CONFIG_SPL_STACK_R_ADDR=0x200000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index f3e23685157..3978e963ae4 100644
--- a/configs/zynq_cse_nor_defconfig
+++ b/configs/zynq_cse_nor_defconfig
@@ -11,6 +11,7 @@ CONFIG_SYS_MALLOC_LEN=0x1000
 CONFIG_ENV_SIZE=0x190
 CONFIG_DEFAULT_DEVICE_TREE="zynq-cse-nor"
 CONFIG_SPL_STACK_R_ADDR=0x200000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index 09dbf7ba5a6..8c4993ae5ae 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -12,6 +12,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x190
 CONFIG_DEFAULT_DEVICE_TREE="zynq-cse-qspi-single"
 CONFIG_SPL_STACK_R_ADDR=0x200000
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xfffffe00
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x20000
-- 
2.43.0

