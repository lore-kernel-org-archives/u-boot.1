Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BD1C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 04:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3882B87B6B;
	Tue, 23 Jan 2024 05:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226A687B36; Tue, 23 Jan 2024 04:53:43 +0100 (CET)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
 [209.85.219.170])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C830387707
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 04:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@gmail.com
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so3452005276.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 19:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705982011; x=1706586811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=py3g3JSu/zdNGApPY93HYHl/r4cGZg/rpq+fDLqKUF4=;
 b=poNH03akH4WdxDUNKt/bwvCUek//XxKeH15qMAgZO54oOI6WSpvuKgvsPNlb9HO3mb
 tmViyPYc9DQNxDXCLZXdI6tN0R9KSBnBmVjJ7uC2NZl+1ALlRHs0DbPUyU06CgVAuGfJ
 3VjPjN8GTIJq4fmGJqn+qDu14YvpwcyB/wueM8PU3kOb3cwOvYa0lihW+u9mJLNq7G+R
 +14Yi3t/SOEhmnQnGKFqGWmZVgIvgDF7/3obDy49S79DzXVUpNUFlL7yyJTyWZQFiO0Q
 wMF8bC1dObpwbuB97GGDibBOQpM95sn6ux4qDAlF1fg8HMfSfQ9OdfS+dXcOgLjRtSXM
 XrlQ==
X-Gm-Message-State: AOJu0YxPQodvCBpGZMIo/0nwXcEZ4Y/Ex5ro0BLs4LGpI8a5XAvfj+ri
 0OxtTD8vM6FPIdiMhfcr07pliyVkFe41YXq+TMVynR1JTx4H6tn3ifgGW+HasGxgImFh97sIMGl
 J/3vzDrCytfiR4asOb6Jbu9IlYFayll6nn7Y=
X-Google-Smtp-Source: AGHT+IG3YtDAgyyIaEjB18sZ78Sdze2Ff5u7LwJRdtN6J5CtCW9esmoQj5uMfrH+68LIXHFi8L5EiBgItsk4rnlpWYc=
X-Received: by 2002:a5b:64d:0:b0:dc2:1b80:3166 with SMTP id
 o13-20020a5b064d000000b00dc21b803166mr3427848ybq.129.1705982010809; Mon, 22
 Jan 2024 19:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20220529165521.912054-1-trini@konsulko.com>
In-Reply-To: <20220529165521.912054-1-trini@konsulko.com>
From: Kever Yang <kever.yang@rock-chips.com>
Date: Tue, 23 Jan 2024 11:53:18 +0800
Message-ID: <CAKUh=RyhSZKzh+ab6kq1ZLYqEonhbjikJcaDASqhbdo6kQ+-Lg@mail.gmail.com>
Subject: Re: [PATCH 01/20] Convert CONFIG_SPL_STACK to Kconfig
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 23 Jan 2024 05:06:43 +0100
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

Hi Tom,

rk3036 only has small size internal sram, so it can only use very
simple SPL which only including dram init, and no SPL_FRAMEWORK
support.
In this convert, the CONFIG_SPL_STACK is lost for this SoC, any
suggestions on this kind of issue?

Thanks,
- Kever

diff --git a/include/configs/rk3036_common.h b/include/configs/rk3036_commo=
n.h
index 0eded1838c2a..2f3260e449c1 100644
--- a/include/configs/rk3036_common.h
+++ b/include/configs/rk3036_common.h
@@ -10,8 +10,6 @@

 #define CONFIG_SYS_HZ_CLOCK            24000000

-#define CONFIG_SPL_STACK               0x10081fff
-
 #define CONFIG_ROCKCHIP_MAX_INIT_SIZE  (4 << 10)
 #define CONFIG_ROCKCHIP_CHIP_TAG       "RK30"

Tom Rini <trini@konsulko.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=B8=80 01:00=E5=86=99=E9=81=93=EF=BC=9A
>
> This converts the following to Kconfig:
>    CONFIG_SPL_STACK
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  README                                        | 32 -------------------
>  arch/microblaze/cpu/start.S                   |  2 +-
>  common/spl/Kconfig                            | 18 +++++++++++
>  configs/A10-OLinuXino-Lime_defconfig          |  1 +
>  configs/A10s-OLinuXino-M_defconfig            |  1 +
>  configs/A13-OLinuXinoM_defconfig              |  1 +
>  configs/A13-OLinuXino_defconfig               |  1 +
>  configs/A20-OLinuXino-Lime2-eMMC_defconfig    |  1 +
>  configs/A20-OLinuXino-Lime2_defconfig         |  1 +
>  configs/A20-OLinuXino-Lime_defconfig          |  1 +
>  configs/A20-OLinuXino_MICRO-eMMC_defconfig    |  1 +
>  configs/A20-OLinuXino_MICRO_defconfig         |  1 +
>  configs/A20-Olimex-SOM-EVB_defconfig          |  1 +
>  configs/A20-Olimex-SOM204-EVB-eMMC_defconfig  |  1 +
>  configs/A20-Olimex-SOM204-EVB_defconfig       |  1 +
>  configs/A33-OLinuXino_defconfig               |  1 +
>  configs/Ainol_AW1_defconfig                   |  1 +
>  configs/Ampe_A76_defconfig                    |  1 +
>  configs/Auxtek-T003_defconfig                 |  1 +
>  configs/Auxtek-T004_defconfig                 |  1 +
>  configs/Bananapi_M2_Ultra_defconfig           |  1 +
>  configs/Bananapi_defconfig                    |  1 +
>  configs/Bananapi_m2m_defconfig                |  1 +
>  configs/Bananapro_defconfig                   |  1 +
>  configs/CHIP_defconfig                        |  1 +
>  configs/CHIP_pro_defconfig                    |  1 +
>  configs/CSQ_CS908_defconfig                   |  1 +
>  configs/Chuwi_V7_CW0825_defconfig             |  1 +
>  configs/Colombus_defconfig                    |  1 +
>  configs/Cubieboard2_defconfig                 |  1 +
>  configs/Cubieboard4_defconfig                 |  1 +
>  configs/Cubieboard_defconfig                  |  1 +
>  configs/Cubietruck_defconfig                  |  1 +
>  configs/Cubietruck_plus_defconfig             |  1 +
>  configs/Empire_electronix_d709_defconfig      |  1 +
>  configs/Empire_electronix_m712_defconfig      |  1 +
>  configs/Hummingbird_A31_defconfig             |  1 +
>  configs/Hyundai_A7HD_defconfig                |  1 +
>  configs/Itead_Ibox_A20_defconfig              |  1 +
>  configs/Lamobo_R1_defconfig                   |  1 +
>  configs/LicheePi_Zero_defconfig               |  1 +
>  configs/Linksprite_pcDuino3_Nano_defconfig    |  1 +
>  configs/Linksprite_pcDuino3_defconfig         |  1 +
>  configs/Linksprite_pcDuino_defconfig          |  1 +
>  configs/MK808C_defconfig                      |  1 +
>  configs/MSI_Primo73_defconfig                 |  1 +
>  configs/MSI_Primo81_defconfig                 |  1 +
>  configs/Marsboard_A10_defconfig               |  1 +
>  configs/Mele_A1000G_quad_defconfig            |  1 +
>  configs/Mele_A1000_defconfig                  |  1 +
>  configs/Mele_I7_defconfig                     |  1 +
>  configs/Mele_M3_defconfig                     |  1 +
>  configs/Mele_M5_defconfig                     |  1 +
>  configs/Mele_M9_defconfig                     |  1 +
>  configs/Merrii_A80_Optimus_defconfig          |  1 +
>  configs/Mini-X_defconfig                      |  1 +
>  .../Nintendo_NES_Classic_Edition_defconfig    |  1 +
>  configs/Orangepi_defconfig                    |  1 +
>  configs/Orangepi_mini_defconfig               |  1 +
>  configs/Sinlinx_SinA31s_defconfig             |  1 +
>  configs/Sinlinx_SinA33_defconfig              |  1 +
>  configs/Sinovoip_BPI_M2_defconfig             |  1 +
>  configs/Sinovoip_BPI_M3_defconfig             |  1 +
>  configs/Sunchip_CX-A99_defconfig              |  1 +
>  configs/UTOO_P66_defconfig                    |  1 +
>  configs/Wexler_TAB7200_defconfig              |  1 +
>  configs/Wits_Pro_A20_DKT_defconfig            |  1 +
>  configs/Wobo_i5_defconfig                     |  1 +
>  configs/Yones_Toptech_BD1078_defconfig        |  1 +
>  configs/Yones_Toptech_BS1078_V2_defconfig     |  1 +
>  configs/a64-olinuxino-emmc_defconfig          |  1 +
>  configs/a64-olinuxino_defconfig               |  1 +
>  configs/alt_defconfig                         |  2 ++
>  configs/amarula_a64_relic_defconfig           |  1 +
>  configs/apalis-tk1_defconfig                  |  2 ++
>  configs/apalis_imx6_defconfig                 |  2 ++
>  configs/apalis_t30_defconfig                  |  2 ++
>  ...edev_cc_v1_0_ultrazedev_som_v1_0_defconfig |  2 ++
>  configs/axm_defconfig                         |  2 ++
>  configs/ba10_tv_box_defconfig                 |  1 +
>  configs/bananapi_m1_plus_defconfig            |  1 +
>  configs/bananapi_m2_berry_defconfig           |  1 +
>  configs/bananapi_m2_plus_h3_defconfig         |  1 +
>  configs/bananapi_m2_plus_h5_defconfig         |  1 +
>  configs/bananapi_m2_zero_defconfig            |  1 +
>  configs/bananapi_m64_defconfig                |  1 +
>  configs/beaver_defconfig                      |  2 ++
>  configs/beelink_gs1_defconfig                 |  1 +
>  configs/beelink_x2_defconfig                  |  1 +
>  configs/bitmain_antminer_s9_defconfig         |  2 ++
>  configs/brppt2_defconfig                      |  2 ++
>  configs/cardhu_defconfig                      |  2 ++
>  configs/cei-tk1-som_defconfig                 |  2 ++
>  configs/cgtqmx8_defconfig                     |  2 ++
>  configs/chromebit_mickey_defconfig            |  2 ++
>  configs/chromebook_bob_defconfig              |  2 ++
>  configs/chromebook_jerry_defconfig            |  2 ++
>  configs/chromebook_kevin_defconfig            |  2 ++
>  configs/chromebook_minnie_defconfig           |  2 ++
>  configs/chromebook_speedy_defconfig           |  2 ++
>  configs/ci20_mmc_defconfig                    |  2 ++
>  configs/cl-som-imx7_defconfig                 |  2 ++
>  configs/clearfog_defconfig                    |  2 ++
>  configs/cm_fx6_defconfig                      |  2 ++
>  configs/colibri_imx6_defconfig                |  2 ++
>  configs/colibri_t20_defconfig                 |  2 ++
>  configs/colibri_t30_defconfig                 |  2 ++
>  configs/colorfly_e708_q1_defconfig            |  1 +
>  configs/controlcenterdc_defconfig             |  2 ++
>  configs/corvus_defconfig                      |  2 ++
>  configs/da850evm_defconfig                    |  2 ++
>  configs/da850evm_nand_defconfig               |  2 ++
>  configs/dalmore_defconfig                     |  2 ++
>  configs/db-88f6720_defconfig                  |  2 ++
>  configs/db-88f6820-amc_defconfig              |  2 ++
>  configs/db-88f6820-gp_defconfig               |  2 ++
>  configs/db-mv784mp-gp_defconfig               |  2 ++
>  configs/deneb_defconfig                       |  2 ++
>  configs/devkit3250_defconfig                  |  2 ++
>  configs/dh_imx6_defconfig                     |  2 ++
>  configs/difrnce_dit4350_defconfig             |  1 +
>  configs/display5_defconfig                    |  2 ++
>  configs/display5_factory_defconfig            |  2 ++
>  configs/ds414_defconfig                       |  2 ++
>  configs/dserve_dsrv9703c_defconfig            |  1 +
>  configs/edminiv2_defconfig                    |  2 ++
>  configs/emlid_neutis_n5_devboard_defconfig    |  1 +
>  configs/evb-px30_defconfig                    |  2 ++
>  configs/evb-px5_defconfig                     |  2 ++
>  configs/evb-rk3288_defconfig                  |  2 ++
>  configs/evb-rk3308_defconfig                  |  2 ++
>  configs/evb-rk3328_defconfig                  |  2 ++
>  configs/evb-rk3399_defconfig                  |  2 ++
>  configs/evb-rk3568_defconfig                  |  2 ++
>  configs/ficus-rk3399_defconfig                |  2 ++
>  configs/firefly-px30_defconfig                |  2 ++
>  configs/firefly-rk3288_defconfig              |  2 ++
>  configs/firefly-rk3399_defconfig              |  2 ++
>  configs/ga10h_v1_1_defconfig                  |  1 +
>  .../gardena-smart-gateway-at91sam_defconfig   |  2 ++
>  configs/ge_b1x5v2_defconfig                   |  2 ++
>  configs/giedi_defconfig                       |  2 ++
>  configs/gose_defconfig                        |  2 ++
>  configs/gt90h_v4_defconfig                    |  1 +
>  configs/gwventana_emmc_defconfig              |  2 ++
>  configs/gwventana_gw5904_defconfig            |  2 ++
>  configs/gwventana_nand_defconfig              |  2 ++
>  configs/h8_homlet_v2_defconfig                |  1 +
>  configs/harmony_defconfig                     |  2 ++
>  configs/helios4_defconfig                     |  2 ++
>  configs/i12-tvbox_defconfig                   |  1 +
>  configs/iNet_3F_defconfig                     |  1 +
>  configs/iNet_3W_defconfig                     |  1 +
>  configs/iNet_86VS_defconfig                   |  1 +
>  configs/iNet_D978_rev2_defconfig              |  1 +
>  configs/icnova-a20-swac_defconfig             |  1 +
>  configs/imx28_xea_defconfig                   |  2 ++
>  configs/imx6dl_icore_nand_defconfig           |  2 ++
>  configs/imx6dl_mamoj_defconfig                |  2 ++
>  configs/imx6q_bosch_acc_defconfig             |  2 ++
>  configs/imx6q_icore_nand_defconfig            |  2 ++
>  configs/imx6q_logic_defconfig                 |  2 ++
>  configs/imx6qdl_icore_mipi_defconfig          |  2 ++
>  configs/imx6qdl_icore_mmc_defconfig           |  2 ++
>  configs/imx6qdl_icore_nand_defconfig          |  2 ++
>  configs/imx6qdl_icore_rqs_defconfig           |  2 ++
>  configs/imx6ul_geam_mmc_defconfig             |  2 ++
>  configs/imx6ul_geam_nand_defconfig            |  2 ++
>  configs/imx6ul_isiot_emmc_defconfig           |  2 ++
>  configs/imx6ul_isiot_nand_defconfig           |  2 ++
>  configs/imx7_cm_defconfig                     |  2 ++
>  configs/imx8mm-cl-iot-gate-optee_defconfig    |  2 ++
>  configs/imx8mm-cl-iot-gate_defconfig          |  2 ++
>  configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |  2 ++
>  configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |  2 ++
>  configs/imx8mm-mx8menlo_defconfig             |  2 ++
>  configs/imx8mm_beacon_defconfig               |  2 ++
>  configs/imx8mm_data_modul_edm_sbc_defconfig   |  2 ++
>  configs/imx8mm_evk_defconfig                  |  2 ++
>  configs/imx8mm_venice_defconfig               |  2 ++
>  configs/imx8mn_beacon_2g_defconfig            |  2 ++
>  configs/imx8mn_beacon_defconfig               |  2 ++
>  configs/imx8mn_bsh_smm_s2_defconfig           |  2 ++
>  configs/imx8mn_bsh_smm_s2pro_defconfig        |  2 ++
>  configs/imx8mn_ddr4_evk_defconfig             |  2 ++
>  configs/imx8mn_evk_defconfig                  |  2 ++
>  configs/imx8mn_var_som_defconfig              |  2 ++
>  configs/imx8mn_venice_defconfig               |  2 ++
>  configs/imx8mp_dhcom_pdk2_defconfig           |  2 ++
>  configs/imx8mp_evk_defconfig                  |  2 ++
>  configs/imx8mp_rsb3720a1_4G_defconfig         |  2 ++
>  configs/imx8mp_rsb3720a1_6G_defconfig         |  2 ++
>  configs/imx8mp_venice_defconfig               |  2 ++
>  configs/imx8mq_cm_defconfig                   |  2 ++
>  configs/imx8mq_evk_defconfig                  |  2 ++
>  configs/imx8mq_phanbell_defconfig             |  2 ++
>  configs/imx8qm_mek_defconfig                  |  2 ++
>  configs/imx8qxp_mek_defconfig                 |  2 ++
>  configs/imx8ulp_evk_defconfig                 |  2 ++
>  configs/inet1_defconfig                       |  1 +
>  configs/inet86dz_defconfig                    |  1 +
>  configs/inet97fv2_defconfig                   |  1 +
>  configs/inet98v_rev2_defconfig                |  1 +
>  configs/inet9f_rev03_defconfig                |  1 +
>  configs/inet_q972_defconfig                   |  1 +
>  configs/jesurun_q5_defconfig                  |  1 +
>  configs/jetson-tk1_defconfig                  |  2 ++
>  configs/k2e_evm_defconfig                     |  2 ++
>  configs/k2g_evm_defconfig                     |  2 ++
>  configs/k2hk_evm_defconfig                    |  2 ++
>  configs/k2l_evm_defconfig                     |  2 ++
>  configs/khadas-edge-captain-rk3399_defconfig  |  2 ++
>  configs/khadas-edge-rk3399_defconfig          |  2 ++
>  configs/khadas-edge-v-rk3399_defconfig        |  2 ++
>  configs/koelsch_defconfig                     |  2 ++
>  configs/kontron-sl-mx6ul_defconfig            |  2 ++
>  configs/kontron-sl-mx8mm_defconfig            |  2 ++
>  configs/kontron_pitx_imx8m_defconfig          |  2 ++
>  configs/kontron_sl28_defconfig                |  2 ++
>  configs/kp_imx6q_tpc_defconfig                |  2 ++
>  configs/lager_defconfig                       |  2 ++
>  configs/leez-rk3399_defconfig                 |  2 ++
>  configs/libretech_all_h3_cc_h2_plus_defconfig |  1 +
>  configs/libretech_all_h3_cc_h3_defconfig      |  1 +
>  configs/libretech_all_h3_cc_h5_defconfig      |  1 +
>  configs/libretech_all_h3_it_h5_defconfig      |  1 +
>  configs/libretech_all_h5_cc_h5_defconfig      |  1 +
>  configs/licheepi_nano_defconfig               |  1 +
>  configs/lion-rk3368_defconfig                 |  2 ++
>  configs/liteboard_defconfig                   |  2 ++
>  configs/ls1021aiot_sdcard_defconfig           |  2 ++
>  configs/ls1021aqds_nand_defconfig             |  2 ++
>  configs/ls1021aqds_sdcard_ifc_defconfig       |  2 ++
>  configs/ls1021aqds_sdcard_qspi_defconfig      |  2 ++
>  configs/ls1021atsn_sdcard_defconfig           |  2 ++
>  ...s1021atwr_sdcard_ifc_SECURE_BOOT_defconfig |  2 ++
>  configs/ls1021atwr_sdcard_ifc_defconfig       |  2 ++
>  configs/ls1021atwr_sdcard_qspi_defconfig      |  2 ++
>  configs/ls1043aqds_nand_defconfig             |  2 ++
>  configs/ls1043aqds_sdcard_ifc_defconfig       |  2 ++
>  configs/ls1043aqds_sdcard_qspi_defconfig      |  2 ++
>  configs/ls1043ardb_nand_SECURE_BOOT_defconfig |  2 ++
>  configs/ls1043ardb_nand_defconfig             |  2 ++
>  .../ls1043ardb_sdcard_SECURE_BOOT_defconfig   |  2 ++
>  configs/ls1043ardb_sdcard_defconfig           |  2 ++
>  configs/ls1046aqds_nand_defconfig             |  2 ++
>  configs/ls1046aqds_sdcard_ifc_defconfig       |  2 ++
>  configs/ls1046aqds_sdcard_qspi_defconfig      |  2 ++
>  configs/ls1046ardb_emmc_defconfig             |  2 ++
>  configs/ls1046ardb_qspi_spl_defconfig         |  2 ++
>  .../ls1046ardb_sdcard_SECURE_BOOT_defconfig   |  2 ++
>  configs/ls1046ardb_sdcard_defconfig           |  2 ++
>  configs/ls1088aqds_sdcard_ifc_defconfig       |  2 ++
>  configs/ls1088aqds_sdcard_qspi_defconfig      |  2 ++
>  ...1088ardb_sdcard_qspi_SECURE_BOOT_defconfig |  2 ++
>  configs/ls1088ardb_sdcard_qspi_defconfig      |  2 ++
>  configs/ls2080aqds_nand_defconfig             |  2 ++
>  configs/ls2080aqds_sdcard_defconfig           |  2 ++
>  configs/ls2080ardb_nand_defconfig             |  2 ++
>  configs/m53menlo_defconfig                    |  2 ++
>  configs/maxbcm_defconfig                      |  2 ++
>  configs/mccmon6_nor_defconfig                 |  2 ++
>  configs/mccmon6_sd_defconfig                  |  2 ++
>  configs/medcom-wide_defconfig                 |  2 ++
>  configs/microblaze-generic_defconfig          |  2 ++
>  configs/miqi-rk3288_defconfig                 |  2 ++
>  configs/mixtile_loftq_defconfig               |  1 +
>  configs/mk802_a10s_defconfig                  |  1 +
>  configs/mk802_defconfig                       |  1 +
>  configs/mk802ii_defconfig                     |  1 +
>  configs/mk808_defconfig                       |  2 ++
>  configs/mt7629_rfb_defconfig                  |  2 ++
>  configs/mx6cuboxi_defconfig                   |  2 ++
>  configs/mx6memcal_defconfig                   |  2 ++
>  configs/mx6sabreauto_defconfig                |  2 ++
>  configs/mx6sabresd_defconfig                  |  2 ++
>  configs/mx6slevk_spl_defconfig                |  2 ++
>  configs/mx6ul_14x14_evk_defconfig             |  2 ++
>  configs/mx6ul_9x9_evk_defconfig               |  2 ++
>  configs/myir_mys_6ulx_defconfig               |  2 ++
>  configs/nanopc-t4-rk3399_defconfig            |  2 ++
>  configs/nanopi-m4-2gb-rk3399_defconfig        |  2 ++
>  configs/nanopi-m4-rk3399_defconfig            |  2 ++
>  configs/nanopi-m4b-rk3399_defconfig           |  2 ++
>  configs/nanopi-neo4-rk3399_defconfig          |  2 ++
>  configs/nanopi-r2s-rk3328_defconfig           |  2 ++
>  configs/nanopi-r4s-rk3399_defconfig           |  2 ++
>  configs/nanopi_a64_defconfig                  |  1 +
>  configs/nanopi_m1_defconfig                   |  1 +
>  configs/nanopi_m1_plus_defconfig              |  1 +
>  configs/nanopi_neo2_defconfig                 |  1 +
>  configs/nanopi_neo_air_defconfig              |  1 +
>  configs/nanopi_neo_defconfig                  |  1 +
>  configs/nanopi_neo_plus2_defconfig            |  1 +
>  configs/nanopi_r1s_h5_defconfig               |  1 +
>  configs/novena_defconfig                      |  2 ++
>  configs/nyan-big_defconfig                    |  2 ++
>  configs/oceanic_5205_5inmfd_defconfig         |  1 +
>  configs/odroid-go2_defconfig                  |  2 ++
>  configs/omapl138_lcdk_defconfig               |  2 ++
>  configs/openpiton_riscv64_spl_defconfig       |  2 ++
>  configs/opos6uldev_defconfig                  |  2 ++
>  configs/orangepi-rk3399_defconfig             |  2 ++
>  configs/orangepi_2_defconfig                  |  1 +
>  configs/orangepi_3_defconfig                  |  1 +
>  configs/orangepi_lite2_defconfig              |  1 +
>  configs/orangepi_lite_defconfig               |  1 +
>  configs/orangepi_one_defconfig                |  1 +
>  configs/orangepi_one_plus_defconfig           |  1 +
>  configs/orangepi_pc2_defconfig                |  1 +
>  configs/orangepi_pc_defconfig                 |  1 +
>  configs/orangepi_pc_plus_defconfig            |  1 +
>  configs/orangepi_plus2e_defconfig             |  1 +
>  configs/orangepi_plus_defconfig               |  1 +
>  configs/orangepi_prime_defconfig              |  1 +
>  configs/orangepi_r1_defconfig                 |  1 +
>  configs/orangepi_win_defconfig                |  1 +
>  configs/orangepi_zero2_defconfig              |  1 +
>  configs/orangepi_zero_defconfig               |  1 +
>  configs/orangepi_zero_plus2_defconfig         |  1 +
>  configs/orangepi_zero_plus2_h3_defconfig      |  1 +
>  configs/orangepi_zero_plus_defconfig          |  1 +
>  configs/parrot_r16_defconfig                  |  1 +
>  configs/paz00_defconfig                       |  2 ++
>  configs/pcm058_defconfig                      |  2 ++
>  configs/phycore-imx8mm_defconfig              |  2 ++
>  configs/phycore-imx8mp_defconfig              |  2 ++
>  configs/phycore-rk3288_defconfig              |  2 ++
>  configs/phycore_pcl063_defconfig              |  2 ++
>  configs/phycore_pcl063_ull_defconfig          |  2 ++
>  configs/pico-dwarf-imx6ul_defconfig           |  2 ++
>  configs/pico-dwarf-imx7d_defconfig            |  2 ++
>  configs/pico-hobbit-imx6ul_defconfig          |  2 ++
>  configs/pico-hobbit-imx7d_defconfig           |  2 ++
>  configs/pico-imx6_defconfig                   |  2 ++
>  configs/pico-imx6ul_defconfig                 |  2 ++
>  configs/pico-imx7d_bl33_defconfig             |  2 ++
>  configs/pico-imx7d_defconfig                  |  2 ++
>  configs/pico-imx8mq_defconfig                 |  2 ++
>  configs/pico-nymph-imx7d_defconfig            |  2 ++
>  configs/pico-pi-imx6ul_defconfig              |  2 ++
>  configs/pico-pi-imx7d_defconfig               |  2 ++
>  configs/pine64-lts_defconfig                  |  1 +
>  configs/pine64_plus_defconfig                 |  1 +
>  configs/pine_h64_defconfig                    |  1 +
>  configs/pinebook-pro-rk3399_defconfig         |  2 ++
>  configs/pinebook_defconfig                    |  1 +
>  configs/pinecube_defconfig                    |  1 +
>  configs/pinephone_defconfig                   |  1 +
>  configs/pinetab_defconfig                     |  1 +
>  configs/plutux_defconfig                      |  2 ++
>  configs/polaroid_mid2407pxe03_defconfig       |  1 +
>  configs/polaroid_mid2809pxe04_defconfig       |  1 +
>  configs/popmetal-rk3288_defconfig             |  2 ++
>  configs/porter_defconfig                      |  2 ++
>  configs/pov_protab2_ips9_defconfig            |  1 +
>  configs/puma-rk3399_defconfig                 |  2 ++
>  configs/px30-core-ctouch2-of10-px30_defconfig |  2 ++
>  configs/px30-core-ctouch2-px30_defconfig      |  2 ++
>  configs/px30-core-edimm2.2-px30_defconfig     |  2 ++
>  configs/q8_a13_tablet_defconfig               |  1 +
>  configs/q8_a23_tablet_800x480_defconfig       |  1 +
>  configs/q8_a33_tablet_1024x600_defconfig      |  1 +
>  configs/q8_a33_tablet_800x480_defconfig       |  1 +
>  configs/r7-tv-dongle_defconfig                |  1 +
>  configs/r8a77970_eagle_defconfig              |  2 ++
>  configs/r8a77980_condor_defconfig             |  2 ++
>  configs/r8a77990_ebisu_defconfig              |  2 ++
>  configs/r8a77995_draak_defconfig              |  2 ++
>  configs/r8a779a0_falcon_defconfig             |  2 ++
>  configs/rcar3_salvator-x_defconfig            |  2 ++
>  configs/rcar3_ulcb_defconfig                  |  2 ++
>  configs/riotboard_defconfig                   |  2 ++
>  configs/roc-cc-rk3308_defconfig               |  2 ++
>  configs/roc-cc-rk3328_defconfig               |  2 ++
>  configs/roc-pc-mezzanine-rk3399_defconfig     |  2 ++
>  configs/roc-pc-rk3399_defconfig               |  2 ++
>  configs/rock-pi-4-rk3399_defconfig            |  2 ++
>  configs/rock-pi-4c-rk3399_defconfig           |  2 ++
>  configs/rock-pi-e-rk3328_defconfig            |  2 ++
>  configs/rock-pi-n10-rk3399pro_defconfig       |  2 ++
>  configs/rock-pi-n8-rk3288_defconfig           |  2 ++
>  configs/rock2_defconfig                       |  2 ++
>  configs/rock64-rk3328_defconfig               |  2 ++
>  configs/rock960-rk3399_defconfig              |  2 ++
>  configs/rock_defconfig                        |  2 ++
>  configs/rockpro64-rk3399_defconfig            |  2 ++
>  configs/sama5d27_giantboard_defconfig         |  2 ++
>  configs/sama5d27_som1_ek_mmc1_defconfig       |  2 ++
>  configs/sama5d27_som1_ek_mmc_defconfig        |  2 ++
>  configs/sama5d27_som1_ek_qspiflash_defconfig  |  2 ++
>  configs/sama5d27_wlsom1_ek_mmc_defconfig      |  2 ++
>  .../sama5d27_wlsom1_ek_qspiflash_defconfig    |  2 ++
>  configs/sama5d2_icp_mmc_defconfig             |  2 ++
>  configs/sama5d2_xplained_emmc_defconfig       |  2 ++
>  configs/sama5d2_xplained_mmc_defconfig        |  2 ++
>  configs/sama5d2_xplained_qspiflash_defconfig  |  2 ++
>  configs/sama5d2_xplained_spiflash_defconfig   |  2 ++
>  configs/sama5d3_xplained_mmc_defconfig        |  2 ++
>  configs/sama5d3_xplained_nandflash_defconfig  |  2 ++
>  configs/sama5d3xek_mmc_defconfig              |  2 ++
>  configs/sama5d3xek_nandflash_defconfig        |  2 ++
>  configs/sama5d3xek_spiflash_defconfig         |  2 ++
>  configs/sama5d4_xplained_mmc_defconfig        |  2 ++
>  configs/sama5d4_xplained_nandflash_defconfig  |  2 ++
>  configs/sama5d4_xplained_spiflash_defconfig   |  2 ++
>  configs/sama5d4ek_mmc_defconfig               |  2 ++
>  configs/sama5d4ek_nandflash_defconfig         |  2 ++
>  configs/sama5d4ek_spiflash_defconfig          |  2 ++
>  configs/seaboard_defconfig                    |  2 ++
>  configs/seeed_npi_imx6ull_defconfig           |  2 ++
>  configs/sifive_unleashed_defconfig            |  2 ++
>  configs/sifive_unmatched_defconfig            |  2 ++
>  configs/silinux_ek874_defconfig               |  2 ++
>  configs/silk_defconfig                        |  2 ++
>  configs/smartweb_defconfig                    |  2 ++
>  configs/sniper_defconfig                      |  2 ++
>  configs/socfpga_agilex_atf_defconfig          |  2 ++
>  configs/socfpga_agilex_defconfig              |  2 ++
>  configs/socfpga_agilex_vab_defconfig          |  2 ++
>  configs/socfpga_arria10_defconfig             |  2 ++
>  configs/socfpga_arria5_defconfig              |  2 ++
>  configs/socfpga_cyclone5_defconfig            |  2 ++
>  configs/socfpga_dbm_soc1_defconfig            |  2 ++
>  configs/socfpga_de0_nano_soc_defconfig        |  2 ++
>  configs/socfpga_de10_nano_defconfig           |  2 ++
>  configs/socfpga_de1_soc_defconfig             |  2 ++
>  configs/socfpga_is1_defconfig                 |  2 ++
>  configs/socfpga_mcvevk_defconfig              |  2 ++
>  configs/socfpga_n5x_atf_defconfig             |  2 ++
>  configs/socfpga_n5x_defconfig                 |  2 ++
>  configs/socfpga_n5x_vab_defconfig             |  2 ++
>  configs/socfpga_secu1_defconfig               |  2 ++
>  configs/socfpga_sockit_defconfig              |  2 ++
>  configs/socfpga_socrates_defconfig            |  2 ++
>  configs/socfpga_sr1500_defconfig              |  2 ++
>  configs/socfpga_stratix10_atf_defconfig       |  2 ++
>  configs/socfpga_stratix10_defconfig           |  2 ++
>  configs/socfpga_vining_fpga_defconfig         |  2 ++
>  configs/sopine_baseboard_defconfig            |  1 +
>  ...stm32mp15-icore-stm32mp1-ctouch2_defconfig |  2 ++
>  ...tm32mp15-icore-stm32mp1-edimm2.2_defconfig |  2 ++
>  ...-microgea-stm32mp1-microdev2-of7_defconfig |  2 ++
>  ...mp15-microgea-stm32mp1-microdev2_defconfig |  2 ++
>  configs/stm32mp15_basic_defconfig             |  2 ++
>  configs/stm32mp15_dhcom_basic_defconfig       |  2 ++
>  configs/stm32mp15_dhcor_basic_defconfig       |  2 ++
>  configs/stout_defconfig                       |  2 ++
>  configs/sun8i_a23_evb_defconfig               |  1 +
>  configs/sunxi_Gemei_G9_defconfig              |  1 +
>  configs/syzygy_hub_defconfig                  |  2 ++
>  configs/tanix_tx6_defconfig                   |  1 +
>  configs/taurus_defconfig                      |  2 ++
>  configs/tbs_a711_defconfig                    |  1 +
>  configs/tec-ng_defconfig                      |  2 ++
>  configs/tec_defconfig                         |  2 ++
>  configs/teres_i_defconfig                     |  1 +
>  configs/theadorable_debug_defconfig           |  2 ++
>  configs/tinker-rk3288_defconfig               |  2 ++
>  configs/tinker-s-rk3288_defconfig             |  2 ++
>  configs/topic_miami_defconfig                 |  2 ++
>  configs/topic_miamilite_defconfig             |  2 ++
>  configs/topic_miamiplus_defconfig             |  2 ++
>  configs/trimslice_defconfig                   |  2 ++
>  configs/turris_omnia_defconfig                |  2 ++
>  configs/udoo_defconfig                        |  2 ++
>  configs/udoo_neo_defconfig                    |  2 ++
>  configs/uniphier_ld4_sld8_defconfig           |  2 ++
>  configs/uniphier_v7_defconfig                 |  2 ++
>  configs/variscite_dart6ul_defconfig           |  2 ++
>  configs/venice2_defconfig                     |  2 ++
>  configs/ventana_defconfig                     |  2 ++
>  configs/verdin-imx8mm_defconfig               |  2 ++
>  configs/verdin-imx8mp_defconfig               |  2 ++
>  configs/vining_2000_defconfig                 |  2 ++
>  configs/vyasa-rk3288_defconfig                |  2 ++
>  configs/wandboard_defconfig                   |  2 ++
>  configs/work_92105_defconfig                  |  2 ++
>  configs/x530_defconfig                        |  2 ++
>  configs/xilinx_zynq_virt_defconfig            |  2 ++
>  configs/xilinx_zynqmp_mini_emmc0_defconfig    |  2 ++
>  configs/xilinx_zynqmp_mini_emmc1_defconfig    |  2 ++
>  configs/xilinx_zynqmp_mini_qspi_defconfig     |  2 ++
>  configs/xilinx_zynqmp_virt_defconfig          |  2 ++
>  configs/zeropi_defconfig                      |  1 +
>  configs/zynq_cse_nand_defconfig               |  2 ++
>  configs/zynq_cse_nor_defconfig                |  2 ++
>  configs/zynq_cse_qspi_defconfig               |  2 ++
>  include/configs/alt.h                         |  3 --
>  include/configs/at91sam9m10g45ek.h            |  3 --
>  include/configs/at91sam9n12ek.h               |  1 -
>  include/configs/at91sam9x5ek.h                |  1 -
>  include/configs/capricorn-common.h            |  1 -
>  include/configs/cgtqmx8.h                     |  1 -
>  include/configs/ci20.h                        |  1 -
>  include/configs/clearfog.h                    |  2 --
>  include/configs/controlcenterdc.h             |  2 --
>  include/configs/corvus.h                      |  1 -
>  include/configs/da850evm.h                    |  1 -
>  include/configs/db-88f6720.h                  |  2 --
>  include/configs/db-88f6820-amc.h              |  2 --
>  include/configs/db-88f6820-gp.h               |  2 --
>  include/configs/db-mv784mp-gp.h               |  2 --
>  include/configs/devkit3250.h                  | 12 -------
>  include/configs/ds414.h                       |  2 --
>  include/configs/edminiv2.h                    |  1 -
>  include/configs/espresso7420.h                |  1 -
>  .../configs/gardena-smart-gateway-at91sam.h   |  1 -
>  include/configs/gose.h                        |  3 --
>  include/configs/helios4.h                     |  2 --
>  include/configs/imx6_spl.h                    |  2 --
>  include/configs/imx7_spl.h                    |  1 -
>  include/configs/imx8mm-cl-iot-gate.h          |  1 -
>  include/configs/imx8mm_beacon.h               |  1 -
>  include/configs/imx8mm_data_modul_edm_sbc.h   |  1 -
>  include/configs/imx8mm_evk.h                  |  1 -
>  include/configs/imx8mm_icore_mx8mm.h          |  1 -
>  include/configs/imx8mm_venice.h               |  1 -
>  include/configs/imx8mn_beacon.h               |  1 -
>  include/configs/imx8mn_bsh_smm_s2_common.h    |  1 -
>  include/configs/imx8mn_evk.h                  |  1 -
>  include/configs/imx8mn_var_som.h              |  1 -
>  include/configs/imx8mn_venice.h               |  1 -
>  include/configs/imx8mp_dhcom_pdk2.h           |  1 -
>  include/configs/imx8mp_evk.h                  |  1 -
>  include/configs/imx8mp_rsb3720.h              |  1 -
>  include/configs/imx8mp_venice.h               |  1 -
>  include/configs/imx8mq_cm.h                   |  1 -
>  include/configs/imx8mq_evk.h                  |  1 -
>  include/configs/imx8mq_phanbell.h             |  1 -
>  include/configs/imx8qm_mek.h                  |  1 -
>  include/configs/imx8qxp_mek.h                 |  1 -
>  include/configs/imx8ulp_evk.h                 |  1 -
>  include/configs/koelsch.h                     |  1 -
>  include/configs/kontron-sl-mx8mm.h            |  1 -
>  include/configs/kontron_pitx_imx8m.h          |  1 -
>  include/configs/kontron_sl28.h                |  1 -
>  include/configs/lager.h                       |  1 -
>  include/configs/ls1021aiot.h                  |  2 --
>  include/configs/ls1021aqds.h                  |  4 ---
>  include/configs/ls1021atsn.h                  |  2 --
>  include/configs/ls1021atwr.h                  |  2 --
>  include/configs/ls1043a_common.h              |  4 ---
>  include/configs/ls1046a_common.h              |  3 --
>  include/configs/ls1088a_common.h              |  1 -
>  include/configs/ls2080a_common.h              |  1 -
>  include/configs/m53menlo.h                    |  1 -
>  include/configs/maxbcm.h                      |  2 --
>  include/configs/microblaze-generic.h          |  3 --
>  include/configs/mt7629.h                      |  1 -
>  include/configs/omapl138_lcdk.h               |  1 -
>  include/configs/openpiton-riscv64.h           |  2 --
>  include/configs/phycore_imx8mm.h              |  1 -
>  include/configs/phycore_imx8mp.h              |  1 -
>  include/configs/pico-imx8mq.h                 |  1 -
>  include/configs/pm9g45.h                      |  1 -
>  include/configs/porter.h                      |  1 -
>  include/configs/px30_common.h                 |  1 -
>  include/configs/rcar-gen3-common.h            |  1 -
>  include/configs/rk3036_common.h               |  2 --
>  include/configs/rk3066_common.h               |  2 --
>  include/configs/rk3188_common.h               |  2 --
>  include/configs/rk3288_common.h               |  2 --
>  include/configs/rk3308_common.h               |  1 -
>  include/configs/rk3328_common.h               |  1 -
>  include/configs/rk3368_common.h               |  1 -
>  include/configs/rk3399_common.h               |  2 --
>  include/configs/rk3568_common.h               |  1 -
>  include/configs/sam9x60_curiosity.h           |  2 --
>  include/configs/sama5d27_som1_ek.h            |  1 -
>  include/configs/sama5d27_wlsom1_ek.h          |  1 -
>  include/configs/sama5d2_icp.h                 |  2 --
>  include/configs/sama5d2_xplained.h            |  1 -
>  include/configs/sama5d3_xplained.h            |  2 --
>  include/configs/sama5d3xek.h                  |  2 --
>  include/configs/sama5d4_xplained.h            |  2 --
>  include/configs/sama5d4ek.h                   |  2 --
>  include/configs/sama7g5ek.h                   |  2 --
>  include/configs/sifive-unleashed.h            |  3 --
>  include/configs/sifive-unmatched.h            |  3 --
>  include/configs/silk.h                        |  1 -
>  include/configs/smartweb.h                    |  1 -
>  include/configs/sniper.h                      |  1 -
>  include/configs/socfpga_common.h              |  4 ---
>  include/configs/socfpga_soc64_common.h        |  3 --
>  include/configs/stm32mp15_common.h            |  2 --
>  include/configs/stout.h                       |  1 -
>  include/configs/sunxi-common.h                |  2 --
>  include/configs/taurus.h                      |  1 -
>  include/configs/tegra114-common.h             |  1 -
>  include/configs/tegra124-common.h             |  1 -
>  include/configs/tegra20-common.h              |  1 -
>  include/configs/tegra30-common.h              |  1 -
>  include/configs/theadorable.h                 |  2 --
>  include/configs/ti_armv7_keystone2.h          |  4 ---
>  include/configs/turris_omnia.h                |  2 --
>  include/configs/uniphier.h                    |  1 -
>  include/configs/verdin-imx8mm.h               |  1 -
>  include/configs/verdin-imx8mp.h               |  1 -
>  include/configs/work_92105.h                  |  1 -
>  include/configs/x530.h                        |  2 --
>  include/configs/xea.h                         |  1 -
>  include/configs/xilinx_zynqmp.h               |  2 --
>  include/configs/zynq-common.h                 |  1 -
>  604 files changed, 829 insertions(+), 220 deletions(-)
>
> diff --git a/README b/README
> index 02a2a3ff8824..360d357bfbc1 100644
> --- a/README
> +++ b/README
> @@ -293,33 +293,6 @@ board_init_r():
>
>         SPL-specific notes:
>         - stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined =
and
> -               CONFIG_SPL_STACK_R_ADDR points into SDRAM
> -       - preloader_console_init() can be called here - typically this is
> -               done by selecting CONFIG_SPL_BOARD_INIT and then supplyin=
g a
> -               spl_board_init() function containing this call
> -       - loads U-Boot or (in falcon mode) Linux
> -
> -
> -Configuration Options:
> -----------------------
> -
> -Configuration depends on the combination of board and CPU type; all
> -such information is kept in a configuration file
> -"include/configs/<board_name>.h".
> -
> -Example: For a TQM823L module, all configuration settings are in
> -"include/configs/TQM823L.h".
> -
> -
> -Many of the options are named exactly as the corresponding Linux
> -kernel configuration options. The intention is to make it easier to
> -build a config tool - later.
> -
> -- ARM Platform Bus Type(CCI):
> -               CoreLink Cache Coherent Interconnect (CCI) is ARM BUS whi=
ch
> -               provides full cache coherency between two clusters of mul=
ti-core
> -               CPUs and I/O coherency for devices and I/O masters
> -
>                 CONFIG_SYS_FSL_HAS_CCI400
>
>                 Defined For SoC that has cache coherent interconnect
> @@ -1659,9 +1632,6 @@ The following options need to be configured:
>                 CONFIG_SPL_BSS_START_ADDR
>                 Link address for the BSS within the SPL binary.
>
> -               CONFIG_SPL_STACK
> -               Adress of the start of the stack SPL will use
> -
>                 CONFIG_SPL_PANIC_ON_RAW_IMAGE
>                 When defined, SPL will panic() if the image it has
>                 loaded does not have a signature.
> @@ -1675,8 +1645,6 @@ The following options need to be configured:
>                 CONFIG_SPL_RELOC_STACK
>                 Adress of the start of the stack SPL will use after
>                 relocation.  If unspecified, this is equal to
> -               CONFIG_SPL_STACK.
> -
>                 CONFIG_SYS_SPL_MALLOC_START
>                 Starting address of the malloc pool used in SPL.
>                 When this option is set the full malloc is used in SPL an=
d
> diff --git a/arch/microblaze/cpu/start.S b/arch/microblaze/cpu/start.S
> index 645f7cb0389d..25e9968e4c65 100644
> --- a/arch/microblaze/cpu/start.S
> +++ b/arch/microblaze/cpu/start.S
> @@ -19,7 +19,7 @@ _start:
>         mts     rslr, r8
>
>  #if defined(CONFIG_SPL_BUILD)
> -       addi    r1, r0, CONFIG_SPL_STACK_ADDR
> +       addi    r1, r0, CONFIG_SPL_STACK
>  #else
>         addi    r1, r0, CONFIG_SYS_INIT_SP_OFFSET
>  #endif
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 3cee3c323e84..89288797513f 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -357,6 +357,24 @@ config TPL_SYS_MALLOC_SIMPLE
>           this will make the TPL binary smaller at the cost of more heap
>           usage as the *_simple malloc functions do not re-use free-ed me=
m.
>
> +config SPL_SHARES_INIT_SP_ADDR
> +       bool "SPL and U-Boot use the same initial stack pointer location"
> +       depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && SPL_FRA=
MEWORK
> +       default n if ARCH_SUNXI
> +       default y
> +       help
> +         In many cases, we can use the same initial stack pointer addres=
s for
> +         both SPL and U-Boot itself.  If you need to specify a different=
 address
