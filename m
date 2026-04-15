Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A08F43857
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEBA8421D;
	Wed, 15 Apr 2026 18:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aZm04MZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36DA58424E; Wed, 15 Apr 2026 18:04:08 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E177084262
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso70765855e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269041; x=1776873841;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hYyxbWXOTpIsYP21GviHDjwzXuyMqtz6kllMl4D+u8k=;
 b=aZm04MZVy5P67pj5KXuek4aG/nZOmS8snCZXwbNg145VfMLYYxFK4FZ9O1p17Pc6Fb
 EeI4WDmMuqoKr2nK1JwIe/IszezmkTeLWL5pL0e9Ys1tBOozRxRcfBidMLa6OYaS/j43
 lg8d4p3ib1ARbHbFsTaeGvozn+nDS0+Fwi6jgYTBUoSeYuI1YQw/8bwqkIN1gxNha9gw
 MRKr1DKUkoSu2+tYH/EEPxoNP9luZAxtAx8Dg7ih7xC0NZ57Jf4BTkZUFr0DsCkhUY+w
 Bt9BEZ2A16A81XU6Ofl87JrSMHZ1UGsfverwG+b6e1vXYaJSEgbVN8InDeDleTWy7OSf
 RydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269041; x=1776873841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hYyxbWXOTpIsYP21GviHDjwzXuyMqtz6kllMl4D+u8k=;
 b=U4CEwiOAM54ytK+GWy/jKupVEnmgoz2HuRU/AxgxXBP6i646XGQqyROxcIx32Uco38
 f1a8PoVYAVlHk8mToEi2ppKt2EYePDfRHUXfw1qEDg2C35GK+pesTtmPJAV/EAJIgULq
 NQOARoKHg7dLf4aeaBnbaPD7FyioL2BGG3J/8lO2wYRH8XnxmZFBMmo9pqbAAysKbBSW
 wZA+npZMZTwcohBHtcHqreIcXJX+hUecUJloWbh07te1hmiaRhrUWxq2dx8QfELb27Cn
 cH1e9lgkAB5EIPVMWhW4Zpg8otJYZJNWwkhvMXohMV9jY71sukE6EkC6Hksavd+2nDHH
 hJFQ==
X-Gm-Message-State: AOJu0YzARjrF+B8OcYTI9OFE51Wq0Cr/jRzf8f2Z3j4c2EjWRRBHAQnD
 WZYw7yEEkk0e7vdROOXSjXcx4DsHS4+770l+YRkJnuEJ25tvnjJZcuC+42k3iaGNC7U=
X-Gm-Gg: AeBDievdgwIK76DuzhVn8C9hIqrC0tKGbWjC6sFphSaMwvjZjOkyzOr3bxWMzsWMz0e
 5w1P18cvF+OV5pFjRwvEN3f3QpeIWbesCXTQn3BFB6F7LRNiCTGrFdl50HBC5GfyADg9ajw/Glj
 okOA/4lN3yGspxpB6SrfzMNRviPzFkDzgY72rMypRHji0uGKkxB2FSioO/8b/X7kV7SAfAG7UEf
 gPRZ4+m8dqqkMYWG4riN/U7xaziS/1TsoDmUYVayKYnBdz454Z2UZjm7ONs4K78SAMj+XIqj9Y5
 7c8IpYvMFzbOh+DK+UmRlpiE+nRaMm+YF/yG0cVfc5YiWYUUvcShZxgp7z3XuO6hg+G5J3FNWQA
 KRZ+CpfObFunGd9f7PZ/lDmH1GxKevf67h9guA5U0F7TnTmoM1aE/pSpv2sZ0eHVlaqIVBl168e
 hYXJl0gw6CI2xYNzGaDxjgtbLyB0EhJFs=
X-Received: by 2002:a05:600c:620f:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-488f45cc718mr2002645e9.3.1776269041263; 
 Wed, 15 Apr 2026 09:04:01 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e05bsm232549345e9.6.2026.04.15.09.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:04:00 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:31 +0200
Subject: [PATCH v6 10/14] am33xx: Support upstream devicetree USB device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-10-94cde349bb01@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=msp@baylibre.com;
 h=from:subject:message-id; bh=q3wYaGY0+aA2jhNMP0CNM/HhLVRpzNZtCwxxFigoQOw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz7245u4VrT+oTNWbWwRtCvL0XMg2H98xtOaRPe81WvO
 /UoUCqno5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZy9xzDP50pfKtXWFTUX5HX
 LhRr+jg9fPYms7s/PpmXBIrIfFb+dojhf43JeX7nnpVTgjY5z/u/e8G31YsurArY060pzrF+4+3
 f2/gB
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

