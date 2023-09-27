Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71284E7F150
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 01:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE9186BEF;
	Wed, 27 Sep 2023 03:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WeMilqHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBA986C13; Wed, 27 Sep 2023 03:06:22 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD3B86BE7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 03:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7741c2e76a3so528873185a.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 18:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695776779; x=1696381579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=guRxwu8RFT6QXZgGin12/JLjAOZS6pvbSo75uzYZZRs=;
 b=WeMilqHqdGULUQa+ucJk6BQmIdPrmPVSsuJffq086U78XbnBguRnhoReDzCO1yhzYO
 0QCU+z1x3ONhHs6YnHZ5eFStkGD6jKUjtX13+I1wVg3ilKYKM6553vNjbb0N+h6TOx7e
 qnLJKzitzKS+sm1jhuZdh6TsqKTXykvTA8VG1mBFod4qUN7dOgIBGgKtYZqHrY1L1SX/
 xjWz5Nhx7F7bz7AB4FYPn0xrRpVQzE6sd6AL1Xk909GGNU8MKviAWVPeCJ7ezzsdadqy
 2/23U0Tj5Fb9Ip7VQQgAWr+iJUt8YYiM2iSy84jEGnRGyRLycPz/FhWOcoJl9OI9hSTE
 pYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695776779; x=1696381579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=guRxwu8RFT6QXZgGin12/JLjAOZS6pvbSo75uzYZZRs=;
 b=enLXDWX7zolzVdCjnTwyQCoGM+ddypf7K7NjPdoqr0J2qai7uqo+yI/qNjIbYzkP+E
 ZuzWk+i0yhw2Ac48tVO5B2n4l+KlDjaFrXKI93+N4o1IbiH/gWC2bdhvhGu2S577AZF1
 EvdP57GpTdb+4jdxlbkjtryl1F735mgJ5pSfu+uoex7UxdqMtUsGNvNfaSqTZ6mbmB+P
 y+JotqwxaujPgx/UQrXuVv6sQvAwnjEkp5Yry/8MxpgnrA1uvFATR3/9BiWgFV/xAKx9
 exup1UDE0FIY6say2UA+Fu+EErdxzFmT2b1dZBnekx/SM6Lwmkeq6AQfxUq+1rcrIi++
 ZfXA==
X-Gm-Message-State: AOJu0Ywqlx7wJHb5ur1MLM99LA2Cp2xUn9+Rm7+bLdVGczkXN76OvMkP
 ik4C2R7h1fjdI1tsuF8GmhjBhtUfUHnD7RuGMXc=
X-Google-Smtp-Source: AGHT+IGUgOiNoD1/fgLWzmu4BhrrHrEZ+QugYU/zVctqWq0JGwoEzA6iCconanKVH4qMdRQHqOGsEg==
X-Received: by 2002:a05:620a:3184:b0:76d:a110:856d with SMTP id
 bi4-20020a05620a318400b0076da110856dmr664313qkb.0.1695776778675; 
 Tue, 26 Sep 2023 18:06:18 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 i6-20020aa787c6000000b0068a0b5df6b2sm10603117pfo.196.2023.09.26.18.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 18:06:07 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v12] Boot var automatic management for removable medias
Date: Wed, 27 Sep 2023 10:04:36 +0900
Message-Id: <20230927010436.1503621-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Raymond Mao <raymond.mao@linaro.org>

Changes for complying to EFI spec §3.5.1.1
'Removable Media Boot Behavior'.
Boot variables can be automatically generated during a removable
media is probed. At the same time, unused boot variables will be
detected and removed.

Please note that currently the function 'efi_disk_remove' has no
ability to distinguish below two scenarios
a) Unplugging of a removable media under U-Boot
b) U-Boot exiting and booting an OS
Thus currently the boot variables management is not added into
'efi_disk_remove' to avoid boot options being added/erased
repeatedly under scenario b) during power cycles
See TODO comments under function 'efi_disk_remove' for more details

The original efi_secboot tests expect that BootOrder EFI variable
is not defined. With this commit, the BootOrder EFI variable is
automatically added when the disk is detected. The original efi_secboot
tests end up with unexpected failure.
The efi_secboot tests need to be modified to clear the BootOrder
EFI variable at the beginning of each test.

Co-developed-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_disk.c                      | 18 ++++++++++++++++++
 lib/efi_loader/efi_setup.c                     |  7 +++++++
 test/py/tests/test_efi_secboot/test_signed.py  |  9 +++++++++
 .../test_efi_secboot/test_signed_intca.py      |  3 +++
 .../py/tests/test_efi_secboot/test_unsigned.py |  3 +++
 5 files changed, 40 insertions(+)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index f0d76113b0..b808a7fe62 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -690,6 +690,13 @@ int efi_disk_probe(void *ctx, struct event *event)
 			return -1;
 	}
 
