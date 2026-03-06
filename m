Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C38FCC065
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2589C84010;
	Fri,  6 Mar 2026 20:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="har4b/4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81ABD84006; Fri,  6 Mar 2026 20:08:40 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 569A983F2D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8cb3e0093e3so917427985a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772824116; x=1773428916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37VhEnwkvOwheDAokYqgagKbkmDOjP/u0WIhE4CKZ3M=;
 b=har4b/4EEVZJlShkDgOItTsgBaCaCMy7hnoY++oAK6YIzJD4GifO+FSKmO/KCKC/h/
 og2s6r35DAiZXLSMKT9bc6GQ/KNJfIkxoKkXIz0E1E0d4KF0I+1h3+3az8IPqP4kXBRy
 4OxHJ0ogsNtsOpDllg7LmzpwkdYNTuYeePPKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772824116; x=1773428916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=37VhEnwkvOwheDAokYqgagKbkmDOjP/u0WIhE4CKZ3M=;
 b=HNoKlEu2lFRPbJuziQnTuGVo86shCCiI0Hbph39R7vBvDxtWqvQc0H3+djFXpoNFBP
 JupU8AjgxLHEdpLAi5pLQjC9RIjlPQHOWog+ipA6z+bER5/lUSA9uHplwD8J0b37NPoJ
 BFmQ1Vj2vSzg7HiO8QBlebZZv/v6ZzM6peF+cvc9fchrAaZYHhiFU1vFBU+uMerKSXCA
 3bmhFVhoYlvVT/qwgIGfHklIABR85/gDK+EFYAilTdXoJIzU7iWbPYSAKapAaZajDcEt
 so9L3YEG/7a6MH4FRShwVN66Q47CcukTBtKuV6DJzKl2t3F6jgkfJaVRIPFC7B7SDwZZ
 rqqQ==
X-Gm-Message-State: AOJu0YxI2gt4R/GtVaSHe3te8G3eZ/X462YqZ8Ha9aEABbDR09FYNPfZ
 smPY3zsvPdWoiY7KLd6CAYrR1zeBwRrN3GqZenjsakBv++wVP49dB88WgHU0JpLKtol5Xn/6pNi
 SRd4=
X-Gm-Gg: ATEYQzzJcJwo7wX6UOfIX8qzkzfmTv736MLoR7RAGflxTDxKb6qdy3RbpbIDwB/yGnT
 QVrZjsBdDB1eEfskLJeoWno4f9MJvJou2xHF1g/8KEvNDDeBSpCqdYJzHaZ2fUgwBIgG5EKKKxP
 Afm+v/V1pqZfr7iuiXlw0F7iHz4+eY2D8wVtPGciq+V3v2+rs0NMvMO4LbqVKLdf/JEo8tdLZL0
 gC6+ed249KzNay6eTvXAmrPQgMiO/Bq+oTWNA8zOJ6sFYUCs3uoXu4VyN9K5ZJaC0PI6I091iqi
 DhgOEwKm3F7nFtkWTnZ6eWrRXVXeZnW70CcwCNdd5fBW+iusNxEXZSBTcQhvGNOociDybuODkIK
 Kt35LL6LJrQIfV9AwZvzHObre5Zw+PH4lLSVrWEcOJ+Wd3WHVj0LE7cD125eZEO1KjBQBO2OHvW
 islyyyaJ8yT+XcT7GZhQ==
X-Received: by 2002:a05:620a:472a:b0:8c7:1106:1a44 with SMTP id
 af79cd13be357-8cd6d4b5daamr407270585a.79.1772824116325; 
 Fri, 06 Mar 2026 11:08:36 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f54ceaesm164372285a.40.2026.03.06.11.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:08:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 5/7] test: Convert fs_helper to use a class
Date: Fri,  6 Mar 2026 12:08:11 -0700
Message-ID: <20260306190818.3586749-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306190818.3586749-1-sjg@chromium.org>
References: <20260306190818.3586749-1-sjg@chromium.org>
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

