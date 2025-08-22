Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BB3CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 23:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3350D83096;
	Sat, 23 Aug 2025 01:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gGsragP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF3A382F8F; Sat, 23 Aug 2025 01:29:53 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E677B82C84
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 01:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e2bdso577903f8f.2
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755905391; x=1756510191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WXBUEB0LirF/I3UPx0hbAgBVKDK3rlA7I8W1oaESloY=;
 b=gGsragP+hLuQw4xQ2t0zfAjzsI1ykAM75vSNumMwdNDfUrQk4kiMoNZdfgCrLSdmaQ
 0IO43lNI4kNUbOS6sQu87okmZnkX4q5QlobcLg/LN01yIrwdB5hhrH1zbEP7YgVTkKCT
 /nh4QCBdHcnf/j4urcDPzZ4P0zyUSUDpoYAo6zC0ImMn9+vftuKPYGks98QP63SwWtUN
 uubkuSffXmXarJmD+rmq39Egsmh7KgoQSbHmUJin2v59PEm17PPZVwDxb3xIs9orFNbe
 GQwtzoOA5Do5VGWNd6D9DgA6NuSW8eHJ644ombYlqVEc3UZIes9EXg8aY2AsJPDeW9bK
 XJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755905391; x=1756510191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXBUEB0LirF/I3UPx0hbAgBVKDK3rlA7I8W1oaESloY=;
 b=JeATixugK3rQRqs/BREVFg5CPxpZGHhf/4Zlrdz9m02uAQlnhH+oGPC7Aa7icn654j
 49j/uClHUm+iNK7zo3Xfu4gBPHGlozbL6GR4EFhyz4P1KuGcB+oWLSNQV93NN0V87zLn
 KVDGidOhFSY5BzjlG5WDzASGC3SVjGpqj55avoM0fBTZqUP5Nju/9THZau8/9TakTJBi
 gIyOKwZUlR9yEMBSCBYB+XMEULIDTSGKPgEFzIduQCb/Or0SOXoRtVY+jyZ8u62TfR3M
 MsIs4u7a6+U0TRVkMi574t2LB40/vTYxetEz5Qbrpuk1siE1tFGEFnJ9wG+DVZnPxlJ2
 sgLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEWEkpKNRL3vfTfAA57gIKTGx30B8fwISrrXTbHHC6Q30xBnf2K+CETDilX9v00k/km9IBoTQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzUmTDbnzA13RnrQNiUYY9IHT/+KrLCn3tRIcuAkZ1PLJUvzQlk
 Y6SeGTTLAmwhRsZTrd02HbsuYGNiDLoVvZcAGyHy6J18CzjDCg13Zl0Z
X-Gm-Gg: ASbGncv6nCK+3i2IM3xoPjiJtJolPrdr8pLRNjyJkhU77ACUYGYUz7SBYEuDcBH4smx
 Lu59zOKXHKd4KmhjpBO2Cd4Zxo04h8uHWsvLjRY4CGj8BDmn3NW24Y6d6PxA7l/jfIk/onl+6DJ
 hd4EyBru4v1+31IiQkh6NEHdDW1Jd8dG/CIA0LigZhisx7wukLvV4MPjK1fDh0aTqQ6cL+ZoxUl
 1v0NNd+ulo7u77/iii/GLlrF6EBDPAUXSrGqpl2I9OAgu+rBrVcy8M4TjBVLI/pHuYxEzBkPLog
 DQbN09TZwK1YT2Deu2n07ABB1pcrHlKQ3nIncIUO2tIgVeS9VP3i4qOqIGE2z4accNE5f15LREx
 lQE5CIQfBmZ4OYrOOGqei/cccxOLAGseZ/qfXzMyFJy/ERxVYppsxi8euqTurbwOVidUsV7g=
