Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA09D340BC
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0722C8419D;
	Tue, 27 Jan 2026 17:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nfpCfS2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A348F84191; Tue, 27 Jan 2026 17:51:17 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C11C8410D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so86485185e9.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532675; x=1770137475;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SNLYqFgxoj+PbtqFSfm8xLZswKrOgX0Jjtwg8lCL0Uo=;
 b=nfpCfS2rsAZUirBCecWsLUvGlNBCqK7Ac2QJ7aVrfkewUAP8JjQHFIoWEnCYvddv7U
 QZK2s+y6MXG9Yl6NfQuiPpWSIgIDfrgrLzjJH3iNm4i5OVg+iuJO7LVYdwUBXLBBD33T
 avxltmTqhsqf8H6YOzvT3TzilkKNEm9oGk2H2R4IwlCUe9bOSw+VXEzyGdI3Lk2xOCye
 tAoqQ9doJFl6TxQqlmiTCPKOnvuA48NVi9i3SppKY4lyQRYe9ExY+g1ABHQ89oM0Vqa2
 p+ayOflEHYVlBxsFVEMk2kbhx8gqA7IoC7mn8CJmFxXpZT1yvCL0Ib+Y/8fkInU4Ge4f
 oDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532675; x=1770137475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SNLYqFgxoj+PbtqFSfm8xLZswKrOgX0Jjtwg8lCL0Uo=;
 b=knqpC5MaVEtNonmg9Sk9jL0wilmj5oM8HVEgL+dLyfi6PSrdwbLpbkhtNJzSk3LpFu
 AzFSYFJgl03Rfia9eypLf2tSTfmpd6yuRR9y4clwq5T2uQyJzLtfl+obvp0bTmw4WPYN
 w4G6KyTVYevGcrMe/CZELkqZITPjUG5f11gDKiBC7FwUjdBH29sUtxbea5CNvPWLUPHO
 3SXfquZp9HqmfVwAz8+ZtL1LesV2f+t50rbwvwOZ6bQKTDxUDplsejzgyPddy9gPzShd
 d1saIzdJ3MExSOGRTrB25FjPCsaAdxAusOkyzYevyyFWiVkoP8CrFl+A/azTRpB10yD4
 pmkw==
X-Gm-Message-State: AOJu0YwvxZJylQMPEbtx4KVv3Lhdq9T72VpofXgvSI1GhgpI4fhp34eT
 iBsvpn/8EkUy9ZIWxjtXknJdqTdlzKdB5SDyVVQIRjNdeRquTh1RUMMgXj0xwvNNA60=
X-Gm-Gg: AZuq6aL0AdDbiimgmPGI0+zcrUruKhO+ozGn21eY2YQsDwgu+yH7KeWX71LUGpe9FoS
 hZ8oyxIlS5poWcnSrvTiSR4Eg3EXiSh4jVLjf0TshjwRhJW8pxaLDauMIkbkwFG7FtmB3fsRDLS
 Zc6P1ruVJN/i6h0+tUejXP2FwWkzWH+zmPwmH5azVNc4iDYzJeIN180z60aGAmhbn6KWhSkFRa9
 woiiylYbemRF/U6CSIZw8D8Agwtfhud3suJ+UKEQYw2aF4Vfmp86UbI5Qu0XqUMOWsZTjLhDc6G
 TusL9f0f4q7ngLDRKOwRZPeD6+KsviVtOqRMP0/Gt2ICL0WuK7s5FrwgtytOFnmhki9xyP2hA2i
 p6Ofc9onb4qpIbaNmPT/brnF7TuKU2iFKawtyDkbRyaM43vJrrkIojm5X/T5hOcdtMhy3yFVuJn
 7Zys/sijTd
X-Received: by 2002:a05:600c:6989:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-48069c5a2bcmr31112525e9.22.1769532674799; 
 Tue, 27 Jan 2026 08:51:14 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cd8fadfsm4868045e9.0.2026.01.27.08.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:14 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 17:48:21 +0100
Subject: [PATCH v4 07/10] arm: dts: am335x-*-u-boot: Add chosen tick-timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-7-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN7da2ITjO478ceeaXdYT8v5LEmtojVhC0YyqKr6OX
 MfIzeIdpSwMYlwMsmKKLJ2JoWn/5XceS160bDPMHFYmkCEMXJwCMJELjxl+MZd9j37R9jZIuHNV
 6aeHSZ+77vVeKOpZsmrLXu++2/tSRRgZ1qZZdxqIz7766U5b6b6HCTtVLSqNXzWenBT9qNiiKXE
 VAwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