Create a class around mk_fs() (and later setup_image()) to handle the
common tasks of image creation. Many callers of fs_helper.mk_fs()
create their own scratch directories while users of
fs_helper.setup_image() rely on one being returned. Unify this by
adding 'srcdir' as a field while converting to a class.

The class delegates to the existing mk_fs() function for the actual
filesystem creation, adding lifecycle management for scratch
directories and the image file.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v3:
- Rewrite the commit message as suggested by Tom Rini
- Make the class a thin wrapper that delegates to mk_fs()

 test/py/tests/fs_helper.py | 82 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 72e18588288..07c011fa430 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -7,13 +7,95 @@
 
 import re
 import os
+import shutil
 from subprocess import call, check_call, check_output, CalledProcessError
 from subprocess import DEVNULL
+import tempfile
 
 # size_gran (int): Size granularity of file system image in bytes
 SIZE_GRAN = 1 << 20
 
 
+class FsHelper:
+    """Creating a filesystem containing test files
+
+    Usage:
+        with FsHelper(ubman.config, 'ext4', 10, 'mmc1') as fsh:
+            # create files in the self.srcdir directory
+            fsh.mk_fs()
+            # Now use the filesystem
+
+        # The filesystem and srcdir are erased after the 'with' statement.
+
+        It is also possible to use an existing srcdir:
+
+            with FsHelper(ubman.config, 'fat32', 10, 'usb2') as fsh:
+                fsh.srcdir = src_dir
+                fsh.mk_fs()
+                ...
+
+    Properties:
+        fs_img (str): Filename for the filesystem image
+    """
+    def __init__(self, config, fs_type, size_mb, prefix):
+        """Set up a new object
+
+        Args:
+            config (u_boot_config): U-Boot configuration
+            fs_type (str): File system type: one of ext2, ext3, ext4, vfat,
+                fat12, fat16, fat32, exfat, fs_generic (which means vfat)
+            size_mb (int): Size of file system in MB
+            prefix (str): Prefix string of volume's file name
+        """
+        if ('fat' not in fs_type and 'ext' not in fs_type and
+             fs_type not in ['exfat', 'fs_generic']):
+            raise ValueError(f"Unsupported filesystem type '{fs_type}'")
+
+        self.config = config
+        self.fs_type = fs_type
+        self.size_mb = size_mb
+        self.prefix = prefix
+        self.quiet = True
+        self.fs_img = None
+        self.tmpdir = None
+        self.srcdir = None
+        self._do_cleanup = False
+
+    def mk_fs(self):
+        """Make a new filesystem and copy in the files"""
+        self.setup()
+        self._do_cleanup = True
+        self.fs_img = mk_fs(self.config, self.fs_type, self.size_mb << 20,
+                            self.prefix, self.srcdir, quiet=self.quiet)
+
+    def setup(self):
+        """Set up the srcdir ready to receive files"""
+        if not self.srcdir:
+            if self.config:
+                self.srcdir = os.path.join(self.config.persistent_data_dir,
+                                           f'{self.prefix}.{self.fs_type}.tmp')
+                if os.path.exists(self.srcdir):
+                    shutil.rmtree(self.srcdir)
+                os.mkdir(self.srcdir)
+            else:
+                self.tmpdir = tempfile.TemporaryDirectory('fs_helper')
+                self.srcdir = self.tmpdir.name
+
+    def cleanup(self):
+        """Remove created image"""
+        if self.tmpdir:
+            self.tmpdir.cleanup()
+        if self._do_cleanup:
+            os.remove(self.fs_img)
+
+    def __enter__(self):
+        self.setup()
+        return self
+
+    def __exit__(self, extype, value, traceback):
+        self.cleanup()
+
+
 def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False):
     """Create a file system volume
 
-- 
2.43.0

