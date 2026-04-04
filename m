Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6CEE88D9D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6778407E;
	Sat,  4 Apr 2026 16:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T9163AIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D977840ED; Sat,  4 Apr 2026 16:03:57 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A91B84020
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-41c420d1460so846716fac.3
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311433; x=1775916233; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMoGHOaqF9w9n8yN2izhCpnr/grNuKtnhFwHRXPEr2M=;
 b=T9163AIBpnZEpjgKNgu7Qu10IHMNrnPCaKkoToaq/8FXQmpn+OeDhJaQKeaXi48+NR
 jX7vVvuvrIBcfojIR2uDc9GCPBxwUcLcopqr9u2maivC1idpz9TMvxPhle7PIvThh6L4
 hrAV8d6yiORYjfMX2/SZCyPS9y263PZmj1qeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311433; x=1775916233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pMoGHOaqF9w9n8yN2izhCpnr/grNuKtnhFwHRXPEr2M=;
 b=g+wEN4Br6d0MRVjLl+C6bYRSo7sWNSPEWPJQl10dbSK21daeuzz6EsraXCwcA1Btj5
 1wBq+aC0NhRJOQRIJLKhvWAARbnU6Ro7AjU7NJ/dErTHNCAItu176GeSNZ5me1VJzmXS
 rAm06XeoCn0elO3rb06x7W+oYJCQfPGSwKdmjcHsjEn6JPEqs5qAIwbU7Y6YY1lsnaPb
 OJvtYKK7GIRbH0Q2xcEKOZyaKXCv1hdrFexTToPsR+DN6WBnOsj3r5gWz+NlDmjvPbNh
 3JxNFeAYJ0a45MMdKJHIlWKXCcO9fgQS+mVUCAMkr7ICtPD09K/V7iPHWfl47QQeA/ls
 wQFQ==
X-Gm-Message-State: AOJu0Yw5pyOPM2pTHyMPt3SOa/YatqasSF8cEraO7sPc9A/d41f7U3n3
 6AG0CEHpOsJCqCmAe3g/PhkWEtPegjKr9jkHVxPiGh+krRAq3vmoUknjWwqWGbsEvf3Y9v1Naua
 9T4w=
X-Gm-Gg: AeBDiesiUbvIxpZZwHcD9BnNikpa2GhglP1OZs/goFzWSr/2rzurWc1ZAOTV4Cs5+fJ
 ZoF5bmE7jxLccgS6yPfWla0BEtyi8eIIH5+NPeP7jQR+Kg0YaDtZDxt/r4IPL7TqncDsAgXFRhM
 fmLgWNjA6sN19JqkT70h/Lav+bM20b7W+rqm7WSCzilv53VA3COteUVz7MFKjKUNlte3dbho2Y9
 nkFre3hrHnwZ+cuYYGofQevLst5hCrtv8u7O9Wll1phkxCJwnWZgEchuZ/pPl90YscKYY5ysopN
 SZ2SMh/2nlw1vctpaCF2m6DrL4TqIPRuE+YOV3YPCDJ8GUyljl7rDJbOvJ8Wsnvy9rOHKw2W+Jc
 HZ5EzF+LeZrdeJKX/V93Qsr6/SnFfo9ziw5v5hSK9SGQR9RIU1RcnKRwFbDxgXtRTenvc+DWdj6
 UoK7jaVuO8KrOugA4d+Q==
X-Received: by 2002:a05:6871:79b:b0:423:1a33:c275 with SMTP id
 586e51a60fabf-4231a342d07mr3053146fac.9.1775311433146; 
 Sat, 04 Apr 2026 07:03:53 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:03:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/14] test: fs_helper: Skip empty srcdir when creating a
 filesystem
Date: Sat,  4 Apr 2026 08:03:06 -0600
Message-ID: <20260404140328.3724864-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404140328.3724864-1-sjg@chromium.org>
References: <20260404140328.3724864-1-sjg@chromium.org>
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

FsHelper.mk_fs() always creates a srcdir via setup(), then passes it
to the module-level mk_fs(). This fails for filesystem types like ext2
that do not support the -d flag, raising ValueError even when no files
need to be copied.

Pass None for src_dir when the srcdir is empty, so that creating an
empty filesystem works for all supported types.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index e323a97b220..ee779474ce6 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -66,8 +66,9 @@ class FsHelper:
         """Make a new filesystem and copy in the files"""
         self.setup()
         self._do_cleanup = True
+        src_dir = self.srcdir if os.listdir(self.srcdir) else None
         self.fs_img = mk_fs(self.config, self.fs_type, self.size_mb << 20,
-                            self.prefix, self.srcdir, quiet=self.quiet)
+                            self.prefix, src_dir, quiet=self.quiet)
 
     def setup(self):
         """Set up the srcdir ready to receive files"""
-- 
2.43.0

