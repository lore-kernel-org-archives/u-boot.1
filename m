Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536A2C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F6182F33;
	Mon, 23 Jun 2025 14:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DSCurFVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024B78210D; Mon, 23 Jun 2025 14:10:44 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B746C82977
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6088d856c6eso7930726a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680641; x=1751285441;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HggudwxLMgsUbt1Tj6Cm1LSfnjMez+WRUaGlNuVmeZQ=;
 b=DSCurFVpb+8Bdg9QAVleSqrD8rZgbEJWlUbyoCdDAjUWHd0rdcVYGXqlycI8ukhPfd
 u3peObMlJwgy1zrHM9fcBHloldyM89yjO7hGXI5OWpT7BvBd/IIfZv4V2iJjc+FJomQq
 uT46qLdmRcdOrJgWSDT0dXwl+bOhGPJKKXdhCDqoiLZDdHV+5OFc+61wFI251+1c/E4n
 3M2eAOswdIlAyPLl+sv8FuWDwDcLmOBmQ7Bt19Md6J1rKyaEn8V91nEIy1d5MXcSYPOG
 lqLNcJQxbhTc/eRaDHJG9+7O2JWaDOKZSGfFn2jDntXCPwBfTQ2vADM2PM8A0kqYUbaI
 Kp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680641; x=1751285441;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HggudwxLMgsUbt1Tj6Cm1LSfnjMez+WRUaGlNuVmeZQ=;
 b=Cipn+T//PMeYR7rPcw3kTB7iGb3XjyyONtGRSr8qWVgiMDTlfwYYbgP3YlCEm4ncaL
 AIH61jf9yLDHN+dT102P2vrd4zMy05Vtw9Ob8f6IrSQTk91D8fI3liYag9J0JfodoceX
 60wMOJE0RUWt44Ubtd1ucgMZUqewG/seUpJeha9vcw05YRHonfUQ2fTilcUDiTIwTK/g
 EjKrwQU8cm53GRUVdHuY16BaTwgCe+KuTzafABjHtcRF7ibLC8KS8ZmmZx1L8iI38Vgd
 IEdNsaQREeWNtXPa3qvMQQGbeY+CoB6sv48BYH2Ul6m/bs96fIDKHtyL+6bv0Vn/4UKD
 ronA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQCoWZjZKtoZ90JkqQ/t8GfaAGXp14xfhz5n8+2JfmxNzdGRITtGhRRV8Wogy6Bmx+XNKB6yw=@lists.denx.de
X-Gm-Message-State: AOJu0YzHb79pGI/V00SLp9rZmBiE9fZCOU0RYFU7WAk4xE95dnyEIZaQ
 3ImcqphrHM051qXmIDEcsBNiVzxb0vE9Zlt+l2k/WDA4TcJBvaSRhHzOTvMV03AZsnQ=
X-Gm-Gg: ASbGncubHqSV5tkR0Q1KJQBarrFg43/9VbsVqI9DzfC6/jw5KQz2Gr2SDWbGQ2UVdZp
 4sQ7moKjFbA4dUnK4vfh8kWDGi5UsYyiIQoGHG9e4TsNNBOH+Ayi3JOmtH61VAtbqo+POqh3F0t
 v/fAS77xnvCAegBpHn0L78hgJKxXp6M3zE8NG2Z1C9P/VtLbJdqjbk7N4gkAnJVLCNKrGzT5d3w
 ilh5u+K7k2JhkNN9NffbwywORodBvRcp/OMin/klDXGBZx+F6g4oa13siPnXrDx2M01BipO9g7Y
 lhRxDctykftP7w3m9oE84mND2Tq6sQQlgHhRM0w5IFoaG8CRtExRYoweXkceOGaTqxnihg==
X-Google-Smtp-Source: AGHT+IE68bdcQgyv0OwQvY+s6CSHyuN/xi24Czb05hxjuNXUuaIySN7yKySCQheF0ZqIN0Eb7jJnPA==
X-Received: by 2002:a17:907:7250:b0:ade:902e:7b6b with SMTP id
 a640c23a62f3a-ae0578f3ba9mr1206606866b.7.1750680641021; 
 Mon, 23 Jun 2025 05:10:41 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae054209a40sm709651366b.173.2025.06.23.05.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:40 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:34 +0200
Subject: [PATCH v3 11/22] arm64: dts: ti: k3-am6*: Add boot phase flag to
 support MMC boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-11-a4da322c16af@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2920; i=msp@baylibre.com;
 h=from:subject:message-id; bh=9mQbKqXDNNqBT52De6geZslnF8SwT8yqbGtr6+bM8i0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI58+xK3esvPKNr8H4n8ffDfnz1Jg4v4ll3jdq181QP
 r5uinlNRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzkhg7D/8Ald67Mb2vZt872
 8PQ97cpSP/dqOf9gSHs9cU7ti8ur8o8y/HfTdg6/7d9/JF1hHk/bHAVJa/UnGXciVQ3fMkyp0DD
 zZAcA
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

The bootph-all flag was introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across
different boot phases.

For eMMC and SD boot modes, voltage regulator nodes, io-expander
nodes, gpio nodes, and MMC nodes need to be present in all boot
stages, so add missing bootph-all phase flag to these nodes to
support SD boot and eMMC boot.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429151454.4160506-2-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: db3cd905b8c8cd40f15a34e30a225704bb8a2fcb ]

(cherry picked from commit efc9013586bda11485bbc190592bd25d83d0c1bc)
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts | 12 ++++++++++++
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts  |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts b/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts
index 8e9fc00a6b3c7459a360f9e1d6bbb60e68c460ab..aafdb90c0eb700b554c6c308be6c1732d0459a8c 100644
--- a/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts
@@ -69,6 +69,7 @@
 		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
+		bootph-all;
 	};
 };
 
@@ -77,12 +78,14 @@
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
 		>;
+		bootph-all;
 	};
 
 	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (C13) UART0_RTSn.GPIO1_23 */
 		>;
+		bootph-all;
 	};
 
 	pmic_irq_pins_default: pmic-irq-default-pins {
@@ -118,6 +121,7 @@
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+		bootph-all;
 	};
 
 	exp2: gpio@23 {
@@ -229,6 +233,14 @@
 	DVDD-supply = <&buck2_reg>;
 };
 
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_gpio1 {
+	bootph-all;
+};
+
 &gpmc0 {
 	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
 };
diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index a9557ee73b8311087db9ce9cd9596efb8bb8975d..22be41d46eb519917516fba5f2439bdb492c46f4 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -313,6 +313,7 @@
 			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
 			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
 		>;
+		bootph-all;
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
@@ -634,6 +635,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
 	disable-wp;
+	bootph-all;
 };
 
 &sdhci1 {

-- 
2.49.0

