Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25286C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8202F848A1;
	Mon, 20 Jul 2026 14:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tZMik/IJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9195684119; Mon, 20 Jul 2026 10:29:45 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91CB782991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 27F933F5E7
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784536183;
 bh=rMOWPmDSNDjMO+cbcuDoaWdkzo54vnsqOiqfgvE0tS0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tZMik/IJ//06fjTuxdU957u17J00+q8wXqcqH2zYMZnv0bOkA4hNOTyqhKJRwKeyf
 RdaDFKX5XRk9T33YAi322d/Fv6qrbVToI+DQFQqEPvE0h0cd/xC0OnaMoSQjJRax9R
 bXHaRB94LBcLI68ffatz4wcAmvphCun+ky8Byt1aQLVRkpGArhSvELN8mPTTy6H5TD
 nJqDjvc5Nowd1ynB6NFrNEXHKwiJJJDbvK+rq6W8qUOn4Zg0URrJaj1k04G63ZRmoh
 lELfzNxIi+H/R/ejrlYa7U72o3LzOumZSpmUC2zV7xNKiwbXclh9LW326mVppGXjG9
 weLHCf1PRiotsytlDRrEElSMxrKpL1nuZq8ZwKAzVVrzixKybKQgEHrkGPSbb27UYb
 dxNCskO7C573bZGNqvJNm0eE9qwDccKzfVQJ+dOqIkOUS/qc0B7kd6qPvyJ5sOjYgS
 lfjhu4fg9NYZtiRHtGt3Ak8VuM1zikB6EQLlID6+5f3PhnGvjOZlA/j4/4eeH0X52a
 q4zN6GCHASeQ70TWYLkfeNgPVM8XM04GOArucj487EPMOHpE5EEhqmCb5Kxl0YVNfU
 sHrlR9nw6hkh8Ov3owWvsTwADxDF0yJS/rDQG9SE0WX7QlYn43Y/FqGzeXkYPXhjMj
 52eIOO3fqxeYTbYhvrzBP6aU=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cefa1a2be6so76274735ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536181; x=1785140981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rMOWPmDSNDjMO+cbcuDoaWdkzo54vnsqOiqfgvE0tS0=;
 b=JBVlKlGSVx6EhsjF29DI3VuKYjU7INP/sT+uQqFyByfNgcII/6zweCTWes7bBxxYh9
 oRjL5TGOPMcoSFrSY1gNOG3iey8HRS2+ze9jk8kyQYRIBGGWNrx0hNkeQN1lsw3EJh2D
 llfHpoQZNfos7WOMZns5YDkEEb6y118GJJT7lEb53EiOpnn9h+m2YmT7st76Bp6b1vog
 Omd9Qxj6vlyJvtIA9VAnHgfGykLnlcE6zrE3VHfhuHMdjMDDAKepQMI2yymrniwsnw7S
 TuVvisYzN5bvrg/Og6buheNsmbokKQ6lqXR8K7kNc+fZ8EPDz2stESFHfK1jE4aRVRP5
 BgKg==
X-Gm-Message-State: AOJu0YwuK/RiRQvjznO5AC1BTI+Lds2OyGcqlPo17MPixl5BC5+rq6T+
 QNsO7gf5Da39Q5MxA7k40JLvp9+YzV+jONUp/X7RjnRofNjacx9V9G7bv6MH8FuXC2gqkKah2eC
 bUz/t7ZDjF0oI3B8syaFf4ZzsrboOzvR9NiHNybAin9/1B9zL0UhjSDtLG+DRANEp4RxhXVpkrf
 +mY7U=
X-Gm-Gg: AR+sD13Nz7uGOC1ISaeK2LiY+AsCQbTua1bgNbPX6eyx93JBe12SAXaC4F9bO//eZkt
 0CQ4ion8D5wt97BDbGXHR0OcSfnWKPodN2Bxt8ObuLbeJkZ7HWpC3nGEzqMjj6DSddZTiDU+F86
 xnqgHz58fdezA12b8qt0sQBaBFMeur9BPMYl7hYvS41rh6tjwuKHdJDGZewnSZ0xtrVMpSMoqBB
 Wu3t5ivTvdj/vROCU5OmFJS1JSpa261xW49iR7GN+XTUIhFSma1gA/LrJnM1wvveNNQoO+wPMC8
 ys0kT7brQUu04ZqlVOIJlDNeHMjBoXLQPlf2YABxIV+RweZ09Twzh+f1+WbQ0o81VXFdE7NpyTp
 EzD5g/RFn9qXmucw+sg7hTF4iOOzGUPiP8g9cpIAWEQBtLC4NQV3b9plMLqzoEK7J+vo=
X-Received: by 2002:a17:902:ea07:b0:2c9:ed16:8d8d with SMTP id
 d9443c01a7336-2cf349ea664mr154765375ad.38.1784536181528; 
 Mon, 20 Jul 2026 01:29:41 -0700 (PDT)
X-Received: by 2002:a17:902:ea07:b0:2c9:ed16:8d8d with SMTP id
 d9443c01a7336-2cf349ea664mr154765235ad.38.1784536181102; 
 Mon, 20 Jul 2026 01:29:41 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34713fe1sm52975265ad.55.2026.07.20.01.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:29:40 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] test: check default GUID selection of signature
 database variables
Date: Mon, 20 Jul 2026 08:29:14 +0000
Message-ID: <20260720082917.2162-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720082917.2162-1-aristo.chen@canonical.com>
References: <20260714094902.438079-1-aristo.chen@canonical.com>
 <20260720082917.2162-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 14:28:29 +0200
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
global variable GUID. Then enroll PK and KEK, also without -guid, and
check that both are created under the global variable GUID and not
under the image security database GUID. This is also the first
coverage of dbt and dbr anywhere under test/.

The signature database enrollment happens in setup mode because once
secure boot is enabled, efi_variable_authenticate() only accepts
writes to PK, KEK, db and dbx; PK and KEK are enrolled last because
installing PK leaves setup mode.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
Changes in v2:
- also check that PK and KEK are created under the global variable
  GUID and not under the image security database GUID (suggested by
  Heinrich Schuchardt)

 test/py/tests/test_efi_secboot/conftest.py    |  8 ++++
 .../py/tests/test_efi_secboot/test_authvar.py | 47 +++++++++++++++++++
 2 files changed, 55 insertions(+)

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
index 7b45f8fb814..a41e9eb9204 100644
--- a/test/py/tests/test_efi_secboot/test_authvar.py
+++ b/test/py/tests/test_efi_secboot/test_authvar.py
@@ -279,3 +279,50 @@ class TestEfiAuthVar(object):
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
+
+        with ubman.log.section('Test Case 6c'):
+            # Test Case 6c, PK and KEK get the global variable GUID by
+            # default. Enrolling PK leaves setup mode, so this must come
+            # after the signature database enrollment above.
+            for var in ('PK', 'KEK'):
+                output = ubman.run_command_list([
+                    'fatload host 0:1 4000000 %s.auth' % var,
+                    'setenv -e -nv -bs -rt -at -i 4000000:$filesize %s' % var,
+                    'printenv -e -n -guid 8be4df61-93ca-11d2-aa0d-00e098032b8c %s' % var])
+                assert 'Failed to set EFI variable' not in ''.join(output)
+                assert '%s:' % var in ''.join(output)
+
+            for var in ('PK', 'KEK'):
+                output = ubman.run_command(
+                    'printenv -e -n -guid d719b2cb-3d3a-4596-a3bc-dad00e67656f %s' % var)
+                assert '\"%s\" not defined' % var in output
-- 
2.43.0

