Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA11F41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B6783F9A;
	Mon,  9 Mar 2026 16:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GLy+ox/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB6B83F9A; Mon,  9 Mar 2026 16:13:35 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6131183F9B
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-50697d6a69cso59565521cf.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773069203; x=1773674003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPRHd1A5vqwXzXB8uCcbDwYf3Q7C2uG4pC/6y2d1Zf0=;
 b=GLy+ox/folx0BRWIbF/7ZNkJr1nPRV2qxTYVob//DyVyCme8e0DQ68KInfbROtSACI
 xXxSyFbVnzTv6XA7CrP7BmrXMZ89vo+0AuYKnYwZ+oj/xiDhxq10gJjV2R1wAe5ADJLG
 i05inJgvNhxV9xSAtdvfkcB+FoOYXI1z7oYLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069203; x=1773674003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kPRHd1A5vqwXzXB8uCcbDwYf3Q7C2uG4pC/6y2d1Zf0=;
 b=ZDoj6PedMBHwD8XGGKNgZ0eU8dUTbRcjr0v7ArEZVVFgqKBn5ywoMVoo1mHyfEy86/
 X6MDv3LbxhDyw9sDvVrjqDLfDG0hbYZgexJqTahG9ph8douMebU7EskfXG2RuOof+TVg
 Lo1jtazO3nRFLW2ZVGYcwNsBEEXAFtG+EAf+/+r0kYXGG6w0SaNTfHVXQgTjAhpkuxVd
 Nwo4LWhnh+rTnUbAhGWk1pWx73wvExKvXkiTDonACcKudGDd/Wr/BosOj+oVlkFCxaqK
 QAEEeo/UViZLhs0ww8k5FN+DIAkq7Tq2zjNd7qT0qpYE3a5FjL+qJh+WhqJda6gTDh1x
 SD1g==
X-Gm-Message-State: AOJu0YwSTduRHexRgrARq+8P6KJ2MVRVoAgoFLVksFO10Lnjet7uuKPX
 MYqbC6WZVwyLyh/ktiLOQKJQy9IKLC3Ef4C/9Am8UAhyq6PQVJOa/Ek9Xd39OqbF25T0PmyZtjy
 74n0=
X-Gm-Gg: ATEYQzwF1wYrk+zOcaPPXtqgIJptbJThVPxUkRx2klZ6CfWS2djUEuWm5Z/ZO7jk5UI
 qYxPz41Y1VNS9kfEH8yncknyGuFAgyXWNM1cDU0u2J0Lr+O9G1Mrwa9BVhtNUpngFbKdiO5Ke+P
 i10R9IyZuivqnUsm6tr0LQNy15HdiMVqS9idMpvBYB8jyzADWtbk8rWVavjmqXQjn0jxovjz1vg
 2/lG058/a68uxfPwEOXEwgBPVG0nBW5X7yqkZHVIQpa4OYweof7z15o5F0qLTVti5i7jfcaIDx6
 4EQldBUpwUv9SfifqKvHnFRWXk4YD77YUc3atpSLH/VJtC1HTMr9RM/i4b/vkqfCPNplmhA9B2U
 zpXO0SIqd7/SY4LITp7Ir8bVBmz832cEHyceVrOMMBI8lxtW7yU67hgZbw1Q0fzeySKk8acr25Q
 /rvKOEX8W0zIFlzSBLuw==
X-Received: by 2002:ac8:5cc9:0:b0:509:481:537c with SMTP id
 d75a77b69052e-50904815c2cmr99372481cf.45.1773069203530; 
 Mon, 09 Mar 2026 08:13:23 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5091a7dec85sm19337291cf.32.2026.03.09.08.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:13:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v4 2/5] test: fs_helper: Add a quiet flag to mk_fs()
Date: Mon,  9 Mar 2026 09:13:01 -0600
Message-ID: <20260309151307.831537-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309151307.831537-1-sjg@chromium.org>
References: <20260309151307.831537-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

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

