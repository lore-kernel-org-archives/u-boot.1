Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA348C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 14:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 195C288669;
	Thu,  4 Jul 2024 16:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vLVZlJ5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B8D886A6; Thu,  4 Jul 2024 16:38:00 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71EB6885D7
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 16:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so4722345e9.3
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720103877; x=1720708677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gIsdNMLZqgmxW5xf5L1BwYaBUD4SBJsRko2zp92IYyY=;
 b=vLVZlJ5icyb4lMtdlTZ9CRo0napMVCGz3CG99fTlleOQSDuBCEgau9u494LIxVJgfc
 8FkmO25kT93FYqwXLcOeKk/yqswFqdSvpXNU8Ryshjyt7rS+BuVwr4KXLzmba+jm2C9Q
 g/W0avIotnU5BP613j2rNw5zp2JgZy50hCqqrz5NhUBT9cOqfCS5nFWCPNin5L/5XwGZ
 VItsTCo312+Fz2egCk2KhYcEurzpb0K1c4Lf0glwyueSqacCfA6Gp3nTDgZ75ZwuPthT
 R9UwnKkkDmPbFx+sThBFERXmMtGgHYkyEMy9sp/cJ0nOn6K/FO23TCGscw+esi20wkuE
 1xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720103877; x=1720708677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIsdNMLZqgmxW5xf5L1BwYaBUD4SBJsRko2zp92IYyY=;
 b=PalCmq65ZivzrwvQ0fIJqTiWe6YXJBD6GANJ3NUwCUmREoP6viCnownB5VyvcZPEh1
 kdiCChpwIdhjixR9jQRy3gW/c7Nh3iI8uEXAA/YBT7JuMSjTpzHvGqzMzKrRd5KLRba2
 oIJVZ1PdwFRLw8l69CmVAXRbyJq2B/G2AURhDwGkm1061QI2iCfN1Rghb+/3FU7sRyuv
 ncDqhydx97bZ45Tp0zEu7sM7hRp2eCTD6g7R4p+1u+WS+14uYPGFKJgeOnfXOYBEeb7I
 WUthk9+ckvT3fUhx+PXWmGgGjhBygyLcTBLucqiWRe9UjpbmcRhLsn3OvMSp7QowAqmM
 kGtg==
X-Gm-Message-State: AOJu0YwP18bVi6Zmqe31kz7UyWF2jUw4a2actoABrDY1hKBaIaDfZfDj
 YP5RN7gsz2x7bMWDJgE9qWDfYZbqNrkVzXBUzFk50OAlBq2utx+Xjm2VwRdzKkc=
X-Google-Smtp-Source: AGHT+IFrnmtziqbJm3T52dY1x7mzINlMNIyWHqpOhfig2WtQKXLKbH5TISTAQhFPCQid4YGCoEup2A==
X-Received: by 2002:a7b:c84e:0:b0:424:a4c1:6ee7 with SMTP id
 5b1f17b1804b1-4264a3db5e2mr14953765e9.18.1720103877074; 
 Thu, 04 Jul 2024 07:37:57 -0700 (PDT)
Received: from hades.. (ppp046103011142.access.hol.gr. [46.103.11.142])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d0b19sm27270635e9.10.2024.07.04.07.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 07:37:56 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] test: test for ignore OsIndications
Date: Thu,  4 Jul 2024 17:37:52 +0300
Message-ID: <20240704143752.250847-1-ilias.apalodimas@linaro.org>
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

The tests we currently have expect the firmware update to fail
when OsIndications is not set properly. However, we have a Kconfig flag
that explicitly ignores that variable and trigers the capsule update
regardless. Adjust the tests accordingly

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .../py/tests/test_efi_capsule/test_capsule_firmware_raw.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index 05853578c293..f3a2dff5c2c8 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -95,6 +95,9 @@ class TestEfiCapsuleFirmwareRaw:
             'config_efi_ignore_osindications')
         need_reboot = True if ignore_os_indications else False
 
+        capsule_auth = u_boot_config.buildconfig.get(
+            'config_efi_capsule_authenticate')
+
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
         with u_boot_console.log.section('Test Case 2-b, after reboot'):
@@ -104,10 +107,10 @@ class TestEfiCapsuleFirmwareRaw:
             if not ignore_os_indications:
                 check_file_exist(u_boot_console, disk_img, capsule_files)
 
-            expected = 'u-boot:New' if ignore_os_indications else 'u-boot:Old'
+            expected = 'u-boot:New' if (ignore_os_indications and not capsule_auth) else 'u-boot:Old'
             verify_content(u_boot_console, '100000', expected)
 
-            expected = 'u-boot-env:New' if ignore_os_indications else 'u-boot-env:Old'
+            expected = 'u-boot-env:New' if (ignore_os_indications and not capsule_auth) else 'u-boot-env:Old'
             verify_content(u_boot_console, '150000', expected)
 
     def test_efi_capsule_fw3(
-- 
2.43.0

