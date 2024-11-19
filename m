Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9E7D6C2BA
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A7789623;
	Wed, 20 Nov 2024 01:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6b+EEN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E20A89555; Tue, 19 Nov 2024 23:46:53 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA666895D9
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3821a8c7c5cso667193f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056410; x=1732661210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sF6Tp2/pRdN0BzptcIUevTa/Zbklnfm6T4bZ8FxQZi8=;
 b=a6b+EEN5L3jl2KNwpyHfHXQipa8RxKLY32+9twVhQhNxF+YMGqnic8O6jcEEQTo2tb
 eLcBoGuCLHmbcBgMbbsqBVU3ACmv+TMoBigETGMW+i/RlTBo696RBV1tzWDFUDm0HNOB
 V2hXTT1pgUSSJg8lnShThiIE1vlYSxa057u0UpTNfZpUOfUlegDCVg+MzLcznDL6UcTh
 mHfuUuN6nSPZe0HkLecU3LiFAuao90u1t5oe5oAK11NzEB6wPAXp/MghhWeM2a2Btiy4
 FZ/H2m+UES3VEAVoLTieG3bPB4xfpbGYG6LH9V/mh67MyoTOttgToUexfJuKMjam2IOq
 jMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056410; x=1732661210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sF6Tp2/pRdN0BzptcIUevTa/Zbklnfm6T4bZ8FxQZi8=;
 b=OI5+LPh482s0YWdaISQ3s6ESCI3Yvk8V7dk0/YfKIVwV89+q2dYCHGbjY8PLN7hoxB
 x+lXpU8OLBki73SbspkYJ99F2PsHrM7+hoqnCNJvZZYn7Jhkpd9/SMlF/y9POtun2Ypt
 MHOBQcOadfsyo1YCMWOcGoW5thI/R+PG0khEE+emwyZ4P7ZqoB2WmD7z5mhLuv1c8vbT
 R+DbX2y+VdxeN6p2TsPQvP5L7Y2dxUYANh+8f81jN+b5i5jWxGeq3zhOVQ4KNpVca7rV
 rM2yjgvysE7bqeJ4aKtDSae5bMdR9qVUKj4SQWAma261AWStIG67fb1P8wpZHKoVIK8m
 YgsQ==
X-Gm-Message-State: AOJu0Yy9OroGEl8Ep/dzGp+vfk3CiP5VZtZ8Y/EWPgYxPa/VsYmBfGST
 hYIebY1Qbg4OON/Y2ALINUKIioqiiOv4D2FFOwLPGe/eAfDXYYAVzOQkCrwO
X-Gm-Gg: ASbGncvz60y34dejWNCm/e5ObI3RSI3u8uHeB9MTU6qcjbeVHed+nTIiNhqAGY+FWCc
 N6o/mJncB2729654I8X/mWnohDsRFYa3Bqi0otCcHONts8o5+YetACgCs+1p2O1TYE1E8GLkHkK
 X/M+bCBRZGO5TioD32dd5Iv0yxwCLTVJtBSaeLwtV4vMNTY/Us4cM+5vlQW+3OTmQHz6uJEx5Rl
 mQJtBlVxIIoiMus4b11S2XIcoWJOag1Jzt5O/qQsvAqfSirm/w7ogTkYxSupcey5MWaWfed10lP
 MgRnkDllx8jhKqMovdLQdLMhgSu5
X-Google-Smtp-Source: AGHT+IENKCrfsuSN+EAX5dXjVpQEpBjy+/AcX2R682N6EG9DHzKtRHqhReJagMvUq7LcH6LwCoLnlQ==
X-Received: by 2002:a05:600c:3ba6:b0:432:7c08:d0fb with SMTP id
 5b1f17b1804b1-433489b1372mr2204645e9.3.1732056409966; 
 Tue, 19 Nov 2024 14:46:49 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:46:49 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 03/10] ARM: dts: socfpga: add Mercury+ AA1 for u-boot dts
Date: Tue, 19 Nov 2024 22:46:36 +0000
Message-Id: <20241119224643.27692-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119224643.27692-1-l.rubusch@gmail.com>
References: <20241119224643.27692-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Introduce u-boot specific device-tree files for Enclustra Mercury+ AA1
SoMs (Intel/arria10).

Generic device-tree fragments for linux and U-boot shall be provided in
dts/upstream. The selection of the generic device-tree fragments depends
on a selected boot-mode and a selected carrier board.

