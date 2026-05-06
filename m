Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2356CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62ED38493F;
	Wed,  6 May 2026 17:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QxGi7Tb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1EB5848FD; Wed,  6 May 2026 17:57:59 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 318BE8466D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dbd23bc684so3958811a34.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083074; x=1778687874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKO0yWeHH5alShSk2aKdu3HRor+sEfgoM2gj7kJrnp0=;
 b=QxGi7Tb29hvXw44G7pCAyR3NHWDcmSF/al6Su2wg2qSmdTuNz8HtcStIwwgoHH45+n
 kMaNDkadePazbIdpqeUyB4UdDO+J/uSMJywX2Qj3YbH1Vg1iRijbbm7easVWZs4Pv8lJ
 czuF7BbVREhAl+23iT4Kk0zsILCd+S1wf8/pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083074; x=1778687874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rKO0yWeHH5alShSk2aKdu3HRor+sEfgoM2gj7kJrnp0=;
 b=HsvO9mSF8Ufc4kp+rRU4YjjkHDQ7CFcvOY2KfU+55v0kPp04yGqMeoFiNg8aXZTzNs
 40oaUic1aFdQvLsbGUb7YhvAEXl+95IB9XJVbHYtaJDBe8o/hg24gZUf6BOPKnf5pe7c
 hrXVJwFAKpySnPkCdUprFNCTqFQQgcwBHOWOAcDX/himMch1rwiRit9AkJSRsppM4v9y
 1vqxLbyl9oPeGNpfrB99/MBfpKOaE336mGhu7N8JBYCuqQ7HJBHmb2kFvsTMwRxnbMSx
 kf6D1IfeuChscV/TlUeDYuGU/Y6n9AN5WIZ055lhiWfV8NmB3ymU4BlFKWZIxj0chac7
 H0Ug==
X-Gm-Message-State: AOJu0Yz2nAxevLOe6mzQf8lP/tECCw8HSZ/LRXXDgF0L7E5ZvhHs4piI
 Z5A6Kcqm5yCFM0IC9ayqmGVE303++MVUncyvGT+/qXYBijHFzUCU6ayJWNOljTPtQFKP8yNX3c+
 UjSwQlPRf
X-Gm-Gg: AeBDiesOtUkqdLQbsAe6mCJCigBnF1oS1wKAdsor9LCdznNoAOh1sXJW22pAlnO+2ZE
 28UkK9p+4RrwlIHScLJ6WxtUvTDqRwsEC599OpdNiyus4y+l2dZvuWfwRVS0mutltgXMo3vHt8Z
 ccFfUHGSj7qE7jv9PP/w8wACc6AouVKJWDzyxoph9YHkB3aJ0y+PyWARmDKEZEawwrbhdrEDDTu
 K1LcPhxoLAiwaDiEGWB3o0H54t1GOS+1mXNe6/leQ64ffwZMysW0i6Rf3vgzHA82yU84WMH30iT
 7ZXlVyJKbSdATz5lhTlbrMrOU8gntvKLpkZRpth41eYfGeDr0UQd9tyhCZ1GwcYhXMeZoQtesE3
 DmwWK5XrIp3VAe/zw18ayX+gehd20kn8jrBgM015MXMCQuCI4fOuqNcXpKGFAx9ahn50It5TKWW
 UFJIXZQewsLK9GsT1BF45RSmiVV2FX
X-Received: by 2002:a05:6830:3817:b0:7dc:dd19:7f69 with SMTP id
 46e09a7af769-7e1df0c4d9dmr2046382a34.17.1778083074091; 
 Wed, 06 May 2026 08:57:54 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:57:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/10] test: Convert test_efi_secboot fixtures to FsHelper
Date: Wed,  6 May 2026 09:56:16 -0600
Message-ID: <20260506155639.1191640-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506155639.1191640-1-sjg@chromium.org>
References: <20260506155639.1191640-1-sjg@chromium.org>
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

Simplify these test-setup fixtures by using the helper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_efi_secboot/conftest.py | 402 ++++++++++-----------
 1 file changed, 197 insertions(+), 205 deletions(-)

diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
index 76b8f9fa0a3..8f0c68c0130 100644
--- a/test/py/tests/test_efi_secboot/conftest.py
+++ b/test/py/tests/test_efi_secboot/conftest.py
@@ -4,8 +4,8 @@
 
 """Fixture for UEFI secure boot test."""
 
