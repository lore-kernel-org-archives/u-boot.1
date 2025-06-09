Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62B6C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 20:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC6F82B45;
	Mon,  9 Jun 2025 22:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="D+z6UB1J";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S8YdaSse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82AB82C30; Mon,  9 Jun 2025 21:27:35 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED03782B63
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bGMPl4jtZz9tR9;
 Mon,  9 Jun 2025 21:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBSNo/QHTn0TQbaHMjK0Mm3Qip7MXjJYtJkx1QJMykk=;
 b=D+z6UB1JopOcGztHj4kLe6Oc8SPqmFwPqeFJ2PJjaUWMn88sWORZ/oDJIglDEkbRAlu27t
 i/HkIde+Yz8KSTh1V3AC5+ymAf5vGyibXnehCTdd2McQ8o/iqZsb8FB9ZFK57Qu1VvPy6J
 8sBRg4EY5eQcbA1obiCl3YlLVVX7N7RA4sv7M9xE/42qfbFDaMd14ef4rZnY4BS603aFLK
 KhWhQM+5N2IGG5Xtw/sRu466yZ9fzRRuEaV8ORTWpvxeBvKXWvLmEsLv10bL1Z5IK1W4VZ
 F6i4kypqlSf8F/sGkuwNdBAWkDgsRxZZ/FY9cf3EmAvM2cpqN8bBrE7OVmZ2lA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBSNo/QHTn0TQbaHMjK0Mm3Qip7MXjJYtJkx1QJMykk=;
 b=S8YdaSseLyafhwKnjbxVnzOJY64lMEJj942s/XcKv5iYnDVGSfcgISfC8McfhiBw1bRsP9
 BsKkQDDNsGcjAIgOE0mbii4fPW4qR+KWyIJ+ELQ5FodgGIPdXyequDMTFLEr7OF/r7WAXm
 GBadjV9OrvomkeKlvDI1q3FPfR0LfeIwUo9Oa9NnFraHX/kknKMwVvKsp+VBSHnH+ou10b
 j4ntAuY+3owd7i3X76RJ09cogrl3S5wQkwuXa4drc8l2EWB7LGDwJBDU7/5vEcYAGYZHrR
 dE+WWvYWWZr+6i6wEZIDVc0L0Ap5aN1zw6EOxEAyKbheTREoGfMWK0tNym7YTw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/8] env: Rename SYS_RELOC_GD_ENV_ADDR to
 ENV_RELOC_GD_ENV_ADDR
Date: Mon,  9 Jun 2025 21:26:38 +0200
Message-ID: <20250609192701.20260-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
References: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n9boosrfyita97n4rkau8iow3f8hmsx3
X-MBO-RS-ID: cbe6fda7925b0a16b62
X-Mailman-Approved-At: Mon, 09 Jun 2025 22:23:14 +0200
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

Rename the variable and add ENV_ prefix, so that all configuration
options which are related to environment would have an CONFIG_ENV_
prefix. No functional change.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Add RB from Tom
---
 arch/arm/Kconfig                                            | 4 ++--
 arch/arm/lib/crt0.S                                         | 2 +-
 arch/arm/lib/crt0_64.S                                      | 2 +-
 arch/arm/mach-rockchip/Kconfig                              | 4 ++--
 common/board_r.c                                            | 2 +-
 configs/M5208EVBE_defconfig                                 | 2 +-
 configs/M5235EVB_Flash32_defconfig                          | 2 +-
 configs/M5235EVB_defconfig                                  | 2 +-
 configs/M5249EVB_defconfig                                  | 2 +-
 configs/M5253DEMO_defconfig                                 | 2 +-
 configs/M5272C3_defconfig                                   | 2 +-
 configs/M5275EVB_defconfig                                  | 2 +-
 configs/M5282EVB_defconfig                                  | 2 +-
 configs/M5329AFEE_defconfig                                 | 2 +-
 configs/M5329BFEE_defconfig                                 | 2 +-
 configs/M5373EVB_defconfig                                  | 2 +-
 configs/MCR3000_defconfig                                   | 2 +-
 configs/P1010RDB-PA_36BIT_NAND_defconfig                    | 2 +-
 configs/P1010RDB-PA_36BIT_SDCARD_defconfig                  | 2 +-
 configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig                | 2 +-
 configs/P1010RDB-PA_NAND_defconfig                          | 2 +-
 configs/P1010RDB-PA_SDCARD_defconfig                        | 2 +-
 configs/P1010RDB-PA_SPIFLASH_defconfig                      | 2 +-
 configs/P1010RDB-PB_36BIT_NAND_defconfig                    | 2 +-
 configs/P1010RDB-PB_36BIT_SDCARD_defconfig                  | 2 +-
 configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig                | 2 +-
 configs/P1010RDB-PB_NAND_defconfig                          | 2 +-
 configs/P1010RDB-PB_SDCARD_defconfig                        | 2 +-
 configs/P1010RDB-PB_SPIFLASH_defconfig                      | 2 +-
 configs/P1020RDB-PC_36BIT_NAND_defconfig                    | 2 +-
 configs/P1020RDB-PC_36BIT_SDCARD_defconfig                  | 2 +-
 configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig                | 2 +-
 configs/P1020RDB-PC_NAND_defconfig                          | 2 +-
 configs/P1020RDB-PC_SDCARD_defconfig                        | 2 +-
 configs/P1020RDB-PC_SPIFLASH_defconfig                      | 2 +-
 configs/P1020RDB-PD_NAND_defconfig                          | 2 +-
 configs/P1020RDB-PD_SDCARD_defconfig                        | 2 +-
 configs/P1020RDB-PD_SPIFLASH_defconfig                      | 2 +-
 configs/P2020RDB-PC_36BIT_NAND_defconfig                    | 2 +-
 configs/P2020RDB-PC_36BIT_SDCARD_defconfig                  | 2 +-
 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig                | 2 +-
 configs/P2020RDB-PC_NAND_defconfig                          | 2 +-
 configs/P2020RDB-PC_SDCARD_defconfig                        | 2 +-
 configs/P2020RDB-PC_SPIFLASH_defconfig                      | 2 +-
 configs/P2041RDB_NAND_defconfig                             | 2 +-
 configs/P2041RDB_SDCARD_defconfig                           | 2 +-
 configs/P2041RDB_SPIFLASH_defconfig                         | 2 +-
 configs/SBx81LIFKW_defconfig                                | 2 +-
 configs/SBx81LIFXCAT_defconfig                              | 2 +-
 configs/T2080QDS_SECURE_BOOT_defconfig                      | 2 +-
 configs/ae350_rv32_defconfig                                | 2 +-
 configs/ae350_rv32_xip_defconfig                            | 2 +-
 configs/ae350_rv64_defconfig                                | 2 +-
 configs/ae350_rv64_xip_defconfig                            | 2 +-
 configs/am335x_baltos_defconfig                             | 2 +-
 configs/am335x_evm_defconfig                                | 2 +-
 configs/am335x_evm_spiboot_defconfig                        | 2 +-
 configs/am335x_guardian_defconfig                           | 2 +-
 configs/am335x_hs_evm_defconfig                             | 2 +-
 configs/am335x_hs_evm_uart_defconfig                        | 2 +-
 configs/am335x_igep003x_defconfig                           | 2 +-
 configs/am335x_pdu001_defconfig                             | 2 +-
 configs/am335x_shc_defconfig                                | 2 +-
 configs/am335x_shc_ict_defconfig                            | 2 +-
 configs/am335x_shc_netboot_defconfig                        | 2 +-
 configs/am335x_shc_sdboot_defconfig                         | 2 +-
 configs/am335x_sl50_defconfig                               | 2 +-
 configs/am43xx_evm_defconfig                                | 2 +-
 configs/am43xx_evm_qspiboot_defconfig                       | 2 +-
 configs/am43xx_evm_rtconly_defconfig                        | 2 +-
 configs/am43xx_evm_usbhost_boot_defconfig                   | 2 +-
 configs/am43xx_hs_evm_defconfig                             | 2 +-
 configs/am43xx_hs_evm_qspi_defconfig                        | 2 +-
 configs/am57xx_evm_defconfig                                | 2 +-
 configs/am57xx_hs_evm_defconfig                             | 2 +-
 configs/am57xx_hs_evm_usb_defconfig                         | 2 +-
 configs/am62ax_evm_r5_defconfig                             | 2 +-
 configs/am62px_evm_r5_defconfig                             | 2 +-
 configs/am62x_beagleplay_r5_defconfig                       | 2 +-
 configs/am62x_evm_r5_defconfig                              | 2 +-
 configs/am64x_evm_r5_defconfig                              | 2 +-
 configs/am65x_evm_a53_defconfig                             | 2 +-
 configs/am65x_evm_r5_defconfig                              | 2 +-
 configs/am65x_evm_r5_usbmsc_defconfig                       | 2 +-
 configs/am67a_beagley_ai_r5_defconfig                       | 2 +-
 configs/amd_versal2_mini_defconfig                          | 2 +-
 configs/amd_versal2_mini_emmc_defconfig                     | 2 +-
 configs/amd_versal2_mini_ospi_defconfig                     | 2 +-
 configs/amd_versal2_mini_qspi_defconfig                     | 2 +-
 configs/amd_versal2_virt_defconfig                          | 2 +-
 configs/aml-a311d-cc_defconfig                              | 2 +-
 configs/aml-s905d3-cc_defconfig                             | 2 +-
 configs/an7581_evb_defconfig                                | 2 +-
 configs/ap121_defconfig                                     | 2 +-
 configs/ap143_defconfig                                     | 2 +-
 configs/ap152_defconfig                                     | 2 +-
 configs/apalis-imx8_defconfig                               | 2 +-
 configs/apalis-tk1_defconfig                                | 2 +-
 configs/apalis_imx6_defconfig                               | 2 +-
 configs/apalis_t30_defconfig                                | 2 +-
 configs/aristainetos2c_defconfig                            | 2 +-
 configs/aristainetos2ccslb_defconfig                        | 2 +-
 configs/arndale_defconfig                                   | 2 +-
 configs/at91sam9260ek_dataflash_cs0_defconfig               | 2 +-
 configs/at91sam9260ek_dataflash_cs1_defconfig               | 2 +-
 configs/at91sam9260ek_nandflash_defconfig                   | 2 +-
 configs/at91sam9261ek_dataflash_cs0_defconfig               | 2 +-
 configs/at91sam9261ek_dataflash_cs3_defconfig               | 2 +-
 configs/at91sam9261ek_nandflash_defconfig                   | 2 +-
 configs/at91sam9263ek_dataflash_cs0_defconfig               | 2 +-
 configs/at91sam9263ek_dataflash_defconfig                   | 2 +-
 configs/at91sam9263ek_nandflash_defconfig                   | 2 +-
 configs/at91sam9g10ek_dataflash_cs0_defconfig               | 2 +-
 configs/at91sam9g10ek_dataflash_cs3_defconfig               | 2 +-
 configs/at91sam9g10ek_nandflash_defconfig                   | 2 +-
 configs/at91sam9g20ek_2mmc_defconfig                        | 2 +-
 configs/at91sam9g20ek_2mmc_nandflash_defconfig              | 2 +-
 configs/at91sam9g20ek_dataflash_cs0_defconfig               | 2 +-
 configs/at91sam9g20ek_dataflash_cs1_defconfig               | 2 +-
 configs/at91sam9g20ek_nandflash_defconfig                   | 2 +-
 configs/at91sam9m10g45ek_mmc_defconfig                      | 2 +-
 configs/at91sam9m10g45ek_nandflash_defconfig                | 2 +-
 configs/at91sam9n12ek_mmc_defconfig                         | 2 +-
 configs/at91sam9n12ek_nandflash_defconfig                   | 2 +-
 configs/at91sam9n12ek_spiflash_defconfig                    | 2 +-
 configs/at91sam9rlek_dataflash_defconfig                    | 2 +-
 configs/at91sam9rlek_mmc_defconfig                          | 2 +-
 configs/at91sam9rlek_nandflash_defconfig                    | 2 +-
 configs/at91sam9x5ek_dataflash_defconfig                    | 2 +-
 configs/at91sam9x5ek_mmc_defconfig                          | 2 +-
 configs/at91sam9x5ek_nandflash_defconfig                    | 2 +-
 configs/at91sam9x5ek_spiflash_defconfig                     | 2 +-
 configs/at91sam9xeek_dataflash_cs0_defconfig                | 2 +-
 configs/at91sam9xeek_dataflash_cs1_defconfig                | 2 +-
 configs/at91sam9xeek_nandflash_defconfig                    | 2 +-
 configs/axm_defconfig                                       | 2 +-
 configs/axs101_defconfig                                    | 2 +-
 configs/axs103_defconfig                                    | 2 +-
 configs/bananapi-cm4-cm4io_defconfig                        | 2 +-
 configs/bananapi-m2-pro_defconfig                           | 2 +-
 configs/bananapi-m2s_defconfig                              | 2 +-
 configs/bananapi-m5_defconfig                               | 2 +-
 configs/bayleybay_defconfig                                 | 2 +-
 configs/bcm7260_defconfig                                   | 2 +-
 configs/bcm7445_defconfig                                   | 2 +-
 configs/bcm968380gerg_ram_defconfig                         | 2 +-
 configs/beaver_defconfig                                    | 2 +-
 configs/beelink-gsking-x_defconfig                          | 2 +-
 configs/beelink-gt1-ultimate_defconfig                      | 2 +-
 configs/beelink-gtking_defconfig                            | 2 +-
 configs/beelink-gtkingpro_defconfig                         | 2 +-
 configs/bitmain_antminer_s9_defconfig                       | 2 +-
 configs/bk4r1_defconfig                                     | 2 +-
 configs/brppt1_mmc_defconfig                                | 2 +-
 configs/brppt2_defconfig                                    | 2 +-
 configs/brsmarc1_defconfig                                  | 2 +-
 configs/brxre1_defconfig                                    | 2 +-
 configs/cardhu_defconfig                                    | 2 +-
 configs/cei-tk1-som_defconfig                               | 2 +-
 configs/cherryhill_defconfig                                | 2 +-
 configs/chiliboard_defconfig                                | 2 +-
 configs/chromebit_mickey_defconfig                          | 2 +-
 configs/chromebook_bob_defconfig                            | 2 +-
 configs/chromebook_jerry_defconfig                          | 2 +-
 configs/chromebook_kevin_defconfig                          | 2 +-
 configs/chromebook_link64_defconfig                         | 2 +-
 configs/chromebook_link_defconfig                           | 2 +-
 configs/chromebook_minnie_defconfig                         | 2 +-
 configs/chromebook_samus_defconfig                          | 2 +-
 configs/chromebook_samus_tpl_defconfig                      | 2 +-
 configs/chromebook_speedy_defconfig                         | 2 +-
 configs/chromebox_panther_defconfig                         | 2 +-
 configs/ci20_mmc_defconfig                                  | 2 +-
 configs/cl-som-imx7_defconfig                               | 2 +-
 configs/clearfog_gt_8k_defconfig                            | 2 +-
 configs/cm3588-nas-rk3588_defconfig                         | 2 +-
 configs/cm_fx6_defconfig                                    | 2 +-
 configs/cm_t43_defconfig                                    | 2 +-
 configs/cobra5272_defconfig                                 | 2 +-
 configs/colibri-imx6ull-emmc_defconfig                      | 2 +-
 configs/colibri-imx6ull_defconfig                           | 2 +-
 configs/colibri-imx8x_defconfig                             | 2 +-
 configs/colibri_imx6_defconfig                              | 2 +-
 configs/colibri_imx7_defconfig                              | 2 +-
 configs/colibri_imx7_emmc_defconfig                         | 2 +-
 configs/colibri_t20_defconfig                               | 2 +-
 configs/colibri_t30_defconfig                               | 2 +-
 configs/colibri_vf_defconfig                                | 2 +-
 configs/comtrend_ar5315u_ram_defconfig                      | 2 +-
 configs/comtrend_ar5387un_ram_defconfig                     | 2 +-
 configs/comtrend_ct5361_ram_defconfig                       | 2 +-
 configs/comtrend_vr3032u_ram_defconfig                      | 2 +-
 configs/comtrend_wap5813n_ram_defconfig                     | 2 +-
 configs/conga-qeval20-qa3-e3845-internal-uart_defconfig     | 2 +-
 configs/conga-qeval20-qa3-e3845_defconfig                   | 2 +-
 configs/controlcenterdc_defconfig                           | 2 +-
 configs/coreboot64-no-spl_defconfig                         | 2 +-
 configs/coreboot64_defconfig                                | 2 +-
 configs/coreboot_defconfig                                  | 2 +-
 configs/corvus_defconfig                                    | 2 +-
 configs/cougarcanyon2_defconfig                             | 2 +-
 configs/crownbay_defconfig                                  | 2 +-
 configs/crs305-1g-4s-bit_defconfig                          | 2 +-
 configs/crs305-1g-4s_defconfig                              | 2 +-
 configs/crs326-24g-2s-bit_defconfig                         | 2 +-
 configs/crs326-24g-2s_defconfig                             | 2 +-
 configs/crs328-4c-20s-4s-bit_defconfig                      | 2 +-
 configs/crs328-4c-20s-4s_defconfig                          | 2 +-
 configs/da850evm_defconfig                                  | 2 +-
 configs/da850evm_nand_defconfig                             | 2 +-
 configs/dalmore_defconfig                                   | 2 +-
 configs/db-88f6720_defconfig                                | 2 +-
 configs/db-88f6820-amc_defconfig                            | 2 +-
 configs/db-88f6820-amc_nand_defconfig                       | 2 +-
 configs/db-88f6820-gp_defconfig                             | 2 +-
 configs/db-mv784mp-gp_defconfig                             | 2 +-
 configs/db-xc3-24g4xg_defconfig                             | 2 +-
 configs/devkit8000_defconfig                                | 2 +-
 configs/dfi-bt700-q7x-151_defconfig                         | 2 +-
 configs/display5_defconfig                                  | 2 +-
 configs/display5_factory_defconfig                          | 2 +-
 configs/dra7xx_evm_defconfig                                | 2 +-
 configs/dra7xx_hs_evm_defconfig                             | 2 +-
 configs/dra7xx_hs_evm_usb_defconfig                         | 2 +-
 configs/draco-etamin_defconfig                              | 2 +-
 configs/draco-rastaban_defconfig                            | 2 +-
 configs/draco-thuban_defconfig                              | 2 +-
 configs/dragonboard410c_defconfig                           | 2 +-
 configs/dragonboard820c_defconfig                           | 2 +-
 configs/ds116_defconfig                                     | 2 +-
 configs/ds414_defconfig                                     | 2 +-
 configs/durian_defconfig                                    | 2 +-
 configs/e850-96_defconfig                                   | 2 +-
 configs/eDPU_defconfig                                      | 2 +-
 configs/eaidk-610-rk3399_defconfig                          | 2 +-
 configs/edison_defconfig                                    | 2 +-
 configs/efi-x86_app32_defconfig                             | 2 +-
 configs/efi-x86_app64_defconfig                             | 2 +-
 configs/efi-x86_payload32_defconfig                         | 2 +-
 configs/efi-x86_payload64_defconfig                         | 2 +-
 configs/elgin-rv1108_defconfig                              | 2 +-
 configs/emsdp_defconfig                                     | 2 +-
 configs/endeavoru_defconfig                                 | 2 +-
 configs/espresso7420_defconfig                              | 2 +-
 configs/evb-ast2500_defconfig                               | 2 +-
 configs/evb-ast2600_defconfig                               | 2 +-
 configs/evb-px30_defconfig                                  | 2 +-
 configs/evb-px5_defconfig                                   | 2 +-
 configs/evb-rk3036_defconfig                                | 2 +-
 configs/evb-rk3128_defconfig                                | 2 +-
 configs/evb-rk3229_defconfig                                | 2 +-
 configs/evb-rk3288_defconfig                                | 2 +-
 configs/evb-rk3308_defconfig                                | 2 +-
 configs/evb-rk3328_defconfig                                | 2 +-
 configs/evb-rk3399_defconfig                                | 2 +-
 configs/evb-rv1108_defconfig                                | 2 +-
 configs/ficus-rk3399_defconfig                              | 2 +-
 configs/firefly-px30_defconfig                              | 2 +-
 configs/firefly-rk3288_defconfig                            | 2 +-
 configs/firefly-rk3399_defconfig                            | 2 +-
 configs/galileo_defconfig                                   | 2 +-
 configs/gardena-smart-gateway-at91sam_defconfig             | 2 +-
 configs/gardena-smart-gateway-mt7688_defconfig              | 2 +-
 configs/ge_bx50v3_defconfig                                 | 2 +-
 configs/geekbox_defconfig                                   | 2 +-
 configs/generic-rk3328_defconfig                            | 2 +-
 configs/generic-rk3399_defconfig                            | 2 +-
 configs/generic-rk3568_defconfig                            | 2 +-
 configs/generic-rk3588_defconfig                            | 2 +-
 configs/grouper_defconfig                                   | 2 +-
 configs/grpeach_defconfig                                   | 2 +-
 configs/gurnard_defconfig                                   | 2 +-
 configs/guruplug_defconfig                                  | 2 +-
 configs/gwventana_emmc_defconfig                            | 2 +-
 configs/gwventana_nand_defconfig                            | 2 +-
 configs/harmony_defconfig                                   | 2 +-
 configs/hc2910_2aghd05_defconfig                            | 2 +-
 configs/hihope_rzg2_defconfig                               | 2 +-
 configs/hikey960_defconfig                                  | 2 +-
 configs/hikey_defconfig                                     | 2 +-
 configs/hmibsc_defconfig                                    | 2 +-
 configs/hsdk_4xd_defconfig                                  | 2 +-
 configs/hsdk_defconfig                                      | 2 +-
 configs/huawei_hg556a_ram_defconfig                         | 2 +-
 configs/ib62x0_defconfig                                    | 2 +-
 configs/ibex-ast2700_defconfig                              | 2 +-
 configs/ibm-sbp1_defconfig                                  | 2 +-
 configs/iconnect_defconfig                                  | 2 +-
 configs/ideapad-yoga-11_defconfig                           | 2 +-
 configs/igep00x0_defconfig                                  | 2 +-
 configs/imgtec_xilfpga_defconfig                            | 2 +-
 configs/imx6dl_icore_nand_defconfig                         | 2 +-
 configs/imx6dl_mamoj_defconfig                              | 2 +-
 configs/imx6dl_sielaff_defconfig                            | 2 +-
 configs/imx6q_icore_nand_defconfig                          | 2 +-
 configs/imx6q_logic_defconfig                               | 2 +-
 configs/imx6qdl_icore_mipi_defconfig                        | 2 +-
 configs/imx6qdl_icore_mmc_defconfig                         | 2 +-
 configs/imx6qdl_icore_nand_defconfig                        | 2 +-
 configs/imx6qdl_icore_rqs_defconfig                         | 2 +-
 configs/imx6ul_geam_mmc_defconfig                           | 2 +-
 configs/imx6ul_geam_nand_defconfig                          | 2 +-
 configs/imx6ul_isiot_emmc_defconfig                         | 2 +-
 configs/imx6ul_isiot_nand_defconfig                         | 2 +-
 configs/imx6ulz_smm_m2_defconfig                            | 2 +-
 configs/imx6ulz_smm_m2b_defconfig                           | 2 +-
 configs/imx7_cm_defconfig                                   | 2 +-
 configs/imx8m_data_modul.config                             | 2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig                  | 2 +-
 configs/imx8mm-cl-iot-gate_defconfig                        | 2 +-
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig                | 2 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig               | 2 +-
 configs/imx8mm-mx8menlo_defconfig                           | 2 +-
 configs/imx8mm-phygate-tauri-l_defconfig                    | 2 +-
 configs/imx8mm_beacon_defconfig                             | 2 +-
 configs/imx8mm_beacon_fspi_defconfig                        | 2 +-
 configs/imx8mm_evk_defconfig                                | 2 +-
 configs/imx8mm_evk_fspi_defconfig                           | 2 +-
 configs/imx8mm_phg_defconfig                                | 2 +-
 configs/imx8mn_beacon_2g_defconfig                          | 2 +-
 configs/imx8mn_beacon_defconfig                             | 2 +-
 configs/imx8mn_beacon_fspi_defconfig                        | 2 +-
 configs/imx8mn_bsh_smm_s2_defconfig                         | 2 +-
 configs/imx8mn_bsh_smm_s2pro_defconfig                      | 2 +-
 configs/imx8mn_ddr4_evk_defconfig                           | 2 +-
 configs/imx8mn_evk_defconfig                                | 2 +-
 configs/imx8mn_var_som_defconfig                            | 2 +-
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig               | 2 +-
 configs/imx8mp_beacon_defconfig                             | 2 +-
 configs/imx8mp_debix_model_a_defconfig                      | 2 +-
 configs/imx8mp_evk_defconfig                                | 2 +-
 configs/imx8mp_navqp_defconfig                              | 2 +-
 configs/imx8mp_rsb3720a1_4G_defconfig                       | 2 +-
 configs/imx8mp_rsb3720a1_6G_defconfig                       | 2 +-
 configs/imx8mq_cm_defconfig                                 | 2 +-
 configs/imx8mq_evk_defconfig                                | 2 +-
 configs/imx8mq_phanbell_defconfig                           | 2 +-
 configs/imx8mq_reform2_defconfig                            | 2 +-
 configs/imx8qm_mek_defconfig                                | 2 +-
 configs/imx8qm_rom7720_a1_4G_defconfig                      | 2 +-
 configs/imx8qxp_mek_defconfig                               | 2 +-
 configs/imx91_11x11_evk_defconfig                           | 2 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig                | 2 +-
 configs/imx93-phycore_defconfig                             | 2 +-
 configs/imx93_11x11_evk_defconfig                           | 2 +-
 configs/imx93_9x9_qsb_defconfig                             | 2 +-
 configs/imx93_9x9_qsb_inline_ecc_defconfig                  | 2 +-
 configs/imx93_var_som_defconfig                             | 2 +-
 configs/imx95_19x19_evk_defconfig                           | 2 +-
 configs/imx_dhsom.config                                    | 2 +-
 configs/imxrt1020-evk_defconfig                             | 2 +-
 configs/imxrt1050-evk_defconfig                             | 2 +-
 configs/imxrt1050-evk_fspi_defconfig                        | 2 +-
 configs/imxrt1170-evk_defconfig                             | 2 +-
 configs/integratorap_cm720t_defconfig                       | 2 +-
 configs/integratorap_cm920t_defconfig                       | 2 +-
 configs/integratorap_cm926ejs_defconfig                     | 2 +-
 configs/integratorap_cm946es_defconfig                      | 2 +-
 configs/inteno_xg6846_ram_defconfig                         | 2 +-
 configs/iot_devkit_defconfig                                | 2 +-
 configs/j7200_evm_a72_defconfig                             | 2 +-
 configs/j7200_evm_r5_defconfig                              | 2 +-
 configs/j721e_beagleboneai64_a72_defconfig                  | 2 +-
 configs/j721e_beagleboneai64_r5_defconfig                   | 2 +-
 configs/j721e_evm_a72_defconfig                             | 2 +-
 configs/j721e_evm_r5_defconfig                              | 2 +-
 configs/j721s2_evm_a72_defconfig                            | 2 +-
 configs/j721s2_evm_r5_defconfig                             | 2 +-
 configs/j722s_evm_r5_defconfig                              | 2 +-
 configs/j784s4_evm_a72_defconfig                            | 2 +-
 configs/j784s4_evm_r5_defconfig                             | 2 +-
 configs/jaguar-rk3588_defconfig                             | 2 +-
 configs/jethub_j100_defconfig                               | 2 +-
 configs/jethub_j80_defconfig                                | 2 +-
 configs/jetson-tk1_defconfig                                | 2 +-
 configs/k2e_evm_defconfig                                   | 2 +-
 configs/k2e_hs_evm_defconfig                                | 2 +-
 configs/k2g_evm_defconfig                                   | 2 +-
 configs/k2g_hs_evm_defconfig                                | 2 +-
 configs/k2hk_evm_defconfig                                  | 2 +-
 configs/k2hk_hs_evm_defconfig                               | 2 +-
 configs/k2l_evm_defconfig                                   | 2 +-
 configs/k2l_hs_evm_defconfig                                | 2 +-
 configs/khadas-edge-captain-rk3399_defconfig                | 2 +-
 configs/khadas-edge-rk3399_defconfig                        | 2 +-
 configs/khadas-edge-v-rk3399_defconfig                      | 2 +-
 configs/khadas-vim2_defconfig                               | 2 +-
 configs/khadas-vim3_android_ab_defconfig                    | 2 +-
 configs/khadas-vim3_android_defconfig                       | 2 +-
 configs/khadas-vim3_defconfig                               | 2 +-
 configs/khadas-vim3l_android_ab_defconfig                   | 2 +-
 configs/khadas-vim3l_android_defconfig                      | 2 +-
 configs/khadas-vim3l_defconfig                              | 2 +-
 configs/khadas-vim_defconfig                                | 2 +-
 configs/kontron_pitx_imx8m_defconfig                        | 2 +-
 configs/kp_imx53_defconfig                                  | 2 +-
 configs/kp_imx6q_tpc_defconfig                              | 2 +-
 configs/kylin-rk3036_defconfig                              | 2 +-
 configs/lckfb-tspi-rk3566_defconfig                         | 2 +-
 configs/leez-rk3399_defconfig                               | 2 +-
 configs/legoev3_defconfig                                   | 2 +-
 configs/librem5_defconfig                                   | 2 +-
 configs/libretech-ac_defconfig                              | 2 +-
 configs/libretech-cc_defconfig                              | 2 +-
 configs/libretech-cc_v2_defconfig                           | 2 +-
 configs/linkit-smart-7688_defconfig                         | 2 +-
 configs/liteboard_defconfig                                 | 2 +-
 configs/ls1012a2g5rdb_tfa_defconfig                         | 2 +-
 configs/ls1012afrdm_tfa_defconfig                           | 2 +-
 configs/ls1012afrwy_tfa_defconfig                           | 2 +-
 configs/ls1012aqds_tfa_SECURE_BOOT_defconfig                | 2 +-
 configs/ls1012aqds_tfa_defconfig                            | 2 +-
 configs/ls1012ardb_tfa_SECURE_BOOT_defconfig                | 2 +-
 configs/ls1012ardb_tfa_defconfig                            | 2 +-
 configs/ls1021aiot_qspi_defconfig                           | 2 +-
 configs/ls1021aiot_sdcard_defconfig                         | 2 +-
 configs/ls1021aqds_nand_defconfig                           | 2 +-
 configs/ls1021aqds_qspi_defconfig                           | 2 +-
 configs/ls1021aqds_sdcard_ifc_defconfig                     | 2 +-
 configs/ls1021aqds_sdcard_qspi_defconfig                    | 2 +-
 configs/ls1021atsn_qspi_defconfig                           | 2 +-
 configs/ls1021atsn_sdcard_defconfig                         | 2 +-
 configs/ls1021atwr_qspi_defconfig                           | 2 +-
 configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig         | 2 +-
 configs/ls1021atwr_sdcard_ifc_defconfig                     | 2 +-
 configs/ls1021atwr_sdcard_qspi_defconfig                    | 2 +-
 configs/ls1043aqds_tfa_defconfig                            | 2 +-
 configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig               | 2 +-
 configs/ls1046afrwy_tfa_defconfig                           | 2 +-
 configs/ls1046aqds_tfa_defconfig                            | 2 +-
 configs/ls1046ardb_tfa_defconfig                            | 2 +-
 configs/ls1088aqds_tfa_defconfig                            | 2 +-
 configs/ls1088ardb_tfa_defconfig                            | 2 +-
 configs/ls2080aqds_nand_defconfig                           | 2 +-
 configs/ls2080aqds_qspi_defconfig                           | 2 +-
 configs/ls2080ardb_nand_defconfig                           | 2 +-
 configs/ls2088aqds_tfa_defconfig                            | 2 +-
 configs/lschlv2_defconfig                                   | 2 +-
 configs/lsxhl_defconfig                                     | 2 +-
 configs/lxr2_defconfig                                      | 2 +-
 configs/m53menlo_defconfig                                  | 2 +-
 configs/marsboard_defconfig                                 | 2 +-
 configs/maxbcm_defconfig                                    | 2 +-
 configs/medcom-wide_defconfig                               | 2 +-
 configs/meerkat96_defconfig                                 | 2 +-
 configs/meesc_dataflash_defconfig                           | 2 +-
 configs/meesc_defconfig                                     | 2 +-
 configs/microchip_mpfs_icicle_defconfig                     | 2 +-
 configs/minnowmax_defconfig                                 | 2 +-
 configs/miqi-rk3288_defconfig                               | 2 +-
 configs/mk808_defconfig                                     | 2 +-
 configs/mocha_defconfig                                     | 2 +-
 configs/mot_defconfig                                       | 2 +-
 configs/msc_sm2s_imx8mp_defconfig                           | 2 +-
 configs/mscc_jr2_defconfig                                  | 2 +-
 configs/mscc_luton_defconfig                                | 2 +-
 configs/mscc_ocelot_defconfig                               | 2 +-
 configs/mscc_serval_defconfig                               | 2 +-
 configs/mscc_servalt_defconfig                              | 2 +-
 configs/mt7620_mt7530_rfb_defconfig                         | 2 +-
 configs/mt7620_rfb_defconfig                                | 2 +-
 configs/mt7621_nand_rfb_defconfig                           | 2 +-
 configs/mt7621_rfb_defconfig                                | 2 +-
 configs/mt7623a_unielec_u7623_02_defconfig                  | 2 +-
 configs/mt7623n_bpir2_defconfig                             | 2 +-
 configs/mt7628_rfb_defconfig                                | 2 +-
 configs/mt7629_rfb_defconfig                                | 2 +-
 configs/mt8516_pumpkin_defconfig                            | 2 +-
 configs/mvebu_crb_cn9130_defconfig                          | 2 +-
 configs/mvebu_db-88f3720_defconfig                          | 2 +-
 configs/mvebu_db_armada8k_defconfig                         | 2 +-
 configs/mvebu_db_cn9130_defconfig                           | 2 +-
 configs/mvebu_espressobin-88f3720_defconfig                 | 2 +-
 configs/mvebu_espressobin_ultra-88f3720_defconfig           | 2 +-
 configs/mvebu_mcbin-88f8040_defconfig                       | 2 +-
 configs/mvebu_puzzle-m801-88f8040_defconfig                 | 2 +-
 configs/mx23_olinuxino_defconfig                            | 2 +-
 configs/mx23evk_defconfig                                   | 2 +-
 configs/mx28evk_defconfig                                   | 2 +-
 configs/mx51evk_defconfig                                   | 2 +-
 configs/mx53cx9020_defconfig                                | 2 +-
 configs/mx53loco_defconfig                                  | 2 +-
 configs/mx53ppd_defconfig                                   | 2 +-
 configs/mx6cuboxi_defconfig                                 | 2 +-
 configs/mx6memcal_defconfig                                 | 2 +-
 configs/mx6qsabrelite_defconfig                             | 2 +-
 configs/mx6sabreauto_defconfig                              | 2 +-
 configs/mx6sabresd_defconfig                                | 2 +-
 configs/mx6slevk_defconfig                                  | 2 +-
 configs/mx6sllevk_defconfig                                 | 2 +-
 configs/mx6sllevk_plugin_defconfig                          | 2 +-
 configs/mx6sxsabreauto_defconfig                            | 2 +-
 configs/mx6sxsabresd_defconfig                              | 2 +-
 configs/mx6ul_14x14_evk_defconfig                           | 2 +-
 configs/mx6ul_9x9_evk_defconfig                             | 2 +-
 configs/mx6ull_14x14_evk_defconfig                          | 2 +-
 configs/mx6ull_14x14_evk_plugin_defconfig                   | 2 +-
 configs/mx6ulz_14x14_evk_defconfig                          | 2 +-
 configs/mx7dsabresd_defconfig                               | 2 +-
 configs/mx7dsabresd_qspi_defconfig                          | 2 +-
 configs/mx7ulp_evk_defconfig                                | 2 +-
 configs/mx7ulp_evk_plugin_defconfig                         | 2 +-
 configs/myir_mys_6ulx_defconfig                             | 2 +-
 configs/n2350_defconfig                                     | 2 +-
 configs/nanopc-t4-rk3399_defconfig                          | 2 +-
 configs/nanopc-t6-rk3588_defconfig                          | 2 +-
 configs/nanopi-k2_defconfig                                 | 2 +-
 configs/nanopi-m4-2gb-rk3399_defconfig                      | 2 +-
 configs/nanopi-m4-rk3399_defconfig                          | 2 +-
 configs/nanopi-m4b-rk3399_defconfig                         | 2 +-
 configs/nanopi-neo4-rk3399_defconfig                        | 2 +-
 configs/nanopi-r2c-plus-rk3328_defconfig                    | 2 +-
 configs/nanopi-r2c-rk3328_defconfig                         | 2 +-
 configs/nanopi-r2s-plus-rk3328_defconfig                    | 2 +-
 configs/nanopi-r2s-rk3328_defconfig                         | 2 +-
 configs/nanopi-r4s-rk3399_defconfig                         | 2 +-
 configs/nas220_defconfig                                    | 2 +-
 configs/netgear_cg3100d_ram_defconfig                       | 2 +-
 configs/netgear_dgnd3700v2_ram_defconfig                    | 2 +-
 configs/neu2-io-rv1126_defconfig                            | 2 +-
 configs/nitrogen6dl2g_defconfig                             | 2 +-
 configs/nitrogen6dl_defconfig                               | 2 +-
 configs/nitrogen6q2g_defconfig                              | 2 +-
 configs/nitrogen6q_defconfig                                | 2 +-
 configs/nitrogen6s1g_defconfig                              | 2 +-
 configs/nitrogen6s_defconfig                                | 2 +-
 configs/novena_defconfig                                    | 2 +-
 configs/nsa310s_defconfig                                   | 2 +-
 configs/nsim_700_defconfig                                  | 2 +-
 configs/nsim_700be_defconfig                                | 2 +-
 configs/nsim_hs38_defconfig                                 | 2 +-
 configs/nsim_hs38be_defconfig                               | 2 +-
 configs/nyan-big_defconfig                                  | 2 +-
 configs/odroid-c2_defconfig                                 | 2 +-
 configs/odroid-c4_defconfig                                 | 2 +-
 configs/odroid-go-ultra_defconfig                           | 2 +-
 configs/odroid-hc4_defconfig                                | 2 +-
 configs/odroid-m1s-rk3566_defconfig                         | 2 +-
 configs/odroid-m2-rk3588s_defconfig                         | 2 +-
 configs/odroid-n2_defconfig                                 | 2 +-
 configs/odroid-n2l_defconfig                                | 2 +-
 configs/odroid-xu3_defconfig                                | 2 +-
 configs/odroid_defconfig                                    | 2 +-
 configs/omap3_evm_defconfig                                 | 2 +-
 configs/omapl138_lcdk_defconfig                             | 2 +-
 configs/openrd_base_defconfig                               | 2 +-
 configs/openrd_client_defconfig                             | 2 +-
 configs/openrd_ultimate_defconfig                           | 2 +-
 configs/opos6uldev_defconfig                                | 2 +-
 configs/orangepi-3b-rk3566_defconfig                        | 2 +-
 configs/orangepi-r1-plus-lts-rk3328_defconfig               | 2 +-
 configs/orangepi-r1-plus-rk3328_defconfig                   | 2 +-
 configs/orangepi-rk3399_defconfig                           | 2 +-
 configs/origen_defconfig                                    | 2 +-
 configs/ouya_defconfig                                      | 2 +-
 configs/p200_defconfig                                      | 2 +-
 configs/p201_defconfig                                      | 2 +-
 configs/p212_defconfig                                      | 2 +-
 configs/p2371-0000_defconfig                                | 2 +-
 configs/p2371-2180_defconfig                                | 2 +-
 configs/p2571_defconfig                                     | 2 +-
 configs/p2771-0000-000_defconfig                            | 2 +-
 configs/p2771-0000-500_defconfig                            | 2 +-
 configs/paz00_defconfig                                     | 2 +-
 configs/pcm051_rev3_defconfig                               | 2 +-
 configs/pcm052_defconfig                                    | 2 +-
 configs/pcm058_defconfig                                    | 2 +-
 configs/pe2201_defconfig                                    | 2 +-
 configs/peach-pi_defconfig                                  | 2 +-
 configs/peach-pit_defconfig                                 | 2 +-
 configs/phycore-am335x-r2-regor_defconfig                   | 2 +-
 configs/phycore-am335x-r2-wega_defconfig                    | 2 +-
 configs/phycore-imx8mm_defconfig                            | 2 +-
 configs/phycore-imx8mp_defconfig                            | 2 +-
 configs/phycore-rk3288_defconfig                            | 2 +-
 configs/phycore_am62ax_r5_defconfig                         | 2 +-
 configs/phycore_am62x_r5_defconfig                          | 2 +-
 configs/phycore_am64x_r5_defconfig                          | 2 +-
 configs/phycore_pcl063_defconfig                            | 2 +-
 configs/phycore_pcl063_ull_defconfig                        | 2 +-
 configs/pic32mzdask_defconfig                               | 2 +-
 configs/picasso_defconfig                                   | 2 +-
 configs/pico-dwarf-imx6ul_defconfig                         | 2 +-
 configs/pico-dwarf-imx7d_defconfig                          | 2 +-
 configs/pico-hobbit-imx6ul_defconfig                        | 2 +-
 configs/pico-hobbit-imx7d_defconfig                         | 2 +-
 configs/pico-imx6_defconfig                                 | 2 +-
 configs/pico-imx6ul_defconfig                               | 2 +-
 configs/pico-imx7d_bl33_defconfig                           | 2 +-
 configs/pico-imx7d_defconfig                                | 2 +-
 configs/pico-imx8mq_defconfig                               | 2 +-
 configs/pico-nymph-imx7d_defconfig                          | 2 +-
 configs/pico-pi-imx6ul_defconfig                            | 2 +-
 configs/pico-pi-imx7d_defconfig                             | 2 +-
 configs/pinebook-pro-rk3399_defconfig                       | 2 +-
 configs/pinephone-pro-rk3399_defconfig                      | 2 +-
 configs/plutux_defconfig                                    | 2 +-
 configs/pm9g45_defconfig                                    | 2 +-
 configs/pogo_e02_defconfig                                  | 2 +-
 configs/pomelo_defconfig                                    | 2 +-
 configs/poplar_defconfig                                    | 2 +-
 configs/popmetal-rk3288_defconfig                           | 2 +-
 configs/puma-rk3399_defconfig                               | 2 +-
 configs/px30-core-ctouch2-of10-px30_defconfig               | 2 +-
 configs/px30-core-ctouch2-px30_defconfig                    | 2 +-
 configs/px30-core-edimm2.2-px30_defconfig                   | 2 +-
 configs/pxm2_defconfig                                      | 2 +-
 configs/qc750_defconfig                                     | 2 +-
 configs/qemu-ppce500_defconfig                              | 2 +-
 configs/qemu-riscv32_defconfig                              | 2 +-
 configs/qemu-riscv32_smode_defconfig                        | 2 +-
 configs/qemu-riscv32_spl_defconfig                          | 2 +-
 configs/qemu-riscv64_defconfig                              | 2 +-
 configs/qemu-riscv64_smode_defconfig                        | 2 +-
 configs/qemu-riscv64_spl_defconfig                          | 2 +-
 configs/qemu-x86_64_defconfig                               | 2 +-
 configs/qemu-x86_defconfig                                  | 2 +-
 configs/qnap-ts433-rk3568_defconfig                         | 2 +-
 configs/r8a77970_eagle_defconfig                            | 2 +-
 configs/r8a77970_v3msk_defconfig                            | 2 +-
 configs/r8a77980_condor_defconfig                           | 2 +-
 configs/r8a77980_v3hsk_defconfig                            | 2 +-
 configs/r8a77990_ebisu_defconfig                            | 2 +-
 configs/r8a77995_draak_defconfig                            | 2 +-
 configs/radxa-zero-3-rk3566_defconfig                       | 2 +-
 configs/radxa-zero2_defconfig                               | 2 +-
 configs/radxa-zero_defconfig                                | 2 +-
 configs/rcar3_salvator-x_defconfig                          | 2 +-
 configs/rcar3_ulcb_defconfig                                | 2 +-
 configs/renesas_rcar4.config                                | 2 +-
 configs/renesas_rzg2l_smarc_defconfig                       | 2 +-
 configs/ringneck-px30_defconfig                             | 2 +-
 configs/riotboard_defconfig                                 | 2 +-
 configs/roc-cc-rk3308_defconfig                             | 2 +-
 configs/roc-cc-rk3328_defconfig                             | 2 +-
 configs/roc-pc-mezzanine-rk3399_defconfig                   | 2 +-
 configs/roc-pc-rk3399_defconfig                             | 2 +-
 configs/rock-3b-rk3568_defconfig                            | 2 +-
 configs/rock-3c-rk3566_defconfig                            | 2 +-
 configs/rock-4c-plus-rk3399_defconfig                       | 2 +-
 configs/rock-4se-rk3399_defconfig                           | 2 +-
 configs/rock-5-itx-rk3588_defconfig                         | 2 +-
 configs/rock-pi-4-rk3399_defconfig                          | 2 +-
 configs/rock-pi-4c-rk3399_defconfig                         | 2 +-
 configs/rock-pi-e-rk3328_defconfig                          | 2 +-
 configs/rock-pi-e-v3-rk3328_defconfig                       | 2 +-
 configs/rock-pi-n10-rk3399pro_defconfig                     | 2 +-
 configs/rock-pi-n8-rk3288_defconfig                         | 2 +-
 configs/rock-pi-s-rk3308_defconfig                          | 2 +-
 configs/rock-s0-rk3308_defconfig                            | 2 +-
 configs/rock2_defconfig                                     | 2 +-
 configs/rock64-rk3328_defconfig                             | 2 +-
 configs/rock960-rk3399_defconfig                            | 2 +-
 configs/rock_defconfig                                      | 2 +-
 configs/rockpro64-rk3399_defconfig                          | 2 +-
 configs/rpi_0_w_defconfig                                   | 2 +-
 configs/rpi_2_defconfig                                     | 2 +-
 configs/rpi_3_32b_defconfig                                 | 2 +-
 configs/rpi_3_b_plus_defconfig                              | 2 +-
 configs/rpi_3_defconfig                                     | 2 +-
 configs/rpi_4_32b_defconfig                                 | 2 +-
 configs/rpi_4_defconfig                                     | 2 +-
 configs/rpi_defconfig                                       | 2 +-
 configs/rut_defconfig                                       | 2 +-
 configs/s400_defconfig                                      | 2 +-
 configs/s5p_goni_defconfig                                  | 2 +-
 configs/s5pc210_universal_defconfig                         | 2 +-
 configs/sagem_f@st1704_ram_defconfig                        | 2 +-
 configs/sam9x60_curiosity_mmc1_defconfig                    | 2 +-
 configs/sam9x60_curiosity_mmc_defconfig                     | 2 +-
 configs/sam9x60ek_mmc_defconfig                             | 2 +-
 configs/sam9x60ek_nandflash_defconfig                       | 2 +-
 configs/sam9x60ek_qspiflash_defconfig                       | 2 +-
 configs/sama5d27_som1_ek_mmc1_defconfig                     | 2 +-
 configs/sama5d27_som1_ek_mmc_defconfig                      | 2 +-
 configs/sama5d27_som1_ek_qspiflash_defconfig                | 2 +-
 configs/sama5d27_wlsom1_ek_mmc_defconfig                    | 2 +-
 configs/sama5d27_wlsom1_ek_qspiflash_defconfig              | 2 +-
 configs/sama5d29_curiosity_mmc1_defconfig                   | 2 +-
 configs/sama5d29_curiosity_mmc_defconfig                    | 2 +-
 configs/sama5d29_curiosity_qspiflash_defconfig              | 2 +-
 configs/sama5d2_icp_mmc_defconfig                           | 2 +-
 configs/sama5d2_icp_qspiflash_defconfig                     | 2 +-
 configs/sama5d2_ptc_ek_mmc_defconfig                        | 2 +-
 configs/sama5d2_ptc_ek_nandflash_defconfig                  | 2 +-
 configs/sama5d2_xplained_emmc_defconfig                     | 2 +-
 configs/sama5d2_xplained_mmc_defconfig                      | 2 +-
 configs/sama5d2_xplained_qspiflash_defconfig                | 2 +-
 configs/sama5d2_xplained_spiflash_defconfig                 | 2 +-
 configs/sama5d36ek_cmp_mmc_defconfig                        | 2 +-
 configs/sama5d36ek_cmp_nandflash_defconfig                  | 2 +-
 configs/sama5d36ek_cmp_spiflash_defconfig                   | 2 +-
 configs/sama5d3_xplained_mmc_defconfig                      | 2 +-
 configs/sama5d3_xplained_nandflash_defconfig                | 2 +-
 configs/sama5d3xek_mmc_defconfig                            | 2 +-
 configs/sama5d3xek_nandflash_defconfig                      | 2 +-
 configs/sama5d3xek_spiflash_defconfig                       | 2 +-
 configs/sama5d4_xplained_mmc_defconfig                      | 2 +-
 configs/sama5d4_xplained_nandflash_defconfig                | 2 +-
 configs/sama5d4_xplained_spiflash_defconfig                 | 2 +-
 configs/sama5d4ek_mmc_defconfig                             | 2 +-
 configs/sama5d4ek_nandflash_defconfig                       | 2 +-
 configs/sama5d4ek_spiflash_defconfig                        | 2 +-
 configs/sama7g54_curiosity_mmc_defconfig                    | 2 +-
 configs/sama7g54_curiosity_nandflash_defconfig              | 2 +-
 configs/sama7g54_curiosity_qspiflash_defconfig              | 2 +-
 configs/sama7g5ek_mmc1_defconfig                            | 2 +-
 configs/sama7g5ek_mmc_defconfig                             | 2 +-
 configs/seaboard_defconfig                                  | 2 +-
 configs/seeed_npi_imx6ull_defconfig                         | 2 +-
 configs/sei510_defconfig                                    | 2 +-
 configs/sei610_defconfig                                    | 2 +-
 configs/sfr_nb4-ser_ram_defconfig                           | 2 +-
 configs/sheep-rk3368_defconfig                              | 2 +-
 configs/sifive_unleashed_defconfig                          | 2 +-
 configs/sifive_unmatched_defconfig                          | 2 +-
 configs/silinux_ek874_defconfig                             | 2 +-
 configs/slimbootloader_defconfig                            | 2 +-
 configs/smartweb_defconfig                                  | 2 +-
 configs/smdk5250_defconfig                                  | 2 +-
 configs/smdk5420_defconfig                                  | 2 +-
 configs/smdkv310_defconfig                                  | 2 +-
 configs/smegw01_defconfig                                   | 2 +-
 configs/sniper_defconfig                                    | 2 +-
 configs/snow_defconfig                                      | 2 +-
 configs/socfpga_agilex5_defconfig                           | 2 +-
 configs/socfpga_arria10_defconfig                           | 2 +-
 configs/socfpga_arria5_defconfig                            | 2 +-
 configs/socfpga_cyclone5_defconfig                          | 2 +-
 configs/socfpga_dbm_soc1_defconfig                          | 2 +-
 configs/socfpga_de0_nano_soc_defconfig                      | 2 +-
 configs/socfpga_de10_nano_defconfig                         | 2 +-
 configs/socfpga_de10_standard_defconfig                     | 2 +-
 configs/socfpga_de1_soc_defconfig                           | 2 +-
 configs/socfpga_is1_defconfig                               | 2 +-
 configs/socfpga_mcvevk_defconfig                            | 2 +-
 configs/socfpga_sockit_defconfig                            | 2 +-
 configs/socfpga_socrates_defconfig                          | 2 +-
 configs/socfpga_sr1500_defconfig                            | 2 +-
 configs/socfpga_stratix10_atf_defconfig                     | 2 +-
 configs/socfpga_stratix10_defconfig                         | 2 +-
 configs/socfpga_vining_fpga_defconfig                       | 2 +-
 configs/som-db5800-som-6867_defconfig                       | 2 +-
 configs/somlabs_visionsom_6ull_defconfig                    | 2 +-
 configs/sonoff-ihost-rv1126_defconfig                       | 2 +-
 configs/spring_defconfig                                    | 2 +-
 configs/star_defconfig                                      | 2 +-
 configs/starfive_visionfive2_defconfig                      | 2 +-
 configs/stih410-b2260_defconfig                             | 2 +-
 configs/stm32746g-eval_defconfig                            | 2 +-
 configs/stm32746g-eval_spl_defconfig                        | 2 +-
 configs/stm32f429-evaluation_defconfig                      | 2 +-
 configs/stm32f469-discovery_defconfig                       | 2 +-
 configs/stm32f746-disco_defconfig                           | 2 +-
 configs/stm32f746-disco_spl_defconfig                       | 2 +-
 configs/stm32f769-disco_defconfig                           | 2 +-
 configs/stm32f769-disco_spl_defconfig                       | 2 +-
 configs/stm32h743-disco_defconfig                           | 2 +-
 configs/stm32h743-eval_defconfig                            | 2 +-
 configs/stm32h750-art-pi_defconfig                          | 2 +-
 configs/stm32mp13_defconfig                                 | 2 +-
 configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig          | 2 +-
 configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig         | 2 +-
 configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig | 2 +-
 configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig     | 2 +-
 configs/stm32mp15-odyssey_defconfig                         | 2 +-
 configs/stm32mp15_basic_defconfig                           | 2 +-
 configs/stm32mp15_defconfig                                 | 2 +-
 configs/stm32mp15_trusted_defconfig                         | 2 +-
 configs/stm32mp_dhsom.config                                | 2 +-
 configs/stmark2_defconfig                                   | 2 +-
 configs/surface-rt_defconfig                                | 2 +-
 configs/syzygy_hub_defconfig                                | 2 +-
 configs/taurus_defconfig                                    | 2 +-
 configs/tb100_defconfig                                     | 2 +-
 configs/tbs2910_defconfig                                   | 2 +-
 configs/tec-ng_defconfig                                    | 2 +-
 configs/tec_defconfig                                       | 2 +-
 configs/tegratab_defconfig                                  | 2 +-
 configs/tf701t_defconfig                                    | 2 +-
 configs/th1520_lpi4a_defconfig                              | 2 +-
 configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig   | 2 +-
 configs/theadorable-x86-conga-qa3-e3845_defconfig           | 2 +-
 configs/theadorable-x86-dfi-bt700_defconfig                 | 2 +-
 configs/theadorable_debug_defconfig                         | 2 +-
 configs/thunderx_88xx_defconfig                             | 2 +-
 configs/tiger-rk3588_defconfig                              | 2 +-
 configs/tinker-rk3288_defconfig                             | 2 +-
 configs/tinker-s-rk3288_defconfig                           | 2 +-
 configs/tools-only_defconfig                                | 2 +-
 configs/topic_miami_defconfig                               | 2 +-
 configs/topic_miamilite_defconfig                           | 2 +-
 configs/topic_miamiplus_defconfig                           | 2 +-
 configs/toradex-smarc-imx8mp_defconfig                      | 2 +-
 configs/tplink_wdr4300_defconfig                            | 2 +-
 configs/tqma6dl_mba6_mmc_defconfig                          | 2 +-
 configs/tqma6dl_mba6_spi_defconfig                          | 2 +-
 configs/tqma6q_mba6_mmc_defconfig                           | 2 +-
 configs/tqma6q_mba6_spi_defconfig                           | 2 +-
 configs/tqma6s_mba6_mmc_defconfig                           | 2 +-
 configs/tqma6s_mba6_spi_defconfig                           | 2 +-
 configs/transformer_t20_defconfig                           | 2 +-
 configs/transformer_t30_defconfig                           | 2 +-
 configs/trats2_defconfig                                    | 2 +-
 configs/trats_defconfig                                     | 2 +-
 configs/trimslice_defconfig                                 | 2 +-
 configs/turris_1x_nor_defconfig                             | 2 +-
 configs/turris_1x_sdcard_defconfig                          | 2 +-
 configs/turris_mox_defconfig                                | 2 +-
 configs/turris_omnia_defconfig                              | 2 +-
 configs/u200_defconfig                                      | 2 +-
 configs/uDPU_defconfig                                      | 2 +-
 configs/udoo_defconfig                                      | 2 +-
 configs/udoo_neo_defconfig                                  | 2 +-
 configs/uniphier_ld4_sld8_defconfig                         | 2 +-
 configs/uniphier_v7_defconfig                               | 2 +-
 configs/uniphier_v8_defconfig                               | 2 +-
 configs/usb_a9263_dataflash_defconfig                       | 2 +-
 configs/usbarmory_defconfig                                 | 2 +-
 configs/variscite_dart6ul_defconfig                         | 2 +-
 configs/venice2_defconfig                                   | 2 +-
 configs/ventana_defconfig                                   | 2 +-
 configs/verdin-am62_a53_defconfig                           | 2 +-
 configs/verdin-am62_r5_defconfig                            | 2 +-
 configs/verdin-am62p_a53_defconfig                          | 2 +-
 configs/verdin-am62p_r5_defconfig                           | 2 +-
 configs/verdin-imx8mm_defconfig                             | 2 +-
 configs/verdin-imx8mp_defconfig                             | 2 +-
 configs/vf610twr_defconfig                                  | 2 +-
 configs/vf610twr_nand_defconfig                             | 2 +-
 configs/videostrong-kii-pro_defconfig                       | 2 +-
 configs/vinco_defconfig                                     | 2 +-
 configs/vining_2000_defconfig                               | 2 +-
 configs/vocore2_defconfig                                   | 2 +-
 configs/vyasa-rk3288_defconfig                              | 2 +-
 configs/wandboard_defconfig                                 | 2 +-
 configs/warp7_bl33_defconfig                                | 2 +-
 configs/warp7_defconfig                                     | 2 +-
 configs/wetek-core2_defconfig                               | 2 +-
 configs/wetek-hub_defconfig                                 | 2 +-
 configs/wetek-play2_defconfig                               | 2 +-
 configs/x250_defconfig                                      | 2 +-
 configs/x3_t30_defconfig                                    | 2 +-
 configs/xilinx_mbv32_defconfig                              | 2 +-
 configs/xilinx_mbv32_smode_defconfig                        | 2 +-
 configs/xilinx_mbv64_defconfig                              | 2 +-
 configs/xilinx_mbv64_smode_defconfig                        | 2 +-
 configs/xilinx_versal_mini_defconfig                        | 2 +-
 configs/xilinx_versal_mini_emmc0_defconfig                  | 2 +-
 configs/xilinx_versal_mini_emmc1_defconfig                  | 2 +-
 configs/xilinx_versal_net_mini_defconfig                    | 2 +-
 configs/xilinx_versal_net_mini_emmc_defconfig               | 2 +-
 configs/xilinx_versal_net_virt_defconfig                    | 2 +-
 configs/xilinx_versal_virt_defconfig                        | 2 +-
 configs/xilinx_zynq_virt_defconfig                          | 2 +-
 configs/xilinx_zynqmp_kria_defconfig                        | 2 +-
 configs/xilinx_zynqmp_mini_defconfig                        | 2 +-
 configs/xilinx_zynqmp_mini_emmc0_defconfig                  | 2 +-
 configs/xilinx_zynqmp_mini_emmc1_defconfig                  | 2 +-
 configs/xilinx_zynqmp_mini_nand_defconfig                   | 2 +-
 configs/xilinx_zynqmp_mini_nand_single_defconfig            | 2 +-
 configs/xilinx_zynqmp_mini_qspi_defconfig                   | 2 +-
 configs/xilinx_zynqmp_r5_defconfig                          | 2 +-
 configs/xilinx_zynqmp_virt_defconfig                        | 2 +-
 configs/zynq_cse_nand_defconfig                             | 2 +-
 configs/zynq_cse_nor_defconfig                              | 2 +-
 configs/zynq_cse_qspi_defconfig                             | 2 +-
 env/Kconfig                                                 | 2 +-
 868 files changed, 870 insertions(+), 870 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 79f60eb3f34..6194de36074 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1067,7 +1067,7 @@ config ARCH_OWL
 	select CLK
 	select CLK_OWL
 	select OF_CONTROL
