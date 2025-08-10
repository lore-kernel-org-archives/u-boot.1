Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3B4C87FCA
	for <u-boot@archiver.kernel.org>; Sun, 10 Aug 2025 12:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F5E82E34;
	Sun, 10 Aug 2025 14:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mPnIjEUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D0F83281; Sun, 10 Aug 2025 14:22:05 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2671182DA1
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 14:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-61571192c3aso4130406a12.2
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754828521; x=1755433321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2U9CQqnmrkMp3YhYVVpn4uO0HptsQINbIuNA461JNE=;
 b=mPnIjEULph/7gfH/g6H0Svhbp7bBpYhMSGBuYr5H5plAOgSapRwXCmtgtCiDT9vPKb
 zqCWEa1Jn+H2b08Fb0oJBlY40raWj68to17X+2sSV7qhxEtbey9uksluv/PDvRjWA5nx
 V8UtJBSkOC5m8DQ9ZeHurJiyMahfRJ77u9Eq/8/lZLyE1/nzr8hBkkVmWiYZ++d+KClo
 28qAKWOQr3MCWBFYMl97chBMgoNyI+FrveU4JmgDfxj/si3Efs4SImphyG0RFzVHUEV8
 7wYBk9gtNtIKsVvMpuWNDYMl3C3dg+OYakrzCHgTCxfa2lLwkarWt1HnqK7dlKpDaQWj
 SAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754828521; x=1755433321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2U9CQqnmrkMp3YhYVVpn4uO0HptsQINbIuNA461JNE=;
 b=nK4r7KiEY0aun6Sqpa3ZLhjAgfL4ePWWPNvEVa8SmIPyNI8WIuW2Wzol9b8Buys+Le
 WM9+SJzAd0MhbE2EOABB3RJD9IHegBSCfpzl8c6U8NXBNXFsgIOJoKTO/pa7FMxQpO1B
 Hsi0modvtxkPTDUvQlEdBlZBNR6VjECH+d2sqJqbMKKMaj6cDO3zjPmojCqcTXSac669
 FLv1l8wnFY8wfW4DcRUg3zK+ji+bgXGSewL/+5t4tNdKy7fWzIi3YMrHfQuFzMAMfDot
 pYETc03ncTxPQizd9Qsm2aELsYEZW0YnSlqaA7UC6btc/FDeEamIoawEj8mu7o/TmfE4
 AVyg==
X-Gm-Message-State: AOJu0YxYHHjtdojVssVz4F0aLrqBcEbzK/Dsiepzsr4MBRfSMVy2DwOq
 UAiM2TxBD5e3rBNTw0Oul/pQbRpSYOQYiQhK9caIYvk4lmVnMXndBgV1
X-Gm-Gg: ASbGncvvlr5HevzWD3urnNYNj5u4xyhorvePC2+qQVYXuY0ZGor7O5npJP0qvLVWJpW
 Rfu6+nshuRbZ1AA4KsmgZIKr8lVswRAhxYVb4emIhbnHa3Pw4dxJMVTezSCM4raUVmPQiusyEjj
 4gBXp/6gFJOTrwCdJQXQjtDSlfcLfsC5JgFwtKGFfnejhDKXE4Zz0yGNhV0ByyrGLhoQ/S2GB1c
 ZYyJ8SWUhYHd9Y/AxcSqRU9gHMvTRJR19YfrJNUffq9NPVb5P0sLrYq7mSMoyZQ1Qyd7CA+kvcM
 oDzEws0FZC/Lp3OeFuc+eBpQZo4yB5cUr4iVM6FwjsUoOGDLE/qvEP0OzVuXgQhKqU6XtR9eCRj
 LrQXlDpqB8Z+RvQ==
