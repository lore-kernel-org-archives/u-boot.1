Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EC6C61DCB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 10:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BB983E40;
	Sat, 21 Feb 2026 11:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUVWTl0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A8B83D0F; Sat, 21 Feb 2026 11:00:55 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6453D83936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 11:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8876d1a39bso389238366b.1
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 02:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771668053; x=1772272853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gJ+rHdDuRcrzC6n4B9Oz0vH3EXQuPo8Hmyhs/CUSzA=;
 b=nUVWTl0Kf7s82oF35JRtwzaeiLhHrO/Gj3fgHhj9eHO18bKw90s2/YcvKK/yGtYT98
 +vATuI4ZPd8mYUzXIu15p/fTujKTQNm18KPWe22lB5S4pcMWc+dwL2+XToHwUt+pw1ie
 Wulwi6eNJamDE6Ta0VX8YTnf5KkAqoPSy2pbaRSC8ReXncv6rl6lFHAUxCKbPwBEW0Gp
 5ovQxegYEc3yAxxPH6STcEGWSgR2WsXiVdXswFmodTdS+A2VvFU42kmN0UUX4LRcxgek
 cYpq9az5vXxIR64HZJpUUZPsmNkAsuE5IZW6FXRVVPQbZDtQey6W/TAN7dUlSQSesIQf
 OfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771668053; x=1772272853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3gJ+rHdDuRcrzC6n4B9Oz0vH3EXQuPo8Hmyhs/CUSzA=;
 b=Ydee/9X4ohqI7k1Clyw2wcOnfaZRJquN/GHsB1DAYP9spoH8QF/9fxXgd02mazZVwA
 syOM07ng6F2mRGsn7NnlqLnHausa7HEmdGdiac9WIk3StQUzTCn4F9SuzKGmr1dcOLII
 jqBlZz9MwpK3qugiQtWmwBKQt/PTXMNHGENON22WxnpFGRiPkut/LRnyGxqejtKCLU+U
 gG9nwh2uYkKT9qrBwpoTWeAbNHEJcbcIemhmZXUJgM3VtOIzDqqXaPkXr6v/kjON7F3f
 CI1Ic93WsZ6Bl1nRD4Ki3gAYlPQmvmA4I5uU75ZXXXtgJvweFi2oG+FGzJ4Oflg3ztSM
 XSYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvKchs5Qvq+Kg9/oYv4w9WXnc/+2jzj+c5kQ4ot4IdmvqZx0HBZshpkCxo2x1i95aZv+g2kOw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1yZGb3JMj8lYJ/LKmp9/jbDf5cWhJnqsiegzZ1l4j0ZY+a6b3
 9ij9dqJueLZ0c0yaxBM2vB3ttlxJ2BKlDXb8K2OeUQ8GJxwfKgRSORx5Sw+qvQ==
X-Gm-Gg: AZuq6aIFwtz0+BE9eQBeH7RegZdyUL4lrcElTZKis4oR95XGlaxW3dueCkHrE8bnFAt
 aOUvmI2WKSbLKpK6AnMAqUO7esX8qp40S+iSLoV50/tSNKavJyvbMvvcTUkofTc2V5XHqRBv7zL
 L7OS8+uVJQ/35E0cjOzPHb204Fi6q5T0Ct3YGvpzT2dBUhSYGbsctmoQah//5yMD5i3ASMWWwNv
 2F1Mhyx/G9T3VozepHFY9xpm/29xQCDxUFGrrQ82A2rAanZ5j5u4+TGLECRiVLw7MfOFaro+C17
 H+ip7GyM4YYHFh5zKLjylEJJwQqFcXYf3sn+vh0lYyTzaHhMzBz4ReHgTPB0rbwRsjBbYEJcG4C
 jYePShv059toRXLBLbPSFDGBmGzWP44NSZB7ZlvNV87A9VbPJdnaRAQHtAf97V1vbnflcFBtKib
 zAXgiQtDJGX61NhkEP6cF71SvUal9tyarqh7Zb64FhMnzjyU2KQOh9Iyj62yqJwT7t
X-Received: by 2002:a17:907:9615:b0:b88:448c:be01 with SMTP id
 a640c23a62f3a-b908197515amr169791366b.18.1771668052550; 
 Sat, 21 Feb 2026 02:00:52 -0800 (PST)
Received: from localhost.localdomain.pl ([89.151.31.85])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eab9aabb2sm421298a12.8.2026.02.21.02.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 02:00:51 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/6] fw_env: allocate buffer of proper size in
 flash_write_buf()
Date: Sat, 21 Feb 2026 11:00:07 +0100
Message-ID: <20260221100011.29049-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260221100011.29049-1-zajec5@gmail.com>
References: <20260221100011.29049-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

When dealing with env data not aligned to flash blocks flash_write_buf()
has to use an extra buffer. It reads existing flash content to it,
modifies required part and writes it back.

While reading and writing a size stored in "write_total" is used. It's
what should be used when allocating the buffer too.

In some cases allocating memory of "erase_len" size could result in
allocating too big buffer. That wouldn't break anything but it was
making code less intuitive.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/env/fw_env.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index c69da0b926a..fcbe09ea981 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -1037,11 +1037,11 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 	 * block back again.
 	 */
 	if (write_total > count) {
-		data = malloc(erase_len);
+		data = malloc(write_total);
 		if (!data) {
 			fprintf(stderr,
 				"Cannot malloc %zu bytes: %s\n",
-				erase_len, strerror(errno));
+				write_total, strerror(errno));
 			return -1;
 		}
 
-- 
2.51.0

