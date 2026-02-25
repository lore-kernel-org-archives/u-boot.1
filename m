Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7118FFD3776
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273E5841B8;
	Wed, 25 Feb 2026 17:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dF3SWl3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F97841BC; Wed, 25 Feb 2026 17:27:18 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B54A84172
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d196a2334fso1136433a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772036673; x=1772641473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUpN9BvZCsG3x2vUx3EPhJXzgQP6Wjw9TR0k/bV8t6M=;
 b=dF3SWl3v90oZztC6owtpcIXgObJ851TS4xyvbnvzkEBv9p8skOrFwY5eLfZZVzjiY6
 P0zeS8Qy61gDv2PNRnAmL9JnfXq03omQ2+WrxYaxubVlDF9eKw10cll41ius5haVIDfw
 DgSXNwnScoDFWgDoWmR+vKV2LBDYFG3y/AiT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036673; x=1772641473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AUpN9BvZCsG3x2vUx3EPhJXzgQP6Wjw9TR0k/bV8t6M=;
 b=c1/BMlXfm0YM0QdnXDNcey5gqOaYe4o6irPFvwpHfx4JMnUl9nEvZaALq//X9xlhpo
 BDboq/uQIA+i/NuTcl9cDoa+DJ/nVLtQxREME4zKG7e5CtzS5NcroRMD2PEgeUfCTHbY
 FvUqEdXirjSTPwvJfdOQdT4xt5Va2Q3brrhlXVvdXOsC/AIGLOzYVzF3J4bR5ostlcpf
 K1tsp/HV3sAMFJmswTDRca241J35EkkjBz2XRuvyLBrqoQs4O35EyEyKSIIGTfJvJk6r
 z9hI/HHQP3mdI6mvKpNoMZRMqHkq1hFDgOSHVdFDow1UZHqwgO99L9QJwGlpuD5wj170
 iGcw==
X-Gm-Message-State: AOJu0YymmU9O2kLR3+owTh7itVGtbLQ4E6KY9Qnj1zHNTlzfGnzHuyKP
 R+LaPxZ/EsN3yu2eFuzeZ/CCAFwfV99JD2EeJW6DUOvJFJbtRFwi8GALjR4HdNS/5lHBcN7eq3X
 gmw4=
X-Gm-Gg: ATEYQzyQ662zyn3ewoYHdM6ZsZNmnaQYGZQ7tv5JWQxauV20MVdu465vKcSYC37Joof
 6YuDhYHatxfiBuhPOhRqX0zhf0NzIHF5lMe8hPVY1Gk+FksdWPvevgOdIb7lhgCRLF6v/rfhpF2
 u2Y6JQUsISXDUTSwZElASmnSuwA4b8Ojji/GNapPMqZEiQai4ihfQNYmI+6lM4CfDIRVhiZhisO
 lv6DzXCRpVIJS2p44YOCEL2VhEdUt5nVGB7h8fb4DHpt/wwZ12N3/BPramknRFQxTO+aCuPbIPC
 P137vVLMlvpCqxcnp4suy6R0mBpGfqkT+Q8LEyPzWCXAvEXIqHxeNqGhjEeogx17oE2oBgyjfAs
 lxGn7KAc8omzt8Jm34YQiQbEWurO+nLCSf3/BSCY4kikzXhNjrvy6Rp9QaMLy5p1vaJD5LYvPwj
 KKJ2BIe/P0LilImK6SRQ==
X-Received: by 2002:a05:6830:2aa4:b0:7d1:93ea:5bc0 with SMTP id
 46e09a7af769-7d572f4b4cdmr2598715a34.9.1772036673122; 
 Wed, 25 Feb 2026 08:24:33 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf7874csm13534383a34.1.2026.02.25.08.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:24:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 6/6] test: Convert test_efi_bootmgr to use FsHelper
Date: Wed, 25 Feb 2026 09:23:50 -0700
Message-ID: <20260225162357.3449937-7-sjg@chromium.org>
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

As an example of how to use the helper, use it to simplify this test.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
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

