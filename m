Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9244CF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0101488E84;
	Thu,  3 Oct 2024 17:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WPOzdfhH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C09CA88EE0; Thu,  3 Oct 2024 17:24:17 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53FB388E19
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cc846fbc4so904144f8f.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727969052; x=1728573852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GosR7VMpkoVByMXOpu4LiNAj/1DQy5mnx904UmnIiPg=;
 b=WPOzdfhHJvAwQfiKSQGxwcmih9MXqaQAdekuRb0MOpwR6uKoRIGw7qQ8c/XsuiTV5K
 crDT+5ITwlOhgrFK4Og97QanFgd79SaZX/KZMnJhhqpfcIzRIU14VsgDVvF9ruVGZ2PU
 6FLV561qYR2WnSMUg1sBscDJBAWr+HmdI27i6CdGse2fKOcnngvLRuulgirBtZuNRkSm
 T8HCbhiglSJW1AWR1LvtZK/14CYvcoS0+4H1wCWYq8Y6Xay1OfF7omOkKmaJd6FWdIvD
 zMs7DQU+cIzpy++n6ZzIQvRBRNjAQykQ+jqvimjwIKyHn9b22NDETqhZF/D1GcH0zkbA
 w2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727969052; x=1728573852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GosR7VMpkoVByMXOpu4LiNAj/1DQy5mnx904UmnIiPg=;
 b=gbeyd59k+lxCiZMAPsjGOUZ/GI9O1QkJTjaKP4DT7NLKpsiZHpGve69wFH/dPniqNg
 t77/eQ3a+v7jua7Y73Z50WZMSlCTjOAknGx1seCu7PKSxs9aVmbWBXE+9Ww39Hr1Jfgn
 0hgjs89TeCVoMuE+HztTQ36P45VxMn6rQGqkb4hMr7jEbRc6Vzpv19hj8fVE+INtDtaW
 wVW2S3iDjmSNTw5hlMc0WPvrTV2yLtmIg9k0dZ/yA/3giT4PBJxqiZOSZ6shxZZyIunP
 N0KmagJD95xYHkp4pITHujU73um/8XVNbQznfgAzkmLmguHLl5pXyY3LKdtuVwLuAl2g
 1Mvw==
X-Gm-Message-State: AOJu0Yx3Rdc7ZZ6/beaiy0k0gbOPvStLTN+s/uVHZJxf4ss9eBHH+pV3
 PYB1GeKPk5bida3racp57jAVdINZvZO5V6kKHFj1VMyPrvjRBTKrs4gZSiLCtAINoZ1b0622PY9
 T9XY1Waan
X-Google-Smtp-Source: AGHT+IEYj6infb46yNMmFVPqmaCfxU85O7Z1Rsc7RNYRBVNVqkcc0WR2qNGS0frzdmSsXuW7U9J5bw==
X-Received: by 2002:adf:ffc2:0:b0:37c:cc96:d1cd with SMTP id
 ffacd0b85a97d-37cfb9d3364mr4432158f8f.34.1727969051543; 
 Thu, 03 Oct 2024 08:24:11 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm1506220f8f.8.2024.10.03.08.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:24:09 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Felix Brack <fb@ltec.ch>,
 Icenowy Zheng <icenowy@aosc.xyz>, Tom Rini <trini@konsulko.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Chris Morgan <macromorgan@hotmail.com>, Wills Wang <wills.wang@live.com>,
 Rosy Song <rosysong@rosinson.com>, Mark Kettenis <kettenis@openbsd.org>,
 Wolfgang Wegner <w.wegner@astro-kom.de>, Stelian Pop <stelian@popies.net>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 liuhao <liuhao@phytium.com.cn>, shuyiqi <shuyiqi@phytium.com.cn>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Trevor Woerner <twoerner@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Brodkin <abrodkin@synopsys.com>, Andy Yan <andy.yan@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Yang Xiwen <firbidden405@outlook.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 David Lechner <david@lechnology.com>, Johan Jonker <jbx6244@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 Otavio Salvador <otavio@ossystems.com.br>, Eric Nelson <eric@nelint.com>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
 Tianrui Wei <tianrui-wei@outlook.com>, Minkyu Kang <mk7.kang@samsung.com>,
 lixinde <lixinde@phytium.com.cn>,
 weichangzheng <weichangzheng@phytium.com.cn>,
 Ilko Iliev <iliev@ronetix.at>, Stefan Bosch <stefan_b@posteo.net>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Greg Gallagher <greg@embeddedgreg.com>,
 Mihai Sain <mihai.sain@microchip.com>, Sean Anderson <seanga2@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Sergey Temerkhanov <s.temerkhanov@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, Usama Arif <usama.arif@arm.com>,
 Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Martyn Welch <martyn.welch@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Andrew Davis <afd@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Hector Martin <marcan@marcan.st>,
 Sumit Garg <sumit.garg@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>,
 TracyMg_Li <TracyMg_Li@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrii Chepurnyi <Andrii_Chepurnyi@epam.com>
