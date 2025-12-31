Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569C9EE645A
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9868419D;
	Wed, 31 Dec 2025 20:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p1ObwhAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F148408D; Wed, 31 Dec 2025 20:11:17 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8E8E84172
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 95B353FB5F
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767208275;
 bh=muWKk3Sdh2FXIT58u0GK+vA/eKu3EAqYf5mU5drNhoA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=p1ObwhAV0YJLMx7DUfrwMZSnf8zBzHaGhl78ZNVTf8Q7vi9SWeIbUaLt40EHyvJ+C
 l8OI1CAshf83SlO51AkIYLSHPvQ7LwW4ILW66tS+krz7DdUGe7xjGWy/z2/kvZLbIf
 5wJ50Xsfu9q7gIcxtOEO5IBkLe0YoQWwTSbjosP3I3+CFAE7sdHjV+3C6nMqmm5qRs
 /oCNjF0NCxXAKu+CN/GYq5tx+Ve8MGDPpxiE0YZ0gNjCRPjCdi/SPDAMcTueEm5jbu
 +jH+7aOU0xhGWMVODyh1bluTVysdgue1ODn5eTo1yGn/XcLxWifzKfJX2XsTUHaL9f
 Y1RDGEhiRvWS61cwQLCLepAcYMUQD4pPbHFQemPFY8CU1P6zRz4CI7lxHsvxaeoB6B
 B8Y5QDX9g6mILcnsrtEGhMVDOZsbeB1z+uUxb9mCph7INt1s2MwqtRG3AABWPqypNh
 lJ1C54gxC3eoRgjLnr4Jxyg+cOZjEgnQ8a8+IVzC546aV8En7BcA8BWZnfInOkhqjf
 b9deLLmZU75UljhJ/lN4WDoItnGIf5owoX8+odxapUrnC+8HggqkmY3hoXuoSeejHZ
 6cbrg4JwWDkoU6YZljqngmbDjWyGWffvDK/A5L9iChZRf9vPH3ZZYISp3vnO8b1tni
 cf6YH/mqcTkzFtYEAK7hacEY=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso4448355e9.3
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767208275; x=1767813075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=muWKk3Sdh2FXIT58u0GK+vA/eKu3EAqYf5mU5drNhoA=;
 b=tEXrzwJECdNXnBV+swJsrSa12DH608Hq46Lwknr3oC8UHqlh0k4UuCp5G0GEW3Vrf4
 0WW4uARtLrpDP9RYdcb5tLS9N0rWWNq3PQyNB4xnrLDLETfYe/b4G5VbhlEo9HNOdc5t
 n3GIIoltPCfumUbt7xt5I4dLJBbSWBfdJ5m1hfeYRt91miIjE7XJ1nSdCLgeR+IFwWs5
 6thCr9yRuVg1xjxutdQp5IxT8mvOq3rvzLOSjIVGzi8s7xvRLjYHVdyZtAGHdc3bX9Hs
 N4gLFoUMfA36tIbvweyRU4Fw/IRXu0Z+Q3hESINvT7Oo5KW78Hxti2TOtOyVwcjiikcE
 fsaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDj8hJI4095RKoi9Wa0Mk2rjzZ2M0uucm8Qepn/2y5RtTmeeaEUEqEAQEzMl4nNfsPMPsgXLA=@lists.denx.de
X-Gm-Message-State: AOJu0YzedkrB5cziW44yVhYPmV7ohTi+Ew/r7I7cNJj4SFC1+ohHb8/n
 MDrguOKWFGTksHWBnzDVWJ/Syx8MK1Wv2prQ7IYBxHWfra1724PqGpZhJQC9QRuBCUdKsob1jpD
 wN2Szh5zpRCG1RWdkcLdkELGOYYz+4fPGEzsWCFjCOEoUXlrMy5PPKUEQda4AmjT1JXUU3jc=
X-Gm-Gg: AY/fxX4I/sebw+lUxT7ydRg7XbwwQHwXUNGnOrlwZyh+Ey5p5xxb9RKcMpCATQHJNlo
 Scark3tIshIpBBAdAhLRdHULRVHT4fbQOkhJT+usUNd4E8cc9JWglmgxGUSDmlC1fh3iKiCCQI2
 k9LRs1B8ID8tibuQCiUqTRhUZaO9A7A4g71FC7p18EA3/DSRnWqR27JahuTA9u4eqxYIj4vX6l9
 vXwIKZcDyg6zrZsqJWdjX+RVuVFfnWhOP0qTlW+ZBNQmwkMqCCB5ujWVlV2t8g2qO+M74iH/VWY
 50mVYDjXEwuN7hQ28RloIf/xzh9f4qq4+3ZH08h1YnnhAoYnQRgkSPCuFaX2Ds63K8oU1pKrK5g
 qR0+QFrdbcI+69We1yrn6425iV1iSYzMmpwRcMDZiuc4Jzt/aUwwXObUwpaaA0xPwrfMxeIlflx
 aT
X-Received: by 2002:a05:600c:6287:b0:47d:5dae:73b1 with SMTP id
 5b1f17b1804b1-47d5dae7628mr77754875e9.23.1767208275205; 
 Wed, 31 Dec 2025 11:11:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCCSj2l52ilWvwjP2Xy7L1dBP3svChVn9JN+CpC+LdPAUTRKEjWVNtFnHmgt8J77q4d7r3uQ==
X-Received: by 2002:a05:600c:6287:b0:47d:5dae:73b1 with SMTP id
 5b1f17b1804b1-47d5dae7628mr77754645e9.23.1767208274803; 
 Wed, 31 Dec 2025 11:11:14 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272eaf8sm701685995e9.5.2025.12.31.11.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:11:14 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/4] dm: add missing includes in dm/of_addr.h
Date: Wed, 31 Dec 2025 20:10:53 +0100
Message-ID: <20251231191054.247270-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Includes like dm/of_addr.h should be usable without having to add #include
statements for prerequisite includes.

Add the missing includes in dm/of_addr.h.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/dm/of_addr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dm/of_addr.h b/include/dm/of_addr.h
index 5fb5a4855b4..8c96cb5f606 100644
--- a/include/dm/of_addr.h
+++ b/include/dm/of_addr.h
@@ -9,6 +9,10 @@
 #ifndef _DM_OF_ADDR_H
 #define _DM_OF_ADDR_H
 
+#include <asm/types.h>
+#include <dm/of.h>
+#include <linux/types.h>
+
 /**
  * of_translate_address() - translate a device-tree address to a CPU address
  *
-- 
2.51.0

