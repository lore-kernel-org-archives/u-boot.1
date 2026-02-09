Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF4CE7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7466483C5E;
	Mon,  9 Feb 2026 18:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hQCBapcF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117BC83C91; Mon,  9 Feb 2026 18:27:29 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9CE383C23
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45e934bb51dso1252118b6e.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770658045; x=1771262845;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zCH6+ZN3h8EPAnjdprlDXWTk7BeaRAekVt7Qi7L586Y=;
 b=hQCBapcF2V8WSWu8swBuBEQPEoaleF/k0sh7Xq94miMPabBjbflrHGq9T7cFSIKhQ/
 /IHpRSQup78LnV/Q1TWF0wD5JcgSxrluLAZi3/UDRyrQWC20szMQYb7MKa6MdA4dqSId
 izP033iJk4PGtDVuXlGvd5xlx12wyXX3xR6xgzjZjYitL0VKOW2cPDJDDD7QRPVeEmW/
 WAPEMWmPhIstUQOCZEUKnhsJeFY9MahYsII63F84BV4RoiV82XqTgScBlXJF4Fww0ctO
 NDTSZiM6EnBgWc9jtzSR9thzkGPHXFx26Q7VfYl37+TlFBDlwxCZi30m/76YKY+9Aowm
 lYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770658045; x=1771262845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zCH6+ZN3h8EPAnjdprlDXWTk7BeaRAekVt7Qi7L586Y=;
 b=iZXVOlYhDvMDrCvj54wz7i4TYUtxzn2lwf9qsIOTZN6aQVS9ZG18UAmzk0dm0po4eS
 S4Xdj+3mZsk94+ObQvZj9HDSRXo4TTbWaYwOZ/Af0boZxg/WdAVv2pWCKWpCSQhpBr5D
 U6Q3eu/X8PNyZvxwxyoj7IsGmfyeGnQN1416g9r7QagT8f24mwr8PJ9gVRamZmDdUR5r
 V7UgKFp57qBLairX4/83Io+bgQM96qDztGIkq7tyqeS3IFbaY6yOMQhFw8rTZdbZi1JJ
 WmrrfJyyT8U923AmwJJabp4eOk+PxuUGHtDb3n7sr+yj5aQ+3qWuxroDMnRm0WMCuPsC
 1ryA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZoy6PlaSL1aFtcvBQTxK49bDSgTPBE5PjDyu/+qSxboWaGxam7bBolyqAWL6NuSuTZTstXbY=@lists.denx.de
X-Gm-Message-State: AOJu0YwgeaKP9CS+AUJOlG09oP5Ukyk69q47cuP6osAFY35MBBqwCChF
 hK/C6r8/BhqpOEDCnCp3wApRhAGhpETICFY0OI3MfHt/wBTq5NXHOQt07J8ufyQmsi4=
X-Gm-Gg: AZuq6aJIKtOrxWedNTJHclJ4KsYY5zjFU2VMlZVcf15vV1ufhm7Gk/uhnaUqY1SxBCa
 adRI5ZtxX7B7Gg9XoyJu3lvKl9RxcYKyQR9pho83jnbO9oTD3iNhNoahHU3IzFxGaeBqLmKJvGi
 pYo6irSdnAZzLVbT/YXk3Th1afr8cyKw+wtxhASx5PaV/Qpg+f8ASeC3E5hXGVqelvrZQDRvVEY
 sBNLZq6+LGO9lVM+VQOppAABdm3Hnqbr8kBm5dbucNQpq+hK2xTsplWN2G0SDpkJGd4vT530qjK
 zjqmbVwETd/V26I+++227EoX6/enqpQzdJt93rcbXIoYNBNHPLKDd4C2VoDOhf/eP2EA0fOtk2M
 Uzq3EPpAfOyNSfD/zPVtWC3GzNZS9ytUoFSZjBuyymP9N0jpeX51rT3v8boHyN9nmTNFskoK6Jr
 3T2zHl7Aqo4Z/Gzi4=
X-Received: by 2002:a05:6808:7003:b0:462:aa0f:436d with SMTP id
 5614622812f47-462fca1e91bmr5917877b6e.1.1770658045599; 
 Mon, 09 Feb 2026 09:27:25 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-462fe9de7ecsm6695383b6e.9.2026.02.09.09.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:27:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 11:26:56 -0600
