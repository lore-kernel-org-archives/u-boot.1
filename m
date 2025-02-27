Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6DFC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA30B8141D;
	Thu, 27 Feb 2025 17:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ghjG070T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B02981430; Thu, 27 Feb 2025 17:28:32 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D59881113
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso1945197a91.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673708; x=1741278508; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6UkWZcawnp+BS4g3tis2A1xbM6jd1/Z1uMRet6DAPSE=;
 b=ghjG070Tev0JvqFQF4qgQyxCB3GncTX55ZfQ1nYTG9S2omE6GjjguCNGkvmFHChwxq
 UBg0QVw2zqk13k2o1qkoVKSb8ikixdhovBSfNMUg7UDGb3dXiZ3MW2zhEiv7zsUQt3MV
 gHSbF4piaCvec9F6er1HLUbiibolTCoOtXva8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673708; x=1741278508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6UkWZcawnp+BS4g3tis2A1xbM6jd1/Z1uMRet6DAPSE=;
 b=VE7MgvxWBdilX+Q1UfdZlIS7DICvTjCqVn0xEJTzYL26TBmpgsdL2+w41qJ2m4wduw
 4wIY+paufGiS4f/HzMFl0R7dzOAc1jbIa/gXIl2t31OoJVZCcNnmvSpOxkcPqzPO8chP
 5BxUeC6o1B9OnIjfGW+2TzydCDfcy1fp5bHpdozEykr4u6tC67ZuJrZ1d4422+gesFBQ
 WloBRTZJ1MfzgxCTFJfOupWFI7JKbH70tDriVAJ7pPXf9ujBicMj6O7vf3ebxWD4Z83S
 itq8GLJJ8ZjjkpleTgxQskjpnRKb5WNCCe0IsPtxETQJRXhg3CbzF9uAdVylihS4ZYgG
 ip6Q==
X-Gm-Message-State: AOJu0YwkqJMHXwqHL5mdTxaIPVl/Aun/aWpBMNWKGOV/n0eLndGpHw2r
 YaUdtnFzyXHCgf8GzC76ryK7pxbxlSzVT56Bq4fsp2WcZ757uczML6rPnlwN0xwY0s3z9E05aEa
 Nfb6l/opogsOrVZMpTmOsKipJm2Y+yfHmJP4O57xNYRpFn4I=
X-Gm-Gg: ASbGncsuY4VqqFm24sI1/tWf2hqO6OL65b4Blph9OauEc1o1Pu+rTlpt/DTkNfibkHK
 tMpFJTfsZ81lTBJYGCtdZNHqZtDjC7sjJ5W+oHNq8D+ZrCrHBDPlNirlj6wxWLKGbJb2w3Rn8xQ
 9ZpH/yYEo8
X-Google-Smtp-Source: AGHT+IFVhsDNBsW2J+4v3DTnSwuy7/TVsNPEDjIRrGBABi0vuGlMkkeoxgiICjfQUscj1ZxFW51qLbfXQnYp/4yPDYY=
X-Received: by 2002:a17:90b:3e83:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2fce7b04f5fmr40968836a91.28.1740673707895; Thu, 27 Feb 2025
 08:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-3-sjg@chromium.org>
 <af7605e4-7042-43a7-b742-621a286be275@kwiboo.se>
In-Reply-To: <af7605e4-7042-43a7-b742-621a286be275@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:27:24 -0700
X-Gm-Features: AQ5f1Jp-bX9jXdqLt32tgwntx6TpklRfgjGzqNMJ7JvzUuPMR9CA1o2f6EVhHNw
Message-ID: <CAFLszThbZJkNFG4HSnJ37e-uyQZ2RGJfmH8GnyeObtjXf-tK5g@mail.gmail.com>
Subject: Re: [PATCH v2 02/35] spl: Add an SPL_HAVE_INIT_STACK option
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonas,