> +         however, say N here and then set a different value in CONFIG_SP=
L_STACK.
> +
> +config SPL_STACK
> +       hex "Initial stack pointer location"
> +       depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && SPL_FRA=
MEWORK
> +       depends on !SPL_SHARES_INIT_SP_ADDR
> +       help
> +         Address of the start of the stack SPL will use before SDRAM is
> +         initialized.
> +
>  config SPL_STACK_R
>         bool "Enable SDRAM location for SPL stack"
>         help
> diff --git a/configs/A10-OLinuXino-Lime_defconfig b/configs/A10-OLinuXino=
-Lime_defconfig
> index 07e6e3f00993..026668b0bd06 100644
> --- a/configs/A10-OLinuXino-Lime_defconfig
> +++ b/configs/A10-OLinuXino-Lime_defconfig
> @@ -11,6 +11,7 @@ CONFIG_I2C1_ENABLE=3Dy
>  CONFIG_SATAPWR=3D"PC3"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/A10s-OLinuXino-M_defconfig b/configs/A10s-OLinuXino-=
M_defconfig
> index 2aeaffacd0c8..7e9b92ee5ee4 100644
> --- a/configs/A10s-OLinuXino-M_defconfig
> +++ b/configs/A10s-OLinuXino-M_defconfig
> @@ -9,6 +9,7 @@ CONFIG_MMC1_CD_PIN=3D"PG13"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D1
>  CONFIG_USB1_VBUS_PIN=3D"PB10"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/A13-OLinuXinoM_defconfig b/configs/A13-OLinuXinoM_de=
fconfig
> index 4f39d70f8156..625a331e4456 100644
> --- a/configs/A13-OLinuXinoM_defconfig
> +++ b/configs/A13-OLinuXinoM_defconfig
> @@ -13,6 +13,7 @@ CONFIG_VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH=3Dy
>  CONFIG_VIDEO_LCD_POWER=3D"PB10"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
>  CONFIG_SYS_I2C_SLAVE=3D0x7f
> diff --git a/configs/A13-OLinuXino_defconfig b/configs/A13-OLinuXino_defc=
onfig
> index 0746061317bc..5e0396c150fa 100644
> --- a/configs/A13-OLinuXino_defconfig
> +++ b/configs/A13-OLinuXino_defconfig
> @@ -15,6 +15,7 @@ CONFIG_VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH=3Dy
>  CONFIG_VIDEO_LCD_POWER=3D"AXP0-0"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_CMD_DFU=3Dy
> diff --git a/configs/A20-OLinuXino-Lime2-eMMC_defconfig b/configs/A20-OLi=
nuXino-Lime2-eMMC_defconfig
> index 45f9e9e07d04..e0db1e673882 100644
> --- a/configs/A20-OLinuXino-Lime2-eMMC_defconfig
> +++ b/configs/A20-OLinuXino-Lime2-eMMC_defconfig
> @@ -13,6 +13,7 @@ CONFIG_SATAPWR=3D"PC3"
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_CMD_DFU=3Dy
> diff --git a/configs/A20-OLinuXino-Lime2_defconfig b/configs/A20-OLinuXin=
o-Lime2_defconfig
> index 187d8a5e6b6d..a78cbfb1391a 100644
> --- a/configs/A20-OLinuXino-Lime2_defconfig
> +++ b/configs/A20-OLinuXino-Lime2_defconfig
> @@ -11,6 +11,7 @@ CONFIG_I2C1_ENABLE=3Dy
>  CONFIG_SATAPWR=3D"PC3"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_CMD_DFU=3Dy
> diff --git a/configs/A20-OLinuXino-Lime_defconfig b/configs/A20-OLinuXino=
-Lime_defconfig
> index 1964fb6aa3de..da3532ccc463 100644
> --- a/configs/A20-OLinuXino-Lime_defconfig
> +++ b/configs/A20-OLinuXino-Lime_defconfig
> @@ -9,6 +9,7 @@ CONFIG_I2C1_ENABLE=3Dy
>  CONFIG_SATAPWR=3D"PC3"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/A20-OLinuXino_MICRO-eMMC_defconfig b/configs/A20-OLi=
nuXino_MICRO-eMMC_defconfig
> index e4892cc5176e..0563a5188e65 100644
> --- a/configs/A20-OLinuXino_MICRO-eMMC_defconfig
> +++ b/configs/A20-OLinuXino_MICRO-eMMC_defconfig
> @@ -11,6 +11,7 @@ CONFIG_VIDEO_VGA=3Dy
>  CONFIG_SATAPWR=3D"PB8"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/A20-OLinuXino_MICRO_defconfig b/configs/A20-OLinuXin=
o_MICRO_defconfig
> index e491e73ccba8..4993cf7d2d71 100644
> --- a/configs/A20-OLinuXino_MICRO_defconfig
> +++ b/configs/A20-OLinuXino_MICRO_defconfig
> @@ -12,6 +12,7 @@ CONFIG_VIDEO_VGA=3Dy
>  CONFIG_SATAPWR=3D"PB8"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/A20-Olimex-SOM-EVB_defconfig b/configs/A20-Olimex-SO=
M-EVB_defconfig
> index 3685a93ca50a..0db97ae8415a 100644
> --- a/configs/A20-Olimex-SOM-EVB_defconfig
> +++ b/configs/A20-Olimex-SOM-EVB_defconfig
> @@ -12,6 +12,7 @@ CONFIG_USB0_VBUS_DET=3D"PH5"
>  CONFIG_SATAPWR=3D"PC3"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig b/configs/A20-O=
limex-SOM204-EVB-eMMC_defconfig
> index 24294daaaf8b..91d29e44469b 100644
> --- a/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
> +++ b/configs/A20-Olimex-SOM204-EVB-eMMC_defconfig
> @@ -13,6 +13,7 @@ CONFIG_SATAPWR=3D"PC3"
>  CONFIG_GMAC_TX_DELAY=3D4
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/A20-Olimex-SOM204-EVB_defconfig b/configs/A20-Olimex=
-SOM204-EVB_defconfig
> index 5dd6f77b7b6b..893f2e627d5c 100644
> --- a/configs/A20-Olimex-SOM204-EVB_defconfig
> +++ b/configs/A20-Olimex-SOM204-EVB_defconfig
> @@ -12,6 +12,7 @@ CONFIG_SATAPWR=3D"PC3"
>  CONFIG_GMAC_TX_DELAY=3D4
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/A33-OLinuXino_defconfig b/configs/A33-OLinuXino_defc=
onfig
> index 786fc6cf376b..c9eec1f88790 100644
> --- a/configs/A33-OLinuXino_defconfig
> +++ b/configs/A33-OLinuXino_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_DCLK_PHASE=3D0
>  CONFIG_VIDEO_LCD_BL_EN=3D"PB2"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DCDC1_VOLT=3D3300
>  CONFIG_USB_MUSB_HOST=3Dy
> diff --git a/configs/Ainol_AW1_defconfig b/configs/Ainol_AW1_defconfig
> index 89cad5d6c784..8cd38f7905bb 100644
> --- a/configs/Ainol_AW1_defconfig
> +++ b/configs/Ainol_AW1_defconfig
> @@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH8"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Ampe_A76_defconfig b/configs/Ampe_A76_defconfig
> index b00392437094..68707ed3e951 100644
> --- a/configs/Ampe_A76_defconfig
> +++ b/configs/Ampe_A76_defconfig
> @@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_POWER=3D"AXP0-0"
>  CONFIG_VIDEO_LCD_BL_EN=3D"AXP0-1"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Auxtek-T003_defconfig b/configs/Auxtek-T003_defconfi=
g
> index 0f38a85f9f8c..703df186b27f 100644
> --- a/configs/Auxtek-T003_defconfig
> +++ b/configs/Auxtek-T003_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DRAM_EMR1=3D0
>  CONFIG_USB1_VBUS_PIN=3D"PB10"
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Auxtek-T004_defconfig b/configs/Auxtek-T004_defconfi=
g
> index f201bd108197..a8d236eaf9d9 100644
> --- a/configs/Auxtek-T004_defconfig
> +++ b/configs/Auxtek-T004_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN5I=3Dy
>  CONFIG_DRAM_CLK=3D432
>  CONFIG_USB1_VBUS_PIN=3D"PG13"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Bananapi_M2_Ultra_defconfig b/configs/Bananapi_M2_Ul=
tra_defconfig
> index 79eb3ede7725..7d9c688171d4 100644
> --- a/configs/Bananapi_M2_Ultra_defconfig
> +++ b/configs/Bananapi_M2_Ultra_defconfig
> @@ -12,6 +12,7 @@ CONFIG_USB2_VBUS_PIN=3D"PH23"
>  # CONFIG_HAS_ARMV7_SECURE_BASE is not set
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Bananapi_defconfig b/configs/Bananapi_defconfig
> index f1b0b6da8f2f..6cc2d5b64720 100644
> --- a/configs/Bananapi_defconfig
> +++ b/configs/Bananapi_defconfig
> @@ -9,6 +9,7 @@ CONFIG_VIDEO_COMPOSITE=3Dy
>  CONFIG_GMAC_TX_DELAY=3D3
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_NETCONSOLE=3Dy
> diff --git a/configs/Bananapi_m2m_defconfig b/configs/Bananapi_m2m_defcon=
fig
> index ba26aa1861a3..6a07f26c02c4 100644
> --- a/configs/Bananapi_m2m_defconfig
> +++ b/configs/Bananapi_m2m_defconfig
> @@ -10,6 +10,7 @@ CONFIG_MMC0_CD_PIN=3D"PB4"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_USB0_ID_DET=3D"PH8"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/Bananapro_defconfig b/configs/Bananapro_defconfig
> index 9214a9b69604..19b644613a6c 100644
> --- a/configs/Bananapro_defconfig
> +++ b/configs/Bananapro_defconfig
> @@ -11,6 +11,7 @@ CONFIG_VIDEO_COMPOSITE=3Dy
>  CONFIG_GMAC_TX_DELAY=3D3
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_NETCONSOLE=3Dy
> diff --git a/configs/CHIP_defconfig b/configs/CHIP_defconfig
> index be092cd0949d..40d2c5b668af 100644
> --- a/configs/CHIP_defconfig
> +++ b/configs/CHIP_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_TIMINGS_DDR3_800E_1066G_1333J=3Dy
>  CONFIG_USB0_VBUS_PIN=3D"PB10"
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  CONFIG_CHIP_DIP_SCAN=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_CMD_DFU=3Dy
> diff --git a/configs/CHIP_pro_defconfig b/configs/CHIP_pro_defconfig
> index 16456c1dea54..90168010bb8e 100644
> --- a/configs/CHIP_pro_defconfig
> +++ b/configs/CHIP_pro_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN5I=3Dy
>  CONFIG_DRAM_TIMINGS_DDR3_800E_1066G_1333J=3Dy
>  CONFIG_USB0_VBUS_PIN=3D"PB10"
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  # CONFIG_CMD_FLASH is not set
> diff --git a/configs/CSQ_CS908_defconfig b/configs/CSQ_CS908_defconfig
> index f79bc78f24d6..49be3fc4a2d2 100644
> --- a/configs/CSQ_CS908_defconfig
> +++ b/configs/CSQ_CS908_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D432
>  CONFIG_USB1_VBUS_PIN=3D""
>  CONFIG_USB2_VBUS_PIN=3D""
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/Chuwi_V7_CW0825_defconfig b/configs/Chuwi_V7_CW0825_=
defconfig
> index d517ab9a7ca4..b59d1786e6ef 100644
> --- a/configs/Chuwi_V7_CW0825_defconfig
> +++ b/configs/Chuwi_V7_CW0825_defconfig
> @@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  CONFIG_VIDEO_LCD_PANEL_HITACHI_TX18D42VM=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Colombus_defconfig b/configs/Colombus_defconfig
> index 5f1946061218..24b55bfa8cc9 100644
> --- a/configs/Colombus_defconfig
> +++ b/configs/Colombus_defconfig
> @@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PM1"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH13"
>  CONFIG_VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Cubieboard2_defconfig b/configs/Cubieboard2_defconfi=
g
> index 0be8a07aa62c..794d6668d2f8 100644
> --- a/configs/Cubieboard2_defconfig
> +++ b/configs/Cubieboard2_defconfig
> @@ -8,6 +8,7 @@ CONFIG_MMC0_CD_PIN=3D"PH1"
>  CONFIG_SATAPWR=3D"PB8"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Cubieboard4_defconfig b/configs/Cubieboard4_defconfi=
g
> index 82b3ac10f965..928299e8a513 100644
> --- a/configs/Cubieboard4_defconfig
> +++ b/configs/Cubieboard4_defconfig
> @@ -12,6 +12,7 @@ CONFIG_USB0_ID_DET=3D"PH16"
>  CONFIG_USB1_VBUS_PIN=3D"PH14"
>  CONFIG_USB3_VBUS_PIN=3D"PH15"
>  CONFIG_AXP_GPIO=3Dy
> +CONFIG_SPL_STACK=3D0x18000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_SUN8I_RSB=3Dy
>  CONFIG_AXP809_POWER=3Dy
> diff --git a/configs/Cubieboard_defconfig b/configs/Cubieboard_defconfig
> index 31d4fb4709fb..1027c5e3bf95 100644
> --- a/configs/Cubieboard_defconfig
> +++ b/configs/Cubieboard_defconfig
> @@ -8,6 +8,7 @@ CONFIG_MMC0_CD_PIN=3D"PH1"
>  CONFIG_SATAPWR=3D"PB8"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Cubietruck_defconfig b/configs/Cubietruck_defconfig
> index fc692ff761a7..560248dc5b17 100644
> --- a/configs/Cubietruck_defconfig
> +++ b/configs/Cubietruck_defconfig
> @@ -13,6 +13,7 @@ CONFIG_SATAPWR=3D"PH12"
>  CONFIG_GMAC_TX_DELAY=3D1
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_CMD_DFU=3Dy
> diff --git a/configs/Cubietruck_plus_defconfig b/configs/Cubietruck_plus_=
defconfig
> index cbd77cfc0294..8119b8b9cf6b 100644
> --- a/configs/Cubietruck_plus_defconfig
> +++ b/configs/Cubietruck_plus_defconfig
> @@ -16,6 +16,7 @@ CONFIG_I2C0_ENABLE=3Dy
>  CONFIG_AXP_GPIO=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Empire_electronix_d709_defconfig b/configs/Empire_el=
ectronix_d709_defconfig
> index d1b76663fbcc..0187b896f873 100644
> --- a/configs/Empire_electronix_d709_defconfig
> +++ b/configs/Empire_electronix_d709_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_POWER=3D"AXP0-0"
>  CONFIG_VIDEO_LCD_BL_EN=3D"AXP0-1"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Empire_electronix_m712_defconfig b/configs/Empire_el=
ectronix_m712_defconfig
> index e2d8a21a64a5..6570b97ca4c6 100644
> --- a/configs/Empire_electronix_m712_defconfig
> +++ b/configs/Empire_electronix_m712_defconfig
> @@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_POWER=3D"AXP0-0"
>  CONFIG_VIDEO_LCD_BL_EN=3D"AXP0-1"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Hummingbird_A31_defconfig b/configs/Hummingbird_A31_=
defconfig
> index 20144b230287..3afe4c56ae4d 100644
> --- a/configs/Hummingbird_A31_defconfig
> +++ b/configs/Hummingbird_A31_defconfig
> @@ -9,6 +9,7 @@ CONFIG_USB2_VBUS_PIN=3D""
>  CONFIG_VIDEO_VGA_VIA_LCD=3Dy
>  CONFIG_VIDEO_VGA_EXTERNAL_DAC_EN=3D"PH25"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/Hyundai_A7HD_defconfig b/configs/Hyundai_A7HD_defcon=
fig
> index 0c655b24e76c..8bf7d1efba61 100644
> --- a/configs/Hyundai_A7HD_defconfig
> +++ b/configs/Hyundai_A7HD_defconfig
> @@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_VIDEO_LCD_BL_PWM_ACTIVE_LOW is not set
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Itead_Ibox_A20_defconfig b/configs/Itead_Ibox_A20_de=
fconfig
> index b8f1350c8789..42cb24e88ef7 100644
> --- a/configs/Itead_Ibox_A20_defconfig
> +++ b/configs/Itead_Ibox_A20_defconfig
> @@ -8,6 +8,7 @@ CONFIG_MMC0_CD_PIN=3D"PH1"
>  CONFIG_SATAPWR=3D"PB8"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Lamobo_R1_defconfig b/configs/Lamobo_R1_defconfig
> index 8b25863b30c8..d4692f8184a5 100644
> --- a/configs/Lamobo_R1_defconfig
> +++ b/configs/Lamobo_R1_defconfig
> @@ -10,6 +10,7 @@ CONFIG_SATAPWR=3D"PB3"
>  CONFIG_GMAC_TX_DELAY=3D4
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defc=
onfig
> index 5bc36f29680a..2e0b0b71e140 100644
> --- a/configs/LicheePi_Zero_defconfig
> +++ b/configs/LicheePi_Zero_defconfig
> @@ -5,5 +5,6 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_V3S=3Dy
>  CONFIG_DRAM_CLK=3D360
>  # CONFIG_HAS_ARMV7_SECURE_BASE is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  # CONFIG_NETDEVICES is not set
> diff --git a/configs/Linksprite_pcDuino3_Nano_defconfig b/configs/Linkspr=
ite_pcDuino3_Nano_defconfig
> index 37726bedf89b..dbafdd5bd80c 100644
> --- a/configs/Linksprite_pcDuino3_Nano_defconfig
> +++ b/configs/Linksprite_pcDuino3_Nano_defconfig
> @@ -10,6 +10,7 @@ CONFIG_SATAPWR=3D"PH2"
>  CONFIG_GMAC_TX_DELAY=3D3
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Linksprite_pcDuino3_defconfig b/configs/Linksprite_p=
cDuino3_defconfig
> index 4545bdcd999d..ff6a4e8b3794 100644
> --- a/configs/Linksprite_pcDuino3_defconfig
> +++ b/configs/Linksprite_pcDuino3_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DRAM_ZQ=3D122
>  CONFIG_SATAPWR=3D"PH2"
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Linksprite_pcDuino_defconfig b/configs/Linksprite_pc=
Duino_defconfig
> index c671bab2e7ae..279641551b30 100644
> --- a/configs/Linksprite_pcDuino_defconfig
> +++ b/configs/Linksprite_pcDuino_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN4I=3Dy
>  CONFIG_USB1_VBUS_PIN=3D""
>  CONFIG_USB2_VBUS_PIN=3D""
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/MK808C_defconfig b/configs/MK808C_defconfig
> index f4d31b392405..4e678bdf051f 100644
> --- a/configs/MK808C_defconfig
> +++ b/configs/MK808C_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN7I=3Dy
>  CONFIG_DRAM_CLK=3D384
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/MSI_Primo73_defconfig b/configs/MSI_Primo73_defconfi=
g
> index 5a43945596a6..7a4b224bf2a1 100644
> --- a/configs/MSI_Primo73_defconfig
> +++ b/configs/MSI_Primo73_defconfig
> @@ -10,6 +10,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH8"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/MSI_Primo81_defconfig b/configs/MSI_Primo81_defconfi=
g
> index de1b6884b8f9..bb820fd0a39f 100644
> --- a/configs/MSI_Primo81_defconfig
> +++ b/configs/MSI_Primo81_defconfig
> @@ -13,6 +13,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PA25"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH13"
>  CONFIG_VIDEO_LCD_PANEL_MIPI_4_LANE_513_MBPS_VIA_SSD2828=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> diff --git a/configs/Marsboard_A10_defconfig b/configs/Marsboard_A10_defc=
onfig
> index 8ba587db9cbd..c88cfd6aa321 100644
> --- a/configs/Marsboard_A10_defconfig
> +++ b/configs/Marsboard_A10_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN4I=3Dy
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Mele_A1000G_quad_defconfig b/configs/Mele_A1000G_qua=
d_defconfig
> index 13f418fb0cc3..8ee6791408a0 100644
> --- a/configs/Mele_A1000G_quad_defconfig
> +++ b/configs/Mele_A1000G_quad_defconfig
> @@ -8,6 +8,7 @@ CONFIG_INITIAL_USB_SCAN_DELAY=3D2000
>  CONFIG_USB1_VBUS_PIN=3D"PC27"
>  CONFIG_USB2_VBUS_PIN=3D""
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/Mele_A1000_defconfig b/configs/Mele_A1000_defconfig
> index a62ca5d2f18c..429baf3faf29 100644
> --- a/configs/Mele_A1000_defconfig
> +++ b/configs/Mele_A1000_defconfig
> @@ -8,6 +8,7 @@ CONFIG_VIDEO_VGA=3Dy
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Mele_I7_defconfig b/configs/Mele_I7_defconfig
> index 62cb674d2950..48dad606b884 100644
> --- a/configs/Mele_I7_defconfig
> +++ b/configs/Mele_I7_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_ZQ=3D120
>  CONFIG_USB1_VBUS_PIN=3D"PC27"
>  CONFIG_USB2_VBUS_PIN=3D""
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/Mele_M3_defconfig b/configs/Mele_M3_defconfig
> index fce30278d496..ce962395a253 100644
> --- a/configs/Mele_M3_defconfig
> +++ b/configs/Mele_M3_defconfig
> @@ -9,6 +9,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_VIDEO_VGA=3Dy
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Mele_M5_defconfig b/configs/Mele_M5_defconfig
> index 79ea3f0db29b..a426729700e9 100644
> --- a/configs/Mele_M5_defconfig
> +++ b/configs/Mele_M5_defconfig
> @@ -9,6 +9,7 @@ CONFIG_MMC0_CD_PIN=3D"PH1"
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Mele_M9_defconfig b/configs/Mele_M9_defconfig
> index 1338e0973dbe..b84a2aebe206 100644
> --- a/configs/Mele_M9_defconfig
> +++ b/configs/Mele_M9_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_ZQ=3D120
>  CONFIG_USB1_VBUS_PIN=3D"PC27"
>  CONFIG_USB2_VBUS_PIN=3D""
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/Merrii_A80_Optimus_defconfig b/configs/Merrii_A80_Op=
timus_defconfig
> index 5f008a206e76..3709a11ec036 100644
> --- a/configs/Merrii_A80_Optimus_defconfig
> +++ b/configs/Merrii_A80_Optimus_defconfig
> @@ -12,6 +12,7 @@ CONFIG_USB0_ID_DET=3D"PH3"
>  CONFIG_USB1_VBUS_PIN=3D"PH4"
>  CONFIG_USB3_VBUS_PIN=3D"PH5"
>  CONFIG_AXP_GPIO=3Dy
> +CONFIG_SPL_STACK=3D0x18000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_SUN8I_RSB=3Dy
>  CONFIG_AXP809_POWER=3Dy
> diff --git a/configs/Mini-X_defconfig b/configs/Mini-X_defconfig
> index 61f880e15d95..76b6b7d2bce7 100644
> --- a/configs/Mini-X_defconfig
> +++ b/configs/Mini-X_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN4I=3Dy
>  CONFIG_USB0_VBUS_PIN=3D"PB9"
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Nintendo_NES_Classic_Edition_defconfig b/configs/Nin=
tendo_NES_Classic_Edition_defconfig
> index a26695ca1675..1a939d8e0e01 100644
> --- a/configs/Nintendo_NES_Classic_Edition_defconfig
> +++ b/configs/Nintendo_NES_Classic_Edition_defconfig
> @@ -9,6 +9,7 @@ CONFIG_DRAM_ODT_EN=3Dy
>  CONFIG_USB0_VBUS_DET=3D"AXP0-VBUS-DETECT"
>  CONFIG_AXP_GPIO=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  # CONFIG_CMD_FLASH is not set
>  CONFIG_CMD_MTDPARTS=3Dy
> diff --git a/configs/Orangepi_defconfig b/configs/Orangepi_defconfig
> index eed986aa15c2..e7cf38ac7d1f 100644
> --- a/configs/Orangepi_defconfig
> +++ b/configs/Orangepi_defconfig
> @@ -12,6 +12,7 @@ CONFIG_VIDEO_COMPOSITE=3Dy
>  CONFIG_GMAC_TX_DELAY=3D3
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Orangepi_mini_defconfig b/configs/Orangepi_mini_defc=
onfig
> index 974826baed0c..494edf0625ea 100644
> --- a/configs/Orangepi_mini_defconfig
> +++ b/configs/Orangepi_mini_defconfig
> @@ -14,6 +14,7 @@ CONFIG_VIDEO_COMPOSITE=3Dy
>  CONFIG_GMAC_TX_DELAY=3D3
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Sinlinx_SinA31s_defconfig b/configs/Sinlinx_SinA31s_=
defconfig
> index 4495b806ceb5..2d33331f3d3d 100644
> --- a/configs/Sinlinx_SinA31s_defconfig
> +++ b/configs/Sinlinx_SinA31s_defconfig
> @@ -10,6 +10,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=3D3
>  CONFIG_USB1_VBUS_PIN=3D""
>  CONFIG_USB2_VBUS_PIN=3D""
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/Sinlinx_SinA33_defconfig b/configs/Sinlinx_SinA33_de=
fconfig
> index 0f30dfc1dc98..fcee14b5462b 100644
> --- a/configs/Sinlinx_SinA33_defconfig
> +++ b/configs/Sinlinx_SinA33_defconfig
> @@ -13,6 +13,7 @@ CONFIG_VIDEO_LCD_DCLK_PHASE=3D0
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_CMD_DFU=3Dy
>  CONFIG_DFU_RAM=3Dy
> diff --git a/configs/Sinovoip_BPI_M2_defconfig b/configs/Sinovoip_BPI_M2_=
defconfig
> index ebb9e3522644..c080a247105e 100644
> --- a/configs/Sinovoip_BPI_M2_defconfig
> +++ b/configs/Sinovoip_BPI_M2_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D432
>  CONFIG_USB1_VBUS_PIN=3D""
>  CONFIG_USB2_VBUS_PIN=3D""
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/Sinovoip_BPI_M3_defconfig b/configs/Sinovoip_BPI_M3_=
defconfig
> index 23240a138c43..32ec5deca7d8 100644
> --- a/configs/Sinovoip_BPI_M3_defconfig
> +++ b/configs/Sinovoip_BPI_M3_defconfig
> @@ -17,6 +17,7 @@ CONFIG_AXP_GPIO=3Dy
>  CONFIG_SATAPWR=3D"PD25"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_SUN8I_EMAC=3Dy
> diff --git a/configs/Sunchip_CX-A99_defconfig b/configs/Sunchip_CX-A99_de=
fconfig
> index ee0c15b9c0a6..749bf1cff9db 100644
> --- a/configs/Sunchip_CX-A99_defconfig
> +++ b/configs/Sunchip_CX-A99_defconfig
> @@ -12,4 +12,5 @@ CONFIG_USB0_VBUS_PIN=3D"PH15"
>  CONFIG_USB1_VBUS_PIN=3D"PL7"
>  CONFIG_USB3_VBUS_PIN=3D"PL8"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x18000
>  CONFIG_SYS_PBSIZE=3D1024
> diff --git a/configs/UTOO_P66_defconfig b/configs/UTOO_P66_defconfig
> index 64ab3821890c..4e6652db18f6 100644
> --- a/configs/UTOO_P66_defconfig
> +++ b/configs/UTOO_P66_defconfig
> @@ -20,6 +20,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"AXP0-1"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  CONFIG_VIDEO_LCD_TL059WV5C0=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Wexler_TAB7200_defconfig b/configs/Wexler_TAB7200_de=
fconfig
> index 9ecb64b3d565..f63d18c327fa 100644
> --- a/configs/Wexler_TAB7200_defconfig
> +++ b/configs/Wexler_TAB7200_defconfig
> @@ -13,6 +13,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH8"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Wits_Pro_A20_DKT_defconfig b/configs/Wits_Pro_A20_DK=
T_defconfig
> index 7deea8af63e3..09608dd1cc2a 100644
> --- a/configs/Wits_Pro_A20_DKT_defconfig
> +++ b/configs/Wits_Pro_A20_DKT_defconfig
> @@ -12,6 +12,7 @@ CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/Wobo_i5_defconfig b/configs/Wobo_i5_defconfig
> index 95279c3ccc92..ab919c0795a8 100644
> --- a/configs/Wobo_i5_defconfig
> +++ b/configs/Wobo_i5_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D432
>  CONFIG_MMC0_CD_PIN=3D"PB3"
>  CONFIG_USB1_VBUS_PIN=3D"PG12"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Yones_Toptech_BD1078_defconfig b/configs/Yones_Topte=
ch_BD1078_defconfig
> index 89196e8ba28c..1117e147cc17 100644
> --- a/configs/Yones_Toptech_BD1078_defconfig
> +++ b/configs/Yones_Toptech_BD1078_defconfig
> @@ -19,6 +19,7 @@ CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_VIDEO_LCD_BL_PWM_ACTIVE_LOW is not set
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/Yones_Toptech_BS1078_V2_defconfig b/configs/Yones_To=
ptech_BS1078_V2_defconfig
> index a14881b32933..ef30aee82815 100644
> --- a/configs/Yones_Toptech_BS1078_V2_defconfig
> +++ b/configs/Yones_Toptech_BS1078_V2_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PA25"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH13"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_USB_MUSB_HOST=3Dy
> diff --git a/configs/a64-olinuxino-emmc_defconfig b/configs/a64-olinuxino=
-emmc_defconfig
> index 6a1289758aae..7d8e7649f2a5 100644
> --- a/configs/a64-olinuxino-emmc_defconfig
> +++ b/configs/a64-olinuxino-emmc_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN50I=3Dy
>  CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=3Dy
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_SUN8I_EMAC=3Dy
> diff --git a/configs/a64-olinuxino_defconfig b/configs/a64-olinuxino_defc=
onfig
> index 89618ac6a701..06f51a8f8d31 100644
> --- a/configs/a64-olinuxino_defconfig
> +++ b/configs/a64-olinuxino_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN50I=3Dy
>  CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=3Dy
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/alt_defconfig b/configs/alt_defconfig
> index 897b3a230e2e..4e73e6af7d74 100644
> --- a/configs/alt_defconfig
> +++ b/configs/alt_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_MAX_SIZE=3D0x4000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6340000
>  CONFIG_SPL_RAM_SUPPORT=3Dy
>  CONFIG_SPL_RAM_DEVICE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/amarula_a64_relic_defconfig b/configs/amarula_a64_re=
lic_defconfig
> index 2811667c5115..0e173c28c12a 100644
> --- a/configs/amarula_a64_relic_defconfig
> +++ b/configs/amarula_a64_relic_defconfig
> @@ -7,6 +7,7 @@ CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=3Dy
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_VIDEO_DE2 is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
> diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
> index 548ff2e21523..3c004695897d 100644
> --- a/configs/apalis-tk1_defconfig
> +++ b/configs/apalis-tk1_defconfig
> @@ -23,6 +23,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_ARCH_MISC_INIT=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Apalis TK1 # "
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_SYS_CBSIZE=3D1024
> diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfi=
g
> index 11ee2f3d34a9..96483af9442c 100644
> --- a/configs/apalis_imx6_defconfig
> +++ b/configs/apalis_imx6_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
> diff --git a/configs/apalis_t30_defconfig b/configs/apalis_t30_defconfig
> index b665ca2f4b44..5b31d4c9943c 100644
> --- a/configs/apalis_t30_defconfig
> +++ b/configs/apalis_t30_defconfig
> @@ -19,6 +19,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_ARCH_MISC_INIT=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Apalis T30 # "
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_SYS_CBSIZE=3D1024
> diff --git a/configs/avnet_ultrazedev_cc_v1_0_ultrazedev_som_v1_0_defconf=
ig b/configs/avnet_ultrazedev_cc_v1_0_ultrazedev_som_v1_0_defconfig
> index 8f610c42e045..d9330d049dda 100644
> --- a/configs/avnet_ultrazedev_cc_v1_0_ultrazedev_som_v1_0_defconfig
> +++ b/configs/avnet_ultrazedev_cc_v1_0_ultrazedev_som_v1_0_defconfig
> @@ -30,6 +30,8 @@ CONFIG_BOOTDELAY=3D0
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffffc
>  CONFIG_SPL_FS_LOAD_KERNEL_NAME=3D"atf-uboot.ub"
>  CONFIG_SPL_FS_LOAD_ARGS_NAME=3D"u-boot.bin"
>  CONFIG_SPL_OS_BOOT=3Dy
> diff --git a/configs/axm_defconfig b/configs/axm_defconfig
> index 1d49c196f3f9..2a5458b5214b 100644
> --- a/configs/axm_defconfig
> +++ b/configs/axm_defconfig
> @@ -40,6 +40,8 @@ CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x600
>  # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x304000
>  CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_RAW_ONLY=3Dy
> diff --git a/configs/ba10_tv_box_defconfig b/configs/ba10_tv_box_defconfi=
g
> index b14731554b78..66c444fc7507 100644
> --- a/configs/ba10_tv_box_defconfig
> +++ b/configs/ba10_tv_box_defconfig
> @@ -9,6 +9,7 @@ CONFIG_USB0_VBUS_PIN=3D"PB9"
>  CONFIG_USB2_VBUS_PIN=3D"PH12"
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/bananapi_m1_plus_defconfig b/configs/bananapi_m1_plu=
s_defconfig
> index 1b5f6ba4d39c..955a60ddc34d 100644
> --- a/configs/bananapi_m1_plus_defconfig
> +++ b/configs/bananapi_m1_plus_defconfig
> @@ -9,6 +9,7 @@ CONFIG_VIDEO_COMPOSITE=3Dy
>  CONFIG_GMAC_TX_DELAY=3D3
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_NETCONSOLE=3Dy
> diff --git a/configs/bananapi_m2_berry_defconfig b/configs/bananapi_m2_be=
rry_defconfig
> index d7d7ced9d9bf..08f7683233cf 100644
> --- a/configs/bananapi_m2_berry_defconfig
> +++ b/configs/bananapi_m2_berry_defconfig
> @@ -9,6 +9,7 @@ CONFIG_USB1_VBUS_PIN=3D"PH23"
>  # CONFIG_HAS_ARMV7_SECURE_BASE is not set
>  CONFIG_AHCI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SCSI_AHCI=3Dy
> diff --git a/configs/bananapi_m2_plus_h3_defconfig b/configs/bananapi_m2_=
plus_h3_defconfig
> index d706c9a4e17f..d0981f6481af 100644
> --- a/configs/bananapi_m2_plus_h3_defconfig
> +++ b/configs/bananapi_m2_plus_h3_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D672
>  CONFIG_MACPWR=3D"PD6"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/bananapi_m2_plus_h5_defconfig b/configs/bananapi_m2_=
plus_h5_defconfig
> index 111e037ee57e..0fb1bda1c6ef 100644
> --- a/configs/bananapi_m2_plus_h5_defconfig
> +++ b/configs/bananapi_m2_plus_h5_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D672
>  CONFIG_MACPWR=3D"PD6"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/bananapi_m2_zero_defconfig b/configs/bananapi_m2_zer=
o_defconfig
> index 74c164c27c56..6a3594c0938d 100644
> --- a/configs/bananapi_m2_zero_defconfig
> +++ b/configs/bananapi_m2_zero_defconfig
> @@ -6,4 +6,5 @@ CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D408
>  CONFIG_MMC0_CD_PIN=3D""
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
> diff --git a/configs/bananapi_m64_defconfig b/configs/bananapi_m64_defcon=
fig
> index 6c1aa1ae7432..5d1d10a0918c 100644
> --- a/configs/bananapi_m64_defconfig
> +++ b/configs/bananapi_m64_defconfig
> @@ -7,6 +7,7 @@ CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=3Dy
>  CONFIG_MMC0_CD_PIN=3D"PH13"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_SUN8I_EMAC=3Dy
> diff --git a/configs/beaver_defconfig b/configs/beaver_defconfig
> index d61f25376f53..e0e4393d3904 100644
> --- a/configs/beaver_defconfig
> +++ b/configs/beaver_defconfig
> @@ -16,6 +16,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Tegra30 (Beaver) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2084
> diff --git a/configs/beelink_gs1_defconfig b/configs/beelink_gs1_defconfi=
g
> index 339e6c9e3c9c..6453a72a7d78 100644
> --- a/configs/beelink_gs1_defconfig
> +++ b/configs/beelink_gs1_defconfig
> @@ -8,6 +8,7 @@ CONFIG_MMC0_CD_PIN=3D"PF6"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_PSCI_RESET is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x118000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_LED=3Dy
>  CONFIG_LED_GPIO=3Dy
> diff --git a/configs/beelink_x2_defconfig b/configs/beelink_x2_defconfig
> index 432079a6ad35..4065e64d523f 100644
> --- a/configs/beelink_x2_defconfig
> +++ b/configs/beelink_x2_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D567
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/bitmain_antminer_s9_defconfig b/configs/bitmain_antm=
iner_s9_defconfig
> index be5b8a0a3291..02a8435fbcd5 100644
> --- a/configs/bitmain_antminer_s9_defconfig
> +++ b/configs/bitmain_antminer_s9_defconfig
> @@ -29,6 +29,8 @@ CONFIG_USE_PREBOOT=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x30000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffe00
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_PROMPT=3D"antminer> "
> diff --git a/configs/brppt2_defconfig b/configs/brppt2_defconfig
> index b9f3587bdaaf..af91188b69c4 100644
> --- a/configs/brppt2_defconfig
> +++ b/configs/brppt2_defconfig
> @@ -32,6 +32,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run b_default"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
> diff --git a/configs/cardhu_defconfig b/configs/cardhu_defconfig
> index 92729c3179f0..2b73fa22d8a9 100644
> --- a/configs/cardhu_defconfig
> +++ b/configs/cardhu_defconfig
> @@ -15,6 +15,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Tegra30 (Cardhu) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2084
> diff --git a/configs/cei-tk1-som_defconfig b/configs/cei-tk1-som_defconfi=
g
> index 0e583194a13a..7bf45bae4e5a 100644
> --- a/configs/cei-tk1-som_defconfig
> +++ b/configs/cei-tk1-som_defconfig
> @@ -17,6 +17,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Tegra124 (TK1-SOM) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2086
> diff --git a/configs/cgtqmx8_defconfig b/configs/cgtqmx8_defconfig
> index 112a9860d833..d60437884c9c 100644
> --- a/configs/cgtqmx8_defconfig
> +++ b/configs/cgtqmx8_defconfig
> @@ -31,6 +31,8 @@ CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x13e000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x800
>  CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=3D0
> diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_micke=
y_defconfig
> index 0225e108b537..862b37d0fb64 100644
> --- a/configs/chromebit_mickey_defconfig
> +++ b/configs/chromebit_mickey_defconfig
> @@ -28,6 +28,8 @@ CONFIG_BOARD_EARLY_INIT_R=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_de=
fconfig
> index d5676b5ea7a1..21943010f4ed 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -33,6 +33,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x10000
>  CONFIG_HANDOFF=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff8effff
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x4000
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerr=
y_defconfig
> index 89990e51b783..a0f15f6e7b2d 100644
> --- a/configs/chromebook_jerry_defconfig
> +++ b/configs/chromebook_jerry_defconfig
> @@ -29,6 +29,8 @@ CONFIG_BOARD_EARLY_INIT_R=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevi=
n_defconfig
> index 5d95c9e68a6e..7f773fcf90ca 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x10000
>  CONFIG_HANDOFF=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff8effff
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x4000
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_min=
nie_defconfig
> index 7542d4fb21b1..513e5f85e9cb 100644
> --- a/configs/chromebook_minnie_defconfig
> +++ b/configs/chromebook_minnie_defconfig
> @@ -29,6 +29,8 @@ CONFIG_BOARD_EARLY_INIT_R=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
> diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_spe=
edy_defconfig
> index 2aaa997ef81a..7fc505ee4e36 100644
> --- a/configs/chromebook_speedy_defconfig
> +++ b/configs/chromebook_speedy_defconfig
> @@ -29,6 +29,8 @@ CONFIG_BOARD_EARLY_INIT_R=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
> diff --git a/configs/ci20_mmc_defconfig b/configs/ci20_mmc_defconfig
> index e8bcc0b7f99b..a1c2fa732c12 100644
> --- a/configs/ci20_mmc_defconfig
> +++ b/configs/ci20_mmc_defconfig
> @@ -25,6 +25,8 @@ CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x2e00
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xf4008000
>  # CONFIG_SPL_BANNER_PRINT is not set
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x1c
> diff --git a/configs/cl-som-imx7_defconfig b/configs/cl-som-imx7_defconfi=
g
> index af7fb37afccd..67b70d9523d8 100644
> --- a/configs/cl-som-imx7_defconfig
> +++ b/configs/cl-som-imx7_defconfig
> @@ -28,6 +28,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0xe000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x946bb8
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x80
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
> index fc7aaba37dd6..bbb475e97907 100644
> --- a/configs/clearfog_defconfig
> +++ b/configs/clearfog_defconfig
> @@ -29,6 +29,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x22fd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_TLV_EEPROM=3Dy
> diff --git a/configs/cm_fx6_defconfig b/configs/cm_fx6_defconfig
> index bb63d5f7756e..d1f8c494ae4e 100644
> --- a/configs/cm_fx6_defconfig
> +++ b/configs/cm_fx6_defconfig
> @@ -30,6 +30,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt; run distro_bootcmd; =
run legacy_bootcmd"
>  CONFIG_USE_PREBOOT=3Dy
>  CONFIG_PREBOOT=3D"usb start;sf probe"
>  CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x80
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defcon=
fig
> index 1873581e7555..9436f9f0a389 100644
> --- a/configs/colibri_imx6_defconfig
> +++ b/configs/colibri_imx6_defconfig
> @@ -35,6 +35,8 @@ CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
> diff --git a/configs/colibri_t20_defconfig b/configs/colibri_t20_defconfi=
g
> index 76eb9e12c29c..1f616af3c52c 100644
> --- a/configs/colibri_t20_defconfig
> +++ b/configs/colibri_t20_defconfig
> @@ -18,6 +18,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_ARCH_MISC_INIT=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffffc
>  CONFIG_SYS_PROMPT=3D"Colibri T20 # "
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_SYS_CBSIZE=3D1024
> diff --git a/configs/colibri_t30_defconfig b/configs/colibri_t30_defconfi=
g
> index c9f8a5e65e4e..b9012f025827 100644
> --- a/configs/colibri_t30_defconfig
> +++ b/configs/colibri_t30_defconfig
> @@ -19,6 +19,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_ARCH_MISC_INIT=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Colibri T30 # "
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_SYS_CBSIZE=3D1024
> diff --git a/configs/colorfly_e708_q1_defconfig b/configs/colorfly_e708_q=
1_defconfig
> index 304ae18a857d..f17083310a27 100644
> --- a/configs/colorfly_e708_q1_defconfig
> +++ b/configs/colorfly_e708_q1_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PA25"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH13"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_AXP_DLDO2_VOLT=3D1800
> diff --git a/configs/controlcenterdc_defconfig b/configs/controlcenterdc_=
defconfig
> index fd8cbe577dea..9b5380960809 100644
> --- a/configs/controlcenterdc_defconfig
> +++ b/configs/controlcenterdc_defconfig
> @@ -38,6 +38,8 @@ CONFIG_SPL_MAX_SIZE=3D0x27fd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x40031000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/corvus_defconfig b/configs/corvus_defconfig
> index 9683c662f9dd..e7db00a21223 100644
> --- a/configs/corvus_defconfig
> +++ b/configs/corvus_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SPL_MAX_SIZE=3D0x3000
>  CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x800
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4000
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_RAW_ONLY=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
> diff --git a/configs/da850evm_defconfig b/configs/da850evm_defconfig
> index 8ddde6a80b59..a4bc7e41265a 100644
> --- a/configs/da850evm_defconfig
> +++ b/configs/da850evm_defconfig
> @@ -39,6 +39,8 @@ CONFIG_SPL_PAD_TO=3D0x8000
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x8001ff00
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/da850evm_nand_defconfig b/configs/da850evm_nand_defc=
onfig
> index 4e3ff7021445..ef180e686431 100644
> --- a/configs/da850evm_nand_defconfig
> +++ b/configs/da850evm_nand_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SPL_PAD_TO=3D0x8000
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x8001ff00
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
> diff --git a/configs/dalmore_defconfig b/configs/dalmore_defconfig
> index 1a0ad00a3195..7811ef83db86 100644
> --- a/configs/dalmore_defconfig
> +++ b/configs/dalmore_defconfig
> @@ -16,6 +16,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Tegra114 (Dalmore) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2086
> diff --git a/configs/db-88f6720_defconfig b/configs/db-88f6720_defconfig
> index cf7bd174a589..77e0bbc858ae 100644
> --- a/configs/db-88f6720_defconfig
> +++ b/configs/db-88f6720_defconfig
> @@ -28,6 +28,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1ffd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_I2C=3Dy
> diff --git a/configs/db-88f6820-amc_defconfig b/configs/db-88f6820-amc_de=
fconfig
> index fc2cd98f9419..5d52c1fcc604 100644
> --- a/configs/db-88f6820-amc_defconfig
> +++ b/configs/db-88f6820-amc_defconfig
> @@ -29,6 +29,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x22fd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_MAXARGS=3D96
>  # CONFIG_CMD_FLASH is not set
> diff --git a/configs/db-88f6820-gp_defconfig b/configs/db-88f6820-gp_defc=
onfig
> index 8243a49fba72..04a07e0e812a 100644
> --- a/configs/db-88f6820-gp_defconfig
> +++ b/configs/db-88f6820-gp_defconfig
> @@ -28,6 +28,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x22fd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_I2C=3Dy
> diff --git a/configs/db-mv784mp-gp_defconfig b/configs/db-mv784mp-gp_defc=
onfig
> index 2f5a3215d990..a1e072545373 100644
> --- a/configs/db-mv784mp-gp_defconfig
> +++ b/configs/db-mv784mp-gp_defconfig
> @@ -28,6 +28,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1bfd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  # CONFIG_CMD_FLASH is not set
> diff --git a/configs/deneb_defconfig b/configs/deneb_defconfig
> index 42f4d40d9e63..21dfc26c1e06 100644
> --- a/configs/deneb_defconfig
> +++ b/configs/deneb_defconfig
> @@ -40,6 +40,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x13e000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x800
>  CONFIG_SPL_POWER_DOMAIN=3Dy
> diff --git a/configs/devkit3250_defconfig b/configs/devkit3250_defconfig
> index f447aecf8b03..5290ac5e82e1 100644
> --- a/configs/devkit3250_defconfig
> +++ b/configs/devkit3250_defconfig
> @@ -29,6 +29,8 @@ CONFIG_SPL_MAX_SIZE=3D0x20000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfff8
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_RAW_ONLY=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
> diff --git a/configs/dh_imx6_defconfig b/configs/dh_imx6_defconfig
> index 8c0b9b3d4565..05b9eb8cbf3d 100644
> --- a/configs/dh_imx6_defconfig
> +++ b/configs/dh_imx6_defconfig
> @@ -35,6 +35,8 @@ CONFIG_SPL_FIT=3Dy
>  CONFIG_BOOTDELAY=3D3
>  # CONFIG_USE_BOOTCOMMAND is not set
>  CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x11400
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/difrnce_dit4350_defconfig b/configs/difrnce_dit4350_=
defconfig
> index 29d9978cb32f..a3917eaf1794 100644
> --- a/configs/difrnce_dit4350_defconfig
> +++ b/configs/difrnce_dit4350_defconfig
> @@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_POWER=3D"AXP0-0"
>  CONFIG_VIDEO_LCD_BL_EN=3D"AXP0-1"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/display5_defconfig b/configs/display5_defconfig
> index 2b92ed95b4b7..b39b4de2c153 100644
> --- a/configs/display5_defconfig
> +++ b/configs/display5_defconfig
> @@ -37,6 +37,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"if run check_em_pad; then run recovery;else if tes=
t ${BOOT_FROM} =3D FACTORY; then run factory_nfs;else run boot_mmc;fi;fi"
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_BOOTCOUNT_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/display5_factory_defconfig b/configs/display5_factor=
y_defconfig
> index 9c3965c0a6f5..163737cb5db2 100644
> --- a/configs/display5_factory_defconfig
> +++ b/configs/display5_factory_defconfig
> @@ -34,6 +34,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"echo SDP Display5 recovery"
>  CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
> index 73907b3e3896..b0288f57b0d1 100644
> --- a/configs/ds414_defconfig
> +++ b/configs/ds414_defconfig
> @@ -36,6 +36,8 @@ CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1bfd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  # CONFIG_CMD_FLASH is not set
> diff --git a/configs/dserve_dsrv9703c_defconfig b/configs/dserve_dsrv9703=
c_defconfig
> index dfc270ccc52a..c737cdb4d99c 100644
> --- a/configs/dserve_dsrv9703c_defconfig
> +++ b/configs/dserve_dsrv9703c_defconfig
> @@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/edminiv2_defconfig b/configs/edminiv2_defconfig
> index ace1f768c214..dd6118bf2129 100644
> --- a/configs/edminiv2_defconfig
> +++ b/configs/edminiv2_defconfig
> @@ -25,6 +25,8 @@ CONFIG_RESET_PHY_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0xfff0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1ffff
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x20000
>  CONFIG_SPL_NOR_SUPPORT=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  # CONFIG_AUTO_COMPLETE is not set
> diff --git a/configs/emlid_neutis_n5_devboard_defconfig b/configs/emlid_n=
eutis_n5_devboard_defconfig
> index e54f4aa75245..d9272eae168f 100644
> --- a/configs/emlid_neutis_n5_devboard_defconfig
> +++ b/configs/emlid_neutis_n5_devboard_defconfig
> @@ -8,5 +8,6 @@ CONFIG_DRAM_ZQ=3D3881977
>  # CONFIG_DRAM_ODT_EN is not set
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
> diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
> index 019e9422192e..7b1138ee63fb 100644
> --- a/configs/evb-px30_defconfig
> +++ b/configs/evb-px30_defconfig
> @@ -35,6 +35,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_TPL_BANNER_PRINT is not set
>  CONFIG_SPL_ATF=3Dy
> diff --git a/configs/evb-px5_defconfig b/configs/evb-px5_defconfig
> index 238ef9a9e8db..753e6edc35d6 100644
> --- a/configs/evb-px5_defconfig
> +++ b/configs/evb-px5_defconfig
> @@ -40,6 +40,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x20000
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x188000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_ATF=3Dy
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> diff --git a/configs/evb-rk3288_defconfig b/configs/evb-rk3288_defconfig
> index 7c91aacabd67..6587c19c36a1 100644
> --- a/configs/evb-rk3288_defconfig
> +++ b/configs/evb-rk3288_defconfig
> @@ -28,6 +28,8 @@ CONFIG_SILENT_CONSOLE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_SPL_OPTEE_IMAGE=3Dy
> diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> index 8d9ca36cdde7..e871ba1b8e76 100644
> --- a/configs/evb-rk3308_defconfig
> +++ b/configs/evb-rk3308_defconfig
> @@ -27,6 +27,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x20000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_CONSOLE is not set
> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
> index 3aa1ce733c8c..f247f692a0c7 100644
> --- a/configs/evb-rk3328_defconfig
> +++ b/configs/evb-rk3328_defconfig
> @@ -32,6 +32,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_SPL_ATF=3Dy
> diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
> index 186ecd1f9d53..a2f0698525b5 100644
> --- a/configs/evb-rk3399_defconfig
> +++ b/configs/evb-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
> index 8d1e45391ddd..6afd5d6d70fc 100644
> --- a/configs/evb-rk3568_defconfig
> +++ b/configs/evb-rk3568_defconfig
> @@ -30,6 +30,8 @@ CONFIG_SPL_MAX_SIZE=3D0x20000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_ATF=3Dy
>  CONFIG_CMD_GPT=3Dy
> diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defcon=
fig
> index fac88892d662..7012c02f28eb 100644
> --- a/configs/ficus-rk3399_defconfig
> +++ b/configs/ficus-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x10000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff8effff
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x4000
>  CONFIG_CMD_BOOTZ=3Dy
> diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defcon=
fig
> index 4330885a306e..31374c55d8c3 100644
> --- a/configs/firefly-px30_defconfig
> +++ b/configs/firefly-px30_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_TPL_BANNER_PRINT is not set
>  CONFIG_SPL_ATF=3Dy
> diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_de=
fconfig
> index 6351ba1715f1..c2b3a0e315de 100644
> --- a/configs/firefly-rk3288_defconfig
> +++ b/configs/firefly-rk3288_defconfig
> @@ -24,6 +24,8 @@ CONFIG_SILENT_CONSOLE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  CONFIG_CMD_GPIO=3Dy
> diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_de=
fconfig
> index 2be11295243f..2f7cb97aa653 100644
> --- a/configs/firefly-rk3399_defconfig
> +++ b/configs/firefly-rk3399_defconfig
> @@ -21,6 +21,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/ga10h_v1_1_defconfig b/configs/ga10h_v1_1_defconfig
> index 440a263c191c..7cdb6c56755b 100644
> --- a/configs/ga10h_v1_1_defconfig
> +++ b/configs/ga10h_v1_1_defconfig
> @@ -17,6 +17,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_CONS_INDEX=3D5
> diff --git a/configs/gardena-smart-gateway-at91sam_defconfig b/configs/ga=
rdena-smart-gateway-at91sam_defconfig
> index 8e509f699daf..42d700b6cd58 100644
> --- a/configs/gardena-smart-gateway-at91sam_defconfig
> +++ b/configs/gardena-smart-gateway-at91sam_defconfig
> @@ -38,6 +38,8 @@ CONFIG_SPL_MAX_SIZE=3D0x7000
>  CONFIG_SPL_PAD_TO=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x308000
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_RAW_ONLY=3Dy
> diff --git a/configs/ge_b1x5v2_defconfig b/configs/ge_b1x5v2_defconfig
> index fd1f3e37de33..5966870df2d7 100644
> --- a/configs/ge_b1x5v2_defconfig
> +++ b/configs/ge_b1x5v2_defconfig
> @@ -37,6 +37,8 @@ CONFIG_LOG_MAX_LEVEL=3D8
>  CONFIG_LOG_DEFAULT_LEVEL=3D4
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x11400
>  CONFIG_SPL_USB_HOST=3Dy
> diff --git a/configs/giedi_defconfig b/configs/giedi_defconfig
> index ae05c9a71929..ec6082a92c6a 100644
> --- a/configs/giedi_defconfig
> +++ b/configs/giedi_defconfig
> @@ -40,6 +40,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x13e000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x800
>  CONFIG_SPL_POWER_DOMAIN=3Dy
> diff --git a/configs/gose_defconfig b/configs/gose_defconfig
> index 9099f5dc9880..350c4ec3f0ec 100644
> --- a/configs/gose_defconfig
> +++ b/configs/gose_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_MAX_SIZE=3D0x4000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6340000
>  CONFIG_SPL_RAM_SUPPORT=3Dy
>  CONFIG_SPL_RAM_DEVICE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/gt90h_v4_defconfig b/configs/gt90h_v4_defconfig
> index 929d93c88997..c81f0f6c5eb9 100644
> --- a/configs/gt90h_v4_defconfig
> +++ b/configs/gt90h_v4_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_CONS_INDEX=3D5
> diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_de=
fconfig
> index f0e720463b67..ef4829c54780 100644
> --- a/configs/gwventana_emmc_defconfig
> +++ b/configs/gwventana_emmc_defconfig
> @@ -40,6 +40,8 @@ CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_PCI_INIT_R=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_FIT_IMAGE_TINY=3Dy
>  CONFIG_SPL_DMA=3Dy
> diff --git a/configs/gwventana_gw5904_defconfig b/configs/gwventana_gw590=
4_defconfig
> index 53d5bddd6197..e070dc88b331 100644
> --- a/configs/gwventana_gw5904_defconfig
> +++ b/configs/gwventana_gw5904_defconfig
> @@ -40,6 +40,8 @@ CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_PCI_INIT_R=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_FIT_IMAGE_TINY=3Dy
>  CONFIG_SPL_DMA=3Dy
> diff --git a/configs/gwventana_nand_defconfig b/configs/gwventana_nand_de=
fconfig
> index e0225278582a..a279935c124e 100644
> --- a/configs/gwventana_nand_defconfig
> +++ b/configs/gwventana_nand_defconfig
> @@ -40,6 +40,8 @@ CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_PCI_INIT_R=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_FIT_IMAGE_TINY=3Dy
>  CONFIG_SPL_DMA=3Dy
> diff --git a/configs/h8_homlet_v2_defconfig b/configs/h8_homlet_v2_defcon=
fig
> index 795de6f3ee96..8af0b3c33324 100644
> --- a/configs/h8_homlet_v2_defconfig
> +++ b/configs/h8_homlet_v2_defconfig
> @@ -11,6 +11,7 @@ CONFIG_USB1_VBUS_PIN=3D"PL6"
>  CONFIG_AXP_GPIO=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO4_VOLT=3D3300
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/harmony_defconfig b/configs/harmony_defconfig
> index 6497d41f97c2..50a210703d47 100644
> --- a/configs/harmony_defconfig
> +++ b/configs/harmony_defconfig
> @@ -14,6 +14,8 @@ CONFIG_OF_SYSTEM_SETUP=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffffc
>  CONFIG_SYS_PROMPT=3D"Tegra20 (Harmony) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2085
> diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
> index d52d07a87ef1..9384aa50fb7e 100644
> --- a/configs/helios4_defconfig
> +++ b/configs/helios4_defconfig
> @@ -29,6 +29,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x22fd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_TLV_EEPROM=3Dy
> diff --git a/configs/i12-tvbox_defconfig b/configs/i12-tvbox_defconfig
> index a336dd47f052..29cea180201c 100644
> --- a/configs/i12-tvbox_defconfig
> +++ b/configs/i12-tvbox_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D384
>  CONFIG_MACPWR=3D"PH21"
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/iNet_3F_defconfig b/configs/iNet_3F_defconfig
> index 88d48610b25f..8b6936497fd5 100644
> --- a/configs/iNet_3F_defconfig
> +++ b/configs/iNet_3F_defconfig
> @@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/iNet_3W_defconfig b/configs/iNet_3W_defconfig
> index 91b7807e2ae6..a05876a18f3f 100644
> --- a/configs/iNet_3W_defconfig
> +++ b/configs/iNet_3W_defconfig
> @@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH8"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/iNet_86VS_defconfig b/configs/iNet_86VS_defconfig
> index f4943012e21c..3a9f30877b03 100644
> --- a/configs/iNet_86VS_defconfig
> +++ b/configs/iNet_86VS_defconfig
> @@ -13,6 +13,7 @@ CONFIG_VIDEO_LCD_POWER=3D"AXP0-0"
>  CONFIG_VIDEO_LCD_BL_EN=3D"AXP0-1"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/iNet_D978_rev2_defconfig b/configs/iNet_D978_rev2_de=
fconfig
> index 339e9f6d12d4..664745c9f135 100644
> --- a/configs/iNet_D978_rev2_defconfig
> +++ b/configs/iNet_D978_rev2_defconfig
> @@ -17,6 +17,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> diff --git a/configs/icnova-a20-swac_defconfig b/configs/icnova-a20-swac_=
defconfig
> index 44080b998658..afe5b28e66b9 100644
> --- a/configs/icnova-a20-swac_defconfig
> +++ b/configs/icnova-a20-swac_defconfig
> @@ -19,6 +19,7 @@ CONFIG_VIDEO_LCD_MODE=3D"x:800,y:480,depth:24,pclk_khz:=
33000,le:45,ri:209,up:22,lo
>  CONFIG_VIDEO_LCD_POWER=3D"PH22"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_CMD_UNZIP=3Dy
> diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
> index 8388cd631f25..f460a01e8cef 100644
> --- a/configs/imx28_xea_defconfig
> +++ b/configs/imx28_xea_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x20000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x0
>  CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=3Dy
> diff --git a/configs/imx6dl_icore_nand_defconfig b/configs/imx6dl_icore_n=
and_defconfig
> index c98a5cc735a8..48e075345354 100644
> --- a/configs/imx6dl_icore_nand_defconfig
> +++ b/configs/imx6dl_icore_nand_defconfig
> @@ -24,6 +24,8 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
> diff --git a/configs/imx6dl_mamoj_defconfig b/configs/imx6dl_mamoj_defcon=
fig
> index 6f249dbe2fcd..0595dccaea7c 100644
> --- a/configs/imx6dl_mamoj_defconfig
> +++ b/configs/imx6dl_mamoj_defconfig
> @@ -17,6 +17,8 @@ CONFIG_SYS_MEMTEST_END=3D0x88000000
>  CONFIG_LTO=3Dy
>  CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_BOOTDELAY=3D3
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_OS_BOOT=3Dy
>  CONFIG_SPL_FALCON_BOOT_MMCSD=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=3D0x1000
> diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_=
defconfig
> index 4b75e5794e99..a052193cb760 100644
> --- a/configs/imx6q_bosch_acc_defconfig
> +++ b/configs/imx6q_bosch_acc_defconfig
> @@ -34,6 +34,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run mmc_mmc_fit"
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xaa
>  # CONFIG_SPL_CRC32 is not set
>  # CONFIG_SPL_CRYPTO is not set
> diff --git a/configs/imx6q_icore_nand_defconfig b/configs/imx6q_icore_nan=
d_defconfig
> index 278bc98cbc17..340766919d65 100644
> --- a/configs/imx6q_icore_nand_defconfig
> +++ b/configs/imx6q_icore_nand_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SUPPORT_RAW_INITRD=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
> diff --git a/configs/imx6q_logic_defconfig b/configs/imx6q_logic_defconfi=
g
> index c5ad6dcdd1f2..2d8b83c9f1b4 100644
> --- a/configs/imx6q_logic_defconfig
> +++ b/configs/imx6q_logic_defconfig
> @@ -27,6 +27,8 @@ CONFIG_BOOTCOMMAND=3D"run autoboot"
>  CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
>  CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x93ffb8
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
> diff --git a/configs/imx6qdl_icore_mipi_defconfig b/configs/imx6qdl_icore=
_mipi_defconfig
> index a2f1abe1aa6e..d1136ff97175 100644
> --- a/configs/imx6qdl_icore_mipi_defconfig
> +++ b/configs/imx6qdl_icore_mipi_defconfig
> @@ -33,6 +33,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
>  CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_OS_BOOT=3Dy
>  CONFIG_SPL_FALCON_BOOT_MMCSD=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=3D0x1000
> diff --git a/configs/imx6qdl_icore_mmc_defconfig b/configs/imx6qdl_icore_=
mmc_defconfig
> index 91b32e4a0353..7f60a1290b7e 100644
> --- a/configs/imx6qdl_icore_mmc_defconfig
> +++ b/configs/imx6qdl_icore_mmc_defconfig
> @@ -36,6 +36,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
>  CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_OS_BOOT=3Dy
>  CONFIG_SPL_FALCON_BOOT_MMCSD=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=3D0x1000
> diff --git a/configs/imx6qdl_icore_nand_defconfig b/configs/imx6qdl_icore=
_nand_defconfig
> index 278bc98cbc17..340766919d65 100644
> --- a/configs/imx6qdl_icore_nand_defconfig
> +++ b/configs/imx6qdl_icore_nand_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SUPPORT_RAW_INITRD=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
> diff --git a/configs/imx6qdl_icore_rqs_defconfig b/configs/imx6qdl_icore_=
rqs_defconfig
> index cfd35608cfcc..f4ce0bdc33a0 100644
> --- a/configs/imx6qdl_icore_rqs_defconfig
> +++ b/configs/imx6qdl_icore_rqs_defconfig
> @@ -30,6 +30,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
>  CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_OS_BOOT=3Dy
>  CONFIG_SPL_FALCON_BOOT_MMCSD=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=3D0x1000
> diff --git a/configs/imx6ul_geam_mmc_defconfig b/configs/imx6ul_geam_mmc_=
defconfig
> index a84547feddd9..dc517d8bdc96 100644
> --- a/configs/imx6ul_geam_mmc_defconfig
> +++ b/configs/imx6ul_geam_mmc_defconfig
> @@ -28,6 +28,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
>  CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_PROMPT=3D"geam6ul> "
> diff --git a/configs/imx6ul_geam_nand_defconfig b/configs/imx6ul_geam_nan=
d_defconfig
> index 8bd4360efd2e..ad7c821ebaf5 100644
> --- a/configs/imx6ul_geam_nand_defconfig
> +++ b/configs/imx6ul_geam_nand_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SUPPORT_RAW_INITRD=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
> diff --git a/configs/imx6ul_isiot_emmc_defconfig b/configs/imx6ul_isiot_e=
mmc_defconfig
> index 9262055f1da5..0a451618e78e 100644
> --- a/configs/imx6ul_isiot_emmc_defconfig
> +++ b/configs/imx6ul_isiot_emmc_defconfig
> @@ -28,6 +28,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
>  CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_PROMPT=3D"isiotmx6ul> "
> diff --git a/configs/imx6ul_isiot_nand_defconfig b/configs/imx6ul_isiot_n=
and_defconfig
> index d1da6da311c8..dd8543d5f5c2 100644
> --- a/configs/imx6ul_isiot_nand_defconfig
> +++ b/configs/imx6ul_isiot_nand_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SUPPORT_RAW_INITRD=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run $modeboot"
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
> diff --git a/configs/imx7_cm_defconfig b/configs/imx7_cm_defconfig
> index 351d47fe552e..8b05ee2f6df5 100644
> --- a/configs/imx7_cm_defconfig
> +++ b/configs/imx7_cm_defconfig
> @@ -26,6 +26,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"ask"
>  # CONFIG_BOARD_EARLY_INIT_F is not set
>  CONFIG_SPL_MAX_SIZE=3D0xe000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x946bb8
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
> diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-=
cl-iot-gate-optee_defconfig
> index f2ce0a712dbf..64d2befc98c6 100644
> --- a/configs/imx8mm-cl-iot-gate-optee_defconfig
> +++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
> @@ -26,6 +26,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot=
-gate_defconfig
> index add2687779e0..2494d1a79b0e 100644
> --- a/configs/imx8mm-cl-iot-gate_defconfig
> +++ b/configs/imx8mm-cl-iot-gate_defconfig
> @@ -28,6 +28,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8m=
m-icore-mx8mm-ctouch2_defconfig
> index 6e3cb0601e11..5196f6f0ea2c 100644
> --- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
> +++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
> @@ -26,6 +26,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"imx8mm-icore-mx8mm-ctouch2.d=
tb"
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_POWER=3Dy
> diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8=
mm-icore-mx8mm-edimm2.2_defconfig
> index 3a2259515e07..cf385a625b3f 100644
> --- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
> +++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
> @@ -26,6 +26,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"imx8mm-icore-mx8mm-edimm2.2.=
dtb"
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_POWER=3Dy
> diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_=
defconfig
> index 1eb00e1a745d..f104dada533a 100644
> --- a/configs/imx8mm-mx8menlo_defconfig
> +++ b/configs/imx8mm-mx8menlo_defconfig
> @@ -37,6 +37,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defc=
onfig
> index d11671f0346e..3481aff6d55f 100644
> --- a/configs/imx8mm_beacon_defconfig
> +++ b/configs/imx8mm_beacon_defconfig
> @@ -28,6 +28,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"imx8mm-beacon-kit.dtb"
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm=
_data_modul_edm_sbc_defconfig
> index b76f4c44e316..3e141aef6c37 100644
> --- a/configs/imx8mm_data_modul_edm_sbc_defconfig
> +++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
> @@ -46,6 +46,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
> index 00f605804df4..2d73d2454dea 100644
> --- a/configs/imx8mm_evk_defconfig
> +++ b/configs/imx8mm_evk_defconfig
> @@ -26,6 +26,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defc=
onfig
> index 1db032f39ec8..3f8662ac7155 100644
> --- a/configs/imx8mm_venice_defconfig
> +++ b/configs/imx8mm_venice_defconfig
> @@ -33,6 +33,8 @@ CONFIG_PREBOOT=3D"gsc wd-disable"
>  CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2=
g_defconfig
> index 905d3e502abd..bb503652362e 100644
> --- a/configs/imx8mn_beacon_2g_defconfig
> +++ b/configs/imx8mn_beacon_2g_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x187ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defc=
onfig
> index f4b61c1aa5de..95e4cc432ada 100644
> --- a/configs/imx8mn_beacon_defconfig
> +++ b/configs/imx8mn_beacon_defconfig
> @@ -35,6 +35,8 @@ CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x187ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm=
_s2_defconfig
> index 2e27dd98c566..9a4609dd8239 100644
> --- a/configs/imx8mn_bsh_smm_s2_defconfig
> +++ b/configs/imx8mn_bsh_smm_s2_defconfig
> @@ -30,6 +30,8 @@ CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x980000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_=
smm_s2pro_defconfig
> index 706beb9e6532..66586ba96a23 100644
> --- a/configs/imx8mn_bsh_smm_s2pro_defconfig
> +++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
> @@ -31,6 +31,8 @@ CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x980000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_=
defconfig
> index 222554188631..16f217cd5a75 100644
> --- a/configs/imx8mn_ddr4_evk_defconfig
> +++ b/configs/imx8mn_ddr4_evk_defconfig
> @@ -29,6 +29,8 @@ CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x980000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
> index beb89a7523ef..ead7f6d21a82 100644
> --- a/configs/imx8mn_evk_defconfig
> +++ b/configs/imx8mn_evk_defconfig
> @@ -33,6 +33,8 @@ CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x980000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_de=
fconfig
> index c79168917271..a1f9cee1e193 100644
> --- a/configs/imx8mn_var_som_defconfig
> +++ b/configs/imx8mn_var_som_defconfig
> @@ -31,6 +31,8 @@ CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x980000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defc=
onfig
> index 2ca467871bd8..f2ddb98a1c0b 100644
> --- a/configs/imx8mn_venice_defconfig
> +++ b/configs/imx8mn_venice_defconfig
> @@ -35,6 +35,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x980000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_p=
dk2_defconfig
> index 6507b9d8b191..cc815ac2fe04 100644
> --- a/configs/imx8mp_dhcom_pdk2_defconfig
> +++ b/configs/imx8mp_dhcom_pdk2_defconfig
> @@ -49,6 +49,8 @@ CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x400
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x96fc00
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
> index 55dce14294e6..1f4bf537c407 100644
> --- a/configs/imx8mp_evk_defconfig
> +++ b/configs/imx8mp_evk_defconfig
> @@ -33,6 +33,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x400
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x960000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb37=
20a1_4G_defconfig
> index 152b0bae091f..e8c1bc511918 100644
> --- a/configs/imx8mp_rsb3720a1_4G_defconfig
> +++ b/configs/imx8mp_rsb3720a1_4G_defconfig
> @@ -39,6 +39,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x400
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x960000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb37=
20a1_6G_defconfig
> index 223767bb7d7b..323f5fb3356a 100644
> --- a/configs/imx8mp_rsb3720a1_6G_defconfig
> +++ b/configs/imx8mp_rsb3720a1_6G_defconfig
> @@ -39,6 +39,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x400
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x960000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defc=
onfig
> index c44eadae6020..2485ae21ee7c 100644
> --- a/configs/imx8mp_venice_defconfig
> +++ b/configs/imx8mp_venice_defconfig
> @@ -35,6 +35,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x26000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x400
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x960000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mq_cm_defconfig b/configs/imx8mq_cm_defconfig
> index a9cc11c22fee..a67c82ac3c34 100644
> --- a/configs/imx8mq_cm_defconfig
> +++ b/configs/imx8mq_cm_defconfig
> @@ -30,6 +30,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x187ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
> index 7ac45288632e..da03518af2b2 100644
> --- a/configs/imx8mq_evk_defconfig
> +++ b/configs/imx8mq_evk_defconfig
> @@ -32,6 +32,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x187ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_=
defconfig
> index 83485648a577..6ef649b1646f 100644
> --- a/configs/imx8mq_phanbell_defconfig
> +++ b/configs/imx8mq_phanbell_defconfig
> @@ -34,6 +34,8 @@ CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x2b000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x187ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
> index 0bd0dbeb6e2a..5fc2e7a414ef 100644
> --- a/configs/imx8qm_mek_defconfig
> +++ b/configs/imx8qm_mek_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x13e000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x800
>  CONFIG_SPL_POWER_DOMAIN=3Dy
> diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconfi=
g
> index 5603bbf1a31d..8b382156006f 100644
> --- a/configs/imx8qxp_mek_defconfig
> +++ b/configs/imx8qxp_mek_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x13e000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x800
>  CONFIG_SPL_POWER_DOMAIN=3Dy
> diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfi=
g
> index 778766cd9799..5d3c8395aeef 100644
> --- a/configs/imx8ulp_evk_defconfig
> +++ b/configs/imx8ulp_evk_defconfig
> @@ -31,6 +31,8 @@ CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x22050000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_WATCHDOG=3Dy
> diff --git a/configs/inet1_defconfig b/configs/inet1_defconfig
> index 13fd425d5e22..dae6b23a936e 100644
> --- a/configs/inet1_defconfig
> +++ b/configs/inet1_defconfig
> @@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/inet86dz_defconfig b/configs/inet86dz_defconfig
> index 2b824983ac70..0382a4a05411 100644
> --- a/configs/inet86dz_defconfig
> +++ b/configs/inet86dz_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_CONS_INDEX=3D5
> diff --git a/configs/inet97fv2_defconfig b/configs/inet97fv2_defconfig
> index 4b9946f92dbd..f3e374c2e345 100644
> --- a/configs/inet97fv2_defconfig
> +++ b/configs/inet97fv2_defconfig
> @@ -13,6 +13,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH8"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/inet98v_rev2_defconfig b/configs/inet98v_rev2_defcon=
fig
> index f068de4b57f9..c392fc2bb871 100644
> --- a/configs/inet98v_rev2_defconfig
> +++ b/configs/inet98v_rev2_defconfig
> @@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_POWER=3D"AXP0-0"
>  CONFIG_VIDEO_LCD_BL_EN=3D"AXP0-1"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/inet9f_rev03_defconfig b/configs/inet9f_rev03_defcon=
fig
> index 08efec27097d..81a1c9940fd8 100644
> --- a/configs/inet9f_rev03_defconfig
> +++ b/configs/inet9f_rev03_defconfig
> @@ -13,6 +13,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH8"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/inet_q972_defconfig b/configs/inet_q972_defconfig
> index 73700b12297a..a4a828c70a3a 100644
> --- a/configs/inet_q972_defconfig
> +++ b/configs/inet_q972_defconfig
> @@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_DCLK_PHASE=3D0
>  CONFIG_VIDEO_LCD_BL_EN=3D"PA25"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH13"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/jesurun_q5_defconfig b/configs/jesurun_q5_defconfig
> index d5b0da01edf6..5fce5836c9c5 100644
> --- a/configs/jesurun_q5_defconfig
> +++ b/configs/jesurun_q5_defconfig
> @@ -8,6 +8,7 @@ CONFIG_MACPWR=3D"PH19"
>  CONFIG_USB0_VBUS_PIN=3D"PB9"
>  CONFIG_VIDEO_COMPOSITE=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/jetson-tk1_defconfig b/configs/jetson-tk1_defconfig
> index 20fed61ec7aa..e0f32a5d63f2 100644
> --- a/configs/jetson-tk1_defconfig
> +++ b/configs/jetson-tk1_defconfig
> @@ -16,6 +16,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Tegra124 (Jetson TK1) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2089
> diff --git a/configs/k2e_evm_defconfig b/configs/k2e_evm_defconfig
> index 9c34a0ddc6ae..ed6e96dac690 100644
> --- a/configs/k2e_evm_defconfig
> +++ b/configs/k2e_evm_defconfig
> @@ -31,6 +31,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0xfff8
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xc1223f4
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
>  CONFIG_SPL_NAND_ECC=3Dy
> diff --git a/configs/k2g_evm_defconfig b/configs/k2g_evm_defconfig
> index 0469e4f11492..1ec8dd042e21 100644
> --- a/configs/k2g_evm_defconfig
> +++ b/configs/k2g_evm_defconfig
> @@ -30,6 +30,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0xfff8
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xc0c23f4
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
>  CONFIG_SPL_NAND_ECC=3Dy
> diff --git a/configs/k2hk_evm_defconfig b/configs/k2hk_evm_defconfig
> index 543810905cd6..2238aed03e5f 100644
> --- a/configs/k2hk_evm_defconfig
> +++ b/configs/k2hk_evm_defconfig
> @@ -31,6 +31,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0xfff8
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xc2223f4
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
>  CONFIG_SPL_NAND_ECC=3Dy
> diff --git a/configs/k2l_evm_defconfig b/configs/k2l_evm_defconfig
> index 1a68b45197fb..d96b8084ee45 100644
> --- a/configs/k2l_evm_defconfig
> +++ b/configs/k2l_evm_defconfig
> @@ -31,6 +31,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0xfff8
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xc1223f4
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
>  CONFIG_SPL_NAND_ECC=3Dy
> diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khada=
s-edge-captain-rk3399_defconfig
> index 24fa9b016532..085c6b667321 100644
> --- a/configs/khadas-edge-captain-rk3399_defconfig
> +++ b/configs/khadas-edge-captain-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-r=
k3399_defconfig
> index 78ac8ade5889..b66301877e2a 100644
> --- a/configs/khadas-edge-rk3399_defconfig
> +++ b/configs/khadas-edge-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge=
-v-rk3399_defconfig
> index 2ae99a15b522..5438d0a32264 100644
> --- a/configs/khadas-edge-v-rk3399_defconfig
> +++ b/configs/khadas-edge-v-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
> index 186200f02819..467b44c3e6b0 100644
> --- a/configs/koelsch_defconfig
> +++ b/configs/koelsch_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_MAX_SIZE=3D0x4000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6340000
>  CONFIG_SPL_RAM_SUPPORT=3Dy
>  CONFIG_SPL_RAM_DEVICE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6u=
l_defconfig
> index 1ba4d1fca841..904e953ce0fa 100644
> --- a/configs/kontron-sl-mx6ul_defconfig
> +++ b/configs/kontron-sl-mx6ul_defconfig
> @@ -28,6 +28,8 @@ CONFIG_BOARD_TYPES=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
> diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8m=
m_defconfig
> index db69cf53c8cd..cd96210c6bbf 100644
> --- a/configs/kontron-sl-mx8mm_defconfig
> +++ b/configs/kontron-sl-mx8mm_defconfig
> @@ -29,6 +29,8 @@ CONFIG_BOARD_TYPES=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91fff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  # CONFIG_SPL_FIT_IMAGE_TINY is not set
> diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_=
imx8m_defconfig
> index f8e11f581f02..4660e98e5aeb 100644
> --- a/configs/kontron_pitx_imx8m_defconfig
> +++ b/configs/kontron_pitx_imx8m_defconfig
> @@ -32,6 +32,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x187ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defcon=
fig
> index 9f4be1ac9d01..345db0314896 100644
> --- a/configs/kontron_sl28_defconfig
> +++ b/configs/kontron_sl28_defconfig
> @@ -40,6 +40,8 @@ CONFIG_PCI_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x18009ff0
>  CONFIG_SPL_MPC8XXX_INIT_DDR=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x230000
> diff --git a/configs/kp_imx6q_tpc_defconfig b/configs/kp_imx6q_tpc_defcon=
fig
> index 012a5c492ed1..4ec988e3133c 100644
> --- a/configs/kp_imx6q_tpc_defconfig
> +++ b/configs/kp_imx6q_tpc_defconfig
> @@ -27,6 +27,8 @@ CONFIG_AUTOBOOT_STOP_STR=3D"."
>  # CONFIG_USE_BOOTCOMMAND is not set
>  CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
>  CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_POWER=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/lager_defconfig b/configs/lager_defconfig
> index d13b75de412e..c9ec38d711ff 100644
> --- a/configs/lager_defconfig
> +++ b/configs/lager_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_MAX_SIZE=3D0x4000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6340000
>  CONFIG_SPL_RAM_SUPPORT=3Dy
>  CONFIG_SPL_RAM_DEVICE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfi=
g
> index c8e462867e1b..d524e4546c81 100644
> --- a/configs/leez-rk3399_defconfig
> +++ b/configs/leez-rk3399_defconfig
> @@ -19,6 +19,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/libretech_all_h3_cc_h2_plus_defconfig b/configs/libr=
etech_all_h3_cc_h2_plus_defconfig
> index d720dd5c8bd7..ca995568024d 100644
> --- a/configs/libretech_all_h3_cc_h2_plus_defconfig
> +++ b/configs/libretech_all_h3_cc_h2_plus_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D672
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/libretech_all_h3_cc_h3_defconfig b/configs/libretech=
_all_h3_cc_h3_defconfig
> index 6b9faddb901c..7ca312c8fbcd 100644
> --- a/configs/libretech_all_h3_cc_h3_defconfig
> +++ b/configs/libretech_all_h3_cc_h3_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D672
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/libretech_all_h3_cc_h5_defconfig b/configs/libretech=
_all_h3_cc_h5_defconfig
> index a20d43f0fed6..524138aa2e17 100644
> --- a/configs/libretech_all_h3_cc_h5_defconfig
> +++ b/configs/libretech_all_h3_cc_h5_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN50I_H5=3Dy
>  CONFIG_DRAM_CLK=3D672
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/libretech_all_h3_it_h5_defconfig b/configs/libretech=
_all_h3_it_h5_defconfig
> index 5bc923a68f46..1b0833358632 100644
> --- a/configs/libretech_all_h3_it_h5_defconfig
> +++ b/configs/libretech_all_h3_it_h5_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D672
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPI_FLASH_XMC=3Dy
>  CONFIG_SPI=3Dy
> diff --git a/configs/libretech_all_h5_cc_h5_defconfig b/configs/libretech=
_all_h5_cc_h5_defconfig
> index 987393d168e9..e0734f96735a 100644
> --- a/configs/libretech_all_h5_cc_h5_defconfig
> +++ b/configs/libretech_all_h5_cc_h5_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D672
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPI_FLASH_XMC=3Dy
>  CONFIG_SUN8I_EMAC=3Dy
> diff --git a/configs/licheepi_nano_defconfig b/configs/licheepi_nano_defc=
onfig
> index 8502cf3e8d22..0252763c7762 100644
> --- a/configs/licheepi_nano_defconfig
> +++ b/configs/licheepi_nano_defconfig
> @@ -10,5 +10,6 @@ CONFIG_DRAM_CLK=3D156
>  CONFIG_DRAM_ZQ=3D0
>  # CONFIG_VIDEO_SUNXI is not set
>  CONFIG_SPL_SPI_SUNXI=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  # CONFIG_SYSRESET is not set
> diff --git a/configs/lion-rk3368_defconfig b/configs/lion-rk3368_defconfi=
g
> index c03eecabcaca..c700115aecc6 100644
> --- a/configs/lion-rk3368_defconfig
> +++ b/configs/lion-rk3368_defconfig
> @@ -38,6 +38,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x20000
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x188000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x4000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x200
> diff --git a/configs/liteboard_defconfig b/configs/liteboard_defconfig
> index 334b22ac8ab2..9832654fa460 100644
> --- a/configs/liteboard_defconfig
> +++ b/configs/liteboard_defconfig
> @@ -24,6 +24,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"mmc dev ${mmcdev};if mmc rescan; then if run loadb=
ootscript; then run bootscript; else if run loadimage; then run mmcboot; el=
se run netboot; fi; fi; else run netboot; fi"
>  CONFIG_DEFAULT_FDT_FILE=3D"imx6ul-liteboard.dtb"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdc=
ard_defconfig
> index 85b0c937cdb3..74d5e7ce2f25 100644
> --- a/configs/ls1021aiot_sdcard_defconfig
> +++ b/configs/ls1021aiot_sdcard_defconfig
> @@ -35,6 +35,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x1c000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xe8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1021aqds_nand_defconfig b/configs/ls1021aqds_nand_=
defconfig
> index 4ec86e736d25..57eefa684948 100644
> --- a/configs/ls1021aqds_nand_defconfig
> +++ b/configs/ls1021aqds_nand_defconfig
> @@ -45,6 +45,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x1c000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xe8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1021aqds_sdcard_ifc_defconfig b/configs/ls1021aqds=
_sdcard_ifc_defconfig
> index 079b19ab5e7f..a2b39eb38438 100644
> --- a/configs/ls1021aqds_sdcard_ifc_defconfig
> +++ b/configs/ls1021aqds_sdcard_ifc_defconfig
> @@ -44,6 +44,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x1c000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xe8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1021aqds_sdcard_qspi_defconfig b/configs/ls1021aqd=
s_sdcard_qspi_defconfig
> index a6a4be372eec..62100e447479 100644
> --- a/configs/ls1021aqds_sdcard_qspi_defconfig
> +++ b/configs/ls1021aqds_sdcard_qspi_defconfig
> @@ -43,6 +43,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x1c000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xe8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1021atsn_sdcard_defconfig b/configs/ls1021atsn_sdc=
ard_defconfig
> index b97c0a0035ae..85ba389ff6b1 100644
> --- a/configs/ls1021atsn_sdcard_defconfig
> +++ b/configs/ls1021atsn_sdcard_defconfig
> @@ -37,6 +37,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x1c000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xe8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig b/config=
s/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
> index 772737ff5620..13d46e47194e 100644
> --- a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
> +++ b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
> @@ -44,6 +44,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x1c000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xe8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1021atwr_sdcard_ifc_defconfig b/configs/ls1021atwr=
_sdcard_ifc_defconfig
> index d04a0b6f0f83..6dab204210d7 100644
> --- a/configs/ls1021atwr_sdcard_ifc_defconfig
> +++ b/configs/ls1021atwr_sdcard_ifc_defconfig
> @@ -45,6 +45,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x1c000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xe8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1021atwr_sdcard_qspi_defconfig b/configs/ls1021atw=
r_sdcard_qspi_defconfig
> index 3b1e5d9df88d..bdc279b646ea 100644
> --- a/configs/ls1021atwr_sdcard_qspi_defconfig
> +++ b/configs/ls1021atwr_sdcard_qspi_defconfig
> @@ -46,6 +46,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x1c000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xe8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1043aqds_nand_defconfig b/configs/ls1043aqds_nand_=
defconfig
> index 87696444a272..ec60f8edfddc 100644
> --- a/configs/ls1043aqds_nand_defconfig
> +++ b/configs/ls1043aqds_nand_defconfig
> @@ -51,6 +51,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xf0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1043aqds_sdcard_ifc_defconfig b/configs/ls1043aqds=
_sdcard_ifc_defconfig
> index 140ca826af9e..ad8fce935897 100644
> --- a/configs/ls1043aqds_sdcard_ifc_defconfig
> +++ b/configs/ls1043aqds_sdcard_ifc_defconfig
> @@ -52,6 +52,8 @@ CONFIG_SPL_MAX_SIZE=3D0x17000
>  CONFIG_SPL_PAD_TO=3D0x1d000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001e000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xf0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1043aqds_sdcard_qspi_defconfig b/configs/ls1043aqd=
s_sdcard_qspi_defconfig
> index b13156a573d2..4464284f3375 100644
> --- a/configs/ls1043aqds_sdcard_qspi_defconfig
> +++ b/configs/ls1043aqds_sdcard_qspi_defconfig
> @@ -52,6 +52,8 @@ CONFIG_SPL_MAX_SIZE=3D0x17000
>  CONFIG_SPL_PAD_TO=3D0x1d000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001e000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xf0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1043ardb_nand_SECURE_BOOT_defconfig b/configs/ls10=
43ardb_nand_SECURE_BOOT_defconfig
> index 33320c24bc1a..5c51cd5b8c3b 100644
> --- a/configs/ls1043ardb_nand_SECURE_BOOT_defconfig
> +++ b/configs/ls1043ardb_nand_SECURE_BOOT_defconfig
> @@ -35,6 +35,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1a000
>  CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xf0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1043ardb_nand_defconfig b/configs/ls1043ardb_nand_=
defconfig
> index f47c019745ab..bb0f3e6cb505 100644
> --- a/configs/ls1043ardb_nand_defconfig
> +++ b/configs/ls1043ardb_nand_defconfig
> @@ -41,6 +41,8 @@ CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001d000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xf0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig b/configs/ls=
1043ardb_sdcard_SECURE_BOOT_defconfig
> index 40f794001d08..2042b44fe4e8 100644
> --- a/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
> +++ b/configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SPL_MAX_SIZE=3D0x17000
>  CONFIG_SPL_PAD_TO=3D0x1d000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001e000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x110
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1043ardb_sdcard_defconfig b/configs/ls1043ardb_sdc=
ard_defconfig
> index 94e7b9617f27..f51d76c67571 100644
> --- a/configs/ls1043ardb_sdcard_defconfig
> +++ b/configs/ls1043ardb_sdcard_defconfig
> @@ -42,6 +42,8 @@ CONFIG_SPL_PAD_TO=3D0x1d000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001e000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xf0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1046aqds_nand_defconfig b/configs/ls1046aqds_nand_=
defconfig
> index dba986d729fe..322a352669f8 100644
> --- a/configs/ls1046aqds_nand_defconfig
> +++ b/configs/ls1046aqds_nand_defconfig
> @@ -52,6 +52,8 @@ CONFIG_SPL_PAD_TO=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1001f000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x110
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1046aqds_sdcard_ifc_defconfig b/configs/ls1046aqds=
_sdcard_ifc_defconfig
> index 0dfbf4225165..4f4cdf1d05ca 100644
> --- a/configs/ls1046aqds_sdcard_ifc_defconfig
> +++ b/configs/ls1046aqds_sdcard_ifc_defconfig
> @@ -53,6 +53,8 @@ CONFIG_SPL_PAD_TO=3D0x21000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x10020000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x110
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1046aqds_sdcard_qspi_defconfig b/configs/ls1046aqd=
s_sdcard_qspi_defconfig
> index 52d826fb0614..89d52aa33ccb 100644
> --- a/configs/ls1046aqds_sdcard_qspi_defconfig
> +++ b/configs/ls1046aqds_sdcard_qspi_defconfig
> @@ -53,6 +53,8 @@ CONFIG_SPL_PAD_TO=3D0x21000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x10020000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x110
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1046ardb_emmc_defconfig b/configs/ls1046ardb_emmc_=
defconfig
> index 6e0ce4dade06..11725e5aa0c4 100644
> --- a/configs/ls1046ardb_emmc_defconfig
> +++ b/configs/ls1046ardb_emmc_defconfig
> @@ -43,6 +43,8 @@ CONFIG_SPL_PAD_TO=3D0x21000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x10020000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x110
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1046ardb_qspi_spl_defconfig b/configs/ls1046ardb_q=
spi_spl_defconfig
> index 39e38e479788..ae7d0b32694e 100644
> --- a/configs/ls1046ardb_qspi_spl_defconfig
> +++ b/configs/ls1046ardb_qspi_spl_defconfig
> @@ -46,6 +46,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x10020000
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_MPC8XXX_INIT_DDR=3Dy
> diff --git a/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig b/configs/ls=
1046ardb_sdcard_SECURE_BOOT_defconfig
> index 852824eeff5b..ea8588c86ae8 100644
> --- a/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
> +++ b/configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
> @@ -40,6 +40,8 @@ CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_PAD_TO=3D0x21000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x10020000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x110
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1046ardb_sdcard_defconfig b/configs/ls1046ardb_sdc=
ard_defconfig
> index 85a8ec9b1085..ed87dbaffd9a 100644
> --- a/configs/ls1046ardb_sdcard_defconfig
> +++ b/configs/ls1046ardb_sdcard_defconfig
> @@ -43,6 +43,8 @@ CONFIG_SPL_PAD_TO=3D0x21000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
>  CONFIG_SPL_FSL_PBL=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x10020000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x110
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1088aqds_sdcard_ifc_defconfig b/configs/ls1088aqds=
_sdcard_ifc_defconfig
> index ca634fd39861..8b03ff8062b8 100644
> --- a/configs/ls1088aqds_sdcard_ifc_defconfig
> +++ b/configs/ls1088aqds_sdcard_ifc_defconfig
> @@ -43,6 +43,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_RESET_PHY_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x16000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x18009ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x8b0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1088aqds_sdcard_qspi_defconfig b/configs/ls1088aqd=
s_sdcard_qspi_defconfig
> index b21ce6794bd3..5cd2ca27087c 100644
> --- a/configs/ls1088aqds_sdcard_qspi_defconfig
> +++ b/configs/ls1088aqds_sdcard_qspi_defconfig
> @@ -44,6 +44,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_RESET_PHY_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x16000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x18009ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x8b0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig b/confi=
gs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
> index e8397fcd4ed2..e7500e14eaf7 100644
> --- a/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
> +++ b/configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
> @@ -44,6 +44,8 @@ CONFIG_MISC_INIT_R=3Dy
>  CONFIG_RESET_PHY_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x16000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x18009ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x8b0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls1088ardb_sdcard_qspi_defconfig b/configs/ls1088ard=
b_sdcard_qspi_defconfig
> index 283dcccc905e..db65a7c05683 100644
> --- a/configs/ls1088ardb_sdcard_qspi_defconfig
> +++ b/configs/ls1088ardb_sdcard_qspi_defconfig
> @@ -45,6 +45,8 @@ CONFIG_MISC_INIT_R=3Dy
>  CONFIG_RESET_PHY_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x16000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x18009ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x8b0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_=
defconfig
> index 0c57920b4877..08f9536d22a2 100644
> --- a/configs/ls2080aqds_nand_defconfig
> +++ b/configs/ls2080aqds_nand_defconfig
> @@ -36,6 +36,8 @@ CONFIG_RESET_PHY_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x16000
>  CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x18009ff0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_MPC8XXX_INIT_DDR=3Dy
> diff --git a/configs/ls2080aqds_sdcard_defconfig b/configs/ls2080aqds_sdc=
ard_defconfig
> index 23c20203ba75..f8978da43ca9 100644
> --- a/configs/ls2080aqds_sdcard_defconfig
> +++ b/configs/ls2080aqds_sdcard_defconfig
> @@ -36,6 +36,8 @@ CONFIG_BOOTCOMMAND=3D"mmc read 0x80200000 0x6800 0x800;=
 fsl_mc apply dpl 0x8020000
