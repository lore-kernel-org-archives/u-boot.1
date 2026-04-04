Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CF9E88D9D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39BF84178;
	Sat,  4 Apr 2026 16:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nd31spBu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7DD84181; Sat,  4 Apr 2026 16:04:16 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43AA8416F
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4233e152457so210888fac.1
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311452; x=1775916252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWefJqWhgSH+VDXEZMtiFzLAShn/sHtvtWnUNBu7xVg=;
 b=Nd31spBuOiEZdEL6iu5cc/sKh2ac07A8qQ+Y0PWf5u7Y0bZ7MYR5dU67BnffN3DNnt
 3oVvLr2WEunr/gncL5eaPvpQVjMYg/lpRoyZR1Jsf4VYnQOdQvJA4r9KVv6gYh2buKCj
 PJ1Tg9SoDaj3UE98JM+tyCKN42HX3KXfART5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311452; x=1775916252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FWefJqWhgSH+VDXEZMtiFzLAShn/sHtvtWnUNBu7xVg=;
 b=cZmPqRv3UtqFjVAvp2D2tZ26GnLjzWz1VJZ9oHDTre2bSxmlsWl9Cs0ybJkf1a8ngq
 yJtRsRC93FlZsMWo89ojc8CiJBiO43TX1AZTgLyv/5xU4qnrvlS6nDe8CCA4A6weAW8G
 preUQOkbmfcGzg/HiUOMWiri0VOqvvAL6ixmi3REhcIRCQgBrUd/GNAV6pITN4gQS2AP
 ZKWMzioCDAapNZwFe9OAslhhKP3NhWkc/jsW2OAzC3clPCL/Xp7hhv5y+oUiU4ko6UDc
 yWL0fGeD3zdzMOEn+T4x0IxNgIY5yS67Mo6UYIEH2XwS0FabEF4T9GTcIp9oxnfU5s1K
 P+vw==
X-Gm-Message-State: AOJu0YzF5UjwtIInWKs9C+z7BH3WvPePTEDgGSZFl5WdUzAVCoL+P8JV
 PGUzdGb6pR5boFS8z1oZlwC08BxMe1K2KWMCkNRDUse3hmbQeGZ+FpX32lkr557jIukp9c7HoUF
 Sid4=
X-Gm-Gg: AeBDiesgqNeqK+Qzlg/k9aN/FI0EVbYj3U7zs7omZJF7UQxTKKUcd9goBWTv7gDhV0J
 729peGvqZ4pdTzWcYBRcIx5vMMtFYUFD2RRdN2F1qyffFzu7obfEXpHKrKKoh+FPf/46L//vI3/
 ZhJrXY/q5fs4VoQYXEKPG6feTJbzcUHIdQ55yeCarfB8mV43+/1syMymjRq0SiLYgeVlWCfZDUQ
 PPy6YakJLwDcCiYkn5lLMEAZatuvBN/oyl63BvPsJwakBMyHLFnvTfmQV5viUpgUKaVeYkXSMQW
 aT1EBki/iy+Fjd3lv0JkDWwRiM7EOqvb948qC5Lw3ANciA9qIoAotZ4HK2IwEEd1lxinX3kxdMg
 ug19F+N73YPY01mghtyYEoNnsdEmS2rO7SKXI2/bnnkhtxiBs19HkVuiZ1DqZnKV4y+b6DTSWvP
 /hEEdpu4A+aKHNKldHpQ==
X-Received: by 2002:a05:6870:ef17:b0:417:5ca8:8155 with SMTP id
 586e51a60fabf-42310131c73mr3698953fac.24.1775311451998; 
 Sat, 04 Apr 2026 07:04:11 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:04:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/14] test: Convert setup_bootflow_image() to use FsHelper
Date: Sat,  4 Apr 2026 08:03:13 -0600
Message-ID: <20260404140328.3724864-10-sjg@chromium.org>
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

Simplify this test-setup code by using the helper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_ut.py | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 758f99cbfce..8bc915ee5e0 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -172,10 +172,10 @@ def setup_bootflow_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
         dtbdir (str or None): Devicetree filename
         script (str): Script to place in the extlinux.conf file
     """
-    fname, mnt = fs_helper.setup_image(ubman, devnum, 0xc, second_part=True,
-                                       basename=basename)
+    fsh = FsHelper(ubman.config, 'vfat', 18, prefix=basename)
+    fsh.setup()
 
-    ext = os.path.join(mnt, 'extlinux')
+    ext = os.path.join(fsh.srcdir, 'extlinux')
     mkdir_cond(ext)
 
     conf = os.path.join(ext, 'extlinux.conf')
@@ -187,25 +187,30 @@ def setup_bootflow_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
         fd.write(gzip.compress(b'vmlinux'))
     mkimage = ubman.config.build_dir + '/tools/mkimage'
     utils.run_and_log(
-        ubman, f'{mkimage} -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
+        ubman, f'{mkimage} -f auto -d {inf} {os.path.join(fsh.srcdir, vmlinux)}')
 
-    with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
+    with open(os.path.join(fsh.srcdir, initrd), 'w', encoding='ascii') as fd:
         print('initrd', file=fd)
 
     if dtbdir:
-        mkdir_cond(os.path.join(mnt, dtbdir))
+        mkdir_cond(os.path.join(fsh.srcdir, dtbdir))
 
-        dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
+        dtb_file = os.path.join(fsh.srcdir, f'{dtbdir}/sandbox.dtb')
         utils.run_and_log(
             ubman, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
 
-    fsfile = 'vfat18M.img'
-    utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
-    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
-    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
-    copy_partition(ubman, fsfile, fname)
-    utils.run_and_log(ubman, f'rm -rf {mnt}')
-    utils.run_and_log(ubman, f'rm -f {fsfile}')
+    fsh.mk_fs()
+
+    img = DiskHelper(ubman.config, devnum, basename, True)
+    img.add_fs(fsh, DiskHelper.VFAT, bootable=True)
+
+    ext4 = FsHelper(ubman.config, 'ext4', 1, prefix=basename)
+    ext4.setup()
+    ext4.mk_fs()
+
+    img.add_fs(ext4, DiskHelper.EXT4)
+    img.create()
+    fsh.cleanup()
 
 def setup_fedora_image(ubman, devnum, basename):
     """Create a 20MB Fedora disk image with a single FAT partition
-- 
2.43.0

