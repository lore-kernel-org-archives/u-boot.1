Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9994AD7308D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478CC84101;
	Sat,  4 Apr 2026 16:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i4eZLgRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3517780325; Sat,  4 Apr 2026 16:04:07 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F83C84020
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so2226874fac.3
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311443; x=1775916243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqcYtr6SzE9QNvTzAXzmYoBRESuvyalgh5HvXZtNODA=;
 b=i4eZLgRlkzY7a6fQsUng0qB2p7cw1UMhPaAG8mG0watipPJM4Y99Hh1/uvDwRJ4OZP
 2ikWKzPkosAp1s/7r3HzHm2WwcJUdf9cX4jFvqBSusc/xYePDYDxTu9Sooj7VqxO3g6E
 RdFQpuOiKVw3D45PFIl/JwwD/Vcb3auJw2Hsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311443; x=1775916243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hqcYtr6SzE9QNvTzAXzmYoBRESuvyalgh5HvXZtNODA=;
 b=iKM3ac8npm8NjVb/Vq0nOwpc2r5SKKhF5n3Rnxb6szeONMTXqAZc7S8OwbVsWOMnPj
 aJBrTuBGygnriJgmwLNi1n/nUKi3w53gzlg6RvPL+hp1XJrVr+VpkMiQ5ohICCucXqQu
 N+szi1xOXr2u9kGl2vyR/9PrASBnthkwQjhrrm9sjACjxeGhurZOPs6HsDcPTIgA8lOr
 B/slKIuYNJgnk8oJL8aeZckBoGdAnwnqbmzL1DIOCku4WsSfOYnDRXBegFcgSYpjcrfT
 R1meHCvAXE2K6dyWVep8G1M8HkambpByAI4iY/ibAUsR+KGoxyrcQwH3J99unHuut83V
 4NwQ==
X-Gm-Message-State: AOJu0Yw1QhfbqrERS26Iecv2xF4BZornNC3EuccD9F92n+EVSORSME5r
 qrlds2JrFPpbWWmSzyrUFIahkKtXoAmDx2Z0uUxehmsCXpKziUDiblslJgzAaPQntzFqU7uC+UU
 PRhM=
X-Gm-Gg: AeBDievqIUBWIbNH4TceUcxQQQrtG4nrD7+yCMwOchlB4y5po5MlomniA1XcsAYhAGR
 937yLhxDv1aCeyprzn0Pl5My9VeSgI/+o0uXAesUxnytXieBVtN+hidlc1z5sSgfjf6lPAUYaPs
 E9zWFW7oKI2MIRDwXBwrcZABAnCkQZ/NliAcAAqT/Akv9a+YMLt1MLuJi5UVzqxGLdUft0iywSi
 mziHShBnb+qn400VnBkY+Y5Wpw7BIlrtYZYhU0Mli+nDd+wYEUQKjTSBQyyLFlNk21Ge+dUCtWD
 ulW18eEJnG2AWGBZvNFlO3JFMRPIU3BCQ55r6QNuSmBwbQ6Rc0n4Zvy256t01d9rQEmkCFdqNlj
 uiWeYbUrfOZzotmLHolDxbCbqOgGuufmj+ymmkwV83MhoLfxWTarBDG9pqC6F9AQ4hcBmxH3c++
 1+qD2Zn3fKQvBpYeMRq1sS+eQVDKJf
X-Received: by 2002:a05:6870:f203:b0:416:3d80:fb76 with SMTP id
 586e51a60fabf-4230ffc22f7mr3636832fac.28.1775311443137; 
 Sat, 04 Apr 2026 07:04:03 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:04:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/14] test: Convert test_efi_bootmgr to use FsHelper
Date: Sat,  4 Apr 2026 08:03:10 -0600
Message-ID: <20260404140328.3724864-7-sjg@chromium.org>
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

Simplify this test by using the helper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_efi_bootmgr.py | 38 ++++++++++++-------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/test/py/tests/test_efi_bootmgr.py b/test/py/tests/test_efi_bootmgr.py
index 4c10cbdf17d..7d1f3f16d00 100644
--- a/test/py/tests/test_efi_bootmgr.py
+++ b/test/py/tests/test_efi_bootmgr.py
@@ -5,7 +5,7 @@
 import shutil
 import pytest
 from subprocess import call, check_call, CalledProcessError
-from tests import fs_helper
+from tests.fs_helper import DiskHelper, FsHelper
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_efidebug')
@@ -20,22 +20,19 @@ def test_efi_bootmgr(ubman):
     Args:
         ubman -- U-Boot console
     """
-    try:
-        efi_bootmgr_data, mnt = fs_helper.setup_image(ubman, 0, 0xc,
-                                                      basename='test_efi_bootmgr')
-
-        with open(mnt + '/initrd-1.img', 'w', encoding = 'ascii') as file:
-            file.write("initrd 1")
-
-        with open(mnt + '/initrd-2.img', 'w', encoding = 'ascii') as file:
-            file.write("initrd 2")
-
-        shutil.copyfile(ubman.config.build_dir + '/lib/efi_loader/initrddump.efi',
-                        mnt + '/initrddump.efi')
-
-        fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x100000,
-                                 'test_efi_bootmgr', mnt)
-        check_call(f'dd if={fsfile} of={efi_bootmgr_data} bs=1M seek=1', shell=True)
+    with DiskHelper(ubman.config, 0, 'test_efi_bootmgr') as img, \
+            FsHelper(ubman.config, 'vfat', 1, 'test_efi_bootmgr') as fsh:
+        with open(f'{fsh.srcdir}/initrd-1.img', 'w', encoding = 'ascii') as outf:
+            outf.write("initrd 1")
+        with open(f'{fsh.srcdir}/initrd-2.img', 'w', encoding = 'ascii') as outf:
+            outf.write("initrd 2")
+        shutil.copyfile(
+            ubman.config.build_dir + '/lib/efi_loader/initrddump.efi',
+            f'{fsh.srcdir}/initrddump.efi')
+        fsh.mk_fs()
+
+        img.add_fs(fsh, DiskHelper.VFAT)
+        efi_bootmgr_data = img.create()
 
         ubman.run_command(cmd = f'host bind 0 {efi_bootmgr_data}')
 
@@ -61,10 +58,3 @@ def test_efi_bootmgr(ubman):
 
         ubman.run_command(cmd = 'efidebug boot rm 0001')
         ubman.run_command(cmd = 'efidebug boot rm 0002')
-    except CalledProcessError as err:
-        pytest.skip('Preparing test_efi_bootmgr image failed')
-        call('rm -f %s' % efi_bootmgr_data, shell=True)
-        return
-    finally:
-        call('rm -rf %s' % mnt, shell=True)
-        call('rm -f %s' % efi_bootmgr_data, shell=True)
-- 
2.43.0

