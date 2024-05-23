Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949E0C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 09:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD6F884FF;
	Thu, 23 May 2024 11:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BhxSh8H4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E8D88516; Thu, 23 May 2024 11:27:17 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AE8884FE
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 11:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e73359b8fbso41245191fa.2
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716456435; x=1717061235;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F9WRkOnxyqKaEMc6jXlTD6ifS2asOMvR3L984Hxj99A=;
 b=BhxSh8H4QZlwoFXjN9uXcftA/KYF/mSeZruyC5HDEt8e5tAyWpE6rDaOsH7Zs4THAi
 fAuqxnuoNAFG4GO6D/rXP5TBwOwyCLC7rxCydTxUmg4j0aq50FDz7jt9lT2zNcdBB6AO
 adC75WiEZJEndvNKTHVJDg0gMyEiCSvpQ7GtrFUQ31iennH7FH9btNXSMyxfyEQ7wmPl
 Tpp6EviwNaVSxEhTZdvX1VoK+zQ0nX++BZS6LRUXqrNjYyiWt9aoSI/3NspjrteRS6yS
 p+RArjHZndXaFKZZ64knZG8exblgdfhhCPd33WoyMcE2exIH3Re2h6DEWhteDrONcVHE
 jioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716456435; x=1717061235;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F9WRkOnxyqKaEMc6jXlTD6ifS2asOMvR3L984Hxj99A=;
 b=ZPdzKJ/g8Rr7/kFFa2qEX3lMJXU5L6Ex8PKWOYkHRc0KNEWrvpRCXOVEywckx1U9vr
 PySvW4Or2HCO7M+tiSRPrhAbz73AJxcO0VJ1RQoufs9sXRyLSPSLcHCN4bv+piRmy3fJ
 IOlI1aDhjSfe/5WJx09gg8eaqXv1ahsT5gO8VDHw75rtfxo/Ddl2LbFfDrNspfvzBLXs
 d2p0gb81CEF7TVbRNW0nECYi/sWBus/7/7dKj1b4tUIRnGrjjBNwYiI7RhkWc32J+osx
 7yl3RJ9qVe5XpIupgo48c7tGhsK+PwPzipwf5INYvkm+E9XvXqHZiCff8qXjNjmD8jvx
 uAcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgRQrk0FFmqlaqQ8wKelbia3dE4PNsk0OlOf0GblC8Y8TpFE0dXcPWRP2blkyOBPGwCsIO70eYSdmjBQFrT1YbwyFgOA==
X-Gm-Message-State: AOJu0Yzz5ee1D/v+IIMg7DSEHJtkqCGsGXGrA6qG4GNl5YLn2+EE7PRN
 fqeMUdDZ046qIaS0Tsb+fytPIwhX2US7Q1JilOZHW6sqc8ftmWzGKd9Zhy8kLTA=
X-Google-Smtp-Source: AGHT+IHxbxvb8c18UcqQeeoRx/pYasBO537A1yzWIxthSqFtb8DHHJGqfN2zdYYhcTudPgAhFHEFjA==
X-Received: by 2002:a2e:9bc7:0:b0:2da:a73:4f29 with SMTP id
 38308e7fff4ca-2e9494fa890mr40308781fa.30.1716456434949; 
 Thu, 23 May 2024 02:27:14 -0700 (PDT)
Received: from mkorpershoek-xps13.local
 (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr. [86.206.229.59])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fb99e8sm19570375e9.43.2024.05.23.02.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 02:27:14 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 23 May 2024 11:27:09 +0200
Subject: [PATCH] image: Set load_end on partial loads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-image-partial-decomp-v1-1-af036235963a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOwLT2YC/x2MQQqAIBAAvxJ7bsG0IvtKdFhyq4Uy0Ygg+nvSc
 QZmHkgchRP0xQORL0ly+AxVWcC0kl8YxWUGrXStGm1QdsoyUDyFNnQ8HXtA17aqZms7NgQ5DZF
 nuf/tML7vB8ti/ItmAAAA
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-b6b73
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

When decompressing, it's possible that the algorithm only performs
a partial decompression.
This usually happens when CONFIG_SYS_BOOTM_LEN is too small for
the uncompressed image.

When that happens, image_decomp() returns an error and *load_end == load.
The error is then handled by handle_decomp_error().

handle_decomp_error() expects the number of uncompressed bytes in
uncomp_size but receives *load_end - load == load - load == 0.

Because of this, handle_decomp_error does not report the expected
"Image too large: increase CONFIG_SYS_BOOTM_LEN" error message.

Modify the image_decomp() logic to always report the decompressed size,
even when a partial decompression happened.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
This has been tested on an AM62X SK EVM board with a big lz4 image and
the default CONFIG_SYS_BOOTM_LEN of 0x800000.

This has also been tested on sandbox using:
=> ut compression
---
 boot/image.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index 073931cd7a3f..4f48e6eb563d 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -531,10 +531,10 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 		printf("Unimplemented compression type %d\n", comp);
 		return ret;
 	}
-	if (ret)
-		return ret;
 
 	*load_end = load + image_len;
+	if (ret)
+		return ret;
 
 	return 0;
 }

---
base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
change-id: 20240523-image-partial-decomp-d6604e998e3a

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

