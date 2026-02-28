Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA75FEE4C8
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 18:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B56483F2D;
	Sat, 28 Feb 2026 19:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dRv7KXsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DFD283F61; Sat, 28 Feb 2026 19:23:37 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E82483F2D
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 19:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-899c3441177so53972006d6.0
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772303013; x=1772907813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3iwK7FkuBUu8mMTOWzOyGfRCN3Tsicxprh9hOvJFWWI=;
 b=dRv7KXsN3fCWPzbyleMZ937+Ey+hp+OEKPGp6fVM8oZNn8YHdDUemI3leX8MQ6Yxg7
 QO7VsgOKWfOWHMWbWsX3t7BPYpHg2vVvPgJkVbab6HC7UtRly++J0JVkPLCq5w7/1sI5
 J1bxCYzCZmLs5shiUNQAePWh4xVH5dbV5aglE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772303013; x=1772907813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3iwK7FkuBUu8mMTOWzOyGfRCN3Tsicxprh9hOvJFWWI=;
 b=J/V1DPQ0idtj9e4INzmBhtXRvtZq+FOJZXYSTv36a8Ad2gvHWXzHFOphl4cpN/B8/3
 5kV1o3KPj0w+sX+4xCFyV4j/szaQhXfF5wmm/LWVIbh1Vtfp19atdz7vi15fCDEUmXtR
 UCdATRHoTJMUFwJDYTKstqHThG5+Cd1cnAfmOBQELzSQIVmEfdA4VyL+xj3GLgtvATTo
 sklkdg5S6OESKExEUoq+98ZYmvnEEkOrX60JhoL//42XvjRNsVgX7Utw4dn51Barc7iM
 nwkY9J5odYclZmgpknXez2A/FNsbuClZqmjGR+2T+fCvj2sqZvXTmwODad1p4kqgeVQ2
 Ozlg==
X-Gm-Message-State: AOJu0YzMvImxBWVDDREK0fNLk+1KSdVLJwr/uAFFao0CccWsyvRhafs/
 lo92cmM7RLHclzM7qd/ru6q+tNXjl26rvFiDu4I7a52INn5osecBZIJChmNip2HbR5I0GNqVcIX
 BAPQ=
X-Gm-Gg: ATEYQzxAh0BTXWqkzPvmMi6S2wxBAV6diWFzUwFhpc3A3nmyqWlSASDhPa+qgt9Pci/
 7DaNP70znudTwSHuVTr/thX7jdxnY+EPRzAktGaITIXq+M0wsbZK65clKMgXKmUg3jAU/+or8WC
 6VONFNWmpBl4ltLRe3keFP3LJE+AK2dhpExylZVNxmaAT0ww/ndBA8VkHyTGjM4GvbB10UR3EYk
 jxbInlYL3BkCGhIO5YTMQ+ExbHAh9GJcSTHOwI0AnOs3BXfNCSO7j0AZUwCNxBj7cRo2+U32UTC
 QlZIHz5bwwgd6xUtUvNzPFwLsk6S6QvEmRbQHVQc8560VfBbjh7LFgYdKeTHC5+LtdraDBSikUH
 eEuVIdrgNWCZ6XpRWscOHwfMhtK9cKHuyED1AFvj7WjMdbH9gZINYXw7AqyCTLSu4Pvs7Jeoi9e
 Y+D4J7s7qMMMBZ8avV9q/kEbTwx7CC
X-Received: by 2002:a05:6214:3004:b0:88a:2de5:c824 with SMTP id
 6a1803df08f44-899d1e73f0emr93535156d6.54.1772303013309; 
 Sat, 28 Feb 2026 10:23:33 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449a66f1sm78508601cf.12.2026.02.28.10.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 6/7] test: Add a helper class to create disk images
Date: Sat, 28 Feb 2026 11:22:46 -0700
Message-ID: <20260228182304.3728735-7-sjg@chromium.org>
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

Provide a way to create disk images which consist of multiple filesystem
images.

Provide an option to use the current directory for images, instead of
persistent-data directory. This makes it easy for C tests to locate the
image.

The setup_image() function is used from a lot of places and that code
itself needs some work, so this is left for a future series.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Explain why setup_image() is left to later

 test/py/tests/fs_helper.py | 97 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index fac811f352e..0139a3ba523 100644
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

