Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A46E7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFB1586D90;
	Tue, 26 Sep 2023 16:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XKZDu18o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EAEC86DEC; Tue, 26 Sep 2023 16:15:35 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4F086D4F
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-351365e47f6so15228565ab.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737724; x=1696342524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sA20BCK1xOvjPgVXsu6/p5u99zmr5Cjzt14cP0djL98=;
 b=XKZDu18ofVQVRIPBLDVxlFUqnqYmUmXLyv/RfpmwjWG6mLK34t4zIACg1AimeZJrul
 uQJYbUqrBWekK3fyCd6E5oSHGFTDR4FQdnLv7hLYcoeaLakrUj0DQKlJEagkqVLsnZZn
 kt813a1elo6vlbyryhIY9brag9YpmErEQCFt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737724; x=1696342524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sA20BCK1xOvjPgVXsu6/p5u99zmr5Cjzt14cP0djL98=;
 b=Z3va5R5GFP+ub2MwWiDgpfGJfso9nmREAorSX5Q8lEMn6bh8II6vH8CghsqNn42pax
 GcwyhKY0fNesFRYLQ+tqgimu6nwOh5c3TRj1sPamtXuYQH845XfJU+w8PHf9gXW6SDQ2
 q1tf0lBcxDFFQITvmI15gSv9ilDbzS3c38RNdGSjLso08B4LvKKKoin4aqzWbpqYgvb4
 4D68cfeDIRziPlFSgiNhdpF2t6L+bvRCy8DrCxq7Hc9FdfNMpyz+3gLz1ls+wwEu8/V6
 e5QCeYGlwTgiXCob6DWmeVWTa8cEUCSaeJbJ/IWE9zgHfxi62JK3KrtUmW0pPc6LaRuI
 LiBQ==
X-Gm-Message-State: AOJu0YxZweuyx0ITzuiNqEWNqHp19hXm8fty19y6Z6HWozmaVKYlXwGo
 N6xe8v4srk+ZLoQLSauqON7YO99abk2VhEYHwVY=
X-Google-Smtp-Source: AGHT+IEEwnjOJGMszl72YPlF2TmtnCbaJqj05ljiLhZhJRksolgfxTsO+sw99Irytd2o8S2CILs/Lg==
X-Received: by 2002:a92:1a08:0:b0:351:4f0c:b95d with SMTP id
 a8-20020a921a08000000b003514f0cb95dmr3163474ila.22.1695737723070; 
 Tue, 26 Sep 2023 07:15:23 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 01/44] configs: Resync with savedefconfig
Date: Tue, 26 Sep 2023 08:14:15 -0600
Message-ID: <20230926141514.2101787-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 Sep 2023 16:16:12 +0200
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

Rsync all defconfig files using moveconfig.py

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/10m50_defconfig                               |  2 +-
 configs/3c120_defconfig                               |  2 +-
 configs/CMPC885_defconfig                             |  2 +-
 configs/CMPCPRO_defconfig                             |  4 ++--
 configs/MCR3000_defconfig                             |  4 ++--
 configs/MPC837XERDB_defconfig                         |  2 +-
 configs/MPC8548CDS_36BIT_defconfig                    |  4 ++--
 configs/MPC8548CDS_defconfig                          |  4 ++--
 configs/MPC8548CDS_legacy_defconfig                   |  4 ++--
 configs/P1010RDB-PA_36BIT_NAND_defconfig              |  4 ++--
 configs/P1010RDB-PA_36BIT_NOR_defconfig               |  4 ++--
 configs/P1010RDB-PA_36BIT_SDCARD_defconfig            |  4 ++--
 configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig          |  4 ++--
 configs/P1010RDB-PA_NAND_defconfig                    |  4 ++--
 configs/P1010RDB-PA_NOR_defconfig                     |  4 ++--
 configs/P1010RDB-PA_SDCARD_defconfig                  |  4 ++--
 configs/P1010RDB-PA_SPIFLASH_defconfig                |  4 ++--
 configs/P1010RDB-PB_36BIT_NAND_defconfig              |  4 ++--
 configs/P1010RDB-PB_36BIT_NOR_defconfig               |  4 ++--
 configs/P1010RDB-PB_36BIT_SDCARD_defconfig            |  4 ++--
 configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig          |  4 ++--
 configs/P1010RDB-PB_NAND_defconfig                    |  4 ++--
 configs/P1010RDB-PB_NOR_defconfig                     |  4 ++--
 configs/P1010RDB-PB_SDCARD_defconfig                  |  4 ++--
 configs/P1010RDB-PB_SPIFLASH_defconfig                |  4 ++--
 configs/P1020RDB-PC_36BIT_NAND_defconfig              |  4 ++--
 configs/P1020RDB-PC_36BIT_SDCARD_defconfig            |  6 +++---
 configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig          |  6 +++---
 configs/P1020RDB-PC_36BIT_defconfig                   |  4 ++--
 configs/P1020RDB-PC_NAND_defconfig                    |  4 ++--
 configs/P1020RDB-PC_SDCARD_defconfig                  |  6 +++---
 configs/P1020RDB-PC_SPIFLASH_defconfig                |  6 +++---
 configs/P1020RDB-PC_defconfig                         |  4 ++--
 configs/P1020RDB-PD_NAND_defconfig                    |  4 ++--
 configs/P1020RDB-PD_SDCARD_defconfig                  |  6 +++---
 configs/P1020RDB-PD_SPIFLASH_defconfig                |  6 +++---
 configs/P1020RDB-PD_defconfig                         |  4 ++--
 configs/P2020RDB-PC_36BIT_NAND_defconfig              |  4 ++--
 configs/P2020RDB-PC_36BIT_SDCARD_defconfig            |  6 +++---
 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig          |  6 +++---
 configs/P2020RDB-PC_36BIT_defconfig                   |  4 ++--
 configs/P2020RDB-PC_NAND_defconfig                    |  4 ++--
 configs/P2020RDB-PC_SDCARD_defconfig                  |  6 +++---
 configs/P2020RDB-PC_SPIFLASH_defconfig                |  6 +++---
 configs/P2020RDB-PC_defconfig                         |  4 ++--
 configs/P2041RDB_NAND_defconfig                       |  6 +++---
 configs/P2041RDB_SDCARD_defconfig                     |  6 +++---
 configs/P2041RDB_SPIFLASH_defconfig                   |  6 +++---
 configs/P2041RDB_defconfig                            |  4 ++--
 configs/T1024RDB_NAND_defconfig                       |  4 ++--
 configs/T1024RDB_SDCARD_defconfig                     |  4 ++--
 configs/T1024RDB_SPIFLASH_defconfig                   |  4 ++--
 configs/T1024RDB_defconfig                            |  2 +-
 configs/T1042D4RDB_NAND_defconfig                     |  4 ++--
 configs/T1042D4RDB_SDCARD_defconfig                   |  4 ++--
 configs/T1042D4RDB_SPIFLASH_defconfig                 |  4 ++--
 configs/T1042D4RDB_defconfig                          |  2 +-
 configs/T2080QDS_NAND_defconfig                       |  6 +++---
 configs/T2080QDS_SDCARD_defconfig                     |  6 +++---
 configs/T2080QDS_SECURE_BOOT_defconfig                |  4 ++--
 configs/T2080QDS_SPIFLASH_defconfig                   |  6 +++---
 configs/T2080QDS_SRIO_PCIE_BOOT_defconfig             |  4 ++--
 configs/T2080QDS_defconfig                            |  4 ++--
 configs/T2080RDB_NAND_defconfig                       |  4 ++--
 configs/T2080RDB_SDCARD_defconfig                     |  4 ++--
 configs/T2080RDB_SPIFLASH_defconfig                   |  4 ++--
 configs/T2080RDB_defconfig                            |  2 +-
 configs/T2080RDB_revD_NAND_defconfig                  |  4 ++--
 configs/T2080RDB_revD_SDCARD_defconfig                |  4 ++--
 configs/T2080RDB_revD_SPIFLASH_defconfig              |  4 ++--
 configs/T2080RDB_revD_defconfig                       |  2 +-
 configs/T4240RDB_SDCARD_defconfig                     |  4 ++--
 configs/T4240RDB_defconfig                            |  2 +-
 configs/ae350_rv32_defconfig                          |  2 +-
 configs/ae350_rv32_spl_defconfig                      |  2 +-
 configs/ae350_rv32_spl_xip_defconfig                  |  2 +-
 configs/ae350_rv32_xip_defconfig                      |  2 +-
 configs/ae350_rv64_defconfig                          |  2 +-
 configs/ae350_rv64_spl_defconfig                      |  2 +-
 configs/ae350_rv64_spl_xip_defconfig                  |  2 +-
 configs/ae350_rv64_xip_defconfig                      |  2 +-
 configs/am335x_baltos_defconfig                       |  2 +-
 configs/am335x_evm_defconfig                          |  2 +-
 configs/am335x_evm_spiboot_defconfig                  |  2 +-
 configs/am335x_hs_evm_defconfig                       |  2 +-
 configs/am335x_hs_evm_uart_defconfig                  |  2 +-
 configs/am335x_igep003x_defconfig                     |  4 ++--
 configs/am43xx_hs_evm_defconfig                       |  2 +-
 configs/am57xx_evm_defconfig                          |  2 +-
 configs/am57xx_hs_evm_defconfig                       |  2 +-
 configs/am57xx_hs_evm_usb_defconfig                   |  3 +--
 configs/am65x_evm_a53_defconfig                       |  2 +-
 configs/am65x_hs_evm_a53_defconfig                    |  2 +-
 configs/apalis-imx8_defconfig                         |  2 +-
 configs/apalis-tk1_defconfig                          |  2 +-
 configs/bayleybay_defconfig                           |  1 -
 configs/bcmns_defconfig                               |  4 ++--
 configs/boston32r2_defconfig                          |  2 +-
 configs/boston32r2el_defconfig                        |  2 +-
 configs/boston32r6_defconfig                          |  2 +-
 configs/boston32r6el_defconfig                        |  2 +-
 configs/boston64r2_defconfig                          |  2 +-
 configs/boston64r2el_defconfig                        |  2 +-
 configs/boston64r6_defconfig                          |  2 +-
 configs/boston64r6el_defconfig                        |  2 +-
 configs/brppt1_mmc_defconfig                          |  2 +-
 configs/brppt2_defconfig                              |  2 +-
 configs/brsmarc1_defconfig                            |  2 +-
 configs/brxre1_defconfig                              |  2 +-
 configs/cgtqmx8_defconfig                             |  2 +-
 configs/cherryhill_defconfig                          |  1 -
 configs/chromebook_coral_defconfig                    |  3 +--
 configs/chromebook_link_defconfig                     |  1 -
 configs/chromebook_samus_defconfig                    |  1 -
 configs/chromebook_samus_tpl_defconfig                |  6 ++----
 configs/chromebox_panther_defconfig                   |  1 -
 configs/cm_fx6_defconfig                              |  4 ++--
 configs/colibri-imx8x_defconfig                       |  2 +-
 configs/colibri_vf_defconfig                          |  2 +-
 .../conga-qeval20-qa3-e3845-internal-uart_defconfig   |  1 -
 configs/conga-qeval20-qa3-e3845_defconfig             |  1 -
 configs/coreboot64_defconfig                          |  2 +-
 configs/coreboot_defconfig                            |  2 +-
 configs/cortina_presidio-asic-emmc_defconfig          |  1 -
 configs/cougarcanyon2_defconfig                       |  1 -
 configs/crownbay_defconfig                            |  1 -
 configs/deneb_defconfig                               |  4 ++--
 configs/dfi-bt700-q7x-151_defconfig                   |  1 -
 configs/display5_factory_defconfig                    |  2 +-
 configs/dra7xx_evm_defconfig                          |  2 +-
 configs/dra7xx_hs_evm_defconfig                       |  2 +-
 configs/dra7xx_hs_evm_usb_defconfig                   |  2 +-
 configs/dragonboard410c_defconfig                     |  2 +-
 configs/durian_defconfig                              |  1 -
 configs/ea-lpc3250devkitv2_defconfig                  |  2 +-
 configs/efi-x86_payload32_defconfig                   |  1 -
 configs/efi-x86_payload64_defconfig                   |  2 --
 configs/endeavoru_defconfig                           |  6 ++----
 configs/galileo_defconfig                             |  1 -
 configs/gardena-smart-gateway-mt7688_defconfig        |  2 +-
 configs/gazerbeam_defconfig                           |  4 ++--
 configs/ge_b1x5v2_defconfig                           |  2 +-
 configs/ge_bx50v3_defconfig                           |  2 +-
 configs/giedi_defconfig                               |  4 ++--
 configs/grouper_common_defconfig                      |  6 ++----
 configs/gwventana_emmc_defconfig                      |  4 ++--
 configs/gwventana_nand_defconfig                      |  4 ++--
 configs/highbank_defconfig                            |  2 +-
 configs/igep00x0_defconfig                            |  4 ++--
 configs/imx28_xea_defconfig                           |  2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig            |  2 +-
 configs/imx8mm-cl-iot-gate_defconfig                  |  2 +-
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig          |  2 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig         |  2 +-
 configs/imx8mm-mx8menlo_defconfig                     |  2 +-
 configs/imx8mm_evk_defconfig                          |  2 +-
 configs/imx8mm_evk_fspi_defconfig                     |  2 +-
 configs/imx8mm_phg_defconfig                          |  2 +-
 configs/imx8mm_venice_defconfig                       |  2 +-
 configs/imx8mn_bsh_smm_s2_defconfig                   |  2 +-
 configs/imx8mn_bsh_smm_s2pro_defconfig                |  2 +-
 configs/imx8mn_ddr4_evk_defconfig                     |  2 +-
 configs/imx8mn_evk_defconfig                          |  2 +-
 configs/imx8mn_var_som_defconfig                      |  2 +-
 configs/imx8mn_venice_defconfig                       |  2 +-
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig         |  2 +-
 configs/imx8mp_beacon_defconfig                       |  2 +-
 configs/imx8mp_evk_defconfig                          |  2 +-
 configs/imx8mp_rsb3720a1_4G_defconfig                 |  2 +-
 configs/imx8mp_rsb3720a1_6G_defconfig                 |  2 +-
 configs/imx8mp_venice_defconfig                       |  2 +-
 configs/imx8mq_cm_defconfig                           |  2 +-
 configs/imx8mq_evk_defconfig                          |  2 +-
 configs/imx8mq_phanbell_defconfig                     |  2 +-
 configs/imx8mq_reform2_defconfig                      |  2 +-
 configs/imx8qm_dmsse20a1_defconfig                    |  2 +-
 configs/imx8qm_mek_defconfig                          |  2 +-
 configs/imx8qxp_mek_defconfig                         |  2 +-
 configs/iot2050_defconfig                             |  4 ++--
 configs/j7200_evm_a72_defconfig                       |  2 +-
 configs/j721e_evm_a72_defconfig                       |  2 +-
 configs/j721s2_evm_a72_defconfig                      |  2 +-
 configs/k2e_evm_defconfig                             |  2 +-
 configs/k2e_hs_evm_defconfig                          |  2 +-
 configs/k2g_evm_defconfig                             |  2 +-
 configs/k2g_hs_evm_defconfig                          |  2 +-
 configs/k2hk_evm_defconfig                            |  2 +-
 configs/k2hk_hs_evm_defconfig                         |  2 +-
 configs/k2l_evm_defconfig                             |  2 +-
 configs/kmcent2_defconfig                             |  2 +-
 configs/kmcoge5ne_defconfig                           |  4 ++--
 configs/kmeter1_defconfig                             |  4 ++--
 configs/kmopti2_defconfig                             |  4 ++--
 configs/kmsupx5_defconfig                             |  4 ++--
 configs/kmtepr2_defconfig                             |  4 ++--
 configs/kontron-sl-mx6ul_defconfig                    |  4 ++--
 configs/kontron-sl-mx8mm_defconfig                    |  2 +-
 configs/kontron_pitx_imx8m_defconfig                  |  2 +-
 configs/kontron_sl28_defconfig                        |  4 ++--
 configs/librem5_defconfig                             |  2 +-
 configs/ls1012a2g5rdb_qspi_defconfig                  |  4 ++--
 configs/ls1012a2g5rdb_tfa_defconfig                   |  4 ++--
 configs/ls1012afrdm_qspi_defconfig                    |  4 ++--
 configs/ls1012afrdm_tfa_defconfig                     |  4 ++--
 configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig        |  4 ++--
 configs/ls1012afrwy_qspi_defconfig                    |  4 ++--
 configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig         |  4 ++--
 configs/ls1012afrwy_tfa_defconfig                     |  4 ++--
 configs/ls1012aqds_qspi_defconfig                     |  4 ++--
 configs/ls1012aqds_tfa_SECURE_BOOT_defconfig          |  4 ++--
 configs/ls1012aqds_tfa_defconfig                      |  4 ++--
 configs/ls1012ardb_qspi_SECURE_BOOT_defconfig         |  4 ++--
 configs/ls1012ardb_qspi_defconfig                     |  4 ++--
 configs/ls1012ardb_tfa_SECURE_BOOT_defconfig          |  4 ++--
 configs/ls1012ardb_tfa_defconfig                      |  4 ++--
 configs/ls1021aiot_qspi_defconfig                     |  2 +-
 configs/ls1021aiot_sdcard_defconfig                   |  4 ++--
 configs/ls1021aqds_ddr4_nor_defconfig                 |  4 ++--
 configs/ls1021aqds_ddr4_nor_lpuart_defconfig          |  4 ++--
 configs/ls1021aqds_nand_defconfig                     |  6 +++---
 configs/ls1021aqds_nor_SECURE_BOOT_defconfig          |  4 ++--
 configs/ls1021aqds_nor_defconfig                      |  4 ++--
 configs/ls1021aqds_nor_lpuart_defconfig               |  4 ++--
 configs/ls1021aqds_qspi_defconfig                     |  4 ++--
 configs/ls1021aqds_sdcard_ifc_defconfig               |  2 +-
 configs/ls1021atsn_qspi_defconfig                     |  4 ++--
 configs/ls1021atsn_sdcard_defconfig                   |  4 ++--
 configs/ls1021atwr_nor_SECURE_BOOT_defconfig          |  4 ++--
 configs/ls1021atwr_nor_defconfig                      |  4 ++--
 configs/ls1021atwr_nor_lpuart_defconfig               |  4 ++--
 configs/ls1021atwr_qspi_defconfig                     |  4 ++--
 configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig   |  4 ++--
 configs/ls1021atwr_sdcard_ifc_defconfig               |  4 ++--
 configs/ls1021atwr_sdcard_qspi_defconfig              |  4 ++--
 configs/ls1028aqds_tfa_SECURE_BOOT_defconfig          |  4 ++--
 configs/ls1028aqds_tfa_defconfig                      |  4 ++--
 configs/ls1028aqds_tfa_lpuart_defconfig               |  4 ++--
 configs/ls1028ardb_tfa_SECURE_BOOT_defconfig          |  4 ++--
 configs/ls1028ardb_tfa_defconfig                      |  4 ++--
 configs/ls1043aqds_defconfig                          |  4 ++--
 configs/ls1043aqds_lpuart_defconfig                   |  4 ++--
 configs/ls1043aqds_nand_defconfig                     |  4 ++--
 configs/ls1043aqds_nor_ddr3_defconfig                 |  4 ++--
 configs/ls1043aqds_qspi_defconfig                     |  4 ++--
 configs/ls1043aqds_sdcard_ifc_defconfig               |  4 ++--
 configs/ls1043aqds_sdcard_qspi_defconfig              |  4 ++--
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig          |  4 ++--
 configs/ls1043aqds_tfa_defconfig                      |  4 ++--
 configs/ls1043ardb_SECURE_BOOT_defconfig              |  2 +-
 configs/ls1043ardb_defconfig                          |  2 +-
 configs/ls1043ardb_nand_SECURE_BOOT_defconfig         |  2 +-
 configs/ls1043ardb_nand_defconfig                     |  2 +-
 configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig       |  2 +-
 configs/ls1043ardb_sdcard_defconfig                   |  2 +-
 configs/ls1043ardb_tfa_SECURE_BOOT_defconfig          |  2 +-
 configs/ls1043ardb_tfa_defconfig                      |  2 +-
 configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig         |  2 +-
 configs/ls1046afrwy_tfa_defconfig                     |  2 +-
 configs/ls1046aqds_SECURE_BOOT_defconfig              |  4 ++--
 configs/ls1046aqds_defconfig                          |  4 ++--
 configs/ls1046aqds_lpuart_defconfig                   |  4 ++--
 configs/ls1046aqds_nand_defconfig                     |  4 ++--
 configs/ls1046aqds_qspi_defconfig                     |  4 ++--
 configs/ls1046aqds_sdcard_ifc_defconfig               |  4 ++--
 configs/ls1046aqds_sdcard_qspi_defconfig              |  4 ++--
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig          |  4 ++--
 configs/ls1046aqds_tfa_defconfig                      |  4 ++--
 configs/ls1046ardb_emmc_defconfig                     |  2 +-
 configs/ls1046ardb_qspi_SECURE_BOOT_defconfig         |  2 +-
 configs/ls1046ardb_qspi_defconfig                     |  2 +-
 configs/ls1046ardb_qspi_spl_defconfig                 |  2 +-
 configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig       |  2 +-
 configs/ls1046ardb_sdcard_defconfig                   |  2 +-
 configs/ls1046ardb_tfa_SECURE_BOOT_defconfig          |  2 +-
 configs/ls1046ardb_tfa_defconfig                      |  2 +-
 configs/ls1088aqds_defconfig                          |  2 +-
 configs/ls1088aqds_qspi_SECURE_BOOT_defconfig         |  4 ++--
 configs/ls1088aqds_qspi_defconfig                     |  4 ++--
 configs/ls1088aqds_sdcard_ifc_defconfig               |  2 +-
 configs/ls1088aqds_sdcard_qspi_defconfig              |  2 +-
 configs/ls1088aqds_tfa_defconfig                      |  4 ++--
 configs/ls1088ardb_qspi_SECURE_BOOT_defconfig         |  4 ++--
 configs/ls1088ardb_qspi_defconfig                     |  4 ++--
 configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig  |  2 +-
 configs/ls1088ardb_sdcard_qspi_defconfig              |  2 +-
 configs/ls1088ardb_tfa_SECURE_BOOT_defconfig          |  2 +-
 configs/ls1088ardb_tfa_defconfig                      |  2 +-
 configs/ls2080aqds_SECURE_BOOT_defconfig              |  4 ++--
 configs/ls2080aqds_defconfig                          |  4 ++--
 configs/ls2080aqds_nand_defconfig                     |  6 +++---
 configs/ls2080aqds_qspi_defconfig                     |  6 +++---
 configs/ls2080aqds_sdcard_defconfig                   |  6 +++---
 configs/ls2080ardb_SECURE_BOOT_defconfig              |  4 ++--
 configs/ls2080ardb_defconfig                          |  4 ++--
 configs/ls2080ardb_nand_defconfig                     |  6 +++---
 configs/ls2081ardb_defconfig                          |  6 +++---
 configs/ls2088aqds_tfa_defconfig                      |  4 ++--
 configs/ls2088ardb_qspi_SECURE_BOOT_defconfig         |  6 +++---
 configs/ls2088ardb_qspi_defconfig                     |  6 +++---
 configs/ls2088ardb_tfa_SECURE_BOOT_defconfig          |  4 ++--
 configs/ls2088ardb_tfa_defconfig                      |  4 ++--
 configs/lx2160aqds_tfa_SECURE_BOOT_defconfig          |  2 +-
 configs/lx2160aqds_tfa_defconfig                      |  4 ++--
 configs/lx2160ardb_tfa_SECURE_BOOT_defconfig          |  2 +-
 configs/lx2160ardb_tfa_defconfig                      |  4 ++--
 configs/lx2160ardb_tfa_stmm_defconfig                 |  4 ++--
 configs/lx2162aqds_tfa_SECURE_BOOT_defconfig          |  2 +-
 configs/lx2162aqds_tfa_defconfig                      |  4 ++--
 configs/lx2162aqds_tfa_verified_boot_defconfig        |  4 ++--
 configs/m53menlo_defconfig                            |  2 +-
 configs/minnowmax_defconfig                           |  1 -
 configs/msc_sm2s_imx8mp_defconfig                     |  2 +-
 configs/mvebu_espressobin-88f3720_defconfig           |  3 +--
 configs/mx53ppd_defconfig                             |  2 +-
 configs/mx6cuboxi_defconfig                           |  2 +-
 configs/nyan-big_defconfig                            |  2 +-
 configs/octeontx2_95xx_defconfig                      |  3 +--
 configs/octeontx2_96xx_defconfig                      |  3 +--
 configs/octeontx_81xx_defconfig                       |  2 +-
 configs/octeontx_83xx_defconfig                       |  2 +-
 configs/odroid-xu3_defconfig                          |  1 -
 configs/odroid_defconfig                              |  1 -
 configs/omap35_logic_somlv_defconfig                  |  2 +-
 configs/omap3_logic_somlv_defconfig                   |  2 +-
 configs/origen_defconfig                              |  1 -
 configs/pcm051_rev3_defconfig                         |  2 +-
 configs/pg_wcom_expu1_defconfig                       |  4 ++--
 configs/pg_wcom_expu1_update_defconfig                |  4 ++--
 configs/pg_wcom_seli8_defconfig                       |  4 ++--
 configs/pg_wcom_seli8_update_defconfig                |  4 ++--
 configs/phycore-am335x-r2-regor_defconfig             |  2 +-
 configs/phycore-am335x-r2-wega_defconfig              |  2 +-
 configs/pomelo_defconfig                              |  1 -
 configs/qemu-ppce500_defconfig                        |  4 ++--
 configs/qemu-x86_64_defconfig                         |  2 +-
 configs/r8a77990_ebisu_defconfig                      |  2 +-
 configs/r8a77995_draak_defconfig                      |  2 +-
 configs/rcar3_salvator-x_defconfig                    |  2 +-
 configs/rcar3_ulcb_defconfig                          |  2 +-
 configs/rock64-rk3328_defconfig                       |  4 ++--
 configs/rpi_0_w_defconfig                             |  2 +-
 configs/rpi_2_defconfig                               |  2 +-
 configs/rpi_3_32b_defconfig                           |  2 +-
 configs/rpi_3_b_plus_defconfig                        |  2 +-
 configs/rpi_3_defconfig                               |  2 +-
 configs/rpi_4_32b_defconfig                           |  4 ++--
 configs/rpi_4_defconfig                               |  4 ++--
 configs/rpi_arm64_defconfig                           |  4 ++--
 configs/rpi_defconfig                                 |  2 +-
 configs/s5p4418_nanopi2_defconfig                     |  2 +-
 configs/s5p_goni_defconfig                            |  1 -
 configs/s5pc210_universal_defconfig                   |  1 -
 configs/sama5d29_curiosity_mmc1_defconfig             |  1 -
 configs/sama5d29_curiosity_mmc_defconfig              |  1 -
 configs/sandbox64_defconfig                           |  3 +--
 configs/sandbox_defconfig                             |  5 ++---
 configs/slimbootloader_defconfig                      |  2 --
 configs/socfpga_arria10_defconfig                     |  2 +-
 configs/socfpga_arria5_defconfig                      |  2 +-
 configs/socfpga_cyclone5_defconfig                    |  2 +-
 configs/socfpga_dbm_soc1_defconfig                    |  2 +-
 configs/socfpga_de0_nano_soc_defconfig                |  2 +-
 configs/socfpga_de10_nano_defconfig                   |  2 +-
 configs/socfpga_de10_standard_defconfig               |  2 +-
 configs/socfpga_de1_soc_defconfig                     |  2 +-
 configs/socfpga_is1_defconfig                         |  2 +-
 configs/socfpga_mcvevk_defconfig                      |  2 +-
 configs/socfpga_sockit_defconfig                      |  2 +-
 configs/socfpga_sr1500_defconfig                      |  2 +-
 configs/socfpga_vining_fpga_defconfig                 |  2 +-
 configs/socrates_defconfig                            |  2 +-
 configs/som-db5800-som-6867_defconfig                 |  1 -
 configs/starfive_visionfive2_defconfig                | 11 ++++-------
 configs/stm32mp15_basic_defconfig                     |  2 +-
 configs/stm32mp15_defconfig                           |  2 +-
 configs/stm32mp15_trusted_defconfig                   |  2 +-
 configs/stmark2_defconfig                             |  2 +-
 configs/ten64_tfa_defconfig                           |  2 +-
 .../theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig |  1 -
 configs/theadorable-x86-conga-qa3-e3845_defconfig     |  1 -
 configs/theadorable-x86-dfi-bt700_defconfig           |  1 -
 configs/tools-only_defconfig                          |  2 +-
 configs/topic_miami_defconfig                         |  1 -
 configs/topic_miamilite_defconfig                     |  1 -
 configs/topic_miamiplus_defconfig                     |  1 -
 configs/tqma6dl_mba6_mmc_defconfig                    |  2 +-
 configs/tqma6dl_mba6_spi_defconfig                    |  2 +-
 configs/tqma6q_mba6_mmc_defconfig                     |  2 +-
 configs/tqma6q_mba6_spi_defconfig                     |  2 +-
 configs/tqma6s_mba6_mmc_defconfig                     |  2 +-
 configs/tqma6s_mba6_spi_defconfig                     |  2 +-
 configs/transformer_t30_defconfig                     |  6 ++----
 configs/trats2_defconfig                              |  1 -
 configs/trats_defconfig                               |  1 -
 configs/tuge1_defconfig                               |  4 ++--
 configs/turris_mox_defconfig                          |  3 +--
 configs/turris_omnia_defconfig                        |  2 +-
 configs/tuxx1_defconfig                               |  4 ++--
 configs/uniphier_ld4_sld8_defconfig                   |  2 +-
 configs/uniphier_v7_defconfig                         |  2 +-
 configs/uniphier_v8_defconfig                         |  2 +-
 configs/verdin-am62_a53_defconfig                     |  2 +-
 configs/verdin-imx8mm_defconfig                       |  2 +-
 configs/verdin-imx8mp_defconfig                       |  2 +-
 configs/warp7_defconfig                               |  2 +-
 configs/x3_t30_defconfig                              |  6 ++----
 configs/xenguest_arm64_defconfig                      |  2 +-
 configs/xilinx_versal_mini_qspi_defconfig             |  2 +-
 configs/xilinx_versal_net_mini_defconfig              |  2 +-
 configs/xilinx_versal_net_mini_qspi_defconfig         |  2 +-
 configs/xilinx_versal_net_virt_defconfig              |  2 +-
 configs/xilinx_versal_virt_defconfig                  |  2 +-
 configs/xilinx_zynq_virt_defconfig                    |  3 +--
 configs/xilinx_zynqmp_mini_qspi_defconfig             |  2 +-
 configs/xilinx_zynqmp_virt_defconfig                  |  3 +--
 configs/zynq_cse_qspi_defconfig                       |  2 +-
 416 files changed, 586 insertions(+), 645 deletions(-)

