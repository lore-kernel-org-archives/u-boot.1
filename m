Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3079CD4F54
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 749668484F;
	Sat, 23 May 2026 10:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lYoDPMYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2CC84876; Sat, 23 May 2026 10:55:38 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D52D28469F
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so8962639a34.0
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526534; x=1780131334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvd+xPkyHu5yhmPLOZ0y4L0r93eI12uNfCUGb/gANKg=;
 b=lYoDPMYMkirOkxOxCG1NaFStk9/dQkYwpsPanKu6wNyPbNHJAWKhFM7d5Ynlr6M7e7
 M5J6J1hLVUyC0wTIlKXuUDU3eP23tPNhS+Xof7oGoIV597WPBwBPtQhT6X3NR80RCB6V
 N9WMB3gH7A/xebsYePM3MP3phZPx5tyZCzfNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526534; x=1780131334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvd+xPkyHu5yhmPLOZ0y4L0r93eI12uNfCUGb/gANKg=;
 b=H682E3k+kOWjHLa34xGgekaLF6pSecDp7t/SCbb6FatbrtfRy+UzRyoKnqNwpPgwEO
 afGKnlj6J2HCqEjrj4Nd9l/jH+kfFElanLgpLcTyQfCW+ztMYzNGQ2LU7x008WpDDp3b
 ooamcHzAqqIt+Po5XETayceztQPh+1Yq4LzIeoaABIcnrD83MH5WPt7yFxBqtkM3tmHu
 A6YMOz6j/iiT+gLc1uN5qigQy8sE4CA4dnrG7DGtFHJB2bO6pQaVHz49pbT4DkpUz5ie
 sDjo4s/F9ZUNXjJKUiNrzKA0dQd3ArCoH5Tx/lSjMAWO+dYAHZ97XZbTmaDjsHRWkOJl
 F77g==
X-Gm-Message-State: AOJu0YzWDkQzKaMD4xKTxtr1VySKmTVD3eAKpNAM/gcxk4rFojL5MG52
 +kSWcBO9a1eCXkEvFeywZg3S6x/sM4N3mnId5lFQxWTWASOKaTalDr+TWA+dhUXGHzUc5Z8uP6s
 CpxaevRfQuNs=
X-Gm-Gg: Acq92OH63hOjrsNeNtgjFfYSCBT1CnxS60SeyJEYXV98T0f4Y7iai1nb+joenARdUzA
 WB1zbBpWxSOsU3ZY/eGX+CaflEuAo89BUa56P9rSACARO7ETqhEJnNO/8ymTTXuEcXGTeEdmwFE
 1nNVfzzFuk/Cmr9o4S+YK9W2vkCQUsDC7Ew+0fS34exOgmX43iOLSmEhkjWMZVS+q7LLEwz904I
 b0LcqRFcVvo6H1+TUu/5hUheusaiQbJRLQYL0OAnQcYOuDSpNNw9BK3+KBNLFx4GoZ222Gm1PQu
 cq3E2FBRhOviz6x1Mi1KTPfIi/lm8nz3/+PHNWIhg3LqlQ7uUG65GsV78AO2JEVN8XvF0IQAwcv
 AqmqHsKPFYDwFKrRBT+reVt4EwsSRS8SDIPAhKP9E3Bl2oLyFwxvqM9vyiCoqzn/YBqoEdm50yK
 LKfw6tTkoLwg5434zAAZ7vOZJH+pcd
X-Received: by 2002:a9d:6748:0:b0:7d9:ade1:e19b with SMTP id
 46e09a7af769-7e5ea577be3mr3898879a34.14.1779526534642; 
 Sat, 23 May 2026 01:55:34 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/11] test: Move disk images to persistent-data directory
Date: Sat, 23 May 2026 02:54:47 -0600
Message-ID: <20260523085455.750591-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523085455.750591-1-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
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

It is annoying to have disk images in the source directory since it
clutters up the working space.

Remove cur_dir=True from DiskHelper calls so disk images are written to
the persistent-data directory instead.

