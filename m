Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B11CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC5B848FD;
	Wed,  6 May 2026 17:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HrDZVT6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E67E84A14; Wed,  6 May 2026 17:58:05 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC88E8466D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso5883298a34.3
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083080; x=1778687880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHfJnWtrhuT9QZAta0ki5lWVGcAG63OZCmXX0Z99y08=;
 b=HrDZVT6TPNlG7gMeWi8CQlspeJuNKZ2p6eSkbx3LPw6Ln/O5AoMnA9q3Dt61cPmvIq
 +cTVFr5krbUt1dfu8KFzBT00FFwRd8fqROL6sTZE0sVPzeGYRr+x/L0Z6gYQj5aZCYY4
 fXlQDXLgcNzDgnElKeOq5pI1Xdo21t9/CR7eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083080; x=1778687880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZHfJnWtrhuT9QZAta0ki5lWVGcAG63OZCmXX0Z99y08=;
 b=dpHcpUGd+U6CvJBLFhF6tJK3V1nNKucZmH2X2hn7ArncyzW50JIJJlUZ/ZrSvMZfQz
 qILZn1RmsmWF04dso/Lh8eEsB5WjUN+ach6GwjGf1fYFXD4k8//nd6fXbaBC0fDn4KgV
 s5FRLmMYLrEfLtGGbEOCXc8f+hb8OlwOEtjwD5xmuRBAC1SB+jczw4wM0/ySSZjxU9We
 IuyfTqeRZI9L/w3sv1bWv0LhkbsEJB6pPHs0K9nznowIDLBdBZLy+BsGu4Dcn2jvpdw1
 6Jgr4FkZtAVbKh3tiTlWmZ9F+oFHVDrtfV+BikH5pWYikhE9+9RA7/P+9WWUOf0MWGxa
 GJqw==
X-Gm-Message-State: AOJu0YyHPY0ropFzqAbt6dpH3zJY+mdzk3yZdyJXvn/cF0/n3TI31idC
 UuaENsX/MW5sTZXKC0YqrvSy8GZFp2zHnrrjmWXg2m9tPld345LsgudzGcVktY5xd2l22ggj/n6
 P0b5B7Q==
X-Gm-Gg: AeBDietczaVkc00cZeK2h35502a0WAumTwi7X9MuusfYFbD4AH+YRjX2ms5BBhVRk2K
 Xuwa/yoTHb6ki3qQKXQqhPDSMzn9QEb8QGGsxayFg7JYK76uX3dNHyqdQ9YGFOBV7wQpto78Oq0
 NBf1zPr562ggJNLPK933hNbsOVHBYnj4rnCW8BxkNOg7oBG37rxFdB0HLQ7MuWt69ZdflffLi0N
 Nx9S+uJ2H6NlJHzKxV/fW3eF5xwyQhMW1V2nGrN3S0B/CwZVSJQzwzL6uJ//w+nGoIRWt4qeUqL
 mopGEn6pQJoyggUCHz3S0W9TTI7rF3sVisInagGDkRzf5l3Zl3e0GluEujE6wHHZ857u8T3/7R5
 SSNWq96tCl1b8zx4PJcXFIZoI5+uQYC5dVzrpaVB1QeNSmFBJL3nxVDdEj0hmY5/i+ceDvyULyz
 PJhb4UM9wmtl5SGI8+MUDjM7KEIMVC
X-Received: by 2002:a05:6830:82e8:b0:7d9:ad90:5670 with SMTP id
 46e09a7af769-7e1df0d2a13mr2315830a34.18.1778083079624; 
 Wed, 06 May 2026 08:57:59 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:57:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/10] test: Drop unused setup_image() helper
Date: Wed,  6 May 2026 09:56:18 -0600
Message-ID: <20260506155639.1191640-5-sjg@chromium.org>
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

All callers now use the FsHelper and DiskHelper classes, so this
older procedural helper has no remaining users.  Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index ee779474ce6..04cb01fa074 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -261,40 +261,6 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False)
         call(f'rm -f {fs_img}', shell=True)
         raise
 
-def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
-                basename='mmc'):
-    """Create a disk image with one or two partitions
-
-    Args:
-        ubman (ConsoleBase): Console to use
-        devnum (int): Device number to use, e.g. 1
-        part_type (int): Partition type, e.g. 0xc for FAT32
-        img_size (int): Image size in MiB
-        second_part (bool): True to contain a small second partition
-        basename (str): Base name to use in the filename, e.g. 'mmc'
-
-    Returns:
-        tuple:
-            str: Filename of MMC image
-            str: Directory name of scratch directory
-    """
-    fname = os.path.join(ubman.config.source_dir, f'{basename}{devnum}.img')
-    mnt = os.path.join(ubman.config.persistent_data_dir, 'scratch')
-
-    spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
-    if second_part:
-        spec += '\ntype=c'
-
-    try:
-        check_call(f'mkdir -p {mnt}', shell=True)
-        check_call(f'qemu-img create {fname} {img_size}M', shell=True)
-        check_call(f'printf "{spec}" | sfdisk {fname}', shell=True)
-    except CalledProcessError:
-        call(f'rm -f {fname}', shell=True)
-        raise
-
-    return fname, mnt
-
 # Just for trying out
 if __name__ == "__main__":
     import collections
-- 
2.43.0

