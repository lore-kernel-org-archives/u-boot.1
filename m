Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D36D31A2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A51F830E4;
	Wed, 14 Jan 2026 10:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u3Hm+2Bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD1E0830A0; Wed, 14 Jan 2026 09:34:37 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDCA383642
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b86f81d8051so105950466b.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 00:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768379675; x=1768984475;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QxmiZiiUf+Djrb7eiQlzCszzrpcfGENTbChncYgzfPk=;
 b=u3Hm+2BzmAdkXohK/J8MrYvT8GdmBJ47vFhapTDnBrKskGt39ErBicnSdSLTRW83+l
 Hsizw/ZtTCcSeBg0GOkEfeZ37JxmCSC0h+I3mMdtQOQSIbboTfwKn6d1+CBD0ikVvjxq
 TpCqI7NjKRgDRX+yNoW50VseYAKVF2VQlm923ngXvp0W6wnDusNKy9Ta50VwHmHN6HNB
 s5hWfJlNBMG8CjuEKK9sLRR69Q6RTGOFMUNI96jGZdmsn0AMP297L5URU8SLEvFoSPK9
 oful9hRUHsm0clzKhCB0WSr0O1C2BKPAk/AEe6MHkwBos2f+P3/JrDe3NAvmgtPaE106
 qXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379675; x=1768984475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QxmiZiiUf+Djrb7eiQlzCszzrpcfGENTbChncYgzfPk=;
 b=l6VBwLC/wyf6I3+LT3B2nCrT61DHL0NhhectEx9OhOkEYS4oVeKnHkiTK+U6QlW5SH
 ZQFc62H2ihNDInwQeDl64BrycN8xfpNYRQzdGaYjrX821ndyRr5vzOLPD5YD+oZDO2j3
 7R9yWKcyAYBa1NRHsaXGiMfzHIPqajrqjYdsKI+ztWdunoyLjvlre0a32gXaX817jQ2G
 jHd6ezZWy5LihM1Z/4MNzI+G5kwvQXgsItIYl7SC4qbxOkp7qBv4C2HmQq/4P33dD1Rr
 MNSrLoSqA10niHFdCXaU/MOVQnR4X4w5GQXlaQmrAjlMhM23vOYivI0JyjAMXOMmOUeo
 wfuw==
X-Gm-Message-State: AOJu0YyV3yp20Ifnq641ekAcCb0Un9+CFy5bzLFvAsNIezs03f5RhvGA
 1qbsBSbKfEtvWmlh9Y0sZMBcVTDVGsJZT2eUycpU0odSXubkfbnFajM69YG8Dgi7TVQ=
X-Gm-Gg: AY/fxX5rNKiw+w/rptw8j7Mb7t0o8Cr8vHnQYpZ+kPvt9fy/txTA8wzeiJN191lR8PY
 3piYtLLTPfD1LNirO7k8hikGokeF//XDR+Fw5VpBaeGi+JxR8x/K727tl8Rp5PgkXq7fZseTCoU
 Gt3n5hu6xAAikSySaMG5glHxcrf2qdHNwlGun0zzEuxP7EzUpoqzMgrk6PBDGV5d8g3oYvL8VTe
 6xmqmJYcECJgSV+MvjaVfEv2AWAj8mFEmk5zOkRdvCJSkdFaUdh2zf1mku1X5r+nxBZZ6l0pFQ1
 RfmcagXsLDPY95RvNQwddEvHaBUrUCKVHWZrruc2LveX10b/Q8ORzeO5CYG+OyU2IPRGEHk1sTP
 PLAbMooVcpaHJFBbL5NP6mNt743p3CVXQYmybNnT+j+GsaB61hw5CX9zGMVXGakzEv07E+mO/Ge
 AhgNtweVU5
X-Received: by 2002:a17:906:292a:b0:b72:5629:1789 with SMTP id
 a640c23a62f3a-b87357e3725mr433695966b.13.1768379675349; 
 Wed, 14 Jan 2026 00:34:35 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b876e9ac655sm38566166b.6.2026.01.14.00.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:34:34 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 14 Jan 2026 09:33:48 +0100
Subject: [PATCH v3 1/6] dm: core: lists_bind_fdt: Remove unused variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-topic-musb-probing-v2026-01-v3-1-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=msp@baylibre.com;
 h=from:subject:message-id; bh=bU4OpVYe2A9WGIKY+7PcFOwx0HAXFBo8V34bQvvD2Q0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz0kD+zQ5q5rI3mzLlYtNeore3sEVaJ5CTr3XIaH9tnT
 hSJKZLvKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgImwWDEyrFQv5RaNqG6V4bWT
 3dW8V+Vpruykn4KbLU9tLDF/qZVsxPA/SJrj0AL1BxY7p4r9U5p9dTvbvuP7u9/N3fEqfmPun9o
 8ZgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 14 Jan 2026 10:17:21 +0100
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

'result' is unused in this function, remove it.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/lists.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index c7be504b6fc69ec2870a6766eed35cb9eba46a97..52ba6c7bfa007b660b854de62c97ad3c1761f1a5 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -207,7 +207,6 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 	bool found = false;
 	const char *name, *compat_list, *compat;
 	int compat_length, i;
-	int result = 0;
 	int ret = 0;
 
 	if (devp)
@@ -283,9 +282,9 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 		break;
 	}
 
-	if (!found && !result && ret != -ENODEV)
+	if (!found && ret != -ENODEV)
 		log_debug("No match for node '%s'\n", name);
 
-	return result;
+	return 0;
 }
 #endif

-- 
2.51.0

