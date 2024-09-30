Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952FECE8345
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7808788F57;
	Mon, 30 Sep 2024 15:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="znye09uL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C752688F4E; Mon, 30 Sep 2024 15:25:05 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8E488ED7
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 15:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c89f3f28b6so576864a12.2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727702699; x=1728307499; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wu/MMSsolNkelLDF1RBUjrpM+ZsTkzEegcfvSoD+jtQ=;
 b=znye09uLO77i2Q1eAfgvcumxelHGfN/Ehyc4gPmxTwYFj1FOluuWDEkXHlbEFf+O/z
 ls8JI4RTZ228N18OXASGIwswY6amUDfsyu3RjdvUJNi+cRcvINMNxr47cnom6ovsBkHA
 IJYn2kJJwK11kFBZ/5swdzlVzVu6IYxpbmi+/c4PDJN91H+JhOcIoa8BGDbB+YOzEalx
 M6HWfrPg5gpysXW7UmGN1SU7guWQAfBQZmOH5QD9bL1YvlC4nSLSEHVRjwt7swhb5520
 he2JTzIrgFIGQWbrzPVXj5f0dvNE5x4RfkcrxLnQ9OhtqPnMVNp2IgWfS3waKDZaG8ol
 Dlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702699; x=1728307499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wu/MMSsolNkelLDF1RBUjrpM+ZsTkzEegcfvSoD+jtQ=;
 b=d3HK4zG1BR8q4QBDMf0hBm74YQkwRal+3Jf2HnnVgcnXeYB1upjokW/DzZBAhrA/NV
 jlRGpj4POU5vVLwB9HR7Xohws+ENnH40TEbgo6MvnijfH1vG7HwBecDpIuCD4WK/HIa3
 M1+ilSXLApWGCAZECXBNtYLG4t+tHGLw5Ded17YQnpize2AoGMmdBb/k9+BcHFPMA9yA
 ge/HsVOQA92fdon3qqhFgN7fzd3kI3X1A4kvUVkIa2HiLBbLEp43amUWK30NRMDRjpT4
 +mCN6i6mWYGGRqA+RE3Atli9cXe4BjTjZdKOw5DYr/bW1gtcx4FKuhDOGboZd9TBoAmi
 FdHg==
X-Gm-Message-State: AOJu0YxV10OL22b8v6/h7R1NCXI7Dg95c2owobqrivXKcWsCEFsipw31
 t4V1K9/OKYw1UzEtq6bSXEOegbQH8hF6G85t0/2OrFScu0nCiFZH3hn2ZsWJ544=
X-Google-Smtp-Source: AGHT+IGMznW4lvllb0w8VoNQvek98OmCiZ/EL9EiWk7Fh+JoqyXniGApQJgPXdXPU1Vl+2QytfnA5w==
X-Received: by 2002:a05:6402:24a4:b0:5c8:79fa:2e3e with SMTP id
 4fb4d7f45d1cf-5c882603bd9mr12674548a12.28.1727702699142; 
 Mon, 30 Sep 2024 06:24:59 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c88245fbeasm4484786a12.54.2024.09.30.06.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 06:24:57 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Sep 2024 15:24:54 +0200
Subject: [PATCH 2/4] arm: dts: bcm: Update bcm6846 and bcm96846
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-bcmbca-nand-support-v1-2-e637c65de947@linaro.org>
References: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
In-Reply-To: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0
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

Update the devicetrees for the BCM6846 and the reference
design BCM96846 from the Linux kernel so we get support
for NAND. (Linux v6.11-rc7).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/dts/bcm6846.dtsi | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/dts/bcm96846.dts | 14 ++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/dts/bcm6846.dtsi b/arch/arm/dts/bcm6846.dtsi
index 8aa47a2583b2..ee361cb00b7c 100644
--- a/arch/arm/dts/bcm6846.dtsi
+++ b/arch/arm/dts/bcm6846.dtsi
@@ -35,6 +35,8 @@
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
@@ -60,6 +62,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <200000000>;
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+		};
 	};
 
 	psci {
@@ -99,5 +107,31 @@
 			clock-names = "refclk";
 			status = "disabled";
 		};
+
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6846-hsspi", "brcm,bcmbca-hsspi-v1.0";
+			reg = <0x1000 0x600>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
+
+		nand_controller: nand-controller@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			status = "disabled";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/dts/bcm96846.dts b/arch/arm/dts/bcm96846.dts
index c70ebccabc19..943896afb7cc 100644
--- a/arch/arm/dts/bcm96846.dts
+++ b/arch/arm/dts/bcm96846.dts
@@ -28,3 +28,17 @@
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
+
+&nand_controller {
+	brcm,wp-not-connected;
+	status = "okay";
+};
+
+&nandcs {
+	nand-on-flash-bbt;
+	brcm,nand-ecc-use-strap;
+};

-- 
2.46.1

