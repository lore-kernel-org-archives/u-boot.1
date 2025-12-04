Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A651D1F9DE
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 847BE840DF;
	Thu,  4 Dec 2025 13:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M1fsvqkY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E16E83FA5; Thu,  4 Dec 2025 11:26:53 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63E584015
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b7277324204so118881066b.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764844001; x=1765448801;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dxUG6eBiKqCJvuP04O+fw0ydtKH0quOigkZXjnRArvI=;
 b=M1fsvqkYkDejbjCsT4qHPDaZo4ises6wDr4/D0YTHZa2cju3/HfY26Po9AGQCD0bgo
 WdCprHhDVdurzNQ5y2s+hGiAyVhbBhvYSwu2PC7aGime9H3N9DPD6BLLOnm+BqPh/bQu
 /TA7JgLjm+PjVnCm9Bbu2EdEMAdPctJP2fUJwhNqEXrBJCYeYNlFHrAyFYS7jrydnMcv
 jUHoQ/Fd72wkFugT9u1g+/h7716lzCNl2SSZ4o24gEWCdddf4RlPfPZMiUuci1reS4gt
 a2F7vtaYhlRMmY718P1Jl36vDitZKXo2YfCC9ANcrLbBE6lrFK62i6cTxM0U/mm0GS7N
 3x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764844001; x=1765448801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dxUG6eBiKqCJvuP04O+fw0ydtKH0quOigkZXjnRArvI=;
 b=bPDjESw3ajo5ZDh06PVWBxSzrJ1mZnMtZFomVMWeBOOCf70LpsobCmUMixmLUE0qwx
 8iBk7FPeup0ZjSbByW/i7WsKraMi+sGnWt25SLf4nKxeEoakKsCNOghRwv3rwDXa7C+J
 YMCZLTbQh5EISiB/J8F4Kyhy2V2uNDQ8S+PVdyJAUvQKESuZzRy4lO+nOurNG0tH9chG
 SAGVZm+ngkbuexDq4s5j6a89tID0/8pFmjkH3N53XZliy2LhWWsYMNDjWooMLJH6CER4
 9oZ+P5qpGVXmuglwbfGW64lE4bMmYrlg9zZSQQ+Tdeo4gobPO0tzFDvDbNJy1+WmW/cu
 5ayA==
X-Gm-Message-State: AOJu0YwHnd/VOdp+eAoA+4r+JE+iaViJaQxCjEvdcRa/KoIrEB25OSfS
 ATgTk98q4AjPjixdLoqJUny0fsqRDye44OutnPiKpVpiRIUoYFW+xqwb3Aq1x/KE8DE=
X-Gm-Gg: ASbGncsIZ/GFe5nBr/ZwdabGYeCq9vOqnDHi8b0YbRCqRTbeiM4h2Yev987bM549u8e
 b6ZpAeRiJHy6bR6YirMIiZAyqvJEkpUBcTJACK6tiD8CLxUIbNSnMLUTWvyFEF/u6tjiFtA5Gzs
 QR5rl58Ws1VULYuSU43q7514WcZ7J7cJty1uqdnYJzsI7cYxL0smTFn8/pvSwv2zUYYyR3Emqmy
 DAgLKwMmzFLOJwk3IVbj1C/JgWjVBf0kho+d0EkD41oLcwzD1AUNJYvgqoPBITEnVwUoeg+xXk6
 L+71aZPXyZrO/pfnQXO9hzUzUrsIVMR4yktEzolvE7ibZ/4F4eYD+Hmv6keRrgAchMyxk6NZ+7l
 qE25imgsIO14Rt6XOSgWnbyeDzo32lIcUzpSViVEUSuVYIxz7gPYOcecYFZkJcRulhT0w8fOmkT
 mCTpASBLA=
X-Google-Smtp-Source: AGHT+IHn3VvvxhUm6QN6nqVOtsZ8AB0nYr8GcgWplrznK8ntPkjIR9/1+acV7osejq8NRgeTQzG9dg==
X-Received: by 2002:a17:907:5c8:b0:b73:21af:99d4 with SMTP id
 a640c23a62f3a-b79ec473903mr242999566b.24.1764844001218; 
 Thu, 04 Dec 2025 02:26:41 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f445967fsm94637466b.10.2025.12.04.02.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:40 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 11:25:44 +0100
Subject: [PATCH v3 8/9] am33xx: Support upstream devicetree USB device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-8-3d1566ce4dc7@baylibre.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=msp@baylibre.com;
 h=from:subject:message-id; bh=IiE+vs1wlXtSAKgWwsqkG24+Nz8ibSF5V56Oqw0ALIY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxLOXSrd53Qry+mKdsLhYbtFa259P1Ny/tsf21dTkJ
 hb7sEZ3lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwEQW/mFkaFBknhI2N4/liV+S
 TE3srqD3d9uXLkwvu1418/Fz0TM3cxn+Gd5wmFSxRfPhNdumRfo5HUnyPcZsel0WIW6/kwRvFfH
 zAAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
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
2.51.0

