Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2131CAC594
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942F5835B0;
	Sun, 14 Sep 2025 15:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TD6IwM9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1567080B9B; Sun, 14 Sep 2025 13:01:18 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B247F81E13
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 13:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-331503fdc51so228808fac.0
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 04:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757847674; x=1758452474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIPsCF0t5vwYDxM+J1jv5TODW2SVpx7uoLqTi/ReN+8=;
 b=TD6IwM9n3vjwQVbwtCpJJWdK3DOi0gUhPnZLgUg04DUnrAvADd1nRyf/XfaU52aVYG
 /zhrSP7LSe/oO4pJAXiHFX1G4arrpNXjK5m2J3Jas6oyuJ7q/U0fQztPtNtsbMN8ojgD
 gKLcESPFTJ/wx07ozMG3LWshTriEdohniTvU9J/En0K1c9TFjJSUMcAmpdboEvp1G4Vz
 pH6QI2Xd58vjAJChv6iAOJI1MXWh4WjlIsP6/wJZ4nNwoQgjiWTSvhxJoJcy6Fc23WnD
 B/abgbJ4gKkhY2IC0qTbvmweRrZ8WCYG700tTWtUh8vrKDPYRuXATLWA9VBkauqllbea
 0QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757847674; x=1758452474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIPsCF0t5vwYDxM+J1jv5TODW2SVpx7uoLqTi/ReN+8=;
 b=LthD1PfsE5jhnhP5uqtTgqJeXjBhbTedTD2GuuD4yRjpFnbe8HC26uSq8zgBjKPFYg
 TiGYt1taonQKx+l9JEYgi21bHXN3RVCiLFB4tvoFO54WSFpCLF2uOrIzAmWIWO1TB+e4
 HADFGVX09IxGQTd3Sz7FmOytVOHAITEjYBpVjm69iq6O4NUJo1wkRp13QVDCflyKhtyZ
 ms9mFYqgA4QZSJHxH+nYyKOgrW9Vkz+oH0R/7TU8pbIfLmteb11zPhuTDqH2Fcza7m9V
 oFx+z8t12+Pv23c1vbdDetLRALF/rrk922d/4BK8NmpXVXNPMSEbEqvCZx/q0stL+BHx
 JSyg==
X-Gm-Message-State: AOJu0YynaqpJvaWLSOjVjcbRdf4tiuEZMnOb85dl2L7SEeqvASfhO46K
 KlEmYUZ0PW0JDppcqQIGY7URE+oRWLlUVVOJ8Clwz3ZrJRxTCLZbFtzJ9g6jKX42
X-Gm-Gg: ASbGncveUkWRDw3amMtgoQVPfI19GcwRWeKvxJ3Ll5RMp+cW19aZGA3NbLK31nK11xo
 sM9Rcvx+KirLLGo7KP5qdOWwC+WpOWuk0SmJu6Rkv7NJo8sql/hWxwPMdGVoEhT6YNBWYkj0wCh
 BEvtmJyWfEdwPL8u54xkNl4O6imET87sd6K2bSI2SHP1BkzQEE2y0NGwxdCYB2eKV34ApbU3n3K
 NcmUy09HidwSUngfMsRnJNBPIKNWteDVm4yIYKbdDybpfoEvK6h0ZcXr6PXo46TyO93tEw5LBTF
 oULsNiyC9uWvA8zUqrmX/gVH/1fReSkw/0PRCJn65ooZ4LYzKY8jOBt+p9LBf6K/pCGHALVRE+D
 KLz3+/60rzr3TYz9hXHBLCEMCWrfnHDoE6RoUnbhU6HUYsWZKnXlf7jgfOB9etNMOzXQT33qilr
 a352PwWw==
X-Google-Smtp-Source: AGHT+IFsjC51cOriuf9EUj75SryGsBdzjPZHkbw+VcrsamBHCoJF7N7AVjj7beukXpxUacGhsST+8g==
X-Received: by 2002:a05:6871:80f:b0:321:8f88:a3cb with SMTP id
 586e51a60fabf-32e567c66f7mr4670389fac.17.1757847674123; 
 Sun, 14 Sep 2025 04:01:14 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d32d56557sm2612720fac.1.2025.09.14.04.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 04:01:13 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 quentin.schulz@cherry.de, alice.guo@nxp.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 4/7] arm: dts: k3-am6xx: Fix FIT image memory overlap in
 binman configurations
