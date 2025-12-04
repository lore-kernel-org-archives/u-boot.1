Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46565D1F9DE
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5CD7840C1;
	Thu,  4 Dec 2025 13:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OtrwozQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E1D84008; Thu,  4 Dec 2025 11:26:46 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E438401A
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b73161849e1so161454966b.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764843999; x=1765448799;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SNLYqFgxoj+PbtqFSfm8xLZswKrOgX0Jjtwg8lCL0Uo=;
 b=OtrwozQKRRtoAJzP4lXWmFtZpllnn/G61I9Jtdugp4FjYhc4he5IjhTmG1PSSHJj/I
 uer+U4S39/l3K5wC1r3uLGZAKDhSmyAQ6IKmL9D3az6xvangXScgySG2NxP2k06heExK
 +W3D7GJvjEPGGVjYDhiKyhjGdTufs1x+aZ7b3Ql1BATeq1SpvyASmlmc1lmrZtN8IZs/
 SizhtpCY/Z4VbWgTc0/PpWQXXJSYmnWN3M/6Veif1Tg16wGeGB2QfF+YqFWq4cW0akCW
 ryfN6JTT7TCqYl56xboLZN1k6fY5fsWDVeRwUcqA6QkbGTO0blcXgqv1VA86o41o1woF
 EEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764843999; x=1765448799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SNLYqFgxoj+PbtqFSfm8xLZswKrOgX0Jjtwg8lCL0Uo=;
 b=NkuzLguqcB1wVDYHxD9zSzE7p9bAL5flI3VUeR5vM3oAYtKxKnzbvBBnUGSMasQXHG
 oSj1yZrnSDfbfkoSMzhBWTicq1Rtv2+jhp0d1ZtdW8VUjTNIaKSBb7eJLe3kbciV/VVG
 FOo8UQveEW3SKhKxzyiLJUxxvUjYsPp5qHyyADL2sCj4PRjU0kGl4sJWvipKxNRcFRuo
 N3z3ukF2SjPhO5f0rU0pOOmzRnZwd9A0+m7/XPo20OHgzuc7L0RAWACXE+9S2AIeFsjc
 ZASk5nwkpEOBGfA9A/qSqWODbCFgoNXtd3YA9+4yC3Pso7VcMWMsyrSnL90NCUBZAkBf
 uFBA==
X-Gm-Message-State: AOJu0Yzr06QcTTogkO2V18r+aOy/tjMZ5B0cpzBvUlr2wxNV/CF13G/U
 Y7vxzW3SVnN3iHhPpxPBu2Om89iwECoDS2czsfPMnYrWPWtsp0hkN54o/EuFtkQtuQo=
X-Gm-Gg: ASbGncu0zuNrdLswHUIzgEFC2H4+7tQOjEuWOIMtCG4sPRyiKA50zKJAwI4zL0Hh+ld
 ERYR0jwN2sYaeEMACwtipgWtUCDg8ahPQnBxX7R73hnuFe4HsBF0IwsfZ4e/Ok6IOIo5wQtVVx7
 azhBe/k6oPwPNYX62Xlozt22RWHHQOSkKGxVkySww6XCAHixrjdFGUWNi4H96zDnQsatv7HnYE7
 PirreAwTev/YyPjV4FWGcBO7MNc3Tx/JWhTSwW12KZjM4mIqlxeHRTzMdaNy6Lz42nRmI60XP5D
 gnoPdlzeXVuh1PTA/YLuZemM9h2Yg4rMXVEIxZTegtlqAcSdFh1Pgzay0f+6U7eDiDUMgzTEIYu
 iXu423M6tOu5y4z+SH2B89mAWShZ24WiSrACIWeWwWbbVRLASY4WIm3F1di6kzLa16zaW/MGWWo
 7w4ntQK60=
X-Google-Smtp-Source: AGHT+IEIw+4kbMopPQkNKmQD3Xb89wQopDxXaKvUr/SXE+ozj93ZWYrawcm1iVFLVNzygwDXvbwpeA==
X-Received: by 2002:a17:907:608c:b0:b71:cec2:d54 with SMTP id
 a640c23a62f3a-b79dc77817amr597848266b.57.1764843999174; 
 Thu, 04 Dec 2025 02:26:39 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4a2f19dsm93590266b.64.2025.12.04.02.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:38 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 11:25:42 +0100
Subject: [PATCH v3 6/9] arm: dts: am335x-*-u-boot: Add chosen tick-timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-6-3d1566ce4dc7@baylibre.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5056; i=msp@baylibre.com;
 h=from:subject:message-id; bh=6C1L7mQBvWGLAFTeO8xDWr5/MsA9cQZpFewpgZDcBQI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxMMHO+b06c8Q4GTt2zTRIHDyXWvvj16xXOavtL7NN
 1owffP3jlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhIgCbD/zin1s8Fqlciir5H
 iO6TdC3MeHS9hsko1U1hVoFlib3LYUaG3vnLfjOWHjk72cJZ3kvK0unr1aL3TN3Wif7WvFYvnn/
 nBAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

