Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A1EC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F26878BF;
	Mon,  4 Dec 2023 09:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JFM4KKJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F3C878CC; Mon,  4 Dec 2023 09:21:13 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B96B87561
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50bfa5a6cffso524730e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701678068; x=1702282868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVwafFKXIh3FbhC1lJWBgKFPyIn+L4/RH22wj1wt5/o=;
 b=JFM4KKJiLRiTTLJ4NgO+3ByAO+6wMNTzmAFxUysdtAnSjgLWMeHN8M9gARme2cdfGG
 LinW3BT7HZyQL6LsL5XnkrkLmxHK2wwsT624xsJUfZZMw+DIn6kAjsK1yQfmMNTxRr2L
 q9hMBMFEpQ9FW5ZSw8pkVwrAO1l3uvVyicZaPLQqahC5cdFWfhxXFA3AdWUFq2MrsyE2
 96azWcyiu4jeR9ARqrp4T29RLCtJC3y+p7UYQKB086Gic3alp1P+u0aIP9jtTglBXlRN
 9wG+EjPgZhNEaIAnFNPGZrMGhomvG/Z4baZzNEzq1MQXFP7+S1gkJUEYu2vHxaiRAJe4
 Ln0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678068; x=1702282868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVwafFKXIh3FbhC1lJWBgKFPyIn+L4/RH22wj1wt5/o=;
 b=SfIjP1k7XihL/iEsUpE2u7pahQvxAt8gyxolOjTRj2+rKzZ+FWTmpdarC2CjM37Fw6
 RA04fE79o/ulOs6/zZBho8PmztTmC9pXbwBAndgE2maqJM5FVZcB1qnl1NX37iojGMrS
 x9Ey7SFD2Kf3LVCQPP/FeQ9+9Nnq0RJ8Fk3qKMHZ/wSmQ8utpdk7oDQ7O/89+g1XYyQh
 v0g1NbqCyiGiqD5FI9UNs/BsKy9Rc7kq602dg+sP35Z2LxEEW/26CGX0MzXXjSakYqu8
 0JBodMCgCtoNrG0PTkqQ/2Vd36J/pAVY8hHcjkBeOwhSfD3vREXSvxpTZTPMVfhjew8c
 Jl9A==
X-Gm-Message-State: AOJu0YwHlEflo0+2VeawhqgL7XjqC9NANRszjmeEHZD99U4HE08ALiGe
 yhq2UYOqVV8ppjHjP1wN3zg=
X-Google-Smtp-Source: AGHT+IHM4BlOkNawTs+eNBVk52dScl23qagG5Qxn6l5UTCW4BBxaVUHMUdeF+NCmTuynZ2kXywD1ug==
X-Received: by 2002:a05:6512:2826:b0:50b:fcb7:313a with SMTP id
 cf38-20020a056512282600b0050bfcb7313amr258254lfb.12.1701678068154; 
 Mon, 04 Dec 2023 00:21:08 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 q16-20020a19a410000000b0050bfe62b073sm3655lfc.170.2023.12.04.00.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:21:07 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/8] drivers: pinctrl: create Tegra DM pinctrl driver
Date: Mon,  4 Dec 2023 10:20:48 +0200
Message-Id: <20231204082054.4943-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204082054.4943-1-clamor95@gmail.com>
References: <20231204082054.4943-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The existing pinctrl driver available for Tegra SOC is well
designed, but it lacks DM support. Let's add a DM compatible
overlay, which allows use of the device tree, along with preserving
backward compatibility with all existing setups and the ability
to use it in SPL board configuration stage.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra114/pinmux.h | 303 +++++++++++++++
 arch/arm/include/asm/arch-tegra124/pinmux.h | 327 ++++++++++++++++
 arch/arm/include/asm/arch-tegra20/pinmux.h  | 291 +++++++++++++++
 arch/arm/include/asm/arch-tegra210/pinmux.h | 394 ++++++++++++++++++++
 arch/arm/include/asm/arch-tegra30/pinmux.h  | 381 +++++++++++++++++++
 drivers/pinctrl/Kconfig                     |   1 +
 drivers/pinctrl/Makefile                    |   1 +
 drivers/pinctrl/tegra/Kconfig               |  18 +
 drivers/pinctrl/tegra/Makefile              |   8 +
 drivers/pinctrl/tegra/pinctrl-tegra.c       | 248 ++++++++++++
 drivers/pinctrl/tegra/pinctrl-tegra20.c     | 177 +++++++++
 11 files changed, 2149 insertions(+)
 create mode 100644 drivers/pinctrl/tegra/Kconfig
 create mode 100644 drivers/pinctrl/tegra/Makefile
 create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra.c
 create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra20.c

diff --git a/arch/arm/include/asm/arch-tegra114/pinmux.h b/arch/arm/include/asm/arch-tegra114/pinmux.h
index 414b22e201..63b3684931 100644
--- a/arch/arm/include/asm/arch-tegra114/pinmux.h
+++ b/arch/arm/include/asm/arch-tegra114/pinmux.h
@@ -312,6 +312,309 @@ enum pmux_func {
 	PMUX_FUNC_COUNT,
 };
 
+static const char * const tegra_pinctrl_to_pingrp[] = {
+	[PMUX_PINGRP_ULPI_DATA0_PO1] = "ulpi_data0_po1",
+	[PMUX_PINGRP_ULPI_DATA1_PO2] = "ulpi_data1_po2",
+	[PMUX_PINGRP_ULPI_DATA2_PO3] = "ulpi_data2_po3",
+	[PMUX_PINGRP_ULPI_DATA3_PO4] = "ulpi_data3_po4",
+	[PMUX_PINGRP_ULPI_DATA4_PO5] = "ulpi_data4_po5",
+	[PMUX_PINGRP_ULPI_DATA5_PO6] = "ulpi_data5_po6",
+	[PMUX_PINGRP_ULPI_DATA6_PO7] = "ulpi_data6_po7",
+	[PMUX_PINGRP_ULPI_DATA7_PO0] = "ulpi_data7_po0",
+	[PMUX_PINGRP_ULPI_CLK_PY0] = "ulpi_clk_py0",
+	[PMUX_PINGRP_ULPI_DIR_PY1] = "ulpi_dir_py1",
+	[PMUX_PINGRP_ULPI_NXT_PY2] = "ulpi_nxt_py2",
+	[PMUX_PINGRP_ULPI_STP_PY3] = "ulpi_stp_py3",
+	[PMUX_PINGRP_DAP3_FS_PP0] = "dap3_fs_pp0",
+	[PMUX_PINGRP_DAP3_DIN_PP1] = "dap3_din_pp1",
+	[PMUX_PINGRP_DAP3_DOUT_PP2] = "dap3_dout_pp2",
+	[PMUX_PINGRP_DAP3_SCLK_PP3] = "dap3_sclk_pp3",
+	[PMUX_PINGRP_PV0] = "pv0",
+	[PMUX_PINGRP_PV1] = "pv1",
+	[PMUX_PINGRP_SDMMC1_CLK_PZ0] = "sdmmc1_clk_pz0",
+	[PMUX_PINGRP_SDMMC1_CMD_PZ1] = "sdmmc1_cmd_pz1",
+	[PMUX_PINGRP_SDMMC1_DAT3_PY4] = "sdmmc1_dat3_py4",
+	[PMUX_PINGRP_SDMMC1_DAT2_PY5] = "sdmmc1_dat2_py5",
+	[PMUX_PINGRP_SDMMC1_DAT1_PY6] = "sdmmc1_dat1_py6",
+	[PMUX_PINGRP_SDMMC1_DAT0_PY7] = "sdmmc1_dat0_py7",
+	[PMUX_PINGRP_CLK2_OUT_PW5] = "clk2_out_pw5",
+	[PMUX_PINGRP_CLK2_REQ_PCC5] = "clk2_req_pcc5",
+	[PMUX_PINGRP_HDMI_INT_PN7] = "hdmi_int_pn7",
+	[PMUX_PINGRP_DDC_SCL_PV4] = "ddc_scl_pv4",
+	[PMUX_PINGRP_DDC_SDA_PV5] = "ddc_sda_pv5",
+	[PMUX_PINGRP_UART2_RXD_PC3] = "uart2_rxd_pc3",
+	[PMUX_PINGRP_UART2_TXD_PC2] = "uart2_txd_pc2",
+	[PMUX_PINGRP_UART2_RTS_N_PJ6] = "uart2_rts_n_pj6",
+	[PMUX_PINGRP_UART2_CTS_N_PJ5] = "uart2_cts_n_pj5",
+	[PMUX_PINGRP_UART3_TXD_PW6] = "uart3_txd_pw6",
+	[PMUX_PINGRP_UART3_RXD_PW7] = "uart3_rxd_pw7",
+	[PMUX_PINGRP_UART3_CTS_N_PA1] = "uart3_cts_n_pa1",
+	[PMUX_PINGRP_UART3_RTS_N_PC0] = "uart3_rts_n_pc0",
+	[PMUX_PINGRP_PU0] = "pu0",
+	[PMUX_PINGRP_PU1] = "pu1",
+	[PMUX_PINGRP_PU2] = "pu2",
+	[PMUX_PINGRP_PU3] = "pu3",
+	[PMUX_PINGRP_PU4] = "pu4",
+	[PMUX_PINGRP_PU5] = "pu5",
+	[PMUX_PINGRP_PU6] = "pu6",
+	[PMUX_PINGRP_GEN1_I2C_SDA_PC5] = "gen1_i2c_sda_pc5",
+	[PMUX_PINGRP_GEN1_I2C_SCL_PC4] = "gen1_i2c_scl_pc4",
+	[PMUX_PINGRP_DAP4_FS_PP4] = "dap4_fs_pp4",
+	[PMUX_PINGRP_DAP4_DIN_PP5] = "dap4_din_pp5",
+	[PMUX_PINGRP_DAP4_DOUT_PP6] = "dap4_dout_pp6",
+	[PMUX_PINGRP_DAP4_SCLK_PP7] = "dap4_sclk_pp7",
+	[PMUX_PINGRP_CLK3_OUT_PEE0] = "clk3_out_pee0",
+	[PMUX_PINGRP_CLK3_REQ_PEE1] = "clk3_req_pee1",
+	[PMUX_PINGRP_GMI_WP_N_PC7] = "gmi_wp_n_pc7",
+	[PMUX_PINGRP_GMI_IORDY_PI5] = "gmi_iordy_pi5",
+	[PMUX_PINGRP_GMI_WAIT_PI7] = "gmi_wait_pi7",
+	[PMUX_PINGRP_GMI_ADV_N_PK0] = "gmi_adv_n_pk0",
+	[PMUX_PINGRP_GMI_CLK_PK1] = "gmi_clk_pk1",
+	[PMUX_PINGRP_GMI_CS0_N_PJ0] = "gmi_cs0_n_pj0",
+	[PMUX_PINGRP_GMI_CS1_N_PJ2] = "gmi_cs1_n_pj2",
+	[PMUX_PINGRP_GMI_CS2_N_PK3] = "gmi_cs2_n_pk3",
+	[PMUX_PINGRP_GMI_CS3_N_PK4] = "gmi_cs3_n_pk4",
+	[PMUX_PINGRP_GMI_CS4_N_PK2] = "gmi_cs4_n_pk2",
+	[PMUX_PINGRP_GMI_CS6_N_PI3] = "gmi_cs6_n_pi3",
+	[PMUX_PINGRP_GMI_CS7_N_PI6] = "gmi_cs7_n_pi6",
+	[PMUX_PINGRP_GMI_AD0_PG0] = "gmi_ad0_pg0",
+	[PMUX_PINGRP_GMI_AD1_PG1] = "gmi_ad1_pg1",
+	[PMUX_PINGRP_GMI_AD2_PG2] = "gmi_ad2_pg2",
+	[PMUX_PINGRP_GMI_AD3_PG3] = "gmi_ad3_pg3",
+	[PMUX_PINGRP_GMI_AD4_PG4] = "gmi_ad4_pg4",
+	[PMUX_PINGRP_GMI_AD5_PG5] = "gmi_ad5_pg5",
+	[PMUX_PINGRP_GMI_AD6_PG6] = "gmi_ad6_pg6",
+	[PMUX_PINGRP_GMI_AD7_PG7] = "gmi_ad7_pg7",
+	[PMUX_PINGRP_GMI_AD8_PH0] = "gmi_ad8_ph0",
+	[PMUX_PINGRP_GMI_AD9_PH1] = "gmi_ad9_ph1",
+	[PMUX_PINGRP_GMI_AD10_PH2] = "gmi_ad10_ph2",
+	[PMUX_PINGRP_GMI_AD11_PH3] = "gmi_ad11_ph3",
+	[PMUX_PINGRP_GMI_AD12_PH4] = "gmi_ad12_ph4",
+	[PMUX_PINGRP_GMI_AD13_PH5] = "gmi_ad13_ph5",
+	[PMUX_PINGRP_GMI_AD14_PH6] = "gmi_ad14_ph6",
+	[PMUX_PINGRP_GMI_AD15_PH7] = "gmi_ad15_ph7",
+	[PMUX_PINGRP_GMI_A16_PJ7] = "gmi_a16_pj7",
+	[PMUX_PINGRP_GMI_A17_PB0] = "gmi_a17_pb0",
+	[PMUX_PINGRP_GMI_A18_PB1] = "gmi_a18_pb1",
+	[PMUX_PINGRP_GMI_A19_PK7] = "gmi_a19_pk7",
+	[PMUX_PINGRP_GMI_WR_N_PI0] = "gmi_wr_n_pi0",
+	[PMUX_PINGRP_GMI_OE_N_PI1] = "gmi_oe_n_pi1",
+	[PMUX_PINGRP_GMI_DQS_P_PJ3] = "gmi_dqs_p_pj3",
+	[PMUX_PINGRP_GMI_RST_N_PI4] = "gmi_rst_n_pi4",
+	[PMUX_PINGRP_GEN2_I2C_SCL_PT5] = "gen2_i2c_scl_pt5",
+	[PMUX_PINGRP_GEN2_I2C_SDA_PT6] = "gen2_i2c_sda_pt6",
+	[PMUX_PINGRP_SDMMC4_CLK_PCC4] = "sdmmc4_clk_pcc4",
+	[PMUX_PINGRP_SDMMC4_CMD_PT7] = "sdmmc4_cmd_pt7",
+	[PMUX_PINGRP_SDMMC4_DAT0_PAA0] = "sdmmc4_dat0_paa0",
+	[PMUX_PINGRP_SDMMC4_DAT1_PAA1] = "sdmmc4_dat1_paa1",
+	[PMUX_PINGRP_SDMMC4_DAT2_PAA2] = "sdmmc4_dat2_paa2",
+	[PMUX_PINGRP_SDMMC4_DAT3_PAA3] = "sdmmc4_dat3_paa3",
+	[PMUX_PINGRP_SDMMC4_DAT4_PAA4] = "sdmmc4_dat4_paa4",
+	[PMUX_PINGRP_SDMMC4_DAT5_PAA5] = "sdmmc4_dat5_paa5",
+	[PMUX_PINGRP_SDMMC4_DAT6_PAA6] = "sdmmc4_dat6_paa6",
+	[PMUX_PINGRP_SDMMC4_DAT7_PAA7] = "sdmmc4_dat7_paa7",
+	[PMUX_PINGRP_CAM_MCLK_PCC0] = "cam_mclk_pcc0",
+	[PMUX_PINGRP_PCC1] = "pcc1",
+	[PMUX_PINGRP_PBB0] = "pbb0",
+	[PMUX_PINGRP_CAM_I2C_SCL_PBB1] = "cam_i2c_scl_pbb1",
+	[PMUX_PINGRP_CAM_I2C_SDA_PBB2] = "cam_i2c_sda_pbb2",
+	[PMUX_PINGRP_PBB3] = "pbb3",
+	[PMUX_PINGRP_PBB4] = "pbb4",
+	[PMUX_PINGRP_PBB5] = "pbb5",
+	[PMUX_PINGRP_PBB6] = "pbb6",
+	[PMUX_PINGRP_PBB7] = "pbb7",
+	[PMUX_PINGRP_PCC2] = "pcc2",
+	[PMUX_PINGRP_JTAG_RTCK] = "jtag_rtck",
+	[PMUX_PINGRP_PWR_I2C_SCL_PZ6] = "pwr_i2c_scl_pz6",
+	[PMUX_PINGRP_PWR_I2C_SDA_PZ7] = "pwr_i2c_sda_pz7",
+	[PMUX_PINGRP_KB_ROW0_PR0] = "kb_row0_pr0",
+	[PMUX_PINGRP_KB_ROW1_PR1] = "kb_row1_pr1",
+	[PMUX_PINGRP_KB_ROW2_PR2] = "kb_row2_pr2",
+	[PMUX_PINGRP_KB_ROW3_PR3] = "kb_row3_pr3",
+	[PMUX_PINGRP_KB_ROW4_PR4] = "kb_row4_pr4",
+	[PMUX_PINGRP_KB_ROW5_PR5] = "kb_row5_pr5",
+	[PMUX_PINGRP_KB_ROW6_PR6] = "kb_row6_pr6",
+	[PMUX_PINGRP_KB_ROW7_PR7] = "kb_row7_pr7",
+	[PMUX_PINGRP_KB_ROW8_PS0] = "kb_row8_ps0",
+	[PMUX_PINGRP_KB_ROW9_PS1] = "kb_row9_ps1",
+	[PMUX_PINGRP_KB_ROW10_PS2] = "kb_row10_ps2",
+	[PMUX_PINGRP_KB_COL0_PQ0] = "kb_col0_pq0",
+	[PMUX_PINGRP_KB_COL1_PQ1] = "kb_col1_pq1",
+	[PMUX_PINGRP_KB_COL2_PQ2] = "kb_col2_pq2",
+	[PMUX_PINGRP_KB_COL3_PQ3] = "kb_col3_pq3",
+	[PMUX_PINGRP_KB_COL4_PQ4] = "kb_col4_pq4",
+	[PMUX_PINGRP_KB_COL5_PQ5] = "kb_col5_pq5",
+	[PMUX_PINGRP_KB_COL6_PQ6] = "kb_col6_pq6",
+	[PMUX_PINGRP_KB_COL7_PQ7] = "kb_col7_pq7",
+	[PMUX_PINGRP_CLK_32K_OUT_PA0] = "clk_32k_out_pa0",
+	[PMUX_PINGRP_SYS_CLK_REQ_PZ5] = "sys_clk_req_pz5",
+	[PMUX_PINGRP_CORE_PWR_REQ] = "core_pwr_req",
+	[PMUX_PINGRP_CPU_PWR_REQ] = "cpu_pwr_req",
+	[PMUX_PINGRP_PWR_INT_N] = "pwr_int_n",
+	[PMUX_PINGRP_CLK_32K_IN] = "clk_32k_in",
+	[PMUX_PINGRP_OWR] = "owr",
+	[PMUX_PINGRP_DAP1_FS_PN0] = "dap1_fs_pn0",
+	[PMUX_PINGRP_DAP1_DIN_PN1] = "dap1_din_pn1",
+	[PMUX_PINGRP_DAP1_DOUT_PN2] = "dap1_dout_pn2",
+	[PMUX_PINGRP_DAP1_SCLK_PN3] = "dap1_sclk_pn3",
+	[PMUX_PINGRP_CLK1_REQ_PEE2] = "clk1_req_pee2",
+	[PMUX_PINGRP_CLK1_OUT_PW4] = "clk1_out_pw4",
+	[PMUX_PINGRP_SPDIF_IN_PK6] = "spdif_in_pk6",
+	[PMUX_PINGRP_SPDIF_OUT_PK5] = "spdif_out_pk5",
+	[PMUX_PINGRP_DAP2_FS_PA2] = "dap2_fs_pa2",
+	[PMUX_PINGRP_DAP2_DIN_PA4] = "dap2_din_pa4",
+	[PMUX_PINGRP_DAP2_DOUT_PA5] = "dap2_dout_pa5",
+	[PMUX_PINGRP_DAP2_SCLK_PA3] = "dap2_sclk_pa3",
+	[PMUX_PINGRP_DVFS_PWM_PX0] = "dvfs_pwm_px0",
+	[PMUX_PINGRP_GPIO_X1_AUD_PX1] = "gpio_x1_aud_px1",
+	[PMUX_PINGRP_GPIO_X3_AUD_PX3] = "gpio_x3_aud_px3",
+	[PMUX_PINGRP_DVFS_CLK_PX2] = "dvfs_clk_px2",
+	[PMUX_PINGRP_GPIO_X4_AUD_PX4] = "gpio_x4_aud_px4",
+	[PMUX_PINGRP_GPIO_X5_AUD_PX5] = "gpio_x5_aud_px5",
+	[PMUX_PINGRP_GPIO_X6_AUD_PX6] = "gpio_x6_aud_px6",
+	[PMUX_PINGRP_GPIO_X7_AUD_PX7] = "gpio_x7_aud_px7",
+	[PMUX_PINGRP_SDMMC3_CLK_PA6] = "sdmmc3_clk_pa6",
+	[PMUX_PINGRP_SDMMC3_CMD_PA7] = "sdmmc3_cmd_pa7",
+	[PMUX_PINGRP_SDMMC3_DAT0_PB7] = "sdmmc3_dat0_pb7",
+	[PMUX_PINGRP_SDMMC3_DAT1_PB6] = "sdmmc3_dat1_pb6",
+	[PMUX_PINGRP_SDMMC3_DAT2_PB5] = "sdmmc3_dat2_pb5",
+	[PMUX_PINGRP_SDMMC3_DAT3_PB4] = "sdmmc3_dat3_pb4",
+	[PMUX_PINGRP_HDMI_CEC_PEE3] = "hdmi_cec_pee3",
+	[PMUX_PINGRP_SDMMC1_WP_N_PV3] = "sdmmc1_wp_n_pv3",
+	[PMUX_PINGRP_SDMMC3_CD_N_PV2] = "sdmmc3_cd_n_pv2",
+	[PMUX_PINGRP_GPIO_W2_AUD_PW2] = "gpio_w2_aud_pw2",
+	[PMUX_PINGRP_GPIO_W3_AUD_PW3] = "gpio_w3_aud_pw3",
+	[PMUX_PINGRP_USB_VBUS_EN0_PN4] = "usb_vbus_en0_pn4",
+	[PMUX_PINGRP_USB_VBUS_EN1_PN5] = "usb_vbus_en1_pn5",
+	[PMUX_PINGRP_SDMMC3_CLK_LB_IN_PEE5] = "sdmmc3_clk_lb_in_pee5",
+	[PMUX_PINGRP_SDMMC3_CLK_LB_OUT_PEE4] = "sdmmc3_clk_lb_out_pee4",
+	[PMUX_PINGRP_GMI_CLK_LB] = "gmi_clk_lb",
+	[PMUX_PINGRP_RESET_OUT_N] = "reset_out_n",
+};
+
+static const char * const tegra_pinctrl_to_drvgrp[] = {
+	[PMUX_DRVGRP_AO1] = "drive_ao1",
+	[PMUX_DRVGRP_AO2] = "drive_ao2",
+	[PMUX_DRVGRP_AT1] = "drive_at1",
+	[PMUX_DRVGRP_AT2] = "drive_at2",
+	[PMUX_DRVGRP_AT3] = "drive_at3",
+	[PMUX_DRVGRP_AT4] = "drive_at4",
+	[PMUX_DRVGRP_AT5] = "drive_at5",
+	[PMUX_DRVGRP_CDEV1] = "drive_cdev1",
+	[PMUX_DRVGRP_CDEV2] = "drive_cdev2",
+	[PMUX_DRVGRP_DAP1] = "drive_dap1",
+	[PMUX_DRVGRP_DAP2] = "drive_dap2",
+	[PMUX_DRVGRP_DAP3] = "drive_dap3",
+	[PMUX_DRVGRP_DAP4] = "drive_dap4",
+	[PMUX_DRVGRP_DBG] = "drive_dbg",
+	[PMUX_DRVGRP_SDIO3] = "drive_sdio3",
+	[PMUX_DRVGRP_SPI] = "drive_spi",
+	[PMUX_DRVGRP_UAA] = "drive_uaa",
+	[PMUX_DRVGRP_UAB] = "drive_uab",
+	[PMUX_DRVGRP_UART2] = "drive_uart2",
+	[PMUX_DRVGRP_UART3] = "drive_uart3",
+	[PMUX_DRVGRP_SDIO1] = "drive_sdio1",
+	[PMUX_DRVGRP_DDC] = "drive_ddc",
+	[PMUX_DRVGRP_GMA] = "drive_gma",
+	[PMUX_DRVGRP_GME] = "drive_gme",
+	[PMUX_DRVGRP_GMF] = "drive_gmf",
+	[PMUX_DRVGRP_GMG] = "drive_gmg",
+	[PMUX_DRVGRP_GMH] = "drive_gmh",
+	[PMUX_DRVGRP_OWR] = "drive_owr",
+	[PMUX_DRVGRP_UDA] = "drive_uda",
+	[PMUX_DRVGRP_DEV3] = "drive_dev3",
+	[PMUX_DRVGRP_CEC] = "drive_cec",
+	[PMUX_DRVGRP_AT6] = "drive_at6",
+	[PMUX_DRVGRP_DAP5] = "drive_dap5",
+	[PMUX_DRVGRP_USB_VBUS_EN] = "drive_usb_vbus_en",
+	[PMUX_DRVGRP_AO3] = "drive_ao3",
+	[PMUX_DRVGRP_HV0] = "drive_hv0",
+	[PMUX_DRVGRP_SDIO4] = "drive_sdio4",
+	[PMUX_DRVGRP_AO0] = "drive_ao0",
+};
+
+static const char * const tegra_pinctrl_to_func[] = {
+	[PMUX_FUNC_DEFAULT] = "default",
+	[PMUX_FUNC_BLINK] = "blink",
+	[PMUX_FUNC_CEC] = "cec",
+	[PMUX_FUNC_CLDVFS] = "cldvfs",
+	[PMUX_FUNC_CLK] = "clk",
+	[PMUX_FUNC_CLK12] = "clk12",
+	[PMUX_FUNC_CPU] = "cpu",
+	[PMUX_FUNC_DAP] = "dap",
+	[PMUX_FUNC_DAP1] = "dap1",
+	[PMUX_FUNC_DAP2] = "dap2",
+	[PMUX_FUNC_DEV3] = "dev3",
+	[PMUX_FUNC_DISPLAYA] = "displaya",
+	[PMUX_FUNC_DISPLAYA_ALT] = "displaya_alt",
+	[PMUX_FUNC_DISPLAYB] = "displayb",
+	[PMUX_FUNC_DTV] = "dtv",
+	[PMUX_FUNC_EMC_DLL] = "emc_dll",
+	[PMUX_FUNC_EXTPERIPH1] = "extperiph1",
+	[PMUX_FUNC_EXTPERIPH2] = "extperiph2",
+	[PMUX_FUNC_EXTPERIPH3] = "extperiph3",
+	[PMUX_FUNC_GMI] = "gmi",
+	[PMUX_FUNC_GMI_ALT] = "gmi_alt",
+	[PMUX_FUNC_HDA] = "hda",
+	[PMUX_FUNC_HSI] = "hsi",
+	[PMUX_FUNC_I2C1] = "i2c1",
+	[PMUX_FUNC_I2C2] = "i2c2",
+	[PMUX_FUNC_I2C3] = "i2c3",
+	[PMUX_FUNC_I2C4] = "i2c4",
+	[PMUX_FUNC_I2CPWR] = "i2cpwr",
+	[PMUX_FUNC_I2S0] = "i2s0",
+	[PMUX_FUNC_I2S1] = "i2s1",
+	[PMUX_FUNC_I2S2] = "i2s2",
+	[PMUX_FUNC_I2S3] = "i2s3",
+	[PMUX_FUNC_I2S4] = "i2s4",
+	[PMUX_FUNC_IRDA] = "irda",
+	[PMUX_FUNC_KBC] = "kbc",
+	[PMUX_FUNC_NAND] = "nand",
+	[PMUX_FUNC_NAND_ALT] = "nand_alt",
+	[PMUX_FUNC_OWR] = "owr",
+	[PMUX_FUNC_PMI] = "pmi",
+	[PMUX_FUNC_PWM0] = "pwm0",
+	[PMUX_FUNC_PWM1] = "pwm1",
+	[PMUX_FUNC_PWM2] = "pwm2",
+	[PMUX_FUNC_PWM3] = "pwm3",
+	[PMUX_FUNC_PWRON] = "pwron",
+	[PMUX_FUNC_RESET_OUT_N] = "reset_out_n",
+	[PMUX_FUNC_RTCK] = "rtck",
+	[PMUX_FUNC_SDMMC1] = "sdmmc1",
+	[PMUX_FUNC_SDMMC2] = "sdmmc2",
+	[PMUX_FUNC_SDMMC3] = "sdmmc3",
+	[PMUX_FUNC_SDMMC4] = "sdmmc4",
+	[PMUX_FUNC_SOC] = "soc",
+	[PMUX_FUNC_SPDIF] = "spdif",
+	[PMUX_FUNC_SPI1] = "spi1",
+	[PMUX_FUNC_SPI2] = "spi2",
+	[PMUX_FUNC_SPI3] = "spi3",
+	[PMUX_FUNC_SPI4] = "spi4",
+	[PMUX_FUNC_SPI5] = "spi5",
+	[PMUX_FUNC_SPI6] = "spi6",
+	[PMUX_FUNC_SYSCLK] = "sysclk",
+	[PMUX_FUNC_TRACE] = "trace",
+	[PMUX_FUNC_UARTA] = "uarta",
+	[PMUX_FUNC_UARTB] = "uartb",
+	[PMUX_FUNC_UARTC] = "uartc",
+	[PMUX_FUNC_UARTD] = "uartd",
+	[PMUX_FUNC_ULPI] = "ulpi",
+	[PMUX_FUNC_USB] = "usb",
+	[PMUX_FUNC_VGP1] = "vgp1",
+	[PMUX_FUNC_VGP2] = "vgp2",
+	[PMUX_FUNC_VGP3] = "vgp3",
+	[PMUX_FUNC_VGP4] = "vgp4",
+	[PMUX_FUNC_VGP5] = "vgp5",
+	[PMUX_FUNC_VGP6] = "vgp6",
+	[PMUX_FUNC_VI] = "vi",
+	[PMUX_FUNC_VI_ALT1] = "vi_alt1",
+	[PMUX_FUNC_VI_ALT3] = "vi_alt3",
+	[PMUX_FUNC_RSVD1] = "rsvd1",
+	[PMUX_FUNC_RSVD2] = "rsvd2",
+	[PMUX_FUNC_RSVD3] = "rsvd3",
+	[PMUX_FUNC_RSVD4] = "rsvd4",
+};
+
 #define TEGRA_PMX_SOC_DRV_GROUP_BASE_REG 0x868
 #define TEGRA_PMX_SOC_HAS_IO_CLAMPING
 #define TEGRA_PMX_SOC_HAS_DRVGRPS
