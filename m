Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DA0E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 05:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB607806DC;
	Tue, 14 Jan 2025 06:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="MMJMBXmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C828061B; Tue, 14 Jan 2025 05:54:39 +0100 (CET)
Received: from mail-qv1-xf63.google.com (mail-qv1-xf63.google.com
 [IPv6:2607:f8b0:4864:20::f63])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB91805DA
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-qv1-xf63.google.com with SMTP id
 6a1803df08f44-6dada7c89d9so2063766d6.3
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1736830475; x=1737435275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i7brHBQ/ZVR8bvkHmmziFYK8/1cpRo7sbozODT+wJUg=;
 b=MMJMBXmDrG0dfvvSr4K40bSmqP7v89ZeWkmUe0+3GPUjYjGYgHBd3GnwVlz3jJHYW7
 Az5ylaHJX5I6MIg9gg4zFCtxbT0obJo5kgoXM9JqxajqpE9KEDKvNxId30M5Ygm7uOFu
 qkooh3oAskcdSpLO0i0z8oP1AiMMkzabJtUzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736830475; x=1737435275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7brHBQ/ZVR8bvkHmmziFYK8/1cpRo7sbozODT+wJUg=;
 b=UfWZLnLjPPAbvKudEVDtRJqBG+sEKS2o/Qvdj1cB8pMAWvUnZv6N6Ws7pybsdt3MiM
 ff1Wua5bv3j+fwAwmBH3FBHUF9uGK/+C6ZT1ODmTM+sNfH4dTk9tTd5lI8W39EEFl3ob
 1oxY0VD1ZsgpmRvRGNxlVx9TboIPawBuRHPKzMv7deBjC1xnSsAKZlvRfFokIr47e3/h
 32Y270yJj5RKrpsCEx/lvXYh0UwSsj5kg+O9WjeNDHLQEg8oAIbN6W0PXrVx7GqgLvtL
 mnvpfHyAO7WQ30rpfxt8znVPMzzK96WvlYp6a/ccJvwmqdAQ96fox6LyMP94uM9SLV/z
 Kpfw==
X-Gm-Message-State: AOJu0YydXLwGOEy1ca786je1Eh+rVbAu7GjTeK/Fm1iqujyU3TdmOdLq
 xijcQx9fVMxDzzBzSXLoPQQdPsMKahG9KS7tuGgCHkAWo8b15MFM8G3C13VwAQJX1F1HOJZtinW
 AqPgi6E6CyFzWLMwcrLp7YkM9yMybPmguUo1Pzdnkd0TQj9kdCFy4p2KAnPKMj1P7POD506CodA
 UWYeQIohm95/O8R+FgKPgPklJL4v4RNXaXQT8pnhsV0a1DKeDs21aW+cbYHDnkLl0Xb+N2
X-Gm-Gg: ASbGncunV+ypWRoYHqOMGuTKrgOi2fgGN7yF8ycLNpn32qC0xr0Oe93mlnlEx0hP47K
 ZhOk6NHzOzGy+2ujKFdbkWR0JtuFmm3Nd+bf75zxZQseiRuR1Evj2L0fWfsh8tmDSLalODz4a5B
 swADNs/fclP+S+Q6OoUiNuNWaGj+pTCy59gGsfY+nOhh44OIggvjjcWX9jDdGUVEKSS0IQVhIjN
 0qa69GwxrSEqJwYrQ9PpWu93ZNvUxSD0M0r1pDVu/5xxH4NzenFnob0sguGgmxcrKshtvK2Ou0b
 fwelV7HD9B2hb9I7XL5ybz04ZJnhkUI=
X-Google-Smtp-Source: AGHT+IF42yvyAT9fXngLmR9YJvRs42hvMV0rGmevux8vhAlIqeB15T5nFWuCuQLY1BE5Mu3PMMb2oLRRnBgD
X-Received: by 2002:ac8:5702:0:b0:469:c8e8:d50d with SMTP id
 d75a77b69052e-46c7109dbfemr154563621cf.15.1736830475560; 
 Mon, 13 Jan 2025 20:54:35 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-46c8731f2d6sm2613821cf.3.2025.01.13.20.54.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2025 20:54:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, dregan@mail.com, dregan@broadcom.com
Subject: [PATCH v2 2/3] arm: dts: Update nand node for bcmbca board dts
Date: Mon, 13 Jan 2025 20:54:24 -0800
Message-Id: <20250114045425.148801-3-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114045425.148801-1-dregan@broadcom.com>
References: <20250114045425.148801-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jan 2025 06:35:58 +0100
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

Update bcmbca dts to current nand node naming convention.

Changes in v2:
- Removed addition of nand-on-flash-bbt parameter

Signed-off-by: david regan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Anand Gore <anand.gore@broadcom.com>
---
 arch/arm/dts/bcm96753ref.dts   | 18 +++++++-----------
 arch/arm/dts/bcm968360bg.dts   | 18 +++++++-----------
 arch/arm/dts/bcm968580xref.dts | 18 +++++++-----------
 3 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/arch/arm/dts/bcm96753ref.dts b/arch/arm/dts/bcm96753ref.dts
index ebc8c8e4ce77..c763358514fc 100644
--- a/arch/arm/dts/bcm96753ref.dts
+++ b/arch/arm/dts/bcm96753ref.dts
@@ -64,19 +64,15 @@
 	status = "okay";
 };
 
-&nand {
+&nand_controller {
+	brcm,wp-not-connected;
 	status = "okay";
-	write-protect = <0>;
-	#address-cells = <1>;
-	#size-cells = <0>;
+};
 
-	nandcs@0 {
-		compatible = "brcm,nandcs";
-		reg = <0>;
-		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
-		brcm,nand-oob-sector-size = <16>;
-	};
+&nandcs {
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	brcm,nand-oob-sector-size = <16>;
 };
 
 &leds {
diff --git a/arch/arm/dts/bcm968360bg.dts b/arch/arm/dts/bcm968360bg.dts
index 1335f484ee6c..a5b30f4e4a6b 100644
--- a/arch/arm/dts/bcm968360bg.dts
+++ b/arch/arm/dts/bcm968360bg.dts
@@ -62,19 +62,15 @@
 	status = "okay";
 };
 
-&nand {
+&nand_controller {
+	brcm,wp-not-connected;
 	status = "okay";
-	write-protect = <0>;
-	#address-cells = <1>;
-	#size-cells = <0>;
+};
 
-	nandcs@0 {
-		compatible = "brcm,nandcs";
-		reg = <0>;
-		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
-		brcm,nand-oob-sector-size = <16>;
-	};
+&nandcs {
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	brcm,nand-oob-sector-size = <16>;
 };
 
 &leds {
diff --git a/arch/arm/dts/bcm968580xref.dts b/arch/arm/dts/bcm968580xref.dts
index 9aa45877b543..77616023010e 100644
--- a/arch/arm/dts/bcm968580xref.dts
+++ b/arch/arm/dts/bcm968580xref.dts
@@ -62,19 +62,15 @@
 	status = "okay";
 };
 
-&nand {
+&nand_controller {
+	brcm,wp-not-connected;
 	status = "okay";
-	write-protect = <0>;
-	#address-cells = <1>;
-	#size-cells = <0>;
+};
 
-	nandcs@0 {
-		compatible = "brcm,nandcs";
-		reg = <0>;
-		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
-		brcm,nand-oob-sector-size = <16>;
-	};
+&nandcs {
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	brcm,nand-oob-sector-size = <16>;
 };
 
 &leds {
-- 
2.37.3