On Intel/Arria10 a handoff setup is needed for initialization of
various clock / pinmux / DRAM settings only used by U-Boot provided by
the current patch.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 ..._arria10_enclustra_mercury_aa1-u-boot.dtsi |  45 +++
 .../socfpga_arria10_enclustra_mercury_aa1.dts |  45 +++
 .../socfpga_arria10_mercury_aa1-u-boot.dtsi   |  19 ++
 .../dts/socfpga_arria10_mercury_aa1_handoff.h | 305 ++++++++++++++++++
 board/enclustra/mercury_aa1/Kconfig           |  37 +++
 board/enclustra/mercury_aa1/MAINTAINERS       |   2 +
 6 files changed, 453 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h

diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
new file mode 100644
index 0000000000..6e38286572
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Lothar Rubusch <l.rubusch@gmail.com>
+ */
+
+/* Arria10 handoff (u-boot) */
+#include "socfpga_arria10_mercury_aa1_handoff.h"
+#include "socfpga_arria10-handoff.dtsi"
+#include "socfpga_arria10_handoff_u-boot.dtsi"
+#include "socfpga_arria10_mercury_aa1-u-boot.dtsi"
+
+/* Specific boot-mode (u-boot) */
+#if IS_ENABLED(CONFIG_ENCLUSTRA_SDMMC) || IS_ENABLED(CONFIG_ENCLUSTRA_EMMC)
+
+/ {
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		phandlepart = <&mmc 1>;
+	};
+};
+
+&fpga_mgr {
+	bootph-all;
+	firmware-loader = <&fs_loader0>;
+	altr,bitstream = "fpga.itb";
+};
+
+#elif IS_ENABLED(CONFIG_ENCLUSTRA_QSPI)
+
+/ {
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		sfconfig = <0 0 50000000 3>;
+	};
+};
+
+&fpga_mgr {
+	bootph-all;
+	firmware-loader = <&fs_loader0>;
+	altr,bitstream = "300000";
+};
+
+#endif
diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
new file mode 100644
index 0000000000..e8cc51a7b8
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Lothar Rubusch <l.rubusch@gmail.com>
+ */
+
+/dts-v1/;
+
+/* The arria10 family */
+#include "socfpga/socfpga_arria10_mercury_aa1.dtsi"
+
+/ {
+	aliases {
+		ethernet0 = &gmac0;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		i2c0 = &i2c1;
+		i2c1 = &i2c0;
+		spi0 = &qspi;
+	};
+};
+
+&qspi {
+	bootph-all;
+	status = "okay";
+	flash0: s25fl512s@0 {
+		bootph-all;
+
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+
+		cdns,tshsl-ns = <200>;
+		cdns,tsd2d-ns = <255>;
+		cdns,tchsh-ns = <20>;
+		cdns,tslch-ns = <20>;
+	};
+};
+
+/* Carrier board support */
+#if IS_ENABLED(CONFIG_ENCLUSTRA_PE1)
+# include "socfpga/socfpga_enclustra_mercury_pe1.dtsi"
+#elif IS_ENABLED(CONFIG_ENCLUSTRA_PE3)
+# include "socfpga/socfpga_enclustra_mercury_pe3.dtsi"
+#elif IS_ENABLED(CONFIG_ENCLUSTRA_ST1)
+# include "socfpga/socfpga_enclustra_mercury_st1.dtsi"
+#endif
diff --git a/arch/arm/dts/socfpga_arria10_mercury_aa1-u-boot.dtsi b/arch/arm/dts/socfpga_arria10_mercury_aa1-u-boot.dtsi
index 8866df3ddd..ad5b5a87e0 100644
--- a/arch/arm/dts/socfpga_arria10_mercury_aa1-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_arria10_mercury_aa1-u-boot.dtsi
@@ -33,6 +33,21 @@
 	bootph-all;
 };
 
+&l4_main_clk {
+	bootph-all;
+};
+
+&qspi_clk {
+	bootph-all;
+};
+
+&qspi {
+	bootph-all;
+	flash0: s25fl512s@0 {
+		bootph-all;
+	};
+};
+
 &mmc {
 	bootph-all;
 };
@@ -52,3 +67,7 @@
 &uart1 {
 	bootph-all;
 };
