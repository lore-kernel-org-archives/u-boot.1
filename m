Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F63FCC05D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5666D83FA3;
	Fri,  6 Mar 2026 20:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VKj/Xe5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A8484006; Fri,  6 Mar 2026 20:08:36 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3830C83FDE
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8cb513e860cso977088785a.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772824112; x=1773428912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GijFLuqRg8WVk+Ej7Pnwl/z3kbQfOIIU/Jg4kwTdxjo=;
 b=VKj/Xe5OExvyh/gHLDyiRVEAvFNW8pFaATtz7fpubUJRJI4v6kLJv3xOkhulF4xQ9c
 rYOrzT9UKXsMp8BNnhNvY7LpVtYa69THZ9f2+7OeFS/VZVJypoFqJyAxsFuQndnuiCiy
 wEZsG3q8lbo29N4MIrw4M8ZiyVa8RTiwta14c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772824112; x=1773428912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GijFLuqRg8WVk+Ej7Pnwl/z3kbQfOIIU/Jg4kwTdxjo=;
 b=LMhptKh69ZSqOEsLd71d0CSZmBOQTuzvJbwZew/ebN3sEP8pUkZpH0UYcrpNLlN7h7
 rY3xPhI12w8s1SXxfUyVFRE3b0rmGNgxMGG5yzPT0vj2/Cc0v0hYWU/l7f16ewQWVCt4
 t9Xcfnlo6+RsZ2B4lOvoJ/S44srofjPOAEGnH4Lb7aKazrmoF+7KuHTApR11WmIQyETB
 FsxNP8xGZwkcPFkXwib7kYji9x+HYKJUz9zhmTlJMvpthaZfEHfSNHLvThrpQOIqJ/zj
 q/ZF8T9Zel8JFAHH26HOW3LCiyIlShTUHLKSjl+7+cM/Mu3371CLuXPSukWB13r6jIC3
 fAog==
X-Gm-Message-State: AOJu0YzBGzzxSG73hTwje1VjxvtV3vS/lnnd01s6MRFFR19H3HogMELL
 uJfxYt70zFw9c83JHU0OXhlo8Hxv/LmsAiuE2YYMigDfVh1ElUbUR5I/+kwngJ5+KyeHfb0yFjE
 enWA=
X-Gm-Gg: ATEYQzxqR6RDS0A13e+zOh0wEfQaauTx3MUb6Y7PJbTP5oHKC2BCBvFyhBvrzO7u6Tk
 kgZbYodGLmFAqE7UINNGaKJM4mPTnG3xwwlav7rK6aFD14Npjf0OtG/zn6+TyomJ2AB8p5BND1h
 crFfRMWaXme9aboOYX/qh5Zs8KJhTh1/0t3AzZaOwSH49yvgQgvj+u0nQB+pSBoquu2MtAb0pIm
 Gr8c3xiQVs/iYiRznpbgGNhy1iqkVmlhr9atx5w66Bm7XXfoqq8E3QBBOBKnuGdnwNf5GPei/YD
 TM5WImar+FfYUQ0hlYg+kZGz2KcBUUS/yfLHv0+KV4IfRjSAC4HlFUbDp4netIbBeTKnyV/sOJP
 DPnZCq4qF7MPW2pUSOVOpIYSczAjQ0oCWyskupcbdVllqUqjv31WEcbL3iD5dZ5T9CoPr94pnps
 CrpQfTdHGVSzRUbcKw37a0b29Kw2YL
X-Received: by 2002:a05:620a:4002:b0:8ca:2a02:dfd5 with SMTP id
 af79cd13be357-8cd6d38f9bemr440440885a.30.1772824112439; 
 Fri, 06 Mar 2026 11:08:32 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f54ceaesm164372285a.40.2026.03.06.11.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:08:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 3/7] test: Update comment for fs_helper.setup_image()
Date: Fri,  6 Mar 2026 12:08:09 -0700
Message-ID: <20260306190818.3586749-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306190818.3586749-1-sjg@chromium.org>
References: <20260306190818.3586749-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

This function actually allows creating two partitions now, so update its
comment to match that.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 test/py/tests/fs_helper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 4b123ab0afd..47340295fbb 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -85,7 +85,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
 
 def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
                 basename='mmc'):
-    """Create a disk image with a single partition
+    """Create a disk image with one or two partitions
 
     Args:
         ubman (ConsoleBase): Console to use
-- 
2.43.0

