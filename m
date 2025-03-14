Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98942C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2A181F3A;
	Fri, 14 Mar 2025 17:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jcd0nkYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C150581F54; Fri, 14 Mar 2025 17:11:26 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4857C81E1C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e61375c108so2990457a12.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968684; x=1742573484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqZE94FkbjozVltF+lsc4HRVZOFcEWv42jXQKacvDls=;
 b=jcd0nkYS8etirVqGHHOCH6+CcGjqnEMTr0HovZLIDpVbpgLui4gDh+MJa8wJJJUHpq
 cVo1DEzD3a7HM+1NF8HEkr1PqgxhCgIlLtyQdBLx2lJ7cV09W7chJAXAQFgvK9G4wcUf
 ZS+/zBH0kcy1pud7OnPuS5FZWqq7/NH8ovpo2mgPro186LrR97ZCGaQ4fpAHu5hUVNd4
 5LrQhkAQsqd/+NNa9GurT1H3DikvdhFOCpCZX2CtuGagRKpmjSrFQ/0WclB7KEAu+sSP
 UHE8mEPO5KfR7op6hFzYEab4Nq6ugyFcc+exQIseAanuq9puI1iEc0CxsgBIiM6eaBGq
 aJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968684; x=1742573484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqZE94FkbjozVltF+lsc4HRVZOFcEWv42jXQKacvDls=;
 b=liwoslKT0IbW/Kc9YdlRzF645MfZkJ1U6JAO99rsNF/UxzLEahBUHcO9CTEd/FiG41
 hTTyWj3BFH+DbWoTCvYZg9V8mS2v8nVUSY6sYz4PWNcxjZmQpfvaTT/LVPY7ogWD/SnJ
 rKu2A9G9D9JsQTOG/p1LUq/BEFA2VvW29u5bEMD/1T6aDuzvnKGVxiE4UVWtzKzYuJIM
 CkuSQVv4SLWitRVGMQM7RO6mCW0ucuGwHwanwi1BmDvQknSG9pwbMJO+m5oKLO1M5pEB
 JS1Jr6HCmmO6IVkhve6LJ6s93Rjik//fZb7UEaW9dycX4X02cUKsLEF5CnX5XEuQAHZ6
 0Kjw==
X-Gm-Message-State: AOJu0YwGXLjTbUBV/CKjCZ2SOmvWtjyCKxenGQmNY9UHtPJZlIiGRLto
 y4A8vGml6J50NBsodSev/ZIcaMik3oNPWLTzSqNhkFEELSmd0p61
X-Gm-Gg: ASbGncvHATW7Wecq1VR0wvWUeoTs1gOPlxNlHIaZ0NZkz/xBqLv2Ek+IrZ6PViTYxR0
 +tCTdShG1Jv1TqD4a9t7x8M4DKAeJalb2ZuCcRjBlJ6lKaM1lv8ndd41jFNkTvLyW777l3/kHbM
 mn96V9IsuajU4GnHT7X6eL0YhSieTrqvpZwC1yxFVaY1maFdXkpUuY0G3io11ffPumm/Ds4AsZ8
 lJLfh/gdrtViMrNIJtVqnTSDkFjsGZYeNUaGjGfv07Kcgau5caSiItkDGYumwJMia0QfBtfKkGb
 HxI6np/wYUqU2hzw2P8Di9syYwDosprvhvqe
X-Google-Smtp-Source: AGHT+IG7axHG8yxtJR3B2IZWbm2TtzRayXjidbjoqzJa5Gpskjy7q4xrzXNAjahXjbzZeG2xlneKgA==
X-Received: by 2002:a05:6402:13c7:b0:5e5:e090:7b52 with SMTP id
 4fb4d7f45d1cf-5e8a09fcb06mr3667099a12.29.1741968683406; 
 Fri, 14 Mar 2025 09:11:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e8169bcdb3sm2161904a12.43.2025.03.14.09.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:11:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/4] ARM: tegra: dts: fix lock,
 io-reset and open-drain properties
Date: Fri, 14 Mar 2025 18:11:00 +0200
Message-ID: <20250314161100.36894-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314161100.36894-1-clamor95@gmail.com>
References: <20250314161100.36894-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra124-xiaomi-mocha.dts        | 14 +++---
 arch/arm/dts/tegra30-asus-p1801-t.dts         | 28 +++++------
 arch/arm/dts/tegra30-asus-tf600t.dts          | 44 +++++++++---------
 arch/arm/dts/tegra30-asus-transformer.dtsi    | 26 +++++------
 .../dts/tegra30-lenovo-ideapad-yoga-11.dts    | 46 +++++++++----------
 arch/arm/dts/tegra30-microsoft-surface-rt.dts | 38 +++++++--------
 arch/arm/dts/tegra30-wexler-qc750.dts         | 10 ++--
 7 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/arch/arm/dts/tegra124-xiaomi-mocha.dts b/arch/arm/dts/tegra124-xiaomi-mocha.dts