+
+&watchdog1 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h b/arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
new file mode 100644
index 0000000000..b7cdb74792
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
@@ -0,0 +1,305 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Intel Arria 10 SoCFPGA configuration
+ */
+
+#ifndef __SOCFPGA_ARRIA10_CONFIG_H__
+#define __SOCFPGA_ARRIA10_CONFIG_H__
+
+/* Clocks */
+#define CB_INTOSC_LS_CLK_HZ 60000000
+#define EMAC0_CLK_HZ 250000000
+#define EMAC1_CLK_HZ 250000000
+#define EMAC2_CLK_HZ 250000000
+#define EOSC1_CLK_HZ 33333000
+#define F2H_FREE_CLK_HZ 200000000
+#define H2F_USER0_CLK_HZ 100000000
+#define H2F_USER1_CLK_HZ 50000000
+#define L3_MAIN_FREE_CLK_HZ 400000000
+#define SDMMC_CLK_HZ 200000000
+#define TPIU_CLK_HZ 100000000
+#define MAINPLLGRP_CNTR15CLK_CNT 900
+#define MAINPLLGRP_CNTR2CLK_CNT 900
+#define MAINPLLGRP_CNTR3CLK_CNT 900
+#define MAINPLLGRP_CNTR4CLK_CNT 900
+#define MAINPLLGRP_CNTR5CLK_CNT 900
+#define MAINPLLGRP_CNTR6CLK_CNT 9
+#define MAINPLLGRP_CNTR7CLK_CNT 19
+#define MAINPLLGRP_CNTR7CLK_SRC 0
+#define MAINPLLGRP_CNTR8CLK_CNT 39
+#define MAINPLLGRP_CNTR9CLK_CNT 900
+#define MAINPLLGRP_CNTR9CLK_SRC 0
+#define MAINPLLGRP_MPUCLK_CNT 0
+#define MAINPLLGRP_MPUCLK_SRC 0
+#define MAINPLLGRP_NOCCLK_CNT 0
+#define MAINPLLGRP_NOCCLK_SRC 0
+#define MAINPLLGRP_NOCDIV_CSATCLK 0
+#define MAINPLLGRP_NOCDIV_CSPDBGCLK 1
+#define MAINPLLGRP_NOCDIV_CSTRACECLK 0
+#define MAINPLLGRP_NOCDIV_L4MAINCLK 0
+#define MAINPLLGRP_NOCDIV_L4MPCLK 1
+#define MAINPLLGRP_NOCDIV_L4SPCLK 2
+#define MAINPLLGRP_VCO0_PSRC 0
+#define MAINPLLGRP_VCO1_DENOM 32
+#define MAINPLLGRP_VCO1_NUMER 1980
+#define PERPLLGRP_CNTR2CLK_CNT 7
+#define PERPLLGRP_CNTR2CLK_SRC 1
+#define PERPLLGRP_CNTR3CLK_CNT 900
+#define PERPLLGRP_CNTR3CLK_SRC 1
+#define PERPLLGRP_CNTR4CLK_CNT 19
+#define PERPLLGRP_CNTR4CLK_SRC 1
+#define PERPLLGRP_CNTR5CLK_CNT 499
+#define PERPLLGRP_CNTR5CLK_SRC 1
+#define PERPLLGRP_CNTR6CLK_CNT 900
+#define PERPLLGRP_CNTR6CLK_SRC 0
+#define PERPLLGRP_CNTR7CLK_CNT 900
+#define PERPLLGRP_CNTR8CLK_CNT 900
+#define PERPLLGRP_CNTR8CLK_SRC 0
+#define PERPLLGRP_CNTR9CLK_CNT 900
+#define PERPLLGRP_EMACCTL_EMAC0SEL 0
+#define PERPLLGRP_EMACCTL_EMAC1SEL 0
+#define PERPLLGRP_EMACCTL_EMAC2SEL 0
+#define PERPLLGRP_GPIODIV_GPIODBCLK 32000
+#define PERPLLGRP_VCO0_PSRC 0
+#define PERPLLGRP_VCO1_DENOM 32
+#define PERPLLGRP_VCO1_NUMER 1980
+#define CLKMGR_TESTIOCTRL_DEBUGCLKSEL 16
+#define CLKMGR_TESTIOCTRL_MAINCLKSEL 8
+#define CLKMGR_TESTIOCTRL_PERICLKSEL 8
+#define ALTERAGRP_MPUCLK_MAINCNT 1
+#define ALTERAGRP_MPUCLK_PERICNT 900
+#define ALTERAGRP_NOCCLK_MAINCNT 4
+#define ALTERAGRP_NOCCLK_PERICNT 900
+#define ALTERAGRP_MPUCLK ((ALTERAGRP_MPUCLK_PERICNT << 16) | \
+	(ALTERAGRP_MPUCLK_MAINCNT))
+#define ALTERAGRP_NOCCLK ((ALTERAGRP_NOCCLK_PERICNT << 16) | \
+	(ALTERAGRP_NOCCLK_MAINCNT))
+
+/* Pin Mux Configuration */
+#define CONFIG_IO_10_INPUT_BUF_EN 1
+#define CONFIG_IO_10_PD_DRV_STRG 10
+#define CONFIG_IO_10_PD_SLW_RT 1
+#define CONFIG_IO_10_PU_DRV_STRG 8
+#define CONFIG_IO_10_PU_SLW_RT 1
+#define CONFIG_IO_10_RTRIM 1
+#define CONFIG_IO_10_WK_PU_EN 0
+#define CONFIG_IO_11_INPUT_BUF_EN 1
+#define CONFIG_IO_11_PD_DRV_STRG 10
+#define CONFIG_IO_11_PD_SLW_RT 1
+#define CONFIG_IO_11_PU_DRV_STRG 8
+#define CONFIG_IO_11_PU_SLW_RT 1
+#define CONFIG_IO_11_RTRIM 1
+#define CONFIG_IO_11_WK_PU_EN 0
+#define CONFIG_IO_12_INPUT_BUF_EN 1
+#define CONFIG_IO_12_PD_DRV_STRG 10
+#define CONFIG_IO_12_PD_SLW_RT 1
+#define CONFIG_IO_12_PU_DRV_STRG 8
+#define CONFIG_IO_12_PU_SLW_RT 1
+#define CONFIG_IO_12_RTRIM 1
+#define CONFIG_IO_12_WK_PU_EN 0
+#define CONFIG_IO_13_INPUT_BUF_EN 1
+#define CONFIG_IO_13_PD_DRV_STRG 10
+#define CONFIG_IO_13_PD_SLW_RT 1
+#define CONFIG_IO_13_PU_DRV_STRG 8
+#define CONFIG_IO_13_PU_SLW_RT 1
+#define CONFIG_IO_13_RTRIM 1
+#define CONFIG_IO_13_WK_PU_EN 0
+#define CONFIG_IO_14_INPUT_BUF_EN 1
+#define CONFIG_IO_14_PD_DRV_STRG 10
+#define CONFIG_IO_14_PD_SLW_RT 1
+#define CONFIG_IO_14_PU_DRV_STRG 8
+#define CONFIG_IO_14_PU_SLW_RT 1
+#define CONFIG_IO_14_RTRIM 1
+#define CONFIG_IO_14_WK_PU_EN 0
+#define CONFIG_IO_15_INPUT_BUF_EN 1
+#define CONFIG_IO_15_PD_DRV_STRG 10
+#define CONFIG_IO_15_PD_SLW_RT 1
+#define CONFIG_IO_15_PU_DRV_STRG 8
+#define CONFIG_IO_15_PU_SLW_RT 1
+#define CONFIG_IO_15_RTRIM 1
+#define CONFIG_IO_15_WK_PU_EN 0
+#define CONFIG_IO_16_INPUT_BUF_EN 0
+#define CONFIG_IO_16_PD_DRV_STRG 10
+#define CONFIG_IO_16_PD_SLW_RT 1
+#define CONFIG_IO_16_PU_DRV_STRG 8
+#define CONFIG_IO_16_PU_SLW_RT 1
+#define CONFIG_IO_16_RTRIM 1
+#define CONFIG_IO_16_WK_PU_EN 0
+#define CONFIG_IO_17_INPUT_BUF_EN 1
+#define CONFIG_IO_17_PD_DRV_STRG 10
+#define CONFIG_IO_17_PD_SLW_RT 1
+#define CONFIG_IO_17_PU_DRV_STRG 8
+#define CONFIG_IO_17_PU_SLW_RT 1
+#define CONFIG_IO_17_RTRIM 1
+#define CONFIG_IO_17_WK_PU_EN 0
+#define CONFIG_IO_1_INPUT_BUF_EN 1
+#define CONFIG_IO_1_PD_DRV_STRG 10
+#define CONFIG_IO_1_PD_SLW_RT 0
+#define CONFIG_IO_1_PU_DRV_STRG 8
+#define CONFIG_IO_1_PU_SLW_RT 0
+#define CONFIG_IO_1_RTRIM 1
+#define CONFIG_IO_1_WK_PU_EN 1
+#define CONFIG_IO_2_INPUT_BUF_EN 1
+#define CONFIG_IO_2_PD_DRV_STRG 10
+#define CONFIG_IO_2_PD_SLW_RT 0
+#define CONFIG_IO_2_PU_DRV_STRG 8
+#define CONFIG_IO_2_PU_SLW_RT 0
+#define CONFIG_IO_2_RTRIM 1
+#define CONFIG_IO_2_WK_PU_EN 1
+#define CONFIG_IO_3_INPUT_BUF_EN 1
+#define CONFIG_IO_3_PD_DRV_STRG 10
+#define CONFIG_IO_3_PD_SLW_RT 0
+#define CONFIG_IO_3_PU_DRV_STRG 8
+#define CONFIG_IO_3_PU_SLW_RT 0
+#define CONFIG_IO_3_RTRIM 1
+#define CONFIG_IO_3_WK_PU_EN 1
+#define CONFIG_IO_4_INPUT_BUF_EN 1
+#define CONFIG_IO_4_PD_DRV_STRG 10
+#define CONFIG_IO_4_PD_SLW_RT 1
+#define CONFIG_IO_4_PU_DRV_STRG 8
+#define CONFIG_IO_4_PU_SLW_RT 1
+#define CONFIG_IO_4_RTRIM 1
+#define CONFIG_IO_4_WK_PU_EN 0
+#define CONFIG_IO_5_INPUT_BUF_EN 1
+#define CONFIG_IO_5_PD_DRV_STRG 10
+#define CONFIG_IO_5_PD_SLW_RT 1
+#define CONFIG_IO_5_PU_DRV_STRG 8
+#define CONFIG_IO_5_PU_SLW_RT 1
+#define CONFIG_IO_5_RTRIM 1
+#define CONFIG_IO_5_WK_PU_EN 0
+#define CONFIG_IO_6_INPUT_BUF_EN 0
+#define CONFIG_IO_6_PD_DRV_STRG 10
+#define CONFIG_IO_6_PD_SLW_RT 1
+#define CONFIG_IO_6_PU_DRV_STRG 8
+#define CONFIG_IO_6_PU_SLW_RT 1
+#define CONFIG_IO_6_RTRIM 1
+#define CONFIG_IO_6_WK_PU_EN 0
+#define CONFIG_IO_7_INPUT_BUF_EN 1
+#define CONFIG_IO_7_PD_DRV_STRG 10
+#define CONFIG_IO_7_PD_SLW_RT 1
+#define CONFIG_IO_7_PU_DRV_STRG 8
+#define CONFIG_IO_7_PU_SLW_RT 1
+#define CONFIG_IO_7_RTRIM 1
+#define CONFIG_IO_7_WK_PU_EN 0
+#define CONFIG_IO_8_INPUT_BUF_EN 1
+#define CONFIG_IO_8_PD_DRV_STRG 10
+#define CONFIG_IO_8_PD_SLW_RT 1
+#define CONFIG_IO_8_PU_DRV_STRG 8
+#define CONFIG_IO_8_PU_SLW_RT 1
+#define CONFIG_IO_8_RTRIM 1
+#define CONFIG_IO_8_WK_PU_EN 0
+#define CONFIG_IO_9_INPUT_BUF_EN 1
+#define CONFIG_IO_9_PD_DRV_STRG 10
+#define CONFIG_IO_9_PD_SLW_RT 1
+#define CONFIG_IO_9_PU_DRV_STRG 8
+#define CONFIG_IO_9_PU_SLW_RT 1
+#define CONFIG_IO_9_RTRIM 1
+#define CONFIG_IO_9_WK_PU_EN 0
+#define CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
+#define CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
+#define PINMUX_DEDICATED_IO_10_SEL 15
+#define PINMUX_DEDICATED_IO_11_SEL 15
+#define PINMUX_DEDICATED_IO_12_SEL 15
+#define PINMUX_DEDICATED_IO_13_SEL 15
+#define PINMUX_DEDICATED_IO_14_SEL 15
+#define PINMUX_DEDICATED_IO_15_SEL 15
+#define PINMUX_DEDICATED_IO_16_SEL 13
+#define PINMUX_DEDICATED_IO_17_SEL 13
+#define PINMUX_DEDICATED_IO_4_SEL 8
+#define PINMUX_DEDICATED_IO_5_SEL 8
+#define PINMUX_DEDICATED_IO_6_SEL 8
+#define PINMUX_DEDICATED_IO_7_SEL 8
+#define PINMUX_DEDICATED_IO_8_SEL 8
+#define PINMUX_DEDICATED_IO_9_SEL 8
+#define PINMUX_I2C0_USEFPGA_SEL 0
+#define PINMUX_I2C1_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC0_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC1_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC2_USEFPGA_SEL 0
+#define PINMUX_NAND_USEFPGA_SEL 0
+#define PINMUX_PLL_CLOCK_OUT_USEFPGA_SEL 0
+#define PINMUX_QSPI_USEFPGA_SEL 0
+#define PINMUX_RGMII0_USEFPGA_SEL 0
+#define PINMUX_RGMII1_USEFPGA_SEL 0
+#define PINMUX_RGMII2_USEFPGA_SEL 0
+#define PINMUX_SDMMC_USEFPGA_SEL 0
+#define PINMUX_SHARED_IO_Q1_10_SEL 8
+#define PINMUX_SHARED_IO_Q1_11_SEL 8
+#define PINMUX_SHARED_IO_Q1_12_SEL 8
+#define PINMUX_SHARED_IO_Q1_1_SEL 8
+#define PINMUX_SHARED_IO_Q1_2_SEL 8
+#define PINMUX_SHARED_IO_Q1_3_SEL 8
+#define PINMUX_SHARED_IO_Q1_4_SEL 8
+#define PINMUX_SHARED_IO_Q1_5_SEL 8
+#define PINMUX_SHARED_IO_Q1_6_SEL 8
+#define PINMUX_SHARED_IO_Q1_7_SEL 8
+#define PINMUX_SHARED_IO_Q1_8_SEL 8
+#define PINMUX_SHARED_IO_Q1_9_SEL 8
+#define PINMUX_SHARED_IO_Q2_10_SEL 4
+#define PINMUX_SHARED_IO_Q2_11_SEL 4
+#define PINMUX_SHARED_IO_Q2_12_SEL 4
+#define PINMUX_SHARED_IO_Q2_1_SEL 4
+#define PINMUX_SHARED_IO_Q2_2_SEL 4
+#define PINMUX_SHARED_IO_Q2_3_SEL 4
+#define PINMUX_SHARED_IO_Q2_4_SEL 4
+#define PINMUX_SHARED_IO_Q2_5_SEL 4
+#define PINMUX_SHARED_IO_Q2_6_SEL 4
+#define PINMUX_SHARED_IO_Q2_7_SEL 4
+#define PINMUX_SHARED_IO_Q2_8_SEL 4
+#define PINMUX_SHARED_IO_Q2_9_SEL 4
+#define PINMUX_SHARED_IO_Q3_10_SEL 15
+#define PINMUX_SHARED_IO_Q3_11_SEL 1
+#define PINMUX_SHARED_IO_Q3_12_SEL 1
+#define PINMUX_SHARED_IO_Q3_1_SEL 15
+#define PINMUX_SHARED_IO_Q3_2_SEL 15
+#define PINMUX_SHARED_IO_Q3_3_SEL 15
+#define PINMUX_SHARED_IO_Q3_4_SEL 15
+#define PINMUX_SHARED_IO_Q3_5_SEL 15
+#define PINMUX_SHARED_IO_Q3_6_SEL 15
+#define PINMUX_SHARED_IO_Q3_7_SEL 0
+#define PINMUX_SHARED_IO_Q3_8_SEL 0
+#define PINMUX_SHARED_IO_Q3_9_SEL 15
+#define PINMUX_SHARED_IO_Q4_10_SEL 15
+#define PINMUX_SHARED_IO_Q4_11_SEL 15
+#define PINMUX_SHARED_IO_Q4_12_SEL 15
+#define PINMUX_SHARED_IO_Q4_1_SEL 10
+#define PINMUX_SHARED_IO_Q4_2_SEL 10
+#define PINMUX_SHARED_IO_Q4_3_SEL 10
+#define PINMUX_SHARED_IO_Q4_4_SEL 10
+#define PINMUX_SHARED_IO_Q4_5_SEL 10
+#define PINMUX_SHARED_IO_Q4_6_SEL 10
+#define PINMUX_SHARED_IO_Q4_7_SEL 15
+#define PINMUX_SHARED_IO_Q4_8_SEL 15
+#define PINMUX_SHARED_IO_Q4_9_SEL 15
+#define PINMUX_SPIM0_USEFPGA_SEL 0
+#define PINMUX_SPIM1_USEFPGA_SEL 0
+#define PINMUX_SPIS0_USEFPGA_SEL 0
+#define PINMUX_SPIS1_USEFPGA_SEL 0
+#define PINMUX_UART0_USEFPGA_SEL 0
+#define PINMUX_UART1_USEFPGA_SEL 0
+#define PINMUX_USB0_USEFPGA_SEL 0
+#define PINMUX_USB1_USEFPGA_SEL 0
+
+/* Bridge Configuration */
+#define F2H_AXI_SLAVE 0
+#define F2SDRAM0_AXI_SLAVE 0
+#define F2SDRAM1_AXI_SLAVE 0
+#define F2SDRAM2_AXI_SLAVE 0
+#define H2F_AXI_MASTER 1
+#define LWH2F_AXI_MASTER 1
+
+/* Voltage Select for Config IO */
+#define CONFIG_IO_BANK_VSEL \
+	(((CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
+	(CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
+
+/* Macro for Config IO bit mapping */
+#define CONFIG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0x7) << 19) | \
+	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \
+	((NAME ## _WK_PU_EN & 0x1) << 16) | \
+	((NAME ## _PU_SLW_RT & 0x1) << 13) | \
+	((NAME ## _PU_DRV_STRG & 0x1f) << 8) | \
+	((NAME ## _PD_SLW_RT & 0x1) << 5) | \
+	(NAME ## _PD_DRV_STRG & 0x1f))
+
+#endif /* __SOCFPGA_ARRIA10_CONFIG_H__ */
diff --git a/board/enclustra/mercury_aa1/Kconfig b/board/enclustra/mercury_aa1/Kconfig
index 40c7cb2687..a5f3c2a051 100644
--- a/board/enclustra/mercury_aa1/Kconfig
+++ b/board/enclustra/mercury_aa1/Kconfig
@@ -12,4 +12,41 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "socfpga_mercury_aa1"
 
+choice
+	prompt "Mercury+ AA1 base-board"
+	default ENCLUSTRA_PE1
+	help
+	  Select the base-board for Mercury+ AA1.
+
+config ENCLUSTRA_PE1
+	bool "Mercury+ PE1"
+
+config ENCLUSTRA_PE3
+	bool "Mercury+ PE3"
+
+config ENCLUSTRA_ST1
+	bool "Mercury+ ST1"
+
+config ENCLUSTRA_CUSTOM_BASE
+	bool "Customized base-board"
+
+endchoice
+
+choice
+	prompt "Mercury+ AA1 boot-mode"
+	default ENCLUSTRA_SDMMC
+	help
+	  Select the boot-mode for the Mercury+ AA1 setup.
+
+config ENCLUSTRA_SDMMC
+	bool "SD card"
+
+config ENCLUSTRA_EMMC
+	bool "eMMC"
+
+config ENCLUSTRA_QSPI
+	bool "QSPI flash"
+
+endchoice
+
 endif
diff --git a/board/enclustra/mercury_aa1/MAINTAINERS b/board/enclustra/mercury_aa1/MAINTAINERS
index 13baf949ab..f765530770 100644
--- a/board/enclustra/mercury_aa1/MAINTAINERS
+++ b/board/enclustra/mercury_aa1/MAINTAINERS
@@ -1,6 +1,8 @@
 Enclustra Mercury+ AA1
 M:	Lothar Rubusch <l.rubusch@gmail.com>
 S:	Maintained
+N:	arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
+N:	arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
 N:	board/enclustra/mercury_aa1/
 N:	board/enclustra/common/
 N:	configs/socfpga_enclustra_mercury_aa1_defconfig
-- 
2.39.2