-from subprocess import call, check_call, CalledProcessError
-from tests import fs_helper
+from subprocess import check_call, CalledProcessError
+from tests.fs_helper import DiskHelper, FsHelper
 import pytest
 from defs import *
 
@@ -22,117 +22,113 @@ def efi_boot_env(request, ubman):
     """
 
     try:
-        image_path, mnt_point = fs_helper.setup_image(ubman, 0, 0xc,
-                                                      basename='test_efi_secboot')
-
-        # suffix
-        # *.key: RSA private key in PEM
-        # *.crt: X509 certificate (self-signed) in PEM
-        # *.esl: signature list
-        # *.hash: message digest of image as signature list
-        # *.auth: signed signature list in signature database format
-        # *.efi: UEFI image
-        # *.efi.signed: signed UEFI image
-
-        # Create signature database
-        # PK
-        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_PK/ -keyout PK.key -out PK.crt -nodes -days 365'
-                   % mnt_point, shell=True)
-        check_call('cd %s; %scert-to-efi-sig-list -g %s PK.crt PK.esl; %ssign-efi-sig-list -t "2020-04-01" -c PK.crt -k PK.key PK PK.esl PK.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # PK_null for deletion
-        check_call('cd %s; touch PK_null.esl; %ssign-efi-sig-list -t "2020-04-02" -c PK.crt -k PK.key PK PK_null.esl PK_null.auth'
-                   % (mnt_point, EFITOOLS_PATH), shell=True)
-        # KEK
-        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_KEK/ -keyout KEK.key -out KEK.crt -nodes -days 365'
-                   % mnt_point, shell=True)
-        check_call('cd %s; %scert-to-efi-sig-list -g %s KEK.crt KEK.esl; %ssign-efi-sig-list -t "2020-04-03" -c PK.crt -k PK.key KEK KEK.esl KEK.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # db
-        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_db/ -keyout db.key -out db.crt -nodes -days 365'
-                   % mnt_point, shell=True)
-        check_call('cd %s; %scert-to-efi-sig-list -g %s db.crt db.esl; %ssign-efi-sig-list -t "2020-04-04" -c KEK.crt -k KEK.key db db.esl db.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # db1
-        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_db1/ -keyout db1.key -out db1.crt -nodes -days 365'
-                   % mnt_point, shell=True)
-        check_call('cd %s; %scert-to-efi-sig-list -g %s db1.crt db1.esl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key db db1.esl db1.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # db2 (APPEND_WRITE)
-        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_db2/ -keyout db2.key -out db2.crt -nodes -days 365'
-                   % mnt_point, shell=True)
-        check_call('cd %s; %scert-to-efi-sig-list -g %s db2.crt db2.esl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key db db2.esl db2.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # dbx (TEST_dbx certificate)
-        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_dbx/ -keyout dbx.key -out dbx.crt -nodes -days 365'
-                   % mnt_point, shell=True)
-        check_call('cd %s; %scert-to-efi-sig-list -g %s dbx.crt dbx.esl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx dbx.esl dbx.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # dbx_hash (digest of TEST_db certificate)
-        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db.crt dbx_hash.crl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx dbx_hash.crl dbx_hash.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 384 db.crt dbx_hash384.crl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx dbx_hash384.crl dbx_hash384.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 512 db.crt dbx_hash512.crl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx dbx_hash512.crl dbx_hash512.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # dbx_hash1 (digest of TEST_db1 certificate)
-        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db1.crt dbx_hash1.crl; %ssign-efi-sig-list -t "2020-04-06" -c KEK.crt -k KEK.key dbx dbx_hash1.crl dbx_hash1.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # dbx_hash2 (digest of TEST_db2 certificate, with APPEND_WRITE)
-        check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db2.crt dbx_hash2.crl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key dbx dbx_hash2.crl dbx_hash2.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # dbx_db (with TEST_db certificate)
-        check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx db.esl dbx_db.auth'
-                   % (mnt_point, EFITOOLS_PATH),
-                   shell=True)
-
-        # Copy image
-        check_call('cp %s/lib/efi_loader/helloworld.efi %s' %
-                   (ubman.config.build_dir, mnt_point), shell=True)
-
-        # Sign image
-        check_call('cd %s; sbsign --key db.key --cert db.crt helloworld.efi'
-                   % mnt_point, shell=True)
-        # Sign already-signed image with another key
-        check_call('cd %s; sbsign --key db1.key --cert db1.crt --output helloworld.efi.signed_2sigs helloworld.efi.signed'
-                   % mnt_point, shell=True)
-        # Create a corrupted signed image
-        check_call('cd %s; sh %s/test/py/tests/test_efi_secboot/forge_image.sh helloworld.efi.signed helloworld_forged.efi.signed'
-                   % (mnt_point, ubman.config.source_dir), shell=True)
-        # Digest image
-        check_call('cd %s; %shash-to-efi-sig-list helloworld.efi db_hello.hash; %ssign-efi-sig-list -t "2020-04-07" -c KEK.crt -k KEK.key db db_hello.hash db_hello.auth'
-                   % (mnt_point, EFITOOLS_PATH, EFITOOLS_PATH),
-                   shell=True)
-        check_call('cd %s; %shash-to-efi-sig-list helloworld.efi.signed db_hello_signed.hash; %ssign-efi-sig-list -t "2020-04-03" -c KEK.crt -k KEK.key db db_hello_signed.hash db_hello_signed.auth'
-                   % (mnt_point, EFITOOLS_PATH, EFITOOLS_PATH),
-                   shell=True)
-        check_call('cd %s; %ssign-efi-sig-list -t "2020-04-07" -c KEK.crt -k KEK.key dbx db_hello_signed.hash dbx_hello_signed.auth'
-                   % (mnt_point, EFITOOLS_PATH),
-                   shell=True)
-
-        fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x1000000,
-                                 'test_efi_secboot', mnt_point)
-        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
-
+        with DiskHelper(ubman.config, 0, 'test_efi_secboot') as img, \
+                FsHelper(ubman.config, 'vfat', 16,
+                         'test_efi_secboot') as fsh:
+            mnt_point = fsh.srcdir
+
+            # suffix
+            # *.key: RSA private key in PEM
+            # *.crt: X509 certificate (self-signed) in PEM
+            # *.esl: signature list
+            # *.hash: message digest of image as signature list
+            # *.auth: signed signature list in signature database format
+            # *.efi: UEFI image
+            # *.efi.signed: signed UEFI image
+
+            # Create signature database
+            # PK
+            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_PK/ -keyout PK.key -out PK.crt -nodes -days 365'
+                       % mnt_point, shell=True)
+            check_call('cd %s; %scert-to-efi-sig-list -g %s PK.crt PK.esl; %ssign-efi-sig-list -t "2020-04-01" -c PK.crt -k PK.key PK PK.esl PK.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # PK_null for deletion
+            check_call('cd %s; touch PK_null.esl; %ssign-efi-sig-list -t "2020-04-02" -c PK.crt -k PK.key PK PK_null.esl PK_null.auth'
+                       % (mnt_point, EFITOOLS_PATH), shell=True)
+            # KEK
+            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_KEK/ -keyout KEK.key -out KEK.crt -nodes -days 365'
+                       % mnt_point, shell=True)
+            check_call('cd %s; %scert-to-efi-sig-list -g %s KEK.crt KEK.esl; %ssign-efi-sig-list -t "2020-04-03" -c PK.crt -k PK.key KEK KEK.esl KEK.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # db
+            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_db/ -keyout db.key -out db.crt -nodes -days 365'
+                       % mnt_point, shell=True)
+            check_call('cd %s; %scert-to-efi-sig-list -g %s db.crt db.esl; %ssign-efi-sig-list -t "2020-04-04" -c KEK.crt -k KEK.key db db.esl db.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # db1
+            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_db1/ -keyout db1.key -out db1.crt -nodes -days 365'
+                       % mnt_point, shell=True)
+            check_call('cd %s; %scert-to-efi-sig-list -g %s db1.crt db1.esl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key db db1.esl db1.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # db2 (APPEND_WRITE)
+            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_db2/ -keyout db2.key -out db2.crt -nodes -days 365'
+                       % mnt_point, shell=True)
+            check_call('cd %s; %scert-to-efi-sig-list -g %s db2.crt db2.esl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key db db2.esl db2.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # dbx (TEST_dbx certificate)
+            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_dbx/ -keyout dbx.key -out dbx.crt -nodes -days 365'
+                       % mnt_point, shell=True)
+            check_call('cd %s; %scert-to-efi-sig-list -g %s dbx.crt dbx.esl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx dbx.esl dbx.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # dbx_hash (digest of TEST_db certificate)
+            check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db.crt dbx_hash.crl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx dbx_hash.crl dbx_hash.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            check_call('cd %s; %scert-to-efi-hash-list -g %s -s 384 db.crt dbx_hash384.crl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx dbx_hash384.crl dbx_hash384.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            check_call('cd %s; %scert-to-efi-hash-list -g %s -s 512 db.crt dbx_hash512.crl; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx dbx_hash512.crl dbx_hash512.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # dbx_hash1 (digest of TEST_db1 certificate)
+            check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db1.crt dbx_hash1.crl; %ssign-efi-sig-list -t "2020-04-06" -c KEK.crt -k KEK.key dbx dbx_hash1.crl dbx_hash1.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # dbx_hash2 (digest of TEST_db2 certificate, with APPEND_WRITE)
+            check_call('cd %s; %scert-to-efi-hash-list -g %s -s 256 db2.crt dbx_hash2.crl; %ssign-efi-sig-list -a -c KEK.crt -k KEK.key dbx dbx_hash2.crl dbx_hash2.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # dbx_db (with TEST_db certificate)
+            check_call('cd %s; %ssign-efi-sig-list -t "2020-04-05" -c KEK.crt -k KEK.key dbx db.esl dbx_db.auth'
+                       % (mnt_point, EFITOOLS_PATH),
+                       shell=True)
+
+            # Copy image
+            check_call('cp %s/lib/efi_loader/helloworld.efi %s' %
+                       (ubman.config.build_dir, mnt_point), shell=True)
+
+            # Sign image
+            check_call('cd %s; sbsign --key db.key --cert db.crt helloworld.efi'
+                       % mnt_point, shell=True)
+            # Sign already-signed image with another key
+            check_call('cd %s; sbsign --key db1.key --cert db1.crt --output helloworld.efi.signed_2sigs helloworld.efi.signed'
+                       % mnt_point, shell=True)
+            # Create a corrupted signed image
+            check_call('cd %s; sh %s/test/py/tests/test_efi_secboot/forge_image.sh helloworld.efi.signed helloworld_forged.efi.signed'
+                       % (mnt_point, ubman.config.source_dir), shell=True)
+            # Digest image
+            check_call('cd %s; %shash-to-efi-sig-list helloworld.efi db_hello.hash; %ssign-efi-sig-list -t "2020-04-07" -c KEK.crt -k KEK.key db db_hello.hash db_hello.auth'
+                       % (mnt_point, EFITOOLS_PATH, EFITOOLS_PATH),
+                       shell=True)
+            check_call('cd %s; %shash-to-efi-sig-list helloworld.efi.signed db_hello_signed.hash; %ssign-efi-sig-list -t "2020-04-03" -c KEK.crt -k KEK.key db db_hello_signed.hash db_hello_signed.auth'
+                       % (mnt_point, EFITOOLS_PATH, EFITOOLS_PATH),
+                       shell=True)
+            check_call('cd %s; %ssign-efi-sig-list -t "2020-04-07" -c KEK.crt -k KEK.key dbx db_hello_signed.hash dbx_hello_signed.auth'
+                       % (mnt_point, EFITOOLS_PATH),
+                       shell=True)
+
+            fsh.mk_fs()
+            img.add_fs(fsh, DiskHelper.VFAT)
+            yield img.create()
     except CalledProcessError as exception:
         pytest.skip('Setup failed: %s' % exception.cmd)
         return
-    else:
-        yield image_path
-    finally:
-        call('rm -rf %s' % mnt_point, shell=True)
-        call('rm -f %s %s' % (image_path, fsfile), shell=True)
 
 #
 # Fixture for UEFI secure boot test of intermediate certificates
@@ -155,101 +151,97 @@ def efi_boot_env_intca(request, ubman):
     """
 
     try:
