Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB36BC47DB3
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 17:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5119E87BB5;
	Thu, 18 Jan 2024 18:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZdwjaQUf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3DF87BB5; Thu, 18 Jan 2024 18:57:17 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C451187BAE
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 18:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 536F73F26F
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705600635;
 bh=ZqPQtDcUVP39H53v8CDS8ImUuO8/l7t5NqRi1fYvFiQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ZdwjaQUfKdaXfYyAFnU3opk1Qh/Lgj7Jtv0jSRsyld3j1JbIxJWsmjkH2jhgTaJd0
 4/hiPqJQEOwbTm/sHbjDamVct28pO/WsavtIG3kFmwKClrT9x+Bx58hdDjrQeiApUL
 SZ4COUJOj9U9ceNTXZBwrI1V0+gOL24Gk8/paDnzHGgbkN6ek4ODuQf5hWukaksYM0
 bvw1yEIGlLBfeKJPEhBwYz1t7vnxzkm3NENf95VQgjp+Ca8moFy1xVigRDJojoFStp
 JSbceIzaa7gSz2zV6IvgQdUK3Dnk9HbvW/iPNNi2oladzDh4o31IDd3nGUaiX2mOo2
 +B4M+LTAHpIiQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e89a9a76fso12299915e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 09:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705600635; x=1706205435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZqPQtDcUVP39H53v8CDS8ImUuO8/l7t5NqRi1fYvFiQ=;
 b=OQ1JjMk7ksi6VjN/xJlHLsWCyUqWKGUHocsA+w6j9uWP+0SBm86cVKTVPvYO00vEyW
 NhNwSd8Rw/gSYG8McOtcVMOzpI9lcTQeSHWEr1bFg3usw2eh4D4W3a00RhcURU+PEDu7
 cjW6rFpyGu8O04ql1pGCXwpaZY2Y35++en2MoHUPDsiJZEc7cGcCH9JU8g5ubS2FRO//
 uuxVDV98PiqKJRlG+iG45vozRvzlMHWPnz2HGweG6AsvlYNV3BfyjVfh2Y/2K4leIXO6
 Wv8E9x5l2UbAAAS1i4FY2MGIuWOLHtV6tHAuJnKgUu7yQl2jgFBRF7cvZZTN79mIuCYg
 ir7A==
X-Gm-Message-State: AOJu0Yy4Siy42Xm0cxszoY0jTp+9kCFBX8SobmoQRi5SH3nyNcj1sNji
 rfUQ/qv7V5BU8/6vnNDQdZfC8byBAnAu0E6qKTYegsaKIdUBp2o934zjCo2/asVJjoTCL6nktFD
 zR5fOZK0xC6l6Bo+tL6F1nJnzbj4TG+Hsp1IeqgecEXhhLgQ5QKcjxTf8v47YDgZWD60=
X-Received: by 2002:a7b:cbd7:0:b0:40d:87eb:fa98 with SMTP id
 n23-20020a7bcbd7000000b0040d87ebfa98mr866439wmi.28.1705600635024; 
 Thu, 18 Jan 2024 09:57:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsRyBt9lC1QQeD8BP1k0DRla1I+vYD9pLxsgV8brNBSfL3jqH/9dS4Y3UiQP2G7kA8Lxr2mQ==
X-Received: by 2002:a7b:cbd7:0:b0:40d:87eb:fa98 with SMTP id
 n23-20020a7bcbd7000000b0040d87ebfa98mr866433wmi.28.1705600634661; 
 Thu, 18 Jan 2024 09:57:14 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 h5-20020a05600c314500b0040e5e21cd7bsm26168748wmo.11.2024.01.18.09.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 09:57:14 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: enhance unicode_test_utf8_to_utf32_stream()
Date: Thu, 18 Jan 2024 18:57:12 +0100
Message-ID: <20240118175712.51068-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Additionally test a UTF-8 string where each code point translates to three
UTF-8 bytes.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/unicode_ut.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/test/unicode_ut.c b/test/unicode_ut.c
index 1d0d90c2d7..47c3f52774 100644
--- a/test/unicode_ut.c
+++ b/test/unicode_ut.c
@@ -752,9 +752,10 @@ static int unicode_test_utf8_to_utf32_stream(struct unit_test_state *uts)
 
 	const u32 u1[] = {0x55, 0x2D, 0x42, 0x6F, 0x6F, 0x74, 0x0000};
 	const u32 u2[] = {0x6B, 0x61, 0x66, 0x62, 0xE1, 0x74, 0x75, 0x72, 0x00};
-	const u32 u3[] = {0x0392, 0x20, 0x69, 0x73, 0x20, 0x6E, 0x6F, 0x74,
-			  0x20, 0x42, 0x00};
+	const u32 u3[] = {0x6f5c, 0x6c34, 0x8266};
 	const u32 u4[] = {0x6A, 0x32, 0x6C, 0x00};
+	const u32 u5[] = {0x0392, 0x20, 0x69, 0x73, 0x20, 0x6E, 0x6F, 0x74,
+			  0x20, 0x42, 0x00};
 
 	memset(buf, 0, sizeof(buf));
 	utf8_to_utf32_stream_helper(d1, buf);
@@ -765,9 +766,13 @@ static int unicode_test_utf8_to_utf32_stream(struct unit_test_state *uts)
 	ut_asserteq_mem(u2, buf, sizeof(u2));
 
 	memset(buf, 0, sizeof(buf));
-	utf8_to_utf32_stream_helper(d5, buf);
+	utf8_to_utf32_stream_helper(d3, buf);
 	ut_asserteq_mem(u3, buf, sizeof(u3));
 
+	memset(buf, 0, sizeof(buf));
+	utf8_to_utf32_stream_helper(d5, buf);
+	ut_asserteq_mem(u5, buf, sizeof(u5));
+
 	memset(buf, 0, sizeof(buf));
 	utf8_to_utf32_stream_helper(j2, buf);
 	ut_asserteq_mem(u4, buf, sizeof(u4));
-- 
2.43.0

