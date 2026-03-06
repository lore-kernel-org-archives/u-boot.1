Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2415FCC065
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB50584027;
	Fri,  6 Mar 2026 20:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hReE5mVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFFB783F00; Fri,  6 Mar 2026 20:08:44 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC0E8400F
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8cb3bae8d3eso879888685a.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772824120; x=1773428920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8TA8ICnCvDS/qiQbINFFuGboE0qvVWH3GnTjhZ000o=;
 b=hReE5mVE2OTrWrEuDC1M/otZkhlelf2Zr3fF2KzUJXjpXRYZ5pu25uLetnGJcbwKXL
 p3l9Tk4UnRUznPTZTyKM3PuTdzb4Gl9oPtEP4/CdZvWlh9OU/vqLG09ZU/rYX3d3DRVW
 k0Vh2ROgLEJ/ySONMDSlQ+zXQd5GNxbqtffQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772824120; x=1773428920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8TA8ICnCvDS/qiQbINFFuGboE0qvVWH3GnTjhZ000o=;
 b=o8MEj44g2lclsfDxvEmuDHkkVjcHum+2TO9HToNNQ8VJ8AhMx1geMdzyDvTnROrPOf
 QUqAkTRG9l5CXNCzAJMLz/XiNk3GP6HN/P2PdcYTxuO0irv0S6ACtC43OwvDXqPbs31G
 AZOpihK+qUuY1RbqtYNvtl6TPzD90JmmAT4ACcwOr3fTO1ISgNJBkNfacio7DsEHiZ6m
 JSM9QrtLl0ANaxqKucJk2cdf+SiNqPAjSY83pLTn20LpGgknd1DnWb0tH0oKCY9umx1G
 8UfwUeZGC5C+pnSocpsiDly+oI07qUDcwTdQY8veikBR505N1rj4hm8VpNBF8wAEBXAr
 APOA==
X-Gm-Message-State: AOJu0Yw4GdqAgTWoyXYgYCYwk2ouRFSQNw2OvVWINPf4loVuyTI9d6Ix
 W5zZzmUDQfP12BsNN1oGv5D8OUqC4pmTn8/xwovr4rCdGAS521dWegHfOAOmgSQKXHReM9SwmT+
 gm0w=
X-Gm-Gg: ATEYQzxzr/tFu2iT2HP6RBv2beUZEMHThX74QGfJmfsfJn/KgFbhtVeQ+jeTF0ekva8
 ghppuiJ47kwcIbTfs7FDKzSeEtF0CL7LQPptq1LhLQJUwzymB+05m5vAxjGUWh1lrtg0Gp7vac5
 p6X/dPjYFwDy/aA+M16W5QWx5E04qkUqZAcuohNzD8JorYySQszVFCWlkOjGgX1M2Y49WzYL0Xi
 uEC27IrkjUpSGI3LkQGzkQnYdW5NnNCTKLDR8d4VKhVA1i5WQds2uDytbsr/isQB1wsuyAQpao9
 NTCcgIjZJijIXui8QK+wP8bU6uKuYQ1hUz+9+WnxG5eF10uXvL97EojFq6c+zX1C85r9gvfpcpo
 0PXsiNi8wx/XLdrx4JafYsaDhfGV220GbieyfLP53mD5LgdirlimCqOGlcAS8PMJ25VGNnDWNwW
 aVwv55LOjRxrVAdXqT0A==
X-Received: by 2002:a05:620a:bc1:b0:8a2:bff5:40d9 with SMTP id
 af79cd13be357-8cd6d32583fmr410980585a.16.1772824119783; 
 Fri, 06 Mar 2026 11:08:39 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f54ceaesm164372285a.40.2026.03.06.11.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:08:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 7/7] test: Convert test_efi_bootmgr to use FsHelper
Date: Fri,  6 Mar 2026 12:08:13 -0700
Message-ID: <20260306190818.3586749-8-sjg@chromium.org>
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

