Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A568D1F9DD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140BA840CC;
	Thu,  4 Dec 2025 13:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mKadgTDz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3820C8401A; Thu,  4 Dec 2025 11:26:48 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9B883AEF
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-640b06fa959so1230888a12.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764844000; x=1765448800;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U6W4HqE9yI+pkEX5/RX/GogLPWlMWTx3fDFgvOQybZA=;
 b=mKadgTDzw82UtHZNHi6fyGdqdluW4vofCVUPTLu3vauT+KqjeTOz18XSZCliyYVinf
 3LC6S6P7Nrsj5hEtP+Jc2OB1bCbRBMP5a+P5yBla0+IaLbdh0lDGlUC+zpVCJ+XsAD1Q
 21r4Zm7Cd5vL2c0t1d4HXgLBQotq3FZu01Fv9AwMmoJ43SFkfNX2Q6pzYorbhGIv+P8x
 PyVd509nRAq9QGAwOEQ4dHtlAqoTa0axv3XOGLSeyAF9v/alUoC3pouWfhdBe8VgkrRf
 CnNwZ7y/8twyAQm5USTD5IH9KBq0n1QNzJgIojmPKTe46xujGkNI3VSqZ+bqsTdhZXW+
 D9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764844000; x=1765448800;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U6W4HqE9yI+pkEX5/RX/GogLPWlMWTx3fDFgvOQybZA=;
 b=EuKk17GeQY62HEyJbfwUAw0prOTy+2Okvd3u3GkAf63eJdB7ivgi+3aYqJAKJ1yXT7
 uW9PEmfLjTlpBxrWC2+Mc2dzFlaYnJdGnFjwJhKhpf0WjWkJ3Cu1slbfTVAXwkDFFUj4
 PSJtASwNvjjqnTyz8gC57EYFbwBGthiuhqKEhoicyYMkJh80c9ZDgsdfR4+lemTgoQex
 twJtpnuCHK/u6+E3Kyqe/PjqsRc1246ViArKrjbMtj03ZqKIoK79JeWMfygGNBxzSHvX
 YjYPeuqLruNScoVkqCLONVaGDtLW3/v6q7AoXunjXFKpkzq/xv3hPTdoX9Vig1HZnjSI
 r92Q==
X-Gm-Message-State: AOJu0Yx0UHkXj6v0yeZYl2lOOIerh+RrXxspSDRxlqKDqw97shvS4UEb
 36/ODO817WrSAkbg5jN5kY9UbOZVXLt0N4FgMebkWtTuIkMgDhDq2CDLL6XP5G0P06U=
X-Gm-Gg: ASbGncvg+d6cOIxK53hOLzKQS2ImErZVESFLAQNvyVbSJm3QWYspCzmjqXMh2MZRoZi
 kSfgbgaeZox0NSHgmArNHzvkwA5jUwHd0sBG18gA59BTT7s64gJz59Uyiz8H2/le5pjbbIT2+45
 TxdeUP2KdaUTeqUa503aO/ceK7X5YpmufpM2mZiInsELaAM8zfV6WWBA+zUHCjKClhUp8VRjKjQ
 5GqOgviOgH/KdZuQ9TTOFObY4s6XV46BokTqiz6cbidC7mVZKpKLoun1y0p+x5reapZKHZjzOcd
 8yRXgkI88aEmRdNIgedNmJaInQ+Yl2VeRscSm/X7YITVWmnGhSql9MO0v0zYmgtF3ATnoJb9rEF
 HF8ylondXZEfgpG+JJ82tsDz/MEiNvFyS/cCCUcevblQWjSFADmJuBPK23sMJ7ZHU/8AeRUB5D8
 RPOBn2LTM=
X-Google-Smtp-Source: AGHT+IECV7wwXRuEYAbisWICPAFaUi55nJgWQ8NIqMnjm/vPrN6DA3hS6nYrNA3cZicoEc7WS5b5Rw==
X-Received: by 2002:a05:6402:440f:b0:643:83f3:1b9f with SMTP id
 4fb4d7f45d1cf-6479c4b261cmr5025602a12.31.1764844000220; 
 Thu, 04 Dec 2025 02:26:40 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b412dd8csm904433a12.33.2025.12.04.02.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:39 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 11:25:43 +0100
Subject: [PATCH v3 7/9] am33xx: Fix comment about config symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-7-3d1566ce4dc7@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=msp@baylibre.com;
 h=from:subject:message-id; bh=GOR6Yw1ouCDvQ1THX7A9qx84hQ8xo0RbLBPgzFeY3Q0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxBPsdRMUg+PO6ETY3a1bv/DzFHXRCObZWspHJcQ6j
 7yod6rtKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIkksDL8jwyL1dATyHlzfVL5
 itn9d+UET7+QNby1+JJZ3okXR9uZIxgZ9n09ocwfzNg6wyRm14xcxTYjjajYXqWYEDMf8/Sy7gX
 cAA==
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

Fix #else and #endif comments to match actual #if condition. Comments
incorrectly referenced CONFIG_USB_MUSB_* instead of CONFIG_AM335X_USB*
and CONFIG_XPL_BUILD.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 90b341303c7309dc21b34cc01020db997f53c8f3..c3931900622957a5499fe6483473c61e3a62fff0 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -259,7 +259,7 @@ int arch_misc_init(void)
 {
 	return 0;
 }
-#else	/* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#else /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 int arch_misc_init(void)
 {
@@ -282,7 +282,7 @@ int arch_misc_init(void)
 	return 0;
 }
 
-#endif /* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#endif /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 

-- 
2.51.0

