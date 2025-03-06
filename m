Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5765BC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F372814A4;
	Fri,  7 Mar 2025 00:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iHjEuAbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E67805D7; Fri,  7 Mar 2025 00:23:18 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7368144A
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fd9d9ae47cso12505297b3.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303393; x=1741908193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1QmPOUfRT30tgCz1TAZmKHnSYwHH4S7UAY4hW83tv8=;
 b=iHjEuAbEQJ4lpHheKrHPsgumhDqOOAIHVQKkuUBT01OVmii49DIMF3+sDFQF7M3deS
 XvKi2Hv27SYGz8GZb5LzsKkJh6lODG3UROHEiWGp6oGhPXQt0VC6DwzXpElaxS9rGTXo
 vMU1jynEnR097A+JU8wJ3E05sBxVtcqIivI+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303393; x=1741908193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1QmPOUfRT30tgCz1TAZmKHnSYwHH4S7UAY4hW83tv8=;
 b=JZOT9mWr1bdLM49+BK5VS73mXWMqBKzP7SkxX1N1trTw39gh3tGxUnHhu4Hz97YVse
 lzeB1W/5H1wT6dgHE7FQCpCsIXBxtAqlHMr0befUVfTQzV06zd3vH4GNTAYdyNi6OyFo
 rneoMvQcF9fE6kZB5iFrs/iOaFXo2wep5ozhkEkdt/J3eRMahf1g9NJYZdu8aaX7yh4e
 IwVLxslmu6cDaf0aztvGI66yV/86HdMSl8NsVSRrXTQ7jWgIFuvJtsYhtOVTkbwNk+Yy
 ULAEIVGUHCv0N5a2HP5y6u+rlSAkoz6YScDwgNr5scjS58TVDuLOBkfoXAZCA6KwlkVy
 mtbw==
X-Gm-Message-State: AOJu0YyyUswnS7oJQu8xMO5JHXrCcOlwifs9hcBScA+mYxwRn4qxkx6l
 TDPakolQ69JWaSP5mQ45TG7mzM5WddKiQHLM7fJG+Hkv89VaSY7a4AIjWDoLpy2ZSlKPDPHy22b
 g
X-Gm-Gg: ASbGncss2+oEr1z2HjsE1R6CrmoxMxF1CZjvnyS/Gy1Si7mTPIxmvYSlixOz1inJbun
 ylElrCfZn2+Dy4VwtF+86Rg9wY4Bc0oE15PYiNAfxJXT4JYC9r0vraeyJNemmJevzTrIAqnu2V4
 mh024KhGZyypTHo98yNIlwFzZVa0u0Uaf0gSpsbh+d7Z1Ly+nFJLYiLCafqL2QOhCTOsPXcs0rh
 P2kR4x9jOJMBNC9XqyZZUBIWIvbvykAtQ1ZfXNVD2Q0y3qfSqT55j1Dbrp1fV11RWDbusLKoOD+
 hqmx+9u1zqrsUQuw6T1EqNn3VRydGfM1yPE/VcDrTQSZH9Cg
X-Google-Smtp-Source: AGHT+IHt25P6iqSez079Avgnd1RxiJxTUVDlMvOA7Mhs6LQxiLx7W7lf0Tqv7XZCtom+57jprPaWcg==
X-Received: by 2002:a05:690c:6f0a:b0:6f0:23da:49a3 with SMTP id
 00721157ae682-6febf295f42mr21323957b3.8.1741303392879; 
 Thu, 06 Mar 2025 15:23:12 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 08/10] test/py: Rework test_efi_secboot to not use virt-make-fs
Date: Thu,  6 Mar 2025 17:17:10 -0600
Message-ID: <20250306232256.4150882-9-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306232256.4150882-1-trini@konsulko.com>
References: <20250306232256.4150882-1-trini@konsulko.com>
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

