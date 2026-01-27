Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9D9D340BC
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C42684181;
	Tue, 27 Jan 2026 17:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Up2zh8wK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526FB84181; Tue, 27 Jan 2026 17:51:19 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F088418E
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4801d21c411so31613965e9.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532677; x=1770137477;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JMvrKGm8iMO8vDqnCCQ1AFfC9GSHWim+Ld/hrGa1pIo=;
 b=Up2zh8wKT3llEdUeZqm3uMkcWBCW7zND/tjFDqKA02o8VRr7hyT5Pic40H5lQ9A9qp
 BYq4PnLpA9xyTT217HVoZ/xkgkkMdv3AYgeP28yCs4gb102ojV1zzvyusrbifWP35Wus
 v6H5eJ855LGKTi720zI32mo+dtBQX5UUhP1FROUzUNJxFa2/KlkBjzMzbVI81Jggs4Of
 yV/6N0IzzRY/ke3SSyPu/5xW7MYfnDNL+AeY6N5RA9HnTSYXuHVgMpMfpNRfxSPTiYHy
 2MUNeSOd3jm66opDUD4+amcMHTtuU5SkB+Sywg3A5n6djsfCozMXJrBedOjYv8cvMQ/m
 IjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532677; x=1770137477;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JMvrKGm8iMO8vDqnCCQ1AFfC9GSHWim+Ld/hrGa1pIo=;
 b=NAWGOyukuuhOJtPgwq3CKHnmioOlAJOu9qs9wjREPrF70mOA2607om+N+Sf/JpeCXN
 tTB72Bqnexy5ZJHFOfJiRanGz4MbwmTzejOc/Y6ZqA/ZkSUF42qshmy6c2inOCQYRrGg
 941J/ON/QVpRb0+6u2fSkHIYfArk4wc8H1kTG9IHJCBgxPbqKjnV+7/y6mkPVI+Ozf/Q
 UIL0qZ/PRiglansa+pz8NUtZOz5t8FCJ2C+2igVvNd6EeiVEvkcgDTsecfmQFyBsgyPc
 MzarACBWcny5iHI3jJiOIFbNV5NRPAZ754mdMpabWoDNQEL5ZrktdKT1T//eZF8QUzPV
 R0oA==
X-Gm-Message-State: AOJu0YxJWHpvzZeWhqkXddglDJrfP5EvJEp9TK3cBUsge2M1DMg3CULI
 9P+DLjC+LB9BqcquZyfMmwzy9y4yPrSutCs37eRtlQyrxkLkpYZbfTb6FmiEBH2WWpg=
X-Gm-Gg: AZuq6aIV5JCly0UsouXvd23eVx1zAaJTB3w94BA0qGyY57yJ2M6OxNNyM5PCm7lETgb
 4Di1aIIGKeCm6FnSEvHWKLY8KJmZZPrUwAgAJTy1QmCDUPA2V9qEMWsluHwrYb/lyMID1EjLuQs
 E8IZTzFyYeu8smoOEmRApIFwPNi5QNi1xCxnII2uWJJsz3BVU7hyPNJJuZrnSQek0zRyl+OEPXi
 7Ci9yTfRyZLr3Aqb3ftWoGuG1koP8zIBbuBSsPVE+SM4qWA4oHCF1P83jlZvRNX/9SUZ6x8Z86d
 flGZWGQ/FzUXRBzetINEf8xQdEK4n3EE8mRvNtIVS/cmIpKKHdJ55k/fjVemahz/y+YVw8h3Sj0
 OnDfCXHhCt8d478LUCBZQjX3GAyJm5WmmKYYk/s8a+YCxUdfb70gWDV8IeB9fSRpjRObHGZf3W2
 DBXvXUztBF
X-Received: by 2002:a05:600c:3b96:b0:477:63b5:6f76 with SMTP id
 5b1f17b1804b1-48069c53d44mr38254145e9.25.1769532676851; 
 Tue, 27 Jan 2026 08:51:16 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm66426595e9.7.2026.01.27.08.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:16 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 17:48:23 +0100
Subject: [PATCH v4 09/10] am33xx: Support upstream devicetree USB device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-9-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JtolNpG9Ib4Oo0LBvcJkemyzngqceDyWoKMeqtCotFk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN689DT2mh5ryHWiaWXou8tGTHTY6lb3tft6vGzvXS
 V032/quo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACbiuZ+Rof+7Ixu389T0d68+
 TQj4EpfX/eD81ZimY58/LtvzqH/9rmxGhq1TVTdf1W0WvOvmHm6UFcBdzuY3Y1Fnwk3LqH2iXDl
 lDAA=
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

