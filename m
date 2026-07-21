Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1961FC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B36380EEF;
	Tue, 21 Jul 2026 15:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k0Z5mkj_4hkQ; Tue, 21 Jul 2026 15:55:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6BA080EE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649345;
	bh=RMhoT5BF4rdWRtPLcBFiGHBjFZ02dhqGM6S8fz/R3VA=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Bn7yBcs//rG8+LhqcDyfWIrbSjZfpDHJ5L4D5Wdb2z9Xl8wvryIybFjDv9E0u5CXN
	 Kjko1wLL+ejPMNFIs/LvDI3lpKyQGmNlph4qXuGQJOYzee+OmA4LORBp4D2iEfuclV
	 q/vJztO7Myr3CWlh6C6jVvWmBC+UtwVgSy7OHvxMFCDl5bvKbn3w9Sqfe4MCx7IR+Z
	 OCg/Zf4ZFJze0/bl1bFpumAO9e/NMunNVOiuQS8rtR5nneQzW1ddudRDPLgNlXhpnc
	 DeHwUK9Vn6PNkox6RDZX71OhxlQYrxT/z3O+AYkuXx0nai/NOyEP59Yv+i89NE32O3
	 BSo6o8PFoqAGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6BA080EE5;
	Tue, 21 Jul 2026 15:55:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F38D109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80E0E40277
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AzPdgZjayIpN for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:28:43 +0000 (UTC)
X-Greylist: delayed 434 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 15:28:43 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 86A5A40164
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86A5A40164
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86A5A40164
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:43 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 31AA33FC09
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:36 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so225587015ad.1
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647294; x=1785252094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RMhoT5BF4rdWRtPLcBFiGHBjFZ02dhqGM6S8fz/R3VA=;
 b=JO3VoNAth2q/8BmtUBkdKWJ61nhHFtQir3mwEK8mjzMYavVHkuYaCaEgXMpXVb87o6
 VJ+5Ipn6xmRL4x8a6d4ZIQvYfNhKFkrTNMjPk2KdpVTfWPrwoh2mN1FEA+raHU3jeiPW
 XeGYY/4wHMeRjhhIaVwLcWxjYjFqsbnNcfNo5cbetAl5Y/oEXbVaWvdYxAi9SMbphFUK
 YYWzAF4SDS5xYsZzJk7gvfvRdhyIs1WAU6v+SybnQRGV6H3LYaRD/OIFJb1/n6cmMZvW
 xYszohWhz2vWbYyw85FYd4oLR3x2UrbMW99cOXrMtZezpqtj71j3EaX/ZfHO8rI9qZW1
 5liw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzeEmQ2tChkk3LQEu0Fi4xa3zKHJh5nbO8ODtPPYZBmZ++oKCuCtfHGLgmvPpejwQI7oDlUYg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwLwZ5ayS8DFQWXEqHpTJlwVNv/lQ3rSuFi4XfrYse/k2uo3LL4
 Qktl2ZtDJa1wMLZIwTFuXxPKwec5c/dEFr7D+DryZDVE99F/rOljfmtLUeBSdTCyHgOqmYQIIW8
 5vR8+ENRvafMZ9QdKGqiDjmIJHeupRrNp/luL+Jw9x+IHTVbuL+K3xG5gLX6uAjqa5D/gjNDPGn
 BtKmjAayxk0w==
X-Gm-Gg: AR+sD10ALME0+aNqxKZ9EJy3DUSHOWTigSLtaJ6P3MFDioBVnWBA2O1w4r99dICKo+H
 0TKfcm455sA8DFqDC3XI5fJ6ZuDcOSRAJvQuMnvHq8efeDh9avVyqw3mPEdXXyC1cO8cXNUeaCb
 sIwgIi6rOdQfr60uH8uEvFta79/AZSeUa5RZ0KRa8UYdz8kLHp53J44CgdDut0aoscXut98V/2Z
 cT3hr48ozlYav781bh8ZePmzeBF2K4TaHcop2AO+u3c0IHjIOeZQ+AUhuWXlt3Nn0zRWF/Yy/4b
 +v3J1sMwBmGjbR/XKhwU2hnTqq+T399VrTei4TzmSZPFvv8ftlBMA+ryTItfWiPs1YcJbBdJScE
 Ej3nFa2DOIe6ywo13biPB7/ubQLsMGjAM3PNpRCnuAZqlMnafvVfSNf+M3TKT5Zbf2hU=