-        image_path, mnt_point = fs_helper.setup_image(ubman, 0, 0xc,
-                                                      basename='test_efi_secboot_intca')
-
-        # Create signature database
-        # PK
-        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_PK/ -keyout PK.key -out PK.crt -nodes -days 365'
-                   % mnt_point, shell=True)
-        check_call('cd %s; %scert-to-efi-sig-list -g %s PK.crt PK.esl; %ssign-efi-sig-list -t "2020-04-01" -c PK.crt -k PK.key PK PK.esl PK.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        # PK_null for deletion
-        check_call('cd %s; touch PK_null.esl; %ssign-efi-sig-list -c PK.crt -k PK.key PK PK_null.esl PK_null.auth'
-                   % (mnt_point, EFITOOLS_PATH), shell=True)
-        # KEK
-        check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_KEK/ -keyout KEK.key -out KEK.crt -nodes -days 365'
-                   % mnt_point, shell=True)
-        check_call('cd %s; %scert-to-efi-sig-list -g %s KEK.crt KEK.esl; %ssign-efi-sig-list -c PK.crt -k PK.key KEK KEK.esl KEK.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-
-        # We will have three-tier hierarchy of certificates:
-        #   TestRoot: Root CA (self-signed)
-        #   TestSub: Intermediate CA (signed by Root CA)
-        #   TestCert: User certificate (signed by Intermediate CA, and used
-        #             for signing an image)
-        #
-        # NOTE:
-        # I consulted the following EDK2 document for certificate options:
-        #     BaseTools/Source/Python/Pkcs7Sign/Readme.md
-        # Please not use them as they are in product system. They are
-        # for test purpose only.
-
-        # TestRoot
-        check_call('cp %s/test/py/tests/test_efi_secboot/openssl.cnf %s'
-                   % (ubman.config.source_dir, mnt_point), shell=True)
-        check_call('cd %s; export OPENSSL_CONF=./openssl.cnf; openssl genrsa -out TestRoot.key 2048; openssl req -extensions v3_ca -new -x509 -days 365 -key TestRoot.key -out TestRoot.crt -subj "/CN=TEST_root/"; touch index.txt; touch index.txt.attr'
-                   % mnt_point, shell=True)
-        # TestSub
-        check_call('cd %s; touch serial.new; export OPENSSL_CONF=./openssl.cnf; openssl genrsa -out TestSub.key 2048; openssl req -new -key TestSub.key -out TestSub.csr -subj "/CN=TEST_sub/"; openssl ca -in TestSub.csr -out TestSub.crt -extensions v3_int_ca -days 365 -batch -rand_serial -cert TestRoot.crt -keyfile TestRoot.key'
-                   % mnt_point, shell=True)
-        # TestCert
-        check_call('cd %s; touch serial.new; export OPENSSL_CONF=./openssl.cnf; openssl genrsa -out TestCert.key 2048; openssl req -new -key TestCert.key -out TestCert.csr -subj "/CN=TEST_cert/"; openssl ca -in TestCert.csr -out TestCert.crt -extensions usr_cert -days 365 -batch -rand_serial -cert TestSub.crt -keyfile TestSub.key'
-                   % mnt_point, shell=True)
-        # db
-        #  for TestCert
-        check_call('cd %s; %scert-to-efi-sig-list -g %s TestCert.crt TestCert.esl; %ssign-efi-sig-list -c KEK.crt -k KEK.key db TestCert.esl db_a.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        #  for TestSub
-        check_call('cd %s; %scert-to-efi-sig-list -g %s TestSub.crt TestSub.esl; %ssign-efi-sig-list -t "2020-07-16" -c KEK.crt -k KEK.key db TestSub.esl db_b.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        #  for TestRoot
-        check_call('cd %s; %scert-to-efi-sig-list -g %s TestRoot.crt TestRoot.esl; %ssign-efi-sig-list -t "2020-07-17" -c KEK.crt -k KEK.key db TestRoot.esl db_c.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        ## dbx (hash of certificate with revocation time)
-        #  for TestCert
-        check_call('cd %s; %scert-to-efi-hash-list -g %s -t "2020-07-20" -s 256 TestCert.crt TestCert.crl; %ssign-efi-sig-list -c KEK.crt -k KEK.key dbx TestCert.crl dbx_a.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        #  for TestSub
-        check_call('cd %s; %scert-to-efi-hash-list -g %s -t "2020-07-21" -s 256 TestSub.crt TestSub.crl; %ssign-efi-sig-list -t "2020-07-18" -c KEK.crt -k KEK.key dbx TestSub.crl dbx_b.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-        #  for TestRoot
-        check_call('cd %s; %scert-to-efi-hash-list -g %s -t "2020-07-22" -s 256 TestRoot.crt TestRoot.crl; %ssign-efi-sig-list -t "2020-07-19" -c KEK.crt -k KEK.key dbx TestRoot.crl dbx_c.auth'
-                   % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
-                   shell=True)
-
-        # Sign image
-        # additional intermediate certificates may be included
-        # in SignedData
-
-        check_call('cp %s/lib/efi_loader/helloworld.efi %s' %
-                   (ubman.config.build_dir, mnt_point), shell=True)
-        # signed by TestCert
-        check_call('cd %s; %ssbsign --key TestCert.key --cert TestCert.crt --out helloworld.efi.signed_a helloworld.efi'
-                   % (mnt_point, SBSIGN_PATH), shell=True)
-        # signed by TestCert with TestSub in signature
-        check_call('cd %s; %ssbsign --key TestCert.key --cert TestCert.crt --addcert TestSub.crt --out helloworld.efi.signed_ab helloworld.efi'
-                   % (mnt_point, SBSIGN_PATH), shell=True)
-        # signed by TestCert with TestSub and TestRoot in signature
-        check_call('cd %s; cat TestSub.crt TestRoot.crt > TestSubRoot.crt; %ssbsign --key TestCert.key --cert TestCert.crt --addcert TestSubRoot.crt --out helloworld.efi.signed_abc helloworld.efi'
-                   % (mnt_point, SBSIGN_PATH), shell=True)
-
-        fsfile = fs_helper.mk_fs(ubman.config, 'vfat', 0x1000000,
-                                 'test_efi_secboot_intca', mnt_point)
-        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
-
+        with DiskHelper(ubman.config, 0, 'test_efi_secboot_intca') as img, \
+                FsHelper(ubman.config, 'vfat', 16,
+                         'test_efi_secboot_intca') as fsh:
+            mnt_point = fsh.srcdir
+
+            # Create signature database
+            # PK
+            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_PK/ -keyout PK.key -out PK.crt -nodes -days 365'
+                       % mnt_point, shell=True)
+            check_call('cd %s; %scert-to-efi-sig-list -g %s PK.crt PK.esl; %ssign-efi-sig-list -t "2020-04-01" -c PK.crt -k PK.key PK PK.esl PK.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            # PK_null for deletion
+            check_call('cd %s; touch PK_null.esl; %ssign-efi-sig-list -c PK.crt -k PK.key PK PK_null.esl PK_null.auth'
+                       % (mnt_point, EFITOOLS_PATH), shell=True)
+            # KEK
+            check_call('cd %s; openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=TEST_KEK/ -keyout KEK.key -out KEK.crt -nodes -days 365'
+                       % mnt_point, shell=True)
+            check_call('cd %s; %scert-to-efi-sig-list -g %s KEK.crt KEK.esl; %ssign-efi-sig-list -c PK.crt -k PK.key KEK KEK.esl KEK.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+
+            # We will have three-tier hierarchy of certificates:
+            #   TestRoot: Root CA (self-signed)
+            #   TestSub: Intermediate CA (signed by Root CA)
+            #   TestCert: User certificate (signed by Intermediate CA, and used
+            #             for signing an image)
+            #
+            # NOTE:
+            # I consulted the following EDK2 document for certificate options:
+            #     BaseTools/Source/Python/Pkcs7Sign/Readme.md
+            # Please not use them as they are in product system. They are
+            # for test purpose only.
+
+            # TestRoot
+            check_call('cp %s/test/py/tests/test_efi_secboot/openssl.cnf %s'
+                       % (ubman.config.source_dir, mnt_point), shell=True)
+            check_call('cd %s; export OPENSSL_CONF=./openssl.cnf; openssl genrsa -out TestRoot.key 2048; openssl req -extensions v3_ca -new -x509 -days 365 -key TestRoot.key -out TestRoot.crt -subj "/CN=TEST_root/"; touch index.txt; touch index.txt.attr'
+                       % mnt_point, shell=True)
+            # TestSub
+            check_call('cd %s; touch serial.new; export OPENSSL_CONF=./openssl.cnf; openssl genrsa -out TestSub.key 2048; openssl req -new -key TestSub.key -out TestSub.csr -subj "/CN=TEST_sub/"; openssl ca -in TestSub.csr -out TestSub.crt -extensions v3_int_ca -days 365 -batch -rand_serial -cert TestRoot.crt -keyfile TestRoot.key'
+                       % mnt_point, shell=True)
+            # TestCert
+            check_call('cd %s; touch serial.new; export OPENSSL_CONF=./openssl.cnf; openssl genrsa -out TestCert.key 2048; openssl req -new -key TestCert.key -out TestCert.csr -subj "/CN=TEST_cert/"; openssl ca -in TestCert.csr -out TestCert.crt -extensions usr_cert -days 365 -batch -rand_serial -cert TestSub.crt -keyfile TestSub.key'
+                       % mnt_point, shell=True)
+            # db
+            #  for TestCert
+            check_call('cd %s; %scert-to-efi-sig-list -g %s TestCert.crt TestCert.esl; %ssign-efi-sig-list -c KEK.crt -k KEK.key db TestCert.esl db_a.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            #  for TestSub
+            check_call('cd %s; %scert-to-efi-sig-list -g %s TestSub.crt TestSub.esl; %ssign-efi-sig-list -t "2020-07-16" -c KEK.crt -k KEK.key db TestSub.esl db_b.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            #  for TestRoot
+            check_call('cd %s; %scert-to-efi-sig-list -g %s TestRoot.crt TestRoot.esl; %ssign-efi-sig-list -t "2020-07-17" -c KEK.crt -k KEK.key db TestRoot.esl db_c.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            ## dbx (hash of certificate with revocation time)
+            #  for TestCert
+            check_call('cd %s; %scert-to-efi-hash-list -g %s -t "2020-07-20" -s 256 TestCert.crt TestCert.crl; %ssign-efi-sig-list -c KEK.crt -k KEK.key dbx TestCert.crl dbx_a.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            #  for TestSub
+            check_call('cd %s; %scert-to-efi-hash-list -g %s -t "2020-07-21" -s 256 TestSub.crt TestSub.crl; %ssign-efi-sig-list -t "2020-07-18" -c KEK.crt -k KEK.key dbx TestSub.crl dbx_b.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+            #  for TestRoot
+            check_call('cd %s; %scert-to-efi-hash-list -g %s -t "2020-07-22" -s 256 TestRoot.crt TestRoot.crl; %ssign-efi-sig-list -t "2020-07-19" -c KEK.crt -k KEK.key dbx TestRoot.crl dbx_c.auth'
+                       % (mnt_point, EFITOOLS_PATH, GUID, EFITOOLS_PATH),
+                       shell=True)
+
+            # Sign image
+            # additional intermediate certificates may be included
+            # in SignedData
+
+            check_call('cp %s/lib/efi_loader/helloworld.efi %s' %
+                       (ubman.config.build_dir, mnt_point), shell=True)
+            # signed by TestCert
+            check_call('cd %s; %ssbsign --key TestCert.key --cert TestCert.crt --out helloworld.efi.signed_a helloworld.efi'
+                       % (mnt_point, SBSIGN_PATH), shell=True)
+            # signed by TestCert with TestSub in signature
+            check_call('cd %s; %ssbsign --key TestCert.key --cert TestCert.crt --addcert TestSub.crt --out helloworld.efi.signed_ab helloworld.efi'
+                       % (mnt_point, SBSIGN_PATH), shell=True)
+            # signed by TestCert with TestSub and TestRoot in signature
+            check_call('cd %s; cat TestSub.crt TestRoot.crt > TestSubRoot.crt; %ssbsign --key TestCert.key --cert TestCert.crt --addcert TestSubRoot.crt --out helloworld.efi.signed_abc helloworld.efi'
+                       % (mnt_point, SBSIGN_PATH), shell=True)
+
+            fsh.mk_fs()
+            img.add_fs(fsh, DiskHelper.VFAT)
+            yield img.create()
     except CalledProcessError as e:
         pytest.skip('Setup failed: %s' % e.cmd)
         return
-    else:
-        yield image_path
-    finally:
-        call('rm -rf %s' % mnt_point, shell=True)
-        call('rm -f %s %s' % (image_path, fsfile), shell=True)
-- 
2.43.0

