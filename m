Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE96C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5503F8787A;
	Mon,  4 Dec 2023 09:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmmILYu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4599B878F9; Mon,  4 Dec 2023 09:21:17 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F8387561
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c9bd3ec4f6so50542411fa.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701678072; x=1702282872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQ9loQeuToSlcuDb1rN3i9onmCwHqnQNLLswXuKBC4o=;
 b=TmmILYu8qT9lIa7pjEWNqECcDOLhTrrmOeXbms4yBxOwXyJ+eVgW2KeB8vBghQRXir
 WUH/kE5UbgxC04KRfpyawIwhP4R5irAHknwlunGwGIBsxOYB898W6691KSTss1gN3SbA
 fHRpac4mNMUmF6ifdZETWwr3mtu3y7hkA4732JY9v1OmbU3ezhOiGKL8iyd8Mwce56KY
 G6U6SXjpLkdpxZqTzD4f/54sjCIAMfprp45CSSS2ZXwksYP/A4QzKHBUaJpYZHb73fER
 LclwB+1nd/rVMG5efVgHtmmgutbYVEqBPHjVzdJi+vgYmFraJxcbWOuIM22oTqJ3IoZo
 OELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678072; x=1702282872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQ9loQeuToSlcuDb1rN3i9onmCwHqnQNLLswXuKBC4o=;
 b=wiloKWoEUl0H9R2WfUi7t2A6xCp9wbLJf3pFAyYt680TujJPRz0VEkAPHyZgbapvKq
 DLLdALTK5hETP56h78szS8rpRkJ5vAboUi/zxTd/AhQbx5BUOPfCjMGXKjzaKDFjkauy
 gqR2Bg34svboZ8cxT0BOLXX0I82YvN2yXe8jyefqnaZmzXJSkafbN8ldQC3k9HRf0WBs
 LXFPhJTN+ZxssxrZVTy2UbJMXap18+R/yz6+c7EU/JZJNAyhaQqr6eWWYedceER3EMuZ
 6kmxcBqFZXzs6HoHiiudz5pHkBlTJyziFMqr6iTY/AI81CZqZV2/BnUUlsrhlmdVT/Ou
 0+pQ==
X-Gm-Message-State: AOJu0YxxcI/6BHaSUd9HUhhlVV4pd86PN7dg+xIIXvm2K7MsDhfEHcWB
 EYq4dD/olABq9eACRCxmxO4=
X-Google-Smtp-Source: AGHT+IGYyNaohQ08p4cxaEJAbx1mMRz/eXlOAAQVZI4KDdaIQx+FR6DsvRgZN8g2ZRVYZsG4k6b9tw==
X-Received: by 2002:ac2:520f:0:b0:50b:d764:28e9 with SMTP id
 a15-20020ac2520f000000b0050bd76428e9mr1371069lfl.129.1701678071843; 
 Mon, 04 Dec 2023 00:21:11 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 q16-20020a19a410000000b0050bfe62b073sm3655lfc.170.2023.12.04.00.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:21:11 -0800 (PST)
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
Subject: [PATCH v1 5/8] board: lg: x3-t30: switch to DM pinmux
Date: Mon,  4 Dec 2023 10:20:51 +0200
Message-Id: <20231204082054.4943-6-clamor95@gmail.com>
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

Drop the pinmux setup in the board in favor of setting it up in
the device tree. Device tree nodes match nodes used for the Linux
device tree and are set according to the service manual.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-lg-p880.dts    |  90 +++
 arch/arm/dts/tegra30-lg-p895.dts    |  93 +++
 arch/arm/dts/tegra30-lg-x3.dtsi     | 845 ++++++++++++++++++++++++++++
 board/lg/x3-t30/Kconfig             |  12 -
 board/lg/x3-t30/configs/p880.config |   1 -
 board/lg/x3-t30/configs/p895.config |   1 -
 board/lg/x3-t30/pinmux-config-x3.h  | 449 ---------------
 board/lg/x3-t30/x3-t30.c            |  23 -
 include/configs/x3-t30.h            |  13 +-
 9 files changed, 1029 insertions(+), 498 deletions(-)
 delete mode 100644 board/lg/x3-t30/pinmux-config-x3.h

diff --git a/arch/arm/dts/tegra30-lg-p880.dts b/arch/arm/dts/tegra30-lg-p880.dts
index 81d364310d..1d5ca1459b 100644
--- a/arch/arm/dts/tegra30-lg-p880.dts
+++ b/arch/arm/dts/tegra30-lg-p880.dts
@@ -11,6 +11,96 @@
 		mmc1 = &sdmmc3; /* uSD slot */
 	};
 
