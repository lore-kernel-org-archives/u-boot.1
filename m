Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2193BC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB6782F49;
	Mon, 23 Jun 2025 14:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NM7pfSoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A944582D4A; Mon, 23 Jun 2025 14:10:45 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C6781E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so7900149a12.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680642; x=1751285442;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sMFQNEbTRrOlDeFyTklH47opipT5vlJJCDCM4P08OZo=;
 b=NM7pfSoCNIaLVqR8oDGiCR19X+hxpaWA0o9HM5dIPxa5M7PdJyBy9gxjD6E3VIm/z6
 HvoHi7hxa6csKys+C9XVY3zbENUS/J2YbOH9Q0sOnl2DP7tOWm59buy0+e+yIYMgrIXl
 rfNrrdo8qLcOGuWIzy5ON0lmfE6Vb1NNl2ipV+1HlAxlDKgJoXCmEEemSYMay26g8uZB
 GPSU6oqfr/d/3a3qhElLn7eRSggnbqMM0HSGfZPItr0O9/1DI0lT+L32X+gj40C9w8vK
 DueMeEWjlY3jgmZylY+6+oK6kEKEZYu3AVgCIm9L1iHpOzEjaJhD2VWDLDBzWTmd+QzR
 Y7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680642; x=1751285442;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sMFQNEbTRrOlDeFyTklH47opipT5vlJJCDCM4P08OZo=;
 b=JHmfKNgYHAlHumuoevakh0a5TsIfpKfa1ZwSRvgURQdaOIMRYN6pCo1PF7QpWMYwpQ
 cVxNQV5H7BS1aK1TEUTeIBvi9TcmEcaB0eAFMaXBz0q3GZce5bO08vQCTm//TCDVWFxu
 +X5LBhpawK2rjYWnGYsRP2/zR108IRo6iJCDXVPumS/OIhOugxPaIIvBA0tpnLutBOjv
 EAt+pNRZXtY2nkEADWK9yVeO2HeDt3aHbd0wlMHgoizK/eOSgSoFUsv/IxAVz44nlhyo
 8SuUstUYPviVIOsOIZzbE9XXV3288npxTytNWVGJXh7NZGl+hPL90VHQxZ/SbyOfwz+G
 zVIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8y1EzVFWUm8ii+shAoWDtJigd5oUwykuAAjlX9Yspb6bQRLd9utyeOQrbASnVnFgTrM4JMuw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/T0zZ8tTt+3O9r0p5lZDZB/S1QRfhyWWn8vo05gkiYaqzSIQG
 7UjLUw64wTd5b2FZFxWpBwlmWIUsRShWCJd0cqwIU/OPdgBltBQ0yQWLZR8esGt/yJo=
X-Gm-Gg: ASbGncup47QxLwNKq2ZsVV0uqOcn666YXTg0j42auGtME10fpQkIGzNoRmryn2KuM6U
 WJooPQXCA8hAEfL3kLnv7Md/gDG6iZBrmyVl/eknyqt9pxmonCy4GIbgKzx2+j/itaHtVNfGzyb
 JPLydrOAoklT/Gac/0HuuHd//sRu+ApgpYc1FOwMmpUsDF+MD+Y1v4bH4iMPeWqWoFHX8mYBSix
 2RVGoZd8Kx1smx4LQIHpMz2f0FVf4DZ4FfEZUffVyQZgsdaSg+1I8xUfqBepabB1IkG2XmI57Nt
 LX/4zjrtO+oRaUK5h7JK+8QZngRNAM8vMG5wiSdAs+dDWU8u1Z4LC8MU6gM=
X-Google-Smtp-Source: AGHT+IE0Ah69I7r4Z1Kpk3kO65zZPzlasQzNxyyAUUytZZbu6KJFEW8Q5zTq9yDe0jwKYks6j1EKmQ==
X-Received: by 2002:a17:907:6088:b0:ad5:72d4:85ee with SMTP id
 a640c23a62f3a-ae057b984bamr1202995766b.53.1750680642359; 
 Mon, 23 Jun 2025 05:10:42 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae053e7f286sm709515666b.19.2025.06.23.05.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:41 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:35 +0200
