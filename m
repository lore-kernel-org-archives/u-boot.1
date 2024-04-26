Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D634C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5F1788F19;
	Fri, 26 Apr 2024 16:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sXpyHPy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967BF885AE; Fri, 26 Apr 2024 16:14:03 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F080E88699
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 335E13FE70
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140835;
 bh=ApmwgEGRp91HC6dBUQVBOxak2BTxmBrUDqBXeIQI3Gg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sXpyHPy9nrUUdFVC4JFieQbRQ2hkysZ0VqgPl99XGDE9nnJQANj3TCAnFcsAa35t5
 3YRbnMQR6hx7HKeE2h7xK6APDdFFtkFPrkbp2ws+Zb7vjP96px8W6hErSfTo5AqVIu
 uqMMMa+AWtU98+yBGuICP1FaiT/fFAQKhItCgC2gSD+ixBfU9ODVz7M7hr8aWEUETU
 DNFnrpW+KxegYMIDYuaCKDETadHcrId1mwxAKfrlUqb1ZtvPMrUyvHS3xvVY3t2jEI
 OzUFbydDnGvYp9oRyJTA52/4jSQIJAfdOwtvqJFoDFsNJOaQPQkfUHTaX1sbySY/9Q
 xwD5EOoRdI6cQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34a4ded7d49so2002046f8f.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140834; x=1714745634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ApmwgEGRp91HC6dBUQVBOxak2BTxmBrUDqBXeIQI3Gg=;
 b=OSgQ7ZACKng4TIh/qyLIcaSMtvjqvSVtnW2Cu41sovXRrWWAb1egODmKHq7naEns1W
 0xKAI2rDfK47APmlRPHtTGXXTxENL2dCSGF0W3pzXZQXv626+ahHM+QVJXZNEgqzIlqA
 rs0jtIJw1wyMOINpQu0aHBRay3knygJ72afnzbx2StillTsIlCFB/UihTAmaTpurWiyx
 84PxKy4V9qjMy4bd9uiQsUaudKlFXJu6pb9RBQL7rjrWxjPhWHcMINs5RePgzFrWAVxF
 E0CU4XBOzXXJ1r2s7rM1LYoru/fgFAiYmJ8V/Tenyoi1wledsE9fmOOLMqCFhJtpE2es
 bdQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC3DIIiK+mlaX0aufUJBSS/LmD+NEh4G1OqLz6ZK0nlvF6uAICalVU79lxzFw8oEICb40HMmDEXerD4z/J1am3Apingg==
X-Gm-Message-State: AOJu0Yy0G6A9n6aRCgaYX/iXX9pIuK4SsiRzSX5yoMXHEZUh+QVgR2Hd
 yQqThnEM9KSMMta+ej/7dsu9496jYUsWMbHQHFbV8tuWDHhVEzsKNJq8FOIu4tA4uDjlMdX0KDW
 IPD6z146GJwrfacpMkvmaCv1HkBrMBwPO4FDHG4ZYw1qjqysKMwmQOzFyFEJJEx7cExk=
X-Received: by 2002:a5d:4382:0:b0:346:dace:5310 with SMTP id
 i2-20020a5d4382000000b00346dace5310mr1847902wrq.22.1714140834347; 
 Fri, 26 Apr 2024 07:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBBffGQKyFscUykaRh2UI774rY1U4lz2RTrVJMYPrths2oCjxwTNXuyHgdNqeZZeK3YtbD9g==
X-Received: by 2002:a5d:4382:0:b0:346:dace:5310 with SMTP id
 i2-20020a5d4382000000b00346dace5310mr1847885wrq.22.1714140833867; 
 Fri, 26 Apr 2024 07:13:53 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:53 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 08/14] efi_loader: improve error handling in try_load_entry()
Date: Fri, 26 Apr 2024 16:13:15 +0200
Message-ID: <20240426141321.232236-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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

The image is not unloaded if a security violation occurs.

If efi_set_load_options() fails, we do not free the memory allocated for
the optional data. We do not unload the image.

* Unload the image if a security violation occurs.
* Free load_options if efi_set_load_options() fails.
* Unload the image if efi_set_load_options() fails.

Fixes: 53f6a5aa8626 ("efi_loader: Replace config option for initrd loading")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c                  | 97 +++++++++----------
 test/py/tests/test_efi_secboot/test_signed.py | 28 +++---
 .../test_efi_secboot/test_signed_intca.py     | 10 +-
 .../tests/test_efi_secboot/test_unsigned.py   |  6 +-
 4 files changed, 70 insertions(+), 71 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index db394df6bf4..c64cbe82402 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -613,9 +613,12 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 	void *load_option;
 	efi_uintn_t size;
 	efi_status_t ret;
+	u32 attributes;
 
