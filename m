Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BC4FEE4C8
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 18:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8AF83F0A;
	Sat, 28 Feb 2026 19:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QmYVhRhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8110483F00; Sat, 28 Feb 2026 19:23:25 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F80283EC6
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 19:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-506cb1b63d0so39294751cf.2
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772303001; x=1772907801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsKuajzTKQozsW/QbloHx+PiVsPF/sJahRdcvT8/8HU=;
 b=QmYVhRhVwdmRJgGKXiwQM7TEpATU+W9Vn4MzMRk8ZLPgsBbvkh4zwlqRGtUHgRVG/+
 jfyWnDQwUCK05VEOsq/t0rv0JAOMTBJPRqQMKvv2lWl3YyieKTEiIFAFfRernYXzzhai
 3tAZgLN5ObY7nWZUJ6ziA/Giy9RDl1PolJLxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772303001; x=1772907801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IsKuajzTKQozsW/QbloHx+PiVsPF/sJahRdcvT8/8HU=;
 b=o3L0QLw3gY5nb9qlLxZowwpy9srfohbAXsPRQd55Sc+XaLzaL7fNL/cGVFByzLtkzz
 szI7JctfhxNX4XVeZdZV4hqMoQDSG+NYVlz8YfLUqyBfqPtXcVQOaEqJjrrdqjlcXliV
 1tEOTkZ3n/eRVtFGi07EZRkzH6qj3+adTTXiyU7uU8INu6PChqC5TpYbgcomUFXlzTpD
 FBE+TlFLIgIZwQZNL8v4vzjeH4xHevK0x1laWWR8jSP/n2henSdNxHcOiX3wDfzBVa+V
 ocQh6KC2t5oe6cT0w71WO6Jd1KpBP4bXDKxolvwutBYeAPWHKSL/8TGIoOQfCA91Wm4q
 W//g==
X-Gm-Message-State: AOJu0YxBKydKoDYiWqu5R6X70z2MohJMd7s7NX5D4a0YAxVcGa6YyWmi
 M0dgYho4ogNCGR+3BE1CMMlnlFqHQdIbmbNb6ts0I7wEpsVKZuu+NYSl4dXE3h0QIRtmKRlyrdK
 zO0s=
X-Gm-Gg: ATEYQzwggUOWtjBlm2Vixk2nxlc10tB/cGUuKuMH7bqGl54bl7eWRsTsk8hmNSI0AIP
 hdgWHkGvpnCBWUpR9eF/kxS2jG5ZIEa1WcFR1CvVPb2ckjLYTX2hKLCSO+Kv13hGKkvyW3IUs7g
 zC8e75Dx4hyKVmykz/7296rX2Ix20iiqUEmgkq8FVsSGp9k9s4HfNvTIO+PXaf6VjHARFjKkodK
 +4j98kj3DZmsPNVRIHrnvPMmJlyoHXLwHw4eNdVMqJl495JdS+ctpJWOzJcOp7UE/3c3u6c7Tbp
 RkrD7eknuSj0pFKcQlNz6Hlbw6ecX/pl8KqYvspMWqZc24AuitpBNgWIaEtktPKi9FAtYlQe6rX
 V5PSJ2X/Bu4YEBgal4kcVDNV4Sj2Vj3ip6a5AX+odjTVdjpuALsLsvMeHkO205dk01lAr8I6yrj
 AnTZwTR+MIvwXX0bisqg==
X-Received: by 2002:a05:622a:286:b0:4ed:ddd9:1402 with SMTP id
 d75a77b69052e-50752782e77mr95134921cf.24.1772303001311; 
 Sat, 28 Feb 2026 10:23:21 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449a66f1sm78508601cf.12.2026.02.28.10.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 1/7] test: fs_helper: Allow passing the image filename
Date: Sat, 28 Feb 2026 11:22:41 -0700
Message-ID: <20260228182304.3728735-2-sjg@chromium.org>
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

The mk_fs() function always generates its own image filename from the
prefix and fs_type. Some callers need to specify a custom leaf name
while still keeping the image under the persistent-data directory.

Add an fs_img parameter that accepts a leaf filename. When provided,
it is joined with persistent_data_dir instead of the default name.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v2:
- Split the quiet flag into a separate commit
- Fix fs_img to accept only a leaf name, always under persistent_data_dir

 test/py/tests/fs_helper.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index b8a22b22806..bd9169b2a4d 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -9,7 +9,8 @@ import re
 import os
 from subprocess import call, check_call, check_output, CalledProcessError
 
-def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
+def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
+          fs_img=None):
     """Create a file system volume
 
     Args:
@@ -19,11 +20,15 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
         prefix (str): Prefix string of volume's file name
         src_dir (str): Root directory to use, or None for none
         size_gran (int): Size granularity of file system image in bytes
+        fs_img (str or None): Leaf filename for image, or None to use a
+            default name. The image is always placed under
+            persistent_data_dir.
 
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
     """
-    fs_img = f'{prefix}.{fs_type}.img'
+    if not fs_img:
+        fs_img = f'{prefix}.{fs_type}.img'
     fs_img = os.path.join(config.persistent_data_dir, fs_img)
 
     if fs_type == 'fat12':
-- 
2.43.0

