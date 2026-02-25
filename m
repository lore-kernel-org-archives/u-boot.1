Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E10FD3773
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AF76841BD;
	Wed, 25 Feb 2026 17:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FMrdgys4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280AD841C2; Wed, 25 Feb 2026 17:27:43 +0100 (CET)
Received: from mail-ot1-x341.google.com (unknown [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F0984194
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d4c7d04890so6194465a34.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772036663; x=1772641463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAAvdiPZsC0XnIx160+QnapIVXqVU3cQuhKLJoL4OWA=;
 b=FMrdgys4sEiS8pn1hW/FPTDKvxJLOc9+p4XZMCzAUt0iKpEwc0jBjv3Ewr4IMTCGh/
 vX64nJP279Oc2IuUQgTAb8bOGsqqvIQwoPf2KaiNznlPfMYANm2t2HMk2KOJ1y35kmXN
 dhzXMbVpv39fKvYhAau4lB9h7GFDjfB5G3IKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036663; x=1772641463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yAAvdiPZsC0XnIx160+QnapIVXqVU3cQuhKLJoL4OWA=;
 b=iSWopsxdU/eHmClib3CQQElcLvYNmSb+eglSMT7vuEZfWDqppxvdfEOQgGZy0DxgcN
 3MG//rO2M+vLsulrX1C5OgtjNtenTUw3HQfyfSo2pjqtOxGAoJ9yI6tdGAuk3d120bm1
 cJ/WOAeZnfy2XjBMLeVAkIPfiPgL4c/gqGOQdE1Vo1Op+GPEEb3w590HRCiu28sT4OzP
 5WkP1oGbFXpZIM5WwE60wj1DAOv02n89S4TLsH4MeoFnUETG9WMsdf+p0pCsncuE0tVF
 LoC+kLPWA8OFb5/WT3/NBqT/biDfpgaEKHOl2K5B9FID5JTGj3+hahoY5xZB4QoYRdLD
 XXNQ==
X-Gm-Message-State: AOJu0Yz+pnrpmSWsrscqhibClk9938hVt+T7/s6K136anxBD23oDn9RQ
 CJBYedtf01txUna7DgHKrHjEpqNNHHnymOtjmGbBff6+XvRb52IXiE4TSeQUM8SBQbd2Lpd+2ue
 BFZKTtA==
X-Gm-Gg: ATEYQzzs02VWM5UqsG8Yig7Go+mtAgCs9G+A95KdNryekoe2w2dsUkE0wWWiAOGiLeL
 rxbg7nh/xwQkTt3BANrrVyPl/xaFUXwcG976fy82N7Y5kTA0MhGmBPNChc/q/KeR/umeuSWThpB
 0hSNVXwbkKUyulN3Hjl2iMG+EBTI58HXtHtP82MKjeYteQ1P8tKG01NK4oeWn43qnjb6P2/pT8o
 o9xJw2F9AO+6EO29RHO2JaE8cAY0nRXEFZp4l+KeoBwzk8FKmJkRsxeuqOV3A3CfAcfhY70MrMO
 10llBzKZRa2+rE+ujqJC7zUWORF/45ruXXZftoERCZ2DtFKpM+vOwK71GyN4Mu2nasanNTn2nun
 k08Iwhkjd2V3Xli4My8uZnuwxyCp0584Zm/IYR18nYEfN1+NXrlHeszf4PMZEsj7k+O/ut5H11v
 mFqsvlFyEpw6y2jQBotg==
X-Received: by 2002:a05:6830:440f:b0:7cf:db69:5475 with SMTP id
 46e09a7af769-7d52bfb9305mr11803373a34.24.1772036663174; 
 Wed, 25 Feb 2026 08:24:23 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf7874csm13534383a34.1.2026.02.25.08.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:24:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH 1/6] test: Update fs_helper to support passing in the image
Date: Wed, 25 Feb 2026 09:23:45 -0700
Message-ID: <20260225162357.3449937-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225162357.3449937-1-sjg@chromium.org>
References: <20260225162357.3449937-1-sjg@chromium.org>
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

This function is useful for other scripts, so add a parameter to specify
the image name, if desired.

Also add a flag to quieten the output of some of the tools, since in
many cases we only want to see warnings / errors.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 test/py/tests/fs_helper.py | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index b8a22b22806..d124f03a7dc 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -8,8 +8,10 @@
 import re
 import os
 from subprocess import call, check_call, check_output, CalledProcessError
+from subprocess import DEVNULL
 
-def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
+def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
+          fs_img=None, quiet=False):
     """Create a file system volume
 
     Args:
@@ -19,12 +21,15 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
         prefix (str): Prefix string of volume's file name
         src_dir (str): Root directory to use, or None for none
         size_gran (int): Size granularity of file system image in bytes
+        fs_img (str or None): Filename for image, or None to invent one
+        quiet (bool): Suppress non-error output
 
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
     """
-    fs_img = f'{prefix}.{fs_type}.img'
-    fs_img = os.path.join(config.persistent_data_dir, fs_img)
+    if not fs_img:
+        leaf = f'{prefix}.{fs_type}.img'
+        fs_img = os.path.join(config.persistent_data_dir, leaf)
 
     if fs_type == 'fat12':
         mkfs_opt = '-F 12'
@@ -58,14 +63,17 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
         check_call(f'rm -f {fs_img}', shell=True)
         check_call(f'truncate -s $(( {size_gran} * {count} )) {fs_img}',
                    shell=True)
-        check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True)
+        check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
+                   stdout=DEVNULL if quiet else None)
         if fs_type == 'ext4':
             sb_content = check_output(f'tune2fs -l {fs_img}',
                                       shell=True).decode()
             if 'metadata_csum' in sb_content:
                 check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
         elif fs_lnxtype == 'vfat' and src_dir:
-            check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/', shell=True)
+            flags = f"-smpQ{'' if quiet else 'v'}"
+            check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
+                       shell=True)
         elif fs_lnxtype == 'exfat' and src_dir:
             check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
         return fs_img
-- 
2.43.0