>  CONFIG_RESET_PHY_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x16000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x18009ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x8b0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_=
defconfig
> index e703a8cba860..7304c4d02467 100644
> --- a/configs/ls2080ardb_nand_defconfig
> +++ b/configs/ls2080ardb_nand_defconfig
> @@ -42,6 +42,8 @@ CONFIG_RESET_PHY_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x16000
>  CONFIG_SPL_PAD_TO=3D0x80000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x18009ff0
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_MPC8XXX_INIT_DDR=3Dy
> diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
> index 336ba0180e72..455f19617aca 100644
> --- a/configs/m53menlo_defconfig
> +++ b/configs/m53menlo_defconfig
> @@ -34,6 +34,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_PAD_TO=3D0x8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x70004000
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/maxbcm_defconfig b/configs/maxbcm_defconfig
> index 9c22966d8847..457e56919d05 100644
> --- a/configs/maxbcm_defconfig
> +++ b/configs/maxbcm_defconfig
> @@ -27,6 +27,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1bfd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_I2C=3Dy
> diff --git a/configs/mccmon6_nor_defconfig b/configs/mccmon6_nor_defconfi=
g
> index 3718d08b6700..cef2bb0ba5bc 100644
> --- a/configs/mccmon6_nor_defconfig
> +++ b/configs/mccmon6_nor_defconfig
> @@ -24,6 +24,8 @@ CONFIG_SPL_LOAD_FIT=3Dy
>  # CONFIG_USE_BOOTCOMMAND is not set
>  CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FIT_IMAGE_TINY=3Dy
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_NOR_SUPPORT=3Dy
> diff --git a/configs/mccmon6_sd_defconfig b/configs/mccmon6_sd_defconfig
> index 3228050dd206..8f3b4ecfc9d3 100644
> --- a/configs/mccmon6_sd_defconfig
> +++ b/configs/mccmon6_sd_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SPL_LOAD_FIT=3Dy
>  # CONFIG_USE_BOOTCOMMAND is not set
>  CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_NOR_SUPPORT=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/medcom-wide_defconfig b/configs/medcom-wide_defconfi=
g
> index 4b2e305c1070..855b88b75a60 100644
> --- a/configs/medcom-wide_defconfig
> +++ b/configs/medcom-wide_defconfig
> @@ -15,6 +15,8 @@ CONFIG_OF_SYSTEM_SETUP=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffffc
>  CONFIG_SYS_PROMPT=3D"Tegra20 (Medcom-Wide) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2089
> diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-ge=
neric_defconfig
> index a7698ac1ec10..86bda86b72f2 100644
> --- a/configs/microblaze-generic_defconfig
> +++ b/configs/microblaze-generic_defconfig
> @@ -28,6 +28,8 @@ CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0xffb00
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x100000
>  CONFIG_SPL_NOR_SUPPORT=3Dy
>  CONFIG_SPL_OS_BOOT=3Dy
>  CONFIG_SYS_OS_BASE=3D0x2c060000
> diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfi=
g
> index c1151d13b602..7000b89311a2 100644
> --- a/configs/miqi-rk3288_defconfig
> +++ b/configs/miqi-rk3288_defconfig
> @@ -24,6 +24,8 @@ CONFIG_SILENT_CONSOLE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  CONFIG_CMD_GPIO=3Dy
> diff --git a/configs/mixtile_loftq_defconfig b/configs/mixtile_loftq_defc=
onfig
> index 0cd94d7b4381..11e3dfcf4bab 100644
> --- a/configs/mixtile_loftq_defconfig
> +++ b/configs/mixtile_loftq_defconfig
> @@ -9,6 +9,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_USB1_VBUS_PIN=3D"PH24"
>  CONFIG_USB2_VBUS_PIN=3D""
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_REALTEK=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
> diff --git a/configs/mk802_a10s_defconfig b/configs/mk802_a10s_defconfig
> index 1fa1f0031b06..3ce7e5f1d68a 100644
> --- a/configs/mk802_a10s_defconfig
> +++ b/configs/mk802_a10s_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D432
>  CONFIG_DRAM_EMR1=3D0
>  CONFIG_USB1_VBUS_PIN=3D"PB10"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/mk802_defconfig b/configs/mk802_defconfig
> index 281130a43e29..0fd8d3adbd21 100644
> --- a/configs/mk802_defconfig
> +++ b/configs/mk802_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN4I=3Dy
>  CONFIG_USB2_VBUS_PIN=3D"PH12"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
>  CONFIG_SYS_I2C_SLAVE=3D0x7f
> diff --git a/configs/mk802ii_defconfig b/configs/mk802ii_defconfig
> index 8123d900d934..942911bddbaf 100644
> --- a/configs/mk802ii_defconfig
> +++ b/configs/mk802ii_defconfig
> @@ -4,6 +4,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"sun4i-a10-mk802ii"
>  CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN4I=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
> index fadea658eb25..7df44fb81f11 100644
> --- a/configs/mk808_defconfig
> +++ b/configs/mk808_defconfig
> @@ -36,6 +36,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x32000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x1008ffff
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x200000
>  CONFIG_SPL_SEPARATE_BSS=3Dy
> diff --git a/configs/mt7629_rfb_defconfig b/configs/mt7629_rfb_defconfig
> index 3ee77f39a3db..f5e3c26d66ce 100644
> --- a/configs/mt7629_rfb_defconfig
> +++ b/configs/mt7629_rfb_defconfig
> @@ -28,6 +28,8 @@ CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x10000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x106000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_NOR_SUPPORT=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
> diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
> index 41122ade90e1..016a54f7cb35 100644
> --- a/configs/mx6cuboxi_defconfig
> +++ b/configs/mx6cuboxi_defconfig
> @@ -26,6 +26,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run di=
stro_bootcmd"
>  CONFIG_USE_PREBOOT=3Dy
>  CONFIG_PREBOOT=3D"if hdmidet; then usb start; setenv stdin  serial,usbkb=
d; setenv stdout serial,vidconsole; setenv stderr serial,vidconsole; else s=
etenv stdin  serial; setenv stdout serial; setenv stderr serial; fi;"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
> index d555dbf7b1be..cf807d8f3db5 100644
> --- a/configs/mx6memcal_defconfig
> +++ b/configs/mx6memcal_defconfig
> @@ -15,6 +15,8 @@ CONFIG_SPL=3Dy
>  CONFIG_SYS_MEMTEST_START=3D0x10000000
>  CONFIG_SYS_MEMTEST_END=3D0x20000000
>  CONFIG_SUPPORT_RAW_INITRD=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_HUSH_PARSER=3Dy
> diff --git a/configs/mx6sabreauto_defconfig b/configs/mx6sabreauto_defcon=
fig
> index 3d2e906f934b..016898f9ab11 100644
> --- a/configs/mx6sabreauto_defconfig
> +++ b/configs/mx6sabreauto_defconfig
> @@ -33,6 +33,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt;mmc dev ${mmcdev};if =
mmc rescan; then if run loa
>  CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
>  CONFIG_SPL_LEGACY_IMAGE_FORMAT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FIT_IMAGE_TINY=3Dy
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
> diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
> index 33d8db9dff23..072617681dba 100644
> --- a/configs/mx6sabresd_defconfig
> +++ b/configs/mx6sabresd_defconfig
> @@ -32,6 +32,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt;mmc dev ${mmcdev};if =
mmc rescan; then if run loa
>  CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
>  CONFIG_SPL_LEGACY_IMAGE_FORMAT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FIT_IMAGE_TINY=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
> diff --git a/configs/mx6slevk_spl_defconfig b/configs/mx6slevk_spl_defcon=
fig
> index 24407c113d65..a5ccf579029a 100644
> --- a/configs/mx6slevk_spl_defconfig
> +++ b/configs/mx6slevk_spl_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SUPPORT_RAW_INITRD=3Dy
>  CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"mmc dev ${mmcdev}; if mmc rescan; then if run load=
bootscript; then run bootscript; else if run loadimage; then run mmcboot; e=
lse run netboot; fi; fi; else run netboot; fi"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/mx6ul_14x14_evk_defconfig b/configs/mx6ul_14x14_evk_=
defconfig
> index 065ead0a7ad2..8d182478164c 100644
> --- a/configs/mx6ul_14x14_evk_defconfig
> +++ b/configs/mx6ul_14x14_evk_defconfig
> @@ -27,6 +27,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt;mmc dev ${mmcdev};mmc=
 dev ${mmcdev}; if mmc resc
