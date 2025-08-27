Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1521CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 21:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8F3831B4;
	Wed, 27 Aug 2025 23:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="hASnlZDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08456831BB; Wed, 27 Aug 2025 20:27:12 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC04983106
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ben.wolsieffer@hefring.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7f722cb35c4so22428685a.3
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1756319228; x=1756924028;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KcLfShX/m63O0YfnHjaNbjT6mjA+CF/ks49OLrPS60g=;
 b=hASnlZDDHxaRQpXzbpzLgIDRwG9VEeU3DJEsjfpfrHV7n7yP1E/z1Uqa5Ypm2ZTzeB
 4gR29/zU5aZbXt3R9TeDmGIthXsYWk35xFn2D2H7cMsuizq50VZdNoiG9lMLSBq1JswB
 8gvNPisgpROeGxMZJtnd9KGn9gdx+3Ulrume6/nKjHWZKZnxzA9JIPjGIym6NjkYFuj3
 1fp87XKXDIBg6OZ9Px1ks8dC4bQIAzrK6x+Z5VhZklzVhIPjUVdvY5l0zb3tJDvilaEP
 nWFNgOqNn1gP4jKYbZGY35EXu8oKXLGP53FN2wAQ3wN10AaWMeYUiXV6A5q2RmK1BF+x
 sRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319228; x=1756924028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KcLfShX/m63O0YfnHjaNbjT6mjA+CF/ks49OLrPS60g=;
 b=CT1IhcBgexDTsEOEvQZL9TpxU56Y/SY0lP72NAqRxNqM2CVUQxYDb217l4y778Bjn4
 hAIwfR26WkAzobE4PhM77ixD3eampdzUKySXP9jchp+xtGyOM9cvyothnJU0RMlWUF5R
 2uLlZi326kpyMZl4tfxmSffPPHs5qvdy083Ds26mEDFZeXLwaxAoaTNKk/TEtXCbJeGJ
 pvf8vH54SvOmAWafN/th9aE9MAl6w+kmn9mWd7YZT894MhD1ACrqHl9kqV82pAiHdKl4
 C9zVYxJyL8yvrNgCnS4c0XqVHU7Y/BQhXw60tiJsUBsxE5mCxTL07Ac9Ri30I3fd4NGI
 7Vkw==
X-Gm-Message-State: AOJu0YzWRxpldEYiad399yMRckWwBDyfNZ2gwqC0blNa6nTvF6qQCktm
 2OuyOItraHJYxqervGJnIZygGreLviZchwBMLTvXet4/lK1fTSKUsSqp30qj4bLAasRdk7wkDIP
 VUQi6
X-Gm-Gg: ASbGnctVZlhu+Pk21p8eSR1yRUnZNMi+a6c76+WwQLW0abjzMdjFT4gwWP8Z1V3QmmZ
 7HB9PldLuHl4MOu7fikqqJk4kaKhAlzruQGiyhHHUWUb2STt8E9FCjtiBvrGmdVAo9I4GOFLwKN
 xJHUg0mgexCVTOiIYwOoMih/DrM8oFbeKYBQJIQ5U8JVB5FcSkQo0+6id3GllCwhjBPgJd43G8t
 eLm8MXf3AE1/O7FNz62Oy6oY69ZGGhAvMOQlgXmMg2iMSjwQoDvWaGN8qXQrn4H1lOysoQFoiuu
 fSn0epDj+UAlbSKDKtzN7Pq5fDe1UWjudvQQMVhbhhJfm+M3TfrW/qD0ushKw6bUd2kXKvCFqTm
 pEaQJw1IPt9D5m9CIPB4O3yx2VFvPEcSER3vrc8gfiWzz6NZnpbfgGUnx6A==
X-Google-Smtp-Source: AGHT+IEBiUK3mOHtDmZlN4xxN5C/EpmWZQgI0r3B3e94feSm+KJbblT7FMaEOyJxCXx4xsSAW50klw==
X-Received: by 2002:a05:620a:414d:b0:7f9:d31c:784 with SMTP id
 af79cd13be357-7f9d31c10camr6881785a.51.1756319228478; 
 Wed, 27 Aug 2025 11:27:08 -0700 (PDT)
Received: from dell-xps-15-9500.lan ([2601:18c:8002:3d40:f314:c442:b04f:971c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ebee415f6dsm930315185a.27.2025.08.27.11.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:27:07 -0700 (PDT)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] net: designware: avoid regulator enable failure
Date: Wed, 27 Aug 2025 14:27:05 -0400
Message-ID: <20250827182705.64488-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 Aug 2025 23:55:07 +0200
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

Use regulator_set_enable_if_allowed() to avoid failure if regulator is
shared between multiple devices.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/net/designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index fce3ef910cb..b0979e621f6 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -894,7 +894,7 @@ int designware_eth_probe(struct udevice *dev)
 	if (ret) {
 		debug("%s: No phy supply\n", dev->name);
 	} else {
-		ret = regulator_set_enable(phy_supply, true);
+		ret = regulator_set_enable_if_allowed(phy_supply, true);
 		if (ret) {
 			puts("Error enabling phy supply\n");
 			return ret;
-- 
2.50.1

