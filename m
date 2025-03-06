Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DCDC282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF6C81782;
	Fri,  7 Mar 2025 00:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GZRkKIMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B349810F5; Fri,  7 Mar 2025 00:23:18 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E3178142D
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6fd8be1e534so12370817b3.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303391; x=1741908191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzHrdVSFlrods3ZWIOAUTq0SofOlpz7FW2yvspw0Znk=;
 b=GZRkKIMKNxKhdtaZhWrG1mECmeBcVWZOCJQFytrNPQNJbnHOwKelelRFjIHwWnX14y
 3qyyrCVish331OG4k/4SF1zB5si00HK4a8YQx9H5yGvtkyDrNZL3hqzoNanr4Kl0d/+c
 YxkMbhTaiIYg2wXkINXY68fRVrl1gdO6NzsxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303391; x=1741908191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzHrdVSFlrods3ZWIOAUTq0SofOlpz7FW2yvspw0Znk=;
 b=gqi+VWf/JqmSbKreclF+uuoHYwspkK3Di2BYjmlfxnZLxPBSIkOK6efeb4YeIdkgoH
 ZC0tbiL46d1MpRoBZcOvky6OC3Hoc62XdKv2i1KJxvCYLzsZU6L7qqGZTiTwgwF6WH+E
 enKXg2yPAefDxqfV4ImLnxi0H0gHETjsCBbqljB9p9hvAfTx9lt4e1yrHDecb+klDB8X
 U1ebKa/5tiB3cyBCSz4ozbAEX83MI9ptzAk+522KhJt0XErt0QQ2DaXCJEdIY79XUUmv
 xetXuxAwefpQnro5g0cA7QKNlhCRs1WMd/yil4KshsminK7/4n9Ke/tgkklOOpFm/SiW
 ZScg==
X-Gm-Message-State: AOJu0Yw1k7jhZ7bKvCVvH1pNBoMOEQxowtjD3X7Rh68YvCcGYrj++Kz/
 Dr5V1K35Y163G+38fOCxiS//6VSlto8DvXZXTTXKLJDy+wDOJCmOTL8a8R3MLZ86PjaNfUMkh2q
 a
X-Gm-Gg: ASbGncvOgpjGajCCzx+gsMe9JybZJDy85WoVKlqFJCMwTejQYfVyBOO26berYWnAUTO
 a3Cz7QY0vww12H7zkBc5qKgL2iqgDSmEjH4/RD7MtbtKtoOcHombsN2JWSesqkw1HEzlfXcsNiS
 f5fonVCanWmi5u0YJWATNaWZqBLSEC98JLj1UC+IPf08Wp0GY1MuuM/D0iGuaby41RR9afINMww
 NQjnTmrvmRDstzof7UcPdrXNez/4JY1fCxCRQ7hb8Iw7OXcgDCu3jbORRqGdexEYDbZRmzXq/dr
 C8ukb5Mula0Gg3xRoeRp7fH0wvGw2UeDXgD91vUaIwyotRtQ
X-Google-Smtp-Source: AGHT+IEtWwz5O8mTxABldYpMM8friKO7JqvM8lPjD+bFAOKCY9U6l79YwLfjdxhA7WXHJMumT2cpTA==
X-Received: by 2002:a05:690c:6813:b0:6fd:a226:fb2b with SMTP id
 00721157ae682-6febf2a2a83mr21653197b3.3.1741303391322; 
 Thu, 06 Mar 2025 15:23:11 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 07/10] test/py: Rework test_efi_capsule to not use virt-make-fs
Date: Thu,  6 Mar 2025 17:17:09 -0600
Message-ID: <20250306232256.4150882-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306232256.4150882-1-trini@konsulko.com>
References: <20250306232256.4150882-1-trini@konsulko.com>
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

The problem with using "virt-make-fs" to make a filesystem image is that
it is extremely slow. Switch to using the fs_helper functions we have
instead from the filesystem tests as these can add files to images and
are significantly faster and still do not require root access.