On Mon, 17 Feb 2025 at 13:44, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 22:14, Simon Glass wrote:
> > At present there is a hex value SPL_STACK which both determines whether
> > SPL has its own initial stack and the hex value of that stack.
> >
> > Split off the former into SPL_HAVE_INIT_STACK with SPL_STACK depending
> > on that and only providing the latter.
>
> See remark on the name of the symbol in the preceding TPL patch.
>
> Also this and preceding patch should be split out into its own series.
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add new patch with an SPL_HAVE_INIT_STACK option
> >
> >  arch/arm/cpu/armv7/lowlevel_init.S            |  2 +-
> >  arch/arm/cpu/armv7/start.S                    |  2 +-
> >  arch/arm/lib/crt0.S                           |  2 +-
> >  arch/arm/lib/crt0_64.S                        |  2 +-
> >  arch/riscv/cpu/start.S                        |  2 +-
> >  common/spl/Kconfig                            | 28 +++++++++++++++----
> >  configs/alt_defconfig                         |  1 +
> >  configs/apalis-tk1_defconfig                  |  1 +
> >  configs/apalis_t30_defconfig                  |  1 +
> >  configs/axm_defconfig                         |  1 +
> >  configs/beaver_defconfig                      |  1 +
> >  configs/bitmain_antminer_s9_defconfig         |  1 +
> >  configs/capricorn_cxg3_defconfig              |  1 +
> >  configs/cardhu_defconfig                      |  1 +
> >  configs/cei-tk1-som_defconfig                 |  1 +
> >  configs/cgtqmx8_defconfig                     |  1 +
> >  configs/chromebit_mickey_defconfig            |  1 +
> >  configs/chromebook_bob_defconfig              |  1 +
> >  configs/chromebook_jerry_defconfig            |  1 +
> >  configs/chromebook_kevin_defconfig            |  1 +
> >  configs/chromebook_minnie_defconfig           |  1 +
> >  configs/chromebook_speedy_defconfig           |  1 +
> >  configs/ci20_mmc_defconfig                    |  1 +
> >  configs/clearfog_defconfig                    |  1 +
> >  configs/clearfog_sata_defconfig               |  1 +
> >  configs/clearfog_spi_defconfig                |  1 +
> >  configs/colibri_t20_defconfig                 |  1 +
> >  configs/colibri_t30_defconfig                 |  1 +
> >  configs/controlcenterdc_defconfig             |  1 +
> >  configs/corvus_defconfig                      |  1 +
> >  configs/da850evm_defconfig                    |  1 +
> >  configs/da850evm_nand_defconfig               |  1 +
> >  configs/dalmore_defconfig                     |  1 +
> >  configs/db-88f6720_defconfig                  |  1 +
> >  configs/db-88f6820-amc_defconfig              |  1 +
> >  configs/db-88f6820-amc_nand_defconfig         |  1 +
> >  configs/db-88f6820-gp_defconfig               |  1 +
> >  configs/db-mv784mp-gp_defconfig               |  1 +
> >  configs/ds116_defconfig                       |  1 +
> >  configs/ds414_defconfig                       |  1 +
> >  configs/endeavoru_defconfig                   |  1 +
> >  configs/evb-px5_defconfig                     |  1 +
> >  configs/evb-rk3036_defconfig                  |  1 +
> >  configs/evb-rk3288_defconfig                  |  1 +
> >  .../gardena-smart-gateway-at91sam_defconfig   |  1 +
> >  configs/gose_defconfig                        |  1 +
> >  configs/grouper_defconfig                     |  1 +
> >  configs/harmony_defconfig                     |  1 +
> >  configs/helios4_defconfig                     |  1 +
> >  configs/ideapad-yoga-11_defconfig             |  1 +
> >  configs/imx28_xea_defconfig                   |  1 +
> >  configs/imx8mm-cl-iot-gate-optee_defconfig    |  1 +
> >  configs/imx8mm-cl-iot-gate_defconfig          |  1 +
> >  configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |  1 +
> >  configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |  1 +
> >  configs/imx8mm-mx8menlo_defconfig             |  1 +
> >  configs/imx8mm-phygate-tauri-l_defconfig      |  1 +
> >  configs/imx8mm_beacon_defconfig               |  1 +
> >  configs/imx8mm_beacon_fspi_defconfig          |  1 +
> >  configs/imx8mm_data_modul_edm_sbc_defconfig   |  1 +
> >  configs/imx8mm_evk_defconfig                  |  1 +
> >  configs/imx8mm_evk_fspi_defconfig             |  1 +
> >  configs/imx8mm_phg_defconfig                  |  1 +
> >  configs/imx8mm_venice_defconfig               |  1 +
> >  configs/imx8mn_beacon_2g_defconfig            |  1 +
> >  configs/imx8mn_beacon_defconfig               |  1 +
> >  configs/imx8mn_beacon_fspi_defconfig          |  1 +
> >  configs/imx8mn_bsh_smm_s2_defconfig           |  1 +
> >  configs/imx8mn_bsh_smm_s2pro_defconfig        |  1 +
> >  configs/imx8mn_ddr4_evk_defconfig             |  1 +
> >  configs/imx8mn_evk_defconfig                  |  1 +
> >  configs/imx8mn_var_som_defconfig              |  1 +
> >  configs/imx8mn_venice_defconfig               |  1 +
> >  configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |  1 +
> >  configs/imx8mp_beacon_defconfig               |  1 +
> >  configs/imx8mp_data_modul_edm_sbc_defconfig   |  1 +
> >  configs/imx8mp_debix_model_a_defconfig        |  1 +
> >  configs/imx8mp_dhsom.config                   |  1 +
> >  configs/imx8mp_evk_defconfig                  |  1 +
> >  configs/imx8mp_navqp_defconfig                |  1 +
> >  configs/imx8mp_rsb3720a1_4G_defconfig         |  1 +
> >  configs/imx8mp_rsb3720a1_6G_defconfig         |  1 +
> >  configs/imx8mp_venice_defconfig               |  1 +
> >  configs/imx8mq_cm_defconfig                   |  1 +
> >  configs/imx8mq_evk_defconfig                  |  1 +
> >  configs/imx8mq_phanbell_defconfig             |  1 +
> >  configs/imx8mq_reform2_defconfig              |  1 +
> >  configs/imx8qm_dmsse20a1_defconfig            |  1 +
> >  configs/imx8qm_mek_defconfig                  |  1 +
> >  configs/imx8qxp_mek_defconfig                 |  1 +
> >  configs/imx8ulp_evk_defconfig                 |  1 +
> >  configs/imx93-phycore_defconfig               |  1 +
> >  configs/imx93_11x11_evk_defconfig             |  1 +
> >  configs/imx93_9x9_qsb_defconfig               |  1 +
> >  configs/imx93_9x9_qsb_inline_ecc_defconfig    |  1 +
> >  configs/imx93_var_som_defconfig               |  1 +
> >  configs/jetson-tk1_defconfig                  |  1 +
> >  configs/k2e_evm_defconfig                     |  1 +
> >  configs/k2g_evm_defconfig                     |  1 +
> >  configs/k2hk_evm_defconfig                    |  1 +
> >  configs/k2l_evm_defconfig                     |  1 +
> >  configs/koelsch_defconfig                     |  1 +
> >  configs/kontron-sl-mx8mm_defconfig            |  1 +
> >  configs/kontron_pitx_imx8m_defconfig          |  1 +
> >  configs/kontron_sl28_defconfig                |  1 +
> >  configs/kylin-rk3036_defconfig                |  1 +
> >  configs/lager_defconfig                       |  1 +
> >  configs/librem5_defconfig                     |  1 +
> >  configs/ls1021aiot_sdcard_defconfig           |  1 +
> >  configs/ls1021aqds_nand_defconfig             |  1 +
> >  configs/ls1021aqds_sdcard_ifc_defconfig       |  1 +
> >  configs/ls1021aqds_sdcard_qspi_defconfig      |  1 +
> >  configs/ls1021atsn_sdcard_defconfig           |  1 +
> >  ...s1021atwr_sdcard_ifc_SECURE_BOOT_defconfig |  1 +
> >  configs/ls1021atwr_sdcard_ifc_defconfig       |  1 +
> >  configs/ls1021atwr_sdcard_qspi_defconfig      |  1 +
> >  configs/ls2080aqds_nand_defconfig             |  1 +
> >  configs/ls2080ardb_nand_defconfig             |  1 +
> >  configs/m53menlo_defconfig                    |  1 +
> >  configs/maxbcm_defconfig                      |  1 +
> >  configs/medcom-wide_defconfig                 |  1 +
> >  configs/microblaze-generic_defconfig          |  1 +
> >  configs/mk808_defconfig                       |  1 +
> >  configs/msc_sm2s_imx8mp_defconfig             |  1 +
> >  configs/mt7629_rfb_defconfig                  |  1 +
> >  configs/n2350_defconfig                       |  1 +
> >  configs/nyan-big_defconfig                    |  1 +
> >  configs/omapl138_lcdk_defconfig               |  1 +
> >  configs/openpiton_riscv64_spl_defconfig       |  1 +
> >  configs/paz00_defconfig                       |  1 +
> >  configs/phycore-imx8mm_defconfig              |  1 +
> >  configs/phycore-imx8mp_defconfig              |  1 +
> >  configs/phycore-rk3288_defconfig              |  1 +
> >  configs/pico-imx8mq_defconfig                 |  1 +
> >  configs/plutux_defconfig                      |  1 +
> >  configs/popmetal-rk3288_defconfig             |  1 +
> >  configs/porter_defconfig                      |  1 +
> >  configs/qc750_defconfig                       |  1 +
> >  configs/r8a77970_eagle_defconfig              |  1 +
> >  configs/r8a77970_v3msk_defconfig              |  1 +
> >  configs/r8a77980_condor_defconfig             |  1 +
> >  configs/r8a77980_v3hsk_defconfig              |  1 +
> >  configs/r8a77990_ebisu_defconfig              |  1 +
> >  configs/r8a77995_draak_defconfig              |  1 +
> >  configs/rcar3_salvator-x_defconfig            |  1 +
> >  configs/rcar3_ulcb_defconfig                  |  1 +
> >  configs/rock-pi-n8-rk3288_defconfig           |  1 +
> >  configs/rock2_defconfig                       |  1 +
> >  configs/rock_defconfig                        |  1 +
> >  configs/sama5d27_giantboard_defconfig         |  1 +
> >  configs/sama5d27_som1_ek_mmc1_defconfig       |  1 +
> >  configs/sama5d27_som1_ek_mmc_defconfig        |  1 +
> >  configs/sama5d27_som1_ek_qspiflash_defconfig  |  1 +
> >  configs/sama5d27_wlsom1_ek_mmc_defconfig      |  1 +
> >  .../sama5d27_wlsom1_ek_qspiflash_defconfig    |  1 +
> >  configs/sama5d2_icp_mmc_defconfig             |  1 +
> >  configs/sama5d2_xplained_emmc_defconfig       |  1 +
> >  configs/sama5d2_xplained_mmc_defconfig        |  1 +
> >  configs/sama5d2_xplained_qspiflash_defconfig  |  1 +
> >  configs/sama5d2_xplained_spiflash_defconfig   |  1 +
> >  configs/sama5d3_xplained_mmc_defconfig        |  1 +
> >  configs/sama5d3_xplained_nandflash_defconfig  |  1 +
> >  configs/sama5d3xek_mmc_defconfig              |  1 +
> >  configs/sama5d3xek_nandflash_defconfig        |  1 +
> >  configs/sama5d3xek_spiflash_defconfig         |  1 +
> >  configs/sama5d4_xplained_mmc_defconfig        |  1 +
> >  configs/sama5d4_xplained_nandflash_defconfig  |  1 +
> >  configs/sama5d4_xplained_spiflash_defconfig   |  1 +
> >  configs/sama5d4ek_mmc_defconfig               |  1 +
> >  configs/sama5d4ek_nandflash_defconfig         |  1 +
> >  configs/sama5d4ek_spiflash_defconfig          |  1 +
> >  configs/seaboard_defconfig                    |  1 +
> >  configs/sifive_unleashed_defconfig            |  1 +
> >  configs/sifive_unmatched_defconfig            |  1 +
> >  configs/silinux_ek874_defconfig               |  1 +
> >  configs/silk_defconfig                        |  1 +
> >  configs/smartweb_defconfig                    |  1 +
> >  configs/socfpga_agilex5_defconfig             |  1 +
> >  configs/socfpga_agilex_atf_defconfig          |  1 +
> >  configs/socfpga_agilex_defconfig              |  1 +
> >  configs/socfpga_agilex_vab_defconfig          |  1 +
> >  configs/socfpga_arria10_defconfig             |  1 +
> >  configs/socfpga_arria5_defconfig              |  1 +
> >  configs/socfpga_cyclone5_defconfig            |  1 +
> >  configs/socfpga_dbm_soc1_defconfig            |  1 +
> >  configs/socfpga_de0_nano_soc_defconfig        |  1 +
> >  configs/socfpga_de10_nano_defconfig           |  1 +
> >  configs/socfpga_de10_standard_defconfig       |  1 +
> >  configs/socfpga_de1_soc_defconfig             |  1 +
> >  configs/socfpga_is1_defconfig                 |  1 +
> >  configs/socfpga_mcvevk_defconfig              |  1 +
> >  configs/socfpga_n5x_atf_defconfig             |  1 +
> >  configs/socfpga_n5x_defconfig                 |  1 +
> >  configs/socfpga_n5x_vab_defconfig             |  1 +
> >  configs/socfpga_secu1_defconfig               |  1 +
> >  configs/socfpga_sockit_defconfig              |  1 +
> >  configs/socfpga_socrates_defconfig            |  1 +
> >  configs/socfpga_sr1500_defconfig              |  1 +
> >  configs/socfpga_stratix10_atf_defconfig       |  1 +
> >  configs/socfpga_stratix10_defconfig           |  1 +
> >  configs/socfpga_vining_fpga_defconfig         |  1 +
> >  configs/starfive_visionfive2_defconfig        |  1 +
> >  ...stm32mp15-icore-stm32mp1-ctouch2_defconfig |  1 +
> >  ...tm32mp15-icore-stm32mp1-edimm2.2_defconfig |  1 +
> >  ...-microgea-stm32mp1-microdev2-of7_defconfig |  1 +
> >  ...mp15-microgea-stm32mp1-microdev2_defconfig |  1 +
> >  configs/stm32mp15_basic_defconfig             |  1 +
> >  configs/stm32mp15_dhsom.config                |  1 +
> >  configs/stout_defconfig                       |  1 +
> >  configs/surface-rt_defconfig                  |  1 +
> >  configs/syzygy_hub_defconfig                  |  1 +
> >  configs/taurus_defconfig                      |  1 +
> >  configs/tec-ng_defconfig                      |  1 +
> >  configs/tec_defconfig                         |  1 +
> >  configs/theadorable_debug_defconfig           |  1 +
> >  configs/topic_miami_defconfig                 |  1 +
> >  configs/topic_miamilite_defconfig             |  1 +
> >  configs/topic_miamiplus_defconfig             |  1 +
> >  configs/transformer_t20_defconfig             |  1 +
> >  configs/transformer_t30_defconfig             |  1 +
> >  configs/trimslice_defconfig                   |  1 +
> >  configs/turris_omnia_defconfig                |  1 +
> >  configs/uniphier_ld4_sld8_defconfig           |  1 +
> >  configs/uniphier_v7_defconfig                 |  1 +
> >  configs/venice2_defconfig                     |  1 +
> >  configs/ventana_defconfig                     |  1 +
> >  configs/verdin-imx8mm_defconfig               |  1 +
> >  configs/verdin-imx8mp_defconfig               |  1 +
> >  configs/vyasa-rk3288_defconfig                |  1 +
> >  configs/work_92105_defconfig                  |  1 +
> >  configs/x3_t30_defconfig                      |  1 +
> >  configs/x530_defconfig                        |  1 +
> >  configs/xilinx_mbv32_defconfig                |  1 +
> >  configs/xilinx_mbv32_smode_defconfig          |  1 +
> >  configs/xilinx_mbv64_defconfig                |  1 +
> >  configs/xilinx_mbv64_smode_defconfig          |  1 +
> >  configs/xilinx_zynq_virt_defconfig            |  1 +
> >  configs/xilinx_zynqmp_kria_defconfig          |  1 +
> >  configs/xilinx_zynqmp_mini_emmc0_defconfig    |  1 +
> >  configs/xilinx_zynqmp_mini_emmc1_defconfig    |  1 +
> >  configs/xilinx_zynqmp_mini_qspi_defconfig     |  1 +
> >  configs/xilinx_zynqmp_virt_defconfig          |  1 +
> >  configs/zynq_cse_nand_defconfig               |  1 +
> >  configs/zynq_cse_nor_defconfig                |  1 +
> >  configs/zynq_cse_qspi_defconfig               |  1 +
> >  245 files changed, 267 insertions(+), 10 deletions(-)
>
> This does not seem to apply on top of master or next.

Yes unfortunately I have my own tree for the moment as too many of my
efforts have been blocked. If we get this through review then I can
send a rebased series or PR to Tom. If you want to try out a tree, see
vbh3 and vbi3

>
> Please do not introduce mass changes in a series targeting a different
> topic, instead send it as its own series and link and mention it in the
> cover letter if it's needed for a clean apply.

OK, well I am 8 series in at this point, so another couple won't make
too much difference.

Regards,
Simon
