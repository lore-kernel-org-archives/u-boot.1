Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3705FC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 14:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BFE875DB;
	Mon,  4 Dec 2023 15:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gDnPYx+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F3487896; Mon,  4 Dec 2023 09:21:19 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27A9875B6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50bef9b7a67so1406605e87.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701678074; x=1702282874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLqvgIjtqITiqOv9Has477HE/SuN2OuS0e0CsHw3ik4=;
 b=gDnPYx+PCvStU8Zvu6dwT+3p6tlcHLzp86B73l2NefdDouyhgVVjCeolGxZL+KJLKA
 O2srdsZZAtNYupP6WOroNH/HMMi5ddPBQwUtm9Ih23fTVxbdx147eyta3edSQRZ30B+k
 PFmjQPGw3T8eWY1E0eYsm8/TptaG28Vh6F62goNK1jwY41mN1CnkWx7KM2ydkgKACwgB
 2jEr/2heQnE0uZnDOeZohe6a1lfBYmb6Cybz2d0+ffP6smVsPXIx6AB/QZuk2ZZiz0wS
 NbByMjgrRVWq4Yg/mrlPFCyWgdS6AEpPwdlquIUaC7sHjVqg1R1BFKcoUcZD4hW11W1g
 FUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678074; x=1702282874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLqvgIjtqITiqOv9Has477HE/SuN2OuS0e0CsHw3ik4=;
 b=YIvyQZBEg7FPqxg56pQedCjJF341/dDEKBjM1DFH0T/DpTWIdC4N8ng4K7JFOIJsQ1
 xTI7M0n30pD62vRIFvRW/Db8Kx7/Wvz1YpzvXiSf0nohApQpqToEiuVyab9uNZDGICVD
 WkVK20Mzv0owGtF6/T8yNsFVWtVRH02xVtWPq9SQq/juBhS7SL3EH40SunyQRNjSGO/p
 tjX9rNryGTD4jhGTBaF1yn5gAmhFF2XvKaj/MuAr0mwteNy/tIArxwgT4BfsWVOBZNVU
 H1PLH0/D4ncvpKTMXjS2ZuN2XUrQgZX27ENj/I3UdR6kBEDeXxxVzMuvcL/GajzFB/rp
 zMAg==
X-Gm-Message-State: AOJu0Yzy1jvSXKmOf8RC1oN+7yUmHBNmolaWDSwpV/OTy0l1Ej2eQBI1
 B73cMZBPX2KmWlEFGD6AUec=
X-Google-Smtp-Source: AGHT+IGVi1xkcSJDk8W5bmB1CjTzgPm2jk6pXxeZeeW0VRhvA32Pp/aASSzQMdhzZ3A56uBN96Q1eg==
X-Received: by 2002:a19:a418:0:b0:50b:deea:78e1 with SMTP id
 q24-20020a19a418000000b0050bdeea78e1mr1809545lfc.33.1701678073662; 
 Mon, 04 Dec 2023 00:21:13 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 q16-20020a19a410000000b0050bfe62b073sm3655lfc.170.2023.12.04.00.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:21:12 -0800 (PST)
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
Subject: [PATCH v1 6/8] board: asus: transformer: switch to DM pinmux
Date: Mon,  4 Dec 2023 10:20:52 +0200
Message-Id: <20231204082054.4943-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204082054.4943-1-clamor95@gmail.com>
References: <20231204082054.4943-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Dec 2023 15:39:38 +0100
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

Drop the pinmux setup in the board in favor of setting it up in
the device tree. Device tree nodes match nodes used in the Linux
device tree. 

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-p1801-t.dts         | 982 +++++++++++++++++
 arch/arm/dts/tegra30-asus-tf201.dts           |  45 +
 arch/arm/dts/tegra30-asus-tf300t.dts          |  45 +
 arch/arm/dts/tegra30-asus-tf300tg.dts         | 128 +++
 arch/arm/dts/tegra30-asus-tf300tl.dts         | 163 +++
 arch/arm/dts/tegra30-asus-tf600t.dts          | 889 ++++++++++++++++
 arch/arm/dts/tegra30-asus-tf700t.dts          |  53 +
 arch/arm/dts/tegra30-asus-transformer.dtsi    | 984 ++++++++++++++++++
 .../pinmux-config-transformer.h               | 365 -------
 board/asus/transformer-t30/transformer-t30.c  |  23 -
 10 files changed, 3289 insertions(+), 388 deletions(-)
 delete mode 100644 board/asus/transformer-t30/pinmux-config-transformer.h