+	/* only do the boot option management when UEFI sub-system is initialized */
+	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) && efi_obj_list_initialized == EFI_SUCCESS) {
+		ret = efi_bootmgr_update_media_device_boot_option();
+		if (ret != EFI_SUCCESS)
+			return -1;
+	}
+
 	return 0;
 }
 
@@ -742,6 +749,17 @@ int efi_disk_remove(void *ctx, struct event *event)
 	dev_tag_del(dev, DM_TAG_EFI);
 
 	return 0;
+
+	/*
+	 * TODO A flag to distinguish below 2 different scenarios of this
+	 * function call is needed:
+	 * a) Unplugging of a removable media under U-Boot
+	 * b) U-Boot exiting and booting an OS
+	 * In case of scenario a), efi_bootmgr_update_media_device_boot_option()
+	 * needs to be invoked here to update the boot options and remove the
+	 * unnecessary ones.
+	 */
+
 }
 
 /**
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 58d4e13402..69c8b27730 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -245,6 +245,13 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) {
+		/* update boot option after variable service initialized */
+		ret = efi_bootmgr_update_media_device_boot_option();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	/* Define supported languages */
 	ret = efi_init_platform_lang();
 	if (ret != EFI_SUCCESS)
diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tests/test_efi_secboot/test_signed.py
index ca52e853d8..b77b60e223 100644
--- a/test/py/tests/test_efi_secboot/test_signed.py
+++ b/test/py/tests/test_efi_secboot/test_signed.py
@@ -28,6 +28,7 @@ class TestEfiSignedImage(object):
             # Test Case 1a, run signed image if no PK
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld.efi.signed -s ""',
                 'efidebug boot next 1',
                 'bootefi bootmgr'])
@@ -52,6 +53,7 @@ class TestEfiSignedImage(object):
             # Test Case 2a, db is not yet installed
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 KEK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
                 'fatload host 0:1 4000000 PK.auth',
@@ -96,6 +98,7 @@ class TestEfiSignedImage(object):
             # Test Case 3a, rejected by dbx
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
                 'fatload host 0:1 4000000 KEK.auth',
@@ -132,6 +135,7 @@ class TestEfiSignedImage(object):
             # Test Case 4, rejected by dbx
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 dbx_hash.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
                 'fatload host 0:1 4000000 db.auth',
@@ -161,6 +165,7 @@ class TestEfiSignedImage(object):
             # is verified
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 KEK.auth',
@@ -217,6 +222,7 @@ class TestEfiSignedImage(object):
             # is verified. Same as before but reject dbx_hash1.auth only
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 KEK.auth',
@@ -294,6 +300,7 @@ class TestEfiSignedImage(object):
         with u_boot_console.log.section('Test Case 7a'):
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 KEK.auth',
@@ -317,6 +324,7 @@ class TestEfiSignedImage(object):
         with u_boot_console.log.section('Test Case 7b'):
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 db.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 KEK.auth',
@@ -348,6 +356,7 @@ class TestEfiSignedImage(object):
             # Test Case 8a, Secure boot is not yet forced
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld_forged.efi.signed -s ""',
                 'efidebug boot next 1',
                 'efidebug test bootmgr'])
diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py b/test/py/tests/test_efi_secboot/test_signed_intca.py
index d8d599d22f..318715fa08 100644
--- a/test/py/tests/test_efi_secboot/test_signed_intca.py
+++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
@@ -30,6 +30,7 @@ class TestEfiSignedImageIntca(object):
             # Test Case 1a, with no Int CA and not authenticated by root CA
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 db_c.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 KEK.auth',
@@ -63,6 +64,7 @@ class TestEfiSignedImageIntca(object):
             # Test Case 2a, unsigned and not authenticated by root CA
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 KEK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
                 'fatload host 0:1 4000000 PK.auth',
@@ -105,6 +107,7 @@ class TestEfiSignedImageIntca(object):
             # Test Case 3a, revoked by int CA in dbx
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 dbx_b.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
                 'fatload host 0:1 4000000 db_c.auth',
diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py b/test/py/tests/test_efi_secboot/test_unsigned.py
index df63f0df08..9042a46ccc 100644
--- a/test/py/tests/test_efi_secboot/test_unsigned.py
+++ b/test/py/tests/test_efi_secboot/test_unsigned.py
@@ -28,6 +28,7 @@ class TestEfiUnsignedImage(object):
             # Test Case 1
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 KEK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
                 'fatload host 0:1 4000000 PK.auth',
@@ -55,6 +56,7 @@ class TestEfiUnsignedImage(object):
             # Test Case 2
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 db_hello.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 KEK.auth',
@@ -79,6 +81,7 @@ class TestEfiUnsignedImage(object):
             # Test Case 3a, rejected by dbx
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
+                'setenv -e -nv -bs -rt BootOrder',
                 'fatload host 0:1 4000000 db_hello.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
                 'fatload host 0:1 4000000 KEK.auth',
-- 
2.34.1