X-Received: by 2002:a17:902:f688:b0:2ca:5d24:720b with SMTP id
 d9443c01a7336-2cf349caff7mr214401575ad.39.1784647294528; 
 Tue, 21 Jul 2026 08:21:34 -0700 (PDT)
X-Received: by 2002:a17:902:f688:b0:2ca:5d24:720b with SMTP id
 d9443c01a7336-2cf349caff7mr214401145ad.39.1784647294067; 
 Tue, 21 Jul 2026 08:21:34 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347119dfsm77733775ad.56.2026.07.21.08.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:21:33 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Garrett Giordano <ggiordano@phytec.com>, Suhaas Joshi <s-joshi@ti.com>,
 upstream@lists.phytec.de, u-boot@lists.u-boot-project.org
Subject: [PATCH v3 4/7] arm: dts: k3: phycore: widen SPL overlay load address
 spacing
Date: Tue, 21 Jul 2026 15:21:03 +0000
Message-ID: <20260721152110.283998-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721152110.283998-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 15:55:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784647296;
 bh=RMhoT5BF4rdWRtPLcBFiGHBjFZ02dhqGM6S8fz/R3VA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MtKhzhPbQgPtSM9ukMP/tUl63juNajRgNuoL1yKb0XvbrX54MoJcZZaK0jtdv+Li9
 mnzt/o/Kf7appPRTNDk6OiuAbyGFHrDs/ViO4sqZumH2crlagDunSZn2EKFohwKMim
 NHeOHkVSkS0scjlTnc/D27PSv7OCfXnVxYxd4qaCacjpWBnc4OrSGEIwvZeIyoPBcG
 1kj1JL8aXPx7E+El08NS6ZwEFNGWh/jcyX6SGF0FrQWjGJCUvdaY5R5//iX6U1Wsgs
 AD1ZORQTTlHd/elOIpZZel3CqlHmmKxDP8kzy1u2UP1x+X4EbaM/n+uW5BCAJMz2vI
 sMQi/WexR/zsgnUdxyra7Tij8kWAO/dlbOgwQjZk7C4eh6cdXBEPxXo4s0PGKIgfw9
 tdnXR+4lutae2Vfy05QdZu8kmGbB7oVnvkRfq7V5YangCJzzls4zEi7xR2L8kLEFwm
 KOhPzY3kDoywYFb0ELXC1NAHkHBhb8GAu1wboRlnXKOv8NDuTsssOCId+o7XAOpbnI
 SxLgnJucn4xT59frMDaAL+jbEiOosLH6t+v/DGvd/YP/81Re/piPfp36jAHRQ2nmgb
 HF77UD6emFlFe+U8vOsA4XlEJES3wjxdvUFSBxcZW3HLIeIQgFXVew8LbpgNa1/HLR
 zSLl7ms5MZ0CNaJbuXiOV0bg=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=MtKhzhPb
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The phyCORE AM62x, AM62Ax and AM64x u-boot FIT images carry four
devicetree overlays (som-no-rtc, som-no-spi, som-no-eth, som-qspi)
that SPL loads simultaneously as loadables of the same configuration.
Their load addresses are spaced only 4 KiB apart, but each packaged
image is larger than that. Measured on a phycore_am62x build, every
overlay is between 6035 and 6163 bytes including the prepended
ti-secure certificate, and the raw dtbo that remains in memory after
the certificate is stripped is still around 4.2 to 4.4 KiB.

Loading the images back to back therefore overwrites the tail of the
previously loaded overlay, so by the time the board code applies the
overlays from the recorded /fit-images addresses the earlier ones are
already corrupted.

Space the overlay slots 16 KiB apart so each image has comfortable
headroom. The addresses are only consumed through the /fit-images
records that SPL writes while loading the images, so no other code
needs to change. This also allows the upcoming mkimage load address
overlap check to pass for these boards.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 6 +++---
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 6 +++---
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 6d57a5d9ffa..d0eaa7dd992 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -368,7 +368,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -383,7 +383,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F008000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -398,7 +398,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F00C000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index cdc9a100a04..2c98e16b00b 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -295,7 +295,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -310,7 +310,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F008000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -325,7 +325,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F00C000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 07cb79fd04a..64679195e72 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -402,7 +402,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -417,7 +417,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F008000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -432,7 +432,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F00C000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
-- 
2.43.0

