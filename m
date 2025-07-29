Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3493EC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76FC83045;
	Wed, 30 Jul 2025 07:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P/vDGa1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DF682BCD; Tue, 29 Jul 2025 14:51:18 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC14882063
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60c5b8ee2d9so11584379a12.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753793475; x=1754398275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kW+czL4QjPddpnAkQ+TzP3eik80nh1Sli2uxZTK9UI=;
 b=P/vDGa1HDGuLEl9ty4iMrM3QdMnua4/KNx795SNS85nE1xGhumeMnz1o6rNnj8XCvZ
 17VX9FguF5vKFQu/0LE7OqwqPL1GRQFJgNOxQI6QQyWvoLCsqKruaqy/R5d32koX8uj3
 FU/7Cjhwq9nfNLH0zHSw7OPRrJKxlUpwBbjr5VEraSqy2iZHEaX6RcB+LiSDxl+8UDIa
 WYMrIlaPVO3BzfPMxERZp0SwGvrHLpiwwZMeQrKRWdzw4/cwmU/Hst0KxQ2Xdgy3uQLz
 7xns28jl5Dg7vUPISUpTagFlYx/RpQG5fWjm8ie85hGOu1u/pXHGGclRbozcm1bqjJLM
 AhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753793475; x=1754398275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kW+czL4QjPddpnAkQ+TzP3eik80nh1Sli2uxZTK9UI=;
 b=asUVv9HNWiOU2joKbr6H+ld5aJXTmRmfN0pvQF+JJXn5wEjenDV5SdlpOvNbZZnlzO
 ngyzXqbJ4s/DkxryDOTpuKP3OZnw6Fgg8Gx0rA+HEn1y4yXzcfa8MqcirGBODS4DNAj0
 RrVIQ8FIIFtRfT4ncIWWAgy9j97LWNaDLbKG0Zt64vAH1kh7e7iCHfEryfbapqH+L6AZ
 m2ILA/y00D1Ljq999OGHyD+p3DhOF6CSLWkUNzmg3QwOkeuSGoSmlcbsL+nl+WpZqvvF
 w9kFwVRvE2BLVU6047NuJQl3la5IPxaKmNgT3yKnZIox+zUFT/DAP4OMvuYsH05I79Ab
 f55A==
X-Gm-Message-State: AOJu0YwoBb5qZ22RmkUqPtfKCKZtk/pEYxKpK8m8Hp6eEWZiYUNl99dR
 2TJ5ZwVFbchkDCotDYFJdJ1XxcooxrUd/4FmzgVx1+ZaP2ysw+4tojdU5e3lK9+R
X-Gm-Gg: ASbGncvyZ/mjHvLZcWpCSp0g5hPH/yi1whN87ZJ8fnzI011VpukqEL1aG8K06jIkX4q
 s37LAO1RDFR5TIYU6ItjtpwlhChAooM0BnJKzG5TJmofbFZTbMtOgs52ePUIxpWdeOKukIR2H3d
 Orxte+wYqL5kEBGYU2SXIis+PVIFL7uTbUm92Yxef7pEf4EfQmN3vt9ukzRhf1qryQbwEY0iK83
 78bqq1vbwj181GsgGNA43/H7SsxSB9XUZ5CTsgoOqpKmShKkh83pcMmr0j74/G5qxdMrdeavwEY
 SJZEw7WJNVESTGnU8ePCSj+gtStTKHW10uGm8vn243GluZ4LMej29QP8rr93KVn8kBKBqYrZ3Aj
 hkraaij/IcDWNBDTMRm9c1HEHvebXQZ0F/LtrTHrT61qFOQo3UJvdms63oA1iNYQVdM4Y15c=
X-Google-Smtp-Source: AGHT+IGoc7mdzA8VUs96udUR0rxqqZ9yVMkfan/PQY7WCwj4vYA8xiajXFRxnUmYF5u7y5OwpoO90A==
X-Received: by 2002:a17:907:3cc4:b0:ae0:b3cd:b7f8 with SMTP id
 a640c23a62f3a-af619608944mr1732636266b.40.1753793474880; 
 Tue, 29 Jul 2025 05:51:14 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635acc99esm572223366b.115.2025.07.29.05.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 05:51:14 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 3/5] arm: dts: k3-am6xx: Fix FIT image memory overlap in
 binman configurations
Date: Tue, 29 Jul 2025 12:48:54 +0000
Message-ID: <20250729125022.4220-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729125022.4220-1-aristo.chen@canonical.com>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 22 +++++++++----------
 arch/arm/dts/k3-am62a-sk-binman.dtsi          | 16 +++++++-------
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  6 ++---
 6 files changed, 49 insertions(+), 49 deletions(-)

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
index 9bcdf74ffe4..20e34398225 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -238,8 +238,8 @@
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
@@ -251,8 +251,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
+					load = <0x9ca20000>;
+					entry = <0x9ca20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
 					};
@@ -326,7 +326,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F002000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -341,7 +341,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -356,7 +356,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F006000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
@@ -428,8 +428,8 @@
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
@@ -441,8 +441,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
+					load = <0x9ca20000>;
+					entry = <0x9ca20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
 					};
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index 0685bdd7e0c..8f66b67681b 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -222,8 +222,8 @@
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
@@ -235,8 +235,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
+					load = <0x9ca20000>;
+					entry = <0x9ca20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
 					};
@@ -351,8 +351,8 @@
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
@@ -364,8 +364,8 @@
 					arch = "arm32";
 					compression = "none";
 					os = "tifsstub-gp";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
+					load = <0x9ca20000>;
+					entry = <0x9ca20000>;
 					blob-ext {
 						filename = "tifsstub.bin_gp";
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

