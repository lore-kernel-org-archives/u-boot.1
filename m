Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442BAF44863
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED1884201;
	Fri, 10 Apr 2026 15:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="RegMYqpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A917A84228; Fri, 10 Apr 2026 15:33:05 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7BBF84099
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43cf5ad500fso1695489f8f.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827983; x=1776432783;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hYyxbWXOTpIsYP21GviHDjwzXuyMqtz6kllMl4D+u8k=;
 b=RegMYqpxuNU4J4q2ygbwSLk8bj4P0LpTjpbRUAomYKJFee+Lbq1gOXDVnoKREiRW77
 AuDZl0dVZZLPEDXLOoLIqWsAvXmDz0/18wpt9Ivxh8fOAKdWoWcEHosfUOcKaNMx2Fej
 ny3TerOh+SaCGCgSKp5VwH0X5yIAOTTqYWnFXzZUfJEONpJGvmJGuSvjkH8h28fw8KXS
 26/MUaoUiOny6oyHGzoA7xVQLL0xJnZYROpRYkYqO+7ZiyjCgDwHGw/FZqzTagjwKiaG
 PKz9udBII+eSGSnocltsZWA+jGQ5hEqLFJDuP1dRCsY0g88r14RNbaVQSqZ8eQeUZl0m
 M/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827983; x=1776432783;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hYyxbWXOTpIsYP21GviHDjwzXuyMqtz6kllMl4D+u8k=;
 b=l0B9sNxXSf/JrYAbRoYK0uDP+MLDzaMi8bzvf4SHXveULtGSioOXOeqSf2Zfy3/+qA
 kD0oFe2lfsFR4TqVFICepsa57aAu9nGqYSjMH86c+0MLO6w0TQcvwGpkk2tocgWwwszx
 YJMZStrtI4LpR52wAQBLjNUIK047YpuAExXA37/1oPb7JJ/F4sFW+tMSIpetonqAQb5q
 4mMGEb1h9nESye6F6Smdd6N9tHfPy7tbvDTq1kPNAwEPySAwNLJX+dBbVSxpGiwLTbVw
 iQMxBnbeSyJ5PL8KR8InjkTUDwXlp6JvkzqIQZ/mhLSq1IPt9z28OBAH54pE317+u5xE
 9Rjg==
X-Gm-Message-State: AOJu0YwVQmLmd3UvvBQpTcEaJGYGktUlrbmQSuLcaL+xo1TUQ0Q90HrR
 MKw2EecolhKv3Mw0psfijlIcHuo31FctrxM/OuXrqhPBB4vUaOLcby+ZY/QzWPzHyJM=
X-Gm-Gg: AeBDievino0CQC9JsOypG19Z4q8M5m84vnvCsUG6YPi37DfNBzLsnIKK9g+Ea892P21
 sbK7Vu74IxgJKiPyb8BqvvjDaWvAAMS8BioufeIo8zivfTH1MOnw/o3WWrNUsd8zekq9bnXT8uX
 VJJqP2RclHTmRqnJyfDJgoEVi5kFs6+5uuajZI8WKcvCy+1By3N3m9XpDGyxYwHKiuLvz+a92/F
 l1q2FKH+z3Zx4VnHtM6CR9IoTH7wDy+rnyhq37os69S+l0kUn1VxtTAw/PJb85EnICuDAtU9pd8
 LR01dTfxNkJ346YEoJi91nIi7sUpc/34QlsuT9mUkXSBSMfLF3OnX7sIURYcb/bapShy5BwYqnl
 QD9B8tx7DHLfNJQ5MkPC2nLvu4W6De+Q2L8V4BQuQuyziFjN5hntxJ7X2PSO52qZi9HiMWJ9Dog
 mNkR8C2a6hkFpl5b/qCUpd
X-Received: by 2002:a05:6000:1869:b0:43b:4e13:221f with SMTP id
 ffacd0b85a97d-43d642da684mr4869321f8f.47.1775827983107; 
 Fri, 10 Apr 2026 06:33:03 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63deb904sm8275291f8f.9.2026.04.10.06.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:33:02 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:50 +0200
Subject: [PATCH v5 10/12] am33xx: Support upstream devicetree USB device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-10-4b9c7aca0e3e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=msp@baylibre.com;
 h=from:subject:message-id; bh=q3wYaGY0+aA2jhNMP0CNM/HhLVRpzNZtCwxxFigoQOw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbvz99D/HWXCr9d0XzonaZP/arfnNoKs1rf73eZqZH+
 uHNxy6f7ShlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJFGoyMjyPr71y+/SEpfkG
 Zq2ZT3/OmrPJUN09lpdVmHlC9NI3JZaMDNfDlpm+jjthubchY2VpRQrb0raroqGdz7db9Jlv+Xb
 gMwcA
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

Support musb being probed by ti,musb-am33xx. The non-upstream DT probing
used a wrapper driver that probed ti-musb-peripheral and ti-musb-host.
This wrapper registered as UCLASS_MISC, which is why it is requested in
this board.c file.

With the new devicetree the wrapper that registers as UCLASS_MISC is
gone, instead the UCLASS_USB and UCLASS_USB_GADGET_GENERIC have to be
requested.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index c3931900622957a5499fe6483473c61e3a62fff0..20556b8fb5f1eb469469006b3483003f716146b8 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -266,11 +266,17 @@ int arch_misc_init(void)
 	struct udevice *dev;
 	int ret;
 
-	/*
-	 * Trigger probe of the UCLASS_MISC device which is a USB wrapper driver
-	 * ti-musb-wrapper that handles all usb host and gadget devices.
-	 */
-	ret = uclass_first_device_err(UCLASS_MISC, &dev);
+	if (IS_ENABLED(CONFIG_OF_UPSTREAM)) {
+		uclass_first_device_err(UCLASS_USB, &dev);
+		ret = uclass_first_device_err(UCLASS_USB_GADGET_GENERIC, &dev);
+	} else {
+		/*
+		 * Trigger probe of the UCLASS_MISC device which is a USB
+		 * wrapper driver ti-musb-wrapper that handles all usb host and
+		 * gadget devices.
+		 */
+		ret = uclass_first_device_err(UCLASS_MISC, &dev);
+	}
 	if (ret)
 		printf("Failed probing USB %d, continue without USB\n", ret);
 

-- 
2.53.0

