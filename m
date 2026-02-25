Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387CDFD3773
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3DE4841C8;
	Wed, 25 Feb 2026 17:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cUZZ6jNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A601F841D2; Wed, 25 Feb 2026 17:28:42 +0100 (CET)
Received: from mail-ot1-x343.google.com (unknown [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B116F83F5B
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d4be94eeacso2165133a34.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772036673; x=1772641473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ostxgX9G6zudXJVFP448SODHVezEsbG3mxXEMakc50=;
 b=cUZZ6jNx/FglFh2KjFFYW70lksRA9EcMa/141tRpVKWDczPYk5T09ClVaEHyZYpe3O
 6jhIEpgvr2ePTcgPfekQT4/aeCaROesPXuKcTS+pgzx8RQ8CMi0pXTt1uumLRogt/OGA
 KiTLj4Aq8HOdkFnG/mJP2m/yb9W7CUtlAUsaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036673; x=1772641473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ostxgX9G6zudXJVFP448SODHVezEsbG3mxXEMakc50=;
 b=TsG+u1tIdiDQahBuQN99sbPjQPARfpyB+7BBwYMlP7JMrwtxGWj3MCH/+AT/920AfY
 MYsI81wTABzzXreoZAj1JvuAybI6o5FK/VoIWjyp/FL9IslEyIdN5kLC3GsAz3+EuYzW
 evFVHNWWWFEU+YGesUPPiomRM4PXH/FR82BQLKqzRQmTpX7IWC4dbdD8f3sbGYpEJMqt
 NHP+HCbxhJt99oFSFJntJCwU8D8JFQoUo244jSSrBG/LNC6CIvURMeANsmQUQUU2PObX
 OPyZ9sV1oSXEO5l2zGgh/XfyPmNatn6CUvb3AhO+aR8jgM7Y1YTGBLRLLo9Z28YG/NFt
 SJ9w==
X-Gm-Message-State: AOJu0YzMZH27rJbnmCQ/CsG2vDjBcFU8vfO3pdinxXHAEcHwbgAQi7BR
 d7ESvZiOW4BPaYODyceRC8/+XThqpO59N4jCuPGdLxHjoJKlGZkGl+N9mH/Y81LGc5Bk+Ov1vy1
 y3xNDDw==
X-Gm-Gg: ATEYQzxvXhsz0QNK9+7J7/1NTGOTJg1QSEyRH5fa4B3en0MXl+qBU+lXb7jaxdRNv9Z
 mhIBwxxOBZ/fP7ruihvAMjjkYC5XzFVuV2jp4LmBnlHuhoMeJsOijfMXrE48wQ6rauJEGiVCajn
 CGOfzFa6u/RCaUGCFEgHc0KFZHojCCYhloIxzhtxeVkvMmyRBZMU+AANj308+rdIe5nljSXhybA
 w1mbWVk38fYXs5wHCMtpQCozwWql3z5wOI2nMwEuuts8IERzyVavPFCE9QbsB0Z3ACAeEqVechQ
 IrUkDYopMjyZbrZTco8j9vHm0pDQDkB1li8AupbMbZQxecqQxoK0J6GJHcRgso3t+2Exfgq0hEE
 trd8Zziv38d1Ym/rQz4/2U2IrvRt7AjhXeccbPEeRygWvdedk31TwpE5MFHQRewZp+e7S9fia/j
 kOp6pfNbs1y/cEe7j9TA==
X-Received: by 2002:a05:6830:730c:b0:7c7:2c63:f2d6 with SMTP id
 46e09a7af769-7d52bee4aa5mr12479759a34.11.1772036671695; 
 Wed, 25 Feb 2026 08:24:31 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf7874csm13534383a34.1.2026.02.25.08.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:24:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH 5/6] test: Add a helper class to create disk images
Date: Wed, 25 Feb 2026 09:23:49 -0700
Message-ID: <20260225162357.3449937-6-sjg@chromium.org>
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

Provide a way to create disk images which consist of multiple filesystem
images.

Provide an option to use the current directory for images, instead of
persistent-data directory. This makes it easy for C tests to locate the
image.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 test/py/tests/fs_helper.py | 97 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 531974d7dbe..f27a3945aa9 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -157,6 +157,103 @@ class FsHelper:
         self.cleanup()
 
 
+class DiskHelper:
+    """Helper class for creating disk images containing filesystems
+
+    Usage:
+        with DiskHelper(ubman.config, 0, 'mmc') as img, \
+                FsHelper(ubman.config, 'ext4', 1, 'mmc') as fsh:
+            # Write files to fsh.srcdir
+            ...
+
+            # Create the filesystem
+            fsh.mk_fs()
+
+            # Add this filesystem to the disk
+            img.add_fs(fsh, DiskHelper.VFAT)
+
+            # Add more filesystems as needed (add another 'with' clause)
+            ...
+
+            # Get the final disk image
+            data = img.create()
+    """
+
+    # Partition-type codes
+    VFAT  = 0xc
+    EXT4  = 0x83
+
+    def __init__(self, config, devnum, prefix, cur_dir=False):
+        """Set up a new disk image
+
+        Args:
+            config (u_boot_config): U-Boot configuration
+            devnum (int): Device number (for filename)
+            prefix (str): Prefix string of volume's file name
+            cur_dir (bool): True to put the file in the current directory,
+                instead of the persistent-data directory
+        """
+        self.fs_list = []
+        self.fname = os.path.join('' if cur_dir else config.persistent_data_dir,
+                                  f'{prefix}{devnum}.img')
+        self.remove_img = True
+        self._do_cleanup = False
+
+    def add_fs(self, fs_img, part_type, bootable=False):
+        """Add a new filesystem
+
+        Args:
+            fs_img (FsHelper): Filesystem to add
+            part_type (DiskHelper.VFAT or DiskHelper.EXT4): Partition type
+            bootable (bool): True to set the 'bootable' flag
+        """
+        self.fs_list.append([fs_img, part_type, bootable])
+
+    def create(self):
+        """Create the disk image
+
+        Create an image with a partition table and the filesystems
+        """
+        spec = ''
+        pos = 1   # Reserve 1MB for the partition table itself
+        for fsi, part_type, bootable in self.fs_list:
+            if spec:
+                spec += '\n'
+            spec += f'type={part_type:x}, size={fsi.size_mb}M, start={pos}M'
+            if bootable:
+                spec += ', bootable'
+            pos += fsi.size_mb
+
+        img_size = pos
+        try:
+            check_call(f'qemu-img create {self.fname} {img_size}M', shell=True)
+            self._do_cleanup = True
+            check_call(f'printf "{spec}" | sfdisk {self.fname}', shell=True)
+        except CalledProcessError:
+            os.remove(self.fname)
+            raise
+
+        pos = 1   # Reserve 1MB for the partition table itself
+        for fsi, part_type, bootable in self.fs_list:
+            check_call(
+                f'dd if={fsi.fs_img} of={self.fname} bs=1M seek={pos} conv=notrunc',
+                shell=True)
+            pos += fsi.size_mb
+        return self.fname
+
+    def cleanup(self):
+        """Remove created file"""
+        if self._do_cleanup:
+            os.remove(self.fname)
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, extype, value, traceback):
+        if self.remove_img:
+            self.cleanup()
+
+
 def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
           fs_img=None, quiet=False):
     """Create a file system volume
-- 
2.43.0

