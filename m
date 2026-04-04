Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B68E88D9D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8089484154;
	Sat,  4 Apr 2026 16:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ONaLc1Ee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B4584020; Sat,  4 Apr 2026 16:04:09 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 189F184101
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dbba5076c8so675308a34.0
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311445; x=1775916245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sItkOvvhVkwURHZFcKDrDWPJB/dJVW+Pw1ZmN22mN2c=;
 b=ONaLc1Eeb6KC6/xiLAfPT/V+1yUgtIC5x24puwq8SSN+ASwlFcUl+sXv61Z6rbkiCW
 V+wkIqIL1CblwYXPoAfTj8z9wSocHgm++Bs5xWvNS8ReoA0zOk8d10IJ9MfmCOydUxwe
 hxWaKv7+PCeFLYir6V6vi1b6EKxiMpzf3JUR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311445; x=1775916245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sItkOvvhVkwURHZFcKDrDWPJB/dJVW+Pw1ZmN22mN2c=;
 b=SrwsOFcem+7NlmrLbUw5MTYpLqS3YSsnbEiGts/9AvqYrEImp7JkF0qQKQ6JAgDd3E
 Htazoebkcw2E4bP0wjNluh0O4n3TCPEApf7ct2Z9BvY+1jlhs4LHcs/+Gzec/jn8ykzm
 nAgV2+NbuJXQIk+stbeImxFfLTZxzCTpN8e2Ml0kTKfLMV7hqVhAv2UN2jAj+JwUx0F6
 QgWqhTDp71sqTvnmBXUImyGxDc6/is9uVA/CB1XKKWJohSOARLhPC8NX4wtg2HxAMx60
 sqqniWo0hV/IwcHUMA7lryjkp5m6LbNytSW15Fhafz9KplRS6dSdUIo/4HBP/URwPMi3
 PUtA==
X-Gm-Message-State: AOJu0Yzj3UBtSkzFIhN3AioEB5yybuhJVbMfM/q6zn+d0C43Ee3ts3Hx
 Tk3h3Ggr+BNjr7SqgjfvEiiF+G+C3B9UZt34oC1z88UwBTENf9kDwYGgfQLgM1JyT65o0cBYaCB
 A2QU=
X-Gm-Gg: AeBDievflrpgN7SxXd8SENqj+cjjqJod9ubcw9nD1HrsSttEFTvbmWXty/T0f4csaCj
 jVy8O0t1GkqWhUgL0W8sxTBhieLnXQtVF5pLql2XblqKgZj4RCJimncnIQCfoEJcJ0JTd3U/0kA
 w/4Pqeb/JeMguQfdJJ4tVKC6i4sjzqpK3kFv3jEU1c40LcFdrs0Up0S8bMEqoLkt4/QJsZOaZgZ
 +SNFVvSewOoDQj1bFbuOoVmjpWP9jAVeXBLN6kPFfEJSVL6fOf2NwJ0YQykK1pMnkMJdyLk2SBZ
 302qVga085/LhNmzntUK4ykTdyi96jh7cEX19tj7/GcLb97h+cB5jay1TqnH62M7BSXWWnmJ5iS
 xXmN++0NaWaPfTZ7AtD2L93Ljme05IOilTBttnX7XyyUhxjEkotpM4K8YWy6/lFGepff9jWt7VY
 lqXyHT8vP7l7JTwxI/7g==
X-Received: by 2002:a05:6870:529:b0:423:1858:63e1 with SMTP id
 586e51a60fabf-423185883famr2979528fac.31.1775311444961; 
 Sat, 04 Apr 2026 07:04:04 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:04:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/14] test: Convert setup_bootmenu_image() to use FsHelper
Date: Sat,  4 Apr 2026 08:03:11 -0600
Message-ID: <20260404140328.3724864-8-sjg@chromium.org>
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

 test/py/tests/test_ut.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 98641a46c1d..a1c4af1b096 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -17,6 +17,7 @@ import pytest
 import utils
 # pylint: disable=E0611
 from tests import fs_helper
+from fs_helper import DiskHelper, FsHelper
 from test_android import test_abootimg
 
 def mkdir_cond(dirname):
@@ -45,7 +46,6 @@ def setup_bootmenu_image(ubman):
     This is modelled on Armbian 22.08 Jammy
     """
     mmc_dev = 4
-    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0x83)
 
     script = '''# DO NOT EDIT THIS FILE
 #
@@ -121,7 +121,9 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
 # Recompile with:
 # mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
 '''
-    bootdir = os.path.join(mnt, 'boot')
+    fsh = FsHelper(ubman.config, 'ext4', 18, 'mmc')
+    fsh.setup()
+    bootdir = os.path.join(fsh.srcdir, 'boot')
     mkdir_cond(bootdir)
     cmd_fname = os.path.join(bootdir, 'boot.cmd')
     scr_fname = os.path.join(bootdir, 'boot.scr')
@@ -150,13 +152,12 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     utils.run_and_log(
         ubman, f'echo here {kernel} {symlink}')
     os.symlink(kernel, symlink)
+    fsh.mk_fs()
+    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
+    img.add_fs(fsh, DiskHelper.EXT4)
+    img.create()
+    fsh.cleanup()
 
-    fsfile = 'ext18M.img'
-    utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
-    utils.run_and_log(ubman, f'mkfs.ext4 {fsfile} -d {mnt}')
-    copy_partition(ubman, fsfile, fname)
-    utils.run_and_log(ubman, f'rm -rf {mnt}')
-    utils.run_and_log(ubman, f'rm -f {fsfile}')
 
 def setup_bootflow_image(ubman):
     """Create a 20MB disk image with a single FAT partition"""
-- 
2.43.0

