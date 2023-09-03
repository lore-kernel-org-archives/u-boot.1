Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7412AC71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC778682B;
	Sun,  3 Sep 2023 22:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VQ4i7nl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B2E868BB; Sun,  3 Sep 2023 22:49:03 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8648B868B8
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so114901966b.2
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774140; x=1694378940;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ssKd6q0X5n56FowY+d9EKZwYozJRtjcPdoih2L7vjU=;
 b=VQ4i7nl8Quz+24liKJUEPDXhhlBk21kVUpfoxCXRu/Ssl16XppTUXTfVRu3WS5I5qZ
 XfGh/Ve/NlN8SEXbdu3mzGp4FWEI01tYMTK3Vg9LdoNutt8rMpSnuttRn//FEkOEmeUq
 y30TU6qsST/9F+QoCV1h+0H9IycD9Pwv6jItY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774140; x=1694378940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ssKd6q0X5n56FowY+d9EKZwYozJRtjcPdoih2L7vjU=;
 b=L5RsVTySJAXLzYOrh18mi4f8QiF9JB5+bMDlEKbFUIukVTwLbWdgWvl6EDxHDDARti
 TKOJtVDln8LZ1eA6Y0DrxBMNWATrcaGxCL8kiCBbHwZMKwUs7Hu1H915sKXug80FWeTR
 PfMXmx3k+E2u6F0zAlKSEGBRC1jZUJzfuf2GTWV70KDkHvSI46AqLfiW8dk/OL0KBOS6
 cf6xoBVItlefHgyqqIjadfCXD6NUHk6kvcj/F2KZLFeoywyBqggEPyx3T4OFRh8t9m2x
 TfAtSu65SOGYKxCz/9WHFBEn+d/R7eesry4VFcOl72xaf2rN02c+6kYhGSGNiySpyHC2
 626A==
X-Gm-Message-State: AOJu0YxG9C1M3EV9mqqfXlwRw6xZDNiT05zX4GCW5hHkxqquGLuP6gZG
 D7mbYD+nqqZNJN+TQSsLURJ0jSato+rG+3gy+YRG8w==
X-Google-Smtp-Source: AGHT+IHbfXj2W7sNM+0aoFqphGS9FupyiLPf1vxJxcAorb6CCtrX76CbVE4wDbxke5XCqAvQH6B8Iw==
X-Received: by 2002:a17:906:28d0:b0:9a2:1b05:24c6 with SMTP id
 p16-20020a17090628d000b009a21b0524c6mr4611028ejd.22.1693774139865; 
 Sun, 03 Sep 2023 13:48:59 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:48:59 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 06/10] ARM: dts: stm32: add touchscreen on stm32f746-disco
 board
Date: Sun,  3 Sep 2023 22:48:45 +0200
Message-Id: <20230903204849.660722-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
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

commit f0215440069c4fb12958d2d321e05faa2708a11d Linux upstream.

The patch adds support for touchscreen on the stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
---

 arch/arm/dts/stm32f746-disco.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/stm32f746-disco.dts b/arch/arm/dts/stm32f746-disco.dts
index 1ed58f236149..9541f449fd0e 100644
--- a/arch/arm/dts/stm32f746-disco.dts
+++ b/arch/arm/dts/stm32f746-disco.dts
@@ -7,8 +7,9 @@
 /dts-v1/;
 #include "stm32f746.dtsi"
 #include "stm32f746-pinctrl.dtsi"
-#include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "STMicroelectronics STM32F746-DISCO board";
@@ -63,6 +64,22 @@
 	status = "okay";
 };
 
+&i2c3 {
+	pinctrl-0 = <&i2c3_pins_a>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306";
+		reg = <0x38>;
+		interrupt-parent = <&gpioi>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <272>;
+	};
+};
+
 &sdio1 {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-- 
2.34.1

