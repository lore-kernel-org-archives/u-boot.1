Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A717F4485A
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490E38418C;
	Fri, 10 Apr 2026 15:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="eQL4IlWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020BB83DC9; Fri, 10 Apr 2026 15:32:54 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A2384105
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so14580225e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827971; x=1776432771;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0yyWrM6NJUldq00B16UViycAsr54IKp7IZgCpCJPrwI=;
 b=eQL4IlWOMgVtTBTlmOP3NrFUBWD1nRN/rEhEm1dv+PWRDHiJbaecHH4b2XR/clhVGz
 Oub9feSfxDbZkB2kaDR3AEwPCqaDjabJ9MeITeWHROLU/BNxoqRVJ7Y8pDrUmoKpkCpK
 WjXY8WopDXSwZC7bSwoHHT69jn7WG22xMauoJjcJ+hi5xha8aY6DDEBxEL4sHI8H+luB
 l5gzCciLk6IGjqDxfRa2JHWCXuUXxl5eY2OUaWUnLLyWIMd9vefTZGZLv/WlIevddqCo
 b4GdgC0NVPNBZGwp9NXNt5sn3b+HujWHFN6iDzg2tgtbMTn2/ZbFq73c2acK0hsXna/D
 lYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827971; x=1776432771;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0yyWrM6NJUldq00B16UViycAsr54IKp7IZgCpCJPrwI=;
 b=XNWWGEpWv4b1Pz1l8BKJ5hcYhCX+Ux8Nwu31dkpEc6tFO7utaj1e3EPKjzZpLkd+GH
 AHqYei68pJul2JumuVYhi6mvHcurwld4xYT+4tobQrfKNsMd1EBETFOQkjwS7to1P8z+
 O6G4l/LgEyN8yX47vtTHzL6jEZYewxfmwy9+Fgb4u3pCSkHkKHGEOWha/Jkt+ZKcx3k6
 1RbYn8pFRgqJCqodfBCo9cZL2vdNmU5TNj29/UdC41XUjjf2VL0SlQ0R697Tf4Jem1+X
 Iqin+B5RRSc4o437GEu28nhbp5ykbpoWpES9CXaat/W7ynPsCqEblyeUdyNDtnaNkZ+G
 sqww==
X-Gm-Message-State: AOJu0YxfqJcoNdtTOsbSU2Ak0MHYPJdNHSuXOj7Gayft6twecZkz4NgM
 8aPUZAVJRLzlu6W8cXSTuZuB3DP7oin2OO79skNYUMbHE/a0RK8Sb3zmE3OpwR8Hdb4=
X-Gm-Gg: AeBDietEh9bX1WMhf+mWebhZ/mxifCdiSTOMIlDcEiLwvN+gBmfAAwrPyh9WrERY4kc
 73M8dyI8cI+7Jpc0z5VDi62MJW8qO0MVEXVqp4Nzlr/drK7YXV8JouO/DhD3NxdZGzIz0bN2/yG
 P1n16A1neC+4gEYorIzXpR7yu12EUN8ez07Uk6aZPKIkf6IKsVJe+8SHxQ+hQ38Ogiax20J1R9Q
 qymhKkQ8iGY6Nc8h7EwpyHR6IQukirI0mcx56EyYQPumiHszk0i91Q+Fyl5FlIunUzAgHX6dzF3
 n1zD+yls+0O4lJWDEm7ExA3XiJ57eDIVgluqiiToWk23dC2bPnGis41cfqwdOdiqFfOwMR5Xr+r
 21hwY9lJQLuybaZGw58rjBssbioY9MVI/kC8ctDVKlbHmr4a8bK/il8j3IIWJmc35qWfyNiKANP
 olmsOkEvIg8+FUwuUm5mW1
X-Received: by 2002:a05:600c:34d3:b0:488:a25e:14b2 with SMTP id
 5b1f17b1804b1-488d67d2534mr38659665e9.9.1775827971472; 
 Fri, 10 Apr 2026 06:32:51 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5888acbsm88043335e9.1.2026.04.10.06.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:32:51 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:41 +0200
Subject: [PATCH v5 01/12] arm: dts: am335x-evm: Add backlight to the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-1-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
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
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=msp@baylibre.com;
 h=from:subject:message-id; bh=1ifQvbZwb2UbUrp1H9acuN2r4lT9ExZrhwgY6iwflto=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbv4/VhEsetFgmqPG62fLhvVgmgVtthXtD9/zcM136j
 dmygjqbjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhIxwyG/+XFG96c89e1U55t
 sPjgvNlc84NvlgWd406a9u742cjlvZyMDI0/mDq8sndl/S40WnJM+pm9Xo8dh1DZ2kpjHTbd159
 PMQEA
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