-	efi_create_indexed_name(varname, sizeof(varname), "Boot", n);
+	*handle = NULL;
+	*load_options = NULL;
 
+	efi_create_indexed_name(varname, sizeof(varname), "Boot", n);
 	load_option = efi_get_var(varname, &efi_global_variable_guid, &size);
 	if (!load_option)
 		return EFI_LOAD_ERROR;
@@ -626,55 +629,54 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 		goto error;
 	}
 
-	if (lo.attributes & LOAD_OPTION_ACTIVE) {
-		u32 attributes;
-
-		log_debug("trying to load \"%ls\" from %pD\n", lo.label,
-			  lo.file_path);
-
-		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
-			/* file_path doesn't contain a device path */
-			ret = try_load_from_short_path(lo.file_path, handle);
-		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
-			if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
-				ret = try_load_from_uri_path(
-					(struct efi_device_path_uri *)lo.file_path,
-					lo.label, handle);
-			else
-				ret = EFI_LOAD_ERROR;
-		} else {
-			ret = try_load_from_media(lo.file_path, handle);
-		}
-		if (ret != EFI_SUCCESS) {
-			log_warning("Loading %ls '%ls' failed\n",
-				    varname, lo.label);
-			goto error;
-		}
+	if (!(lo.attributes & LOAD_OPTION_ACTIVE)) {
+		ret = EFI_LOAD_ERROR;
+		goto error;
+	}
 
-		attributes = EFI_VARIABLE_BOOTSERVICE_ACCESS |
-			     EFI_VARIABLE_RUNTIME_ACCESS;
-		ret = efi_set_variable_int(u"BootCurrent",
-					   &efi_global_variable_guid,
-					   attributes, sizeof(n), &n, false);
-		if (ret != EFI_SUCCESS)
-			goto unload;
-		/* try to register load file2 for initrd's */
-		if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
-			ret = efi_initrd_register();
-			if (ret != EFI_SUCCESS)
-				goto unload;
-		}
+	log_debug("trying to load \"%ls\" from %pD\n", lo.label, lo.file_path);
 
-		log_info("Booting: %ls\n", lo.label);
+	if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
+		/* file_path doesn't contain a device path */
+		ret = try_load_from_short_path(lo.file_path, handle);
+	} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
+		if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
+			ret = try_load_from_uri_path(
+				(struct efi_device_path_uri *)lo.file_path,
+				lo.label, handle);
+		else
+			ret = EFI_LOAD_ERROR;
 	} else {
-		ret = EFI_LOAD_ERROR;
+		ret = try_load_from_media(lo.file_path, handle);
+	}
+	if (ret != EFI_SUCCESS) {
+		log_warning("Loading %ls '%ls' failed\n",
+			    varname, lo.label);
+		goto error;
+	}
+
+	attributes = EFI_VARIABLE_BOOTSERVICE_ACCESS |
+		     EFI_VARIABLE_RUNTIME_ACCESS;
+	ret = efi_set_variable_int(u"BootCurrent", &efi_global_variable_guid,
+				   attributes, sizeof(n), &n, false);
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	/* try to register load file2 for initrd's */
+	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
+		ret = efi_initrd_register();
+		if (ret != EFI_SUCCESS)
+			goto error;
 	}
 
-	/* Set load options */
+	log_info("Booting: %ls\n", lo.label);
+
+	/* Ignore the optional data in auto-generated boot options */
 	if (size >= sizeof(efi_guid_t) &&
 	    !guidcmp(lo.optional_data, &efi_guid_bootmenu_auto_generated))
 		size = 0;
 
+	/* Set optional data in loaded file protocol */
 	if (size) {
 		*load_options = malloc(size);
 		if (!*load_options) {
@@ -683,18 +685,15 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 		}
 		memcpy(*load_options, lo.optional_data, size);
 		ret = efi_set_load_options(*handle, size, *load_options);
-	} else {
-		*load_options = NULL;
+		if (ret != EFI_SUCCESS)
+			free(load_options);
 	}
 
 error:
-	free(load_option);
-
-	return ret;
-
-unload:
-	if (EFI_CALL(efi_unload_image(*handle)) != EFI_SUCCESS)
+	if (ret != EFI_SUCCESS && *handle &&
+	    EFI_CALL(efi_unload_image(*handle)) != EFI_SUCCESS)
 		log_err("Unloading image failed\n");
+
 	free(load_option);
 
 	return ret;
diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tests/test_efi_secboot/test_signed.py
index 2f862a259ad..5000a4ab7b6 100644
--- a/test/py/tests/test_efi_secboot/test_signed.py
+++ b/test/py/tests/test_efi_secboot/test_signed.py
@@ -62,13 +62,13 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert('\'HELLO1\' failed' in ''.join(output))
-            assert('efi_start_image() returned: 26' in ''.join(output))
+            assert('efi_bootmgr_load() returned: 26' in ''.join(output))
             output = u_boot_console.run_command_list([
                 'efidebug boot add -b 2 HELLO2 host 0:1 /helloworld.efi -s ""',
                 'efidebug boot order 2',
                 'efidebug test bootmgr'])
             assert '\'HELLO2\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         with u_boot_console.log.section('Test Case 2b'):
             # Test Case 2b, authenticated by db
@@ -80,7 +80,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 2',
                 'efidebug test bootmgr'])
             assert '\'HELLO2\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
             output = u_boot_console.run_command_list([
                 'efidebug boot order 1',
                 'bootefi bootmgr'])
@@ -108,7 +108,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         with u_boot_console.log.section('Test Case 3b'):
             # Test Case 3b, rejected by dbx even if db allows
@@ -120,7 +120,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
     def test_efi_signed_image_auth4(self, u_boot_console, efi_boot_env):
         """
@@ -146,7 +146,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
     def test_efi_signed_image_auth5(self, u_boot_console, efi_boot_env):
         """
@@ -196,7 +196,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         with u_boot_console.log.section('Test Case 5d'):
             # Test Case 5d, rejected if both of signatures are revoked
@@ -208,7 +208,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         # Try rejection in reverse order.
         u_boot_console.restart_uboot()
@@ -233,7 +233,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
     def test_efi_signed_image_auth6(self, u_boot_console, efi_boot_env):
         """
@@ -268,7 +268,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         with u_boot_console.log.section('Test Case 6c'):
             # Test Case 6c, rejected by image's digest in dbx
@@ -282,7 +282,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
     def test_efi_signed_image_auth7(self, u_boot_console, efi_boot_env):
         """
@@ -310,7 +310,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         # sha512 of an x509 cert in dbx
         u_boot_console.restart_uboot()
@@ -333,7 +333,7 @@ class TestEfiSignedImage(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
     def test_efi_signed_image_auth8(self, u_boot_console, efi_boot_env):
         """
@@ -368,4 +368,4 @@ class TestEfiSignedImage(object):
                 'efidebug test bootmgr'])
             assert(not 'hELLO, world!' in ''.join(output))
             assert('\'HELLO1\' failed' in ''.join(output))
-            assert('efi_start_image() returned: 26' in ''.join(output))
+            assert('efi_bootmgr_load() returned: 26' in ''.join(output))
diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py b/test/py/tests/test_efi_secboot/test_signed_intca.py
index 8d9a5f3e7fe..cf906205bc2 100644
--- a/test/py/tests/test_efi_secboot/test_signed_intca.py
+++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
@@ -43,7 +43,7 @@ class TestEfiSignedImageIntca(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_a\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         with u_boot_console.log.section('Test Case 1b'):
             # Test Case 1b, signed and authenticated by root CA
@@ -74,7 +74,7 @@ class TestEfiSignedImageIntca(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         with u_boot_console.log.section('Test Case 2b'):
             # Test Case 2b, signed and authenticated by root CA
@@ -84,7 +84,7 @@ class TestEfiSignedImageIntca(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         with u_boot_console.log.section('Test Case 2c'):
             # Test Case 2c, signed and authenticated by root CA
@@ -122,7 +122,7 @@ class TestEfiSignedImageIntca(object):
             assert 'Hello, world!' in ''.join(output)
             # Or,
             # assert '\'HELLO_abc\' failed' in ''.join(output)
-            # assert 'efi_start_image() returned: 26' in ''.join(output)
+            # assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
 
         with u_boot_console.log.section('Test Case 3b'):
             # Test Case 3b, revoked by root CA in dbx
@@ -132,4 +132,4 @@ class TestEfiSignedImageIntca(object):
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py b/test/py/tests/test_efi_secboot/test_unsigned.py
index 7c078f220d0..b4320ae4054 100644
--- a/test/py/tests/test_efi_secboot/test_unsigned.py
+++ b/test/py/tests/test_efi_secboot/test_unsigned.py
@@ -42,7 +42,7 @@ class TestEfiUnsignedImage(object):
             output = u_boot_console.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
 
     def test_efi_unsigned_image_auth2(self, u_boot_console, efi_boot_env):
@@ -95,7 +95,7 @@ class TestEfiUnsignedImage(object):
             output = u_boot_console.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
 
         with u_boot_console.log.section('Test Case 3b'):
@@ -113,5 +113,5 @@ class TestEfiUnsignedImage(object):
             output = u_boot_console.run_command_list([
                 'efidebug boot order 1',
                 'efidebug test bootmgr'])
-            assert 'efi_start_image() returned: 26' in ''.join(output)
+            assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
-- 
2.43.0