Move scsi.img too (used by the bootstd tests) and mmc6.img (used by the
MBR tests).

Add a few comments as to where the images are used.

This keeps the source tree clean and puts disk images in the same place
as other test data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/img/common.py    |  2 +-
 test/py/img/efi.py       |  2 +-
 test/py/img/script.py    |  2 +-
 test/py/tests/test_ut.py | 11 +++++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/test/py/img/common.py b/test/py/img/common.py
index 301b6c840d4..a2c86c5c282 100644
--- a/test/py/img/common.py
+++ b/test/py/img/common.py
@@ -74,7 +74,7 @@ def make_extlinux_disk(ubman, devnum, basename, vmlinux, initrd, dtbdir,
 
     fsh.mk_fs()
 
-    img = DiskHelper(ubman.config, devnum, basename, True)
+    img = DiskHelper(ubman.config, devnum, basename)
     img.add_fs(fsh, DiskHelper.VFAT, bootable=True)
 
     ext4 = FsHelper(ubman.config, 'ext4', 1, prefix=basename)
diff --git a/test/py/img/efi.py b/test/py/img/efi.py
index 4cb0bb95a59..06fda8a90b2 100644
--- a/test/py/img/efi.py
+++ b/test/py/img/efi.py
@@ -31,7 +31,7 @@ def setup_efi_image(ubman):
 
     fsh.mk_fs()
 
-    img = DiskHelper(ubman.config, devnum, 'flash', True)
+    img = DiskHelper(ubman.config, devnum, 'flash')
     img.add_fs(fsh, DiskHelper.VFAT)
     img.create()
     fsh.cleanup()
diff --git a/test/py/img/script.py b/test/py/img/script.py
index e6072bf5bd9..5c0c9e99183 100644
--- a/test/py/img/script.py
+++ b/test/py/img/script.py
@@ -126,7 +126,7 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
         ubman, f'echo here {kernel} {symlink}')
     os.symlink(kernel, symlink)
     fsh.mk_fs()
-    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
+    img = DiskHelper(ubman.config, mmc_dev, 'mmc')
     img.add_fs(fsh, DiskHelper.EXT4)
     img.create()
     fsh.cleanup()
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 38fec6cf8a2..9c938943259 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -32,7 +32,8 @@ from img.cedit import setup_cedit_file
 def test_ut_dm_init(ubman):
     """Initialize data for ut dm tests."""
 
-    fn = ubman.config.source_dir + '/testflash.bin'
+    # This is used by flash-stick@0 in test.py
+    fn = ubman.config.persistent_data_dir + '/testflash.bin'
     if not os.path.exists(fn):
         data = b'this is a test'
         data += b'\x00' * ((4 * 1024 * 1024) - len(data))
@@ -45,8 +46,8 @@ def test_ut_dm_init(ubman):
         with open(fn, 'wb') as fh:
             fh.write(data)
 
-    # Create a file with a single partition
-    fn = ubman.config.source_dir + '/scsi.img'
+    # Create a file with a single partition (used by /scsi in test.dts) */
+    fn = ubman.config.persistent_data_dir + '/scsi.img'
     if not os.path.exists(fn):
         data = b'\x00' * (2 * 1024 * 1024)
         with open(fn, 'wb') as fh:
@@ -54,11 +55,13 @@ def test_ut_dm_init(ubman):
         utils.run_and_log(
             ubman, f'sfdisk {fn}', stdin=b'type=83')
 
+    # These two are used by test/dm/host.c
     FsHelper(ubman.config, 'ext2', 2, '2MB').mk_fs()
     FsHelper(ubman.config, 'fat32', 1, '1MB').mk_fs()
 
+    # This is used by test/cmd/mbr.c
     mmc_dev = 6
-    fn = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    fn = os.path.join(ubman.config.persistent_data_dir, f'mmc{mmc_dev}.img')
     data = b'\x00' * (12 * 1024 * 1024)
     with open(fn, 'wb') as fh:
         fh.write(data)
-- 
2.43.0

