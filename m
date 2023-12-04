Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3606BC46CA0
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30979878DA;
	Mon,  4 Dec 2023 09:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzFmNWD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF32087896; Mon,  4 Dec 2023 09:21:18 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5624878E6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50bf26f8988so1170208e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701678075; x=1702282875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BigMOZQr98HQH8qkRW6F8wTnQBY3C1cKNBtgpQos5GM=;
 b=dzFmNWD7X6lxQQTXy3ezJFJJQZW3N9C8tHQtyA/V8gy6nUuAxvcPWHxRAOzY7W/TD2
 o3rCohhklDd975Pkg2TMqNQx98Pj9NQEm+aU1K9rmLZh+YZIk5OlDtwr5vRBeTaDN/j2
 FCYdF2VVHtGJAboVu2ovWkMoViUnC+GghG+tStk3XMkGIUYAg6j1gox1rCXJXOpjWHrK
 RS7hq4Xg2COrgLVcf+stLYtR6cxeN5qHEYh01Si9Zu+oXTXyHmOZknwvpYP6FkuDOgXd
 lajgGgwiGSCl2IGFSCSRrPLg3mFLgVwwSH2n8c9jchNTIxGM7T5X/3h1oUFOjYo3qsA0
 WGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678075; x=1702282875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BigMOZQr98HQH8qkRW6F8wTnQBY3C1cKNBtgpQos5GM=;
 b=FPuiF60dKAH2ZtrKuLcshBpCyoVkAdNzXHjwBn++CtBEm4FpfXXItm5tbMymUDcIm4
 KMZRMBsDAHW5xJjSegRIcr+klK2YE0oe0Nuupd/A1gxyy1wEw6XpHNXOCqnnGHdl+W05
 c8iiW+qAKMpOcfgZRosjhl1oLGLlP1WBa7cM/qoJDJkeggn9fMrwVZqHOz/eQUmw8ltC
 dh/1/B8oKrN4LgC7rVn454oWVVmy+n7eMJXc7iCxKmEjSZYHeuUhZhIJ+QHr85RakJQg
 SGaIh75lB0rSQd6L278HCQP3Ot7Tql0l1fHs0mbWAIb+bJkJY5cs9PnEe9rG0pVQzl71
 AvGw==
X-Gm-Message-State: AOJu0YztpHWmiT/mhz7Hvgfa+eFzFu4XIAO1xgVzdupBluEJIswEMwSE
 wgikd30N+gNllQOxdBbKHao=
X-Google-Smtp-Source: AGHT+IHhTuVajP08UoY0P11p8uBueLYheHrhlToER5hMWlvuF2DieB/47hwDOonO8tBHjoaJhD1d0w==
X-Received: by 2002:a05:6512:2512:b0:50b:f86b:b3b4 with SMTP id
 be18-20020a056512251200b0050bf86bb3b4mr598873lfb.117.1701678074703; 
 Mon, 04 Dec 2023 00:21:14 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 q16-20020a19a410000000b0050bfe62b073sm3655lfc.170.2023.12.04.00.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:21:14 -0800 (PST)
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
Subject: [PATCH v1 7/8] board: htc: endeavoru: switch to DM pinmux
Date: Mon,  4 Dec 2023 10:20:53 +0200
Message-Id: <20231204082054.4943-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204082054.4943-1-clamor95@gmail.com>
References: <20231204082054.4943-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Drop the pinmux setup in the board in favor of setting it up in
the device tree. Device tree nodes match nodes used for the Linux
device tree and are set according to the downstream kernel. 

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-htc-endeavoru.dts        | 1147 +++++++++++++++++
 board/htc/endeavoru/endeavoru.c               |   14 -
 board/htc/endeavoru/pinmux-config-endeavoru.h |  362 ------
 3 files changed, 1147 insertions(+), 376 deletions(-)
 delete mode 100644 board/htc/endeavoru/pinmux-config-endeavoru.h

diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
index 21cd0f9207..dbff795bd8 100644
--- a/arch/arm/dts/tegra30-htc-endeavoru.dts
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -52,6 +52,1153 @@
 		};
 	};
 
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* PORT A */
+			clk_32k_out {
+				nvidia,pins = "clk_32k_out_pa0";
+				nvidia,function = "blink";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt_uart_cts {
+				nvidia,pins = "uart3_cts_n_pa1";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_aic3008_i2s {
+				nvidia,pins = "dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			wifi_sdio_clock {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			wifi_sdio_command {
+				nvidia,pins = "sdmmc3_cmd_pa7";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT B */
+			mdm_imc_uart {
+				nvidia,pins = "gmi_a17_pb0",
+						"gmi_a18_pb1";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_3v3_en {
+				nvidia,pins = "lcd_pwr0_pb2",
+						"lcd_pclk_pb3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			wifi_sdio_data {
+				nvidia,pins = "sdmmc3_dat3_pb4",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat0_pb7";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT C */
+			bt_uart_rts {
+				nvidia,pins = "uart3_rts_n_pc0";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mdm_ap2bb_rst_pwrdwn {
+				nvidia,pins = "lcd_pwr1_pc1";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			cam_spi_clk_do {
+				nvidia,pins = "uart2_txd_pc2",
+						"uart2_rxd_pc3";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			per_sensor_i2c {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+						"gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+			mdm_ap2bb_slave_wakeup {
+				nvidia,pins = "lcd_pwr2_pc6";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mhl_int {
+				nvidia,pins = "gmi_wp_n_pc7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT D */
+			sdmmc3_data {
+				nvidia,pins = "sdmmc3_dat5_pd0",
+						"sdmmc3_dat4_pd1";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_1v8_en {
+				nvidia,pins = "lcd_dc1_pd2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3_dat6_pd3 {
+				nvidia,pins = "sdmmc3_dat6_pd3",
+						"sdmmc3_dat7_pd4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT E */
+			mhl_usb_sel {
+				nvidia,pins = "lcd_d0_pe0";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd_d1_pe1 {
+				nvidia,pins = "lcd_d1_pe1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			peh_cap_int {
+				nvidia,pins = "lcd_d2_pe2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mhl_1v2_en {
+				nvidia,pins = "lcd_d3_pe3",
+						"lcd_d4_pe4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dsp_lcm_1v8_en {
+				nvidia,pins = "lcd_d5_pe5";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mhl_rst {
+				nvidia,pins = "lcd_d6_pe6";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			peh_vibrator_on {
+				nvidia,pins = "lcd_d7_pe7";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT F */
+			cam_vcm_2v85_pwr {
+				nvidia,pins = "lcd_d8_pf0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_d9_d13 {
+				nvidia,pins = "lcd_d9_pf1",
+						"lcd_d10_pf2",
+						"lcd_d11_pf3",
+						"lcd_d12_pf4",
+						"lcd_d13_pf5";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam_cam2_core_1v8_en {
+				nvidia,pins = "lcd_d14_pf6";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sys_pmu_msecure {
+				nvidia,pins = "lcd_d15_pf7";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PORT G */
+			bootstraps {
+				nvidia,pins = "gmi_ad0_pg0",
+						"gmi_ad1_pg1",
+						"gmi_ad2_pg2",
+						"gmi_ad3_pg3",
+						"gmi_ad4_pg4",
+						"gmi_ad5_pg5",
+						"gmi_ad6_pg6",
+						"gmi_ad7_pg7";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT H */
+			haptic_pwm {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_ad9 {
+				nvidia,pins = "gmi_ad9_ph1";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_ad10 {
+				nvidia,pins = "gmi_ad10_ph2";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dsp_tp_rst {
+				nvidia,pins = "gmi_ad11_ph3",
+						"gmi_ad12_ph4",
+						"gmi_ad13_ph5",
+						"gmi_ad14_ph6";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_ad15 {
+				nvidia,pins = "gmi_ad15_ph7";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT I */
+			gmi_wr_n {
+				nvidia,pins = "gmi_wr_n_pi0",
+						"gmi_oe_n_pi1",
+						"gmi_dqs_pi2",
+						"gmi_cs6_n_pi3";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_rst_n_pi4 {
+				nvidia,pins = "gmi_rst_n_pi4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sim_detect {
+				nvidia,pins = "gmi_iordy_pi5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			peh_gyr_int {
+				nvidia,pins = "gmi_cs7_n_pi6",
+						"gmi_wait_pi7";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT J */
+			mdm_bb2ap_host_wakeup {
+				nvidia,pins = "gmi_cs0_n_pj0";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dsp_lcm_de {
+				nvidia,pins = "lcd_de_pj1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			peh_comp_int {
+				nvidia,pins = "gmi_cs1_n_pj2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_hsync {
+				nvidia,pins = "lcd_hsync_pj3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mdm_ap_usb_uart_oe {
+				nvidia,pins = "lcd_vsync_pj4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mcam_spi_di_cs0 {
+				nvidia,pins = "uart2_cts_n_pj5",
+						"uart2_rts_n_pj6";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mdm_tx {
+				nvidia,pins = "gmi_a16_pj7";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PORT K */
+			gmi_adv_n {
+				nvidia,pins = "gmi_adv_n_pk0",
+						"gmi_clk_pk1",
+						"gmi_cs2_n_pk3";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_cs4_n {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_cs3_n {
+				nvidia,pins = "gmi_cs3_n_pk4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
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
+			mdm_rts {
+				nvidia,pins = "gmi_a19_pk7";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PORT L */
+			port_l {
+				nvidia,pins = "vi_d2_pl0",
+						"vi_d3_pl1",
+						"vi_d4_pl2",
+						"vi_d5_pl3",
+						"vi_d6_pl4",
+						"vi_d7_pl5",
+						"vi_d8_pl6",
+						"vi_d9_pl7";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT M */
+			dsp_lcd_id {
+				nvidia,pins = "lcd_d16_pm0",
+						"lcd_d17_pm1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			front_cam_rst {
+				nvidia,pins = "lcd_d18_pm2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mdm_v_dcin_modem_en {
+				nvidia,pins = "lcd_d19_pm3",
+						"lcd_d20_pm4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			nfc_pins {
+				nvidia,pins = "lcd_d21_pm5",
+						"lcd_d22_pm6";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			cam_vaa_2v85_en {
+				nvidia,pins = "lcd_d23_pm7";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT N */
+			mdm_ap2bb_rst_host_pwr {
+				nvidia,pins = "dap1_fs_pn0",
+						"dap1_din_pn1",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mdm_bb_fatal_int {
+				nvidia,pins = "dap1_dout_pn2";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_cs0_n {
+				nvidia,pins = "lcd_cs0_n_pn4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_sdout {
+				nvidia,pins = "lcd_sdout_pn5";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dsp_lcd_rst {
+				nvidia,pins = "lcd_dc0_pn6";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mhl_hpd {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT O */
+			ap_usb_uart_sel {
+				nvidia,pins = "ulpi_data7_po0";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bsp_ap_debug_tx {
+				nvidia,pins = "ulpi_data0_po1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bsp_ap_debug_rx {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi_data2 {
+				nvidia,pins = "ulpi_data2_po3";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			con_wifi_irq {
+				nvidia,pins = "ulpi_data3_po4";
+				nvidia,function = "hsi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			per_gsensor_int {
+				nvidia,pins = "ulpi_data4_po5";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi_data5_data6 {
+				nvidia,pins = "ulpi_data5_po6",
+						"ulpi_data6_po7";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT P */
+			aud_ap_pcm {
+				nvidia,pins = "dap3_fs_pp0",
+						"dap3_din_pp1",
+						"dap3_dout_pp2",
+						"dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_btpcm {
+				nvidia,pins = "dap4_fs_pp4",
+						"dap4_din_pp5";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_ext {
+				nvidia,pins = "dap4_dout_pp6",
+						"dap4_sclk_pp7";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PORT Q */
+			port_q {
+				nvidia,pins = "kb_col0_pq0",
+						"kb_col1_pq1",
+						"kb_col2_pq2",
+						"kb_col3_pq3",
+						"kb_col4_pq4",
+						"kb_col5_pq5",
+						"kb_col6_pq6",
+						"kb_col7_pq7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT R */
+			raw_intr0 {
+				nvidia,pins = "kb_row0_pr0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			per_torch_en {
+				nvidia,pins = "kb_row1_pr1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gyro_pwr {
+				nvidia,pins = "kb_row2_pr2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			haptic_en {
+				nvidia,pins = "kb_row3_pr3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb_row4_row5 {
+				nvidia,pins = "kb_row4_pr4",
+						"kb_row5_pr5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam_id {
+				nvidia,pins = "kb_row6_pr6",
+						"kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT S */
+			dsp_vol_up {
+				nvidia,pins = "kb_row8_ps0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			con_usb_id_1 {
+				nvidia,pins = "kb_row9_ps1",
+						"kb_row10_ps2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			port_s {
+				nvidia,pins = "kb_row11_ps3",
+						"kb_row12_ps4",
+						"kb_row13_ps5",
+						"kb_row14_ps6",
+						"kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT T */
+			dsp_tw_i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+			per_emmc_cmd {
+				nvidia,pins = "sdmmc4_cmd_pt7";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT U */
+			con_bt_en {
+				nvidia,pins = "pu0", "pu1", "pu2",
+						"pu3", "pu4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			per_capsensor_int_cpu {
+				nvidia,pins = "pu5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dsp_ap_kpdpwr {
+				nvidia,pins = "pu6";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			jtag_rtck {
+				nvidia,pins = "jtag_rtck_pu7";
+				nvidia,function = "rtck";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT V */
+			mdm_bb2ap_suspend_req {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dsp_tp_att {
+				nvidia,pins = "pv1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			con_wifi_en {
+				nvidia,pins = "pv2", "pv3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mhl_ddc {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			crt_hsync {
+				nvidia,pins = "crt_hsync_pv6";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			crt_vsync {
+				nvidia,pins = "crt_vsync_pv7";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PORT W */
+			pwr_chg_stat {
+				nvidia,pins = "lcd_cs1_n_pw0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dsp_bl_pwm_cpu {
+				nvidia,pins = "lcd_m1_pw1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			aud_hp_det {
+				nvidia,pins = "spi2_cs1_n_pw2";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dsp_vol_down {
+				nvidia,pins = "spi2_cs2_n_pw3";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_mclk {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_aic3008_rst {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			con_bt_tx {
+				nvidia,pins = "uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			con_bt_rx {
+				nvidia,pins = "uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT X */
+			aud_spi_do {
+				nvidia,pins = "spi2_mosi_px0",
+						"spi2_sck_px2",
+						"spi2_cs0_n_px3";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			aud_spi_di {
+				nvidia,pins = "spi2_miso_px1";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi1_mosi {
+				nvidia,pins = "spi1_mosi_px4";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pwr_chg_int {
+				nvidia,pins = "spi1_sck_px5";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi1_cs0_n {
+				nvidia,pins = "spi1_cs0_n_px6";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			audio_mclk_en {
+				nvidia,pins = "spi1_miso_px7";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PORT Y */
+			led_drv_en_trig {
+				nvidia,pins = "ulpi_clk_py0",
+						"ulpi_dir_py1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mhl_3v3_en {
+				nvidia,pins = "ulpi_nxt_py2";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			peh_v_srio_1v8_en {
+				nvidia,pins = "ulpi_stp_py3";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_remo_tx {
+				nvidia,pins = "sdmmc1_dat3_py4";
+				nvidia,function = "uarte";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			aud_remo_rx {
+				nvidia,pins = "sdmmc1_dat2_py5";
+				nvidia,function = "uarte";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			nfc_irq {
+				nvidia,pins = "sdmmc1_dat1_py6";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			testpoint1 {
+				nvidia,pins = "sdmmc1_dat0_py7";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT Z */
+			aud_remo_oe {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			testpoint2 {
+				nvidia,pins = "sdmmc1_cmd_pz1";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mdm_usb_uart_oe {
+				nvidia,pins = "lcd_sdin_pz2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_wr_n {
+				nvidia,pins = "lcd_wr_n_pz3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_sck {
+				nvidia,pins = "lcd_sck_pz4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
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
+			sys_pwr_i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT AA */
+			bsp_emmc {
+				nvidia,pins = "sdmmc4_dat0_paa0",
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
+			/* PORT BB */
+			cam1_rst {
+				nvidia,pins = "pbb0";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam_i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+			per_flash_en {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			cam_vddio_1v8_en {
+				nvidia,pins = "pbb4";
+				nvidia,function = "vgp4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam1_vcm_pd {
+				nvidia,pins = "pbb5";
+				nvidia,function = "vgp5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_remo_pres {
+				nvidia,pins = "pbb6";
+				nvidia,function = "vgp6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			front_cam_standby {
+				nvidia,pins = "pbb7";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT CC */
+			cam_mclk {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam_sel {
+				nvidia,pins = "pcc1";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pwr_themp_alert_int {
+				nvidia,pins = "pcc2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bsp_emmc_resout {
+				nvidia,pins = "sdmmc4_rst_n_pcc3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bsp_emmc_clk {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			aud_dock_out_en {
+				nvidia,pins = "clk2_req_pcc5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PORT DD */
+			/* PORT EE */
+			clk3_out {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			raw_intr1 {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk1_req {
+				nvidia,pins = "clk1_req_pee2";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			hdmi_cec {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
+
 	uarta: serial@70006000 {
 		status = "okay";
 	};
diff --git a/board/htc/endeavoru/endeavoru.c b/board/htc/endeavoru/endeavoru.c
index 7fb6125b14..78eb34e7d4 100644
--- a/board/htc/endeavoru/endeavoru.c
+++ b/board/htc/endeavoru/endeavoru.c
@@ -7,21 +7,7 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <dm.h>
 #include <fdt_support.h>
-#include <asm/arch/pinmux.h>
-
-#include "pinmux-config-endeavoru.h"
-
-/*
- * Routine: pinmux_init
- * Description: Do individual peripheral pinmux configs
- */
-void pinmux_init(void)
-{
-	pinmux_config_pingrp_table(endeavoru_pinmux_common,
-		ARRAY_SIZE(endeavoru_pinmux_common));
-}
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/board/htc/endeavoru/pinmux-config-endeavoru.h b/board/htc/endeavoru/pinmux-config-endeavoru.h
deleted file mode 100644
index a00c5c988f..0000000000
--- a/board/htc/endeavoru/pinmux-config-endeavoru.h
+++ /dev/null
@@ -1,362 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
- *
- * Copyright (c) 2022, Svyatoslav Ryhel.
- */
-
-#ifndef _PINMUX_CONFIG_ENDEAVORU_H_
-#define _PINMUX_CONFIG_ENDEAVORU_H_
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
-static struct pmux_pingrp_config endeavoru_pinmux_common[] = {
-	/* SDMMC1 pinmux */
-	DEFAULT_PINMUX(SDMMC1_CLK_PZ0,  SDMMC1, NORMAL,   NORMAL, OUTPUT),
-	DEFAULT_PINMUX(SDMMC1_CMD_PZ1,  SDMMC1,     UP,   NORMAL,  INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT3_PY4,  UARTE, NORMAL,   NORMAL, OUTPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT2_PY5,  UARTE, NORMAL,   NORMAL,  INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT1_PY6,  RSVD2, NORMAL, TRISTATE,  INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT0_PY7, SDMMC1,     UP,   NORMAL,  INPUT),
-
-	/* SDMMC3 pinmux */
-	DEFAULT_PINMUX(SDMMC3_CLK_PA6,   SDMMC3, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(SDMMC3_CMD_PA7,   SDMMC3,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT0_PB7,  SDMMC3,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT1_PB6,  SDMMC3,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT2_PB5,  SDMMC3,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT3_PB4,  SDMMC3,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT4_PD1,  SDMMC3,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT5_PD0,  SDMMC3,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT6_PD3, INVALID, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT7_PD4, INVALID, NORMAL, NORMAL, INPUT),
-
-	/* SDMMC4 pinmux */
-	LV_PINMUX(SDMMC4_CLK_PCC4,  SDMMC4, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_CMD_PT7,   SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_DAT0_PAA0, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_DAT1_PAA1, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_DAT2_PAA2, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_DAT3_PAA3, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_DAT4_PAA4, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_DAT5_PAA5, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_DAT6_PAA6, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_DAT7_PAA7, SDMMC4,     UP, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(SDMMC4_RST_N_PCC3, RSVD2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-
-	/* I2C pinmux */
-	I2C_PINMUX(GEN1_I2C_SCL_PC4,  I2C1, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-	I2C_PINMUX(GEN1_I2C_SDA_PC5,  I2C1, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-	I2C_PINMUX(GEN2_I2C_SCL_PT5,  I2C2, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-	I2C_PINMUX(GEN2_I2C_SDA_PT6,  I2C2, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-	I2C_PINMUX(CAM_I2C_SCL_PBB1,  I2C3, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-	I2C_PINMUX(CAM_I2C_SDA_PBB2,  I2C3, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-	I2C_PINMUX(DDC_SCL_PV4,       I2C4, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-	I2C_PINMUX(DDC_SDA_PV5,       I2C4, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-	I2C_PINMUX(PWR_I2C_SCL_PZ6, I2CPWR, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-	I2C_PINMUX(PWR_I2C_SDA_PZ7, I2CPWR, NORMAL, NORMAL, INPUT, DISABLE, ENABLE),
-
-	/* HDMI pinmux */
-	DEFAULT_PINMUX(HDMI_CEC_PEE3,  CEC, NORMAL,   NORMAL, INPUT),
-	DEFAULT_PINMUX(HDMI_INT_PN7, RSVD1, NORMAL, TRISTATE, INPUT),
-
-	/* ULPI pinmux */
-	DEFAULT_PINMUX(ULPI_DATA0_PO1, UARTA, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(ULPI_DATA1_PO2, UARTA, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(ULPI_DATA2_PO3,  SPI3, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(ULPI_DATA3_PO4,   HSI, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(ULPI_DATA4_PO5,  SPI2, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(ULPI_DATA5_PO6,  ULPI, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(ULPI_DATA6_PO7,  ULPI, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(ULPI_DATA7_PO0,  SPI2, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(ULPI_CLK_PY0,   RSVD2, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(ULPI_DIR_PY1,   RSVD2, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(ULPI_NXT_PY2,    ULPI, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(ULPI_STP_PY3,    ULPI, NORMAL, NORMAL,  INPUT),
-
-	/* DAP3 pinmux */
-	DEFAULT_PINMUX(DAP3_FS_PP0,   I2S2, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(DAP3_DIN_PP1,  I2S2, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(DAP3_DOUT_PP2, I2S2, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(DAP3_SCLK_PP3, I2S2, NORMAL, NORMAL, INPUT),
-
-	/* PV-gpio group pinmux */
-	DEFAULT_PINMUX(PV0, RSVD1, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(PV1, RSVD1, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(PV2, RSVD2, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(PV3, RSVD2, NORMAL, NORMAL, OUTPUT),
-
-	/* CLK2 pinmux */
-	DEFAULT_PINMUX(CLK2_OUT_PW5,  RSVD4, NORMAL, NORMAL,  INPUT),
-	DEFAULT_PINMUX(CLK2_REQ_PCC5, RSVD4, NORMAL, NORMAL, OUTPUT),
-
-	/* LCD pinmux */
-	DEFAULT_PINMUX(LCD_PWR1_PC1,     RSVD4, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_PWR2_PC6,  DISPLAYA, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_SDIN_PZ2,  DISPLAYA,     UP, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_SDOUT_PN5, DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_WR_N_PZ3,  DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_CS0_N_PN4,    RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_DC0_PN6,   DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_SCK_PZ4,   DISPLAYA,     UP, TRISTATE, OUTPUT),
-	DEFAULT_PINMUX(LCD_PWR0_PB2,  DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_PCLK_PB3,  DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_DE_PJ1,    DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_HSYNC_PJ3, DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_VSYNC_PJ4, DISPLAYA,   DOWN, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D0_PE0,    DISPLAYA, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_D1_PE1,    DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D2_PE2,       RSVD3, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_D3_PE3,    DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D4_PE4,    DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D5_PE5,    DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D6_PE6,       RSVD3, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D7_PE7,    DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D8_PF0,       RSVD4,   DOWN, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D9_PF1,    DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D10_PF2,   DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D11_PF3,   DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D12_PF4,   DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D13_PF5,   DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D14_PF6,      RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D15_PF7,      RSVD4, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_D16_PM0,   DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D17_PM1,   DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D18_PM2,      RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D19_PM3,      RSVD4, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_D20_PM4,   DISPLAYA, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_D21_PM5,      RSVD4, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_D22_PM6,      RSVD4, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_D23_PM7,      RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_CS1_N_PW0,    RSVD4,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(LCD_M1_PW1,    DISPLAYA, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(LCD_DC1_PD2,      RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(CRT_HSYNC_PV6,      CRT, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(CRT_VSYNC_PV7,    RSVD4, NORMAL, NORMAL, OUTPUT),
-
-	/* VI-group pinmux */
-	LV_PINMUX(VI_D0_PT4,    INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D1_PD5,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D2_PL0,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D3_PL1,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D4_PL2,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D5_PL3,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D6_PL4,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D7_PL5,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D8_PL6,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D9_PL7,     SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D10_PT2,   INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_D11_PT3,   INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_PCLK_PT0,   SDMMC2, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_MCLK_PT1,  INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_VSYNC_PD6, INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-	LV_PINMUX(VI_HSYNC_PD7, INVALID, NORMAL, NORMAL, INPUT, DISABLE, DISABLE),
-
-	/* UART-2 pinmux */
-	DEFAULT_PINMUX(UART2_RXD_PC3,   SPI4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(UART2_TXD_PC2,   SPI4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(UART2_RTS_N_PJ6, SPI4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(UART2_CTS_N_PJ5, SPI4, NORMAL, NORMAL, INPUT),
-
-	/* UART-3 pinmux */
-	DEFAULT_PINMUX(UART3_TXD_PW6,   UARTC, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(UART3_RXD_PW7,   UARTC,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(UART3_CTS_N_PA1, UARTC,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(UART3_RTS_N_PC0, UARTC, NORMAL, NORMAL, OUTPUT),
-
-	/* PU-gpio group pinmux */
-	DEFAULT_PINMUX(PU0, RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PU1, RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PU2, RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PU3, RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PU4, RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PU5, RSVD4,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(PU6,  PWM3,     UP, TRISTATE, INPUT),
-
-	/* DAP4 pinmux */
-	DEFAULT_PINMUX(DAP4_FS_PP4,    I2S3,   DOWN, NORMAL, INPUT),
-	DEFAULT_PINMUX(DAP4_DIN_PP5,   I2S3,   DOWN, NORMAL, INPUT),
-	DEFAULT_PINMUX(DAP4_DOUT_PP6, RSVD4, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(DAP4_SCLK_PP7, RSVD4, NORMAL, NORMAL, OUTPUT),
-
-	/* CLK3 pinmux */
-	DEFAULT_PINMUX(CLK3_OUT_PEE0, EXTPERIPH3, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(CLK3_REQ_PEE1,      RSVD4, NORMAL, TRISTATE, INPUT),
-
-	/* GMI pinmux */
-	DEFAULT_PINMUX(GMI_WP_N_PC7,  RSVD1,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_IORDY_PI5, RSVD1, NORMAL, TRISTATE, INPUT),
-	DEFAULT_PINMUX(GMI_WAIT_PI7,  RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_ADV_N_PK0, RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_CLK_PK1,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_CS0_N_PJ0,   GMI, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_CS1_N_PJ2, RSVD1, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_CS2_N_PK3, RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_CS3_N_PK4, RSVD1, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_CS4_N_PK2, RSVD4,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_CS6_N_PI3,  NAND, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_CS7_N_PI6,  NAND, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD0_PG0,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD1_PG1,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD2_PG2,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD3_PG3,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD4_PG4,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD5_PG5,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD6_PG6,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD7_PG7,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD8_PH0,    PWM0, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(GMI_AD9_PH1,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD10_PH2,   NAND, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(GMI_AD11_PH3,  RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD12_PH4,  RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD13_PH5,  RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD14_PH6,  RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_AD15_PH7,   NAND,   UP, TRISTATE, INPUT),
-	DEFAULT_PINMUX(GMI_A16_PJ7,   UARTD, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(GMI_A17_PB0,   UARTD, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_A18_PB1,   UARTD, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_A19_PK7,   UARTD, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(GMI_WR_N_PI0,  RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_OE_N_PI1,  RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_DQS_PI2,   RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(GMI_RST_N_PI4, RSVD4,   UP, TRISTATE, INPUT),
-
-	DEFAULT_PINMUX(CAM_MCLK_PCC0, VI_ALT3, NORMAL, NORMAL, INPUT),
-
-	DEFAULT_PINMUX(PCC1, RSVD3, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PBB0, RSVD3, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PBB3,  VGP3, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(PBB4,  VGP4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PBB5,  VGP5, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PBB6,  VGP6, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PBB7, RSVD3, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PCC2, RSVD3,     UP, NORMAL, INPUT),
-
-	DEFAULT_PINMUX(JTAG_RTCK_PU7, RTCK, UP, NORMAL, INPUT),
-
-	/* KBC keys */
-	DEFAULT_PINMUX(KB_ROW0_PR0, RSVD4, NORMAL, TRISTATE, INPUT),
-	DEFAULT_PINMUX(KB_ROW1_PR1,   KBC, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(KB_ROW2_PR2, RSVD4, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(KB_ROW3_PR3, RSVD3, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_ROW4_PR4, RSVD4, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_ROW5_PR5,   KBC, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(KB_ROW6_PR6,   KBC, NORMAL, TRISTATE, INPUT),
-	DEFAULT_PINMUX(KB_ROW7_PR7,   KBC,     UP, TRISTATE, INPUT),
-	DEFAULT_PINMUX(KB_ROW8_PS0,   KBC,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_ROW9_PS1,   KBC, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_ROW10_PS2,  KBC, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_ROW11_PS3,  KBC, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_ROW12_PS4,  KBC, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_ROW13_PS5,  KBC, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_ROW14_PS6,  KBC, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_ROW15_PS7,  KBC, NORMAL, NORMAL, INPUT),
-
-	DEFAULT_PINMUX(KB_COL0_PQ0, KBC,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_COL1_PQ1, KBC,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_COL2_PQ2, KBC,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_COL3_PQ3, KBC,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_COL4_PQ4, KBC,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_COL5_PQ5, KBC,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_COL6_PQ6, KBC, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(KB_COL7_PQ7, KBC, NORMAL, NORMAL, INPUT),
-
-	/* CLK */
-	DEFAULT_PINMUX(CLK_32K_OUT_PA0, BLINK, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(SYS_CLK_REQ_PZ5, SYSCLK, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(OWR, OWR, UP, NORMAL, INPUT),
-
-	/* DAP1 pinmux */
-	DEFAULT_PINMUX(DAP1_FS_PN0,   I2S0, NORMAL, TRISTATE, OUTPUT),
-	DEFAULT_PINMUX(DAP1_DIN_PN1,  I2S0, NORMAL, TRISTATE, OUTPUT),
-	DEFAULT_PINMUX(DAP1_DOUT_PN2, I2S0, NORMAL, TRISTATE, INPUT),
-	DEFAULT_PINMUX(DAP1_SCLK_PN3, I2S0, NORMAL, TRISTATE, OUTPUT),
-
-	/* CLK1 pinmux */
-	DEFAULT_PINMUX(CLK1_REQ_PEE2, DAP, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(CLK1_OUT_PW4, RSVD4, NORMAL, NORMAL, INPUT),
-
-	/* SPDIF pinmux */
-	DEFAULT_PINMUX(SPDIF_IN_PK6, SPDIF, NORMAL, TRISTATE, INPUT),
-	DEFAULT_PINMUX(SPDIF_OUT_PK5, SPDIF, NORMAL, TRISTATE, OUTPUT),
-
-	/* DAP2 pinmux */
-	DEFAULT_PINMUX(DAP2_FS_PA2,   I2S1, DOWN, NORMAL, INPUT),
-	DEFAULT_PINMUX(DAP2_DIN_PA4,  I2S1, DOWN, NORMAL, INPUT),
-	DEFAULT_PINMUX(DAP2_DOUT_PA5, I2S1, DOWN, NORMAL, INPUT),
-	DEFAULT_PINMUX(DAP2_SCLK_PA3, I2S1, DOWN, NORMAL, INPUT),
-
-	/* SPI pinmux */
-	DEFAULT_PINMUX(SPI2_MOSI_PX0,  SPI2, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(SPI2_MISO_PX1,  SPI2, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(SPI2_CS0_N_PX3, SPI2, NORMAL, NORMAL, OUTPUT),
-	DEFAULT_PINMUX(SPI2_SCK_PX2,   SPI2, NORMAL, NORMAL, OUTPUT),
-
-	DEFAULT_PINMUX(SPI2_CS1_N_PW2, SPI2,  UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(SPI2_CS2_N_PW3, SPI2,  UP, TRISTATE, INPUT),
-
-	DEFAULT_PINMUX(SPI1_MOSI_PX4,  SPI1, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(SPI1_SCK_PX5,   SPI2,     UP, NORMAL, INPUT),
-	DEFAULT_PINMUX(SPI1_CS0_N_PX6, SPI1, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(SPI1_MISO_PX7, RSVD4, NORMAL, NORMAL, OUTPUT),
-
-	/* PEX pinmux */
-	DEFAULT_PINMUX(PEX_L0_PRSNT_N_PDD0,  PCIE, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PEX_L0_RST_N_PDD1,    PCIE, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PEX_L0_CLKREQ_N_PDD2, PCIE, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PEX_WAKE_N_PDD3,      PCIE, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PEX_L1_PRSNT_N_PDD4,  PCIE, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PEX_L1_RST_N_PDD5,    PCIE, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PEX_L1_CLKREQ_N_PDD6, PCIE, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PEX_L2_PRSNT_N_PDD7,  PCIE, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PEX_L2_RST_N_PCC6,    PCIE, NORMAL, NORMAL, INPUT),
-	DEFAULT_PINMUX(PEX_L2_CLKREQ_N_PCC7, PCIE, NORMAL, NORMAL, INPUT),
-};
-
-#endif	/* _PINMUX_CONFIG_TRANSFORMER_H_ */
-- 
2.40.1