Subject: [PATCH 2/2] arm: dts: mt7622: Use generic node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-dtb-fix-spi-bus-bridge-warning-v1-2-84e3e2d8352d@baylibre.com>
References: <20260209-mtk-dtb-fix-spi-bus-bridge-warning-v1-0-84e3e2d8352d@baylibre.com>
In-Reply-To: <20260209-mtk-dtb-fix-spi-bus-bridge-warning-v1-0-84e3e2d8352d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2810; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EDBMuB5cLHg1zlIJYy4bRtJUWtxsYrUCcCfNwI4qRTc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpihjy9iUsrR5kd4SNMucCaqGFln7Ex+3Hhmxmg
 kBKH5TLtaqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoY8hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACtMH/1toxpG6Mn2PEBDQNGbjzeaePJK6qcS0pRyxP8O
 EvYxO98HIW3ejsVsS1UIoRwMznxwwUGrkTvmcNgtfmrLeY1agYfi52/p2VRtUfM2P3aZcH7eDor
 rv2vTLQVez+3IuXK8zuh+LqIYCum59rjmwlv7Ia+KWPDY1OzOA4C9Vit22VTU0vKHrxViO+RO3B
 TPtDY3puvrJaISbYH4kRfJx61c6ixzxKw2i/O9/VaMlTHBpR/GuLDoSWtKzML1VhuDhdknwD1M3
 hOHINHywYoGyDoyORlW6jcKHXrqmM07BfJolxBJ2H/j+Fnai43CFjQuwqYdXNwhRJ8xaPCrYphH
 59U8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:38:26 +0100
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

Replace node names in mt7622.dtsi with generic names. This makes it more
consistent with the upstream bindings.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt7622.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/mt7622.dtsi b/arch/arm/dts/mt7622.dtsi
index 12c501711bb..d75a4e4be87 100644
--- a/arch/arm/dts/mt7622.dtsi
+++ b/arch/arm/dts/mt7622.dtsi
@@ -37,7 +37,7 @@
 		};
 	};
 
-	snfi: snfi@1100d000 {
+	snfi: spi@1100d000 {
 		compatible = "mediatek,mtk-snfi-spi";
 		reg = <0x1100d000 0x2000>;
 		clocks = <&pericfg CLK_PERI_NFI_PD>,
@@ -86,7 +86,7 @@
 		clock-names = "system-clk";
 	};
 
-	infracfg: infracfg@10000000 {
+	infracfg: clock-controller@10000000 {
 		compatible = "mediatek,mt7622-infracfg",
 			     "syscon";
 		reg = <0x10000000 0x1000>;
@@ -94,13 +94,13 @@
 		#reset-cells = <1>;
 	};
 
-	pericfg: pericfg@10002000 {
+	pericfg: clock-controller@10002000 {
 		compatible = "mediatek,mt7622-pericfg", "syscon";
 		reg = <0x10002000 0x1000>;
 		#clock-cells = <1>;
 	};
 
-	scpsys: scpsys@10006000 {
+	scpsys: power-controller@10006000 {
 		compatible = "mediatek,mt7622-scpsys",
 			     "syscon";
 		#power-domain-cells = <1>;
@@ -122,13 +122,13 @@
 		interrupt-parent = <&gic>;
 	};
 
-	apmixedsys: apmixedsys@10209000 {
+	apmixedsys: clock-controller@10209000 {
 		compatible = "mediatek,mt7622-apmixedsys";
 		reg = <0x10209000 0x1000>;
 		#clock-cells = <1>;
 	};
 
-	topckgen: topckgen@10210000 {
+	topckgen: clock-controller@10210000 {
 		compatible = "mediatek,mt7622-topckgen";
 		reg = <0x10210000 0x1000>;
 		#clock-cells = <1>;
@@ -198,7 +198,7 @@
 		status = "disabled";
 	};
 
-	ssusbsys: ssusbsys@1a000000 {
+	ssusbsys: clock-controller@1a000000 {
 		compatible = "mediatek,mt7622-ssusbsys",
 			     "syscon";
 		reg = <0x1a000000 0x1000>;
@@ -206,7 +206,7 @@
 		#reset-cells = <1>;
 	};
 
-	pciesys: pciesys@1a100800 {
+	pciesys: clock-controller@1a100800 {
 		compatible = "mediatek,mt7622-pciesys", "syscon";
 		reg = <0x1a100800 0x1000>;
 		#clock-cells = <1>;
@@ -364,7 +364,7 @@
 		};
 	};
 
-	ethsys: syscon@1b000000 {
+	ethsys: clock-controller@1b000000 {
 		compatible = "mediatek,mt7622-ethsys", "syscon";
 		reg = <0x1b000000 0x1000>;
 		#clock-cells = <1>;
@@ -399,7 +399,7 @@
 		status = "disabled";
 	};
 
-	sgmiisys: sgmiisys@1b128000 {
+	sgmiisys: syscon@1b128000 {
 		compatible = "mediatek,mt7622-sgmiisys", "syscon";
 		reg = <0x1b128000 0x3000>;
 		#clock-cells = <1>;
@@ -424,7 +424,7 @@
 		status = "disabled";
 	};
 
-	soft_i2c: soft_i2c@0 {
+	soft_i2c: i2c@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";

-- 
2.43.0

