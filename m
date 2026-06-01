Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C5ECD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED5EE84A09;
	Mon,  1 Jun 2026 14:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="D4xV/SB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8904D8485F; Mon,  1 Jun 2026 11:32:36 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A9C84837
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so2462856f8f.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306354; x=1780911154; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dfbfH8v4xySYdPtSrwrUYkHcl/53g9TkVInwERrltt4=;
 b=D4xV/SB/jH0EQTYnI6bJn9k+Gc6iI9taTrxOrltqnm91eTMpPDkc+t3yyVtPP+N/V5
 cYDKN0DIWYWvttF2whVuwvPwRRfU5dQKZfTohvugySArz2sYjqcBaUWDjiv0lh1J67mx
 /1GBl/j01skgR/08xyAvoneUregOD6JNrxHPMAy5l73wvIaU6MovEl3jEpXUQiXQnr8X
 Ll33oOF0qwYwJcP3bK42iIy4rofkfkGl4VSezZQmyZRc11TgqEVnTR3tYTdXgwXq7t7d
 s6HwDlOg7fiH/oi7M+y8tnQIL8JxggLT4xH++349flh9l0M8bQKAvM+e5c/SNAsD0oYG
 cf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306354; x=1780911154;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dfbfH8v4xySYdPtSrwrUYkHcl/53g9TkVInwERrltt4=;
 b=nNDiNM9asbmZnOhen01tcfD9FmCIIXGtFwWe38hDsMsOqxNiG8LrCTWkzbpz4Gwcf6
 MYbDsZZdHXZj+aQ5hfmUtbqgLS6wIdmBp+UXh0RjxsC3PjB/HiiO262npZHOctC9Eon6
 skI7S5Krsag3He2Yp9v87upTCbIgr0rcUXCULxbZVXwyfvW1/D0Z6uG4y+emFLIdOg+g
 3k4BmlZ2ZCnBC6jpwmSf4icF0u/z9HquUzz6iwabPK+BOtwxZ9hxEQVC+ynJBTmyZL2+
 4geWAXlVTrMAAeTckqVo0iatc90m9X/kvFR82bI4OexOQQEbc301zhyhyh1dIsUhDS7c
 Q3Hw==
X-Gm-Message-State: AOJu0YwRJf/nH0KyLeWp9HQzbze7T3rMsQAmPBK+dWl3bVDk6QzFsKDT
 Sr+OO3Nm2bV327L6GXuBHsCJ/hcSouhsEMfztIOW/ldzwJ8CAZlfjYpLr8Pt/D9oFG8=
X-Gm-Gg: Acq92OFQJx31cAYCb+1Rb4kC3WPPqqYyPjUBHvxsbmt5+hQvo676Z71vNb5yUwjmIbU
 rt4Lyh5GKRSI8Ku3h8uDn3RgUVEl7M6QrA7DuvegsFN2r7Xbb0GZ/t8FwXJyZKp/V8bv49gQMRj
 d0XcQ0mUmc0dxHI/i6b9cyvovXF/R+7UYJJsz66R60wUWHLuXMJr8bc/w1BcevuDzXjGeFYUUAv
 hofZNmszBA9AGqVQMm4u+2QDD1n6vCfqAqFFudLZKURyWBr7AyYzD5uYXKGUOa02jPITvBL4Bif
 OENBXh6AwaTQoO1ysQHus225WOQWB8lzDZHcV+2NG5sF/zDibhkmHLW1+960YR3G2uRiGBCrT2u
 QenRmWEpIrE9/Fo2/OpBa2L+uc783G+b8upgutChiHroSJamR2UIqU0HuikgruGrzn2b7+owMJR
 brOVod4gRoEA8ysTugcNJ8UVl02rMpO+8=
X-Received: by 2002:a05:600c:190b:b0:48f:f64c:c2fe with SMTP id
 5b1f17b1804b1-490a298f29amr177503285e9.22.1780306353727; 
 Mon, 01 Jun 2026 02:32:33 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c6319ddsm227848155e9.0.2026.06.01.02.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:33 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:45 +0200
Subject: [PATCH v8 10/17] am33xx: Support upstream devicetree USB device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-10-2c33c98e7ce5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1798; i=msp@baylibre.com;
 h=from:subject:message-id; bh=oGUl/xSpWiXGTDltDl4GA7ou+PXomTKYifn9AASTqDE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwNJwg7lxyxJfe1bwf3mj/qLUVDZN+iZryHdZ/kccV
 27f+GvaUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABO5yMPwPzFSTf7LebEK5re9
 Vybdf3XV4DnLkWdis8SO6f7Sf8G2mJuR4cfn0/ZLBfafPGyvMSfyPKPclHucP0o21SiUFpU8CGL
 iZQYA
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

Support musb being probed by ti,musb-am33xx. The non-upstream DT probing
used a wrapper driver that probed ti-musb-peripheral and ti-musb-host.
This wrapper registered as UCLASS_MISC, which is why it is requested in
this board.c file.

With the new devicetree the wrapper that registers as UCLASS_MISC is
gone, instead the UCLASS_USB and UCLASS_USB_GADGET_GENERIC have to be
requested.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index c3931900622957a5499fe6483473c61e3a62fff0..5a006cf309b08d0e035faeb675368da73076e7ed 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -264,15 +264,19 @@ int arch_misc_init(void)
 int arch_misc_init(void)
 {
 	struct udevice *dev;
-	int ret;
+	int ret = 0;
 
-	/*
-	 * Trigger probe of the UCLASS_MISC device which is a USB wrapper driver
-	 * ti-musb-wrapper that handles all usb host and gadget devices.
-	 */
-	ret = uclass_first_device_err(UCLASS_MISC, &dev);
-	if (ret)
-		printf("Failed probing USB %d, continue without USB\n", ret);
+	if (!IS_ENABLED(CONFIG_OF_UPSTREAM)) {
+		/*
+		 * Trigger probe of the UCLASS_MISC device which is a USB
+		 * wrapper driver ti-musb-wrapper that handles all usb host and
+		 * gadget devices. Note that with OF_UPSTREAM the devices are
+		 * bound directly, no wrapper necessary.
+		 */
+		ret = uclass_first_device_err(UCLASS_MISC, &dev);
+		if (ret)
+			printf("Failed probing USB %d, continue without USB\n", ret);
+	}
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
 	if (!ret)

-- 
2.53.0