diff --git a/arch/arm/include/asm/arch-tegra124/pinmux.h b/arch/arm/include/asm/arch-tegra124/pinmux.h
index 4c593aae7c..3aba17d21e 100644
--- a/arch/arm/include/asm/arch-tegra124/pinmux.h
+++ b/arch/arm/include/asm/arch-tegra124/pinmux.h
@@ -341,6 +341,333 @@ enum pmux_func {
 	PMUX_FUNC_COUNT,
 };
 
+static const char * const tegra_pinctrl_to_pingrp[] = {
+	[PMUX_PINGRP_ULPI_DATA0_PO1] = "ulpi_data0_po1",
+	[PMUX_PINGRP_ULPI_DATA1_PO2] = "ulpi_data1_po2",
+	[PMUX_PINGRP_ULPI_DATA2_PO3] = "ulpi_data2_po3",
+	[PMUX_PINGRP_ULPI_DATA3_PO4] = "ulpi_data3_po4",
+	[PMUX_PINGRP_ULPI_DATA4_PO5] = "ulpi_data4_po5",
+	[PMUX_PINGRP_ULPI_DATA5_PO6] = "ulpi_data5_po6",
+	[PMUX_PINGRP_ULPI_DATA6_PO7] = "ulpi_data6_po7",
+	[PMUX_PINGRP_ULPI_DATA7_PO0] = "ulpi_data7_po0",
+	[PMUX_PINGRP_ULPI_CLK_PY0] = "ulpi_clk_py0",
+	[PMUX_PINGRP_ULPI_DIR_PY1] = "ulpi_dir_py1",
+	[PMUX_PINGRP_ULPI_NXT_PY2] = "ulpi_nxt_py2",
+	[PMUX_PINGRP_ULPI_STP_PY3] = "ulpi_stp_py3",
+	[PMUX_PINGRP_DAP3_FS_PP0] = "dap3_fs_pp0",
+	[PMUX_PINGRP_DAP3_DIN_PP1] = "dap3_din_pp1",
+	[PMUX_PINGRP_DAP3_DOUT_PP2] = "dap3_dout_pp2",
+	[PMUX_PINGRP_DAP3_SCLK_PP3] = "dap3_sclk_pp3",
+	[PMUX_PINGRP_PV0] = "pv0",
+	[PMUX_PINGRP_PV1] = "pv1",
+	[PMUX_PINGRP_SDMMC1_CLK_PZ0] = "sdmmc1_clk_pz0",
+	[PMUX_PINGRP_SDMMC1_CMD_PZ1] = "sdmmc1_cmd_pz1",
+	[PMUX_PINGRP_SDMMC1_DAT3_PY4] = "sdmmc1_dat3_py4",
+	[PMUX_PINGRP_SDMMC1_DAT2_PY5] = "sdmmc1_dat2_py5",
+	[PMUX_PINGRP_SDMMC1_DAT1_PY6] = "sdmmc1_dat1_py6",
+	[PMUX_PINGRP_SDMMC1_DAT0_PY7] = "sdmmc1_dat0_py7",
+	[PMUX_PINGRP_CLK2_OUT_PW5] = "clk2_out_pw5",
+	[PMUX_PINGRP_CLK2_REQ_PCC5] = "clk2_req_pcc5",
+	[PMUX_PINGRP_HDMI_INT_PN7] = "hdmi_int_pn7",
+	[PMUX_PINGRP_DDC_SCL_PV4] = "ddc_scl_pv4",
+	[PMUX_PINGRP_DDC_SDA_PV5] = "ddc_sda_pv5",
+	[PMUX_PINGRP_UART2_RXD_PC3] = "uart2_rxd_pc3",
+	[PMUX_PINGRP_UART2_TXD_PC2] = "uart2_txd_pc2",
+	[PMUX_PINGRP_UART2_RTS_N_PJ6] = "uart2_rts_n_pj6",
+	[PMUX_PINGRP_UART2_CTS_N_PJ5] = "uart2_cts_n_pj5",
+	[PMUX_PINGRP_UART3_TXD_PW6] = "uart3_txd_pw6",
+	[PMUX_PINGRP_UART3_RXD_PW7] = "uart3_rxd_pw7",
+	[PMUX_PINGRP_UART3_CTS_N_PA1] = "uart3_cts_n_pa1",
+	[PMUX_PINGRP_UART3_RTS_N_PC0] = "uart3_rts_n_pc0",
+	[PMUX_PINGRP_PU0] = "pu0",
+	[PMUX_PINGRP_PU1] = "pu1",
+	[PMUX_PINGRP_PU2] = "pu2",
+	[PMUX_PINGRP_PU3] = "pu3",
+	[PMUX_PINGRP_PU4] = "pu4",
+	[PMUX_PINGRP_PU5] = "pu5",
+	[PMUX_PINGRP_PU6] = "pu6",
+	[PMUX_PINGRP_GEN1_I2C_SDA_PC5] = "gen1_i2c_sda_pc5",
+	[PMUX_PINGRP_GEN1_I2C_SCL_PC4] = "gen1_i2c_scl_pc4",
+	[PMUX_PINGRP_DAP4_FS_PP4] = "dap4_fs_pp4",
+	[PMUX_PINGRP_DAP4_DIN_PP5] = "dap4_din_pp5",
+	[PMUX_PINGRP_DAP4_DOUT_PP6] = "dap4_dout_pp6",
+	[PMUX_PINGRP_DAP4_SCLK_PP7] = "dap4_sclk_pp7",
+	[PMUX_PINGRP_CLK3_OUT_PEE0] = "clk3_out_pee0",
+	[PMUX_PINGRP_CLK3_REQ_PEE1] = "clk3_req_pee1",
+	[PMUX_PINGRP_PC7] = "pc7",
+	[PMUX_PINGRP_PI5] = "pi5",
+	[PMUX_PINGRP_PI7] = "pi7",
+	[PMUX_PINGRP_PK0] = "pk0",
+	[PMUX_PINGRP_PK1] = "pk1",
+	[PMUX_PINGRP_PJ0] = "pj0",
+	[PMUX_PINGRP_PJ2] = "pj2",
+	[PMUX_PINGRP_PK3] = "pk3",
+	[PMUX_PINGRP_PK4] = "pk4",
+	[PMUX_PINGRP_PK2] = "pk2",
+	[PMUX_PINGRP_PI3] = "pi3",
+	[PMUX_PINGRP_PI6] = "pi6",
+	[PMUX_PINGRP_PG0] = "pg0",
+	[PMUX_PINGRP_PG1] = "pg1",
+	[PMUX_PINGRP_PG2] = "pg2",
+	[PMUX_PINGRP_PG3] = "pg3",
+	[PMUX_PINGRP_PG4] = "pg4",
+	[PMUX_PINGRP_PG5] = "pg5",
+	[PMUX_PINGRP_PG6] = "pg6",
+	[PMUX_PINGRP_PG7] = "pg7",
+	[PMUX_PINGRP_PH0] = "ph0",
+	[PMUX_PINGRP_PH1] = "ph1",
+	[PMUX_PINGRP_PH2] = "ph2",
+	[PMUX_PINGRP_PH3] = "ph3",
+	[PMUX_PINGRP_PH4] = "ph4",
+	[PMUX_PINGRP_PH5] = "ph5",
+	[PMUX_PINGRP_PH6] = "ph6",
+	[PMUX_PINGRP_PH7] = "ph7",
+	[PMUX_PINGRP_PJ7] = "pj7",
+	[PMUX_PINGRP_PB0] = "pb0",
+	[PMUX_PINGRP_PB1] = "pb1",
+	[PMUX_PINGRP_PK7] = "pk7",
+	[PMUX_PINGRP_PI0] = "pi0",
+	[PMUX_PINGRP_PI1] = "pi1",
+	[PMUX_PINGRP_PI2] = "pi2",
+	[PMUX_PINGRP_PI4] = "pi4",
+	[PMUX_PINGRP_GEN2_I2C_SCL_PT5] = "gen2_i2c_scl_pt5",
+	[PMUX_PINGRP_GEN2_I2C_SDA_PT6] = "gen2_i2c_sda_pt6",
+	[PMUX_PINGRP_SDMMC4_CLK_PCC4] = "sdmmc4_clk_pcc4",
+	[PMUX_PINGRP_SDMMC4_CMD_PT7] = "sdmmc4_cmd_pt7",
+	[PMUX_PINGRP_SDMMC4_DAT0_PAA0] = "sdmmc4_dat0_paa0",
+	[PMUX_PINGRP_SDMMC4_DAT1_PAA1] = "sdmmc4_dat1_paa1",
+	[PMUX_PINGRP_SDMMC4_DAT2_PAA2] = "sdmmc4_dat2_paa2",
+	[PMUX_PINGRP_SDMMC4_DAT3_PAA3] = "sdmmc4_dat3_paa3",
+	[PMUX_PINGRP_SDMMC4_DAT4_PAA4] = "sdmmc4_dat4_paa4",
+	[PMUX_PINGRP_SDMMC4_DAT5_PAA5] = "sdmmc4_dat5_paa5",
+	[PMUX_PINGRP_SDMMC4_DAT6_PAA6] = "sdmmc4_dat6_paa6",
+	[PMUX_PINGRP_SDMMC4_DAT7_PAA7] = "sdmmc4_dat7_paa7",
+	[PMUX_PINGRP_CAM_MCLK_PCC0] = "cam_mclk_pcc0",
+	[PMUX_PINGRP_PCC1] = "pcc1",
+	[PMUX_PINGRP_PBB0] = "pbb0",
+	[PMUX_PINGRP_CAM_I2C_SCL_PBB1] = "cam_i2c_scl_pbb1",
+	[PMUX_PINGRP_CAM_I2C_SDA_PBB2] = "cam_i2c_sda_pbb2",
+	[PMUX_PINGRP_PBB3] = "pbb3",
+	[PMUX_PINGRP_PBB4] = "pbb4",
+	[PMUX_PINGRP_PBB5] = "pbb5",
+	[PMUX_PINGRP_PBB6] = "pbb6",
+	[PMUX_PINGRP_PBB7] = "pbb7",
+	[PMUX_PINGRP_PCC2] = "pcc2",
+	[PMUX_PINGRP_JTAG_RTCK] = "jtag_rtck",
+	[PMUX_PINGRP_PWR_I2C_SCL_PZ6] = "pwr_i2c_scl_pz6",
+	[PMUX_PINGRP_PWR_I2C_SDA_PZ7] = "pwr_i2c_sda_pz7",
+	[PMUX_PINGRP_KB_ROW0_PR0] = "kb_row0_pr0",
+	[PMUX_PINGRP_KB_ROW1_PR1] = "kb_row1_pr1",
+	[PMUX_PINGRP_KB_ROW2_PR2] = "kb_row2_pr2",
+	[PMUX_PINGRP_KB_ROW3_PR3] = "kb_row3_pr3",
+	[PMUX_PINGRP_KB_ROW4_PR4] = "kb_row4_pr4",
+	[PMUX_PINGRP_KB_ROW5_PR5] = "kb_row5_pr5",
+	[PMUX_PINGRP_KB_ROW6_PR6] = "kb_row6_pr6",
+	[PMUX_PINGRP_KB_ROW7_PR7] = "kb_row7_pr7",
+	[PMUX_PINGRP_KB_ROW8_PS0] = "kb_row8_ps0",
+	[PMUX_PINGRP_KB_ROW9_PS1] = "kb_row9_ps1",
+	[PMUX_PINGRP_KB_ROW10_PS2] = "kb_row10_ps2",
+	[PMUX_PINGRP_KB_ROW11_PS3] = "kb_row11_ps3",
+	[PMUX_PINGRP_KB_ROW12_PS4] = "kb_row12_ps4",
+	[PMUX_PINGRP_KB_ROW13_PS5] = "kb_row13_ps5",
+	[PMUX_PINGRP_KB_ROW14_PS6] = "kb_row14_ps6",
+	[PMUX_PINGRP_KB_ROW15_PS7] = "kb_row15_ps7",
+	[PMUX_PINGRP_KB_COL0_PQ0] = "kb_col0_pq0",
+	[PMUX_PINGRP_KB_COL1_PQ1] = "kb_col1_pq1",
+	[PMUX_PINGRP_KB_COL2_PQ2] = "kb_col2_pq2",
+	[PMUX_PINGRP_KB_COL3_PQ3] = "kb_col3_pq3",
+	[PMUX_PINGRP_KB_COL4_PQ4] = "kb_col4_pq4",
+	[PMUX_PINGRP_KB_COL5_PQ5] = "kb_col5_pq5",
+	[PMUX_PINGRP_KB_COL6_PQ6] = "kb_col6_pq6",
+	[PMUX_PINGRP_KB_COL7_PQ7] = "kb_col7_pq7",
+	[PMUX_PINGRP_CLK_32K_OUT_PA0] = "clk_32k_out_pa0",
+	[PMUX_PINGRP_CORE_PWR_REQ] = "core_pwr_req",
+	[PMUX_PINGRP_CPU_PWR_REQ] = "cpu_pwr_req",
+	[PMUX_PINGRP_PWR_INT_N] = "pwr_int_n",
+	[PMUX_PINGRP_CLK_32K_IN] = "clk_32k_in",
+	[PMUX_PINGRP_OWR] = "owr",
+	[PMUX_PINGRP_DAP1_FS_PN0] = "dap1_fs_pn0",
+	[PMUX_PINGRP_DAP1_DIN_PN1] = "dap1_din_pn1",
+	[PMUX_PINGRP_DAP1_DOUT_PN2] = "dap1_dout_pn2",
+	[PMUX_PINGRP_DAP1_SCLK_PN3] = "dap1_sclk_pn3",
+	[PMUX_PINGRP_DAP_MCLK1_REQ_PEE2] = "dap_mclk1_req_pee2",
+	[PMUX_PINGRP_DAP_MCLK1_PW4] = "dap_mclk1_pw4",
+	[PMUX_PINGRP_SPDIF_IN_PK6] = "spdif_in_pk6",
+	[PMUX_PINGRP_SPDIF_OUT_PK5] = "spdif_out_pk5",
+	[PMUX_PINGRP_DAP2_FS_PA2] = "dap2_fs_pa2",
+	[PMUX_PINGRP_DAP2_DIN_PA4] = "dap2_din_pa4",
+	[PMUX_PINGRP_DAP2_DOUT_PA5] = "dap2_dout_pa5",
+	[PMUX_PINGRP_DAP2_SCLK_PA3] = "dap2_sclk_pa3",
+	[PMUX_PINGRP_DVFS_PWM_PX0] = "dvfs_pwm_px0",
+	[PMUX_PINGRP_GPIO_X1_AUD_PX1] = "gpio_x1_aud_px1",
+	[PMUX_PINGRP_GPIO_X3_AUD_PX3] = "gpio_x3_aud_px3",
+	[PMUX_PINGRP_DVFS_CLK_PX2] = "dvfs_clk_px2",
+	[PMUX_PINGRP_GPIO_X4_AUD_PX4] = "gpio_x4_aud_px4",
+	[PMUX_PINGRP_GPIO_X5_AUD_PX5] = "gpio_x5_aud_px5",
+	[PMUX_PINGRP_GPIO_X6_AUD_PX6] = "gpio_x6_aud_px6",
+	[PMUX_PINGRP_GPIO_X7_AUD_PX7] = "gpio_x7_aud_px7",
+	[PMUX_PINGRP_SDMMC3_CLK_PA6] = "sdmmc3_clk_pa6",
+	[PMUX_PINGRP_SDMMC3_CMD_PA7] = "sdmmc3_cmd_pa7",
+	[PMUX_PINGRP_SDMMC3_DAT0_PB7] = "sdmmc3_dat0_pb7",
+	[PMUX_PINGRP_SDMMC3_DAT1_PB6] = "sdmmc3_dat1_pb6",
+	[PMUX_PINGRP_SDMMC3_DAT2_PB5] = "sdmmc3_dat2_pb5",
+	[PMUX_PINGRP_SDMMC3_DAT3_PB4] = "sdmmc3_dat3_pb4",
+	[PMUX_PINGRP_PEX_L0_RST_N_PDD1] = "pex_l0_rst_n_pdd1",
+	[PMUX_PINGRP_PEX_L0_CLKREQ_N_PDD2] = "pex_l0_clkreq_n_pdd2",
+	[PMUX_PINGRP_PEX_WAKE_N_PDD3] = "pex_wake_n_pdd3",
+	[PMUX_PINGRP_PEX_L1_RST_N_PDD5] = "pex_l1_rst_n_pdd5",
+	[PMUX_PINGRP_PEX_L1_CLKREQ_N_PDD6] = "pex_l1_clkreq_n_pdd6",
+	[PMUX_PINGRP_HDMI_CEC_PEE3] = "hdmi_cec_pee3",
+	[PMUX_PINGRP_SDMMC1_WP_N_PV3] = "sdmmc1_wp_n_pv3",
+	[PMUX_PINGRP_SDMMC3_CD_N_PV2] = "sdmmc3_cd_n_pv2",
+	[PMUX_PINGRP_GPIO_W2_AUD_PW2] = "gpio_w2_aud_pw2",
+	[PMUX_PINGRP_GPIO_W3_AUD_PW3] = "gpio_w3_aud_pw3",
+	[PMUX_PINGRP_USB_VBUS_EN0_PN4] = "usb_vbus_en0_pn4",
+	[PMUX_PINGRP_USB_VBUS_EN1_PN5] = "usb_vbus_en1_pn5",
+	[PMUX_PINGRP_SDMMC3_CLK_LB_IN_PEE5] = "sdmmc3_clk_lb_in_pee5",
+	[PMUX_PINGRP_SDMMC3_CLK_LB_OUT_PEE4] = "sdmmc3_clk_lb_out_pee4",
+	[PMUX_PINGRP_GMI_CLK_LB] = "gmi_clk_lb",
+	[PMUX_PINGRP_RESET_OUT_N] = "reset_out_n",
+	[PMUX_PINGRP_KB_ROW16_PT0] = "kb_row16_pt0",
+	[PMUX_PINGRP_KB_ROW17_PT1] = "kb_row17_pt1",
+	[PMUX_PINGRP_USB_VBUS_EN2_PFF1] = "usb_vbus_en2_pff1",
+	[PMUX_PINGRP_PFF2] = "pff2",
+	[PMUX_PINGRP_DP_HPD_PFF0] = "dp_hpd_pff0",
+};
+
+static const char * const tegra_pinctrl_to_drvgrp[] = {
+	[PMUX_DRVGRP_AO1] = "ao1",
+	[PMUX_DRVGRP_AO2] = "ao2",
+	[PMUX_DRVGRP_AT1] = "at1",
+	[PMUX_DRVGRP_AT2] = "at2",
+	[PMUX_DRVGRP_AT3] = "at3",
+	[PMUX_DRVGRP_AT4] = "at4",
+	[PMUX_DRVGRP_AT5] = "at5",
+	[PMUX_DRVGRP_CDEV1] = "cdev1",
+	[PMUX_DRVGRP_CDEV2] = "cdev2",
+	[PMUX_DRVGRP_DAP1] = "dap1",
+	[PMUX_DRVGRP_DAP2] = "dap2",
+	[PMUX_DRVGRP_DAP3] = "dap3",
+	[PMUX_DRVGRP_DAP4] = "dap4",
+	[PMUX_DRVGRP_DBG] = "dbg",
+	[PMUX_DRVGRP_SDIO3] = "sdio3",
+	[PMUX_DRVGRP_SPI] = "spi",
+	[PMUX_DRVGRP_UAA] = "uaa",
+	[PMUX_DRVGRP_UAB] = "uab",
+	[PMUX_DRVGRP_UART2] = "uart2",
+	[PMUX_DRVGRP_UART3] = "uart3",
+	[PMUX_DRVGRP_SDIO1] = "sdio1",
+	[PMUX_DRVGRP_DDC] = "ddc",
+	[PMUX_DRVGRP_GMA] = "gma",
+	[PMUX_DRVGRP_GME] = "gme",
+	[PMUX_DRVGRP_GMF] = "gmf",
+	[PMUX_DRVGRP_GMG] = "gmg",
+	[PMUX_DRVGRP_GMH] = "gmh",
+	[PMUX_DRVGRP_OWR] = "owr",
+	[PMUX_DRVGRP_UDA] = "uda",
+	[PMUX_DRVGRP_GPV] = "gpv",
+	[PMUX_DRVGRP_DEV3] = "dev3",
+	[PMUX_DRVGRP_CEC] = "cec",
+	[PMUX_DRVGRP_AT6] = "at6",
+	[PMUX_DRVGRP_DAP5] = "dap5",
+	[PMUX_DRVGRP_USB_VBUS_EN] = "usb_vbus_en",
+	[PMUX_DRVGRP_AO3] = "ao3",
+	[PMUX_DRVGRP_AO0] = "ao0",
+	[PMUX_DRVGRP_HV0] = "hv0",
+	[PMUX_DRVGRP_SDIO4] = "sdio4",
+	[PMUX_DRVGRP_AO4] = "ao4",
+};
+
+static const char * const tegra_pinctrl_to_func[] = {
+	[PMUX_FUNC_DEFAULT] = "default",
+	[PMUX_FUNC_BLINK] = "blink",
+	[PMUX_FUNC_CCLA] = "ccla",
+	[PMUX_FUNC_CEC] = "cec",
+	[PMUX_FUNC_CLDVFS] = "cldvfs",
+	[PMUX_FUNC_CLK] = "clk",
+	[PMUX_FUNC_CLK12] = "clk12",
+	[PMUX_FUNC_CPU] = "cpu",
+	[PMUX_FUNC_CSI] = "csi",
+	[PMUX_FUNC_DAP] = "dap",
+	[PMUX_FUNC_DAP1] = "dap1",
+	[PMUX_FUNC_DAP2] = "dap2",
+	[PMUX_FUNC_DEV3] = "dev3",
+	[PMUX_FUNC_DISPLAYA] = "displaya",
+	[PMUX_FUNC_DISPLAYA_ALT] = "displaya_alt",
+	[PMUX_FUNC_DISPLAYB] = "displayb",
+	[PMUX_FUNC_DP] = "dp",
+	[PMUX_FUNC_DSI_B] = "dsi_b",
+	[PMUX_FUNC_DTV] = "dtv",
+	[PMUX_FUNC_EXTPERIPH1] = "extperiph1",
+	[PMUX_FUNC_EXTPERIPH2] = "extperiph2",
+	[PMUX_FUNC_EXTPERIPH3] = "extperiph3",
+	[PMUX_FUNC_GMI] = "gmi",
+	[PMUX_FUNC_GMI_ALT] = "gmi_alt",
+	[PMUX_FUNC_HDA] = "hda",
+	[PMUX_FUNC_HSI] = "hsi",
+	[PMUX_FUNC_I2C1] = "i2c1",
+	[PMUX_FUNC_I2C2] = "i2c2",
+	[PMUX_FUNC_I2C3] = "i2c3",
+	[PMUX_FUNC_I2C4] = "i2c4",
+	[PMUX_FUNC_I2CPWR] = "i2cpwr",
+	[PMUX_FUNC_I2S0] = "i2s0",
+	[PMUX_FUNC_I2S1] = "i2s1",
+	[PMUX_FUNC_I2S2] = "i2s2",
+	[PMUX_FUNC_I2S3] = "i2s3",
+	[PMUX_FUNC_I2S4] = "i2s4",
+	[PMUX_FUNC_IRDA] = "irda",
+	[PMUX_FUNC_KBC] = "kbc",
+	[PMUX_FUNC_OWR] = "owr",
+	[PMUX_FUNC_PE] = "pe",
+	[PMUX_FUNC_PE0] = "pe0",
+	[PMUX_FUNC_PE1] = "pe1",
+	[PMUX_FUNC_PMI] = "pmi",
+	[PMUX_FUNC_PWM0] = "pwm0",
+	[PMUX_FUNC_PWM1] = "pwm1",
+	[PMUX_FUNC_PWM2] = "pwm2",
+	[PMUX_FUNC_PWM3] = "pwm3",
+	[PMUX_FUNC_PWRON] = "pwron",
+	[PMUX_FUNC_RESET_OUT_N] = "reset_out_n",
+	[PMUX_FUNC_RTCK] = "rtck",
+	[PMUX_FUNC_SATA] = "sata",
+	[PMUX_FUNC_SDMMC1] = "sdmmc1",
+	[PMUX_FUNC_SDMMC2] = "sdmmc2",
+	[PMUX_FUNC_SDMMC3] = "sdmmc3",
+	[PMUX_FUNC_SDMMC4] = "sdmmc4",
+	[PMUX_FUNC_SOC] = "soc",
+	[PMUX_FUNC_SPDIF] = "spdif",
+	[PMUX_FUNC_SPI1] = "spi1",
+	[PMUX_FUNC_SPI2] = "spi2",
+	[PMUX_FUNC_SPI3] = "spi3",
+	[PMUX_FUNC_SPI4] = "spi4",
+	[PMUX_FUNC_SPI5] = "spi5",
+	[PMUX_FUNC_SPI6] = "spi6",
+	[PMUX_FUNC_SYS] = "sys",
+	[PMUX_FUNC_TMDS] = "tmds",
+	[PMUX_FUNC_TRACE] = "trace",
+	[PMUX_FUNC_UARTA] = "uarta",
+	[PMUX_FUNC_UARTB] = "uartb",
+	[PMUX_FUNC_UARTC] = "uartc",
+	[PMUX_FUNC_UARTD] = "uartd",
+	[PMUX_FUNC_ULPI] = "ulpi",
+	[PMUX_FUNC_USB] = "usb",
+	[PMUX_FUNC_VGP1] = "vgp1",
+	[PMUX_FUNC_VGP2] = "vgp2",
+	[PMUX_FUNC_VGP3] = "vgp3",
+	[PMUX_FUNC_VGP4] = "vgp4",
+	[PMUX_FUNC_VGP5] = "vgp5",
+	[PMUX_FUNC_VGP6] = "vgp6",
+	[PMUX_FUNC_VI] = "vi",
+	[PMUX_FUNC_VI_ALT1] = "vi_alt1",
+	[PMUX_FUNC_VI_ALT3] = "vi_alt3",
+	[PMUX_FUNC_VIMCLK2] = "vimclk2",
+	[PMUX_FUNC_VIMCLK2_ALT] = "vimclk2_alt",
+	[PMUX_FUNC_RSVD1] = "rsvd1",
+	[PMUX_FUNC_RSVD2] = "rsvd2",
+	[PMUX_FUNC_RSVD3] = "rsvd3",
+	[PMUX_FUNC_RSVD4] = "rsvd4",
+};
+
 #define TEGRA_PMX_SOC_DRV_GROUP_BASE_REG 0x868
 #define TEGRA_PMX_SOC_MIPIPADCTRL_BASE_REG 0x820
 #define TEGRA_PMX_SOC_HAS_IO_CLAMPING