The problem with using "virt-make-fs" to make a filesystem image is that
it is extremely slow. Switch to using the fs_helper functions we have
instead from the filesystem tests as these can add files to images and
are significantly faster and still do not require root access.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 test/py/tests/test_efi_secboot/conftest.py | 32 ++++++++++------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
index 0fa0747fc764..bd05bfc55c7d 100644
--- a/test/py/tests/test_efi_secboot/conftest.py
+++ b/test/py/tests/test_efi_secboot/conftest.py
@@ -5,6 +5,7 @@
 """Fixture for UEFI secure boot test."""
 
 from subprocess import call, check_call, CalledProcessError
+from tests import fs_helper
 import pytest
 from defs import *
 
@@ -19,13 +20,10 @@ def efi_boot_env(request, u_boot_config):
     Return:
         A path to disk image to be used for testing
     """
-    image_path = u_boot_config.persistent_data_dir
-    image_path = image_path + '/test_efi_secboot.img'
 
     try:
-        mnt_point = u_boot_config.build_dir + '/mnt_efisecure'
-        check_call('rm -rf {}'.format(mnt_point), shell=True)
-        check_call('mkdir -p {}'.format(mnt_point), shell=True)
+        image_path, mnt_point = fs_helper.setup_image(u_boot_config, 0, 0xc,
+                                                      basename='test_efi_secboot')
 
         # suffix
         # *.key: RSA private key in PEM
@@ -123,9 +121,9 @@ def efi_boot_env(request, u_boot_config):
                    % (mnt_point, EFITOOLS_PATH),
                    shell=True)
 
-        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(
-            mnt_point, image_path), shell=True)
-        check_call('rm -rf {}'.format(mnt_point), shell=True)
+        fsfile = fs_helper.mk_fs(u_boot_config, 'vfat', 0x1000000,
+                                 'test_efi_secboot', mnt_point)
+        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
 
     except CalledProcessError as exception:
         pytest.skip('Setup failed: %s' % exception.cmd)
@@ -133,7 +131,8 @@ def efi_boot_env(request, u_boot_config):
     else:
         yield image_path
     finally:
-        call('rm -f %s' % image_path, shell=True)
+        call('rm -rf %s' % mnt_point, shell=True)
+        call('rm -f %s %s' % (image_path, fsfile), shell=True)
 
 #
 # Fixture for UEFI secure boot test of intermediate certificates
@@ -154,13 +153,10 @@ def efi_boot_env_intca(request, u_boot_config):
     Return:
         A path to disk image to be used for testing
     """
-    image_path = u_boot_config.persistent_data_dir
-    image_path = image_path + '/test_efi_secboot_intca.img'
 
     try:
-        mnt_point = u_boot_config.persistent_data_dir + '/mnt_efi_secboot_intca'
-        check_call('rm -rf {}'.format(mnt_point), shell=True)
-        check_call('mkdir -p {}'.format(mnt_point), shell=True)
+        image_path, mnt_point = fs_helper.setup_image(u_boot_config, 0, 0xc,
+                                                      basename='test_efi_secboot_intca')
 
         # Create signature database
         # PK
@@ -242,8 +238,9 @@ def efi_boot_env_intca(request, u_boot_config):
         check_call('cd %s; cat TestSub.crt TestRoot.crt > TestSubRoot.crt; %ssbsign --key TestCert.key --cert TestCert.crt --addcert TestSubRoot.crt --out helloworld.efi.signed_abc helloworld.efi'
                    % (mnt_point, SBSIGN_PATH), shell=True)
 
-        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(mnt_point, image_path), shell=True)
-        check_call('rm -rf {}'.format(mnt_point), shell=True)
+        fsfile = fs_helper.mk_fs(u_boot_config, 'vfat', 0x1000000,
+                                 'test_efi_secboot_intca', mnt_point)
+        check_call(f'dd if={fsfile} of={image_path} bs=1M seek=1', shell=True)
 
     except CalledProcessError as e:
         pytest.skip('Setup failed: %s' % e.cmd)
@@ -251,4 +248,5 @@ def efi_boot_env_intca(request, u_boot_config):
     else:
         yield image_path
     finally:
-        call('rm -f %s' % image_path, shell=True)
+        call('rm -rf %s' % mnt_point, shell=True)
+        call('rm -f %s %s' % (image_path, fsfile), shell=True)
-- 
2.43.0

