Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC94C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 12:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DD984D24;
	Tue, 14 Jul 2026 14:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="M0pp/Bwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2992D84CE5; Tue, 14 Jul 2026 11:49:46 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3127984C5E
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 11:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DEE563F606
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784022583;
 bh=M0D5P8Ih35Xq4FFg6wFyCLctow4U5Xh92XmbMmQwaso=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=M0pp/BwocNpI9U+rTCssH8x4PClRIUekdP7IOwekilOuwOXZ1fOqMIXWcHIy3jRls
 +JgqqTcyF7ZdvK9ruJqc8w9lKBPlpQOavF7Y9qdsvtf4nt3APXPmBtJCwO0ffJoQPT
 wmQnpK9+GS9LyFfr+gMWdkIsTWxjTmeo1E5bWhr2/a60UInZlIKdVfFzhig1osqX+U
 wzTds0exz+STqTO/4tY5O872zQoMAKGSyc5vthZ/vCt7z0Smz34nsNj+lAiiIJ0qDX
 y29+3a2EQXah7UCxgjsgR9k9Xpn3XNcpP6zEASdQPn9KgrpV2MV5FVVnB4B8EO9aoH
 N7VHTWWoolOcbGAhlquOQByOvzfoee/xVxqXn2lBJvs8Ptf3a4gNQybHlbOfstm8xX
 joKq26Y4eX0UA3laWzqqsbKPbynDJiU2SMnQuQJT+ifqJN7Ib0+lvNP2QqjK4/qXES
 pMOSyM8GtwepVa5SjAE4GrcoIx2Q/ykVRP6tB183mT9JVyYBoKu8fE5lNPWEWE+aY8
 lNJnom6FEItFd2+uv9DZq84hwO1GVLAgRnoP3DAwPZ8JsaaC8+avzoMkyjXt9mM3KI
 dCdoTTCYUMbT9aVO+jiGzAPbtKjnV9WW/Yvj79OSK70wJ9BhN/cmsmBm7cYbhZ8q2l
 pNnkv9Zam0tyckPP+JD7MRas=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84857446424so8496522b3a.1
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 02:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022582; x=1784627382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M0D5P8Ih35Xq4FFg6wFyCLctow4U5Xh92XmbMmQwaso=;
 b=MSRCf0IluKH569jdHt8lN7+3tdgbgOpgkaToJ16GQB7MYBHfe97jMGLr8MaYfWDhF/
 Gc8QL4cxpSISv+xFCm1ix6c7OCa/NLlT+07+ot0K1EkY5bEeGdgEx42HY50rut6+ViiB
 tXgL3z7bhdA9hSH1FYwooT0gLVu/OMz9Uzo+OCGCJPoMwg5GnhqGuAfKS/xTGmOKrk98
 d54bJsP0QWibkMPtj6KAne79/TlTTDvhoL6vqp0C54mQHuA2ryllf5N95VJNlPRniyVl
 jzpSqEe720WVTGDDDvFn0vynWhp9qkeZbhl/zJh0xO0diL4YVPr+y2u3NG8WOcfHFAXs
 KwsA==
X-Gm-Message-State: AOJu0Yz64zrJYHgp1ZjjcwcbBd6y4mC3PFoMuLEsss5yjE5gN61PAsrX
 qYO7UO8FjatJkZ7hVhw6h9slQ3z4wY1lJwjhPiM2NZtPGIIFbAXIcmlJOu4EdvEFmUP4JJfmLqo
 08n6Vyv5S1q4EEgMKWwWyf67oNtCTXI1pqVEGk861DESmNBhHddlVa5Rc4LBefxlX+fMv788uQZ
 5ZG4w=
X-Gm-Gg: AfdE7cmFpFm8aWRqWPbsaKr4wgEgh2i4vIockIdBdHDZqFsHEDkesAdBdOYCPUR+49z
 tA6jpCDhtnhMQRq5dxQGNmKVaf9qaOvtII8a7y1ORvNA3VP4GIm9UoVBwoCsRDzMksAywhhe89U
 MJvUh+uWmHTv78DZCeZA9r6MBBVPtmD7ID2d+onru/y5Je/+4BpP4xqPydYpY82TjQNqqqbqI+R
 7MVTV5ghZZROFZfWN3+qOlIrGsWZwJQMWRgCjCpVY/0DBNJ32qT+1H33UUc7g+ooHXomhue7WNL
 r+FW5QFXlxSsaYVfAn6llPNpUC19391baql6E5ey8gIO+F4wCS3hUlww57tqmfUCbohvhXqIYUk
 8LuXqi4LROXO6A4x0ANU+QYwAD3jtxtzE1dTeJhbgRHg9h7hSiLk87h4BH08vq5d+fzv17Ub+/D
 KpA849