diff --git a/arch/arm/include/asm/arch-tegra20/pinmux.h b/arch/arm/include/asm/arch-tegra20/pinmux.h
index e9e3801e6f..8c8579e87e 100644
--- a/arch/arm/include/asm/arch-tegra20/pinmux.h
+++ b/arch/arm/include/asm/arch-tegra20/pinmux.h
@@ -159,6 +159,47 @@ enum pmux_pingrp {
 	PMUX_PINGRP_COUNT,
 };
 
+enum pmux_drvgrp {
+	PMUX_DRVGRP_AO1,
+	PMUX_DRVGRP_AO2,
+	PMUX_DRVGRP_AT1,
+	PMUX_DRVGRP_AT2,
+	PMUX_DRVGRP_CDEV1,
+	PMUX_DRVGRP_CDEV2,
+	PMUX_DRVGRP_CSUS,
+	PMUX_DRVGRP_DAP1,
+	PMUX_DRVGRP_DAP2,
+	PMUX_DRVGRP_DAP3,
+	PMUX_DRVGRP_DAP4,
+	PMUX_DRVGRP_DBG,
+	PMUX_DRVGRP_LCD1,
+	PMUX_DRVGRP_LCD2,
+	PMUX_DRVGRP_SDIO2,
+	PMUX_DRVGRP_SDIO3,
+	PMUX_DRVGRP_SPI,
+	PMUX_DRVGRP_UAA,
+	PMUX_DRVGRP_UAB,
+	PMUX_DRVGRP_UART2,
+	PMUX_DRVGRP_UART3,
+	PMUX_DRVGRP_VI1,
+	PMUX_DRVGRP_VI2,
+	PMUX_DRVGRP_XM2A,
+	PMUX_DRVGRP_XM2C,
+	PMUX_DRVGRP_XM2D,
+	PMUX_DRVGRP_XM2CLK,
+	PMUX_DRVGRP_SDIO1 = (0x78 / 4),
+	PMUX_DRVGRP_CRT = (0x84 / 4),
+	PMUX_DRVGRP_DDC,
+	PMUX_DRVGRP_GMA,
+	PMUX_DRVGRP_GMB,
+	PMUX_DRVGRP_GMC,
+	PMUX_DRVGRP_GMD,
+	PMUX_DRVGRP_GME,
+	PMUX_DRVGRP_OWR,
+	PMUX_DRVGRP_UDA,
+	PMUX_DRVGRP_COUNT,
+};
+
 /*
  * Functions which can be assigned to each of the pin groups. The values here
  * bear no relation to the values programmed into pinmux registers and are
@@ -232,6 +273,256 @@ enum pmux_func {
 	PMUX_FUNC_COUNT,
 };
 
+static const char * const tegra_pinctrl_to_pingrp[] = {
+	/* APB_MISC_PP_TRISTATE_REG_A_0 */
+	[PMUX_PINGRP_ATA] = "ata",
+	[PMUX_PINGRP_ATB] = "atb",
+	[PMUX_PINGRP_ATC] = "atc",
+	[PMUX_PINGRP_ATD] = "atd",
+	[PMUX_PINGRP_CDEV1] = "cdev1",
+	[PMUX_PINGRP_CDEV2] = "cdev2",
+	[PMUX_PINGRP_CSUS] = "csus",
+	[PMUX_PINGRP_DAP1] = "dap1",
+
+	[PMUX_PINGRP_DAP2] = "dap2",
+	[PMUX_PINGRP_DAP3] = "dap3",
+	[PMUX_PINGRP_DAP4] = "dap4",
+	[PMUX_PINGRP_DTA] = "dta",
+	[PMUX_PINGRP_DTB] = "dtb",
+	[PMUX_PINGRP_DTC] = "dtc",
+	[PMUX_PINGRP_DTD] = "dtd",
+	[PMUX_PINGRP_DTE] = "dte",
+
+	[PMUX_PINGRP_GPU] = "gpu",
+	[PMUX_PINGRP_GPV] = "gpv",
+	[PMUX_PINGRP_I2CP] = "i2cp",
+	[PMUX_PINGRP_IRTX] = "irtx",
+	[PMUX_PINGRP_IRRX] = "irrx",
+	[PMUX_PINGRP_KBCB] = "kbcb",
+	[PMUX_PINGRP_KBCA] = "kbca",
+	[PMUX_PINGRP_PMC] = "pmc",
+
+	[PMUX_PINGRP_PTA] = "pta",
+	[PMUX_PINGRP_RM] = "rm",
+	[PMUX_PINGRP_KBCE] = "kbce",
+	[PMUX_PINGRP_KBCF] = "kbcf",
+	[PMUX_PINGRP_GMA] = "gma",
+	[PMUX_PINGRP_GMC] = "gmc",
+	[PMUX_PINGRP_SDIO1] = "sdio1",
+	[PMUX_PINGRP_OWC] = "owc",
+
+	/* 32: APB_MISC_PP_TRISTATE_REG_B_0 */
+	[PMUX_PINGRP_GME] = "gme",
+	[PMUX_PINGRP_SDC] = "sdc",
+	[PMUX_PINGRP_SDD] = "sdd",
+	[PMUX_PINGRP_RESERVED0] = "reserved0",
+	[PMUX_PINGRP_SLXA] = "slxa",
+	[PMUX_PINGRP_SLXC] = "slxc",
+	[PMUX_PINGRP_SLXD] = "slxd",
+	[PMUX_PINGRP_SLXK] = "slxk",
+
+	[PMUX_PINGRP_SPDI] = "spdi",
+	[PMUX_PINGRP_SPDO] = "spdo",
+	[PMUX_PINGRP_SPIA] = "spia",
+	[PMUX_PINGRP_SPIB] = "spib",
+	[PMUX_PINGRP_SPIC] = "spic",
+	[PMUX_PINGRP_SPID] = "spid",
+	[PMUX_PINGRP_SPIE] = "spie",
+	[PMUX_PINGRP_SPIF] = "spif",
+
+	[PMUX_PINGRP_SPIG] = "spig",
+	[PMUX_PINGRP_SPIH] = "spih",
+	[PMUX_PINGRP_UAA] = "uaa",
+	[PMUX_PINGRP_UAB] = "uab",
+	[PMUX_PINGRP_UAC] = "uac",
+	[PMUX_PINGRP_UAD] = "uad",
+	[PMUX_PINGRP_UCA] = "uca",
+	[PMUX_PINGRP_UCB] = "ucb",
+
+	[PMUX_PINGRP_RESERVED1] = "reserved1",
+	[PMUX_PINGRP_ATE] = "ate",
+	[PMUX_PINGRP_KBCC] = "kbcc",
+	[PMUX_PINGRP_RESERVED2] = "reserved2",
+	[PMUX_PINGRP_RESERVED3] = "reserved3",
+	[PMUX_PINGRP_GMB] = "gmb",
+	[PMUX_PINGRP_GMD] = "gmd",
+	[PMUX_PINGRP_DDC] = "ddc",
+
+	/* 64: APB_MISC_PP_TRISTATE_REG_C_0 */
+	[PMUX_PINGRP_LD0] = "ld0",
+	[PMUX_PINGRP_LD1] = "ld1",
+	[PMUX_PINGRP_LD2] = "ld2",
+	[PMUX_PINGRP_LD3] = "ld3",
+	[PMUX_PINGRP_LD4] = "ld4",
+	[PMUX_PINGRP_LD5] = "ld5",
+	[PMUX_PINGRP_LD6] = "ld6",
+	[PMUX_PINGRP_LD7] = "ld7",
+
+	[PMUX_PINGRP_LD8] = "ld8",
+	[PMUX_PINGRP_LD9] = "ld9",
+	[PMUX_PINGRP_LD10] = "ld10",
+	[PMUX_PINGRP_LD11] = "ld11",
+	[PMUX_PINGRP_LD12] = "ld12",
+	[PMUX_PINGRP_LD13] = "ld13",
+	[PMUX_PINGRP_LD14] = "ld14",
+	[PMUX_PINGRP_LD15] = "ld15",
+
+	[PMUX_PINGRP_LD16] = "ld16",
+	[PMUX_PINGRP_LD17] = "ld17",
+	[PMUX_PINGRP_LHP0] = "lhp0",
+	[PMUX_PINGRP_LHP1] = "lhp1",
+	[PMUX_PINGRP_LHP2] = "lhp2",
+	[PMUX_PINGRP_LVP0] = "lvp0",
+	[PMUX_PINGRP_LVP1] = "lvp1",
+	[PMUX_PINGRP_HDINT] = "hdint",
+
+	[PMUX_PINGRP_LM0] = "lm0",
+	[PMUX_PINGRP_LM1] = "lm1",
+	[PMUX_PINGRP_LVS] = "lvs",
+	[PMUX_PINGRP_LSC0] = "lsc0",
+	[PMUX_PINGRP_LSC1] = "lsc1",
+	[PMUX_PINGRP_LSCK] = "lsck",
+	[PMUX_PINGRP_LDC] = "ldc",
+	[PMUX_PINGRP_LCSN] = "lcsn",
+
+	/* 96: APB_MISC_PP_TRISTATE_REG_D_0 */
+	[PMUX_PINGRP_LSPI] = "lspi",
+	[PMUX_PINGRP_LSDA] = "lsda",
+	[PMUX_PINGRP_LSDI] = "lsdi",
+	[PMUX_PINGRP_LPW0] = "lpw0",
+	[PMUX_PINGRP_LPW1] = "lpw1",
+	[PMUX_PINGRP_LPW2] = "lpw2",
+	[PMUX_PINGRP_LDI] = "ldi",
+	[PMUX_PINGRP_LHS] = "lhs",
+
+	[PMUX_PINGRP_LPP] = "lpp",
+	[PMUX_PINGRP_RESERVED4] = "reserved4",
+	[PMUX_PINGRP_KBCD] = "kbcd",
+	[PMUX_PINGRP_GPU7] = "gpu7",
+	[PMUX_PINGRP_DTF] = "dtf",
+	[PMUX_PINGRP_UDA] = "uda",
+	[PMUX_PINGRP_CRTP] = "crtp",
+	[PMUX_PINGRP_SDB] = "sdb",
+
+	/* these pin groups only have pullup and pull down control */
+	[PMUX_PINGRP_CK32] = "ck32",
+	[PMUX_PINGRP_DDRC] = "ddrc",
+	[PMUX_PINGRP_PMCA] = "pmca",
+	[PMUX_PINGRP_PMCB] = "pmcb",
+	[PMUX_PINGRP_PMCC] = "pmcc",
+	[PMUX_PINGRP_PMCD] = "pmcd",
+	[PMUX_PINGRP_PMCE] = "pmce",
+	[PMUX_PINGRP_XM2C] = "xm2c",
+	[PMUX_PINGRP_XM2D] = "xm2d",
+};
+
+static const char * const tegra_pinctrl_to_drvgrp[] = {
+	[PMUX_DRVGRP_AO1] = "drive_ao1",
+	[PMUX_DRVGRP_AO2] = "drive_ao2",
+	[PMUX_DRVGRP_AT1] = "drive_at1",
+	[PMUX_DRVGRP_AT2] = "drive_at2",
+	[PMUX_DRVGRP_CDEV1] = "drive_cdev1",
+	[PMUX_DRVGRP_CDEV2] = "drive_cdev2",
+	[PMUX_DRVGRP_CSUS] = "drive_csus",
+	[PMUX_DRVGRP_DAP1] = "drive_dap1",
+	[PMUX_DRVGRP_DAP2] = "drive_dap2",
+	[PMUX_DRVGRP_DAP3] = "drive_dap3",
+	[PMUX_DRVGRP_DAP4] = "drive_dap4",
+	[PMUX_DRVGRP_DBG] = "drive_dbg",
+	[PMUX_DRVGRP_LCD1] = "drive_lcd1",
+	[PMUX_DRVGRP_LCD2] = "drive_lcd2",
+	[PMUX_DRVGRP_SDIO2] = "drive_sdio2",
+	[PMUX_DRVGRP_SDIO3] = "drive_sdio3",
+	[PMUX_DRVGRP_SPI] = "drive_spi",
+	[PMUX_DRVGRP_UAA] = "drive_uaa",
+	[PMUX_DRVGRP_UAB] = "drive_uab",
+	[PMUX_DRVGRP_UART2] = "drive_uart2",
+	[PMUX_DRVGRP_UART3] = "drive_uart3",
+	[PMUX_DRVGRP_VI1] = "drive_vi1",
+	[PMUX_DRVGRP_VI2] = "drive_vi2",
+	[PMUX_DRVGRP_XM2A] = "drive_xm2a",
+	[PMUX_DRVGRP_XM2C] = "drive_xm2c",
+	[PMUX_DRVGRP_XM2D] = "drive_xm2d",
+	[PMUX_DRVGRP_XM2CLK] = "drive_xm2clk",
+	[PMUX_DRVGRP_SDIO1] = "drive_sdio1",
+	[PMUX_DRVGRP_CRT] = "drive_crt",
+	[PMUX_DRVGRP_DDC] = "drive_ddc",
+	[PMUX_DRVGRP_GMA] = "drive_gma",
+	[PMUX_DRVGRP_GMB] = "drive_gmb",
+	[PMUX_DRVGRP_GMC] = "drive_gmc",
+	[PMUX_DRVGRP_GMD] = "drive_gmd",
+	[PMUX_DRVGRP_GME] = "drive_gme",
+	[PMUX_DRVGRP_OWR] = "drive_owr",
+	[PMUX_DRVGRP_UDA] = "drive_uda",
+};
+
+static const char * const tegra_pinctrl_to_func[] = {
+	[PMUX_FUNC_DEFAULT] = "default",
+	[PMUX_FUNC_AHB_CLK] = "ahb_clk",
+	[PMUX_FUNC_APB_CLK] = "apb_clk",
+	[PMUX_FUNC_AUDIO_SYNC] = "audio_sync",
+	[PMUX_FUNC_CRT] = "crt",
+	[PMUX_FUNC_DAP1] = "dap1",
+	[PMUX_FUNC_DAP2] = "dap2",
+	[PMUX_FUNC_DAP3] = "dap3",
+	[PMUX_FUNC_DAP4] = "dap4",
+	[PMUX_FUNC_DAP5] = "dap5",
+	[PMUX_FUNC_DISPA] = "dispa",
+	[PMUX_FUNC_DISPB] = "dispb",
+	[PMUX_FUNC_EMC_TEST0_DLL] = "emc_test0_dll",
+	[PMUX_FUNC_EMC_TEST1_DLL] = "emc_test1_dll",
+	[PMUX_FUNC_GMI] = "gmi",
+	[PMUX_FUNC_GMI_INT] = "gmi_int",
+	[PMUX_FUNC_HDMI] = "hdmi",
+	[PMUX_FUNC_I2C] = "i2c",
+	[PMUX_FUNC_I2C2] = "i2c2",
+	[PMUX_FUNC_I2C3] = "i2c3",
+	[PMUX_FUNC_IDE] = "ide",
+	[PMUX_FUNC_KBC] = "kbc",
+	[PMUX_FUNC_MIO] = "mio",
+	[PMUX_FUNC_MIPI_HS] = "mipi_hs",
+	[PMUX_FUNC_NAND] = "nand",
+	[PMUX_FUNC_OSC] = "osc",
+	[PMUX_FUNC_OWR] = "owr",
+	[PMUX_FUNC_PCIE] = "pcie",
+	[PMUX_FUNC_PLLA_OUT] = "plla_out",
+	[PMUX_FUNC_PLLC_OUT1] = "pllc_out1",
+	[PMUX_FUNC_PLLM_OUT1] = "pllm_out1",
+	[PMUX_FUNC_PLLP_OUT2] = "pllp_out2",
+	[PMUX_FUNC_PLLP_OUT3] = "pllp_out3",
+	[PMUX_FUNC_PLLP_OUT4] = "pllp_out4",
+	[PMUX_FUNC_PWM] = "pwm",
+	[PMUX_FUNC_PWR_INTR] = "pwr_intr",
+	[PMUX_FUNC_PWR_ON] = "pwr_on",
+	[PMUX_FUNC_RTCK] = "rtck",
+	[PMUX_FUNC_SDIO1] = "sdio1",
+	[PMUX_FUNC_SDIO2] = "sdio2",
+	[PMUX_FUNC_SDIO3] = "sdio3",
+	[PMUX_FUNC_SDIO4] = "sdio4",
+	[PMUX_FUNC_SFLASH] = "sflash",
+	[PMUX_FUNC_SPDIF] = "spdif",
+	[PMUX_FUNC_SPI1] = "spi1",
+	[PMUX_FUNC_SPI2] = "spi2",
+	[PMUX_FUNC_SPI2_ALT] = "spi2_alt",
+	[PMUX_FUNC_SPI3] = "spi3",
+	[PMUX_FUNC_SPI4] = "spi4",
+	[PMUX_FUNC_TRACE] = "trace",
+	[PMUX_FUNC_TWC] = "twc",
+	[PMUX_FUNC_UARTA] = "uarta",
+	[PMUX_FUNC_UARTB] = "uartb",
+	[PMUX_FUNC_UARTC] = "uartc",
+	[PMUX_FUNC_UARTD] = "uartd",
+	[PMUX_FUNC_UARTE] = "uarte",
+	[PMUX_FUNC_ULPI] = "ulpi",
+	[PMUX_FUNC_VI] = "vi",
+	[PMUX_FUNC_VI_SENSOR_CLK] = "vi_sensor_clk",
+	[PMUX_FUNC_XIO] = "xio",
+	[PMUX_FUNC_RSVD1] = "rsvd1",
+	[PMUX_FUNC_RSVD2] = "rsvd2",
+	[PMUX_FUNC_RSVD3] = "rsvd3",
+	[PMUX_FUNC_RSVD4] = "rsvd4",
+};
+
 #define TEGRA_PMX_SOC_DRV_GROUP_BASE_REG 0x868
 #include <asm/arch-tegra/pinmux.h>
 