diff --git a/arch/arm/dts/tegra30-asus-p1801-t.dts b/arch/arm/dts/tegra30-asus-p1801-t.dts
index 19de984d5f..350443d55e 100644
--- a/arch/arm/dts/tegra30-asus-p1801-t.dts
+++ b/arch/arm/dts/tegra30-asus-p1801-t.dts
@@ -60,6 +60,988 @@
 		};
 	};
 
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* SDMMC1 pinmux */
+			sdmmc1_clk {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1_cmd {
+				nvidia,pins = "sdmmc1_dat3_py4",
+						"sdmmc1_dat2_py5",
+						"sdmmc1_dat1_py6",
+						"sdmmc1_dat0_py7",
+						"sdmmc1_cmd_pz1";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1_cd {
+				nvidia,pins = "gmi_iordy_pi5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1_wp {
+				nvidia,pins = "vi_d11_pt3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SDMMC2 pinmux */
+			vi_d1_pd5 {
+				nvidia,pins = "vi_d1_pd5",
+						"vi_d2_pl0",
+						"vi_d3_pl1",
+						"vi_d5_pl3",
+						"vi_d7_pl5";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			vi_d8_pl6 {
+				nvidia,pins = "vi_d8_pl6",
+						"vi_d9_pl7";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+				nvidia,ioreset = <0>;
+			};
+
+			/* SDMMC3 pinmux */
+			sdmmc3_clk {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3_cmd {
+				nvidia,pins = "sdmmc3_cmd_pa7",
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat3_pb4",
+						"sdmmc3_dat4_pd1",
+						"sdmmc3_dat5_pd0",
+						"sdmmc3_dat6_pd3",
+						"sdmmc3_dat7_pd4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SDMMC4 pinmux */
+			sdmmc4_clk {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4_cmd {
+				nvidia,pins = "sdmmc4_cmd_pt7",
+						"sdmmc4_dat0_paa0",
+						"sdmmc4_dat1_paa1",
+						"sdmmc4_dat2_paa2",
+						"sdmmc4_dat3_paa3",
+						"sdmmc4_dat4_paa4",
+						"sdmmc4_dat5_paa5",
+						"sdmmc4_dat6_paa6",
+						"sdmmc4_dat7_paa7";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4_rst_n {
+				nvidia,pins = "sdmmc4_rst_n_pcc3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam_mclk {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			drive_sdmmc4 {
+				nvidia,pins = "drive_gma",
+						"drive_gmb",
+						"drive_gmc",
+						"drive_gmd";
+				nvidia,pull-down-strength = <9>;
+				nvidia,pull-up-strength = <9>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+
+			/* I2C pinmux */
+			gen1_i2c {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+						"gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			gen2_i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			cam_i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			ddc_i2c {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			pwr_i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			hotplug_i2c {
+				nvidia,pins = "pu4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* HDMI pinmux */
+			hdmi_cec {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			hdmi_hpd {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-A */
+			ulpi_data0_po1 {
+				nvidia,pins = "ulpi_data0_po1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ulpi_data1_po2 {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi_data5_po6 {
+				nvidia,pins = "ulpi_data5_po6";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi_data7_po0 {
+				nvidia,pins = "ulpi_data7_po0",
+						"ulpi_data2_po3",
+						"ulpi_data3_po4",
+						"ulpi_data4_po5",
+						"ulpi_data6_po7";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-B */
+			uartb_txd_rts {
+				nvidia,pins = "uart2_txd_pc2",
+						"uart2_rts_n_pj6";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			uartb_rxd_cts {
+				nvidia,pins = "uart2_rxd_pc3",
+						"uart2_cts_n_pj5";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-C */
+			uartc_rxd_cts {
+				nvidia,pins = "uart3_cts_n_pa1",
+						"uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartc_txd_rts {
+				nvidia,pins = "uart3_rts_n_pc0",
+						"uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* UART-D */
+			ulpi_nxt_py2 {
+				nvidia,pins = "ulpi_nxt_py2";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi_clk_py0 {
+				nvidia,pins = "ulpi_clk_py0",
+						"ulpi_dir_py1",
+						"ulpi_stp_py3";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* I2S pinmux */
+			dap_i2s0 {
+				nvidia,pins = "dap1_fs_pn0",
+						"dap1_din_pn1",
+						"dap1_dout_pn2",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap_i2s1 {
+				nvidia,pins = "dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap3_fs {
+				nvidia,pins = "dap3_fs_pp0",
+						"dap3_din_pp1";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap3_dout {
+				nvidia,pins = "dap3_dout_pp2",
+						"dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap_i2s3 {
+				nvidia,pins = "dap4_fs_pp4",
+						"dap4_din_pp5",
+						"dap4_dout_pp6",
+						"dap4_sclk_pp7";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* sensors pinmux */
+			nct_irq {
+				nvidia,pins = "pcc2";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Asus EC pinmux */
+			ec_irqs {
+				nvidia,pins = "kb_row10_ps2",
+						"kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ec_reqs {
+				nvidia,pins = "kb_col1_pq1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* memory type bootstrap */
+			mem_boostraps {
+				nvidia,pins = "gmi_ad4_pg4",
+						"gmi_ad5_pg5";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PCI-e pinmux */
+			pex_l2_rst_n {
+				nvidia,pins = "pex_l2_rst_n_pcc6",
+						"pex_l0_rst_n_pdd1",
+						"pex_l1_rst_n_pdd5";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pex_l2_clkreq_n {
+				nvidia,pins = "pex_l2_clkreq_n_pcc7",
+						"pex_l0_prsnt_n_pdd0",
+						"pex_l0_clkreq_n_pdd2",
+						"pex_wake_n_pdd3",
+						"pex_l1_prsnt_n_pdd4",
+						"pex_l1_clkreq_n_pdd6",
+						"pex_l2_prsnt_n_pdd7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SPI pinmux */
+			spi1_mosi_px4 {
+				nvidia,pins = "spi1_mosi_px4",
+						"spi1_sck_px5",
+						"spi1_cs0_n_px6",
+						"spi1_miso_px7";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2_cs1_n_pw2 {
+				nvidia,pins = "spi2_cs1_n_pw2";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2_sck_px2 {
+				nvidia,pins = "spi2_sck_px2";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_a17_pb0 {
+				nvidia,pins = "gmi_a17_pb0",
+						"gmi_a16_pj7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_a18_pb1 {
+				nvidia,pins = "gmi_a18_pb1";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_a19_pk7 {
+				nvidia,pins = "gmi_a19_pk7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Display A pinmux */
+			lcd_pwr0_pb2 {
+				nvidia,pins = "lcd_pwr0_pb2",
+						"lcd_pclk_pb3",
+						"lcd_pwr1_pc1",
+						"lcd_d0_pe0",
+						"lcd_d1_pe1",
+						"lcd_d2_pe2",
+						"lcd_d3_pe3",
+						"lcd_d4_pe4",
+						"lcd_d5_pe5",
+						"lcd_d6_pe6",
+						"lcd_d7_pe7",
+						"lcd_d8_pf0",
+						"lcd_d9_pf1",
+						"lcd_d10_pf2",
+						"lcd_d11_pf3",
+						"lcd_d12_pf4",
+						"lcd_d13_pf5",
+						"lcd_d14_pf6",
+						"lcd_d15_pf7",
+						"lcd_de_pj1",
+						"lcd_hsync_pj3",
+						"lcd_vsync_pj4",
+						"lcd_d16_pm0",
+						"lcd_d17_pm1",
+						"lcd_d18_pm2",
+						"lcd_d19_pm3",
+						"lcd_d20_pm4",
+						"lcd_d21_pm5",
+						"lcd_d22_pm6",
+						"lcd_d23_pm7",
+						"lcd_cs1_n_pw0",
+						"lcd_dc0_pn6",
+						"lcd_sck_pz4",
+						"lcd_sdin_pz2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_cs0_n_pn4 {
+				nvidia,pins = "lcd_cs0_n_pn4",
+						"lcd_sdout_pn5",
+						"lcd_wr_n_pz3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			blink {
+				nvidia,pins = "clk_32k_out_pa0";
+				nvidia,function = "blink";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* KBC keys */
+			kb_col0_pq0 {
+				nvidia,pins = "kb_col0_pq0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb_col1_pq1 {
+				nvidia,pins = "kb_row1_pr1",
+						"kb_row3_pr3",
+						"kb_row9_ps1",
+						"kb_row11_ps3",
+						"kb_row14_ps6",
+						"kb_col6_pq6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb_col4_pq4 {
+				nvidia,pins = "kb_col4_pq4",
+						"kb_col5_pq5",
+						"kb_col7_pq7",
+						"kb_row2_pr2",
+						"kb_row4_pr4",
+						"kb_row5_pr5",
+						"kb_row12_ps4",
+						"kb_row13_ps5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_wp_n_pc7 {
+				nvidia,pins = "gmi_wp_n_pc7",
+						"gmi_wait_pi7",
+						"gmi_cs3_n_pk4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_cs0_n_pj0 {
+				nvidia,pins = "gmi_cs0_n_pj0",
+						"gmi_cs1_n_pj2",
+						"gmi_cs2_n_pk3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			vi_pclk_pt0 {
+				nvidia,pins = "vi_pclk_pt0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+				nvidia,ioreset = <0>;
+			};
+
+			/* GPIO keys pinmux */
+			power_key {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			vol_keys {
+				nvidia,pins = "kb_col2_pq2",
+						"kb_col3_pq3";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Bluetooth */
+			bt_shutdown {
+				nvidia,pins = "pu0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bt_dev_wake {
+				nvidia,pins = "pu1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt_host_wake {
+				nvidia,pins = "pu6";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pu2 {
+				nvidia,pins = "pu2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pu3 {
+				nvidia,pins = "pu3";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pcc1 {
+				nvidia,pins = "pcc1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pv2 {
+				nvidia,pins = "pv2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pv3 {
+				nvidia,pins = "pv3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			vi_vsync_pd6 {
+				nvidia,pins = "vi_vsync_pd6",
+						"vi_hsync_pd7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+				nvidia,ioreset = <0>;
+			};
+			vi_d10_pt2 {
+				nvidia,pins = "vi_d10_pt2",
+						"vi_d0_pt4", "pbb0";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			kb_row0_pr0 {
+				nvidia,pins = "kb_row0_pr0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad0_pg0 {
+				nvidia,pins = "gmi_ad0_pg0",
+						"gmi_ad1_pg1",
+						"gmi_ad2_pg2",
+						"gmi_ad3_pg3",
+						"gmi_ad6_pg6",
+						"gmi_ad7_pg7",
+						"gmi_wr_n_pi0",
+						"gmi_oe_n_pi1",
+						"gmi_dqs_pi2",
+						"gmi_adv_n_pk0",
+						"gmi_clk_pk1";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_ad13_ph5 {
+				nvidia,pins = "gmi_ad13_ph5";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_ad10_ph2 {
+				nvidia,pins = "gmi_ad10_ph2",
+						"gmi_ad11_ph3",
+						"gmi_ad14_ph6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_ad12_ph4 {
+				nvidia,pins = "gmi_ad12_ph4",
+						"gmi_rst_n_pi4";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* USB2 VBUS control */
+			usb2_vbus_control {
+				nvidia,pins = "gmi_ad15_ph7";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/* PWM pinmux */
+			pwm_0 {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pwm_1 {
+				nvidia,pins = "gmi_ad9_ph1";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pwm_2 {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* S/PDIF pinmux */
+			spdif_out {
+				nvidia,pins = "spdif_out_pk5";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			spdif_in {
+				nvidia,pins = "spdif_in_pk6";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			vi_d4_pl2 {
+				nvidia,pins = "vi_d4_pl2";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			vi_d6_pl4 {
+				nvidia,pins = "vi_d6_pl4";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,lock = <0>;
+				nvidia,ioreset = <0>;
+			};
+			vi_mclk_pt1 {
+				nvidia,pins = "vi_mclk_pt1";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			jtag_rtck {
+				nvidia,pins = "jtag_rtck_pu7";
+				nvidia,function = "rtck";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			crt_hsync_pv6 {
+				nvidia,pins = "crt_hsync_pv6",
+						"crt_vsync_pv7";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			clk1_out {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk2_out {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "extperiph2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk3_out {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			sys_clk_req {
+				nvidia,pins = "sys_clk_req_pz5";
+				nvidia,function = "sysclk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pbb4 {
+				nvidia,pins = "pbb4";
+				nvidia,function = "vgp4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb5 {
+				nvidia,pins = "pbb5";
+				nvidia,function = "vgp5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb6 {
+				nvidia,pins = "pbb6";
+				nvidia,function = "vgp6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk2_req_pcc5 {
+				nvidia,pins = "clk2_req_pcc5",
+						"clk1_req_pee2";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk3_req_pee1 {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* P1801-T specific pinmux */
+			lcd_pwr2 {
+				nvidia,pins = "lcd_pwr2_pc6",
+						"lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_m1 {
+				nvidia,pins = "lcd_m1_pw1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			key_mode {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			splashtop {
+				nvidia,pins = "gmi_cs6_n_pi3";
+				nvidia,function = "nand_alt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			w8_detect {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "nand_alt";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb7 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2_mosi_px0 {
+				nvidia,pins = "spi2_mosi_px0";
+				nvidia,function = "spi6";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			tp_vendor {
+				nvidia,pins = "kb_row6_pr6",
+						"kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			tp_power {
+				nvidia,pins = "kb_row8_ps0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* GPIO power/drive control */
+			drive_dap1 {
+				nvidia,pins = "drive_dap1",
+						"drive_dap2",
+						"drive_dbg",
+						"drive_at5",
+						"drive_gme",
+						"drive_ddc",
+						"drive_ao1",
+						"drive_uart3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+			drive_sdio1 {
+				nvidia,pins = "drive_sdio1",
+						"drive_sdio3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,pull-down-strength = <46>;
+				nvidia,pull-up-strength = <42>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FAST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FAST>;
+			};
+		};
+	};
+
 	uarta: serial@70006000 {
 		status = "okay";
 	};
diff --git a/arch/arm/dts/tegra30-asus-tf201.dts b/arch/arm/dts/tegra30-asus-tf201.dts
index 59e19f9766..12dd909b5f 100644
--- a/arch/arm/dts/tegra30-asus-tf201.dts
+++ b/arch/arm/dts/tegra30-asus-tf201.dts
@@ -7,6 +7,51 @@
 	model = "ASUS Transformer Prime TF201";
 	compatible = "asus,tf201", "nvidia,tegra30";
 
+	pinmux@70000868 {
+		state_default: pinmux {
+			lcd_pwr2_pc6 {
+				nvidia,pins = "lcd_pwr2_pc6",
+						"lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pbb7 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			kb_row7_pr7 {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_cs4_n_pk2 {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
+
 	usb-phy@7d008000 {
 		/delete-property/ nvidia,xcvr-setup-use-fuses;
 		nvidia,xcvr-setup = <5>;      /* Based on TF201 fuse value - 48 */
diff --git a/arch/arm/dts/tegra30-asus-tf300t.dts b/arch/arm/dts/tegra30-asus-tf300t.dts
index db08488420..b30afa3022 100644
--- a/arch/arm/dts/tegra30-asus-tf300t.dts
+++ b/arch/arm/dts/tegra30-asus-tf300t.dts
@@ -15,4 +15,49 @@
 			output-low;
 		};
 	};
+
+	pinmux@70000868 {
+		state_default: pinmux {
+			lcd_pwr2_pc6 {
+				nvidia,pins = "lcd_pwr2_pc6",
+						"lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pbb7 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			kb_row7_pr7 {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_cs4_n_pk2 {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
 };
diff --git a/arch/arm/dts/tegra30-asus-tf300tg.dts b/arch/arm/dts/tegra30-asus-tf300tg.dts
index 6f42182c99..83921c664c 100644
--- a/arch/arm/dts/tegra30-asus-tf300tg.dts
+++ b/arch/arm/dts/tegra30-asus-tf300tg.dts
@@ -6,4 +6,132 @@
 / {
 	model = "ASUS Transformer Pad 3G TF300TG";
 	compatible = "asus,tf300tg", "nvidia,tegra30";
+
+	pinmux@70000868 {
+		state_default: pinmux {
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pbb7 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_cs4_n_pk2 {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			lcd_pwr2_pc6 {
+				nvidia,pins = "lcd_pwr2_pc6",
+						"lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row7_pr7 {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spi2_cs2_n_pw3 {
+				nvidia,pins = "spi2_cs2_n_pw3";
+				nvidia,function = "spi2";
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			dap3_din_pp1 {
+				nvidia,pins = "dap3_din_pp1";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spi1_sck_px5 {
+				nvidia,pins = "spi1_sck_px5";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pu5 {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			spi2_mosi_px0 {
+				nvidia,pins = "spi2_mosi_px0";
+				nvidia,function = "spi2";
+			};
+
+			spi1_miso_px7 {
+				nvidia,pins = "spi1_miso_px7";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			clk3_req_pee1 {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ulpi_nxt_py2 {
+				nvidia,pins = "ulpi_nxt_py2";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_stp_py3 {
+				nvidia,pins = "ulpi_stp_py3";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pu3 {
+				nvidia,pins = "pu3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			dap1_din_pn1 {
+				nvidia,pins = "dap1_din_pn1";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
 };
diff --git a/arch/arm/dts/tegra30-asus-tf300tl.dts b/arch/arm/dts/tegra30-asus-tf300tl.dts
index 242f79170c..13b96fd0b0 100644
--- a/arch/arm/dts/tegra30-asus-tf300tl.dts
+++ b/arch/arm/dts/tegra30-asus-tf300tl.dts
@@ -6,4 +6,167 @@
 / {
 	model = "ASUS Transformer Pad LTE TF300TL";
 	compatible = "asus,tf300tl", "nvidia,tegra30";
+
+	pinmux@70000868 {
+		state_default: pinmux {
+			lcd_pwr2_pc6 {
+				nvidia,pins = "lcd_pwr2_pc6",
+						"lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pbb7 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			kb_row7_pr7 {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_cs4_n_pk2 {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* TF300TL specific pinmux reconfiguration */
+
+			ulpi_data5_po6 {
+				nvidia,pins = "ulpi_data5_po6";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap3_din_pp1 {
+				nvidia,pins = "dap3_din_pp1";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			crt_hsync_pv6 {
+				nvidia,pins = "crt_hsync_pv6";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			crt_vsync_pv7 {
+				nvidia,pins = "crt_vsync_pv7";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pu5 {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk3_out_pee0 {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk3_req_pee1 {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			dap1_fs_pn0 {
+				nvidia,pins = "dap1_fs_pn0",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			dap1_din_pn1 {
+				nvidia,pins = "dap1_din_pn1";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap1_dout_pn2 {
+				nvidia,pins = "dap1_dout_pn2";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk1_req_pee2 {
+				nvidia,pins = "clk1_req_pee2";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spi2_mosi_px0 {
+				nvidia,pins = "spi2_mosi_px0";
+				nvidia,function = "spi2";
+			};
+
+			spi1_sck_px5 {
+				nvidia,pins = "spi1_sck_px5";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			spi1_miso_px7 {
+				nvidia,pins = "spi1_miso_px7";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			spi2_cs2_n_pw3 {
+				nvidia,pins = "spi2_cs2_n_pw3";
+				nvidia,function = "spi2";
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
 };
diff --git a/arch/arm/dts/tegra30-asus-tf600t.dts b/arch/arm/dts/tegra30-asus-tf600t.dts
index 3f11d33bc4..f49e7341fe 100644
--- a/arch/arm/dts/tegra30-asus-tf600t.dts
+++ b/arch/arm/dts/tegra30-asus-tf600t.dts
@@ -53,6 +53,895 @@
 		};
 	};
 
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* SDMMC1 pinmux */
+			sdmmc1_clk {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1_cmd {
+				nvidia,pins = "sdmmc1_dat3_py4",
+						"sdmmc1_dat2_py5",
+						"sdmmc1_dat1_py6",
+						"sdmmc1_dat0_py7",
+						"sdmmc1_cmd_pz1";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1_cd {
+				nvidia,pins = "gmi_iordy_pi5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1_wp {
+				nvidia,pins = "vi_d11_pt3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SDMMC2 pinmux */
+			vi_d1_pd5 {
+				nvidia,pins = "vi_d1_pd5",
+						"vi_d2_pl0",
+						"vi_d3_pl1",
+						"vi_d5_pl3",
+						"vi_d7_pl5";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			vi_d8_pl6 {
+				nvidia,pins = "vi_d8_pl6",
+						"vi_d9_pl7";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+				nvidia,ioreset = <0>;
+			};
+
+			/* SDMMC3 pinmux */
+			sdmmc3_clk {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3_cmd {
+				nvidia,pins = "sdmmc3_cmd_pa7",
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat3_pb4",
+						"sdmmc3_dat4_pd1",
+						"sdmmc3_dat5_pd0",
+						"sdmmc3_dat6_pd3",
+						"sdmmc3_dat7_pd4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SDMMC4 pinmux */
+			sdmmc4_clk {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4_cmd {
+				nvidia,pins = "sdmmc4_cmd_pt7",
+						"sdmmc4_dat0_paa0",
+						"sdmmc4_dat1_paa1",
+						"sdmmc4_dat2_paa2",
+						"sdmmc4_dat3_paa3",
+						"sdmmc4_dat4_paa4",
+						"sdmmc4_dat5_paa5",
+						"sdmmc4_dat6_paa6",
+						"sdmmc4_dat7_paa7";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4_rst_n {
+				nvidia,pins = "sdmmc4_rst_n_pcc3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam_mclk {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* I2C pinmux */
+			gen1_i2c {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+						"gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			gen2_i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			cam_i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			ddc_i2c {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			pwr_i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			hotplug_i2c {
+				nvidia,pins = "pu4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* HDMI pinmux */
+			hdmi_cec {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			hdmi_hpd {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-A */
+			ulpi_data0_po1 {
+				nvidia,pins = "ulpi_data0_po1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ulpi_data1_po2 {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi_data5_po6 {
+				nvidia,pins = "ulpi_data5_po6";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi_data7_po0 {
+				nvidia,pins = "ulpi_data7_po0",
+						"ulpi_data2_po3",
+						"ulpi_data3_po4",
+						"ulpi_data4_po5",
+						"ulpi_data6_po7";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-B */
+			uartb_txd_rts {
+				nvidia,pins = "uart2_txd_pc2",
+						"uart2_rts_n_pj6";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			uartb_rxd_cts {
+				nvidia,pins = "uart2_rxd_pc3",
+						"uart2_cts_n_pj5";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-C */
+			uartc_rxd_cts {
+				nvidia,pins = "uart3_cts_n_pa1",
+						"uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartc_txd_rts {
+				nvidia,pins = "uart3_rts_n_pc0",
+						"uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* UART-D */
+			ulpi_nxt_py2 {
+				nvidia,pins = "ulpi_nxt_py2";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi_clk_py0 {
+				nvidia,pins = "ulpi_clk_py0",
+						"ulpi_dir_py1",
+						"ulpi_stp_py3";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* I2S pinmux */
+			dap_i2s0 {
+				nvidia,pins = "dap1_fs_pn0",
+						"dap1_din_pn1",
+						"dap1_dout_pn2",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap_i2s1 {
+				nvidia,pins = "dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap3_fs {
+				nvidia,pins = "dap3_fs_pp0";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap3_din {
+				nvidia,pins = "dap3_din_pp1";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap3_dout {
+				nvidia,pins = "dap3_dout_pp2",
+						"dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap_i2s3 {
+				nvidia,pins = "dap4_fs_pp4",
+						"dap4_din_pp5",
+						"dap4_dout_pp6",
+						"dap4_sclk_pp7";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			i2s4 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			nct_irq {
+				nvidia,pins = "pcc2";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			hall {
+				nvidia,pins = "pbb6";
+				nvidia,function = "vgp6";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Asus EC pinmux */
+			ec_irqs {
+				nvidia,pins = "kb_row10_ps2",
+						"kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ec_reqs {
+				nvidia,pins = "kb_col1_pq1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Memory type bootstrap */
+			mem_boostraps {
+				nvidia,pins = "gmi_ad4_pg4",
+						"gmi_ad5_pg5";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PCI-e pinmux */
+			pex_l2_rst_n {
+				nvidia,pins = "pex_l2_rst_n_pcc6",
+						"pex_l0_rst_n_pdd1",
+						"pex_l1_rst_n_pdd5";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pex_l2_clkreq_n {
+				nvidia,pins = "pex_l2_clkreq_n_pcc7",
+						"pex_l0_prsnt_n_pdd0",
+						"pex_l0_clkreq_n_pdd2",
+						"pex_wake_n_pdd3",
+						"pex_l1_prsnt_n_pdd4",
+						"pex_l1_clkreq_n_pdd6",
+						"pex_l2_prsnt_n_pdd7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Display A pinmux */
+			lcd_pwr0_pb2 {
+				nvidia,pins = "lcd_pwr0_pb2",
+						"lcd_pclk_pb3",
+						"lcd_pwr1_pc1",
+						"lcd_d0_pe0",
+						"lcd_d1_pe1",
+						"lcd_d2_pe2",
+						"lcd_d3_pe3",
+						"lcd_d4_pe4",
+						"lcd_d5_pe5",
+						"lcd_d6_pe6",
+						"lcd_d7_pe7",
+						"lcd_d8_pf0",
+						"lcd_d9_pf1",
+						"lcd_d10_pf2",
+						"lcd_d11_pf3",
+						"lcd_d12_pf4",
+						"lcd_d13_pf5",
+						"lcd_d14_pf6",
+						"lcd_d15_pf7",
+						"lcd_de_pj1",
+						"lcd_hsync_pj3",
+						"lcd_vsync_pj4",
+						"lcd_d16_pm0",
+						"lcd_d17_pm1",
+						"lcd_d18_pm2",
+						"lcd_d19_pm3",
+						"lcd_d20_pm4",
+						"lcd_d21_pm5",
+						"lcd_d22_pm6",
+						"lcd_d23_pm7",
+						"lcd_cs1_n_pw0",
+						"lcd_m1_pw1",
+						"lcd_dc0_pn6",
+						"lcd_sck_pz4",
+						"lcd_sdin_pz2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_cs0_n_pn4 {
+				nvidia,pins = "lcd_sdout_pn5",
+						"lcd_wr_n_pz3",
+						"lcd_pwr2_pc6",
+						"lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			blink {
+				nvidia,pins = "clk_32k_out_pa0";
+				nvidia,function = "blink";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* KBC keys */
+			kb_col0 {
+				nvidia,pins = "kb_col0_pq0",
+						"kb_row1_pr1",
+						"kb_row3_pr3",
+						"kb_row6_pr6",
+						"kb_row8_ps0",
+						"kb_row9_ps1",
+						"kb_row11_ps3",
+						"kb_row14_ps6",
+						"kb_col6_pq6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb_col5 {
+				nvidia,pins = "kb_col5_pq5",
+						"kb_col7_pq7",
+						"kb_row2_pr2",
+						"kb_row4_pr4",
+						"kb_row5_pr5",
+						"kb_row13_ps5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_cs0_n_pj0 {
+				nvidia,pins = "gmi_wp_n_pc7",
+						"gmi_wait_pi7",
+						"gmi_cs0_n_pj0",
+						"gmi_cs1_n_pj2",
+						"gmi_cs2_n_pk3",
+						"gmi_cs3_n_pk4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			vi_pclk_pt0 {
+				nvidia,pins = "vi_pclk_pt0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+				nvidia,ioreset = <0>;
+			};
+
+			/* GPIO keys pinmux */
+			power_key {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			vol_keys {
+				nvidia,pins = "kb_col3_pq3",
+						"kb_col4_pq4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Bluetooth */
+			bt_shutdown {
+				nvidia,pins = "pu0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bt_dev_wake {
+				nvidia,pins = "pu1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt_host_wake {
+				nvidia,pins = "pu6";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pu2 {
+				nvidia,pins = "pu2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pu3 {
+				nvidia,pins = "pu3";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pcc1 {
+				nvidia,pins = "pcc1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pv2 {
+				nvidia,pins = "pv2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pv3 {
+				nvidia,pins = "pv3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			vi_vsync_pd6 {
+				nvidia,pins = "vi_vsync_pd6",
+						"vi_hsync_pd7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+				nvidia,ioreset = <0>;
+			};
+			vi_d10_pt2 {
+				nvidia,pins = "vi_d10_pt2",
+						"vi_d0_pt4", "pbb0";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			kb_row0_pr0 {
+				nvidia,pins = "kb_row0_pr0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad0_pg0 {
+				nvidia,pins = "gmi_ad0_pg0",
+						"gmi_ad1_pg1",
+						"gmi_ad2_pg2",
+						"gmi_ad3_pg3",
+						"gmi_ad6_pg6",
+						"gmi_ad7_pg7",
+						"gmi_wr_n_pi0",
+						"gmi_oe_n_pi1",
+						"gmi_dqs_pi2",
+						"gmi_adv_n_pk0",
+						"gmi_clk_pk1";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_ad13_ph5 {
+				nvidia,pins = "gmi_ad13_ph5";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_ad10_ph2 {
+				nvidia,pins = "gmi_ad10_ph2",
+						"gmi_ad11_ph3",
+						"gmi_ad14_ph6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_ad12_ph4 {
+				nvidia,pins = "gmi_ad12_ph4",
+						"gmi_rst_n_pi4",
+						"gmi_cs7_n_pi6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Vibrator control */
+			vibrator {
+				nvidia,pins = "gmi_ad11_ph3";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PWM pinmux */
+			pwm_0 {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pwm_1 {
+				nvidia,pins = "gmi_ad9_ph1";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pwm_2 {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_cs_n {
+				nvidia,pins = "gmi_cs4_n_pk2",
+						"gmi_cs6_n_pi3";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Spdif pinmux */
+			spdif_out {
+				nvidia,pins = "spdif_out_pk5";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			spdif_in {
+				nvidia,pins = "spdif_in_pk6";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			vi_d4_pl2 {
+				nvidia,pins = "vi_d4_pl2";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			vi_d6_pl4 {
+				nvidia,pins = "vi_d6_pl4";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,lock = <0>;
+				nvidia,ioreset = <0>;
+			};
+			vi_mclk_pt1 {
+				nvidia,pins = "vi_mclk_pt1";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			jtag {
+				nvidia,pins = "jtag_rtck_pu7";
+				nvidia,function = "rtck";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			crt_sync {
+				nvidia,pins = "crt_hsync_pv6",
+						"crt_vsync_pv7";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			clk1_out {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk2_out {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "extperiph2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk3_out {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sys_clk_req {
+				nvidia,pins = "sys_clk_req_pz5";
+				nvidia,function = "sysclk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb4 {
+				nvidia,pins = "pbb4";
+				nvidia,function = "vgp4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb5 {
+				nvidia,pins = "pbb5";
+				nvidia,function = "vgp5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk2_req_pcc5 {
+				nvidia,pins = "clk2_req_pcc5",
+						"clk1_req_pee2";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk3_req_pee1 {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO power/drive control */
+			drive_dap1 {
+				nvidia,pins = "drive_dap1",
+						"drive_dap2",
+						"drive_dbg",
+						"drive_at5",
+						"drive_gme",
+						"drive_ddc",
+						"drive_ao1",
+						"drive_uart3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+			drive_sdio1 {
+				nvidia,pins = "drive_sdio1",
+						"drive_sdio3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,pull-down-strength = <46>;
+				nvidia,pull-up-strength = <42>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FAST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FAST>;
+			};
+			drive_sdmmc4 {
+				nvidia,pins = "drive_gma",
+						"drive_gmb",
+						"drive_gmc",
+						"drive_gmd";
+				nvidia,pull-down-strength = <9>;
+				nvidia,pull-up-strength = <9>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+		};
+	};
+
 	uarta: serial@70006000 {
 		status = "okay";
 	};
diff --git a/arch/arm/dts/tegra30-asus-tf700t.dts b/arch/arm/dts/tegra30-asus-tf700t.dts
index d530527c9f..cc03f5a7ec 100644
--- a/arch/arm/dts/tegra30-asus-tf700t.dts
+++ b/arch/arm/dts/tegra30-asus-tf700t.dts
@@ -9,5 +9,58 @@
 
 	/delete-node/ host1x@50000000;
 
+	pinmux@70000868 {
+		state_default: pinmux {
+			lcd_pwr2_pc6 {
+				nvidia,pins = "lcd_pwr2_pc6",
+						"lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spi2_mosi_px0 {
+				nvidia,pins = "spi2_mosi_px0";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb7 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row7_pr7 {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_cs4_n_pk2 {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
+
 	/delete-node/ panel;
 };
diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
index c4649eee79..e6cc6e7105 100644
--- a/arch/arm/dts/tegra30-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -37,6 +37,990 @@
 		};
 	};
 
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* SDMMC1 pinmux */
+			sdmmc1_clk {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc1_cmd {
+				nvidia,pins = "sdmmc1_dat3_py4",
+						"sdmmc1_dat2_py5",
+						"sdmmc1_dat1_py6",
+						"sdmmc1_dat0_py7",
+						"sdmmc1_cmd_pz1";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc1_cd {
+				nvidia,pins = "gmi_iordy_pi5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc1_wp {
+				nvidia,pins = "vi_d11_pt3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SDMMC2 pinmux */
+			vi_d1_pd5 {
+				nvidia,pins = "vi_d1_pd5",
+						"vi_d2_pl0",
+						"vi_d3_pl1",
+						"vi_d5_pl3",
+						"vi_d7_pl5";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			vi_d8_pl6 {
+				nvidia,pins = "vi_d8_pl6",
+						"vi_d9_pl7";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+				nvidia,io-reset = <0>;
+			};
+
+			/* SDMMC3 pinmux */
+			sdmmc3_clk {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc3_cmd {
+				nvidia,pins = "sdmmc3_cmd_pa7",
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat3_pb4",
+						"sdmmc3_dat4_pd1",
+						"sdmmc3_dat5_pd0",
+						"sdmmc3_dat6_pd3",
+						"sdmmc3_dat7_pd4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SDMMC4 pinmux */
+			sdmmc4_clk {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc4_cmd {
+				nvidia,pins = "sdmmc4_cmd_pt7",
+						"sdmmc4_dat0_paa0",
+						"sdmmc4_dat1_paa1",
+						"sdmmc4_dat2_paa2",
+						"sdmmc4_dat3_paa3",
+						"sdmmc4_dat4_paa4",
+						"sdmmc4_dat5_paa5",
+						"sdmmc4_dat6_paa6",
+						"sdmmc4_dat7_paa7";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc4_rst_n {
+				nvidia,pins = "sdmmc4_rst_n_pcc3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			cam_mclk {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			drive_sdmmc4 {
+				nvidia,pins = "drive_gma",
+						"drive_gmb",
+						"drive_gmc",
+						"drive_gmd";
+				nvidia,pull-down-strength = <9>;
+				nvidia,pull-up-strength = <9>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+
+			/* I2C pinmux */
+			gen1_i2c {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+						"gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+
+			gen2_i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+
+			cam_i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+
+			ddc_i2c {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+
+			pwr_i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+
+			hotplug_i2c {
+				nvidia,pins = "pu4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* HDMI pinmux */
+			hdmi_cec {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			hdmi_hpd {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-A */
+			ulpi_data0_po1 {
+				nvidia,pins = "ulpi_data0_po1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_data1_po2 {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ulpi_data5_po6 {
+				nvidia,pins = "ulpi_data5_po6";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ulpi_data7_po0 {
+				nvidia,pins = "ulpi_data7_po0",
+						"ulpi_data2_po3",
+						"ulpi_data3_po4",
+						"ulpi_data4_po5",
+						"ulpi_data6_po7";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-B */
+			uartb_txd_rts {
+				nvidia,pins = "uart2_txd_pc2",
+						"uart2_rts_n_pj6";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			uartb_rxd_cts {
+				nvidia,pins = "uart2_rxd_pc3",
+						"uart2_cts_n_pj5";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-C */
+			uartc_rxd_cts {
+				nvidia,pins = "uart3_cts_n_pa1",
+						"uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			uartc_txd_rts {
+				nvidia,pins = "uart3_rts_n_pc0",
+						"uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* UART-D */
+			ulpi_nxt_py2 {
+				nvidia,pins = "ulpi_nxt_py2";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ulpi_clk_py0 {
+				nvidia,pins = "ulpi_clk_py0",
+						"ulpi_dir_py1",
+						"ulpi_stp_py3";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* I2S pinmux */
+			dap_i2s0 {
+				nvidia,pins = "dap1_fs_pn0",
+						"dap1_din_pn1",
+						"dap1_dout_pn2",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap_i2s1 {
+				nvidia,pins = "dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap3_fs {
+				nvidia,pins = "dap3_fs_pp0",
+						"dap3_din_pp1";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap3_dout {
+				nvidia,pins = "dap3_dout_pp2",
+						"dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap_i2s3 {
+				nvidia,pins = "dap4_fs_pp4",
+						"dap4_din_pp5",
+						"dap4_dout_pp6",
+						"dap4_sclk_pp7";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			nct_irq {
+				nvidia,pins = "pcc2";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Asus EC pinmux */
+			ec_irqs {
+				nvidia,pins = "kb_row10_ps2",
+						"kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ec_reqs {
+				nvidia,pins = "kb_col1_pq1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Memory type bootstrap */
+			mem_boostraps {
+				nvidia,pins = "gmi_ad4_pg4",
+						"gmi_ad5_pg5";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PCI-e pinmux */
+			pex_l2_rst_n {
+				nvidia,pins = "pex_l2_rst_n_pcc6",
+						"pex_l0_rst_n_pdd1",
+						"pex_l1_rst_n_pdd5";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l2_clkreq_n {
+				nvidia,pins = "pex_l2_clkreq_n_pcc7",
+						"pex_l0_prsnt_n_pdd0",
+						"pex_l0_clkreq_n_pdd2",
+						"pex_wake_n_pdd3",
+						"pex_l1_prsnt_n_pdd4",
+						"pex_l1_clkreq_n_pdd6",
+						"pex_l2_prsnt_n_pdd7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SPI pinmux */
+			spi1_mosi_px4 {
+				nvidia,pins = "spi1_mosi_px4",
+						"spi1_sck_px5",
+						"spi1_cs0_n_px6",
+						"spi1_miso_px7";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			hp_detect {
+				nvidia,pins = "spi2_cs1_n_pw2";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			mic_detect {
+				nvidia,pins = "spi2_sck_px2";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_a17_pb0 {
+				nvidia,pins = "gmi_a17_pb0",
+						"gmi_a16_pj7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_a18_pb1 {
+				nvidia,pins = "gmi_a18_pb1";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_a19_pk7 {
+				nvidia,pins = "gmi_a19_pk7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Display A pinmux */
+			lcd_pwr0_pb2 {
+				nvidia,pins = "lcd_pwr0_pb2",
+						"lcd_pclk_pb3",
+						"lcd_pwr1_pc1",
+						"lcd_d0_pe0",
+						"lcd_d1_pe1",
+						"lcd_d2_pe2",
+						"lcd_d3_pe3",
+						"lcd_d4_pe4",
+						"lcd_d5_pe5",
+						"lcd_d6_pe6",
+						"lcd_d7_pe7",
+						"lcd_d8_pf0",
+						"lcd_d9_pf1",
+						"lcd_d10_pf2",
+						"lcd_d11_pf3",
+						"lcd_d12_pf4",
+						"lcd_d13_pf5",
+						"lcd_d14_pf6",
+						"lcd_d15_pf7",
+						"lcd_de_pj1",
+						"lcd_hsync_pj3",
+						"lcd_vsync_pj4",
+						"lcd_d16_pm0",
+						"lcd_d17_pm1",
+						"lcd_d18_pm2",
+						"lcd_d19_pm3",
+						"lcd_d20_pm4",
+						"lcd_d21_pm5",
+						"lcd_d22_pm6",
+						"lcd_d23_pm7",
+						"lcd_cs1_n_pw0",
+						"lcd_m1_pw1",
+						"lcd_dc0_pn6",
+						"lcd_sck_pz4",
+						"lcd_sdin_pz2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			lcd_cs0_n_pn4 {
+				nvidia,pins = "lcd_cs0_n_pn4",
+						"lcd_sdout_pn5",
+						"lcd_wr_n_pz3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			blink {
+				nvidia,pins = "clk_32k_out_pa0";
+				nvidia,function = "blink";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* KBC keys */
+			kb_col0_pq0 {
+				nvidia,pins = "kb_col0_pq0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_col1_pq1 {
+				nvidia,pins = "kb_row1_pr1",
+						"kb_row3_pr3",
+						"kb_row6_pr6",
+						"kb_row8_ps0",
+						"kb_row9_ps1",
+						"kb_row11_ps3",
+						"kb_row14_ps6",
+						"kb_col6_pq6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			kb_col4_pq4 {
+				nvidia,pins = "kb_col4_pq4",
+						"kb_col5_pq5",
+						"kb_col7_pq7",
+						"kb_row2_pr2",
+						"kb_row4_pr4",
+						"kb_row5_pr5",
+						"kb_row12_ps4",
+						"kb_row13_ps5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_wp_n_pc7 {
+				nvidia,pins = "gmi_wp_n_pc7",
+						"gmi_wait_pi7",
+						"gmi_cs3_n_pk4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_cs0_n_pj0 {
+				nvidia,pins = "gmi_cs0_n_pj0",
+						"gmi_cs1_n_pj2",
+						"gmi_cs2_n_pk3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			vi_pclk_pt0 {
+				nvidia,pins = "vi_pclk_pt0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+				nvidia,io-reset = <0>;
+			};
+
+			/* GPIO keys pinmux */
+			power_key {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			vol_keys {
+				nvidia,pins = "kb_col2_pq2",
+						"kb_col3_pq3";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Bluetooth */
+			bt_shutdown {
+				nvidia,pins = "pu0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			bt_dev_wake {
+				nvidia,pins = "pu1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			bt_host_wake {
+				nvidia,pins = "pu6";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pu2 {
+				nvidia,pins = "pu2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pu3 {
+				nvidia,pins = "pu3";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pcc1 {
+				nvidia,pins = "pcc1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pv2 {
+				nvidia,pins = "pv2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pv3 {
+				nvidia,pins = "pv3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_vsync_pd6 {
+				nvidia,pins = "vi_vsync_pd6",
+						"vi_hsync_pd7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+				nvidia,io-reset = <0>;
+			};
+
+			vi_d10_pt2 {
+				nvidia,pins = "vi_d10_pt2",
+						"vi_d0_pt4", "pbb0";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			kb_row0_pr0 {
+				nvidia,pins = "kb_row0_pr0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad0_pg0 {
+				nvidia,pins = "gmi_ad0_pg0",
+						"gmi_ad1_pg1",
+						"gmi_ad2_pg2",
+						"gmi_ad3_pg3",
+						"gmi_ad6_pg6",
+						"gmi_ad7_pg7",
+						"gmi_wr_n_pi0",
+						"gmi_oe_n_pi1",
+						"gmi_dqs_pi2",
+						"gmi_adv_n_pk0",
+						"gmi_clk_pk1";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad13_ph5 {
+				nvidia,pins = "gmi_ad13_ph5";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_ad10_ph2 {
+				nvidia,pins = "gmi_ad10_ph2",
+						"gmi_ad11_ph3",
+						"gmi_ad14_ph6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad12_ph4 {
+				nvidia,pins = "gmi_ad12_ph4",
+						"gmi_rst_n_pi4",
+						"gmi_cs7_n_pi6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Vibrator control */
+			vibrator {
+				nvidia,pins = "gmi_ad15_ph7";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PWM pimnmux */
+			pwm_0 {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pwm_1 {
+				nvidia,pins = "gmi_ad9_ph1";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pwm_2 {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_cs6_n_pi3 {
+				nvidia,pins = "gmi_cs6_n_pi3";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Spdif pinmux */
+			spdif_out {
+				nvidia,pins = "spdif_out_pk5";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spdif_in {
+				nvidia,pins = "spdif_in_pk6";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			vi_d4_pl2 {
+				nvidia,pins = "vi_d4_pl2";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d6_pl4 {
+				nvidia,pins = "vi_d6_pl4";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,lock = <0>;
+				nvidia,io-reset = <0>;
+			};
+
+			vi_mclk_pt1 {
+				nvidia,pins = "vi_mclk_pt1";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			jtag_rtck {
+				nvidia,pins = "jtag_rtck_pu7";
+				nvidia,function = "rtck";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			crt_hsync_pv6 {
+				nvidia,pins = "crt_hsync_pv6",
+						"crt_vsync_pv7";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			clk1_out {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk2_out {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "extperiph2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk3_out {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sys_clk_req {
+				nvidia,pins = "sys_clk_req_pz5";
+				nvidia,function = "sysclk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb4 {
+				nvidia,pins = "pbb4";
+				nvidia,function = "vgp4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pbb5 {
+				nvidia,pins = "pbb5";
+				nvidia,function = "vgp5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pbb6 {
+				nvidia,pins = "pbb6";
+				nvidia,function = "vgp6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk2_req_pcc5 {
+				nvidia,pins = "clk2_req_pcc5",
+						"clk1_req_pee2";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk3_req_pee1 {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO power/drive control */
+			drive_dap1 {
+				nvidia,pins = "drive_dap1",
+						"drive_dap2",
+						"drive_dbg",
+						"drive_at5",
+						"drive_gme",
+						"drive_ddc",
+						"drive_ao1",
+						"drive_uart3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+
+			drive_sdio1 {
+				nvidia,pins = "drive_sdio1",
+						"drive_sdio3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,pull-down-strength = <46>;
+				nvidia,pull-up-strength = <42>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FAST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FAST>;
+			};
+		};
+	};
+
 	uarta: serial@70006000 {
 		status = "okay";
 	};
diff --git a/board/asus/transformer-t30/pinmux-config-transformer.h b/board/asus/transformer-t30/pinmux-config-transformer.h
deleted file mode 100644
index 96ff45d375..0000000000
--- a/board/asus/transformer-t30/pinmux-config-transformer.h
+++ /dev/null
@@ -1,365 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
- *
- * Copyright (c) 2021, Svyatoslav Ryhel.
- */
-
-#ifndef _PINMUX_CONFIG_TRANSFORMER_H_
-#define _PINMUX_CONFIG_TRANSFORMER_H_
-
-#define DEFAULT_PINMUX(_pingrp, _mux, _pull, _tri, _io)		\
-	{							\
-		.pingrp		= PMUX_PINGRP_##_pingrp,	\
-		.func		= PMUX_FUNC_##_mux,		\
-		.pull		= PMUX_PULL_##_pull,		\
-		.tristate	= PMUX_TRI_##_tri,		\
-		.io		= PMUX_PIN_##_io,		\
-		.lock		= PMUX_PIN_LOCK_DEFAULT,	\
-		.od		= PMUX_PIN_OD_DEFAULT,		\
-		.ioreset	= PMUX_PIN_IO_RESET_DEFAULT,	\
-	}
-
-#define I2C_PINMUX(_pingrp, _mux, _pull, _tri, _io, _lock, _od)	\
-	{							\
-		.pingrp		= PMUX_PINGRP_##_pingrp,	\
-		.func		= PMUX_FUNC_##_mux,		\
-		.pull		= PMUX_PULL_##_pull,		\
-		.tristate	= PMUX_TRI_##_tri,		\
-		.io		= PMUX_PIN_##_io,		\
-		.lock		= PMUX_PIN_LOCK_##_lock,	\
-		.od		= PMUX_PIN_OD_##_od,		\
-		.ioreset	= PMUX_PIN_IO_RESET_DEFAULT,	\
-	}
-
-#define LV_PINMUX(_pingrp, _mux, _pull, _tri, _io, _lock, _ioreset) \
-	{							\
-		.pingrp		= PMUX_PINGRP_##_pingrp,	\
-		.func		= PMUX_FUNC_##_mux,		\
-		.pull		= PMUX_PULL_##_pull,		\
-		.tristate	= PMUX_TRI_##_tri,		\
-		.io		= PMUX_PIN_##_io,		\
-		.lock		= PMUX_PIN_LOCK_##_lock,	\
-		.od		= PMUX_PIN_OD_DEFAULT,		\
-		.ioreset	= PMUX_PIN_IO_RESET_##_ioreset	\
-	}
-
-#define DEFAULT_PADCFG(_drvgrp, _slwf, _slwr, _drvup, _drvdn, _lpmd, _schmt, _hsm) \
-	{							\
-		.drvgrp		= PMUX_DRVGRP_##_drvgrp,	\
-		.slwf		= _slwf,			\
-		.slwr		= _slwr,			\
-		.drvup		= _drvup,			\
-		.drvdn		= _drvdn,			\
-		.lpmd		= PMUX_LPMD_##_lpmd,		\
-		.schmt		= PMUX_SCHMT_##_schmt,		\
-		.hsm		= PMUX_HSM_##_hsm,		\
-	}
-
-static struct pmux_pingrp_config transformer_pinmux_common[] = {
-	/* SDMMC1 pinmux */
-	DEFAULT_PINMUX(SDMMC1_CLK_PZ0,  SDMMC1,      NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_CMD_PZ1,  SDMMC1,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT3_PY4, SDMMC1,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT2_PY5, SDMMC1,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT1_PY6, SDMMC1,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT0_PY7, SDMMC1,          UP,    NORMAL,   INPUT),
-
-	/* SDMMC3 pinmux */
-	DEFAULT_PINMUX(SDMMC3_CLK_PA6,  SDMMC3,      NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_CMD_PA7,  SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT0_PB7, SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT1_PB6, SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT2_PB5, SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT3_PB4, SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT4_PD1, SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT5_PD0, SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT6_PD3, SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT7_PD4, SDMMC3,          UP,    NORMAL,   INPUT),
-
-	/* SDMMC4 pinmux */
-	LV_PINMUX(SDMMC4_CLK_PCC4,      SDMMC4,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_CMD_PT7,       SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT0_PAA0,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT1_PAA1,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT2_PAA2,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT3_PAA3,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT4_PAA4,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT5_PAA5,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT6_PAA6,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT7_PAA7,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_RST_N_PCC3,    RSVD1,         DOWN,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-
-	/* I2C pinmux */
-	I2C_PINMUX(GEN1_I2C_SCL_PC4,    I2C1,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-	I2C_PINMUX(GEN1_I2C_SDA_PC5,    I2C1,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-	I2C_PINMUX(GEN2_I2C_SCL_PT5,    I2C2,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-	I2C_PINMUX(GEN2_I2C_SDA_PT6,    I2C2,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-	I2C_PINMUX(CAM_I2C_SCL_PBB1,    I2C3,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-	I2C_PINMUX(CAM_I2C_SDA_PBB2,    I2C3,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-	I2C_PINMUX(DDC_SCL_PV4,         I2C4,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-	I2C_PINMUX(DDC_SDA_PV5,         I2C4,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-	I2C_PINMUX(PWR_I2C_SCL_PZ6,     I2CPWR,      NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-	I2C_PINMUX(PWR_I2C_SDA_PZ7,     I2CPWR,      NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
-
-	/* HDMI-CEC pinmux */
-	DEFAULT_PINMUX(HDMI_CEC_PEE3,   CEC,         NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(HDMI_INT_PN7,    RSVD1,       NORMAL,  TRISTATE,   INPUT),
-
-	/* ULPI pinmux */
-	DEFAULT_PINMUX(ULPI_DATA0_PO1,  UARTA,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(ULPI_DATA1_PO2,  UARTA,         DOWN,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(ULPI_DATA2_PO3,  UARTA,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(ULPI_DATA3_PO4,  UARTA,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(ULPI_DATA4_PO5,  UARTA,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(ULPI_DATA5_PO6,  UARTA,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(ULPI_DATA6_PO7,  UARTA,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(ULPI_DATA7_PO0,  UARTA,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(ULPI_CLK_PY0,    UARTD,       NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(ULPI_DIR_PY1,    UARTD,       NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(ULPI_NXT_PY2,    UARTD,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(ULPI_STP_PY3,    UARTD,       NORMAL,  TRISTATE,  OUTPUT),
-
-	/* DAP3 pinmux */
-	DEFAULT_PINMUX(DAP3_FS_PP0,     I2S2,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(DAP3_DIN_PP1,    I2S2,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(DAP3_DOUT_PP2,   I2S2,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP3_SCLK_PP3,   I2S2,        NORMAL,    NORMAL,   INPUT),
-
-	DEFAULT_PINMUX(PV0,             RSVD1,           UP,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PV2,             RSVD1,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PV3,             RSVD1,       NORMAL,  TRISTATE,  OUTPUT),
-
-	/* CLK2 pinmux */
-	DEFAULT_PINMUX(CLK2_OUT_PW5,    EXTPERIPH2,  NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(CLK2_REQ_PCC5,   DAP,         NORMAL,    NORMAL,   INPUT),
-
-	/* LCD pinmux */
-	DEFAULT_PINMUX(LCD_PWR1_PC1,    DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_PWR2_PC6,    DISPLAYA,    NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(LCD_SDIN_PZ2,    DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_SDOUT_PN5,   DISPLAYA,    NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(LCD_WR_N_PZ3,    DISPLAYA,    NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(LCD_CS0_N_PN4,   DISPLAYA,    NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(LCD_DC0_PN6,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_SCK_PZ4,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_PWR0_PB2,    DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_PCLK_PB3,    DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_DE_PJ1,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_HSYNC_PJ3,   DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_VSYNC_PJ4,   DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D0_PE0,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D1_PE1,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D2_PE2,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D3_PE3,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D4_PE4,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D5_PE5,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D6_PE6,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D7_PE7,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D8_PF0,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D9_PF1,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D10_PF2,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D11_PF3,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D12_PF4,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D13_PF5,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D14_PF6,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D15_PF7,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D16_PM0,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D17_PM1,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D18_PM2,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D19_PM3,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D20_PM4,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D21_PM5,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D22_PM6,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D23_PM7,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_CS1_N_PW0,   DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_M1_PW1,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_DC1_PD2,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(CRT_HSYNC_PV6,   CRT,         NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(CRT_VSYNC_PV7,   CRT,         NORMAL,  TRISTATE,  OUTPUT),
-
-	/* VI-group pinmux */
-	LV_PINMUX(VI_D0_PT4,            RSVD1,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D1_PD5,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D2_PL0,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D3_PL1,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D4_PL2,            VI,          NORMAL,    NORMAL,  OUTPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D5_PL3,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D6_PL4,            VI,          NORMAL,    NORMAL,  OUTPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D7_PL5,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D8_PL6,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D9_PL7,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D10_PT2,           RSVD1,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D11_PT3,           RSVD1,           UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_PCLK_PT0,          RSVD1,           UP,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_MCLK_PT1,          VI,              UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_HSYNC_PD7,         RSVD1,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_VSYNC_PD6,         RSVD1,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-
-	/* UART-B pinmux */
-	DEFAULT_PINMUX(UART2_RXD_PC3,   UARTB,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(UART2_TXD_PC2,   UARTB,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(UART2_RTS_N_PJ6, UARTB,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(UART2_CTS_N_PJ5, UARTB,       NORMAL,    NORMAL,   INPUT),
-
-	/* UART-C pinmux */
-	DEFAULT_PINMUX(UART3_TXD_PW6,   UARTC,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(UART3_RXD_PW7,   UARTC,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(UART3_CTS_N_PA1, UARTC,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(UART3_RTS_N_PC0, UARTC,       NORMAL,    NORMAL,  OUTPUT),
-
-	/* U-gpio group pinmux */
-	DEFAULT_PINMUX(PU0,             RSVD1,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PU1,             RSVD1,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PU2,             RSVD1,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PU3,             RSVD1,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PU4,             RSVD1,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PU5,             PWM2,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PU6,             RSVD1,         DOWN,    NORMAL,   INPUT),
-
-	/* DAP4 pinmux */
-	DEFAULT_PINMUX(DAP4_FS_PP4,     I2S3,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP4_DIN_PP5,    I2S3,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP4_DOUT_PP6,   I2S3,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP4_SCLK_PP7,   I2S3,        NORMAL,    NORMAL,   INPUT),
-
-	/* CLK3 pinmux */
-	DEFAULT_PINMUX(CLK3_OUT_PEE0,   EXTPERIPH3,  NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(CLK3_REQ_PEE1,   DEV3,        NORMAL,  TRISTATE,   INPUT),
-
-	DEFAULT_PINMUX(CAM_MCLK_PCC0,   VI_ALT3,         UP,    NORMAL,   INPUT),
-
-	DEFAULT_PINMUX(PCC1,            RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PBB0,            RSVD1,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PBB3,            VGP3,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PBB4,            VGP4,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PBB5,            VGP5,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PBB6,            VGP6,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PBB7,            I2S4,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PCC2,            I2S4,        NORMAL,    NORMAL,   INPUT),
-
-	DEFAULT_PINMUX(JTAG_RTCK_PU7,   RTCK,        NORMAL,    NORMAL,  OUTPUT),
-
-	/* KBC keys */
-	DEFAULT_PINMUX(KB_ROW0_PR0,     RSVD4,           UP,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(KB_ROW1_PR1,     KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW2_PR2,     KBC,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(KB_ROW3_PR3,     KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW4_PR4,     KBC,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(KB_ROW5_PR5,     KBC,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(KB_ROW6_PR6,     KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW7_PR7,     KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW8_PS0,     KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW9_PS1,     KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW10_PS2,    KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW11_PS3,    KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW12_PS4,    KBC,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(KB_ROW13_PS5,    KBC,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(KB_ROW14_PS6,    KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW15_PS7,    KBC,             UP,    NORMAL,   INPUT),
-
-	DEFAULT_PINMUX(KB_COL0_PQ0,     KBC,         NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(KB_COL1_PQ1,     KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_COL2_PQ2,     RSVD4,           UP,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(KB_COL3_PQ3,     RSVD4,           UP,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(KB_COL4_PQ4,     RSVD4,           UP,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(KB_COL5_PQ5,     KBC,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(KB_COL6_PQ6,     KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_COL7_PQ7,     KBC,         NORMAL,  TRISTATE,   INPUT),
-
-	/* CLK */
-	DEFAULT_PINMUX(CLK_32K_OUT_PA0, BLINK,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(SYS_CLK_REQ_PZ5, SYSCLK,      NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(OWR,             OWR,         NORMAL,    NORMAL,   INPUT),
-
-	/* DAP1 pinmux */
-	DEFAULT_PINMUX(DAP1_FS_PN0,     I2S0,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(DAP1_DIN_PN1,    I2S0,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(DAP1_DOUT_PN2,   I2S0,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(DAP1_SCLK_PN3,   I2S0,        NORMAL,  TRISTATE,   INPUT),
-
-	/* CLK1 pinmux */
-	DEFAULT_PINMUX(CLK1_REQ_PEE2,   DAP,         NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(CLK1_OUT_PW4,    EXTPERIPH1,  NORMAL,    NORMAL,   INPUT),
-
-	/* SPDIF pinmux */
-	DEFAULT_PINMUX(SPDIF_IN_PK6,    SPDIF,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SPDIF_OUT_PK5,   SPDIF,       NORMAL,  TRISTATE,  OUTPUT),
-
-	/* DAP2 pinmux */
-	DEFAULT_PINMUX(DAP2_FS_PA2,     I2S1,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP2_DIN_PA4,    I2S1,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP2_DOUT_PA5,   I2S1,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP2_SCLK_PA3,   I2S1,        NORMAL,    NORMAL,   INPUT),
-
-	/* SPI pinmux */
-	DEFAULT_PINMUX(SPI1_MOSI_PX4,   SPI1,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SPI1_SCK_PX5,    SPI1,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SPI1_CS0_N_PX6,  SPI1,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SPI1_MISO_PX7,   SPI1,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SPI2_SCK_PX2,    GMI,         NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SPI2_CS1_N_PW2,  SPI2,            UP,    NORMAL,   INPUT),
-
-	/* PEX pinmux */
-	DEFAULT_PINMUX(PEX_L0_PRSNT_N_PDD0,  PCIE,   NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PEX_L0_RST_N_PDD1,    PCIE,   NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PEX_L0_CLKREQ_N_PDD2, PCIE,   NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PEX_WAKE_N_PDD3,      PCIE,   NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PEX_L1_PRSNT_N_PDD4,  PCIE,   NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PEX_L1_RST_N_PDD5,    PCIE,   NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PEX_L1_CLKREQ_N_PDD6, PCIE,   NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PEX_L2_PRSNT_N_PDD7,  PCIE,   NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PEX_L2_RST_N_PCC6,    PCIE,   NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PEX_L2_CLKREQ_N_PCC7, PCIE,   NORMAL,    NORMAL,   INPUT),
-
-	/* GMI pinmux */
-	DEFAULT_PINMUX(GMI_WP_N_PC7,    RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_IORDY_PI5,   RSVD1,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_WAIT_PI7,    RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_ADV_N_PK0,   NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_CLK_PK1,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_CS2_N_PK3,   RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_CS3_N_PK4,   RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_CS7_N_PI6,   NAND,            UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_AD0_PG0,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD1_PG1,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD2_PG2,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD3_PG3,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD4_PG4,     NAND,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_AD5_PG5,     NAND,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_AD6_PG6,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD7_PG7,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD8_PH0,     PWM0,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD9_PH1,     PWM1,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD10_PH2,    NAND,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD11_PH3,    NAND,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD12_PH4,    NAND,            UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_AD13_PH5,    NAND,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_AD14_PH6,    NAND,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD15_PH7,    NAND,          DOWN,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_A16_PJ7,     SPI4,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_A17_PB0,     SPI4,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_A18_PB1,     SPI4,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_A19_PK7,     SPI4,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_WR_N_PI0,    NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_OE_N_PI1,    NAND,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(GMI_DQS_PI2,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
-};
-
-static struct pmux_pingrp_config tf700t_mipi_pinmux[] = {
-	DEFAULT_PINMUX(LCD_PWR2_PC6,    DISPLAYA,    NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(LCD_DC1_PD2,     DISPLAYA,    NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PBB3,            VGP3,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PBB7,            I2S4,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(SPI2_MOSI_PX0,   SPI2,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(KB_ROW7_PR7,     KBC,         NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_CS4_N_PK2,   GMI,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(CAM_MCLK_PCC0,   VI_ALT3,         UP,  TRISTATE,   INPUT),
-};
-
-static struct pmux_drvgrp_config transformer_padctrl[] = {
-	/* (_drvgrp, _slwf, _slwr, _drvup, _drvdn, _lpmd, _schmt, _hsm) */
-	DEFAULT_PADCFG(SDIO1, SDIOCFG_DRVUP_SLWF, SDIOCFG_DRVDN_SLWR, \
-		SDIOCFG_DRVUP, SDIOCFG_DRVDN, NONE, DISABLE, DISABLE),
-};
-#endif	/* _PINMUX_CONFIG_TRANSFORMER_H_ */
diff --git a/board/asus/transformer-t30/transformer-t30.c b/board/asus/transformer-t30/transformer-t30.c
index 7cac6fde6f..a3fac1ca36 100644
--- a/board/asus/transformer-t30/transformer-t30.c
+++ b/board/asus/transformer-t30/transformer-t30.c
@@ -9,30 +9,7 @@
 
 /* T30 Transformers derive from Cardhu board */
 
-#include <dm.h>
 #include <fdt_support.h>
-#include <asm/arch/pinmux.h>
-#include <asm/arch/gp_padctrl.h>
-
-#include "pinmux-config-transformer.h"
-
-/*
- * Routine: pinmux_init
- * Description: Do individual peripheral pinmux configs
- */
-void pinmux_init(void)
-{
-	pinmux_config_pingrp_table(transformer_pinmux_common,
-		ARRAY_SIZE(transformer_pinmux_common));
-
-	pinmux_config_drvgrp_table(transformer_padctrl,
-		ARRAY_SIZE(transformer_padctrl));
-
-	if (of_machine_is_compatible("asus,tf700t")) {
-		pinmux_config_pingrp_table(tf700t_mipi_pinmux,
-			ARRAY_SIZE(tf700t_mipi_pinmux));
-	}
-}
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
-- 
2.40.1

