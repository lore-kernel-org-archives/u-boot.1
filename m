Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E5CE7FDCF
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 19:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5899B83CBD;
	Tue,  3 Feb 2026 20:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eMUe95Mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB8183CEA; Tue,  3 Feb 2026 20:16:25 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B4C83C39
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 20:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-4096aab5521so4159162fac.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 11:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770146182; x=1770750982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t8AUPYIw+UKzKBJygykbmN1ynjjqIirFpBRo9x8LWWE=;
 b=eMUe95Mw+1UZagz8rwXwc+8H2fItDouKr8c58EziFCjRJ8YKgVrw/p8KE2+X1Hvkq4
 zMDDKc+UiZnTVy82dDCv1BVbojNdCTL5ehTnnDjyxutEHUZTavXgSayETdoiYh/Syqho
 uqQjwETNaNJZt59YID2F0CAPkndazhKwFpvyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770146182; x=1770750982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8AUPYIw+UKzKBJygykbmN1ynjjqIirFpBRo9x8LWWE=;
 b=jA8hQ+A96kjTyiKDLLtl6OejllSW7XcOQB8qzd+G8oEqBkhLTWu4OgZO2RIMZ7fZEw
 l3EUxGjR/9D/tFGAW2GeIzGX1UXIISUreLzpw8amGQ79toqYdRzz6kIFTAcrR4tHP0bm
 LBzjBbHFZI4ptgWW5K2dYGPMjtjjdxHBUCFhtlpV0GSeS+eVgN6JBlQ8CBwB/CR8ZfeF
 H70j0hTrB/NRyYExScuIopaMNyL3AtoGCt5tcS8d4pqxarqu/2ESliOTUAJr2e4R7u1K
 Vu6Oe1jRaGJv5uGyPErYqnhwPiYmOWT1P7Sqis9Q2DqqbuFlgosygvzT1Q6zgjiwNn9J
 HQhA==
X-Gm-Message-State: AOJu0YyoiRUYn1532hLbCtq/N3FmKNVTyA7KnMBbNNX83sCvtbbPZfC1
 1murYrXYn3pOZb+b7ctfE+mwmIsVnK29EYcaz053LGfiYz9t+t+0lv9tdKgaXvm1FD+fdf/uvug
 p7Zel
X-Gm-Gg: AZuq6aJ0/kccaNNtHCKdZrv+F9MDffKFNERDemAEkMRmF9rNCHZAv8NNSkFKqYBmLri
 qQx6ne3j9m2RgLR7W10Pc6qN41CAKtmaQlmAkxx5hNYo1aFH8WlyunsgI6n4JrZSu5APy5Cc5Y8
 q9LtM06v6KEGCfnG+d99eSc4TTHtuZECzZaYp1w3bxxveAWPrjIUcWH4o0hI1a0zTA/FOQANSYm
 PGoRfdq5y2yQDbx9uSiKP35q+r8iRgL0xxmc04iQTsEceLzEPQXDbv00X3YlyR6ffdK/EaImYWk
 IM4YyFrrXuvtITu8b5FQghjuHdD9P7Exjl9fwqwF+W3l1ZhVJfLuvl90lquUvPcoayfirH63amk
 epk0duuGxQNQVQviFz+K9MYDxL08gDVVavPUg7W+qF0utRhAMQIJ2AIB4R7wG9w3s86gsJWgyRc
 JiCbVs82K6w0sptipU4r8OK9eG2iURiOqkhVq61xv/yXhdA+OgZVUhCqNMuoPyJ8+UyuYYnXJbX
 S3JYfzKW2jFUmXu2iOL3iTTGaMVIzju4m2vB29mGw==
X-Received: by 2002:a05:6870:e80a:b0:3e8:5127:e75b with SMTP id
 586e51a60fabf-40a53edf084mr227165fac.30.1770146182139; 
 Tue, 03 Feb 2026 11:16:22 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f028sm193584fac.2.2026.02.03.11.16.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 11:16:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] doc: develop/process: Clarify name usage in the Signed-off-by
 line
Date: Tue,  3 Feb 2026 13:16:20 -0600
Message-ID: <20260203191620.1476575-1-trini@konsulko.com>
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

Long ago we took the Linux Kernel documentation about adding a
Signed-off-by line and adjusted it slightly for how we organized things.
In 2003 Linus clarified the intent and then re-worded what the name
portion of the Signed-off-by line can be. Mirror that change here.

Link: https://git.kernel.org/torvalds/c/d4563201f33a
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/process.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index fd81d9c5ebd4..3c783ed5a0e9 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -139,8 +139,7 @@ document.
   message by which the signer certifies that they were involved in the development
   of the patch and that they accept the `Developer Certificate of Origin
   <https://developercertificate.org/>`_. Following this and adding a
-  ``Signed-off-by:`` line that contains the developer's name and email address
-  is required.
+  ``Signed-off-by:`` line using a known identity and email address is required.
 
    * Please note that in U-Boot, we do not add a ``Signed-off-by`` tag if we
      just pass on a patch without any changes.
-- 
2.43.0