X-Google-Smtp-Source: AGHT+IELC0ffncB4GBrbIUWOOp/bTFdYZlAQXu4wQ5GuSOkG2v6P71oZeRk4LBBgKXZARDzFcLTsVg==
X-Received: by 2002:a05:6000:2288:b0:3b7:8880:181a with SMTP id
 ffacd0b85a97d-3c5dac16ee7mr3650606f8f.13.1755905391138; 
 Fri, 22 Aug 2025 16:29:51 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-251-209-58.retail.telecomitalia.it.
 [95.251.209.58]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1483sm1216970f8f.50.2025.08.22.16.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 16:29:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Subject: [RFC PATCH 5/5] airoha: add PCS node for AN7581
Date: Sat, 23 Aug 2025 01:29:19 +0200
Message-ID: <20250822232921.30076-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822232921.30076-1-ansuelsmth@gmail.com>
References: <20250822232921.30076-1-ansuelsmth@gmail.com>
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

Add PCS node for Airoha AN7581 SoC to enable support for Serdes Ethernet
and PON port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi     | 71 +++++++++++++++++++++++++++++
 arch/arm/dts/en7581-evb-u-boot.dtsi | 18 ++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index a9297ca6503..9ee0f808660 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -35,6 +35,48 @@
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
 
+		pon_pcs: pcs@1fa08000 {
+			compatible = "airoha,an7581-pcs-pon";
+			reg = <0x0 0x1fa08000 0x0 0x1000>,
+			      <0x0 0x1fa80000 0x0 0x60>,
+			      <0x0 0x1fa80a00 0x0 0x164>,
+			      <0x0 0x1fa84000 0x0 0x450>,
+			      <0x0 0x1fa85900 0x0 0x338>,
+			      <0x0 0x1fa86000 0x0 0x300>,
+			      <0x0 0x1fa8a000 0x0 0x1000>,
+			      <0x0 0x1fa8b000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk EN7581_XPON_MAC_RST>,
+				 <&scuclk EN7581_XPON_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
+		eth_pcs: pcs@1fa09000 {
+			compatible = "airoha,an7581-pcs-eth";
+			reg = <0x0 0x1fa09000 0x0 0x1000>,
+			      <0x0 0x1fa70000 0x0 0x60>,
+			      <0x0 0x1fa70a00 0x0 0x164>,
+			      <0x0 0x1fa74000 0x0 0x450>,
+			      <0x0 0x1fa75900 0x0 0x338>,
+			      <0x0 0x1fa76000 0x0 0x300>,
+			      <0x0 0x1fa7a000 0x0 0x1000>,
+			      <0x0 0x1fa7b000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk EN7581_XSI_MAC_RST>,
+				 <&scuclk EN7581_XSI_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
 		eth: ethernet@1fb50000 {
 			compatible = "airoha,en7581-eth";
 			reg = <0 0x1fb50000 0 0x2600>,
@@ -52,6 +94,35 @@
 			reset-names = "fe", "pdma", "qdma",
 				      "hsi0-mac", "hsi1-mac", "hsi-mac",
 				      "xfp-mac";
+
+			gdm1: ethernet@1 {
+				compatible = "airoha,eth-mac";
+				reg = <1>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <10000>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			gdm2: ethernet@2 {
+				compatible = "airoha,eth-mac";
+				reg = <2>;
+				pcs = <&pon_pcs>;
+
+				status = "disabled";
+			};
+
+			gdm4: ethernet@4 {
+				compatible = "airoha,eth-mac";
+				reg = <4>;
+				pcs = <&eth_pcs>;
+
+				status = "disabled";
+			};
 		};
 
 		switch: switch@1fb58000 {
diff --git a/arch/arm/dts/en7581-evb-u-boot.dtsi b/arch/arm/dts/en7581-evb-u-boot.dtsi
index ebd3b8b4958..6b084e3defe 100644
--- a/arch/arm/dts/en7581-evb-u-boot.dtsi
+++ b/arch/arm/dts/en7581-evb-u-boot.dtsi
@@ -9,3 +9,21 @@
 };
 
 #include "an7581-u-boot.dtsi"
+
+&gdm1 {
+	status = "okay";
+};
+
+&gdm2 {
+	// status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+};
+
+&gdm4 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+};
-- 
2.50.0

