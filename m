Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5328CC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 13:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08EC882012;
	Sun, 23 Mar 2025 14:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="D3GehwO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A36E810FE; Sat, 22 Mar 2025 21:57:13 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C0E81D4F
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 21:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso14621655e9.3
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 13:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1742676992; x=1743281792;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MYK2YTPsaSOMy316iCWElSPRtSc/y7r1ZVTEsVCBVxk=;
 b=D3GehwO1TuXdNj5lPYn3zg6oXMPzyXVRinN61D7rwvnXYy9CBYI002k3twEie+5B9u
 1RxW9sJ/Q4EXkuT3PJylKOdD5s7LD4e4c1eQHV9ZRo/86m5Ofg/LIuHM0DUY+FcjtA4a
 6l5OM+sBacP8gwr8b2qktUjLiaZ90UeRWbu5GxJVCIQIrBaSR779UQkaLSEig5sGRNJc
 nQ48qlsk09ciaywjwJOpSHa1wCsLjcGqM1/r3jLus48xstGS8eFO6oM0JXgxSVSygSB8
 iuDK5eTOEwGjcHYdzW0am56OXth2nlmMPh6QSMhntiB5yCbyytFpzm6Ljq55S8mototG
 gsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742676992; x=1743281792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MYK2YTPsaSOMy316iCWElSPRtSc/y7r1ZVTEsVCBVxk=;
 b=QS1BM0sqjQhr6pBsszBB1FjY/stlQelfrivN7BJJ3OH1V+5IJaMYzne5XuARkdIup+
 gNChwA5oka7biF5Rx2C15Vub6F8zqiLNjLFUSiSTCb1SIdaCb6wNWYgDVywbOqJnDgWD
 seS034ghvZpLwY9mmdG82QD4kFjvS7jw7t2QRCU+KAZuaIfbY3gZhEWQ1rFnWwTfG7qz
 BUkYhvpcMZ+k+DkqNctgPrnIYmkcbEp6MTHIx52BjMl/POr9pk2yUFRmneUoKl64c8LB
 8xdrNAWGciiNr2OCon6GdsLOMurDnuFHQEWMh7JBPrGhHPYltvj0WS4xe87MiunK3oYS
 0fLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe8zuzSQcik3JQipSq+92KA1lqritbtknkbc+MvCYPrRXIroHdygwDGzah01uc0IpP1GEa3SI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9kOnXAGKN8AsC5h4aBFRjCs/LsDjub4U3qHgLMZB9im+9CJUw
 mRNo4+BOVfQezyFd2Jf1zWoH5UfoSgOlJDaw2JuQDI9aBUZf9xEgKjOVyWzfwaA=
X-Gm-Gg: ASbGncuoeDR2lxko6VTmUGtR84Nu7FVlUPA1/54ONlrorxtSwMs0F/Cg/EkQRIXU+w3
 1SfIq+IhcCr8ipjNt07u7ScN3PNcTrhLDDWzB47yfa0wFAKhZ8RL8he1Lr7mBF+xHnp3nqBxT3v
 fybl+aZ4oURJ1+T5g8U4OLCOMoFkmGfSgjKD41XxcAhsEuEgNjRPQd6f9018i3hMGuCE1KRFG7R
 7mxPMT5JF86tqyvXAngilHaVnXG2QS1182FCHiqCU89EuUouXVnWuVsl3S+AMErTI/zQtQpppuR
 GobD+NtI7DIWO3gjNOlH0WTR73Bug3Eeqiz8Q74IP+hBVWifIfvj89AHW+9glTc=
X-Google-Smtp-Source: AGHT+IHR0tMPt7COsGXblxI8wYtJivOB0P3uQsjbMY0OHukbnYgto2X1oMIDvxPzHHSM7Af1PfLogg==
X-Received: by 2002:a05:600c:4747:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-43d509e43e3mr69375295e9.3.1742676991706; 
 Sat, 22 Mar 2025 13:56:31 -0700 (PDT)
Received: from vbuilder.hifiphile.com
 ([2a01:cb14:11e8:8e01:be24:11ff:fe59:5422])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e64casm5965338f8f.73.2025.03.22.13.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 13:56:31 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH] usb: gadget: atmel: Add SAM9X60 support
Date: Sat, 22 Mar 2025 20:56:24 +0000
Message-Id: <20250322205625.1330306-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Mar 2025 14:18:39 +0100
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

Add compatible "microchip,sam9x60-udc" and device tree binding.
Compared to SAM9X5 the only difference is the DPRAM memory from the
USB High Speed Device Port (UDPHS) hardware block was increased,
so we can reuse the same endpoint data.

Tested on SAM9X60-Curiosity board with nfs and ums commands.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/sam9x60.dtsi                        | 14 ++++++++++++++
 arch/arm/mach-at91/include/mach/atmel_usba_udc.h |  2 +-
 drivers/usb/gadget/atmel_usba_udc.c              |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 3b684fc63d5..96a8faf09b3 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -69,6 +69,20 @@
 		#size-cells = <1>;
 		ranges;
 
+		usb0: gadget@500000 {
+			compatible = "microchip,sam9x60-udc";
+			reg = <0x500000 0x100000>,
+				<0xf803c000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_CORE 8>;
+			clock-names = "pclk", "hclk";
+			assigned-clocks = <&pmc PMC_TYPE_CORE 8>;
+			assigned-clock-rates = <480000000>;
+			status = "disabled";
+		};
+
 		usb1: usb@600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
diff --git a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
index 835b47d91ba..23c71985c90 100644
--- a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
+++ b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
@@ -20,7 +20,7 @@
 	}
 
 #if defined(CONFIG_AT91SAM9G45) || defined(CONFIG_AT91SAM9M10G45) || \
-	defined(CONFIG_AT91SAM9X5)
+	defined(CONFIG_AT91SAM9X5) || defined(CONFIG_SAM9X60)
 static struct usba_ep_data usba_udc_ep[] = {
 	EP("ep0", 0, 64, 1, 0, 0),
 	EP("ep1", 1, 1024, 2, 1, 1),
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index a77037a7094..f9326f0a7e7 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1443,6 +1443,7 @@ static const struct udevice_id usba_udc_ids[] = {
 	{ .compatible = "atmel,at91sam9rl-udc" },
 	{ .compatible = "atmel,at91sam9g45-udc" },
 	{ .compatible = "atmel,sama5d3-udc" },
+	{ .compatible = "microchip,sam9x60-udc" },
 	{}
 };
 
-- 
2.39.5

