Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0DCCE79AC
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 09:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4EE86AC7;
	Wed, 20 Sep 2023 11:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O/QiuwvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E51D86AD8; Wed, 20 Sep 2023 11:18:46 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D809486AC0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 11:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d8164e661abso6540477276.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695201522; x=1695806322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i3Rjr6eWpJ9cWl1oe+GpFQ2KXRHDPVF86KThRuYwipc=;
 b=O/QiuwvEOQuayANPwTsOBl6DnJO51Brk2px+hwo4NYGXq5tyZtcF5Bw8AAQgMVRslq
 bRoPl7VI6ag29FDGhRLmL4/zSvlLUbt6SI1eC1F8Xu6rPsfg9TEe/HmhbpJpPGyDEqA4
 szUieFNjbf7Aq27x193PD7H+Uv/IxJ3lBsVNculIywGBlUpIsJkJTwR/B0PkOXoPtdD5
 SAEtb6TbYcwhN8bQyKwUjzEOJIagr64GSDvzEa1WvaPt9cj6lZn6PWOG1y+O79B82Vlh
 rzdyxyKGYeccuHbLbIvPuCqbaUxrY7aZyR6PEdFwp9i7lgkNB+weGR4cgPfEWvbpWmpz
 o1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695201522; x=1695806322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i3Rjr6eWpJ9cWl1oe+GpFQ2KXRHDPVF86KThRuYwipc=;
 b=wP+BTCYFkOm1T0AaHT4df0OI6rcCejupy+Cexl2Tn7nz233Qp/jLgN/PqxrxzHZWEb
 xdDrRPSOG8/vdPfq29+fFNChEyC2K0U19pRFSMHTjJ+d3YjwoRj6LVYnie/s6M7LioyX
 eYNi7HJEZhTaJjuwJ6pV5M+e7OiT33vpc7anEBe7mkxSIZZ8rMXzf2zQGuk1PcqJt2Yq
 /3kBihOzUe3bxfjIMiHMoYb3PFcwUVk8tKvFcvNYAxWMSanDaNT9KXNyTtJBfB6lojq3
 tnOy+dvdmy/1PsWAiyyQsiXVKk1bKwt6O1H9LH7sf0r9OBm3lajvFaGut1HTmVE5kzr2
 7BHw==
X-Gm-Message-State: AOJu0YzPuhyWOHasu4qn7eeWYAgl6Mf1OoWHnhlT58t54QQcF/CbH4Oc
 HHkoCtwlgjprCf/K1x7miBivrxmjUbdLBuI/2hA=
X-Google-Smtp-Source: AGHT+IG8JSvsyd4fys/2iy/U5vdasgLyJxrzrZvQfFjyNvvMqNasvQtFzXOrqWGOFFlGjOuU0CnmcA==
X-Received: by 2002:a05:6a00:2d9d:b0:690:41a1:9b64 with SMTP id
 fb29-20020a056a002d9d00b0069041a19b64mr2193129pfb.1.1695199309741; 
 Wed, 20 Sep 2023 01:41:49 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 k2-20020aa790c2000000b006875df4773fsm9783655pfk.163.2023.09.20.01.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 01:41:48 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v11] Boot var automatic management for removable medias
Date: Wed, 20 Sep 2023 17:41:21 +0900
Message-Id: <20230920084121.1248590-1-masahisa.kojima@linaro.org>
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

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

base-commit: 8bd7d08407f986fe3c69f3e198f6f7152e12dea8
-- 
2.34.1

