Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6375DC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 04:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C150877A0;
	Fri, 10 Nov 2023 05:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="muA1rcXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA4487796; Fri, 10 Nov 2023 05:27:28 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1AE487795
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 05:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-66d09b6d007so10800236d6.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 20:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699590441; x=1700195241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMp02tF2/jn50c0fdB6OUXNmWJ9Af2C5T6zhn2D5BPI=;
 b=muA1rcXEW1UV0ytByrk/oz/vuO7kL/M5Szuv8+JLohfHHFY3sZW5v5q4Tn1coMbMKW
 6+JvY0qla9DiPjvWA90QSopUCqBoggSNPTIlTn4YSs0zA/+Aa9ufsx25M+rq4pdYGAZq
 ujAG9mRgWMuq7W+eZZWfQo6eFqEo14D6RbQL5NFW/G0Wkle6TwLwu7dp19DOw7hH/jPq
 sq9/5/DA4FEI+4sRDsPBAQ48VTq05vuMv2PMU0t4d7SXPVCEk1lW+JFZB4wooN2XotQ+
 ni+S40bdTeGBscZ+sajQQgtDd49nxGSB518samtlg5SGdhDB9WKak39uPeWU4WFYc01J
 R7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699590441; x=1700195241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMp02tF2/jn50c0fdB6OUXNmWJ9Af2C5T6zhn2D5BPI=;
 b=o5TY9c0iL/aKbWJtamq+fAKn5twYwIcXo5Z8lxIo1/WL8jhCu3973LiJ6l2rbP6I26
 wEUpA97eZRYjRnp6Pfb9nJ5+Ip11akGFqY+UNFjwNues+jYvCmrhtbzt3RIwwRMopasI
 IvpvSU+Vk0opNS2b96ZRak7X34ZoUNZVcjTBCSqx3UgQcaMOxrP5u7LholG/3rTttkkF
 gdIAWrm7wPUrREhnt8opfpTWbusAkgJ1lAa0uqcfb4TRE7fKsiX3du3TwgJNsvACBXxW
 W4w5nDy5AXlY05IOsmMvxjIudLF0aDB3y/aUT1K7/NyAO77e5CPoGEIRF4JnpngLM7yx
 RcEw==
X-Gm-Message-State: AOJu0YwKFnJ+XRzaRWdr9TK+didg99ZRC2gUKVvYvCLFFGqfG4yFbCXC
 IsubnJ6RTNtZqmONUFojqVLmrQYm513MFxxhCLg=
X-Google-Smtp-Source: AGHT+IE/39rKwHRMrxLkfDXIlyOXct/rRbXebKb2Lc3eaLeJaCt4Vmnxn7CrXnlXXLzUgocEmJUKcA==
X-Received: by 2002:a05:6214:d44:b0:675:667d:a1b6 with SMTP id
 4-20020a0562140d4400b00675667da1b6mr7212832qvr.0.1699590440388; 
 Thu, 09 Nov 2023 20:27:20 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 n18-20020a170902e55200b001c0bf60ba5csm4304818plf.272.2023.11.09.20.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 20:27:19 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Huang Jianan <jnhuang95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-erofs@lists.ozlabs.org
Subject: [PATCH v12 4/9] efi_loader: Boot var automatic management
Date: Fri, 10 Nov 2023 13:25:37 +0900
Message-Id: <20231110042542.3797301-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
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
automatically added when the disk is detected. The original
efi_secboot tests end up with unexpected failure.
The efi_secboot tests need to be modified to explicitly set
the BootOrder EFI variable.

squashfs and erofs ls tests are also affected by this modification,
need to clear the previous state before squashfs ls test starts.

Co-developed-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 lib/efi_loader/efi_disk.c                     | 18 ++++++++
 lib/efi_loader/efi_setup.c                    |  7 ++++
 test/py/tests/test_efi_secboot/test_signed.py | 42 +++++++++----------
 .../test_efi_secboot/test_signed_intca.py     | 14 +++----
 .../tests/test_efi_secboot/test_unsigned.py   | 14 +++----
 test/py/tests/test_fs/test_erofs.py           |  9 ++++
 .../test_fs/test_squashfs/test_sqfs_ls.py     |  9 ++++
 7 files changed, 78 insertions(+), 35 deletions(-)

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
index ad719afd63..c02569cb6d 100644
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
index ca52e853d8..2f862a259a 100644
--- a/test/py/tests/test_efi_secboot/test_signed.py
+++ b/test/py/tests/test_efi_secboot/test_signed.py
@@ -29,7 +29,7 @@ class TestEfiSignedImage(object):
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -37,7 +37,7 @@ class TestEfiSignedImage(object):
             # Test Case 1b, run unsigned image if no PK
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 2',
+                'efidebug boot order 2',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -59,13 +59,13 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert('\'HELLO1\' failed' in ''.join(output))
             assert('efi_start_image() returned: 26' in ''.join(output))
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 2',
+                'efidebug boot order 2',
                 'efidebug test bootmgr'])
             assert '\'HELLO2\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -77,12 +77,12 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 2',
