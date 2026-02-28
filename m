Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128C6FEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 18:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D48BF83EC6;
	Sat, 28 Feb 2026 19:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ejpx4GRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B170083F2D; Sat, 28 Feb 2026 19:23:28 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B5683EC6
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 19:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-50335b926c2so31466211cf.2
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772303004; x=1772907804; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqmK8Wi/riQfxqqYSkEy4WoA9ZmSeEbmCexTKD20P3E=;
 b=Ejpx4GRDEV2atwOsOeOHf+3JP14pLf+nkJdydURyw7g9HforeVlnh1MYcUFODtQ7yE
 3hjSr8U/+vLGd5BOg03cs9Oq3VtN2UuiBAYm3enFtcji8cl5SmV8WlVIPVJC5fDM6ZSR
 RjUE2t8E7eqvFPTA9erkwig+lepyPYp4fdsIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772303004; x=1772907804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xqmK8Wi/riQfxqqYSkEy4WoA9ZmSeEbmCexTKD20P3E=;
 b=LPuaE6wHZBP74FSYN2a8xPw739bX1TXANie0hlWyFy63VkzyTVqTdZfSZBFatlb4wk
 rzpXj32qaOiWN0HXB4/wZsV0nSpTqI4lHz5c0HHC4xeGHi4MaXCQPuFZ+SQWsHJRL5Fp
 GWTsWnOjpkrNfiCulG1WGblRc9b16u7g9KLoepU6MHlnh70IzXJMNnbQUJh8FmGzMTxH
 Rx5BnJi4ZyrAbS17fwtj/iyAzxYJZ887BDbaqngIi1kCALMUpf8oBN/wgOX6kCqT5Qos
 GijUCf8ZYaUP7su/V786SvhTIpDJGZmYao47BQXKtl1JdX2A0oWuB6XYaoUxvLbC8BZ9
 Aq0w==
X-Gm-Message-State: AOJu0Yyi/m7P/bt/YNF6AoJEiaajuutVuOMKuWozjCSA7UzWuLdNBZHJ
 rSx4ngMdUXZlzVCH+W61hcuO6OFCG3puFhLaZ4qicOkNBxaVD0EXienmHIcbWTmwQ4NhP/hYmf/
 hewY=
X-Gm-Gg: ATEYQzxBDXMJZk2qmnpDQyILMinehYufGaw4Dw9ps+Ars1l2NqY8mRdalJwuu7/59gT
 RPJXkup9DLnqPJoPvL3wfjHP53zFiCpfy6EGMQjrT0LRjPZSjNusY/VnJj9cw8u3yUOSY00ewdg
 BjZvltLDJSvlRBSIyW+x4qOT/a6JMUOmJTSnxI6BMeE2JsYUXOJmGmZiskOoPjh1qhFvpw7xwzc
 LlT4RLJoPAym0+tzrLI7IDNtpEZ4j8SpohTsbD+WgFRVhdc+5GARv8XP1MPglboFbnYI/9EyJfj
 08SHjhLChelg0YxUWn3Ix7lmO/g+DET6wdPE+8GAPPHeyRT3EbrIZOAnj/ZiA6fa2yb7XbYZoBY
 ehbJF9C/2MvuziGAA5xtOJRItqI7ifOXLv6qJs71i7kuua/9l15LS2O6xww3+iP0aT1tkbBZ2ew
 lA886M0DKimnPXOoe07oVF1IG2Ynu8
X-Received: by 2002:ac8:57d3:0:b0:501:3df2:fd60 with SMTP id
 d75a77b69052e-507527cb205mr112166861cf.12.1772303004136; 
 Sat, 28 Feb 2026 10:23:24 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449a66f1sm78508601cf.12.2026.02.28.10.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 2/7] test: fs_helper: Add a quiet flag to mk_fs()
Date: Sat, 28 Feb 2026 11:22:42 -0700
Message-ID: <20260228182304.3728735-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228182304.3728735-1-sjg@chromium.org>
References: <20260228182304.3728735-1-sjg@chromium.org>
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

In many cases callers only want to see warnings and errors from the
filesystem-creation tools, not their normal output.

Add a quiet parameter to mk_fs() that suppresses the output of mkfs
and switches mcopy from verbose to quiet mode.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Add new patch to split the quiet flag out of the previous patch

 test/py/tests/fs_helper.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index bd9169b2a4d..4b123ab0afd 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -8,9 +8,10 @@
 import re
 import os
 from subprocess import call, check_call, check_output, CalledProcessError
+from subprocess import DEVNULL
 
 def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
-          fs_img=None):
+          fs_img=None, quiet=False):
     """Create a file system volume
 
     Args:
@@ -23,6 +24,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
         fs_img (str or None): Leaf filename for image, or None to use a
             default name. The image is always placed under
             persistent_data_dir.
+        quiet (bool): Suppress non-error output
 
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
@@ -63,14 +65,17 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
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