+	pinmux@70000868 {
+		state_default: pinmux {
+			/* WLAN SDIO pinmux */
+			host_wlan_wake {
+				nvidia,pins = "pu4";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GNSS UART-B pinmux */
+			uartb_rxd {
+				nvidia,pins = "uart2_rxd_pc3";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartb_txd {
+				nvidia,pins = "uart2_txd_pc2";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gps_reset {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* MicroSD pinmux */
+			sdmmc3_clk {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3_data {
+				nvidia,pins = "sdmmc3_cmd_pa7",
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat3_pb4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			microsd_detect {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO keys pinmux */
+			volume_up {
+				nvidia,pins = "ulpi_data6_po7";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			current_alert_irq {
+				nvidia,pins = "uart2_rts_n_pj6";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* AUDIO pinmux */
+			sub_mic_ldo {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
+
 	sdmmc3: sdhci@78000400  {
 		status = "okay";
 		bus-width = <4>;
diff --git a/arch/arm/dts/tegra30-lg-p895.dts b/arch/arm/dts/tegra30-lg-p895.dts
index 074205d5a9..43bb373a16 100644
--- a/arch/arm/dts/tegra30-lg-p895.dts
+++ b/arch/arm/dts/tegra30-lg-p895.dts
@@ -15,6 +15,99 @@
 		};
 	};
 
+	pinmux@70000868 {
+		state_default: pinmux {
+			/* GNSS UART-B pinmux */
+			uartb_cts_rxd {
+				nvidia,pins = "uart2_cts_n_pj5",
+						"uart2_rxd_pc3";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartb_rts_txd {
+				nvidia,pins = "uart2_rts_n_pj6",
+						"uart2_txd_pc2";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gps_reset {
+				nvidia,pins = "spdif_out_pk5";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* GPIO keys pinmux */
+			volume_up {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			memo_key {
+				nvidia,pins = "sdmmc3_dat1_pb6";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			current_alert_irq {
+				nvidia,pins = "spi1_cs0_n_px6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Panel pinmux */
+			panel_vdd {
+				nvidia,pins = "pbb0";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* AUDIO pinmux */
+			sub_mic_ldo {
+				nvidia,pins = "gmi_dqs_pi2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Modem pinmux */
+			usim_detect {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO power/drive control */
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
 	panel: panel {
 		compatible = "hitachi,tx13d100vm0eaa";
 
diff --git a/arch/arm/dts/tegra30-lg-x3.dtsi b/arch/arm/dts/tegra30-lg-x3.dtsi
index 01936b872e..30d6dcb654 100644
--- a/arch/arm/dts/tegra30-lg-x3.dtsi
+++ b/arch/arm/dts/tegra30-lg-x3.dtsi
@@ -37,6 +37,851 @@
 		};
 	};
 
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* WLAN SDIO pinmux */
+			sdmmc1_clk {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1_cmd {
+				nvidia,pins = "sdmmc1_cmd_pz1",
+						"sdmmc1_dat3_py4",
+						"sdmmc1_dat2_py5",
+						"sdmmc1_dat1_py6",
+						"sdmmc1_dat0_py7";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			wlan_reset {
+				nvidia,pins = "pv3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			wlan_host_wake {
+				nvidia,pins = "pu6";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GNSS UART-B pinmux */
+			gps_pwr_en {
+				nvidia,pins = "kb_row6_pr6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gps_ldo_en {
+				nvidia,pins = "ulpi_dir_py1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gps_clk_ref {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Bluetooth UART-C pinmux */
+			uartc_cts_rxd {
+				nvidia,pins = "uart3_cts_n_pa1",
+						"uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartc_rts_txd {
+				nvidia,pins = "uart3_rts_n_pc0",
+						"uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt_reset {
+				nvidia,pins = "clk2_req_pcc5";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt_dev_wake {
+				nvidia,pins = "kb_row11_ps3";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt_host_wake {
+				nvidia,pins = "kb_row12_ps4";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bt_pcm_dap4 {
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
+			/* EMMC pinmux */
+			sdmmc4_clk {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4_data {
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
+			sdmmc4_reset {
+				nvidia,pins = "sdmmc4_rst_n_pcc3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
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
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
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
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
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
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+
+			ddc_i2c {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
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
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+
+			mhl_i2c {
+				nvidia,pins = "kb_col6_pq6",
+						"kb_col7_pq7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO keys pinmux */
+			power_key {
+				nvidia,pins = "gmi_wp_n_pc7";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			volume_down {
+				nvidia,pins = "ulpi_data3_po4";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			sen_vdd {
+				nvidia,pins = "spi1_miso_px7";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			proxi_vdd {
+				nvidia,pins = "spi2_miso_px1";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			sen_vio {
+				nvidia,pins = "lcd_dc1_pd2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			nct_irq {
+				nvidia,pins = "gmi_iordy_pi5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bat_irq {
+				nvidia,pins = "kb_row8_ps0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			charger_irq {
+				nvidia,pins = "gmi_cs1_n_pj2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mpu_irq {
+				nvidia,pins = "gmi_ad12_ph4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			compass_irq {
+				nvidia,pins = "gmi_ad13_ph5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			light_irq {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* LED pinmux */
+			backlight_en {
+				nvidia,pins = "lcd_dc0_pn6";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			flash_led_en {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			keypad_led {
+				nvidia,pins = "kb_row2_pr2",
+						"kb_row3_pr3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* NFC pinmux */
+			nfc_irq {
+				nvidia,pins = "spi2_cs1_n_pw2";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			nfc_ven {
+				nvidia,pins = "spi1_sck_px5";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			nfc_firm {
+				nvidia,pins = "kb_row0_pr0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* DC pinmux */
+			lcd_pwr {
+				nvidia,pins = "lcd_pwr0_pb2",
+						"lcd_pwr1_pc1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd_wr_n {
+				nvidia,pins = "lcd_wr_n_pz3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_id {
+				nvidia,pins = "lcd_m1_pw1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd_pclk {
+				nvidia,pins = "lcd_pclk_pb3",
+						"lcd_de_pj1",
+						"lcd_hsync_pj3",
+						"lcd_vsync_pj4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			lcd_rgb_blue {
+				nvidia,pins = "lcd_d0_pe0",
+						"lcd_d1_pe1",
+						"lcd_d2_pe2",
+						"lcd_d3_pe3",
+						"lcd_d4_pe4",
+						"lcd_d5_pe5",
+						"lcd_d18_pm2",
+						"lcd_d19_pm3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_rgb_green {
+				nvidia,pins = "lcd_d6_pe6",
+						"lcd_d7_pe7",
+						"lcd_d8_pf0",
+						"lcd_d9_pf1",
+						"lcd_d10_pf2",
+						"lcd_d11_pf3",
+						"lcd_d20_pm4",
+						"lcd_d21_pm5";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_rgb_red {
+				nvidia,pins = "lcd_d12_pf4",
+						"lcd_d13_pf5",
+						"lcd_d14_pf6",
+						"lcd_d15_pf7",
+						"lcd_d16_pm0",
+						"lcd_d17_pm1",
+						"lcd_d22_pm6",
+						"lcd_d23_pm7";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Bridge pinmux */
+			bridge_reset {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			rgb_ic_en {
+				nvidia,pins = "gmi_a18_pb1";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bridge_clk {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			rgb_bridge {
+				nvidia,pins = "lcd_sdin_pz2",
+						"lcd_sdout_pn5",
+						"lcd_cs0_n_pn4",
+						"lcd_sck_pz4";
+				nvidia,function = "spi5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Panel pinmux */
+			panel_reset {
+				nvidia,pins = "lcd_cs1_n_pw0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			panel_vio {
+				nvidia,pins = "ulpi_clk_py0";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Touchscreen pinmux */
+			touch_vdd {
+				nvidia,pins = "kb_col1_pq1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			touch_vio {
+				nvidia,pins = "spi1_mosi_px4";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			touch_int_n {
+				nvidia,pins = "kb_col3_pq3";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			touch_rst_n {
+				nvidia,pins = "ulpi_data0_po1";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			touch_maker_id {
+				nvidia,pins = "kb_col2_pq2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* MHL pinmux */
+			mhl_vio {
+				nvidia,pins = "pv2";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mhl_rst_n {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			mhl_int {
+				nvidia,pins = "crt_vsync_pv7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mhl_sel {
+				nvidia,pins = "kb_row10_ps2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			hdmi_hpd {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* AUDIO pinmux */
+			hp_detect {
+				nvidia,pins = "pbb6";
+				nvidia,function = "vgp6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			hp_hook {
+				nvidia,pins = "ulpi_data4_po5";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ear_mic_en {
+				nvidia,pins = "spi2_mosi_px0";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			audio_irq {
+				nvidia,pins = "spi2_cs2_n_pw3";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			audio_mclk {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap_i2s0 {
+				nvidia,pins = "dap1_fs_pn0",
+						"dap1_din_pn1",
+						"dap1_dout_pn2",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
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
+
+			/* MUIC pinmux */
+			muic_irq {
+				nvidia,pins = "gmi_cs0_n_pj0";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			muic_dp2t {
+				nvidia,pins = "pcc2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			muic_usif {
+				nvidia,pins = "ulpi_stp_py3";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ifx_usb_vbus_en {
+				nvidia,pins = "kb_row4_pr4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pcb_rev {
+				nvidia,pins = "gmi_wait_pi7",
+						"gmi_rst_n_pi4";
+				nvidia,function = "gmi";
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
+			/* Camera pinmux */
+			cam_mclk {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam_pmic_en {
+				nvidia,pins = "pbb4";
+				nvidia,function = "vgp4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			front_cam_rst {
+				nvidia,pins = "pbb5";
+				nvidia,function = "vgp5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			front_cam_vio {
+				nvidia,pins = "ulpi_nxt_py2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			rear_cam_rst {
+				nvidia,pins = "gmi_cs3_n_pk4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			rear_cam_eprom_pr {
+				nvidia,pins = "gmi_cs2_n_pk3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			rear_cam_vcm_pwdn {
+				nvidia,pins = "kb_row1_pr1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Haptic pinmux */
+			haptic_en {
+				nvidia,pins = "gmi_ad9_ph1";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			haptic_osc {
+				nvidia,pins = "gmi_ad11_ph3";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Modem pinmux */
+			cp2ap_ack1_host_active {
+				nvidia,pins = "pu5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			cp2ap_ack2_host_wakeup {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ap2cp_ack2_suspend_req {
+				nvidia,pins = "kb_row14_ps6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ap2cp_ack1_slave_wakeup {
+				nvidia,pins = "kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			cp_kkp {
+				nvidia,pins = "kb_col0_pq0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cp_crash_irq {
+				nvidia,pins = "kb_row13_ps5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ap2cp_uarta_tx_ipc {
+				nvidia,pins = "pu0";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ap2cp_uarta_rx_ipc {
+				nvidia,pins = "pu1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			fota_ap_cts_cp_rts {
+				nvidia,pins = "pu2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			fota_ap_rts_cp_cts {
+				nvidia,pins = "pu3";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			modem_enable {
+				nvidia,pins = "ulpi_data7_po0";
+				nvidia,function = "hsi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			modem_reset {
+				nvidia,pins = "pv1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			dap_i2s2 {
+				nvidia,pins = "dap3_fs_pp0",
+						"dap3_din_pp1",
+						"dap3_dout_pp2",
+						"dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO power/drive control */
+			drive_i2c {
+				nvidia,pins = "drive_dbg",
+						"drive_at5",
+						"drive_gme",
+						"drive_ddc",
+						"drive_ao1";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+
+			drive_uart3 {
+				nvidia,pins = "drive_uart3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+
+			drive_gmi {
+				nvidia,pins = "drive_at3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+		};
+	};
+
 	uartd: serial@70006300 {
 		status = "okay";
 	};
diff --git a/board/lg/x3-t30/Kconfig b/board/lg/x3-t30/Kconfig
index 53d776019d..53b6ab3e93 100644
--- a/board/lg/x3-t30/Kconfig
+++ b/board/lg/x3-t30/Kconfig
@@ -9,16 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "x3-t30"
 
-config DEVICE_P880
-	bool "Enable support for LG Optimus 4X HD"
-	help
-	  LG Optimus 4X HD derives from x3 board but has slight
-	  differences.
-
-config DEVICE_P895
-	bool "Enable support for LG Optimus Vu"
-	help
-	  LG Optimus Vu derives from x3 board but has slight
-	  differences.
-
 endif
diff --git a/board/lg/x3-t30/configs/p880.config b/board/lg/x3-t30/configs/p880.config
index 1a47b5f769..57c2885779 100644
--- a/board/lg/x3-t30/configs/p880.config
+++ b/board/lg/x3-t30/configs/p880.config
@@ -1,4 +1,3 @@
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-lg-p880"
-CONFIG_DEVICE_P880=y
 CONFIG_SYS_PROMPT="Tegra30 (P880) # "
 CONFIG_VIDEO_LCD_RENESAS_R69328=y
diff --git a/board/lg/x3-t30/configs/p895.config b/board/lg/x3-t30/configs/p895.config
index 019a5662d6..2eba92594b 100644
--- a/board/lg/x3-t30/configs/p895.config
+++ b/board/lg/x3-t30/configs/p895.config
@@ -1,4 +1,3 @@
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-lg-p895"
-CONFIG_DEVICE_P895=y
 CONFIG_SYS_PROMPT="Tegra30 (P895) # "
 CONFIG_VIDEO_LCD_RENESAS_R61307=y
diff --git a/board/lg/x3-t30/pinmux-config-x3.h b/board/lg/x3-t30/pinmux-config-x3.h
deleted file mode 100644
index cdb28095f3..0000000000
--- a/board/lg/x3-t30/pinmux-config-x3.h
+++ /dev/null
@@ -1,449 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
- *
- * Copyright (c) 2021, Svyatoslav Ryhel.
- */
-
-#ifndef _PINMUX_CONFIG_X3_H_
-#define _PINMUX_CONFIG_X3_H_
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
-static struct pmux_pingrp_config tegra3_x3_pinmux_common[] = {
-	/* SDMMC1 pinmux */
-	DEFAULT_PINMUX(SDMMC1_CLK_PZ0,      SDMMC1,      NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_CMD_PZ1,      SDMMC1,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT3_PY4,     SDMMC1,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT2_PY5,     SDMMC1,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT1_PY6,     SDMMC1,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC1_DAT0_PY7,     SDMMC1,          UP,    NORMAL,   INPUT),
-
-	/* SDMMC3 pinmux */
-//	DEFAULT_PINMUX(SDMMC3_CLK_PA6,      SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(SDMMC3_CMD_PA7,      SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(SDMMC3_DAT0_PB7,     RSVD1,       NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(SDMMC3_DAT1_PB6,     RSVD1,       NORMAL,    NORMAL,   INPUT), // device specific
-//	DEFAULT_PINMUX(SDMMC3_DAT2_PB5,     RSVD1,       NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(SDMMC3_DAT3_PB4,     RSVD1,       NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(SDMMC3_DAT4_PD1,     SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(SDMMC3_DAT5_PD0,     SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(SDMMC3_DAT6_PD3,     SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(SDMMC3_DAT7_PD4,     RSVD2,       NORMAL,  TRISTATE,   INPUT), // device specific
-
-	/* SDMMC4 pinmux */
-	LV_PINMUX(SDMMC4_CLK_PCC4,          SDMMC4,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-//	LV_PINMUX(SDMMC4_CMD_PT7,           SDMMC4,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE), // device specific
-	LV_PINMUX(SDMMC4_DAT0_PAA0,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT1_PAA1,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT2_PAA2,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT3_PAA3,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT4_PAA4,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT5_PAA5,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT6_PAA6,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_DAT7_PAA7,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(SDMMC4_RST_N_PCC3,        RSVD2,         DOWN,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-
-	/* I2C1 pinmux */
-	I2C_PINMUX(GEN1_I2C_SCL_PC4,        I2C1,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-	I2C_PINMUX(GEN1_I2C_SDA_PC5,        I2C1,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-
-	/* I2C2 pinmux */
-	I2C_PINMUX(GEN2_I2C_SCL_PT5,        I2C2,            UP,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-	I2C_PINMUX(GEN2_I2C_SDA_PT6,        I2C2,            UP,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-
-	/* I2C3 pinmux */
-	I2C_PINMUX(CAM_I2C_SCL_PBB1,        I2C3,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-	I2C_PINMUX(CAM_I2C_SDA_PBB2,        I2C3,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-
-	/* I2C4 pinmux */
-	I2C_PINMUX(DDC_SCL_PV4,             I2C4,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-	I2C_PINMUX(DDC_SDA_PV5,             I2C4,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-
-	/* Power I2C pinmux */
-	I2C_PINMUX(PWR_I2C_SCL_PZ6,         I2CPWR,      NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-	I2C_PINMUX(PWR_I2C_SDA_PZ7,         I2CPWR,      NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
-
-	/* HDMI-CEC pinmux */
-	DEFAULT_PINMUX(HDMI_CEC_PEE3,       CEC,         NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(HDMI_INT_PN7,        RSVD1,       NORMAL,  TRISTATE,   INPUT),
-
-	/* ULPI pinmux */
-	DEFAULT_PINMUX(ULPI_DATA0_PO1,      SPI3,            UP,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(ULPI_DATA1_PO2,      SPI3,            UP,    NORMAL,  OUTPUT), // LCD_BRIDGE_RESET_N
-	DEFAULT_PINMUX(ULPI_DATA2_PO3,      SPI3,            UP,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(ULPI_DATA3_PO4,      SPI3,            UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(ULPI_DATA4_PO5,      ULPI,            UP,    NORMAL,   INPUT),
-//	DEFAULT_PINMUX(ULPI_DATA5_PO6,      SPI2,            UP,  TRISTATE,   INPUT), // unconfigured
-//	DEFAULT_PINMUX(ULPI_DATA6_PO7,      SPI2,            UP,    NORMAL,   INPUT), // device specific
-//	DEFAULT_PINMUX(ULPI_DATA7_PO0,      SPI2,            UP,    NORMAL,   INPUT), // unconfigured
-	DEFAULT_PINMUX(ULPI_CLK_PY0,        RSVD2,         DOWN,    NORMAL,  OUTPUT), // LCD_EN
-	DEFAULT_PINMUX(ULPI_DIR_PY1,        RSVD2,           UP,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(ULPI_NXT_PY2,        RSVD2,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(ULPI_STP_PY3,        SPI1,        NORMAL,    NORMAL,  OUTPUT),
-
-	/* DAP3 pinmux */
-	DEFAULT_PINMUX(DAP3_FS_PP0,         I2S2,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP3_DIN_PP1,        I2S2,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP3_DOUT_PP2,       I2S2,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP3_SCLK_PP3,       I2S2,        NORMAL,    NORMAL,   INPUT),
-
-	DEFAULT_PINMUX(PV0,                 RSVD1,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PV1,                 RSVD1,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PV2,                 OWR,         NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PV3,                 RSVD2,         DOWN,    NORMAL,   INPUT),
-
-	/* CLK2 pinmux */
-	DEFAULT_PINMUX(CLK2_OUT_PW5,        RSVD2,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(CLK2_REQ_PCC5,       DAP,         NORMAL,    NORMAL,  OUTPUT),
-
-	/* LCD pinmux */
-	DEFAULT_PINMUX(LCD_PWR1_PC1,        DISPLAYA,    NORMAL,    NORMAL,  OUTPUT),
-//	DEFAULT_PINMUX(LCD_PWR2_PC6,        DISPLAYA,      DOWN,  TRISTATE,  OUTPUT), // unconfigured
-	DEFAULT_PINMUX(LCD_SDIN_PZ2,        SPI5,        NORMAL,    NORMAL,   INPUT), // LCD_RGB_SDI
-	DEFAULT_PINMUX(LCD_SDOUT_PN5,       SPI5,        NORMAL,    NORMAL,   INPUT), // LCD_RGB_SDO
-	DEFAULT_PINMUX(LCD_WR_N_PZ3,        DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_CS0_N_PN4,       SPI5,        NORMAL,    NORMAL,   INPUT), // LCD_RGB_CS
-	DEFAULT_PINMUX(LCD_DC0_PN6,         RSVD3,       NORMAL,    NORMAL,  OUTPUT), // LCD_CP_EN / BL
-	DEFAULT_PINMUX(LCD_SCK_PZ4,         SPI5,        NORMAL,    NORMAL,   INPUT), // LCD_RGB_SCL
-	DEFAULT_PINMUX(LCD_PWR0_PB2,        DISPLAYA,    NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(LCD_PCLK_PB3,        DISPLAYA,    NORMAL,    NORMAL,   INPUT), // LCD_RGB_PCLK
-	DEFAULT_PINMUX(LCD_DE_PJ1,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_HSYNC_PJ3,       DISPLAYA,    NORMAL,    NORMAL,   INPUT), // LCD_RGB_HSYNC
-	DEFAULT_PINMUX(LCD_VSYNC_PJ4,       DISPLAYA,    NORMAL,    NORMAL,   INPUT), // LCD_RGB_VSYNC
-	DEFAULT_PINMUX(LCD_D0_PE0,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D1_PE1,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D2_PE2,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D3_PE3,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D4_PE4,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D5_PE5,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D6_PE6,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D7_PE7,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D8_PF0,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D9_PF1,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D10_PF2,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D11_PF3,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D12_PF4,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D13_PF5,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D14_PF6,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D15_PF7,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D16_PM0,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D17_PM1,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D18_PM2,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D19_PM3,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D20_PM4,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D21_PM5,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D22_PM6,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_D23_PM7,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(LCD_CS1_N_PW0,       RSVD4,           UP,    NORMAL,  OUTPUT), // LCD_RESET_N
-	DEFAULT_PINMUX(LCD_M1_PW1,          DISPLAYA,    NORMAL,  TRISTATE,  OUTPUT), // LCD_MAKER_ID
-	DEFAULT_PINMUX(LCD_DC1_PD2,         RSVD3,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(CRT_HSYNC_PV6,       RSVD2,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(CRT_VSYNC_PV7,       RSVD2,       NORMAL,    NORMAL,   INPUT),
-
-	/* VI-group pinmux */
-	LV_PINMUX(VI_D0_PT4,                RSVD2,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D1_PD5,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D2_PL0,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D3_PL1,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D4_PL2,                VI,          NORMAL,    NORMAL,  OUTPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D5_PL3,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D6_PL4,                VI,          NORMAL,    NORMAL,  OUTPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D7_PL5,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D8_PL6,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D9_PL7,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D10_PT2,               RSVD2,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_D11_PT3,               RSVD2,           UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_PCLK_PT0,              RSVD1,           UP,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_MCLK_PT1,              VI,              UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_HSYNC_PD7,             RSVD2,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-	LV_PINMUX(VI_VSYNC_PD6,             RSVD2,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-
-	/* UART-B pinmux */
-//	DEFAULT_PINMUX(UART2_RXD_PC3,       UARTB,       NORMAL,    NORMAL,   INPUT), // device specific
-//	DEFAULT_PINMUX(UART2_TXD_PC2,       UARTB,       NORMAL,    NORMAL,  OUTPUT), // device specific
-	DEFAULT_PINMUX(UART2_RTS_N_PJ6,     UARTB,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(UART2_CTS_N_PJ5,     UARTB,       NORMAL,    NORMAL,   INPUT),
-
-	/* UART-C pinmux */
-	DEFAULT_PINMUX(UART3_TXD_PW6,       UARTC,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(UART3_RXD_PW7,       UARTC,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(UART3_CTS_N_PA1,     UARTC,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(UART3_RTS_N_PC0,     UARTC,       NORMAL,    NORMAL,  OUTPUT),
-
-	/* PU-gpio group pinmux */
-//	DEFAULT_PINMUX(PU0,                 UARTA,       NORMAL,    NORMAL,  OUTPUT), // device specific
-//	DEFAULT_PINMUX(PU1,                 UARTA,       NORMAL,    NORMAL,   INPUT), // device specific
-//	DEFAULT_PINMUX(PU2,                 RSVD1,       NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(PU3,                 PWM0,        NORMAL,  TRISTATE,   INPUT), // device specific
-//	DEFAULT_PINMUX(PU4,                 PWM1,        NORMAL,  TRISTATE,   INPUT), // device specific
-	DEFAULT_PINMUX(PU5,                 RSVD4,         DOWN,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PU6,                 PWM3,          DOWN,    NORMAL,   INPUT),
-
-	/* DAP4 pinmux */
-	DEFAULT_PINMUX(DAP4_FS_PP4,         I2S3,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP4_DIN_PP5,        I2S3,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP4_DOUT_PP6,       I2S3,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP4_SCLK_PP7,       I2S3,        NORMAL,    NORMAL,   INPUT),
-
-	/* CLK3 pinmux */
-	DEFAULT_PINMUX(CLK3_OUT_PEE0,       EXTPERIPH3,  NORMAL,    NORMAL,  OUTPUT), // MIPI_BRIDGE_CLK
-	DEFAULT_PINMUX(CLK3_REQ_PEE1,       DEV3,        NORMAL,    NORMAL,   INPUT),
-
-	DEFAULT_PINMUX(CAM_MCLK_PCC0,       VI_ALT2,         UP,    NORMAL,   INPUT),
-
-	DEFAULT_PINMUX(PCC1,                RSVD3,       NORMAL,    NORMAL,  OUTPUT),
-//	DEFAULT_PINMUX(PBB0,                RSVD2,       NORMAL,    NORMAL,  OUTPUT), // device specific
-	DEFAULT_PINMUX(PBB3,                VGP3,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PBB4,                VGP4,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PBB5,                VGP5,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PBB6,                VGP6,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PBB7,                I2S4,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PCC2,                RSVD3,       NORMAL,    NORMAL,  OUTPUT),
-
-	DEFAULT_PINMUX(JTAG_RTCK_PU7,       RTCK,        NORMAL,    NORMAL,  OUTPUT),
-
-	/* KBC keys */
-	DEFAULT_PINMUX(KB_ROW0_PR0,         RSVD4,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(KB_ROW1_PR1,         KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW2_PR2,         RSVD4,         DOWN,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(KB_ROW3_PR3,         RSVD3,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(KB_ROW4_PR4,         RSVD4,         DOWN,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(KB_ROW5_PR5,         KBC,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW6_PR6,         KBC,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW7_PR7,         KBC,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW8_PS0,         KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW9_PS1,         KBC,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW10_PS2,        KBC,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW11_PS3,        KBC,           DOWN,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(KB_ROW12_PS4,        KBC,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW13_PS5,        KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW14_PS6,        KBC,         NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_ROW15_PS7,        KBC,           DOWN,    NORMAL,   INPUT),
-
-	DEFAULT_PINMUX(KB_COL0_PQ0,         KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_COL1_PQ1,         KBC,         NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(KB_COL2_PQ2,         KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_COL3_PQ3,         KBC,         NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_COL4_PQ4,         KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_COL5_PQ5,         KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_COL6_PQ6,         KBC,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(KB_COL7_PQ7,         KBC,             UP,    NORMAL,   INPUT),
-
-	/* CLK */
-	DEFAULT_PINMUX(CLK_32K_OUT_PA0,     BLINK,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SYS_CLK_REQ_PZ5,     SYSCLK,      NORMAL,    NORMAL,   INPUT),
-//	DEFAULT_PINMUX(CORE_PWR_REQ,        RSVD1,       NORMAL,    NORMAL,   INPUT), // unconfigured
-//	DEFAULT_PINMUX(CPU_PWR_REQ,         RSVD1,       NORMAL,    NORMAL,   INPUT), // unconfigured
-//	DEFAULT_PINMUX(PWR_INT_N,           RSVD1,       NORMAL,    NORMAL,   INPUT), // unconfigured
-//	DEFAULT_PINMUX(CLK_32K_IN,          RSVD1,       NORMAL,    NORMAL,   INPUT), // unconfigured
-	DEFAULT_PINMUX(OWR,                 OWR,         NORMAL,    NORMAL,   INPUT),
-
-	/* DAP1 pinmux */
-	DEFAULT_PINMUX(DAP1_FS_PN0,         I2S0,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP1_DIN_PN1,        I2S0,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP1_DOUT_PN2,       I2S0,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP1_SCLK_PN3,       I2S0,        NORMAL,    NORMAL,   INPUT),
-
-	/* CLK1 pinmux */
-	DEFAULT_PINMUX(CLK1_REQ_PEE2,       DAP,         NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(CLK1_OUT_PW4,        EXTPERIPH1,    DOWN,    NORMAL,   INPUT),
-
-	/* SPDIF pinmux */
-	DEFAULT_PINMUX(SPDIF_IN_PK6,        SPDIF,       NORMAL,    NORMAL,  OUTPUT),
-//	DEFAULT_PINMUX(SPDIF_OUT_PK5,       SPDIF,         DOWN,    NORMAL,  OUTPUT), // device specific
-
-	/* DAP2 pinmux */
-	DEFAULT_PINMUX(DAP2_FS_PA2,         HDA,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP2_DIN_PA4,        HDA,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP2_DOUT_PA5,       HDA,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(DAP2_SCLK_PA3,       HDA,           DOWN,    NORMAL,   INPUT),
-
-	/* SPI pinmux */
-	DEFAULT_PINMUX(SPI1_MOSI_PX4,       SPI2,        NORMAL,    NORMAL,  OUTPUT),
-//	DEFAULT_PINMUX(SPI1_SCK_PX5,        SPI1,        NORMAL,    NORMAL,  OUTPUT), // device specific
-//	DEFAULT_PINMUX(SPI1_CS0_N_PX6,      GMI,         NORMAL,    NORMAL,   INPUT), // device specific
-	DEFAULT_PINMUX(SPI1_MISO_PX7,       RSVD4,       NORMAL,    NORMAL,  OUTPUT),
-
-	DEFAULT_PINMUX(SPI2_MOSI_PX0,       SPI2,          DOWN,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(SPI2_MISO_PX1,       GMI,         NORMAL,    NORMAL,  OUTPUT),
-//	DEFAULT_PINMUX(SPI2_CS0_N_PX3,      SPI6,            UP,    NORMAL,   INPUT), // unconfigured
-//	DEFAULT_PINMUX(SPI2_SCK_PX2,        SPI6,            UP,    NORMAL,   INPUT), // unconfigured
-	DEFAULT_PINMUX(SPI2_CS1_N_PW2,      SPI2,        NORMAL,    NORMAL,   INPUT),
-//	DEFAULT_PINMUX(SPI2_CS2_N_PW3,      SPI2,            UP,  TRISTATE,   INPUT), // unconfigured
-
-	/* PEX pinmux */
-	DEFAULT_PINMUX(PEX_L0_PRSNT_N_PDD0,  PCIE,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PEX_L0_RST_N_PDD1,    PCIE,        NORMAL,  TRISTATE,  OUTPUT),
-	DEFAULT_PINMUX(PEX_L0_CLKREQ_N_PDD2, PCIE,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PEX_WAKE_N_PDD3,      PCIE,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PEX_L1_PRSNT_N_PDD4,  PCIE,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PEX_L1_RST_N_PDD5,    PCIE,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PEX_L1_CLKREQ_N_PDD6, PCIE,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PEX_L2_PRSNT_N_PDD7,  PCIE,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PEX_L2_RST_N_PCC6,    PCIE,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PEX_L2_CLKREQ_N_PCC7, PCIE,        NORMAL,  TRISTATE,   INPUT),
-
-	/* GMI pinmux */
-	DEFAULT_PINMUX(GMI_WP_N_PC7,         GMI,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_IORDY_PI5,        RSVD1,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_WAIT_PI7,         GMI,             UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_ADV_N_PK0,        GMI,         NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_CLK_PK1,          GMI,         NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_CS0_N_PJ0,        GMI,             UP,  TRISTATE,   INPUT), // LCD_RGB_DE
-	DEFAULT_PINMUX(GMI_CS1_N_PJ2,        RSVD1,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_CS2_N_PK3,        RSVD1,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_CS3_N_PK4,        RSVD1,       NORMAL,    NORMAL,  OUTPUT),
-//	DEFAULT_PINMUX(GMI_CS4_N_PK2,        RSVD4,           UP,    NORMAL,   INPUT), // device specific
-	DEFAULT_PINMUX(GMI_CS6_N_PI3,        GMI,             UP,    NORMAL,   INPUT),
-//	DEFAULT_PINMUX(GMI_CS7_N_PI6,        GMI,             UP,    NORMAL,   INPUT), // device specific
-	DEFAULT_PINMUX(GMI_AD0_PG0,          GMI,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_AD1_PG1,          GMI,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_AD2_PG2,          GMI,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_AD3_PG3,          GMI,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_AD4_PG4,          GMI,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_AD5_PG5,          GMI,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_AD6_PG6,          GMI,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_AD7_PG7,          GMI,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_AD8_PH0,          GMI,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_AD9_PH1,          GMI,           DOWN,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_AD10_PH2,         GMI,         NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD11_PH3,         PWM3,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD12_PH4,         RSVD4,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_AD13_PH5,         RSVD4,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_AD14_PH6,         GMI,         NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_AD15_PH7,         GMI,         NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_A16_PJ7,          UARTD,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_A17_PB0,          UARTD,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_A18_PB1,          UARTD,         DOWN,    NORMAL,  OUTPUT), // RGB_IC_EN
-	DEFAULT_PINMUX(GMI_A19_PK7,          UARTD,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_WR_N_PI0,         GMI,         NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_OE_N_PI1,         RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(GMI_DQS_PI2,          GMI,         NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(GMI_RST_N_PI4,        GMI,             UP,    NORMAL,   INPUT),
-};
-
-#ifdef CONFIG_DEVICE_P880
-static struct pmux_pingrp_config tegra3_p880_pinmux[] = {
-	/* SDMMC3 pinmux */
-	DEFAULT_PINMUX(SDMMC3_CLK_PA6,      SDMMC3,      NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_CMD_PA7,      SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT0_PB7,     SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT1_PB6,     SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT2_PB5,     SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT3_PB4,     SDMMC3,          UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT4_PD1,     SDMMC3,          UP,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT5_PD0,     SDMMC3,          UP,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT6_PD3,     SDMMC3,          UP,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT7_PD4,     SDMMC3,          UP,  TRISTATE,   INPUT),
-
-	/* SDMMC4 pinmux */
-	LV_PINMUX(SDMMC4_CMD_PT7,           SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-
-	/* ULPI pinmux */
-	DEFAULT_PINMUX(ULPI_DATA6_PO7,      SPI2,        NORMAL,    NORMAL,   INPUT),
-
-	/* UART-B pinmux */
-	DEFAULT_PINMUX(UART2_RXD_PC3,       UARTB,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(UART2_TXD_PC2,       UARTB,           UP,    NORMAL,  OUTPUT),
-
-	/* GPIO group pinmux */
-	DEFAULT_PINMUX(PU0,                 UARTA,           UP,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PU1,                 UARTA,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PU2,                 UARTA,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PU3,                 UARTA,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PU4,                 PWM1,        NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PBB0,                I2S4,        NORMAL,  TRISTATE,   INPUT),
-
-	/* SPDIF pinmux  */
-	DEFAULT_PINMUX(SPDIF_OUT_PK5,       SPDIF,           UP,  TRISTATE,  OUTPUT),
-
-	/* SPI pinmux */
-	DEFAULT_PINMUX(SPI1_SCK_PX5,        SPI2,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(SPI1_CS0_N_PX6,      SPI1,        NORMAL,    NORMAL,   INPUT),
-
-	/* GMI pinmux */
-	DEFAULT_PINMUX(GMI_CS4_N_PK2,       RSVD1,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_CS7_N_PI6,       GMI,           DOWN,    NORMAL,  OUTPUT),
-};
-#endif  /* CONFIG_DEVICE_P880 */
-
-#ifdef CONFIG_DEVICE_P895
-static struct pmux_pingrp_config tegra3_p895_pinmux[] = {
-	/* SDMMC3 pinmux */
-	DEFAULT_PINMUX(SDMMC3_CLK_PA6,      SDMMC3,      NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_CMD_PA7,      SDMMC3,      NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT0_PB7,     RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT1_PB6,     RSVD1,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT2_PB5,     RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT3_PB4,     RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT4_PD1,     SDMMC3,      NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT5_PD0,     SDMMC3,      NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT6_PD3,     SDMMC3,      NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(SDMMC3_DAT7_PD4,     RSVD2,       NORMAL,  TRISTATE,   INPUT),
-
-	/* SDMMC4 pinmux */
-	LV_PINMUX(SDMMC4_CMD_PT7,           SDMMC4,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
-
-	/* ULPI pinmux */
-	DEFAULT_PINMUX(ULPI_DATA6_PO7,      SPI2,            UP,    NORMAL,   INPUT),
-
-	/* UART-B pinmux */
-	DEFAULT_PINMUX(UART2_RXD_PC3,       UARTB,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(UART2_TXD_PC2,       UARTB,       NORMAL,    NORMAL,  OUTPUT),
-
-	/* Gpio group pinmux */
-	DEFAULT_PINMUX(PU0,                 UARTA,       NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(PU1,                 UARTA,       NORMAL,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(PU2,                 RSVD1,       NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PU3,                 PWM0,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PU4,                 PWM1,        NORMAL,  TRISTATE,   INPUT),
-	DEFAULT_PINMUX(PBB0,                RSVD2,       NORMAL,    NORMAL,  OUTPUT), // LCD_EN_3V0
-
-	/* SPDIF pinmux */
-	DEFAULT_PINMUX(SPDIF_OUT_PK5,       SPDIF,         DOWN,    NORMAL,  OUTPUT),
-
-	/* SPI pinmux */
-	DEFAULT_PINMUX(SPI1_SCK_PX5,        SPI1,        NORMAL,    NORMAL,  OUTPUT),
-	DEFAULT_PINMUX(SPI1_CS0_N_PX6,      GMI,         NORMAL,    NORMAL,   INPUT),
-
-	/* GMI pinmux */
-	DEFAULT_PINMUX(GMI_CS4_N_PK2,       RSVD4,           UP,    NORMAL,   INPUT),
-	DEFAULT_PINMUX(GMI_CS7_N_PI6,       GMI,             UP,    NORMAL,   INPUT),
-};
-#endif  /* CONFIG_DEVICE_P895 */
-#endif	/* _PINMUX_CONFIG_X3_H_ */
diff --git a/board/lg/x3-t30/x3-t30.c b/board/lg/x3-t30/x3-t30.c
index 6b9169be6a..b781a16e70 100644
--- a/board/lg/x3-t30/x3-t30.c
+++ b/board/lg/x3-t30/x3-t30.c
@@ -9,32 +9,9 @@
 
 #include <dm.h>
 #include <fdt_support.h>
-#include <asm/arch/pinmux.h>
 #include <asm/arch/clock.h>
 #include <asm/arch-tegra/fuse.h>
 
-#include "pinmux-config-x3.h"
-
-/*
- * Routine: pinmux_init
- * Description: Do individual peripheral pinmux configs
- */
-void pinmux_init(void)
-{
-	pinmux_config_pingrp_table(tegra3_x3_pinmux_common,
-		ARRAY_SIZE(tegra3_x3_pinmux_common));
-
-#ifdef CONFIG_DEVICE_P880
-	pinmux_config_pingrp_table(tegra3_p880_pinmux,
-		ARRAY_SIZE(tegra3_p880_pinmux));
-#endif
-
-#ifdef CONFIG_DEVICE_P895
-	pinmux_config_pingrp_table(tegra3_p895_pinmux,
-		ARRAY_SIZE(tegra3_p895_pinmux));
-#endif
-}
-
 int nvidia_board_init(void)
 {
 	/* Set up panel bridge clocks */
diff --git a/include/configs/x3-t30.h b/include/configs/x3-t30.h
index d29ea700b2..14532542ea 100644
--- a/include/configs/x3-t30.h
+++ b/include/configs/x3-t30.h
@@ -14,19 +14,8 @@
 
 #include "tegra30-common.h"
 
-#define CFG_TEGRA_BOARD_STRING		"LG X3 Board"
-
-#ifdef CONFIG_DEVICE_P880
 /* High-level configuration options */
-#undef CFG_TEGRA_BOARD_STRING
-#define CFG_TEGRA_BOARD_STRING		"LG Optimus 4X HD"
-#endif
-
-#ifdef CONFIG_DEVICE_P895
-/* High-level configuration options */
-#undef CFG_TEGRA_BOARD_STRING
-#define CFG_TEGRA_BOARD_STRING		"LG Optimus Vu"
-#endif
+#define CFG_TEGRA_BOARD_STRING		"LG X3 Board"
 
 #define X3_FLASH_UBOOT \
 	"flash_uboot=echo Preparing RAM;" \
-- 
2.40.1

