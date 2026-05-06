Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F127CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273FF84A17;
	Wed,  6 May 2026 17:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EmKsJfAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 414808468B; Wed,  6 May 2026 17:58:18 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2356E849E5
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7dbec19732eso5021595a34.3
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083094; x=1778687894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTkL5uCIsyWGyyGAtmUTvLGLLfRLLMR0m/ox7e8zQr4=;
 b=EmKsJfAPTrySOHdoSEbYNCP0EHexCrstORxHmuQDsMfdFe0h0PUgKUFZ0W7Wu6lVwG
 srfKIaXt21295tfIL8eup54J+70hjFlzl/v0Yt+yK88xeJw1EU4dxVWwLJra5051Qtru
 lRzJpWxaa7ueTTn88qtqZqZqd+35u7Ony9kPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083094; x=1778687894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sTkL5uCIsyWGyyGAtmUTvLGLLfRLLMR0m/ox7e8zQr4=;
 b=Bwo27u/NdAWJrzmwuV65mCAy20twOFXoxxqzn975iJvLE/Ib5nrvZsMwbQAgTQdwM1
 777MzK1M83iUeGNNxliD+ExgIOYbsfIXKrO5StWwELUdkI4zHSCzPJRsf9PlRP+XwaBt
 yJrsR0fGAZmpXpUMwvDeRH6DwMguAln3EdmXZUDE5seqnjqZ8zV2Oa4SZB5gXxugyeXt
 fJE5Fs/yEMuAex6azLERo6U1X02doDP2Bk/5NCiCYRhMv3Wcs85U/6S/55SG+cq6IakQ
 XRGTqUt2tlwTaVzPrGmQsiHIeaOxHPIXgmvLD9cKcu2I23NhwPxKGtPzF/0PT5PdhYIc
 3hdg==
X-Gm-Message-State: AOJu0YwYGjcL14LZm8M3hs+vFU7cZ05qY2abMY2Qqbquiea7SaxqJYbx
 A0zupx+eTBnpxs5nyQYzb4zPQDE5tnBkIkviPZc9O8Px8/5KQUr7ErbTfPWroUCgEO0sq6LCGDO
 /nA+rQLlX
X-Gm-Gg: AeBDieseU39esIiykKzpylCpfWHak8foBrewlm9faIEyT7zUfvgC+6fDDWEbNI6djKR
 qVn5KOVE//3ze9rchNHdyv2by/xnMlwJCcpYbc6NtUjhENliNnZESF2xNxoeEaMykF7Q8SGXdTh
 nPnWh1auvdgXnSTr2WHvL5qwoyLCJFNIPL3DgATyocZT9coUU7IuPSRPcClstlzRRk6ZhbPldj5
 ussY69dN+6GhGFHGUn8SDTQpWLoChEZfRxYhs///7+LNzVBQtX0rQvF6PzL1v3vDWcz0L9Vch2x
 LfMtij8kb/joeZpGEHh9IzLATU9uQ7yBurY3o1PfYBMHxNNz+T4PhPOJ7iOsH8JPnUsfOeOBf1H
 7dYM6hSiuW8wm6wK0MNvLKq8/vEnGFn9QDRfUb/3A9agLQio8DVm2MeycJEo4H5/d+GYhnR3pey
 jUD7OUFIQ/Gqzk1vmYFJCqL989uQWM
X-Received: by 2002:a05:6830:82b5:b0:7d7:f15b:bdcf with SMTP id
 46e09a7af769-7e1df1a93a3mr2101666a34.28.1778083094320; 
 Wed, 06 May 2026 08:58:14 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:58:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] test: Set the default fs_img in the constructor
Date: Wed,  6 May 2026 09:56:24 -0600
Message-ID: <20260506155639.1191640-11-sjg@chromium.org>
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

Figure out the default image path in FsHelper.__init__() and let callers
override fsh.fs_img before mk_fs() if they need a different filename.

Move the pre-existing-image cleanup to __init__() so mk_fs() can drop
its 'rm -f' shell call and just truncate the file directly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 7659f9e2650..3ebf3036804 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -24,6 +24,13 @@ class FsHelper:
 
         # The filesystem and srcdir are erased after the 'with' statement.
 
+        To set the image filename:
+
+            with FsHelper(ubman.config, 'ext4', 10, 'mmc1') as fsh:
+                fsh.fs_img = 'myfile.img'
+                fsh.mk_fs()
+                ...
+
         It is also possible to use an existing srcdir:
 
             with FsHelper(ubman.config, 'fat32', 10, 'usb2') as fsh:
@@ -32,7 +39,8 @@ class FsHelper:
                 ...
 
     Properties:
-        fs_img (str): Filename for the filesystem image
+        fs_img (str): Filename for the filesystem image; this is set to a
+            default value but can be overwritten before mk_fs()
     """
     def __init__(self, config, fs_type, size_mb, prefix):
         """Set up a new object
@@ -54,11 +62,19 @@ class FsHelper:
         self.size_mb = size_mb
         self.prefix = prefix
         self.quiet = True
-        self.fs_img = None
         self.tmpdir = None
         self.srcdir = None
         self._do_cleanup = False
 
+        # Use a default filename; the caller can adjust it
+        leaf = f'{prefix}.{fs_type}.img'
+        if config:
+            self.fs_img = os.path.join(config.persistent_data_dir, leaf)
+            if os.path.exists(self.fs_img):
+                os.remove(self.fs_img)
+        else:
+            self.fs_img = leaf
+
         # Some distributions do not add /sbin to the default PATH, where
         # mkfs lives
         if '/sbin' not in os.environ['PATH'].split(os.pathsep):
@@ -102,12 +118,9 @@ class FsHelper:
         self._do_cleanup = True
         src_dir = self.srcdir if os.listdir(self.srcdir) else None
 
-        fs_img = os.path.join(self.config.persistent_data_dir,
-                              f'{self.prefix}.{self.fs_type}.img')
-
+        fs_img = self.fs_img
         mkfs_opt, fs_lnxtype = self._get_fs_args()
 
-        check_call(f'rm -f {fs_img}', shell=True)
         with open(fs_img, 'wb') as fsi:
             fsi.truncate(self.size_mb << 20)
         check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
@@ -123,7 +136,6 @@ class FsHelper:
                        shell=True)
         elif fs_lnxtype == 'exfat' and src_dir:
             check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
-        self.fs_img = fs_img
 
     def setup(self):
         """Set up the srcdir ready to receive files"""
-- 
2.43.0