Date: Sun, 14 Sep 2025 10:59:29 +0000
Message-ID: <20250914110021.4103-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

Fix memory overlaps in FIT image configurations for TI AM62x and AM64x
PHYCore and SK boards.

The overlaps occurred in two categories:

1. TI firmware stub images (tifsstub-hs, tifsstub-fs, tifsstub-gp):
   These mutually exclusive firmware variants were incorrectly assigned
   the same load address within FIT configurations, causing overlap
   detection to fail. Adjust addresses with 64KB spacing:
   - tifsstub-hs: Keep original address
   - tifsstub-fs: Move to +64KB offset
   - tifsstub-gp: Move to +128KB offset

2. Device tree overlay images (som-no-rtc, som-no-spi, som-no-eth):
   These overlay files had insufficient spacing between load addresses,
   causing actual memory overlaps. Increase spacing to 8KB boundaries
   to accommodate overlay sizes safely.

An upcoming commit will validate if the memory region is overlapped

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 22 +++++++++----------
 arch/arm/dts/k3-am625-sk-binman.dtsi          | 16 +++++++-------
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 16 +++++++-------
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 10 ++++-----
 arch/arm/dts/k3-am62a-sk-binman.dtsi          |  4 ++--
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  6 ++---
 6 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index a9bd5a2be84..4344cefeba3 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -234,8 +234,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc10000>;
+					entry = <0x9dc10000>;
 					blob-ext {
 						filename = "tifsstub.bin_fs";
 					};
@@ -247,8 +247,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc20000>;
+					entry = <0x9dc20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
 					};
@@ -322,7 +322,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F002000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -337,7 +337,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -352,7 +352,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F006000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
@@ -479,8 +479,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc10000>;
+					entry = <0x9dc10000>;
 					blob-ext {
 						filename = "tifsstub.bin_fs";
 					};
@@ -492,8 +492,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc20000>;
+					entry = <0x9dc20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
 					};
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index f743c4353b4..1619f733a0d 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -231,8 +231,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc10000>;
+					entry = <0x9dc10000>;
 					blob-ext {
 						filename = "tifsstub.bin_fs";
 					};
@@ -244,8 +244,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc20000>;
+					entry = <0x9dc20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
 					};
@@ -362,8 +362,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc10000>;
+					entry = <0x9dc10000>;
 					blob-ext {
 						filename = "tifsstub.bin_fs";
 					};
@@ -375,8 +375,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc20000>;
+					entry = <0x9dc20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
 					};
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 65fef6e4790..6c4ad72d936 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -219,8 +219,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc10000>;
+					entry = <0x9dc10000>;
 					blob-ext {
 						filename = "tifsstub.bin_fs";
 					};
@@ -232,8 +232,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc20000>;
+					entry = <0x9dc20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
 					};
@@ -346,8 +346,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc10000>;
+					entry = <0x9dc10000>;
 					blob-ext {
 						filename = "tifsstub.bin_fs";
 					};
@@ -359,8 +359,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
+					load = <0x9dc20000>;
+					entry = <0x9dc20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
 					};
diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index a284226320c..786c7a2d458 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -184,8 +184,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-fs";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
+					load = <0x9ca10000>;
+					entry = <0x9ca10000>;
 					blob-ext {
 						filename = "tifsstub.bin_fs";
 					};
@@ -260,7 +260,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F002000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -275,7 +275,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -290,7 +290,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F006000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index e64c165ecbf..214acd7f0f7 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -168,8 +168,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-fs";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
+					load = <0x9ca10000>;
+					entry = <0x9ca10000>;
 					blob-ext {
 						filename = "tifsstub.bin_fs";
 					};
diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 966905bd64d..59d8902bf48 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -371,7 +371,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F002000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -386,7 +386,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -401,7 +401,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F006000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
-- 
2.43.0