Subject: [PATCH v11 08/29] configs: replace '# CONFIG_NET is not set' with
 CONFIG_NO_NET=y
Date: Thu,  3 Oct 2024 17:22:54 +0200
Message-Id: <e8c3893de8e918e1174078d578aae88dcc402552.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Oct 2024 17:25:39 +0200
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

The parent patch has made the networking stack a choice between NO_NET,
NET and NET_LWIP. Therefore '# CONFIG_NET is not set' is now
'CONFIG_NO_NET=y'. Adjust the defconfigs accordingly. Note that this
patch is intended to be folded in but is kept separate separate for now
to make review easier.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Tested-by: Felix Brack <fb@ltec.ch>
---
 configs/LicheePi_Zero_defconfig                  | 2 +-
 configs/M5249EVB_defconfig                       | 2 +-
 configs/am335x_pdu001_defconfig                  | 2 +-
 configs/am62ax_evm_r5_defconfig                  | 2 +-
 configs/am62px_evm_r5_defconfig                  | 2 +-
 configs/am62x_beagleplay_r5_defconfig            | 2 +-
 configs/amcore_defconfig                         | 2 +-
 configs/amd_versal2_mini_defconfig               | 2 +-
 configs/amd_versal2_mini_emmc_defconfig          | 2 +-
 configs/amd_versal2_mini_ospi_defconfig          | 2 +-
 configs/amd_versal2_mini_qspi_defconfig          | 2 +-
 configs/anbernic-rgxx3-rk3566_defconfig          | 2 +-
 configs/ap143_defconfig                          | 2 +-
 configs/ap152_defconfig                          | 2 +-
 configs/apple_m1_defconfig                       | 2 +-
 configs/astro_mcf5373l_defconfig                 | 2 +-
 configs/at91sam9rlek_dataflash_defconfig         | 2 +-
 configs/at91sam9rlek_mmc_defconfig               | 2 +-
 configs/at91sam9rlek_nandflash_defconfig         | 2 +-
 configs/bcm7260_defconfig                        | 2 +-
 configs/bcm7445_defconfig                        | 2 +-
 configs/bcm968380gerg_ram_defconfig              | 2 +-
 configs/bcmns_defconfig                          | 2 +-
 configs/chromebook_samus_tpl_defconfig           | 2 +-
 configs/cortina_presidio-asic-base_defconfig     | 2 +-
 configs/cortina_presidio-asic-pnand_defconfig    | 2 +-
 configs/durian_defconfig                         | 2 +-
 configs/e850-96_defconfig                        | 2 +-
 configs/ea-lpc3250devkitv2_defconfig             | 2 +-
 configs/efi-x86_app32_defconfig                  | 2 +-
 configs/efi-x86_app64_defconfig                  | 2 +-
 configs/emsdp_defconfig                          | 2 +-
 configs/evb-px5_defconfig                        | 2 +-
 configs/generic-rk3568_defconfig                 | 2 +-
 configs/generic-rk3588_defconfig                 | 2 +-
 configs/hc2910_2aghd05_defconfig                 | 2 +-
 configs/igep00x0_defconfig                       | 2 +-
 configs/imx6q_bosch_acc_defconfig                | 2 +-
 configs/imx6ulz_smm_m2_defconfig                 | 2 +-
 configs/iot_devkit_defconfig                     | 2 +-
 configs/j722s_evm_r5_defconfig                   | 2 +-
 configs/legoev3_defconfig                        | 2 +-
 configs/mk808_defconfig                          | 2 +-
 configs/mx23evk_defconfig                        | 2 +-
 configs/mx28evk_defconfig                        | 2 +-
 configs/mx6memcal_defconfig                      | 2 +-
 configs/mx6ulz_14x14_evk_defconfig               | 2 +-
 configs/mx7ulp_com_defconfig                     | 2 +-
 configs/mx7ulp_evk_defconfig                     | 2 +-
 configs/mx7ulp_evk_plugin_defconfig              | 2 +-
 configs/netgear_cg3100d_ram_defconfig            | 2 +-
 configs/nsim_700_defconfig                       | 2 +-
 configs/nsim_700be_defconfig                     | 2 +-
 configs/nsim_hs38be_defconfig                    | 2 +-
 configs/openpiton_riscv64_defconfig              | 2 +-
 configs/openpiton_riscv64_spl_defconfig          | 2 +-
 configs/origen_defconfig                         | 2 +-
 configs/pe2201_defconfig                         | 2 +-
 configs/pinecube_defconfig                       | 2 +-
 configs/pm9261_defconfig                         | 2 +-
 configs/s5p4418_nanopi2_defconfig                | 2 +-
 configs/s5p_goni_defconfig                       | 2 +-
 configs/s5pc210_universal_defconfig              | 2 +-
 configs/sama5d27_giantboard_defconfig            | 2 +-
 configs/sama5d29_curiosity_mmc1_defconfig        | 2 +-
 configs/sama5d29_curiosity_mmc_defconfig         | 2 +-
 configs/sama5d29_curiosity_qspiflash_defconfig   | 2 +-
 configs/sama7g54_curiosity_mmc_defconfig         | 2 +-
 configs/sama7g54_curiosity_nandflash_defconfig   | 2 +-
 configs/sama7g54_curiosity_qspiflash_defconfig   | 2 +-
 configs/sipeed_maix_bitm_defconfig               | 2 +-
 configs/sipeed_maix_smode_defconfig              | 2 +-
 configs/stemmy_defconfig                         | 2 +-
 configs/stm32f429-discovery_defconfig            | 2 +-
 configs/stm32f429-evaluation_defconfig           | 2 +-
 configs/stm32f469-discovery_defconfig            | 2 +-
 configs/stm32h743-disco_defconfig                | 2 +-
 configs/stm32h743-eval_defconfig                 | 2 +-
 configs/stm32h750-art-pi_defconfig               | 2 +-
 configs/stm32mp25_defconfig                      | 2 +-
 configs/stmark2_defconfig                        | 2 +-
 configs/th1520_lpi4a_defconfig                   | 2 +-
 configs/thunderx_88xx_defconfig                  | 2 +-
 configs/tools-only_defconfig                     | 2 +-
 configs/topic_miami_defconfig                    | 2 +-
 configs/topic_miamilite_defconfig                | 2 +-
 configs/topic_miamiplus_defconfig                | 2 +-
 configs/total_compute_defconfig                  | 2 +-
 configs/trats2_defconfig                         | 2 +-
 configs/trats_defconfig                          | 2 +-
 configs/xenguest_arm64_defconfig                 | 2 +-
 configs/xenguest_arm64_virtio_defconfig          | 2 +-
 configs/xilinx_versal_mini_defconfig             | 2 +-
 configs/xilinx_versal_mini_emmc0_defconfig       | 2 +-
 configs/xilinx_versal_mini_emmc1_defconfig       | 2 +-
 configs/xilinx_versal_mini_ospi_defconfig        | 2 +-
 configs/xilinx_versal_mini_qspi_defconfig        | 2 +-
 configs/xilinx_versal_net_mini_defconfig         | 2 +-
 configs/xilinx_versal_net_mini_emmc_defconfig    | 2 +-
 configs/xilinx_versal_net_mini_ospi_defconfig    | 2 +-
 configs/xilinx_versal_net_mini_qspi_defconfig    | 2 +-
 configs/xilinx_zynqmp_mini_defconfig             | 2 +-
 configs/xilinx_zynqmp_mini_emmc0_defconfig       | 2 +-
 configs/xilinx_zynqmp_mini_emmc1_defconfig       | 2 +-
 configs/xilinx_zynqmp_mini_nand_defconfig        | 2 +-
 configs/xilinx_zynqmp_mini_nand_single_defconfig | 2 +-
 configs/xilinx_zynqmp_mini_qspi_defconfig        | 2 +-
 configs/zynq_cse_nand_defconfig                  | 2 +-
 configs/zynq_cse_nor_defconfig                   | 2 +-
 configs/zynq_cse_qspi_defconfig                  | 2 +-
 110 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defconfig
