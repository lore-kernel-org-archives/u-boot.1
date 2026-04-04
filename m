Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0691AE88D9D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FD983B48;
	Sat,  4 Apr 2026 16:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k8Frh7uQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9306840AA; Sat,  4 Apr 2026 16:03:55 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 709A480325
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40efc77933fso1722559fac.3
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311431; x=1775916231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCSzA3zLHBWTczbsOx7QtwIfFwAR3aipzS+RhcQ445M=;
 b=k8Frh7uQFcsEOcNMtgw1a7JxeFBWGOj4lIJ0MeD//Sioi3O0nGI6iMdK8cn16dDIC9
 PZNyFt+i4x6L5hwBMa55FO1rCBtML/6p9dD7rIEj5mKPKYCPT6wY7apDKVkq/GvtXLiK
 t5sj6O9yzycFvrZDSvfzosU+GaXvFeZKmjgRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311431; x=1775916231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OCSzA3zLHBWTczbsOx7QtwIfFwAR3aipzS+RhcQ445M=;
 b=H2FYPxi5HEo4QDyuz1b8lCxnVgET2aneQue8RDaY9ml+SvzjAP7VHzx/zVByT+UWgK
 cWddRrw7hg9+u24Z7zH26rPTkJe6wjH7POxUWqsnNElarX0QkEW/Qky5C12Rdg8vsIMV
 1n8fFKTPPV/oJ/2Beq/BKqAMd2tJ15XcvwuCAVCIDkBwJ1nVsblEzuVDp1Y4gezlPmZY
 tB6ORsiEAAYhewk+jV4hw24vpU8hWi7Y/OCRCOeuN2yVS6rW2cWU8K9Nl6MzN0Ilc61T
 VOt2vlbZfLq4pj1iDg1d83XuRpdfUzk/rT7SvCu9rxa8iOoIwahmNqNrbVrFKurxa5uz
 hbiQ==
X-Gm-Message-State: AOJu0Ywh5MJtDPIOlZWJ2UzKRUhFSfQlQz7BOs+QTaSJIi66rU6MMwCq
 qI6f+x/OF8SdQR+737Y86aa5/PKcUIgybnRBzYf/CUlDn6OIqU4rGJAwmdh0cvQmi6EB2r5B1uN
 bwpU=
X-Gm-Gg: AeBDieskkUKAXF2NN4hCwfdUVS82onA+7e0BiHjVS7iJ6K+sABeoA+KNYc7i5J+zXjr
 xnOyZVCL8x08rMRfwe+HQ0Z3TkGVmzM94iOxx1+oaLDlmAJpJ8ANESkz43dvomL3/IqM+9LFhE9
 yS9ZWEQLRqGsDHfgroUUOzUEBnOEd7oq9Ry7omUYFEJB3Yw1mSRNZILPy7859ZOQMYyKAwzBhTV
 ouEAc48KqETzAej/KlP8c0mfWM5LeqPmkVZYxV8PpVcqHN9igtLJoAe3Jeh8QnHOdyP/PNnYi6U
 rCgpVWEZHr/oQjNu0EnsZtbJj1NsNWVQZH2F21wQ8OXz8djbixsYHjLWjb61o/xAElmTY1P7WdW
 s6ZSSY3nyddX9v5arWcF4kiUTg0Y10LEjgHTsMHkiZQPKoKLMn+VjHRA9HFxRUpZZC8WyuAg8ox
 a/PQbWmaVFktdSPXST+Q==
X-Received: by 2002:a05:6870:934a:b0:417:5a8c:feba with SMTP id
 586e51a60fabf-4230fcbd3ebmr3772651fac.12.1775311431385; 
 Sat, 04 Apr 2026 07:03:51 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:03:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/14] test: Add a helper class to create disk images
Date: Sat,  4 Apr 2026 08:03:05 -0600
Message-ID: <20260404140328.3724864-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404140328.3724864-1-sjg@chromium.org>
References: <20260404140328.3724864-1-sjg@chromium.org>
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

Provide a way to create disk images which consist of multiple filesystem
images.

Include a cur_dir option to place the disk image in the current
directory rather than in the persistent-data directory. This matches the
behaviour of setup_image() which places disk images in source_dir where
sandbox expects to find them. This flag is a temporary feature and
should be removed once all tests are migrated to use the persistent-data
directory instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 92 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 800376b1e7d..e323a97b220 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -97,6 +97,98 @@ class FsHelper:
         self.cleanup()
 
 
+class DiskHelper:
+    """Helper class for creating disk images containing filesytems
+
+    Usage:
+        with DiskHelper(ubman.config, 0, 'mmc') as img, \
+                FsHelper(ubman.config, 'ext1', 1, 'mmc') as fsh:
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
+
+    def add_fs(self, fs_img, part_type, bootable=False):
+        """Add a new filesystem
+
+        Args:
+            fs_img (FsHelper): Filesystem to add
+            part_type (DiskHelper.FAT or DiskHelper.EXT4): Partition type
+            bootable (bool): True to set the 'bootable' flat
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
+    def cleanup(self, remove_full_img=False):
+        """Remove created file"""
+        os.remove(self.fname)
+
+    def __enter__(self):
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

