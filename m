Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16970D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0E283D9C;
	Fri, 28 Nov 2025 23:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VimWrBF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE0B83B8B; Fri, 28 Nov 2025 21:47:44 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3600583B63
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso18312035e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764362862; x=1764967662;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P2nb3Qx1L4Tb//gNj8tpT8eT2ePMlgaZxIGoSggfdUs=;
 b=VimWrBF9d5046GQo3xjDH/6j4l8q0KRal61Ky52Ry2f5nUfli1gZ8D9pO/FgQeQYoV
 yUqHSFk+jvZ+ONn/8GLUbZTUcY2JFesaGqNPXAMuP2MK88BffUnyEI8npe4W6TLqeJfA
 +nMFH73vKnENmR0T61pM0ep1ejSRijFQdK3k1GtmGIs8gGf71HdtYZwCIAWwdc8Yzdof
 XuZEb1CSSaIdoxTyzqxvaclY6lmxlC0ZjpnVbNd5Otx3EFZielFcQcbpNumASsmh1G7+
 j5hp2B/Q7nHiPZN4038UsntXlnC3z/CbEWJiqH9AE1XsU0Dvv0Pq8qknI+2w06rZGjGT
 Zkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764362862; x=1764967662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P2nb3Qx1L4Tb//gNj8tpT8eT2ePMlgaZxIGoSggfdUs=;
 b=RUYI49a38EghSP8jEkILPEfbPCUbQ7tPoHIUxZSPMNptRGDyOlxXj2YF6UaW2LeuYp
 dyEhQsqxFYLY9iGo2NO6mXeQXvMcvAk1LeURKyviL7BgqxtUYBi7nL1pT7VTNm+3sDcE
 D/V63bqMCB6a2gArqgiVD162JheGl3og7nGz1N+tiV4NrouJd+clQii+KkobhCw5VwIL
 YLGmQCB3eQjj6QKAySplzoypzaqdNdvdi5s+aYe5HuHJ9oQhCUZwSY+mP8m0oi2xNTnb
 QZdvI746VVOGEqekPnVOGC2vnBRsXHckt3yHITaJuLMV2wMdAJBaXqYlOHXFZJtdrhoA
 eJ4Q==
X-Gm-Message-State: AOJu0Yyfo0QBkDHwSXaVj+kHtJHOkD6y7k9Kqhmx2fPw9jxTQWgnbX3E
 pGuiEjT3v/8gJJi5qDlCyCvem5oHKqxulUSy7KaAujbsPZNZ4Y/NlNfUtt/MFLfqtsI=
X-Gm-Gg: ASbGnctNP5lBF/Mb5eTLvziKBJalbw1zr+eZkvrZChqfrElGFlYPDCt/TLl7lPNixlH
 +S02g77ZWkCLKZ5tdUnCKIfks8IoLeP/CDF3oeHvb97jmWUlFf5RI9EoJk0wxHY6tzZsMM+VHpN
 egy9zfQ2w/S2MW7P2Su4RN86BVwOg80R+vQ8WbOIe8fzVvfFNCkZjnvt2uGzUCLnEVly2ODLUUH
 jb+FUaaRJaIOYmHK318yESXWVP37Sgpw1J7wQ0zAvyD5XgWSKtQv8EjAo7J1i7Dk8kD9wygNjuR
 sOAGiWj1Y9CEgWQtVtRycJFEKX15/ZdXJQUecWXbeIFJGsw4ZUyJR429aRi2myZgBs0I1sQ7rPn
 0OWw+FKuBeuVpDpNdQFzZaMBENwQTnoxMlv7DyuZY2lXvyGQhW5oPrYXoceP8WKtof30RkGwC+J
 hDl5AhF+Y=
X-Google-Smtp-Source: AGHT+IEp0esy2VkOxHZFLfcUQhTOWGQ6Wvk5zXrg7qocl59ukeGDgCVFq7XUFWCQ8F4WC5wE/3Heqw==
X-Received: by 2002:a05:600c:35c6:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-477c0513e47mr369765785e9.12.1764362861627; 
 Fri, 28 Nov 2025 12:47:41 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4791163e3dasm104291915e9.11.2025.11.28.12.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:47:41 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 21:46:36 +0100
Subject: [PATCH v2 6/7] am33xx: Support upstream devicetree binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-evm-oftree-v2026-01-v2-6-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=msp@baylibre.com;
 h=from:subject:message-id; bh=sRhdoiB22/GyVw+mNVOUheplx6PNL2RHzK67IsrT7no=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtrrDVs63+Wx49ojfDeY/B9hOP+BfWnixon/J1wqvbJ
 jPuRQlN6ihlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJ1Bsw/M9rDvrL2cgr0vv9
 sl+l4sNrpyoWTTVP/tXkr/XS1HN3/zxGhpWsjW9XR01zZZyorLrWatNj5U+TXXfmmUY8ndU+2aL
 rOh8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

Also don't fail if the USB devices are not available.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index d7db260513308257f142ea70d5d5c643afc920c9..4bfdb55b2dd5c66cd58bce360cf1c69fb7a00cd6 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -266,12 +266,16 @@ int arch_misc_init(void)
 	struct udevice *dev;
 	int ret;
 
-	ret = uclass_first_device_err(UCLASS_MISC, &dev);
-	if (ret)
-		return ret;
+	if (IS_ENABLED(CONFIG_OF_UPSTREAM)) {
+		uclass_first_device_err(UCLASS_USB, &dev);
+		ret = uclass_first_device_err(UCLASS_USB_GADGET_GENERIC, &dev);
+	} else {
+		ret = uclass_first_device_err(UCLASS_MISC, &dev);
+	}
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
-	usb_ether_init();
+	if (!ret)
+		usb_ether_init();
 #endif
 
 	return 0;

-- 
2.51.0

