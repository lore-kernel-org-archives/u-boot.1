Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9A9C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64E681761;
	Tue, 11 Mar 2025 17:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="co6+XpXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B798181A02; Tue, 11 Mar 2025 17:48:28 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72C6681760
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2239c066347so103078855ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711705; x=1742316505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6aPaztCGQiGSTy7CyiKP3+ErAT3mWPcH7u6ckW9AFEE=;
 b=co6+XpXlO+JfUOmKB8ISE3G6bfGs/lw16ssQwxS+2PX34DL9/v1DErlQMsMt3t3PBo
 rLBUfVowM3ksr/DXEBWy1WzxbSG+oh7A8+9K0a0xR1ypdFZ+3Fn/Qkai55o5Nqkbr1ya
 wMbA+u86/qPOI8AlZzgzF/iPMBJkwpPSqHbitLXvOEog1rUe07oayvxlgqLWTy7OCsS/
 en03mnSf9qCTgAd311MW/7nPugu82YcwDx+kBkSf1ButWBxJYPBHPWKx08bWezYgjly3
 49dfqd2tn3TEB0Vim8MfXo4thzXhyzCkHWwO6NJyYXsChxst2FJj1NhDsuyufPeIKLfo
 bKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711705; x=1742316505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6aPaztCGQiGSTy7CyiKP3+ErAT3mWPcH7u6ckW9AFEE=;
 b=XgTUOlLXSRTuMa6QAqa5zT+YK/wTV4Ab7wHY+j0HyWuU6GYsMi7M9lDzTqnKAlkVB1
 inJKTDZhxC35gwHR1CasepCFcbusJSwpayIAYlHitug7JIrACdMp1rFk/dwivGccW4wQ
 KcbigchwyrsfSKWv07T8CVT5R1gNwLiRY2vGWFE/ufT2njQExVpl7WC9tFsOhVkoDkyr
 cZ5Cf5HLFxjAvxjNQAZoeB6OYfDe2vfmd83Y/dD7hFDJCPy9/hiltG066vFy8ZuAr1hI
 68Q3X+J227/IrE5Onn3/rZNr2zdOwDB0jsHVfeoBjw3sw/+U5PUmhJASmzhXi7V87QVf
 5xaw==
X-Gm-Message-State: AOJu0Yy5Lb9CJU2eaWJ9ZxBWdR5/zl/0WaFWkAoui8TW4LRZSL9CAL8R
 zsxOEGSh3LuTdbyroyFjJn5Yio+5sHdZoMJwKQWBhEMPVvmUH71W4avz1WGqsm0=
X-Gm-Gg: ASbGncv0xY0FvckSkB6MA9Iz+ymEdVyQ6y+WQTK1wKAzYN+CSzFEokV7VIhNPMgIFVT
 8bXTQ9U6CzXSTPiQ+5B9JctauLLe2U7H7FtQ3UO4UDNHum13BOrxAMIlAS7edl8VUhRz5jtoKJ/
 1HK882TSjz0X8QotxPv9VO2GbzrfSct5IMcJqGDZtXulH/Z0BRanSCLhir/mNLXIa8ozBiCrQZb
 iOJesKu2BnCLv4GRVCFQngYibZfTwNV4CbI9xIdwX0ecgVfh7Wkf2w3E2HxZ8Aus6q2yni6QZfH
 c01St8eR6vtcUoFIRwuktiVB+6/STQ/CG/83JzoCEYTtkq8k80Ys0Ak=
X-Google-Smtp-Source: AGHT+IHZd/UQ9Q4V1T7Z7OM0zh3PPV098HrRJxhDmGcOmadfNEL8iSRvzREems+36JPqJSwSaGMn7A==
X-Received: by 2002:a17:902:ec92:b0:21c:fb6:7c3c with SMTP id
 d9443c01a7336-22428897d9bmr257683855ad.17.1741711704862; 
 Tue, 11 Mar 2025 09:48:24 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:24 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 15/16] py/tests: test_efi_selftest: Add test for removing EFI
 netdevices
Date: Tue, 11 Mar 2025 13:47:57 -0300
Message-ID: <20250311164758.421900-16-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311164758.421900-1-adriano.cordova@canonical.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 test/py/tests/test_efi_selftest.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
index af9992a6f7f..2b7944d1983 100644
--- a/test/py/tests/test_efi_selftest.py
+++ b/test/py/tests/test_efi_selftest.py
@@ -216,3 +216,27 @@ def test_efi_selftest_count_netdevices(u_boot_console):
     u_boot_console.run_command('bootefi selftest', wait_for_prompt=False)
     if u_boot_console.p.expect([f'Detected {ethernet_count} active EFI net devices']):
         raise Exception('Failures occurred during the EFI selftest')
+
+@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
+@pytest.mark.buildconfigspec('cmd_dm')
+@pytest.mark.buildconfigspec('cmd_bind')
+def test_efi_selftest_remove_netdevices(u_boot_console):
+    """Test the EFI net device driver
+
+    u_boot_console -- U-Boot console
+
+    This function removes all the ETH_UCLASS udevices and
+    calls the EFI net device selftest to check that the EFI driver
+    sees the same.
+    """
+    u_boot_console.restart_uboot()
+    response = u_boot_console.run_command('dm tree')
+    lines = response.splitlines()[2:]
+    ethernet_count = sum(1 for line in lines if line.strip().startswith('ethernet') and '[ + ]' in line)
+
+    for i in range(ethernet_count):
+        u_boot_console.run_command(f'unbind ethernet {i}')
+    u_boot_console.run_command(cmd='setenv efi_selftest netdevices')
+    u_boot_console.run_command('bootefi selftest', wait_for_prompt=False)
+    if u_boot_console.p.expect(['Detected 0 active EFI net devices']):
+        raise Exception('Failures occurred during the EFI selftest')
-- 
2.48.1