index 009384eaf1b..c37c49ccbb1 100644
--- a/configs/LicheePi_Zero_defconfig
+++ b/configs/LicheePi_Zero_defconfig
@@ -5,4 +5,4 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_V3S=y
 CONFIG_DRAM_CLK=360
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
diff --git a/configs/M5249EVB_defconfig b/configs/M5249EVB_defconfig
index eac85b9c2d5..ed1446d81cb 100644
--- a/configs/M5249EVB_defconfig
+++ b/configs/M5249EVB_defconfig
@@ -22,7 +22,7 @@ CONFIG_CMD_MX_CYCLIC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/configs/am335x_pdu001_defconfig b/configs/am335x_pdu001_defconfig
index d9acc81e9d3..a8e901b40f9 100644
--- a/configs/am335x_pdu001_defconfig
+++ b/configs/am335x_pdu001_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_OF_TRANSLATE=y
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 092d0830623..6b926f47507 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -68,7 +68,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index 4f7be44cfba..11a00dbfc04 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -72,7 +72,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index ee4c43ff97f..e32ec42111c 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -69,7 +69,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/amcore_defconfig b/configs/amcore_defconfig
index f1f5201b30a..94c5379590d 100644
--- a/configs/amcore_defconfig
+++ b/configs/amcore_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_DIAG=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="AMCORE"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index 0dd2305bfb2..684205d25a3 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index 7ad44386a6d..8484f182b93 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 2242960392f..d064165d79b 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index 3360c1546a2..e48c26243b8 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index a03509bf467..937c27a947e 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/ap143_defconfig b/configs/ap143_defconfig
index c22048c1b53..13842e6c0f8 100644
--- a/configs/ap143_defconfig
+++ b/configs/ap143_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:256k(u-boot),64k(u-boot-env),6336k
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=25000000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/configs/ap152_defconfig b/configs/ap152_defconfig
index ec700a5b3f0..5cc0ad2e682 100644
--- a/configs/ap152_defconfig
+++ b/configs/ap152_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:256k(u-boot),64k(u-boot-env),6336k
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=25000000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_BAR=y
diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index dca6e0ca8ba..d491a5d03c5 100644
--- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -11,7 +11,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_CMD_SELECT_FONT=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_APPLE_SPI_KEYB=y
 # CONFIG_MMC is not set