diff --git a/arch/arm/include/asm/arch-tegra210/pinmux.h b/arch/arm/include/asm/arch-tegra210/pinmux.h
index 9e94074628..062d724319 100644
--- a/arch/arm/include/asm/arch-tegra210/pinmux.h
+++ b/arch/arm/include/asm/arch-tegra210/pinmux.h
@@ -403,6 +403,400 @@ enum pmux_func {
 	PMUX_FUNC_COUNT,
 };
 
+static const char * const tegra_pinctrl_to_pingrp[] = {
+	[PMUX_PINGRP_SDMMC1_CLK_PM0] = "sdmmc1_clk_pm0",
+	[PMUX_PINGRP_SDMMC1_CMD_PM1] = "sdmmc1_cmd_pm1",
+	[PMUX_PINGRP_SDMMC1_DAT3_PM2] = "sdmmc1_dat3_pm2",
+	[PMUX_PINGRP_SDMMC1_DAT2_PM3] = "sdmmc1_dat2_pm3",
+	[PMUX_PINGRP_SDMMC1_DAT1_PM4] = "sdmmc1_dat1_pm4",
+	[PMUX_PINGRP_SDMMC1_DAT0_PM5] = "sdmmc1_dat0_pm5",
+	[PMUX_PINGRP_SDMMC3_CLK_PP0] = "sdmmc3_clk_pp0",
+	[PMUX_PINGRP_SDMMC3_CMD_PP1] = "sdmmc3_cmd_pp1",
+	[PMUX_PINGRP_SDMMC3_DAT0_PP5] = "sdmmc3_dat0_pp5",
+	[PMUX_PINGRP_SDMMC3_DAT1_PP4] = "sdmmc3_dat1_pp4",
+	[PMUX_PINGRP_SDMMC3_DAT2_PP3] = "sdmmc3_dat2_pp3",
+	[PMUX_PINGRP_SDMMC3_DAT3_PP2] = "sdmmc3_dat3_pp2",
+	[PMUX_PINGRP_PEX_L0_RST_N_PA0] = "pex_l0_rst_n_pa0",
+	[PMUX_PINGRP_PEX_L0_CLKREQ_N_PA1] = "pex_l0_clkreq_n_pa1",
+	[PMUX_PINGRP_PEX_WAKE_N_PA2] = "pex_wake_n_pa2",
+	[PMUX_PINGRP_PEX_L1_RST_N_PA3] = "pex_l1_rst_n_pa3",
+	[PMUX_PINGRP_PEX_L1_CLKREQ_N_PA4] = "pex_l1_clkreq_n_pa4",
+	[PMUX_PINGRP_SATA_LED_ACTIVE_PA5] = "sata_led_active_pa5",
+	[PMUX_PINGRP_SPI1_MOSI_PC0] = "spi1_mosi_pc0",
+	[PMUX_PINGRP_SPI1_MISO_PC1] = "spi1_miso_pc1",
+	[PMUX_PINGRP_SPI1_SCK_PC2] = "spi1_sck_pc2",
+	[PMUX_PINGRP_SPI1_CS0_PC3] = "spi1_cs0_pc3",
+	[PMUX_PINGRP_SPI1_CS1_PC4] = "spi1_cs1_pc4",
+	[PMUX_PINGRP_SPI2_MOSI_PB4] = "spi2_mosi_pb4",
+	[PMUX_PINGRP_SPI2_MISO_PB5] = "spi2_miso_pb5",
+	[PMUX_PINGRP_SPI2_SCK_PB6] = "spi2_sck_pb6",
+	[PMUX_PINGRP_SPI2_CS0_PB7] = "spi2_cs0_pb7",
+	[PMUX_PINGRP_SPI2_CS1_PDD0] = "spi2_cs1_pdd0",
+	[PMUX_PINGRP_SPI4_MOSI_PC7] = "spi4_mosi_pc7",
+	[PMUX_PINGRP_SPI4_MISO_PD0] = "spi4_miso_pd0",
+	[PMUX_PINGRP_SPI4_SCK_PC5] = "spi4_sck_pc5",
+	[PMUX_PINGRP_SPI4_CS0_PC6] = "spi4_cs0_pc6",
+	[PMUX_PINGRP_QSPI_SCK_PEE0] = "qspi_sck_pee0",
+	[PMUX_PINGRP_QSPI_CS_N_PEE1] = "qspi_cs_n_pee1",
+	[PMUX_PINGRP_QSPI_IO0_PEE2] = "qspi_io0_pee2",
+	[PMUX_PINGRP_QSPI_IO1_PEE3] = "qspi_io1_pee3",
+	[PMUX_PINGRP_QSPI_IO2_PEE4] = "qspi_io2_pee4",
+	[PMUX_PINGRP_QSPI_IO3_PEE5] = "qspi_io3_pee5",
+	[PMUX_PINGRP_DMIC1_CLK_PE0] = "dmic1_clk_pe0",
+	[PMUX_PINGRP_DMIC1_DAT_PE1] = "dmic1_dat_pe1",
+	[PMUX_PINGRP_DMIC2_CLK_PE2] = "dmic2_clk_pe2",
+	[PMUX_PINGRP_DMIC2_DAT_PE3] = "dmic2_dat_pe3",
+	[PMUX_PINGRP_DMIC3_CLK_PE4] = "dmic3_clk_pe4",
+	[PMUX_PINGRP_DMIC3_DAT_PE5] = "dmic3_dat_pe5",
+	[PMUX_PINGRP_GEN1_I2C_SCL_PJ1] = "gen1_i2c_scl_pj1",
+	[PMUX_PINGRP_GEN1_I2C_SDA_PJ0] = "gen1_i2c_sda_pj0",
+	[PMUX_PINGRP_GEN2_I2C_SCL_PJ2] = "gen2_i2c_scl_pj2",
+	[PMUX_PINGRP_GEN2_I2C_SDA_PJ3] = "gen2_i2c_sda_pj3",
+	[PMUX_PINGRP_GEN3_I2C_SCL_PF0] = "gen3_i2c_scl_pf0",
+	[PMUX_PINGRP_GEN3_I2C_SDA_PF1] = "gen3_i2c_sda_pf1",
+	[PMUX_PINGRP_CAM_I2C_SCL_PS2] = "cam_i2c_scl_ps2",
+	[PMUX_PINGRP_CAM_I2C_SDA_PS3] = "cam_i2c_sda_ps3",
+	[PMUX_PINGRP_PWR_I2C_SCL_PY3] = "pwr_i2c_scl_py3",
+	[PMUX_PINGRP_PWR_I2C_SDA_PY4] = "pwr_i2c_sda_py4",
+	[PMUX_PINGRP_UART1_TX_PU0] = "uart1_tx_pu0",
+	[PMUX_PINGRP_UART1_RX_PU1] = "uart1_rx_pu1",
+	[PMUX_PINGRP_UART1_RTS_PU2] = "uart1_rts_pu2",
+	[PMUX_PINGRP_UART1_CTS_PU3] = "uart1_cts_pu3",
+	[PMUX_PINGRP_UART2_TX_PG0] = "uart2_tx_pg0",
+	[PMUX_PINGRP_UART2_RX_PG1] = "uart2_rx_pg1",
+	[PMUX_PINGRP_UART2_RTS_PG2] = "uart2_rts_pg2",
+	[PMUX_PINGRP_UART2_CTS_PG3] = "uart2_cts_pg3",
+	[PMUX_PINGRP_UART3_TX_PD1] = "uart3_tx_pd1",
+	[PMUX_PINGRP_UART3_RX_PD2] = "uart3_rx_pd2",
+	[PMUX_PINGRP_UART3_RTS_PD3] = "uart3_rts_pd3",
+	[PMUX_PINGRP_UART3_CTS_PD4] = "uart3_cts_pd4",
+	[PMUX_PINGRP_UART4_TX_PI4] = "uart4_tx_pi4",
+	[PMUX_PINGRP_UART4_RX_PI5] = "uart4_rx_pi5",
+	[PMUX_PINGRP_UART4_RTS_PI6] = "uart4_rts_pi6",
+	[PMUX_PINGRP_UART4_CTS_PI7] = "uart4_cts_pi7",
+	[PMUX_PINGRP_DAP1_FS_PB0] = "dap1_fs_pb0",
+	[PMUX_PINGRP_DAP1_DIN_PB1] = "dap1_din_pb1",
+	[PMUX_PINGRP_DAP1_DOUT_PB2] = "dap1_dout_pb2",
+	[PMUX_PINGRP_DAP1_SCLK_PB3] = "dap1_sclk_pb3",
+	[PMUX_PINGRP_DAP2_FS_PAA0] = "dap2_fs_paa0",
+	[PMUX_PINGRP_DAP2_DIN_PAA2] = "dap2_din_paa2",
+	[PMUX_PINGRP_DAP2_DOUT_PAA3] = "dap2_dout_paa3",
+	[PMUX_PINGRP_DAP2_SCLK_PAA1] = "dap2_sclk_paa1",
+	[PMUX_PINGRP_DAP4_FS_PJ4] = "dap4_fs_pj4",
+	[PMUX_PINGRP_DAP4_DIN_PJ5] = "dap4_din_pj5",
+	[PMUX_PINGRP_DAP4_DOUT_PJ6] = "dap4_dout_pj6",
+	[PMUX_PINGRP_DAP4_SCLK_PJ7] = "dap4_sclk_pj7",
+	[PMUX_PINGRP_CAM1_MCLK_PS0] = "cam1_mclk_ps0",
+	[PMUX_PINGRP_CAM2_MCLK_PS1] = "cam2_mclk_ps1",
+	[PMUX_PINGRP_JTAG_RTCK] = "jtag_rtck",
+	[PMUX_PINGRP_CLK_32K_IN] = "clk_32k_in",
+	[PMUX_PINGRP_CLK_32K_OUT_PY5] = "clk_32k_out_py5",
+	[PMUX_PINGRP_BATT_BCL] = "batt_bcl",
+	[PMUX_PINGRP_CLK_REQ] = "clk_req",
+	[PMUX_PINGRP_CPU_PWR_REQ] = "cpu_pwr_req",
+	[PMUX_PINGRP_PWR_INT_N] = "pwr_int_n",
+	[PMUX_PINGRP_SHUTDOWN] = "shutdown",
+	[PMUX_PINGRP_CORE_PWR_REQ] = "core_pwr_req",
+	[PMUX_PINGRP_AUD_MCLK_PBB0] = "aud_mclk_pbb0",
+	[PMUX_PINGRP_DVFS_PWM_PBB1] = "dvfs_pwm_pbb1",
+	[PMUX_PINGRP_DVFS_CLK_PBB2] = "dvfs_clk_pbb2",
+	[PMUX_PINGRP_GPIO_X1_AUD_PBB3] = "gpio_x1_aud_pbb3",
+	[PMUX_PINGRP_GPIO_X3_AUD_PBB4] = "gpio_x3_aud_pbb4",
+	[PMUX_PINGRP_PCC7] = "pcc7",
+	[PMUX_PINGRP_HDMI_CEC_PCC0] = "hdmi_cec_pcc0",
+	[PMUX_PINGRP_HDMI_INT_DP_HPD_PCC1] = "hdmi_int_dp_hpd_pcc1",
+	[PMUX_PINGRP_SPDIF_OUT_PCC2] = "spdif_out_pcc2",
+	[PMUX_PINGRP_SPDIF_IN_PCC3] = "spdif_in_pcc3",
+	[PMUX_PINGRP_USB_VBUS_EN0_PCC4] = "usb_vbus_en0_pcc4",
+	[PMUX_PINGRP_USB_VBUS_EN1_PCC5] = "usb_vbus_en1_pcc5",
+	[PMUX_PINGRP_DP_HPD0_PCC6] = "dp_hpd0_pcc6",
+	[PMUX_PINGRP_WIFI_EN_PH0] = "wifi_en_ph0",
+	[PMUX_PINGRP_WIFI_RST_PH1] = "wifi_rst_ph1",
+	[PMUX_PINGRP_WIFI_WAKE_AP_PH2] = "wifi_wake_ap_ph2",
+	[PMUX_PINGRP_AP_WAKE_BT_PH3] = "ap_wake_bt_ph3",
+	[PMUX_PINGRP_BT_RST_PH4] = "bt_rst_ph4",
+	[PMUX_PINGRP_BT_WAKE_AP_PH5] = "bt_wake_ap_ph5",
+	[PMUX_PINGRP_AP_WAKE_NFC_PH7] = "ap_wake_nfc_ph7",
+	[PMUX_PINGRP_NFC_EN_PI0] = "nfc_en_pi0",
+	[PMUX_PINGRP_NFC_INT_PI1] = "nfc_int_pi1",
+	[PMUX_PINGRP_GPS_EN_PI2] = "gps_en_pi2",
+	[PMUX_PINGRP_GPS_RST_PI3] = "gps_rst_pi3",
+	[PMUX_PINGRP_CAM_RST_PS4] = "cam_rst_ps4",
+	[PMUX_PINGRP_CAM_AF_EN_PS5] = "cam_af_en_ps5",
+	[PMUX_PINGRP_CAM_FLASH_EN_PS6] = "cam_flash_en_ps6",
+	[PMUX_PINGRP_CAM1_PWDN_PS7] = "cam1_pwdn_ps7",
+	[PMUX_PINGRP_CAM2_PWDN_PT0] = "cam2_pwdn_pt0",
+	[PMUX_PINGRP_CAM1_STROBE_PT1] = "cam1_strobe_pt1",
+	[PMUX_PINGRP_LCD_TE_PY2] = "lcd_te_py2",
+	[PMUX_PINGRP_LCD_BL_PWM_PV0] = "lcd_bl_pwm_pv0",
+	[PMUX_PINGRP_LCD_BL_EN_PV1] = "lcd_bl_en_pv1",
+	[PMUX_PINGRP_LCD_RST_PV2] = "lcd_rst_pv2",
+	[PMUX_PINGRP_LCD_GPIO1_PV3] = "lcd_gpio1_pv3",
+	[PMUX_PINGRP_LCD_GPIO2_PV4] = "lcd_gpio2_pv4",
+	[PMUX_PINGRP_AP_READY_PV5] = "ap_ready_pv5",
+	[PMUX_PINGRP_TOUCH_RST_PV6] = "touch_rst_pv6",
+	[PMUX_PINGRP_TOUCH_CLK_PV7] = "touch_clk_pv7",
+	[PMUX_PINGRP_MODEM_WAKE_AP_PX0] = "modem_wake_ap_px0",
+	[PMUX_PINGRP_TOUCH_INT_PX1] = "touch_int_px1",
+	[PMUX_PINGRP_MOTION_INT_PX2] = "motion_int_px2",
+	[PMUX_PINGRP_ALS_PROX_INT_PX3] = "als_prox_int_px3",
+	[PMUX_PINGRP_TEMP_ALERT_PX4] = "temp_alert_px4",
+	[PMUX_PINGRP_BUTTON_POWER_ON_PX5] = "button_power_on_px5",
+	[PMUX_PINGRP_BUTTON_VOL_UP_PX6] = "button_vol_up_px6",
+	[PMUX_PINGRP_BUTTON_VOL_DOWN_PX7] = "button_vol_down_px7",
+	[PMUX_PINGRP_BUTTON_SLIDE_SW_PY0] = "button_slide_sw_py0",
+	[PMUX_PINGRP_BUTTON_HOME_PY1] = "button_home_py1",
+	[PMUX_PINGRP_PA6] = "pa6",
+	[PMUX_PINGRP_PE6] = "pe6",
+	[PMUX_PINGRP_PE7] = "pe7",
+	[PMUX_PINGRP_PH6] = "ph6",
+	[PMUX_PINGRP_PK0] = "pk0",
+	[PMUX_PINGRP_PK1] = "pk1",
+	[PMUX_PINGRP_PK2] = "pk2",
+	[PMUX_PINGRP_PK3] = "pk3",
+	[PMUX_PINGRP_PK4] = "pk4",
+	[PMUX_PINGRP_PK5] = "pk5",
+	[PMUX_PINGRP_PK6] = "pk6",
+	[PMUX_PINGRP_PK7] = "pk7",
+	[PMUX_PINGRP_PL0] = "pl0",
+	[PMUX_PINGRP_PL1] = "pl1",
+	[PMUX_PINGRP_PZ0] = "pz0",
+	[PMUX_PINGRP_PZ1] = "pz1",
+	[PMUX_PINGRP_PZ2] = "pz2",
+	[PMUX_PINGRP_PZ3] = "pz3",
+	[PMUX_PINGRP_PZ4] = "pz4",
+	[PMUX_PINGRP_PZ5] = "pz5",
+};
+
+static const char * const tegra_pinctrl_to_drvgrp[] = {
+	[PMUX_DRVGRP_ALS_PROX_INT] = "als_prox_int",
+	[PMUX_DRVGRP_AP_READY] = "ap_ready",
+	[PMUX_DRVGRP_AP_WAKE_BT] = "ap_wake_bt",
+	[PMUX_DRVGRP_AP_WAKE_NFC] = "ap_wake_nfc",
+	[PMUX_DRVGRP_AUD_MCLK] = "aud_mclk",
+	[PMUX_DRVGRP_BATT_BCL] = "batt_bcl",
+	[PMUX_DRVGRP_BT_RST] = "bt_rst",
+	[PMUX_DRVGRP_BT_WAKE_AP] = "bt_wake_ap",
+	[PMUX_DRVGRP_BUTTON_HOME] = "button_home",
+	[PMUX_DRVGRP_BUTTON_POWER_ON] = "button_power_on",
+	[PMUX_DRVGRP_BUTTON_SLIDE_SW] = "button_slide_sw",
+	[PMUX_DRVGRP_BUTTON_VOL_DOWN] = "button_vol_down",
+	[PMUX_DRVGRP_BUTTON_VOL_UP] = "button_vol_up",
+	[PMUX_DRVGRP_CAM1_MCLK] = "cam1_mclk",
+	[PMUX_DRVGRP_CAM1_PWDN] = "cam1_pwdn",
+	[PMUX_DRVGRP_CAM1_STROBE] = "cam1_strobe",
+	[PMUX_DRVGRP_CAM2_MCLK] = "cam2_mclk",
+	[PMUX_DRVGRP_CAM2_PWDN] = "cam2_pwdn",
+	[PMUX_DRVGRP_CAM_AF_EN] = "cam_af_en",
+	[PMUX_DRVGRP_CAM_FLASH_EN] = "cam_flash_en",
+	[PMUX_DRVGRP_CAM_I2C_SCL] = "cam_i2c_scl",
+	[PMUX_DRVGRP_CAM_I2C_SDA] = "cam_i2c_sda",
+	[PMUX_DRVGRP_CAM_RST] = "cam_rst",
+	[PMUX_DRVGRP_CLK_32K_IN] = "clk_32k_in",
+	[PMUX_DRVGRP_CLK_32K_OUT] = "clk_32k_out",
+	[PMUX_DRVGRP_CLK_REQ] = "clk_req",
+	[PMUX_DRVGRP_CORE_PWR_REQ] = "core_pwr_req",
+	[PMUX_DRVGRP_CPU_PWR_REQ] = "cpu_pwr_req",
+	[PMUX_DRVGRP_DAP1_DIN] = "dap1_din",
+	[PMUX_DRVGRP_DAP1_DOUT] = "dap1_dout",
+	[PMUX_DRVGRP_DAP1_FS] = "dap1_fs",
+	[PMUX_DRVGRP_DAP1_SCLK] = "dap1_sclk",
+	[PMUX_DRVGRP_DAP2_DIN] = "dap2_din",
+	[PMUX_DRVGRP_DAP2_DOUT] = "dap2_dout",
+	[PMUX_DRVGRP_DAP2_FS] = "dap2_fs",
+	[PMUX_DRVGRP_DAP2_SCLK] = "dap2_sclk",
+	[PMUX_DRVGRP_DAP4_DIN] = "dap4_din",
+	[PMUX_DRVGRP_DAP4_DOUT] = "dap4_dout",
+	[PMUX_DRVGRP_DAP4_FS] = "dap4_fs",
+	[PMUX_DRVGRP_DAP4_SCLK] = "dap4_sclk",
+	[PMUX_DRVGRP_DMIC1_CLK] = "dmic1_clk",
+	[PMUX_DRVGRP_DMIC1_DAT] = "dmic1_dat",
+	[PMUX_DRVGRP_DMIC2_CLK] = "dmic2_clk",
+	[PMUX_DRVGRP_DMIC2_DAT] = "dmic2_dat",
+	[PMUX_DRVGRP_DMIC3_CLK] = "dmic3_clk",
+	[PMUX_DRVGRP_DMIC3_DAT] = "dmic3_dat",
+	[PMUX_DRVGRP_DP_HPD0] = "dp_hpd0",
+	[PMUX_DRVGRP_DVFS_CLK] = "dvfs_clk",
+	[PMUX_DRVGRP_DVFS_PWM] = "dvfs_pwm",
+	[PMUX_DRVGRP_GEN1_I2C_SCL] = "gen1_i2c_scl",
+	[PMUX_DRVGRP_GEN1_I2C_SDA] = "gen1_i2c_sda",
+	[PMUX_DRVGRP_GEN2_I2C_SCL] = "gen2_i2c_scl",
+	[PMUX_DRVGRP_GEN2_I2C_SDA] = "gen2_i2c_sda",
+	[PMUX_DRVGRP_GEN3_I2C_SCL] = "gen3_i2c_scl",
+	[PMUX_DRVGRP_GEN3_I2C_SDA] = "gen3_i2c_sda",
+	[PMUX_DRVGRP_PA6] = "pa6",
+	[PMUX_DRVGRP_PCC7] = "pcc7",
+	[PMUX_DRVGRP_PE6] = "pe6",
+	[PMUX_DRVGRP_PE7] = "pe7",
+	[PMUX_DRVGRP_PH6] = "ph6",
+	[PMUX_DRVGRP_PK0] = "pk0",
+	[PMUX_DRVGRP_PK1] = "pk1",
+	[PMUX_DRVGRP_PK2] = "pk2",
+	[PMUX_DRVGRP_PK3] = "pk3",
+	[PMUX_DRVGRP_PK4] = "pk4",
+	[PMUX_DRVGRP_PK5] = "pk5",
+	[PMUX_DRVGRP_PK6] = "pk6",
+	[PMUX_DRVGRP_PK7] = "pk7",
+	[PMUX_DRVGRP_PL0] = "pl0",
+	[PMUX_DRVGRP_PL1] = "pl1",
+	[PMUX_DRVGRP_PZ0] = "pz0",
+	[PMUX_DRVGRP_PZ1] = "pz1",
+	[PMUX_DRVGRP_PZ2] = "pz2",
+	[PMUX_DRVGRP_PZ3] = "pz3",
+	[PMUX_DRVGRP_PZ4] = "pz4",
+	[PMUX_DRVGRP_PZ5] = "pz5",
+	[PMUX_DRVGRP_GPIO_X1_AUD] = "gpio_x1_aud",
+	[PMUX_DRVGRP_GPIO_X3_AUD] = "gpio_x3_aud",
+	[PMUX_DRVGRP_GPS_EN] = "gps_en",
+	[PMUX_DRVGRP_GPS_RST] = "gps_rst",
+	[PMUX_DRVGRP_HDMI_CEC] = "hdmi_cec",
+	[PMUX_DRVGRP_HDMI_INT_DP_HPD] = "hdmi_int_dp_hpd",
+	[PMUX_DRVGRP_JTAG_RTCK] = "jtag_rtck",
+	[PMUX_DRVGRP_LCD_BL_EN] = "lcd_bl_en",
+	[PMUX_DRVGRP_LCD_BL_PWM] = "lcd_bl_pwm",
+	[PMUX_DRVGRP_LCD_GPIO1] = "lcd_gpio1",
+	[PMUX_DRVGRP_LCD_GPIO2] = "lcd_gpio2",
+	[PMUX_DRVGRP_LCD_RST] = "lcd_rst",
+	[PMUX_DRVGRP_LCD_TE] = "lcd_te",
+	[PMUX_DRVGRP_MODEM_WAKE_AP] = "modem_wake_ap",
+	[PMUX_DRVGRP_MOTION_INT] = "motion_int",
+	[PMUX_DRVGRP_NFC_EN] = "nfc_en",
+	[PMUX_DRVGRP_NFC_INT] = "nfc_int",
+	[PMUX_DRVGRP_PEX_L0_CLKREQ_N] = "pex_l0_clkreq_n",
+	[PMUX_DRVGRP_PEX_L0_RST_N] = "pex_l0_rst_n",
+	[PMUX_DRVGRP_PEX_L1_CLKREQ_N] = "pex_l1_clkreq_n",
+	[PMUX_DRVGRP_PEX_L1_RST_N] = "pex_l1_rst_n",
+	[PMUX_DRVGRP_PEX_WAKE_N] = "pex_wake_n",
+	[PMUX_DRVGRP_PWR_I2C_SCL] = "pwr_i2c_scl",
+	[PMUX_DRVGRP_PWR_I2C_SDA] = "pwr_i2c_sda",
+	[PMUX_DRVGRP_PWR_INT_N] = "pwr_int_n",
+	[PMUX_DRVGRP_QSPI_SCK] = "qspi_sck",
+	[PMUX_DRVGRP_SATA_LED_ACTIVE] = "sata_led_active",
+	[PMUX_DRVGRP_SDMMC1] = "sdmmc1",
+	[PMUX_DRVGRP_SDMMC2] = "sdmmc2",
+	[PMUX_DRVGRP_SDMMC3] = "sdmmc3",
+	[PMUX_DRVGRP_SDMMC4] = "sdmmc4",
+	[PMUX_DRVGRP_SHUTDOWN] = "shutdown",
+	[PMUX_DRVGRP_SPDIF_IN] = "spdif_in",
+	[PMUX_DRVGRP_SPDIF_OUT] = "spdif_out",
+	[PMUX_DRVGRP_SPI1_CS0] = "spi1_cs0",
+	[PMUX_DRVGRP_SPI1_CS1] = "spi1_cs1",
+	[PMUX_DRVGRP_SPI1_MISO] = "spi1_miso",
+	[PMUX_DRVGRP_SPI1_MOSI] = "spi1_mosi",
+	[PMUX_DRVGRP_SPI1_SCK] = "spi1_sck",
+	[PMUX_DRVGRP_SPI2_CS0] = "spi2_cs0",
+	[PMUX_DRVGRP_SPI2_CS1] = "spi2_cs1",
+	[PMUX_DRVGRP_SPI2_MISO] = "spi2_miso",
+	[PMUX_DRVGRP_SPI2_MOSI] = "spi2_mosi",
+	[PMUX_DRVGRP_SPI2_SCK] = "spi2_sck",
+	[PMUX_DRVGRP_SPI4_CS0] = "spi4_cs0",
+	[PMUX_DRVGRP_SPI4_MISO] = "spi4_miso",
+	[PMUX_DRVGRP_SPI4_MOSI] = "spi4_mosi",
+	[PMUX_DRVGRP_SPI4_SCK] = "spi4_sck",
+	[PMUX_DRVGRP_TEMP_ALERT] = "temp_alert",
+	[PMUX_DRVGRP_TOUCH_CLK] = "touch_clk",
+	[PMUX_DRVGRP_TOUCH_INT] = "touch_int",
+	[PMUX_DRVGRP_TOUCH_RST] = "touch_rst",
+	[PMUX_DRVGRP_UART1_CTS] = "uart1_cts",
+	[PMUX_DRVGRP_UART1_RTS] = "uart1_rts",
+	[PMUX_DRVGRP_UART1_RX] = "uart1_rx",
+	[PMUX_DRVGRP_UART1_TX] = "uart1_tx",
+	[PMUX_DRVGRP_UART2_CTS] = "uart2_cts",
+	[PMUX_DRVGRP_UART2_RTS] = "uart2_rts",
+	[PMUX_DRVGRP_UART2_RX] = "uart2_rx",
+	[PMUX_DRVGRP_UART2_TX] = "uart2_tx",
+	[PMUX_DRVGRP_UART3_CTS] = "uart3_cts",
+	[PMUX_DRVGRP_UART3_RTS] = "uart3_rts",
+	[PMUX_DRVGRP_UART3_RX] = "uart3_rx",
+	[PMUX_DRVGRP_UART3_TX] = "uart3_tx",
+	[PMUX_DRVGRP_UART4_CTS] = "uart4_cts",
+	[PMUX_DRVGRP_UART4_RTS] = "uart4_rts",
+	[PMUX_DRVGRP_UART4_RX] = "uart4_rx",
+	[PMUX_DRVGRP_UART4_TX] = "uart4_tx",
+	[PMUX_DRVGRP_USB_VBUS_EN0] = "usb_vbus_en0",
+	[PMUX_DRVGRP_USB_VBUS_EN1] = "usb_vbus_en1",
+	[PMUX_DRVGRP_WIFI_EN] = "wifi_en",
+	[PMUX_DRVGRP_WIFI_RST] = "wifi_rst",
+	[PMUX_DRVGRP_WIFI_WAKE_AP] = "wifi_wake_ap",
+};
+
+static const char * const tegra_pinctrl_to_func[] = {
+	[PMUX_FUNC_DEFAULT] = "default",
+	[PMUX_FUNC_AUD] = "aud",
+	[PMUX_FUNC_BCL] = "bcl",
+	[PMUX_FUNC_BLINK] = "blink",
+	[PMUX_FUNC_CCLA] = "ccla",
+	[PMUX_FUNC_CEC] = "cec",
+	[PMUX_FUNC_CLDVFS] = "cldvfs",
+	[PMUX_FUNC_CLK] = "clk",
+	[PMUX_FUNC_CORE] = "core",
+	[PMUX_FUNC_CPU] = "cpu",
+	[PMUX_FUNC_DISPLAYA] = "displaya",
+	[PMUX_FUNC_DISPLAYB] = "displayb",
+	[PMUX_FUNC_DMIC1] = "dmic1",
+	[PMUX_FUNC_DMIC2] = "dmic2",
+	[PMUX_FUNC_DMIC3] = "dmic3",
+	[PMUX_FUNC_DP] = "dp",
+	[PMUX_FUNC_DTV] = "dtv",
+	[PMUX_FUNC_EXTPERIPH3] = "extperiph3",
+	[PMUX_FUNC_I2C1] = "i2c1",
+	[PMUX_FUNC_I2C2] = "i2c2",
+	[PMUX_FUNC_I2C3] = "i2c3",
+	[PMUX_FUNC_I2CPMU] = "i2cpmu",
+	[PMUX_FUNC_I2CVI] = "i2cvi",
+	[PMUX_FUNC_I2S1] = "i2s1",
+	[PMUX_FUNC_I2S2] = "i2s2",
+	[PMUX_FUNC_I2S3] = "i2s3",
+	[PMUX_FUNC_I2S4A] = "i2s4a",
+	[PMUX_FUNC_I2S4B] = "i2s4b",
+	[PMUX_FUNC_I2S5A] = "i2s5a",
+	[PMUX_FUNC_I2S5B] = "i2s5b",
+	[PMUX_FUNC_IQC0] = "iqc0",
+	[PMUX_FUNC_IQC1] = "iqc1",
+	[PMUX_FUNC_JTAG] = "jtag",
+	[PMUX_FUNC_PE] = "pe",
+	[PMUX_FUNC_PE0] = "pe0",
+	[PMUX_FUNC_PE1] = "pe1",
+	[PMUX_FUNC_PMI] = "pmi",
+	[PMUX_FUNC_PWM0] = "pwm0",
+	[PMUX_FUNC_PWM1] = "pwm1",
+	[PMUX_FUNC_PWM2] = "pwm2",
+	[PMUX_FUNC_PWM3] = "pwm3",
+	[PMUX_FUNC_QSPI] = "qspi",
+	[PMUX_FUNC_SATA] = "sata",
+	[PMUX_FUNC_SDMMC1] = "sdmmc1",
+	[PMUX_FUNC_SDMMC3] = "sdmmc3",
+	[PMUX_FUNC_SHUTDOWN] = "shutdown",
+	[PMUX_FUNC_SOC] = "soc",
+	[PMUX_FUNC_SOR0] = "sor0",
+	[PMUX_FUNC_SOR1] = "sor1",
+	[PMUX_FUNC_SPDIF] = "spdif",
+	[PMUX_FUNC_SPI1] = "spi1",
+	[PMUX_FUNC_SPI2] = "spi2",
+	[PMUX_FUNC_SPI3] = "spi3",
+	[PMUX_FUNC_SPI4] = "spi4",
+	[PMUX_FUNC_SYS] = "sys",
+	[PMUX_FUNC_TOUCH] = "touch",
+	[PMUX_FUNC_UART] = "uart",
+	[PMUX_FUNC_UARTA] = "uarta",
+	[PMUX_FUNC_UARTB] = "uartb",
+	[PMUX_FUNC_UARTC] = "uartc",
+	[PMUX_FUNC_UARTD] = "uartd",
+	[PMUX_FUNC_USB] = "usb",
+	[PMUX_FUNC_VGP1] = "vgp1",
+	[PMUX_FUNC_VGP2] = "vgp2",
+	[PMUX_FUNC_VGP3] = "vgp3",
+	[PMUX_FUNC_VGP4] = "vgp4",
+	[PMUX_FUNC_VGP5] = "vgp5",
+	[PMUX_FUNC_VGP6] = "vgp6",
+	[PMUX_FUNC_VIMCLK] = "vimclk",
+	[PMUX_FUNC_VIMCLK2] = "vimclk2",
+	[PMUX_FUNC_RSVD0] = "rsvd0",
+	[PMUX_FUNC_RSVD1] = "rsvd1",
+	[PMUX_FUNC_RSVD2] = "rsvd2",
+	[PMUX_FUNC_RSVD3] = "rsvd3",
+};
+
 #define TEGRA_PMX_SOC_DRV_GROUP_BASE_REG 0x8d4
 #define TEGRA_PMX_SOC_HAS_IO_CLAMPING
 #define TEGRA_PMX_SOC_HAS_DRVGRPS
