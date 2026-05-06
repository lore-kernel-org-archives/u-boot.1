Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDB1CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE742849E0;
	Wed,  6 May 2026 17:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mog7IZJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D5D6849F7; Wed,  6 May 2026 17:58:09 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A289848FD
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dea1272943so4019537a34.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083084; x=1778687884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1FIyZy+8inZynNa4UusPKbLST5hhymkXLz5RQ0eW1o=;
 b=mog7IZJ8cWbvPI1cvcfLX7xY75TfcYTQhbfQKEn8dw+32OMjTQSjaifzrgd/xrv0Lx
 Anx0K2ac6jLb5jwMGQd9BUGShW5xUb23HybEgz1DwkhTwEgMzNfHjUYEL7g2S6StBuPd
 8RSc3cuh6ekQTqN+qh8NL2/HVpmOjDT94xjlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083084; x=1778687884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h1FIyZy+8inZynNa4UusPKbLST5hhymkXLz5RQ0eW1o=;
 b=VSEnxDupd6ev5ZMBByXzxhB7cvPPAkxVwwTflegn4pa9QA4TxKCVRxWve60t+JB47e
 Nx/3SFdqJFFip+35mGt9LXpI+oDlPbB3CeSCHh64w/WDWUrmKy2qD9pBQ34T08F14KL7
 kotWY3ma9ukeJhYe/kENgbNT9EaSq2KznS6zyGUGNlD8Si+reUtKUgXhpo0L+Opkts6P
 j8OQDSP5w7KsXkkw65eEVLusCDxVqdilUksPHISnXr8boLS+3VQtDYB4hrR8vABOH7K+
 HcSwbfKDoRTKsTerEoj/OODfjUx3bi7UF+I5ic0IPZYsH4vnKrNVqTSMLcKFzAtz+ryu
 U2nA==
X-Gm-Message-State: AOJu0YyKTX31Ms0F2TOeK8q4J8i8T0DwR7TFVU5PIMShyQ4ZcsAK4/x+
 hjgcaeq/e7tqwzLtFmVPhSRa4poazzWtnnqjdchOJScHcmCC77ToL9EeKGqxubjj2YbXHWha/kY
 Ph7qQAA==
X-Gm-Gg: AeBDietOwkFbnL28+A8F8j77CuYJX0gnB6NVoY5HdjuR7nf4Y4o0IBrYl93j/NvFGB5
 lDFexEInYnOOzO3XUoD32u1rrQBjRcRUjI0SxZomoa6cq5cEJdS6wtb/yZdaLpp+EWKuHD6m3IW
 /hODfU7ga/fI7OA0Fz52LVdZ4k1wBk6Tcu4z1tYLmc3+I8wczhSXLAla9lunkJ7W+Otb7K+JJx/
 oV9Vy7nQakAOT7g/YtvX4qmI4JuBwhkecpTANR6worjk+geEAJJ7dq70E4JqGdku2lzjmR+GUsD
 jewqgJt/qaVoeqd7CfDcckitL/5XHmy524uy4IoYfGuBJxUMT05XSPLdu74D1HyEs90P7fGeHsz
 rUrLNkkW3kUG0mAUouq5d/DbBjrcoyL2a46StUCZoRCqGyWRwozEqtPCWg4ieAQS7gyqUr4eC+f
 i2vUKw/GvVNPa4s2oxwydgr3CekRHB
X-Received: by 2002:a05:6830:391a:b0:7d7:d0f1:a132 with SMTP id
 46e09a7af769-7e1df072f9emr2005866a34.22.1778083084103; 
 Wed, 06 May 2026 08:58:04 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:58:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/10] test: Factor mkfs args into _get_fs_args() helper
Date: Wed,  6 May 2026 09:56:20 -0600
Message-ID: <20260506155639.1191640-7-sjg@chromium.org>
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

Move the mkfs option and program-name selection out of mk_fs() into a
small helper.  This shortens mk_fs() and isolates the per-fs-type table
from the surrounding logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 179fbf04dfb..40cab6dddee 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -62,20 +62,14 @@ class FsHelper:
         self.srcdir = None
         self._do_cleanup = False
 
-    def mk_fs(self):
-        """Make a new filesystem and copy in the files
+    def _get_fs_args(self):
+        """Get the mkfs options and program to use
 
-        Raises:
-            CalledProcessError: if any error occurs when creating the
-                filesystem
+        Returns:
+            tuple:
+                str: mkfs options, e.g. '-F 32' for fat32
+                str: mkfs program to use, e.g. 'ext4' for ext4
         """
-        self.setup()
-        self._do_cleanup = True
-        src_dir = self.srcdir if os.listdir(self.srcdir) else None
-
-        fs_img = os.path.join(self.config.persistent_data_dir,
-                              f'{self.prefix}.{self.fs_type}.img')
-
         if self.fs_type == 'fat12':
             mkfs_opt = '-F 12'
         elif self.fs_type == 'fat16':
@@ -91,6 +85,23 @@ class FsHelper:
             fs_lnxtype = 'vfat'
         else:
             fs_lnxtype = self.fs_type
+        return mkfs_opt, fs_lnxtype
+
+    def mk_fs(self):
+        """Make a new filesystem and copy in the files
+
+        Raises:
+            CalledProcessError: if any error occurs when creating the
+                filesystem
+        """
+        self.setup()
+        self._do_cleanup = True
+        src_dir = self.srcdir if os.listdir(self.srcdir) else None
+
+        fs_img = os.path.join(self.config.persistent_data_dir,
+                              f'{self.prefix}.{self.fs_type}.img')
+
+        mkfs_opt, fs_lnxtype = self._get_fs_args()
 
         if src_dir:
             if fs_lnxtype == 'ext4':
-- 
2.43.0

