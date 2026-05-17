Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF05CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38A2846E6;
	Mon, 18 May 2026 00:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lQfqn5HP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9588A8468A; Mon, 18 May 2026 00:52:00 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A829A846AD
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7dccb8644c4so970519a34.0
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058316; x=1779663116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7JfKmCArb6ejFZTvMDjj2BQXssKrM5aB7H76XIw9r8=;
 b=lQfqn5HPSQobKRwo2act1N0CDE1td4lGo+7Ow1vIPgvu4f85/ijdxF0ISlRKKO7nMZ
 raMAxTK2AGH678awFjCME0cs6qN2t071ZcjHP/iq2eaz8OTxOa1zg6MI/0tlC5P8AQGn
 IynB8eAfzQ9qFOm1pM6WGGWJk+LjHVVBpAYWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058316; x=1779663116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J7JfKmCArb6ejFZTvMDjj2BQXssKrM5aB7H76XIw9r8=;
 b=LOECe+Z/nHdYCZumi1nys4hpgLCjs9xH1dli2EkVhPAmvzFJXozZhOFZxN+e02aK8w
 kW9P8s6QGBIJkDsFlmOq7B5h4QyKZC1rzd5ltdzotEOFSjsxthgoq28XMR+z5FXEDGF+
 28zWdV2ITm5drVjnTamwhnUDGisWLFQ2K0Hv/v3pbNi5V19OrBjjOilXRJJptgU8h7nF
 qa6rjLFhhSYJePpj76zi/2jyzSvuYRK5z2vk5fBv1Q/7JU9f4oG2nbTQUHmMaVM8emiB
 7dUjnJUJqkyST41YrnoWQNKK4pQKn6AdxCNHPoaBJrHMvFPeM6Xk5NTNaZeb3zDLA0IW
 JdQg==
X-Gm-Message-State: AOJu0Yw95Vxrf5oSxA2cu5FuKlSZmPkszdHn9QcEx1JD4Rro4V7Qcyt1
 zzUyifb4g1OpcqyK45H6CDGwnJaNIR87XBZY8TBDG6K1rLnF81bMW4pWlAQu9O5Mdi4kSepQy6f
 tj+joDyRA3Ok=
X-Gm-Gg: Acq92OETW++m+ADSqzu6snhIOmm6/isQ1vVdXc8c8F9BV0bDFIF9xSF1pIKs8vfEzVa
 1xwy55OAopnw/zkU/8n+0eMLy0SiM8GZEnm/ULOVEhX4Y+M57x7quiQMfTpe5tb9SNUS9eM+qsI
 7k8fjgt58sxuHcSR3900GsG8rIS1I8S32UZ1ipTdKVdFVZ+R+pHXUUJ1fU9m1QcTvpu/AyIXejy
 t8xdgge8S7YAD6DZxSKZLuB3jdEXgKDzfpgkWiF1m4YahuASK0M6aY6GLCsYAFfJVB8+/espSt2
 PO3zJiV9vZrQlBsfdI9Uz8To/R12HoIjlPTCDVvkdN97eLwEftifYZMAQfIHvD0EONTkEjqqKKp
 KJDYHv1zuZ7C6TLNPH8y9UySjynfHVcqXyD3hHivc19yq9usQUdxsZSNNs7UzYMKn7zUv3KRB3p
 UusvkS5hhi6sEpb98zCQ==
X-Received: by 2002:a05:6830:6606:b0:7de:a2cc:9da2 with SMTP id
 46e09a7af769-7e4f2b903bemr9153313a34.15.1779058316451; 
 Sun, 17 May 2026 15:51:56 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/11] test: Move disk images to persistent-data directory
Date: Sun, 17 May 2026 16:51:09 -0600
Message-ID: <20260517225122.2966807-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517225122.2966807-1-sjg@chromium.org>
References: <20260517225122.2966807-1-sjg@chromium.org>
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

 test/py/img/armbian.py   |  2 +-
 test/py/img/common.py    |  2 +-
 test/py/img/efi.py       |  2 +-
 test/py/tests/test_ut.py | 11 +++++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/test/py/img/armbian.py b/test/py/img/armbian.py
index 1bcba3fae63..697b8fcd9a0 100644
--- a/test/py/img/armbian.py
+++ b/test/py/img/armbian.py
@@ -126,7 +126,7 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
         ubman, f'echo here {kernel} {symlink}')
     os.symlink(kernel, symlink)
     fsh.mk_fs()
-    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
+    img = DiskHelper(ubman.config, mmc_dev, 'mmc')
     img.add_fs(fsh, DiskHelper.EXT4)
     img.create()
     fsh.cleanup()
diff --git a/test/py/img/common.py b/test/py/img/common.py
index 37349c0a2e7..16bf23a4c6f 100644
--- a/test/py/img/common.py
+++ b/test/py/img/common.py
@@ -74,7 +74,7 @@ def setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
 
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
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index e8d47b79365..2205ba6acf6 100644
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