diff --git a/arch/arm/include/asm/arch-tegra30/pinmux.h b/arch/arm/include/asm/arch-tegra30/pinmux.h
index 1261943f58..686417d5b3 100644
--- a/arch/arm/include/asm/arch-tegra30/pinmux.h
+++ b/arch/arm/include/asm/arch-tegra30/pinmux.h
@@ -390,6 +390,387 @@ enum pmux_func {
 	PMUX_FUNC_COUNT,
 };
 
+static const char * const tegra_pinctrl_to_pingrp[] = {
+	[PMUX_PINGRP_ULPI_DATA0_PO1] = "ulpi_data0_po1",
+	[PMUX_PINGRP_ULPI_DATA1_PO2] = "ulpi_data1_po2",
+	[PMUX_PINGRP_ULPI_DATA2_PO3] = "ulpi_data2_po3",
+	[PMUX_PINGRP_ULPI_DATA3_PO4] = "ulpi_data3_po4",
+	[PMUX_PINGRP_ULPI_DATA4_PO5] = "ulpi_data4_po5",
+	[PMUX_PINGRP_ULPI_DATA5_PO6] = "ulpi_data5_po6",
+	[PMUX_PINGRP_ULPI_DATA6_PO7] = "ulpi_data6_po7",
+	[PMUX_PINGRP_ULPI_DATA7_PO0] = "ulpi_data7_po0",
+	[PMUX_PINGRP_ULPI_CLK_PY0] = "ulpi_clk_py0",
+	[PMUX_PINGRP_ULPI_DIR_PY1] = "ulpi_dir_py1",
+	[PMUX_PINGRP_ULPI_NXT_PY2] = "ulpi_nxt_py2",
+	[PMUX_PINGRP_ULPI_STP_PY3] = "ulpi_stp_py3",
+	[PMUX_PINGRP_DAP3_FS_PP0] = "dap3_fs_pp0",
+	[PMUX_PINGRP_DAP3_DIN_PP1] = "dap3_din_pp1",
+	[PMUX_PINGRP_DAP3_DOUT_PP2] = "dap3_dout_pp2",
+	[PMUX_PINGRP_DAP3_SCLK_PP3] = "dap3_sclk_pp3",
+	[PMUX_PINGRP_PV0] = "pv0",
+	[PMUX_PINGRP_PV1] = "pv1",
+	[PMUX_PINGRP_SDMMC1_CLK_PZ0] = "sdmmc1_clk_pz0",
+	[PMUX_PINGRP_SDMMC1_CMD_PZ1] = "sdmmc1_cmd_pz1",
+	[PMUX_PINGRP_SDMMC1_DAT3_PY4] = "sdmmc1_dat3_py4",
+	[PMUX_PINGRP_SDMMC1_DAT2_PY5] = "sdmmc1_dat2_py5",
+	[PMUX_PINGRP_SDMMC1_DAT1_PY6] = "sdmmc1_dat1_py6",
+	[PMUX_PINGRP_SDMMC1_DAT0_PY7] = "sdmmc1_dat0_py7",
+	[PMUX_PINGRP_PV2] = "pv2",
+	[PMUX_PINGRP_PV3] = "pv3",
+	[PMUX_PINGRP_CLK2_OUT_PW5] = "clk2_out_pw5",
+	[PMUX_PINGRP_CLK2_REQ_PCC5] = "clk2_req_pcc5",
+	[PMUX_PINGRP_LCD_PWR1_PC1] = "lcd_pwr1_pc1",
+	[PMUX_PINGRP_LCD_PWR2_PC6] = "lcd_pwr2_pc6",
+	[PMUX_PINGRP_LCD_SDIN_PZ2] = "lcd_sdin_pz2",
+	[PMUX_PINGRP_LCD_SDOUT_PN5] = "lcd_sdout_pn5",
+	[PMUX_PINGRP_LCD_WR_N_PZ3] = "lcd_wr_n_pz3",
+	[PMUX_PINGRP_LCD_CS0_N_PN4] = "lcd_cs0_n_pn4",
+	[PMUX_PINGRP_LCD_DC0_PN6] = "lcd_dc0_pn6",
+	[PMUX_PINGRP_LCD_SCK_PZ4] = "lcd_sck_pz4",
+	[PMUX_PINGRP_LCD_PWR0_PB2] = "lcd_pwr0_pb2",
+	[PMUX_PINGRP_LCD_PCLK_PB3] = "lcd_pclk_pb3",
+	[PMUX_PINGRP_LCD_DE_PJ1] = "lcd_de_pj1",
+	[PMUX_PINGRP_LCD_HSYNC_PJ3] = "lcd_hsync_pj3",
+	[PMUX_PINGRP_LCD_VSYNC_PJ4] = "lcd_vsync_pj4",
+	[PMUX_PINGRP_LCD_D0_PE0] = "lcd_d0_pe0",
+	[PMUX_PINGRP_LCD_D1_PE1] = "lcd_d1_pe1",
+	[PMUX_PINGRP_LCD_D2_PE2] = "lcd_d2_pe2",
+	[PMUX_PINGRP_LCD_D3_PE3] = "lcd_d3_pe3",
+	[PMUX_PINGRP_LCD_D4_PE4] = "lcd_d4_pe4",
+	[PMUX_PINGRP_LCD_D5_PE5] = "lcd_d5_pe5",
+	[PMUX_PINGRP_LCD_D6_PE6] = "lcd_d6_pe6",
+	[PMUX_PINGRP_LCD_D7_PE7] = "lcd_d7_pe7",
+	[PMUX_PINGRP_LCD_D8_PF0] = "lcd_d8_pf0",
+	[PMUX_PINGRP_LCD_D9_PF1] = "lcd_d9_pf1",
+	[PMUX_PINGRP_LCD_D10_PF2] = "lcd_d10_pf2",
+	[PMUX_PINGRP_LCD_D11_PF3] = "lcd_d11_pf3",
+	[PMUX_PINGRP_LCD_D12_PF4] = "lcd_d12_pf4",
+	[PMUX_PINGRP_LCD_D13_PF5] = "lcd_d13_pf5",
+	[PMUX_PINGRP_LCD_D14_PF6] = "lcd_d14_pf6",
+	[PMUX_PINGRP_LCD_D15_PF7] = "lcd_d15_pf7",
+	[PMUX_PINGRP_LCD_D16_PM0] = "lcd_d16_pm0",
+	[PMUX_PINGRP_LCD_D17_PM1] = "lcd_d17_pm1",
+	[PMUX_PINGRP_LCD_D18_PM2] = "lcd_d18_pm2",
+	[PMUX_PINGRP_LCD_D19_PM3] = "lcd_d19_pm3",
+	[PMUX_PINGRP_LCD_D20_PM4] = "lcd_d20_pm4",
+	[PMUX_PINGRP_LCD_D21_PM5] = "lcd_d21_pm5",
+	[PMUX_PINGRP_LCD_D22_PM6] = "lcd_d22_pm6",
+	[PMUX_PINGRP_LCD_D23_PM7] = "lcd_d23_pm7",
+	[PMUX_PINGRP_LCD_CS1_N_PW0] = "lcd_cs1_n_pw0",
+	[PMUX_PINGRP_LCD_M1_PW1] = "lcd_m1_pw1",
+	[PMUX_PINGRP_LCD_DC1_PD2] = "lcd_dc1_pd2",
+	[PMUX_PINGRP_HDMI_INT_PN7] = "hdmi_int_pn7",
+	[PMUX_PINGRP_DDC_SCL_PV4] = "ddc_scl_pv4",
+	[PMUX_PINGRP_DDC_SDA_PV5] = "ddc_sda_pv5",
+	[PMUX_PINGRP_CRT_HSYNC_PV6] = "crt_hsync_pv6",
+	[PMUX_PINGRP_CRT_VSYNC_PV7] = "crt_vsync_pv7",
+	[PMUX_PINGRP_VI_D0_PT4] = "vi_d0_pt4",
+	[PMUX_PINGRP_VI_D1_PD5] = "vi_d1_pd5",
+	[PMUX_PINGRP_VI_D2_PL0] = "vi_d2_pl0",
+	[PMUX_PINGRP_VI_D3_PL1] = "vi_d3_pl1",
+	[PMUX_PINGRP_VI_D4_PL2] = "vi_d4_pl2",
+	[PMUX_PINGRP_VI_D5_PL3] = "vi_d5_pl3",
+	[PMUX_PINGRP_VI_D6_PL4] = "vi_d6_pl4",
+	[PMUX_PINGRP_VI_D7_PL5] = "vi_d7_pl5",
+	[PMUX_PINGRP_VI_D8_PL6] = "vi_d8_pl6",
+	[PMUX_PINGRP_VI_D9_PL7] = "vi_d9_pl7",
+	[PMUX_PINGRP_VI_D10_PT2] = "vi_d10_pt2",
+	[PMUX_PINGRP_VI_D11_PT3] = "vi_d11_pt3",
+	[PMUX_PINGRP_VI_PCLK_PT0] = "vi_pclk_pt0",
+	[PMUX_PINGRP_VI_MCLK_PT1] = "vi_mclk_pt1",
+	[PMUX_PINGRP_VI_VSYNC_PD6] = "vi_vsync_pd6",
+	[PMUX_PINGRP_VI_HSYNC_PD7] = "vi_hsync_pd7",
+	[PMUX_PINGRP_UART2_RXD_PC3] = "uart2_rxd_pc3",
+	[PMUX_PINGRP_UART2_TXD_PC2] = "uart2_txd_pc2",
+	[PMUX_PINGRP_UART2_RTS_N_PJ6] = "uart2_rts_n_pj6",
+	[PMUX_PINGRP_UART2_CTS_N_PJ5] = "uart2_cts_n_pj5",
+	[PMUX_PINGRP_UART3_TXD_PW6] = "uart3_txd_pw6",
+	[PMUX_PINGRP_UART3_RXD_PW7] = "uart3_rxd_pw7",
+	[PMUX_PINGRP_UART3_CTS_N_PA1] = "uart3_cts_n_pa1",
+	[PMUX_PINGRP_UART3_RTS_N_PC0] = "uart3_rts_n_pc0",
+	[PMUX_PINGRP_PU0] = "pu0",
+	[PMUX_PINGRP_PU1] = "pu1",
+	[PMUX_PINGRP_PU2] = "pu2",
+	[PMUX_PINGRP_PU3] = "pu3",
+	[PMUX_PINGRP_PU4] = "pu4",
+	[PMUX_PINGRP_PU5] = "pu5",
+	[PMUX_PINGRP_PU6] = "pu6",
+	[PMUX_PINGRP_GEN1_I2C_SDA_PC5] = "gen1_i2c_sda_pc5",
+	[PMUX_PINGRP_GEN1_I2C_SCL_PC4] = "gen1_i2c_scl_pc4",
+	[PMUX_PINGRP_DAP4_FS_PP4] = "dap4_fs_pp4",
+	[PMUX_PINGRP_DAP4_DIN_PP5] = "dap4_din_pp5",
+	[PMUX_PINGRP_DAP4_DOUT_PP6] = "dap4_dout_pp6",
+	[PMUX_PINGRP_DAP4_SCLK_PP7] = "dap4_sclk_pp7",
+	[PMUX_PINGRP_CLK3_OUT_PEE0] = "clk3_out_pee0",
+	[PMUX_PINGRP_CLK3_REQ_PEE1] = "clk3_req_pee1",
+	[PMUX_PINGRP_GMI_WP_N_PC7] = "gmi_wp_n_pc7",
+	[PMUX_PINGRP_GMI_IORDY_PI5] = "gmi_iordy_pi5",
+	[PMUX_PINGRP_GMI_WAIT_PI7] = "gmi_wait_pi7",
+	[PMUX_PINGRP_GMI_ADV_N_PK0] = "gmi_adv_n_pk0",
+	[PMUX_PINGRP_GMI_CLK_PK1] = "gmi_clk_pk1",
+	[PMUX_PINGRP_GMI_CS0_N_PJ0] = "gmi_cs0_n_pj0",
+	[PMUX_PINGRP_GMI_CS1_N_PJ2] = "gmi_cs1_n_pj2",
+	[PMUX_PINGRP_GMI_CS2_N_PK3] = "gmi_cs2_n_pk3",
+	[PMUX_PINGRP_GMI_CS3_N_PK4] = "gmi_cs3_n_pk4",
+	[PMUX_PINGRP_GMI_CS4_N_PK2] = "gmi_cs4_n_pk2",
+	[PMUX_PINGRP_GMI_CS6_N_PI3] = "gmi_cs6_n_pi3",
+	[PMUX_PINGRP_GMI_CS7_N_PI6] = "gmi_cs7_n_pi6",
+	[PMUX_PINGRP_GMI_AD0_PG0] = "gmi_ad0_pg0",
+	[PMUX_PINGRP_GMI_AD1_PG1] = "gmi_ad1_pg1",
+	[PMUX_PINGRP_GMI_AD2_PG2] = "gmi_ad2_pg2",
+	[PMUX_PINGRP_GMI_AD3_PG3] = "gmi_ad3_pg3",
+	[PMUX_PINGRP_GMI_AD4_PG4] = "gmi_ad4_pg4",
+	[PMUX_PINGRP_GMI_AD5_PG5] = "gmi_ad5_pg5",
+	[PMUX_PINGRP_GMI_AD6_PG6] = "gmi_ad6_pg6",
+	[PMUX_PINGRP_GMI_AD7_PG7] = "gmi_ad7_pg7",
+	[PMUX_PINGRP_GMI_AD8_PH0] = "gmi_ad8_ph0",
+	[PMUX_PINGRP_GMI_AD9_PH1] = "gmi_ad9_ph1",
+	[PMUX_PINGRP_GMI_AD10_PH2] = "gmi_ad10_ph2",
+	[PMUX_PINGRP_GMI_AD11_PH3] = "gmi_ad11_ph3",
+	[PMUX_PINGRP_GMI_AD12_PH4] = "gmi_ad12_ph4",
+	[PMUX_PINGRP_GMI_AD13_PH5] = "gmi_ad13_ph5",
+	[PMUX_PINGRP_GMI_AD14_PH6] = "gmi_ad14_ph6",
+	[PMUX_PINGRP_GMI_AD15_PH7] = "gmi_ad15_ph7",
+	[PMUX_PINGRP_GMI_A16_PJ7] = "gmi_a16_pj7",
+	[PMUX_PINGRP_GMI_A17_PB0] = "gmi_a17_pb0",
+	[PMUX_PINGRP_GMI_A18_PB1] = "gmi_a18_pb1",
+	[PMUX_PINGRP_GMI_A19_PK7] = "gmi_a19_pk7",
+	[PMUX_PINGRP_GMI_WR_N_PI0] = "gmi_wr_n_pi0",
+	[PMUX_PINGRP_GMI_OE_N_PI1] = "gmi_oe_n_pi1",
+	[PMUX_PINGRP_GMI_DQS_PI2] = "gmi_dqs_pi2",
+	[PMUX_PINGRP_GMI_RST_N_PI4] = "gmi_rst_n_pi4",
+	[PMUX_PINGRP_GEN2_I2C_SCL_PT5] = "gen2_i2c_scl_pt5",
+	[PMUX_PINGRP_GEN2_I2C_SDA_PT6] = "gen2_i2c_sda_pt6",
+	[PMUX_PINGRP_SDMMC4_CLK_PCC4] = "sdmmc4_clk_pcc4",
+	[PMUX_PINGRP_SDMMC4_CMD_PT7] = "sdmmc4_cmd_pt7",
+	[PMUX_PINGRP_SDMMC4_DAT0_PAA0] = "sdmmc4_dat0_paa0",
+	[PMUX_PINGRP_SDMMC4_DAT1_PAA1] = "sdmmc4_dat1_paa1",
+	[PMUX_PINGRP_SDMMC4_DAT2_PAA2] = "sdmmc4_dat2_paa2",
+	[PMUX_PINGRP_SDMMC4_DAT3_PAA3] = "sdmmc4_dat3_paa3",
+	[PMUX_PINGRP_SDMMC4_DAT4_PAA4] = "sdmmc4_dat4_paa4",
+	[PMUX_PINGRP_SDMMC4_DAT5_PAA5] = "sdmmc4_dat5_paa5",
+	[PMUX_PINGRP_SDMMC4_DAT6_PAA6] = "sdmmc4_dat6_paa6",
+	[PMUX_PINGRP_SDMMC4_DAT7_PAA7] = "sdmmc4_dat7_paa7",
+	[PMUX_PINGRP_SDMMC4_RST_N_PCC3] = "sdmmc4_rst_n_pcc3",
+	[PMUX_PINGRP_CAM_MCLK_PCC0] = "cam_mclk_pcc0",
+	[PMUX_PINGRP_PCC1] = "pcc1",
+	[PMUX_PINGRP_PBB0] = "pbb0",
+	[PMUX_PINGRP_CAM_I2C_SCL_PBB1] = "cam_i2c_scl_pbb1",
+	[PMUX_PINGRP_CAM_I2C_SDA_PBB2] = "cam_i2c_sda_pbb2",
+	[PMUX_PINGRP_PBB3] = "pbb3",
+	[PMUX_PINGRP_PBB4] = "pbb4",
+	[PMUX_PINGRP_PBB5] = "pbb5",
+	[PMUX_PINGRP_PBB6] = "pbb6",
+	[PMUX_PINGRP_PBB7] = "pbb7",
+	[PMUX_PINGRP_PCC2] = "pcc2",
+	[PMUX_PINGRP_JTAG_RTCK_PU7] = "jtag_rtck_pu7",
+	[PMUX_PINGRP_PWR_I2C_SCL_PZ6] = "pwr_i2c_scl_pz6",
+	[PMUX_PINGRP_PWR_I2C_SDA_PZ7] = "pwr_i2c_sda_pz7",
+	[PMUX_PINGRP_KB_ROW0_PR0] = "kb_row0_pr0",
+	[PMUX_PINGRP_KB_ROW1_PR1] = "kb_row1_pr1",
+	[PMUX_PINGRP_KB_ROW2_PR2] = "kb_row2_pr2",
+	[PMUX_PINGRP_KB_ROW3_PR3] = "kb_row3_pr3",
+	[PMUX_PINGRP_KB_ROW4_PR4] = "kb_row4_pr4",
+	[PMUX_PINGRP_KB_ROW5_PR5] = "kb_row5_pr5",
+	[PMUX_PINGRP_KB_ROW6_PR6] = "kb_row6_pr6",
+	[PMUX_PINGRP_KB_ROW7_PR7] = "kb_row7_pr7",
+	[PMUX_PINGRP_KB_ROW8_PS0] = "kb_row8_ps0",
+	[PMUX_PINGRP_KB_ROW9_PS1] = "kb_row9_ps1",
+	[PMUX_PINGRP_KB_ROW10_PS2] = "kb_row10_ps2",
+	[PMUX_PINGRP_KB_ROW11_PS3] = "kb_row11_ps3",
+	[PMUX_PINGRP_KB_ROW12_PS4] = "kb_row12_ps4",
+	[PMUX_PINGRP_KB_ROW13_PS5] = "kb_row13_ps5",
+	[PMUX_PINGRP_KB_ROW14_PS6] = "kb_row14_ps6",
+	[PMUX_PINGRP_KB_ROW15_PS7] = "kb_row15_ps7",
+	[PMUX_PINGRP_KB_COL0_PQ0] = "kb_col0_pq0",
+	[PMUX_PINGRP_KB_COL1_PQ1] = "kb_col1_pq1",
+	[PMUX_PINGRP_KB_COL2_PQ2] = "kb_col2_pq2",
+	[PMUX_PINGRP_KB_COL3_PQ3] = "kb_col3_pq3",
+	[PMUX_PINGRP_KB_COL4_PQ4] = "kb_col4_pq4",
+	[PMUX_PINGRP_KB_COL5_PQ5] = "kb_col5_pq5",
+	[PMUX_PINGRP_KB_COL6_PQ6] = "kb_col6_pq6",
+	[PMUX_PINGRP_KB_COL7_PQ7] = "kb_col7_pq7",
+	[PMUX_PINGRP_CLK_32K_OUT_PA0] = "clk_32k_out_pa0",
+	[PMUX_PINGRP_SYS_CLK_REQ_PZ5] = "sys_clk_req_pz5",
+	[PMUX_PINGRP_CORE_PWR_REQ] = "core_pwr_req",
+	[PMUX_PINGRP_CPU_PWR_REQ] = "cpu_pwr_req",
+	[PMUX_PINGRP_PWR_INT_N] = "pwr_int_n",
+	[PMUX_PINGRP_CLK_32K_IN] = "clk_32k_in",
+	[PMUX_PINGRP_OWR] = "owr",
+	[PMUX_PINGRP_DAP1_FS_PN0] = "dap1_fs_pn0",
+	[PMUX_PINGRP_DAP1_DIN_PN1] = "dap1_din_pn1",
+	[PMUX_PINGRP_DAP1_DOUT_PN2] = "dap1_dout_pn2",
+	[PMUX_PINGRP_DAP1_SCLK_PN3] = "dap1_sclk_pn3",
+	[PMUX_PINGRP_CLK1_REQ_PEE2] = "clk1_req_pee2",
+	[PMUX_PINGRP_CLK1_OUT_PW4] = "clk1_out_pw4",
+	[PMUX_PINGRP_SPDIF_IN_PK6] = "spdif_in_pk6",
+	[PMUX_PINGRP_SPDIF_OUT_PK5] = "spdif_out_pk5",
+	[PMUX_PINGRP_DAP2_FS_PA2] = "dap2_fs_pa2",
+	[PMUX_PINGRP_DAP2_DIN_PA4] = "dap2_din_pa4",
+	[PMUX_PINGRP_DAP2_DOUT_PA5] = "dap2_dout_pa5",
+	[PMUX_PINGRP_DAP2_SCLK_PA3] = "dap2_sclk_pa3",
+	[PMUX_PINGRP_SPI2_MOSI_PX0] = "spi2_mosi_px0",
+	[PMUX_PINGRP_SPI2_MISO_PX1] = "spi2_miso_px1",
+	[PMUX_PINGRP_SPI2_CS0_N_PX3] = "spi2_cs0_n_px3",
+	[PMUX_PINGRP_SPI2_SCK_PX2] = "spi2_sck_px2",
+	[PMUX_PINGRP_SPI1_MOSI_PX4] = "spi1_mosi_px4",
+	[PMUX_PINGRP_SPI1_SCK_PX5] = "spi1_sck_px5",
+	[PMUX_PINGRP_SPI1_CS0_N_PX6] = "spi1_cs0_n_px6",
+	[PMUX_PINGRP_SPI1_MISO_PX7] = "spi1_miso_px7",
+	[PMUX_PINGRP_SPI2_CS1_N_PW2] = "spi2_cs1_n_pw2",
+	[PMUX_PINGRP_SPI2_CS2_N_PW3] = "spi2_cs2_n_pw3",
+	[PMUX_PINGRP_SDMMC3_CLK_PA6] = "sdmmc3_clk_pa6",
+	[PMUX_PINGRP_SDMMC3_CMD_PA7] = "sdmmc3_cmd_pa7",
+	[PMUX_PINGRP_SDMMC3_DAT0_PB7] = "sdmmc3_dat0_pb7",
+	[PMUX_PINGRP_SDMMC3_DAT1_PB6] = "sdmmc3_dat1_pb6",
+	[PMUX_PINGRP_SDMMC3_DAT2_PB5] = "sdmmc3_dat2_pb5",
+	[PMUX_PINGRP_SDMMC3_DAT3_PB4] = "sdmmc3_dat3_pb4",
+	[PMUX_PINGRP_SDMMC3_DAT4_PD1] = "sdmmc3_dat4_pd1",
+	[PMUX_PINGRP_SDMMC3_DAT5_PD0] = "sdmmc3_dat5_pd0",
+	[PMUX_PINGRP_SDMMC3_DAT6_PD3] = "sdmmc3_dat6_pd3",
+	[PMUX_PINGRP_SDMMC3_DAT7_PD4] = "sdmmc3_dat7_pd4",
+	[PMUX_PINGRP_PEX_L0_PRSNT_N_PDD0] = "pex_l0_prsnt_n_pdd0",
+	[PMUX_PINGRP_PEX_L0_RST_N_PDD1] = "pex_l0_rst_n_pdd1",
+	[PMUX_PINGRP_PEX_L0_CLKREQ_N_PDD2] = "pex_l0_clkreq_n_pdd2",
+	[PMUX_PINGRP_PEX_WAKE_N_PDD3] = "pex_wake_n_pdd3",
+	[PMUX_PINGRP_PEX_L1_PRSNT_N_PDD4] = "pex_l1_prsnt_n_pdd4",
+	[PMUX_PINGRP_PEX_L1_RST_N_PDD5] = "pex_l1_rst_n_pdd5",
+	[PMUX_PINGRP_PEX_L1_CLKREQ_N_PDD6] = "pex_l1_clkreq_n_pdd6",
+	[PMUX_PINGRP_PEX_L2_PRSNT_N_PDD7] = "pex_l2_prsnt_n_pdd7",
+	[PMUX_PINGRP_PEX_L2_RST_N_PCC6] = "pex_l2_rst_n_pcc6",
+	[PMUX_PINGRP_PEX_L2_CLKREQ_N_PCC7] = "pex_l2_clkreq_n_pcc7",
+	[PMUX_PINGRP_HDMI_CEC_PEE3] = "hdmi_cec_pee3",
+};
+
+static const char * const tegra_pinctrl_to_drvgrp[] = {
+	[PMUX_DRVGRP_AO1] = "drive_ao1",
+	[PMUX_DRVGRP_AO2] = "drive_ao2",
+	[PMUX_DRVGRP_AT1] = "drive_at1",
+	[PMUX_DRVGRP_AT2] = "drive_at2",
+	[PMUX_DRVGRP_AT3] = "drive_at3",
+	[PMUX_DRVGRP_AT4] = "drive_at4",
+	[PMUX_DRVGRP_AT5] = "drive_at5",
+	[PMUX_DRVGRP_CDEV1] = "drive_cdev1",
+	[PMUX_DRVGRP_CDEV2] = "drive_cdev2",
+	[PMUX_DRVGRP_CSUS] = "drive_csus",
+	[PMUX_DRVGRP_DAP1] = "drive_dap1",
+	[PMUX_DRVGRP_DAP2] = "drive_dap2",
+	[PMUX_DRVGRP_DAP3] = "drive_dap3",
+	[PMUX_DRVGRP_DAP4] = "drive_dap4",
+	[PMUX_DRVGRP_DBG] = "drive_dbg",
+	[PMUX_DRVGRP_LCD1] = "drive_lcd1",
+	[PMUX_DRVGRP_LCD2] = "drive_lcd2",
+	[PMUX_DRVGRP_SDIO2] = "drive_sdio2",
+	[PMUX_DRVGRP_SDIO3] = "drive_sdio3",
+	[PMUX_DRVGRP_SPI] = "drive_spi",
+	[PMUX_DRVGRP_UAA] = "drive_uaa",
+	[PMUX_DRVGRP_UAB] = "drive_uab",
+	[PMUX_DRVGRP_UART2] = "drive_uart2",
+	[PMUX_DRVGRP_UART3] = "drive_uart3",
+	[PMUX_DRVGRP_VI1] = "drive_vi1",
+	[PMUX_DRVGRP_SDIO1] = "drive_sdio1",
+	[PMUX_DRVGRP_CRT] = "drive_crt",
+	[PMUX_DRVGRP_DDC] = "drive_ddc",
+	[PMUX_DRVGRP_GMA] = "drive_gma",
+	[PMUX_DRVGRP_GMB] = "drive_gmb",
+	[PMUX_DRVGRP_GMC] = "drive_gmc",
+	[PMUX_DRVGRP_GMD] = "drive_gmd",
+	[PMUX_DRVGRP_GME] = "drive_gme",
+	[PMUX_DRVGRP_GMF] = "drive_gmf",
+	[PMUX_DRVGRP_GMG] = "drive_gmg",
+	[PMUX_DRVGRP_GMH] = "drive_gmh",
+	[PMUX_DRVGRP_OWR] = "drive_owr",
+	[PMUX_DRVGRP_UDA] = "drive_uda",
+	[PMUX_DRVGRP_GPV] = "drive_gpv",
+	[PMUX_DRVGRP_DEV3] = "drive_dev3",
+	[PMUX_DRVGRP_CEC] = "drive_cec",
+};
+
+static const char * const tegra_pinctrl_to_func[] = {
+	[PMUX_FUNC_DEFAULT] = "default",
+	[PMUX_FUNC_BLINK] = "blink",
+	[PMUX_FUNC_CEC] = "cec",
+	[PMUX_FUNC_CLK_12M_OUT] = "clk_12m_out",
+	[PMUX_FUNC_CLK_32K_IN] = "clk_32k_in",
+	[PMUX_FUNC_CORE_PWR_REQ] = "core_pwr_req",
+	[PMUX_FUNC_CPU_PWR_REQ] = "cpu_pwr_req",
+	[PMUX_FUNC_CRT] = "crt",
+	[PMUX_FUNC_DAP] = "dap",
+	[PMUX_FUNC_DDR] = "ddr",
+	[PMUX_FUNC_DEV3] = "dev3",
+	[PMUX_FUNC_DISPLAYA] = "displaya",
+	[PMUX_FUNC_DISPLAYB] = "displayb",
+	[PMUX_FUNC_DTV] = "dtv",
+	[PMUX_FUNC_EXTPERIPH1] = "extperiph1",
+	[PMUX_FUNC_EXTPERIPH2] = "extperiph2",
+	[PMUX_FUNC_EXTPERIPH3] = "extperiph3",
+	[PMUX_FUNC_GMI] = "gmi",
+	[PMUX_FUNC_GMI_ALT] = "gmi_alt",
+	[PMUX_FUNC_HDA] = "hda",
+	[PMUX_FUNC_HDCP] = "hdcp",
+	[PMUX_FUNC_HDMI] = "hdmi",
+	[PMUX_FUNC_HSI] = "hsi",
+	[PMUX_FUNC_I2C1] = "i2c1",
+	[PMUX_FUNC_I2C2] = "i2c2",
+	[PMUX_FUNC_I2C3] = "i2c3",
+	[PMUX_FUNC_I2C4] = "i2c4",
+	[PMUX_FUNC_I2CPWR] = "i2cpwr",
+	[PMUX_FUNC_I2S0] = "i2s0",
+	[PMUX_FUNC_I2S1] = "i2s1",
+	[PMUX_FUNC_I2S2] = "i2s2",
+	[PMUX_FUNC_I2S3] = "i2s3",
+	[PMUX_FUNC_I2S4] = "i2s4",
+	[PMUX_FUNC_INVALID] = "invalid",
+	[PMUX_FUNC_KBC] = "kbc",
+	[PMUX_FUNC_MIO] = "mio",
+	[PMUX_FUNC_NAND] = "nand",
+	[PMUX_FUNC_NAND_ALT] = "nand_alt",
+	[PMUX_FUNC_OWR] = "owr",
+	[PMUX_FUNC_PCIE] = "pcie",
+	[PMUX_FUNC_PWM0] = "pwm0",
+	[PMUX_FUNC_PWM1] = "pwm1",
+	[PMUX_FUNC_PWM2] = "pwm2",
+	[PMUX_FUNC_PWM3] = "pwm3",
+	[PMUX_FUNC_PWR_INT_N] = "pwr_int_n",
+	[PMUX_FUNC_RTCK] = "rtck",
+	[PMUX_FUNC_SATA] = "sata",
+	[PMUX_FUNC_SDMMC1] = "sdmmc1",
+	[PMUX_FUNC_SDMMC2] = "sdmmc2",
+	[PMUX_FUNC_SDMMC3] = "sdmmc3",
+	[PMUX_FUNC_SDMMC4] = "sdmmc4",
+	[PMUX_FUNC_SPDIF] = "spdif",
+	[PMUX_FUNC_SPI1] = "spi1",
+	[PMUX_FUNC_SPI2] = "spi2",
+	[PMUX_FUNC_SPI2_ALT] = "spi2_alt",
+	[PMUX_FUNC_SPI3] = "spi3",
+	[PMUX_FUNC_SPI4] = "spi4",
+	[PMUX_FUNC_SPI5] = "spi5",
+	[PMUX_FUNC_SPI6] = "spi6",
+	[PMUX_FUNC_SYSCLK] = "sysclk",
+	[PMUX_FUNC_TEST] = "test",
+	[PMUX_FUNC_TRACE] = "trace",
+	[PMUX_FUNC_UARTA] = "uarta",
+	[PMUX_FUNC_UARTB] = "uartb",
+	[PMUX_FUNC_UARTC] = "uartc",
+	[PMUX_FUNC_UARTD] = "uartd",
+	[PMUX_FUNC_UARTE] = "uarte",
+	[PMUX_FUNC_ULPI] = "ulpi",
+	[PMUX_FUNC_VGP1] = "vgp1",
+	[PMUX_FUNC_VGP2] = "vgp2",
+	[PMUX_FUNC_VGP3] = "vgp3",
+	[PMUX_FUNC_VGP4] = "vgp4",
+	[PMUX_FUNC_VGP5] = "vgp5",
+	[PMUX_FUNC_VGP6] = "vgp6",
+	[PMUX_FUNC_VI] = "vi",
+	[PMUX_FUNC_VI_ALT1] = "vi_alt1",
+	[PMUX_FUNC_VI_ALT2] = "vi_alt2",
+	[PMUX_FUNC_VI_ALT3] = "vi_alt3",
+	[PMUX_FUNC_RSVD1] = "rsvd1",
+	[PMUX_FUNC_RSVD2] = "rsvd2",
+	[PMUX_FUNC_RSVD3] = "rsvd3",
+	[PMUX_FUNC_RSVD4] = "rsvd4",
+};
+
 #define TEGRA_PMX_SOC_DRV_GROUP_BASE_REG 0x868
 #define TEGRA_PMX_SOC_HAS_DRVGRPS
 #define TEGRA_PMX_GRPS_HAVE_LPMD
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 75b3ff47a2..fceafea24c 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -358,6 +358,7 @@ source "drivers/pinctrl/nxp/Kconfig"
 source "drivers/pinctrl/renesas/Kconfig"
 source "drivers/pinctrl/rockchip/Kconfig"
 source "drivers/pinctrl/sunxi/Kconfig"
