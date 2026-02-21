Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF8CC61DE1
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 10:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699C883D0F;
	Sat, 21 Feb 2026 11:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sp1gxaHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3914283E8E; Sat, 21 Feb 2026 11:00:57 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A2883936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 11:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8fa79b9fcdso470549266b.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 02:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771668055; x=1772272855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwVZlW2qMKMv19objUVz392heDhvzsUHYN1PNBV7ebo=;
 b=Sp1gxaHDybf319UYw7SrK/auBE+KwSl8h7M58/eFiJzOSeIevUGwIMhtMEK0RANurz
 J7qxW3OWdMaqCMkEMkW3i77j5S3AW1IbYC4Tih4XwBhQQjK1kxluBJgKkHYZTR7IDxvq
 DXimdIgsLNv0ZNNxRCUArCBIdTUZftB2+GEjegSkCXjTlvZ2fpaNF0zksta7MMSv0ppP
 dFFNCqZUP0bHK8+pFsuzHWgc/rFQfh1N4TnN2sgWCzYqEf8S1pe+i8POwF1jOx6/axLk
 r2Q+84n4pOoK2QW8kI2pv+zHVR8F1WxpFGvQOfi91XeJket4Vq9oi9vMuQWtmuVoZBIO
 7YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771668055; x=1772272855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OwVZlW2qMKMv19objUVz392heDhvzsUHYN1PNBV7ebo=;
 b=BGSm7pwIlijhBi+6hlUuZ2TqAH6k3fLdxo4dgKJigw5LiGqT4Dq1OCj18smRomKZOd
 7fFS3CcSC4p138dh8b9d5J/FPCPW7cip7CJzx0neCu0V1kVO08qv+md1jHHjj3qsklTS
 tbG5vatVgEEdkrfN/sxW4weLyJ7IYRgZXQsOqunRErtqYs0W/h9T0WpCciH1XLD3Xb6H
 NRAE6otRXJVyms5450cJzjMjFWP9JaCqdkNN4saGUq3SEBFOC0bfRKiYkH9exZxOCix9
 x8EGvzuz7mMeu0iOcq/ggVBN/BDMNjS4xcrV92u+gRz86niFEYCxz7H1xda1hY1ZpBey
 SIdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfkX/bdnOy53+raJi9Ydn7cHF3f/UjMo+UgH7EUdihVvLxpgZNYImN77vMDvyH6HYG9ZRDPJA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxq6eKy9uR8vOVBGZx+AGpnnxlH34PuvQ9s2TcHctEWPDHLPY1e
 e0jkERwU08k9+96gbP8O3TmPAGp7GcOQ2sGLGCfB/uwq7Cy4I/No2LjA
X-Gm-Gg: AZuq6aJEd7tqUF73C3m2BLkqTVFWSujX7HzYCFxRbmUtUVrpFXUniElojRQtrtTkzpb
 BfpFmptGifniNuJP4c/BYCVY+oG1wtUE53HUcBDpnETN+HEaXakPtH2FJ93SjbkRJ68g7GUIDVA
 4vswLTlLLbeb+DETrPReL50dtzQx+/iyeEv9v71XqHaTZEfsK0tgJ6fuD/JGKNiGdH6VFpRQDNg
 3WpvjVzwNzuWswFN+mJnOqQby56rPg5PRV/0EbK5vhc1hquv8BzILO0KEQ5QQSlyZNY3+4l4CmD
 6ET2CiPRFdwWYTClt45+uV+4DXfiwFwtuNb3E3ta5rCJpJy8XeHK119qyjEzxAZTiafnpN/6BkY
 08jj9c9BQ7J2G7mpslo70jXiBdR9GlCQyfltjOmMPoLkuSblLbL3Kn4jInbrvONELCCZ5a3GGBA
 RpQ4B2K+n3USLU4Aq2py/iRP4/Sh6feYw54Dl563ZhQq+nlqQDaDUXXRW13qtUSOMx
X-Received: by 2002:a17:907:844:b0:b8d:bcea:44e with SMTP id
 a640c23a62f3a-b90543ad1eamr567962966b.15.1771668054512; 
 Sat, 21 Feb 2026 02:00:54 -0800 (PST)
Received: from localhost.localdomain.pl ([89.151.31.85])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eab9aabb2sm421298a12.8.2026.02.21.02.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 02:00:53 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/6] fw_env: add ROUND_UP() helper
Date: Sat, 21 Feb 2026 11:00:08 +0100
Message-ID: <20260221100011.29049-4-zajec5@gmail.com>
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

We already have DIV_ROUND_UP() to simplify code so add ROUND_UP() as
well. This makes code in flash_write_buf() easier to follow.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/env/fw_env.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index fcbe09ea981..c369bda1b85 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -50,6 +50,7 @@ struct env_opts default_opts = {
 };
 
 #define DIV_ROUND_UP(n, d)	(((n) + (d) - 1) / (d))
+#define ROUND_UP(x, y)		(DIV_ROUND_UP(x, y) * (y))
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
@@ -1027,8 +1028,7 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 		 * to the start of the data, then count bytes of data, and
 		 * to the end of the block
 		 */
-		write_total = ((block_seek + count + blocklen - 1) /
-			       blocklen) * blocklen;
+		write_total = ROUND_UP(block_seek + count, blocklen);
 	}
 
 	/*
-- 
2.51.0

