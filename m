Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5772DFF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90008848B0;
	Wed, 29 Apr 2026 17:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lKpS/VIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9CB1848B4; Wed, 29 Apr 2026 17:40:09 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5FE84099
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 17:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B97763F281
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777477206;
 bh=6y0TnCG3a6jzIozHHxpIsLSSenQueakTEGUrHEYNb1k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lKpS/VImC3S2NwcbZqwPIF4QH6jKhf+JzPveBDSHPh19qNGqKLGnbWkr9vO8F5SM/
 d63UDkYhX0tj+AKso3G9jkPtXV0s7LRwW+BKMl3AvQwT0iYDYyP7GI7rf/2TCjhEEo
 djLU/d5SJyJkxxXNe9iF5BJ6lta7JLWGLRU9+5K8c6UXk2TvPBKWfM8Sj9rhDhFn3a
 1DcNWlsOZjGv6/xNyyAcy0p715PQGbowTNUrTcc4upbgB5qw8Ew0Kg5NKmF790AoOf
 OTFrk2cWVIAgf0P9FcBJZRo39wxeOBrOhzbs3dQa5jPXrxim/bbCjrDCel2K333cMj
 CXEEZp4E7nkw3Lf41ZLAqpuaB7GiVEBC3BzwQ+BQQSen2qmdBIlW4OcMeMetAzwxua
 y5hR1vU1/orQ7W7fHmJbpTiwRd8hXP9zALK25cOdTTAAm9pFeckvgDiwEFQ4QqvTG2
 bMjDp7KoK3tAqcIdflo/ZnIQGiPQsaeangOl8FPrUio/HMJryqni6eURCFDHp0MqH+
 h+m0RkSDH2MoPl1xhkkWqd2VGLWcGpzi7TI9Lok6ZWHILeOmxwJTnP91LPaw5/G/aR
 pK6wSVjZEdP1Xw8iGP9mMWk9ifJiBPutzogS4veS0vJGbmWGyKeyW3EUBXWr/cezW2
 eE9RmQ80LM5JKObnfo2cyW6g=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4411a1f9601so8784558f8f.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777477206; x=1778082006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6y0TnCG3a6jzIozHHxpIsLSSenQueakTEGUrHEYNb1k=;
 b=ErBuEpnpIE1CtDxbTRKRM/7EovTxrXa8KSBlJap7SYp71BR2RS/AKd2XOOxq61jcU5
 YY/rUVtFQZIdxittBA5h5Fm0zeHQ9NE/5lr4VbbY3v/eS4xrMlz1PTMb6QWH7i8enuEg
 nipaL4Ku3P0fhJoJ5iuvMMElBaMHhSGIS5BKbIpH0vkEnyw9TaVcXjVQHJLE860ReWFZ
 bkmRNQAT8xTh+G+z6SRiA9zeskuAmLPQCURfa4qih978Q+680QOL9vDXyzUQjBWn4MOR
 xzF4OKM1pBhASlT8mVEemmQ+fUVPPpumQNIppu0bBXCrrDNsyPkqotO1HsNsc4Ym/MHR
 A/Ng==
X-Forwarded-Encrypted: i=1;
 AFNElJ8A26rhx8nwKp/A5Mzf5V0Iy+5Yx9oQfymIuIhe87SsRT/h+A+fYtUOT7b42+tg5QISyikYfrw=@lists.denx.de
X-Gm-Message-State: AOJu0YxI93BzR9n2ycrk4IKI5Q0HByveHhdh8Pwl21XIMTwkGa+aZ1jQ
 cHbE0hlHdfqlCVdC6ouMQU65kZEfChBFC48ANcHAn4e6+Rwsan15wntMKPvLl6i5m3FapqQgr5n
 PvBoLZ+wgCQjywe6A66AyP7CnmZs/YWEUYKyyTXc7vQToXAiCEfG1xnAYiwkiLu6+oOxAb54=
X-Gm-Gg: AeBDiev+uLOinymr4X0pQbHgGLedPqAfZtBUPAvwhdqrc5EZdfOBkpO/Sk0gWmM7alV
 ofAnAjq7lOM+GeVUj8hQEvzIA2cd4VInHsKO1NODN4fqadK7aQfJLCK1KIK8w2uyFBjtiOXQRTR
 h8B+5sxp39q1uiJGiiiLny8NKnDVR43p5gQFIQzjkrkvsZ8xQZ+Sy5Xhk2w5sTnE1RmeeAxPOeI
 GfpTPlbOn+Q32gBVc+3IGGizKwLELYqijczzUqVka4/DMbTGI3oaWWP6HxI7ttQaC7AV6HdATnF
 BssgMSJxt7w+vNRn6/lRBv1k7RjRQOoqfgjiuHwPj8IYuECorgR/cFeTD6zggh1o2JPxAuvuGTx
 W8VeEBqe6eWCUscji1h75S3FWdNdjojGcZVnMApJl+8aqsZY2pjE/hsvAntSboO6T0ySNFmcDqU
 zYWHYtDVAzz29xYDLMX/LV49UVTupshv7jBGO3CUT9B0Fn9VuSTrlqE24qSW5K
X-Received: by 2002:a05:600c:1e28:b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-48a77b240c0mr127361015e9.29.1777477206182; 
 Wed, 29 Apr 2026 08:40:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1e28:b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-48a77b240c0mr127360515e9.29.1777477205704; 
 Wed, 29 Apr 2026 08:40:05 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c2ddc65sm33251645e9.4.2026.04.29.08.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:40:05 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: initialize variables in efi_dp_from_http()
Date: Wed, 29 Apr 2026 17:40:00 +0200
Message-ID: <20260429154000.71351-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

When using lwIP, efi_dp_from_http() may fail to initialize ip or mask.
Initialize the variables before the call.

Addresses-Coverity-ID: 645840 - Uninitialized variables (UNINIT)
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_device_path.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index b3fb20b2501..9efb158f5dd 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -955,8 +955,8 @@ struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev
 	efi_uintn_t uridp_len;
 	char *pos;
 	char tmp[128];
-	struct efi_ipv4_address ip;
-	struct efi_ipv4_address mask;
+	struct efi_ipv4_address ip = { .ip_addr = { 0, 0, 0, 0 } };
+	struct efi_ipv4_address mask = { .ip_addr = { 0, 0, 0, 0 } };
 
 	if ((server && strlen("http://") + strlen(server) + 1  > sizeof(tmp)) ||
 	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
-- 
2.53.0