+source "drivers/pinctrl/tegra/Kconfig"
 source "drivers/pinctrl/uniphier/Kconfig"
 source "drivers/pinctrl/starfive/Kconfig"
 
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index fc1f01a02c..96a0516fe0 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARCH_RMOBILE) += renesas/
 obj-$(CONFIG_ARCH_RZN1) += renesas/
 obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
+obj-$(CONFIG_$(SPL_)PINCTRL_TEGRA)	+= tegra/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
 obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
diff --git a/drivers/pinctrl/tegra/Kconfig b/drivers/pinctrl/tegra/Kconfig
new file mode 100644
index 0000000000..669d8e258e
--- /dev/null
+++ b/drivers/pinctrl/tegra/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config PINCTRL_TEGRA
+	bool "Nvidia Tegra pinctrl driver"
+	depends on DM
+	help
+	  Support pin multiplexing control on Nvidia Tegra SoCs.
+	  The driver is an overlay to existing driver and allows
+	  the usage of dedicated device tree node which contains
+	  full description of each pin.
+
+config SPL_PINCTRL_TEGRA
+	bool "Nvidia Tegra SPL pinctrl driver"
+	depends on SPL_PINCTRL
+	help
+	  Enables support of pre-DM version of pin multiplexing
+	  control driver used on SPL stage for board setup and
+	  available for backwards compatibility purpose.
diff --git a/drivers/pinctrl/tegra/Makefile b/drivers/pinctrl/tegra/Makefile
new file mode 100644
index 0000000000..be97474816
--- /dev/null
+++ b/drivers/pinctrl/tegra/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+ifndef CONFIG_SPL_BUILD
+ifdef CONFIG_TEGRA20
+obj-y += pinctrl-tegra20.o
+else
+obj-y += pinctrl-tegra.o
+endif
+endif
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
new file mode 100644
index 0000000000..1688d52d2a
--- /dev/null
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2023
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <stdlib.h>
+
+#include <asm/arch/pinmux.h>
+
+static void tegra_pinctrl_set_drive(struct udevice *config, int drvcnt)
+{
+	struct pmux_drvgrp_config *drive_group;
+	int i, ret, pad_id;
+	const char **pads;
+
+	drive_group = kmalloc_array(drvcnt, sizeof(*drive_group), GFP_KERNEL);
+	if (!drive_group) {
+		log_err("%s: cannot allocate drive group array\n", __func__);
+		return;
+	}
+
+	drive_group[0].slwf = dev_read_u32_default(config, "nvidia,slew-rate-falling", 0);
+	drive_group[0].slwr = dev_read_u32_default(config, "nvidia,slew-rate-rising", 0);
+	drive_group[0].drvup = dev_read_u32_default(config, "nvidia,pull-up-strength", 0);
+	drive_group[0].drvdn = dev_read_u32_default(config, "nvidia,pull-down-strength", 0);
+#ifdef TEGRA_PMX_GRPS_HAVE_LPMD
+	drive_group[0].lpmd = dev_read_u32_default(config, "nvidia,low-power-mode", 0);
+#endif
+#ifdef TEGRA_PMX_GRPS_HAVE_SCHMT
+	drive_group[0].schmt = dev_read_u32_default(config, "nvidia,schmitt", 0);
+#endif
+#ifdef TEGRA_PMX_GRPS_HAVE_HSM
+	drive_group[0].hsm = dev_read_u32_default(config, "nvidia,high-speed-mode", 0);
+#endif
+
+	for (i = 1; i < drvcnt; i++)
+		memcpy(&drive_group[i], &drive_group[0], sizeof(drive_group[0]));
+
+	ret = dev_read_string_list(config, "nvidia,pins", &pads);
+	if (ret < 0) {
+		log_err("%s: could not parse property nvidia,pins\n", __func__);
+		goto exit;
+	}
+
+	for (i = 0; i < drvcnt; i++) {
+		for (pad_id = 0; pad_id < PMUX_DRVGRP_COUNT; pad_id++)
+			if (tegra_pinctrl_to_drvgrp[pad_id])
+				if (!strcmp(pads[i], tegra_pinctrl_to_drvgrp[pad_id])) {
+					drive_group[i].drvgrp = pad_id;
+					break;
+				}
+
+		debug("%s drvmap: %d, %d, %d, %d, %d\n", pads[i],
+		      drive_group[i].drvgrp, drive_group[i].slwf,
+		      drive_group[i].slwr, drive_group[i].drvup,
+		      drive_group[i].drvdn);
+	}
+
+	pinmux_config_drvgrp_table(drive_group, drvcnt);
+
+	free(pads);
+exit:
+	kfree(drive_group);
+}
+
+static void tegra_pinctrl_set_pin(struct udevice *config, int pincnt)
+{
+	struct pmux_pingrp_config *pinmux_group;
+	int i, ret, pin_id;
+	const char *function;
+	const char **pins;
+
+	pinmux_group = kmalloc_array(pincnt, sizeof(*pinmux_group), GFP_KERNEL);
+	if (!pinmux_group) {
+		log_err("%s: cannot allocate pinmux group array\n", __func__);
+		return;
+	}
+
+	/* decode function id and fill the first copy of pmux_pingrp_config */
+	function = dev_read_string(config, "nvidia,function");
+	if (function)
+		for (i = 0; i < PMUX_FUNC_COUNT; i++)
+			if (tegra_pinctrl_to_func[i])
+				if (!strcmp(function, tegra_pinctrl_to_func[i]))
+					break;
+
+	pinmux_group[0].func = i;
+
+	pinmux_group[0].pull = dev_read_u32_default(config, "nvidia,pull", 0);
+	pinmux_group[0].tristate = dev_read_u32_default(config, "nvidia,tristate", 0);
+#ifdef TEGRA_PMX_PINS_HAVE_E_INPUT
+	pinmux_group[0].io = dev_read_u32_default(config, "nvidia,enable-input", 0);
+#endif
+#ifdef TEGRA_PMX_PINS_HAVE_LOCK
+	pinmux_group[0].lock = dev_read_u32_default(config, "nvidia,lock", 0);
+#endif
+#ifdef TEGRA_PMX_PINS_HAVE_OD
+	pinmux_group[0].od = dev_read_u32_default(config, "nvidia,open-drain", 0);
+#endif
+#ifdef TEGRA_PMX_PINS_HAVE_IO_RESET
+	pinmux_group[0].ioreset = dev_read_u32_default(config, "nvidia,io-reset", 0);
+#endif
+#ifdef TEGRA_PMX_PINS_HAVE_RCV_SEL
+	pinmux_group[0].rcv_sel = dev_read_u32_default(config, "nvidia,rcv-sel", 0);
+#endif
+#ifdef TEGRA_PMX_PINS_HAVE_E_IO_HV
+	pinmux_group[0].e_io_hv = dev_read_u32_default(config, "nvidia,io-hv", 0);
+#endif
+#ifdef TEGRA_PMX_PINS_HAVE_SCHMT
+	pinmux_group[0].schmt = dev_read_u32_default(config, "nvidia,schmitt", 0);
+#endif
+#ifdef TEGRA_PMX_PINS_HAVE_HSM
+	pinmux_group[0].hsm = dev_read_u32_default(config, "nvidia,high-speed-mode", 0);
+#endif
+
+	for (i = 1; i < pincnt; i++)
+		memcpy(&pinmux_group[i], &pinmux_group[0], sizeof(pinmux_group[0]));
+
+	ret = dev_read_string_list(config, "nvidia,pins", &pins);
+	if (ret < 0) {
+		log_err("%s: could not parse property nvidia,pins\n", __func__);
+		goto exit;
+	}
+
+	for (i = 0; i < pincnt; i++) {
+		for (pin_id = 0; pin_id < PMUX_PINGRP_COUNT; pin_id++)
+			if (tegra_pinctrl_to_pingrp[pin_id])
+				if (!strcmp(pins[i], tegra_pinctrl_to_pingrp[pin_id])) {
+					pinmux_group[i].pingrp = pin_id;
+					break;
+				}
+
+		debug("%s pinmap: %d, %d, %d, %d\n", pins[i],
+		      pinmux_group[i].pingrp, pinmux_group[i].func,
+		      pinmux_group[i].pull, pinmux_group[i].tristate);
+	}
+
+	pinmux_config_pingrp_table(pinmux_group, pincnt);
+
+	free(pins);
+exit:
+	kfree(pinmux_group);
+}
+
+static int tegra_pinctrl_set_state(struct udevice *dev, struct udevice *config)
+{
+	struct udevice *child;
+	int ret;
+	const char *name;
+
+	device_foreach_child(child, config) {
+		/* Pinmux node can contain pins and drives */
+		ret = dev_read_string_index(child, "nvidia,pins", 0,
+					    &name);
+		if (ret < 0) {
+			log_err("%s: could not parse property nvidia,pins\n", __func__);
+			return ret;
+		}
+
+		ret = dev_read_string_count(child, "nvidia,pins");
+		if (ret < 0) {
+			log_err("%s: could not count nvidia,pins\n", __func__);
+			return ret;
+		}
+
+		if (!strncmp(name, "drive_", 6))
+			/* Drive node is detected */
+			tegra_pinctrl_set_drive(child, ret);
+		else
+			/* Pin node is detected */
+			tegra_pinctrl_set_pin(child, ret);
+	}
+
+	return 0;
+}
+
+static int tegra_pinctrl_get_pins_count(struct udevice *dev)
+{
+	return PMUX_PINGRP_COUNT;
+}
+
+static const char *tegra_pinctrl_get_pin_name(struct udevice *dev,
+					      unsigned int selector)
+{
+	return tegra_pinctrl_to_pingrp[selector];
+}
+
+static int tegra_pinctrl_get_groups_count(struct udevice *dev)
+{
+	return PMUX_DRVGRP_COUNT;
+}
+
+static const char *tegra_pinctrl_get_group_name(struct udevice *dev,
+						unsigned int selector)
+{
+	return tegra_pinctrl_to_drvgrp[selector];
+}
+
+static int tegra_pinctrl_get_functions_count(struct udevice *dev)
+{
+	return PMUX_FUNC_COUNT;
+}
+
+static const char *tegra_pinctrl_get_function_name(struct udevice *dev,
+						   unsigned int selector)
+{
+	return tegra_pinctrl_to_func[selector];
+}
+
+const struct pinctrl_ops tegra_pinctrl_ops = {
+	.get_pins_count = tegra_pinctrl_get_pins_count,
+	.get_pin_name = tegra_pinctrl_get_pin_name,
+	.get_groups_count = tegra_pinctrl_get_groups_count,
+	.get_group_name = tegra_pinctrl_get_group_name,
+	.get_functions_count = tegra_pinctrl_get_functions_count,
+	.get_function_name = tegra_pinctrl_get_function_name,
+	.set_state = tegra_pinctrl_set_state,
+};
+
+static int tegra_pinctrl_bind(struct udevice *dev)
+{
+	/*
+	 * Make sure that the pinctrl driver gets probed after binding
+	 * to provide initial configuration and assure that further
+	 * probed devices are working correctly.
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
+static const struct udevice_id tegra_pinctrl_ids[] = {
+	{ .compatible = "nvidia,tegra30-pinmux" },
+	{ .compatible = "nvidia,tegra114-pinmux" },
+	{ },
+};
+
+U_BOOT_DRIVER(tegra_pinctrl) = {
+	.name		= "tegra_pinctrl",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= tegra_pinctrl_ids,
+	.bind		= tegra_pinctrl_bind,
+	.ops		= &tegra_pinctrl_ops,
+};
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
new file mode 100644
index 0000000000..f18cb83154
--- /dev/null
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2023
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <stdlib.h>
+
+#include <asm/arch/pinmux.h>
+
+static void tegra_pinctrl_set_pin(struct udevice *config)
+{
+	int i, count, pin_id, ret;
+	int pull, tristate;
+	const char **pins;
+
+	ret = dev_read_u32(config, "nvidia,pull", &pull);
+	if (ret)
+		pull = ret;
+
+	ret = dev_read_u32(config, "nvidia,tristate", &tristate);
+	if (ret)
+		tristate = ret;
+
+	count = dev_read_string_list(config, "nvidia,pins", &pins);
+	if (count < 0) {
+		log_err("%s: could not parse property nvidia,pins\n", __func__);
+		return;
+	}
+
+	for (i = 0; i < count; i++) {
+		for (pin_id = 0; pin_id < PMUX_PINGRP_COUNT; pin_id++)
+			if (tegra_pinctrl_to_pingrp[pin_id])
+				if (!strcmp(pins[i], tegra_pinctrl_to_pingrp[pin_id]))
+					break;
+
+		if (pull >= 0)
+			pinmux_set_pullupdown(pin_id, pull);
+
+		if (tristate >= 0) {
+			if (!tristate)
+				pinmux_tristate_disable(pin_id);
+			else
+				pinmux_tristate_enable(pin_id);
+		}
+	}
+
+	free(pins);
+}
+
+static void tegra_pinctrl_set_func(struct udevice *config)
+{
+	int i, count, func_id, pin_id;
+	const char *function;
+	const char **pins;
+
+	function = dev_read_string(config, "nvidia,function");
+	if (function)
+		for (i = 0; i < PMUX_FUNC_COUNT; i++)
+			if (tegra_pinctrl_to_func[i])
+				if (!strcmp(function, tegra_pinctrl_to_func[i]))
+					break;
+
+	func_id = i;
+
+	count = dev_read_string_list(config, "nvidia,pins", &pins);
+	if (count < 0) {
+		log_err("%s: could not parse property nvidia,pins\n", __func__);
+		return;
+	}
+
+	for (i = 0; i < count; i++) {
+		for (pin_id = 0; pin_id < PMUX_PINGRP_COUNT; pin_id++)
+			if (tegra_pinctrl_to_pingrp[pin_id])
+				if (!strcmp(pins[i], tegra_pinctrl_to_pingrp[pin_id]))
+					break;
+
+		debug("%s(%d) muxed to %s(%d)\n", pins[i], pin_id, function, func_id);
+
+		pinmux_set_func(pin_id, func_id);
+	}
+
+	free(pins);
+}
+
+static int tegra_pinctrl_set_state(struct udevice *dev, struct udevice *config)
+{
+	struct udevice *child;
+
+	device_foreach_child(child, config) {
+		/*
+		 * Tegra20 pinmux is set differently then any other
+		 * Tegra SOC. Nodes are arranged by function muxing,
+		 * then actual pins setup (with node name prefix
+		 * conf_*) and then drive setup.
+		 */
+		if (!strncmp(child->name, "conf_", 5))
+			tegra_pinctrl_set_pin(child);
+		else if (!strncmp(child->name, "drive_", 6))
+			debug("%s: drive configuration is not supported\n", __func__);
+		else
+			tegra_pinctrl_set_func(child);
+	}
+
+	return 0;
+}
+
+static int tegra_pinctrl_get_pins_count(struct udevice *dev)
+{
+	return PMUX_PINGRP_COUNT;
+}
+
+static const char *tegra_pinctrl_get_pin_name(struct udevice *dev,
+					      unsigned int selector)
+{
+	return tegra_pinctrl_to_pingrp[selector];
+}
+
+static int tegra_pinctrl_get_groups_count(struct udevice *dev)
+{
+	return PMUX_DRVGRP_COUNT;
+}
+
+static const char *tegra_pinctrl_get_group_name(struct udevice *dev,
+						unsigned int selector)
+{
+	return tegra_pinctrl_to_drvgrp[selector];
+}
+
+static int tegra_pinctrl_get_functions_count(struct udevice *dev)
+{
+	return PMUX_FUNC_COUNT;
+}
+
+static const char *tegra_pinctrl_get_function_name(struct udevice *dev,
+						   unsigned int selector)
+{
+	return tegra_pinctrl_to_func[selector];
+}
+
+const struct pinctrl_ops tegra_pinctrl_ops = {
+	.get_pins_count = tegra_pinctrl_get_pins_count,
+	.get_pin_name = tegra_pinctrl_get_pin_name,
+	.get_groups_count = tegra_pinctrl_get_groups_count,
+	.get_group_name = tegra_pinctrl_get_group_name,
+	.get_functions_count = tegra_pinctrl_get_functions_count,
+	.get_function_name = tegra_pinctrl_get_function_name,
+	.set_state = tegra_pinctrl_set_state,
+};
+
+static int tegra_pinctrl_bind(struct udevice *dev)
+{
+	/*
+	 * Make sure that the pinctrl driver gets probed after binding
+	 * to provide initial configuration and assure that further
+	 * probed devices are working correctly.
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
+static const struct udevice_id tegra_pinctrl_ids[] = {
+	{ .compatible = "nvidia,tegra20-pinmux" },
+	{ },
+};
+
+U_BOOT_DRIVER(tegra_pinctrl) = {
+	.name		= "tegra_pinctrl",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= tegra_pinctrl_ids,
+	.bind		= tegra_pinctrl_bind,
+	.ops		= &tegra_pinctrl_ops,
+};
-- 
2.40.1

