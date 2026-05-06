Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCF0CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5F7E84A0B;
	Wed,  6 May 2026 17:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gPNUS048";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD75D8466D; Wed,  6 May 2026 17:58:15 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC446849E0
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d1872504cbso967918a34.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083092; x=1778687892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AANlHPaDtzMf5KrVsVAqojxH8uytooUrOmS6Gj31AHY=;
 b=gPNUS048mARVbc7eDxFuQogm4CHB/eLDtdwPat9hNAHryY85/gofWKCHpOd9zhE5g/
 P9eknpOLZPrxq5Iy9FGNcufGbNg7p5Uxa05PI8Xz8OcKGs2otkvJXaSuvfDh+WL5D7QF
 7D3jCoWGdQgfVKkOFqliqp4H+udD2eHl3dvWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083092; x=1778687892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AANlHPaDtzMf5KrVsVAqojxH8uytooUrOmS6Gj31AHY=;
 b=cl/N19HqJ28JQcIAQiHMa98KQwoD/igA5ghaWZJ4NR0ZKwQQmx4vvkcJxrchidtdNd
 U+XATmez8xkP7fNAs/x20PpMLN5c6z+aYrVotpJJeZdwlMqTdKTO4ry/3dCHuYkRbw/C
 bmwTWavWL5/k4NBz9debMAwt3X/b+QSUDgJKwdgilKaIswdXZvKnmTusxa+cLAzFewCg
 noygLsazhnME8+GLwkSZJLZI/xwaHWlcqKtmCmY1odcptdlRcN+a2pkEOdUzwgn6hPl1
 UIUksv02yq5ot0/hJWQcjX4p+6cjVOB25D5XykKqZ5LVPeVQCMaxIg2JEX5dPYRfj4Y4
 auqg==
X-Gm-Message-State: AOJu0YxlfKfxjxADOxXuWdqGX/cpxz7fi/mesp5tNHxlu9RNndHf+1ON
 SezPSWaNqhtoURNEPIMXJjKJ2wL/xMZU9mZ7vgdc23HGnFYpkwY/KoWCLlAvA7m4OhkXR4WzTym
 AVB3QDw==
X-Gm-Gg: AeBDieuAtz/RNaEQPHqHm+UVJTHafVjVl3qEdDJOIb63TQPNKCSp6PpEjw6cszh2F59
 AAIF8mjncgH//seZ8b0aK7omQeDoBP+fXwGd0LzaCIZ+RO7j2ItsatSzYMCIITfrwT7fSUfNWI7
 05q6EslN7rTJ9q7CQoKibEvmCIQMdXFe69A3C1F98S2rCmyse2uHqB9ZtJwko0UT/oZrqUblIFB
 Mhd+A+lCGm4CyQXztFN5QttMBNSn6aPNl6sPIh0A62dJFoHF4R+419120VefzH2iMDrCWlNMHA7
 Kxg6exfETn6iWY7X/dEsNo9eVETDm429O42w09K5aUw1Chvg5HGKOywPsP9mo88VnjhGk/uW1EH
 Ks0QfIo7R8qt8QMAoDr+s79TPzdMpmg8CPZYgVgMah/O/8dzdQYo2vMt6MhbKoKAJaIVQPGeIZ4
 my6otiaKuww+9efOwdhnkuois9vEiX
X-Received: by 2002:a05:6830:3689:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e1dd75bbd0mr2904218a34.8.1778083092127; 
 Wed, 06 May 2026 08:58:12 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:58:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/10] test: Use Python truncate() for image file
Date: Wed,  6 May 2026 09:56:23 -0600
Message-ID: <20260506155639.1191640-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506155639.1191640-1-sjg@chromium.org>
References: <20260506155639.1191640-1-sjg@chromium.org>
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

Replace the shell 'truncate -s <size>M' invocation with Python's
file.truncate(), avoiding a subshell for what is just a sized empty
file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index f81b9c274dc..7659f9e2650 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -108,7 +108,8 @@ class FsHelper:
         mkfs_opt, fs_lnxtype = self._get_fs_args()
 
         check_call(f'rm -f {fs_img}', shell=True)
-        check_call(f'truncate -s {self.size_mb}M {fs_img}', shell=True)
+        with open(fs_img, 'wb') as fsi:
+            fsi.truncate(self.size_mb << 20)
         check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
                    stdout=DEVNULL if self.quiet else None)
         if self.fs_type == 'ext4':
-- 
2.43.0

