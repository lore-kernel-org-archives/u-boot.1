Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F37AE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 19:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA708036B;
	Thu, 19 Dec 2024 20:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="dGjctjWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED0680312; Thu, 19 Dec 2024 19:50:09 +0100 (CET)
Received: from mail-qv1-xf61.google.com (mail-qv1-xf61.google.com
 [IPv6:2607:f8b0:4864:20::f61])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6328E8022B
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-qv1-xf61.google.com with SMTP id
 6a1803df08f44-6d8de4407f3so997666d6.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1734634206; x=1735239006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=elX00jXAQkaKgsYxzUX01+U5QNJPZmKZizOpS+PsO7Y=;
 b=dGjctjWhKQzeWdUCNv5uQUXNGP8O8/7cqWilBpZ06s46Kg1M5Ne6+t7xZB34TgV0YN
 ZFdM3RRlF929OPwrU3Wf+yPtaGFmEQljuvBej1i6HAcNp537l5/yDdXRjJeKktlSgt3o
 /R1JM3GKFunpRhXqenRyzMNYsw9g+BM+QIjLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734634206; x=1735239006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elX00jXAQkaKgsYxzUX01+U5QNJPZmKZizOpS+PsO7Y=;
 b=HScSwUkLRMyO3Fng1CkISDtTz0LBjDBWtgY8sEz9bc25/BBiLrq/GQVwafpWpTTNEO
 DHtQiinnCZsm2j2gI0BdEbRXj5so/RHooDmCiAncW57RtXpY+FXnr5jtCE/7ZwHsCODx
 FYOhqau3fAfxaovEuI7gzHHUcSj3AiLuQ9ETTljlPwtTDu+KgKZmn6he2UzhZYTZe6wN
 LGlWa/EIf2BM4bpILoxfS7i1+OLXjU5sacYdAzG98XTM9ge+1lph2YwT8qt75tgURfCa
 hg+/iYna4ig9M5ua3Mgt6FvZ2Wc420qLCtpHFToj6d5jORs+rQ1xPD8slXNMaYlXF0wF
 wPxg==
X-Gm-Message-State: AOJu0YyenzBxklBGC7/OyDaBLAz2MAvkrzSSQMVFqEuDeEpQDL5nJaFZ
 GnmQdA/tik8d4CUNnFNoPPRHgzw2QA6LAoFn6Hu1F9Aa+d5xVfaKdohrpSkn4aoKtqCI0ydmNld
 lyF6oBH+KBwTkSMZmsOGjrANZefK9fekLCUPQ62P4JpgTFVWjKM9mEJSSnZ+DWfzmwXng/ydrYp
 LH2tF5x7n/XwKwEx2FlREmrwPNfZXHPMIWvIbuFfmLNxgQ5GEQ8KPnhpUPMPKjuN0hE9Kc
X-Gm-Gg: ASbGncuCN2jN8d6fKAFghOc5Eb30tEjKC7SL1TdllGZp3Xam5fVP+KWzcwTsWGS+wPo
 aaYmRmwsUe3As4053Bws8pd7Mc2SCeRaFHkvfKgoRCIOfajKHXXt03h8PFr/Kge0DVvi6W0djdx
 a0jvXpw4fPMjV72hYmm+2rUoak+6Zv3E1XvPMQzR/5S23rS+uSslrmb1/qBsY66S6parrBQBD7z
 923Iy9uBLQBPz//iPwOD7saJacTLSnZl47+J7qQ18RSklfVIwecZtUWcFIF29I4BWTd+A91pHnf
 D2vg5cKWZgCoa2Mtpa7+E/4R/46GLA8=
X-Google-Smtp-Source: AGHT+IHVDgeci01rH7xMiJXzI487L1U6iwM6Qtd2JwZhSQ5aWzQCUWJgC4Dcqfgi9ueVycd/kkHllFnJ+5TF
X-Received: by 2002:a05:6214:3008:b0:6d4:2db5:e585 with SMTP id
 6a1803df08f44-6dd233172fbmr8856d6.1.1734634205859; 
 Thu, 19 Dec 2024 10:50:05 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-6dd180f0c0dsm981206d6.27.2024.12.19.10.50.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Dec 2024 10:50:05 -0800 (PST)
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
Subject: [PATCH 2/2] arm: dts: Update nand node for bcmbca board dts
Date: Thu, 19 Dec 2024 10:49:53 -0800
Message-Id: <20241219184953.226978-3-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241219184953.226978-1-dregan@broadcom.com>
References: <20241219184953.226978-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Dec 2024 20:41:51 +0100
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

Signed-off-by: david regan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Anand Gore <anand.gore@broadcom.com>
---
 arch/arm/dts/bcm96753ref.dts   | 19 ++++++++-----------
 arch/arm/dts/bcm968360bg.dts   | 19 ++++++++-----------
 arch/arm/dts/bcm968580xref.dts | 19 ++++++++-----------
 3 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/arch/arm/dts/bcm96753ref.dts b/arch/arm/dts/bcm96753ref.dts
index ebc8c8e4ce77..1efaf3c9fbf1 100644
--- a/arch/arm/dts/bcm96753ref.dts
+++ b/arch/arm/dts/bcm96753ref.dts
@@ -64,19 +64,16 @@
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
+	nand-on-flash-bbt;
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	brcm,nand-oob-sector-size = <16>;
 };
 
 &leds {
diff --git a/arch/arm/dts/bcm968360bg.dts b/arch/arm/dts/bcm968360bg.dts
index 1335f484ee6c..725ba6c06772 100644
--- a/arch/arm/dts/bcm968360bg.dts
+++ b/arch/arm/dts/bcm968360bg.dts
@@ -62,19 +62,16 @@
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
+	nand-on-flash-bbt;
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	brcm,nand-oob-sector-size = <16>;
 };
 
 &leds {
diff --git a/arch/arm/dts/bcm968580xref.dts b/arch/arm/dts/bcm968580xref.dts
index 9aa45877b543..6aea79ece865 100644
--- a/arch/arm/dts/bcm968580xref.dts
+++ b/arch/arm/dts/bcm968580xref.dts
@@ -62,19 +62,16 @@
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
+	nand-on-flash-bbt;
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	brcm,nand-oob-sector-size = <16>;
 };
 
 &leds {
-- 
2.37.3

