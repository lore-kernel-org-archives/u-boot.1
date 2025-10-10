Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148B6CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 20:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3601D8427F;
	Fri, 10 Oct 2025 22:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="H7Hh8a8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E57B8404A; Fri, 10 Oct 2025 22:30:01 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9753F8442B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 22:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CDB153F7D6; 
 Fri, 10 Oct 2025 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760128196;
 bh=sUh/lKyQ/CTkxSA258arLGern4O2fKH20wNI+N/e0CA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=H7Hh8a8dxFJS2kIRmTcH8TXgTg8h8M88bA0FffP4KDec+qSHPn5F3fW1+BUDiK3Ah
 9wgOu9Je+AoqhJ8SxmQkzuZZZtE6LWX+qRFUQe0LOCTHWcuwJt2HpMcqNPQl74ChiX
 mXEdkNvrQ3Ci5KszDsaTkcE/zh76+iDwDum+NcuJu5NGKQnbMZ716XpnbfoB18bbYh
 KEKqwQ6xw5cmfwse8nKudfSgXdJX2vDbgfKE0gA9bEjbKeRWjnfQVUhm6SkfPEWcVQ
 nN+3vJi3vR2Kum6AxvbvSgkvGrWzPHLxIAr0ge9Ce2thPW6WiMe9/BkFDeSaDbBtkU
 rKwoTiZ2q4CYbu52222N/GotrihEsQMdFtKmVKmSCRDY//QunHwlL8ogQWGjvqJKt7
 IXUlTO1DTEgnXCivyqipeo/2xV2C5n6C9GC5NLoLskC3bQqCIOQN3E/+XbFdjgjUAn
 WQo8C4ZuxL+DxreNuo/VCbFvwLpP4rWyb11vwVnQOAva1U6Oa7efQdlgFY1aL3ha+K
 8W4Ll71Xjg9o0bnxty3wUI0h+F2iIpfyVJ1KUncT2764EbLd3+RdU6xc8OhotDmUbu
 KavO5UTNY2a7cTFSUIGlyi6CTBzgA21lGR0HnUqsN8Kk13zXfOMpzYrgnNYt46pa92
 HG5WMR9td8bA3Gcp3dWHJV74=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: uninstall PK after secboot tests
Date: Fri, 10 Oct 2025 22:29:26 +0200
Message-ID: <20251010202926.2603488-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The EFI secure boot tests install a security data base.
Other EFI tests assume that secure boot is not enabled.
Add the missing tear-down at the end of each secboot test sequence.

Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_efi_secboot/conftest.py          | 5 ++++-
 test/py/tests/test_efi_secboot/test_signed.py       | 9 +++++++++
 test/py/tests/test_efi_secboot/test_signed_intca.py | 9 +++++++++
 test/py/tests/test_efi_secboot/test_unsigned.py     | 9 +++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
index aa9a3536296..76b8f9fa0a3 100644
--- a/test/py/tests/test_efi_secboot/conftest.py
+++ b/test/py/tests/test_efi_secboot/conftest.py
@@ -162,9 +162,12 @@ def efi_boot_env_intca(request, ubman):
         # PK
         check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_PK/ -keyout PK.key -out PK.crt -nodes -days 365'
                    % mnt_point, shell=True)
-        check_call('cd %s; %scert-to-efi-sig-list -g %s PK.crt PK.esl; %ssign-efi-sig-list -c PK.crt -k PK.key PK PK.esl PK.auth'
+        check_call('cd %s; %scert-to-efi-sig-list -g %s PK.crt PK.esl; %ssign-efi-sig-list -t "2020-04-01" -c PK.crt -k PK.key PK PK.esl PK.auth'
                    % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
                    shell=True)
+        # PK_null for deletion
+        check_call('cd %s; touch PK_null.esl; %ssign-efi-sig-list -c PK.crt -k PK.key PK PK_null.esl PK_null.auth'
+                   % (mnt_point, EFITOOLS_PATH), shell=True)
         # KEK
         check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_KEK/ -keyout KEK.key -out KEK.crt -nodes -days 365'
                    % mnt_point, shell=True)
diff --git a/test/py/tests/test_efi_secboot/test_signed.py b/test/py/tests/test_efi_secboot/test_signed.py
index e8aaef7090c..9e6d3fdf8d8 100644
--- a/test/py/tests/test_efi_secboot/test_signed.py
+++ b/test/py/tests/test_efi_secboot/test_signed.py
@@ -369,3 +369,12 @@ class TestEfiSignedImage(object):
             assert(not 'hELLO, world!' in ''.join(output))
             assert('\'HELLO1\' failed' in ''.join(output))
             assert('efi_bootmgr_load() returned: 26' in ''.join(output))
+
+        with ubman.log.section('Test Case 8c'):
+            # Test Case 8c, Uninstall PK
+            output = ubman.run_command_list([
+                'fatload host 0:1 4000000 PK_null.auth',
+                'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
+                'printenv -e -n PK'])
+            assert 'Failed to set EFI variable' not in ''.join(output)
+            assert '\"PK\" not defined' in ''.join(output)
diff --git a/test/py/tests/test_efi_secboot/test_signed_intca.py b/test/py/tests/test_efi_secboot/test_signed_intca.py
index 58f7be03b8b..06d86baef19 100644
--- a/test/py/tests/test_efi_secboot/test_signed_intca.py
+++ b/test/py/tests/test_efi_secboot/test_signed_intca.py
@@ -133,3 +133,12 @@ class TestEfiSignedImageIntca(object):
                 'efidebug test bootmgr'])
             assert '\'HELLO_abc\' failed' in ''.join(output)
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
+
+        with ubman.log.section('Test Case 3c'):
+            # Test Case 3c, Uninstall PK
+            output = ubman.run_command_list([
+                'fatload host 0:1 4000000 PK_null.auth',
+                'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
+                'printenv -e -n PK'])
+            assert 'Failed to set EFI variable' not in ''.join(output)
+            assert '\"PK\" not defined' in ''.join(output)
diff --git a/test/py/tests/test_efi_secboot/test_unsigned.py b/test/py/tests/test_efi_secboot/test_unsigned.py
index bd6e1b2dadd..2b86dc44cff 100644
--- a/test/py/tests/test_efi_secboot/test_unsigned.py
+++ b/test/py/tests/test_efi_secboot/test_unsigned.py
@@ -115,3 +115,12 @@ class TestEfiUnsignedImage(object):
                 'efidebug test bootmgr'])
             assert 'efi_bootmgr_load() returned: 26' in ''.join(output)
             assert 'Hello, world!' not in ''.join(output)
+
+        with ubman.log.section('Test Case 3c'):
+            # Test Case 3c, Uninstall PK
+            output = ubman.run_command_list([
+                'fatload host 0:1 4000000 PK_null.auth',
+                'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK',
+                'printenv -e -n PK'])
+            assert 'Failed to set EFI variable' not in ''.join(output)
+            assert '\"PK\" not defined' in ''.join(output)
-- 
2.51.0