X-Google-Smtp-Source: AGHT+IGjJy4X/5+fvB3UW5dLC6oG2IFZLL8G3YhGjHVD8uNiGfHCSO70aP4foPgjCXqtg+Pe8exRPQ==
X-Received: by 2002:a05:6402:2690:b0:617:ed82:33ac with SMTP id
 4fb4d7f45d1cf-617ed8234e0mr7637358a12.26.1754828521118; 
 Sun, 10 Aug 2025 05:22:01 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8fe7a32sm16699647a12.37.2025.08.10.05.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 05:22:00 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] board: microsoft: add Microsoft Surface 2 support
Date: Sun, 10 Aug 2025 15:21:33 +0300
Message-ID: <20250810122133.55729-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810122133.55729-1-clamor95@gmail.com>
References: <20250810122133.55729-1-clamor95@gmail.com>
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Surface 2 is a Surface-series Windows RT hybrid tablet computer created by
Microsoft. Surface 2 uses a 1.7 GHz quad-core Nvidia Tegra 4 chipset with
2 GB of RAM, features 10.6 inch FullHD ClearType HD screen with 16:9 aspect
ratio and 32/64 GB of internal memory that can be supplemented with a
microSDXC card giving up to 64 GB of additional storage.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                         |   2 +
 .../dts/tegra114-microsoft-surface-2-0b.dts   |  10 +
 .../dts/tegra114-microsoft-surface-2-13.dts   |  10 +
 .../tegra114-microsoft-surface-2-common.dtsi  | 905 ++++++++++++++++++
 arch/arm/mach-tegra/tegra114/Kconfig          |   5 +
 board/microsoft/surface-2/Kconfig             |  13 +
 board/microsoft/surface-2/MAINTAINERS         |   7 +
 board/microsoft/surface-2/Makefile            |   6 +
 board/microsoft/surface-2/board-info.c        |  71 ++
 board/microsoft/surface-2/surface-2-spl.c     |  42 +
 board/microsoft/surface-2/surface-2.env       |   8 +
 configs/surface-2_defconfig                   |  82 ++
 doc/board/microsoft/index.rst                 |   1 +
 doc/board/microsoft/surface-2.rst             |  41 +
 14 files changed, 1203 insertions(+)
 create mode 100644 arch/arm/dts/tegra114-microsoft-surface-2-0b.dts
 create mode 100644 arch/arm/dts/tegra114-microsoft-surface-2-13.dts
 create mode 100644 arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
 create mode 100644 board/microsoft/surface-2/Kconfig
 create mode 100644 board/microsoft/surface-2/MAINTAINERS
 create mode 100644 board/microsoft/surface-2/Makefile
 create mode 100644 board/microsoft/surface-2/board-info.c
 create mode 100644 board/microsoft/surface-2/surface-2-spl.c
 create mode 100644 board/microsoft/surface-2/surface-2.env
 create mode 100644 configs/surface-2_defconfig
 create mode 100644 doc/board/microsoft/surface-2.rst

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e212ed40b78..563bff94906 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -124,6 +124,8 @@ dtb-$(CONFIG_ARCH_TEGRA) += \
 	tegra30-wexler-qc750.dtb \
 	tegra114-asus-tf701t.dtb \
 	tegra114-dalmore.dtb \
+	tegra114-microsoft-surface-2-0b.dtb \
+	tegra114-microsoft-surface-2-13.dtb \
 	tegra114-nvidia-tegratab.dtb \
 	tegra124-apalis.dtb \
 	tegra124-jetson-tk1.dtb \
