Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEF8C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69E388085;
	Wed, 27 Mar 2024 15:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FSwsfYL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC8D188019; Wed, 27 Mar 2024 15:06:56 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA1E8803A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6b729669bso5642375b3a.3
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711548407; x=1712153207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=u7Wmc4B7Qbhg4p2N2fBtKNs2YgxkFukC7h4qawfKL60=;
 b=FSwsfYL2vklbXqoVm+o0PhtvVs1hrm+kmsxw/0JiUgbxG1a95vGJkZ3Q+bY8gBpVEw
 lpSE5y0RrzDxQl0NxQirV66ts2dMZ33RJYWOSJsx39qHM/4dJ3j21UiPXyZcaCEMaNbh
 zTg5pGV0tH8Tzlpj7WgTZSjDXxNuQ9asqPJZvHVDkS5KI4ME6t7AmgFya+z4i8wW5Pg3
 Up/UczsQnH/2vS4yHH7nSPgMbFylcN2UyjJbr6UmchN0n5ZsJ4FE9SkP5eIW5AxzyTcy
 u3FlA1aKG+XVVFqMdZsfAHIZFsRsDBmE1nOoVG7JeJMYY8HlXFWAZIg96xiypx4uu8p/
 /yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711548407; x=1712153207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7Wmc4B7Qbhg4p2N2fBtKNs2YgxkFukC7h4qawfKL60=;
 b=OTroHCv3fvKltXeRIOYVNEOg85IKYVDOyYxSxkYPu9cdeARtaWGMjN1neMjOLALoNj
 QBJTFtsGe1zHy+CZ0vxICnnLr2JT3EezDPACfAYn581XhHlJaofglnzSTxmVTiN5OCGF
 eROkGptN6OL7Iuu7NVclgr247Wr6pd2kJWpP2RBJz0kT0VlLrnwEp/Nln5yrC5FHBfYZ
 uJKYBqwEmrmJXnGNQgK6xxrRMyvaBbz+hWHLtGOYsldL3d/NHwlVs9wQs6F/QfTo8jqY
 HJiOsBzphPVySmYpCj9sHU82sTMbzfsNlVfInQUfSJ776qV6M4h/YVB6u5u4uTNkdx94
 buIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW29+LafsaXPjFLh6AEDxAMmNF7mEQ3L1zpIkvNbLFxZIlBQKIYGt/ado+XjxL4emqYbDzOJ8QvgHGZIpa7+hoso76WEQ==
X-Gm-Message-State: AOJu0Yz/Kip7ncJ5ijMGestlEFoa+XsDnKDUCmVjw/PI+bUZc/tdNtv7
 NikOjDtW4QF3qHji7EXvr1QgM+NfVRdK8ryGtgYVE7VOlJZq1ODi
X-Google-Smtp-Source: AGHT+IFKhGK5ett5f2bwytlztAgRhEvEELrPdo39Ddxmva1fRKMTwBzqvDh4ZA4LdhmuLrJWY9+bZQ==
X-Received: by 2002:a05:6a00:14d5:b0:6ea:9252:435 with SMTP id
 w21-20020a056a0014d500b006ea92520435mr1557128pfu.30.1711548407020; 
 Wed, 27 Mar 2024 07:06:47 -0700 (PDT)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 y4-20020aa78044000000b006e6fc52ecd0sm7765245pfm.123.2024.03.27.07.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 07:06:46 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Weizhao Ouyang <o451686892@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
Subject: [RFC PATCH] efi_loader: Fix EFI_VARIABLE_APPEND_WRITE hash check
Date: Wed, 27 Mar 2024 14:06:28 +0000
Message-Id: <20240327140628.106143-1-o451686892@gmail.com>
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
 lib/efi_loader/efi_variable.c                  |  3 +--
 test/py/tests/test_efi_secboot/conftest.py     | 10 ++++++++++
 test/py/tests/test_efi_secboot/test_authvar.py |  4 ++--
 test/py/tests/test_efi_secboot/test_signed.py  | 10 +++++-----
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 40f7a0fb10..f41aa8f9ad 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -259,7 +259,6 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	/* check if a variable exists */
 	var = efi_var_mem_find(vendor, variable_name, NULL);
 	append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
-	attributes &= ~(u32)EFI_VARIABLE_APPEND_WRITE;
 	delete = !append && (!data_size || !attributes);
 
 	/* check attributes */
@@ -275,7 +274,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 
 		/* attributes won't be changed */
 		if (!delete &&
-		    ((ro_check && var->attr != attributes) ||
+		    ((ro_check && var->attr != (attributes & ~(u32)EFI_VARIABLE_APPEND_WRITE)) ||
 		     (!ro_check && ((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY)
 				    != (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))) {
 			return EFI_INVALID_PARAMETER;
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
index 2f862a259a..34719ad1f2 100644
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

