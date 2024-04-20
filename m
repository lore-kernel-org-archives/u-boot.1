Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D648BC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 14:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88398820B;
	Sat, 20 Apr 2024 16:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HCrtGnnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7267880F4; Sat, 20 Apr 2024 16:01:11 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE075880F9
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 16:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1E00B3F200; 
 Sat, 20 Apr 2024 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713621667;
 bh=gjhMPQOdGaEFxcmSVli3eqfn5v2yBOwHvsAh4xbvY/M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HCrtGnnIu5g4Fso2UdhrNIN5vcEK3cEj4TOyrjLaYUehhZMTcF07f5XteintSRozE
 FeAhIj3ibdFet7NZZeuujJg/0rjO8i0U2b37Zc3UGVjz8v/KjPmjQhTQHD1oUVHqKE
 ncMUuOBTOwlWW9I3Pt915c+mhpetXCMZ4mT1FqkqyzSgQD5kVV8s2TBGbpAOmWGACb
 yB+JxwVsKsY2ijPDquqNxq6QxFUl2xS/26Yz/XsPyF33SRBKbtqHFT4KkLlMLjqLmT
 LJlOJ8hXxARTZkq7BLIPLVv1pgsqLjOeVAChTVCWEbsOwSlCvBFOJfp6xlDgD9ECPm
 czmHNk8cP75iw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: improve error handling in try_load_entry()
Date: Sat, 20 Apr 2024 16:00:58 +0200
Message-ID: <20240420140058.120695-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

If a load option is not active, we use a random value from the stack to
allocate memory for the optional data of the load option.

* Unload the image if a security violation occurs.
* Free load_options if efi_set_load_options() fails.
* Unload the image if efi_set_load_options() fails.
* Do not allocate load_options with a random size from the stack
  if the boot entry is not active.

Fixes: 53f6a5aa8626 ("efi_loader: Replace config option for initrd loading")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_bootmgr.c                  | 97 +++++++++----------
 test/py/tests/test_efi_secboot/test_signed.py | 28 +++---
 .../test_efi_secboot/test_signed_intca.py     | 10 +-
 .../tests/test_efi_secboot/test_unsigned.py   |  6 +-
 4 files changed, 70 insertions(+), 71 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 4ac519228a6..ca2ebdaa32f 100644
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

