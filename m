Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B850FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244C684307;
	Mon, 27 Apr 2026 14:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="AjNCzQf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB56A84150; Mon, 27 Apr 2026 11:03:29 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 409E3839D9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so168102135e9.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280605; x=1777885405;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kzgS9ECsukh3yS0wLILuc+D3766rgurcuPFDikdoUY4=;
 b=AjNCzQf3XyeEHBVtxWXVe3yw4VqZvjnHatvR/twmlVScOaTLdmKGZLCU/9EB37ISzc
 wX9vslA1Ek9m60o8GCpg/XxYI0u92cwpUKA2Viplxn13hZzcPrBy+MB5M3kPjuTgW543
 MuyUIBl+ilboCFK07qLFpXxaYw0WE2ID8njIGdc/Qpu2xgihRqspVFfu+Ac02h9E3P+Q
 6RHyd83wQCATEI2UqN0tPX54quNDVDNo1Q2TLuJtTwYZMLgO+t81KPkcKFwndAgbUT9l
 9+zfjkXI+AYJQsUqFH8XK0Pb1AmP4wUrisb/i1yl9wzuRkQ8iyrvE7qaemV7kOUJBu0R
 oNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280605; x=1777885405;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kzgS9ECsukh3yS0wLILuc+D3766rgurcuPFDikdoUY4=;
 b=nEe+CK/lTo060ko3SSKRteUdP6zJc3wswDOYf0gJYyLZfrrI8PnSs30g/tjxbl55GN
 byet8ZfxI0x8vOQgSHBJPFK06HyE58QaNPk8xHSzoRMMxVmq4suYwsRLhxfeZY7PLijR
 AkhlWyr3sUoVnM427qJN1c35+Tx+URqmlGeFiMSRqQS9j0VKPAb+uLxnK+SdEPfRLjiC
 pdlLUUFnSean+plNjfFlVWRMmVoS5yZ8kPqSRSc95ROvxy2mXvV0xOQJ8qhqBM7lIVn0
 pVGAw8cetQMOtdpPlgKcBmjJfM47d3mz9tjtnydMBIKzq7ZsINahleC2XxWJymTTZj89
 mwtQ==
X-Gm-Message-State: AOJu0YyeQ5aOUHFGR9hf/yM7KZwbN+Mdl1KD6fN87aDpPosX2+Ya36Q3
 v/df1HOE2cC/aPPIpNno5zdp7RUt6pHsze5Rm80cZtkt8we5alH0uWfm4ytHollDhBU=
X-Gm-Gg: AeBDietHsC0uelp8ilTw6hpXNivxrG7cBVQPBc4dePrdMl62WfqIRjx3goKTCa8Kyqj
 FCHvyJT5FNpeXYCWbUtoubRh4uxZ94UlZ/2deXI8ajjZuSDJtVa2AzpYnoTuWDyKoQRRQ+OHHjT
 JUSRuHafuJFmD3b0zycR4NtE/xB5xpDSezUcxdiciruk7MY5CkaYwDP22Q7ivC/3pck2l6811Db
 KXqWQ5vnhpGee2IN4GaCVBYyTRIAhp1gl2lEIDxgHM4ChDZS+AF1u0rMrPeZ2R5YuuB1G9buycI
 3YwCf54Xlh3le4aekqV26p8XfYt/dLfLyCP+mPtTX7epRNzjhRn6NGTO03MSwf6Me2KCDJTrn0D
 l2/NCjf+r3QYwhz9TBJsQduE7+eomI5BMazkzrxy7bxkRY8CVH7j4e+uXdpaIpYqciDdnoXYNjy
 +kAKW/O6QLCrc1eT0w+cvynyhY8cgGLV4=
X-Received: by 2002:a05:600c:3053:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48a53ea1526mr238553075e9.28.1777280604476; 
 Mon, 27 Apr 2026 02:03:24 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm861275625e9.3.2026.04.27.02.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:24 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:23 +0200
Subject: [PATCH v7 07/14] arm: dts: am335x-*-u-boot: Add chosen tick-timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-7-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5571; i=msp@baylibre.com;
 h=from:subject:message-id; bh=XwiSNNuRwCiAY3tQ8wARBVsJ0usYVWkkf1Og3rTmWdk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3arrp8xTFuB4ce/txVtDly8znLGdkCYaq8tU+nz7Fq
 Nj5lLFsRwkLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEQ5/hx+1XemFrlU4svhzY
 /F61VfeGLGu46a2qK9sq5rIrKM2uZPhfdCjBumwft2T50knC5jbWTwPOcU/fNNuvpXNiEBPrt1l
 MAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 27 Apr 2026 14:54:41 +0200
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
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am335x-bone-common-u-boot.dtsi                | 14 ++++++++++++++
 arch/arm/dts/am335x-bone-u-boot.dtsi                       |  6 ++++++
 arch/arm/dts/am335x-boneblack-u-boot.dtsi                  |  6 ++++++
 arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi              |  6 ++++++
 arch/arm/dts/am335x-bonegreen-u-boot.dtsi                  |  6 ++++++
 arch/arm/dts/am335x-evm-u-boot.dtsi                        |  6 ++++++
 arch/arm/dts/am335x-evmsk-u-boot.dtsi                      |  6 ++++++
 arch/arm/dts/am335x-icev2-u-boot.dtsi                      |  4 ++++
 arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi               |  6 ++++++
 arch/arm/dts/am335x-sancloud-bbe-extended-wifi-u-boot.dtsi |  6 ++++++
 10 files changed, 66 insertions(+)

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
diff --git a/arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi b/arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..e348f84d9be9a858596d5f5e1a7127e7d8c1e7d3
--- /dev/null
+++ b/arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-bonegreen-eco U-Boot Additions
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
2.53.0

