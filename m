Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D68CC83F0A
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 16:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17EC833E9;
	Tue,  8 Jul 2025 18:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a4MUhV5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E4C68331D; Tue,  8 Jul 2025 18:51:22 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D4683394
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 18:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so770285e9.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751993479; x=1752598279; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hr9t4HxaAXdbN5CkVvOLZHlW1UzXzKlmhNm8IvngZW8=;
 b=a4MUhV5OMpO1bMWXprbB+R2PsPqzZ0bbSMHU/ua0Y1aw9xfj5rVdYi+A7a6Mh9dtJ3
 VgK234/4SSC8tCVUDFpDBff6GmBE19NmFGc6yCdUZpUMVrhFzpHstDU6GGUKAzo2ERs2
 3NwHNMX3BelKKjyC5kO96p4ZR1CAf/NsWcfopQ5MAsHgjXDanKcBwQnoChXhQYDIyG1S
 HTHbb1F79KkVHVTj4y/IOk55rcr71GiygaXNH5EYg/nPyAQ+Ln6yzxu7l8q8p0b8vn3K
 edtS34GsMFG+VuyrZBZsixJuDCDZYRpv8aS297wKjr4tuqXK3aVvxchkx4BNo6BGvSC9
 drpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751993479; x=1752598279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hr9t4HxaAXdbN5CkVvOLZHlW1UzXzKlmhNm8IvngZW8=;
 b=B8F8Q0/ST84gr+MMBDaXGZzAyOH+yNQojdcg0BAtEM+a6teu08wJgMf70Mj2PCfPJr
 e3LDTadfiW3qmLeutlViANco3UXekbf24fxlLJwLP2nNsBRTeq49Fd1yjUeO00+FY6+p
 mWoDvnHGoIcCymoKZflkm2VrbjRfe/IW06GxqtlHOMKnEwxIMmJAYIU8N6IAavyikra2
 HhGWkuXvqxYeobUTsc0M0r8+kAzllFZvnLkiTGsNWFMwzKE16Mruz5qaV5MHBVT7MVeb
 LMb4drx7heWJq+w2v7AQ0tsdSUpY2+IlRhEtSqYzdJxpdEnHgU7npRz6C6b+se32TFDZ
 +0aw==
X-Gm-Message-State: AOJu0YxhCSG3zSL7KtzwdFvXYs617SA8PgIVKg2hhA8lW7YoKnfoPyqF
 yb2USJu1pqxk1tst76Sti9koBvdH+FeACSWq4tQ2kvjWWSGf5oCFPDc4pvtkzqigJ84=
X-Gm-Gg: ASbGncu1KVu7sRcUbx+kunj6f9GGxa8plpBBrq8csxZjgptVsTVw4DgdFGlJLCz/SkW
 HgXL+dQoUJhqL5PaVe8ANFAbjIhUTqutb/qTCMPdERgKRvRdSncHKz1Y7k07ZarEcmFW0bdMUE1
 VL53dP1rmJnHiji8N9w0RfL0cPVfdd3BLVIov/kaXWnPw29/lMNVujSiIELg/0BG8ks8/USoJas
 Bck0fk6yxKJxNuriahGO6xOnbBMrWRGotR3vbuqJTKEl8uh4uvf+GAxWC1oEks/g3ogbAoF2E50
 CCqBIdoOxBnp3gRne6tYYvX9uZ0bg+iPI3iG7kPGgFNmpDbAz3scvU8J4imYWh2PfCDMVcCsm7/
 vUy0PIh4d1+zT
X-Google-Smtp-Source: AGHT+IHvQ7nT4bZHAwI7Bpz+zrVAD9sYLpoorCc3yei1zzicnh0BnHnbj/o6Q6GFNvZvB7ugpa9g6g==
X-Received: by 2002:a05:600c:3e10:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-454cebf6f21mr37191235e9.3.1751993478878; 
 Tue, 08 Jul 2025 09:51:18 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030ba29sm13232481f8f.2.2025.07.08.09.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 09:51:18 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 08 Jul 2025 17:51:17 +0100
Subject: [PATCH 2/3] net: Incorrect NOP macro used for test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-net_fix-v1-2-292b9aa20f31@linaro.org>
References: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
In-Reply-To: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In tcp_parse_options the uchar p[0] is attempted to test for a match
with the 32bit macro TCP_0_NOP which can never be true. Instead test
against the 8bit macro TCP_1_NOP.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 net/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 2635727f47d..8740150365f 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -804,7 +804,7 @@ void tcp_parse_options(struct tcp_stream *tcp, uchar *o, int o_len)
 		}
 
 		/* Process optional NOPs */
-		if (p[0] == TCP_O_NOP)
+		if (p[0] == TCP_1_NOP)
 			p++;
 		else
 			p += p[1];

-- 
2.39.5

