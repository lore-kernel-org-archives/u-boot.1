Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687A5C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 11:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9428D8839E;
	Wed,  8 May 2024 13:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cGChvKqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D461B8833D; Wed,  8 May 2024 13:13:38 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A493A88393
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 13:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso2711775a12.3
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715166813; x=1715771613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fRgx+ch51ooSMib5AFwxGtixAuDzOIEJxTLz1LjN/KM=;
 b=cGChvKqtdQJKH6ICC2Bi71ey3RdIyU7VFkf6rPZ29OVYJGA18wAkw/PUHC65bP9qks
 8zGO8B7c5BVu6mRGLEnaZWj/3+uhAOdkeu+HWiqZ04OPU7mOiK/UsQjb0HgcZ8QNeDFm
 wNLyJrQ0YQ8F188DL/KCFv1sDM5VNhqtbuY46qbDOFtWs718kRWQJG7jBhDhTGThQFRA
 4jmYd+Gx+PeGjjJTcBCMyJ2aP9LlPWVvfCNldoFLfZRKQUYtq7wkWhKbF1MmSg7tZBdL
 o+I6rProz8TSARCk8MmhmZeSXxB/rEFPLsJ99G2eUBIjvq3cMMWS9Vyd3Q+OUMKuq1MX
 efug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715166813; x=1715771613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fRgx+ch51ooSMib5AFwxGtixAuDzOIEJxTLz1LjN/KM=;
 b=IKKl43RSAJOPRUDgLdmJnLkr65bKs4vAE6lzQYtDAQ4GdpuqTOcB26uw1jMguFFQVI
 i2aKOrDIuvNu/LTvQO1zlS642rqdLRRLQ+eznlh8ALKjyx5SBXhtHxFCu3LQG0emYrcE
 GSJR+KZgKhwanL9BMauwBLkzvP1kPiNVApGxazruu8M94Dsj0jxHaj789Qz6FMzOO/A2
 wmStyFq9q1SteCuQYg3rHWHro/qASZ84Sqd47W0Vs0BmQkzru937xW1mn1nAXm6uTk+L
 WUwn1MLDz8jCUWBmZlzOyEldF9vOiKB+ZF2LyJIszKj29DgaqJT5Fu7tUAUv86IcRDeW
 dNmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOstsG1kysoAMUeZSxy0Xvx8Q0qTWyE6FRmHeqo9K21/rJ1G2VIzSb4YMDfMl5WFxmj7nO9eaoEwrFIII8TVMa/37v9A==
X-Gm-Message-State: AOJu0YzehhNDccCyRpp8TkBu57/HqaRz4qbDqGbxUuxTxglelLZRZ4J+
 zWyrJEy54uKokoDom5owfHC5AtZtV7rZ7frUOlxgnDqwXResCH+/
X-Google-Smtp-Source: AGHT+IGoRUmm/G2T9sdwkGLGnkYUwmf7T+ExqFtOoml7AjhFPqh3hlWgQmE73173XXk75Zns6muHqg==
X-Received: by 2002:a05:6a20:d80f:b0:1af:8fa8:3116 with SMTP id
 adf61e73a8af0-1afc8dc78abmr1990645637.42.1715166812561; 
 Wed, 08 May 2024 04:13:32 -0700 (PDT)
Received: from ownia.localdomain (vps-bd302c4a.vps.ovh.ca.
 [2402:1f00:8000:800::34b0]) by smtp.gmail.com with ESMTPSA id
 p28-20020a631e5c000000b005e438fe702dsm11225438pgm.65.2024.05.08.04.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 04:13:32 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Weizhao Ouyang <o451686892@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, Qu Wenruo <wqu@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2] efi_loader: Fix EFI_VARIABLE_APPEND_WRITE hash check
Date: Wed,  8 May 2024 19:13:12 +0800
Message-Id: <20240508111312.154617-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.40.1
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

According to UEFI v2.10 spec section 8.2.6, if a caller invokes the
SetVariables() service, it will produce a digest from hash(VariableName,
VendorGuid, Attributes, TimeStamp, DataNew_variable_content), then the
firmware that implements the SetVariable() service will compare the
digest with the result of applying the signer’s public key to the
signature. For EFI variable append write, efitools sign-efi-sig-list has
an option "-a" to add EFI_VARIABLE_APPEND_WRITE attr, and u-boot will
drop this attribute in efi_set_variable_int(). So if a caller uses
"sign-efi-sig-list -a" to create the authenticated variable, this append
write will fail in the u-boot due to "hash check failed".

This patch resumes writing the EFI_VARIABLE_APPEND_WRITE attr to ensure
that the hash check is correct. And also update the "test_efi_secboot"
test case to compliance with the change.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
v2: skip attr for efi_var_mem_ins()
---
 lib/efi_loader/efi_variable.c                  |  6 +++---
 test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++++++
 test/py/tests/test_efi_secboot/test_authvar.py |  4 ++--
 test/py/tests/test_efi_secboot/test_signed.py  | 10 +++++-----
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 1cc02acb3b..09651d4675 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -288,7 +288,6 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	/* check if a variable exists */
 	var = efi_var_mem_find(vendor, variable_name, NULL);
 	append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
-	attributes &= ~EFI_VARIABLE_APPEND_WRITE;
 	delete = !append && (!data_size || !attributes);
 
 	/* check attributes */
