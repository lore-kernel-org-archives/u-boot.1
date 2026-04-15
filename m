Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2AFF43848
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B728423F;
	Wed, 15 Apr 2026 18:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="oesOW3Uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A03F84201; Wed, 15 Apr 2026 18:03:51 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A888421D
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so979422966b.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269029; x=1776873829;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0yyWrM6NJUldq00B16UViycAsr54IKp7IZgCpCJPrwI=;
 b=oesOW3Uykdn0GLb8uJH+lPMu5TY1S5cOb8omlrMBrO3vGgXErrBfdC8x9a8KrIFh4r
 7je7IkliWOXFmhS344E2Byp4dmSlRa6ejtvulVQAV1ibznBUm0akWsYktk0jqhjFgU6z
 NP1Gi5SYvijgcKtXqsI0aShI7UpY7YyrnLE9CwgeFB8/KRNgL24YdMMbZlaiSDDdo6qd
 7fJV5axx87prjRupoyzZWAg/8my55VcJUwajI6ZzkZHZo4EY6+buv6nlKInhpTDU+GY+
 Xga8Dodj6JCMJWudKy0HkIMIUJZeZmeTeJaUai1LgNQFZGLGxyj3VLfD9MyTqBzw269J
 w5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269029; x=1776873829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0yyWrM6NJUldq00B16UViycAsr54IKp7IZgCpCJPrwI=;
 b=VFPvuzfbXdQNpprry61wuzhVF0+XKV6QhaD8x3MZWU5JuKM8Ef72qyQ4TCdutyR3B3
 zTuuJW0IojSIu5ZuT24clQnoGln+AqKlKw0XUaWQz39esNc75kLWXAdAU37lxA7erTq1
 YJKMHRJyP/XUe4lW8zItinqFLnopBOKHIFWY7rw8YjEcr41Xtvw2nrm8TcwgtwpzEl/6
 Ut6QozToMleODeL0AviKTq0KPUmgX8oNYWl+3xX78dcJauR0Fl68WnWsdNYgn3wZmhkh
 nYI2r9OI4uCL9d4WsBUbhtrkM6x9P5YylwWwN+MrQGnEd7jMuTE8v22IEISyWXoDbyK2
 7OOg==
X-Gm-Message-State: AOJu0Yy64c9OyjnoVhLQl7C4FKB8GjJ+dK/TEUV9y7d1EAzrsfUPlqVS
 clgWISVvW45m+YVt7TcXj5xfuV8duO8kkouHEJTYfdop2CAZ8k/SFdSegLZjx2aIc/M=
X-Gm-Gg: AeBDievGdYELGSn7M3R1qnKqgSf7sBASSkVnUrpegj6k1Z9U6XaWkrTUT4wfHmJODXV
 G61FZCt1pwx0/OgOH1DSq4V+OZr1CfQDxA+5T994LEqnbrZX0YE3ll7vRj0ThfV76AD+zpaNIA6
 tPw0QORRz+A5EwEkEeCKGGl0be796sP31VYezpNXtumYWOBR9TTbJNiDS5nS+Ph5ja4vmuGylLe
 fpJz3mPHDFR4zVnM2VAFGa1tl7+duV7rur7xx+kzUOkZUgYwFbfHsIGO8ZRecqrhzsCcWRzSntm
 FkGs8XDkPmzuyFZR+xrva1BtXHCt1AANuHWZpx4Ofhf54dWN7zu95LwyIBgGOXVbjUmoBMxFVsT
 t/XyAtN0L3kYD8PSqNuwNTysXKGahF7KRoM1mYPJ67fGy9c+L966t0RJ2juU9U5HG3aGN/jgU4/
 o/H3ntG/0NdfxiwPEIduYTpjUXWZiTHaw=
X-Received: by 2002:a17:907:cb08:b0:b98:40a3:aa0c with SMTP id
 a640c23a62f3a-b9d7279740bmr885417866b.24.1776269028883; 
 Wed, 15 Apr 2026 09:03:48 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33d6d3sm6493297f8f.8.2026.04.15.09.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:03:48 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:22 +0200
Subject: [PATCH v6 01/14] arm: dts: am335x-evm: Add backlight to the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-1-94cde349bb01@baylibre.com>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
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
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=msp@baylibre.com;
 h=from:subject:message-id; bh=1ifQvbZwb2UbUrp1H9acuN2r4lT9ExZrhwgY6iwflto=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz722aGinX8ZJvAZaUiERv7tCakPzJno/CeGbPelLGnn
 m/jCg7pKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIk83cTwh9tb6IJblPwzh6Z1
 utenKwsEnzqdGMBxWKSr9EzkrX0Bqxn+is6ZV+36jDelffasTxpb1OY2FJuI/Qw7tT792YPZTHw
 1HAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