diff --git a/configs/10m50_defconfig b/configs/10m50_defconfig
index b76f31b009f0..02f1249113bc 100644
--- a/configs/10m50_defconfig
+++ b/configs/10m50_defconfig
@@ -11,8 +11,8 @@ CONFIG_DEFAULT_DEVICE_TREE="10m50_devboard"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SYS_LOAD_ADDR=0xcc000000
 CONFIG_ENV_ADDR=0xF4080000
-CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0xCFF80000
+CONFIG_FIT=y
 # CONFIG_AUTOBOOT is not set
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/3c120_defconfig b/configs/3c120_defconfig
index 13da353d7eb8..6bd5471ab3a1 100644
--- a/configs/3c120_defconfig
+++ b/configs/3c120_defconfig
@@ -11,8 +11,8 @@ CONFIG_DEFAULT_DEVICE_TREE="3c120_devboard"
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SYS_LOAD_ADDR=0xd4000000
 CONFIG_ENV_ADDR=0xE2880000
-CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0xD7F80000
+CONFIG_FIT=y
 # CONFIG_AUTOBOOT is not set
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/CMPC885_defconfig b/configs/CMPC885_defconfig
index 54873daa1565..de4321fe688d 100644
--- a/configs/CMPC885_defconfig
+++ b/configs/CMPC885_defconfig
@@ -23,7 +23,6 @@ CONFIG_SYS_SCCR=0x00420000
 CONFIG_SYS_SCCR_MASK=0x00000000
 CONFIG_SYS_DER=0x2002000F
 CONFIG_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=5
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_FLUSH_STDIN=y
@@ -31,6 +30,7 @@ CONFIG_AUTOBOOT_PROMPT="\nEnter password - autoboot in %d sec...\n"
 CONFIG_AUTOBOOT_ENCRYPTION=y
 CONFIG_AUTOBOOT_STOP_STR_ENABLE=y
 CONFIG_AUTOBOOT_STOP_STR_SHA256="4813494d137e1631bba301d5acab6e7bb7aa74ce1185d456565ef51d737677b2"
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run flashboot"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/CMPCPRO_defconfig b/configs/CMPCPRO_defconfig
index d817274a9360..cb87dd8c6472 100644
--- a/configs/CMPCPRO_defconfig
+++ b/configs/CMPCPRO_defconfig
@@ -102,8 +102,6 @@ CONFIG_SPCR_OPT_SPEC_READ=y
 CONFIG_LCRR_EADC_1=y
 CONFIG_LCRR_CLKDIV_2=y
 CONFIG_FIT=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOOTDELAY=5
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_FLUSH_STDIN=y
@@ -111,6 +109,8 @@ CONFIG_AUTOBOOT_PROMPT="\nEnter password - autoboot in %d sec...\n"
 CONFIG_AUTOBOOT_ENCRYPTION=y
 CONFIG_AUTOBOOT_STOP_STR_ENABLE=y
 CONFIG_AUTOBOOT_STOP_STR_SHA256="4813494d137e1631bba301d5acab6e7bb7aa74ce1185d456565ef51d737677b2"
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run flashboot"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/MCR3000_defconfig b/configs/MCR3000_defconfig
index 2bae14b21463..13d6522407dd 100644
--- a/configs/MCR3000_defconfig
+++ b/configs/MCR3000_defconfig
@@ -20,9 +20,8 @@ CONFIG_SYS_PLPRCR=0x00460004
 CONFIG_SYS_SCCR=0x00C20000
 CONFIG_SYS_SCCR_MASK=0x60000000
 CONFIG_SYS_DER=0x2002000F
-CONFIG_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_MONITOR_BASE=0x04000000
+CONFIG_FIT=y
 CONFIG_BOOTDELAY=5
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_FLUSH_STDIN=y
@@ -30,6 +29,7 @@ CONFIG_AUTOBOOT_PROMPT="\nEnter password - autoboot in %d sec...\n"
 CONFIG_AUTOBOOT_ENCRYPTION=y
 CONFIG_AUTOBOOT_STOP_STR_ENABLE=y
 CONFIG_AUTOBOOT_STOP_STR_SHA256="4813494d137e1631bba301d5acab6e7bb7aa74ce1185d456565ef51d737677b2"
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run flashboot"
 # CONFIG_HWCONFIG is not set
diff --git a/configs/MPC837XERDB_defconfig b/configs/MPC837XERDB_defconfig
index bf7370f5c652..33f0bab63469 100644
--- a/configs/MPC837XERDB_defconfig
+++ b/configs/MPC837XERDB_defconfig
@@ -119,9 +119,9 @@ CONFIG_LCRR_CLKDIV_8=y
 CONFIG_FSL_SERDES=y
 CONFIG_USE_UBOOTPATH=y
 CONFIG_DEBUG_UART=y
+CONFIG_BOOTDELAY=6
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_BOOTDELAY=6
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_PCI_INIT_R=y
diff --git a/configs/MPC8548CDS_36BIT_defconfig b/configs/MPC8548CDS_36BIT_defconfig
index ebffbb22c90a..4d3d6918147e 100644
--- a/configs/MPC8548CDS_36BIT_defconfig
+++ b/configs/MPC8548CDS_36BIT_defconfig
@@ -20,10 +20,10 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_UBOOTPATH="8548cds/u-boot.bin"
 CONFIG_PCIE1=y
 CONFIG_PHYS_64BIT=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
 # CONFIG_MISC_INIT_R is not set
diff --git a/configs/MPC8548CDS_defconfig b/configs/MPC8548CDS_defconfig
index 4ed84d04354a..b7f7e7b41612 100644
--- a/configs/MPC8548CDS_defconfig
+++ b/configs/MPC8548CDS_defconfig
@@ -19,10 +19,10 @@ CONFIG_ENABLE_36BIT_PHYS=y
 CONFIG_USE_UBOOTPATH=y
 CONFIG_UBOOTPATH="8548cds/u-boot.bin"
 CONFIG_PCIE1=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
 # CONFIG_MISC_INIT_R is not set
diff --git a/configs/MPC8548CDS_legacy_defconfig b/configs/MPC8548CDS_legacy_defconfig
index 684a4fa92da0..9acc8bd27ca5 100644
--- a/configs/MPC8548CDS_legacy_defconfig
+++ b/configs/MPC8548CDS_legacy_defconfig
@@ -20,10 +20,10 @@ CONFIG_TARGET_MPC8548CDS_LEGACY=y
 CONFIG_USE_UBOOTPATH=y
 CONFIG_UBOOTPATH="8548cds/u-boot.bin"
 CONFIG_PCIE1=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
 # CONFIG_MISC_INIT_R is not set
diff --git a/configs/P1010RDB-PA_36BIT_NAND_defconfig b/configs/P1010RDB-PA_36BIT_NAND_defconfig
index 1f4b600a6b9f..37a1398e7ed6 100644
--- a/configs/P1010RDB-PA_36BIT_NAND_defconfig
+++ b/configs/P1010RDB-PA_36BIT_NAND_defconfig
@@ -26,12 +26,12 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
+CONFIG_TPL_SYS_MONITOR_BASE=0xD0000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xD0000000
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PA_36BIT_NOR_defconfig b/configs/P1010RDB-PA_36BIT_NOR_defconfig
index 5ef72479c1db..caf1b34823a8 100644
--- a/configs/P1010RDB-PA_36BIT_NOR_defconfig
+++ b/configs/P1010RDB-PA_36BIT_NOR_defconfig
@@ -19,10 +19,10 @@ CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_NO_PBL=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PA_36BIT_SDCARD_defconfig b/configs/P1010RDB-PA_36BIT_SDCARD_defconfig
index 317499a27eca..cc998a8d2eef 100644
--- a/configs/P1010RDB-PA_36BIT_SDCARD_defconfig
+++ b/configs/P1010RDB-PA_36BIT_SDCARD_defconfig
@@ -26,10 +26,10 @@ CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_FSL_FIXED_MMC_LOCATION=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig b/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig
index b81971dc4196..bb263ab73689 100644
--- a/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig
@@ -28,10 +28,10 @@ CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SPIFLASH=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PA_NAND_defconfig b/configs/P1010RDB-PA_NAND_defconfig
index 6a8b7135d174..960229c3fc94 100644
--- a/configs/P1010RDB-PA_NAND_defconfig
+++ b/configs/P1010RDB-PA_NAND_defconfig
@@ -25,12 +25,12 @@ CONFIG_TPL_SYS_MPC85XX_NO_RESETVEC=y
 CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
+CONFIG_TPL_SYS_MONITOR_BASE=0xD0000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xD0000000
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PA_NOR_defconfig b/configs/P1010RDB-PA_NOR_defconfig
index 037489cfa637..78be54ee0e27 100644
--- a/configs/P1010RDB-PA_NOR_defconfig
+++ b/configs/P1010RDB-PA_NOR_defconfig
@@ -18,10 +18,10 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_NO_PBL=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PA_SDCARD_defconfig b/configs/P1010RDB-PA_SDCARD_defconfig
index 859d058f5438..c664a9958ec7 100644
--- a/configs/P1010RDB-PA_SDCARD_defconfig
+++ b/configs/P1010RDB-PA_SDCARD_defconfig
@@ -25,10 +25,10 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_FSL_FIXED_MMC_LOCATION=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PA_SPIFLASH_defconfig b/configs/P1010RDB-PA_SPIFLASH_defconfig
index 84f741555ef2..2ffba7d4804e 100644
--- a/configs/P1010RDB-PA_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PA_SPIFLASH_defconfig
@@ -27,10 +27,10 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SPIFLASH=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PB_36BIT_NAND_defconfig b/configs/P1010RDB-PB_36BIT_NAND_defconfig
index 7a38a56bb5bf..b9790cd517a1 100644
--- a/configs/P1010RDB-PB_36BIT_NAND_defconfig
+++ b/configs/P1010RDB-PB_36BIT_NAND_defconfig
@@ -26,12 +26,12 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
+CONFIG_TPL_SYS_MONITOR_BASE=0xD0000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xD0000000
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PB_36BIT_NOR_defconfig b/configs/P1010RDB-PB_36BIT_NOR_defconfig
index f390a725e9a0..a76c91b744a7 100644
--- a/configs/P1010RDB-PB_36BIT_NOR_defconfig
+++ b/configs/P1010RDB-PB_36BIT_NOR_defconfig
@@ -19,10 +19,10 @@ CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_NO_PBL=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PB_36BIT_SDCARD_defconfig b/configs/P1010RDB-PB_36BIT_SDCARD_defconfig
index 58dc15607e4d..b6504a532f0b 100644
--- a/configs/P1010RDB-PB_36BIT_SDCARD_defconfig
+++ b/configs/P1010RDB-PB_36BIT_SDCARD_defconfig
@@ -26,10 +26,10 @@ CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_FSL_FIXED_MMC_LOCATION=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig b/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig
index 66acf63f029b..14bfd973b73a 100644
--- a/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig
@@ -28,10 +28,10 @@ CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SPIFLASH=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PB_NAND_defconfig b/configs/P1010RDB-PB_NAND_defconfig
index fa3f5fa43ab8..589fd5dec3e0 100644
--- a/configs/P1010RDB-PB_NAND_defconfig
+++ b/configs/P1010RDB-PB_NAND_defconfig
@@ -25,12 +25,12 @@ CONFIG_TPL_SYS_MPC85XX_NO_RESETVEC=y
 CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