diff --git a/configs/astro_mcf5373l_defconfig b/configs/astro_mcf5373l_defconfig
index d1942c28971..8dd369d68a1 100644
--- a/configs/astro_mcf5373l_defconfig
+++ b/configs/astro_mcf5373l_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_I2C=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_JFFS2=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_FPGA_ALTERA=y
 CONFIG_FPGA_CYCLON2=y
 CONFIG_FPGA_XILINX=y
diff --git a/configs/at91sam9rlek_dataflash_defconfig b/configs/at91sam9rlek_dataflash_defconfig
index 931af2b2fda..01ac2cc8d1e 100644
--- a/configs/at91sam9rlek_dataflash_defconfig
+++ b/configs/at91sam9rlek_dataflash_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9rlek_mmc_defconfig b/configs/at91sam9rlek_mmc_defconfig
index 70d431c1f52..93f7d762109 100644
--- a/configs/at91sam9rlek_mmc_defconfig
+++ b/configs/at91sam9rlek_mmc_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9rlek_nandflash_defconfig b/configs/at91sam9rlek_nandflash_defconfig
index 1277a357cd2..928ad9f4f70 100644
--- a/configs/at91sam9rlek_nandflash_defconfig
+++ b/configs/at91sam9rlek_nandflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/bcm7260_defconfig b/configs/bcm7260_defconfig
index 2bf3c0d7fbe..345e37bca7e 100644
--- a/configs/bcm7260_defconfig
+++ b/configs/bcm7260_defconfig
@@ -35,7 +35,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_BCMSTB=y
 CONFIG_MTD=y
diff --git a/configs/bcm7445_defconfig b/configs/bcm7445_defconfig
index 07e3b57ac33..eb6629ba57a 100644
--- a/configs/bcm7445_defconfig
+++ b/configs/bcm7445_defconfig
@@ -37,7 +37,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_BCMSTB=y
 CONFIG_MTD=y
diff --git a/configs/bcm968380gerg_ram_defconfig b/configs/bcm968380gerg_ram_defconfig
index 6c119eb42a6..053c459e05c 100644
--- a/configs/bcm968380gerg_ram_defconfig
+++ b/configs/bcm968380gerg_ram_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_NAND=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_BCM6345_GPIO=y
 CONFIG_LED=y
diff --git a/configs/bcmns_defconfig b/configs/bcmns_defconfig
index 365284e94c3..f2719821656 100644
--- a/configs/bcmns_defconfig
+++ b/configs/bcmns_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="NS"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index 1be57560f89..075e3f192a3 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -74,7 +74,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_ACPIGEN is not set
diff --git a/configs/cortina_presidio-asic-base_defconfig b/configs/cortina_presidio-asic-base_defconfig
index eb5743da64d..78167d56d83 100644
--- a/configs/cortina_presidio-asic-base_defconfig
+++ b/configs/cortina_presidio-asic-base_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CORTINA_GPIO=y
 # CONFIG_MMC is not set
 CONFIG_DM_SERIAL=y
diff --git a/configs/cortina_presidio-asic-pnand_defconfig b/configs/cortina_presidio-asic-pnand_defconfig
index c7367d4d91c..f1526227d65 100644
--- a/configs/cortina_presidio-asic-pnand_defconfig
+++ b/configs/cortina_presidio-asic-pnand_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CORTINA_GPIO=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/durian_defconfig b/configs/durian_defconfig
index f1d45ca3064..ae7a05edee1 100644
--- a/configs/durian_defconfig
+++ b/configs/durian_defconfig
@@ -28,7 +28,7 @@ CONFIG_SYS_PROMPT="durian#"
 CONFIG_CMD_PCI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 # CONFIG_MMC is not set
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index e5d90996234..5797c6cb1f9 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -20,7 +20,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK_EXYNOS850=y
 CONFIG_MMC_DW=y
 CONFIG_SOC_SAMSUNG=y
