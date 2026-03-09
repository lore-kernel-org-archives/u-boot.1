Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3822BF41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14B883BC7;
	Mon,  9 Mar 2026 16:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q4bhuYf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B404883F14; Mon,  9 Mar 2026 16:14:03 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9860383BC7
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8cb38e86cf2so1252421285a.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773069210; x=1773674010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NR56JQusPfvOk3Zg+ldrKN0mNrmHYvT5MOjuEO61n5w=;
 b=Q4bhuYf+IdnpD1YAIjgZnCII+3mpspH7AYrTtqlYjlnHW0cGld/9gDx7ZmBYnibfir
 W9haRdCJ4gm8PdglLShvL+lyUeBpCgkqOfEHu/FMgmxFDACEP8hqyB4hRxLBqYJo8v/e
 257SjIWB3ZmsZQYWb6oo8zsLklz4otpR04F7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069210; x=1773674010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NR56JQusPfvOk3Zg+ldrKN0mNrmHYvT5MOjuEO61n5w=;
 b=DyZEMRo/sjTkf7nvSUvpeuy7PS2XRr40Bc2E6iAA/MFrBRnhB/oCXIm0Jm8jbVcQbk
 6d7WWKW04+HH5xFBpCeghxynmTzVJKEN/Q1h4zvKcKtODfqjzrAt/5C0QsSQAfGLfecg
 ubj2d2V8IzGhN7QTMeid7QVJkZQ2xr42pifucWwViaPBHFJOcoClq/mdhXjxPDpGD1+3
 S5O2ZxqCqmM/dNe5cyqapiIik1tV2ZT3BMSGGsZiQnxB56Ih+1bxRavFbhVCk/dpK0v9
 kjTUJoQjpNrs3Rev6TH98Cvazj8jiE/wWb8X6UdFi39pQ663bj6+NPO9J3TPg12xYRWm
 BnNw==
X-Gm-Message-State: AOJu0YzSN8b6S/NzuU1UpxN5quMWZ9UKUdKbaI3w4RyX7WQzFEL74SYI
 Hpu+rDOrF7IcF+mj9FPyeBGlpQhZhTY/WTZBUcqupJkq4rpFaq0h++XaeK78qIAn/YQgOItDoln
 cXbM=
X-Gm-Gg: ATEYQzzeIhp2GtmCPkapaxNjiAKOFQBCukrBZOWz6tZJB8IDipqq1BYyl2It1aRQhUf
 SsSsvEXtmqKxgvWOIjEOEEMLBJtNGiMA/sQh5mRd9LBmAqG3hVeiwvRFDP4V0i7n2/vlpihLEUW
 uRL62kT0mmM9AzgF1rrkMHKw0sd6LHKQKw84wq9bo5FQ3QxOH0Ee5gVU+ksVOAT/G+BhaNkgF9L
 RRrn/PFHEAmC9nuN1weslbIqQvstU68KbnlbbT5Qybmh6lXvkztLCQRU+dTEEBQ32ObmGKV3fhV
 +nWji/QEswuzjG6SDfN7ds94LK9i1t7neE0kdGgaip50AdF+DBiBcO/GUDWdpHHwgaAZi4JWSdn
 12Lnodk7ULo7hBDpN61CptOIrW5fHbvstsDvYBNF28sxq3NVrMfooCHhCla1fe3E1MO805xUgch
 rk8Mg4REapGIeFEmSOVg==
X-Received: by 2002:a05:622a:153:b0:509:15d8:2c0a with SMTP id
 d75a77b69052e-50915d83273mr54266191cf.32.1773069209650; 
 Mon, 09 Mar 2026 08:13:29 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5091a7dec85sm19337291cf.32.2026.03.09.08.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:13:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v4 5/5] test: Convert fs_helper to use a class
Date: Mon,  9 Mar 2026 09:13:04 -0600
Message-ID: <20260309151307.831537-6-sjg@chromium.org>
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

Changes in v4:
- Use an explicit list for fs_type validation

Changes in v3:
- Rewrite the commit message as suggested by Tom Rini
- Make the class a thin wrapper that delegates to mk_fs()

 test/py/tests/fs_helper.py | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 72e18588288..800376b1e7d 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -7,13 +7,96 @@
 
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
+        if fs_type not in ['fat12', 'fat16', 'fat32', 'vfat',
+                          'ext2', 'ext3', 'ext4',
+                          'exfat', 'fs_generic']:
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

