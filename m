Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12D5CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28AB98490D;
	Wed,  6 May 2026 17:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BedAraxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FBC0848FD; Wed,  6 May 2026 17:57:56 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 025098466D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso5752697a34.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083070; x=1778687870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIk6gomOt8lsEeyhjs8HFgp4/PhmhKZknk680vZWw3Y=;
 b=BedAraxtJKXV6PSSKmGtPWG0WdOqeV7uMH30/dl0aolNaAKYtaimr34D2yr3g7usex
 jiwz0K3w7zKvObofYo2Mjvaum2sceH3XC0CwmI3oy0M+ZDkNha0oKhjVb3Ln2+L3fl3M
 1y4AQQMO53o2/yDyRK2AYStiH7/fpKWQzw/bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083070; x=1778687870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vIk6gomOt8lsEeyhjs8HFgp4/PhmhKZknk680vZWw3Y=;
 b=VL1688R0vId9KdbFhohpvHoSCXRGtQDp3rwGtE9OqZjjvNT2+6GOqqEbtx2ueDSoZf
 oABQt0xDs2Wc7xSG9k9/G8ptFxwjw+uIstm3JQypZxl+V9+Vd5JrIxNQbAensb5e2Y2v
 NpvJnGNeHsNKfJbAm5fODhRa/P5LdugYv4ipMHeFz1YuLs1bvZU6f1Lsm6FsaCXn/mFG
 7izWN1CuAHBYM0pCxk2H3xZQYAOJYJXoRG0q+tQJX/N7k5z/xGc8HMqTrRTYa3QH4LyM
 d4dlgv1JsvuDCRbTpWgx8v/8MGuEPyuDnrRDKCqJnbNZGm361/MigUWxgxanHdplJNLj
 EoRw==
X-Gm-Message-State: AOJu0Yylz9t14v2eZofdwb3+E/aY4EoM0RdWpNNowrAr4XADWflZ2kfv
 mrr3nZTPIpQFf4NfmYa7eSplIq7LU4gDv6Eam85pKEV4o8qMPYrYV5q3hs4Wo00Mm6UDmx3pXyO
 Thd3MnA8y
X-Gm-Gg: AeBDieufxZKaGqQVKn2Uo0J+DftaygV6D5dexNF+UgjMvQE7o2uA6oND0+u63PT7u0N
 5CxrQV1oZDvdJyiElJ/l2S56eploBKkV3TbYtVc1Yr5HjGKZf4cVmfiUGcb+8gWKo7idRR1G6Ga
 MQW2wqe+tHlmNw4WuX+BwYbXw/N12TnceZF9jAy46ZsTtHyGHJ3nr3kCk+HfsKXfncwIYIFhnot
 wcV3YN6CqnoHLnbwYHW1aWExMZN1vJCbFyd8YWtytqIHD++0bCnlxkwks7rYpEFc+O/pgyBMuuR
 jI7gp2xcsVHgG4deN9O8W4A/MN229qK+ZL2nD0vYvUjbYrBbZAIRbS1ViLNySbnjOdh2hHCtRJU
 BIkVovw91alQixmOapy8lO8JpUCBw6b4OjELUAyZ3LCrYD0/X4lmDpKUdza8ygPl9QT60L66fr8
 MpNOdEbO1pPu/bxfaSi3gMkbpIOIFj
X-Received: by 2002:a05:6830:6d4a:b0:7d7:fac4:e359 with SMTP id
 46e09a7af769-7e1df194684mr2284287a34.27.1778083070207; 
 Wed, 06 May 2026 08:57:50 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:57:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/10] test: Convert test_eficonfig to FsHelper
Date: Wed,  6 May 2026 09:56:15 -0600
Message-ID: <20260506155639.1191640-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506155639.1191640-1-sjg@chromium.org>
References: <20260506155639.1191640-1-sjg@chromium.org>
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

 test/py/tests/test_eficonfig.py | 46 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/test/py/tests/test_eficonfig.py b/test/py/tests/test_eficonfig.py
index ac1600ec252..903d9eab6d2 100644
--- a/test/py/tests/test_eficonfig.py
+++ b/test/py/tests/test_eficonfig.py
@@ -6,8 +6,8 @@ import pytest
 import shutil
 import pytest
 import time
-from subprocess import call, check_call, CalledProcessError
-from tests import fs_helper
+from subprocess import CalledProcessError
+from tests.fs_helper import DiskHelper, FsHelper
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_eficonfig')
@@ -29,30 +29,26 @@ def test_efi_eficonfig(ubman):
 
         """
         try:
-            image_path, mnt_point = fs_helper.setup_image(u_boot_config, 0,
-                                                          0xc,
-                                                          basename='test_eficonfig')
-
-            with open(mnt_point + '/initrd-1.img', 'w', encoding = 'ascii') as file:
-                file.write("initrd 1")
-
-            with open(mnt_point + '/initrd-2.img', 'w', encoding = 'ascii') as file:
-                file.write("initrd 2")
-
-            shutil.copyfile(u_boot_config.build_dir + '/lib/efi_loader/initrddump.efi',
-                            mnt_point + '/initrddump.efi')
-
-            fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x100000,
-                                     'test_eficonfig', mnt_point)
-            check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
-
-            yield image_path
-        except CalledProcessError as err:
+            with DiskHelper(u_boot_config, 0, 'test_eficonfig') as img, \
+                    FsHelper(u_boot_config, 'vfat', 1,
+                             'test_eficonfig') as fsh:
+                with open(f'{fsh.srcdir}/initrd-1.img', 'w',
+                          encoding='ascii') as file:
+                    file.write("initrd 1")
+
+                with open(f'{fsh.srcdir}/initrd-2.img', 'w',
+                          encoding='ascii') as file:
+                    file.write("initrd 2")
+
+                shutil.copyfile(
+                    u_boot_config.build_dir + '/lib/efi_loader/initrddump.efi',
+                    f'{fsh.srcdir}/initrddump.efi')
+
+                fsh.mk_fs()
+                img.add_fs(fsh, DiskHelper.VFAT)
+                yield img.create()
+        except CalledProcessError:
             pytest.skip('Preparing test_eficonfig image failed')
-            call('rm -f %s' % image_path, shell=True)
-        finally:
-            call('rm -rf %s' % mnt_point, shell=True)
-            call('rm -f %s' % image_path, shell=True)
 
     def send_user_input_and_wait(user_str, expect_str):
         time.sleep(0.1) # TODO: does not work correctly without sleep
-- 
2.43.0