diff --git a/configs/ea-lpc3250devkitv2_defconfig b/configs/ea-lpc3250devkitv2_defconfig
index af9fc5f2f5c..c3af7afced1 100644
--- a/configs/ea-lpc3250devkitv2_defconfig
+++ b/configs/ea-lpc3250devkitv2_defconfig
@@ -25,7 +25,7 @@ CONFIG_SYS_PROMPT="EA-LPC3250v2=> "
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_OF_CONTROL=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_LPC32XX_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_LPC32XX=y
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index 53ec63461d5..c2856b4000f 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -35,7 +35,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_GZIP is not set
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 3d021483dd0..0b709cf4dad 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -38,7 +38,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CONSOLE_SCROLL_LINES=5
diff --git a/configs/emsdp_defconfig b/configs/emsdp_defconfig
index 07bed2b5623..26efa794058 100644
--- a/configs/emsdp_defconfig
+++ b/configs/emsdp_defconfig
@@ -30,7 +30,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="app.bin"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_SNPS=y
diff --git a/configs/evb-px5_defconfig b/configs/evb-px5_defconfig
index ccd38831533..8efab0c2fc0 100644
--- a/configs/evb-px5_defconfig
+++ b/configs/evb-px5_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_TPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 66a33afbbaf..383dad3087b 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -40,7 +40,7 @@ CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 42bc2c9a765..3c81401968d 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -35,7 +35,7 @@ CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/hc2910_2aghd05_defconfig b/configs/hc2910_2aghd05_defconfig
index e68b44478a9..4302436d2e6 100644
--- a/configs/hc2910_2aghd05_defconfig
+++ b/configs/hc2910_2aghd05_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index f1d9bb34aba..51c825d3fbe 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -60,7 +60,7 @@ CONFIG_ENV_UBI_VOLUME="config"
 CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index dce1b64bf69..3fca5d5139d 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -81,7 +81,7 @@ CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 93ead4c373b..c2adff17abf 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
diff --git a/configs/iot_devkit_defconfig b/configs/iot_devkit_defconfig
index c4920052f82..3dda897f765 100644
--- a/configs/iot_devkit_defconfig
+++ b/configs/iot_devkit_defconfig
@@ -34,7 +34,7 @@ CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="app.bin"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_SNPS=y
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index e574be9e19d..fd3259f6afb 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -72,7 +72,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/legoev3_defconfig b/configs/legoev3_defconfig
index 34ef3493cac..60b7a84205c 100644
--- a/configs/legoev3_defconfig
+++ b/configs/legoev3_defconfig
@@ -44,7 +44,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DAVINCI=y
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index 9a342d3a33a..36ab4b03401 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_TPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/mx23evk_defconfig b/configs/mx23evk_defconfig
index 7d0e7cc1e00..59ab64ec97a 100644
--- a/configs/mx23evk_defconfig
+++ b/configs/mx23evk_defconfig
@@ -41,7 +41,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MXS_GPIO=y
 CONFIG_MMC_MXS=y
 CONFIG_PINCTRL=y
diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
index dddb57efd3e..1295ff80c7b 100644
--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -47,7 +47,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_MXS_GPIO=y
 CONFIG_MMC_MXS=y
diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
index 4c8a5960d38..5cc8236feb9 100644
--- a/configs/mx6memcal_defconfig
+++ b/configs/mx6memcal_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 # CONFIG_MMC is not set
 CONFIG_FSL_USDHC=y
diff --git a/configs/mx6ulz_14x14_evk_defconfig b/configs/mx6ulz_14x14_evk_defconfig
index d57b47ef47a..2c13dd4dbc3 100644
--- a/configs/mx6ulz_14x14_evk_defconfig
+++ b/configs/mx6ulz_14x14_evk_defconfig
@@ -36,7 +36,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_74X164=y
 CONFIG_DM_I2C=y
diff --git a/configs/mx7ulp_com_defconfig b/configs/mx7ulp_com_defconfig
index f8dcc0abef5..6ea84c053ca 100644
--- a/configs/mx7ulp_com_defconfig
+++ b/configs/mx7ulp_com_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_IMX_RGPIO2P=y
 # CONFIG_MXC_GPIO is not set
diff --git a/configs/mx7ulp_evk_defconfig b/configs/mx7ulp_evk_defconfig
index 38e6b62df45..5aadb9e93f1 100644
--- a/configs/mx7ulp_evk_defconfig
+++ b/configs/mx7ulp_evk_defconfig
@@ -33,7 +33,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_IMX_RGPIO2P=y
 # CONFIG_MXC_GPIO is not set
diff --git a/configs/mx7ulp_evk_plugin_defconfig b/configs/mx7ulp_evk_plugin_defconfig
index d007d180969..2f45fac0a89 100644
--- a/configs/mx7ulp_evk_plugin_defconfig
+++ b/configs/mx7ulp_evk_plugin_defconfig
@@ -31,7 +31,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_IMX_RGPIO2P=y
 # CONFIG_MXC_GPIO is not set
diff --git a/configs/netgear_cg3100d_ram_defconfig b/configs/netgear_cg3100d_ram_defconfig
index 352b98fc0a5..377cc26f937 100644
--- a/configs/netgear_cg3100d_ram_defconfig
+++ b/configs/netgear_cg3100d_ram_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_SPI=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_BCM6345_GPIO=y
 CONFIG_LED=y