-	select SYS_RELOC_GD_ENV_ADDR
+	select ENV_RELOC_GD_ENV_ADDR
 	imply CMD_DM
 
 config ARCH_QEMU
@@ -1206,7 +1206,7 @@ config ARCH_SUNXI
 	select USB_STORAGE if DISTRO_DEFAULTS && USB_HOST
 	select SPL_USE_TINY_PRINTF if SPL
 	select USE_PREBOOT
-	select SYS_RELOC_GD_ENV_ADDR
+	select ENV_RELOC_GD_ENV_ADDR
 	imply BOARD_LATE_INIT
 	imply CMD_DM
 	imply CMD_GPT
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index a50dde60e8b..3e11fadafc6 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -145,7 +145,7 @@ ENTRY(_main)
 	ldr	r1, =CONFIG_TEXT_BASE
 	sub	r1, r0
 	add	lr, r1
-#if defined(CONFIG_SYS_RELOC_GD_ENV_ADDR)
+#if defined(CONFIG_ENV_RELOC_GD_ENV_ADDR)
 	ldr	r0, [r9, #GD_ENV_ADDR]		/* r0 = gd->env_addr */
 	add	r0, r0, r1
 	str	r0, [r9, #GD_ENV_ADDR]
diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index 30950ddaf9b..f3f279f2c39 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -119,7 +119,7 @@ ENTRY(_main)
 	ldr	x9, _TEXT_BASE		/* x9 <- Linked value of _start */
 	sub	x9, x9, x0		/* x9 <- Run-vs-link offset */
 	add	lr, lr, x9
-#if defined(CONFIG_SYS_RELOC_GD_ENV_ADDR)
+#if defined(CONFIG_ENV_RELOC_GD_ENV_ADDR)
 	ldr	x0, [x18, #GD_ENV_ADDR]	/* x0 <- gd->env_addr */
 	add	x0, x0, x9
 	str	x0, [x18, #GD_ENV_ADDR]
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 9210877a4a4..2c5f9770958 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -363,7 +363,7 @@ config ROCKCHIP_RK3528
 	imply SPL_REGMAP
 	imply SPL_SERIAL
 	imply SPL_SYSCON
-	imply SYS_RELOC_GD_ENV_ADDR
+	imply ENV_RELOC_GD_ENV_ADDR
 	imply SYSRESET
 	imply SYSRESET_PSCI if SPL_ATF
 	help
@@ -447,7 +447,7 @@ config ROCKCHIP_RK3576
 	imply SPL_REGMAP
 	imply SPL_SERIAL
 	imply SPL_SYSCON
-	imply SYS_RELOC_GD_ENV_ADDR
+	imply ENV_RELOC_GD_ENV_ADDR
 	imply SYSRESET
 	help
 	  The Rockchip RK3576 is a ARM-based SoC with quad-core Cortex-A72 and
diff --git a/common/board_r.c b/common/board_r.c
index 46b5ded69d8..8ee2a4790bb 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -144,7 +144,7 @@ static int initr_reloc_global_data(void)
 	 */
 	fixup_cpu();
 #endif
-#ifdef CONFIG_SYS_RELOC_GD_ENV_ADDR
+#ifdef CONFIG_ENV_RELOC_GD_ENV_ADDR
 	/*
 	 * Relocate the early env_addr pointer unless we know it is not inside
 	 * the binary. Some systems need this and for the rest, it doesn't hurt.
diff --git a/configs/M5208EVBE_defconfig b/configs/M5208EVBE_defconfig
index d87c4754a30..53c9c236929 100644
--- a/configs/M5208EVBE_defconfig
+++ b/configs/M5208EVBE_defconfig
@@ -24,7 +24,7 @@ CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="M5208EVBe"
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
diff --git a/configs/M5235EVB_Flash32_defconfig b/configs/M5235EVB_Flash32_defconfig
index 8aa806894be..98e5f546dd3 100644
--- a/configs/M5235EVB_Flash32_defconfig
+++ b/configs/M5235EVB_Flash32_defconfig
@@ -31,7 +31,7 @@ CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="u-boot.bin"
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/M5235EVB_defconfig b/configs/M5235EVB_defconfig
index c76d6556dbe..8ffd3237bc5 100644
--- a/configs/M5235EVB_defconfig
+++ b/configs/M5235EVB_defconfig
@@ -30,7 +30,7 @@ CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="u-boot.bin"
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/M5249EVB_defconfig b/configs/M5249EVB_defconfig
index ed1446d81cb..d2626d6b8de 100644
--- a/configs/M5249EVB_defconfig
+++ b/configs/M5249EVB_defconfig
@@ -21,7 +21,7 @@ CONFIG_LOOPW=y
 CONFIG_CMD_MX_CYCLIC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
diff --git a/configs/M5253DEMO_defconfig b/configs/M5253DEMO_defconfig
index 4f5e3183395..e3b1f114e1b 100644
--- a/configs/M5253DEMO_defconfig
+++ b/configs/M5253DEMO_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="M5253DEMO"
 # CONFIG_BLOCK_CACHE is not set
diff --git a/configs/M5272C3_defconfig b/configs/M5272C3_defconfig
index 754b43eabbc..ca82470d61a 100644
--- a/configs/M5272C3_defconfig
+++ b/configs/M5272C3_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="M5272C3"
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
diff --git a/configs/M5275EVB_defconfig b/configs/M5275EVB_defconfig
index d09dbf21428..5baea74d413 100644
--- a/configs/M5275EVB_defconfig
+++ b/configs/M5275EVB_defconfig
@@ -30,7 +30,7 @@ CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
diff --git a/configs/M5282EVB_defconfig b/configs/M5282EVB_defconfig
index 2786c673fb9..399b270add4 100644
--- a/configs/M5282EVB_defconfig
+++ b/configs/M5282EVB_defconfig
@@ -24,7 +24,7 @@ CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="M5282EVB"
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
diff --git a/configs/M5329AFEE_defconfig b/configs/M5329AFEE_defconfig
index db3ae65b8ab..6548528ee11 100644
--- a/configs/M5329AFEE_defconfig
+++ b/configs/M5329AFEE_defconfig
@@ -24,7 +24,7 @@ CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="M5329EVB"
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
diff --git a/configs/M5329BFEE_defconfig b/configs/M5329BFEE_defconfig
index 0cbde6ea8c2..e229bd78dc1 100644
--- a/configs/M5329BFEE_defconfig
+++ b/configs/M5329BFEE_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="M5329EVB"
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
diff --git a/configs/M5373EVB_defconfig b/configs/M5373EVB_defconfig
index ba55e1115b6..980f4a43db5 100644
--- a/configs/M5373EVB_defconfig
+++ b/configs/M5373EVB_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="M5373EVB"
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
diff --git a/configs/MCR3000_defconfig b/configs/MCR3000_defconfig
index 004f7505e7d..62c663be831 100644
--- a/configs/MCR3000_defconfig
+++ b/configs/MCR3000_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_IPADDR=y
 CONFIG_IPADDR="192.168.0.3"
 CONFIG_USE_NETMASK=y
diff --git a/configs/P1010RDB-PA_36BIT_NAND_defconfig b/configs/P1010RDB-PA_36BIT_NAND_defconfig
index 779c7dacb90..0ad65759f38 100644
--- a/configs/P1010RDB-PA_36BIT_NAND_defconfig
+++ b/configs/P1010RDB-PA_36BIT_NAND_defconfig
@@ -78,7 +78,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0xc000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PA_36BIT_SDCARD_defconfig b/configs/P1010RDB-PA_36BIT_SDCARD_defconfig
index d3184c96753..db45b859db9 100644
--- a/configs/P1010RDB-PA_36BIT_SDCARD_defconfig
+++ b/configs/P1010RDB-PA_36BIT_SDCARD_defconfig
@@ -68,7 +68,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff800000.flash:2m(uboot-env),1m(dtb),5m(kernel
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig b/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig
index 09fb2661e88..24190ac40e9 100644
--- a/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig
@@ -70,7 +70,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff800000.flash:2m(uboot-env),1m(dtb),5m(kernel
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PA_NAND_defconfig b/configs/P1010RDB-PA_NAND_defconfig
index 56779fdcdf4..6704d32fba0 100644
--- a/configs/P1010RDB-PA_NAND_defconfig
+++ b/configs/P1010RDB-PA_NAND_defconfig
@@ -77,7 +77,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0xc000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PA_SDCARD_defconfig b/configs/P1010RDB-PA_SDCARD_defconfig
index 86349579f76..505fd7b604c 100644
--- a/configs/P1010RDB-PA_SDCARD_defconfig
+++ b/configs/P1010RDB-PA_SDCARD_defconfig
@@ -67,7 +67,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff800000.flash:2m(uboot-env),1m(dtb),5m(kernel
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PA_SPIFLASH_defconfig b/configs/P1010RDB-PA_SPIFLASH_defconfig
index ae79576c30d..3b7b7bcf472 100644
--- a/configs/P1010RDB-PA_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PA_SPIFLASH_defconfig
@@ -69,7 +69,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff800000.flash:2m(uboot-env),1m(dtb),5m(kernel
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PB_36BIT_NAND_defconfig b/configs/P1010RDB-PB_36BIT_NAND_defconfig
index 93d99322c54..c4793830bb3 100644
--- a/configs/P1010RDB-PB_36BIT_NAND_defconfig
+++ b/configs/P1010RDB-PB_36BIT_NAND_defconfig
@@ -79,7 +79,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PB_36BIT_SDCARD_defconfig b/configs/P1010RDB-PB_36BIT_SDCARD_defconfig
index aefc2d5114e..551ddfaba25 100644
--- a/configs/P1010RDB-PB_36BIT_SDCARD_defconfig
+++ b/configs/P1010RDB-PB_36BIT_SDCARD_defconfig
@@ -69,7 +69,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff800000.flash:2m(uboot-env),1m(dtb),5m(kernel
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig b/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig
index 46cf0be1f62..c13ebee53d9 100644
--- a/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig
@@ -71,7 +71,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff800000.flash:2m(uboot-env),1m(dtb),5m(kernel
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PB_NAND_defconfig b/configs/P1010RDB-PB_NAND_defconfig
index 5979bcef3fe..8fa122e1059 100644
--- a/configs/P1010RDB-PB_NAND_defconfig
+++ b/configs/P1010RDB-PB_NAND_defconfig
@@ -78,7 +78,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PB_SDCARD_defconfig b/configs/P1010RDB-PB_SDCARD_defconfig
index 27ed09418aa..699f9f546e8 100644
--- a/configs/P1010RDB-PB_SDCARD_defconfig
+++ b/configs/P1010RDB-PB_SDCARD_defconfig
@@ -68,7 +68,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff800000.flash:2m(uboot-env),1m(dtb),5m(kernel
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1010RDB-PB_SPIFLASH_defconfig b/configs/P1010RDB-PB_SPIFLASH_defconfig
index dc164c0f436..895662546b1 100644
--- a/configs/P1010RDB-PB_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PB_SPIFLASH_defconfig
@@ -70,7 +70,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ff800000.flash:2m(uboot-env),1m(dtb),5m(kernel
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1020RDB-PC_36BIT_NAND_defconfig b/configs/P1020RDB-PC_36BIT_NAND_defconfig
index 03683f0e1e5..67036016470 100644
--- a/configs/P1020RDB-PC_36BIT_NAND_defconfig
+++ b/configs/P1020RDB-PC_36BIT_NAND_defconfig
@@ -78,7 +78,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0xc000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1020RDB-PC_36BIT_SDCARD_defconfig b/configs/P1020RDB-PC_36BIT_SDCARD_defconfig
index ea809a95670..5599914455e 100644
--- a/configs/P1020RDB-PC_36BIT_SDCARD_defconfig
+++ b/configs/P1020RDB-PC_36BIT_SDCARD_defconfig
@@ -69,7 +69,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig b/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig
index eaa892cbd76..5b64d8b30f9 100644
--- a/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig
+++ b/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig
@@ -71,7 +71,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1020RDB-PC_NAND_defconfig b/configs/P1020RDB-PC_NAND_defconfig
index 3949c4d94d7..df94be4e3df 100644
--- a/configs/P1020RDB-PC_NAND_defconfig
+++ b/configs/P1020RDB-PC_NAND_defconfig
@@ -77,7 +77,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0xc000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1020RDB-PC_SDCARD_defconfig b/configs/P1020RDB-PC_SDCARD_defconfig
index ea7e58f3eb0..a0cf4ba1d46 100644
--- a/configs/P1020RDB-PC_SDCARD_defconfig
+++ b/configs/P1020RDB-PC_SDCARD_defconfig
@@ -68,7 +68,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1020RDB-PC_SPIFLASH_defconfig b/configs/P1020RDB-PC_SPIFLASH_defconfig
index 6d7d9734604..390c5614047 100644
--- a/configs/P1020RDB-PC_SPIFLASH_defconfig
+++ b/configs/P1020RDB-PC_SPIFLASH_defconfig
@@ -70,7 +70,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1020RDB-PD_NAND_defconfig b/configs/P1020RDB-PD_NAND_defconfig
index 3361d0db63c..3c8bced6eec 100644
--- a/configs/P1020RDB-PD_NAND_defconfig
+++ b/configs/P1020RDB-PD_NAND_defconfig
@@ -80,7 +80,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x60000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1020RDB-PD_SDCARD_defconfig b/configs/P1020RDB-PD_SDCARD_defconfig
index 4c71c73d2f0..7c6b6c57338 100644
--- a/configs/P1020RDB-PD_SDCARD_defconfig
+++ b/configs/P1020RDB-PD_SDCARD_defconfig
@@ -71,7 +71,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ec000000.nor:128k(dtb),6016k(kernel),57088k(fs
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P1020RDB-PD_SPIFLASH_defconfig b/configs/P1020RDB-PD_SPIFLASH_defconfig
index 85a5c917594..ad5babc4342 100644
--- a/configs/P1020RDB-PD_SPIFLASH_defconfig
+++ b/configs/P1020RDB-PD_SPIFLASH_defconfig
@@ -73,7 +73,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ec000000.nor:128k(dtb),6016k(kernel),57088k(fs
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P2020RDB-PC_36BIT_NAND_defconfig b/configs/P2020RDB-PC_36BIT_NAND_defconfig
index 8dfe52ccff5..68feffd62f5 100644
--- a/configs/P2020RDB-PC_36BIT_NAND_defconfig
+++ b/configs/P2020RDB-PC_36BIT_NAND_defconfig
@@ -82,7 +82,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0xc000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P2020RDB-PC_36BIT_SDCARD_defconfig b/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
index d283e16eb0a..e81325262b8 100644
--- a/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
+++ b/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
@@ -73,7 +73,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=fef000000.nor:256k(vsc7385-firmware),256k(dtb)
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig b/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
index 2ef218cb040..53f33faf971 100644
--- a/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
+++ b/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
@@ -75,7 +75,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=fef000000.nor:256k(vsc7385-firmware),256k(dtb)
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P2020RDB-PC_NAND_defconfig b/configs/P2020RDB-PC_NAND_defconfig
index 0f79bfee5e6..f4bdfb7b1bd 100644
--- a/configs/P2020RDB-PC_NAND_defconfig
+++ b/configs/P2020RDB-PC_NAND_defconfig
@@ -81,7 +81,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0xc000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P2020RDB-PC_SDCARD_defconfig b/configs/P2020RDB-PC_SDCARD_defconfig
index d19646dbd27..4d5df6579e2 100644
--- a/configs/P2020RDB-PC_SDCARD_defconfig
+++ b/configs/P2020RDB-PC_SDCARD_defconfig
@@ -72,7 +72,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ef000000.nor:256k(vsc7385-firmware),256k(dtb),
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P2020RDB-PC_SPIFLASH_defconfig b/configs/P2020RDB-PC_SPIFLASH_defconfig
index 1c5522b3421..4b16b53449a 100644
--- a/configs/P2020RDB-PC_SPIFLASH_defconfig
+++ b/configs/P2020RDB-PC_SPIFLASH_defconfig
@@ -74,7 +74,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=ef000000.nor:256k(vsc7385-firmware),256k(dtb),
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P2041RDB_NAND_defconfig b/configs/P2041RDB_NAND_defconfig
index 4f4d2d75cab..71b02050c56 100644
--- a/configs/P2041RDB_NAND_defconfig
+++ b/configs/P2041RDB_NAND_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P2041RDB_SDCARD_defconfig b/configs/P2041RDB_SDCARD_defconfig
index 3106ee8b7ce..6b8e8d9de4c 100644
--- a/configs/P2041RDB_SDCARD_defconfig
+++ b/configs/P2041RDB_SDCARD_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/P2041RDB_SPIFLASH_defconfig b/configs/P2041RDB_SPIFLASH_defconfig
index 2ef35896c7d..3f12aca2dc4 100644
--- a/configs/P2041RDB_SPIFLASH_defconfig
+++ b/configs/P2041RDB_SPIFLASH_defconfig
@@ -58,7 +58,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/SBx81LIFKW_defconfig b/configs/SBx81LIFKW_defconfig
index 0a22a41d884..e7bbdce887a 100644
--- a/configs/SBx81LIFKW_defconfig
+++ b/configs/SBx81LIFKW_defconfig
@@ -39,7 +39,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=20000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DM_PCA953X=y
diff --git a/configs/SBx81LIFXCAT_defconfig b/configs/SBx81LIFXCAT_defconfig
index 523993a456f..59ec9f3b968 100644
--- a/configs/SBx81LIFXCAT_defconfig
+++ b/configs/SBx81LIFXCAT_defconfig
@@ -40,7 +40,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=20000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
diff --git a/configs/T2080QDS_SECURE_BOOT_defconfig b/configs/T2080QDS_SECURE_BOOT_defconfig
index a05d7008e4f..631789b0585 100644
--- a/configs/T2080QDS_SECURE_BOOT_defconfig
+++ b/configs/T2080QDS_SECURE_BOOT_defconfig
@@ -59,7 +59,7 @@ CONFIG_MTDIDS_DEFAULT="nor0=fe8000000.nor,nand0=fff800000.flash,spi0=spife110000
 CONFIG_MTDPARTS_DEFAULT="mtdparts=fe8000000.nor:1m(uboot),5m(kernel),128k(dtb),96m(fs),-(user);fff800000.flash:1m(uboot),5m(kernel),128k(dtb),96m(fs),-(user);spife110000.0:1m(uboot),5m(kernel),128k(dtb),-(user)"
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
index 395a27eb30e..467d61d73df 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -29,7 +29,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index a53795f5900..75eb0618454 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index 6d0130949b7..932739e5dec 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -29,7 +29,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index b1997264797..5ec2cba670b 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defconfig
index bb09354f716..5c43503ff32 100644
--- a/configs/am335x_baltos_defconfig
+++ b/configs/am335x_baltos_defconfig
@@ -48,7 +48,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:128k(SPL),128k(SPL.backup1),128k(
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 674ad6c06ee..208bbb163f4 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -54,7 +54,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),1
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index d53d1b6e906..5fd3e96abb1 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -45,7 +45,7 @@ CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bone
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index 7bfc39ed653..4f8fd5b740c 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -67,7 +67,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index 55f1519f0e0..b224f8635a4 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -41,7 +41,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),1
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index 1bf7b5f8a12..fd8aa3dbfa8 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -43,7 +43,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),1
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index 580b8fbb291..c36658a1cfe 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -69,7 +69,7 @@ CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="config"
 CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am335x_pdu001_defconfig b/configs/am335x_pdu001_defconfig
index 09753fdbd06..07367fc66b4 100644
--- a/configs/am335x_pdu001_defconfig
+++ b/configs/am335x_pdu001_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/am335x_shc_defconfig b/configs/am335x_shc_defconfig
index 32790e852bc..94fe4d7df8d 100644
--- a/configs/am335x_shc_defconfig
+++ b/configs/am335x_shc_defconfig
@@ -59,7 +59,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am335x_shc_ict_defconfig b/configs/am335x_shc_ict_defconfig
index 82532c9e20b..02dd6a96623 100644
--- a/configs/am335x_shc_ict_defconfig
+++ b/configs/am335x_shc_ict_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am335x_shc_netboot_defconfig b/configs/am335x_shc_netboot_defconfig
index dc8582b9b18..1fb1518b4c3 100644
--- a/configs/am335x_shc_netboot_defconfig
+++ b/configs/am335x_shc_netboot_defconfig
@@ -61,7 +61,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am335x_shc_sdboot_defconfig b/configs/am335x_shc_sdboot_defconfig
index 88b1a9fefb2..05a371e92ad 100644
--- a/configs/am335x_shc_sdboot_defconfig
+++ b/configs/am335x_shc_sdboot_defconfig
@@ -60,7 +60,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 1e0e1fd66cc..906f02ee576 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -56,7 +56,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index 0fc4c0f269a..6d41a94738e 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -45,7 +45,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),2
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index d735af9674b..7da9241aaa5 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -36,7 +36,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index 0fe5479757b..cb3a588321e 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -42,7 +42,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),2
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index 8dab015991e..3ae06f25c3c 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -51,7 +51,7 @@ CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index 419bcb7aed3..6c4d6eeb57b 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -41,7 +41,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),2
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index dd346d23946..cc444ac2817 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -37,7 +37,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 8eb25f090a0..911715e6141 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -58,7 +58,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc am5729-beagleboneai am572x-idk am571x-idk am574x-idk"
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 2b10fb50698..8d94b3ebf3d 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -51,7 +51,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc am5729-beagleboneai am572x-idk am571x-idk am574x-idk"
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 579e8d58734..e38929e940c 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -55,7 +55,7 @@ CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 4ea551b509b..52df6e0ca3f 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -59,7 +59,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index f2e1f31ef0f..21a381e8113 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -64,7 +64,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index 7ca5f58ea0c..a184989ea50 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -62,7 +62,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 4e3ed7801e6..162be534ce4 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index b222bcd6e43..6f9ec2c21e8 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -81,7 +81,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_OF_LIST="k3-am642-r5-evm k3-am642-r5-sk"
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index 4ee406b8347..fdee4d0bf07 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -73,7 +73,7 @@ CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 386749ebabd..f783b6882dc 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -74,7 +74,7 @@ CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index 90a857b8b95..5722e9efd17 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -60,7 +60,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/am67a_beagley_ai_r5_defconfig b/configs/am67a_beagley_ai_r5_defconfig
index ebd4e50e34e..b0a95da1086 100644
--- a/configs/am67a_beagley_ai_r5_defconfig
+++ b/configs/am67a_beagley_ai_r5_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index d224583f56a..e1c5d9b7fb9 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -60,7 +60,7 @@ CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index 3afc6cb2736..42bab43a72b 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_HS200_SUPPORT=y
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 54328e85784..c2934625f2e 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -54,7 +54,7 @@ CONFIG_SYS_PROMPT="versal2> "
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index 48fb7ae0e7f..1c61ae821a9 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -54,7 +54,7 @@ CONFIG_SYS_PROMPT="versal2> "
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 88e8fbd1566..ac9877fe5df 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -67,7 +67,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SIMPLE_PM_BUS=y
diff --git a/configs/aml-a311d-cc_defconfig b/configs/aml-a311d-cc_defconfig
index 6d0d5eb403b..55b77e2a0be 100644
--- a/configs/aml-a311d-cc_defconfig
+++ b/configs/aml-a311d-cc_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/aml-s905d3-cc_defconfig b/configs/aml-s905d3-cc_defconfig
index 1975c67752b..c73f4981d85 100644
--- a/configs/aml-s905d3-cc_defconfig
+++ b/configs/aml-s905d3-cc_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index cfe388213ef..0ccab4f066f 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_LOG=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
diff --git a/configs/ap121_defconfig b/configs/ap121_defconfig
index 353aa0abb1f..0fa4eca481b 100644
--- a/configs/ap121_defconfig
+++ b/configs/ap121_defconfig
@@ -45,7 +45,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:256k(u-boot),64k(u-boot-env),6144k
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=25000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
diff --git a/configs/ap143_defconfig b/configs/ap143_defconfig
index 9083bf293f5..87914b538cc 100644
--- a/configs/ap143_defconfig
+++ b/configs/ap143_defconfig
@@ -45,7 +45,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:256k(u-boot),64k(u-boot-env),6336k
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=25000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
diff --git a/configs/ap152_defconfig b/configs/ap152_defconfig
index 0864bf46d54..aacde07b6e4 100644
--- a/configs/ap152_defconfig
+++ b/configs/ap152_defconfig
@@ -45,7 +45,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:256k(u-boot),64k(u-boot-env),6336k
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=25000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index 15b5153ce4c..3872e8cd9b0 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_UUID=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
index 73463473dfb..539060c5282 100644
--- a/configs/apalis-tk1_defconfig
+++ b/configs/apalis-tk1_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index f51386d10a8..fd08432e57a 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -69,7 +69,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/apalis_t30_defconfig b/configs/apalis_t30_defconfig
index 411d6354f8b..9937344cb6f 100644
--- a/configs/apalis_t30_defconfig
+++ b/configs/apalis_t30_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/aristainetos2c_defconfig b/configs/aristainetos2c_defconfig
index 09cab1b3513..b479e44667e 100644
--- a/configs/aristainetos2c_defconfig
+++ b/configs/aristainetos2c_defconfig
@@ -61,7 +61,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_EARLY=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/aristainetos2ccslb_defconfig b/configs/aristainetos2ccslb_defconfig
index 61fa5011385..b0fff63371f 100644
--- a/configs/aristainetos2ccslb_defconfig
+++ b/configs/aristainetos2ccslb_defconfig
@@ -61,7 +61,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_EARLY=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/arndale_defconfig b/configs/arndale_defconfig
index d2564aa288c..1b08b81eb69 100644
--- a/configs/arndale_defconfig
+++ b/configs/arndale_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_SOUND=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_I2C_S3C24X0=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
diff --git a/configs/at91sam9260ek_dataflash_cs0_defconfig b/configs/at91sam9260ek_dataflash_cs0_defconfig
index 9b077097c69..56250bf84ec 100644
--- a/configs/at91sam9260ek_dataflash_cs0_defconfig
+++ b/configs/at91sam9260ek_dataflash_cs0_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9260ek_dataflash_cs1_defconfig b/configs/at91sam9260ek_dataflash_cs1_defconfig
index dafbc768fde..8befb11930a 100644
--- a/configs/at91sam9260ek_dataflash_cs1_defconfig
+++ b/configs/at91sam9260ek_dataflash_cs1_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9260ek_nandflash_defconfig b/configs/at91sam9260ek_nandflash_defconfig
index bb5930cfbcd..02890de8259 100644
--- a/configs/at91sam9260ek_nandflash_defconfig
+++ b/configs/at91sam9260ek_nandflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9261ek_dataflash_cs0_defconfig b/configs/at91sam9261ek_dataflash_cs0_defconfig
index 09095e9499c..bfb2ee28951 100644
--- a/configs/at91sam9261ek_dataflash_cs0_defconfig
+++ b/configs/at91sam9261ek_dataflash_cs0_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9261ek_dataflash_cs3_defconfig b/configs/at91sam9261ek_dataflash_cs3_defconfig
index d594d96cfd9..16c3b0cb019 100644
--- a/configs/at91sam9261ek_dataflash_cs3_defconfig
+++ b/configs/at91sam9261ek_dataflash_cs3_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9261ek_nandflash_defconfig b/configs/at91sam9261ek_nandflash_defconfig
index 07d7a792da5..1f62bbf7a81 100644
--- a/configs/at91sam9261ek_nandflash_defconfig
+++ b/configs/at91sam9261ek_nandflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9263ek_dataflash_cs0_defconfig b/configs/at91sam9263ek_dataflash_cs0_defconfig
index 9bfda68255e..9b083ec36b7 100644
--- a/configs/at91sam9263ek_dataflash_cs0_defconfig
+++ b/configs/at91sam9263ek_dataflash_cs0_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9263ek_dataflash_defconfig b/configs/at91sam9263ek_dataflash_defconfig
index 9bfda68255e..9b083ec36b7 100644
--- a/configs/at91sam9263ek_dataflash_defconfig
+++ b/configs/at91sam9263ek_dataflash_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9263ek_nandflash_defconfig b/configs/at91sam9263ek_nandflash_defconfig
index 284bf22c95e..e860376aa70 100644
--- a/configs/at91sam9263ek_nandflash_defconfig
+++ b/configs/at91sam9263ek_nandflash_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9g10ek_dataflash_cs0_defconfig b/configs/at91sam9g10ek_dataflash_cs0_defconfig
index 211b20bd0ab..759eea6ee6c 100644
--- a/configs/at91sam9g10ek_dataflash_cs0_defconfig
+++ b/configs/at91sam9g10ek_dataflash_cs0_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9g10ek_dataflash_cs3_defconfig b/configs/at91sam9g10ek_dataflash_cs3_defconfig
index f6529b1be32..31ef371dbb9 100644
--- a/configs/at91sam9g10ek_dataflash_cs3_defconfig
+++ b/configs/at91sam9g10ek_dataflash_cs3_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9g10ek_nandflash_defconfig b/configs/at91sam9g10ek_nandflash_defconfig
index 3b53a17b693..2e5e38a62b3 100644
--- a/configs/at91sam9g10ek_nandflash_defconfig
+++ b/configs/at91sam9g10ek_nandflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9g20ek_2mmc_defconfig b/configs/at91sam9g20ek_2mmc_defconfig
index 273e93c5185..a7d5f76987a 100644
--- a/configs/at91sam9g20ek_2mmc_defconfig
+++ b/configs/at91sam9g20ek_2mmc_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9g20ek_2mmc_nandflash_defconfig b/configs/at91sam9g20ek_2mmc_nandflash_defconfig
index 58a75830bb0..719f0b47766 100644
--- a/configs/at91sam9g20ek_2mmc_nandflash_defconfig
+++ b/configs/at91sam9g20ek_2mmc_nandflash_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9g20ek_dataflash_cs0_defconfig b/configs/at91sam9g20ek_dataflash_cs0_defconfig
index 752031697ce..2095ebce100 100644
--- a/configs/at91sam9g20ek_dataflash_cs0_defconfig
+++ b/configs/at91sam9g20ek_dataflash_cs0_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9g20ek_dataflash_cs1_defconfig b/configs/at91sam9g20ek_dataflash_cs1_defconfig
index adf3c104f3e..3a51cd39d3f 100644
--- a/configs/at91sam9g20ek_dataflash_cs1_defconfig
+++ b/configs/at91sam9g20ek_dataflash_cs1_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9g20ek_nandflash_defconfig b/configs/at91sam9g20ek_nandflash_defconfig
index 15378f5e128..92972325a75 100644
--- a/configs/at91sam9g20ek_nandflash_defconfig
+++ b/configs/at91sam9g20ek_nandflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9m10g45ek_mmc_defconfig b/configs/at91sam9m10g45ek_mmc_defconfig
index 796181b0470..4d3cd7fdb40 100644
--- a/configs/at91sam9m10g45ek_mmc_defconfig
+++ b/configs/at91sam9m10g45ek_mmc_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9m10g45ek_nandflash_defconfig b/configs/at91sam9m10g45ek_nandflash_defconfig
index 62f2a46425b..c4fc3d6f882 100644
--- a/configs/at91sam9m10g45ek_nandflash_defconfig
+++ b/configs/at91sam9m10g45ek_nandflash_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9n12ek_mmc_defconfig b/configs/at91sam9n12ek_mmc_defconfig
index c50842a61d4..07dc2e0d316 100644
--- a/configs/at91sam9n12ek_mmc_defconfig
+++ b/configs/at91sam9n12ek_mmc_defconfig
@@ -40,7 +40,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=atmel_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=atmel_nand:256k(bootstrap)ro,512k(uboot)ro,256k(env),256k(env_redundant),256k(spare),512k(dtb),6M(kernel)ro,-(rootfs)"
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9n12ek_nandflash_defconfig b/configs/at91sam9n12ek_nandflash_defconfig
index 30470b5f450..d266e71aa46 100644
--- a/configs/at91sam9n12ek_nandflash_defconfig
+++ b/configs/at91sam9n12ek_nandflash_defconfig
@@ -41,7 +41,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=atmel_nand:256k(bootstrap)ro,512k(uboot)ro,256
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9n12ek_spiflash_defconfig b/configs/at91sam9n12ek_spiflash_defconfig
index cb4f0b548fe..354e5faf666 100644
--- a/configs/at91sam9n12ek_spiflash_defconfig
+++ b/configs/at91sam9n12ek_spiflash_defconfig
@@ -42,7 +42,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=atmel_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=atmel_nand:256k(bootstrap)ro,512k(uboot)ro,256k(env),256k(env_redundant),256k(spare),512k(dtb),6M(kernel)ro,-(rootfs)"
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9rlek_dataflash_defconfig b/configs/at91sam9rlek_dataflash_defconfig
index 9ebe2de1f2c..189cf430e80 100644
--- a/configs/at91sam9rlek_dataflash_defconfig
+++ b/configs/at91sam9rlek_dataflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9rlek_mmc_defconfig b/configs/at91sam9rlek_mmc_defconfig
index 0fef493164e..2a18067c54f 100644
--- a/configs/at91sam9rlek_mmc_defconfig
+++ b/configs/at91sam9rlek_mmc_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_NAND=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9rlek_nandflash_defconfig b/configs/at91sam9rlek_nandflash_defconfig
index 7e31d11d0f2..967331fe147 100644
--- a/configs/at91sam9rlek_nandflash_defconfig
+++ b/configs/at91sam9rlek_nandflash_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/at91sam9x5ek_dataflash_defconfig b/configs/at91sam9x5ek_dataflash_defconfig
index c40319e9f82..0a817d8eea9 100644
--- a/configs/at91sam9x5ek_dataflash_defconfig
+++ b/configs/at91sam9x5ek_dataflash_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9x5ek_mmc_defconfig b/configs/at91sam9x5ek_mmc_defconfig
index 8db86c777ef..6959d149bd4 100644
--- a/configs/at91sam9x5ek_mmc_defconfig
+++ b/configs/at91sam9x5ek_mmc_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9x5ek_nandflash_defconfig b/configs/at91sam9x5ek_nandflash_defconfig
index c6fa5a01359..ac6feb2857c 100644
--- a/configs/at91sam9x5ek_nandflash_defconfig
+++ b/configs/at91sam9x5ek_nandflash_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9x5ek_spiflash_defconfig b/configs/at91sam9x5ek_spiflash_defconfig
index 12336d0b168..4f2f6fd8538 100644
--- a/configs/at91sam9x5ek_spiflash_defconfig
+++ b/configs/at91sam9x5ek_spiflash_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9xeek_dataflash_cs0_defconfig b/configs/at91sam9xeek_dataflash_cs0_defconfig
index 9b077097c69..56250bf84ec 100644
--- a/configs/at91sam9xeek_dataflash_cs0_defconfig
+++ b/configs/at91sam9xeek_dataflash_cs0_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9xeek_dataflash_cs1_defconfig b/configs/at91sam9xeek_dataflash_cs1_defconfig
index dafbc768fde..8befb11930a 100644
--- a/configs/at91sam9xeek_dataflash_cs1_defconfig
+++ b/configs/at91sam9xeek_dataflash_cs1_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9xeek_nandflash_defconfig b/configs/at91sam9xeek_nandflash_defconfig
index bb5930cfbcd..02890de8259 100644
--- a/configs/at91sam9xeek_nandflash_defconfig
+++ b/configs/at91sam9xeek_nandflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/axm_defconfig b/configs/axm_defconfig
index bc54795395e..2090822023c 100644
--- a/configs/axm_defconfig
+++ b/configs/axm_defconfig
@@ -76,7 +76,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/axs101_defconfig b/configs/axs101_defconfig
index 8ab5addf90e..a863ea8720f 100644
--- a/configs/axs101_defconfig
+++ b/configs/axs101_defconfig
@@ -36,7 +36,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/axs103_defconfig b/configs/axs103_defconfig
index c852bd9eed7..5fcca08058c 100644
--- a/configs/axs103_defconfig
+++ b/configs/axs103_defconfig
@@ -36,7 +36,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/bananapi-cm4-cm4io_defconfig b/configs/bananapi-cm4-cm4io_defconfig
index 51ef5368b56..cb17acadd43 100644
--- a/configs/bananapi-cm4-cm4io_defconfig
+++ b/configs/bananapi-cm4-cm4io_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
index 1ce163b9cbe..0d05edd817b 100644
--- a/configs/bananapi-m2-pro_defconfig
+++ b/configs/bananapi-m2-pro_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
index d6440e33bf5..8088d63baa5 100644
--- a/configs/bananapi-m2s_defconfig
+++ b/configs/bananapi-m2s_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index a471f081607..8d24d5f4567 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
diff --git a/configs/bayleybay_defconfig b/configs/bayleybay_defconfig
index c32d535e87b..154ad12a4e2 100644
--- a/configs/bayleybay_defconfig
+++ b/configs/bayleybay_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/bcm7260_defconfig b/configs/bcm7260_defconfig
index 83008602004..040ef695fec 100644
--- a/configs/bcm7260_defconfig
+++ b/configs/bcm7260_defconfig
@@ -35,7 +35,7 @@ CONFIG_DOS_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_BCMSTB=y
diff --git a/configs/bcm7445_defconfig b/configs/bcm7445_defconfig
index 7f940e58339..1eafadf2535 100644
--- a/configs/bcm7445_defconfig
+++ b/configs/bcm7445_defconfig
@@ -37,7 +37,7 @@ CONFIG_DOS_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_BCMSTB=y
diff --git a/configs/bcm968380gerg_ram_defconfig b/configs/bcm968380gerg_ram_defconfig
index 053c459e05c..2951f98b6b4 100644
--- a/configs/bcm968380gerg_ram_defconfig
+++ b/configs/bcm968380gerg_ram_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_NAND=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_BCM6345_GPIO=y
diff --git a/configs/beaver_defconfig b/configs/beaver_defconfig
index 8e0c5367352..56f0362e201 100644
--- a/configs/beaver_defconfig
+++ b/configs/beaver_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index a25f42f7b6c..d811ab987f3 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/beelink-gt1-ultimate_defconfig b/configs/beelink-gt1-ultimate_defconfig
index 489818096c7..3bf832ac8b2 100644
--- a/configs/beelink-gt1-ultimate_defconfig
+++ b/configs/beelink-gt1-ultimate_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index b5229ee0377..6ef1d311bd9 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index fe8e9a8cc0d..cb31d04bf87 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/bitmain_antminer_s9_defconfig b/configs/bitmain_antminer_s9_defconfig
index 77744d55c3b..30c3fd0f9fb 100644
--- a/configs/bitmain_antminer_s9_defconfig
+++ b/configs/bitmain_antminer_s9_defconfig
@@ -74,7 +74,7 @@ CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_BOOTP_SERVERIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
index 511c86313c3..a4174d9219b 100644
--- a/configs/bk4r1_defconfig
+++ b/configs/bk4r1_defconfig
@@ -55,7 +55,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=500
 CONFIG_NETCONSOLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index 743c3255e46..2f336d3b64f 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -80,7 +80,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/brppt2_defconfig b/configs/brppt2_defconfig
index d468465a9cc..04defac9a71 100644
--- a/configs/brppt2_defconfig
+++ b/configs/brppt2_defconfig
@@ -64,7 +64,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt-parent interrupts dmas dma-names"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_ARP_TIMEOUT=1500
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/brsmarc1_defconfig b/configs/brsmarc1_defconfig
index a31049d1f6b..ebc885464a7 100644
--- a/configs/brsmarc1_defconfig
+++ b/configs/brsmarc1_defconfig
@@ -84,7 +84,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index 030ce1a3158..9bbe6bf447c 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -74,7 +74,7 @@ CONFIG_OF_SPL_REMOVE_PROPS=""
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/cardhu_defconfig b/configs/cardhu_defconfig
index 4d1bb6e1cc1..ad220c19788 100644
--- a/configs/cardhu_defconfig
+++ b/configs/cardhu_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/cei-tk1-som_defconfig b/configs/cei-tk1-som_defconfig
index 311dd70bc44..f9965bba23e 100644
--- a/configs/cei-tk1-som_defconfig
+++ b/configs/cei-tk1-som_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/cherryhill_defconfig b/configs/cherryhill_defconfig
index d247505ce4c..6349667a18e 100644
--- a/configs/cherryhill_defconfig
+++ b/configs/cherryhill_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconfig
index 3b4b04c9c88..1677b671c6b 100644
--- a/configs/chiliboard_defconfig
+++ b/configs/chiliboard_defconfig
@@ -47,7 +47,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index 0f803d9a408..02f7876f2dc 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -58,7 +58,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 3f11b110c92..cbb8beb91c2 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_LOG=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SYS_I2C_ROCKCHIP=y
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index a955265f9ce..928a713cd1f 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -58,7 +58,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index aa2ef298762..a9dbe33e3d6 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_LOG=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SYS_I2C_ROCKCHIP=y
diff --git a/configs/chromebook_link64_defconfig b/configs/chromebook_link64_defconfig
index 0fc1279f873..16d14e14621 100644
--- a/configs/chromebook_link64_defconfig
+++ b/configs/chromebook_link64_defconfig
@@ -60,7 +60,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
index a2231cc314f..b5b3851a010 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 45876f6e81d..7a875d42c3f 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -59,7 +59,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/chromebook_samus_defconfig b/configs/chromebook_samus_defconfig
index 6e9aa601009..ed1c62330c9 100644
--- a/configs/chromebook_samus_defconfig
+++ b/configs/chromebook_samus_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index 42337d7a11e..5e452cf7b79 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -72,7 +72,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_NO_NET=y
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index c848ebd7f34..d890a344f52 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -59,7 +59,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/chromebox_panther_defconfig b/configs/chromebox_panther_defconfig
index a1561fd0d25..3bcf92ed1fa 100644
--- a/configs/chromebox_panther_defconfig
+++ b/configs/chromebox_panther_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/ci20_mmc_defconfig b/configs/ci20_mmc_defconfig
index 2b3086b8673..025c37afcff 100644
--- a/configs/ci20_mmc_defconfig
+++ b/configs/ci20_mmc_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_FAT=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_JZ4780_EFUSE=y
diff --git a/configs/cl-som-imx7_defconfig b/configs/cl-som-imx7_defconfig
index 21db8c4d045..0676b949a27 100644
--- a/configs/cl-som-imx7_defconfig
+++ b/configs/cl-som-imx7_defconfig
@@ -69,7 +69,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_MMC is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_SPL_DM=y
diff --git a/configs/clearfog_gt_8k_defconfig b/configs/clearfog_gt_8k_defconfig
index eaa8a333049..ead29d99338 100644
--- a/configs/clearfog_gt_8k_defconfig
+++ b/configs/clearfog_gt_8k_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/cm3588-nas-rk3588_defconfig b/configs/cm3588-nas-rk3588_defconfig
index e09451b2490..092612719cc 100644
--- a/configs/cm3588-nas-rk3588_defconfig
+++ b/configs/cm3588-nas-rk3588_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/cm_fx6_defconfig b/configs/cm_fx6_defconfig
index 0e916771d9f..4eb86fee70b 100644
--- a/configs/cm_fx6_defconfig
+++ b/configs/cm_fx6_defconfig
@@ -65,7 +65,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC0"
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index a7940c2774c..471d6bd3f49 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -65,7 +65,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/cobra5272_defconfig b/configs/cobra5272_defconfig
index d7ce71925e9..ca2eada6291 100644
--- a/configs/cobra5272_defconfig
+++ b/configs/cobra5272_defconfig
@@ -22,7 +22,7 @@ CONFIG_CMD_IMLS=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_PING=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_USE_IPADDR=y
 CONFIG_IPADDR="192.168.100.2"
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index ba65a3c40a6..20469aa1973 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index 785e8a65f21..26e9b565bd5 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index 7dc4a3d042a..cf027bc1c75 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_UUID=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 9fc844b3269..7ce17b0bad9 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -68,7 +68,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 7885d0e7da2..6c24f59b28c 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -59,7 +59,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_IP_DEFRAG=y
 CONFIG_USE_IPADDR=y
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index ab6a156e893..fa53b29eaac 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_IP_DEFRAG=y
diff --git a/configs/colibri_t20_defconfig b/configs/colibri_t20_defconfig
index feb24d843b3..5ff472be67b 100644
--- a/configs/colibri_t20_defconfig
+++ b/configs/colibri_t20_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/colibri_t30_defconfig b/configs/colibri_t30_defconfig
index 3a8ea1c1a76..23ce3d9bbfd 100644
--- a/configs/colibri_t30_defconfig
+++ b/configs/colibri_t30_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 3a806243b19..9a8fc7a4007 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -63,7 +63,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_USE_IPADDR=y
diff --git a/configs/comtrend_ar5315u_ram_defconfig b/configs/comtrend_ar5315u_ram_defconfig
index d83e24ebf91..203d4ef2300 100644
--- a/configs/comtrend_ar5315u_ram_defconfig
+++ b/configs/comtrend_ar5315u_ram_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=6
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/comtrend_ar5387un_ram_defconfig b/configs/comtrend_ar5387un_ram_defconfig
index 6a49c0a6a23..22df1e9c171 100644
--- a/configs/comtrend_ar5387un_ram_defconfig
+++ b/configs/comtrend_ar5387un_ram_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=6
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/comtrend_ct5361_ram_defconfig b/configs/comtrend_ct5361_ram_defconfig
index 49b353542b5..a932dc69d1a 100644
--- a/configs/comtrend_ct5361_ram_defconfig
+++ b/configs/comtrend_ct5361_ram_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=6
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/comtrend_vr3032u_ram_defconfig b/configs/comtrend_vr3032u_ram_defconfig
index 6592b11dc48..dca76d9a0ab 100644
--- a/configs/comtrend_vr3032u_ram_defconfig
+++ b/configs/comtrend_vr3032u_ram_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=6
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/comtrend_wap5813n_ram_defconfig b/configs/comtrend_wap5813n_ram_defconfig
index 60f8f3f707e..31e928c57b9 100644
--- a/configs/comtrend_wap5813n_ram_defconfig
+++ b/configs/comtrend_wap5813n_ram_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=6
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig b/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
index bb3d7213540..a4a2949e8e0 100644
--- a/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
+++ b/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/conga-qeval20-qa3-e3845_defconfig b/configs/conga-qeval20-qa3-e3845_defconfig
index c5fb5a9bbe1..d7a6be405f4 100644
--- a/configs/conga-qeval20-qa3-e3845_defconfig
+++ b/configs/conga-qeval20-qa3-e3845_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/controlcenterdc_defconfig b/configs/controlcenterdc_defconfig
index 0e1b22c49d9..2533bb8b50c 100644
--- a/configs/controlcenterdc_defconfig
+++ b/configs/controlcenterdc_defconfig
@@ -67,7 +67,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="ccdc.img"
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/coreboot64-no-spl_defconfig b/configs/coreboot64-no-spl_defconfig
index fe11e5d4880..aadf11e9867 100644
--- a/configs/coreboot64-no-spl_defconfig
+++ b/configs/coreboot64-no-spl_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_SOUND=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 706c0cd71d7..719b2f02c1e 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -40,7 +40,7 @@ CONFIG_MAC_PARTITION=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index bd190e40ffc..dfb97a3d302 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/corvus_defconfig b/configs/corvus_defconfig
index 729ebf7a6c8..fe7d53bcdd8 100644
--- a/configs/corvus_defconfig
+++ b/configs/corvus_defconfig
@@ -68,7 +68,7 @@ CONFIG_DOS_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/cougarcanyon2_defconfig b/configs/cougarcanyon2_defconfig
index 134b3533250..fac3a85212a 100644
--- a/configs/cougarcanyon2_defconfig
+++ b/configs/cougarcanyon2_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/crownbay_defconfig b/configs/crownbay_defconfig
index 3129cbf5f30..645c1649cbf 100644
--- a/configs/crownbay_defconfig
+++ b/configs/crownbay_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/crs305-1g-4s-bit_defconfig b/configs/crs305-1g-4s-bit_defconfig
index 4087504dd66..92bff3d0cdb 100644
--- a/configs/crs305-1g-4s-bit_defconfig
+++ b/configs/crs305-1g-4s-bit_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/crs305-1g-4s_defconfig b/configs/crs305-1g-4s_defconfig
index a14a5e83aea..f53526a1431 100644
--- a/configs/crs305-1g-4s_defconfig
+++ b/configs/crs305-1g-4s_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/crs326-24g-2s-bit_defconfig b/configs/crs326-24g-2s-bit_defconfig
index 815ebefb225..5c81e5bc596 100644
--- a/configs/crs326-24g-2s-bit_defconfig
+++ b/configs/crs326-24g-2s-bit_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/crs326-24g-2s_defconfig b/configs/crs326-24g-2s_defconfig
index bdd6e84a0a4..3cc2ccfefd2 100644
--- a/configs/crs326-24g-2s_defconfig
+++ b/configs/crs326-24g-2s_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/crs328-4c-20s-4s-bit_defconfig b/configs/crs328-4c-20s-4s-bit_defconfig
index d1980634f4f..a02420d29c9 100644
--- a/configs/crs328-4c-20s-4s-bit_defconfig
+++ b/configs/crs328-4c-20s-4s-bit_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/crs328-4c-20s-4s_defconfig b/configs/crs328-4c-20s-4s_defconfig
index 19c48338f94..5fd8ff63446 100644
--- a/configs/crs328-4c-20s-4s_defconfig
+++ b/configs/crs328-4c-20s-4s_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/da850evm_defconfig b/configs/da850evm_defconfig
index 861bfea28e9..c76f6847d85 100644
--- a/configs/da850evm_defconfig
+++ b/configs/da850evm_defconfig
@@ -75,7 +75,7 @@ CONFIG_CMD_DIAG=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/da850evm_nand_defconfig b/configs/da850evm_nand_defconfig
index 27910a5b9b1..655cb5d4e9e 100644
--- a/configs/da850evm_nand_defconfig
+++ b/configs/da850evm_nand_defconfig
@@ -71,7 +71,7 @@ CONFIG_CMD_DIAG=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/dalmore_defconfig b/configs/dalmore_defconfig
index e35a4f43384..0aed9ebad58 100644
--- a/configs/dalmore_defconfig
+++ b/configs/dalmore_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/db-88f6720_defconfig b/configs/db-88f6720_defconfig
index 79e3f568bf8..f790ba82f0a 100644
--- a/configs/db-88f6720_defconfig
+++ b/configs/db-88f6720_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_FS_GENERIC=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/db-88f6820-amc_defconfig b/configs/db-88f6820-amc_defconfig
index 7742bf77482..48aa425f4df 100644
--- a/configs/db-88f6820-amc_defconfig
+++ b/configs/db-88f6820-amc_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_SPL_OF_TRANSLATE=y
diff --git a/configs/db-88f6820-amc_nand_defconfig b/configs/db-88f6820-amc_nand_defconfig
index d970cf72be7..1b96ffca2d9 100644
--- a/configs/db-88f6820-amc_nand_defconfig
+++ b/configs/db-88f6820-amc_nand_defconfig
@@ -59,7 +59,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_SPL_OF_TRANSLATE=y
diff --git a/configs/db-88f6820-gp_defconfig b/configs/db-88f6820-gp_defconfig
index b93c717e5b3..33297c7895c 100644
--- a/configs/db-88f6820-gp_defconfig
+++ b/configs/db-88f6820-gp_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_SPL_OF_TRANSLATE=y
diff --git a/configs/db-mv784mp-gp_defconfig b/configs/db-mv784mp-gp_defconfig
index 5aa19109ed9..5162f70ab9e 100644
--- a/configs/db-mv784mp-gp_defconfig
+++ b/configs/db-mv784mp-gp_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_SPL_OF_TRANSLATE=y
diff --git a/configs/db-xc3-24g4xg_defconfig b/configs/db-xc3-24g4xg_defconfig
index 06e52cc41ef..e02d1873c17 100644
--- a/configs/db-xc3-24g4xg_defconfig
+++ b/configs/db-xc3-24g4xg_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_DM_I2C=y
diff --git a/configs/devkit8000_defconfig b/configs/devkit8000_defconfig
index 33201cec772..90076485527 100644
--- a/configs/devkit8000_defconfig
+++ b/configs/devkit8000_defconfig
@@ -55,7 +55,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/dfi-bt700-q7x-151_defconfig b/configs/dfi-bt700-q7x-151_defconfig
index d9fff4e457e..7cfeba0f24e 100644
--- a/configs/dfi-bt700-q7x-151_defconfig
+++ b/configs/dfi-bt700-q7x-151_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/display5_defconfig b/configs/display5_defconfig
index 950e4c5d84d..16807f4e77b 100644
--- a/configs/display5_defconfig
+++ b/configs/display5_defconfig
@@ -96,7 +96,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ALTBOOTCMD="run recovery"
diff --git a/configs/display5_factory_defconfig b/configs/display5_factory_defconfig
index 3e545e5e12c..3f07dc4b1a0 100644
--- a/configs/display5_factory_defconfig
+++ b/configs/display5_factory_defconfig
@@ -94,7 +94,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_SF=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index ee4c91a2ed2..6e5cfa92ef1 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -64,7 +64,7 @@ CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index 930abba1c84..e4d5b117996 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -56,7 +56,7 @@ CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 9589d796464..d81e1fc7ad6 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -52,7 +52,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index 7fd2d87dfb9..eb873d4f0f0 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -70,7 +70,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x200000
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_USE_ROOTPATH=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 9d8b5aff7a1..f034e2ea68b 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -67,7 +67,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_USE_ROOTPATH=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index 84fdd247c55..6a405de8171 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -67,7 +67,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_USE_ROOTPATH=y
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 449d48a3c00..20b2794b618 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_SYSBOOT=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
index b7c7b64db90..ff2c960983a 100644
--- a/configs/dragonboard820c_defconfig
+++ b/configs/dragonboard820c_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_PMIC=y
 CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_EXT4_INTERFACE="mmc"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_STUB=y
diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
index f4481b88b30..31026c8dbbd 100644
--- a/configs/ds116_defconfig
+++ b/configs/ds116_defconfig
@@ -59,7 +59,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:1m(u-boot),7040k(kernel),64k(u-boot-env),-(data)"
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
index ee2ee60c92c..c32fac153de 100644
--- a/configs/ds414_defconfig
+++ b/configs/ds414_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/durian_defconfig b/configs/durian_defconfig
index ea1d37e9db6..336c7a5269e 100644
--- a/configs/durian_defconfig
+++ b/configs/durian_defconfig
@@ -27,7 +27,7 @@ CONFIG_SYS_PROMPT="durian#"
 # CONFIG_CMD_UNZIP is not set
 CONFIG_CMD_PCI=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 5f2009ca1f2..34bfc75ea31 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -34,7 +34,7 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_NO_NET=y
 CONFIG_CLK_EXYNOS850=y
diff --git a/configs/eDPU_defconfig b/configs/eDPU_defconfig
index 43041039b46..b50e3815178 100644
--- a/configs/eDPU_defconfig
+++ b/configs/eDPU_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
index 5e1791d63f9..e30cd1842c4 100644
--- a/configs/eaidk-610-rk3399_defconfig
+++ b/configs/eaidk-610-rk3399_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/edison_defconfig b/configs/edison_defconfig
index 7e85a91898e..733b0ebe639 100644
--- a/configs/edison_defconfig
+++ b/configs/edison_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CPU=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index c730945f4f9..71d1bbd956e 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -33,7 +33,7 @@ CONFIG_ISO_PARTITION=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_NO_NET=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 1831fb2d5a7..9f7b53d0106 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -37,7 +37,7 @@ CONFIG_ISO_PARTITION=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_NO_NET=y
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 957fd83e432..e9c5ddf12ad 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 71612d7fb19..b82e10dc3a1 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -31,7 +31,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_INTERFACE="scsi"
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/elgin-rv1108_defconfig b/configs/elgin-rv1108_defconfig
index 601165be85a..6108b70d75a 100644
--- a/configs/elgin-rv1108_defconfig
+++ b/configs/elgin-rv1108_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/emsdp_defconfig b/configs/emsdp_defconfig
index 376862ad300..35a5cc9e449 100644
--- a/configs/emsdp_defconfig
+++ b/configs/emsdp_defconfig
@@ -26,7 +26,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="app.bin"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index e216c2edafd..7aac11192fc 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/espresso7420_defconfig b/configs/espresso7420_defconfig
index 1f44197d725..b23ba6026ef 100644
--- a/configs/espresso7420_defconfig
+++ b/configs/espresso7420_defconfig
@@ -22,4 +22,4 @@ CONFIG_CONSOLE_MUX=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="ESPRESSO7420 # "
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/evb-ast2500_defconfig b/configs/evb-ast2500_defconfig
index 2c89f6c2eb5..7f4371aa75f 100644
--- a/configs/evb-ast2500_defconfig
+++ b/configs/evb-ast2500_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_CLK=y
diff --git a/configs/evb-ast2600_defconfig b/configs/evb-ast2600_defconfig
index c9d75e0cf8e..16e8a58ccc0 100644
--- a/configs/evb-ast2600_defconfig
+++ b/configs/evb-ast2600_defconfig
@@ -77,7 +77,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
index 8a5fb00c034..8a24b0f1461 100644
--- a/configs/evb-px30_defconfig
+++ b/configs/evb-px30_defconfig
@@ -50,7 +50,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/evb-px5_defconfig b/configs/evb-px5_defconfig
index 496936bcf12..aac35211369 100644
--- a/configs/evb-px5_defconfig
+++ b/configs/evb-px5_defconfig
@@ -56,7 +56,7 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_TPL_DM=y
 CONFIG_REGMAP=y
diff --git a/configs/evb-rk3036_defconfig b/configs/evb-rk3036_defconfig
index a456cdc10fa..93588b64eb4 100644
--- a/configs/evb-rk3036_defconfig
+++ b/configs/evb-rk3036_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/evb-rk3128_defconfig b/configs/evb-rk3128_defconfig
index b46da229d54..90cbf55806a 100644
--- a/configs/evb-rk3128_defconfig
+++ b/configs/evb-rk3128_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/evb-rk3229_defconfig b/configs/evb-rk3229_defconfig
index 7a09c2c70ca..116c04c914d 100644
--- a/configs/evb-rk3229_defconfig
+++ b/configs/evb-rk3229_defconfig
@@ -39,7 +39,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/evb-rk3288_defconfig b/configs/evb-rk3288_defconfig
index 025c00c30f6..02347b58c22 100644
--- a/configs/evb-rk3288_defconfig
+++ b/configs/evb-rk3288_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index 777c412130f..e63f876220c 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index db71ec4dc35..4f76c0fefdd 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -40,7 +40,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index b88f5223207..62601fa69a4 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 # CONFIG_ROCKCHIP_IODOMAIN is not set
diff --git a/configs/evb-rv1108_defconfig b/configs/evb-rv1108_defconfig
index 46b94953101..16f7a80588d 100644
--- a/configs/evb-rv1108_defconfig
+++ b/configs/evb-rv1108_defconfig
@@ -21,7 +21,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index 311d37f0f91..d2f999b48e2 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defconfig
index 3b63537136c..f8b70767d9f 100644
--- a/configs/firefly-px30_defconfig
+++ b/configs/firefly-px30_defconfig
@@ -52,7 +52,7 @@ CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 4d07e0b2635..d7b01e67db9 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -45,7 +45,7 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index fc9610a122c..ab142f8ce86 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/galileo_defconfig b/configs/galileo_defconfig
index b9e53ecc8fd..f522948a60d 100644
--- a/configs/galileo_defconfig
+++ b/configs/galileo_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/gardena-smart-gateway-at91sam_defconfig b/configs/gardena-smart-gateway-at91sam_defconfig
index e62e6ed397d..d045120aad2 100644
--- a/configs/gardena-smart-gateway-at91sam_defconfig
+++ b/configs/gardena-smart-gateway-at91sam_defconfig
@@ -82,7 +82,7 @@ CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="ubi"
 CONFIG_ENV_UBI_VOLUME="uboot_env0"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_env1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index d9ccf35afa3..3c2bcc6a3c4 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -72,7 +72,7 @@ CONFIG_MTDPARTS_DEFAULT="spi0.0:640k(uboot),64k(uboot_env0),64k(uboot_env1),64k(
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ge_bx50v3_defconfig b/configs/ge_bx50v3_defconfig
index 676b5bc8a28..46209761576 100644
--- a/configs/ge_bx50v3_defconfig
+++ b/configs/ge_bx50v3_defconfig
@@ -47,7 +47,7 @@ CONFIG_OF_LIST="imx6q-bx50v3 imx6q-b850v3 imx6q-b650v3 imx6q-b450v3"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
diff --git a/configs/geekbox_defconfig b/configs/geekbox_defconfig
index 80f91de7a11..42b5c0c38a8 100644
--- a/configs/geekbox_defconfig
+++ b/configs/geekbox_defconfig
@@ -17,7 +17,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-geekbox.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/generic-rk3328_defconfig b/configs/generic-rk3328_defconfig
index c0225b1afd0..26e010864dc 100644
--- a/configs/generic-rk3328_defconfig
+++ b/configs/generic-rk3328_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_RNG=y
 CONFIG_SPL_OF_CONTROL=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/generic-rk3399_defconfig b/configs/generic-rk3399_defconfig
index 383102cddd0..4a95379c931 100644
--- a/configs/generic-rk3399_defconfig
+++ b/configs/generic-rk3399_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_RNG=y
 CONFIG_SPL_OF_CONTROL=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_ADC is not set
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index dd9a501f704..09400bae27a 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -42,7 +42,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 695eef085bf..ed2f936b324 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -36,7 +36,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/grouper_defconfig b/configs/grouper_defconfig
index 016fc60b41a..76ec9a39a7c 100644
--- a/configs/grouper_defconfig
+++ b/configs/grouper_defconfig
@@ -54,7 +54,7 @@ CONFIG_OF_LIST="tegra30-asus-nexus7-grouper-E1565 tegra30-asus-nexus7-grouper-PM
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/grpeach_defconfig b/configs/grpeach_defconfig
index d2cc1cf7981..0f141b6f0a2 100644
--- a/configs/grpeach_defconfig
+++ b/configs/grpeach_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_RZA1_GPIO=y
 CONFIG_LED=y
diff --git a/configs/gurnard_defconfig b/configs/gurnard_defconfig
index 9929d588f37..bde531a6003 100644
--- a/configs/gurnard_defconfig
+++ b/configs/gurnard_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_TFTP_PORT=y
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/guruplug_defconfig b/configs/guruplug_defconfig
index ec0db1f8626..c09f307b441 100644
--- a/configs/guruplug_defconfig
+++ b/configs/guruplug_defconfig
@@ -43,7 +43,7 @@ CONFIG_ISO_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_ATA_STRIDE=4
diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_defconfig
index cf1b3b6fa66..9aabd6be88a 100644
--- a/configs/gwventana_emmc_defconfig
+++ b/configs/gwventana_emmc_defconfig
@@ -92,7 +92,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NETCONSOLE=y
diff --git a/configs/gwventana_nand_defconfig b/configs/gwventana_nand_defconfig
index 2bc28f6203c..aae68d3d620 100644
--- a/configs/gwventana_nand_defconfig
+++ b/configs/gwventana_nand_defconfig
@@ -96,7 +96,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NETCONSOLE=y
 CONFIG_USE_IPADDR=y
diff --git a/configs/harmony_defconfig b/configs/harmony_defconfig
index 9fa9c12918b..6bce588c7a5 100644
--- a/configs/harmony_defconfig
+++ b/configs/harmony_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
diff --git a/configs/hc2910_2aghd05_defconfig b/configs/hc2910_2aghd05_defconfig
index d7cc7d18ed8..2d347a20f16 100644
--- a/configs/hc2910_2aghd05_defconfig
+++ b/configs/hc2910_2aghd05_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index c9753e13657..5169b089687 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -23,7 +23,7 @@ CONFIG_OF_LIST="renesas/r8a774a1-hihope-rzg2m-ex renesas/r8a774b1-hihope-rzg2n-e
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=0
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_GPIO_HOG=y
diff --git a/configs/hikey960_defconfig b/configs/hikey960_defconfig
index a684994722c..440f257072d 100644
--- a/configs/hikey960_defconfig
+++ b/configs/hikey960_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_MMC=y
 CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_EXT4_INTERFACE="mmc"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:2"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=1024
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_K3=y
diff --git a/configs/hikey_defconfig b/configs/hikey_defconfig
index c4f63619292..c63e66cf383 100644
--- a/configs/hikey_defconfig
+++ b/configs/hikey_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_HIKEY_GPIO=y
 CONFIG_MMC_DW=y
diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
index 4550eba71ab..6832ed46077 100644
--- a/configs/hmibsc_defconfig
+++ b/configs/hmibsc_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/hsdk_4xd_defconfig b/configs/hsdk_4xd_defconfig
index 4c9d2e76866..e44c54821a4 100644
--- a/configs/hsdk_4xd_defconfig
+++ b/configs/hsdk_4xd_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/hsdk_defconfig b/configs/hsdk_defconfig
index 2aab639f6a7..60110d85d55 100644
--- a/configs/hsdk_defconfig
+++ b/configs/hsdk_defconfig
@@ -40,7 +40,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/huawei_hg556a_ram_defconfig b/configs/huawei_hg556a_ram_defconfig
index 17d1c102031..5b8fa3715f4 100644
--- a/configs/huawei_hg556a_ram_defconfig
+++ b/configs/huawei_hg556a_ram_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=6
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/ib62x0_defconfig b/configs/ib62x0_defconfig
index 567c7eb3a03..a8c53fc02fa 100644
--- a/configs/ib62x0_defconfig
+++ b/configs/ib62x0_defconfig
@@ -42,7 +42,7 @@ CONFIG_ISO_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_ATA_STRIDE=4
diff --git a/configs/ibex-ast2700_defconfig b/configs/ibex-ast2700_defconfig
index 6cb2a21ed2d..f088aec8716 100644
--- a/configs/ibex-ast2700_defconfig
+++ b/configs/ibex-ast2700_defconfig
@@ -66,7 +66,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_DEVICE_TREE_INCLUDES="ast2700-u-boot.dtsi"
 # CONFIG_OF_TAG_MIGRATE is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=2
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_SEQ_ALIAS is not set
diff --git a/configs/ibm-sbp1_defconfig b/configs/ibm-sbp1_defconfig
index c86a9b33c5d..5f16301e5b5 100644
--- a/configs/ibm-sbp1_defconfig
+++ b/configs/ibm-sbp1_defconfig
@@ -73,7 +73,7 @@ CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/iconnect_defconfig b/configs/iconnect_defconfig
index 6ee40e380b2..20074b36862 100644
--- a/configs/iconnect_defconfig
+++ b/configs/iconnect_defconfig
@@ -43,7 +43,7 @@ CONFIG_ISO_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ideapad-yoga-11_defconfig b/configs/ideapad-yoga-11_defconfig
index a4feb364b3e..350dbcc4dcd 100644
--- a/configs/ideapad-yoga-11_defconfig
+++ b/configs/ideapad-yoga-11_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index c2ece13e2a1..726e357b91b 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -57,7 +57,7 @@ CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="config"
 CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
diff --git a/configs/imgtec_xilfpga_defconfig b/configs/imgtec_xilfpga_defconfig
index 233c89c04ee..c8b12b3a0c0 100644
--- a/configs/imgtec_xilfpga_defconfig
+++ b/configs/imgtec_xilfpga_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_TIME=y
 # CONFIG_ISO_PARTITION is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/imx6dl_icore_nand_defconfig b/configs/imx6dl_icore_nand_defconfig
index 4352e3871f5..13421d478ca 100644
--- a/configs/imx6dl_icore_nand_defconfig
+++ b/configs/imx6dl_icore_nand_defconfig
@@ -48,7 +48,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:2m(spl),2m(uboot),1m(env),8m(kernel)
 CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6dl_mamoj_defconfig b/configs/imx6dl_mamoj_defconfig
index 174f768a1eb..255bd611d12 100644
--- a/configs/imx6dl_mamoj_defconfig
+++ b/configs/imx6dl_mamoj_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_PMIC=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
diff --git a/configs/imx6dl_sielaff_defconfig b/configs/imx6dl_sielaff_defconfig
index a364e2c9cdd..6673e1e6915 100644
--- a/configs/imx6dl_sielaff_defconfig
+++ b/configs/imx6dl_sielaff_defconfig
@@ -62,7 +62,7 @@ CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/imx6q_icore_nand_defconfig b/configs/imx6q_icore_nand_defconfig
index 2c7b8cc2c44..d6293c58ede 100644
--- a/configs/imx6q_icore_nand_defconfig
+++ b/configs/imx6q_icore_nand_defconfig
@@ -49,7 +49,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:2m(spl),2m(uboot),1m(env),8m(kernel)
 CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6q_logic_defconfig b/configs/imx6q_logic_defconfig
index fd251e7cdd8..997e406a057 100644
--- a/configs/imx6q_logic_defconfig
+++ b/configs/imx6q_logic_defconfig
@@ -68,7 +68,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx6qdl_icore_mipi_defconfig b/configs/imx6qdl_icore_mipi_defconfig
index cf4c2d9c6f1..c322fd3eff1 100644
--- a/configs/imx6qdl_icore_mipi_defconfig
+++ b/configs/imx6qdl_icore_mipi_defconfig
@@ -60,7 +60,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_LIST="imx6q-icore-mipi imx6dl-icore-mipi"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6qdl_icore_mmc_defconfig b/configs/imx6qdl_icore_mmc_defconfig
index 269fe271a76..0b82fbecbee 100644
--- a/configs/imx6qdl_icore_mmc_defconfig
+++ b/configs/imx6qdl_icore_mmc_defconfig
@@ -69,7 +69,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_LIST="imx6q-icore imx6dl-icore"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ALTBOOTCMD="run recoveryboot"
diff --git a/configs/imx6qdl_icore_nand_defconfig b/configs/imx6qdl_icore_nand_defconfig
index 2c7b8cc2c44..d6293c58ede 100644
--- a/configs/imx6qdl_icore_nand_defconfig
+++ b/configs/imx6qdl_icore_nand_defconfig
@@ -49,7 +49,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:2m(spl),2m(uboot),1m(env),8m(kernel)
 CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6qdl_icore_rqs_defconfig b/configs/imx6qdl_icore_rqs_defconfig
index 49feb1af830..8520f90c867 100644
--- a/configs/imx6qdl_icore_rqs_defconfig
+++ b/configs/imx6qdl_icore_rqs_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_LIST="imx6q-icore-rqs imx6dl-icore-rqs"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6ul_geam_mmc_defconfig b/configs/imx6ul_geam_mmc_defconfig
index 73a26250b2c..db1f54ecedc 100644
--- a/configs/imx6ul_geam_mmc_defconfig
+++ b/configs/imx6ul_geam_mmc_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6ul_geam_nand_defconfig b/configs/imx6ul_geam_nand_defconfig
index c8d95f38a61..79491674ea5 100644
--- a/configs/imx6ul_geam_nand_defconfig
+++ b/configs/imx6ul_geam_nand_defconfig
@@ -50,7 +50,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:2m(spl),2m(uboot),1m(env),8m(kernel)
 CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6ul_isiot_emmc_defconfig b/configs/imx6ul_isiot_emmc_defconfig
index f7ea75597d1..559c833c232 100644
--- a/configs/imx6ul_isiot_emmc_defconfig
+++ b/configs/imx6ul_isiot_emmc_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6ul_isiot_nand_defconfig b/configs/imx6ul_isiot_nand_defconfig
index b657e829a6a..c7fc61dd7ea 100644
--- a/configs/imx6ul_isiot_nand_defconfig
+++ b/configs/imx6ul_isiot_nand_defconfig
@@ -50,7 +50,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:2m(spl),2m(uboot),1m(env),8m(kernel)
 CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 6e425d6e52d..43862d2573d 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_CLK_COMPOSITE_CCF=y
diff --git a/configs/imx6ulz_smm_m2b_defconfig b/configs/imx6ulz_smm_m2b_defconfig
index c9e66adde98..c0eb1093d8b 100644
--- a/configs/imx6ulz_smm_m2b_defconfig
+++ b/configs/imx6ulz_smm_m2b_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/imx7_cm_defconfig b/configs/imx7_cm_defconfig
index 090bf1d095c..6c5be29448f 100644
--- a/configs/imx7_cm_defconfig
+++ b/configs/imx7_cm_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_PMIC=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index ab883259f09..0c9f85b7671 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -203,7 +203,7 @@ CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SYS_PBSIZE=2081
 CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_TEXT_BASE=0x40200000
 CONFIG_TFTP_TSIZE=y
 CONFIG_USB=y
diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-cl-iot-gate-optee_defconfig
index dbc439c23f5..b52341c1a49 100644
--- a/configs/imx8mm-cl-iot-gate-optee_defconfig
+++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
@@ -77,7 +77,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index 064293c0f51..ede02659a8f 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -80,7 +80,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
index 42926587722..bb90dee583a 100644
--- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
index 86a14547095..d1540de3b84 100644
--- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index 32063bc9280..d7be3f0c679 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -92,7 +92,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index c57b63c1e75..7a7ee935f03 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -74,7 +74,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 27007bd8687..fda40e1269d 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -74,7 +74,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
index 81510a10a1f..7d1772c5d09 100644
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ b/configs/imx8mm_beacon_fspi_defconfig
@@ -77,7 +77,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 5230f7327db..02264e91b4e 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -60,7 +60,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 902585b3b6d..a194eeb7dc5 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -62,7 +62,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index e6d0f41f418..cd6db3ad025 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -63,7 +63,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK_COMPOSITE_CCF=y
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index a5bc8aea027..0f9bf8586bd 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -82,7 +82,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent interrupts"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index 32d2a1599c8..bb3ef43fa3f 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -83,7 +83,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
index 835654d2b63..f340cb1b7c5 100644
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ b/configs/imx8mn_beacon_fspi_defconfig
@@ -82,7 +82,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 206d216394d..c83f6a99a7e 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -62,7 +62,7 @@ CONFIG_MTDPARTS_DEFAULT="gpmi-nand:64m(nandboot),16m(nandfit),32m(nandkernel),1m
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_REGMAP=y
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index ef486f51eee..58550c6c332 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_REGMAP=y
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 3cc7d2b6b13..4edcda0dc85 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -65,7 +65,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index d45c83951ef..6a0e46b14ab 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK_IMX8MN=y
diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index 5a9f31b1c2a..cfa07c59901 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -60,7 +60,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index b3c1b276ba2..0679d041a6e 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -66,7 +66,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index d0b074b1f2b..88cc025bd23 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -81,7 +81,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mp_debix_model_a_defconfig b/configs/imx8mp_debix_model_a_defconfig
index cf19ceae911..9654a45d1db 100644
--- a/configs/imx8mp_debix_model_a_defconfig
+++ b/configs/imx8mp_debix_model_a_defconfig
@@ -59,7 +59,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 5b2c977edf8..4ddb4f2683e 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -67,7 +67,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mp_navqp_defconfig b/configs/imx8mp_navqp_defconfig
index d6e7edcfa28..f7ae8c0a5b0 100644
--- a/configs/imx8mp_navqp_defconfig
+++ b/configs/imx8mp_navqp_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb3720a1_4G_defconfig
index ea091d32eee..000c536c9b7 100644
--- a/configs/imx8mp_rsb3720a1_4G_defconfig
+++ b/configs/imx8mp_rsb3720a1_4G_defconfig
@@ -95,7 +95,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb3720a1_6G_defconfig
index 03e558b9589..c7623f23aa7 100644
--- a/configs/imx8mp_rsb3720a1_6G_defconfig
+++ b/configs/imx8mp_rsb3720a1_6G_defconfig
@@ -95,7 +95,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mq_cm_defconfig b/configs/imx8mq_cm_defconfig
index 1eff6bbc800..ac65565009e 100644
--- a/configs/imx8mq_cm_defconfig
+++ b/configs/imx8mq_cm_defconfig
@@ -56,7 +56,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index a2a6991bee2..6be4b95148e 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -67,7 +67,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index 807c5602d66..ab53f90093e 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -70,7 +70,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index 7d3c81c93d4..9cd1bb5e4e9 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -69,7 +69,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
index afcb0f30594..b73338299f7 100644
--- a/configs/imx8qm_mek_defconfig
+++ b/configs/imx8qm_mek_defconfig
@@ -73,7 +73,7 @@ CONFIG_CMD_FAT=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
diff --git a/configs/imx8qm_rom7720_a1_4G_defconfig b/configs/imx8qm_rom7720_a1_4G_defconfig
index cd1db0ec408..588c398dec4 100644
--- a/configs/imx8qm_rom7720_a1_4G_defconfig
+++ b/configs/imx8qm_rom7720_a1_4G_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FAT=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconfig
index fa36b7b77a1..18fa27115fe 100644
--- a/configs/imx8qxp_mek_defconfig
+++ b/configs/imx8qxp_mek_defconfig
@@ -74,7 +74,7 @@ CONFIG_CMD_FAT=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/imx91_11x11_evk_defconfig b/configs/imx91_11x11_evk_defconfig
index 810a8a8c012..77681e547fd 100644
--- a/configs/imx91_11x11_evk_defconfig
+++ b/configs/imx91_11x11_evk_defconfig
@@ -80,7 +80,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx91_11x11_evk_inline_ecc_defconfig b/configs/imx91_11x11_evk_inline_ecc_defconfig
index f330ea694f7..29b0b54dbe8 100644
--- a/configs/imx91_11x11_evk_inline_ecc_defconfig
+++ b/configs/imx91_11x11_evk_inline_ecc_defconfig
@@ -80,7 +80,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index fc6f4c77df2..1c7a0a4c954 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -86,7 +86,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 16596a89d60..c1203508bc7 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -76,7 +76,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx93_9x9_qsb_defconfig b/configs/imx93_9x9_qsb_defconfig
index 60dd143aeab..632e2290cf3 100644
--- a/configs/imx93_9x9_qsb_defconfig
+++ b/configs/imx93_9x9_qsb_defconfig
@@ -78,7 +78,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx93_9x9_qsb_inline_ecc_defconfig b/configs/imx93_9x9_qsb_inline_ecc_defconfig
index d6084b94b98..485452e7135 100644
--- a/configs/imx93_9x9_qsb_inline_ecc_defconfig
+++ b/configs/imx93_9x9_qsb_inline_ecc_defconfig
@@ -78,7 +78,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index 411f2b2e236..6811a6f58f5 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -87,7 +87,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
index 32aee1fa90a..ad2e35b52c6 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -86,7 +86,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/imx_dhsom.config b/configs/imx_dhsom.config
index e293d61a488..4a3ddc7e90b 100644
--- a/configs/imx_dhsom.config
+++ b/configs/imx_dhsom.config
@@ -26,7 +26,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/imxrt1020-evk_defconfig b/configs/imxrt1020-evk_defconfig
index b67dc399e5c..17c650e6950 100644
--- a/configs/imxrt1020-evk_defconfig
+++ b/configs/imxrt1020-evk_defconfig
@@ -45,7 +45,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_BLOCKSIZE=512
 CONFIG_SPL_DM=y
diff --git a/configs/imxrt1050-evk_defconfig b/configs/imxrt1050-evk_defconfig
index 918713a1c7d..5faf964759d 100644
--- a/configs/imxrt1050-evk_defconfig
+++ b/configs/imxrt1050-evk_defconfig
@@ -51,7 +51,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_BLOCKSIZE=512
 CONFIG_SPL_DM=y
diff --git a/configs/imxrt1050-evk_fspi_defconfig b/configs/imxrt1050-evk_fspi_defconfig
index 86acd158391..cc7e8a3e10b 100644
--- a/configs/imxrt1050-evk_fspi_defconfig
+++ b/configs/imxrt1050-evk_fspi_defconfig
@@ -53,7 +53,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_BLOCKSIZE=512
 CONFIG_SPL_DM=y
diff --git a/configs/imxrt1170-evk_defconfig b/configs/imxrt1170-evk_defconfig
index a57c35bf686..9bd3874143c 100644
--- a/configs/imxrt1170-evk_defconfig
+++ b/configs/imxrt1170-evk_defconfig
@@ -47,7 +47,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/integratorap_cm720t_defconfig b/configs/integratorap_cm720t_defconfig
index bd0a7bf1c4d..c1931bd2e1c 100644
--- a/configs/integratorap_cm720t_defconfig
+++ b/configs/integratorap_cm720t_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_IMLS=y
 CONFIG_CMD_ARMFLASH=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/integratorap_cm920t_defconfig b/configs/integratorap_cm920t_defconfig
index aae5512a5fa..409dd341a98 100644
--- a/configs/integratorap_cm920t_defconfig
+++ b/configs/integratorap_cm920t_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_IMLS=y
 CONFIG_CMD_ARMFLASH=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/integratorap_cm926ejs_defconfig b/configs/integratorap_cm926ejs_defconfig
index 7aaec71a977..a831fbba3d5 100644
--- a/configs/integratorap_cm926ejs_defconfig
+++ b/configs/integratorap_cm926ejs_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_IMLS=y
 CONFIG_CMD_ARMFLASH=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/integratorap_cm946es_defconfig b/configs/integratorap_cm946es_defconfig
index 05fa604368c..ce7ca33efb3 100644
--- a/configs/integratorap_cm946es_defconfig
+++ b/configs/integratorap_cm946es_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_IMLS=y
 CONFIG_CMD_ARMFLASH=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/inteno_xg6846_ram_defconfig b/configs/inteno_xg6846_ram_defconfig
index f325a07a522..0919289d613 100644
--- a/configs/inteno_xg6846_ram_defconfig
+++ b/configs/inteno_xg6846_ram_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_MEMINFO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_SPI=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_DMA=y
 CONFIG_BCM6348_IUDMA=y
diff --git a/configs/iot_devkit_defconfig b/configs/iot_devkit_defconfig
index 5b7e131c9ac..aef0a995c39 100644
--- a/configs/iot_devkit_defconfig
+++ b/configs/iot_devkit_defconfig
@@ -31,7 +31,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="app.bin"
 CONFIG_NO_NET=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 2ae1743ac7b..c9b8e02812b 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -79,7 +79,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 0ae07ddf7c8..f5480b16df8 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -72,7 +72,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index 25d2302bf1f..d3f118a9429 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -80,7 +80,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/j721e_beagleboneai64_r5_defconfig b/configs/j721e_beagleboneai64_r5_defconfig
index 086ad99ff6d..dad3173daa3 100644
--- a/configs/j721e_beagleboneai64_r5_defconfig
+++ b/configs/j721e_beagleboneai64_r5_defconfig
@@ -67,7 +67,7 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_OF_LIST="k3-j721e-r5-beagleboneai64"
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 8aeeeb8bdc6..a27b7c712b4 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -84,7 +84,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index c8324d4c068..15aa0f2a3e4 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -80,7 +80,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 1f216ffdf25..36b6c6ade0b 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -76,7 +76,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 6ea1d712be1..fe95f2c29bc 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -81,7 +81,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index 88717829d82..ab0d4ebb825 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 4589629c9ad..faa3e26afaa 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -66,7 +66,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 4f5a0c943d8..78d89bebd19 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -71,7 +71,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index 35f34ebf071..de5ccfa2385 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -59,7 +59,7 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
index b5deb9d1c19..24011b0a0e6 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_RTC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index 89fcefb6ec6..8b5f7cdbcfd 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_RTC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
diff --git a/configs/jetson-tk1_defconfig b/configs/jetson-tk1_defconfig
index 3b74845046c..9594c30dec6 100644
--- a/configs/jetson-tk1_defconfig
+++ b/configs/jetson-tk1_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/k2e_evm_defconfig b/configs/k2e_evm_defconfig
index ab28e15a3ff..e8635054e8c 100644
--- a/configs/k2e_evm_defconfig
+++ b/configs/k2e_evm_defconfig
@@ -63,7 +63,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=32
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/k2e_hs_evm_defconfig b/configs/k2e_hs_evm_defconfig
index 6b771dfb061..0557dd5a5b3 100644
--- a/configs/k2e_hs_evm_defconfig
+++ b/configs/k2e_hs_evm_defconfig
@@ -37,7 +37,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=32
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/k2g_evm_defconfig b/configs/k2g_evm_defconfig
index 9b8fcc591ae..02a948c251f 100644
--- a/configs/k2g_evm_defconfig
+++ b/configs/k2g_evm_defconfig
@@ -64,7 +64,7 @@ CONFIG_OF_LIST="ti/keystone/keystone-k2g-evm ti/keystone/keystone-k2g-ice"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=32
diff --git a/configs/k2g_hs_evm_defconfig b/configs/k2g_hs_evm_defconfig
index af9316f753a..ca58125aa3f 100644
--- a/configs/k2g_hs_evm_defconfig
+++ b/configs/k2g_hs_evm_defconfig
@@ -39,7 +39,7 @@ CONFIG_OF_LIST="ti/keystone/keystone-k2g-evm ti/keystone/keystone-k2g-ice"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=32
diff --git a/configs/k2hk_evm_defconfig b/configs/k2hk_evm_defconfig
index 31ffb762c26..b3756c60efc 100644
--- a/configs/k2hk_evm_defconfig
+++ b/configs/k2hk_evm_defconfig
@@ -63,7 +63,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=32
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/k2hk_hs_evm_defconfig b/configs/k2hk_hs_evm_defconfig
index 0e43ca1f861..0025412b10f 100644
--- a/configs/k2hk_hs_evm_defconfig
+++ b/configs/k2hk_hs_evm_defconfig
@@ -37,7 +37,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=32
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/k2l_evm_defconfig b/configs/k2l_evm_defconfig
index 8f5c4855dd3..e90297cd2e9 100644
--- a/configs/k2l_evm_defconfig
+++ b/configs/k2l_evm_defconfig
@@ -63,7 +63,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=32
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/k2l_hs_evm_defconfig b/configs/k2l_hs_evm_defconfig
index 4f71a208d8d..8864b60e845 100644
--- a/configs/k2l_hs_evm_defconfig
+++ b/configs/k2l_hs_evm_defconfig
@@ -40,7 +40,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=32
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index c23f0ecd516..8ed3e5f3ec8 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index cac98f721cf..ec3428d34c3 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index 3800bcf2ab3..3903c4e2ad1 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 59491c4d29f..1d8e0601dc9 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index a078c5d363a..ef68e1cf1f5 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index b77a44ce859..3ad82c9afff 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 7cc31efb752..a8126a680fa 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 43db61056ba..8e439cad3c1 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 32d57a5b909..56b4086ee3f 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index 5aa08c41df8..87bacf4500e 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index 775c24f7ddc..02a3b9fa471 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index 8352176df61..7d5effe663e 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -76,7 +76,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
diff --git a/configs/kp_imx53_defconfig b/configs/kp_imx53_defconfig
index 54cfc855f1e..9943f5bd12c 100644
--- a/configs/kp_imx53_defconfig
+++ b/configs/kp_imx53_defconfig
@@ -40,7 +40,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_I2C_DEFAULT_BUS_NUMBER=0x1
diff --git a/configs/kp_imx6q_tpc_defconfig b/configs/kp_imx6q_tpc_defconfig
index abc7f9fa3fe..88063a37e32 100644
--- a/configs/kp_imx6q_tpc_defconfig
+++ b/configs/kp_imx6q_tpc_defconfig
@@ -48,7 +48,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rate
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/kylin-rk3036_defconfig b/configs/kylin-rk3036_defconfig
index 23cca4e3b28..525697842ce 100644
--- a/configs/kylin-rk3036_defconfig
+++ b/configs/kylin-rk3036_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_TIME=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/lckfb-tspi-rk3566_defconfig b/configs/lckfb-tspi-rk3566_defconfig
index 07eef047d6a..b5479fd90e1 100644
--- a/configs/lckfb-tspi-rk3566_defconfig
+++ b/configs/lckfb-tspi-rk3566_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index 2527bb8a10f..df2e17809aa 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/legoev3_defconfig b/configs/legoev3_defconfig
index 60b7a84205c..ff4d78a6d47 100644
--- a/configs/legoev3_defconfig
+++ b/configs/legoev3_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_DIAG=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index dab54d910e3..8fbe4c45fd6 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_DEVRES=y
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 17841630e2b..e3a1e084f75 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index 221f5d52b49..319b416fd61 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index d27886f3ec1..d9a4b68e798 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
diff --git a/configs/linkit-smart-7688_defconfig b/configs/linkit-smart-7688_defconfig
index d70af3f8b33..1602ff5b73a 100644
--- a/configs/linkit-smart-7688_defconfig
+++ b/configs/linkit-smart-7688_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/liteboard_defconfig b/configs/liteboard_defconfig
index c0fba8194ee..ed1b4441538 100644
--- a/configs/liteboard_defconfig
+++ b/configs/liteboard_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ls1012a2g5rdb_tfa_defconfig b/configs/ls1012a2g5rdb_tfa_defconfig
index 25927901797..32d95162e9b 100644
--- a/configs/ls1012a2g5rdb_tfa_defconfig
+++ b/configs/ls1012a2g5rdb_tfa_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SATA=y
 CONFIG_SCSI_AHCI=y
diff --git a/configs/ls1012afrdm_tfa_defconfig b/configs/ls1012afrdm_tfa_defconfig
index 7fdcc88fc1d..a0081d9f055 100644
--- a/configs/ls1012afrdm_tfa_defconfig
+++ b/configs/ls1012afrdm_tfa_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MPC8XXX_GPIO=y
 CONFIG_DM_I2C=y
diff --git a/configs/ls1012afrwy_tfa_defconfig b/configs/ls1012afrwy_tfa_defconfig
index ca691aee737..70f051f76e8 100644
--- a/configs/ls1012afrwy_tfa_defconfig
+++ b/configs/ls1012afrwy_tfa_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SATA=y
 CONFIG_SATA_CEVA=y
diff --git a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
index 38112b4ee08..ff7ebbc8d9c 100644
--- a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MPC8XXX_GPIO=y
 CONFIG_DM_I2C=y
diff --git a/configs/ls1012aqds_tfa_defconfig b/configs/ls1012aqds_tfa_defconfig
index 7b7b7c2becd..e7f7031f42d 100644
--- a/configs/ls1012aqds_tfa_defconfig
+++ b/configs/ls1012aqds_tfa_defconfig
@@ -56,7 +56,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=0
 CONFIG_ENV_SPI_MAX_HZ=1000000
 CONFIG_ENV_SPI_MODE=0x03
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SATA=y
 CONFIG_SCSI_AHCI=y
diff --git a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
index 15458f8bafb..abc1f5ab726 100644
--- a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SATA=y
 CONFIG_SATA_CEVA=y
diff --git a/configs/ls1012ardb_tfa_defconfig b/configs/ls1012ardb_tfa_defconfig
index d77cbe9c6bf..428fc58e2f3 100644
--- a/configs/ls1012ardb_tfa_defconfig
+++ b/configs/ls1012ardb_tfa_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SATA=y
 CONFIG_SATA_CEVA=y
diff --git a/configs/ls1021aiot_qspi_defconfig b/configs/ls1021aiot_qspi_defconfig
index 12aa937f94b..e086f36d6ea 100644
--- a/configs/ls1021aiot_qspi_defconfig
+++ b/configs/ls1021aiot_qspi_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eTSEC2"
 CONFIG_SATA=y
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index 9993bfc4c9c..ea5bb34cfbe 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -73,7 +73,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eTSEC2"
 CONFIG_SATA=y
diff --git a/configs/ls1021aqds_nand_defconfig b/configs/ls1021aqds_nand_defconfig
index 51d5888c2a7..e4adb8eeb1e 100644
--- a/configs/ls1021aqds_nand_defconfig
+++ b/configs/ls1021aqds_nand_defconfig
@@ -89,7 +89,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eTSEC1"
 CONFIG_SATA=y
diff --git a/configs/ls1021aqds_qspi_defconfig b/configs/ls1021aqds_qspi_defconfig
index a874cd8e917..9f26abb123a 100644
--- a/configs/ls1021aqds_qspi_defconfig
+++ b/configs/ls1021aqds_qspi_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eTSEC1"
 CONFIG_SATA=y
diff --git a/configs/ls1021aqds_sdcard_ifc_defconfig b/configs/ls1021aqds_sdcard_ifc_defconfig
index d14b544dd23..10b69284d01 100644
--- a/configs/ls1021aqds_sdcard_ifc_defconfig
+++ b/configs/ls1021aqds_sdcard_ifc_defconfig
@@ -89,7 +89,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eTSEC1"
 CONFIG_SATA=y
diff --git a/configs/ls1021aqds_sdcard_qspi_defconfig b/configs/ls1021aqds_sdcard_qspi_defconfig
index 2ab3cf2d008..30d6c54e4ce 100644
--- a/configs/ls1021aqds_sdcard_qspi_defconfig
+++ b/configs/ls1021aqds_sdcard_qspi_defconfig
@@ -86,7 +86,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eTSEC1"
 CONFIG_SATA=y
diff --git a/configs/ls1021atsn_qspi_defconfig b/configs/ls1021atsn_qspi_defconfig
index 99c2af79289..bc499a51630 100644
--- a/configs/ls1021atsn_qspi_defconfig
+++ b/configs/ls1021atsn_qspi_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_FS_UUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_FSL_CAAM=y
 CONFIG_DM_I2C=y
diff --git a/configs/ls1021atsn_sdcard_defconfig b/configs/ls1021atsn_sdcard_defconfig
index 6e95bd6ba6d..6bb5c1628d7 100644
--- a/configs/ls1021atsn_sdcard_defconfig
+++ b/configs/ls1021atsn_sdcard_defconfig
@@ -71,7 +71,7 @@ CONFIG_CMD_FS_UUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_FSL_CAAM=y
 CONFIG_DM_I2C=y
diff --git a/configs/ls1021atwr_qspi_defconfig b/configs/ls1021atwr_qspi_defconfig
index 935079cf338..ddda1a1d896 100644
--- a/configs/ls1021atwr_qspi_defconfig
+++ b/configs/ls1021atwr_qspi_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_USB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d10000"
 CONFIG_SATA=y
diff --git a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
index 2a1a704c270..6c12c35ab96 100644
--- a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
@@ -81,7 +81,7 @@ CONFIG_CMD_USB=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d10000"
 CONFIG_SPL_DM=y
diff --git a/configs/ls1021atwr_sdcard_ifc_defconfig b/configs/ls1021atwr_sdcard_ifc_defconfig
index 194e78ad266..3f0d277703d 100644
--- a/configs/ls1021atwr_sdcard_ifc_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_defconfig
@@ -82,7 +82,7 @@ CONFIG_CMD_USB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d10000"
 CONFIG_SATA=y
diff --git a/configs/ls1021atwr_sdcard_qspi_defconfig b/configs/ls1021atwr_sdcard_qspi_defconfig
index df969dbe485..897f9b6408d 100644
--- a/configs/ls1021atwr_sdcard_qspi_defconfig
+++ b/configs/ls1021atwr_sdcard_qspi_defconfig
@@ -82,7 +82,7 @@ CONFIG_CMD_USB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="ethernet@2d10000"
 CONFIG_SATA=y
diff --git a/configs/ls1043aqds_tfa_defconfig b/configs/ls1043aqds_tfa_defconfig
index 4be027c1ac5..1537f8aab91 100644
--- a/configs/ls1043aqds_tfa_defconfig
+++ b/configs/ls1043aqds_tfa_defconfig
@@ -66,7 +66,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=0
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SATA=y
 CONFIG_SATA_CEVA=y
 CONFIG_FSL_CAAM=y
diff --git a/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig b/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
index b297af3f669..ce501dd1404 100644
--- a/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=1550000.spi:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FM1@DTSEC3"
 CONFIG_SATA=y
diff --git a/configs/ls1046afrwy_tfa_defconfig b/configs/ls1046afrwy_tfa_defconfig
index 0e290ce55ee..b32adab0bad 100644
--- a/configs/ls1046afrwy_tfa_defconfig
+++ b/configs/ls1046afrwy_tfa_defconfig
@@ -46,7 +46,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FM1@DTSEC3"
 CONFIG_SATA=y
diff --git a/configs/ls1046aqds_tfa_defconfig b/configs/ls1046aqds_tfa_defconfig
index c0529fd848b..7b4d4ff92c7 100644
--- a/configs/ls1046aqds_tfa_defconfig
+++ b/configs/ls1046aqds_tfa_defconfig
@@ -67,7 +67,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=0
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SATA=y
 CONFIG_SATA_CEVA=y
 CONFIG_FSL_CAAM=y
diff --git a/configs/ls1046ardb_tfa_defconfig b/configs/ls1046ardb_tfa_defconfig
index a8f20f9b87b..d0d612bd395 100644
--- a/configs/ls1046ardb_tfa_defconfig
+++ b/configs/ls1046ardb_tfa_defconfig
@@ -51,7 +51,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FM1@DTSEC3"
 CONFIG_SATA=y
diff --git a/configs/ls1088aqds_tfa_defconfig b/configs/ls1088aqds_tfa_defconfig
index df86bf982ee..dafbe9b3b2b 100644
--- a/configs/ls1088aqds_tfa_defconfig
+++ b/configs/ls1088aqds_tfa_defconfig
@@ -61,7 +61,7 @@ CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="DPMAC1@xgmii"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ls1088ardb_tfa_defconfig b/configs/ls1088ardb_tfa_defconfig
index 8d640f6594b..46390a05adb 100644
--- a/configs/ls1088ardb_tfa_defconfig
+++ b/configs/ls1088ardb_tfa_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="DPMAC1@xgmii"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index f028eec4589..77f5a7ac708 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="DPMAC1@xgmii"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ls2080aqds_qspi_defconfig b/configs/ls2080aqds_qspi_defconfig
index ea115f52432..d07ca3217a2 100644
--- a/configs/ls2080aqds_qspi_defconfig
+++ b/configs/ls2080aqds_qspi_defconfig
@@ -48,7 +48,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="DPMAC1@xgmii"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_defconfig
index d04385f36cd..8c623d6a8e5 100644
--- a/configs/ls2080ardb_nand_defconfig
+++ b/configs/ls2080ardb_nand_defconfig
@@ -72,7 +72,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="DPMAC1@xgmii"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_defconfig
index 8c86b8b11eb..51475f2733f 100644
--- a/configs/ls2088aqds_tfa_defconfig
+++ b/configs/ls2088aqds_tfa_defconfig
@@ -55,7 +55,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="DPMAC1@xgmii"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/lschlv2_defconfig b/configs/lschlv2_defconfig
index 18de0ad7ad7..3a53d49ba83 100644
--- a/configs/lschlv2_defconfig
+++ b/configs/lschlv2_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/lsxhl_defconfig b/configs/lsxhl_defconfig
index 018d489dbef..83a0a6f5415 100644
--- a/configs/lsxhl_defconfig
+++ b/configs/lsxhl_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/lxr2_defconfig b/configs/lxr2_defconfig
index a54f4ecbbef..f2afed1c4ba 100644
--- a/configs/lxr2_defconfig
+++ b/configs/lxr2_defconfig
@@ -72,7 +72,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
index a3333c2280c..ac687b10d6e 100644
--- a/configs/m53menlo_defconfig
+++ b/configs/m53menlo_defconfig
@@ -71,7 +71,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/marsboard_defconfig b/configs/marsboard_defconfig
index b90d294ec7d..983e3d2425f 100644
--- a/configs/marsboard_defconfig
+++ b/configs/marsboard_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_I2C=y
diff --git a/configs/maxbcm_defconfig b/configs/maxbcm_defconfig
index 903f8a16d15..663e09c2415 100644
--- a/configs/maxbcm_defconfig
+++ b/configs/maxbcm_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_TIME=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_SPL_OF_TRANSLATE=y
diff --git a/configs/medcom-wide_defconfig b/configs/medcom-wide_defconfig
index d99addadf86..89fac8daaa1 100644
--- a/configs/medcom-wide_defconfig
+++ b/configs/medcom-wide_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/meerkat96_defconfig b/configs/meerkat96_defconfig
index 72beb072a10..a51158b03e5 100644
--- a/configs/meerkat96_defconfig
+++ b/configs/meerkat96_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_MMC_BROKEN_CD=y
diff --git a/configs/meesc_dataflash_defconfig b/configs/meesc_dataflash_defconfig
index 5a040cdc8fa..f6b5c01e6e0 100644
--- a/configs/meesc_dataflash_defconfig
+++ b/configs/meesc_dataflash_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_PING=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/meesc_defconfig b/configs/meesc_defconfig
index 1ce98bd5195..21a3b122acf 100644
--- a/configs/meesc_defconfig
+++ b/configs/meesc_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/microchip_mpfs_icicle_defconfig b/configs/microchip_mpfs_icicle_defconfig
index f8acaa98672..bb110225488 100644
--- a/configs/microchip_mpfs_icicle_defconfig
+++ b/configs/microchip_mpfs_icicle_defconfig
@@ -19,7 +19,7 @@ CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_OF_UPSTREAM=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_DM_MTD=y
 CONFIG_SYSRESET=y
diff --git a/configs/minnowmax_defconfig b/configs/minnowmax_defconfig
index 1eddb58efaf..ecddf388841 100644
--- a/configs/minnowmax_defconfig
+++ b/configs/minnowmax_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index c09a119f862..a4d24c11fe8 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -44,7 +44,7 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index f0a366a6e2d..b983128e1de 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -67,7 +67,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_TPL_OF_PLATDATA=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_TPL_DM=y
 CONFIG_REGMAP=y
diff --git a/configs/mocha_defconfig b/configs/mocha_defconfig
index ffaab6b6753..8d352e49551 100644
--- a/configs/mocha_defconfig
+++ b/configs/mocha_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/mot_defconfig b/configs/mot_defconfig
index 40b4feeeb90..8f0a52d719f 100644
--- a/configs/mot_defconfig
+++ b/configs/mot_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index 9b0c529b3b2..d3c0895ff2d 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -66,7 +66,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/configs/mscc_jr2_defconfig b/configs/mscc_jr2_defconfig
index dc509426162..2cef93802f8 100644
--- a/configs/mscc_jr2_defconfig
+++ b/configs/mscc_jr2_defconfig
@@ -53,7 +53,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
 CONFIG_MSCC_SGPIO=y
diff --git a/configs/mscc_luton_defconfig b/configs/mscc_luton_defconfig
index c4fe30c5255..1fcda3f1681 100644
--- a/configs/mscc_luton_defconfig
+++ b/configs/mscc_luton_defconfig
@@ -56,7 +56,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
 CONFIG_MSCC_SGPIO=y
diff --git a/configs/mscc_ocelot_defconfig b/configs/mscc_ocelot_defconfig
index 9c978201ee1..23d138d03b9 100644
--- a/configs/mscc_ocelot_defconfig
+++ b/configs/mscc_ocelot_defconfig
@@ -55,7 +55,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
 CONFIG_MSCC_SGPIO=y
diff --git a/configs/mscc_serval_defconfig b/configs/mscc_serval_defconfig
index c6835153066..74daabed3f4 100644
--- a/configs/mscc_serval_defconfig
+++ b/configs/mscc_serval_defconfig
@@ -50,7 +50,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
 CONFIG_MSCC_SGPIO=y
diff --git a/configs/mscc_servalt_defconfig b/configs/mscc_servalt_defconfig
index 0979143e4a3..755296900d5 100644
--- a/configs/mscc_servalt_defconfig
+++ b/configs/mscc_servalt_defconfig
@@ -48,7 +48,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
 CONFIG_MSCC_SGPIO=y
diff --git a/configs/mt7620_mt7530_rfb_defconfig b/configs/mt7620_mt7530_rfb_defconfig
index 06f37f007c2..07158e7ba9c 100644
--- a/configs/mt7620_mt7530_rfb_defconfig
+++ b/configs/mt7620_mt7530_rfb_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt-parent interrupts resets reset-names"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 # CONFIG_SIMPLE_BUS is not set
diff --git a/configs/mt7620_rfb_defconfig b/configs/mt7620_rfb_defconfig
index ffe9cc8a674..62897c5545a 100644
--- a/configs/mt7620_rfb_defconfig
+++ b/configs/mt7620_rfb_defconfig
@@ -49,7 +49,7 @@ CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt-parent interrupts resets reset-names"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 # CONFIG_SIMPLE_BUS is not set
diff --git a/configs/mt7621_nand_rfb_defconfig b/configs/mt7621_nand_rfb_defconfig
index 350ce0651e8..d7a8f31a0fa 100644
--- a/configs/mt7621_nand_rfb_defconfig
+++ b/configs/mt7621_nand_rfb_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_PARTITION_TYPE_GUID=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/mt7621_rfb_defconfig b/configs/mt7621_rfb_defconfig
index c44ecb19241..668d1583a9f 100644
--- a/configs/mt7621_rfb_defconfig
+++ b/configs/mt7621_rfb_defconfig
@@ -53,7 +53,7 @@ CONFIG_DOS_PARTITION=y
 CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_PARTITION_TYPE_GUID=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/mt7623a_unielec_u7623_02_defconfig b/configs/mt7623a_unielec_u7623_02_defconfig
index cf89f43297d..dc94f8b3b93 100644
--- a/configs/mt7623a_unielec_u7623_02_defconfig
+++ b/configs/mt7623a_unielec_u7623_02_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_READ=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_IPADDR=y
 CONFIG_IPADDR="192.168.1.1"
 CONFIG_USE_SERVERIP=y
diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
index 42da25ee4ca..404380558f2 100644
--- a/configs/mt7623n_bpir2_defconfig
+++ b/configs/mt7623n_bpir2_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_READ=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_IPADDR=y
 CONFIG_IPADDR="192.168.1.1"
 CONFIG_USE_SERVERIP=y
diff --git a/configs/mt7628_rfb_defconfig b/configs/mt7628_rfb_defconfig
index 0ca8cf65352..1f45ed894ea 100644
--- a/configs/mt7628_rfb_defconfig
+++ b/configs/mt7628_rfb_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_SPI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 # CONFIG_INPUT is not set
 CONFIG_SPI_FLASH_EON=y
diff --git a/configs/mt7629_rfb_defconfig b/configs/mt7629_rfb_defconfig
index f9d558819b7..9db733f6213 100644
--- a/configs/mt7629_rfb_defconfig
+++ b/configs/mt7629_rfb_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_LOG=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-parents"
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_IPADDR=y
 CONFIG_IPADDR="192.168.1.1"
 CONFIG_USE_SERVERIP=y
diff --git a/configs/mt8516_pumpkin_defconfig b/configs/mt8516_pumpkin_defconfig
index a968e83dd54..756d974278a 100644
--- a/configs/mt8516_pumpkin_defconfig
+++ b/configs/mt8516_pumpkin_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_CLK=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/mvebu_crb_cn9130_defconfig b/configs/mvebu_crb_cn9130_defconfig
index e8984b663b5..75b7f95be77 100644
--- a/configs/mvebu_crb_cn9130_defconfig
+++ b/configs/mvebu_crb_cn9130_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
diff --git a/configs/mvebu_db-88f3720_defconfig b/configs/mvebu_db-88f3720_defconfig
index e5de34c85fc..f0e9ae9f674 100644
--- a/configs/mvebu_db-88f3720_defconfig
+++ b/configs/mvebu_db-88f3720_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_AHCI_GENERIC=y
diff --git a/configs/mvebu_db_armada8k_defconfig b/configs/mvebu_db_armada8k_defconfig
index f9b03a7e77a..9e68a656c2e 100644
--- a/configs/mvebu_db_armada8k_defconfig
+++ b/configs/mvebu_db_armada8k_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_AHCI_GENERIC=y
diff --git a/configs/mvebu_db_cn9130_defconfig b/configs/mvebu_db_cn9130_defconfig
index 6dd6be788d3..000e5d3f3eb 100644
--- a/configs/mvebu_db_cn9130_defconfig
+++ b/configs/mvebu_db_cn9130_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_espressobin-88f3720_defconfig
index e9ee88594e9..94fbcf4f2d9 100644
--- a/configs/mvebu_espressobin-88f3720_defconfig
+++ b/configs/mvebu_espressobin-88f3720_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_FS_UUID=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
index fb8efbdf0b9..9db3b15a8c8 100644
--- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
+++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
@@ -48,7 +48,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/mvebu_mcbin-88f8040_defconfig b/configs/mvebu_mcbin-88f8040_defconfig
index 90d341e0a4c..6bc127d1abd 100644
--- a/configs/mvebu_mcbin-88f8040_defconfig
+++ b/configs/mvebu_mcbin-88f8040_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/mvebu_puzzle-m801-88f8040_defconfig b/configs/mvebu_puzzle-m801-88f8040_defconfig
index 21ab2177058..72c1635592a 100644
--- a/configs/mvebu_puzzle-m801-88f8040_defconfig
+++ b/configs/mvebu_puzzle-m801-88f8040_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/mx23_olinuxino_defconfig b/configs/mx23_olinuxino_defconfig
index 6bb3cedde12..c467a7fbe1e 100644
--- a/configs/mx23_olinuxino_defconfig
+++ b/configs/mx23_olinuxino_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/mx23evk_defconfig b/configs/mx23evk_defconfig
index 02cbc4be481..f303322856f 100644
--- a/configs/mx23evk_defconfig
+++ b/configs/mx23evk_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
index fdab7ef73e5..76dde53f2a5 100644
--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/mx51evk_defconfig b/configs/mx51evk_defconfig
index d4457859f12..bcbef81d1d4 100644
--- a/configs/mx51evk_defconfig
+++ b/configs/mx51evk_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC0"
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/mx53cx9020_defconfig b/configs/mx53cx9020_defconfig
index 614cec14102..2161fd82424 100644
--- a/configs/mx53cx9020_defconfig
+++ b/configs/mx53cx9020_defconfig
@@ -20,7 +20,7 @@ CONFIG_CMD_USB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_FPGA_ALTERA=y
 CONFIG_FPGA_CYCLON2=y
diff --git a/configs/mx53loco_defconfig b/configs/mx53loco_defconfig
index fa7b04383e0..1f7da84fbea 100644
--- a/configs/mx53loco_defconfig
+++ b/configs/mx53loco_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC0"
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/mx53ppd_defconfig b/configs/mx53ppd_defconfig
index 4ec8516015f..e2a33ff0ab1 100644
--- a/configs/mx53ppd_defconfig
+++ b/configs/mx53ppd_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
index 14c1386e11f..6a7c8d414e1 100644
--- a/configs/mx6cuboxi_defconfig
+++ b/configs/mx6cuboxi_defconfig
@@ -49,7 +49,7 @@ CONFIG_OF_LIST="imx6dl-hummingboard2-emmc-som-v15 imx6q-hummingboard2-emmc-som-v
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
index cde7086064e..4011b8ef7ff 100644
--- a/configs/mx6memcal_defconfig
+++ b/configs/mx6memcal_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_MEMTEST=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 # CONFIG_MMC is not set
diff --git a/configs/mx6qsabrelite_defconfig b/configs/mx6qsabrelite_defconfig
index 916992351ce..da07b38b4bc 100644
--- a/configs/mx6qsabrelite_defconfig
+++ b/configs/mx6qsabrelite_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_NETCONSOLE=y
diff --git a/configs/mx6sabreauto_defconfig b/configs/mx6sabreauto_defconfig
index 94b251cbdeb..66ae436b538 100644
--- a/configs/mx6sabreauto_defconfig
+++ b/configs/mx6sabreauto_defconfig
@@ -60,7 +60,7 @@ CONFIG_OF_LIST="imx6dl-sabreauto imx6q-sabreauto imx6qp-sabreauto"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index f041f1fd1a3..c29f38fa49e 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_LIST="imx6q-sabresd imx6qp-sabresd imx6dl-sabresd"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/mx6slevk_defconfig b/configs/mx6slevk_defconfig
index e927bb21658..18534a1b45a 100644
--- a/configs/mx6slevk_defconfig
+++ b/configs/mx6slevk_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/configs/mx6sllevk_defconfig b/configs/mx6sllevk_defconfig
index d529f9b8f12..f126c6e1e79 100644
--- a/configs/mx6sllevk_defconfig
+++ b/configs/mx6sllevk_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/configs/mx6sllevk_plugin_defconfig b/configs/mx6sllevk_plugin_defconfig
index 1e61b4214f4..134475d24d8 100644
--- a/configs/mx6sllevk_plugin_defconfig
+++ b/configs/mx6sllevk_plugin_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/configs/mx6sxsabreauto_defconfig b/configs/mx6sxsabreauto_defconfig
index 25b0b11342d..2643f13e26b 100644
--- a/configs/mx6sxsabreauto_defconfig
+++ b/configs/mx6sxsabreauto_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/mx6sxsabresd_defconfig b/configs/mx6sxsabresd_defconfig
index 68df8d4c741..0dc2e2595f1 100644
--- a/configs/mx6sxsabresd_defconfig
+++ b/configs/mx6sxsabresd_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/mx6ul_14x14_evk_defconfig b/configs/mx6ul_14x14_evk_defconfig
index 737a079eaa7..15709a1fcc7 100644
--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/mx6ul_9x9_evk_defconfig b/configs/mx6ul_9x9_evk_defconfig
index 964d00a4085..127a64f6af9 100644
--- a/configs/mx6ul_9x9_evk_defconfig
+++ b/configs/mx6ul_9x9_evk_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/mx6ull_14x14_evk_defconfig b/configs/mx6ull_14x14_evk_defconfig
index 369bc0f2e0a..17f46e06627 100644
--- a/configs/mx6ull_14x14_evk_defconfig
+++ b/configs/mx6ull_14x14_evk_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/mx6ull_14x14_evk_plugin_defconfig b/configs/mx6ull_14x14_evk_plugin_defconfig
index 97d4f9fc65f..2a9f85c1313 100644
--- a/configs/mx6ull_14x14_evk_plugin_defconfig
+++ b/configs/mx6ull_14x14_evk_plugin_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/mx6ulz_14x14_evk_defconfig b/configs/mx6ulz_14x14_evk_defconfig
index 1a49bc2cf01..a01bff6d8a8 100644
--- a/configs/mx6ulz_14x14_evk_defconfig
+++ b/configs/mx6ulz_14x14_evk_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NO_NET=y
diff --git a/configs/mx7dsabresd_defconfig b/configs/mx7dsabresd_defconfig
index 7811b17bf0f..a5a562af0c0 100644
--- a/configs/mx7dsabresd_defconfig
+++ b/configs/mx7dsabresd_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/mx7dsabresd_qspi_defconfig b/configs/mx7dsabresd_qspi_defconfig
index 2ee8bd36252..1b2bae5e2b1 100644
--- a/configs/mx7dsabresd_qspi_defconfig
+++ b/configs/mx7dsabresd_qspi_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/mx7ulp_evk_defconfig b/configs/mx7ulp_evk_defconfig
index 12f13112b63..98b99dd78e1 100644
--- a/configs/mx7ulp_evk_defconfig
+++ b/configs/mx7ulp_evk_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_IMX_RGPIO2P=y
diff --git a/configs/mx7ulp_evk_plugin_defconfig b/configs/mx7ulp_evk_plugin_defconfig
index 8e05d394335..af0efbd3ebf 100644
--- a/configs/mx7ulp_evk_plugin_defconfig
+++ b/configs/mx7ulp_evk_plugin_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_IMX_RGPIO2P=y
diff --git a/configs/myir_mys_6ulx_defconfig b/configs/myir_mys_6ulx_defconfig
index baee86ae170..742713851e7 100644
--- a/configs/myir_mys_6ulx_defconfig
+++ b/configs/myir_mys_6ulx_defconfig
@@ -40,7 +40,7 @@ CONFIG_MTDPARTS_DEFAULT="gpmi-nand:512k(spl),1m(uboot),1m(uboot-dup),-(ubi)"
 CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_I2C_GPIO=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/n2350_defconfig b/configs/n2350_defconfig
index b9ff95c5512..caa2d316765 100644
--- a/configs/n2350_defconfig
+++ b/configs/n2350_defconfig
@@ -59,7 +59,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=pxa3xx_nand-0:-(rootfs);spi1.0:1M(u-boot),64K@1M(u-boot-env),-(data)"
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index cf634bdce4c..677042f43a5 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index e081e0b064a..0f851b40977 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -45,7 +45,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_LIST="rockchip/rk3588-nanopc-t6 rockchip/rk3588-nanopc-t6-lts"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index 797a7f56723..5ab40d4a41c 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_MMC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index e4d6beeb493..3920b068e06 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -32,7 +32,7 @@ CONFIG_SPL_OF_CONTROL=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index 25761e3f9f8..1a9264dae15 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index f32d3e5ffd1..b8b9e3369de 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index 00822f7f655..efd4508ebc0 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index 271b12e4507..16d22a0837e 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -42,7 +42,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index c2d0b5a1f1d..4195979f8ea 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -42,7 +42,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/nanopi-r2s-plus-rk3328_defconfig b/configs/nanopi-r2s-plus-rk3328_defconfig
index c5315580c83..359ac2983b8 100644
--- a/configs/nanopi-r2s-plus-rk3328_defconfig
+++ b/configs/nanopi-r2s-plus-rk3328_defconfig
@@ -42,7 +42,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index 50e96b1d314..a0530117e7d 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -42,7 +42,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index 100b68bb49e..337097f2715 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/nas220_defconfig b/configs/nas220_defconfig
index faa8faf32f8..419ab097c11 100644
--- a/configs/nas220_defconfig
+++ b/configs/nas220_defconfig
@@ -44,7 +44,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_ATA_STRIDE=4
diff --git a/configs/netgear_cg3100d_ram_defconfig b/configs/netgear_cg3100d_ram_defconfig
index 377cc26f937..60a83d509bc 100644
--- a/configs/netgear_cg3100d_ram_defconfig
+++ b/configs/netgear_cg3100d_ram_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_MEMINFO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_SPI=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_BCM6345_GPIO=y
diff --git a/configs/netgear_dgnd3700v2_ram_defconfig b/configs/netgear_dgnd3700v2_ram_defconfig
index e4211a8372e..92e8bbf7c06 100644
--- a/configs/netgear_dgnd3700v2_ram_defconfig
+++ b/configs/netgear_dgnd3700v2_ram_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=6
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/neu2-io-rv1126_defconfig b/configs/neu2-io-rv1126_defconfig
index e3d74933a82..da249f905bb 100644
--- a/configs/neu2-io-rv1126_defconfig
+++ b/configs/neu2-io-rv1126_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_MMC=y
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
diff --git a/configs/nitrogen6dl2g_defconfig b/configs/nitrogen6dl2g_defconfig
index a0d77725083..74525657b1e 100644
--- a/configs/nitrogen6dl2g_defconfig
+++ b/configs/nitrogen6dl2g_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_NETCONSOLE=y
diff --git a/configs/nitrogen6dl_defconfig b/configs/nitrogen6dl_defconfig
index 436ce289f1f..96e743a8057 100644
--- a/configs/nitrogen6dl_defconfig
+++ b/configs/nitrogen6dl_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_NETCONSOLE=y
diff --git a/configs/nitrogen6q2g_defconfig b/configs/nitrogen6q2g_defconfig
index 827e8830602..a3126140687 100644
--- a/configs/nitrogen6q2g_defconfig
+++ b/configs/nitrogen6q2g_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_NETCONSOLE=y
diff --git a/configs/nitrogen6q_defconfig b/configs/nitrogen6q_defconfig
index 62fc8d8f3b6..f9018f12aac 100644
--- a/configs/nitrogen6q_defconfig
+++ b/configs/nitrogen6q_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_NETCONSOLE=y
diff --git a/configs/nitrogen6s1g_defconfig b/configs/nitrogen6s1g_defconfig
index d16cf2ac30f..36c635102ee 100644
--- a/configs/nitrogen6s1g_defconfig
+++ b/configs/nitrogen6s1g_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_NETCONSOLE=y
diff --git a/configs/nitrogen6s_defconfig b/configs/nitrogen6s_defconfig
index bd3ae139362..f4c08d785b7 100644
--- a/configs/nitrogen6s_defconfig
+++ b/configs/nitrogen6s_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_NETCONSOLE=y
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index dbd04b16786..4fd29ef8564 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/nsa310s_defconfig b/configs/nsa310s_defconfig
index 9a42c391556..90a2fc03214 100644
--- a/configs/nsa310s_defconfig
+++ b/configs/nsa310s_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/nsim_700_defconfig b/configs/nsim_700_defconfig
index d50e85a93fa..71802fef030 100644
--- a/configs/nsim_700_defconfig
+++ b/configs/nsim_700_defconfig
@@ -22,7 +22,7 @@ CONFIG_SYS_PROMPT="nsim# "
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_NO_NET=y
diff --git a/configs/nsim_700be_defconfig b/configs/nsim_700be_defconfig
index 4832195f6b4..7401c102d12 100644
--- a/configs/nsim_700be_defconfig
+++ b/configs/nsim_700be_defconfig
@@ -23,7 +23,7 @@ CONFIG_SYS_PROMPT="nsim# "
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_NO_NET=y
diff --git a/configs/nsim_hs38_defconfig b/configs/nsim_hs38_defconfig
index a652687156c..ed011d143cb 100644
--- a/configs/nsim_hs38_defconfig
+++ b/configs/nsim_hs38_defconfig
@@ -26,7 +26,7 @@ CONFIG_CMD_DM=y
 CONFIG_CMD_DHCP=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_DM_SERIAL=y
diff --git a/configs/nsim_hs38be_defconfig b/configs/nsim_hs38be_defconfig
index 67de123d16b..430ed914f37 100644
--- a/configs/nsim_hs38be_defconfig
+++ b/configs/nsim_hs38be_defconfig
@@ -24,7 +24,7 @@ CONFIG_SYS_PROMPT="nsim# "
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_NO_NET=y
diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index 71f364cf7c1..4294194ede6 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index bcaab46f8bc..d92be39cc24 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_I2C=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index cc3d7fc7484..28ac8aa59eb 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index 4bbda284ef1..97c44b1115b 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index 97fae4df75b..99e71cfebf2 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_SATA=y
diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
index 344c7bdd213..15f71711193 100644
--- a/configs/odroid-m1s-rk3566_defconfig
+++ b/configs/odroid-m1s-rk3566_defconfig
@@ -41,7 +41,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
index 21ccbd4c77a..504ddaee538 100644
--- a/configs/odroid-m2-rk3588s_defconfig
+++ b/configs/odroid-m2-rk3588s_defconfig
@@ -41,7 +41,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index a8cbaee3c96..673aca491f1 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
diff --git a/configs/odroid-n2l_defconfig b/configs/odroid-n2l_defconfig
index 773c8061db3..3ed3da2e230 100644
--- a/configs/odroid-n2l_defconfig
+++ b/configs/odroid-n2l_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
diff --git a/configs/odroid-xu3_defconfig b/configs/odroid-xu3_defconfig
index 6431f59568c..83bfa27c84e 100644
--- a/configs/odroid-xu3_defconfig
+++ b/configs/odroid-xu3_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_ADC=y
 CONFIG_ADC_EXYNOS=y
diff --git a/configs/odroid_defconfig b/configs/odroid_defconfig
index 93270e0129d..eec96b5a8a9 100644
--- a/configs/odroid_defconfig
+++ b/configs/odroid_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_DFU_MMC=y
 CONFIG_SET_DFU_ALT_INFO=y
diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index 42c6aadea97..a813d216787 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -49,7 +49,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM=y
diff --git a/configs/omapl138_lcdk_defconfig b/configs/omapl138_lcdk_defconfig
index c0949fc8750..02ec5a73229 100644
--- a/configs/omapl138_lcdk_defconfig
+++ b/configs/omapl138_lcdk_defconfig
@@ -66,7 +66,7 @@ CONFIG_CMD_DIAG=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="zImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/openrd_base_defconfig b/configs/openrd_base_defconfig
index 1ca0b45d93f..cfad5fb037b 100644
--- a/configs/openrd_base_defconfig
+++ b/configs/openrd_base_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/openrd_client_defconfig b/configs/openrd_client_defconfig
index e0cc2e65db3..e0a393e478c 100644
--- a/configs/openrd_client_defconfig
+++ b/configs/openrd_client_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/openrd_ultimate_defconfig b/configs/openrd_ultimate_defconfig
index a115691daad..23415ef12ee 100644
--- a/configs/openrd_ultimate_defconfig
+++ b/configs/openrd_ultimate_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
index 1c96fd01eb8..0379b4bbfe9 100644
--- a/configs/opos6uldev_defconfig
+++ b/configs/opos6uldev_defconfig
@@ -74,7 +74,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_VERSION_VARIABLE=y
 CONFIG_USE_ROOTPATH=y
diff --git a/configs/orangepi-3b-rk3566_defconfig b/configs/orangepi-3b-rk3566_defconfig
index 99a4a135f87..0213993bc2c 100644
--- a/configs/orangepi-3b-rk3566_defconfig
+++ b/configs/orangepi-3b-rk3566_defconfig
@@ -48,7 +48,7 @@ CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_LIST="rk3566-orangepi-3b rk3566-orangepi-3b-v1.1 rk3566-orangepi-3b-v2.1"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index 14b1af6fe51..7d562be867f 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -47,7 +47,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index f7456be1203..c27b718bd63 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -47,7 +47,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index 1ef429849f0..197565f9a80 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/origen_defconfig b/configs/origen_defconfig
index bb69c02529b..2ec232b1950 100644
--- a/configs/origen_defconfig
+++ b/configs/origen_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
diff --git a/configs/ouya_defconfig b/configs/ouya_defconfig
index d4ae9dbb57c..d8f3f389b5e 100644
--- a/configs/ouya_defconfig
+++ b/configs/ouya_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/p200_defconfig b/configs/p200_defconfig
index 36e76d890e5..53e4832e8bb 100644
--- a/configs/p200_defconfig
+++ b/configs/p200_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_MMC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
diff --git a/configs/p201_defconfig b/configs/p201_defconfig
index 5df5f01cbce..33d9be9c9f0 100644
--- a/configs/p201_defconfig
+++ b/configs/p201_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_MMC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
diff --git a/configs/p212_defconfig b/configs/p212_defconfig
index 1c45e3d3923..2b7d2e353c1 100644
--- a/configs/p212_defconfig
+++ b/configs/p212_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_MDIO=y
diff --git a/configs/p2371-0000_defconfig b/configs/p2371-0000_defconfig
index 93e1846a883..422e3530e64 100644
--- a/configs/p2371-0000_defconfig
+++ b/configs/p2371-0000_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/p2371-2180_defconfig b/configs/p2371-2180_defconfig
index 1c6fe537d61..1815b24a4b7 100644
--- a/configs/p2371-2180_defconfig
+++ b/configs/p2371-2180_defconfig
@@ -37,7 +37,7 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/p2571_defconfig b/configs/p2571_defconfig
index b2485423e1e..a8f80486791 100644
--- a/configs/p2571_defconfig
+++ b/configs/p2571_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/p2771-0000-000_defconfig b/configs/p2771-0000-000_defconfig
index a12586523e9..21937a0decf 100644
--- a/configs/p2771-0000-000_defconfig
+++ b/configs/p2771-0000-000_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_SPI=y
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA186_BPMP_I2C=y
diff --git a/configs/p2771-0000-500_defconfig b/configs/p2771-0000-500_defconfig
index 4553d707699..4cd32e60a99 100644
--- a/configs/p2771-0000-500_defconfig
+++ b/configs/p2771-0000-500_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_SPI=y
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA186_BPMP_I2C=y
diff --git a/configs/paz00_defconfig b/configs/paz00_defconfig
index af2cb712e06..22afce410e8 100644
--- a/configs/paz00_defconfig
+++ b/configs/paz00_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_DM_PMIC=y
diff --git a/configs/pcm051_rev3_defconfig b/configs/pcm051_rev3_defconfig
index a4e467fa05e..9d54f7b2d32 100644
--- a/configs/pcm051_rev3_defconfig
+++ b/configs/pcm051_rev3_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt-parent interrupt-controller interrupt-cells dma-names dmas "
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM=y
diff --git a/configs/pcm052_defconfig b/configs/pcm052_defconfig
index 550e45b52ee..7cfeee3cafe 100644
--- a/configs/pcm052_defconfig
+++ b/configs/pcm052_defconfig
@@ -43,7 +43,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VYBRID_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
diff --git a/configs/pcm058_defconfig b/configs/pcm058_defconfig
index 789c4c0f5ba..aae099d647e 100644
--- a/configs/pcm058_defconfig
+++ b/configs/pcm058_defconfig
@@ -58,7 +58,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_I2C=y
diff --git a/configs/pe2201_defconfig b/configs/pe2201_defconfig
index 72f6274ec41..020a2d49e60 100644
--- a/configs/pe2201_defconfig
+++ b/configs/pe2201_defconfig
@@ -26,7 +26,7 @@ CONFIG_CMD_BOOTMETH=y
 CONFIG_CMD_DM=y
 CONFIG_CMD_PCI=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
diff --git a/configs/peach-pi_defconfig b/configs/peach-pi_defconfig
index 247df4c9036..846ea20dfc4 100644
--- a/configs/peach-pi_defconfig
+++ b/configs/peach-pi_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=1
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SYS_I2C_S3C24X0=y
 CONFIG_I2C_MUX=y
diff --git a/configs/peach-pit_defconfig b/configs/peach-pit_defconfig
index df72be8047b..7eacdb7217f 100644
--- a/configs/peach-pit_defconfig
+++ b/configs/peach-pit_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=1
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SYS_I2C_S3C24X0=y
 CONFIG_I2C_MUX=y
diff --git a/configs/phycore-am335x-r2-regor_defconfig b/configs/phycore-am335x-r2-regor_defconfig
index b40fb6197c5..2443af4c4d7 100644
--- a/configs/phycore-am335x-r2-regor_defconfig
+++ b/configs/phycore-am335x-r2-regor_defconfig
@@ -58,7 +58,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/phycore-am335x-r2-wega_defconfig b/configs/phycore-am335x-r2-wega_defconfig
index aaf7ff8456a..ebde47bba80 100644
--- a/configs/phycore-am335x-r2-wega_defconfig
+++ b/configs/phycore-am335x-r2-wega_defconfig
@@ -58,7 +58,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 4558bf89c12..6509471614a 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -80,7 +80,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 9c88d53b8e4..24afa93b4bb 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -93,7 +93,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index db865109d8e..bedcb960e3a 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -51,7 +51,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/phycore_am62ax_r5_defconfig b/configs/phycore_am62ax_r5_defconfig
index 7bcfbe94850..e37e3eca651 100644
--- a/configs/phycore_am62ax_r5_defconfig
+++ b/configs/phycore_am62ax_r5_defconfig
@@ -64,7 +64,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
diff --git a/configs/phycore_am62x_r5_defconfig b/configs/phycore_am62x_r5_defconfig
index a5d494cf87a..546cee09575 100644
--- a/configs/phycore_am62x_r5_defconfig
+++ b/configs/phycore_am62x_r5_defconfig
@@ -71,7 +71,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index 2552479713f..8a8fe70e25c 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -82,7 +82,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/phycore_pcl063_defconfig b/configs/phycore_pcl063_defconfig
index 126caf52b08..d9e7285f544 100644
--- a/configs/phycore_pcl063_defconfig
+++ b/configs/phycore_pcl063_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_I2C_GPIO=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/phycore_pcl063_ull_defconfig b/configs/phycore_pcl063_ull_defconfig
index 547d59a7a52..729ac2be9e2 100644
--- a/configs/phycore_pcl063_ull_defconfig
+++ b/configs/phycore_pcl063_ull_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_I2C_GPIO=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
diff --git a/configs/pic32mzdask_defconfig b/configs/pic32mzdask_defconfig
index 348ea43fd75..266bfdd68d1 100644
--- a/configs/pic32mzdask_defconfig
+++ b/configs/pic32mzdask_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=500
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/picasso_defconfig b/configs/picasso_defconfig
index 6a83df919b5..e8a47f8cbf6 100644
--- a/configs/picasso_defconfig
+++ b/configs/picasso_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/pico-dwarf-imx6ul_defconfig b/configs/pico-dwarf-imx6ul_defconfig
index 8b90285980f..e1f6e6f91f2 100644
--- a/configs/pico-dwarf-imx6ul_defconfig
+++ b/configs/pico-dwarf-imx6ul_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
diff --git a/configs/pico-dwarf-imx7d_defconfig b/configs/pico-dwarf-imx7d_defconfig
index 9d5241a50d0..c1389ac4066 100644
--- a/configs/pico-dwarf-imx7d_defconfig
+++ b/configs/pico-dwarf-imx7d_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/pico-hobbit-imx6ul_defconfig b/configs/pico-hobbit-imx6ul_defconfig
index b945adfe734..137541d373a 100644
--- a/configs/pico-hobbit-imx6ul_defconfig
+++ b/configs/pico-hobbit-imx6ul_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
diff --git a/configs/pico-hobbit-imx7d_defconfig b/configs/pico-hobbit-imx7d_defconfig
index 690139c09ca..72e1a3bccc1 100644
--- a/configs/pico-hobbit-imx7d_defconfig
+++ b/configs/pico-hobbit-imx7d_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/pico-imx6_defconfig b/configs/pico-imx6_defconfig
index 4a9c5ac1a98..6f46d9bf8a1 100644
--- a/configs/pico-imx6_defconfig
+++ b/configs/pico-imx6_defconfig
@@ -55,7 +55,7 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/pico-imx6ul_defconfig b/configs/pico-imx6ul_defconfig
index c9a0ccd15f6..70b79622be1 100644
--- a/configs/pico-imx6ul_defconfig
+++ b/configs/pico-imx6ul_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
diff --git a/configs/pico-imx7d_bl33_defconfig b/configs/pico-imx7d_bl33_defconfig
index 1327523e289..b5485bf8d0b 100644
--- a/configs/pico-imx7d_bl33_defconfig
+++ b/configs/pico-imx7d_bl33_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
diff --git a/configs/pico-imx7d_defconfig b/configs/pico-imx7d_defconfig
index 6009b1c65c1..4707062053b 100644
--- a/configs/pico-imx7d_defconfig
+++ b/configs/pico-imx7d_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfig
index 02cfee2694f..0e14944eed7 100644
--- a/configs/pico-imx8mq_defconfig
+++ b/configs/pico-imx8mq_defconfig
@@ -70,7 +70,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
diff --git a/configs/pico-nymph-imx7d_defconfig b/configs/pico-nymph-imx7d_defconfig
index 9d5241a50d0..c1389ac4066 100644
--- a/configs/pico-nymph-imx7d_defconfig
+++ b/configs/pico-nymph-imx7d_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_defconfig
index daff2e36b00..40db7e23797 100644
--- a/configs/pico-pi-imx6ul_defconfig
+++ b/configs/pico-pi-imx6ul_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
diff --git a/configs/pico-pi-imx7d_defconfig b/configs/pico-pi-imx7d_defconfig
index 28c46abed78..26fccf90db7 100644
--- a/configs/pico-pi-imx7d_defconfig
+++ b/configs/pico-pi-imx7d_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index 17218b91f83..cbf95b4692f 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 88a32050125..81bc6d5400d 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
diff --git a/configs/plutux_defconfig b/configs/plutux_defconfig
index a5bc1f6b284..932a2d10027 100644
--- a/configs/plutux_defconfig
+++ b/configs/plutux_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/pm9g45_defconfig b/configs/pm9g45_defconfig
index 6d8ff63ba6c..3fd178e0520 100644
--- a/configs/pm9g45_defconfig
+++ b/configs/pm9g45_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/pogo_e02_defconfig b/configs/pogo_e02_defconfig
index 50c92925506..b826d78d594 100644
--- a/configs/pogo_e02_defconfig
+++ b/configs/pogo_e02_defconfig
@@ -40,7 +40,7 @@ CONFIG_ISO_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/pomelo_defconfig b/configs/pomelo_defconfig
index b963886d2ef..f7070543260 100644
--- a/configs/pomelo_defconfig
+++ b/configs/pomelo_defconfig
@@ -19,7 +19,7 @@ CONFIG_SYS_PBSIZE=280
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_PROMPT="pomelo#"
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_ECAM_GENERIC=y
 CONFIG_PCI_PHYTIUM=y
diff --git a/configs/poplar_defconfig b/configs/poplar_defconfig
index 24732ad4026..95888920111 100644
--- a/configs/poplar_defconfig
+++ b/configs/poplar_defconfig
@@ -20,7 +20,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x20000000
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index c76cfaa4247..95c1097bc93 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 95ed6eea953..4e12900d279 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -55,7 +55,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BUTTON=y
diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
index 36de779390d..f7f4eb4a7cf 100644
--- a/configs/px30-core-ctouch2-of10-px30_defconfig
+++ b/configs/px30-core-ctouch2-of10-px30_defconfig
@@ -49,7 +49,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
index f59fb8ccb36..c075d60fabd 100644
--- a/configs/px30-core-ctouch2-px30_defconfig
+++ b/configs/px30-core-ctouch2-px30_defconfig
@@ -49,7 +49,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
index 86e8e5597d2..81356419d46 100644
--- a/configs/px30-core-edimm2.2-px30_defconfig
+++ b/configs/px30-core-edimm2.2-px30_defconfig
@@ -49,7 +49,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/pxm2_defconfig b/configs/pxm2_defconfig
index fd2727e48d7..05adbcbb9f3 100644
--- a/configs/pxm2_defconfig
+++ b/configs/pxm2_defconfig
@@ -76,7 +76,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_USE_ROOTPATH=y
diff --git a/configs/qc750_defconfig b/configs/qc750_defconfig
index 9104cc084be..0088580513e 100644
--- a/configs/qc750_defconfig
+++ b/configs/qc750_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/qemu-ppce500_defconfig b/configs/qemu-ppce500_defconfig
index a444899db33..3e734e57c4a 100644
--- a/configs/qemu-ppce500_defconfig
+++ b/configs/qemu-ppce500_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_EXT2=y
 CONFIG_DOS_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_USE_ROOTPATH=y
diff --git a/configs/qemu-riscv32_defconfig b/configs/qemu-riscv32_defconfig
index b9cb780200e..cdffda26281 100644
--- a/configs/qemu-riscv32_defconfig
+++ b/configs/qemu-riscv32_defconfig
@@ -16,7 +16,7 @@ CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-riscv32_smode_defconfig b/configs/qemu-riscv32_smode_defconfig
index 8a09d80da11..3d065b6a9fb 100644
--- a/configs/qemu-riscv32_smode_defconfig
+++ b/configs/qemu-riscv32_smode_defconfig
@@ -17,7 +17,7 @@ CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-riscv32_spl_defconfig b/configs/qemu-riscv32_spl_defconfig
index c4b6d57020b..15f1a5d973d 100644
--- a/configs/qemu-riscv32_spl_defconfig
+++ b/configs/qemu-riscv32_spl_defconfig
@@ -20,7 +20,7 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_CMD_MII is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index 6b2fed4ad16..bf9a0b07400 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -16,7 +16,7 @@ CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 95f24ac3d55..6cc42817970 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -19,7 +19,7 @@ CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index d2b0aec8d3c..1c7cef056c4 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -19,7 +19,7 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_CMD_MII is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 2b88eb41a8f..c16fa5726b6 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -62,7 +62,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_INTERFACE="virtio"
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index c12913e94b3..a3210bc4a5c 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -45,7 +45,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_INTERFACE="virtio"
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index 569950ef11b..e2923233980 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 0a03e6d0d9d..4ab362f0d43 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_DFU=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index 96a5b81ed20..5ef81682caa 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_MMC=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_defconfig
index d46548256d7..3ebb1e73284 100644
--- a/configs/r8a77980_condor_defconfig
+++ b/configs/r8a77980_condor_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_MMC=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_defconfig
index 51e8d2bd368..1980191ceb6 100644
--- a/configs/r8a77980_v3hsk_defconfig
+++ b/configs/r8a77980_v3hsk_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_MMC=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_I2C_RCAR_I2C=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index e7f63110420..7864fc50773 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_USB=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index afabe788c45..b0da941e9ce 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_USB=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
diff --git a/configs/radxa-zero-3-rk3566_defconfig b/configs/radxa-zero-3-rk3566_defconfig
index 062eb5d240d..ea2e022eecb 100644
--- a/configs/radxa-zero-3-rk3566_defconfig
+++ b/configs/radxa-zero-3-rk3566_defconfig
@@ -38,7 +38,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_LIST="rockchip/rk3566-radxa-zero-3w rockchip/rk3566-radxa-zero-3e"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
index c1f5d405877..de2df05ed95 100644
--- a/configs/radxa-zero2_defconfig
+++ b/configs/radxa-zero2_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/radxa-zero_defconfig b/configs/radxa-zero_defconfig
index 82db167e071..e0651401eb6 100644
--- a/configs/radxa-zero_defconfig
+++ b/configs/radxa-zero_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 35904f19152..61183be948a 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -37,7 +37,7 @@ CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index 52f7d8701dd..dab1c9a7353 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -32,7 +32,7 @@ CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask iommus"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_RAM=y
diff --git a/configs/renesas_rcar4.config b/configs/renesas_rcar4.config
index 87d6a60e56e..085d02b51c3 100644
--- a/configs/renesas_rcar4.config
+++ b/configs/renesas_rcar4.config
@@ -12,6 +12,6 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_RENESAS_SDHI=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SYS_I2C_RCAR_I2C=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index 6ec151218eb..f9847de261d 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -41,7 +41,7 @@ CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index 5c651a18b0b..76b9be24c31 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -63,7 +63,7 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/riotboard_defconfig b/configs/riotboard_defconfig
index 24c6c59ac2b..b3f6498d528 100644
--- a/configs/riotboard_defconfig
+++ b/configs/riotboard_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index 25eaebb8be9..f0a1aaf8beb 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
index 9261e128da7..812dd9f3ccc 100644
--- a/configs/roc-cc-rk3328_defconfig
+++ b/configs/roc-cc-rk3328_defconfig
@@ -40,7 +40,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index 89348a4fc77..02d0dbd0132 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 881a1eb7041..cfcce408c8c 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/rock-3b-rk3568_defconfig b/configs/rock-3b-rk3568_defconfig
index 0f83eaae69d..2dac4b12614 100644
--- a/configs/rock-3b-rk3568_defconfig
+++ b/configs/rock-3b-rk3568_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/rock-3c-rk3566_defconfig b/configs/rock-3c-rk3566_defconfig
index c2d2049af01..1e25a3765dc 100644
--- a/configs/rock-3c-rk3566_defconfig
+++ b/configs/rock-3c-rk3566_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index fd92bf51f92..992f5bc2aa4 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 19e43195fac..6a8ea95d88b 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_DFU_MMC=y
diff --git a/configs/rock-5-itx-rk3588_defconfig b/configs/rock-5-itx-rk3588_defconfig
index 960b12c6ed5..ae553a60456 100644
--- a/configs/rock-5-itx-rk3588_defconfig
+++ b/configs/rock-5-itx-rk3588_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 9092a859f6d..219f42bc7d4 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_DFU_MMC=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 238f1353bda..8130e126b97 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_DFU_MMC=y
diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index df340b65933..67edcb35dc5 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -38,7 +38,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
index 9c31cd395c6..053a964c667 100644
--- a/configs/rock-pi-e-v3-rk3328_defconfig
+++ b/configs/rock-pi-e-v3-rk3328_defconfig
@@ -39,7 +39,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index 8a15c47edd7..a719e93d20b 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index 92c9f3d8f8a..0a88037cefd 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index eb0ca5c246c..1dedbb1e865 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
index e806ca8eb18..e3a21132da3 100644
--- a/configs/rock-s0-rk3308_defconfig
+++ b/configs/rock-s0-rk3308_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index e76a61c74cb..35f449ab567 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 676cd38c55d..d7cedbfc925 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -45,7 +45,7 @@ CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_TPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index f392e0709dc..298f4ee0df0 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/rock_defconfig b/configs/rock_defconfig
index b6cb87df4a8..71e504713c1 100644
--- a/configs/rock_defconfig
+++ b/configs/rock_defconfig
@@ -43,7 +43,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_SPL_SIMPLE_BUS is not set
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 25a600ecaaf..24b81f794c3 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SATA=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
diff --git a/configs/rpi_0_w_defconfig b/configs/rpi_0_w_defconfig
index 8d29d991606..18165be1c20 100644
--- a/configs/rpi_0_w_defconfig
+++ b/configs/rpi_0_w_defconfig
@@ -26,7 +26,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_BCM2835_GPIO=y
diff --git a/configs/rpi_2_defconfig b/configs/rpi_2_defconfig
index 1b8676e1d10..7b74e963530 100644
--- a/configs/rpi_2_defconfig
+++ b/configs/rpi_2_defconfig
@@ -26,7 +26,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_BCM2835_GPIO=y
diff --git a/configs/rpi_3_32b_defconfig b/configs/rpi_3_32b_defconfig
index abc10a79ada..4644ebd4cd5 100644
--- a/configs/rpi_3_32b_defconfig
+++ b/configs/rpi_3_32b_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_BCM2835_GPIO=y
diff --git a/configs/rpi_3_b_plus_defconfig b/configs/rpi_3_b_plus_defconfig
index b05a9193666..9de74c60208 100644
--- a/configs/rpi_3_b_plus_defconfig
+++ b/configs/rpi_3_b_plus_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_DFU_MMC=y
diff --git a/configs/rpi_3_defconfig b/configs/rpi_3_defconfig
index 267e4978e6e..c7dbcd2970e 100644
--- a/configs/rpi_3_defconfig
+++ b/configs/rpi_3_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_DFU_MMC=y
diff --git a/configs/rpi_4_32b_defconfig b/configs/rpi_4_32b_defconfig
index fc58ea1fa65..9dd87bf81aa 100644
--- a/configs/rpi_4_32b_defconfig
+++ b/configs/rpi_4_32b_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_DM_DMA=y
diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
index 993b79703b7..8362242b97f 100644
--- a/configs/rpi_4_defconfig
+++ b/configs/rpi_4_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_DM_DMA=y
diff --git a/configs/rpi_defconfig b/configs/rpi_defconfig
index 64e6df41d83..e7a1961549d 100644
--- a/configs/rpi_defconfig
+++ b/configs/rpi_defconfig
@@ -26,7 +26,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_BCM2835_GPIO=y
diff --git a/configs/rut_defconfig b/configs/rut_defconfig
index b2930e8044d..6084336fc21 100644
--- a/configs/rut_defconfig
+++ b/configs/rut_defconfig
@@ -77,7 +77,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_USE_ROOTPATH=y
diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index f6f461aa480..13456b17bdc 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
diff --git a/configs/s5p_goni_defconfig b/configs/s5p_goni_defconfig
index 084e19e1258..3c70c1ccfc4 100644
--- a/configs/s5p_goni_defconfig
+++ b/configs/s5p_goni_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
diff --git a/configs/s5pc210_universal_defconfig b/configs/s5pc210_universal_defconfig
index 190ec961b97..e66d29ce722 100644
--- a/configs/s5pc210_universal_defconfig
+++ b/configs/s5pc210_universal_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=samsung-onenand:128k(s-boot),896k(bootloader),256k(params),2816k(config),8m(csa),7m(kernel),1m(log),12m(modem),60m(qboot),-(UBI)"
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
diff --git a/configs/sagem_f@st1704_ram_defconfig b/configs/sagem_f@st1704_ram_defconfig
index be89b670c60..134bac5aa54 100644
--- a/configs/sagem_f@st1704_ram_defconfig
+++ b/configs/sagem_f@st1704_ram_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=6
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/sam9x60_curiosity_mmc1_defconfig b/configs/sam9x60_curiosity_mmc1_defconfig
index 114589ce9af..61f4db62c09 100644
--- a/configs/sam9x60_curiosity_mmc1_defconfig
+++ b/configs/sam9x60_curiosity_mmc1_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/sam9x60_curiosity_mmc_defconfig b/configs/sam9x60_curiosity_mmc_defconfig
index f4e663f1923..878c95fa82f 100644
--- a/configs/sam9x60_curiosity_mmc_defconfig
+++ b/configs/sam9x60_curiosity_mmc_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/sam9x60ek_mmc_defconfig b/configs/sam9x60ek_mmc_defconfig
index 1e542e2de5c..443772e6b6a 100644
--- a/configs/sam9x60ek_mmc_defconfig
+++ b/configs/sam9x60ek_mmc_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/sam9x60ek_nandflash_defconfig b/configs/sam9x60ek_nandflash_defconfig
index 2fab32b51d0..b2fe5e474da 100644
--- a/configs/sam9x60ek_nandflash_defconfig
+++ b/configs/sam9x60ek_nandflash_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/sam9x60ek_qspiflash_defconfig b/configs/sam9x60ek_qspiflash_defconfig
index 8696b08b51f..c96525bf283 100644
--- a/configs/sam9x60ek_qspiflash_defconfig
+++ b/configs/sam9x60ek_qspiflash_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/sama5d27_som1_ek_mmc1_defconfig b/configs/sama5d27_som1_ek_mmc1_defconfig
index 2e5a4acf27d..1618d0fd413 100644
--- a/configs/sama5d27_som1_ek_mmc1_defconfig
+++ b/configs/sama5d27_som1_ek_mmc1_defconfig
@@ -68,7 +68,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d27_som1_ek_mmc_defconfig b/configs/sama5d27_som1_ek_mmc_defconfig
index 11a536d714c..c7ec72dd1a9 100644
--- a/configs/sama5d27_som1_ek_mmc_defconfig
+++ b/configs/sama5d27_som1_ek_mmc_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d27_som1_ek_qspiflash_defconfig b/configs/sama5d27_som1_ek_qspiflash_defconfig
index 86cb5c287be..779c5fd017f 100644
--- a/configs/sama5d27_som1_ek_qspiflash_defconfig
+++ b/configs/sama5d27_som1_ek_qspiflash_defconfig
@@ -67,7 +67,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d27_wlsom1_ek_mmc_defconfig b/configs/sama5d27_wlsom1_ek_mmc_defconfig
index 014f0093eee..d7f2a0ad0cf 100644
--- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
+++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
@@ -72,7 +72,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
index efe23115f62..bb28296107f 100644
--- a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
+++ b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
@@ -76,7 +76,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d29_curiosity_mmc1_defconfig b/configs/sama5d29_curiosity_mmc1_defconfig
index c8976eec02d..4e56c670357 100644
--- a/configs/sama5d29_curiosity_mmc1_defconfig
+++ b/configs/sama5d29_curiosity_mmc1_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_CONTROL=y
 # CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA5D29"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/sama5d29_curiosity_mmc_defconfig b/configs/sama5d29_curiosity_mmc_defconfig
index 7fe1a5b7552..28d5626a2a5 100644
--- a/configs/sama5d29_curiosity_mmc_defconfig
+++ b/configs/sama5d29_curiosity_mmc_defconfig
@@ -67,7 +67,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nor0:256k(bootstrap)ro,1M(u-boot)ro,256k(env)r
 CONFIG_OF_CONTROL=y
 # CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA5D29"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/sama5d29_curiosity_qspiflash_defconfig b/configs/sama5d29_curiosity_qspiflash_defconfig
index fd3551131db..e19e39cd6dc 100644
--- a/configs/sama5d29_curiosity_qspiflash_defconfig
+++ b/configs/sama5d29_curiosity_qspiflash_defconfig
@@ -67,7 +67,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nor0:256k(bootstrap)ro,1M(u-boot)ro,256k(env)r
 CONFIG_OF_CONTROL=y
 # CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA5D29"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/sama5d2_icp_mmc_defconfig b/configs/sama5d2_icp_mmc_defconfig
index c27b181f19e..15d51565bc2 100644
--- a/configs/sama5d2_icp_mmc_defconfig
+++ b/configs/sama5d2_icp_mmc_defconfig
@@ -75,7 +75,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d2_icp_qspiflash_defconfig b/configs/sama5d2_icp_qspiflash_defconfig
index 463951a9d02..3cf4c9692b0 100644
--- a/configs/sama5d2_icp_qspiflash_defconfig
+++ b/configs/sama5d2_icp_qspiflash_defconfig
@@ -60,7 +60,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_UTMI=y
diff --git a/configs/sama5d2_ptc_ek_mmc_defconfig b/configs/sama5d2_ptc_ek_mmc_defconfig
index e62fd8c600c..7087637f3eb 100644
--- a/configs/sama5d2_ptc_ek_mmc_defconfig
+++ b/configs/sama5d2_ptc_ek_mmc_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_UTMI=y
diff --git a/configs/sama5d2_ptc_ek_nandflash_defconfig b/configs/sama5d2_ptc_ek_nandflash_defconfig
index 320be1be89f..7945e19bac3 100644
--- a/configs/sama5d2_ptc_ek_nandflash_defconfig
+++ b/configs/sama5d2_ptc_ek_nandflash_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_UTMI=y
diff --git a/configs/sama5d2_xplained_emmc_defconfig b/configs/sama5d2_xplained_emmc_defconfig
index 76187ea52ab..2315c5dc516 100644
--- a/configs/sama5d2_xplained_emmc_defconfig
+++ b/configs/sama5d2_xplained_emmc_defconfig
@@ -67,7 +67,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d2_xplained_mmc_defconfig b/configs/sama5d2_xplained_mmc_defconfig
index e752863f5e1..7c803cc03f3 100644
--- a/configs/sama5d2_xplained_mmc_defconfig
+++ b/configs/sama5d2_xplained_mmc_defconfig
@@ -69,7 +69,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d2_xplained_qspiflash_defconfig b/configs/sama5d2_xplained_qspiflash_defconfig
index 4b5a3c11a8e..449519ac227 100644
--- a/configs/sama5d2_xplained_qspiflash_defconfig
+++ b/configs/sama5d2_xplained_qspiflash_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d2_xplained_spiflash_defconfig b/configs/sama5d2_xplained_spiflash_defconfig
index 8941d8fb582..0eeeb51439c 100644
--- a/configs/sama5d2_xplained_spiflash_defconfig
+++ b/configs/sama5d2_xplained_spiflash_defconfig
@@ -73,7 +73,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d36ek_cmp_mmc_defconfig b/configs/sama5d36ek_cmp_mmc_defconfig
index 217632cbc30..7ecca597f03 100644
--- a/configs/sama5d36ek_cmp_mmc_defconfig
+++ b/configs/sama5d36ek_cmp_mmc_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sama5d36ek_cmp_nandflash_defconfig b/configs/sama5d36ek_cmp_nandflash_defconfig
index 91fcd73f01e..4478a2405c8 100644
--- a/configs/sama5d36ek_cmp_nandflash_defconfig
+++ b/configs/sama5d36ek_cmp_nandflash_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sama5d36ek_cmp_spiflash_defconfig b/configs/sama5d36ek_cmp_spiflash_defconfig
index 743959cf459..e4706413e76 100644
--- a/configs/sama5d36ek_cmp_spiflash_defconfig
+++ b/configs/sama5d36ek_cmp_spiflash_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sama5d3_xplained_mmc_defconfig b/configs/sama5d3_xplained_mmc_defconfig
index 984d8146992..74405df7189 100644
--- a/configs/sama5d3_xplained_mmc_defconfig
+++ b/configs/sama5d3_xplained_mmc_defconfig
@@ -70,7 +70,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d3_xplained_nandflash_defconfig b/configs/sama5d3_xplained_nandflash_defconfig
index 831fccc485e..a733e2cd9d7 100644
--- a/configs/sama5d3_xplained_nandflash_defconfig
+++ b/configs/sama5d3_xplained_nandflash_defconfig
@@ -70,7 +70,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d3xek_mmc_defconfig b/configs/sama5d3xek_mmc_defconfig
index 9d0472dea2a..a2b65e9ad12 100644
--- a/configs/sama5d3xek_mmc_defconfig
+++ b/configs/sama5d3xek_mmc_defconfig
@@ -69,7 +69,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/sama5d3xek_nandflash_defconfig b/configs/sama5d3xek_nandflash_defconfig
index 4eefe091c90..99280f3c480 100644
--- a/configs/sama5d3xek_nandflash_defconfig
+++ b/configs/sama5d3xek_nandflash_defconfig
@@ -68,7 +68,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/sama5d3xek_spiflash_defconfig b/configs/sama5d3xek_spiflash_defconfig
index cccdd8e970e..9dcfdd05606 100644
--- a/configs/sama5d3xek_spiflash_defconfig
+++ b/configs/sama5d3xek_spiflash_defconfig
@@ -70,7 +70,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/sama5d4_xplained_mmc_defconfig b/configs/sama5d4_xplained_mmc_defconfig
index c476a9c4230..2a35208fbbe 100644
--- a/configs/sama5d4_xplained_mmc_defconfig
+++ b/configs/sama5d4_xplained_mmc_defconfig
@@ -65,7 +65,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
diff --git a/configs/sama5d4_xplained_nandflash_defconfig b/configs/sama5d4_xplained_nandflash_defconfig
index 43a40d370ad..2066cbe4213 100644
--- a/configs/sama5d4_xplained_nandflash_defconfig
+++ b/configs/sama5d4_xplained_nandflash_defconfig
@@ -66,7 +66,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
diff --git a/configs/sama5d4_xplained_spiflash_defconfig b/configs/sama5d4_xplained_spiflash_defconfig
index 98ec4d75f83..1e60628cb8e 100644
--- a/configs/sama5d4_xplained_spiflash_defconfig
+++ b/configs/sama5d4_xplained_spiflash_defconfig
@@ -70,7 +70,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d4ek_mmc_defconfig b/configs/sama5d4ek_mmc_defconfig
index 6e6e601aab4..2339c47b3a6 100644
--- a/configs/sama5d4ek_mmc_defconfig
+++ b/configs/sama5d4ek_mmc_defconfig
@@ -64,7 +64,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_FAT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d4ek_nandflash_defconfig b/configs/sama5d4ek_nandflash_defconfig
index 268e04676a5..230d4015c2e 100644
--- a/configs/sama5d4ek_nandflash_defconfig
+++ b/configs/sama5d4ek_nandflash_defconfig
@@ -65,7 +65,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d4ek_spiflash_defconfig b/configs/sama5d4ek_spiflash_defconfig
index 60c11f38460..7eb40867b4f 100644
--- a/configs/sama5d4ek_spiflash_defconfig
+++ b/configs/sama5d4ek_spiflash_defconfig
@@ -67,7 +67,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dma-names dmas"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama7g54_curiosity_mmc_defconfig b/configs/sama7g54_curiosity_mmc_defconfig
index fec883e3c17..856310a95e0 100644
--- a/configs/sama7g54_curiosity_mmc_defconfig
+++ b/configs/sama7g54_curiosity_mmc_defconfig
@@ -71,7 +71,7 @@ CONFIG_OF_CONTROL=y
 # CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA7G54"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/sama7g54_curiosity_nandflash_defconfig b/configs/sama7g54_curiosity_nandflash_defconfig
index 7a4cdb0d2ab..451e40ce547 100644
--- a/configs/sama7g54_curiosity_nandflash_defconfig
+++ b/configs/sama7g54_curiosity_nandflash_defconfig
@@ -69,7 +69,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nand0:256k(bootstrap-nand)ro,1M(u-boot-nand)ro
 CONFIG_OF_CONTROL=y
 # CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA7G54"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/sama7g54_curiosity_qspiflash_defconfig b/configs/sama7g54_curiosity_qspiflash_defconfig
index adf5f558e2e..44db2dac32b 100644
--- a/configs/sama7g54_curiosity_qspiflash_defconfig
+++ b/configs/sama7g54_curiosity_qspiflash_defconfig
@@ -70,7 +70,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=nand0:256k(bootstrap-nand)ro,1M(u-boot-nand)ro
 CONFIG_OF_CONTROL=y
 # CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA7G54"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/sama7g5ek_mmc1_defconfig b/configs/sama7g5ek_mmc1_defconfig
index e91135433ed..59b4e081066 100644
--- a/configs/sama7g5ek_mmc1_defconfig
+++ b/configs/sama7g5ek_mmc1_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_CLK=y
diff --git a/configs/sama7g5ek_mmc_defconfig b/configs/sama7g5ek_mmc_defconfig
index 13896f01e49..e151abf0523 100644
--- a/configs/sama7g5ek_mmc_defconfig
+++ b/configs/sama7g5ek_mmc_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_CLK=y
diff --git a/configs/seaboard_defconfig b/configs/seaboard_defconfig
index 21375f233f0..5e04090ef2b 100644
--- a/configs/seaboard_defconfig
+++ b/configs/seaboard_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_TEGRA_KEYBOARD=y
diff --git a/configs/seeed_npi_imx6ull_defconfig b/configs/seeed_npi_imx6ull_defconfig
index 6211588fe1b..a2d38c84461 100644
--- a/configs/seeed_npi_imx6ull_defconfig
+++ b/configs/seeed_npi_imx6ull_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
 CONFIG_USE_NETMASK=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 6df4e9d2f0f..b9bedcc4baf 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_DFU_RAM=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 0b561516caf..770a487398f 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_DFU_RAM=y
diff --git a/configs/sfr_nb4-ser_ram_defconfig b/configs/sfr_nb4-ser_ram_defconfig
index 7125d495376..9cdfade9c4c 100644
--- a/configs/sfr_nb4-ser_ram_defconfig
+++ b/configs/sfr_nb4-ser_ram_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=6
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/sheep-rk3368_defconfig b/configs/sheep-rk3368_defconfig
index 52677a27bdc..bbaee0f147f 100644
--- a/configs/sheep-rk3368_defconfig
+++ b/configs/sheep-rk3368_defconfig
@@ -17,7 +17,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-sheep.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
diff --git a/configs/sifive_unleashed_defconfig b/configs/sifive_unleashed_defconfig
index b1c4d00c05e..01963a4e54e 100644
--- a/configs/sifive_unleashed_defconfig
+++ b/configs/sifive_unleashed_defconfig
@@ -37,7 +37,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_CLK=y
 CONFIG_DM_MTD=y
diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index f70e3db4441..acbea7fe1bb 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 CONFIG_ENV_SPI_BUS=1
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_SPL_CLK=y
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index c9a44247a86..acdd1ad5205 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_USB=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_I2C_RCAR_I2C=y
 CONFIG_SYS_I2C_RCAR_IIC=y
 CONFIG_MMC_IO_VOLTAGE=y
diff --git a/configs/slimbootloader_defconfig b/configs/slimbootloader_defconfig
index 8d24a8dc42c..5d86c8ebae1 100644
--- a/configs/slimbootloader_defconfig
+++ b/configs/slimbootloader_defconfig
@@ -19,7 +19,7 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/smartweb_defconfig b/configs/smartweb_defconfig
index cca9cb8f6e7..ad6230c6b04 100644
--- a/configs/smartweb_defconfig
+++ b/configs/smartweb_defconfig
@@ -72,7 +72,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/smdk5250_defconfig b/configs/smdk5250_defconfig
index bfc4efec598..a51c22d2339 100644
--- a/configs/smdk5250_defconfig
+++ b/configs/smdk5250_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=1
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_I2C_S3C24X0=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
diff --git a/configs/smdk5420_defconfig b/configs/smdk5420_defconfig
index cecbd410976..513ed66a471 100644
--- a/configs/smdk5420_defconfig
+++ b/configs/smdk5420_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=1
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_I2C_S3C24X0=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
diff --git a/configs/smdkv310_defconfig b/configs/smdkv310_defconfig
index b1c77c7f43d..85f2d91f375 100644
--- a/configs/smdkv310_defconfig
+++ b/configs/smdkv310_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
diff --git a/configs/smegw01_defconfig b/configs/smegw01_defconfig
index fe7cbc765b7..b3acec921df 100644
--- a/configs/smegw01_defconfig
+++ b/configs/smegw01_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
index 3874b875c82..3d0f555c63c 100644
--- a/configs/sniper_defconfig
+++ b/configs/sniper_defconfig
@@ -23,7 +23,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
diff --git a/configs/snow_defconfig b/configs/snow_defconfig
index adf6213f70b..faca8200035 100644
--- a/configs/snow_defconfig
+++ b/configs/snow_defconfig
@@ -57,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=1
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_I2C_CROS_EC_LDO=y
 CONFIG_SYS_I2C_S3C24X0=y
 CONFIG_I2C_MUX=y
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 4ac0a5d9b99..33a6221979a 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -70,7 +70,7 @@ CONFIG_OF_LIST=""
 CONFIG_ENV_IS_IN_UBI=y
 CONFIG_ENV_UBI_PART="root"
 CONFIG_ENV_UBI_VOLUME="env"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="kernel.itb"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index 7c6a3c8d081..76fdc0aa4a6 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_defconfig
index f3c142300f2..3c860f97ae9 100644
--- a/configs/socfpga_arria5_defconfig
+++ b/configs/socfpga_arria5_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_MMC=y
diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index 97e5fae0f53..fef4cb90516 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_MMC=y
diff --git a/configs/socfpga_dbm_soc1_defconfig b/configs/socfpga_dbm_soc1_defconfig
index 69b04979423..74ab8c700da 100644
--- a/configs/socfpga_dbm_soc1_defconfig
+++ b/configs/socfpga_dbm_soc1_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
index 7188c46d98e..32cdf6d3a6c 100644
--- a/configs/socfpga_de0_nano_soc_defconfig
+++ b/configs/socfpga_de0_nano_soc_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_nano_defconfig
index 102e781f5c1..4fabd63f2b4 100644
--- a/configs/socfpga_de10_nano_defconfig
+++ b/configs/socfpga_de10_nano_defconfig
@@ -45,7 +45,7 @@ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
index fe3eaad12a3..1c9ecbf2bc8 100644
--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -45,7 +45,7 @@ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_defconfig
index 19e4ab98d59..52ed0ff7ffa 100644
--- a/configs/socfpga_de1_soc_defconfig
+++ b/configs/socfpga_de1_soc_defconfig
@@ -45,7 +45,7 @@ CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
index 38286f71f84..45d3b2f0807 100644
--- a/configs/socfpga_is1_defconfig
+++ b/configs/socfpga_is1_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="zImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_defconfig
index f61a63d835a..bff0c41336f 100644
--- a/configs/socfpga_mcvevk_defconfig
+++ b/configs/socfpga_mcvevk_defconfig
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_defconfig
index 96ce2485a02..fed1dd83dc2 100644
--- a/configs/socfpga_sockit_defconfig
+++ b/configs/socfpga_sockit_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_MMC=y
diff --git a/configs/socfpga_socrates_defconfig b/configs/socfpga_socrates_defconfig
index d14dc86a742..a08c7c0d9e0 100644
--- a/configs/socfpga_socrates_defconfig
+++ b/configs/socfpga_socrates_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_MMC=y
diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
index 39126d38d2b..7744ff9a888 100644
--- a/configs/socfpga_sr1500_defconfig
+++ b/configs/socfpga_sr1500_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_BOOTCOUNT_LIMIT=y
diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
index 8381dca2649..ed26f2dffde 100644
--- a/configs/socfpga_stratix10_atf_defconfig
+++ b/configs/socfpga_stratix10_atf_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="kernel.itb"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 43e3efde2cd..90134d8f3f3 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -61,7 +61,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="Image"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index 031a0f25086..f3b6cb717b3 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="fitImage"
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/som-db5800-som-6867_defconfig b/configs/som-db5800-som-6867_defconfig
index 473b04a42fe..a223c20224a 100644
--- a/configs/som-db5800-som-6867_defconfig
+++ b/configs/som-db5800-som-6867_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/somlabs_visionsom_6ull_defconfig b/configs/somlabs_visionsom_6ull_defconfig
index 3730da52e00..d487a2e728e 100644
--- a/configs/somlabs_visionsom_6ull_defconfig
+++ b/configs/somlabs_visionsom_6ull_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost-rv1126_defconfig
index e94c5e79136..c3bd9101540 100644
--- a/configs/sonoff-ihost-rv1126_defconfig
+++ b/configs/sonoff-ihost-rv1126_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_MMC=y
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
diff --git a/configs/spring_defconfig b/configs/spring_defconfig
index d3b6656d631..ebe9b8fe119 100644
--- a/configs/spring_defconfig
+++ b/configs/spring_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=1
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_I2C_CROS_EC_LDO=y
 CONFIG_SYS_I2C_S3C24X0=y
 CONFIG_I2C_MUX=y
diff --git a/configs/star_defconfig b/configs/star_defconfig
index f0574b077ac..1ba3c00b063 100644
--- a/configs/star_defconfig
+++ b/configs/star_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e145ced8db8..0387dc08cdd 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -85,7 +85,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/stih410-b2260_defconfig b/configs/stih410-b2260_defconfig
index 582b5f38222..c0992f397f6 100644
--- a/configs/stih410-b2260_defconfig
+++ b/configs/stih410-b2260_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_REGMAP=y
diff --git a/configs/stm32746g-eval_defconfig b/configs/stm32746g-eval_defconfig
index 0a7036a5b47..bca3d871f5c 100644
--- a/configs/stm32746g-eval_defconfig
+++ b/configs/stm32746g-eval_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ARM_PL180_MMCI=y
diff --git a/configs/stm32746g-eval_spl_defconfig b/configs/stm32746g-eval_spl_defconfig
index 4706a72cb9c..137c91e6a8e 100644
--- a/configs/stm32746g-eval_spl_defconfig
+++ b/configs/stm32746g-eval_spl_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/stm32f429-evaluation_defconfig b/configs/stm32f429-evaluation_defconfig
index 5747187ac3c..a2ce8c80e20 100644
--- a/configs/stm32f429-evaluation_defconfig
+++ b/configs/stm32f429-evaluation_defconfig
@@ -24,7 +24,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_ARM_PL180_MMCI=y
 CONFIG_MTD=y
diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-discovery_defconfig
index 80e15c4cdb0..7a1fe576cc3 100644
--- a/configs/stm32f469-discovery_defconfig
+++ b/configs/stm32f469-discovery_defconfig
@@ -26,7 +26,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_ARM_PL180_MMCI=y
 CONFIG_MTD=y
diff --git a/configs/stm32f746-disco_defconfig b/configs/stm32f746-disco_defconfig
index 24bf6e6a086..00245dcb750 100644
--- a/configs/stm32f746-disco_defconfig
+++ b/configs/stm32f746-disco_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ARM_PL180_MMCI=y
diff --git a/configs/stm32f746-disco_spl_defconfig b/configs/stm32f746-disco_spl_defconfig
index f1761e50ad9..b849d8f3266 100644
--- a/configs/stm32f746-disco_spl_defconfig
+++ b/configs/stm32f746-disco_spl_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
index e539fce780b..af0a7dacbe2 100644
--- a/configs/stm32f769-disco_defconfig
+++ b/configs/stm32f769-disco_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ARM_PL180_MMCI=y
diff --git a/configs/stm32f769-disco_spl_defconfig b/configs/stm32f769-disco_spl_defconfig
index 93c6c904331..61bbca3ec10 100644
--- a/configs/stm32f769-disco_spl_defconfig
+++ b/configs/stm32f769-disco_spl_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
diff --git a/configs/stm32h743-disco_defconfig b/configs/stm32h743-disco_defconfig
index a674a202e23..38312e9a5f1 100644
--- a/configs/stm32h743-disco_defconfig
+++ b/configs/stm32h743-disco_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_STM32_SDMMC2=y
 # CONFIG_PINCTRL_FULL is not set
diff --git a/configs/stm32h743-eval_defconfig b/configs/stm32h743-eval_defconfig
index d63e7219f33..fcbf7177690 100644
--- a/configs/stm32h743-eval_defconfig
+++ b/configs/stm32h743-eval_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_STM32_SDMMC2=y
 # CONFIG_PINCTRL_FULL is not set
diff --git a/configs/stm32h750-art-pi_defconfig b/configs/stm32h750-art-pi_defconfig
index a92a57d54ea..8a7c45f74a4 100644
--- a/configs/stm32h750-art-pi_defconfig
+++ b/configs/stm32h750-art-pi_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_DM_DMA=y
 CONFIG_STM32_SDMMC2=y
diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
index a327d792579..2eab305cc5d 100644
--- a/configs/stm32mp13_defconfig
+++ b/configs/stm32mp13_defconfig
@@ -51,7 +51,7 @@ CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=-1
 CONFIG_ENV_MMC_USE_DT=y
 CONFIG_SYS_64BIT_LBA=y
diff --git a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
index ff7afa02789..cfbe5a4ae91 100644
--- a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended inter
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.1.1"
diff --git a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
index 0828e0cccb5..f6ca1700a5f 100644
--- a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended inter
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.1.1"
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
index da37b553367..16524245ce1 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended inter
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.1.1"
diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
index 90962431ce4..3348b3f0546 100644
--- a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
+++ b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
@@ -58,7 +58,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended inter
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.1.1"
diff --git a/configs/stm32mp15-odyssey_defconfig b/configs/stm32mp15-odyssey_defconfig
index 6c7cbc82c67..636a777f106 100644
--- a/configs/stm32mp15-odyssey_defconfig
+++ b/configs/stm32mp15-odyssey_defconfig
@@ -63,7 +63,7 @@ CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=-1
 CONFIG_ENV_MMC_USE_DT=y
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index 89735f5f5c6..856311e076d 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -92,7 +92,7 @@ CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=-1
 CONFIG_ENV_MMC_USE_DT=y
 # CONFIG_SPL_ENV_IS_NOWHERE is not set
diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index af5f30509a6..c99c5af3cd7 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -64,7 +64,7 @@ CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=-1
 CONFIG_ENV_MMC_USE_DT=y
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
index 56a76e226ff..6788e932224 100644
--- a/configs/stm32mp15_trusted_defconfig
+++ b/configs/stm32mp15_trusted_defconfig
@@ -65,7 +65,7 @@ CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
 CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=-1
 CONFIG_ENV_MMC_USE_DT=y
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/stm32mp_dhsom.config b/configs/stm32mp_dhsom.config
index 2e69a047ba9..777a02dfe15 100644
--- a/configs/stm32mp_dhsom.config
+++ b/configs/stm32mp_dhsom.config
@@ -84,7 +84,7 @@ CONFIG_SYS_I2C_STM32F7=y
 CONFIG_SYS_LOAD_ADDR=0xc2000000
 CONFIG_SYS_PROMPT="STM32MP> "
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
diff --git a/configs/stmark2_defconfig b/configs/stmark2_defconfig
index 79b21acd032..ae1fa34df2a 100644
--- a/configs/stmark2_defconfig
+++ b/configs/stmark2_defconfig
@@ -36,7 +36,7 @@ CONFIG_MTDIDS_DEFAULT="nor0=spi-flash.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:1m(u-boot),7m(kernel),-(rootfs)"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_CS=1
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="stmark2"
 CONFIG_NO_NET=y
diff --git a/configs/surface-rt_defconfig b/configs/surface-rt_defconfig
index da19b34e64a..71ee397d55a 100644
--- a/configs/surface-rt_defconfig
+++ b/configs/surface-rt_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/syzygy_hub_defconfig b/configs/syzygy_hub_defconfig
index bf11e898145..2fbc2268013 100644
--- a/configs/syzygy_hub_defconfig
+++ b/configs/syzygy_hub_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_FPGA_XILINX=y
diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
index dab30ce295e..793a7f6cfa6 100644
--- a/configs/taurus_defconfig
+++ b/configs/taurus_defconfig
@@ -82,7 +82,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/tb100_defconfig b/configs/tb100_defconfig
index 95cff26fe28..1449660cffe 100644
--- a/configs/tb100_defconfig
+++ b/configs/tb100_defconfig
@@ -21,7 +21,7 @@ CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_PHY_GIGE=y
diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index c307d8c23d0..57d452f960c 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -67,7 +67,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-extended interrupt-names interrupt-map interrupt-map-mask"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/tec-ng_defconfig b/configs/tec-ng_defconfig
index 1af1aa4e0bf..fd8e96dfb09 100644
--- a/configs/tec-ng_defconfig
+++ b/configs/tec-ng_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_SPI_FLASH_WINBOND=y
diff --git a/configs/tec_defconfig b/configs/tec_defconfig
index 7cb13f9f5af..5e50b6711ec 100644
--- a/configs/tec_defconfig
+++ b/configs/tec_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_TEGRA_NAND=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/tegratab_defconfig b/configs/tegratab_defconfig
index f0f83218ba5..93c9841e35f 100644
--- a/configs/tegratab_defconfig
+++ b/configs/tegratab_defconfig
@@ -52,7 +52,7 @@ CONFIG_TEGRA_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/tf701t_defconfig b/configs/tf701t_defconfig
index 69bc945568d..620f8539273 100644
--- a/configs/tf701t_defconfig
+++ b/configs/tf701t_defconfig
@@ -52,7 +52,7 @@ CONFIG_TEGRA_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index b19dc009fde..d46269f3ceb 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -61,7 +61,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
 CONFIG_PARTITION_TYPE_GUID=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NO_NET=y
 # CONFIG_BLOCK_CACHE is not set
diff --git a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
index 393284fa5c4..b14e83f313a 100644
--- a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
@@ -50,7 +50,7 @@ CONFIG_ISO_PARTITION=y
 CONFIG_AMIGA_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/theadorable-x86-conga-qa3-e3845_defconfig b/configs/theadorable-x86-conga-qa3-e3845_defconfig
index 803152b0b59..07d4eee01d4 100644
--- a/configs/theadorable-x86-conga-qa3-e3845_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845_defconfig
@@ -49,7 +49,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/theadorable-x86-dfi-bt700_defconfig b/configs/theadorable-x86-dfi-bt700_defconfig
index 9b64b6ef9d0..3626839857e 100644
--- a/configs/theadorable-x86-dfi-bt700_defconfig
+++ b/configs/theadorable-x86-dfi-bt700_defconfig
@@ -47,7 +47,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
 CONFIG_TFTP_TSIZE=y
diff --git a/configs/theadorable_debug_defconfig b/configs/theadorable_debug_defconfig
index dfcc08bbce5..a72f487ccee 100644
--- a/configs/theadorable_debug_defconfig
+++ b/configs/theadorable_debug_defconfig
@@ -63,7 +63,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/thunderx_88xx_defconfig b/configs/thunderx_88xx_defconfig
index fcfcee7f3ec..7dd75bfe365 100644
--- a/configs/thunderx_88xx_defconfig
+++ b/configs/thunderx_88xx_defconfig
@@ -31,7 +31,7 @@ CONFIG_SYS_PROMPT="ThunderX_88XX> "
 # CONFIG_CMD_EDITENV is not set
 # CONFIG_CMD_SAVEENV is not set
 # CONFIG_CMD_ENV_EXISTS is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_MMC is not set
 CONFIG_DM_SERIAL=y
diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
index b3726b6b511..d164ec216b3 100644
--- a/configs/tiger-rk3588_defconfig
+++ b/configs/tiger-rk3588_defconfig
@@ -60,7 +60,7 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 31fc67aecd2..77c9567a27a 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -45,7 +45,7 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 8f20a836511..1388212f18a 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -45,7 +45,7 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index e64bb768440..c90dfe517d6 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -23,7 +23,7 @@ CONFIG_CMD_ELF=n
 CONFIG_CMD_EXTENSION=n
 CONFIG_CMD_DATE=n
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_ACPIGEN=n
 CONFIG_AXI=y
diff --git a/configs/topic_miami_defconfig b/configs/topic_miami_defconfig
index 1be8d892070..8ea78d2281a 100644
--- a/configs/topic_miami_defconfig
+++ b/configs/topic_miami_defconfig
@@ -62,7 +62,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:0x100000(qspi-boot-bin),-(qspi-rootfs)"
 CONFIG_CMD_UBI=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_RAM=y
diff --git a/configs/topic_miamilite_defconfig b/configs/topic_miamilite_defconfig
index c48d64bf535..a1bd2841d34 100644
--- a/configs/topic_miamilite_defconfig
+++ b/configs/topic_miamilite_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_RAM=y
diff --git a/configs/topic_miamiplus_defconfig b/configs/topic_miamiplus_defconfig
index e16801032e3..d9c520d4267 100644
--- a/configs/topic_miamiplus_defconfig
+++ b/configs/topic_miamiplus_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_RAM=y
diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index ca7d9b56efb..0e7f1813dc1 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -88,7 +88,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/tplink_wdr4300_defconfig b/configs/tplink_wdr4300_defconfig
index 816488b5154..f0f7d7b7e45 100644
--- a/configs/tplink_wdr4300_defconfig
+++ b/configs/tplink_wdr4300_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_PING=y
 # CONFIG_ISO_PARTITION is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK=y
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index d0c5db65177..e2fd022cc38 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index c2bd47359ab..f98775f1ae3 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_mmc_defconfig
index d6706afe040..de5a732463f 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_mmc_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 1a1248f2314..291c1f2fa33 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_mmc_defconfig
index 7bed776507a..8e6935a3c48 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_mmc_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 39d2d8ab5e1..7c499077d0d 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
index c934e1a2410..bbda38b2a3b 100644
--- a/configs/transformer_t20_defconfig
+++ b/configs/transformer_t20_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 335ef326559..b1ebd9b9012 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -55,7 +55,7 @@ CONFIG_OF_LIST="tegra30-asus-p1801-t tegra30-asus-tf201 tegra30-asus-tf300t tegr
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_CLK_GPIO=y
diff --git a/configs/trats2_defconfig b/configs/trats2_defconfig
index f4afd373653..460811dd538 100644
--- a/configs/trats2_defconfig
+++ b/configs/trats2_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
diff --git a/configs/trats_defconfig b/configs/trats_defconfig
index 14849d0e691..70f7e06ba9c 100644
--- a/configs/trats_defconfig
+++ b/configs/trats_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
diff --git a/configs/trimslice_defconfig b/configs/trimslice_defconfig
index 47e467e71b7..46f9d43093d 100644
--- a/configs/trimslice_defconfig
+++ b/configs/trimslice_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=48000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_RTL8169=y
diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index a96fae198c7..cc7d4a1e0d6 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -59,7 +59,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_INITIAL_DTB_READONLY=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth2"
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
index 719a394dd65..ee18cc21443 100644
--- a/configs/turris_1x_sdcard_defconfig
+++ b/configs/turris_1x_sdcard_defconfig
@@ -84,7 +84,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth2"
 CONFIG_NETCONSOLE=y
diff --git a/configs/turris_mox_defconfig b/configs/turris_mox_defconfig
index 5ba7d76f9e6..7792da7b90e 100644
--- a/configs/turris_mox_defconfig
+++ b/configs/turris_mox_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_OF_LIST="armada-3720-turris-mox armada-3720-ripe-atlas"
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 29c34f9d549..de39e19ec6d 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -83,7 +83,7 @@ CONFIG_CMD_HASH=y
 CONFIG_CMD_BTRFS=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth2"
 CONFIG_ARP_TIMEOUT=200
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index a49f87193a1..99c2a8e980a 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_MDIO=y
diff --git a/configs/uDPU_defconfig b/configs/uDPU_defconfig
index 6fc4576fb7a..2f557801d29 100644
--- a/configs/uDPU_defconfig
+++ b/configs/uDPU_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/udoo_defconfig b/configs/udoo_defconfig
index 5730dacd060..cb9ae022c99 100644
--- a/configs/udoo_defconfig
+++ b/configs/udoo_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index 8183edd1f62..517313be9a5 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/uniphier_ld4_sld8_defconfig b/configs/uniphier_ld4_sld8_defconfig
index ece3d293d06..63aead2c352 100644
--- a/configs/uniphier_ld4_sld8_defconfig
+++ b/configs/uniphier_ld4_sld8_defconfig
@@ -48,7 +48,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=uniphier-nand.0:1m(firmware),-(UBI)"
 CONFIG_CMD_UBI=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="zImage"
 CONFIG_USE_GATEWAYIP=y
diff --git a/configs/uniphier_v7_defconfig b/configs/uniphier_v7_defconfig
index 4472609d85e..eceac50ed99 100644
--- a/configs/uniphier_v7_defconfig
+++ b/configs/uniphier_v7_defconfig
@@ -49,7 +49,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=uniphier-nand.0:1m(firmware),-(UBI)"
 CONFIG_CMD_UBI=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="zImage"
 CONFIG_USE_GATEWAYIP=y
diff --git a/configs/uniphier_v8_defconfig b/configs/uniphier_v8_defconfig
index e77d793e9ec..782bcc5df77 100644
--- a/configs/uniphier_v8_defconfig
+++ b/configs/uniphier_v8_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=uniphier-nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=uniphier-nand.0:1m(firmware),-(UBI)"
 CONFIG_CMD_UBI=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="Image"
 CONFIG_USE_GATEWAYIP=y
diff --git a/configs/usb_a9263_dataflash_defconfig b/configs/usb_a9263_dataflash_defconfig
index d7fb61c779c..ceed01480eb 100644
--- a/configs/usb_a9263_dataflash_defconfig
+++ b/configs/usb_a9263_dataflash_defconfig
@@ -36,7 +36,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=atmel_nand:16m(kernel)ro,120m(root1),-(root2)"
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
diff --git a/configs/usbarmory_defconfig b/configs/usbarmory_defconfig
index 3e948721e15..06b0f03fbe5 100644
--- a/configs/usbarmory_defconfig
+++ b/configs/usbarmory_defconfig
@@ -24,7 +24,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="usbarmory"
 CONFIG_DM_I2C=y
diff --git a/configs/variscite_dart6ul_defconfig b/configs/variscite_dart6ul_defconfig
index 9c69d9aef97..0c1c4bb39cc 100644
--- a/configs/variscite_dart6ul_defconfig
+++ b/configs/variscite_dart6ul_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
 CONFIG_DM_I2C_GPIO=y
diff --git a/configs/venice2_defconfig b/configs/venice2_defconfig
index 3d80197ef38..9e201bfbf41 100644
--- a/configs/venice2_defconfig
+++ b/configs/venice2_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
diff --git a/configs/ventana_defconfig b/configs/ventana_defconfig
index 3afa04dd10a..f94c6cf6623 100644
--- a/configs/ventana_defconfig
+++ b/configs/ventana_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index c299c9fe4ad..49431f503c6 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -88,7 +88,7 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index 6d662f2febf..c3a2a582f86 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -53,7 +53,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index cb0bf2c7838..a9a18def354 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -91,7 +91,7 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/verdin-am62p_r5_defconfig b/configs/verdin-am62p_r5_defconfig
index d1cc9b81640..bbdc803eb3a 100644
--- a/configs/verdin-am62p_r5_defconfig
+++ b/configs/verdin-am62p_r5_defconfig
@@ -53,7 +53,7 @@ CONFIG_SPL_REMOTEPROC=y
 CONFIG_CMD_DFU=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 9e7c03e1e88..66c0d944208 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -83,7 +83,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 47c28a1e49d..abb64e8cd04 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -95,7 +95,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/vf610twr_defconfig b/configs/vf610twr_defconfig
index c823cb0a30e..0bb21f58a7c 100644
--- a/configs/vf610twr_defconfig
+++ b/configs/vf610twr_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VYBRID_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/configs/vf610twr_nand_defconfig b/configs/vf610twr_nand_defconfig
index 84e73c0c665..a7e8cf2f7bb 100644
--- a/configs/vf610twr_nand_defconfig
+++ b/configs/vf610twr_nand_defconfig
@@ -44,7 +44,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VYBRID_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
index af0fdedde4b..9c905becff7 100644
--- a/configs/videostrong-kii-pro_defconfig
+++ b/configs/videostrong-kii-pro_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_I2C=y
diff --git a/configs/vinco_defconfig b/configs/vinco_defconfig
index d17f808f86f..216993c57d7 100644
--- a/configs/vinco_defconfig
+++ b/configs/vinco_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_AT91_GPIO=y
 CONFIG_SUPPORT_EMMC_BOOT=y
diff --git a/configs/vining_2000_defconfig b/configs/vining_2000_defconfig
index e6de7431788..7a7e45c65de 100644
--- a/configs/vining_2000_defconfig
+++ b/configs/vining_2000_defconfig
@@ -63,7 +63,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
diff --git a/configs/vocore2_defconfig b/configs/vocore2_defconfig
index e2604a135cf..8f96c531324 100644
--- a/configs/vocore2_defconfig
+++ b/configs/vocore2_defconfig
@@ -70,7 +70,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
 CONFIG_MTDPARTS_DEFAULT="spi0.0:312k(u-boot),4k(env),4k(factory),2368k(kernel),-(filesystem)"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index a6535975331..00935608bbb 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/wandboard_defconfig b/configs/wandboard_defconfig
index e0dc56b1d00..06f8f1ec4d2 100644
--- a/configs/wandboard_defconfig
+++ b/configs/wandboard_defconfig
@@ -53,7 +53,7 @@ CONFIG_OF_LIST="imx6q-wandboard-revd1 imx6qp-wandboard-revd1 imx6dl-wandboard-re
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DWC_AHSATA=y
diff --git a/configs/warp7_bl33_defconfig b/configs/warp7_bl33_defconfig
index 6b68681553c..5a94062f5e2 100644
--- a/configs/warp7_bl33_defconfig
+++ b/configs/warp7_bl33_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/warp7_defconfig b/configs/warp7_defconfig
index 679b6e8997e..03d68aa9a3f 100644
--- a/configs/warp7_defconfig
+++ b/configs/warp7_defconfig
@@ -44,7 +44,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_BOUNCE_BUFFER=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index 89f1f616237..837d922d530 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
index ee5558f220b..954e5cd885c 100644
--- a/configs/wetek-hub_defconfig
+++ b/configs/wetek-hub_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_I2C=y
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
index ee7e03643b0..543de4830a1 100644
--- a/configs/wetek-play2_defconfig
+++ b/configs/wetek-play2_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DM_I2C=y
diff --git a/configs/x250_defconfig b/configs/x250_defconfig
index dffe85bd6eb..628ce40fc91 100644
--- a/configs/x250_defconfig
+++ b/configs/x250_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_UBI=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index 685cb842ad1..e593a542239 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BUTTON=y
 CONFIG_EXTCON=y
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 861d1475453..5bfa6391493 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -32,7 +32,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index 9398b4c240d..5640b7d33c5 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -34,7 +34,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
 CONFIG_DEBUG_UART_UARTLITE=y
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index c39925bd86a..8848b8ade0b 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -33,7 +33,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index 811f93a2671..f3e6952599a 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -35,7 +35,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
 CONFIG_DEBUG_UART_UARTLITE=y
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 561459befb6..605a30b9987 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -57,7 +57,7 @@ CONFIG_SYS_ALT_MEMTEST=y
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_MMC is not set
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index 21f241e07b1..90d6abd490e 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_SDHCI=y
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index 6cb654c7a4b..df6a4165015 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_SDHCI=y
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index 04dd0cdb507..7cae88b0d9f 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -61,7 +61,7 @@ CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
index ab201566407..30f4885d149 100644
--- a/configs/xilinx_versal_net_mini_emmc_defconfig
+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_HS200_SUPPORT=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 2dce60298ef..be3464862c6 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -67,7 +67,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SIMPLE_PM_BUS=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 82e346f5ba4..0c7d2f2370d 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -71,7 +71,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SIMPLE_PM_BUS=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 9a058d5bc15..ca07cd911ce 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -94,7 +94,7 @@ CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 3c9fcf59400..7dae4ca3c82 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -119,7 +119,7 @@ CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 33f85f77ce3..736d4bd4efc 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -53,7 +53,7 @@ CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index 2ddaecd5875..85a6af45c57 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -67,7 +67,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index 31bba1712fb..4c01a43b6e4 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -67,7 +67,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index 3b202b04ab3..afb50a9ff43 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -48,7 +48,7 @@ CONFIG_CLOCKS=y
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index 67e1a6e7037..a40a4493d5d 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -48,7 +48,7 @@ CONFIG_CLOCKS=y
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index f2d0d6f16ed..0367c043574 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -69,7 +69,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_CMD_MP is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/xilinx_zynqmp_r5_defconfig b/configs/xilinx_zynqmp_r5_defconfig
index b9d7797e4b7..d4ec2b59b71 100644
--- a/configs/xilinx_zynqmp_r5_defconfig
+++ b/configs/xilinx_zynqmp_r5_defconfig
@@ -24,7 +24,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ZYNQ_SERIAL=y
 CONFIG_TIMER=y
 CONFIG_CADENCE_TTC_TIMER=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index f736f17466d..3f7a506cdfb 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -118,7 +118,7 @@ CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index 7d15903bb3a..4272b7320b6 100644
--- a/configs/zynq_cse_nand_defconfig
+++ b/configs/zynq_cse_nand_defconfig
@@ -69,7 +69,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index fe4362d3b03..74c4595eb43 100644
--- a/configs/zynq_cse_nor_defconfig
+++ b/configs/zynq_cse_nor_defconfig
@@ -69,7 +69,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index 824758f8289..145b7fd33bb 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -78,7 +78,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/env/Kconfig b/env/Kconfig
index 414db543b82..e551ffe45c3 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -686,7 +686,7 @@ config ENV_UBI_VID_OFFSET
 	help
 	  UBI VID offset for environment. If 0, no custom VID offset is used.
 
-config SYS_RELOC_GD_ENV_ADDR
+config ENV_RELOC_GD_ENV_ADDR
 	bool "Relocate gd->env_addr"
 	help
 	  Relocate the early env_addr pointer so we know it is not inside
-- 
2.47.2

