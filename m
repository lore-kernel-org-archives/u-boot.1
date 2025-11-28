Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C39BD116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 034B983D3C;
	Fri, 28 Nov 2025 23:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="joElG67b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D78483B91; Fri, 28 Nov 2025 21:47:42 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C93C83B63
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso18968145e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764362859; x=1764967659;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9rkpiZ217GupmMCV9SnCvi356MTVYDSDB27SAnLMMao=;
 b=joElG67b9/iDUxEnf6b8XEQN5ElY+aalvPzIIxakl7CpqlImWVtOQPfmS8shdfoiHg
 wOZWqFYuGUHDx+uZdwELWr8lmOTPQctpAI7QB4pvMsCurtXbouWaspEcXxo1xua5/fAb
 Qq/9HSqO6n16bqlMoyEyc+rPx1wqBwe+cST89Tq1KxhsrZnbQUHmx3FKGmX/RyezJB50
 Af7bEWFYq64hkATAR7ZJytnN7DiN7bdx1pJ7ejL2LymosWKiFFlsVUWGuotRwmyqDDnH
 ykiN167UWxcofXzI0dG/5a67XVmKeEf3TK7+uGsFQPjQxdoLlH7N64Zjvgeo/k5qp6Io
 QP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764362859; x=1764967659;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9rkpiZ217GupmMCV9SnCvi356MTVYDSDB27SAnLMMao=;
 b=tj7BeSdaWtFHL2x1jZycMhykJcrx5yGfA9rFOggM0vTAVS1QMTW/rQISM03Owk8Sg/
 9ZIRn8g+Hm9yxNLrY9N1sXiKPG0Q5FwdJlngh5XBA6Bt+HwQ/XAUXO9HHvKgUUCTuyST
 1CuLQeU16GL/3Q2hI7ZHcPxqOx0bGWbtYPif32CzETpnGrl/JQ8rDu9A6nggZSH130p9
 mRE2YDXY648BPrDkw9bUjzgveGX5y1JDoHspOR7JeSfL+1ZpFK0MvN6OmWDQdnVGQHa+
 PLHupToU8OB7y+UxKIFya1Xf/OW6FZTQF+2/lNBZU5GkJ1Br5dgXYtQqM2uq7vlbR8C1
 H+hQ==
X-Gm-Message-State: AOJu0Yx/RKbJWrRurpnGaI87Zfr7FQRF4PmuZ8EXRF5zCX1ifoQsBPyc
 xNezHw/3sXe5DyvBt+RK+MmOZmhH0iSEv5ABplZsZSjHi3s5xPhz6/PFF9C5zD0u/ko=
X-Gm-Gg: ASbGncsEaVZnCmOv3Qmky/oNUhVcmXe93Pyh3/9Typ5m8e2+PnPetq7qKutNrIjGe5C
 Gfvwc0OB4mJJ68YkSdoFia71ijPbI5xWrN6irMklQewjLN9lkYjMvgHTEhSeK9hLhCqh2WpW9gT
 XLe4T/x37ZPGzENxEK2k7hT/6/PsLGFOs0+aL41dh5w+slKB2xKcar7FEZwan8nWBdtSSq5huUn
 h5w0lPKxQQue2ZvJJsQ2fIjyKjtHFYH3Le9YbAjP69+pjKmE80UsbYMChWH95z7nJKRSUi1Dhtd
 qxbiP6tPJxovPvUKAAGo41BAS2Hoi5IuGF+H00HnpptqoNLxYcdkMLd3m4U3CkA3KmVCyPfPh7k
 OpZTqG10eufuYR/QnpHNVmNBc0dkhLzAFlB2TvMF97zK/X9obQd+cafcIMQh2uuToSHuZcvTTDL
 cpG541Ars=
X-Google-Smtp-Source: AGHT+IHGHBSFds4f7P51rkXPoa2JSkJEwWG+6emKBZXjRiXSsOBLqlehAD1hRDAIgIPVVKlc+aoM3Q==
X-Received: by 2002:a05:600c:3553:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-477c0174840mr273052105e9.6.1764362859603; 
 Fri, 28 Nov 2025 12:47:39 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4790b0cc1d6sm163932585e9.12.2025.11.28.12.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:47:39 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 21:46:34 +0100
Subject: [PATCH v2 4/7] arm: dts: am335x-*-u-boot: Add chosen tick-timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-evm-oftree-v2026-01-v2-4-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5000; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Jx3bOlcAapEk+PbAdXOeeOqF5sOLBbnotEvJ9WRDLdI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtLvePE1+Luhp5ZEu9t9lptOasaa6c+hOGaXu+pKz7c
 m5JVMqRjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjI82JGhknrpxrWNhSfaO8K
 PlhxNVns3NEjYV9Kemrfa6ndsywymMfIcH3uISlzZ39Za8udT6MvnrR1UniTZrTxqPLpc4axCtW
 NnAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

