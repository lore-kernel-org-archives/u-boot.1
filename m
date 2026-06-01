Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090E7CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F44849ED;
	Mon,  1 Jun 2026 14:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="beyqJ3vL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8A784869; Mon,  1 Jun 2026 11:32:33 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF01B846A3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490a765f47aso9372455e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306350; x=1780911150; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CQWpi2mZvfCJLYHW+9b7rtGZ7T9w5zi6o9MbL1oWj/g=;
 b=beyqJ3vLFf4/xp7GFyyZ+5GtzntqbxrCz8v4V/1m5UdUn8kEy0V8/KOtPu9tTDQxVL
 rVsbcnQVcJ5nEymdsg1Y40lSOVCIrymsatYxkRxLY3Ft6sklzD5bHzL2nPsEn3HNusa4
 sia+b8NhnfVeGERIbReLUdcHg0OQp38aHQCK6O4n9sB+t1Qil2X6D7fmnodSbcdLKo5z
 JAY+tRCy8Dekl9RMpiLHbnYVD3ZWNYsYhgMIIr512+cbLinSW+sJXjnf2CYq+7Uypsyd
 SyLZS89P8ZVpT8M5IcoI9NdmItaEJsmF/mifhHlxig0jzCvj118qac76OAvjVSmJtbR5
 fcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306350; x=1780911150;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CQWpi2mZvfCJLYHW+9b7rtGZ7T9w5zi6o9MbL1oWj/g=;
 b=iH4rYFmZXXEOS+H4HimtzYW3MVV1I5oLIdlDtct5RqMjd1PMk6LvYKBn942FMYUSfv
 bBK0nXBaZjPVlh2HPA7mG9gxw8kNHhnXvrzGVPkN5Mw4wFFa8l4SL8+fjsLJzPxFIFgG
 eVY+2l71mQPBaIxH5cwp6gnxklh8r/4jjV9hAG6GW9UaZme3SUjXWpXDjLsjza1rxrgC
 LVXH4sj+Z5Zyu8+ngz6NGu/oLVGXkAeV6vjaCSvPPYntE1vVgq47VypDm6zDdA+/xoeH
 qDM46Cse8BM0Pm3ZhKWJyIZRWbWZ5kJnKQs2BUOG0cY5pOKSL76yexsrFYCctcAyPfp9
 aOEg==
X-Gm-Message-State: AOJu0Yw+WYmDdHdJj4p2BVXRgp9e7Jv+4XyagzMCy5VtP/PZICL3KLKW
 9IEKCjKAQzM3IFwTXTJITDYfPxJdWx7jRA7Xx1MLOrqX7AZiqj7dGf0ors5jWZ2UyClTqvAA5xD
 vI+NN
X-Gm-Gg: Acq92OH9ZafSMiM2DHFEao1A5RBgLNjUwl3YbdGRXul+AOZiVbF1U20MWgBe0kWDiot
 gFV4zs6Fv4adqpM6rxcNb3NOBP7QTd/bwAyvsQsrlCxT+j/bIzEqYGLNJXqRniSx+QwcrxNnNhL
 o8xj46/K+LTgRh4pRVRXszycw1m15Lpze/0OK0So2CROCqzZS7ucjYG9A8UM6MNv3qhyy2k6mWh
 XnhRpkzYDANvVvR9VTx2+DZMaE4l+YdwvhDgE4Xe92e/7Lb3qAlyp7BiblNHL9/NFSXNtIaR/0P
 mqkcoLpTz96hR7tqcExjq0MwkjqdcPijw6rud983tmKVXwob7WlGhgLQcyH6cfzBuiw5j9/dE4p
 1Ry5bquB4Gks/m/A6c+Y41zIVubF1E3w0otcPOtmBrFHna25wXGwP0g/VZwroWl0OAc3JP+5DJO
 VS4LA6nzZ/d4xFtZ9UB5SCMX1Y0obZ1Lc=
X-Received: by 2002:a05:600c:1988:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-490a2950c9emr185288605e9.26.1780306350176; 
 Mon, 01 Jun 2026 02:32:30 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c103baesm72713855e9.17.2026.06.01.02.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:29 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:42 +0200
Subject: [PATCH v8 07/17] arm: dts: am335x-*-u-boot: Add chosen tick-timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-7-2c33c98e7ce5@baylibre.com>
References: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
In-Reply-To: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
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
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7145; i=msp@baylibre.com;
 h=from:subject:message-id; bh=F2y1hJvfcQNrQb81I+jgJzW+j0PaGYQYTXioeO0HjSk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwLRA2faMSvENnxUfxyydahhn1i2ctGnvjYiWdZbBS
 UcrX+/sKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIlE9jMy9KkcZT9249T+97N+
 5P269NjCd8KCrs1PP3QvWaP1g8u704jhf/HG0IWTG5ksXWMPsTftTZBSV1hxJ3yreLdWWvBsp7Y
 pjAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
 arch/arm/dts/am335x-boneblack-wireless-u-boot.dtsi         |  6 ++++++
 arch/arm/dts/am335x-boneblue-u-boot.dtsi                   |  6 ++++++
 arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi              |  6 ++++++
 arch/arm/dts/am335x-bonegreen-u-boot.dtsi                  |  6 ++++++
 arch/arm/dts/am335x-bonegreen-wireless-u-boot.dtsi         |  6 ++++++
 arch/arm/dts/am335x-evm-u-boot.dtsi                        |  6 ++++++
 arch/arm/dts/am335x-evmsk-u-boot.dtsi                      |  6 ++++++
 arch/arm/dts/am335x-icev2-u-boot.dtsi                      |  4 ++++
 arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi               |  6 ++++++
 arch/arm/dts/am335x-sancloud-bbe-extended-wifi-u-boot.dtsi |  6 ++++++
 13 files changed, 84 insertions(+)

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
diff --git a/arch/arm/dts/am335x-boneblack-wireless-u-boot.dtsi b/arch/arm/dts/am335x-boneblack-wireless-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..c2cc9d93fd367aa0fc58131770c976a042ad765e
--- /dev/null
+++ b/arch/arm/dts/am335x-boneblack-wireless-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-boneblack-wireless U-Boot Additions
+ */
+
+#include "am335x-bone-common-u-boot.dtsi"
diff --git a/arch/arm/dts/am335x-boneblue-u-boot.dtsi b/arch/arm/dts/am335x-boneblue-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..aae211eef5ccbf2fdaad64a6802b9479655708fb
--- /dev/null
+++ b/arch/arm/dts/am335x-boneblue-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-boneblue U-Boot Additions
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
diff --git a/arch/arm/dts/am335x-bonegreen-wireless-u-boot.dtsi b/arch/arm/dts/am335x-bonegreen-wireless-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..b03e679ece47065d7c26bc9b044e6d141260e9ac
--- /dev/null
+++ b/arch/arm/dts/am335x-bonegreen-wireless-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-bonegreen-wireless U-Boot Additions
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