X-Received: by 2002:a05:6a00:18a0:b0:848:8715:c2cd with SMTP id
 d2e1a72fcca58-848896ddc81mr11311084b3a.47.1784022582266; 
 Tue, 14 Jul 2026 02:49:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:18a0:b0:848:8715:c2cd with SMTP id
 d2e1a72fcca58-848896ddc81mr11311061b3a.47.1784022581906; 
 Tue, 14 Jul 2026 02:49:41 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3c1f77fsm9687752a12.32.2026.07.14.02.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:49:41 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] test: check default GUID selection of signature
 database variables
Date: Tue, 14 Jul 2026 09:49:00 +0000
Message-ID: <20260714094902.438079-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714094902.438079-1-aristo.chen@canonical.com>
References: <20260714094902.438079-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jul 2026 14:51:05 +0200
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

The name to GUID mapping that "env set -e" applies when no -guid
option is given was not covered by any test, which is how the wrong
default GUID for "dbr" went unnoticed until the previous commit.

Add a test case that enrolls each of db, dbx, dbt and dbr in setup
mode without an explicit -guid option and checks that every variable
is created under the image security database GUID and not under the
global variable GUID. This is also the first coverage of dbt and dbr
anywhere under test/. The enrollment happens in setup mode because
once secure boot is enabled, efi_variable_authenticate() only accepts
writes to PK, KEK, db and dbx.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_efi_secboot/conftest.py    |  8 +++++
 .../py/tests/test_efi_secboot/test_authvar.py | 30 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
index 76b8f9fa0a3..0755497d46d 100644
--- a/test/py/tests/test_efi_secboot/conftest.py
+++ b/test/py/tests/test_efi_secboot/conftest.py
@@ -96,6 +96,14 @@ def efi_boot_env(request, ubman):
         check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx db.esl dbx_db.auth'
                    % (mnt_point, EFITOOLS_PATH),
                    shell=True)
+        # dbt (with TEST_db certificate)
+        check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbt db.esl dbt.auth'
+                   % (mnt_point, EFITOOLS_PATH),
+                   shell=True)
+        # dbr (with TEST_db certificate)
+        check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbr db.esl dbr.auth'
+                   % (mnt_point, EFITOOLS_PATH),
+                   shell=True)
 
         # Copy image
         check_call('cp %s/lib/efi_loader/helloworld.efi %s' %
diff --git a/test/py/tests/test_efi_secboot/test_authvar.py b/test/py/tests/test_efi_secboot/test_authvar.py
index 7b45f8fb814..45350b19b06 100644
--- a/test/py/tests/test_efi_secboot/test_authvar.py
+++ b/test/py/tests/test_efi_secboot/test_authvar.py
@@ -279,3 +279,33 @@ class TestEfiAuthVar(object):
             output = ubman.run_command(
                 'printenv -e SetupMode')
             assert '00000000: 01' in output
+
+    def test_efi_var_auth6(self, ubman, efi_boot_env):
+        """
+        Test Case 6 - Default GUID of signature database variables
+        """
+        ubman.restart_uboot()
+        disk_img = efi_boot_env
+        with ubman.log.section('Test Case 6a'):
+            # Test Case 6a, install signature database variables in setup
+            # mode without -guid
+            output = ubman.run_command_list([
+                'host bind 0 %s' % disk_img,
+                'printenv -e SetupMode'])
+            assert '00000000: 01' in ''.join(output)
+
+            for var in ('db', 'dbx', 'dbt', 'dbr'):
+                output = ubman.run_command_list([
+                    'fatload host 0:1 4000000 %s.auth' % var,
+                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize %s' % var,
+                    'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67656f %s' % var])
+                assert 'Failed to set EFI variable' not in ''.join(output)
+                assert '%s:' % var in ''.join(output)
+
+        with ubman.log.section('Test Case 6b'):
+            # Test Case 6b, variables must not exist under the global
+            # variable GUID
+            for var in ('db', 'dbx', 'dbt', 'dbr'):
+                output = ubman.run_command(
+                    'printenv -e -n -guid 8be4df61-93ca-11d2-aa0d-00e098032b8c %s' % var)
+                assert '\"%s\" not defined' % var in output
-- 
2.43.0

