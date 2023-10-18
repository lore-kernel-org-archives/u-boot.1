Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A4CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98E4286FC1;
	Wed, 18 Oct 2023 16:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="pQYOJTjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F6586FB9; Wed, 18 Oct 2023 16:01:44 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F36B86F94
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c50d1b9f22so61178791fa.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1697637701; x=1698242501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIbO9ZHPkk2RBTU4c0uzb4WkLUbmwQd/zOfWtAUv/zM=;
 b=pQYOJTjU11PlWwQNMU3ulU298SoOE/KcCEqfxZHLWzySlh6xbs4Gx75Gg1HR58qM2y
 tDgmoAGEXk2aNd4zgWdsqtzOd95UI39SJMjy5AWT2RcicdcxOGmW6MBG8JNmtjJI42nz
 idyjte1Xul7diT5NladAYONHilfIrYj/UymwkGfCjBMKWflNVMZVatVO54wDtN50yaE2
 Y7OERVb9R9X2y/9EyqdkPAsqy4ZhQC1Elt5hDpP6tWENN7qM+g/Zpz0LZnjqR3ZmOwWU
 GM+EyIVIHOIVX9QRPX9Zon+KouDipSg1fOkPK6ERSX4sTNWD3Xdn3vThwkOUy8okuxjY
 kw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637701; x=1698242501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIbO9ZHPkk2RBTU4c0uzb4WkLUbmwQd/zOfWtAUv/zM=;
 b=RzGBZL/Nek/6iqYE/6b+NKbM4qYakWvBzHL7i2wglO6COAI2b9RVvtHv4WyRUXapXP
 VS0CvQGb3u5u26hRBDkLh3aMTPMJAO9kVjSqP0w56M8vDb7Yxz45U0dWoAJNeTibWld8
 /skB1K5OpTjmx+HuTXyVfh4rKOrC4QsdyHV9DWL81j+GircD+e+UrAdrdOVxF91+EWJD
 RGP3FGcennpPnghSNXCJ/4sdv3EUNvXelrkq9fUoVQhTkJOz1Z3efU3eMNlpktPxcMLH
 iNXfzLGGT9RnhtNBPZ/VERj74mOE96yGBHqcTGqX3WIjZZLWGp16K7erE5GgEp4QAGZY
 tRHA==
X-Gm-Message-State: AOJu0Yy0DsVZNI3Qtns2k7fl+YgHljNwDucugvrGF7NlotI7FEPPm7Az
 x4qvfnJEQhLGITd+pXsAm6XxUg==
X-Google-Smtp-Source: AGHT+IE7J/Kidv0BPlvQSGnaVmVSQ3VuHRoPYsDkZFHPixn8vjdnHD4htmJQq7ylY8MWVhZaJ5eGxQ==
X-Received: by 2002:a2e:a794:0:b0:2c5:1542:57e4 with SMTP id
 c20-20020a2ea794000000b002c5154257e4mr5949486ljf.31.1697637701061; 
 Wed, 18 Oct 2023 07:01:41 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 f2-20020a05651c03c200b002b9bf5b071bsm718692ljp.20.2023.10.18.07.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:01:40 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v5 3/4] arm: dts: at91: sama5: Add flexcom4 node
Date: Wed, 18 Oct 2023 16:00:58 +0200
Message-ID: <20231018140059.161169-4-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018140059.161169-1-artur@conclusive.pl>
References: <20231018140059.161169-1-artur@conclusive.pl>
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

Set up flexcom4 for Microchip SAMA5D27 SoC and prepare it for usage in
I2C mode.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---

v3-v5: no change

v2: new patch

 arch/arm/dts/sama5d2.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/sama5d2.dtsi b/arch/arm/dts/sama5d2.dtsi
index dd6468ed96aa..819564fdd5bb 100644
--- a/arch/arm/dts/sama5d2.dtsi
+++ b/arch/arm/dts/sama5d2.dtsi
@@ -781,6 +781,26 @@
 				status = "disabled";
 			};
 
+			flx4: flexcom@fc018000 {
+				compatible = "atmel,sama5d2-flexcom";
+				reg = <0xfc018000 0x200>;
+				clocks = <&flx4_clk>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0xfc018000 0x800>;
+				status = "disabled";
+
+				i2c6: i2c@600 {
+					compatible = "atmel,sama5d2-i2c";
+					reg = <0x600 0x200>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&flx4_clk>;
+					clock-names = "i2c6_clk";
+					status = "disabled";
+				};
+			};
+
 			aic: interrupt-controller@fc020000 {
 				#interrupt-cells = <3>;
 				compatible = "atmel,sama5d2-aic";
-- 
2.42.0