+CONFIG_TPL_SYS_MONITOR_BASE=0xD0000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xD0000000
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PB_NOR_defconfig b/configs/P1010RDB-PB_NOR_defconfig
index 2bf2041d5844..d96b8fc7ef0c 100644
--- a/configs/P1010RDB-PB_NOR_defconfig
+++ b/configs/P1010RDB-PB_NOR_defconfig
@@ -18,10 +18,10 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_NO_PBL=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PB_SDCARD_defconfig b/configs/P1010RDB-PB_SDCARD_defconfig
index 2ff163b91929..c08089a99d40 100644
--- a/configs/P1010RDB-PB_SDCARD_defconfig
+++ b/configs/P1010RDB-PB_SDCARD_defconfig
@@ -25,10 +25,10 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_FSL_FIXED_MMC_LOCATION=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1010RDB-PB_SPIFLASH_defconfig b/configs/P1010RDB-PB_SPIFLASH_defconfig
index eda92b6924a7..8d5b13b90d8f 100644
--- a/configs/P1010RDB-PB_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PB_SPIFLASH_defconfig
@@ -27,10 +27,10 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SPIFLASH=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs ramdisk_size=$ramdisk_size;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/P1020RDB-PC_36BIT_NAND_defconfig b/configs/P1020RDB-PC_36BIT_NAND_defconfig
index b3c4f2fc9f27..bb459cd71a3c 100644
--- a/configs/P1020RDB-PC_36BIT_NAND_defconfig
+++ b/configs/P1020RDB-PC_36BIT_NAND_defconfig
@@ -27,12 +27,12 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_MP=y
+CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PC_36BIT_SDCARD_defconfig b/configs/P1020RDB-PC_36BIT_SDCARD_defconfig
index 9a38955ca95a..55046af16eec 100644
--- a/configs/P1020RDB-PC_36BIT_SDCARD_defconfig
+++ b/configs/P1020RDB-PC_36BIT_SDCARD_defconfig
@@ -25,13 +25,13 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FSL_FIXED_MMC_LOCATION=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig b/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig
index b59812e41024..2b24877605d0 100644
--- a/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig
+++ b/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig
@@ -27,13 +27,13 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_SPIFLASH=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PC_36BIT_defconfig b/configs/P1020RDB-PC_36BIT_defconfig
index 46b62066794d..9f5e46cfe692 100644
--- a/configs/P1020RDB-PC_36BIT_defconfig
+++ b/configs/P1020RDB-PC_36BIT_defconfig
@@ -21,10 +21,10 @@ CONFIG_PHYS_64BIT=y
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_NO_PBL=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PC_NAND_defconfig b/configs/P1020RDB-PC_NAND_defconfig
index 05ea596e6b73..e38cd0a4f7fe 100644
--- a/configs/P1020RDB-PC_NAND_defconfig
+++ b/configs/P1020RDB-PC_NAND_defconfig
@@ -26,12 +26,12 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_MP=y
+CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PC_SDCARD_defconfig b/configs/P1020RDB-PC_SDCARD_defconfig
index 763b20ae0b6f..95df4500c402 100644
--- a/configs/P1020RDB-PC_SDCARD_defconfig
+++ b/configs/P1020RDB-PC_SDCARD_defconfig
@@ -24,13 +24,13 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FSL_FIXED_MMC_LOCATION=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PC_SPIFLASH_defconfig b/configs/P1020RDB-PC_SPIFLASH_defconfig
index 7db19bdbe771..b519d6cffbfe 100644
--- a/configs/P1020RDB-PC_SPIFLASH_defconfig
+++ b/configs/P1020RDB-PC_SPIFLASH_defconfig
@@ -26,13 +26,13 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_SPIFLASH=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PC_defconfig b/configs/P1020RDB-PC_defconfig
index e8f79eac40bf..fd420577ef7a 100644
--- a/configs/P1020RDB-PC_defconfig
+++ b/configs/P1020RDB-PC_defconfig
@@ -20,10 +20,10 @@ CONFIG_PCIE2=y
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_NO_PBL=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PD_NAND_defconfig b/configs/P1020RDB-PD_NAND_defconfig
index ad33e9009e3d..c04992768e1c 100644
--- a/configs/P1020RDB-PD_NAND_defconfig
+++ b/configs/P1020RDB-PD_NAND_defconfig
@@ -26,12 +26,12 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_MP=y
+CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PD_SDCARD_defconfig b/configs/P1020RDB-PD_SDCARD_defconfig
index 24e0edeaa940..e833bb2b41be 100644
--- a/configs/P1020RDB-PD_SDCARD_defconfig
+++ b/configs/P1020RDB-PD_SDCARD_defconfig
@@ -24,13 +24,13 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FSL_FIXED_MMC_LOCATION=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PD_SPIFLASH_defconfig b/configs/P1020RDB-PD_SPIFLASH_defconfig
index aa09fa1d5a76..4e7c60595347 100644
--- a/configs/P1020RDB-PD_SPIFLASH_defconfig
+++ b/configs/P1020RDB-PD_SPIFLASH_defconfig
@@ -26,13 +26,13 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_SPIFLASH=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P1020RDB-PD_defconfig b/configs/P1020RDB-PD_defconfig
index e665a597ca99..e3435da28891 100644
--- a/configs/P1020RDB-PD_defconfig
+++ b/configs/P1020RDB-PD_defconfig
@@ -20,10 +20,10 @@ CONFIG_PCIE2=y
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_NO_PBL=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P2020RDB-PC_36BIT_NAND_defconfig b/configs/P2020RDB-PC_36BIT_NAND_defconfig
index 6c1017bc0205..ea17afb48092 100644
--- a/configs/P2020RDB-PC_36BIT_NAND_defconfig
+++ b/configs/P2020RDB-PC_36BIT_NAND_defconfig
@@ -27,12 +27,12 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_MP=y
+CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P2020RDB-PC_36BIT_SDCARD_defconfig b/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
index 3e194d147764..476b3d4d72dc 100644
--- a/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
+++ b/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
@@ -25,13 +25,13 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FSL_FIXED_MMC_LOCATION=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig b/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
index 16c47b25c8f3..8a31de073e87 100644
--- a/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
+++ b/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
@@ -27,13 +27,13 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PHYS_64BIT=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_SPIFLASH=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P2020RDB-PC_36BIT_defconfig b/configs/P2020RDB-PC_36BIT_defconfig
index 2c9ff670a4ea..93d22fb55d95 100644
--- a/configs/P2020RDB-PC_36BIT_defconfig
+++ b/configs/P2020RDB-PC_36BIT_defconfig
@@ -21,10 +21,10 @@ CONFIG_PHYS_64BIT=y
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_NO_PBL=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P2020RDB-PC_NAND_defconfig b/configs/P2020RDB-PC_NAND_defconfig
index a7f562b8326b..46d60f3776ee 100644
--- a/configs/P2020RDB-PC_NAND_defconfig
+++ b/configs/P2020RDB-PC_NAND_defconfig
@@ -26,12 +26,12 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_MP=y
+CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P2020RDB-PC_SDCARD_defconfig b/configs/P2020RDB-PC_SDCARD_defconfig
index 6f5316d0c791..6076b54908d6 100644
--- a/configs/P2020RDB-PC_SDCARD_defconfig
+++ b/configs/P2020RDB-PC_SDCARD_defconfig
@@ -24,13 +24,13 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FSL_FIXED_MMC_LOCATION=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P2020RDB-PC_SPIFLASH_defconfig b/configs/P2020RDB-PC_SPIFLASH_defconfig
index 9fa1a39fec64..46e8d1e0337b 100644
--- a/configs/P2020RDB-PC_SPIFLASH_defconfig
+++ b/configs/P2020RDB-PC_SPIFLASH_defconfig
@@ -26,13 +26,13 @@ CONFIG_USE_UBOOTPATH=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_MP=y
+CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
 CONFIG_SPIFLASH=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P2020RDB-PC_defconfig b/configs/P2020RDB-PC_defconfig
index 2a1a7ac7f823..5eaf70b7f7c0 100644
--- a/configs/P2020RDB-PC_defconfig
+++ b/configs/P2020RDB-PC_defconfig
@@ -20,10 +20,10 @@ CONFIG_PCIE2=y
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_NO_PBL=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/P2041RDB_NAND_defconfig b/configs/P2041RDB_NAND_defconfig
index 4b038f0aeb4a..786c8261a8cd 100644
--- a/configs/P2041RDB_NAND_defconfig
+++ b/configs/P2041RDB_NAND_defconfig
@@ -23,15 +23,15 @@ CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/p2041rdb/pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/p2041rdb/rcw_p2041rdb.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/P2041RDB_SDCARD_defconfig b/configs/P2041RDB_SDCARD_defconfig
index d05d53a87df1..7aa26348765d 100644
--- a/configs/P2041RDB_SDCARD_defconfig
+++ b/configs/P2041RDB_SDCARD_defconfig
@@ -23,15 +23,15 @@ CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/p2041rdb/pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/p2041rdb/rcw_p2041rdb.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/P2041RDB_SPIFLASH_defconfig b/configs/P2041RDB_SPIFLASH_defconfig
index 70279c073829..68628757f290 100644
--- a/configs/P2041RDB_SPIFLASH_defconfig
+++ b/configs/P2041RDB_SPIFLASH_defconfig
@@ -24,16 +24,16 @@ CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/p2041rdb/pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/p2041rdb/rcw_p2041rdb.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/P2041RDB_defconfig b/configs/P2041RDB_defconfig
index 6978936b0246..4ea2b4793ad6 100644
--- a/configs/P2041RDB_defconfig
+++ b/configs/P2041RDB_defconfig
@@ -24,12 +24,12 @@ CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T1024RDB_NAND_defconfig b/configs/T1024RDB_NAND_defconfig
index 9b322c0e4777..7c1345b3d7bb 100644
--- a/configs/T1024RDB_NAND_defconfig
+++ b/configs/T1024RDB_NAND_defconfig
@@ -29,12 +29,12 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t102xrdb/t1024_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t102xrdb/t1024_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/T1024RDB_SDCARD_defconfig b/configs/T1024RDB_SDCARD_defconfig
index 8243cc6a1094..cb398f710cae 100644
--- a/configs/T1024RDB_SDCARD_defconfig
+++ b/configs/T1024RDB_SDCARD_defconfig
@@ -29,12 +29,12 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t102xrdb/t1024_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t102xrdb/t1024_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/T1024RDB_SPIFLASH_defconfig b/configs/T1024RDB_SPIFLASH_defconfig
index 7e89d3c03a59..464b36b66b7a 100644
--- a/configs/T1024RDB_SPIFLASH_defconfig
+++ b/configs/T1024RDB_SPIFLASH_defconfig
@@ -31,13 +31,13 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t102xrdb/t1024_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t102xrdb/t1024_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/T1024RDB_defconfig b/configs/T1024RDB_defconfig
index 0d0707e02629..f63268448b5e 100644
--- a/configs/T1024RDB_defconfig
+++ b/configs/T1024RDB_defconfig
@@ -23,9 +23,9 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/T1042D4RDB_NAND_defconfig b/configs/T1042D4RDB_NAND_defconfig
index 7ffa2e7f8828..a44c76821b86 100644
--- a/configs/T1042D4RDB_NAND_defconfig
+++ b/configs/T1042D4RDB_NAND_defconfig
@@ -28,12 +28,12 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/freescale/t104xrdb/t104x_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/freescale/t104xrdb/t1042d4_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/T1042D4RDB_SDCARD_defconfig b/configs/T1042D4RDB_SDCARD_defconfig
index 1add5b60dc09..800f0635a3f2 100644
--- a/configs/T1042D4RDB_SDCARD_defconfig
+++ b/configs/T1042D4RDB_SDCARD_defconfig
@@ -28,12 +28,12 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/freescale/t104xrdb/t104x_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/freescale/t104xrdb/t1042d4_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/T1042D4RDB_SPIFLASH_defconfig b/configs/T1042D4RDB_SPIFLASH_defconfig
index 0902483de796..3fe25ecd3656 100644
--- a/configs/T1042D4RDB_SPIFLASH_defconfig
+++ b/configs/T1042D4RDB_SPIFLASH_defconfig
@@ -30,13 +30,13 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
 CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/freescale/t104xrdb/t104x_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/freescale/t104xrdb/t1042d4_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/T1042D4RDB_defconfig b/configs/T1042D4RDB_defconfig
index fe84f36aceac..4ca833c063ef 100644
--- a/configs/T1042D4RDB_defconfig
+++ b/configs/T1042D4RDB_defconfig
@@ -22,9 +22,9 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/T2080QDS_NAND_defconfig b/configs/T2080QDS_NAND_defconfig
index db9b6c3b2b22..431c485350d5 100644
--- a/configs/T2080QDS_NAND_defconfig
+++ b/configs/T2080QDS_NAND_defconfig
@@ -37,15 +37,15 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xqds/t208x_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xqds/t2080_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080QDS_SDCARD_defconfig b/configs/T2080QDS_SDCARD_defconfig
index a5a9eb53ebd3..eb060f42d838 100644
--- a/configs/T2080QDS_SDCARD_defconfig
+++ b/configs/T2080QDS_SDCARD_defconfig
@@ -37,15 +37,15 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xqds/t208x_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xqds/t2080_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080QDS_SECURE_BOOT_defconfig b/configs/T2080QDS_SECURE_BOOT_defconfig
index 7a311045ad7c..64befc5a6562 100644
--- a/configs/T2080QDS_SECURE_BOOT_defconfig
+++ b/configs/T2080QDS_SECURE_BOOT_defconfig
@@ -32,12 +32,12 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_BOARD_EARLY_INIT_R=y
diff --git a/configs/T2080QDS_SPIFLASH_defconfig b/configs/T2080QDS_SPIFLASH_defconfig
index e4f1cf57d0d2..5f3997abf4a9 100644
--- a/configs/T2080QDS_SPIFLASH_defconfig
+++ b/configs/T2080QDS_SPIFLASH_defconfig
@@ -39,16 +39,16 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xqds/t208x_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xqds/t2080_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig b/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
index 01988120c29d..3b0978950953 100644
--- a/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
+++ b/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
@@ -31,12 +31,12 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080QDS_defconfig b/configs/T2080QDS_defconfig
index 8e746acce16e..c8b0e404d516 100644
--- a/configs/T2080QDS_defconfig
+++ b/configs/T2080QDS_defconfig
@@ -31,12 +31,12 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080RDB_NAND_defconfig b/configs/T2080RDB_NAND_defconfig
index b7e54b85e72b..89e8b959f7f5 100644
--- a/configs/T2080RDB_NAND_defconfig
+++ b/configs/T2080RDB_NAND_defconfig
@@ -34,12 +34,12 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080RDB_SDCARD_defconfig b/configs/T2080RDB_SDCARD_defconfig
index 098cb8e0df5e..585daeb2e77b 100644
--- a/configs/T2080RDB_SDCARD_defconfig
+++ b/configs/T2080RDB_SDCARD_defconfig
@@ -34,12 +34,12 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080RDB_SPIFLASH_defconfig b/configs/T2080RDB_SPIFLASH_defconfig
index 4d94972cca20..6c2383188ad7 100644
--- a/configs/T2080RDB_SPIFLASH_defconfig
+++ b/configs/T2080RDB_SPIFLASH_defconfig
@@ -36,13 +36,13 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080RDB_defconfig b/configs/T2080RDB_defconfig
index e1e963037dbc..370e8e8bc02d 100644
--- a/configs/T2080RDB_defconfig
+++ b/configs/T2080RDB_defconfig
@@ -28,9 +28,9 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080RDB_revD_NAND_defconfig b/configs/T2080RDB_revD_NAND_defconfig
index 582c07c6cd8d..fcf9c9fed3f1 100644
--- a/configs/T2080RDB_revD_NAND_defconfig
+++ b/configs/T2080RDB_revD_NAND_defconfig
@@ -35,12 +35,12 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080RDB_revD_SDCARD_defconfig b/configs/T2080RDB_revD_SDCARD_defconfig
index a98177538ae4..530c5d9f0a37 100644
--- a/configs/T2080RDB_revD_SDCARD_defconfig
+++ b/configs/T2080RDB_revD_SDCARD_defconfig
@@ -35,12 +35,12 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080RDB_revD_SPIFLASH_defconfig b/configs/T2080RDB_revD_SPIFLASH_defconfig
index a5638f7c195b..42babd426c9a 100644
--- a/configs/T2080RDB_revD_SPIFLASH_defconfig
+++ b/configs/T2080RDB_revD_SPIFLASH_defconfig
@@ -37,13 +37,13 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T2080RDB_revD_defconfig b/configs/T2080RDB_revD_defconfig
index d9116df6242f..6874fb855712 100644
--- a/configs/T2080RDB_revD_defconfig
+++ b/configs/T2080RDB_revD_defconfig
@@ -29,9 +29,9 @@ CONFIG_SYS_MEMTEST_END=0x00400000
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T4240RDB_SDCARD_defconfig b/configs/T4240RDB_SDCARD_defconfig
index 8d790c5a36ab..8bbba9fccda2 100644
--- a/configs/T4240RDB_SDCARD_defconfig
+++ b/configs/T4240RDB_SDCARD_defconfig
@@ -32,12 +32,12 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=5
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/freescale/t4rdb/t4_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/freescale/t4rdb/t4_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/T4240RDB_defconfig b/configs/T4240RDB_defconfig
index 4b63ef413a6f..b3affca78d05 100644
--- a/configs/T4240RDB_defconfig
+++ b/configs/T4240RDB_defconfig
@@ -26,9 +26,9 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=5
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;setenv ramdiskaddr 0x02000000;setenv fdtaddr 0x00c00000;setenv loadaddr 0x1000000;bootm $loadaddr $ramdiskaddr $fdtaddr"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
index 06a683d986be..1b7d3dcd473b 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -10,8 +10,8 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_AE350=y
-CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index 75e55ba72470..634dad860f76 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -14,9 +14,9 @@ CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_AE350=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_AVAILABLE_HARTS is not set
+CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x00200000
-CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index c2221b891e31..f3e598f9e0b3 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -15,9 +15,9 @@ CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_AE350=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_XIP=y
+CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
-CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index 6d19400c2d74..1f1189d28689 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -11,8 +11,8 @@ CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_AE350=y
 CONFIG_XIP=y
-CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index 0d7f0a552e79..27a5fc0c92f8 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -10,8 +10,8 @@ CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_AE350=y
 CONFIG_ARCH_RV64I=y
-CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index 6a72b5a0471b..db4e8f8710e9 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -14,9 +14,9 @@ CONFIG_TARGET_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_AVAILABLE_HARTS is not set
+CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x00200000
-CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 43581c79b1c9..e92c47789fad 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -15,9 +15,9 @@ CONFIG_TARGET_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_XIP=y
+CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
-CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index 02d769448959..db43b48248c1 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -11,8 +11,8 @@ CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_XIP=y
-CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defconfig
index 6ef3c78390af..e41fbfec310e 100644
--- a/configs/am335x_baltos_defconfig
+++ b/configs/am335x_baltos_defconfig
@@ -14,8 +14,8 @@ CONFIG_SPL=y
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run usbboot;run mmcboot;setenv mmcdev 1; setenv bootpart 1:2; run mmcboot;run nandboot;"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SYS_SPL_MALLOC=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index a179f1ed5f21..d7cf7d78847d 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -14,8 +14,8 @@ CONFIG_AM335X_USB1=y
 CONFIG_SPL=y
 CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index 09d5e803a3e9..090aae7e76bf 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -17,8 +17,8 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index a3a4ab361c31..4c36f9ddc9e8 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -14,8 +14,8 @@ CONFIG_CLOCK_SYNTHESIZER=y
 CONFIG_SPL=y
 CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index 6e4d327880ce..cc5b45228dde 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -17,8 +17,8 @@ CONFIG_SPL=y
 # CONFIG_SPL_LIBDISK_SUPPORT is not set
 CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index 37e1259a8b15..0b048a57377e 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -15,8 +15,9 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_BOOTCOMMAND="run findfdt;run mmcboot;run nandboot;run netboot;"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SYS_SPL_MALLOC=y
@@ -94,4 +95,3 @@ CONFIG_DRIVER_TI_CPSW=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_OMAP3_SPI=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index 01428ac7aa73..0f7d5bb9a433 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -18,8 +18,8 @@ CONFIG_TI_SECURE_EMIF_PROTECTED_REGION_SIZE=0x01c00000
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_MISC_INIT_R is not set
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 6db59225c280..9008c5e46669 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -18,8 +18,8 @@ CONFIG_SPL_SPI=y
 CONFIG_ARMV7_LPAE=y
 CONFIG_AHCI=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="androidboot.serialno=${serial#} console=ttyS2,115200 androidboot.console=ttyS2 androidboot.hardware=beagle_x15board"
 CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 94ffce1a9986..a7404e9c09ea 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -21,8 +21,8 @@ CONFIG_SPL_SPI=y
 CONFIG_ARMV7_LPAE=y
 CONFIG_AHCI=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="androidboot.serialno=${serial#} console=ttyS2,115200 androidboot.console=ttyS2 androidboot.hardware=beagle_x15board"
 CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 9ed59ac9aecc..dde0fb569aab 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -23,8 +23,8 @@ CONFIG_ARMV7_LPAE=y
 CONFIG_AHCI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="androidboot.serialno=${serial#} console=ttyS2,115200 androidboot.console=ttyS2 androidboot.hardware=beagle_x15board"
 CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
@@ -94,7 +94,6 @@ CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
-CONFIG_PHY=y
 CONFIG_PIPE3_PHY=y
 CONFIG_OMAP_USB2_PHY=y
 CONFIG_DM_PMIC=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index 4301553af8d2..cf55f9bbe3b4 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -32,8 +32,8 @@ CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run init_${boot}; run boot_rprocs; run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern"
 CONFIG_LOGLEVEL=7
 CONFIG_CONSOLE_MUX=y
diff --git a/configs/am65x_hs_evm_a53_defconfig b/configs/am65x_hs_evm_a53_defconfig
index 3f9626e45503..6b32aa27fd40 100644
--- a/configs/am65x_hs_evm_a53_defconfig
+++ b/configs/am65x_hs_evm_a53_defconfig
@@ -32,8 +32,8 @@ CONFIG_SPL_SPI=y
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run envboot; run init_${boot}; run get_fit_${boot}; run get_overlaystring; run run_fit"
 CONFIG_LOGLEVEL=7
 CONFIG_CONSOLE_MUX=y
diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index b726ee351fa0..23bec1c306e8 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -21,9 +21,9 @@ CONFIG_SYS_MEMTEST_END=0x89000000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-apalis${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
index fda85c2d6ae3..eb198463cf77 100644
--- a/configs/apalis-tk1_defconfig
+++ b/configs/apalis-tk1_defconfig
@@ -18,8 +18,8 @@ CONFIG_SYS_LOAD_ADDR=0x81000000
 CONFIG_PCI=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="setenv fdtfile ${soc}-${fdt_module}-${fdt_board}.dtb && run distro_bootcmd"
 CONFIG_CONSOLE_MUX=y
 CONFIG_SYS_STDIO_DEREGISTER=y
diff --git a/configs/bayleybay_defconfig b/configs/bayleybay_defconfig
index 573f1b48645a..f1dec697f28e 100644
--- a/configs/bayleybay_defconfig
+++ b/configs/bayleybay_defconfig
@@ -46,7 +46,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/bcmns_defconfig b/configs/bcmns_defconfig
index 3be6a37009cd..7e54af14f7a8 100644
--- a/configs/bcmns_defconfig
+++ b/configs/bcmns_defconfig
@@ -12,11 +12,11 @@ CONFIG_IDENT_STRING="Broadcom Northstar"
 CONFIG_SYS_LOAD_ADDR=0x00008000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 # CONFIG_BOOTSTD is not set
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOOTDELAY=1
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Boot Northstar system in %d seconds\n"
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run bootcmd_dlink_dir8xxl"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/boston32r2_defconfig b/configs/boston32r2_defconfig
index 5a8dc39c1512..a5345117b65f 100644
--- a/configs/boston32r2_defconfig
+++ b/configs/boston32r2_defconfig
@@ -19,8 +19,8 @@ CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/boston32r2el_defconfig b/configs/boston32r2el_defconfig
index ccc8360d5202..b1fd9273db57 100644
--- a/configs/boston32r2el_defconfig
+++ b/configs/boston32r2el_defconfig
@@ -20,8 +20,8 @@ CONFIG_SYS_LITTLE_ENDIAN=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/boston32r6_defconfig b/configs/boston32r6_defconfig
index fe7b280cea2e..cbb905a593e7 100644
--- a/configs/boston32r6_defconfig
+++ b/configs/boston32r6_defconfig
@@ -20,8 +20,8 @@ CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/boston32r6el_defconfig b/configs/boston32r6el_defconfig
index fc741aad21f7..f326d5f6bb6a 100644
--- a/configs/boston32r6el_defconfig
+++ b/configs/boston32r6el_defconfig
@@ -21,8 +21,8 @@ CONFIG_SYS_LITTLE_ENDIAN=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/boston64r2_defconfig b/configs/boston64r2_defconfig
index 41b8759ed604..2932343c64f9 100644
--- a/configs/boston64r2_defconfig
+++ b/configs/boston64r2_defconfig
@@ -20,8 +20,8 @@ CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/boston64r2el_defconfig b/configs/boston64r2el_defconfig
index 3afc90b48a14..5608bdbbc5ff 100644
--- a/configs/boston64r2el_defconfig
+++ b/configs/boston64r2el_defconfig
@@ -21,8 +21,8 @@ CONFIG_SYS_LITTLE_ENDIAN=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/boston64r6_defconfig b/configs/boston64r6_defconfig
index da8cded1f38e..41ace65a3e5e 100644
--- a/configs/boston64r6_defconfig
+++ b/configs/boston64r6_defconfig
@@ -20,8 +20,8 @@ CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/boston64r6el_defconfig b/configs/boston64r6el_defconfig
index a5b72dec762e..2a0a42486286 100644
--- a/configs/boston64r6el_defconfig
+++ b/configs/boston64r6el_defconfig
@@ -21,8 +21,8 @@ CONFIG_SYS_LITTLE_ENDIAN=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index 653620263cd9..278ce5909bd4 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -24,8 +24,8 @@ CONFIG_LOCALVERSION="-2.0.0"
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_EXPERT is not set
 # CONFIG_FIT is not set
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=0
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run b_default"
 CONFIG_USE_PREBOOT=y
diff --git a/configs/brppt2_defconfig b/configs/brppt2_defconfig
index 05ee4c5797e6..eee873eeda0e 100644
--- a/configs/brppt2_defconfig
+++ b/configs/brppt2_defconfig
@@ -25,9 +25,9 @@ CONFIG_SPL_SPI=y
 # CONFIG_CMD_BMODE is not set
 CONFIG_SYS_LOAD_ADDR=0x10700000
 # CONFIG_EXPERT is not set
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_SPI_BOOT=y
 CONFIG_BOOTDELAY=0
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run b_default"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/brsmarc1_defconfig b/configs/brsmarc1_defconfig
index 94943fccf1ac..8154039431f2 100644
--- a/configs/brsmarc1_defconfig
+++ b/configs/brsmarc1_defconfig
@@ -25,8 +25,8 @@ CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x80000000
 # CONFIG_EXPERT is not set
 # CONFIG_FIT is not set
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=0
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run b_default"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index b50aef0aad92..9a4deff6e7b7 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -22,8 +22,8 @@ CONFIG_ENV_OFFSET_REDUND=0x50000
 CONFIG_SYS_LOAD_ADDR=0x80000000
 # CONFIG_EXPERT is not set
 # CONFIG_FIT is not set
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=0
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev 1; run b_default"
 CONFIG_USE_PREBOOT=y
diff --git a/configs/cgtqmx8_defconfig b/configs/cgtqmx8_defconfig
index 32e0647c93c0..75fc0fcca63e 100644
--- a/configs/cgtqmx8_defconfig
+++ b/configs/cgtqmx8_defconfig
@@ -23,8 +23,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
 CONFIG_LOG=y
diff --git a/configs/cherryhill_defconfig b/configs/cherryhill_defconfig
index 59c3986a2e78..4967be038ae9 100644
--- a/configs/cherryhill_defconfig
+++ b/configs/cherryhill_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index 5394396f8fc6..7d825c73bc44 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -23,8 +23,8 @@ CONFIG_X86_OFFSET_U_BOOT=0xffd00000
 CONFIG_X86_OFFSET_SPL=0xffe80000
 CONFIG_INTEL_ACPIGEN=y
 CONFIG_INTEL_GENERIC_WIFI=y
-CONFIG_BOOTSTD_FULL=y
 CONFIG_SYS_MONITOR_BASE=0x01110000
+CONFIG_BOOTSTD_FULL=y
 CONFIG_CHROMEOS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_SPL_BOOTSTAGE=y
@@ -81,7 +81,6 @@ CONFIG_MAC_PARTITION=y
 # CONFIG_SPL_MAC_PARTITION is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent interrupts linux-name acpi,name acpi,path u-boot,acpi-dsdt-order u-boot,acpi-ssdt-order"
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
index 4347cad33db1..94ffb569e506 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -49,7 +49,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/chromebook_samus_defconfig b/configs/chromebook_samus_defconfig
index 3b6a1732c111..611d649a546a 100644
--- a/configs/chromebook_samus_defconfig
+++ b/configs/chromebook_samus_defconfig
@@ -51,7 +51,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index 9dd29401ef12..8b692bd76ad5 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -1,8 +1,6 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0xffed0000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_TPL_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x3000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x3F8000
@@ -11,6 +9,8 @@ CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="chromebook_samus"
 CONFIG_SPL_TEXT_BASE=0xffe70000
 CONFIG_TPL_TEXT_BASE=0xfffd8100
+CONFIG_TPL_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x3000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_DEBUG_UART_BOARD_INIT=y
@@ -21,7 +21,6 @@ CONFIG_HAVE_MRC=y
 CONFIG_HAVE_REFCODE=y
 CONFIG_SMP=y
 CONFIG_HAVE_VGA_BIOS=y
-CONFIG_X86_OFFSET_U_BOOT=0xffed0000
 CONFIG_SYS_MONITOR_BASE=0xFFED0000
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
@@ -70,7 +69,6 @@ CONFIG_MAC_PARTITION=y
 # CONFIG_SPL_MAC_PARTITION is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebox_panther_defconfig b/configs/chromebox_panther_defconfig
index 4351a811528b..b6b12b47acb6 100644
--- a/configs/chromebox_panther_defconfig
+++ b/configs/chromebox_panther_defconfig
@@ -43,7 +43,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/cm_fx6_defconfig b/configs/cm_fx6_defconfig
index 56527dadd0d0..1a7c8b617e8b 100644
--- a/configs/cm_fx6_defconfig
+++ b/configs/cm_fx6_defconfig
@@ -26,9 +26,10 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_CMD_BMODE is not set
 CONFIG_AHCI=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run legacy_bootcmd"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="usb start;sf probe"
@@ -119,4 +120,3 @@ CONFIG_VIDEO_IPUV3=y
 CONFIG_IMX_HDMI=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SOURCE=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index c7ddb7dd9d28..d2e213c296d3 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -21,9 +21,9 @@ CONFIG_SYS_MEMTEST_END=0x89000000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
 CONFIG_LOG=y
diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 4d4d0e4aaf44..da892c056ef4 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -19,6 +19,7 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=520192
 CONFIG_BOOTDELAY=1
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run ubiboot || run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
@@ -104,5 +105,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig b/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
index 1515246086ea..e1e1afe1cdb2 100644
--- a/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
+++ b/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
@@ -53,7 +53,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/conga-qeval20-qa3-e3845_defconfig b/configs/conga-qeval20-qa3-e3845_defconfig
index d62fb997c993..27d6d4ff8c14 100644
--- a/configs/conga-qeval20-qa3-e3845_defconfig
+++ b/configs/conga-qeval20-qa3-e3845_defconfig
@@ -49,7 +49,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 555d281ef3cf..1f1327f5bfec 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -9,11 +9,11 @@ CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_X86_RUN_64BIT=y
 CONFIG_VENDOR_COREBOOT=y
 CONFIG_TARGET_COREBOOT=y
+CONFIG_SYS_MONITOR_BASE=0x01120000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
-CONFIG_SYS_MONITOR_BASE=0x01120000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index edc38f1f5923..8356bc12659c 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -7,11 +7,11 @@ CONFIG_DEFAULT_DEVICE_TREE="coreboot"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_VENDOR_COREBOOT=y
 CONFIG_TARGET_COREBOOT=y
+CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
-CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
diff --git a/configs/cortina_presidio-asic-emmc_defconfig b/configs/cortina_presidio-asic-emmc_defconfig
index 24caa84c43d1..e6db1b830035 100644
--- a/configs/cortina_presidio-asic-emmc_defconfig
+++ b/configs/cortina_presidio-asic-emmc_defconfig
@@ -19,7 +19,6 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_BOOTDELAY=3
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
diff --git a/configs/cougarcanyon2_defconfig b/configs/cougarcanyon2_defconfig
index 71c79f5fb8da..dd9d912cd37a 100644
--- a/configs/cougarcanyon2_defconfig
+++ b/configs/cougarcanyon2_defconfig
@@ -39,7 +39,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/crownbay_defconfig b/configs/crownbay_defconfig
index e734c758dac8..cef6f822b589 100644
--- a/configs/crownbay_defconfig
+++ b/configs/crownbay_defconfig
@@ -42,7 +42,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/deneb_defconfig b/configs/deneb_defconfig
index 0d714bd313b1..741e8bb159e3 100644
--- a/configs/deneb_defconfig
+++ b/configs/deneb_defconfig
@@ -29,13 +29,13 @@ CONFIG_SYS_LOAD_ADDR=0x80280000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=3
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Autobooting in %d seconds, press \"<Esc><Esc>\" to stop\n"
 CONFIG_AUTOBOOT_STOP_STR="\x1b\x1b"
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="if usrbutton; then run flash_self_test; reset; fi;run flash_self;reset;"
 CONFIG_LOG=y
diff --git a/configs/dfi-bt700-q7x-151_defconfig b/configs/dfi-bt700-q7x-151_defconfig
index 79f5d74ec597..6b5bbc14ab2a 100644
--- a/configs/dfi-bt700-q7x-151_defconfig
+++ b/configs/dfi-bt700-q7x-151_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/display5_factory_defconfig b/configs/display5_factory_defconfig
index a5396f7e54cf..1860a02ec14a 100644
--- a/configs/display5_factory_defconfig
+++ b/configs/display5_factory_defconfig
@@ -31,8 +31,8 @@ CONFIG_SPL_SPI=y
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="echo SDP Display5 recovery"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index 14dff6322155..0a6019d5bdc4 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -20,8 +20,8 @@ CONFIG_ARMV7_LPAE=y
 CONFIG_AHCI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="androidboot.serialno=${serial#} console=ttyS0,115200 androidboot.console=ttyS0 androidboot.hardware=jacinto6evmboard"
 CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index 0d6d9efd4e27..4bc6f415e782 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -23,8 +23,8 @@ CONFIG_ARMV7_LPAE=y
 CONFIG_AHCI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="androidboot.serialno=${serial#} console=ttyS0,115200 androidboot.console=ttyS0 androidboot.hardware=jacinto6evmboard"
 CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 506a65aac3dc..20a72da97d00 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -24,8 +24,8 @@ CONFIG_ARMV7_LPAE=y
 CONFIG_AHCI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="androidboot.serialno=${serial#} console=ttyS0,115200 androidboot.console=ttyS0 androidboot.hardware=jacinto6evmboard"
 CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 84b083464c9c..cc5f60ac3031 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -16,8 +16,8 @@ CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_REMAKE_ELF=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/durian_defconfig b/configs/durian_defconfig
index a5756c16a7cd..dc391edc7aa8 100644
--- a/configs/durian_defconfig
+++ b/configs/durian_defconfig
@@ -20,7 +20,6 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 earlycon=pl011,0x28001000 root=/dev/sda2 rw"
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=280
 CONFIG_SYS_BOOTM_LEN=0x3c00000
diff --git a/configs/ea-lpc3250devkitv2_defconfig b/configs/ea-lpc3250devkitv2_defconfig
index 2b1b032e0b92..d88a2aea5a5e 100644
--- a/configs/ea-lpc3250devkitv2_defconfig
+++ b/configs/ea-lpc3250devkitv2_defconfig
@@ -15,9 +15,9 @@ CONFIG_SYS_PROMPT="EA-LPC3250v2=> "
 CONFIG_SYS_LOAD_ADDR=0x80100000
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=1048575
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_AUTOBOOT is not set
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_CBSIZE=256
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 15323678e314..194a7ab2da35 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -33,7 +33,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 6c6f705b6e03..a06008000d8b 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -16,7 +16,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
@@ -34,7 +33,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_INTERFACE="scsi"
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index 38f26f2dcc57..3747c6369ece 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -16,12 +16,11 @@ CONFIG_TEGRA30=y
 CONFIG_TARGET_ENDEAVORU=y
 CONFIG_CMD_EBTUPDATE=y
 CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_USE_BOOTCOMMAND=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
@@ -44,7 +43,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_NFS is not set
 CONFIG_CMD_PAUSE=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
diff --git a/configs/galileo_defconfig b/configs/galileo_defconfig
index c226ae11a818..3eb1917454d5 100644
--- a/configs/galileo_defconfig
+++ b/configs/galileo_defconfig
@@ -37,7 +37,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index aecd6fbfd625..bedc596910cc 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -29,9 +29,9 @@ CONFIG_BOARD_SIZE_LIMIT=655360
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_STOP_STR="x"
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="cp.b 83000000 84000000 10000 && dhcp uEnv.txt && env import -t ${fileaddr} ${filesize} && run do_u_boot_init; reset"
 CONFIG_USE_PREBOOT=y
diff --git a/configs/gazerbeam_defconfig b/configs/gazerbeam_defconfig
index 7901a195aa71..3c212c767131 100644
--- a/configs/gazerbeam_defconfig
+++ b/configs/gazerbeam_defconfig
@@ -94,11 +94,11 @@ CONFIG_SYS_BARGSIZE=1024
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOOTDELAY=5
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/mmcblk0p3 rw rootwait console=$consoledev,$baudrate $othbootargs;ext2load mmc 0:2 ${kernel_addr} $bootfile;ext2load mmc 0:2 ${fdt_addr} $fdtfile;bootm ${kernel_addr} - ${fdt_addr}"
 # CONFIG_CONSOLE_MUX is not set
diff --git a/configs/ge_b1x5v2_defconfig b/configs/ge_b1x5v2_defconfig
index b3b69a642a49..b760fded8516 100644
--- a/configs/ge_b1x5v2_defconfig
+++ b/configs/ge_b1x5v2_defconfig
@@ -29,8 +29,8 @@ CONFIG_SPL_PAYLOAD="u-boot.img"
 CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run tryboot;"
 CONFIG_DEFAULT_FDT_FILE="imx6dl-b1x5v2.dtb"
diff --git a/configs/ge_bx50v3_defconfig b/configs/ge_bx50v3_defconfig
index 2ef560ccaa49..61f338f37696 100644
--- a/configs/ge_bx50v3_defconfig
+++ b/configs/ge_bx50v3_defconfig
@@ -15,8 +15,8 @@ CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run doquiet; run tryboot"
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
diff --git a/configs/giedi_defconfig b/configs/giedi_defconfig
index 75d5d89823f0..e2ffd7ac7eaf 100644
--- a/configs/giedi_defconfig
+++ b/configs/giedi_defconfig
@@ -29,13 +29,13 @@ CONFIG_SYS_LOAD_ADDR=0x80280000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=3
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Autobooting in %d seconds, press \"<Esc><Esc>\" to stop\n"
 CONFIG_AUTOBOOT_STOP_STR="\x1b\x1b"
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="if usrbutton; then run flash_self_test; reset; fi;run flash_self;reset;"
 CONFIG_LOG=y
diff --git a/configs/grouper_common_defconfig b/configs/grouper_common_defconfig
index 8dc88851f5a9..0a03c8ac7cd4 100644
--- a/configs/grouper_common_defconfig
+++ b/configs/grouper_common_defconfig
@@ -16,12 +16,11 @@ CONFIG_TEGRA30=y
 CONFIG_TARGET_GROUPER=y
 CONFIG_CMD_EBTUPDATE=y
 CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_USE_BOOTCOMMAND=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
@@ -43,7 +42,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_NFS is not set
 CONFIG_CMD_PAUSE=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_defconfig
index 3c558ba7f928..02280dfd708e 100644
--- a/configs/gwventana_emmc_defconfig
+++ b/configs/gwventana_emmc_defconfig
@@ -31,8 +31,9 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="for btype in ${bootdevs}; do echo; echo Attempting ${btype} boot...; if run ${btype}_boot; then; fi; done"
 CONFIG_USE_PREBOOT=y
@@ -176,4 +177,3 @@ CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_HIDE_LOGO_VERSION=y
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_IMX_WATCHDOG=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
diff --git a/configs/gwventana_nand_defconfig b/configs/gwventana_nand_defconfig
index a41a89248714..91248c1aaed5 100644
--- a/configs/gwventana_nand_defconfig
+++ b/configs/gwventana_nand_defconfig
@@ -31,8 +31,9 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="for btype in ${bootdevs}; do echo; echo Attempting ${btype} boot...; if run ${btype}_boot; then; fi; done"
 CONFIG_USE_PREBOOT=y
@@ -183,4 +184,3 @@ CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_HIDE_LOGO_VERSION=y
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_IMX_WATCHDOG=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
diff --git a/configs/highbank_defconfig b/configs/highbank_defconfig
index 4eac7b29fadd..e4764c308132 100644
--- a/configs/highbank_defconfig
+++ b/configs/highbank_defconfig
@@ -16,7 +16,6 @@ CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_ENV_ADDR=0xFFF88000
 CONFIG_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Autobooting in %d seconds...\nPress <s> to stop or <d> to delay\n"
@@ -24,6 +23,7 @@ CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_BOOT_RETRY=y
 CONFIG_BOOT_RETRY_TIME=-1
 CONFIG_RESET_TO_RETRY=y
+CONFIG_OF_BOARD_SETUP=y
 # CONFIG_USE_BOOTCOMMAND is not set
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index a0078e15ef40..8f43dd72e666 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -11,9 +11,10 @@ CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_OMAP3_IGEP00X0=y
 CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
@@ -87,4 +88,3 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_OMAP3_SPI=y
 CONFIG_BCH=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 96d15e89af80..cef7352ad88f 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -27,8 +27,8 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SPL_PAYLOAD="u-boot.img"
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 # CONFIG_BOOTMETH_EXTLINUX is not set
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-cl-iot-gate-optee_defconfig
index 11fdc7ffe81a..19544a93acf4 100644
--- a/configs/imx8mm-cl-iot-gate-optee_defconfig
+++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
@@ -23,8 +23,8 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index bdabb80edbb5..a8a995199258 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -25,8 +25,8 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
index 6d283ec562c6..9a2470d83028 100644
--- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
@@ -22,8 +22,8 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx8mm-icore-mx8mm-ctouch2.dtb"
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
index 38c0c87b22f6..cf2aa15a2e85 100644
--- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
@@ -22,8 +22,8 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx8mm-icore-mx8mm-edimm2.2.dtb"
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index 13bd19515123..509a375328b6 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -29,8 +29,8 @@ CONFIG_SYS_MEMTEST_END=0x80000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="mmc partconf 0 distro_bootpart && load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} boot/fitImage && source ${loadaddr}:bootscr-boot.cmd ; reset"
 CONFIG_DEFAULT_FDT_FILE="imx8mm-mx8menlo.dtb"
 CONFIG_LOG=y
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index ac9810fe1b7a..4f33e10aa593 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -23,8 +23,8 @@ CONFIG_LTO=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 75f0a9502890..739dd4455d16 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -25,8 +25,8 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x25000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index 9fdce5c8b523..74b08005d29b 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -23,8 +23,8 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index a485910a5299..ac9f460d40c2 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -27,9 +27,9 @@ CONFIG_LTO=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="gsc wd-disable"
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index f356b9cc4665..d1449e913a0e 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -24,8 +24,8 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="freescale/imx8mn-bsh-smm-s2.dtb"
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index 57d113102843..e8d9bb90d842 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -25,8 +25,8 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="freescale/imx8mn-bsh-smm-s2pro.dtb"
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 4faeb473fa7d..a141ea8d8a9f 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -23,8 +23,8 @@ CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx8mn-ddr4-evk.dtb"
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 230ce6be3745..de87d906c6f6 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -23,8 +23,8 @@ CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx8mn-evk.dtb"
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index b346b14ebdd2..e958417b9bc3 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -27,9 +27,9 @@ CONFIG_OF_BOARD_FIXUP=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DEFAULT_FDT_FILE="freescale/imx8mn-var-som-symphony.dtb"
 CONFIG_BOARD_TYPES=y
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 39f930ae2cae..aa84053178aa 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -28,9 +28,9 @@ CONFIG_LTO=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="gsc wd-disable"
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index 494be362172d..204b98350ea5 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -26,8 +26,8 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx8mp-icore-mx8mp-edimm2.2.dtb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x26000
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index c6a3e35e73a3..c5b5b500c327 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -39,8 +39,8 @@ CONFIG_LTO=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-beacon-kit.dtb"
 # CONFIG_SYS_DEVICE_NULLDEV is not set
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 73e30db4eedc..a60b869c0f91 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -26,8 +26,8 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x26000
diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb3720a1_4G_defconfig
index 02ce80c7832d..536c3c67731e 100644
--- a/configs/imx8mp_rsb3720a1_4G_defconfig
+++ b/configs/imx8mp_rsb3720a1_4G_defconfig
@@ -32,9 +32,9 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DEFAULT_FDT_FILE="imx8mp-rsb3720-a1.dtb"
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb3720a1_6G_defconfig
index d0bf25a6f5f5..bae5cbe7eff3 100644
--- a/configs/imx8mp_rsb3720a1_6G_defconfig
+++ b/configs/imx8mp_rsb3720a1_6G_defconfig
@@ -32,9 +32,9 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DEFAULT_FDT_FILE="imx8mp-rsb3720-a1.dtb"
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 294206ba8b26..8e3e5ff895a4 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -28,9 +28,9 @@ CONFIG_LTO=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="gsc wd-disable"
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mq_cm_defconfig b/configs/imx8mq_cm_defconfig
index 89a7485bd1d8..1be9380d274c 100644
--- a/configs/imx8mq_cm_defconfig
+++ b/configs/imx8mq_cm_defconfig
@@ -26,8 +26,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_PRINT=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x1f000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 7b135bf9fad2..a7b40b042d02 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -28,8 +28,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x1f000
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index 114ddab10b4c..cbb6afa76bed 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -27,8 +27,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_SD_BOOT=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index a17a180d433c..7da7d01639e7 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -28,8 +28,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="freescale/imx8mq-mnt-reform2.dtb"
 CONFIG_CONSOLE_MUX=y
diff --git a/configs/imx8qm_dmsse20a1_defconfig b/configs/imx8qm_dmsse20a1_defconfig
index 70f7b378d5f8..01eabc43fb37 100644
--- a/configs/imx8qm_dmsse20a1_defconfig
+++ b/configs/imx8qm_dmsse20a1_defconfig
@@ -26,8 +26,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
 CONFIG_LOG=y
diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
index 7f7a20e5a2f9..95b1d831485a 100644
--- a/configs/imx8qm_mek_defconfig
+++ b/configs/imx8qm_mek_defconfig
@@ -26,9 +26,9 @@ CONFIG_SYS_LOAD_ADDR=0x80280000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if test ${sec_boot} = yes; then if run loadcntr; then run mmcboot; else run netboot; fi; else if run loadimage; then run mmcboot; else run netboot; fi; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
 CONFIG_LOG=y
diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconfig
index f34b988c2e10..183f4fd0bbe9 100644
--- a/configs/imx8qxp_mek_defconfig
+++ b/configs/imx8qxp_mek_defconfig
@@ -26,9 +26,9 @@ CONFIG_SYS_LOAD_ADDR=0x80280000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if test ${sec_boot} = yes; then if run loadcntr; then run mmcboot; else run netboot; fi; else if run loadimage; then run mmcboot; else run netboot; fi; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
 CONFIG_LOG=y
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index bcbaa92ee89b..56acd8b2791e 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -30,8 +30,6 @@ CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_SHOW_BOOT_PROGRESS=y
@@ -40,6 +38,8 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_FLUSH_STDIN=y
 CONFIG_AUTOBOOT_PROMPT="Hit SPACE to stop autoboot in %d seconds...\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="run start_watchdog; run distro_bootcmd"
 CONFIG_CONSOLE_MUX=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index ba5914d3b605..78f2f8a39b62 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -30,9 +30,9 @@ CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
 CONFIG_LOGLEVEL=7
 CONFIG_SPL_MAX_SIZE=0xc0000
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 214fa8b2f35d..b685c1fdb3d7 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -30,9 +30,9 @@ CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
 CONFIG_LOGLEVEL=7
 CONFIG_SPL_MAX_SIZE=0xc0000
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 09addcbb25df..2bd935221c77 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -30,8 +30,8 @@ CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
 CONFIG_LOGLEVEL=7
 CONFIG_SPL_MAX_SIZE=0xc0000
diff --git a/configs/k2e_evm_defconfig b/configs/k2e_evm_defconfig
index 44bed00ec973..d0410a46f94a 100644
--- a/configs/k2e_evm_defconfig
+++ b/configs/k2e_evm_defconfig
@@ -26,8 +26,8 @@ CONFIG_SPL=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_TIMESTAMP=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run init_${boot}; run get_mon_${boot} run_mon; run get_kern_${boot}; run init_fw_rd_${boot}; run get_fdt_${boot}; run run_kern"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/k2e_hs_evm_defconfig b/configs/k2e_hs_evm_defconfig
index 55c0182f8749..39086bed2340 100644
--- a/configs/k2e_hs_evm_defconfig
+++ b/configs/k2e_hs_evm_defconfig
@@ -17,8 +17,8 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="keystone-k2e-evm"
 CONFIG_TIMESTAMP=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run run_mon_hs; run init_${boot}; run get_fit_${boot}; bootm ${addr_fit}#${name_fdt}"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/k2g_evm_defconfig b/configs/k2g_evm_defconfig
index 45c7fade320d..2dc8fe1ed463 100644
--- a/configs/k2g_evm_defconfig
+++ b/configs/k2g_evm_defconfig
@@ -25,8 +25,8 @@ CONFIG_SPL=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_TIMESTAMP=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run envboot; run init_${boot}; run get_mon_${boot} run_mon; run set_name_pmmc get_pmmc_${boot} run_pmmc; run get_kern_${boot}; run init_fw_rd_${boot}; run get_fdt_${boot}; run run_kern"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/k2g_hs_evm_defconfig b/configs/k2g_hs_evm_defconfig
index 54a980cab547..f55c21b5f19c 100644
--- a/configs/k2g_hs_evm_defconfig
+++ b/configs/k2g_hs_evm_defconfig
@@ -16,8 +16,8 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="keystone-k2g-evm"
 CONFIG_TIMESTAMP=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run envboot; run run_mon_hs; run init_${boot}; run get_fit_${boot}; bootm ${addr_fit}#${name_fdt}"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/k2hk_evm_defconfig b/configs/k2hk_evm_defconfig
index a26517804846..8b7e0179a836 100644
--- a/configs/k2hk_evm_defconfig
+++ b/configs/k2hk_evm_defconfig
@@ -26,8 +26,8 @@ CONFIG_SPL=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_TIMESTAMP=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run init_${boot}; run get_mon_${boot} run_mon; run get_kern_${boot}; run init_fw_rd_${boot}; run get_fdt_${boot}; run run_kern"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/k2hk_hs_evm_defconfig b/configs/k2hk_hs_evm_defconfig
index 8c0472dcc2b9..604042e1c5da 100644
--- a/configs/k2hk_hs_evm_defconfig
+++ b/configs/k2hk_hs_evm_defconfig
@@ -17,8 +17,8 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="keystone-k2hk-evm"
 CONFIG_TIMESTAMP=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run run_mon_hs; run init_${boot}; run get_fit_${boot}; bootm ${addr_fit}#${name_fdt}"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/k2l_evm_defconfig b/configs/k2l_evm_defconfig
index 55ddd3cce96a..dbc3226de71d 100644
--- a/configs/k2l_evm_defconfig
+++ b/configs/k2l_evm_defconfig
@@ -26,8 +26,8 @@ CONFIG_SPL=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_TIMESTAMP=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run init_${boot}; run get_mon_${boot} run_mon; run get_kern_${boot}; run init_fw_rd_${boot}; run get_fdt_${boot}; run run_kern"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/kmcent2_defconfig b/configs/kmcent2_defconfig
index 0faf3ffef939..2cf9565fc9da 100644
--- a/configs/kmcent2_defconfig
+++ b/configs/kmcent2_defconfig
@@ -21,11 +21,11 @@ CONFIG_PCIE1=y
 CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_KM_IVM_BUS=2
 CONFIG_MP=y
+CONFIG_SYS_MONITOR_BASE=0xEBF40000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SYS_MONITOR_BASE=0xEBF40000
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_LAST_STAGE_INIT=y
diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
index 08494453d9d6..257ceeca90d7 100644
--- a/configs/kmcoge5ne_defconfig
+++ b/configs/kmcoge5ne_defconfig
@@ -122,11 +122,11 @@ CONFIG_LCRR_EADC_2=y
 CONFIG_LCRR_CLKDIV_4=y
 CONFIG_83XX_PCICLK=0x3ef1480
 # CONFIG_PCI is not set
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_HWCONFIG is not set
 CONFIG_LAST_STAGE_INIT=y
diff --git a/configs/kmeter1_defconfig b/configs/kmeter1_defconfig
index 834e040e2875..46e0370e35b2 100644
--- a/configs/kmeter1_defconfig
+++ b/configs/kmeter1_defconfig
@@ -102,11 +102,11 @@ CONFIG_LCRR_DBYP_PLL_BYPASSED=y
 CONFIG_LCRR_EADC_2=y
 CONFIG_LCRR_CLKDIV_4=y
 # CONFIG_PCI is not set
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_HWCONFIG is not set
 CONFIG_LAST_STAGE_INIT=y
diff --git a/configs/kmopti2_defconfig b/configs/kmopti2_defconfig
index c6fbd3941371..c6c021addef6 100644
--- a/configs/kmopti2_defconfig
+++ b/configs/kmopti2_defconfig
@@ -110,11 +110,11 @@ CONFIG_LCRR_EADC_1=y
 CONFIG_LCRR_CLKDIV_2=y
 CONFIG_83XX_PCICLK=0x3ef1480
 # CONFIG_PCI is not set
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_HWCONFIG is not set
 CONFIG_LAST_STAGE_INIT=y
diff --git a/configs/kmsupx5_defconfig b/configs/kmsupx5_defconfig
index 433f6a16b05d..25642e70185b 100644
--- a/configs/kmsupx5_defconfig
+++ b/configs/kmsupx5_defconfig
@@ -96,11 +96,11 @@ CONFIG_LCRR_EADC_1=y
 CONFIG_LCRR_CLKDIV_2=y
 CONFIG_83XX_PCICLK=0x3ef1480
 # CONFIG_PCI is not set
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_HWCONFIG is not set
 CONFIG_LAST_STAGE_INIT=y
diff --git a/configs/kmtepr2_defconfig b/configs/kmtepr2_defconfig
index a8adde1ced00..ea37a290605f 100644
--- a/configs/kmtepr2_defconfig
+++ b/configs/kmtepr2_defconfig
@@ -110,11 +110,11 @@ CONFIG_LCRR_EADC_1=y
 CONFIG_LCRR_CLKDIV_2=y
 CONFIG_83XX_PCICLK=0x3ef1480
 # CONFIG_PCI is not set
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_HWCONFIG is not set
 CONFIG_LAST_STAGE_INIT=y
diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index d54e60395d21..e5e0d16fbc23 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -25,8 +25,9 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_BOARD_TYPES=y
 CONFIG_BOARD_EARLY_INIT_F=y
@@ -107,4 +108,3 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 9558cf1a2d14..ae9337f3e4dd 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -29,8 +29,8 @@ CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOARD_TYPES=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index 295cc51c4fd7..97a87ddccf93 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -27,8 +27,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_PRINT=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index 21a397933e7f..3b33272b70a1 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -33,10 +33,10 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=3
 CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOARD_LATE_INIT=y
 # CONFIG_HWCONFIG is not set
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index 973b2ea20c41..129f5227454f 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -28,9 +28,9 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=0
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_SYS_DEVICE_NULLDEV is not set
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1012a2g5rdb_qspi_defconfig b/configs/ls1012a2g5rdb_qspi_defconfig
index 72b590a73b4c..da3938bb811e 100644
--- a/configs/ls1012a2g5rdb_qspi_defconfig
+++ b/configs/ls1012a2g5rdb_qspi_defconfig
@@ -19,11 +19,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run qspi_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1012a2g5rdb_tfa_defconfig b/configs/ls1012a2g5rdb_tfa_defconfig
index a99afe3ff95a..199f36a5023d 100644
--- a/configs/ls1012a2g5rdb_tfa_defconfig
+++ b/configs/ls1012a2g5rdb_tfa_defconfig
@@ -19,10 +19,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/ls1012afrdm_qspi_defconfig b/configs/ls1012afrdm_qspi_defconfig
index 7e12f6ef546b..70447238d369 100644
--- a/configs/ls1012afrdm_qspi_defconfig
+++ b/configs/ls1012afrdm_qspi_defconfig
@@ -19,11 +19,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 CONFIG_BOOTCOMMAND="run distro_bootcmd;run qspi_bootcmd"
diff --git a/configs/ls1012afrdm_tfa_defconfig b/configs/ls1012afrdm_tfa_defconfig
index 3c9a748a3f16..ec900bd53fb2 100644
--- a/configs/ls1012afrdm_tfa_defconfig
+++ b/configs/ls1012afrdm_tfa_defconfig
@@ -19,10 +19,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig b/configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig
index 4e5079dcc492..199b7d687fbf 100644
--- a/configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig
+++ b/configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig
@@ -19,11 +19,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run sd_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1012afrwy_qspi_defconfig b/configs/ls1012afrwy_qspi_defconfig
index b944f803f70c..8cacc4048990 100644
--- a/configs/ls1012afrwy_qspi_defconfig
+++ b/configs/ls1012afrwy_qspi_defconfig
@@ -21,11 +21,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run sd_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
index 56dcbccffea2..5e95c6ed1b39 100644
--- a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
@@ -19,10 +19,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/ls1012afrwy_tfa_defconfig b/configs/ls1012afrwy_tfa_defconfig
index 90083fa31660..d10886f08e42 100644
--- a/configs/ls1012afrwy_tfa_defconfig
+++ b/configs/ls1012afrwy_tfa_defconfig
@@ -20,10 +20,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/ls1012aqds_qspi_defconfig b/configs/ls1012aqds_qspi_defconfig
index 34bdb1abafc7..7262681e7751 100644
--- a/configs/ls1012aqds_qspi_defconfig
+++ b/configs/ls1012aqds_qspi_defconfig
@@ -23,11 +23,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run qspi_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
index dc0f1c5510f3..06aaa42c9ea6 100644
--- a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
@@ -21,10 +21,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1012aqds_tfa_defconfig b/configs/ls1012aqds_tfa_defconfig
index 7884f388dc68..594ad12e0d0c 100644
--- a/configs/ls1012aqds_tfa_defconfig
+++ b/configs/ls1012aqds_tfa_defconfig
@@ -23,10 +23,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1012ardb_qspi_SECURE_BOOT_defconfig b/configs/ls1012ardb_qspi_SECURE_BOOT_defconfig
index dcd18b4eb8cc..9fa375a1a01c 100644
--- a/configs/ls1012ardb_qspi_SECURE_BOOT_defconfig
+++ b/configs/ls1012ardb_qspi_SECURE_BOOT_defconfig
@@ -20,11 +20,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run qspi_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1012ardb_qspi_defconfig b/configs/ls1012ardb_qspi_defconfig
index 10fe826f99a0..0bfd069f7d8b 100644
--- a/configs/ls1012ardb_qspi_defconfig
+++ b/configs/ls1012ardb_qspi_defconfig
@@ -22,11 +22,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run qspi_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
index 336692b37812..ac2c9cc20f38 100644
--- a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
@@ -20,10 +20,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1012ardb_tfa_defconfig b/configs/ls1012ardb_tfa_defconfig
index 647e8ea2d9b6..cc0f0461688a 100644
--- a/configs/ls1012ardb_tfa_defconfig
+++ b/configs/ls1012ardb_tfa_defconfig
@@ -21,10 +21,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/ls1021aiot_qspi_defconfig b/configs/ls1021aiot_qspi_defconfig
index 0c72f8a1c8ab..c705345eccc1 100644
--- a/configs/ls1021aiot_qspi_defconfig
+++ b/configs/ls1021aiot_qspi_defconfig
@@ -19,9 +19,9 @@ CONFIG_AHCI=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
+CONFIG_QSPI_BOOT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_QSPI_BOOT=y
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index b271792570e6..5e600bf8cfc3 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -26,13 +26,13 @@ CONFIG_AHCI=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021aiot/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021aiot/ls102xa_rcw_sd.cfg"
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1021aqds_ddr4_nor_defconfig b/configs/ls1021aqds_ddr4_nor_defconfig
index b28ae07c6ec7..5a4c3644bcab 100644
--- a/configs/ls1021aqds_ddr4_nor_defconfig
+++ b/configs/ls1021aqds_ddr4_nor_defconfig
@@ -24,12 +24,12 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=3
 CONFIG_SILENT_CONSOLE=y
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1021aqds_ddr4_nor_lpuart_defconfig b/configs/ls1021aqds_ddr4_nor_lpuart_defconfig
index 136246bb9fd5..094a7b1d03c8 100644
--- a/configs/ls1021aqds_ddr4_nor_lpuart_defconfig
+++ b/configs/ls1021aqds_ddr4_nor_lpuart_defconfig
@@ -24,12 +24,12 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=3
 CONFIG_SILENT_CONSOLE=y
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1021aqds_nand_defconfig b/configs/ls1021aqds_nand_defconfig
index ee569eaac6c6..8a794c7af851 100644
--- a/configs/ls1021aqds_nand_defconfig
+++ b/configs/ls1021aqds_nand_defconfig
@@ -32,16 +32,16 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021aqds/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021aqds/ls102xa_rcw_nand.cfg"
 CONFIG_NAND_BOOT=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SILENT_CONSOLE=y
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
index 78eb747319d3..a3ed4cf359fa 100644
--- a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
+++ b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
@@ -24,12 +24,12 @@ CONFIG_FSL_QIXIS=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=3
 CONFIG_SILENT_CONSOLE=y
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1021aqds_nor_defconfig b/configs/ls1021aqds_nor_defconfig
index 04223a999bb7..07f47fa1d761 100644
--- a/configs/ls1021aqds_nor_defconfig
+++ b/configs/ls1021aqds_nor_defconfig
@@ -24,12 +24,12 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=3
 CONFIG_SILENT_CONSOLE=y
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1021aqds_nor_lpuart_defconfig b/configs/ls1021aqds_nor_lpuart_defconfig
index 3a7bc406ab45..c6b0fc4937d3 100644
--- a/configs/ls1021aqds_nor_lpuart_defconfig
+++ b/configs/ls1021aqds_nor_lpuart_defconfig
@@ -24,12 +24,12 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=3
 CONFIG_SILENT_CONSOLE=y
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1021aqds_qspi_defconfig b/configs/ls1021aqds_qspi_defconfig
index cfb6bcf02363..008c49b157dd 100644
--- a/configs/ls1021aqds_qspi_defconfig
+++ b/configs/ls1021aqds_qspi_defconfig
@@ -25,10 +25,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SILENT_CONSOLE=y
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1021aqds_sdcard_ifc_defconfig b/configs/ls1021aqds_sdcard_ifc_defconfig
index 25bd6c72a55d..59836a69cc08 100644
--- a/configs/ls1021aqds_sdcard_ifc_defconfig
+++ b/configs/ls1021aqds_sdcard_ifc_defconfig
@@ -33,9 +33,9 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021aqds/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021aqds/ls102xa_rcw_sd_ifc.cfg"
diff --git a/configs/ls1021atsn_qspi_defconfig b/configs/ls1021atsn_qspi_defconfig
index f0ab507d0657..a1faabd266ba 100644
--- a/configs/ls1021atsn_qspi_defconfig
+++ b/configs/ls1021atsn_qspi_defconfig
@@ -19,11 +19,11 @@ CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_FIT=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SILENT_CONSOLE=y
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1021atsn_sdcard_defconfig b/configs/ls1021atsn_sdcard_defconfig
index 7a8b157926b0..ffabfdb87102 100644
--- a/configs/ls1021atsn_sdcard_defconfig
+++ b/configs/ls1021atsn_sdcard_defconfig
@@ -26,8 +26,6 @@ CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_FIT=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021atsn/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021atsn/ls102xa_rcw_sd.cfg"
@@ -35,6 +33,8 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SILENT_CONSOLE=y
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1021atwr_nor_SECURE_BOOT_defconfig b/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
index dcb48c33e5f6..9afa09be7190 100644
--- a/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
@@ -23,10 +23,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nor_bootcmd;env exists secureboot && esbc_halt;"
diff --git a/configs/ls1021atwr_nor_defconfig b/configs/ls1021atwr_nor_defconfig
index 61e9edfcc412..d476f2ba3f41 100644
--- a/configs/ls1021atwr_nor_defconfig
+++ b/configs/ls1021atwr_nor_defconfig
@@ -23,10 +23,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nor_bootcmd;env exists secureboot && esbc_halt;"
diff --git a/configs/ls1021atwr_nor_lpuart_defconfig b/configs/ls1021atwr_nor_lpuart_defconfig
index 9975f6a73e96..f6a2def2a225 100644
--- a/configs/ls1021atwr_nor_lpuart_defconfig
+++ b/configs/ls1021atwr_nor_lpuart_defconfig
@@ -23,10 +23,10 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nor_bootcmd;env exists secureboot && esbc_halt;"
diff --git a/configs/ls1021atwr_qspi_defconfig b/configs/ls1021atwr_qspi_defconfig
index 2e7d78687805..c654320a8a73 100644
--- a/configs/ls1021atwr_qspi_defconfig
+++ b/configs/ls1021atwr_qspi_defconfig
@@ -23,11 +23,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run qspi_bootcmd; env exists secureboot && esbc_halt"
diff --git a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
index 4a42427b001f..c7021ea4a534 100644
--- a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
@@ -31,14 +31,14 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021atwr/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021atwr/ls102xa_rcw_sd_ifc.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=0
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run sd_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1021atwr_sdcard_ifc_defconfig b/configs/ls1021atwr_sdcard_ifc_defconfig
index 34b229e6f23f..9d5fc6a2f747 100644
--- a/configs/ls1021atwr_sdcard_ifc_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_defconfig
@@ -31,14 +31,14 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021atwr/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021atwr/ls102xa_rcw_sd_ifc.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run sd_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1021atwr_sdcard_qspi_defconfig b/configs/ls1021atwr_sdcard_qspi_defconfig
index 3738107321fb..be9a0692e48d 100644
--- a/configs/ls1021atwr_sdcard_qspi_defconfig
+++ b/configs/ls1021atwr_sdcard_qspi_defconfig
@@ -31,8 +31,6 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021atwr/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021atwr/ls102xa_rcw_sd_qspi.cfg"
@@ -40,6 +38,8 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run qspi_bootcmd; env exists secureboot && esbc_halt"
diff --git a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
index 63c550617d11..5bf649a27f1c 100644
--- a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
@@ -24,10 +24,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1028aqds_tfa_defconfig b/configs/ls1028aqds_tfa_defconfig
index 149bc578cba6..c36e1167b7ff 100644
--- a/configs/ls1028aqds_tfa_defconfig
+++ b/configs/ls1028aqds_tfa_defconfig
@@ -26,10 +26,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1028aqds_tfa_lpuart_defconfig b/configs/ls1028aqds_tfa_lpuart_defconfig
index 4750a57ff8e3..0691c01f8ae5 100644
--- a/configs/ls1028aqds_tfa_lpuart_defconfig
+++ b/configs/ls1028aqds_tfa_lpuart_defconfig
@@ -25,10 +25,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
index 9be2f327fd4d..a3d936b33717 100644
--- a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
@@ -24,10 +24,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
 CONFIG_ID_EEPROM=y
diff --git a/configs/ls1028ardb_tfa_defconfig b/configs/ls1028ardb_tfa_defconfig
index d1581878f6ce..de893ff9b63a 100644
--- a/configs/ls1028ardb_tfa_defconfig
+++ b/configs/ls1028ardb_tfa_defconfig
@@ -26,10 +26,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
 CONFIG_ID_EEPROM=y
diff --git a/configs/ls1043aqds_defconfig b/configs/ls1043aqds_defconfig
index 18bf4bd8792c..6626761fc5bc 100644
--- a/configs/ls1043aqds_defconfig
+++ b/configs/ls1043aqds_defconfig
@@ -33,11 +33,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043aqds_lpuart_defconfig b/configs/ls1043aqds_lpuart_defconfig
index 9dcbe71ad0c1..9b41cffbdff7 100644
--- a/configs/ls1043aqds_lpuart_defconfig
+++ b/configs/ls1043aqds_lpuart_defconfig
@@ -33,11 +33,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043aqds_nand_defconfig b/configs/ls1043aqds_nand_defconfig
index e5f570a3b3c1..9f0deafe89c7 100644
--- a/configs/ls1043aqds_nand_defconfig
+++ b/configs/ls1043aqds_nand_defconfig
@@ -40,15 +40,15 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1043aqds/ls1043aqds_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1043aqds/ls1043aqds_rcw_nand.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_NAND_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043aqds_nor_ddr3_defconfig b/configs/ls1043aqds_nor_ddr3_defconfig
index 67d8288abb00..f45e71480ea1 100644
--- a/configs/ls1043aqds_nor_ddr3_defconfig
+++ b/configs/ls1043aqds_nor_ddr3_defconfig
@@ -33,11 +33,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043aqds_qspi_defconfig b/configs/ls1043aqds_qspi_defconfig
index fa0b47fde8c4..deac2ec907ca 100644
--- a/configs/ls1043aqds_qspi_defconfig
+++ b/configs/ls1043aqds_qspi_defconfig
@@ -33,12 +33,12 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043aqds_sdcard_ifc_defconfig b/configs/ls1043aqds_sdcard_ifc_defconfig
index 6cb961d33dcc..0a47f72052c4 100644
--- a/configs/ls1043aqds_sdcard_ifc_defconfig
+++ b/configs/ls1043aqds_sdcard_ifc_defconfig
@@ -41,15 +41,15 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1043aqds/ls1043aqds_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1043aqds/ls1043aqds_rcw_sd_ifc.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043aqds_sdcard_qspi_defconfig b/configs/ls1043aqds_sdcard_qspi_defconfig
index 4e41508251da..e921db9a09ac 100644
--- a/configs/ls1043aqds_sdcard_qspi_defconfig
+++ b/configs/ls1043aqds_sdcard_qspi_defconfig
@@ -40,9 +40,8 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1043aqds/ls1043aqds_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1043aqds/ls1043aqds_rcw_sd_qspi.cfg"
@@ -50,6 +49,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
index 3e1d2347ecfa..8bb93d56667c 100644
--- a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
@@ -31,11 +31,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043aqds_tfa_defconfig b/configs/ls1043aqds_tfa_defconfig
index 2c5016278d5a..59ee11ed6157 100644
--- a/configs/ls1043aqds_tfa_defconfig
+++ b/configs/ls1043aqds_tfa_defconfig
@@ -33,11 +33,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043ardb_SECURE_BOOT_defconfig b/configs/ls1043ardb_SECURE_BOOT_defconfig
index ea195d7c5041..420918382924 100644
--- a/configs/ls1043ardb_SECURE_BOOT_defconfig
+++ b/configs/ls1043ardb_SECURE_BOOT_defconfig
@@ -24,9 +24,9 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nor_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1043ardb_defconfig b/configs/ls1043ardb_defconfig
index ae8600ffd958..fc583bb216bb 100644
--- a/configs/ls1043ardb_defconfig
+++ b/configs/ls1043ardb_defconfig
@@ -25,9 +25,9 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nor_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1043ardb_nand_SECURE_BOOT_defconfig b/configs/ls1043ardb_nand_SECURE_BOOT_defconfig
index d9ff0fd16a58..409a34463257 100644
--- a/configs/ls1043ardb_nand_SECURE_BOOT_defconfig
+++ b/configs/ls1043ardb_nand_SECURE_BOOT_defconfig
@@ -28,13 +28,13 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1043ardb/ls1043ardb_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1043ardb/ls1043ardb_rcw_nand.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_NAND_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043ardb_nand_defconfig b/configs/ls1043ardb_nand_defconfig
index ad118187432e..868ef422d5cf 100644
--- a/configs/ls1043ardb_nand_defconfig
+++ b/configs/ls1043ardb_nand_defconfig
@@ -32,13 +32,13 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1043ardb/ls1043ardb_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1043ardb/ls1043ardb_rcw_nand.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_NAND_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig b/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
index fe0dd04f1f90..e3da5c606c77 100644
--- a/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
+++ b/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
@@ -29,13 +29,13 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1043ardb/ls1043ardb_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1043ardb/ls1043ardb_rcw_sd.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run sd_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1043ardb_sdcard_defconfig b/configs/ls1043ardb_sdcard_defconfig
index aa5404cbb50e..f30081f25f5c 100644
--- a/configs/ls1043ardb_sdcard_defconfig
+++ b/configs/ls1043ardb_sdcard_defconfig
@@ -33,13 +33,13 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1043ardb/ls1043ardb_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1043ardb/ls1043ardb_rcw_sd.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run sd_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
index 480e928936a9..72685a2eef88 100644
--- a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
@@ -24,9 +24,9 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1043ardb_tfa_defconfig b/configs/ls1043ardb_tfa_defconfig
index e25904170858..21518d220434 100644
--- a/configs/ls1043ardb_tfa_defconfig
+++ b/configs/ls1043ardb_tfa_defconfig
@@ -26,9 +26,9 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig b/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
index d280cf8e6b9a..6f1d71b49af1 100644
--- a/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
@@ -22,8 +22,8 @@ CONFIG_FSL_USE_PCA9547_MUX=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1046afrwy_tfa_defconfig b/configs/ls1046afrwy_tfa_defconfig
index 207f4113975c..b58d98907429 100644
--- a/configs/ls1046afrwy_tfa_defconfig
+++ b/configs/ls1046afrwy_tfa_defconfig
@@ -24,9 +24,9 @@ CONFIG_FSL_USE_PCA9547_MUX=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1046aqds_SECURE_BOOT_defconfig b/configs/ls1046aqds_SECURE_BOOT_defconfig
index 5bdcc868ba20..8d19ca07622b 100644
--- a/configs/ls1046aqds_SECURE_BOOT_defconfig
+++ b/configs/ls1046aqds_SECURE_BOOT_defconfig
@@ -32,11 +32,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nor_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046aqds_defconfig b/configs/ls1046aqds_defconfig
index 51aa5dcbf504..4c00252d64c5 100644
--- a/configs/ls1046aqds_defconfig
+++ b/configs/ls1046aqds_defconfig
@@ -33,11 +33,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nor_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046aqds_lpuart_defconfig b/configs/ls1046aqds_lpuart_defconfig
index 9c1df2416aa5..018b97c002e0 100644
--- a/configs/ls1046aqds_lpuart_defconfig
+++ b/configs/ls1046aqds_lpuart_defconfig
@@ -33,11 +33,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nor_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046aqds_nand_defconfig b/configs/ls1046aqds_nand_defconfig
index 95616f970549..3487d0611b8c 100644
--- a/configs/ls1046aqds_nand_defconfig
+++ b/configs/ls1046aqds_nand_defconfig
@@ -40,15 +40,15 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1046aqds/ls1046aqds_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1046aqds/ls1046aqds_rcw_nand.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_NAND_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nand_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046aqds_qspi_defconfig b/configs/ls1046aqds_qspi_defconfig
index f3796f3771f2..c69427b3275f 100644
--- a/configs/ls1046aqds_qspi_defconfig
+++ b/configs/ls1046aqds_qspi_defconfig
@@ -33,12 +33,12 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:2m(uboot),14m(free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run nor_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046aqds_sdcard_ifc_defconfig b/configs/ls1046aqds_sdcard_ifc_defconfig
index 179fa70f4ee2..c1cad2325b18 100644
--- a/configs/ls1046aqds_sdcard_ifc_defconfig
+++ b/configs/ls1046aqds_sdcard_ifc_defconfig
@@ -41,15 +41,15 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1046aqds/ls1046aqds_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1046aqds/ls1046aqds_rcw_sd_ifc.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run sd_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046aqds_sdcard_qspi_defconfig b/configs/ls1046aqds_sdcard_qspi_defconfig
index b571eaadf629..8a3fd1c5526a 100644
--- a/configs/ls1046aqds_sdcard_qspi_defconfig
+++ b/configs/ls1046aqds_sdcard_qspi_defconfig
@@ -40,9 +40,8 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1046aqds/ls1046aqds_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1046aqds/ls1046aqds_rcw_sd_qspi.cfg"
@@ -50,6 +49,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:2m(uboot),14m(free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run sd_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
index 9cb79e13514b..9f4e2bf18aee 100644
--- a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
@@ -31,11 +31,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1046aqds_tfa_defconfig b/configs/ls1046aqds_tfa_defconfig
index fde56590a43f..fb8737945bbc 100644
--- a/configs/ls1046aqds_tfa_defconfig
+++ b/configs/ls1046aqds_tfa_defconfig
@@ -33,11 +33,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1046ardb_emmc_defconfig b/configs/ls1046ardb_emmc_defconfig
index 924ff78b4593..c4743a9111e8 100644
--- a/configs/ls1046ardb_emmc_defconfig
+++ b/configs/ls1046ardb_emmc_defconfig
@@ -33,13 +33,13 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1046ardb/ls1046ardb_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1046ardb/ls1046ardb_rcw_emmc.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1046ardb_qspi_SECURE_BOOT_defconfig b/configs/ls1046ardb_qspi_SECURE_BOOT_defconfig
index bb278845e069..12bcbe177ecf 100644
--- a/configs/ls1046ardb_qspi_SECURE_BOOT_defconfig
+++ b/configs/ls1046ardb_qspi_SECURE_BOOT_defconfig
@@ -25,13 +25,13 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1046ardb/ls1046ardb_qspi_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1046ardb/ls1046ardb_rcw_qspi.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run qspi_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046ardb_qspi_defconfig b/configs/ls1046ardb_qspi_defconfig
index 0fb1a6c281e5..ee9fe73abc40 100644
--- a/configs/ls1046ardb_qspi_defconfig
+++ b/configs/ls1046ardb_qspi_defconfig
@@ -27,13 +27,13 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1046ardb/ls1046ardb_qspi_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1046ardb/ls1046ardb_rcw_qspi.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run qspi_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046ardb_qspi_spl_defconfig b/configs/ls1046ardb_qspi_spl_defconfig
index eb0184c59276..a5509ee5a1db 100644
--- a/configs/ls1046ardb_qspi_spl_defconfig
+++ b/configs/ls1046ardb_qspi_spl_defconfig
@@ -36,13 +36,13 @@ CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1046ardb/ls1046ardb_qspi_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1046ardb/ls1046ardb_rcw_qspi.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd; run qspi_bootcmd; env exists secureboot && esbc_halt;;"
diff --git a/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig b/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
index 2813c79f5975..70c0c4221e9b 100644
--- a/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
+++ b/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
@@ -32,13 +32,13 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1046ardb/ls1046ardb_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1046ardb/ls1046ardb_rcw_sd.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd;run sd_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1046ardb_sdcard_defconfig b/configs/ls1046ardb_sdcard_defconfig
index a621859aa792..166eab5cf03b 100644
--- a/configs/ls1046ardb_sdcard_defconfig
+++ b/configs/ls1046ardb_sdcard_defconfig
@@ -33,13 +33,13 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1046ardb/ls1046ardb_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1046ardb/ls1046ardb_rcw_sd.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_BOOTCOMMAND="run distro_bootcmd;run sd_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
index fbcf294eb534..0c73b3b0eca8 100644
--- a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
@@ -25,9 +25,9 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1046ardb_tfa_defconfig b/configs/ls1046ardb_tfa_defconfig
index 24a54230f8ee..dffb052d3cc1 100644
--- a/configs/ls1046ardb_tfa_defconfig
+++ b/configs/ls1046ardb_tfa_defconfig
@@ -27,9 +27,9 @@ CONFIG_PCIE3=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/ls1088aqds_defconfig b/configs/ls1088aqds_defconfig
index f53fbad3d316..0b97a854e0e9 100644
--- a/configs/ls1088aqds_defconfig
+++ b/configs/ls1088aqds_defconfig
@@ -26,10 +26,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/ls1088aqds_qspi_SECURE_BOOT_defconfig b/configs/ls1088aqds_qspi_SECURE_BOOT_defconfig
index 921240cd149e..ea0a0eee2a60 100644
--- a/configs/ls1088aqds_qspi_SECURE_BOOT_defconfig
+++ b/configs/ls1088aqds_qspi_SECURE_BOOT_defconfig
@@ -27,10 +27,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="sf probe 0:0;sf read 0x80001000 0xd00000 0x100000; fsl_mc lazyapply dpl 0x80001000 && sf read $kernel_load $kernel_start $kernel_size && bootm $kernel_load"
diff --git a/configs/ls1088aqds_qspi_defconfig b/configs/ls1088aqds_qspi_defconfig
index 45c93c838198..87cf5378b791 100644
--- a/configs/ls1088aqds_qspi_defconfig
+++ b/configs/ls1088aqds_qspi_defconfig
@@ -29,10 +29,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="sf probe 0:0;sf read 0x80001000 0xd00000 0x100000; fsl_mc lazyapply dpl 0x80001000 && sf read $kernel_load $kernel_start $kernel_size && bootm $kernel_load"
diff --git a/configs/ls1088aqds_sdcard_ifc_defconfig b/configs/ls1088aqds_sdcard_ifc_defconfig
index 1f52769ac216..e7f093e34410 100644
--- a/configs/ls1088aqds_sdcard_ifc_defconfig
+++ b/configs/ls1088aqds_sdcard_ifc_defconfig
@@ -35,9 +35,9 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_SD_BOOT=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/ls1088aqds_sdcard_qspi_defconfig b/configs/ls1088aqds_sdcard_qspi_defconfig
index 93d07829b4b9..aeb98cd357f2 100644
--- a/configs/ls1088aqds_sdcard_qspi_defconfig
+++ b/configs/ls1088aqds_sdcard_qspi_defconfig
@@ -36,10 +36,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="mmcinfo;mmc read 0x80001000 0x6800 0x800; fsl_mc lazyapply dpl 0x80001000 && mmc read $kernel_load $kernel_start $kernel_size && bootm $kernel_load"
diff --git a/configs/ls1088aqds_tfa_defconfig b/configs/ls1088aqds_tfa_defconfig
index 05f5496936df..f074430267ec 100644
--- a/configs/ls1088aqds_tfa_defconfig
+++ b/configs/ls1088aqds_tfa_defconfig
@@ -28,11 +28,11 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/ls1088ardb_qspi_SECURE_BOOT_defconfig b/configs/ls1088ardb_qspi_SECURE_BOOT_defconfig
index 48bd56beb3e8..9923cfcccee1 100644
--- a/configs/ls1088ardb_qspi_SECURE_BOOT_defconfig
+++ b/configs/ls1088ardb_qspi_SECURE_BOOT_defconfig
@@ -27,10 +27,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1088ardb_qspi_defconfig b/configs/ls1088ardb_qspi_defconfig
index 7dcd12db0c83..c5615711c513 100644
--- a/configs/ls1088ardb_qspi_defconfig
+++ b/configs/ls1088ardb_qspi_defconfig
@@ -29,10 +29,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_QSPI_BOOT=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig b/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
index c0812a983d5c..8cbedab53077 100644
--- a/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
+++ b/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
@@ -35,10 +35,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1088ardb_sdcard_qspi_defconfig b/configs/ls1088ardb_sdcard_qspi_defconfig
index b98825cdb92a..3218aaf27f8a 100644
--- a/configs/ls1088ardb_sdcard_qspi_defconfig
+++ b/configs/ls1088ardb_sdcard_qspi_defconfig
@@ -36,10 +36,10 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
index 4291aa9c0fdf..1ebba60dd90a 100644
--- a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
@@ -27,9 +27,9 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls1088ardb_tfa_defconfig b/configs/ls1088ardb_tfa_defconfig
index de3a0829d213..c651c047d5bb 100644
--- a/configs/ls1088ardb_tfa_defconfig
+++ b/configs/ls1088ardb_tfa_defconfig
@@ -29,9 +29,9 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/ls2080aqds_SECURE_BOOT_defconfig b/configs/ls2080aqds_SECURE_BOOT_defconfig
index d8416265cfb3..aefcec22bd5c 100644
--- a/configs/ls2080aqds_SECURE_BOOT_defconfig
+++ b/configs/ls2080aqds_SECURE_BOOT_defconfig
@@ -20,11 +20,11 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="fsl_mc apply dpl 0x580d00000 && cp.b $kernel_start $kernel_load $kernel_size && bootm $kernel_load"
diff --git a/configs/ls2080aqds_defconfig b/configs/ls2080aqds_defconfig
index be08d5ba86a8..56ee52686e7b 100644
--- a/configs/ls2080aqds_defconfig
+++ b/configs/ls2080aqds_defconfig
@@ -21,11 +21,11 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="fsl_mc apply dpl 0x580d00000 && cp.b $kernel_start $kernel_load $kernel_size && bootm $kernel_load"
diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index 1afaac2686dc..09364b2a6e88 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -25,13 +25,13 @@ CONFIG_FSL_USE_PCA9547_MUX=y
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_NAND_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="fsl_mc apply dpl 0x580d00000 && cp.b $kernel_start $kernel_load $kernel_size && bootm $kernel_load"
diff --git a/configs/ls2080aqds_qspi_defconfig b/configs/ls2080aqds_qspi_defconfig
index b29f1db8904a..e0a5508227b8 100644
--- a/configs/ls2080aqds_qspi_defconfig
+++ b/configs/ls2080aqds_qspi_defconfig
@@ -19,13 +19,13 @@ CONFIG_FSL_USE_PCA9547_MUX=y
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="fsl_mc apply dpl 0x580d00000 && cp.b $kernel_start $kernel_load $kernel_size && bootm $kernel_load"
diff --git a/configs/ls2080aqds_sdcard_defconfig b/configs/ls2080aqds_sdcard_defconfig
index b45819f87b3e..2edf15001738 100644
--- a/configs/ls2080aqds_sdcard_defconfig
+++ b/configs/ls2080aqds_sdcard_defconfig
@@ -27,12 +27,12 @@ CONFIG_FSL_USE_PCA9547_MUX=y
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="mmc read 0x80200000 0x6800 0x800; fsl_mc apply dpl 0x80200000 && mmc read $kernel_load $kernel_start $kernel_size && bootm $kernel_load"
diff --git a/configs/ls2080ardb_SECURE_BOOT_defconfig b/configs/ls2080ardb_SECURE_BOOT_defconfig
index bcd83018112c..cab952911d04 100644
--- a/configs/ls2080ardb_SECURE_BOOT_defconfig
+++ b/configs/ls2080ardb_SECURE_BOOT_defconfig
@@ -24,11 +24,11 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="env exists mcinitcmd && env exists secureboot && esbc_validate 0x5806C0000; env exists mcinitcmd && fsl_mc lazyapply dpl 0x580d00000;run distro_bootcmd;run nor_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls2080ardb_defconfig b/configs/ls2080ardb_defconfig
index 38ec438c3bca..d43c066e1629 100644
--- a/configs/ls2080ardb_defconfig
+++ b/configs/ls2080ardb_defconfig
@@ -25,11 +25,11 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="env exists mcinitcmd && env exists secureboot && esbc_validate 0x5806C0000; env exists mcinitcmd && fsl_mc lazyapply dpl 0x580d00000;run distro_bootcmd;run nor_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_defconfig
index a406bae1ec76..4d37fab5cbaa 100644
--- a/configs/ls2080ardb_nand_defconfig
+++ b/configs/ls2080ardb_nand_defconfig
@@ -30,13 +30,13 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_NAND_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="env exists mcinitcmd && env exists secureboot && esbc_validate 0x5806C0000; env exists mcinitcmd && fsl_mc lazyapply dpl 0x580d00000;run distro_bootcmd;run nor_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls2081ardb_defconfig b/configs/ls2081ardb_defconfig
index 1ee92831bc51..3469616a0ac6 100644
--- a/configs/ls2081ardb_defconfig
+++ b/configs/ls2081ardb_defconfig
@@ -25,12 +25,12 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="sf probe 0:0; sf read 0x806c0000 0x6c0000 0x40000; env exists mcinitcmd && env exists secureboot && esbc_validate 0x806C0000; sf read 0x80d00000 0xd00000 0x100000; env exists mcinitcmd && fsl_mc lazyapply dpl 0x80d00000; run distro_bootcmd;run qspi_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_defconfig
index aff3c86b9553..2ac4384b66b9 100644
--- a/configs/ls2088aqds_tfa_defconfig
+++ b/configs/ls2088aqds_tfa_defconfig
@@ -22,11 +22,11 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_RESET_PHY_R=y
diff --git a/configs/ls2088ardb_qspi_SECURE_BOOT_defconfig b/configs/ls2088ardb_qspi_SECURE_BOOT_defconfig
index 268740c0fff5..dab8bf725def 100644
--- a/configs/ls2088ardb_qspi_SECURE_BOOT_defconfig
+++ b/configs/ls2088ardb_qspi_SECURE_BOOT_defconfig
@@ -24,12 +24,12 @@ CONFIG_VOL_MONITOR_IR36021_SET=y
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOOTCOMMAND="sf probe 0:0; sf read 0x806c0000 0x6c0000 0x40000; env exists mcinitcmd && env exists secureboot && esbc_validate 0x806C0000; sf read 0x80d00000 0xd00000 0x100000; env exists mcinitcmd && fsl_mc lazyapply dpl 0x80d00000; run distro_bootcmd;run qspi_bootcmd; env exists secureboot && esbc_halt;"
 CONFIG_MISC_INIT_R=y
 CONFIG_RESET_PHY_R=y
diff --git a/configs/ls2088ardb_qspi_defconfig b/configs/ls2088ardb_qspi_defconfig
index f38f77b37f4a..802259fa2f77 100644
--- a/configs/ls2088ardb_qspi_defconfig
+++ b/configs/ls2088ardb_qspi_defconfig
@@ -26,12 +26,12 @@ CONFIG_VOL_MONITOR_IR36021_SET=y
 # CONFIG_SYS_MALLOC_F is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="sf probe 0:0; sf read 0x806c0000 0x6c0000 0x40000; env exists mcinitcmd && env exists secureboot && esbc_validate 0x806C0000; sf read 0x80d00000 0xd00000 0x100000; env exists mcinitcmd && fsl_mc lazyapply dpl 0x80d00000; run distro_bootcmd;run qspi_bootcmd; env exists secureboot && esbc_halt;"
diff --git a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
index 090764c1f929..61e97b900a63 100644
--- a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
@@ -26,11 +26,11 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls2088ardb_tfa_defconfig b/configs/ls2088ardb_tfa_defconfig
index c4c994b57bff..4d69db193b63 100644
--- a/configs/ls2088ardb_tfa_defconfig
+++ b/configs/ls2088ardb_tfa_defconfig
@@ -28,11 +28,11 @@ CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
index 3b54ecb499e9..875b56bb770e 100644
--- a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
@@ -27,10 +27,10 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
 CONFIG_BOARD_EARLY_INIT_R=y
diff --git a/configs/lx2160aqds_tfa_defconfig b/configs/lx2160aqds_tfa_defconfig
index 89bdf1e6e7aa..56b92602fb5f 100644
--- a/configs/lx2160aqds_tfa_defconfig
+++ b/configs/lx2160aqds_tfa_defconfig
@@ -29,11 +29,11 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
 CONFIG_BOARD_EARLY_INIT_R=y
diff --git a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
index 507ee4f0fbb8..8cb89ff6cfa5 100644
--- a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
@@ -28,10 +28,10 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/lx2160ardb_tfa_defconfig b/configs/lx2160ardb_tfa_defconfig
index a86710930cdc..83e3259b3a4e 100644
--- a/configs/lx2160ardb_tfa_defconfig
+++ b/configs/lx2160ardb_tfa_defconfig
@@ -30,11 +30,11 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/lx2160ardb_tfa_stmm_defconfig b/configs/lx2160ardb_tfa_stmm_defconfig
index 6c668f2d89a3..fc584d61c758 100644
--- a/configs/lx2160ardb_tfa_stmm_defconfig
+++ b/configs/lx2160ardb_tfa_stmm_defconfig
@@ -30,11 +30,11 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
 CONFIG_MISC_INIT_R=y
diff --git a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
index f5edef7a5432..942cdb7af5f5 100644
--- a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
@@ -27,10 +27,10 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
 CONFIG_BOARD_EARLY_INIT_R=y
diff --git a/configs/lx2162aqds_tfa_defconfig b/configs/lx2162aqds_tfa_defconfig
index c95bb501181f..e91fccfe54d9 100644
--- a/configs/lx2162aqds_tfa_defconfig
+++ b/configs/lx2162aqds_tfa_defconfig
@@ -29,11 +29,11 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
 CONFIG_BOARD_EARLY_INIT_R=y
diff --git a/configs/lx2162aqds_tfa_verified_boot_defconfig b/configs/lx2162aqds_tfa_verified_boot_defconfig
index bea1859c2f0e..4bd7ef3e5280 100644
--- a/configs/lx2162aqds_tfa_verified_boot_defconfig
+++ b/configs/lx2162aqds_tfa_verified_boot_defconfig
@@ -29,12 +29,12 @@ CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_FSL_QIXIS=y
 CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
+CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=10
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
 CONFIG_BOARD_EARLY_INIT_R=y
diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
index 9f01bf73ab86..ef9e15d15200 100644
--- a/configs/m53menlo_defconfig
+++ b/configs/m53menlo_defconfig
@@ -23,8 +23,8 @@ CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
 CONFIG_ENV_OFFSET_REDUND=0x180000
 CONFIG_SYS_LOAD_ADDR=0x70800000
 CONFIG_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttymxc0,115200"
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/minnowmax_defconfig b/configs/minnowmax_defconfig
index 80e6a4c12b9e..9c03dc8a8a3b 100644
--- a/configs/minnowmax_defconfig
+++ b/configs/minnowmax_defconfig
@@ -52,7 +52,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index 323a7040261a..f8d6dcbf71fc 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -24,8 +24,8 @@ CONFIG_SYS_BARGSIZE=2048
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx8mp-msc-sm2s.dtb"
 CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_espressobin-88f3720_defconfig
index fc394a7e9ded..6c68c239e251 100644
--- a/configs/mvebu_espressobin-88f3720_defconfig
+++ b/configs/mvebu_espressobin-88f3720_defconfig
@@ -18,8 +18,8 @@ CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -27,7 +27,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_FUSE=y
diff --git a/configs/mx53ppd_defconfig b/configs/mx53ppd_defconfig
index 055dbcb03351..0dd1bace7193 100644
--- a/configs/mx53ppd_defconfig
+++ b/configs/mx53ppd_defconfig
@@ -12,8 +12,8 @@ CONFIG_BOOTCOUNT_BOOTLIMIT=10
 CONFIG_SYS_LOAD_ADDR=0x72000000
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run doquiet; run tryboot"
 # CONFIG_CONSOLE_MUX is not set
diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
index b23c78984d13..cf19bd106557 100644
--- a/configs/mx6cuboxi_defconfig
+++ b/configs/mx6cuboxi_defconfig
@@ -22,8 +22,8 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_CMD_HDMIDETECT=y
 CONFIG_AHCI=y
 CONFIG_FIT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="if hdmidet; then usb start; setenv stdin  serial,usbkbd; setenv stdout serial,vidconsole; setenv stderr serial,vidconsole; else setenv stdin  serial; setenv stdout serial; setenv stderr serial; fi;"
diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index cc64facd5f2b..c124f82408f4 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -21,10 +21,10 @@ CONFIG_SYS_LOAD_ADDR=0x82408000
 CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_BEST_MATCH=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTSTAGE=y
 CONFIG_SPL_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_STASH=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_SYS_STDIO_DEREGISTER=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
diff --git a/configs/octeontx2_95xx_defconfig b/configs/octeontx2_95xx_defconfig
index dace990c9edc..895841d26afc 100644
--- a/configs/octeontx2_95xx_defconfig
+++ b/configs/octeontx2_95xx_defconfig
@@ -25,17 +25,16 @@ CONFIG_SYS_MEMTEST_END=0x040f0000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=5
 CONFIG_BOOT_RETRY=y
 CONFIG_BOOT_RETRY_TIME=-1
 CONFIG_BOOT_RETRY_MIN=30
 CONFIG_RESET_TO_RETRY=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200n8 earlycon=pl011,0x87e028000000 maxcpus=6 rootwait rw root=/dev/mmcblk0p2 coherent_pool=16M"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=1050
diff --git a/configs/octeontx2_96xx_defconfig b/configs/octeontx2_96xx_defconfig
index f8dcbf1e5703..d55bb84d419a 100644
--- a/configs/octeontx2_96xx_defconfig
+++ b/configs/octeontx2_96xx_defconfig
@@ -25,17 +25,16 @@ CONFIG_AHCI=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=5
 CONFIG_BOOT_RETRY=y
 CONFIG_BOOT_RETRY_TIME=-1
 CONFIG_BOOT_RETRY_MIN=30
 CONFIG_RESET_TO_RETRY=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200n8 earlycon=pl011,0x87e028000000 maxcpus=24 rootwait rw root=/dev/mmcblk0p2 coherent_pool=16M"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=1050
diff --git a/configs/octeontx_81xx_defconfig b/configs/octeontx_81xx_defconfig
index 2d51abe75156..a20f77505214 100644
--- a/configs/octeontx_81xx_defconfig
+++ b/configs/octeontx_81xx_defconfig
@@ -26,12 +26,12 @@ CONFIG_SYS_MEMTEST_END=0x28f0000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=5
 CONFIG_BOOT_RETRY=y
 CONFIG_BOOT_RETRY_TIME=-1
 CONFIG_BOOT_RETRY_MIN=30
 CONFIG_RESET_TO_RETRY=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200n8 earlycon=pl011,0x87e028000000 maxcpus=4 rootwait rw root=/dev/sda2 coherent_pool=16M"
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/octeontx_83xx_defconfig b/configs/octeontx_83xx_defconfig
index 656ff537c4bf..495bdb3d8432 100644
--- a/configs/octeontx_83xx_defconfig
+++ b/configs/octeontx_83xx_defconfig
@@ -24,12 +24,12 @@ CONFIG_AHCI=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=5
 CONFIG_BOOT_RETRY=y
 CONFIG_BOOT_RETRY_TIME=-1
 CONFIG_BOOT_RETRY_MIN=30
 CONFIG_RESET_TO_RETRY=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200n8 earlycon=pl011,0x87e028000000 maxcpus=24 rootwait rw root=/dev/sda2 coherent_pool=16M"
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/odroid-xu3_defconfig b/configs/odroid-xu3_defconfig
index bb12c9f73893..887686bcfb24 100644
--- a/configs/odroid-xu3_defconfig
+++ b/configs/odroid-xu3_defconfig
@@ -72,5 +72,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Samsung"
 CONFIG_USB_GADGET_VENDOR_NUM=0x04e8
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6601
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/odroid_defconfig b/configs/odroid_defconfig
index b1943cfd39bf..42d96e300f54 100644
--- a/configs/odroid_defconfig
+++ b/configs/odroid_defconfig
@@ -74,6 +74,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6601
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
 CONFIG_LIB_HW_RAND=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
index d9b7e0de5d54..1606e9f8b686 100644
--- a/configs/omap35_logic_somlv_defconfig
+++ b/configs/omap35_logic_somlv_defconfig
@@ -17,8 +17,8 @@ CONFIG_SYS_PROMPT="OMAP Logic # "
 CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL=y
 CONFIG_LTO=y
-CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_SYS_MONITOR_BASE=0x10000000
+CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run autoboot"
 CONFIG_USE_PREBOOT=y
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
index 17fda31a1e78..eaee0421e9f1 100644
--- a/configs/omap3_logic_somlv_defconfig
+++ b/configs/omap3_logic_somlv_defconfig
@@ -17,8 +17,8 @@ CONFIG_SYS_PROMPT="OMAP Logic # "
 CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL=y
 CONFIG_LTO=y
-CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_SYS_MONITOR_BASE=0x10000000
+CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run autoboot"
 CONFIG_USE_PREBOOT=y
diff --git a/configs/origen_defconfig b/configs/origen_defconfig
index fa6c9ae15f27..43301ba67dde 100644
--- a/configs/origen_defconfig
+++ b/configs/origen_defconfig
@@ -57,4 +57,3 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6601
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
diff --git a/configs/pcm051_rev3_defconfig b/configs/pcm051_rev3_defconfig
index 6769634c3996..831a14666fec 100644
--- a/configs/pcm051_rev3_defconfig
+++ b/configs/pcm051_rev3_defconfig
@@ -14,8 +14,8 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="am335x-wega-rdk.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defconfig
index 8e8e85c2e644..455b439151c5 100644
--- a/configs/pg_wcom_expu1_defconfig
+++ b/configs/pg_wcom_expu1_defconfig
@@ -30,13 +30,13 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_expu1_update_defconfig
index e012851d8afa..269116cd0d59 100644
--- a/configs/pg_wcom_expu1_update_defconfig
+++ b/configs/pg_wcom_expu1_update_defconfig
@@ -28,13 +28,13 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defconfig
index ccab1087d20a..678bc1007060 100644
--- a/configs/pg_wcom_seli8_defconfig
+++ b/configs/pg_wcom_seli8_defconfig
@@ -30,13 +30,13 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_seli8_update_defconfig
index 0e2699246ff9..7c7b0019030e 100644
--- a/configs/pg_wcom_seli8_update_defconfig
+++ b/configs/pg_wcom_seli8_update_defconfig
@@ -28,13 +28,13 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0"
 CONFIG_SILENT_CONSOLE=y
diff --git a/configs/phycore-am335x-r2-regor_defconfig b/configs/phycore-am335x-r2-regor_defconfig
index d74078c7bed8..6c316cb3862a 100644
--- a/configs/phycore-am335x-r2-regor_defconfig
+++ b/configs/phycore-am335x-r2-regor_defconfig
@@ -19,6 +19,7 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_PAYLOAD="u-boot.img"
 # CONFIG_FIT is not set
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="am335x-regor-rdk.dtb"
@@ -94,5 +95,4 @@ CONFIG_USB_MUSB_GADGET=y
 CONFIG_USB_MUSB_TI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETHER=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/phycore-am335x-r2-wega_defconfig b/configs/phycore-am335x-r2-wega_defconfig
index 0f75d56c881c..ff204e776b17 100644
--- a/configs/phycore-am335x-r2-wega_defconfig
+++ b/configs/phycore-am335x-r2-wega_defconfig
@@ -19,6 +19,7 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_PAYLOAD="u-boot.img"
 # CONFIG_FIT is not set
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="am335x-wega-rdk.dtb"
@@ -95,5 +96,4 @@ CONFIG_USB_MUSB_GADGET=y
 CONFIG_USB_MUSB_TI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETHER=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/pomelo_defconfig b/configs/pomelo_defconfig
index 3b3fe5958366..ef96529b3221 100644
--- a/configs/pomelo_defconfig
+++ b/configs/pomelo_defconfig
@@ -15,7 +15,6 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 earlycon=pl011,0x28001000 root=/dev/sda2 rw"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=280
 CONFIG_SYS_BOOTM_LEN=0x3c00000
diff --git a/configs/qemu-ppce500_defconfig b/configs/qemu-ppce500_defconfig
index 5f0746e4e27c..fbe84d57029a 100644
--- a/configs/qemu-ppce500_defconfig
+++ b/configs/qemu-ppce500_defconfig
@@ -11,11 +11,11 @@ CONFIG_TARGET_QEMU_PPCE500=y
 CONFIG_ENABLE_36BIT_PHYS=y
 CONFIG_SYS_MPC85XX_NO_RESETVEC=y
 CONFIG_USE_UBOOTPATH=y
+CONFIG_SYS_MONITOR_BASE=0x00F00000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SYS_MONITOR_BASE=0x00F00000
 CONFIG_BOOTDELAY=1
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="test -n \"$qemu_kernel_addr\" && bootm $qemu_kernel_addr - $fdtcontroladdr"
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 165f0b512c8b..f02e9125a6d8 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -18,11 +18,11 @@ CONFIG_SMP=y
 CONFIG_GENERATE_PIRQ_TABLE=y
 CONFIG_GENERATE_MP_TABLE=y
 CONFIG_X86_OFFSET_U_BOOT=0xfff00000
+CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
-CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_SHOW_BOOT_PROGRESS=y
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 95eb911593d3..0cb8b1ed5a34 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -17,9 +17,9 @@ CONFIG_SPL_STACK=0xe6304000
 CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_LTO=y
 CONFIG_REMAKE_ELF=y
+CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77990-ebisu.dtb; booti 0x48080000 - 0x48000000"
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index 4b679716c620..d90fb61023ac 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -17,9 +17,9 @@ CONFIG_SPL_STACK=0xe6304000
 CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_LTO=y
 CONFIG_REMAKE_ELF=y
+CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77995-draak.dtb; booti 0x48080000 - 0x48000000"
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 8de39c6e6d84..258a1f540326 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -16,10 +16,10 @@ CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_PCI=y
 CONFIG_LTO=y
 CONFIG_REMAKE_ELF=y
+CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_FIT=y
 # CONFIG_BOOTSTD is not set
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77950-salvator-x.dtb; booti 0x48080000 - 0x48000000"
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index b8fdb5e38268..64df0c148bd8 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -16,9 +16,9 @@ CONFIG_SPL_STACK=0xe6304000
 CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_LTO=y
 CONFIG_REMAKE_ELF=y
+CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77950-ulcb.dtb; booti 0x48080000 - 0x48000000"
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index c2641f65b507..0297d098761e 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -75,8 +75,6 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
@@ -95,6 +93,8 @@ CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_TPL_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/rpi_0_w_defconfig b/configs/rpi_0_w_defconfig
index 3167bfbe48f7..976b378c80f6 100644
--- a/configs/rpi_0_w_defconfig
+++ b/configs/rpi_0_w_defconfig
@@ -14,11 +14,11 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1049
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
diff --git a/configs/rpi_2_defconfig b/configs/rpi_2_defconfig
index 883dab161702..c8ecb0843260 100644
--- a/configs/rpi_2_defconfig
+++ b/configs/rpi_2_defconfig
@@ -15,11 +15,11 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1049
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
diff --git a/configs/rpi_3_32b_defconfig b/configs/rpi_3_32b_defconfig
index 5ff7d987a431..427f8b6ef8ca 100644
--- a/configs/rpi_3_32b_defconfig
+++ b/configs/rpi_3_32b_defconfig
@@ -14,11 +14,11 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1049
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
diff --git a/configs/rpi_3_b_plus_defconfig b/configs/rpi_3_b_plus_defconfig
index 31f2a6eb310c..09770edc0644 100644
--- a/configs/rpi_3_b_plus_defconfig
+++ b/configs/rpi_3_b_plus_defconfig
@@ -13,11 +13,11 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1049
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
diff --git a/configs/rpi_3_defconfig b/configs/rpi_3_defconfig
index fa6e1507d640..7d0e6268a493 100644
--- a/configs/rpi_3_defconfig
+++ b/configs/rpi_3_defconfig
@@ -13,11 +13,11 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1049
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
diff --git a/configs/rpi_4_32b_defconfig b/configs/rpi_4_32b_defconfig
index 55bf6c0770f0..a6d9ed5b6ebb 100644
--- a/configs/rpi_4_32b_defconfig
+++ b/configs/rpi_4_32b_defconfig
@@ -10,15 +10,15 @@ CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
-CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_PCI=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="pci enum; usb start;"
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1049
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
index 6679cce9a165..e5eb2fa83275 100644
--- a/configs/rpi_4_defconfig
+++ b/configs/rpi_4_defconfig
@@ -10,15 +10,15 @@ CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
-CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_PCI=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="pci enum; usb start;"
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1049
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 26e29ffb5a1f..4c951e7ab759 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -10,15 +10,15 @@ CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
-CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_PCI=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="pci enum; usb start;"
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1049
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
diff --git a/configs/rpi_defconfig b/configs/rpi_defconfig
index 0ac5efec717b..b584e9003a38 100644
--- a/configs/rpi_defconfig
+++ b/configs/rpi_defconfig
@@ -14,11 +14,11 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1049
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
diff --git a/configs/s5p4418_nanopi2_defconfig b/configs/s5p4418_nanopi2_defconfig
index 5356161ff0d2..6c310e2747c3 100644
--- a/configs/s5p4418_nanopi2_defconfig
+++ b/configs/s5p4418_nanopi2_defconfig
@@ -27,8 +27,8 @@ CONFIG_SYS_MEMTEST_END=0xb0000000
 CONFIG_FIT=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=1050
diff --git a/configs/s5p_goni_defconfig b/configs/s5p_goni_defconfig
index dd5e24ca3d29..ac92867bb595 100644
--- a/configs/s5p_goni_defconfig
+++ b/configs/s5p_goni_defconfig
@@ -63,4 +63,3 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6601
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
diff --git a/configs/s5pc210_universal_defconfig b/configs/s5pc210_universal_defconfig
index 1bcdc84b5008..931772af969c 100644
--- a/configs/s5pc210_universal_defconfig
+++ b/configs/s5pc210_universal_defconfig
@@ -62,4 +62,3 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6601
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
diff --git a/configs/sama5d29_curiosity_mmc1_defconfig b/configs/sama5d29_curiosity_mmc1_defconfig
index c4ea11e0085f..67a32fe459e2 100644
--- a/configs/sama5d29_curiosity_mmc1_defconfig
+++ b/configs/sama5d29_curiosity_mmc1_defconfig
@@ -115,6 +115,5 @@ CONFIG_W1=y
 CONFIG_W1_GPIO=y
 CONFIG_W1_EEPROM=y
 CONFIG_W1_EEPROM_DS24XXX=y
-CONFIG_FAT_WRITE=y
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/sama5d29_curiosity_mmc_defconfig b/configs/sama5d29_curiosity_mmc_defconfig
index 23c9ef74780a..ed221ee7f86f 100644
--- a/configs/sama5d29_curiosity_mmc_defconfig
+++ b/configs/sama5d29_curiosity_mmc_defconfig
@@ -114,6 +114,5 @@ CONFIG_W1=y
 CONFIG_W1_GPIO=y
 CONFIG_W1_EEPROM=y
 CONFIG_W1_EEPROM_DS24XXX=y
-CONFIG_FAT_WRITE=y
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index fd110d99a3af..5e199dad6240 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -110,7 +110,6 @@ CONFIG_IPV6=y
 CONFIG_DM_DMA=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
-CONFIG_DEVRES=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_ADC=y
 CONFIG_ADC_SANDBOX=y
@@ -138,6 +137,7 @@ CONFIG_DM_DEMO_SHAPE=y
 CONFIG_DFU_SF=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_QCOM_PMIC_GPIO=y
@@ -271,4 +271,3 @@ CONFIG_FWU_MULTI_BANK_UPDATE=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
-CONFIG_ARM_FFA_TRANSPORT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index d667cb9ae47f..8e13ec45c76a 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -144,7 +144,6 @@ CONFIG_IP_DEFRAG=y
 CONFIG_BOOTP_SERVERIP=y
 CONFIG_IPV6=y
 CONFIG_DM_DMA=y
-CONFIG_DEVRES=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_ADC=y
@@ -183,6 +182,7 @@ CONFIG_DMA_CHANNELS=y
 CONFIG_SANDBOX_DMA=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_QCOM_PMIC_GPIO=y
@@ -231,8 +231,8 @@ CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
 CONFIG_NVME_PCI=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
-CONFIG_PCI_SANDBOX=y
 CONFIG_PCI_FTPCI100=y
+CONFIG_PCI_SANDBOX=y
 CONFIG_PHY=y
 CONFIG_PHY_SANDBOX=y
 CONFIG_PINCTRL=y
@@ -348,4 +348,3 @@ CONFIG_TEST_FDTDEC=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
-CONFIG_ARM_FFA_TRANSPORT=y
diff --git a/configs/slimbootloader_defconfig b/configs/slimbootloader_defconfig
index dbfed814ded0..759fa7d79a68 100644
--- a/configs/slimbootloader_defconfig
+++ b/configs/slimbootloader_defconfig
@@ -11,7 +11,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="if test ${bootdev} = 'usb'; then ${bootdev} start; fi; if test ${bootdev} = 'scsi'; then ${bootdev} scan; fi; ${bootdev} info; ${bootfsload} ${bootdev} ${bootdevnum}:${bootdevpart} ${loadaddr} ${bootfile}; ${bootfsload} ${bootdev} ${bootdevnum}:${bootdevpart} ${ramdiskaddr} ${ramdiskfile}; zboot ${loadaddr} 0 ${ramdiskaddr} ${filesize}"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_MMC=y
@@ -19,7 +18,6 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index 82b16418a6fc..050a3535e0aa 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -14,8 +14,8 @@ CONFIG_SPL_STACK=0xffe2b000
 CONFIG_TARGET_SOCFPGA_ARRIA10_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_arria10"
 CONFIG_SPL_FS_FAT=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_SPL_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_BOOTARGS=y
diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_defconfig
index 42d563a65775..8980a6546899 100644
--- a/configs/socfpga_arria5_defconfig
+++ b/configs/socfpga_arria5_defconfig
@@ -12,8 +12,8 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_ARRIA5_SOCDK=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="socfpga_arria5_socdk.dtb"
diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index fa7904b88de1..0d744f427d9c 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -12,8 +12,8 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_socdk.dtb"
diff --git a/configs/socfpga_dbm_soc1_defconfig b/configs/socfpga_dbm_soc1_defconfig
index de087fabf688..2087b6e61f16 100644
--- a/configs/socfpga_dbm_soc1_defconfig
+++ b/configs/socfpga_dbm_soc1_defconfig
@@ -12,8 +12,8 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_DEVBOARDS_DBM_SOC1=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200"
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
index 364ae912ca5f..646552cce652 100644
--- a/configs/socfpga_de0_nano_soc_defconfig
+++ b/configs/socfpga_de0_nano_soc_defconfig
@@ -12,8 +12,8 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_TERASIC_DE0_NANO=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_de0_nano_soc.dtb"
diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_nano_defconfig
index a79073f27458..3ae28e745ca9 100644
--- a/configs/socfpga_de10_nano_defconfig
+++ b/configs/socfpga_de10_nano_defconfig
@@ -12,8 +12,8 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_TERASIC_DE10_NANO=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_de10_nano.dtb"
diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
index 1385b200aa8c..f3d86bcf5262 100644
--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -12,8 +12,8 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_TERASIC_DE10_STANDARD=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_de10_standard.dtb"
diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_defconfig
index 069a2535d644..cc3038e0b25c 100644
--- a/configs/socfpga_de1_soc_defconfig
+++ b/configs/socfpga_de1_soc_defconfig
@@ -12,8 +12,8 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_TERASIC_DE1_SOC=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_de1_soc.dtb"
diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
index 69eee1c1d519..05518525a464 100644
--- a/configs/socfpga_is1_defconfig
+++ b/configs/socfpga_is1_defconfig
@@ -14,8 +14,8 @@ CONFIG_DM_RESET=y
 CONFIG_SYS_BOOTCOUNT_ADDR=0xfffffff8
 CONFIG_SPL_STACK=0xfffffff8
 CONFIG_TARGET_SOCFPGA_IS1=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200"
diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_defconfig
index f49604becc59..23ea23d867ad 100644
--- a/configs/socfpga_mcvevk_defconfig
+++ b/configs/socfpga_mcvevk_defconfig
@@ -12,8 +12,8 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_ARIES_MCVEVK=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200"
diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_defconfig
index f3d7ecfe8fd0..33b0c795f73b 100644
--- a/configs/socfpga_sockit_defconfig
+++ b/configs/socfpga_sockit_defconfig
@@ -12,8 +12,8 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_TERASIC_SOCKIT=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_sockit.dtb"
diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
index b07e0a3355ae..dc88606daeff 100644
--- a/configs/socfpga_sr1500_defconfig
+++ b/configs/socfpga_sr1500_defconfig
@@ -18,8 +18,8 @@ CONFIG_TARGET_SOCFPGA_SR1500=y
 CONFIG_ENV_OFFSET_REDUND=0xF0000
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x40000000
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_sr1500.dtb"
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index 62caec7597ec..0b9c2a619c47 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -15,8 +15,8 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_TARGET_SOCFPGA_SOFTING_VINING_FPGA=y
 CONFIG_ENV_OFFSET_REDUND=0x110000
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
diff --git a/configs/socrates_defconfig b/configs/socrates_defconfig
index 33092c746131..71c03d26662d 100644
--- a/configs/socrates_defconfig
+++ b/configs/socrates_defconfig
@@ -18,7 +18,6 @@ CONFIG_ENABLE_36BIT_PHYS=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=1
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Enter password to abort autoboot in %d seconds!\n"
@@ -28,6 +27,7 @@ CONFIG_AUTOBOOT_STOP_STR_SHA256="2dd411308b37266d33c9246821adc5aa4002f0091f5e2ae
 CONFIG_BOOT_RETRY=y
 CONFIG_BOOT_RETRY_TIME=120
 CONFIG_RESET_TO_RETRY=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run boot_usb;run boot_nor"
 CONFIG_USE_PREBOOT=y
diff --git a/configs/som-db5800-som-6867_defconfig b/configs/som-db5800-som-6867_defconfig
index 44db48204bd8..c190235ac11d 100644
--- a/configs/som-db5800-som-6867_defconfig
+++ b/configs/som-db5800-som-6867_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e9b63e5b8472..9b3b0022acfd 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -6,15 +6,8 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80000000
 CONFIG_SF_DEFAULT_SPEED=100000000
-CONFIG_ENV_SUPPORT=y
-CONFIG_SAVEENV=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SECT_SIZE_AUTO=y
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xf0000
-CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="jh7110-starfive-visionfive-2"
 CONFIG_SPL_TEXT_BASE=0x8000000
@@ -77,6 +70,10 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_OF_BOARD=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SECT_SIZE_AUTO=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index 9ea5aaa7145a..332c75db5912 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -26,6 +26,7 @@ CONFIG_SYS_MEMTEST_END=0xc4000000
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SPL_LOG=y
 CONFIG_BOARD_EARLY_INIT_F=y
@@ -45,7 +46,6 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
-CONFIG_FDT_SIMPLEFB=y
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_CMD_ADTIMG=y
diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index 4d0a81f8a871..25352929965e 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -20,8 +20,8 @@ CONFIG_SYS_MEMTEST_END=0xc4000000
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
-CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_FDT_SIMPLEFB=y
+CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_CMD_ADTIMG=y
diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
index 0a7d8624858d..a59bc0c5e936 100644
--- a/configs/stm32mp15_trusted_defconfig
+++ b/configs/stm32mp15_trusted_defconfig
@@ -21,8 +21,8 @@ CONFIG_SYS_MEMTEST_END=0xc4000000
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
-CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_FDT_SIMPLEFB=y
+CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_CMD_ADTIMG=y
diff --git a/configs/stmark2_defconfig b/configs/stmark2_defconfig
index 84ccc396d2de..e487521f9d37 100644
--- a/configs/stmark2_defconfig
+++ b/configs/stmark2_defconfig
@@ -11,8 +11,8 @@ CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SYS_LOAD_ADDR=0x40010000
 CONFIG_TARGET_STMARK2=y
 CONFIG_SYS_BARGSIZE=256
-CONFIG_TIMESTAMP=y
 CONFIG_SYS_MONITOR_BASE=0x47E00400
+CONFIG_TIMESTAMP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 rw rootfstype=ramfs rdinit=/bin/init devtmpfs.mount=1"
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index 24282a6a9cb5..2ac57586c600 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -20,9 +20,9 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTSTD_BOOTCOMMAND=y
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_LOGLEVEL=7
diff --git a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
index c5bd0d967366..5dc9904feb48 100644
--- a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
@@ -48,7 +48,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ISO_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/theadorable-x86-conga-qa3-e3845_defconfig b/configs/theadorable-x86-conga-qa3-e3845_defconfig
index b3afaf34a02f..d7b62643f6fa 100644
--- a/configs/theadorable-x86-conga-qa3-e3845_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/theadorable-x86-dfi-bt700_defconfig b/configs/theadorable-x86-dfi-bt700_defconfig
index 8222697f7471..861b59f650a0 100644
--- a/configs/theadorable-x86-dfi-bt700_defconfig
+++ b/configs/theadorable-x86-dfi-bt700_defconfig
@@ -45,7 +45,6 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index 3f588ea69bee..fa1ff4a73f21 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -6,8 +6,8 @@ CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PCI=y
 # CONFIG_SANDBOX_SDL is not set
 CONFIG_ANDROID_BOOT_IMAGE=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 # CONFIG_BOOTSTD_FULL is not set
 # CONFIG_BOOTMETH_CROS is not set
diff --git a/configs/topic_miami_defconfig b/configs/topic_miami_defconfig
index ef1b66e9069a..e748744736d1 100644
--- a/configs/topic_miami_defconfig
+++ b/configs/topic_miami_defconfig
@@ -78,5 +78,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x03fd
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
diff --git a/configs/topic_miamilite_defconfig b/configs/topic_miamilite_defconfig
index af829ac15b82..c7a43ff4e735 100644
--- a/configs/topic_miamilite_defconfig
+++ b/configs/topic_miamilite_defconfig
@@ -78,5 +78,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x03fd
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
diff --git a/configs/topic_miamiplus_defconfig b/configs/topic_miamiplus_defconfig
index 9287b1d79aa4..6139fee504ee 100644
--- a/configs/topic_miamiplus_defconfig
+++ b/configs/topic_miamiplus_defconfig
@@ -78,5 +78,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x03fd
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index e439214435c3..ce301948888b 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -11,8 +11,8 @@ CONFIG_DEFAULT_DEVICE_TREE="imx6dl-mba6b"
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run mmcboot; run netboot; run panicboot"
 CONFIG_DEFAULT_FDT_FILE="imx6dl-mba6x.dtb"
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index c4509c68095b..919cec126fde 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -14,8 +14,8 @@ CONFIG_ENV_OFFSET_REDUND=0x90000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="sf probe; run mmcboot; run netboot; run panicboot"
 CONFIG_DEFAULT_FDT_FILE="imx6dl-mba6x.dtb"
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_mmc_defconfig
index 64f71604ca9d..2910b85980a5 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_mmc_defconfig
@@ -11,8 +11,8 @@ CONFIG_DEFAULT_DEVICE_TREE="imx6q-mba6b"
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run mmcboot; run netboot; run panicboot"
 CONFIG_DEFAULT_FDT_FILE="imx6q-mba6x.dtb"
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 8256f536b8f6..556e6d639ce8 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -14,8 +14,8 @@ CONFIG_ENV_OFFSET_REDUND=0x90000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="sf probe; run mmcboot; run netboot; run panicboot"
 CONFIG_DEFAULT_FDT_FILE="imx6q-mba6x.dtb"
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_mmc_defconfig
index cdf0addfe610..853b0830f8eb 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_mmc_defconfig
@@ -11,8 +11,8 @@ CONFIG_DEFAULT_DEVICE_TREE="imx6dl-mba6b"
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run mmcboot; run netboot; run panicboot"
 CONFIG_DEFAULT_FDT_FILE="imx6dl-mba6x.dtb"
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 06fe3427aab0..7316056bd64f 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -14,8 +14,8 @@ CONFIG_ENV_OFFSET_REDUND=0x90000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="sf probe; run mmcboot; run netboot; run panicboot"
 CONFIG_DEFAULT_FDT_FILE="imx6dl-mba6x.dtb"
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 6fe6f2548dc1..2bb85ceda487 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -16,12 +16,11 @@ CONFIG_TEGRA30=y
 CONFIG_TARGET_TRANSFORMER_T30=y
 CONFIG_CMD_EBTUPDATE=y
 CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_USE_BOOTCOMMAND=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
@@ -45,7 +44,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_NFS is not set
 CONFIG_CMD_PAUSE=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
diff --git a/configs/trats2_defconfig b/configs/trats2_defconfig
index eace020b1181..48524b111edd 100644
--- a/configs/trats2_defconfig
+++ b/configs/trats2_defconfig
@@ -65,5 +65,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6601
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
 CONFIG_LIB_HW_RAND=y
diff --git a/configs/trats_defconfig b/configs/trats_defconfig
index 51fc32667995..3bea80412c94 100644
--- a/configs/trats_defconfig
+++ b/configs/trats_defconfig
@@ -62,5 +62,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6601
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
 CONFIG_LIB_HW_RAND=y
diff --git a/configs/tuge1_defconfig b/configs/tuge1_defconfig
index 7ea2f1766b38..9ff5d1599f19 100644
--- a/configs/tuge1_defconfig
+++ b/configs/tuge1_defconfig
@@ -96,11 +96,11 @@ CONFIG_LCRR_EADC_1=y
 CONFIG_LCRR_CLKDIV_2=y
 CONFIG_83XX_PCICLK=0x3ef1480
 # CONFIG_PCI is not set
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_HWCONFIG is not set
 CONFIG_LAST_STAGE_INIT=y
diff --git a/configs/turris_mox_defconfig b/configs/turris_mox_defconfig
index 234f1e721aa9..e0ca6337bd65 100644
--- a/configs/turris_mox_defconfig
+++ b/configs/turris_mox_defconfig
@@ -21,14 +21,13 @@ CONFIG_OF_BOARD_FIXUP=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_SHA1SUM=y
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 22aaee26384d..65d4a296e72c 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -35,9 +35,9 @@ CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=983040
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_CONSOLE_MUX=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/configs/tuxx1_defconfig b/configs/tuxx1_defconfig
index 4195c0b16591..5b33e8fa64fd 100644
--- a/configs/tuxx1_defconfig
+++ b/configs/tuxx1_defconfig
@@ -110,11 +110,11 @@ CONFIG_LCRR_EADC_1=y
 CONFIG_LCRR_CLKDIV_2=y
 CONFIG_83XX_PCICLK=0x3ef1480
 # CONFIG_PCI is not set
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Hit <SPACE> key to stop autoboot in %2ds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_HWCONFIG is not set
 CONFIG_LAST_STAGE_INIT=y
diff --git a/configs/uniphier_ld4_sld8_defconfig b/configs/uniphier_ld4_sld8_defconfig
index bf70771cda2c..a716c056ff4c 100644
--- a/configs/uniphier_ld4_sld8_defconfig
+++ b/configs/uniphier_ld4_sld8_defconfig
@@ -15,6 +15,7 @@ CONFIG_SPL=y
 CONFIG_MICRO_SUPPORT_CARD=y
 CONFIG_SYS_LOAD_ADDR=0x85000000
 CONFIG_TIMESTAMP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_BOOTCOMMAND="run ${bootdev}script; run ${bootdev}boot"
 CONFIG_USE_PREBOOT=y
@@ -81,4 +82,3 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_PANIC_HANG=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
diff --git a/configs/uniphier_v7_defconfig b/configs/uniphier_v7_defconfig
index 05f1c9902f5c..1e030fc7823a 100644
--- a/configs/uniphier_v7_defconfig
+++ b/configs/uniphier_v7_defconfig
@@ -15,6 +15,7 @@ CONFIG_SPL=y
 CONFIG_MICRO_SUPPORT_CARD=y
 CONFIG_SYS_LOAD_ADDR=0x85000000
 CONFIG_TIMESTAMP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_BOOTCOMMAND="run ${bootdev}script; run ${bootdev}boot"
 CONFIG_USE_PREBOOT=y
@@ -87,4 +88,3 @@ CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_UNIPHIER=y
 CONFIG_PANIC_HANG=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
diff --git a/configs/uniphier_v8_defconfig b/configs/uniphier_v8_defconfig
index 9124662ee873..674b781bc9a4 100644
--- a/configs/uniphier_v8_defconfig
+++ b/configs/uniphier_v8_defconfig
@@ -11,6 +11,7 @@ CONFIG_ARCH_UNIPHIER_V8_MULTI=y
 CONFIG_MICRO_SUPPORT_CARD=y
 CONFIG_SYS_LOAD_ADDR=0x85000000
 CONFIG_TIMESTAMP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_BOOTCOMMAND="run ${bootdev}script; run ${bootdev}boot"
 CONFIG_USE_PREBOOT=y
@@ -76,4 +77,3 @@ CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_UNIPHIER=y
 CONFIG_PANIC_HANG=y
-CONFIG_FDT_FIXUP_PARTITIONS=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 889b7e9936f4..f7c667694319 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -37,9 +37,9 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile k3-am625-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 09e14c6f8c40..c6b4af1303a9 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -28,9 +28,9 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx8mm-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 2df0f4f34433..f938fd0842d1 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -34,9 +34,9 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx8mp-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
diff --git a/configs/warp7_defconfig b/configs/warp7_defconfig
index d0b4e747dd23..26d992d3c2d8 100644
--- a/configs/warp7_defconfig
+++ b/configs/warp7_defconfig
@@ -6,7 +6,6 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx7s-warp"
-CONFIG_OPTEE_TZDRAM_SIZE=0x3000000
 CONFIG_TARGET_WARP7=y
 CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 # CONFIG_ARMV7_VIRT is not set
@@ -81,4 +80,5 @@ CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_USB_ETH_CDC=y
 CONFIG_USBNET_HOST_ADDR="de:ad:be:af:00:00"
+CONFIG_OPTEE_TZDRAM_SIZE=0x3000000
 CONFIG_BOOTM_OPTEE=y
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index 540c43096d8f..816cb89bbe21 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -17,12 +17,11 @@ CONFIG_TARGET_X3_T30=y
 CONFIG_TEGRA_ENABLE_UARTD=y
 CONFIG_CMD_EBTUPDATE=y
 CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_USE_BOOTCOMMAND=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
@@ -45,7 +44,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_NFS is not set
 CONFIG_CMD_PAUSE=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
diff --git a/configs/xenguest_arm64_defconfig b/configs/xenguest_arm64_defconfig
index a696c2807b06..10bf7ca4eefe 100644
--- a/configs/xenguest_arm64_defconfig
+++ b/configs/xenguest_arm64_defconfig
@@ -9,8 +9,8 @@ CONFIG_DEFAULT_DEVICE_TREE="xenguest-arm64"
 CONFIG_SYS_PROMPT="xenguest# "
 CONFIG_IDENT_STRING=" xenguest"
 CONFIG_SYS_LOAD_ADDR=0x40000000
-CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=10
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=1051
 # CONFIG_CMD_BDI is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 4b0793411c78..24cc3cbdc0f9 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -17,8 +17,8 @@ CONFIG_VERSAL_NO_DDR=y
 CONFIG_SYS_LOAD_ADDR=0x8000000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 # CONFIG_AUTOBOOT is not set
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_LOGLEVEL=0
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index 346df0cf23c7..72a70020db0b 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -22,8 +22,8 @@ CONFIG_SYS_MEMTEST_END=0x00001000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 # CONFIG_AUTOBOOT is not set
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_EARLY_INIT_R=y
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index a7ebc38cda1b..1061d8b94859 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -16,8 +16,8 @@ CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 # CONFIG_AUTOBOOT is not set
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_LOGLEVEL=0
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 62322af458d6..a100e9871b51 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -16,9 +16,9 @@ CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=5
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 89566c7d52c0..46ec889f9b8e 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -19,9 +19,9 @@ CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=5
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_USE_PREBOOT=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_CLOCKS=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 990057734595..bc1a1766f1e3 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -27,8 +27,8 @@ CONFIG_SPL_FIT_PRINT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
 CONFIG_LEGACY_IMAGE_FORMAT=y
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_DISTRO_DEFAULTS=y
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_USE_PREBOOT=y
 CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x30000
@@ -148,7 +148,6 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x03fd
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_FUNCTION_THOR=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 CONFIG_SPL_GZIP=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index e6a9dd31a572..5724cc17084e 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -18,8 +18,8 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 # CONFIG_AUTOBOOT is not set
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_LOGLEVEL=0
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_LATE_INIT is not set
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 30e420951dad..20979a7a10bd 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -25,8 +25,8 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_DISTRO_DEFAULTS=y
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="run scsi_init;usb start"
 CONFIG_BOARD_EARLY_INIT_R=y
@@ -219,7 +219,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Xilinx"
 CONFIG_USB_GADGET_VENDOR_NUM=0x03FD
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
-CONFIG_USB_FUNCTION_THOR=y
 CONFIG_USB_ETHER=y
 CONFIG_USB_ETH_CDC=y
 CONFIG_VIDEO=y
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index 08c500930fd5..d0200ef88b8a 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -23,8 +23,8 @@ CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
 CONFIG_SYS_CUSTOM_LDSCRIPT=y
 CONFIG_SYS_LDSCRIPT="arch/arm/mach-zynq/u-boot.lds"
-# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 # CONFIG_AUTOBOOT is not set
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_LATE_INIT is not set
-- 
2.42.0.515.g380fc7ccd1-goog