index 6cb1781566f..64386f2b7b7 100644
--- a/arch/arm/dts/tegra124-xiaomi-mocha.dts
+++ b/arch/arm/dts/tegra124-xiaomi-mocha.dts
@@ -215,8 +215,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,open-drain = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 			gen2-i2c {
 				nvidia,pins = "gen2_i2c_scl_pt5",
@@ -225,8 +225,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,open-drain = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 			cam-i2c {
 				nvidia,pins = "cam_i2c_scl_pbb1",
@@ -235,8 +235,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,open-drain = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 			ddc-i2c {
 				nvidia,pins = "ddc_scl_pv4",
@@ -253,7 +253,7 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,open-drain = <1>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 
 			dsi-b {
diff --git a/arch/arm/dts/tegra30-asus-p1801-t.dts b/arch/arm/dts/tegra30-asus-p1801-t.dts
index 4b7b64b477b..58f1499cb92 100644
--- a/arch/arm/dts/tegra30-asus-p1801-t.dts
+++ b/arch/arm/dts/tegra30-asus-p1801-t.dts
@@ -108,8 +108,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* SDMMC3 pinmux */
@@ -193,7 +193,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			gen2_i2c {
 				nvidia,pins = "gen2_i2c_scl_pt5",
@@ -203,7 +203,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			cam_i2c {
 				nvidia,pins = "cam_i2c_scl_pbb1",
@@ -213,7 +213,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			ddc_i2c {
 				nvidia,pins = "ddc_scl_pv4",
@@ -222,7 +222,7 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			pwr_i2c {
 				nvidia,pins = "pwr_i2c_scl_pz6",
@@ -232,7 +232,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			hotplug_i2c {
 				nvidia,pins = "pu4";
@@ -250,7 +250,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			hdmi_hpd {
 				nvidia,pins = "hdmi_int_pn7";
@@ -622,8 +622,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* GPIO keys pinmux */
@@ -708,8 +708,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi_d10_pt2 {
 				nvidia,pins = "vi_d10_pt2",
@@ -828,8 +828,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi_mclk_pt1 {
 				nvidia,pins = "vi_mclk_pt1";
diff --git a/arch/arm/dts/tegra30-asus-tf600t.dts b/arch/arm/dts/tegra30-asus-tf600t.dts
index 3ddd78b3df6..1b5729c65f4 100644
--- a/arch/arm/dts/tegra30-asus-tf600t.dts
+++ b/arch/arm/dts/tegra30-asus-tf600t.dts
@@ -90,8 +90,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* SDMMC2 pinmux */
@@ -107,8 +107,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* SDMMC3 pinmux */
@@ -142,8 +142,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc4_cmd {
 				nvidia,pins = "sdmmc4_cmd_pt7",
@@ -159,8 +159,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc4_rst_n {
 				nvidia,pins = "sdmmc4_rst_n_pcc3";
@@ -186,7 +186,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			gen2_i2c {
 				nvidia,pins = "gen2_i2c_scl_pt5",
@@ -196,7 +196,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			cam_i2c {
 				nvidia,pins = "cam_i2c_scl_pbb1",
@@ -206,7 +206,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			ddc_i2c {
 				nvidia,pins = "ddc_scl_pv4",
@@ -215,7 +215,7 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			pwr_i2c {
 				nvidia,pins = "pwr_i2c_scl_pz6",
@@ -225,7 +225,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			hotplug_i2c {
 				nvidia,pins = "pu4";
@@ -243,7 +243,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			hdmi_hpd {
 				nvidia,pins = "hdmi_int_pn7";
@@ -613,8 +613,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* GPIO keys pinmux */
@@ -701,8 +701,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			pbb0 {
 				nvidia,pins = "pbb0";
@@ -827,8 +827,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi_mclk_pt1 {
 				nvidia,pins = "vi_mclk_pt1";
@@ -836,8 +836,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			jtag {
diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
index 03ba8fb9604..032fb3d00ac 100644
--- a/arch/arm/dts/tegra30-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -99,8 +99,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* SDMMC3 pinmux */
@@ -189,7 +189,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 
 			gen2_i2c {
@@ -200,7 +200,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 
 			cam_i2c {
@@ -211,7 +211,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 
 			ddc_i2c {
@@ -221,7 +221,7 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 
 			pwr_i2c {
@@ -232,7 +232,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 
 			hotplug_i2c {
@@ -647,8 +647,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* GPIO keys pinmux */
@@ -741,8 +741,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			vi_d10_pt2 {
@@ -879,8 +879,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			vi_mclk_pt1 {
diff --git a/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts b/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
index 9a1e8c0601e..876fac7b661 100644
--- a/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
+++ b/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
@@ -109,8 +109,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc4-cmd {
 				nvidia,pins = "sdmmc4_cmd_pt7",
@@ -127,8 +127,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			cam-mclk {
 				nvidia,pins = "cam_mclk_pcc0";
@@ -147,7 +147,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			gen2-i2c {
 				nvidia,pins = "gen2_i2c_scl_pt5",
@@ -157,7 +157,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			cam-i2c {
 				nvidia,pins = "cam_i2c_scl_pbb1",
@@ -167,7 +167,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			ddc-i2c {
 				nvidia,pins = "ddc_scl_pv4",
@@ -176,7 +176,7 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			pwr-i2c {
 				nvidia,pins = "pwr_i2c_scl_pz6",
@@ -186,7 +186,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* HDMI pinmux */
@@ -724,8 +724,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi-vsync-pd6 {
 				nvidia,pins = "vi_vsync_pd6",
@@ -736,8 +736,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <2>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_ENABLE>;
 			};
 			vi-hsync-pd7 {
 				nvidia,pins = "vi_hsync_pd7",
@@ -749,8 +749,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi-d2-pl0 {
 				nvidia,pins = "vi_d2_pl0",
@@ -760,8 +760,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi-mclk-pt1 {
 				nvidia,pins = "vi_mclk_pt1";
@@ -769,8 +769,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <2>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_ENABLE>;
 			};
 			vi-d11-pt3 {
 				nvidia,pins = "vi_d11_pt3";
@@ -778,8 +778,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi-d5-pl3 {
 				nvidia,pins = "vi_d5_pl3";
@@ -787,8 +787,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* PORT U */
diff --git a/arch/arm/dts/tegra30-microsoft-surface-rt.dts b/arch/arm/dts/tegra30-microsoft-surface-rt.dts
index 6810350a90b..2d22d3e0bb1 100644
--- a/arch/arm/dts/tegra30-microsoft-surface-rt.dts
+++ b/arch/arm/dts/tegra30-microsoft-surface-rt.dts
@@ -103,8 +103,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc4-cmd {
 				nvidia,pins = "sdmmc4_cmd_pt7",
@@ -121,8 +121,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			cam-mclk {
 				nvidia,pins = "cam_mclk_pcc0";
@@ -141,7 +141,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			gen2-i2c {
 				nvidia,pins = "gen2_i2c_scl_pt5",
@@ -151,7 +151,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			cam-i2c {
 				nvidia,pins = "cam_i2c_scl_pbb1",
@@ -161,7 +161,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			ddc-i2c {
 				nvidia,pins = "ddc_scl_pv4",
@@ -170,7 +170,7 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			pwr-i2c {
 				nvidia,pins = "pwr_i2c_scl_pz6",
@@ -180,7 +180,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* HDMI pinmux */
@@ -703,8 +703,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi-d3-pl1 {
 				nvidia,pins = "vi_d3_pl1";
@@ -712,8 +712,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi-hsync-pd7 {
 				nvidia,pins = "vi_hsync_pd7",
@@ -724,8 +724,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi-mclk-pt1 {
 				nvidia,pins = "vi_mclk_pt1";
@@ -733,8 +733,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 			vi-d11-pt3 {
 				nvidia,pins = "vi_d11_pt3";
@@ -742,8 +742,8 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,lock = <1>;
-				nvidia,io-reset = <1>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+				nvidia,io-reset = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* PORT U */
diff --git a/arch/arm/dts/tegra30-wexler-qc750.dts b/arch/arm/dts/tegra30-wexler-qc750.dts
index 87c2a4072e1..b376b91a7fa 100644
--- a/arch/arm/dts/tegra30-wexler-qc750.dts
+++ b/arch/arm/dts/tegra30-wexler-qc750.dts
@@ -157,7 +157,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			gen2-i2c {
 				nvidia,pins = "gen2_i2c_scl_pt5",
@@ -167,7 +167,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			cam-i2c {
 				nvidia,pins = "cam_i2c_scl_pbb1",
@@ -177,7 +177,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			ddc-i2c {
 				nvidia,pins = "ddc_scl_pv4",
@@ -186,7 +186,7 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			pwr-i2c {
 				nvidia,pins = "pwr_i2c_scl_pz6",
@@ -196,7 +196,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
-				nvidia,lock = <0>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 
 			/* HDMI pinmux */
-- 
2.43.0