diff --git a/configs/nsim_700_defconfig b/configs/nsim_700_defconfig
index be2539e8cd7..e8400c2dc30 100644
--- a/configs/nsim_700_defconfig
+++ b/configs/nsim_700_defconfig
@@ -25,7 +25,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
diff --git a/configs/nsim_700be_defconfig b/configs/nsim_700be_defconfig
index 1fcf36a28a5..9ce1a255227 100644
--- a/configs/nsim_700be_defconfig
+++ b/configs/nsim_700be_defconfig
@@ -26,7 +26,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
diff --git a/configs/nsim_hs38be_defconfig b/configs/nsim_hs38be_defconfig
index 9c26e4da7d2..80d0e54192d 100644
--- a/configs/nsim_hs38be_defconfig
+++ b/configs/nsim_hs38be_defconfig
@@ -27,7 +27,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
diff --git a/configs/openpiton_riscv64_defconfig b/configs/openpiton_riscv64_defconfig
index cdb9e1c932e..9df92e5c318 100644
--- a/configs/openpiton_riscv64_defconfig
+++ b/configs/openpiton_riscv64_defconfig
@@ -61,7 +61,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_OF_EMBED=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CPU=y
 CONFIG_MMC=y
 # CONFIG_MMC_WRITE is not set
diff --git a/configs/openpiton_riscv64_spl_defconfig b/configs/openpiton_riscv64_spl_defconfig
index a08040d878d..29304cc50fe 100644
--- a/configs/openpiton_riscv64_spl_defconfig
+++ b/configs/openpiton_riscv64_spl_defconfig
@@ -77,7 +77,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_DOS_PARTITION is not set
 # CONFIG_SPL_PARTITION_UUIDS is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CPU=y
 CONFIG_MMC=y
 # CONFIG_MMC_WRITE is not set
diff --git a/configs/origen_defconfig b/configs/origen_defconfig
index dc9285d4e99..26702d77079 100644
--- a/configs/origen_defconfig
+++ b/configs/origen_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_MMC_DW=y
diff --git a/configs/pe2201_defconfig b/configs/pe2201_defconfig
index 5d32cbf8bf1..91fe7ebf982 100644
--- a/configs/pe2201_defconfig
+++ b/configs/pe2201_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_DM=y
 CONFIG_CMD_PCI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 # CONFIG_MMC is not set
diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index 7cc0a862949..7567a6aa739 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -9,7 +9,7 @@ CONFIG_DRAM_ODT_EN=y
 CONFIG_I2C0_ENABLE=y
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_SPL_I2C=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
diff --git a/configs/pm9261_defconfig b/configs/pm9261_defconfig
index 9f4d434f3e2..026c6de3109 100644
--- a/configs/pm9261_defconfig
+++ b/configs/pm9261_defconfig
@@ -37,7 +37,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=physmap-flash.0:256k(u-boot)ro,64k(u-boot-env)
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/s5p4418_nanopi2_defconfig b/configs/s5p4418_nanopi2_defconfig
index ee72778995b..0bee0008294 100644
--- a/configs/s5p4418_nanopi2_defconfig
+++ b/configs/s5p4418_nanopi2_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_FAT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_MMC_ENV_DEV=2
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_NEXELL=y
 CONFIG_MMC_DW=y
diff --git a/configs/s5p_goni_defconfig b/configs/s5p_goni_defconfig
index 4316510541c..084e19e1258 100644
--- a/configs/s5p_goni_defconfig
+++ b/configs/s5p_goni_defconfig
@@ -44,7 +44,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_DM_I2C_GPIO=y
diff --git a/configs/s5pc210_universal_defconfig b/configs/s5pc210_universal_defconfig
index 67959ad79cd..99e873ff427 100644
--- a/configs/s5pc210_universal_defconfig
+++ b/configs/s5pc210_universal_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_SYS_I2C_S3C24X0=y
diff --git a/configs/sama5d27_giantboard_defconfig b/configs/sama5d27_giantboard_defconfig
index 283c9300c56..34274ca4a32 100644
--- a/configs/sama5d27_giantboard_defconfig
+++ b/configs/sama5d27_giantboard_defconfig
@@ -64,7 +64,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d29_curiosity_mmc1_defconfig b/configs/sama5d29_curiosity_mmc1_defconfig
index 61edb23b196..5d9173a0e57 100644
--- a/configs/sama5d29_curiosity_mmc1_defconfig
+++ b/configs/sama5d29_curiosity_mmc1_defconfig
@@ -70,7 +70,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA5D29"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_UTMI=y
diff --git a/configs/sama5d29_curiosity_mmc_defconfig b/configs/sama5d29_curiosity_mmc_defconfig
index 0b16f386735..2b765f56dda 100644
--- a/configs/sama5d29_curiosity_mmc_defconfig
+++ b/configs/sama5d29_curiosity_mmc_defconfig
@@ -69,7 +69,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA5D29"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_UTMI=y
diff --git a/configs/sama5d29_curiosity_qspiflash_defconfig b/configs/sama5d29_curiosity_qspiflash_defconfig
index 9b522e81ef5..d840d0f3d6f 100644
--- a/configs/sama5d29_curiosity_qspiflash_defconfig
+++ b/configs/sama5d29_curiosity_qspiflash_defconfig
@@ -69,7 +69,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA5D29"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_UTMI=y
diff --git a/configs/sama7g54_curiosity_mmc_defconfig b/configs/sama7g54_curiosity_mmc_defconfig
index 00a091df0e5..ba8643c912c 100644
--- a/configs/sama7g54_curiosity_mmc_defconfig
+++ b/configs/sama7g54_curiosity_mmc_defconfig
@@ -74,7 +74,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA7G54"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sama7g54_curiosity_nandflash_defconfig b/configs/sama7g54_curiosity_nandflash_defconfig
index 0b2116d0419..49b08d3fc2b 100644
--- a/configs/sama7g54_curiosity_nandflash_defconfig
+++ b/configs/sama7g54_curiosity_nandflash_defconfig
@@ -72,7 +72,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA7G54"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sama7g54_curiosity_qspiflash_defconfig b/configs/sama7g54_curiosity_qspiflash_defconfig
index 00e5362a1fa..8fa5857e245 100644
--- a/configs/sama7g54_curiosity_qspiflash_defconfig
+++ b/configs/sama7g54_curiosity_qspiflash_defconfig
@@ -73,7 +73,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA7G54"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sipeed_maix_bitm_defconfig b/configs/sipeed_maix_bitm_defconfig
index 67d5a007a8e..8788eabf55a 100644
--- a/configs/sipeed_maix_bitm_defconfig
+++ b/configs/sipeed_maix_bitm_defconfig
@@ -17,7 +17,7 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_HUSH_PARSER=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi3:0"
 CONFIG_MTDPARTS_DEFAULT="nor0:1M(u-boot),0x1000@0xfff000(env)"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK_K210_SET_RATE=y
 # CONFIG_INPUT is not set
 CONFIG_SF_DEFAULT_BUS=3