diff --git a/arch/arm/dts/tegra114-microsoft-surface-2-0b.dts b/arch/arm/dts/tegra114-microsoft-surface-2-0b.dts
new file mode 100644
index 00000000000..2007aae8737
--- /dev/null
+++ b/arch/arm/dts/tegra114-microsoft-surface-2-0b.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra114-microsoft-surface-2-common.dtsi"
+
+/ {
+	backlight: backlight {
+		enable-gpios = <&gpio TEGRA_GPIO(CC, 2) GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/dts/tegra114-microsoft-surface-2-13.dts b/arch/arm/dts/tegra114-microsoft-surface-2-13.dts
new file mode 100644
index 00000000000..da121d5a101
--- /dev/null
+++ b/arch/arm/dts/tegra114-microsoft-surface-2-13.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra114-microsoft-surface-2-common.dtsi"
+
+/ {
+	backlight: backlight {
+		enable-gpios = <&gpio TEGRA_GPIO(EE, 3) GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi b/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
new file mode 100644
index 00000000000..f8f71262538
--- /dev/null
+++ b/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
@@ -0,0 +1,905 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/input/input.h>
+#include "tegra114.dtsi"
+
+/ {
+	model = "Microsoft Surface 2";
+	compatible = "microsoft,surface-2", "nvidia,tegra114";
+
+	chosen {
+		stdout-path = &uarta;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc3; /* uSD slot */
+
+		usb0 = &usb1;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	host1x@50000000 {
+		dsia: dsi@54300000 {
+			status = "okay";
+
+			avdd-dsi-csi-supply = <&avdd_dsi_csi>;
+
+			panel@0 {
+				compatible = "samsung,ltl106hl02-001";
+				reg = <0>;
+
+				vdd-supply = <&tps65090_fet4>;
+
+				backlight = <&backlight>;
+			};
+		};
+	};
+
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* ULPI pinmux */
+			ulpi-data0 {
+				nvidia,pins = "ulpi_data0_po1",
+						"ulpi_data3_po4",
+						"ulpi_data4_po5";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ulpi-data1 {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-data2 {
+				nvidia,pins = "ulpi_data2_po3";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ulpi-data7 {
+				nvidia,pins = "ulpi_data7_po0",
+						"ulpi_data5_po6",
+						"ulpi_data6_po7";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* I2S pinmux */
+			dap1-din {
+				nvidia,pins = "dap1_fs_pn0",
+						"dap1_din_pn1",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap1-dout {
+				nvidia,pins = "dap1_dout_pn2";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap2-i2s1 {
+				nvidia,pins = "dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap3-i2s2 {
+				nvidia,pins = "dap3_fs_pp0",
+						"dap3_din_pp1",
+						"dap3_dout_pp2",
+						"dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap4-din {
+				nvidia,pins = "dap4_fs_pp4",
+						"dap4_din_pp5",
+						"dap4_sclk_pp7";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap4-dout {
+				nvidia,pins = "dap4_dout_pp6";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* SDMMC1 pinmux */
+			sdmmc1-wp-clk {
+				nvidia,pins = "sdmmc1_wp_n_pv3",
+						"sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1-cmd {
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
+
+			/* SDMMC3 pinmux */
+			sdmmc3-clk {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-cmd {
+				nvidia,pins = "sdmmc3_cmd_pa7",
+						"sdmmc3_dat3_pb4",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_cd_n_pv2",
+						"sdmmc3_clk_lb_in_pee5";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-clk-lb-out {
+				nvidia,pins = "sdmmc3_clk_lb_out_pee4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* SDMMC4 pinmux */
+			sdmmc4-clk {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4-cmd {
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
+			/* HDMI pinmux */
+			hdmi-int {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,rcv-sel = <TEGRA_PIN_DISABLE>;
+			};
+			hdmi-cec {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* I2C pinmux */
+			gen1-i2c {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+						"gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+			gen2-i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+			cam-i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+			ddc-scl-pv4 {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,rcv-sel = <TEGRA_PIN_DISABLE>;
+			};
+			pwr-i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UARTA pinmux */
+			uarta-out {
+				nvidia,pins = "pu0", "pu3";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			uarta-in {
+				nvidia,pins = "pu1", "pu2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UARTB pinmux */
+			uart2-txd-pc2 {
+				nvidia,pins = "uart2_txd_pc2";
+				nvidia,function = "irda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			uart2-rxd-pc3 {
+				nvidia,pins = "uart2_rxd_pc3";
+				nvidia,function = "irda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uart2-cts-n-pj5 {
+				nvidia,pins = "uart2_cts_n_pj5",
+						"uart2_rts_n_pj6";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* UARTC pinmux */
+			uart3-cts-rxd {
+				nvidia,pins = "uart3_cts_n_pa1",
+						"uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uart3-rts-txd {
+				nvidia,pins = "uart3_rts_n_pc0",
+						"uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* UARTD pinmux */
+			uartd-out {
+				nvidia,pins = "ulpi_clk_py0",
+						"ulpi_stp_py3";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			uartd-in {
+				nvidia,pins = "ulpi_dir_py1",
+						"ulpi_nxt_py2";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GMI section */
+			gmi-a17 {
+				nvidia,pins = "gmi_a17_pb0",
+						"gmi_a18_pb1",
+						"gmi_iordy_pi5",
+						"kb_col1_pq1",
+						"kb_row8_ps0",
+						"pbb6";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-wp-n {
+				nvidia,pins = "gmi_wp_n_pc7",
+						"gmi_cs0_n_pj0",
+						"gpio_x7_aud_px7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad0 {
+				nvidia,pins = "gmi_ad0_pg0",
+						"gmi_ad1_pg1",
+						"gmi_ad2_pg2",
+						"gmi_ad3_pg3",
+						"gmi_ad4_pg4",
+						"gmi_ad5_pg5",
+						"gmi_ad6_pg6",
+						"gmi_ad7_pg7",
+						"gmi_oe_n_pi1",
+						"pv1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad8 {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-ad9 {
+				nvidia,pins = "gmi_ad9_ph1",
+						"gmi_ad10_ph2",
+						"gmi_ad11_ph3",
+						"gmi_ad15_ph7",
+						"gmi_cs4_n_pk2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-ad12 {
+				nvidia,pins = "gmi_ad12_ph4",
+						"gmi_ad13_ph5",
+						"gpio_x1_aud_px1",
+						"pcc1",
+						"clk3_req_pee1",
+						"clk1_req_pee2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-ad14 {
+				nvidia,pins = "gmi_ad14_ph6",
+						"gmi_a16_pj7",
+						"gmi_a19_pk7";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-wr-n {
+				nvidia,pins = "gmi_wr_n_pi0";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-cs6-n {
+				nvidia,pins = "gmi_cs6_n_pi3",
+						"gmi_cs7_n_pi6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-rst-n {
+				nvidia,pins = "gmi_rst_n_pi4",
+						"spdif_out_pk5",
+						"spdif_in_pk6",
+						"clk2_out_pw5",
+						"dvfs_pwm_px0",
+						"dvfs_clk_px2",
+						"pbb7",
+						"pcc2",
+						"clk2_req_pcc5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-wait {
+				nvidia,pins = "gmi_wait_pi7";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-cs1-n {
+				nvidia,pins = "gmi_cs1_n_pj2";
+				nvidia,function = "soc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-dqs-p {
+				nvidia,pins = "gmi_dqs_p_pj3";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-adv-n {
+				nvidia,pins = "gmi_adv_n_pk0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-clk {
+				nvidia,pins = "gmi_clk_pk1",
+						"gmi_cs2_n_pk3",
+						"gmi_cs3_n_pk4";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			jtag-rtck {
+				nvidia,pins = "jtag_rtck";
+				nvidia,function = "rtck";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* KBC pinmux */
+			kb-col0 {
+				nvidia,pins = "kb_col0_pq0",
+						"kb_col3_pq3",
+						"kb_col4_pq4",
+						"kb_row4_pr4";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-col2 {
+				nvidia,pins = "kb_col2_pq2",
+						"kb_col6_pq6",
+						"kb_col7_pq7",
+						"kb_row0_pr0",
+						"kb_row2_pr2",
+						"pv0",
+						"sys_clk_req_pz5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-col5 {
+				nvidia,pins = "kb_col5_pq5",
+						"kb_row5_pr5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-row1 {
+				nvidia,pins = "kb_row1_pr1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-row3 {
+				nvidia,pins = "kb_row3_pr3",
+						"kb_row9_ps1";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb-row6 {
+				nvidia,pins = "kb_row6_pr6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb-row7 {
+				nvidia,pins = "kb_row7_pr7",
+						"pbb3",
+						"pbb4",
+						"pbb5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb-row10 {
+				nvidia,pins = "kb_row10_ps2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* CORE pinmux */
+			clk-32k-out {
+				nvidia,pins = "clk_32k_out_pa0";
+				nvidia,function = "blink";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			clk-32k-in {
+				nvidia,pins = "clk_32k_in";
+				nvidia,function = "clk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			core-pwr-req {
+				nvidia,pins = "core_pwr_req";
+				nvidia,function = "pwron";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			cpu-pwr-req {
+				nvidia,pins = "cpu_pwr_req";
+				nvidia,function = "cpu";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pwr-int-n {
+				nvidia,pins = "pwr_int_n";
+				nvidia,function = "pmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,rcv-sel = <TEGRA_PIN_DISABLE>;
+			};
+			reset-out-n {
+				nvidia,pins = "reset_out_n";
+				nvidia,function = "reset_out_n";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* AUD pinmux */
+			gpio-w2-aud {
+				nvidia,pins = "gpio_w2_aud_pw2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gpio-w3-aud {
+				nvidia,pins = "gpio_w3_aud_pw3";
+				nvidia,function = "spi6";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gpio-x3-aud {
+				nvidia,pins = "gpio_x3_aud_px3";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gpio-x4-aud {
+				nvidia,pins = "gpio_x4_aud_px4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gpio-x5-aud {
+				nvidia,pins = "gpio_x5_aud_px5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gpio-x6-aud {
+				nvidia,pins = "gpio_x6_aud_px6";
+				nvidia,function = "spi6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pu4 {
+				nvidia,pins = "pu4";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pu5 {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pu6 {
+				nvidia,pins = "pu6";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb0 {
+				nvidia,pins = "pbb0",
+						"cam_mclk_pcc0";
+				nvidia,function = "vi_alt1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			clk1-out {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk3-out {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* USB pinmux */
+			usb-vbus-en0 {
+				nvidia,pins = "usb_vbus_en0_pn4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+			usb-vbus-en1 {
+				nvidia,pins = "usb_vbus_en1_pn5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
+
+	uarta: serial@70006000 {
+		status = "okay";
+	};
+
+	pwm: pwm@7000a000 {
+		status = "okay";
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* Texas Instruments TPS65090 PMIC */
+		tps65090@48 {
+			compatible = "ti,tps65090";
+			reg = <0x48>;
+
+			regulators {
+				tps65090_fet1: fet1 {
+					regulator-name = "vcd_led";
+					regulator-boot-on;
+				};
+
+				tps65090_fet4: fet4 {
+					regulator-name = "vdd_lcd";
+					regulator-boot-on;
+				};
+
+				tps65090_fet6: fet6 {
+					regulator-name = "vdd_usd";
+					regulator-boot-on;
+				};
+			};
+		};
+
+		/* Texas Instruments TPS65913 PMIC */
+		pmic: tps65913@58 {
+			compatible = "ti,tps65913";
+			reg = <0x58>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			ti,system-power-controller;
+
+			pmic {
+				compatible = "ti,tps65913-pmic";
+
+				regulators {
+					vdd_1v8_vio: smps8 {
+						regulator-name = "vdd_1v8";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-always-on;
+						regulator-boot-on;
+						regulator-ramp-delay = <5000>;
+					};
+
+					avdd_dsi_csi: ldo3 {
+						regulator-name = "avdd_dsi_csi";
+						regulator-min-microvolt = <1200000>;
+						regulator-max-microvolt = <1200000>;
+						regulator-boot-on;
+					};
+
+					vddio_usd: ldo9 {
+						regulator-name = "vddio_usd";
+						regulator-min-microvolt = <2900000>;
+						regulator-max-microvolt = <2900000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+				};
+			};
+		};
+	};
+
+	sdmmc3: sdhci@78000400 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+
+		nvidia,default-tap = <0x3>;
+		nvidia,default-trim = <0x3>;
+
+		vmmc-supply = <&tps65090_fet6>;
+		vqmmc-supply = <&vddio_usd>;
+	};
+
+	sdmmc4: sdhci@78000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+	};
+
+	usb1: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(K, 1) GPIO_ACTIVE_HIGH>;
+	};
+
+	usb-phy@7d000000 {
+		status = "okay";
+
+		nvidia,xcvr-setup = <7>;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		power-supply = <&tps65090_fet1>;
+		pwms = <&pwm 0 1000000>;
+
+		brightness-levels = <1 35 70 105 140 175 210 255>;
+		default-brightness-level = <5>;
+	};
+
+	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "pmic-oscillator";
+	};
+
+	extcon-keys {
+		compatible = "gpio-keys";
+
+		switch-hall-sensor {
+			label = "Hall Sensor";
+			gpios = <&gpio TEGRA_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
+			linux,code = <SW_LID>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power Button";
+			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-windows {
+			label = "Windows Button";
+			gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_ENTER>;
+		};
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra114/Kconfig b/arch/arm/mach-tegra/tegra114/Kconfig
index 98f1d0e71c1..43dd59fb113 100644
--- a/arch/arm/mach-tegra/tegra114/Kconfig
+++ b/arch/arm/mach-tegra/tegra114/Kconfig
@@ -8,6 +8,10 @@ config TARGET_DALMORE
 	bool "NVIDIA Tegra114 Dalmore evaluation board"
 	select BOARD_LATE_INIT
 
+config TARGET_SURFACE_2
+	bool "Microsoft Surface 2"
+	select BOARD_LATE_INIT
+
 config TARGET_TEGRATAB
 	bool "NVIDIA Tegra114 TegraTab evaluation board"
 	select BOARD_LATE_INIT
@@ -22,6 +26,7 @@ config SYS_SOC
 	default "tegra114"
 
 source "board/nvidia/dalmore/Kconfig"
+source "board/microsoft/surface-2/Kconfig"
 source "board/nvidia/tegratab/Kconfig"
 source "board/asus/transformer-t114/Kconfig"
 
diff --git a/board/microsoft/surface-2/Kconfig b/board/microsoft/surface-2/Kconfig
new file mode 100644
index 00000000000..8573666dc92
--- /dev/null
+++ b/board/microsoft/surface-2/Kconfig
@@ -0,0 +1,13 @@
+if TARGET_SURFACE_2
+
+config SYS_BOARD
+	default "surface-2"
+
+config SYS_VENDOR
+	default "microsoft"
+
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "Microsoft Surface 2"
+
+endif
diff --git a/board/microsoft/surface-2/MAINTAINERS b/board/microsoft/surface-2/MAINTAINERS
new file mode 100644
index 00000000000..57747d304cd
--- /dev/null
+++ b/board/microsoft/surface-2/MAINTAINERS
@@ -0,0 +1,7 @@
+SURFACE_2 BOARD
+M:	Jonas Schwöbel <jonasschwoebel@yahoo.de>
+S:	Maintained
+F:	arch/arm/dts/tegra114-microsoft-surface-2*
+F:	board/microsoft/surface-2/
+F:	configs/surface-2_defconfig
+F:	doc/board/microsoft/surface-2.rst
diff --git a/board/microsoft/surface-2/Makefile b/board/microsoft/surface-2/Makefile
new file mode 100644
index 00000000000..43bf6c66db2
--- /dev/null
+++ b/board/microsoft/surface-2/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
+
+obj-$(CONFIG_XPL_BUILD) += surface-2-spl.o
+obj-$(CONFIG_MULTI_DTB_FIT) += board-info.o
diff --git a/board/microsoft/surface-2/board-info.c b/board/microsoft/surface-2/board-info.c
new file mode 100644
index 00000000000..474eadfa4ba
--- /dev/null
+++ b/board/microsoft/surface-2/board-info.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2025
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <stdio.h>
+#include <env.h>
+#include <spl_gpio.h>
+
+#include <asm/gpio.h>
+#include <asm/arch/pinmux.h>
+#include <linux/string.h>
+
+static int id_gpio_get_value(u32 pingrp, u32 pin)
+{
+	/* Configure pinmux */
+	pinmux_set_func(pingrp, PMUX_FUNC_KBC);
+	pinmux_set_pullupdown(pingrp, PMUX_PULL_DOWN);
+	pinmux_tristate_enable(pingrp);
+	pinmux_set_io(pingrp, PMUX_PIN_INPUT);
+
+	/*
+	 * Since this function may be called
+	 * during DM reload we should use SPL
+	 * GPIO functions which do not depend
+	 * on DM.
+	 */
+	spl_gpio_input(NULL, pin);
+	return spl_gpio_get_value(NULL, pin);
+}
+
+static int get_board_id(void)
+{
+	u32 pcb_id0, pcb_id1, pcb_id2, pcb_id3, pcb_id4, board_id;
+
+	pcb_id0 = id_gpio_get_value(PMUX_PINGRP_KB_COL0_PQ0, TEGRA_GPIO(Q, 0));
+	pcb_id1 = id_gpio_get_value(PMUX_PINGRP_KB_COL1_PQ1, TEGRA_GPIO(Q, 1));
+	pcb_id2 = id_gpio_get_value(PMUX_PINGRP_KB_COL2_PQ2, TEGRA_GPIO(Q, 2));
+	pcb_id3 = id_gpio_get_value(PMUX_PINGRP_KB_COL3_PQ3, TEGRA_GPIO(Q, 3));
+	pcb_id4 = id_gpio_get_value(PMUX_PINGRP_KB_COL4_PQ4, TEGRA_GPIO(Q, 4));
+
+	/* Construct board ID */
+	board_id = pcb_id4 << 4 | pcb_id3 << 3 | pcb_id2 << 2 | pcb_id1 << 1 | pcb_id0;
+
+	log_debug("[SURFACE-2]: Board ID %02x\n", board_id);
+
+	return board_id & 0x1f;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	char dt_name[64] = { 0 };
+
+	snprintf(dt_name, sizeof(dt_name), "tegra114-microsoft-surface-2-%02x.dtb",
+		 get_board_id());
+
+	if (!strcmp(name, dts_name))
+		return 0;
+
+	return -1;
+}
+
+void nvidia_board_late_init(void)
+{
+	char dt_path[64] = { 0 };
+
+	snprintf(dt_path, sizeof(dt_path), "tegra114-microsoft-surface-2-%02x.dtb",
+		 get_board_id());
+	env_set("fdtfile", dt_path);
+}
diff --git a/board/microsoft/surface-2/surface-2-spl.c b/board/microsoft/surface-2/surface-2-spl.c
new file mode 100644
index 00000000000..16f4373c7f0
--- /dev/null
+++ b/board/microsoft/surface-2/surface-2-spl.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Surface 2 SPL stage configuration
+ *
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2023
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <asm/arch/tegra.h>
+#include <asm/arch-tegra/tegra_i2c.h>
+#include <linux/delay.h>
+
+#define TPS65913_I2C_ADDR		(0x58 << 1)
+
+#define TPS65913_SMPS12_CTRL		0x20
+#define TPS65913_SMPS12_VOLTAGE		0x23
+#define TPS65913_SMPS45_CTRL		0x28
+#define TPS65913_SMPS45_VOLTAGE		0x2B
+
+#define TPS65913_SMPS12_CTRL_DATA	(0x5100 | TPS65913_SMPS12_CTRL)
+#define TPS65913_SMPS12_VOLTAGE_DATA	(0x3900 | TPS65913_SMPS12_VOLTAGE)
+#define TPS65913_SMPS45_CTRL_DATA	(0x5100 | TPS65913_SMPS45_CTRL)
+#define TPS65913_SMPS45_VOLTAGE_DATA	(0x4c00 | TPS65913_SMPS45_VOLTAGE)
+
+void pmic_enable_cpu_vdd(void)
+{
+	/* Set CORE VDD to 1.200V. */
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS45_VOLTAGE_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS45_CTRL_DATA);
+
+	udelay(1000);
+
+	/* Set CPU VDD to 1.0125V. */
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS12_VOLTAGE_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS12_CTRL_DATA);
+	udelay(10 * 1000);
+}
diff --git a/board/microsoft/surface-2/surface-2.env b/board/microsoft/surface-2/surface-2.env
new file mode 100644
index 00000000000..a77885a7c6d
--- /dev/null
+++ b/board/microsoft/surface-2/surface-2.env
@@ -0,0 +1,8 @@
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_4=power off=reset
+bootmenu_delay=-1
diff --git a/configs/surface-2_defconfig b/configs/surface-2_defconfig
new file mode 100644
index 00000000000..7b71fa2b4ea
--- /dev/null
+++ b/configs/surface-2_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x80110000
+CONFIG_SYS_MALLOC_LEN=0x2500000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="surface-2"
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra114-microsoft-surface-2-0b"
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_TEGRA114=y
+CONFIG_TARGET_SURFACE_2=y
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_SYS_PBSIZE=2086
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+CONFIG_SYS_PROMPT="Tegra114 (Surface 2) # "
+# CONFIG_CMD_BOOTEFI_BOOTMGR is not set
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_UMS_ABORT_KEYED=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PAUSE=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_LIST="tegra114-microsoft-surface-2-0b tegra114-microsoft-surface-2-13"
+CONFIG_DTB_RESELECT=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_BUF_SIZE=0x10000000
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65090=y
+CONFIG_PMIC_PALMAS=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_REGULATOR_TPS65090=y
+CONFIG_DM_REGULATOR_PALMAS=y
+CONFIG_PWM_TEGRA=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYSRESET_PALMAS=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_DSI_TEGRA=y
diff --git a/doc/board/microsoft/index.rst b/doc/board/microsoft/index.rst
index 107f3527852..8318449a9a2 100644
--- a/doc/board/microsoft/index.rst
+++ b/doc/board/microsoft/index.rst
@@ -6,4 +6,5 @@ Microsoft
 .. toctree::
    :maxdepth: 2
 
+   surface-2
    surface-rt
diff --git a/doc/board/microsoft/surface-2.rst b/doc/board/microsoft/surface-2.rst
new file mode 100644
index 00000000000..8185c6f5ae4
--- /dev/null
+++ b/doc/board/microsoft/surface-2.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the Microsoft Surface 2 tablet
+=========================================
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Boot
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-none-eabi-
+    $ make surface-2_defconfig
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-dtb-tegra.bin``
+image, ready for loading.
+
+Boot
+----
+
+Currently, U-Boot can be preloaded into RAM via the Fusée Gelée. To enter
+RCM protocol use ``power`` and ``volume up`` key combination from powered
+off device. The host PC should recognize an APX device.
+
+Built U-Boot ``u-boot-dtb-tegra.bin`` can be loaded from fusee-tools
+directory with
+
+.. code-block:: bash
+
+    $ ./run_bootloader.sh -s T30 -t ./bct/surface-2.bct
+
+To boot Linux, U-Boot will look for an ``extlinux.conf`` on MicroSD and then on
+eMMC. Additionally, if the Volume Down button is pressed while loading, the
+device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
+as mass storage, fastboot, poweroff and enter U-Boot console.
-- 
2.48.1

