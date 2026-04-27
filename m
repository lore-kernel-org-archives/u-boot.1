Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70591FF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB1D08410D;
	Mon, 27 Apr 2026 14:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LOOPKpz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ABEA841DF; Mon, 27 Apr 2026 11:03:23 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC0783C14
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso141317395e9.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280597; x=1777885397;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0yyWrM6NJUldq00B16UViycAsr54IKp7IZgCpCJPrwI=;
 b=LOOPKpz64UPuvXZ/KodHv7NjNSgSTvujCGxtF4mI7VBUnAiyxw0jL3sco+scppDP6F
 qlC3BdBH1seLFr0vJWdoYQbjgKx97EcXY4Luayfhhd/HHM8xhw4eWqNsE3kR2UP5gsPQ
 fb7OIJ6Eco8PL1Akj27pFo+ZZoAD5JC9zY8+giaPtQrybPt+FQ5kK3em/dsFE/Yrytkk
 Wo3bUKeMtBRooxMDZepO/LPmtTzvNGjBbEbXK+xncnVvr6x2FinBoFdwt2PCWW7Ml1YY
 J1oryBV2N46fUQXXHNX4RW5v/mdSeecypDnQnMQUgSV7uEhunaZsueHDRpuIMjI1Yy1g
 tcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280597; x=1777885397;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0yyWrM6NJUldq00B16UViycAsr54IKp7IZgCpCJPrwI=;
 b=EJ54ek1rK0MT8znZ+VXUf837IdxuSlOdqT40m+8L9h40QN1V/WVh+cGCJhNnY7j2q0
 4Xb6zDyXtyutHmH+W75i5dP5MNUWWIX0dL9iTgqv4cXiD0kYPBrpFz1LYyjtThahAjSz
 jDwRPPSmvFfC2pbv7xixV16Qd/GEL02+mPorid8euHl/37+/5oSI1NTy65dXP/wCiAEj
 EeOLvoBe4sE1XR8m9QjenUIsQ7XhsJGF6ubDo35enw3BlG7St0D6GwBEHxh2GMm76Z8c
 yaDou7etNchOxkeBI+z+nxrpVwXuMV+Zq2pQmfBNp8iMA8DcErWkeRCpe09wQoHa/5Mh
 pwMQ==
X-Gm-Message-State: AOJu0Yx2NdG3GYDaNVajE9wtugrkt11em6+77mkF6CPz1jfaeTn8d1jU
 QqS+sUAQKw23xa8VWIn/EMWj5Fla3uOM9qng9UOxZK0njXp3Gk0SaznJEinmxG6VSYI=
X-Gm-Gg: AeBDietpYOQFCoCegntXsJT4X0+GyHxD4iur/x0OLis3jcX5zZh7QI3i2rMK1sbjOFi
 u9CV+mm5+v3CJq03ExFtXbrn3GjmiH7j9naUCU7bqm1bFHABsst/nYc779eTBOMVuzVFbXPLLJO
 qGC9TtaZiT2wwpqc3vCTL3b7bvRCyGlu/FCV9upYGSt+mN4RTu60ob9ovQFc1t00XFb9OMti0tY
 iKu2Mc8jqhJZma2yPCOsvLqN/TF3zbuwkfh7V4VM3+2Z4byxdoFFifELMCgJigRqUL3tuY10tDI
 YRGL3OQ/B5BmVmKAHTZxmhNHepN7dOu5ZxXCautsLfgVJV2TOCGXCEwNs9wIKwHqUhVNBKhKcEe
 wo4COdXBJm75OxWF939sOpo7PW9I7SvCoGy1UxILtcFN2+ICBdLGCPFwoNHyfMppWHFXwQE78nM
 Y8z6BW3JXdeJwrsQVHG3QRUDGzQxsdGrI=
X-Received: by 2002:a05:600c:350e:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-488fb788231mr651580615e9.25.1777280596892; 
 Mon, 27 Apr 2026 02:03:16 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a55dc9f58sm927704015e9.6.2026.04.27.02.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:16 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:17 +0200
Subject: [PATCH v7 01/14] arm: dts: am335x-evm: Add backlight to the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-1-7e6cd1a805a1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=msp@baylibre.com;
 h=from:subject:message-id; bh=1ifQvbZwb2UbUrp1H9acuN2r4lT9ExZrhwgY6iwflto=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3avz2khWrEpVqPNrm/yz9GlHMeyN9dkRSVEnytrjt5
 e3pfiodpSwMYlwMsmKKLJ2JoWn/5XceS160bDPMHFYmkCEMXJwCMBEJfYY/HB+LNfryHl7d/TFx
 x/Nb5zya7OYJK6ctiFrr1NhffD32GCPD6ts//3OUTdqs8f/6JrYDP6fOj1i9WsFzF/u9c8vEGFq
 3swIA
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

Add backlight phandle reference to panel node. Without this reference,
the display driver cannot control backlight, leaving the panel dark.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am335x-evm.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/am335x-evm.dts b/arch/arm/dts/am335x-evm.dts
index 1b5b627006822a9bb4df1c6433ce7eff114dc029..52ca4ff6809ad24fafbdd515fbcde840715cf20f 100644
--- a/arch/arm/dts/am335x-evm.dts
+++ b/arch/arm/dts/am335x-evm.dts
@@ -94,7 +94,7 @@
 		};
 	};
 
-	backlight {
+	pwm_backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 0>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
@@ -106,6 +106,7 @@
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_pins_s0>;
+		backlight = <&pwm_backlight>;
 		panel-info {
 			ac-bias           = <255>;
 			ac-bias-intrpt    = <0>;

-- 
2.53.0

