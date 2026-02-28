Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F819FEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 18:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746C983F5B;
	Sat, 28 Feb 2026 19:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fK0I8WQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C8783F37; Sat, 28 Feb 2026 19:23:39 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFFCF83F56
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 19:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8cbb2329e7eso337931185a.0
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772303015; x=1772907815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8TA8ICnCvDS/qiQbINFFuGboE0qvVWH3GnTjhZ000o=;
 b=fK0I8WQj+nYMhSDL59SXOinUlJXt+hA9Bog2vqOyWFlvrtmFiGJezVeTxzf0SyX5Op
 qh4NZ7Hfan7jdbaA/6qhY/ENTbsa9EwX1Pfi0ehNnSNtFn5/yLyXIcNQsuAjmXzl5p26
 VpDrXlqqpN/MGv1t9j9zF1YPkgxZ6/5la5Hjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772303015; x=1772907815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8TA8ICnCvDS/qiQbINFFuGboE0qvVWH3GnTjhZ000o=;
 b=nCFubR9huo/inZTFLKD8HCqDJX/Pe6RM4LFzOW11qWE4HM9XUmpS24IQUqdpWrlW4j
 I3dVZr81bQn9TnSRqlg9CnynSDqTsmIGsvu4KhL83/VQVNQdRB6q0iQ1VYOfj6Zd/P1g
 4xfDZ3uvFCZ/NCCNPyonjepEDBWDtiuerPWReD2GgUwVw/rDIiAWmQFOupQoh6o4940A
 Y7WbahvRlJGoDZZAFLxjKpP//JiG8KdaAP81r+/yk28wLhzSAg7af87u2jXb8SeVhvh0
 uFibFsO4TOGrfV0c0GKp5oJWyiBWGATTzd27E6szBnyPL5AQ0VslXz4M3Jx/nrwlxJcf
 cyag==
X-Gm-Message-State: AOJu0YwpGBAMVYgdyFe3lVSS/RapYK+Tk/y+PRcb2szYzVqKI/rg4PQ4
 ykNv3t+lZKCy9VxOp6FaLzqIaBSGAOFuCwUvNwQTor/mgIC949sfKrbs4OEqLKGICvmlyPl41D2
 52u0=
X-Gm-Gg: ATEYQzwWxBmIHCWrilfS3+0rFH5fcOPBNXeqRHCXvuEAt3JUzL5dhwteriOmMUWLMFZ
 Kr0/oB9FWa5D54GJJDGoh83bSpvWWKNDuaDLSUfS7hsjWADPdtmcIOZ+Lwq5ZLXzk/lA4lwJ9n/
 2Glm4Njfo5podRW6nzyTI2tIWkZt3QBKCffiH7SPXYIH5pwvB7ZaXpxuB36ccBsOdFxhcgqWJJj
 XzJD7Ki8w17CneVwhq28JtA00ptDMJN4JAfR2/mYxBdxpJfmC1u/q9CfXekl6xq/qzLlUQgY00S
 s7usQ0WhvMJ9FlHb73zBNjh5GKkzdXASZkwCKGjc5aEi/6Rif6GU+Kd09YiNwd4uwu6OQarO1tZ
 J6uvOmSgJ99FLmHWEgT6vEi0QA/anGtqMy45ZUpBpH3kalHKZhZk4LOKRHsx25iSqla5dA7L/XS
 vo+SLR0ZiPK8i0SoLU55knTEbx2dL0
X-Received: by 2002:a05:620a:4509:b0:8ca:44c8:3540 with SMTP id
 af79cd13be357-8cbc8e78817mr887004385a.64.1772303015041; 
 Sat, 28 Feb 2026 10:23:35 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449a66f1sm78508601cf.12.2026.02.28.10.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 7/7] test: Convert test_efi_bootmgr to use FsHelper
Date: Sat, 28 Feb 2026 11:22:47 -0700
Message-ID: <20260228182304.3728735-8-sjg@chromium.org>
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

As an example of how to use the helper, use it to simplify this test.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

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

