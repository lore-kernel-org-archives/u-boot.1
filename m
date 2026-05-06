Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549F6CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A678484A0D;
	Wed,  6 May 2026 17:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zlarz6LM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 836AF849E5; Wed,  6 May 2026 17:58:14 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB481849F6
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dccda31d3eso1807401a34.3
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083090; x=1778687890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1Ns4tyep+rD9F9FntYbSXGEOFvPxNEpiyal0pMl/r4=;
 b=Zlarz6LMEBO1B0dmhaeMoAvli/oMGRlHSfKRGMObyuw+3aXkf2MPkTwnCUcjXQEmBK
 DTicply1GNkkpAxN+0HCfdy1O17uDWPUPqOli4KtaBPd9YTdzHaq+VkmE2YQ1TTHZzuY
 PX5S0SVxAvrOd3sB4+unlVR+ow6MrteJHC+eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083090; x=1778687890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o1Ns4tyep+rD9F9FntYbSXGEOFvPxNEpiyal0pMl/r4=;
 b=GMU+PtE1iuCmHhesfJO0RYDCcxuaBAkInmUNw0u7CLmRoUOM0ff9A+cuFfrOt4u1Yp
 z1vN8VqKZsL368y7FHxYWC3Tjub003GNxm463a10w+kxcOGasKl0s0II62urcnsnd6XR
 p0XHMkkeupVIAT9S/WsE0qk5PRXLwiCNxrinCUJIeIRaIrBOcIFsMfSzbFtHXRKmH5/e
 DSWEL1/a8REcxRB337uU35M9vPL3csmcIYk/8U+14+YgxdgKDzgD7m5/clyWsSZ8rwet
 2jFQu+e+WsJtGcLiPMQi3GZmm9TFJYi+sWb4l/BJ+SETn87vZlmHjBZ0ktRqjrS8rH+4
 K4Og==
X-Gm-Message-State: AOJu0YyKbqbE8BObgf7G3WtSdAepq492wb3qPpJpAW0bwavL/WDjTeru
 hbwrGSooZVGubegxc2Odk0nVEB5jHxizzeck3JvXZl5Qb1zexhl2PH1lY0sgzu0iXFs/CXa4ZZr
 3GJBXAQ==
X-Gm-Gg: AeBDies1YP8i05lZajxpeaVmyGeuWsl8E+YxUb8mcpSsAkvWuktyE5AsPn08VMP29WO
 R/rtiCgBt8yuJfckJpfwzuw/E3VdHxmw4O8vYvXBluUm5vpktaJixUkMBoWDAtFzziw44H/ZljL
 Hl6SYuoqze8iVKYhiuxN1FIQu2Igg0mtzinmphYQM5rW5xgZURtNhLHM/dOOPZAwkiwqkJrYz7a
 YpXgfJNPZAneud9ZZT0gIokpk0lackTpdMwVauPlo8KFH8fjo2g7d7zeRmXUVVLfcaPKFB8pp8k
 VR5LE5h0ZXFT/3sVqpMskzP3tVyZEL/yCieyZ4OXMos6pz5DNLvY8o2hZeaEx755btx55G5PhVp
 OD4enLoW45FDKc4kdgnn1Lj1M7DX4f2XSYt7fjWB8a9fTstTjvMCQCBZQUBRQ/ET7NqFSiFbkEX
 RTj4msDEWGYTF6mZyhpzi6jx9NC9Lw
X-Received: by 2002:a05:6830:82e5:b0:7dd:5a21:2246 with SMTP id
 46e09a7af769-7e1df225a63mr2044927a34.25.1778083089822; 
 Wed, 06 May 2026 08:58:09 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:58:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/10] test: Tidy up the mk_fs() logic a little
Date: Wed,  6 May 2026 09:56:22 -0600
Message-ID: <20260506155639.1191640-9-sjg@chromium.org>
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

Move the /sbin PATH workaround into __init__() so it runs once per
instance.

Drop the SIZE_GRAN rounding since size_mb is already an integer count of
MiB and truncate(1) accepts a 'M' suffix directly.

Drop the try/except wrapper around the mkfs commands so
CalledProcessError propagates naturally.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 54 +++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 3983d42f5ce..f81b9c274dc 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -8,13 +8,10 @@
 import re
 import os
 import shutil
-from subprocess import call, check_call, check_output, CalledProcessError
+from subprocess import check_call, check_output, CalledProcessError
 from subprocess import DEVNULL
 import tempfile
 
-# size_gran (int): Size granularity of file system image in bytes
-SIZE_GRAN = 1 << 20
-
 
 class FsHelper:
     """Creating a filesystem containing test files
@@ -62,6 +59,11 @@ class FsHelper:
         self.srcdir = None
         self._do_cleanup = False
 
+        # Some distributions do not add /sbin to the default PATH, where
+        # mkfs lives
+        if '/sbin' not in os.environ['PATH'].split(os.pathsep):
+            os.environ['PATH'] += os.pathsep + '/sbin'
+
     def _get_fs_args(self):
         """Get the mkfs options and program to use
 
@@ -105,36 +107,22 @@ class FsHelper:
 
         mkfs_opt, fs_lnxtype = self._get_fs_args()
 
-        size = self.size_mb << 20
-        count = (size + SIZE_GRAN - 1) // SIZE_GRAN
-
-        # Some distributions do not add /sbin to the default PATH, where
-        # mkfs lives
-        if '/sbin' not in os.environ['PATH'].split(os.pathsep):
-            os.environ['PATH'] += os.pathsep + '/sbin'
-
-        try:
-            check_call(f'rm -f {fs_img}', shell=True)
-            check_call(f'truncate -s $(( {SIZE_GRAN} * {count} )) {fs_img}',
+        check_call(f'rm -f {fs_img}', shell=True)
+        check_call(f'truncate -s {self.size_mb}M {fs_img}', shell=True)
+        check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
+                   stdout=DEVNULL if self.quiet else None)
+        if self.fs_type == 'ext4':
+            sb_content = check_output(f'tune2fs -l {fs_img}',
+                                      shell=True).decode()
+            if 'metadata_csum' in sb_content:
+                check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
+        elif fs_lnxtype == 'vfat' and src_dir:
+            flags = f"-smpQ{'' if self.quiet else 'v'}"
+            check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
                        shell=True)
-            check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
-                       stdout=DEVNULL if self.quiet else None)
-            if self.fs_type == 'ext4':
-                sb_content = check_output(f'tune2fs -l {fs_img}',
-                                          shell=True).decode()
-                if 'metadata_csum' in sb_content:
-                    check_call(f'tune2fs -O ^metadata_csum {fs_img}',
-                               shell=True)
-            elif fs_lnxtype == 'vfat' and src_dir:
-                flags = f"-smpQ{'' if self.quiet else 'v'}"
-                check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
-                           shell=True)
-            elif fs_lnxtype == 'exfat' and src_dir:
-                check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
-            self.fs_img = fs_img
-        except CalledProcessError:
-            call(f'rm -f {fs_img}', shell=True)
-            raise
+        elif fs_lnxtype == 'exfat' and src_dir:
+            check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
+        self.fs_img = fs_img
 
     def setup(self):
         """Set up the srcdir ready to receive files"""
-- 
2.43.0