diff --git a/configs/sipeed_maix_smode_defconfig b/configs/sipeed_maix_smode_defconfig
index 049fac02cac..c8d8b1ac9e1 100644
--- a/configs/sipeed_maix_smode_defconfig
+++ b/configs/sipeed_maix_smode_defconfig
@@ -18,7 +18,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_HUSH_PARSER=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi3:0"
 CONFIG_MTDPARTS_DEFAULT="nor0:1M(u-boot),0x1000@0xfff000(env)"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_INPUT is not set
 CONFIG_SF_DEFAULT_BUS=3
 CONFIG_FS_EXT4=y
diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index ee8e6be6e2c..efa3b477a6e 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_GETTIME=y
 CONFIG_EFI_PARTITION=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x18100000
 CONFIG_FASTBOOT_FLASH=y
diff --git a/configs/stm32f429-discovery_defconfig b/configs/stm32f429-discovery_defconfig
index 5d59edb7381..21a466572bd 100644
--- a/configs/stm32f429-discovery_defconfig
+++ b/configs/stm32f429-discovery_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_IMLS=y
 CONFIG_CMD_TIMER=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
diff --git a/configs/stm32f429-evaluation_defconfig b/configs/stm32f429-evaluation_defconfig
index 3e220d73984..8f20d4ca3f5 100644
--- a/configs/stm32f429-evaluation_defconfig
+++ b/configs/stm32f429-evaluation_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_ARM_PL180_MMCI=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-discovery_defconfig
index 9b5f38b9efa..33292bfaf0c 100644
--- a/configs/stm32f469-discovery_defconfig
+++ b/configs/stm32f469-discovery_defconfig
@@ -26,7 +26,7 @@ CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_ARM_PL180_MMCI=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/stm32h743-disco_defconfig b/configs/stm32h743-disco_defconfig
index 89d79e98b6f..f098b8dd6da 100644
--- a/configs/stm32h743-disco_defconfig
+++ b/configs/stm32h743-disco_defconfig
@@ -30,6 +30,6 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_STM32_SDMMC2=y
 # CONFIG_PINCTRL_FULL is not set
diff --git a/configs/stm32h743-eval_defconfig b/configs/stm32h743-eval_defconfig
index 6b4ebd11691..82823e8631f 100644
--- a/configs/stm32h743-eval_defconfig
+++ b/configs/stm32h743-eval_defconfig
@@ -30,6 +30,6 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_STM32_SDMMC2=y
 # CONFIG_PINCTRL_FULL is not set
diff --git a/configs/stm32h750-art-pi_defconfig b/configs/stm32h750-art-pi_defconfig
index 319b3033a40..df3ff43f4a9 100644
--- a/configs/stm32h750-art-pi_defconfig
+++ b/configs/stm32h750-art-pi_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_DMA=y
 CONFIG_STM32_SDMMC2=y
 # CONFIG_PINCTRL_FULL is not set
diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index f5623a19bb2..9533e30db4d 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
diff --git a/configs/stmark2_defconfig b/configs/stmark2_defconfig
index f43a24c5b5e..79b21acd032 100644
--- a/configs/stmark2_defconfig
+++ b/configs/stmark2_defconfig
@@ -39,7 +39,7 @@ CONFIG_ENV_SPI_CS=1
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="stmark2"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
 CONFIG_MTD=y
diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index db80e33870b..9ab228256b0 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -58,7 +58,7 @@ CONFIG_CMD_BOOTMENU=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_BLOCK_CACHE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/thunderx_88xx_defconfig b/configs/thunderx_88xx_defconfig
index b754cc01cc8..107ad279e1b 100644
--- a/configs/thunderx_88xx_defconfig
+++ b/configs/thunderx_88xx_defconfig
@@ -32,7 +32,7 @@ CONFIG_SYS_PROMPT="ThunderX_88XX> "
 # CONFIG_CMD_SAVEENV is not set
 # CONFIG_CMD_ENV_EXISTS is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_MMC is not set
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index b54d2cefa10..e00f2c48598 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -22,7 +22,7 @@ CONFIG_BOOTCOMMAND="run distro_bootcmd"
 # CONFIG_CMD_DATE is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_ACPIGEN is not set
 CONFIG_AXI=y
 CONFIG_AXI_SANDBOX=y
diff --git a/configs/topic_miami_defconfig b/configs/topic_miami_defconfig
index 638d7306146..74b03d19ffb 100644
--- a/configs/topic_miami_defconfig
+++ b/configs/topic_miami_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_RAM=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x600000
diff --git a/configs/topic_miamilite_defconfig b/configs/topic_miamilite_defconfig
index af47fab83c0..46071399a4d 100644
--- a/configs/topic_miamilite_defconfig
+++ b/configs/topic_miamilite_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_RAM=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x600000
diff --git a/configs/topic_miamiplus_defconfig b/configs/topic_miamiplus_defconfig
index ad321749694..5562c738c5e 100644
--- a/configs/topic_miamiplus_defconfig
+++ b/configs/topic_miamiplus_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_RAM=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x600000
diff --git a/configs/total_compute_defconfig b/configs/total_compute_defconfig
index 5f21d2e367a..b3d2e5c88a6 100644
--- a/configs/total_compute_defconfig
+++ b/configs/total_compute_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_AVB=y
 CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 # CONFIG_MMC_WRITE is not set
 CONFIG_ARM_PL180_MMCI=y
diff --git a/configs/trats2_defconfig b/configs/trats2_defconfig
index 67561368128..acfc42842e3 100644
--- a/configs/trats2_defconfig
+++ b/configs/trats2_defconfig
@@ -43,7 +43,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_DM_I2C_GPIO=y
diff --git a/configs/trats_defconfig b/configs/trats_defconfig
index 98925243bf4..070ab268474 100644
--- a/configs/trats_defconfig
+++ b/configs/trats_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_DM_I2C_GPIO=y
diff --git a/configs/xenguest_arm64_defconfig b/configs/xenguest_arm64_defconfig
index 6d040c2c15c..91657e0cd8b 100644
--- a/configs/xenguest_arm64_defconfig
+++ b/configs/xenguest_arm64_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_PVBLOCK=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_MMC is not set
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
 CONFIG_DM_SERIAL=y
diff --git a/configs/xenguest_arm64_virtio_defconfig b/configs/xenguest_arm64_virtio_defconfig
index d00a1ba0143..217b45a2c5e 100644
--- a/configs/xenguest_arm64_virtio_defconfig
+++ b/configs/xenguest_arm64_virtio_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_PARTITION_TYPE_GUID=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_MMC is not set
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index b97bf5e60a9..e9183bc8071 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -57,7 +57,7 @@ CONFIG_SYS_ALT_MEMTEST=y
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_MMC is not set
 CONFIG_ARM_DCC=y
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index 5c949e34442..7ba7e65597a 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index 04cba5bc72d..54cc51ee7f3 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -55,7 +55,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index 8f162597603..5ffb2cd5bfb 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -51,7 +51,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 8fbde1c7d3c..552cbdd740b 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -53,7 +53,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index d6ebd080463..c4b1a5d5416 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -61,7 +61,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
index fc88eee10af..c64ab92533b 100644
--- a/configs/xilinx_versal_net_mini_emmc_defconfig
+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
@@ -50,7 +50,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index 872a4a55952..f1a136fe52c 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -50,7 +50,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index 00319e06102..75589c478d8 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -52,7 +52,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 4b45074efc4..09d73b0617f 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -53,7 +53,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index 49c7235fb8c..0e0242d8aac 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -64,7 +64,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_DM_MAILBOX is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index 1ef89f50444..01297f615b8 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -64,7 +64,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_DM_MAILBOX is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index b4719536be1..fd27f565b03 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -48,7 +48,7 @@ CONFIG_CLOCKS=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index 7ede17654dd..480c00ed152 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -48,7 +48,7 @@ CONFIG_CLOCKS=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index 0d79ecece71..d8830a6f247 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -67,7 +67,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_FIRMWARE is not set
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index 750ea0db2b2..e7414c78d1e 100644
--- a/configs/zynq_cse_nand_defconfig
+++ b/configs/zynq_cse_nand_defconfig
@@ -69,7 +69,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_MMC is not set
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index 3155fe0b378..4f2186b2a51 100644
--- a/configs/zynq_cse_nor_defconfig
+++ b/configs/zynq_cse_nor_defconfig
@@ -69,7 +69,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_MMC is not set
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index f2e1aa6d3ab..a372a13fe2d 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -78,7 +78,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_MMC is not set
-- 
2.40.1

