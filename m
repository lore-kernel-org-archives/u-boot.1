Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30708C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4AA88346;
	Mon, 22 Apr 2024 10:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lr4LExk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55451883D4; Mon, 22 Apr 2024 10:41:11 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03D3188346
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 07C743FB77
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713775268;
 bh=37qAUiPr5E9tKyah8XtmfzPEASK4qnS49nZu2BkhCFo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lr4LExk9C4R5RUdhERe4+Pa5mlISuKCq9KZwm0SEdCPpL58gLKRIxKns+5ZDxpgWF
 4OlwfKa+OFYHPZRDwHvGFYR26/Y8nQQexxjDa8lnkRHqdJcgCxznSZJvwdG3KaNnzD
 oLK9MLDEVcXUN7lY1/tduDtbMVMpFqMXfExR/7i4GWrf6KGpneMyKPQkSr2EoImBM0
 bOiMT/N1h+QQGITUV1kWj0DYeyKff1aYYBE+KEc5Rrdkbt/HhTR5/C2O+XSUpyk5Xl
 YUO/VTt5Qtyj+0quy6cnUS3uHSnpyCL/AbV477qfOOqFsQ5I9va1pUBvO3vEusheQW
 CzLS9+cGya1Sg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-417bf71efb4so20136795e9.0
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 01:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713775267; x=1714380067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=37qAUiPr5E9tKyah8XtmfzPEASK4qnS49nZu2BkhCFo=;
 b=EDLdpW1x7ySc6vbSHiBicubEQMrsml2bYI14b+frc4cY1t+z29DKfFP9ImG9b9i74V
 rshkki19t56NMYcc9jPOT2cuQQPunU7ECCoCsl2zFiFefYRoijR2N5kqoHiFINY4fdP8
 OtYed/v80ABs4C8NZddVk+AJWfKhY8SeXb699n4egZcXweexCyvje+K7MosUEvcyTj6U
 /a5JuHYXsReRZudQA5h/kmbFG6KvLcMGnfU47EASFYW1f0f0euTnoNTVywJv6edH1TZm
 WKiAte5YK8aBVSZRcET9oKJQau8NOUbB28ucz+S08YnvYGyq1DW067q9s/A4g02q+eXR
 x9XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYgfLb6WI+hUG5H4ZHVdbAUtqxcjRNfGI9TmB93itQrwr+9wz08OdKAMaSH1EkZ0otrSv0y/6zHIdp1i211P0bnEhjjg==
X-Gm-Message-State: AOJu0Yx+MHwGyUMXR/6ex8/PWcRV+qOFJgTVfbwawWNYPrNpGp+4e92l
 gvLpSbuooE9KzxYtgRa/0JkM9RrhtS03Cy4cZQlUh0W7EyUgHXhI+Y0lASCGHtsn16ssnOvf/Mv
 7SFmhsF/g/rBTkYNkEad5Jrn6rV3beXo83QwPuuHqDur27a/OIjmIz+ZEHW/Q/Ghjuks=
X-Received: by 2002:a05:600c:190c:b0:418:2981:c70f with SMTP id
 j12-20020a05600c190c00b004182981c70fmr9089828wmq.19.1713775267514; 
 Mon, 22 Apr 2024 01:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjORi/zOqnU8hDS3iQnCaChqHcF5mSu7N+8YXc7KGqZZNcIWYQhwMPDvkYukSfA+wOe+R/yQ==
X-Received: by 2002:a05:600c:190c:b0:418:2981:c70f with SMTP id
 j12-20020a05600c190c00b004182981c70fmr9089802wmq.19.1713775266988; 
 Mon, 22 Apr 2024 01:41:06 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c468600b00418accde252sm15935340wmo.30.2024.04.22.01.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 01:41:06 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_loader: improve error handling in try_load_entry()
Date: Mon, 22 Apr 2024 10:41:00 +0200
Message-ID: <20240422084100.80755-1-heinrich.schuchardt@canonical.com>
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

* Unload the image if a security violation occurs.
* Free load_options if efi_set_load_options() fails.
* Unload the image if efi_set_load_options() fails.

Fixes: 53f6a5aa8626 ("efi_loader: Replace config option for initrd loading")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v2:
	remove incorrect statement about uninitialized 'size' from commit
	message
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