+                'efidebug boot order 2',
                 'efidebug test bootmgr'])
             assert '\'HELLO2\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -105,7 +105,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -117,7 +117,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -143,7 +143,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -170,7 +170,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -181,7 +181,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -193,7 +193,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -205,7 +205,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -230,7 +230,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -254,7 +254,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -265,7 +265,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -279,7 +279,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -307,7 +307,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -330,7 +330,7 @@ class TestEfiSignedImage(object):
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed_2sigs -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -349,7 +349,7 @@ class TestEfiSignedImage(object):
             output = u_boot_console.run_command_list([
                 'host bind 0 %s' % disk_img,
                 'efidebug boot add -b 1 HELLO1 host 0:1 /helloworld_forged.efi.signed -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert('hELLO, world!' in ''.join(output))
 
@@ -364,7 +364,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert(not 'hELLO, world!' in ''.join(output))
             assert('\'HELLO1\' failed' in ''.join(output))
diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py b/test/py/tests/test_efi_secboot/test_signed_intca.py
index d8d599d22f..8d9a5f3e7f 100644
--- a/test/py/tests/test_efi_secboot/test_signed_intca.py
+++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
@@ -40,7 +40,7 @@ class TestEfiSignedImageIntca(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO_a host 0:1 /helloworld.efi.signed_a -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_a\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -49,7 +49,7 @@ class TestEfiSignedImageIntca(object):
             # Test Case 1b, signed and authenticated by root CA
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 2 HELLO_ab host 0:1 /helloworld.efi.signed_ab -s ""',
-                'efidebug boot next 2',
+                'efidebug boot order 2',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -71,7 +71,7 @@ class TestEfiSignedImageIntca(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO_abc host 0:1 /helloworld.efi.signed_abc -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -81,7 +81,7 @@ class TestEfiSignedImageIntca(object):
             output = u_boot_console.run_command_list([
                 'fatload host 0:1 4000000 db_b.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
@@ -91,7 +91,7 @@ class TestEfiSignedImageIntca(object):
             output = u_boot_console.run_command_list([
                 'fatload host 0:1 4000000 db_c.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -117,7 +117,7 @@ class TestEfiSignedImageIntca(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO_abc host 0:1 /helloworld.efi.signed_abc -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'Hello, world!' in ''.join(output)
             # Or,
@@ -129,7 +129,7 @@ class TestEfiSignedImageIntca(object):
             output = u_boot_console.run_command_list([
                 'fatload host 0:1 4000000 dbx_c.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
             assert 'efi_start_image() returned: 26' in ''.join(output)
diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py b/test/py/tests/test_efi_secboot/test_unsigned.py
index df63f0df08..7c078f220d 100644
--- a/test/py/tests/test_efi_secboot/test_unsigned.py
+++ b/test/py/tests/test_efi_secboot/test_unsigned.py
@@ -36,11 +36,11 @@ class TestEfiUnsignedImage(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'efi_start_image() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
@@ -65,7 +65,7 @@ class TestEfiUnsignedImage(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert 'Hello, world!' in ''.join(output)
 
@@ -89,11 +89,11 @@ class TestEfiUnsignedImage(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'efi_start_image() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
@@ -107,11 +107,11 @@ class TestEfiUnsignedImage(object):
 
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'bootefi bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
             output = u_boot_console.run_command_list([
-                'efidebug boot next 1',
+                'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert 'efi_start_image() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
index 458a52ba79..87ad8f2d5f 100644
--- a/test/py/tests/test_fs/test_erofs.py
+++ b/test/py/tests/test_fs/test_erofs.py
@@ -196,6 +196,15 @@ def test_erofs(u_boot_console):
     """
     build_dir = u_boot_console.config.build_dir
 
+    # If the EFI subsystem is enabled and initialized, EFI subsystem tries to
+    # add EFI boot option when the new disk is detected. If there is no EFI
+    # System Partition exists, EFI subsystem outputs error messages and
+    # it ends up with test failure.
+    # Restart U-Boot to clear the previous state.
+    # TODO: Ideally EFI test cases need to be fixed, but it will
+    # increase the number of system reset.
+    u_boot_console.restart_uboot()
+
     try:
         # setup test environment
         make_erofs_image(build_dir)
diff --git a/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py b/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
index 527a556ed8..a20a7d1a66 100644
--- a/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
+++ b/test/py/tests/test_fs/test_squashfs/test_sqfs_ls.py
@@ -118,6 +118,15 @@ def test_sqfs_ls(u_boot_console):
     """
     build_dir = u_boot_console.config.build_dir
 
+    # If the EFI subsystem is enabled and initialized, EFI subsystem tries to
+    # add EFI boot option when the new disk is detected. If there is no EFI
+    # System Partition exists, EFI subsystem outputs error messages and
+    # it ends up with test failure.
+    # Restart U-Boot to clear the previous state.
+    # TODO: Ideally EFI test cases need to be fixed, but it will
+    # increase the number of system reset.
+    u_boot_console.restart_uboot()
+
     # setup test environment
     check_mksquashfs_version()
     generate_sqfs_src_dir(build_dir)
-- 
2.34.1