>  # CONFIG_CONSOLE_MUX is not set
>  CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/mx6ul_9x9_evk_defconfig b/configs/mx6ul_9x9_evk_defc=
onfig
> index 2f46b68cbe97..65c1c7785998 100644
> --- a/configs/mx6ul_9x9_evk_defconfig
> +++ b/configs/mx6ul_9x9_evk_defconfig
> @@ -27,6 +27,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt;mmc dev ${mmcdev};mmc=
 dev ${mmcdev}; if mmc resc
>  # CONFIG_CONSOLE_MUX is not set
>  CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/myir_mys_6ulx_defconfig b/configs/myir_mys_6ulx_defc=
onfig
> index f5ccf669f292..fdd7d024ae87 100644
> --- a/configs/myir_mys_6ulx_defconfig
> +++ b/configs/myir_mys_6ulx_defconfig
> @@ -19,6 +19,8 @@ CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_FIT=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
> diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk339=
9_defconfig
> index a1d66c51b5c3..6c023fbe4055 100644
> --- a/configs/nanopc-t4-rk3399_defconfig
> +++ b/configs/nanopc-t4-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2=
gb-rk3399_defconfig
> index c3ecb9946069..390cfbb60f15 100644
> --- a/configs/nanopi-m4-2gb-rk3399_defconfig
> +++ b/configs/nanopi-m4-2gb-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk339=
9_defconfig
> index 608bed247c93..37d91e53912a 100644
> --- a/configs/nanopi-m4-rk3399_defconfig
> +++ b/configs/nanopi-m4-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3=
399_defconfig
> index 125c3ee30e35..7bf1ca299d59 100644
> --- a/configs/nanopi-m4b-rk3399_defconfig
> +++ b/configs/nanopi-m4b-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-r=
k3399_defconfig
> index 3d159ff488ad..69174b951223 100644
> --- a/configs/nanopi-neo4-rk3399_defconfig
> +++ b/configs/nanopi-neo4-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3=
328_defconfig
> index 0049655be380..b1e2a6d3bfee 100644
> --- a/configs/nanopi-r2s-rk3328_defconfig
> +++ b/configs/nanopi-r2s-rk3328_defconfig
> @@ -33,6 +33,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_POWER=3Dy
> diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3=
399_defconfig
> index cd7a521d84e2..ca10940e79b8 100644
> --- a/configs/nanopi-r4s-rk3399_defconfig
> +++ b/configs/nanopi-r4s-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/nanopi_a64_defconfig b/configs/nanopi_a64_defconfig
> index 042689e933cb..8f3c242a7a93 100644
> --- a/configs/nanopi_a64_defconfig
> +++ b/configs/nanopi_a64_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN50I=3Dy
>  CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/nanopi_m1_defconfig b/configs/nanopi_m1_defconfig
> index 547c20358f25..47a6b7804e37 100644
> --- a/configs/nanopi_m1_defconfig
> +++ b/configs/nanopi_m1_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D408
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
> diff --git a/configs/nanopi_m1_plus_defconfig b/configs/nanopi_m1_plus_de=
fconfig
> index 5ce046cd3f70..c71d721f743a 100644
> --- a/configs/nanopi_m1_plus_defconfig
> +++ b/configs/nanopi_m1_plus_defconfig
> @@ -8,6 +8,7 @@ CONFIG_MACPWR=3D"PD6"
>  CONFIG_MMC0_CD_PIN=3D"PH13"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/nanopi_neo2_defconfig b/configs/nanopi_neo2_defconfi=
g
> index f994fceffd4a..66df94b33b9f 100644
> --- a/configs/nanopi_neo2_defconfig
> +++ b/configs/nanopi_neo2_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D672
>  CONFIG_DRAM_ZQ=3D3881977
>  # CONFIG_DRAM_ODT_EN is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/nanopi_neo_air_defconfig b/configs/nanopi_neo_air_de=
fconfig
> index 23c1527e9cd2..b83b6a3499dd 100644
> --- a/configs/nanopi_neo_air_defconfig
> +++ b/configs/nanopi_neo_air_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D408
>  # CONFIG_VIDEO_DE2 is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
> diff --git a/configs/nanopi_neo_defconfig b/configs/nanopi_neo_defconfig
> index e46e5b810594..f8377535e97d 100644
> --- a/configs/nanopi_neo_defconfig
> +++ b/configs/nanopi_neo_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D408
>  # CONFIG_VIDEO_DE2 is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/nanopi_neo_plus2_defconfig b/configs/nanopi_neo_plus=
2_defconfig
> index 8eb370ab6a4d..60f26318429b 100644
> --- a/configs/nanopi_neo_plus2_defconfig
> +++ b/configs/nanopi_neo_plus2_defconfig
> @@ -9,6 +9,7 @@ CONFIG_DRAM_ZQ=3D3881977
>  CONFIG_MACPWR=3D"PD6"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/nanopi_r1s_h5_defconfig b/configs/nanopi_r1s_h5_defc=
onfig
> index 9d0a4d7e5009..06c564ec8cd8 100644
> --- a/configs/nanopi_r1s_h5_defconfig
> +++ b/configs/nanopi_r1s_h5_defconfig
> @@ -9,6 +9,7 @@ CONFIG_DRAM_ZQ=3D3881977
>  CONFIG_MACPWR=3D"PD6"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/novena_defconfig b/configs/novena_defconfig
> index 215aaa605b52..3faeaf150d5f 100644
> --- a/configs/novena_defconfig
> +++ b/configs/novena_defconfig
> @@ -31,6 +31,8 @@ CONFIG_BOOTARGS=3D"console=3Dttymxc1,115200 "
>  CONFIG_BOOTCOMMAND=3D"run distro_bootcmd ; run net_nfs"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
> index 4433b65644f8..1ffddbe35e36 100644
> --- a/configs/nyan-big_defconfig
> +++ b/configs/nyan-big_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0xef8100
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Tegra124 (Nyan-big) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2087
> diff --git a/configs/oceanic_5205_5inmfd_defconfig b/configs/oceanic_5205=
_5inmfd_defconfig
> index 5392e3485f57..21468c426b52 100644
> --- a/configs/oceanic_5205_5inmfd_defconfig
> +++ b/configs/oceanic_5205_5inmfd_defconfig
> @@ -10,6 +10,7 @@ CONFIG_DRAM_ZQ=3D3881949
>  CONFIG_MMC0_CD_PIN=3D""
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_SPI=3Dy
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index 2990b65347e9..6925c26bc106 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -39,6 +39,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_TPL_BANNER_PRINT is not set
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/omapl138_lcdk_defconfig b/configs/omapl138_lcdk_defc=
onfig
> index 8b3796dfb636..5669c355e93e 100644
> --- a/configs/omapl138_lcdk_defconfig
> +++ b/configs/omapl138_lcdk_defconfig
> @@ -37,6 +37,8 @@ CONFIG_SPL_PAD_TO=3D0x8000
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x8001ff00
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0xb5
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
> diff --git a/configs/openpiton_riscv64_spl_defconfig b/configs/openpiton_=
riscv64_spl_defconfig
> index 8d2ddedb54c8..e041de4b2b1c 100644
> --- a/configs/openpiton_riscv64_spl_defconfig
> +++ b/configs/openpiton_riscv64_spl_defconfig
> @@ -25,6 +25,8 @@ CONFIG_BOOTCOMMAND=3D"fdt addr ${fdtcontroladdr}; fdt m=
ove ${fdtcontroladdr} ${fdt
>  CONFIG_SPL_MAX_SIZE=3D0x100000
>  # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x83fffe80
>  # CONFIG_SPL_BANNER_PRINT is not set
>  CONFIG_SPL_CPU=3Dy
>  CONFIG_SPL_FS_EXT4=3Dy
> diff --git a/configs/opos6uldev_defconfig b/configs/opos6uldev_defconfig
> index 8b0b4c33e140..ddf879d19eb3 100644
> --- a/configs/opos6uldev_defconfig
> +++ b/configs/opos6uldev_defconfig
> @@ -31,6 +31,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"imx6ul-opos6uldev.dtb"
>  # CONFIG_CONSOLE_MUX is not set
>  CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_SPL_YMODEM_SUPPORT=3Dy
> diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_=
defconfig
> index 6a8e33321104..790936dff340 100644
> --- a/configs/orangepi-rk3399_defconfig
> +++ b/configs/orangepi-rk3399_defconfig
> @@ -20,6 +20,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/orangepi_2_defconfig b/configs/orangepi_2_defconfig
> index f1e260317ded..e18b8610847c 100644
> --- a/configs/orangepi_2_defconfig
> +++ b/configs/orangepi_2_defconfig
> @@ -7,6 +7,7 @@ CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D672
>  CONFIG_USB1_VBUS_PIN=3D"PG13"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/orangepi_3_defconfig b/configs/orangepi_3_defconfig
> index 59e85bb24e84..824f017dae45 100644
> --- a/configs/orangepi_3_defconfig
> +++ b/configs/orangepi_3_defconfig
> @@ -8,6 +8,7 @@ CONFIG_MMC0_CD_PIN=3D"PF6"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_BLUETOOTH_DT_DEVICE_FIXUP=3D"brcm,bcm4345c5"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x118000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_PHY_SUN50I_USB3=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
> diff --git a/configs/orangepi_lite2_defconfig b/configs/orangepi_lite2_de=
fconfig
> index e7e18effd16d..cfce6cb0d478 100644
> --- a/configs/orangepi_lite2_defconfig
> +++ b/configs/orangepi_lite2_defconfig
> @@ -7,6 +7,7 @@ CONFIG_SUNXI_DRAM_H6_LPDDR3=3Dy
>  CONFIG_MMC0_CD_PIN=3D"PF6"
>  # CONFIG_PSCI_RESET is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x118000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
> diff --git a/configs/orangepi_lite_defconfig b/configs/orangepi_lite_defc=
onfig
> index 4f48ef1b5f5c..c7174170dbf2 100644
> --- a/configs/orangepi_lite_defconfig
> +++ b/configs/orangepi_lite_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D672
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
> diff --git a/configs/orangepi_one_defconfig b/configs/orangepi_one_defcon=
fig
> index ee9d8f397b2e..112ff5e5b6ac 100644
> --- a/configs/orangepi_one_defconfig
> +++ b/configs/orangepi_one_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D672
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/orangepi_one_plus_defconfig b/configs/orangepi_one_p=
lus_defconfig
> index e13a32041ae5..63d3addbdd38 100644
> --- a/configs/orangepi_one_plus_defconfig
> +++ b/configs/orangepi_one_plus_defconfig
> @@ -7,6 +7,7 @@ CONFIG_SUNXI_DRAM_H6_LPDDR3=3Dy
>  CONFIG_MMC0_CD_PIN=3D"PF6"
>  # CONFIG_PSCI_RESET is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x118000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
> diff --git a/configs/orangepi_pc2_defconfig b/configs/orangepi_pc2_defcon=
fig
> index 6a6b81fa3936..7b12bf00ff24 100644
> --- a/configs/orangepi_pc2_defconfig
> +++ b/configs/orangepi_pc2_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DRAM_ZQ=3D3881977
>  CONFIG_MACPWR=3D"PD6"
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/orangepi_pc_defconfig b/configs/orangepi_pc_defconfi=
g
> index 2ef2a962f413..28107ad5f7a2 100644
> --- a/configs/orangepi_pc_defconfig
> +++ b/configs/orangepi_pc_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SPL=3Dy
>  CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D624
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/orangepi_pc_plus_defconfig b/configs/orangepi_pc_plu=
s_defconfig
> index 8457b78a39c9..30638679bc6e 100644
> --- a/configs/orangepi_pc_plus_defconfig
> +++ b/configs/orangepi_pc_plus_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN8I_H3=3Dy
>  CONFIG_DRAM_CLK=3D624
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/orangepi_plus2e_defconfig b/configs/orangepi_plus2e_=
defconfig
> index f33b75d5e3db..85b25ddd1677 100644
> --- a/configs/orangepi_plus2e_defconfig
> +++ b/configs/orangepi_plus2e_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D672
>  CONFIG_MACPWR=3D"PD6"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/orangepi_plus_defconfig b/configs/orangepi_plus_defc=
onfig
> index e8fda9a5f113..dff0a2fd6e98 100644
> --- a/configs/orangepi_plus_defconfig
> +++ b/configs/orangepi_plus_defconfig
> @@ -9,6 +9,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_USB1_VBUS_PIN=3D"PG13"
>  CONFIG_SATAPWR=3D"PG11"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/orangepi_prime_defconfig b/configs/orangepi_prime_de=
fconfig
> index 29ef1b8553ab..8c4cb57ef0f9 100644
> --- a/configs/orangepi_prime_defconfig
> +++ b/configs/orangepi_prime_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D672
>  CONFIG_DRAM_ZQ=3D3881977
>  # CONFIG_DRAM_ODT_EN is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/orangepi_r1_defconfig b/configs/orangepi_r1_defconfi=
g
> index 6b68f77833df..e15069c048e8 100644
> --- a/configs/orangepi_r1_defconfig
> +++ b/configs/orangepi_r1_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DRAM_CLK=3D624
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPI_FLASH_WINBOND=3Dy
>  CONFIG_SUN8I_EMAC=3Dy
> diff --git a/configs/orangepi_win_defconfig b/configs/orangepi_win_defcon=
fig
> index 9fce313eb9e5..830cbbaaeba3 100644
> --- a/configs/orangepi_win_defconfig
> +++ b/configs/orangepi_win_defconfig
> @@ -7,6 +7,7 @@ CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=3Dy
>  CONFIG_MACPWR=3D"PD14"
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPI_FLASH_WINBOND=3Dy
>  CONFIG_PHY_REALTEK=3Dy
> diff --git a/configs/orangepi_zero2_defconfig b/configs/orangepi_zero2_de=
fconfig
> index d9c89c88a97d..62117548e2bc 100644
> --- a/configs/orangepi_zero2_defconfig
> +++ b/configs/orangepi_zero2_defconfig
> @@ -11,6 +11,7 @@ CONFIG_MMC0_CD_PIN=3D"PF6"
>  CONFIG_R_I2C_ENABLE=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_MAX_SIZE=3D0xbfa0
> +CONFIG_SPL_STACK=3D0x58000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/orangepi_zero_defconfig b/configs/orangepi_zero_defc=
onfig
> index e6af0fb8e7d6..b5ff84aaf67c 100644
> --- a/configs/orangepi_zero_defconfig
> +++ b/configs/orangepi_zero_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DRAM_CLK=3D624
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPI_FLASH_WINBOND=3Dy
>  CONFIG_SUN8I_EMAC=3Dy
> diff --git a/configs/orangepi_zero_plus2_defconfig b/configs/orangepi_zer=
o_plus2_defconfig
> index 623dd040835e..79040125dcc3 100644
> --- a/configs/orangepi_zero_plus2_defconfig
> +++ b/configs/orangepi_zero_plus2_defconfig
> @@ -9,6 +9,7 @@ CONFIG_DRAM_ZQ=3D3881977
>  CONFIG_MMC0_CD_PIN=3D"PH13"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/orangepi_zero_plus2_h3_defconfig b/configs/orangepi_=
zero_plus2_h3_defconfig
> index ff73e84a58d3..b2d4f3f8e07d 100644
> --- a/configs/orangepi_zero_plus2_h3_defconfig
> +++ b/configs/orangepi_zero_plus2_h3_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DRAM_CLK=3D672
>  CONFIG_MMC0_CD_PIN=3D"PH13"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/orangepi_zero_plus_defconfig b/configs/orangepi_zero=
_plus_defconfig
> index e7d6b5d32cad..008384e46014 100644
> --- a/configs/orangepi_zero_plus_defconfig
> +++ b/configs/orangepi_zero_plus_defconfig
> @@ -7,6 +7,7 @@ CONFIG_DRAM_CLK=3D624
>  CONFIG_DRAM_ZQ=3D3881977
>  # CONFIG_DRAM_ODT_EN is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/parrot_r16_defconfig b/configs/parrot_r16_defconfig
> index 5922e645075c..14e9b455feb7 100644
> --- a/configs/parrot_r16_defconfig
> +++ b/configs/parrot_r16_defconfig
> @@ -11,6 +11,7 @@ CONFIG_USB0_ID_DET=3D"PD10"
>  CONFIG_USB1_VBUS_PIN=3D"PD12"
>  CONFIG_AXP_GPIO=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_CONS_INDEX=3D5
> diff --git a/configs/paz00_defconfig b/configs/paz00_defconfig
> index 08106e981117..091c9a2b4846 100644
> --- a/configs/paz00_defconfig
> +++ b/configs/paz00_defconfig
> @@ -14,6 +14,8 @@ CONFIG_OF_SYSTEM_SETUP=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffffc
>  CONFIG_SYS_PROMPT=3D"Tegra20 (Paz00) MOD # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2087
> diff --git a/configs/pcm058_defconfig b/configs/pcm058_defconfig
> index 54bef4e062e3..f66589948824 100644
> --- a/configs/pcm058_defconfig
> +++ b/configs/pcm058_defconfig
> @@ -30,6 +30,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_BOOTCOMMAND=3D"run mmcboot;run nandboot"
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x93ffb8
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x18a
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_FS_EXT4=3Dy
> diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_de=
fconfig
> index 492451da0441..8450d2fc31ec 100644
> --- a/configs/phycore-imx8mm_defconfig
> +++ b/configs/phycore-imx8mm_defconfig
> @@ -29,6 +29,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_de=
fconfig
> index bc2fe25545e7..8d783d30cc32 100644
> --- a/configs/phycore-imx8mp_defconfig
> +++ b/configs/phycore-imx8mp_defconfig
> @@ -32,6 +32,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x400
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x960000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_de=
fconfig
> index 522dd6679d72..d791e9dcf8d4 100644
> --- a/configs/phycore-rk3288_defconfig
> +++ b/configs/phycore-rk3288_defconfig
> @@ -25,6 +25,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  CONFIG_CMD_GPIO=3Dy
> diff --git a/configs/phycore_pcl063_defconfig b/configs/phycore_pcl063_de=
fconfig
> index 6dcb789609f0..442dcc75ee04 100644
> --- a/configs/phycore_pcl063_defconfig
> +++ b/configs/phycore_pcl063_defconfig
> @@ -18,6 +18,8 @@ CONFIG_SYS_MEMTEST_END=3D0x90000000
>  CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/phycore_pcl063_ull_defconfig b/configs/phycore_pcl06=
3_ull_defconfig
> index e40ca07b7c08..96ea32747053 100644
> --- a/configs/phycore_pcl063_ull_defconfig
> +++ b/configs/phycore_pcl063_ull_defconfig
> @@ -18,6 +18,8 @@ CONFIG_FIT=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_BOOTCOMMAND=3D"run mmc_mmc_fit"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/pico-dwarf-imx6ul_defconfig b/configs/pico-dwarf-imx=
6ul_defconfig
> index 15dc2098ad44..298865bb2b9f 100644
> --- a/configs/pico-dwarf-imx6ul_defconfig
> +++ b/configs/pico-dwarf-imx6ul_defconfig
> @@ -25,6 +25,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run distro_bootcmd"
>  CONFIG_DEFAULT_FDT_FILE=3D"imx6ul-pico-dwarf.dtb"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
>  CONFIG_SPL_USB_SDP_SUPPORT=3Dy
> diff --git a/configs/pico-dwarf-imx7d_defconfig b/configs/pico-dwarf-imx7=
d_defconfig
> index 00067d2e46d9..e1d0e3438ddb 100644
> --- a/configs/pico-dwarf-imx7d_defconfig
> +++ b/configs/pico-dwarf-imx7d_defconfig
> @@ -27,6 +27,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run di=
stro_bootcmd"
>  CONFIG_DEFAULT_FDT_FILE=3D"imx7d-pico-dwarf.dtb"
>  CONFIG_SPL_MAX_SIZE=3D0xe000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x946bb8
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
> diff --git a/configs/pico-hobbit-imx6ul_defconfig b/configs/pico-hobbit-i=
mx6ul_defconfig
> index eeb95d431dbc..15fe0df9c00c 100644
> --- a/configs/pico-hobbit-imx6ul_defconfig
> +++ b/configs/pico-hobbit-imx6ul_defconfig
> @@ -26,6 +26,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run distro_bootcmd"
>  CONFIG_DEFAULT_FDT_FILE=3D"imx6ul-pico-hobbit.dtb"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
>  CONFIG_SPL_USB_SDP_SUPPORT=3Dy
> diff --git a/configs/pico-hobbit-imx7d_defconfig b/configs/pico-hobbit-im=
x7d_defconfig
> index 64c2ca4b189f..4ccbcf90a618 100644
> --- a/configs/pico-hobbit-imx7d_defconfig
> +++ b/configs/pico-hobbit-imx7d_defconfig
> @@ -27,6 +27,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run di=
stro_bootcmd"
>  CONFIG_DEFAULT_FDT_FILE=3D"imx7d-pico-hobbit.dtb"
>  CONFIG_SPL_MAX_SIZE=3D0xe000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x946bb8
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
> diff --git a/configs/pico-imx6_defconfig b/configs/pico-imx6_defconfig
> index 09809542606d..bc20d4253327 100644
> --- a/configs/pico-imx6_defconfig
> +++ b/configs/pico-imx6_defconfig
> @@ -27,6 +27,8 @@ CONFIG_SPL_LOAD_FIT=3Dy
>  CONFIG_BOOTCOMMAND=3D"run default_boot"
>  CONFIG_DEFAULT_FDT_FILE=3D"ask"
>  CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FIT_IMAGE_TINY=3Dy
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
> diff --git a/configs/pico-imx6ul_defconfig b/configs/pico-imx6ul_defconfi=
g
> index 7e923d0bc027..37cbc96dc0ed 100644
> --- a/configs/pico-imx6ul_defconfig
> +++ b/configs/pico-imx6ul_defconfig
> @@ -26,6 +26,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run distro_bootcmd"
>  CONFIG_DEFAULT_FDT_FILE=3D"ask"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
>  CONFIG_SPL_USB_SDP_SUPPORT=3Dy
> diff --git a/configs/pico-imx7d_bl33_defconfig b/configs/pico-imx7d_bl33_=
defconfig
> index d13336d0548c..3d342d78186b 100644
> --- a/configs/pico-imx7d_bl33_defconfig
> +++ b/configs/pico-imx7d_bl33_defconfig
> @@ -28,6 +28,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run distro_bootcmd"
>  CONFIG_SPL_MAX_SIZE=3D0xe000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x946bb8
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
> diff --git a/configs/pico-imx7d_defconfig b/configs/pico-imx7d_defconfig
> index a6ee5cebfe26..df57fa13321a 100644
> --- a/configs/pico-imx7d_defconfig
> +++ b/configs/pico-imx7d_defconfig
> @@ -27,6 +27,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run di=
stro_bootcmd"
>  CONFIG_DEFAULT_FDT_FILE=3D"ask"
>  CONFIG_SPL_MAX_SIZE=3D0xe000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x946bb8
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
> diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfi=
g
> index b706b80874f2..1a8f2015b8a8 100644
> --- a/configs/pico-imx8mq_defconfig
> +++ b/configs/pico-imx8mq_defconfig
> @@ -33,6 +33,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1f000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x187ff0
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/pico-nymph-imx7d_defconfig b/configs/pico-nymph-imx7=
d_defconfig
> index 00067d2e46d9..e1d0e3438ddb 100644
> --- a/configs/pico-nymph-imx7d_defconfig
> +++ b/configs/pico-nymph-imx7d_defconfig
> @@ -27,6 +27,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run di=
stro_bootcmd"
>  CONFIG_DEFAULT_FDT_FILE=3D"imx7d-pico-dwarf.dtb"
>  CONFIG_SPL_MAX_SIZE=3D0xe000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x946bb8
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
> diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_de=
fconfig
> index 2cc6d4f8bed5..c3613d5745f6 100644
> --- a/configs/pico-pi-imx6ul_defconfig
> +++ b/configs/pico-pi-imx6ul_defconfig
> @@ -26,6 +26,8 @@ CONFIG_BOOTDELAY=3D3
>  CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run distro_bootcmd"
>  CONFIG_DEFAULT_FDT_FILE=3D"imx6ul-pico-pi.dtb"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
>  CONFIG_SPL_USB_SDP_SUPPORT=3Dy
> diff --git a/configs/pico-pi-imx7d_defconfig b/configs/pico-pi-imx7d_defc=
onfig
> index b74b2582cb95..c799968944c6 100644
> --- a/configs/pico-pi-imx7d_defconfig
> +++ b/configs/pico-pi-imx7d_defconfig
> @@ -27,6 +27,8 @@ CONFIG_BOOTCOMMAND=3D"run findfdt; run finduuid; run di=
stro_bootcmd"
>  CONFIG_DEFAULT_FDT_FILE=3D"imx7d-pico-pi.dtb"
>  CONFIG_SPL_MAX_SIZE=3D0xe000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x946bb8
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_USB_GADGET=3Dy
> diff --git a/configs/pine64-lts_defconfig b/configs/pine64-lts_defconfig
> index 94c03f16a8c3..c6b4f7bf1438 100644
> --- a/configs/pine64-lts_defconfig
> +++ b/configs/pine64-lts_defconfig
> @@ -10,6 +10,7 @@ CONFIG_MMC0_CD_PIN=3D""
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_SPI_FLASH_WINBOND=3Dy
> diff --git a/configs/pine64_plus_defconfig b/configs/pine64_plus_defconfi=
g
> index dc02ca10d7e8..7dbe061790cd 100644
> --- a/configs/pine64_plus_defconfig
> +++ b/configs/pine64_plus_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN50I=3Dy
>  CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=3Dy
>  CONFIG_PINE64_DT_SELECTION=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_OF_LIST=3D"sun50i-a64-pine64 sun50i-a64-pine64-plus"
>  CONFIG_PHY_REALTEK=3Dy
> diff --git a/configs/pine_h64_defconfig b/configs/pine_h64_defconfig
> index 7466c3b2c5fd..2cddcf58301e 100644
> --- a/configs/pine_h64_defconfig
> +++ b/configs/pine_h64_defconfig
> @@ -11,6 +11,7 @@ CONFIG_USB3_VBUS_PIN=3D"PL5"
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_PSCI_RESET is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x118000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_SPI_FLASH_WINBOND=3Dy
> diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro=
-rk3399_defconfig
> index 5f763acfcefb..c831830656c7 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_SPL_MTD_SUPPORT=3Dy
> diff --git a/configs/pinebook_defconfig b/configs/pinebook_defconfig
> index 1bdfcf27be03..bf070aab8b34 100644
> --- a/configs/pinebook_defconfig
> +++ b/configs/pinebook_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DRAM_CLK=3D552
>  CONFIG_DRAM_ZQ=3D3881949
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_R_I2C_ENABLE=3Dy
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
> index 1259b85361d0..531cf0f83b62 100644
> --- a/configs/pinecube_defconfig
> +++ b/configs/pinecube_defconfig
> @@ -8,6 +8,7 @@ CONFIG_DRAM_CLK=3D504
>  CONFIG_DRAM_ODT_EN=3Dy
>  CONFIG_I2C0_ENABLE=3Dy
>  # CONFIG_HAS_ARMV7_SECURE_BASE is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> index ae60943e95ab..d882c0cc8802 100644
> --- a/configs/pinephone_defconfig
> +++ b/configs/pinephone_defconfig
> @@ -10,6 +10,7 @@ CONFIG_DRAM_ZQ=3D3881949
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_PINEPHONE_DT_SELECTION=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_OF_LIST=3D"sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
>  CONFIG_LED_STATUS=3Dy
> diff --git a/configs/pinetab_defconfig b/configs/pinetab_defconfig
> index 4ecd241b52f1..f90cb0d1f818 100644
> --- a/configs/pinetab_defconfig
> +++ b/configs/pinetab_defconfig
> @@ -8,4 +8,5 @@ CONFIG_DRAM_CLK=3D552
>  CONFIG_DRAM_ZQ=3D3881949
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
> diff --git a/configs/plutux_defconfig b/configs/plutux_defconfig
> index 95b251627779..fe59c10b1920 100644
> --- a/configs/plutux_defconfig
> +++ b/configs/plutux_defconfig
> @@ -16,6 +16,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffffc
>  CONFIG_SYS_PROMPT=3D"Tegra20 (Plutux) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2084
> diff --git a/configs/polaroid_mid2407pxe03_defconfig b/configs/polaroid_m=
id2407pxe03_defconfig
> index ed8b780b01e1..74ffaf1d0117 100644
> --- a/configs/polaroid_mid2407pxe03_defconfig
> +++ b/configs/polaroid_mid2407pxe03_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_CONS_INDEX=3D5
> diff --git a/configs/polaroid_mid2809pxe04_defconfig b/configs/polaroid_m=
id2809pxe04_defconfig
> index 5953344491c7..10057ade9a5a 100644
> --- a/configs/polaroid_mid2809pxe04_defconfig
> +++ b/configs/polaroid_mid2809pxe04_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_CONS_INDEX=3D5
> diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_=
defconfig
> index 35ec663b3e6e..5b5039e290be 100644
> --- a/configs/popmetal-rk3288_defconfig
> +++ b/configs/popmetal-rk3288_defconfig
> @@ -25,6 +25,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  CONFIG_CMD_GPIO=3Dy
> diff --git a/configs/porter_defconfig b/configs/porter_defconfig
> index c176051cbd09..568ec18049d9 100644
> --- a/configs/porter_defconfig
> +++ b/configs/porter_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_MAX_SIZE=3D0x4000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6340000
>  CONFIG_SPL_RAM_SUPPORT=3Dy
>  CONFIG_SPL_RAM_DEVICE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/pov_protab2_ips9_defconfig b/configs/pov_protab2_ips=
9_defconfig
> index cf7f57574e04..523de63fc27a 100644
> --- a/configs/pov_protab2_ips9_defconfig
> +++ b/configs/pov_protab2_ips9_defconfig
> @@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfi=
g
> index f7431ddf3ec5..e859172c5cd7 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -26,6 +26,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x10000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff8effff
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x4000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x200
> diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30=
-core-ctouch2-of10-px30_defconfig
> index 66d2ca7c28cb..d0bada7bae70 100644
> --- a/configs/px30-core-ctouch2-of10-px30_defconfig
> +++ b/configs/px30-core-ctouch2-of10-px30_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_TPL_BANNER_PRINT is not set
>  CONFIG_SPL_ATF=3Dy
> diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core=
-ctouch2-px30_defconfig
> index 90fb411d551a..8e4de8e8b78d 100644
> --- a/configs/px30-core-ctouch2-px30_defconfig
> +++ b/configs/px30-core-ctouch2-px30_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_TPL_BANNER_PRINT is not set
>  CONFIG_SPL_ATF=3Dy
> diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-cor=
e-edimm2.2-px30_defconfig
> index cc2d5cbeacc5..3a4dbb60ebf1 100644
> --- a/configs/px30-core-edimm2.2-px30_defconfig
> +++ b/configs/px30-core-edimm2.2-px30_defconfig
> @@ -36,6 +36,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_TPL_BANNER_PRINT is not set
>  CONFIG_SPL_ATF=3Dy
> diff --git a/configs/q8_a13_tablet_defconfig b/configs/q8_a13_tablet_defc=
onfig
> index 08be8810d8ce..83981d3ac749 100644
> --- a/configs/q8_a13_tablet_defconfig
> +++ b/configs/q8_a13_tablet_defconfig
> @@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_POWER=3D"AXP0-0"
>  CONFIG_VIDEO_LCD_BL_EN=3D"AXP0-1"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/q8_a23_tablet_800x480_defconfig b/configs/q8_a23_tab=
let_800x480_defconfig
> index 6053587dddf4..11d208a34a05 100644
> --- a/configs/q8_a23_tablet_800x480_defconfig
> +++ b/configs/q8_a23_tablet_800x480_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_CONS_INDEX=3D5
> diff --git a/configs/q8_a33_tablet_1024x600_defconfig b/configs/q8_a33_ta=
blet_1024x600_defconfig
> index 0870d234e864..c848e62d73c9 100644
> --- a/configs/q8_a33_tablet_1024x600_defconfig
> +++ b/configs/q8_a33_tablet_1024x600_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_CONS_INDEX=3D5
> diff --git a/configs/q8_a33_tablet_800x480_defconfig b/configs/q8_a33_tab=
let_800x480_defconfig
> index 3b99004fb9a3..ee5654185b16 100644
> --- a/configs/q8_a33_tablet_800x480_defconfig
> +++ b/configs/q8_a33_tablet_800x480_defconfig
> @@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_POWER=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_EN=3D"PH6"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PH0"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_AXP_DLDO1_VOLT=3D3300
>  CONFIG_CONS_INDEX=3D5
> diff --git a/configs/r7-tv-dongle_defconfig b/configs/r7-tv-dongle_defcon=
fig
> index a8452ba3b742..f5adbd3686cb 100644
> --- a/configs/r7-tv-dongle_defconfig
> +++ b/configs/r7-tv-dongle_defconfig
> @@ -6,6 +6,7 @@ CONFIG_MACH_SUN5I=3Dy
>  CONFIG_DRAM_CLK=3D384
>  CONFIG_USB1_VBUS_PIN=3D"PG13"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_de=
fconfig
> index b42e13bb5588..dfb4adf6654a 100644
> --- a/configs/r8a77970_eagle_defconfig
> +++ b/configs/r8a77970_eagle_defconfig
> @@ -23,6 +23,8 @@ CONFIG_BOOTCOMMAND=3D"tftp 0x48080000 Image; tftp 0x480=
00000 Image-r8a77970-eagle.
>  CONFIG_DEFAULT_FDT_FILE=3D"r8a77970-eagle.dtb"
>  CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6304000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2068
> diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_=
defconfig
> index f05590f7b3d8..d24204d41380 100644
> --- a/configs/r8a77980_condor_defconfig
> +++ b/configs/r8a77980_condor_defconfig
> @@ -24,6 +24,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"r8a77980-condor.dtb"
>  # CONFIG_BOARD_EARLY_INIT_F is not set
>  CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6304000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2068
> diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_de=
fconfig
> index a2349c03dd56..33c277472196 100644
> --- a/configs/r8a77990_ebisu_defconfig
> +++ b/configs/r8a77990_ebisu_defconfig
> @@ -25,6 +25,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"r8a77990-ebisu.dtb"
>  CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
>  CONFIG_UPDATE_TFTP=3Dy
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6304000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2068
> diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_de=
fconfig
> index 1fe0d2abc589..f1fd84a4bd2d 100644
> --- a/configs/r8a77995_draak_defconfig
> +++ b/configs/r8a77995_draak_defconfig
> @@ -24,6 +24,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"r8a77995-draak.dtb"
>  CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
>  CONFIG_UPDATE_TFTP=3Dy
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6304000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2068
> diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_=
defconfig
> index 67e9aa3be7b4..8477127e12b8 100644
> --- a/configs/r8a779a0_falcon_defconfig
> +++ b/configs/r8a779a0_falcon_defconfig
> @@ -26,6 +26,8 @@ CONFIG_BOOTCOMMAND=3D"tftp 0x48080000 Image; tftp 0x480=
00000 Image-r8a779a0-falcon
>  CONFIG_DEFAULT_FDT_FILE=3D"r8a779a0-falcon.dtb"
>  CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6304000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2068
> diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-=
x_defconfig
> index ab865bcc9403..ce22f8b9ecc0 100644
> --- a/configs/rcar3_salvator-x_defconfig
> +++ b/configs/rcar3_salvator-x_defconfig
> @@ -24,6 +24,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"r8a77950-salvator-x.dtb"
>  CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
>  CONFIG_UPDATE_TFTP=3Dy
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6304000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2068
> diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
> index 0b512765331d..2b7c2eace4cd 100644
> --- a/configs/rcar3_ulcb_defconfig
> +++ b/configs/rcar3_ulcb_defconfig
> @@ -24,6 +24,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"r8a77950-ulcb.dtb"
>  CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
>  CONFIG_UPDATE_TFTP=3Dy
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6304000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2068
> diff --git a/configs/riotboard_defconfig b/configs/riotboard_defconfig
> index 8e74a1f087f9..a14f9a409e04 100644
> --- a/configs/riotboard_defconfig
> +++ b/configs/riotboard_defconfig
> @@ -28,6 +28,8 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
>  CONFIG_SPL_FS_LOAD_ARGS_NAME=3D"imx6dl-riotboard.dtb"
> diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defc=
onfig
> index e0464a3f2cff..a35326f9ec8f 100644
> --- a/configs/roc-cc-rk3308_defconfig
> +++ b/configs/roc-cc-rk3308_defconfig
> @@ -27,6 +27,8 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x20000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_CMD_BDI is not set
>  # CONFIG_CMD_CONSOLE is not set
> diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defc=
onfig
> index fdaf633f60fd..1b4fc3381cce 100644
> --- a/configs/roc-cc-rk3328_defconfig
> +++ b/configs/roc-cc-rk3328_defconfig
> @@ -33,6 +33,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_POWER=3Dy
> diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-m=
ezzanine-rk3399_defconfig
> index fbcac4cbdb2b..1748b7d8702a 100644
> --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> @@ -26,6 +26,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x20000
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defc=
onfig
> index b053f7e58466..7b086a1cc1dd 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -26,6 +26,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x20000
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk339=
9_defconfig
> index 89566cdc7571..d9d5f5e5efca 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -22,6 +22,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3=
399_defconfig
> index 1820b7695ec0..220b2af00881 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -22,6 +22,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk332=
8_defconfig
> index e1e50396d328..e231593bd566 100644
> --- a/configs/rock-pi-e-rk3328_defconfig
> +++ b/configs/rock-pi-e-rk3328_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n1=
0-rk3399pro_defconfig
> index c468d7d1ab38..e283476bb9a5 100644
> --- a/configs/rock-pi-n10-rk3399pro_defconfig
> +++ b/configs/rock-pi-n10-rk3399pro_defconfig
> @@ -24,6 +24,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3=
288_defconfig
> index 66258f02c801..7abb343ad698 100644
> --- a/configs/rock-pi-n8-rk3288_defconfig
> +++ b/configs/rock-pi-n8-rk3288_defconfig
> @@ -24,6 +24,8 @@ CONFIG_SILENT_CONSOLE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  CONFIG_CMD_SPL=3Dy
> diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
> index ffc11625e140..c06ab641c300 100644
> --- a/configs/rock2_defconfig
> +++ b/configs/rock2_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SILENT_CONSOLE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  CONFIG_CMD_GPIO=3Dy
> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defc=
onfig
> index 7026b6f4d920..aa4cdde4872c 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -33,6 +33,8 @@ CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_POWER=3Dy
> diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_de=
fconfig
> index 788adb83e2dc..5e9f2cff33f3 100644
> --- a/configs/rock960-rk3399_defconfig
> +++ b/configs/rock960-rk3399_defconfig
> @@ -21,6 +21,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_TPL=3Dy
> diff --git a/configs/rock_defconfig b/configs/rock_defconfig
> index dfc9257225fc..e99272ef2268 100644
> --- a/configs/rock_defconfig
> +++ b/configs/rock_defconfig
> @@ -27,6 +27,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x7800
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x10087fff
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  CONFIG_RANDOM_UUID=3Dy
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk339=
9_defconfig
> index 8a66931edd0f..fff00fba6d91 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SPL_MAX_SIZE=3D0x2e000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x400000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x10000
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/sama5d27_giantboard_defconfig b/configs/sama5d27_gia=
ntboard_defconfig
> index 4dec17850bd1..50f5cacbdde9 100644
> --- a/configs/sama5d27_giantboard_defconfig
> +++ b/configs/sama5d27_giantboard_defconfig
> @@ -40,6 +40,8 @@ CONFIG_BOOTCOMMAND=3D"fatload mmc 0 0x22000000 at91-sam=
a5d27_giantboard.dtb; fatlo
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d27_som1_ek_mmc1_defconfig b/configs/sama5d27_s=
om1_ek_mmc1_defconfig
> index 2d617200e9e9..76af9fc8cb1b 100644
> --- a/configs/sama5d27_som1_ek_mmc1_defconfig
> +++ b/configs/sama5d27_som1_ek_mmc1_defconfig
> @@ -36,6 +36,8 @@ CONFIG_BOOTCOMMAND=3D"fatload mmc 1 0x22000000 at91-sam=
a5d27_som1_ek.dtb; fatload
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d27_som1_ek_mmc_defconfig b/configs/sama5d27_so=
m1_ek_mmc_defconfig
> index 5bbae1299ad2..3852754ceb37 100644
> --- a/configs/sama5d27_som1_ek_mmc_defconfig
> +++ b/configs/sama5d27_som1_ek_mmc_defconfig
> @@ -37,6 +37,8 @@ CONFIG_BOOTCOMMAND=3D"fatload mmc 0 0x22000000 at91-sam=
a5d27_som1_ek.dtb; fatload
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d27_som1_ek_qspiflash_defconfig b/configs/sama5=
d27_som1_ek_qspiflash_defconfig
> index c671328e0c48..35eefb780b5b 100644
> --- a/configs/sama5d27_som1_ek_qspiflash_defconfig
> +++ b/configs/sama5d27_som1_ek_qspiflash_defconfig
> @@ -35,6 +35,8 @@ CONFIG_BOOTARGS=3D"console=3DttyS0,115200 earlyprintk r=
oot=3D/dev/mmcblk0p2 rw rootwai
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d27_wlsom1_ek_mmc_defconfig b/configs/sama5d27_=
wlsom1_ek_mmc_defconfig
> index 78a6ba6f48ca..6ea16c679948 100644
> --- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
> +++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
> @@ -36,6 +36,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_SPL_DISPLAY_PRINT=3Dy
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_AT91_MCK_BYPASS=3Dy
> diff --git a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig b/configs/sam=
a5d27_wlsom1_ek_qspiflash_defconfig
> index b3490e940c13..394a7ab64fb1 100644
> --- a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
> +++ b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
> @@ -36,6 +36,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_SPL_DISPLAY_PRINT=3Dy
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
> diff --git a/configs/sama5d2_icp_mmc_defconfig b/configs/sama5d2_icp_mmc_=
defconfig
> index 9a44370efc72..3772626e4b91 100644
> --- a/configs/sama5d2_icp_mmc_defconfig
> +++ b/configs/sama5d2_icp_mmc_defconfig
> @@ -35,6 +35,8 @@ CONFIG_BOOTCOMMAND=3D"fatload mmc 0:1 0x21000000 at91-s=
ama5d2_icp.dtb; fatload mmc
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_SPL_DISPLAY_PRINT=3Dy
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SPL_RAM_SUPPORT=3Dy
> diff --git a/configs/sama5d2_xplained_emmc_defconfig b/configs/sama5d2_xp=
lained_emmc_defconfig
> index 3865c66f9d23..f80fca265ee9 100644
> --- a/configs/sama5d2_xplained_emmc_defconfig
> +++ b/configs/sama5d2_xplained_emmc_defconfig
> @@ -35,6 +35,8 @@ CONFIG_BOOTCOMMAND=3D"fatload mmc 0:1 0x22000000 at91-s=
ama5d2_xplained.dtb; fatloa
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d2_xplained_mmc_defconfig b/configs/sama5d2_xpl=
ained_mmc_defconfig
> index 10e28fadc6ec..f4a7f2c6a8d2 100644
> --- a/configs/sama5d2_xplained_mmc_defconfig
> +++ b/configs/sama5d2_xplained_mmc_defconfig
> @@ -37,6 +37,8 @@ CONFIG_BOOTCOMMAND=3D"fatload mmc 1:1 0x22000000 at91-s=
ama5d2_xplained.dtb; fatloa
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d2_xplained_qspiflash_defconfig b/configs/sama5=
d2_xplained_qspiflash_defconfig
> index 7e92c29e87dd..bd13e926611d 100644
> --- a/configs/sama5d2_xplained_qspiflash_defconfig
> +++ b/configs/sama5d2_xplained_qspiflash_defconfig
> @@ -38,6 +38,8 @@ CONFIG_BOOTCOMMAND=3D"sf probe 1:0; sf read 0x22000000 =
0x180000 0x80000; sf read 0
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d2_xplained_spiflash_defconfig b/configs/sama5d=
2_xplained_spiflash_defconfig
> index 6a81c728e71b..32e2ea213dcb 100644
> --- a/configs/sama5d2_xplained_spiflash_defconfig
> +++ b/configs/sama5d2_xplained_spiflash_defconfig
> @@ -39,6 +39,8 @@ CONFIG_BOOTCOMMAND=3D"ext4load mmc 0:1 0x22000000 /boot=
/at91-sama5d2_xplained.dtb;
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x10000
> diff --git a/configs/sama5d3_xplained_mmc_defconfig b/configs/sama5d3_xpl=
ained_mmc_defconfig
> index 4f4860e89846..3ed976053a3e 100644
> --- a/configs/sama5d3_xplained_mmc_defconfig
> +++ b/configs/sama5d3_xplained_mmc_defconfig
> @@ -36,6 +36,8 @@ CONFIG_BOOTCOMMAND=3D"if test ! -n ${dtb_name}; then se=
tenv dtb_name at91-${board_
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x318000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d3_xplained_nandflash_defconfig b/configs/sama5=
d3_xplained_nandflash_defconfig
> index 66381750ce99..6e9ba1b490d7 100644
> --- a/configs/sama5d3_xplained_nandflash_defconfig
> +++ b/configs/sama5d3_xplained_nandflash_defconfig
> @@ -33,6 +33,8 @@ CONFIG_BOOTCOMMAND=3D"nand read 0x21000000 0x180000 0x8=
0000;nand read 0x22000000 0
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x318000
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
>  CONFIG_SPL_NAND_BASE=3Dy
> diff --git a/configs/sama5d3xek_mmc_defconfig b/configs/sama5d3xek_mmc_de=
fconfig
> index 741ab76b3f1f..4c7a79496829 100644
> --- a/configs/sama5d3xek_mmc_defconfig
> +++ b/configs/sama5d3xek_mmc_defconfig
> @@ -38,6 +38,8 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x318000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d3xek_nandflash_defconfig b/configs/sama5d3xek_=
nandflash_defconfig
> index 751f1f5904ae..6d6a12c6179f 100644
> --- a/configs/sama5d3xek_nandflash_defconfig
> +++ b/configs/sama5d3xek_nandflash_defconfig
> @@ -35,6 +35,8 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x318000
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
>  CONFIG_SPL_NAND_BASE=3Dy
> diff --git a/configs/sama5d3xek_spiflash_defconfig b/configs/sama5d3xek_s=
piflash_defconfig
> index 952f65ba5b53..ab681fdda9d7 100644
> --- a/configs/sama5d3xek_spiflash_defconfig
> +++ b/configs/sama5d3xek_spiflash_defconfig
> @@ -38,6 +38,8 @@ CONFIG_BOOTCOMMAND=3D"sf probe 0; sf read 0x21000000 0x=
60000 0xc000; sf read 0x220
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x318000
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x10000
> diff --git a/configs/sama5d4_xplained_mmc_defconfig b/configs/sama5d4_xpl=
ained_mmc_defconfig
> index a11d260057d2..d43e86a31fe0 100644
> --- a/configs/sama5d4_xplained_mmc_defconfig
> +++ b/configs/sama5d4_xplained_mmc_defconfig
> @@ -37,6 +37,8 @@ CONFIG_BOOTCOMMAND=3D"if test ! -n ${dtb_name}; then se=
tenv dtb_name at91-${board_
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d4_xplained_nandflash_defconfig b/configs/sama5=
d4_xplained_nandflash_defconfig
> index 715b59b4fb94..10cfb06f4339 100644
> --- a/configs/sama5d4_xplained_nandflash_defconfig
> +++ b/configs/sama5d4_xplained_nandflash_defconfig
> @@ -34,6 +34,8 @@ CONFIG_BOOTCOMMAND=3D"nand read 0x21000000 0x180000 0x8=
0000;nand read 0x22000000 0
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
>  CONFIG_SPL_NAND_BASE=3Dy
> diff --git a/configs/sama5d4_xplained_spiflash_defconfig b/configs/sama5d=
4_xplained_spiflash_defconfig
> index e42b6f7cd9de..b41c6c7d06ed 100644
> --- a/configs/sama5d4_xplained_spiflash_defconfig
> +++ b/configs/sama5d4_xplained_spiflash_defconfig
> @@ -39,6 +39,8 @@ CONFIG_BOOTCOMMAND=3D"sf probe 0; sf read 0x21000000 0x=
60000 0xc000; sf read 0x220
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x10000
> diff --git a/configs/sama5d4ek_mmc_defconfig b/configs/sama5d4ek_mmc_defc=
onfig
> index e0c10e0f2409..3d5eb6894841 100644
> --- a/configs/sama5d4ek_mmc_defconfig
> +++ b/configs/sama5d4ek_mmc_defconfig
> @@ -38,6 +38,8 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/sama5d4ek_nandflash_defconfig b/configs/sama5d4ek_na=
ndflash_defconfig
> index dc6c3c4c580d..8e5295aafe10 100644
> --- a/configs/sama5d4ek_nandflash_defconfig
> +++ b/configs/sama5d4ek_nandflash_defconfig
> @@ -35,6 +35,8 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
>  CONFIG_SPL_NAND_BASE=3Dy
> diff --git a/configs/sama5d4ek_spiflash_defconfig b/configs/sama5d4ek_spi=
flash_defconfig
> index b73a35c8a744..13708da1654a 100644
> --- a/configs/sama5d4ek_spiflash_defconfig
> +++ b/configs/sama5d4ek_spiflash_defconfig
> @@ -38,6 +38,8 @@ CONFIG_BOOTCOMMAND=3D"sf probe 0; sf read 0x21000000 0x=
60000 0xc000; sf read 0x220
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_SPL_MAX_SIZE=3D0x18000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x218000
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x10000
> diff --git a/configs/seaboard_defconfig b/configs/seaboard_defconfig
> index fb67ce6e1558..ea97dcf57a40 100644
> --- a/configs/seaboard_defconfig
> +++ b/configs/seaboard_defconfig
> @@ -14,6 +14,8 @@ CONFIG_OF_SYSTEM_SETUP=3Dy
>  CONFIG_USE_PREBOOT=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffffc
>  CONFIG_SYS_PROMPT=3D"Tegra20 (SeaBoard) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2086
> diff --git a/configs/seeed_npi_imx6ull_defconfig b/configs/seeed_npi_imx6=
ull_defconfig
> index 8fb5590c1ebd..860c98a4ad40 100644
> --- a/configs/seeed_npi_imx6ull_defconfig
> +++ b/configs/seeed_npi_imx6ull_defconfig
> @@ -20,6 +20,8 @@ CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_FIT=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
> diff --git a/configs/sifive_unleashed_defconfig b/configs/sifive_unleashe=
d_defconfig
> index f49fd9fba52a..326bca72bb58 100644
> --- a/configs/sifive_unleashed_defconfig
> +++ b/configs/sifive_unleashed_defconfig
> @@ -25,6 +25,8 @@ CONFIG_DISPLAY_CPUINFO=3Dy
>  CONFIG_DISPLAY_BOARDINFO=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x81cfe70
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_DM_RESET=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatche=
d_defconfig
> index af8cc68cf625..989029b586ea 100644
> --- a/configs/sifive_unmatched_defconfig
> +++ b/configs/sifive_unmatched_defconfig
> @@ -29,6 +29,8 @@ CONFIG_DISPLAY_BOARDINFO=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_ID_EEPROM=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x81cfe60
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_DM_RESET=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defc=
onfig
> index e728cb22269e..ce211a9a1aad 100644
> --- a/configs/silinux_ek874_defconfig
> +++ b/configs/silinux_ek874_defconfig
> @@ -25,6 +25,8 @@ CONFIG_DEFAULT_FDT_FILE=3D"r8a774c0-ek874.dtb"
>  # CONFIG_BOARD_EARLY_INIT_F is not set
>  CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6304000
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2068
> diff --git a/configs/silk_defconfig b/configs/silk_defconfig
> index 684e36f33d10..ac827ff2027a 100644
> --- a/configs/silk_defconfig
> +++ b/configs/silk_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_MAX_SIZE=3D0x4000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6340000
>  CONFIG_SPL_RAM_SUPPORT=3Dy
>  CONFIG_SPL_RAM_DEVICE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/smartweb_defconfig b/configs/smartweb_defconfig
> index 8a11e7b12f41..95048f8c4b1c 100644
> --- a/configs/smartweb_defconfig
> +++ b/configs/smartweb_defconfig
> @@ -35,6 +35,8 @@ CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1000
>  CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x301000
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_RAW_ONLY=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
> diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
> index 4dbe4f1964d1..2f77a39c3227 100644
> --- a/configs/sniper_defconfig
> +++ b/configs/sniper_defconfig
> @@ -14,6 +14,8 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
>  CONFIG_BOOTCOMMAND=3D"setenv boot_mmc_part ${kernel_mmc_part}; if test r=
eboot-${reboot-mode} =3D reboot-r; then echo recovery; setenv boot_mmc_part=
 ${recovery_mmc_part}; fi; if test reboot-${reboot-mode} =3D reboot-b; then=
 echo fastboot; fastboot 0; fi; part start mmc ${boot_mmc_dev} ${boot_mmc_p=
art} boot_mmc_start; part size mmc ${boot_mmc_dev} ${boot_mmc_part} boot_mm=
c_size; mmc dev ${boot_mmc_dev}; mmc read ${kernel_addr_r} ${boot_mmc_start=
} ${boot_mmc_size} && bootm ${kernel_addr_r};"
>  CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0xec00
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4020fffc
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D2
> diff --git a/configs/socfpga_agilex_atf_defconfig b/configs/socfpga_agile=
x_atf_defconfig
> index 10f3947b5db4..869305fefbe6 100644
> --- a/configs/socfpga_agilex_atf_defconfig
> +++ b/configs/socfpga_agilex_atf_defconfig
> @@ -29,6 +29,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run fatscript; run mmcfitload; run mmcfitboot"
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffe3f000
>  CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_CACHE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_de=
fconfig
> index 23e1d7874353..11a4a544ac49 100644
> --- a/configs/socfpga_agilex_defconfig
> +++ b/configs/socfpga_agilex_defconfig
> @@ -26,6 +26,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run fatscript; run mmcload; run linux_qspi_enable;=
 run mmcboot"
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffe3f000
>  CONFIG_SPL_CACHE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x3c00000
> diff --git a/configs/socfpga_agilex_vab_defconfig b/configs/socfpga_agile=
x_vab_defconfig
> index c775ecbdcca9..85ec9094a53b 100644
> --- a/configs/socfpga_agilex_vab_defconfig
> +++ b/configs/socfpga_agilex_vab_defconfig
> @@ -30,6 +30,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run fatscript; run mmcfitload; run mmcfitboot"
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffe3f000
>  CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_CACHE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_=
defconfig
> index d326a3fb82db..8b8d7e4968eb 100644
> --- a/configs/socfpga_arria10_defconfig
> +++ b/configs/socfpga_arria10_defconfig
> @@ -28,6 +28,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x40000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffe2b000
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_FPGA=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_de=
fconfig
> index 62913f6702e4..24c21090b196 100644
> --- a/configs/socfpga_arria5_defconfig
> +++ b/configs/socfpga_arria5_defconfig
> @@ -22,6 +22,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone=
5_defconfig
> index 7809b57ab7c0..d010b54240dd 100644
> --- a/configs/socfpga_cyclone5_defconfig
> +++ b/configs/socfpga_cyclone5_defconfig
> @@ -22,6 +22,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_dbm_soc1_defconfig b/configs/socfpga_dbm_soc=
1_defconfig
> index d6b2e6639896..a1574b6a5d7c 100644
> --- a/configs/socfpga_dbm_soc1_defconfig
> +++ b/configs/socfpga_dbm_soc1_defconfig
> @@ -25,6 +25,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_HUSH_PARSER=3Dy
> diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0=
_nano_soc_defconfig
> index 036fdcc19af9..ec7355d2cc43 100644
> --- a/configs/socfpga_de0_nano_soc_defconfig
> +++ b/configs/socfpga_de0_nano_soc_defconfig
> @@ -23,6 +23,8 @@ CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_n=
ano_defconfig
> index 71c9eaba7a3e..b62f02996287 100644
> --- a/configs/socfpga_de10_nano_defconfig
> +++ b/configs/socfpga_de10_nano_defconfig
> @@ -22,6 +22,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_=
defconfig
> index b800f2762d87..749ec540b4fd 100644
> --- a/configs/socfpga_de1_soc_defconfig
> +++ b/configs/socfpga_de1_soc_defconfig
> @@ -23,6 +23,8 @@ CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_YMODEM_SUPPORT=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_ASKENV=3Dy
> diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfi=
g
> index c9a8650c91ab..c3b6368f6171 100644
> --- a/configs/socfpga_is1_defconfig
> +++ b/configs/socfpga_is1_defconfig
> @@ -25,6 +25,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffff8
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_de=
fconfig
> index 4f703cf3d0ba..18e125f5bdf9 100644
> --- a/configs/socfpga_mcvevk_defconfig
> +++ b/configs/socfpga_mcvevk_defconfig
> @@ -23,6 +23,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_=
defconfig
> index 7c7f90146d68..88763d1e5ab1 100644
> --- a/configs/socfpga_n5x_atf_defconfig
> +++ b/configs/socfpga_n5x_atf_defconfig
> @@ -28,6 +28,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run fatscript; run mmcfitload; run mmcfitboot"
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffe3f000
>  CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_CACHE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfi=
g
> index 8f851e80e29f..a07a338f108d 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -23,6 +23,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run fatscript; run mmcload; run linux_qspi_enable;=
 run mmcboot"
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffe3f000
>  CONFIG_SPL_CACHE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x3c00000
> diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_=
defconfig
> index 82a4f980b899..8efdab84e149 100644
> --- a/configs/socfpga_n5x_vab_defconfig
> +++ b/configs/socfpga_n5x_vab_defconfig
> @@ -29,6 +29,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run fatscript; run mmcfitload; run mmcfitboot"
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffe3f000
>  CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_CACHE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defc=
onfig
> index d59e841f7611..72cf0d1bc88b 100644
> --- a/configs/socfpga_secu1_defconfig
> +++ b/configs/socfpga_secu1_defconfig
> @@ -36,6 +36,8 @@ CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D0x1
>  # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is not set
> diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_de=
fconfig
> index 999e696aa7a7..2a02f1dbfaa6 100644
> --- a/configs/socfpga_sockit_defconfig
> +++ b/configs/socfpga_sockit_defconfig
> @@ -22,6 +22,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_socrates_defconfig b/configs/socfpga_socrate=
s_defconfig
> index 82549a80af54..3d0c48d76623 100644
> --- a/configs/socfpga_socrates_defconfig
> +++ b/configs/socfpga_socrates_defconfig
> @@ -21,6 +21,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_de=
fconfig
> index cbb751e5a20b..53d6b82972f9 100644
> --- a/configs/socfpga_sr1500_defconfig
> +++ b/configs/socfpga_sr1500_defconfig
> @@ -29,6 +29,8 @@ CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffff8
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_st=
ratix10_atf_defconfig
> index 52f99dad7548..9969ac00be3a 100644
> --- a/configs/socfpga_stratix10_atf_defconfig
> +++ b/configs/socfpga_stratix10_atf_defconfig
> @@ -29,6 +29,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run fatscript; run mmcfitload; run mmcfitboot"
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffe3f000
>  CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x02000000
> diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_strati=
x10_defconfig
> index 23050c7f663c..a90e404b4407 100644
> --- a/configs/socfpga_stratix10_defconfig
> +++ b/configs/socfpga_stratix10_defconfig
> @@ -28,6 +28,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run fatscript; run mmcload; run linux_qspi_enable;=
 run mmcboot"
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffe3f000
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x3C00000
>  CONFIG_HUSH_PARSER=3Dy
> diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vini=
ng_fpga_defconfig
> index 37aae07fd645..0f4aa9051477 100644
> --- a/configs/socfpga_vining_fpga_defconfig
> +++ b/configs/socfpga_vining_fpga_defconfig
> @@ -29,6 +29,8 @@ CONFIG_CLOCKS=3Dy
>  CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x0
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_CMDLINE_PS_SUPPORT=3Dy
> diff --git a/configs/sopine_baseboard_defconfig b/configs/sopine_baseboar=
d_defconfig
> index f2220465f39b..576e86493a24 100644
> --- a/configs/sopine_baseboard_defconfig
> +++ b/configs/sopine_baseboard_defconfig
> @@ -11,6 +11,7 @@ CONFIG_MMC0_CD_PIN=3D""
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_SPL_SPI_SUNXI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_SPI_FLASH_WINBOND=3Dy
> diff --git a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig b/configs=
/stm32mp15-icore-stm32mp1-ctouch2_defconfig
> index 5c131252a5de..fe722ce507bf 100644
> --- a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
> +++ b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
> @@ -19,6 +19,8 @@ CONFIG_FIT=3Dy
>  CONFIG_BOOTCOMMAND=3D"run bootcmd_stm32mp"
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x3db00
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x30000000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D3
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig b/config=
s/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
> index 688c9344d177..f47bc1b23411 100644
> --- a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
> +++ b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
> @@ -19,6 +19,8 @@ CONFIG_FIT=3Dy
>  CONFIG_BOOTCOMMAND=3D"run bootcmd_stm32mp"
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x3db00
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x30000000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D3
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig =
b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
> index f6d67f3cc822..9ddd585ecf0c 100644
> --- a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
> +++ b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
> @@ -19,6 +19,8 @@ CONFIG_FIT=3Dy
>  CONFIG_BOOTCOMMAND=3D"run bootcmd_stm32mp"
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x3db00
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x30000000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D3
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig b/co=
nfigs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
> index 39c2f295701b..86d55478f5aa 100644
> --- a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
> +++ b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
> @@ -19,6 +19,8 @@ CONFIG_FIT=3Dy
>  CONFIG_BOOTCOMMAND=3D"run bootcmd_stm32mp"
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x3db00
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x30000000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D3
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_=
defconfig
> index b607c7256e51..be49a8e77127 100644
> --- a/configs/stm32mp15_basic_defconfig
> +++ b/configs/stm32mp15_basic_defconfig
> @@ -29,6 +29,8 @@ CONFIG_SPL_LOG=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x3db00
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x30000000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D3
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_=
dhcom_basic_defconfig
> index 16dcc4ad56f7..fa3cff00cea2 100644
> --- a/configs/stm32mp15_dhcom_basic_defconfig
> +++ b/configs/stm32mp15_dhcom_basic_defconfig
> @@ -30,6 +30,8 @@ CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x3db00
>  CONFIG_SPL_LEGACY_IMAGE_FORMAT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x30000000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D3
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_=
dhcor_basic_defconfig
> index 9a7266229be7..9f32d2c4e815 100644
> --- a/configs/stm32mp15_dhcor_basic_defconfig
> +++ b/configs/stm32mp15_dhcor_basic_defconfig
> @@ -28,6 +28,8 @@ CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x3db00
>  CONFIG_SPL_LEGACY_IMAGE_FORMAT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x30000000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D3
>  CONFIG_SPL_ENV_SUPPORT=3Dy
> diff --git a/configs/stout_defconfig b/configs/stout_defconfig
> index 9ef96bafc99b..4f0cda9c897a 100644
> --- a/configs/stout_defconfig
> +++ b/configs/stout_defconfig
> @@ -34,6 +34,8 @@ CONFIG_SPL_MAX_SIZE=3D0x4000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xe6340000
>  CONFIG_SPL_RAM_SUPPORT=3Dy
>  CONFIG_SPL_RAM_DEVICE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> diff --git a/configs/sun8i_a23_evb_defconfig b/configs/sun8i_a23_evb_defc=
onfig
> index 21ea2ba66ef9..59315cdb05d5 100644
> --- a/configs/sun8i_a23_evb_defconfig
> +++ b/configs/sun8i_a23_evb_defconfig
> @@ -9,6 +9,7 @@ CONFIG_USB0_VBUS_PIN=3D"axp_drivebus"
>  CONFIG_USB0_VBUS_DET=3D"axp_vbus_detect"
>  CONFIG_USB1_VBUS_PIN=3D"PH7"
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_CONS_INDEX=3D5
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/sunxi_Gemei_G9_defconfig b/configs/sunxi_Gemei_G9_de=
fconfig
> index 8b8a880d45ec..b77c4e7a3cb0 100644
> --- a/configs/sunxi_Gemei_G9_defconfig
> +++ b/configs/sunxi_Gemei_G9_defconfig
> @@ -11,6 +11,7 @@ CONFIG_VIDEO_LCD_BL_EN=3D"PH7"
>  CONFIG_VIDEO_LCD_BL_PWM=3D"PB2"
>  CONFIG_VIDEO_LCD_PANEL_LVDS=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/syzygy_hub_defconfig b/configs/syzygy_hub_defconfig
> index a9dc04cdfb97..d9e61aee3df8 100644
> --- a/configs/syzygy_hub_defconfig
> +++ b/configs/syzygy_hub_defconfig
> @@ -27,6 +27,8 @@ CONFIG_USE_PREBOOT=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x30000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffe00
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_FS_LOAD_ARGS_NAME=3D"system.dtb"
>  CONFIG_SPL_OS_BOOT=3Dy
> diff --git a/configs/tanix_tx6_defconfig b/configs/tanix_tx6_defconfig
> index cf34b508a732..d1f12fba9bb0 100644
> --- a/configs/tanix_tx6_defconfig
> +++ b/configs/tanix_tx6_defconfig
> @@ -8,4 +8,5 @@ CONFIG_DRAM_CLK=3D648
>  CONFIG_MMC0_CD_PIN=3D"PF6"
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x118000
>  CONFIG_SYS_PBSIZE=3D1024
> diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
> index 79ceebe2db00..471feed3dfb5 100644
> --- a/configs/taurus_defconfig
> +++ b/configs/taurus_defconfig
> @@ -44,6 +44,8 @@ CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x600
>  # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x304000
>  CONFIG_SPL_CRC32=3Dy
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_RAW_ONLY=3Dy
> diff --git a/configs/tbs_a711_defconfig b/configs/tbs_a711_defconfig
> index a8a9b855cc36..3dd9252a7423 100644
> --- a/configs/tbs_a711_defconfig
> +++ b/configs/tbs_a711_defconfig
> @@ -13,6 +13,7 @@ CONFIG_USB0_VBUS_DET=3D"AXP0-VBUS-DETECT"
>  CONFIG_USB0_ID_DET=3D"PH11"
>  CONFIG_AXP_GPIO=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_AXP_DCDC5_VOLT=3D1200
> diff --git a/configs/tec-ng_defconfig b/configs/tec-ng_defconfig
> index e305b5bcb102..cb80b10aecf7 100644
> --- a/configs/tec-ng_defconfig
> +++ b/configs/tec-ng_defconfig
> @@ -16,6 +16,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Tegra30 (TEC-NG) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2084
> diff --git a/configs/tec_defconfig b/configs/tec_defconfig
> index 9c644e682200..80fbdda5d1c5 100644
> --- a/configs/tec_defconfig
> +++ b/configs/tec_defconfig
> @@ -15,6 +15,8 @@ CONFIG_OF_SYSTEM_SETUP=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffffc
>  CONFIG_SYS_PROMPT=3D"Tegra20 (TEC) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2081
> diff --git a/configs/teres_i_defconfig b/configs/teres_i_defconfig
> index 12e91a58936a..cd6d825715e8 100644
> --- a/configs/teres_i_defconfig
> +++ b/configs/teres_i_defconfig
> @@ -9,6 +9,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_USB1_VBUS_PIN=3D"PL7"
>  CONFIG_I2C0_ENABLE=3Dy
>  CONFIG_PREBOOT=3D"setenv usb_pgood_delay 2000; usb start"
> +CONFIG_SPL_STACK=3D0x54000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/theadorable_debug_defconfig b/configs/theadorable_de=
bug_defconfig
> index b830d75dba6d..f858d732abd4 100644
> --- a/configs/theadorable_debug_defconfig
> +++ b/configs/theadorable_debug_defconfig
> @@ -32,6 +32,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x1bfd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_HUSH_PARSER=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defc=
onfig
> index 32afbebc545a..ce12b79ac471 100644
> --- a/configs/tinker-rk3288_defconfig
> +++ b/configs/tinker-rk3288_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SILENT_CONSOLE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_=
defconfig
> index 072012e066be..8dede27efcc9 100644
> --- a/configs/tinker-s-rk3288_defconfig
> +++ b/configs/tinker-s-rk3288_defconfig
> @@ -25,6 +25,8 @@ CONFIG_SILENT_CONSOLE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x300000
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/topic_miami_defconfig b/configs/topic_miami_defconfi=
g
> index ed6ac3b7ae8c..11d6e450276d 100644
> --- a/configs/topic_miami_defconfig
> +++ b/configs/topic_miami_defconfig
> @@ -27,6 +27,8 @@ CONFIG_USE_PREBOOT=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x30000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffe00
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x20000
> diff --git a/configs/topic_miamilite_defconfig b/configs/topic_miamilite_=
defconfig
> index a80ee2243205..32dc5478dddd 100644
> --- a/configs/topic_miamilite_defconfig
> +++ b/configs/topic_miamilite_defconfig
> @@ -27,6 +27,8 @@ CONFIG_USE_PREBOOT=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x30000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffe00
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x20000
> diff --git a/configs/topic_miamiplus_defconfig b/configs/topic_miamiplus_=
defconfig
> index a402478f64c8..2de1e96bdf88 100644
> --- a/configs/topic_miamiplus_defconfig
> +++ b/configs/topic_miamiplus_defconfig
> @@ -27,6 +27,8 @@ CONFIG_USE_PREBOOT=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x30000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffe00
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x20000
> diff --git a/configs/trimslice_defconfig b/configs/trimslice_defconfig
> index 7d79ea3ec530..b9d465c0e575 100644
> --- a/configs/trimslice_defconfig
> +++ b/configs/trimslice_defconfig
> @@ -16,6 +16,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffffc
>  CONFIG_SYS_PROMPT=3D"Tegra20 (TrimSlice) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2087
> diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defcon=
fig
> index a5087581a4ed..c3ab35e9646c 100644
> --- a/configs/turris_omnia_defconfig
> +++ b/configs/turris_omnia_defconfig
> @@ -41,6 +41,8 @@ CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x22fd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/udoo_defconfig b/configs/udoo_defconfig
> index e21945116c03..03875f9039d9 100644
> --- a/configs/udoo_defconfig
> +++ b/configs/udoo_defconfig
> @@ -22,6 +22,8 @@ CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_BOOTCOMMAND=3D"run findfdt; run distro_bootcmd"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
> index fff11bb10e97..1b9b5a5b6270 100644
> --- a/configs/udoo_neo_defconfig
> +++ b/configs/udoo_neo_defconfig
> @@ -22,6 +22,8 @@ CONFIG_SPL_LIBDISK_SUPPORT=3Dy
>  CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_BOOTCOMMAND=3D"run findfdt; run distro_bootcmd"
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
> diff --git a/configs/uniphier_ld4_sld8_defconfig b/configs/uniphier_ld4_s=
ld8_defconfig
> index 10f00b53aae1..ceb50835f53c 100644
> --- a/configs/uniphier_ld4_sld8_defconfig
> +++ b/configs/uniphier_ld4_sld8_defconfig
> @@ -21,6 +21,8 @@ CONFIG_LOGLEVEL=3D6
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x100000
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NOR_SUPPORT=3Dy
>  CONFIG_CMD_CONFIG=3Dy
> diff --git a/configs/uniphier_v7_defconfig b/configs/uniphier_v7_defconfi=
g
> index 4a79b6563e86..a2ea3a98d09e 100644
> --- a/configs/uniphier_v7_defconfig
> +++ b/configs/uniphier_v7_defconfig
> @@ -21,6 +21,8 @@ CONFIG_LOGLEVEL=3D6
>  CONFIG_SPL_MAX_SIZE=3D0x10000
>  CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x100000
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NOR_SUPPORT=3Dy
>  CONFIG_CMD_CONFIG=3Dy
> diff --git a/configs/variscite_dart6ul_defconfig b/configs/variscite_dart=
6ul_defconfig
> index 7322b12bd17c..e100185743c0 100644
> --- a/configs/variscite_dart6ul_defconfig
> +++ b/configs/variscite_dart6ul_defconfig
> @@ -18,6 +18,8 @@ CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_FIT=3Dy
>  CONFIG_BOOTDELAY=3D3
>  CONFIG_BOOTCOMMAND=3D"run mmc_mmc_fit"
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_SYS_MAXARGS=3D32
> diff --git a/configs/venice2_defconfig b/configs/venice2_defconfig
> index 0ad69b3e678c..cb5fcfbb2362 100644
> --- a/configs/venice2_defconfig
> +++ b/configs/venice2_defconfig
> @@ -16,6 +16,8 @@ CONFIG_CONSOLE_MUX=3Dy
>  CONFIG_SYS_STDIO_DEREGISTER=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x800ffffc
>  CONFIG_SYS_PROMPT=3D"Tegra124 (Venice2) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2086
> diff --git a/configs/ventana_defconfig b/configs/ventana_defconfig
> index 0b1d0f728eeb..f3389b0f7bce 100644
> --- a/configs/ventana_defconfig
> +++ b/configs/ventana_defconfig
> @@ -14,6 +14,8 @@ CONFIG_OF_SYSTEM_SETUP=3Dy
>  CONFIG_USE_PREBOOT=3Dy
>  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
>  CONFIG_SPL_MAX_FOOTPRINT=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xffffc
>  CONFIG_SYS_PROMPT=3D"Tegra20 (Ventana) # "
>  CONFIG_SYS_MAXARGS=3D64
>  CONFIG_SYS_PBSIZE=3D2085
> diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defc=
onfig
> index f25d12609c32..97afc211bf5a 100644
> --- a/configs/verdin-imx8mm_defconfig
> +++ b/configs/verdin-imx8mm_defconfig
> @@ -35,6 +35,8 @@ CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x25000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x920000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defc=
onfig
> index afe6bbaf429c..2107047c1d70 100644
> --- a/configs/verdin-imx8mp_defconfig
> +++ b/configs/verdin-imx8mp_defconfig
> @@ -45,6 +45,8 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x400
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_BOOTROM_SUPPORT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x960000
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x300
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/vining_2000_defconfig b/configs/vining_2000_defconfi=
g
> index a8c3d907d1d4..0559b2864dee 100644
> --- a/configs/vining_2000_defconfig
> +++ b/configs/vining_2000_defconfig
> @@ -31,6 +31,8 @@ CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run distro_bootcmd"
>  CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
>  CONFIG_SPL_I2C=3Dy
> diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defcon=
fig
> index 99c8379ac892..27c704f8a225 100644
> --- a/configs/vyasa-rk3288_defconfig
> +++ b/configs/vyasa-rk3288_defconfig
> @@ -24,6 +24,8 @@ CONFIG_SILENT_CONSOLE=3Dy
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xff718000
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=3D0x2000
>  CONFIG_SPL_OS_BOOT=3Dy
> diff --git a/configs/wandboard_defconfig b/configs/wandboard_defconfig
> index fadc8af36eb5..43af07f07daa 100644
> --- a/configs/wandboard_defconfig
> +++ b/configs/wandboard_defconfig
> @@ -33,6 +33,8 @@ CONFIG_SYS_CONSOLE_IS_IN_ENV=3Dy
>  CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=3Dy
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_BOARD_EARLY_INIT_F=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x91ffb8
>  CONFIG_SPL_FIT_IMAGE_TINY=3Dy
>  CONFIG_SPL_FS_EXT4=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot-dtb.img"
> diff --git a/configs/work_92105_defconfig b/configs/work_92105_defconfig
> index 2261853d0161..7eb23907ebcd 100644
> --- a/configs/work_92105_defconfig
> +++ b/configs/work_92105_defconfig
> @@ -32,6 +32,8 @@ CONFIG_SPL_PAD_TO=3D0x20000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfff8
>  CONFIG_SPL_NAND_SUPPORT=3Dy
>  CONFIG_SPL_NAND_DRIVERS=3Dy
>  CONFIG_SPL_NAND_BASE=3Dy
> diff --git a/configs/x530_defconfig b/configs/x530_defconfig
> index fa385fcb24d6..ac418dad1501 100644
> --- a/configs/x530_defconfig
> +++ b/configs/x530_defconfig
> @@ -32,6 +32,8 @@ CONFIG_SPL_MAX_SIZE=3D0x22fd0
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x4000
>  CONFIG_SPL_BOARD_INIT=3Dy
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x4002c000
>  CONFIG_SPL_WATCHDOG=3Dy
>  CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_vir=
t_defconfig
> index fd8fd1ddfda8..49210f86c4b8 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -30,6 +30,8 @@ CONFIG_USE_PREBOOT=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x30000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffe00
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"u-boot.img"
>  CONFIG_SPL_FS_LOAD_ARGS_NAME=3D"system.dtb"
> diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_=
zynqmp_mini_emmc0_defconfig
> index 44816eb25f0c..2f4b320c811e 100644
> --- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
> +++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
> @@ -26,6 +26,8 @@ CONFIG_BOARD_EARLY_INIT_R=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffffc
>  # CONFIG_CMDLINE_EDITING is not set
>  # CONFIG_AUTO_COMPLETE is not set
>  CONFIG_SYS_MAXARGS=3D64
> diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_=
zynqmp_mini_emmc1_defconfig
> index d6672ff3c12a..001246fd9846 100644
> --- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
> +++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
> @@ -26,6 +26,8 @@ CONFIG_BOARD_EARLY_INIT_R=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffffc
>  # CONFIG_CMDLINE_EDITING is not set
>  # CONFIG_AUTO_COMPLETE is not set
>  CONFIG_SYS_MAXARGS=3D64
> diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_z=
ynqmp_mini_qspi_defconfig
> index 336ca289bd39..9657093c6a33 100644
> --- a/configs/xilinx_zynqmp_mini_qspi_defconfig
> +++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
> @@ -25,6 +25,8 @@ CONFIG_REMAKE_ELF=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffffc
>  # CONFIG_CMDLINE_EDITING is not set
>  # CONFIG_AUTO_COMPLETE is not set
>  # CONFIG_SYS_LONGHELP is not set
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp=
_virt_defconfig
> index 40c9c28e139b..88d5fec201f7 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -33,6 +33,8 @@ CONFIG_BOARD_EARLY_INIT_R=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffffc
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_FS_LOAD_KERNEL_NAME=3D"atf-uboot.ub"
>  CONFIG_SPL_FS_LOAD_ARGS_NAME=3D"u-boot.bin"
> diff --git a/configs/zeropi_defconfig b/configs/zeropi_defconfig
> index dd0dbc96ef69..7d45440c0cc5 100644
> --- a/configs/zeropi_defconfig
> +++ b/configs/zeropi_defconfig
> @@ -8,6 +8,7 @@ CONFIG_MACPWR=3D"PD6"
>  # CONFIG_VIDEO_DE2 is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_CONSOLE_MUX=3Dy
> +CONFIG_SPL_STACK=3D0x8000
>  CONFIG_SYS_PBSIZE=3D1024
>  CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defc=
onfig
> index cb7181324e87..f63a2bbab9a8 100644
> --- a/configs/zynq_cse_nand_defconfig
> +++ b/configs/zynq_cse_nand_defconfig
> @@ -23,6 +23,8 @@ CONFIG_USE_PREBOOT=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x30000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffe00
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_CMDLINE_EDITING is not set
>  # CONFIG_AUTO_COMPLETE is not set
> diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defcon=
fig
> index da7b9d037c3f..d38b8f16f2e2 100644
> --- a/configs/zynq_cse_nor_defconfig
> +++ b/configs/zynq_cse_nor_defconfig
> @@ -23,6 +23,8 @@ CONFIG_USE_PREBOOT=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x30000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffe00
>  CONFIG_SPL_STACK_R=3Dy
>  # CONFIG_CMDLINE_EDITING is not set
>  # CONFIG_AUTO_COMPLETE is not set
> diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defc=
onfig
> index 2f32f9d9a82d..241bf0c922c2 100644
> --- a/configs/zynq_cse_qspi_defconfig
> +++ b/configs/zynq_cse_qspi_defconfig
> @@ -30,6 +30,8 @@ CONFIG_USE_PREBOOT=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x30000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x8000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0xfffffe00
>  CONFIG_SPL_STACK_R=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x100000
> diff --git a/include/configs/alt.h b/include/configs/alt.h
> index 081e2a93b8ef..fe303fda78a0 100644
> --- a/include/configs/alt.h
> +++ b/include/configs/alt.h
> @@ -37,7 +37,4 @@
>         "bootm_size=3D0x10000000\0"       \
>         "usb_pgood_delay=3D2000\0"
>
> -/* SPL support */
> -#define CONFIG_SPL_STACK               0xe6340000
> -
>  #endif /* __ALT_H */
> diff --git a/include/configs/at91sam9m10g45ek.h b/include/configs/at91sam=
9m10g45ek.h
> index 9e43c0e7aa63..85732e3f9dc2 100644
> --- a/include/configs/at91sam9m10g45ek.h
> +++ b/include/configs/at91sam9m10g45ek.h
> @@ -37,9 +37,6 @@
>
>  #endif
>
> -/* Defines for SPL */
> -#define CONFIG_SPL_STACK               0x310000
> -
>  #define CONFIG_SYS_MONITOR_LEN         0x80000
>
>  #ifdef CONFIG_SD_BOOT
> diff --git a/include/configs/at91sam9n12ek.h b/include/configs/at91sam9n1=
2ek.h
> index 141540bd889f..b6346ae1df20 100644
> --- a/include/configs/at91sam9n12ek.h
> +++ b/include/configs/at91sam9n12ek.h
> @@ -52,7 +52,6 @@
>  #endif
>
>  /* SPL */
> -#define CONFIG_SPL_STACK               0x308000
>
>  #define CONFIG_SPL_BSS_START_ADDR      0x20000000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x20080000
> diff --git a/include/configs/at91sam9x5ek.h b/include/configs/at91sam9x5e=
k.h
> index 12a349f867c0..446c5e1d3f24 100644
> --- a/include/configs/at91sam9x5ek.h
> +++ b/include/configs/at91sam9x5ek.h
> @@ -52,7 +52,6 @@
>  #endif
>
>  /* SPL */
> -#define CONFIG_SPL_STACK               0x308000
>
>  #define CONFIG_SPL_BSS_START_ADDR      0x20000000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x20080000
> diff --git a/include/configs/capricorn-common.h b/include/configs/caprico=
rn-common.h
> index 454dac4ad6bc..b22fc6c5ddcc 100644
> --- a/include/configs/capricorn-common.h
> +++ b/include/configs/capricorn-common.h
> @@ -17,7 +17,6 @@
>
>  #define CONFIG_SYS_MONITOR_LEN         (1024 * 1024)
>
> -#define CONFIG_SPL_STACK               0x013E000
>  #define CONFIG_SPL_BSS_START_ADDR      0x00128000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x00120000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x3000  /* 12 KB */
> diff --git a/include/configs/cgtqmx8.h b/include/configs/cgtqmx8.h
> index 2553d9aad63e..d12feda16a47 100644
> --- a/include/configs/cgtqmx8.h
> +++ b/include/configs/cgtqmx8.h
> @@ -14,7 +14,6 @@
>  #ifdef CONFIG_SPL_BUILD
>  #define CONFIG_SYS_MONITOR_LEN                         (1024 * 1024)
>
> -#define CONFIG_SPL_STACK               0x013E000
>  #define CONFIG_SPL_BSS_START_ADDR      0x00128000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x00120000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x3000  /* 12 KB */
> diff --git a/include/configs/ci20.h b/include/configs/ci20.h
> index 33de2b7864ab..f0497407afcc 100644
> --- a/include/configs/ci20.h
> +++ b/include/configs/ci20.h
> @@ -31,7 +31,6 @@
>  #define CONFIG_SYS_BOOTM_LEN           (64 << 20)
>
>  /* SPL */
> -#define CONFIG_SPL_STACK               0xf4008000 /* only max. 2KB spare=
! */
>
>  #define CONFIG_SPL_BSS_START_ADDR      0xf4004000
>
> diff --git a/include/configs/clearfog.h b/include/configs/clearfog.h
> index 6cf44877601f..03f7ceb2f427 100644
> --- a/include/configs/clearfog.h
> +++ b/include/configs/clearfog.h
> @@ -47,8 +47,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + CONFIG_SPL_SIZE)
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  #if defined(CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC) || defined(CONFIG_MVEBU_SP=
L_BOOT_DEVICE_SATA)
>  /* SPL related MMC defines */
>  #ifdef CONFIG_SPL_BUILD
> diff --git a/include/configs/controlcenterdc.h b/include/configs/controlc=
enterdc.h
> index 78b7d4f17f29..62465acc97cf 100644
> --- a/include/configs/controlcenterdc.h
> +++ b/include/configs/controlcenterdc.h
> @@ -39,8 +39,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + CONFIG_SPL_SIZE)
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((212 - 16) << 10))
> -
>  #if CONFIG_SPL_BOOT_DEVICE =3D=3D SPL_BOOT_SDIO_MMC_CARD
>  /* SPL related MMC defines */
>  #ifdef CONFIG_SPL_BUILD
> diff --git a/include/configs/corvus.h b/include/configs/corvus.h
> index 99c8cd311100..f15e15822e52 100644
> --- a/include/configs/corvus.h
> +++ b/include/configs/corvus.h
> @@ -54,7 +54,6 @@
>  /* bootstrap + u-boot + env in nandflash */
>
>  /* Defines for SPL */
> -#define CONFIG_SPL_STACK               (SZ_16K)
>
>  #define CONFIG_SPL_BSS_START_ADDR      CONFIG_SPL_MAX_SIZE
>
> diff --git a/include/configs/da850evm.h b/include/configs/da850evm.h
> index fd58b1a194e8..209a1423c1c0 100644
> --- a/include/configs/da850evm.h
> +++ b/include/configs/da850evm.h
> @@ -182,7 +182,6 @@
>  #define CONFIG_SYS_SPL_MALLOC_START    (CONFIG_SYS_TEXT_BASE - \
>                                                 CONFIG_SYS_MALLOC_LEN)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     CONFIG_SYS_MALLOC_LEN
> -#define CONFIG_SPL_STACK       0x8001ff00
>
>  #endif
>
> diff --git a/include/configs/db-88f6720.h b/include/configs/db-88f6720.h
> index eeaae1fdabcb..e97ff21360e3 100644
> --- a/include/configs/db-88f6720.h
> +++ b/include/configs/db-88f6720.h
> @@ -37,6 +37,4 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + (128 << 10))
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  #endif /* _CONFIG_DB_88F6720_H */
> diff --git a/include/configs/db-88f6820-amc.h b/include/configs/db-88f682=
0-amc.h
> index cb2050015e00..727756dbba7d 100644
> --- a/include/configs/db-88f6820-amc.h
> +++ b/include/configs/db-88f6820-amc.h
> @@ -44,8 +44,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + CONFIG_SPL_SIZE)
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  /*
>   * mv-common.h should be defined after CMD configs since it used them
>   * to enable certain macros
> diff --git a/include/configs/db-88f6820-gp.h b/include/configs/db-88f6820=
-gp.h
> index e1a97daeac8b..c6ce784b4b20 100644
> --- a/include/configs/db-88f6820-gp.h
> +++ b/include/configs/db-88f6820-gp.h
> @@ -44,8 +44,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + CONFIG_SPL_SIZE)
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  #if CONFIG_SPL_BOOT_DEVICE =3D=3D SPL_BOOT_SDIO_MMC_CARD
>  /* SPL related MMC defines */
>  #ifdef CONFIG_SPL_BUILD
> diff --git a/include/configs/db-mv784mp-gp.h b/include/configs/db-mv784mp=
-gp.h
> index 2ec9afe8e843..cade78b85d3c 100644
> --- a/include/configs/db-mv784mp-gp.h
> +++ b/include/configs/db-mv784mp-gp.h
> @@ -56,8 +56,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + (128 << 10))
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  /* Enable DDR support in SPL (DDR3 training from Marvell bin_hdr) */
>  #define CONFIG_SPD_EEPROM              0x4e
>
> diff --git a/include/configs/devkit3250.h b/include/configs/devkit3250.h
> index 53c67c706c3d..15160db276d7 100644
> --- a/include/configs/devkit3250.h
> +++ b/include/configs/devkit3250.h
> @@ -82,18 +82,6 @@
>   * U-Boot Commands
>   */
>
> -/*
> - * SPL specific defines
> - */
> -/* SPL will be executed at offset 0 */
> -
> -/* SPL will use SRAM as stack */
> -#define CONFIG_SPL_STACK               0x0000FFF8
> -
> -/* Use the framework and generic lib */
> -
> -/* SPL will use serial */
> -
>  /* U-Boot will be 0x60000 bytes, loaded and run at CONFIG_SYS_TEXT_BASE =
*/
>  #define CONFIG_SYS_NAND_U_BOOT_SIZE    0x60000
>
> diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> index 3eff94f116ea..16d59ed014cc 100644
> --- a/include/configs/ds414.h
> +++ b/include/configs/ds414.h
> @@ -48,8 +48,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + (128 << 10))
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  /* Default Environment */
>
>  #define CONFIG_EXTRA_ENV_SETTINGS                              \
> diff --git a/include/configs/edminiv2.h b/include/configs/edminiv2.h
> index c0923883acf3..2bc9c9923191 100644
> --- a/include/configs/edminiv2.h
> +++ b/include/configs/edminiv2.h
> @@ -15,7 +15,6 @@
>   * SPL
>   */
>
> -#define CONFIG_SPL_STACK               0x00020000
>  #define CONFIG_SPL_BSS_START_ADDR      0x00020000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x00040000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x0001ffff
> diff --git a/include/configs/espresso7420.h b/include/configs/espresso742=
0.h
> index 9632319e126a..660d1a080495 100644
> --- a/include/configs/espresso7420.h
> +++ b/include/configs/espresso7420.h
> @@ -13,7 +13,6 @@
>  #define CONFIG_ESPRESSO7420
>
>  #define CONFIG_SYS_SDRAM_BASE          0x40000000
> -#define CONFIG_SPL_STACK               CONFIG_IRAM_END
>
>  /* DRAM Memory Banks */
>  #define SDRAM_BANK_SIZE                (256UL << 20UL) /* 256 MB */
> diff --git a/include/configs/gardena-smart-gateway-at91sam.h b/include/co=
nfigs/gardena-smart-gateway-at91sam.h
> index 940b61b6dd13..380622c9c79e 100644
> --- a/include/configs/gardena-smart-gateway-at91sam.h
> +++ b/include/configs/gardena-smart-gateway-at91sam.h
> @@ -33,7 +33,6 @@
>  #define CONFIG_SYS_NAND_READY_PIN      AT91_PIN_PD5
>
>  /* SPL */
> -#define CONFIG_SPL_STACK               0x308000
>
>  #define CONFIG_SPL_BSS_START_ADDR      0x20000000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x20080000
> diff --git a/include/configs/gose.h b/include/configs/gose.h
> index a0af98dd9805..d1fe375a2c1f 100644
> --- a/include/configs/gose.h
> +++ b/include/configs/gose.h
> @@ -32,7 +32,4 @@
>  #define CONFIG_EXTRA_ENV_SETTINGS      \
>         "bootm_size=3D0x10000000\0"
>
> -/* SPL support */
> -#define CONFIG_SPL_STACK               0xe6340000
> -
>  #endif /* __GOSE_H */
> diff --git a/include/configs/helios4.h b/include/configs/helios4.h
> index e90cea374b24..86d441b11b20 100644
> --- a/include/configs/helios4.h
> +++ b/include/configs/helios4.h
> @@ -47,8 +47,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + CONFIG_SPL_SIZE)
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  #if defined(CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC) || defined(CONFIG_MVEBU_SP=
L_BOOT_DEVICE_SATA)
>  /* SPL related MMC defines */
>  #ifdef CONFIG_SPL_BUILD
> diff --git a/include/configs/imx6_spl.h b/include/configs/imx6_spl.h
> index ad6bbd802b55..86e192fb0c89 100644
> --- a/include/configs/imx6_spl.h
> +++ b/include/configs/imx6_spl.h
> @@ -21,7 +21,6 @@
>   *    and some padding thus 'our' max size is really 0x00908000 - 0x0093=
8000
>   *    or 192KB
>   */
> -#define CONFIG_SPL_STACK               0x0093FFB8
>  /*
>   * Pad SPL to 196KB (4KB header + 192KB max size). This allows to write =
the
>   * SPL/U-Boot combination generated with u-boot-with-spl.imx directly to=
 a
> @@ -40,7 +39,6 @@
>   *    and some padding thus 'our' max size is really 0x00908000 - 0x0091=
8000
>   *    or 64KB
>   */
> -#define CONFIG_SPL_STACK               0x0091FFB8
>  /*
>   * Pad SPL to 68KB (4KB header + 64KB max size). This allows to write th=
e
>   * SPL/U-Boot combination generated with u-boot-with-spl.imx directly to=
 a
> diff --git a/include/configs/imx7_spl.h b/include/configs/imx7_spl.h
> index 33a6185ef94c..019ed5e203a9 100644
> --- a/include/configs/imx7_spl.h
> +++ b/include/configs/imx7_spl.h
> @@ -26,7 +26,6 @@
>   *    CONFIG_SPL_TEXT_BASE could be moved to 0x00911000 to gain 4KB of s=
pace
>   *    for the SPL, but 56KB should be more than enough for the SPL.
>   */
> -#define CONFIG_SPL_STACK               0x00946BB8
>  /*
>   * Pad SPL to 68KB (4KB header + 56KB max size + 8KB extra padding)
>   * The extra padding could be removed, but this value was used historica=
lly
> diff --git a/include/configs/imx8mm-cl-iot-gate.h b/include/configs/imx8m=
m-cl-iot-gate.h
> index 114c8c1a800e..0e16d14f8b6f 100644
> --- a/include/configs/imx8mm-cl-iot-gate.h
> +++ b/include/configs/imx8mm-cl-iot-gate.h
> @@ -17,7 +17,6 @@
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x920000
>  #define CONFIG_SPL_BSS_START_ADDR      0x910000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 KB */
> diff --git a/include/configs/imx8mm_beacon.h b/include/configs/imx8mm_bea=
con.h
> index 0151e81630f5..d28774cddbf3 100644
> --- a/include/configs/imx8mm_beacon.h
> +++ b/include/configs/imx8mm_beacon.h
> @@ -14,7 +14,6 @@
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x920000
>  #define CONFIG_SPL_BSS_START_ADDR      0x910000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 KB */
> diff --git a/include/configs/imx8mm_data_modul_edm_sbc.h b/include/config=
s/imx8mm_data_modul_edm_sbc.h
> index 9487fe001043..ed819e392abd 100644
> --- a/include/configs/imx8mm_data_modul_edm_sbc.h
> +++ b/include/configs/imx8mm_data_modul_edm_sbc.h
> @@ -14,7 +14,6 @@
>
>  #define CONFIG_SYS_MONITOR_LEN         SZ_1M
>
> -#define CONFIG_SPL_STACK               0x920000
>  #ifdef CONFIG_SPL_BUILD
>  #define CONFIG_SPL_BSS_START_ADDR      0x910000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
> diff --git a/include/configs/imx8mm_evk.h b/include/configs/imx8mm_evk.h
> index 24345d41a9a7..b6dda3331764 100644
> --- a/include/configs/imx8mm_evk.h
> +++ b/include/configs/imx8mm_evk.h
> @@ -16,7 +16,6 @@
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x920000
>  #define CONFIG_SPL_BSS_START_ADDR      0x910000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 KB */
> diff --git a/include/configs/imx8mm_icore_mx8mm.h b/include/configs/imx8m=
m_icore_mx8mm.h
> index 505ef8beb31a..ffe88f7027b7 100644
> --- a/include/configs/imx8mm_icore_mx8mm.h
> +++ b/include/configs/imx8mm_icore_mx8mm.h
> @@ -15,7 +15,6 @@
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -# define CONFIG_SPL_STACK              0x920000
>  # define CONFIG_SPL_BSS_START_ADDR     0x910000
>  # define CONFIG_SYS_SPL_MALLOC_START   0x42200000
>  # define CONFIG_SYS_SPL_MALLOC_SIZE    SZ_512K
> diff --git a/include/configs/imx8mm_venice.h b/include/configs/imx8mm_ven=
ice.h
> index 560a876b2ff7..eb30ed1b950c 100644
> --- a/include/configs/imx8mm_venice.h
> +++ b/include/configs/imx8mm_venice.h
> @@ -14,7 +14,6 @@
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x920000
>  #define CONFIG_SPL_BSS_START_ADDR      0x910000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_1M
> diff --git a/include/configs/imx8mn_beacon.h b/include/configs/imx8mn_bea=
con.h
> index 0118ca32a961..3b99ba41bda7 100644
> --- a/include/configs/imx8mn_beacon.h
> +++ b/include/configs/imx8mn_beacon.h
> @@ -14,7 +14,6 @@
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x187FF0
>  #define CONFIG_SPL_BSS_START_ADDR      0x0095e000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K
> diff --git a/include/configs/imx8mn_bsh_smm_s2_common.h b/include/configs=
/imx8mn_bsh_smm_s2_common.h
> index 91418e677846..60faedb76e67 100644
> --- a/include/configs/imx8mn_bsh_smm_s2_common.h
> +++ b/include/configs/imx8mn_bsh_smm_s2_common.h
> @@ -16,7 +16,6 @@
>  #define CONFIG_SYS_UBOOT_BASE  \
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
> -#define CONFIG_SPL_STACK               0x980000
>  #define CONFIG_SPL_BSS_START_ADDR      0x950000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K
> diff --git a/include/configs/imx8mn_evk.h b/include/configs/imx8mn_evk.h
> index b828a5b6349d..fac2c26146d6 100644
> --- a/include/configs/imx8mn_evk.h
> +++ b/include/configs/imx8mn_evk.h
> @@ -17,7 +17,6 @@
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x980000
>  #define CONFIG_SPL_BSS_START_ADDR      0x950000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 KB */
> diff --git a/include/configs/imx8mn_var_som.h b/include/configs/imx8mn_va=
r_som.h
> index acfc2834a951..699a51c1eb41 100644
> --- a/include/configs/imx8mn_var_som.h
> +++ b/include/configs/imx8mn_var_som.h
> @@ -16,7 +16,6 @@
>  #define CONFIG_SYS_UBOOT_BASE  \
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
> -#define CONFIG_SPL_STACK               0x980000
>  #define CONFIG_SPL_BSS_START_ADDR      0x950000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K
> diff --git a/include/configs/imx8mn_venice.h b/include/configs/imx8mn_ven=
ice.h
> index 56b3fe117f2c..5807da5ac4b9 100644
> --- a/include/configs/imx8mn_venice.h
> +++ b/include/configs/imx8mn_venice.h
> @@ -14,7 +14,6 @@
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x980000
>  #define CONFIG_SPL_BSS_START_ADDR      0x950000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 KB */
> diff --git a/include/configs/imx8mp_dhcom_pdk2.h b/include/configs/imx8mp=
_dhcom_pdk2.h
> index f641f4902dc0..abe245748f19 100644
> --- a/include/configs/imx8mp_dhcom_pdk2.h
> +++ b/include/configs/imx8mp_dhcom_pdk2.h
> @@ -15,7 +15,6 @@
>  #define CONFIG_SYS_MONITOR_LEN         SZ_1M
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x96FC00
>  #define CONFIG_SPL_BSS_START_ADDR      0x0096FC00
>  #define CONFIG_SYS_SPL_MALLOC_START    0x4c000000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 kiB */
> diff --git a/include/configs/imx8mp_evk.h b/include/configs/imx8mp_evk.h
> index f066bb00bf26..1cfd63d78c6a 100644
> --- a/include/configs/imx8mp_evk.h
> +++ b/include/configs/imx8mp_evk.h
> @@ -17,7 +17,6 @@
>
>  #ifdef CONFIG_SPL_BUILD
>  /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
> -#define CONFIG_SPL_STACK               0x960000
>  #define CONFIG_SPL_BSS_START_ADDR      0x0098FC00
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 KB */
> diff --git a/include/configs/imx8mp_rsb3720.h b/include/configs/imx8mp_rs=
b3720.h
> index b9122d4667fe..97f66bddbc9c 100644
> --- a/include/configs/imx8mp_rsb3720.h
> +++ b/include/configs/imx8mp_rsb3720.h
> @@ -27,7 +27,6 @@
>                  0x5f, 0xd3, 0x6b, 0x9b, 0xe5, 0xb9)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x960000
>  #define CONFIG_SPL_BSS_START_ADDR      0x0098FC00
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 KB */
> diff --git a/include/configs/imx8mp_venice.h b/include/configs/imx8mp_ven=
ice.h
> index 1e8b1ba06e1b..074f5b08fc1a 100644
> --- a/include/configs/imx8mp_venice.h
> +++ b/include/configs/imx8mp_venice.h
> @@ -14,7 +14,6 @@
>         (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x960000
>  #define CONFIG_SPL_BSS_START_ADDR      0x0098FC00
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 KB */
> diff --git a/include/configs/imx8mq_cm.h b/include/configs/imx8mq_cm.h
> index 48fa596eee6e..fc4b1c5bf780 100644
> --- a/include/configs/imx8mq_cm.h
> +++ b/include/configs/imx8mq_cm.h
> @@ -15,7 +15,6 @@
>  #define CONFIG_SYS_MONITOR_LEN         (512 * 1024)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x187FF0
>  #define CONFIG_SPL_BSS_START_ADDR      0x00180000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE    0x80000  /* 512 KB */
> diff --git a/include/configs/imx8mq_evk.h b/include/configs/imx8mq_evk.h
> index 416c83b49024..179c5123d724 100644
> --- a/include/configs/imx8mq_evk.h
> +++ b/include/configs/imx8mq_evk.h
> @@ -16,7 +16,6 @@
>
>  #ifdef CONFIG_SPL_BUILD
>  /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
> -#define CONFIG_SPL_STACK               0x187FF0
>  #define CONFIG_SPL_BSS_START_ADDR      0x00180000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE    0x80000  /* 512 KB */
> diff --git a/include/configs/imx8mq_phanbell.h b/include/configs/imx8mq_p=
hanbell.h
> index 84774eed8eee..bc749538d8cc 100644
> --- a/include/configs/imx8mq_phanbell.h
> +++ b/include/configs/imx8mq_phanbell.h
> @@ -13,7 +13,6 @@
>
>  #ifdef CONFIG_SPL_BUILD
>  /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
> -#define CONFIG_SPL_STACK               0x187FF0
>  #define CONFIG_SPL_BSS_START_ADDR      0x00180000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE    0x80000  /* 512 KB */
> diff --git a/include/configs/imx8qm_mek.h b/include/configs/imx8qm_mek.h
> index 0fa5fe581551..4f3e004f388b 100644
> --- a/include/configs/imx8qm_mek.h
> +++ b/include/configs/imx8qm_mek.h
> @@ -15,7 +15,6 @@
>  #ifdef CONFIG_SPL_BUILD
>  #define CONFIG_SYS_MONITOR_LEN                         (1024 * 1024)
>
> -#define CONFIG_SPL_STACK               0x013E000
>  #define CONFIG_SPL_BSS_START_ADDR      0x00128000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x00120000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x3000  /* 12 KB */
> diff --git a/include/configs/imx8qxp_mek.h b/include/configs/imx8qxp_mek.=
h
> index fd4d2c9669f0..7afc64800eb3 100644
> --- a/include/configs/imx8qxp_mek.h
> +++ b/include/configs/imx8qxp_mek.h
> @@ -13,7 +13,6 @@
>  #ifdef CONFIG_SPL_BUILD
>  #define CONFIG_SYS_MONITOR_LEN                         (1024 * 1024)
>
> -#define CONFIG_SPL_STACK               0x013E000
>  #define CONFIG_SPL_BSS_START_ADDR      0x00128000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x00120000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x3000  /* 12 KB */
> diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.=
h
> index 8fe54f674cd4..55b1795634ab 100644
> --- a/include/configs/imx8ulp_evk.h
> +++ b/include/configs/imx8ulp_evk.h
> @@ -14,7 +14,6 @@
>  #define CONFIG_SYS_UBOOT_BASE  (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_M=
ODE_U_BOOT_SECTOR * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x22050000
>  #define CONFIG_SPL_BSS_START_ADDR      0x22048000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x22040000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x8000  /* 32 KB */
> diff --git a/include/configs/koelsch.h b/include/configs/koelsch.h
> index 3e46f9d5851f..736865ad80af 100644
> --- a/include/configs/koelsch.h
> +++ b/include/configs/koelsch.h
> @@ -33,6 +33,5 @@
>         "bootm_size=3D0x10000000\0"
>
>  /* SPL support */
> -#define CONFIG_SPL_STACK               0xe6340000
>
>  #endif /* __KOELSCH_H */
> diff --git a/include/configs/kontron-sl-mx8mm.h b/include/configs/kontron=
-sl-mx8mm.h
> index c731b04b8e79..b2c826b6f134 100644
> --- a/include/configs/kontron-sl-mx8mm.h
> +++ b/include/configs/kontron-sl-mx8mm.h
> @@ -55,7 +55,6 @@
>  #define CONFIG_SYS_BOOTM_LEN           SZ_64M
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x91fff0
>  #define CONFIG_SPL_BSS_START_ADDR      0x910000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K
> diff --git a/include/configs/kontron_pitx_imx8m.h b/include/configs/kontr=
on_pitx_imx8m.h
> index 5e51f4fd4770..08c6b80abb9a 100644
> --- a/include/configs/kontron_pitx_imx8m.h
> +++ b/include/configs/kontron_pitx_imx8m.h
> @@ -17,7 +17,6 @@
>                  0x40, 0xd4, 0x5c, 0xca, 0x13, 0x99)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x187FF0
>  #define CONFIG_SPL_BSS_START_ADDR       0x00180000
>  #define CONFIG_SYS_SPL_MALLOC_START     0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE      SZ_512K
> diff --git a/include/configs/kontron_sl28.h b/include/configs/kontron_sl2=
8.h
> index 129bd7ed1748..52778dd02b93 100644
> --- a/include/configs/kontron_sl28.h
> +++ b/include/configs/kontron_sl28.h
> @@ -42,7 +42,6 @@
>
>  /* SPL */
>  #define CONFIG_SPL_BSS_START_ADDR      0x80100000
> -#define CONFIG_SPL_STACK               (CONFIG_SYS_FSL_OCRAM_BASE + 0x9f=
f0)
>
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x00100000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x80200000
> diff --git a/include/configs/lager.h b/include/configs/lager.h
> index 98c82a0e5710..f3feaa539fcc 100644
> --- a/include/configs/lager.h
> +++ b/include/configs/lager.h
> @@ -34,6 +34,5 @@
>         "bootm_size=3D0x10000000\0"
>
>  /* SPL support */
> -#define CONFIG_SPL_STACK               0xe6340000
>
>  #endif /* __LAGER_H */
> diff --git a/include/configs/ls1021aiot.h b/include/configs/ls1021aiot.h
> index e8827157256b..614b399af508 100644
> --- a/include/configs/ls1021aiot.h
> +++ b/include/configs/ls1021aiot.h
> @@ -42,8 +42,6 @@
>  #define SDRAM_CFG_BI                   0x00000001
>
>  #ifdef CONFIG_SD_BOOT
> -#define CONFIG_SPL_STACK               0x1001d000
> -
>  #define CONFIG_SYS_SPL_MALLOC_START    (CONFIG_SYS_TEXT_BASE + \
>                 CONFIG_SYS_MONITOR_LEN)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x100000
> diff --git a/include/configs/ls1021aqds.h b/include/configs/ls1021aqds.h
> index d2e0f5f93623..fb50c82a653f 100644
> --- a/include/configs/ls1021aqds.h
> +++ b/include/configs/ls1021aqds.h
> @@ -11,8 +11,6 @@
>  #define CONFIG_SYS_INIT_RAM_SIZE       OCRAM_SIZE
>
>  #ifdef CONFIG_SD_BOOT
> -#define CONFIG_SPL_STACK               0x1001d000
> -
>  #define CONFIG_SYS_SPL_MALLOC_START    (CONFIG_SYS_TEXT_BASE + \
>                 CONFIG_SYS_MONITOR_LEN)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x100000
> @@ -21,8 +19,6 @@
>  #endif
>
>  #ifdef CONFIG_NAND_BOOT
> -#define CONFIG_SPL_STACK               0x1001d000
> -
>  #define CONFIG_SYS_NAND_U_BOOT_SIZE    (400 << 10)
>  #define CONFIG_SYS_NAND_U_BOOT_DST     CONFIG_SYS_TEXT_BASE
>  #define CONFIG_SYS_NAND_U_BOOT_START   CONFIG_SYS_TEXT_BASE
> diff --git a/include/configs/ls1021atsn.h b/include/configs/ls1021atsn.h
> index 35156a00b3a8..3e9175f50451 100644
> --- a/include/configs/ls1021atsn.h
> +++ b/include/configs/ls1021atsn.h
> @@ -44,8 +44,6 @@
>  #define CONFIG_U_BOOT_HDR_SIZE         (16 << 10)
>  #endif /* ifdef CONFIG_NXP_ESBC */
>
> -#define CONFIG_SPL_STACK               0x1001d000
> -
>  #define CONFIG_SYS_SPL_MALLOC_START    (CONFIG_SYS_TEXT_BASE + \
>                 CONFIG_SYS_MONITOR_LEN)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x100000
> diff --git a/include/configs/ls1021atwr.h b/include/configs/ls1021atwr.h
> index afff8fc3e2c8..4470d974ca97 100644
> --- a/include/configs/ls1021atwr.h
> +++ b/include/configs/ls1021atwr.h
> @@ -46,8 +46,6 @@
>  #define CONFIG_U_BOOT_HDR_SIZE                         (16 << 10)
>  #endif /* ifdef CONFIG_NXP_ESBC */
>
> -#define CONFIG_SPL_STACK               0x1001d000
> -
>  #define CONFIG_SYS_SPL_MALLOC_START    (CONFIG_SYS_TEXT_BASE + \
>                 CONFIG_SYS_MONITOR_LEN)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x100000
> diff --git a/include/configs/ls1043a_common.h b/include/configs/ls1043a_c=
ommon.h
> index 710708398262..a09486a4170e 100644
> --- a/include/configs/ls1043a_common.h
> +++ b/include/configs/ls1043a_common.h
> @@ -46,9 +46,6 @@
>
>  /* SD boot SPL */
>  #ifdef CONFIG_SD_BOOT
> -
> -#define CONFIG_SPL_STACK               0x1001e000
> -
>  #define CONFIG_SYS_SPL_MALLOC_START    (CONFIG_SPL_BSS_START_ADDR + \
>                                         CONFIG_SPL_BSS_MAX_SIZE)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x100000
> @@ -70,7 +67,6 @@
>
>  /* NAND SPL */
>  #ifdef CONFIG_NAND_BOOT
> -#define CONFIG_SPL_STACK               0x1001d000
>  #define CONFIG_SYS_NAND_U_BOOT_DST     CONFIG_SYS_TEXT_BASE
>  #define CONFIG_SYS_NAND_U_BOOT_START   CONFIG_SYS_TEXT_BASE
>  #define CONFIG_SYS_SPL_MALLOC_START    0x80200000
> diff --git a/include/configs/ls1046a_common.h b/include/configs/ls1046a_c=
ommon.h
> index bf808d15efa9..92fcc453f165 100644
> --- a/include/configs/ls1046a_common.h
> +++ b/include/configs/ls1046a_common.h
> @@ -46,7 +46,6 @@
>
>  /* SD boot SPL */
>  #ifdef CONFIG_SD_BOOT
> -#define CONFIG_SPL_STACK               0x10020000
>  #define CONFIG_SPL_BSS_START_ADDR      0x8f000000
>  #define CONFIG_SYS_SPL_MALLOC_START    (CONFIG_SPL_BSS_START_ADDR + \
>                                         CONFIG_SPL_BSS_MAX_SIZE)
> @@ -68,7 +67,6 @@
>
>  #if defined(CONFIG_QSPI_BOOT) && defined(CONFIG_SPL)
>  #define CONFIG_SPL_TARGET              "spl/u-boot-spl.pbl"
> -#define CONFIG_SPL_STACK               0x10020000
>  #define CONFIG_SPL_BSS_START_ADDR      0x8f000000
>  #define CONFIG_SYS_SPL_MALLOC_START    (CONFIG_SPL_BSS_START_ADDR + \
>                                         CONFIG_SPL_BSS_MAX_SIZE)
> @@ -78,7 +76,6 @@
>
>  /* NAND SPL */
>  #ifdef CONFIG_NAND_BOOT
> -#define CONFIG_SPL_STACK               0x1001f000
>  #define CONFIG_SYS_NAND_U_BOOT_DST     CONFIG_SYS_TEXT_BASE
>  #define CONFIG_SYS_NAND_U_BOOT_START   CONFIG_SYS_TEXT_BASE
>
> diff --git a/include/configs/ls1088a_common.h b/include/configs/ls1088a_c=
ommon.h
> index 6ed180984e5b..1b8180f6f10b 100644
> --- a/include/configs/ls1088a_common.h
> +++ b/include/configs/ls1088a_common.h
> @@ -145,7 +145,6 @@ unsigned long long get_qixis_addr(void);
>
>  #ifdef CONFIG_SPL
>  #define CONFIG_SPL_BSS_START_ADDR      0x80100000
> -#define CONFIG_SPL_STACK               (CONFIG_SYS_FSL_OCRAM_BASE + 0x9f=
f0)
>  #define CONFIG_SPL_TARGET              "u-boot-with-spl.bin"
>
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x00100000
> diff --git a/include/configs/ls2080a_common.h b/include/configs/ls2080a_c=
ommon.h
> index 5d2b8ebea0d4..f33e369847c3 100644
> --- a/include/configs/ls2080a_common.h
> +++ b/include/configs/ls2080a_common.h
> @@ -138,7 +138,6 @@ unsigned long long get_qixis_addr(void);
>         " 0x580e00000 \0"
>
>  #define CONFIG_SPL_BSS_START_ADDR      0x80100000
> -#define CONFIG_SPL_STACK               (CONFIG_SYS_FSL_OCRAM_BASE + 0x9f=
f0)
>  #define CONFIG_SPL_TARGET              "u-boot-with-spl.bin"
>
>  #ifdef CONFIG_NAND_BOOT
> diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
> index 58d6418b02e9..433952c9d72c 100644
> --- a/include/configs/m53menlo.h
> +++ b/include/configs/m53menlo.h
> @@ -109,7 +109,6 @@
>   * NAND SPL
>   */
>  #define CONFIG_SPL_TARGET              "u-boot-with-nand-spl.imx"
> -#define CONFIG_SPL_STACK               0x70004000
>
>  #define CONFIG_SYS_NAND_SIZE           (256 * 1024 * 1024)
>
> diff --git a/include/configs/maxbcm.h b/include/configs/maxbcm.h
> index 939046f6de85..d728c1fc11b2 100644
> --- a/include/configs/maxbcm.h
> +++ b/include/configs/maxbcm.h
> @@ -51,8 +51,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + (128 << 10))
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  /* SPL related SPI defines */
>
>  /* Enable DDR support in SPL (DDR3 training from Marvell bin_hdr) */
> diff --git a/include/configs/microblaze-generic.h b/include/configs/micro=
blaze-generic.h
> index 37bd47854922..e9c9bf9281ce 100644
> --- a/include/configs/microblaze-generic.h
> +++ b/include/configs/microblaze-generic.h
> @@ -128,9 +128,6 @@
>  /* BRAM size - will be generated */
>  #define CONFIG_SYS_INIT_RAM_SIZE       0x100000
>
> -# define CONFIG_SPL_STACK_ADDR         (CONFIG_SYS_INIT_RAM_ADDR + \
> -                                        CONFIG_SYS_INIT_RAM_SIZE)
> -
>  /* Just for sure that there is a space for stack */
>  #define CONFIG_SPL_STACK_SIZE          0x100
>
> diff --git a/include/configs/mt7629.h b/include/configs/mt7629.h
> index 64263ce2e637..246836a077b9 100644
> --- a/include/configs/mt7629.h
> +++ b/include/configs/mt7629.h
> @@ -20,7 +20,6 @@
>  /* Environment */
>
>  /* Defines for SPL */
> -#define CONFIG_SPL_STACK               0x106000
>
>  #define CONFIG_SPI_ADDR                        0x30000000
>  #define CONFIG_SYS_UBOOT_BASE          (CONFIG_SPI_ADDR + CONFIG_SPL_PAD=
_TO)
> diff --git a/include/configs/omapl138_lcdk.h b/include/configs/omapl138_l=
cdk.h
> index dbb87b9642e2..6fefb1eab900 100644
> --- a/include/configs/omapl138_lcdk.h
> +++ b/include/configs/omapl138_lcdk.h
> @@ -174,7 +174,6 @@
>  #define CONFIG_SYS_SPL_MALLOC_START    (CONFIG_SYS_TEXT_BASE - \
>                                                 CONFIG_SYS_MALLOC_LEN)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     CONFIG_SYS_MALLOC_LEN
> -#define CONFIG_SPL_STACK       0x8001ff00
>
>  /* additions for new relocation code, must added to all boards */
>  #define CONFIG_SYS_SDRAM_BASE          0xc0000000
> diff --git a/include/configs/openpiton-riscv64.h b/include/configs/openpi=
ton-riscv64.h
> index 006ec360ab34..e194fbaeecf7 100644
> --- a/include/configs/openpiton-riscv64.h
> +++ b/include/configs/openpiton-riscv64.h
> @@ -22,8 +22,6 @@
>  #define CONFIG_SYS_SPL_MALLOC_START (CONFIG_SPL_BSS_START_ADDR + \
>                 CONFIG_SPL_BSS_MAX_SIZE)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE  0x0100000
> -#define CONFIG_SPL_STACK    (0x80000000 + 0x04000000 - \
> -               GENERATED_GBL_DATA_SIZE)
>
>  #define CONFIG_SPL_GD_ADDR 0x85000000
>  #endif
> diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_i=
mx8mm.h
> index 0366933cea26..284891414e22 100644
> --- a/include/configs/phycore_imx8mm.h
> +++ b/include/configs/phycore_imx8mm.h
> @@ -17,7 +17,6 @@
>                 (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTO=
R * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x920000
>  #define CONFIG_SPL_BSS_START_ADDR      0x910000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K
> diff --git a/include/configs/phycore_imx8mp.h b/include/configs/phycore_i=
mx8mp.h
> index 8434156998aa..99aecdad4ef6 100644
> --- a/include/configs/phycore_imx8mp.h
> +++ b/include/configs/phycore_imx8mp.h
> @@ -17,7 +17,6 @@
>                 (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTO=
R * 512)
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x960000
>  #define CONFIG_SPL_BSS_START_ADDR      0x98FC00
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K
> diff --git a/include/configs/pico-imx8mq.h b/include/configs/pico-imx8mq.=
h
> index c8dab24f90a2..10e3e23e8dc8 100644
> --- a/include/configs/pico-imx8mq.h
> +++ b/include/configs/pico-imx8mq.h
> @@ -13,7 +13,6 @@
>
>  #ifdef CONFIG_SPL_BUILD
>  /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
> -#define CONFIG_SPL_STACK               0x187FF0
>  #define CONFIG_SPL_BSS_START_ADDR      0x00180000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x80000 /* 512 KB */
> diff --git a/include/configs/pm9g45.h b/include/configs/pm9g45.h
> index 56d2459b9786..6f49568484d9 100644
> --- a/include/configs/pm9g45.h
> +++ b/include/configs/pm9g45.h
> @@ -43,7 +43,6 @@
>  #endif
>
>  /* Defines for SPL */
> -#define CONFIG_SPL_STACK               0x310000
>
>  #define CONFIG_SYS_MONITOR_LEN         0x80000
>
> diff --git a/include/configs/porter.h b/include/configs/porter.h
> index d8c4ea105759..88fa65e0ffc1 100644
> --- a/include/configs/porter.h
> +++ b/include/configs/porter.h
> @@ -38,6 +38,5 @@
>         "bootm_size=3D0x10000000\0"
>
>  /* SPL support */
> -#define CONFIG_SPL_STACK               0xe6340000
>
>  #endif /* __PORTER_H */
> diff --git a/include/configs/px30_common.h b/include/configs/px30_common.=
h
> index 7b36cd765ea4..1cf239f8a634 100644
> --- a/include/configs/px30_common.h
> +++ b/include/configs/px30_common.h
> @@ -13,7 +13,6 @@
>  /* FIXME: ff020000 is pmu_mem (10k), while ff0e0000 is regular int_mem *=
/
>  #define CONFIG_IRAM_BASE               0xff020000
>
> -#define CONFIG_SPL_STACK               0x00400000
>  #define CONFIG_SPL_BSS_START_ADDR      0x4000000
>  #define CONFIG_SYS_BOOTM_LEN           (64 << 20)      /* 64M */
>
> diff --git a/include/configs/rcar-gen3-common.h b/include/configs/rcar-ge=
n3-common.h
> index 8b4c5c0f105e..6cda69159b45 100644
> --- a/include/configs/rcar-gen3-common.h
> +++ b/include/configs/rcar-gen3-common.h
> @@ -49,6 +49,5 @@
>  #else
>  #define CONFIG_SPL_BSS_START_ADDR      0xe631f000
>  #endif
> -#define CONFIG_SPL_STACK               0xe6304000
>
>  #endif /* __RCAR_GEN3_COMMON_H */
> diff --git a/include/configs/rk3036_common.h b/include/configs/rk3036_com=
mon.h
> index 0eded1838c2a..2f3260e449c1 100644
> --- a/include/configs/rk3036_common.h
> +++ b/include/configs/rk3036_common.h
> @@ -10,8 +10,6 @@
>
>  #define CONFIG_SYS_HZ_CLOCK            24000000
>
> -#define CONFIG_SPL_STACK               0x10081fff
> -
>  #define CONFIG_ROCKCHIP_MAX_INIT_SIZE  (4 << 10)
>  #define CONFIG_ROCKCHIP_CHIP_TAG       "RK30"
>
> diff --git a/include/configs/rk3066_common.h b/include/configs/rk3066_com=
mon.h
> index dd33d30e9e54..41e0d18f88c6 100644
> --- a/include/configs/rk3066_common.h
> +++ b/include/configs/rk3066_common.h
> @@ -11,8 +11,6 @@
>
>  #define CONFIG_IRAM_BASE               0x10080000
>
> -#define CONFIG_SPL_STACK               0x1008FFFF
> -
>  #define CONFIG_SYS_SDRAM_BASE          0x60000000
>  #define SDRAM_BANK_SIZE                        (1024UL << 20UL)
>  #define SDRAM_MAX_SIZE                 CONFIG_NR_DRAM_BANKS * SDRAM_BANK=
_SIZE
> diff --git a/include/configs/rk3188_common.h b/include/configs/rk3188_com=
mon.h
> index 466b0e748597..c1d66845412f 100644
> --- a/include/configs/rk3188_common.h
> +++ b/include/configs/rk3188_common.h
> @@ -15,8 +15,6 @@
>
>  /* spl size 32kb sram - 2kb bootrom */
>
> -#define CONFIG_SPL_STACK               0x10087fff
> -
>  #define CONFIG_SYS_SDRAM_BASE          0x60000000
>  #define SDRAM_BANK_SIZE                        (2UL << 30)
>  #define SDRAM_MAX_SIZE                 0x80000000
> diff --git a/include/configs/rk3288_common.h b/include/configs/rk3288_com=
mon.h
> index abeb6535ce35..844c154217bd 100644
> --- a/include/configs/rk3288_common.h
> +++ b/include/configs/rk3288_common.h
> @@ -13,8 +13,6 @@
>
>  #define CONFIG_SYS_HZ_CLOCK            24000000
>
> -#define CONFIG_SPL_STACK               0xff718000
> -
>  #define CONFIG_IRAM_BASE               0xff700000
>
>  /* RAW SD card / eMMC locations. */
> diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_com=
mon.h
> index 2433ea836529..2b0b367df785 100644
> --- a/include/configs/rk3308_common.h
> +++ b/include/configs/rk3308_common.h
> @@ -13,7 +13,6 @@
>  #define CONFIG_SYS_NS16550_MEM32
>
>  #define CONFIG_IRAM_BASE               0xfff80000
> -#define CONFIG_SPL_STACK               0x00400000
>  #define CONFIG_SYS_BOOTM_LEN           (64 << 20)      /* 64M */
>
>
> diff --git a/include/configs/rk3328_common.h b/include/configs/rk3328_com=
mon.h
> index 5141c48de787..25e2c6590014 100644
> --- a/include/configs/rk3328_common.h
> +++ b/include/configs/rk3328_common.h
> @@ -10,7 +10,6 @@
>
>  #define CONFIG_IRAM_BASE               0xff090000
>
> -#define CONFIG_SPL_STACK               0x00400000
>  #define CONFIG_SPL_BSS_START_ADDR      0x2000000
>
>  #define CONFIG_SYS_BOOTM_LEN   (64 << 20)      /* 64M */
> diff --git a/include/configs/rk3368_common.h b/include/configs/rk3368_com=
mon.h
> index 77817a7e73c2..1bdc8cf187b0 100644
> --- a/include/configs/rk3368_common.h
> +++ b/include/configs/rk3368_common.h
> @@ -17,7 +17,6 @@
>  #define CONFIG_IRAM_BASE               0xff8c0000
>
>  #define CONFIG_SPL_BSS_START_ADDR       0x400000
> -#define CONFIG_SPL_STACK                0x00188000
>
>  #define CONFIG_SYS_BOOTM_LEN   (64 << 20)      /* 64M */
>
> diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_com=
mon.h
> index 4582d34af859..112b8639ad75 100644
> --- a/include/configs/rk3399_common.h
> +++ b/include/configs/rk3399_common.h
> @@ -11,10 +11,8 @@
>  #define CONFIG_IRAM_BASE               0xff8c0000
>
>  #if defined(CONFIG_SPL_BUILD) && defined(CONFIG_TPL_BOOTROM_SUPPORT)
> -#define CONFIG_SPL_STACK               0x00400000
>  #define CONFIG_SPL_BSS_START_ADDR      0x00400000
>  #else
> -#define CONFIG_SPL_STACK               0xff8effff
>  /*  BSS setup */
>  #define CONFIG_SPL_BSS_START_ADDR       0xff8e0000
>  #endif
> diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_com=
mon.h
> index 2e726b00c96a..c0721aa1afb9 100644
> --- a/include/configs/rk3568_common.h
> +++ b/include/configs/rk3568_common.h
> @@ -10,7 +10,6 @@
>
>  #define CONFIG_IRAM_BASE               0xfdcc0000
>
> -#define CONFIG_SPL_STACK               0x00400000
>  #define CONFIG_SPL_BSS_START_ADDR      0x4000000
>
>  #define CONFIG_SYS_BOOTM_LEN           (64 << 20)      /* 64M */
> diff --git a/include/configs/sam9x60_curiosity.h b/include/configs/sam9x6=
0_curiosity.h
> index 896697bf4152..afb1e3d0f105 100644
> --- a/include/configs/sam9x60_curiosity.h
> +++ b/include/configs/sam9x60_curiosity.h
> @@ -20,6 +20,4 @@
>  #define CONFIG_SYS_SDRAM_BASE          0x20000000
>  #define CONFIG_SYS_SDRAM_SIZE          0x8000000       /* 128 MB */
>
> -#define CONFIG_SPL_STACK         0x218000
> -
>  #endif
> diff --git a/include/configs/sama5d27_som1_ek.h b/include/configs/sama5d2=
7_som1_ek.h
> index 2bb71e4f42f4..dd5f8d8c8018 100644
> --- a/include/configs/sama5d27_som1_ek.h
> +++ b/include/configs/sama5d27_som1_ek.h
> @@ -15,7 +15,6 @@
>  #define CONFIG_SYS_AT91_MAIN_CLOCK      24000000 /* from 24 MHz crystal =
*/
>
>  /* SPL */
> -#define CONFIG_SPL_STACK               0x218000
>  #define CONFIG_SPL_BSS_START_ADDR      0x20000000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x20080000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x80000
> diff --git a/include/configs/sama5d27_wlsom1_ek.h b/include/configs/sama5=
d27_wlsom1_ek.h
> index 86f7c2bade82..728dc9fb98b6 100644
> --- a/include/configs/sama5d27_wlsom1_ek.h
> +++ b/include/configs/sama5d27_wlsom1_ek.h
> @@ -20,7 +20,6 @@
>  #define CONFIG_SYS_SDRAM_SIZE          0x10000000
>
>  /* SPL */
> -#define CONFIG_SPL_STACK               0x218000
>  #define CONFIG_SPL_BSS_START_ADDR      0x20000000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x20080000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x80000
> diff --git a/include/configs/sama5d2_icp.h b/include/configs/sama5d2_icp.=
h
> index f7f746e9b3e3..0645c21b6185 100644
> --- a/include/configs/sama5d2_icp.h
> +++ b/include/configs/sama5d2_icp.h
> @@ -18,8 +18,6 @@
>  #define CONFIG_SYS_SDRAM_BASE          0x20000000
>  #define CONFIG_SYS_SDRAM_SIZE          0x20000000
>
> -#define CONFIG_SPL_STACK               0x218000
> -
>  #ifdef CONFIG_SD_BOOT
>  /* u-boot env in sd/mmc card */
>  #define FAT_ENV_INTERFACE      "mmc"
> diff --git a/include/configs/sama5d2_xplained.h b/include/configs/sama5d2=
_xplained.h
> index b7cc8d05ce59..8481b0262c4a 100644
> --- a/include/configs/sama5d2_xplained.h
> +++ b/include/configs/sama5d2_xplained.h
> @@ -12,7 +12,6 @@
>  #include "at91-sama5_common.h"
>
>  /* SPL */
> -#define CONFIG_SPL_STACK               0x218000
>  #define CONFIG_SPL_BSS_START_ADDR      0x20000000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x20080000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x80000
> diff --git a/include/configs/sama5d3_xplained.h b/include/configs/sama5d3=
_xplained.h
> index 384e8d6e613b..23ffab226b1a 100644
> --- a/include/configs/sama5d3_xplained.h
> +++ b/include/configs/sama5d3_xplained.h
> @@ -27,8 +27,6 @@
>  #define CONFIG_SYS_SDRAM_BASE           0x20000000
>  #define CONFIG_SYS_SDRAM_SIZE          0x10000000
>
> -#define CONFIG_SPL_STACK               0x318000
> -
>  /* NAND flash */
>  #ifdef CONFIG_CMD_NAND
>  #define CONFIG_SYS_MAX_NAND_DEVICE     1
> diff --git a/include/configs/sama5d3xek.h b/include/configs/sama5d3xek.h
> index 161914294c87..e293002f39d2 100644
> --- a/include/configs/sama5d3xek.h
> +++ b/include/configs/sama5d3xek.h
> @@ -38,8 +38,6 @@
>  #define CONFIG_SYS_SDRAM_BASE           0x20000000
>  #define CONFIG_SYS_SDRAM_SIZE          0x20000000
>
> -#define CONFIG_SPL_STACK               0x318000
> -
>  /* SerialFlash */
>
>  /* NAND flash */
> diff --git a/include/configs/sama5d4_xplained.h b/include/configs/sama5d4=
_xplained.h
> index 6328450b995f..825925c114ab 100644
> --- a/include/configs/sama5d4_xplained.h
> +++ b/include/configs/sama5d4_xplained.h
> @@ -15,8 +15,6 @@
>  #define CONFIG_SYS_SDRAM_BASE           0x20000000
>  #define CONFIG_SYS_SDRAM_SIZE          0x20000000
>
> -#define CONFIG_SPL_STACK               0x218000
> -
>  /* NAND flash */
>  #ifdef CONFIG_CMD_NAND
>  #define CONFIG_SYS_MAX_NAND_DEVICE     1
> diff --git a/include/configs/sama5d4ek.h b/include/configs/sama5d4ek.h
> index a00d2851bd03..d2466da6fcd8 100644
> --- a/include/configs/sama5d4ek.h
> +++ b/include/configs/sama5d4ek.h
> @@ -15,8 +15,6 @@
>  #define CONFIG_SYS_SDRAM_BASE           0x20000000
>  #define CONFIG_SYS_SDRAM_SIZE          0x20000000
>
> -#define CONFIG_SPL_STACK               0x218000
> -
>  /* NAND flash */
>  #ifdef CONFIG_CMD_NAND
>  #define CONFIG_SYS_MAX_NAND_DEVICE     1
> diff --git a/include/configs/sama7g5ek.h b/include/configs/sama7g5ek.h
> index 97bac63ddde1..78347373fca9 100644
> --- a/include/configs/sama7g5ek.h
> +++ b/include/configs/sama7g5ek.h
> @@ -16,6 +16,4 @@
>  #define CONFIG_SYS_SDRAM_BASE          0x60000000
>  #define CONFIG_SYS_SDRAM_SIZE          0x20000000
>
> -#define CONFIG_SPL_STACK               0x218000
> -
>  #endif
> diff --git a/include/configs/sifive-unleashed.h b/include/configs/sifive-=
unleashed.h
> index 31787310c343..58d70922e4e7 100644
> --- a/include/configs/sifive-unleashed.h
> +++ b/include/configs/sifive-unleashed.h
> @@ -18,9 +18,6 @@
>                                          CONFIG_SPL_BSS_MAX_SIZE)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x00100000
>
> -#define CONFIG_SPL_STACK       (0x08000000 + 0x001D0000 - \
> -                                GENERATED_GBL_DATA_SIZE)
> -
>  #endif
>
>  #define CONFIG_SYS_SDRAM_BASE          0x80000000
> diff --git a/include/configs/sifive-unmatched.h b/include/configs/sifive-=
unmatched.h
> index 54b41494f6f1..a88debddca2f 100644
> --- a/include/configs/sifive-unmatched.h
> +++ b/include/configs/sifive-unmatched.h
> @@ -18,9 +18,6 @@
>                                          CONFIG_SPL_BSS_MAX_SIZE)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     0x00100000
>
> -#define CONFIG_SPL_STACK       (0x08000000 + 0x001D0000 - \
> -                                GENERATED_GBL_DATA_SIZE)
> -
>  #endif
>
>  #define CONFIG_SYS_SDRAM_BASE          0x80000000
> diff --git a/include/configs/silk.h b/include/configs/silk.h
> index a300ae86fc9a..58613effaf47 100644
> --- a/include/configs/silk.h
> +++ b/include/configs/silk.h
> @@ -38,6 +38,5 @@
>         "bootm_size=3D0x10000000\0"
>
>  /* SPL support */
> -#define CONFIG_SPL_STACK               0xe6340000
>
>  #endif /* __SILK_H */
> diff --git a/include/configs/smartweb.h b/include/configs/smartweb.h
> index 533129f311b0..d84a2c262efa 100644
> --- a/include/configs/smartweb.h
> +++ b/include/configs/smartweb.h
> @@ -114,7 +114,6 @@
>
>  /* Defines for SPL */
>
> -#define CONFIG_SPL_STACK               0x301000
>  #define CONFIG_SPL_BSS_START_ADDR      CONFIG_SYS_SDRAM_BASE
>  #define CONFIG_SYS_SPL_MALLOC_START     (CONFIG_SPL_BSS_START_ADDR + \
>                                         CONFIG_SPL_BSS_MAX_SIZE)
> diff --git a/include/configs/sniper.h b/include/configs/sniper.h
> index 01697a5c82a1..923da0ef99f9 100644
> --- a/include/configs/sniper.h
> +++ b/include/configs/sniper.h
> @@ -51,7 +51,6 @@
>  #define CONFIG_SPL_BSS_START_ADDR      0x80000000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x80208000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     (1024 * 1024)
> -#define CONFIG_SPL_STACK               LOW_LEVEL_SRAM_STACK
>
>  /*
>   * Serial
> diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_c=
ommon.h
> index bdcb872cd064..441e3545aa4d 100644
> --- a/include/configs/socfpga_common.h
> +++ b/include/configs/socfpga_common.h
> @@ -35,10 +35,6 @@
>  #if ((CONFIG_SYS_BOOTCOUNT_ADDR > CONFIG_SYS_INIT_RAM_ADDR) && \
>       (CONFIG_SYS_BOOTCOUNT_ADDR < (CONFIG_SYS_INIT_RAM_ADDR +  \
>                                    CONFIG_SYS_INIT_RAM_SIZE)))
> -#define CONFIG_SPL_STACK               CONFIG_SYS_BOOTCOUNT_ADDR
> -#else
> -#define CONFIG_SPL_STACK                       \
> -       (CONFIG_SYS_INIT_RAM_ADDR + CONFIG_SYS_INIT_RAM_SIZE)
>  #endif
>
>  /*
> diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/soc=
fpga_soc64_common.h
> index c4ba1d14f931..b73ce9176097 100644
> --- a/include/configs/socfpga_soc64_common.h
> +++ b/include/configs/socfpga_soc64_common.h
> @@ -144,9 +144,6 @@ unsigned int cm_get_l4_sys_free_clk_hz(void);
>   *
>   */
>  #define CONFIG_SPL_TARGET              "spl/u-boot-spl-dtb.hex"
> -#define CONFIG_SPL_STACK               (CONFIG_SYS_INIT_RAM_ADDR  \
> -                                       + CONFIG_SYS_INIT_RAM_SIZE \
> -                                       - SOC64_HANDOFF_SIZE)
>  #define CONFIG_SPL_BSS_START_ADDR      (PHYS_SDRAM_1 + PHYS_SDRAM_1_SIZE=
 \