Upstream devicetrees do not have a binding for the tick-timer. Add it
for all boards built with the am335x_evm_defconfig.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/am335x-bone-common-u-boot.dtsi                | 14 ++++++++++++++
 arch/arm/dts/am335x-bone-u-boot.dtsi                       |  6 ++++++
 arch/arm/dts/am335x-boneblack-u-boot.dtsi                  |  6 ++++++
 arch/arm/dts/am335x-bonegreen-u-boot.dtsi                  |  6 ++++++
 arch/arm/dts/am335x-evm-u-boot.dtsi                        |  6 ++++++
 arch/arm/dts/am335x-evmsk-u-boot.dtsi                      |  6 ++++++
 arch/arm/dts/am335x-icev2-u-boot.dtsi                      |  4 ++++
 arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi               |  6 ++++++
 arch/arm/dts/am335x-sancloud-bbe-extended-wifi-u-boot.dtsi |  6 ++++++
 9 files changed, 60 insertions(+)

diff --git a/arch/arm/dts/am335x-bone-common-u-boot.dtsi b/arch/arm/dts/am335x-bone-common-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..0fa2a311514b7776631797bb99d0d7f299df04bd
--- /dev/null
+++ b/arch/arm/dts/am335x-bone-common-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-bone-common U-Boot Additions
+ *
+ * Common u-boot configuration for all BeagleBone variants
+ */
+
+#include "am33xx-u-boot.dtsi"
+
+/ {
+	chosen {
+		tick-timer = &timer2;
+	};
+};
diff --git a/arch/arm/dts/am335x-bone-u-boot.dtsi b/arch/arm/dts/am335x-bone-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..11264707882b62749779aeb0a12e4471c8ace999
--- /dev/null
+++ b/arch/arm/dts/am335x-bone-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-bone U-Boot Additions
+ */
+
+#include "am335x-bone-common-u-boot.dtsi"
diff --git a/arch/arm/dts/am335x-boneblack-u-boot.dtsi b/arch/arm/dts/am335x-boneblack-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..e2afc77d9edc539323c73dee03511a9cd62d8ca8
--- /dev/null
+++ b/arch/arm/dts/am335x-boneblack-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-boneblack U-Boot Additions
+ */
+
+#include "am335x-bone-common-u-boot.dtsi"
diff --git a/arch/arm/dts/am335x-bonegreen-u-boot.dtsi b/arch/arm/dts/am335x-bonegreen-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..47e371a816faa4c0f9625d0313109fadafaf8459
--- /dev/null
+++ b/arch/arm/dts/am335x-bonegreen-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-bonegreen U-Boot Additions
+ */
+
+#include "am335x-bone-common-u-boot.dtsi"
diff --git a/arch/arm/dts/am335x-evm-u-boot.dtsi b/arch/arm/dts/am335x-evm-u-boot.dtsi
index 72402c82928a72abe3847bfcc0771dabc571d8e6..2ebf60bf7d6ce007e033b75a25a10c60a83e218e 100644
--- a/arch/arm/dts/am335x-evm-u-boot.dtsi
+++ b/arch/arm/dts/am335x-evm-u-boot.dtsi
@@ -5,6 +5,12 @@
 
 #include "am33xx-u-boot.dtsi"
 
+/ {
+	chosen {
+		tick-timer = &timer2;
+	};
+};
+
 &l4_per {
 	bootph-all;
 	segment@300000 {
diff --git a/arch/arm/dts/am335x-evmsk-u-boot.dtsi b/arch/arm/dts/am335x-evmsk-u-boot.dtsi
index 669cb6bf165575c7e688e49fe15732c97c9c0121..06ee1eb7c3ed68e6ccc8630d209b50add20e4d20 100644
--- a/arch/arm/dts/am335x-evmsk-u-boot.dtsi
+++ b/arch/arm/dts/am335x-evmsk-u-boot.dtsi
@@ -7,6 +7,12 @@
 
 #include "am33xx-u-boot.dtsi"
 
+/ {
+	chosen {
+		tick-timer = &timer2;
+	};
+};
+
 &l4_per {
 
 	segment@300000 {
diff --git a/arch/arm/dts/am335x-icev2-u-boot.dtsi b/arch/arm/dts/am335x-icev2-u-boot.dtsi
index ac1feaa9d9f69b79211f34c44af1008a5aed30ca..4ae100a3a7fb6bbb4b618849a15eb370a10dde2a 100644
--- a/arch/arm/dts/am335x-icev2-u-boot.dtsi
+++ b/arch/arm/dts/am335x-icev2-u-boot.dtsi
@@ -6,6 +6,10 @@
 #include "am33xx-u-boot.dtsi"
 
 / {
+	chosen {
+		tick-timer = &timer2;
+	};
+
 	xtal25mhz: xtal25mhz {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi b/arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..52c4bc26e128b6f463659bba070de515e7997efe
--- /dev/null
+++ b/arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-pocketbeagle U-Boot Additions
+ */
+
+#include "am335x-bone-common-u-boot.dtsi"
diff --git a/arch/arm/dts/am335x-sancloud-bbe-extended-wifi-u-boot.dtsi b/arch/arm/dts/am335x-sancloud-bbe-extended-wifi-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..17b86bdba3e43e7e9881e87a3ca0d3a36557c755
--- /dev/null
+++ b/arch/arm/dts/am335x-sancloud-bbe-extended-wifi-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-sancloud-bbe-extended-wifi U-Boot Additions
+ */
+
+#include "am335x-sancloud-bbe-u-boot.dtsi"

-- 
2.51.0

