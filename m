Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C11CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B00849C5;
	Mon,  1 Jun 2026 14:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZHNGvOuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2A7846A3; Mon,  1 Jun 2026 11:32:24 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DED4E8484C
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so67192255e9.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306341; x=1780911141; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0yyWrM6NJUldq00B16UViycAsr54IKp7IZgCpCJPrwI=;
 b=ZHNGvOuqKgorbDqfNRJZvB5xjAXzazoCeAcwcgds9YYWzlfPvsagNH8At+3ig1oLGd
 C/VvHTtxR3fvuYIbMj8N9L4EMR0+t7gNJv7r0mmutrtzzBF1mV2CZdj8vuKL811E8D5k
 IA1e/54B3RdGuYOP8iGO6HlsThbx00HtKTkslxUcOBF5p7CBv60JHd4HNlPYtAgRIdlt
 0B4S0atZhyomETF+cVKlsPh2bsYOgwkuKFXp1ouaywnOivc8U1ENo9yLe1wCGA0dRZsF
 gqYzvLnOebM9dh8Dcrr0A7HmkV4i+tA5aJKpWvOoRqGeLvDQvTSPS3kSiNGw0NiYQ6/V
 ROfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306341; x=1780911141;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0yyWrM6NJUldq00B16UViycAsr54IKp7IZgCpCJPrwI=;
 b=i8uuwnyUx2dQufPCRiXSyw+VzU8HkitkufVOjawEPVP4J7bYHLYzM1oCrH4unzJ4QY
 Vr5t5hsWFld5pXPp77TqbIwnWDynwGp0nXLpCR5D+AqU8LvvrN6ffdsVbPadSjkYZ+k9
 hpWz9QzhD7QOmHIrD0S+pAwGO0UfT9AqKL7gI69UlWa+De09jhogwoaugrj1jKJkC1fH
 QKCBESQ4GJkE0JecJAfFdTnlGDPERXw6E5az5hEG2s7bgSOHBUYwPnSQR14ALY5cO1SY
 vrUyx+L+FXa9JyW4VN/vDqtg/RjH3SChXZmTJqDGMS6zwee8Azvz6gNRUmbkKEnG5Og0
 Ln6g==
X-Gm-Message-State: AOJu0YyBwD5+qEXxfvp61fVyGkmDxaY2RXIICmRxeH0UtOiiK4Pdh/kt
 Gk9DhIHWDTNaMAA5FwRTdTYtRk4qttLB7R/YJ9lkflmQW7pEYSUSzU+nE/Zk0wTX3ik=
X-Gm-Gg: Acq92OHbG+LxsOQ2UvLWMho1jInok2HUw0Fe/seTbbJtNksOJFho18DPS+QQCGbyfAD
 x3jDNQotxa4ZFtxUeqz8Qbs9PiGhH6CsssQM03qoYzyHWn3l4XPDJmXGS3u60VpN6srJqv5EpkM
 563d+X7m8SRwgHrfhMICZe4fG+HyEBDmh0Desyux/cOQiupkdP2l4sFlsC1BkQFUA5CrdCQ9dT4
 U6mjZYGpaMCDksMcrkPJtGpFLURMLoK84ZyJlxupNpNcO5fYMm5pqA6foy7upvSGyQdHOPb4OC9
 A/8Sg9m8Yr2bAQj+lci7B8Euf7zZ+EeY6V3WSuQ/1yARzaCWnJPYT4FlIoOBb06AthrUXv020fi
 zFsEhkvmWPMQIv5yPmdUazstrZzFbw2J2TbFjvsSOitDwQ8nmoKYGpVFGe3fxO9VoXOdLyz3Jjs
 ZUNZvd2idQCs3nRnnfpkzCbvdIXtzjfYFCSDeslcrcYA==
X-Received: by 2002:a05:600c:1991:b0:490:acb8:1490 with SMTP id
 5b1f17b1804b1-490acb815c4mr31264815e9.4.1780306341203; 
 Mon, 01 Jun 2026 02:32:21 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0d5dc2sm100563315e9.2.2026.06.01.02.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:20 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:36 +0200
Subject: [PATCH v8 01/17] arm: dts: am335x-evm: Add backlight to the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-1-2c33c98e7ce5@baylibre.com>
References: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
In-Reply-To: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
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
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=msp@baylibre.com;
 h=from:subject:message-id; bh=1ifQvbZwb2UbUrp1H9acuN2r4lT9ExZrhwgY6iwflto=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZQNcCI/VN2v4XTyYXnempYpTPuZN+YvZRXW37ixOUK
 nqyH9R1lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwESYtjH8T7X8Z3z94nzhNzdn
 bkpn3qajK7m5oLCKe19J1q/rzx/dtGJkmByq5u2UN/m/+0zdyy5GJy59YpJbGm633nRtUNzNiWL
 OTAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