Subject: [PATCH v3 12/22] arm64: dts: ti: k3-am6*: Remove disable-wp for eMMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-12-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6105; i=msp@baylibre.com;
 h=from:subject:message-id; bh=aa9dYvG40B73gp0scSBe2AApZCImrN89cFDWlSmzAu4=;
 b=kA0DAAoWhcFWaZAVSlMByyZiAGhZQ/ijPT2TeXIkOb4XmPWUwK/1jiMFk4sw/kxC49Z8HdTBf
 Yh1BAAWCgAdFiEEiWFVZv8fucZjoqazhcFWaZAVSlMFAmhZQ/gACgkQhcFWaZAVSlOz+QEA/MLY
 xiZ6/EWjcOvAIMlOM5XzMwLhR7zIBEXzkUya/HkA/irmJNFjQn1yCEq1k5gO3yVPIKaJEeXsNyq
 aL+Ls1y4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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

From: Judith Mendez <jm@ti.com>

Remove disable-wp flag for eMMC nodes since this flag is
only applicable to SD according to the binding doc
(mmc/mmc-controller-common.yaml).

For eMMC, this flag should be ignored but lets remove
anyways to cleanup sdhci nodes.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429151454.4160506-4-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: ef839ba8142f14513ba396a033110526b7008096 ]

(cherry picked from commit 9bd6216a75f9f2be497b6f66fcfcbd75b685e92a)
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi               | 1 -
 dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts                | 1 -
 dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi              | 1 -
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts                       | 1 -
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts                       | 1 -
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi                | 1 -
 dts/upstream/src/arm64/ti/k3-am642-evm.dts                       | 1 -
 dts/upstream/src/arm64/ti/k3-am654-base-board.dts                | 1 -
 dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi | 1 -
 dts/upstream/src/arm64/ti/k3-am69-sk.dts                         | 1 -
 10 files changed, 10 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi
index 55ed418c023bc1f03a04514d12a0950ee9f498bb..e5be92aa121891d167a0e29713aca3434f32657c 100644
--- a/dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi
@@ -381,7 +381,6 @@
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	non-removable;
 	bootph-all;
 	status = "okay";
diff --git a/dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts b/dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts
index a5469f2712f0945d5717d9570767fedf2681013a..91c50ff8d5d0c2d188d68e8ccaeaf256a150b7ae 100644
--- a/dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts
+++ b/dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts
@@ -834,7 +834,6 @@
 	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
-	disable-wp;
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
index 147d56b879843ec832d0849e6ed877aa83a72229..0d4115590b9c3d2f92140521e99a6ff8440e398f 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
@@ -338,7 +338,6 @@
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	non-removable;
 	bootph-all;
 	status = "okay";
diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index 22be41d46eb519917516fba5f2439bdb492c46f4..c65ada5a22abbd88a70e81703c28b7b83461c6c8 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -634,7 +634,6 @@
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
index d29f524600af017af607e2cb6122d3a581575ffc..7cc730e27ce69dc30feb97d68c9cec88b553a4bd 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
@@ -455,7 +455,6 @@
 &sdhci0 {
 	status = "okay";
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
index d52cb2a5a589a8e5eb325fd90324d57ec1e3783b..17f97434b91ae8c9e46da872e0a08a60ec4fbc0c 100644
--- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
@@ -436,7 +436,6 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 };
 
 &sdhci1 {
diff --git a/dts/upstream/src/arm64/ti/k3-am642-evm.dts b/dts/upstream/src/arm64/ti/k3-am642-evm.dts
index f8ec40523254ba1ee9b0bec7c00541dceef25526..5c6197ba842e4e1c604d3063d25b7f99c274057f 100644
--- a/dts/upstream/src/arm64/ti/k3-am642-evm.dts
+++ b/dts/upstream/src/arm64/ti/k3-am642-evm.dts
@@ -597,7 +597,6 @@
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am654-base-board.dts b/dts/upstream/src/arm64/ti/k3-am654-base-board.dts
index aa7139cc8a92b44fe94b556d392038edf6e9f35e..c30425960398ebb75ebda44726ed90cd78947d58 100644
--- a/dts/upstream/src/arm64/ti/k3-am654-base-board.dts
+++ b/dts/upstream/src/arm64/ti/k3-am654-base-board.dts
@@ -456,7 +456,6 @@
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 /*
diff --git a/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi b/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi
index ae842b85b70de0b0524e9429f4e1c338c5425d40..12af6cb7f65cfb5045e756080f3970971101f18e 100644
--- a/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -50,5 +50,4 @@
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
diff --git a/dts/upstream/src/arm64/ti/k3-am69-sk.dts b/dts/upstream/src/arm64/ti/k3-am69-sk.dts
index b85227052f97eab2ac22e95d30ec3f6bfde85c0d..f28375629739cbb76567a805d9655a1cd19d4d83 100644
--- a/dts/upstream/src/arm64/ti/k3-am69-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am69-sk.dts
@@ -940,7 +940,6 @@
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 &main_sdhci1 {

-- 
2.49.0

