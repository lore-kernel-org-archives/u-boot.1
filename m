Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0FBCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67854849F7;
	Wed,  6 May 2026 17:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BFg37Igr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B03849E0; Wed,  6 May 2026 17:58:11 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D543849F6
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso3794091a34.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083087; x=1778687887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6HCx6liW/3uLoLMW4IlHQZInOzmC+F9oU7/9gWA66I=;
 b=BFg37IgrIbKRFeSLYzheMxd4atMFZ+V9PoOBH/C3HkmIdg7Lmy2FbUI7NeAfMcIRJj
 2h92+33HHP32PkPy6WdHKxN/6tVWqHHgpl86lViFgP1oiiYapprntNMForB4cc7y5qKz
 srkGT/YlXpHnS51/lKs2QPQ0vhK48W+Ozy2l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083087; x=1778687887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m6HCx6liW/3uLoLMW4IlHQZInOzmC+F9oU7/9gWA66I=;
 b=j867R69w6+/BUbjI/e9Bqz+WCGTXCyjJX5gHNFUzx4VtzedBtzE4R5PbNOn6ZyxI5d
 KjJLBb7nB/eD2KtCEHHOJIR9Chph6UQn8L/iq5C/C0sdAy+LDhv4EIS5iTOgKbduyg7N
 tvUmFqOkJtmWUdUsp6oS+xXk6Doifh1zCPnY/aruTw4kDX91UCe9R/PY/YZKdk+wdYt0
 a7lBmxjVMoWRmWoJ5hPEexQCaKDfLYXWiVvnmobD6hKN7YGsyCr6Mrai/DlSSLKhztHL
 AvkreocehP4KuX4j5fbdVAHOQ1m5If3b/khxz9PHzMrCA+W4CbucjX0PUZyt1m1yvxz/
 JICA==
X-Gm-Message-State: AOJu0Yz2Y0Hu0PVWrc9KE6QQNN9GyOItdZj4KghP7ys2hov3witgTkkj
 qgHCrobrnAGFInJj99NQL3Cd2aaISfsIOwIFu/SdVo1Khq/GQBNmOMT53pwh5bQVOhsUEhqrteE
 7DEWwCA==
X-Gm-Gg: AeBDiesirJD+D4FBFVhuWmD82LjiZIIgy39l/gyINA/3XZ38nzw9hB3FT+1DZD59MBi
 nnQ1s0mOMOzSoCddwedlU+9dQ9IW57VZhGwQVLTla3UD/kOEiUByxvr5OPLJNtJ8Wdq0v8NTa5r
 +3t/k5MuUtRqA+GneWVpMQO8B5Bk2tRIEewEC3hRvBe4FdZi5e+IN23VYE2KP1+9gnraClUVaga
 PY5sagFpS7/pizx51XUrVqKehTxL4lMH1JWghTWiBCYS/6XLmlRGtMkrRFEsMuG7i6pZxlWtWxP
 jfCIMRrsHjJ6C20v4D08ZG3MDlCUn2UhpQ9XNvQLM7yguaGrZWiNnBF7j8+S2pc3mhCtw/4DvOD
 wrmH/tGzK+yQXD7CYezYy+k0qW2VVSHSUCjsfT0xBaey4Gh0zEIJWzOOdTrGv1qx/2rdQ2xEAwb
 G+M00tcCiaC7MOnURhxBN7+BDJpO6LhD16xpUfFdk=
X-Received: by 2002:a05:6830:2587:b0:7d7:da05:f2d2 with SMTP id
 46e09a7af769-7e1defc5b26mr1929555a34.16.1778083087097; 
 Wed, 06 May 2026 08:58:07 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:58:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/10] test: Pass mkfs -d unconditionally for ext filesystems
Date: Wed,  6 May 2026 09:56:21 -0600
Message-ID: <20260506155639.1191640-8-sjg@chromium.org>
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

Modern e2fsprogs supports the -d flag on mkfs.ext2 and mkfs.ext3 as well
as mkfs.ext4, so use it for all ext variants.

An empty source directory is also harmless, so drop the guard that
omitted -d when nothing has been written into srcdir. Remove the
ValueError branch, which is now unreachable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 40cab6dddee..3983d42f5ce 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -76,6 +76,8 @@ class FsHelper:
             mkfs_opt = '-F 16'
         elif self.fs_type == 'fat32':
             mkfs_opt = '-F 32'
+        elif self.fs_type.startswith('ext'):
+            mkfs_opt = f'-d {self.srcdir}'
         else:
             mkfs_opt = ''
 
@@ -103,13 +105,6 @@ class FsHelper:
 
         mkfs_opt, fs_lnxtype = self._get_fs_args()
 
-        if src_dir:
-            if fs_lnxtype == 'ext4':
-                mkfs_opt = mkfs_opt + ' -d ' + src_dir
-            elif fs_lnxtype != 'vfat' and fs_lnxtype != 'exfat':
-                raise ValueError(
-                    f'src_dir not implemented for fs {fs_lnxtype}')
-
         size = self.size_mb << 20
         count = (size + SIZE_GRAN - 1) // SIZE_GRAN
 
-- 
2.43.0