>                                         - CONFIG_SPL_BSS_MAX_SIZE)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     (CONFIG_SYS_MALLOC_LEN)
> diff --git a/include/configs/stm32mp15_common.h b/include/configs/stm32mp=
15_common.h
> index ead3b91e67a2..588d4c1f31f1 100644
> --- a/include/configs/stm32mp15_common.h
> +++ b/include/configs/stm32mp15_common.h
> @@ -36,8 +36,6 @@
>
>  /* Restrict SPL to fit within SYSRAM */
>  #define STM32_SYSRAM_END               (STM32_SYSRAM_BASE + STM32_SYSRAM=
_SIZE)
> -#define CONFIG_SPL_STACK               (STM32_SYSRAM_BASE + \
> -                                        STM32_SYSRAM_SIZE)
>  #endif /* #ifdef CONFIG_SPL */
>  /*MMC SD*/
>  #define CONFIG_SYS_MMC_MAX_DEVICE      3
> diff --git a/include/configs/stout.h b/include/configs/stout.h
> index 4f7fc23dd2d8..f49e88cb17cb 100644
> --- a/include/configs/stout.h
> +++ b/include/configs/stout.h
> @@ -42,6 +42,5 @@
>         "bootm_size=3D0x10000000\0"
>
>  /* SPL support */
> -#define CONFIG_SPL_STACK               0xe6340000
>
>  #endif /* __STOUT_H */
> diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-commo=
n.h
> index 35a2a41d2281..3431366bcda3 100644
> --- a/include/configs/sunxi-common.h
> +++ b/include/configs/sunxi-common.h
> @@ -125,8 +125,6 @@
>  #define LOW_LEVEL_SRAM_STACK           0x00008000      /* End of sram */
>  #endif
>
> -#define CONFIG_SPL_STACK               LOW_LEVEL_SRAM_STACK
> -
>  /* Ethernet support */
>
>  #ifdef CONFIG_USB_EHCI_HCD
> diff --git a/include/configs/taurus.h b/include/configs/taurus.h
> index 238074bff4c9..d7dba72db4c2 100644
> --- a/include/configs/taurus.h
> +++ b/include/configs/taurus.h
> @@ -142,7 +142,6 @@
>  #endif /* #ifndef CONFIG_SPL_BUILD */
>
>  /* Defines for SPL */
> -#define        CONFIG_SPL_STACK                (ATMEL_BASE_SRAM1 + SZ_16=
K)
>  #define CONFIG_SYS_SPL_MALLOC_START     (CONFIG_SYS_TEXT_BASE - \
>                                         CONFIG_SYS_MALLOC_LEN)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE      CONFIG_SYS_MALLOC_LEN
> diff --git a/include/configs/tegra114-common.h b/include/configs/tegra114=
-common.h
> index 09737211803b..fae00e88fe59 100644
> --- a/include/configs/tegra114-common.h
> +++ b/include/configs/tegra114-common.h
> @@ -55,7 +55,6 @@
>
>  /* Defines for SPL */
>  #define CONFIG_SYS_SPL_MALLOC_START    0x80090000
> -#define CONFIG_SPL_STACK               0x800ffffc
>
>  /* For USB EHCI controller */
>  #define CONFIG_USB_EHCI_TXFIFO_THRESH  0x10
> diff --git a/include/configs/tegra124-common.h b/include/configs/tegra124=
-common.h
> index df688dabd1ab..05f6bf0b471b 100644
> --- a/include/configs/tegra124-common.h
> +++ b/include/configs/tegra124-common.h
> @@ -57,7 +57,6 @@
>
>  /* Defines for SPL */
>  #define CONFIG_SYS_SPL_MALLOC_START    0x80090000
> -#define CONFIG_SPL_STACK               0x800ffffc
>
>  /* For USB EHCI controller */
>  #define CONFIG_USB_EHCI_TXFIFO_THRESH  0x10
> diff --git a/include/configs/tegra20-common.h b/include/configs/tegra20-c=
ommon.h
> index fac869272857..97c1f5a2453d 100644
> --- a/include/configs/tegra20-common.h
> +++ b/include/configs/tegra20-common.h
> @@ -56,7 +56,6 @@
>
>  /* Defines for SPL */
>  #define CONFIG_SYS_SPL_MALLOC_START    0x00090000
> -#define CONFIG_SPL_STACK               0x000ffffc
>
>  /* Align LCD to 1MB boundary */
>  #define CONFIG_LCD_ALIGNMENT   MMU_SECTION_SIZE
> diff --git a/include/configs/tegra30-common.h b/include/configs/tegra30-c=
ommon.h
> index b878b1a9e699..7107c06b9a7f 100644
> --- a/include/configs/tegra30-common.h
> +++ b/include/configs/tegra30-common.h
> @@ -52,7 +52,6 @@
>
>  /* Defines for SPL */
>  #define CONFIG_SYS_SPL_MALLOC_START    0x80090000
> -#define CONFIG_SPL_STACK               0x800ffffc
>
>  /* For USB EHCI controller */
>  #define CONFIG_USB_EHCI_TXFIFO_THRESH  0x10
> diff --git a/include/configs/theadorable.h b/include/configs/theadorable.=
h
> index 626261d0742f..e5e21ef3bbc9 100644
> --- a/include/configs/theadorable.h
> +++ b/include/configs/theadorable.h
> @@ -76,8 +76,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + (128 << 10))
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  /* Enable DDR support in SPL (DDR3 training from Marvell bin_hdr) */
>  #define CONFIG_SYS_SDRAM_SIZE          SZ_2G
>
> diff --git a/include/configs/ti_armv7_keystone2.h b/include/configs/ti_ar=
mv7_keystone2.h
> index b804bf3a716b..1cc593fdea29 100644
> --- a/include/configs/ti_armv7_keystone2.h
> +++ b/include/configs/ti_armv7_keystone2.h
> @@ -31,10 +31,6 @@
>                                         CONFIG_SPL_BSS_MAX_SIZE)
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     (32 * 1024)
>  #define KEYSTONE_SPL_STACK_SIZE                (8 * 1024)
> -#define CONFIG_SPL_STACK               (CONFIG_SYS_SPL_MALLOC_START + \
> -                                       CONFIG_SYS_SPL_MALLOC_SIZE + \
> -                                       SPL_MALLOC_F_SIZE + \
> -                                       KEYSTONE_SPL_STACK_SIZE - 4)
>
>  /* SRAM scratch space entries  */
>  #define SRAM_SCRATCH_SPACE_ADDR                0xc0c23fc
> diff --git a/include/configs/turris_omnia.h b/include/configs/turris_omni=
a.h
> index 089828fa3d18..4dc27a31a4e5 100644
> --- a/include/configs/turris_omnia.h
> +++ b/include/configs/turris_omnia.h
> @@ -31,8 +31,6 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + CONFIG_SPL_SIZE)
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  #ifdef CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC
>  /* SPL related MMC defines */
>  # ifdef CONFIG_SPL_BUILD
> diff --git a/include/configs/uniphier.h b/include/configs/uniphier.h
> index f5e096f38da5..6493569888d2 100644
> --- a/include/configs/uniphier.h
> +++ b/include/configs/uniphier.h
> @@ -174,7 +174,6 @@
>  #define CONFIG_SYS_BOOTMAPSZ                   0x20000000
>
>  /* only for SPL */
> -#define CONFIG_SPL_STACK               (0x00100000)
>
>  /* subtract sizeof(struct image_header) */
>  #define CONFIG_SYS_UBOOT_BASE                  (0x130000 - 0x40)
> diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx=
8mm.h
> index ef7ef022ce19..de796917820f 100644
> --- a/include/configs/verdin-imx8mm.h
> +++ b/include/configs/verdin-imx8mm.h
> @@ -16,7 +16,6 @@
>  #define CONFIG_SYS_BOOTM_LEN           SZ_64M
>
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_STACK               0x920000
>  #define CONFIG_SPL_BSS_START_ADDR      0x910000
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K /* 512 KB */
> diff --git a/include/configs/verdin-imx8mp.h b/include/configs/verdin-imx=
8mp.h
> index daff4ccadfc6..e6eb986466cb 100644
> --- a/include/configs/verdin-imx8mp.h
> +++ b/include/configs/verdin-imx8mp.h
> @@ -15,7 +15,6 @@
>
>  #ifdef CONFIG_SPL_BUILD
>  /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
> -#define CONFIG_SPL_STACK               0x960000
>  #define CONFIG_SPL_BSS_START_ADDR      0x0098fc00
>  #define CONFIG_SYS_SPL_MALLOC_START    0x42200000
>  #define CONFIG_SYS_SPL_MALLOC_SIZE     SZ_512K
> diff --git a/include/configs/work_92105.h b/include/configs/work_92105.h
> index 4df58c77bebb..8d1eee2fcac8 100644
> --- a/include/configs/work_92105.h
> +++ b/include/configs/work_92105.h
> @@ -60,7 +60,6 @@
>
>  /* SPL will be executed at offset 0 */
>  /* SPL will use SRAM as stack */
> -#define CONFIG_SPL_STACK     0x0000FFF8
>  /* Use the framework and generic lib */
>  /* SPL will use serial */
>  /* SPL will load U-Boot from NAND offset 0x40000 */
> diff --git a/include/configs/x530.h b/include/configs/x530.h
> index 601a7ee7d4f2..8b690cd9bf40 100644
> --- a/include/configs/x530.h
> +++ b/include/configs/x530.h
> @@ -71,6 +71,4 @@
>
>  #define CONFIG_SPL_BSS_START_ADDR      (0x40000000 + CONFIG_SPL_SIZE)
>
> -#define CONFIG_SPL_STACK               (0x40000000 + ((192 - 16) << 10))
> -
>  #endif /* _CONFIG_X530_H */
> diff --git a/include/configs/xea.h b/include/configs/xea.h
> index 01942eaf2ba5..07419f0afbbc 100644
> --- a/include/configs/xea.h
> +++ b/include/configs/xea.h
> @@ -15,7 +15,6 @@
>  #include <linux/sizes.h>
>
>  /* SPL */
> -#define CONFIG_SPL_STACK               0x20000
>
>  #define CONFIG_SYS_SPL_ARGS_ADDR       0x44000000
>
> diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zyn=
qmp.h
> index 725f3d29034f..9645f9cacbb4 100644
> --- a/include/configs/xilinx_zynqmp.h
> +++ b/include/configs/xilinx_zynqmp.h
> @@ -199,8 +199,6 @@
>         "dfu_bufsiz=3D0x1000\0"
>  #endif
>
> -#define CONFIG_SPL_STACK               0xfffffffc
> -
>  /* Just random location in OCM */
>  #define CONFIG_SPL_BSS_START_ADDR      0x0
>
> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.=
h
> index 440e80c38034..a0e276bcc417 100644
> --- a/include/configs/zynq-common.h
> +++ b/include/configs/zynq-common.h
> @@ -237,7 +237,6 @@
>   * 0xfffffe00 is used for putting wfi loop.
>   * Set it up as limit for now.
>   */
> -#define CONFIG_SPL_STACK       0xfffffe00
>
>  /* BSS setup */
>  #define CONFIG_SPL_BSS_START_ADDR      0x100000
> --
> 2.25.1
>