@@ -304,7 +303,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 
 		/* attributes won't be changed */
 		if (!delete &&
-		    ((ro_check && var->attr != attributes) ||
+		    ((ro_check && var->attr != (attributes & ~EFI_VARIABLE_APPEND_WRITE)) ||
 		     (!ro_check && ((var->attr & ~EFI_VARIABLE_READ_ONLY)
 				    != (attributes & ~EFI_VARIABLE_READ_ONLY))))) {
 			return EFI_INVALID_PARAMETER;
@@ -378,7 +377,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		for (; *old_data; ++old_data)
 			;
 		++old_data;
-		ret = efi_var_mem_ins(variable_name, vendor, attributes,
+		ret = efi_var_mem_ins(variable_name, vendor,
+				      attributes & ~EFI_VARIABLE_APPEND_WRITE,
 				      var->length, old_data, data_size, data,
 				      time);
 	} else {
diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
index ff7ac7c810..0fa0747fc7 100644
--- a/test/py/tests/test_efi_secboot/conftest.py
+++ b/test/py/tests/test_efi_secboot/conftest.py
@@ -64,6 +64,12 @@ def efi_boot_env(request, u_boot_config):
         check_call('cd %s; %scert-to-efi-sig-list -g %s db1.crt db1.esl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key db db1.esl db1.auth'
                    % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
                    shell=True)
+        # db2 (APPEND_WRITE)
+        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_db2/ -keyout db2.key -out db2.crt -nodes -days 365'
+                   % mnt_point, shell=True)
+        check_call('cd %s; %scert-to-efi-sig-list -g %s db2.crt db2.esl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key db db2.esl db2.auth'
+                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                   shell=True)
         # dbx (TEST_dbx certificate)
         check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_dbx/ -keyout dbx.key -out dbx.crt -nodes -days 365'
                    % mnt_point, shell=True)
@@ -84,6 +90,10 @@ def efi_boot_env(request, u_boot_config):
         check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db1.crt dbx_hash1.crl; %ssign-efi-sig-list -t "2020-04-06" -c KEK.crt -k KEK.key dbx dbx_hash1.crl dbx_hash1.auth'
                    % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
                    shell=True)
+        # dbx_hash2 (digest of TEST_db2 certificate, with APPEND_WRITE)
+        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db2.crt dbx_hash2.crl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key dbx dbx_hash2.crl dbx_hash2.auth'
+                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                   shell=True)
         # dbx_db (with TEST_db certificate)
         check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx db.esl dbx_db.auth'
                    % (mnt_point, EFITOOLS_PATH),
diff --git a/test/py/tests/test_efi_secboot/test_authvar.py b/test/py/tests/test_efi_secboot/test_authvar.py
index f99b8270a6..d5aeb65048 100644
--- a/test/py/tests/test_efi_secboot/test_authvar.py
+++ b/test/py/tests/test_efi_secboot/test_authvar.py
@@ -183,7 +183,7 @@ class TestEfiAuthVar(object):
             assert 'db:' in ''.join(output)
 
             output = u_boot_console.run_command_list([
-                'fatload host 0:1 4000000 db1.auth',
+                'fatload host 0:1 4000000 db2.auth',
                 'setenv -e -nv -bs -rt -a -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' in ''.join(output)
 
@@ -197,7 +197,7 @@ class TestEfiAuthVar(object):
         with u_boot_console.log.section('Test Case 3c'):
             # Test Case 3c, update with correct signature
             output = u_boot_console.run_command_list([
-                'fatload host 0:1 4000000 db1.auth',
+                'fatload host 0:1 4000000 db2.auth',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db',
                 'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67656f db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tests/test_efi_secboot/test_signed.py
index 5000a4ab7b..f604138a35 100644
--- a/test/py/tests/test_efi_secboot/test_signed.py
+++ b/test/py/tests/test_efi_secboot/test_signed.py
@@ -177,7 +177,7 @@ class TestEfiSignedImage(object):
         with u_boot_console.log.section('Test Case 5b'):
             # Test Case 5b, authenticated if both signatures are verified
             output = u_boot_console.run_command_list([
-                'fatload host 0:1 4000000 db1.auth',
+                'fatload host 0:1 4000000 db2.auth',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
@@ -201,7 +201,7 @@ class TestEfiSignedImage(object):
         with u_boot_console.log.section('Test Case 5d'):
             # Test Case 5d, rejected if both of signatures are revoked
             output = u_boot_console.run_command_list([
-                'fatload host 0:1 4000000 dbx_hash1.auth',
+                'fatload host 0:1 4000000 dbx_hash2.auth',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize dbx'])
             assert 'Failed to set EFI variable' not in ''.join(output)
             output = u_boot_console.run_command_list([
@@ -223,7 +223,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
-                'fatload host 0:1 4000000 db1.auth',
+                'fatload host 0:1 4000000 db2.auth',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 dbx_hash1.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
@@ -300,7 +300,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
-                'fatload host 0:1 4000000 db1.auth',
+                'fatload host 0:1 4000000 db2.auth',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 dbx_hash384.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
@@ -323,7 +323,7 @@ class TestEfiSignedImage(object):
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
                 'fatload host 0:1 4000000 PK.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
-                'fatload host 0:1 4000000 db1.auth',
+                'fatload host 0:1 4000000 db2.auth',
                 'setenv -e -nv -bs -rt -at -a -i 4000000:$filesize db',
                 'fatload host 0:1 4000000 dbx_hash512.auth',
                 'setenv -e -nv -bs -rt -at -i 4000000:$filesize dbx'])
-- 
2.40.1

