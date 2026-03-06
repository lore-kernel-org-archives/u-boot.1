Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FE4FCC05D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6609883F86;
	Fri,  6 Mar 2026 20:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X3MFsCln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F3584013; Fri,  6 Mar 2026 20:08:42 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D493683F86
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8c70ab3b5fcso1300389485a.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772824118; x=1773428918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuj3UxY1I7ws4ZH8ihRYBr6354fkPTaOiMDPWo1dCyM=;
 b=X3MFsClnMx/8iWCwV9R/sZ1L8o4XljXEUWCnV7W1h6F5JYuPNbMtxPGcSLhDt/tamu
 T68B3b7HCpqe7Ur1NcF6oj0A0QwVHYtxl8YnaNQXHen0pkP682qcfOdF4pC0g27BZyQo
 C+aCm1M5G5Uyo4tmsV+aJXt0vCqWogVY1sEcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772824118; x=1773428918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fuj3UxY1I7ws4ZH8ihRYBr6354fkPTaOiMDPWo1dCyM=;
 b=NhKC/cQbJ63wKI7QUrOX7soGOquN0bG4VuLzovDcM6rbD17ZfppmF3fYNLb3rniTqH
 Juhv2ii0PFkaopn1fVMpu+bZ5lsoiKxqvc6GSMyjHGvh7wt/ybodBcmJDDoSn8HUgr+7
 n7Y+Yvaraw5qnbyYUrdv9C/xxWRhnatM9n9E4OctwJa3DVoWZ4FcSO0cxXFEFjnBKTZN
 k042b6v/KcJc7pCLSt6IcCigkw8FRkRszPR1JzKVcOuCJ+QQ5rwk6tDiW76fUrpQty1k
 RaTsw92W/tzVVaFHgHKhiaremCWC4Txk/3/JiBWN+JXHvW/qALBbTOJxstcR1DbV7ds6
 5t1Q==
X-Gm-Message-State: AOJu0YxywFXFgDwkPDU9QdP+fS6nlwoS7Y47fS4k9kVMhSFqf5FAHTpB
 436r5QcO9NBnhCvlcNg+C6LRkRV8edpQHKBXSyGgCEAcaaRS7r6MuWMKwwKaFPFoxwfiFZifY9d
 E+Yk=
X-Gm-Gg: ATEYQzyLgrkwbVMoAnmzjPqbI/cUPabpiZFyrlkrnUUwrSlLoA+WFwrMA5mKAbfDviQ
 gvW+5ar5xVGblLtxQCCQrhsygTzWVImHEji1SHGh0minYKxugK1qslEnEhOaAtvrBxf4LE7WVun
 gD2TR6CjzzVx8x/UrYRkHF5p2O7OuJ64dmD7b/l/LTsH0awOT6CtPFDH6yf82o7JIlUGFKJZAmh
 VOS/1F3Qc279j9j+fNy3Cp8tTuUDma1hRj47PK5OaDcx6WgGTIo5GHQtOA4voLSHswCaEPPJBt9
 h8NZgTuJAlWWJtierBxv3P/3ruE75G59zCCVv6CoQ8DGOfTYpYBfgIRyFtbA1rXmJd6CBgE6duC
 XyTTzD2V5G6AyR+8gEUFZyPzkkWRayO4ruNDCDsbk2g/NmKC6Uw0aCKZsmpgexgty+eNLjqIpfk
 DNagpZMn+V1QFgZUhlog==
X-Received: by 2002:a05:620a:711a:b0:8cb:4de9:ead6 with SMTP id
 af79cd13be357-8cd6d3f0ad6mr406143485a.9.1772824118091; 
 Fri, 06 Mar 2026 11:08:38 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f54ceaesm164372285a.40.2026.03.06.11.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:08:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 6/7] test: Add a helper class to create disk images
Date: Fri,  6 Mar 2026 12:08:12 -0700
Message-ID: <20260306190818.3586749-7-sjg@chromium.org>
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

Provide a way to create disk images which consist of multiple filesystem
images.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v3:
- Remove cur_dir parameter from DiskHelper as suggested by Tom Rini
- Remove editorialising from commit message

Changes in v2:
- Explain why setup_image() is left to later

 test/py/tests/fs_helper.py | 95 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 07c011fa430..9e0f24f28b4 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -96,6 +96,101 @@ class FsHelper:
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
+    def __init__(self, config, devnum, prefix):
+        """Set up a new disk image
+
+        Args:
+            config (u_boot_config): U-Boot configuration
+            devnum (int): Device number (for filename)
+            prefix (str): Prefix string of volume's file name
+        """
+        self.fs_list = []
+        self.fname = os.path.join(config.persistent_data_dir,
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
 def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False):
     """Create a file system volume
 
-- 
2.43.0