The main change here is that our mount point directory has changed from
"test_efi_capsule" to "scratch" and so we need to update other functions
too. As the disk image that we get created doesn't have a GPT, invoke
sgdisk to do a conversion first.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I tested this as much as I could with an empty
board/sandbox/capsule_pub_esl_good.esl which did show me a few issues
along the way so I am reasonably confident, but this really does need to
be tested on a platform where all tests are run for real.

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 .../tests/test_efi_capsule/capsule_common.py  |  2 +-
 test/py/tests/test_efi_capsule/conftest.py    | 21 ++++++++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/test/py/tests/test_efi_capsule/capsule_common.py b/test/py/tests/test_efi_capsule/capsule_common.py
index fc0d851c619a..68b2e48bf5a5 100644
--- a/test/py/tests/test_efi_capsule/capsule_common.py
+++ b/test/py/tests/test_efi_capsule/capsule_common.py
@@ -136,7 +136,7 @@ def do_reboot_dtb_specified(u_boot_config, u_boot_console, dtb_filename):
         u_boot_console -- A console connection to U-Boot.
         dtb_filename -- DTB file name.
     """
-    mnt_point = u_boot_config.persistent_data_dir + '/test_efi_capsule'
+    mnt_point = u_boot_config.persistent_data_dir + '/scratch'
     u_boot_console.config.dtb = mnt_point + CAPSULE_DATA_DIR \
                                 + f'/{dtb_filename}'
     u_boot_console.restart_uboot()
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index 61eab5112a17..7f8a3de46171 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -7,6 +7,7 @@
 import os
 
 from subprocess import call, check_call, CalledProcessError
+from tests import fs_helper
 import pytest
 from capsule_defs import CAPSULE_DATA_DIR, CAPSULE_INSTALL_DIR, EFITOOLS_PATH
 
@@ -21,12 +22,12 @@ def efi_capsule_data(request, u_boot_config):
     request -- Pytest request object.
     u_boot_config -- U-Boot configuration.
     """
-    mnt_point = u_boot_config.persistent_data_dir + '/test_efi_capsule'
-    data_dir = mnt_point + CAPSULE_DATA_DIR
-    install_dir = mnt_point + CAPSULE_INSTALL_DIR
-    image_path = u_boot_config.persistent_data_dir + '/test_efi_capsule.img'
-
     try:
+        image_path, mnt_point = fs_helper.setup_image(u_boot_config, 0, 0xc,
+                                                      basename='test_efi_capsule')
+        data_dir = mnt_point + CAPSULE_DATA_DIR
+        install_dir = mnt_point + CAPSULE_INSTALL_DIR
+
         # Create a target device
         check_call('dd if=/dev/zero of=./spi.bin bs=1MiB count=16', shell=True)
 
@@ -88,11 +89,15 @@ def efi_capsule_data(request, u_boot_config):
         check_call('cp %s/Test* %s' % (u_boot_config.build_dir, data_dir), shell=True)
         os.environ['PYTHONPATH'] = pythonpath
 
-        # Create a disk image with EFI system partition
-        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat %s %s' %
-                   (mnt_point, image_path), shell=True)
+        # Create a 16MiB partition as the EFI system partition in the disk
+        # image
+        fsfile = fs_helper.mk_fs(u_boot_config, 'vfat', 0x1000000,
+                                 'test_efi_capsule', mnt_point)
+        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
+        check_call('sgdisk --mbrtogpt %s' % image_path, shell=True)
         check_call('sgdisk %s -A 1:set:0 -t 1:C12A7328-F81F-11D2-BA4B-00A0C93EC93B' %
                    image_path, shell=True)
+        call('rm -f %s' % fsfile, shell=True)
 
     except CalledProcessError as exception:
         pytest.skip('Setup failed: %s' % exception.cmd)
-- 
2.43.0

