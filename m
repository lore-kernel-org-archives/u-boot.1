Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B30C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE3B817D3;
	Tue, 11 Mar 2025 17:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iI+RyvMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D0381761; Tue, 11 Mar 2025 17:48:26 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A9C98198A
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2240b4de12bso14949845ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711703; x=1742316503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG+HNgzuMmF0TqQ+6X7W3kmuCHH34omNFQg817X6hLs=;
 b=iI+RyvMkzDD5JeRWVCM6O6TVFJICGiZ0d3gnCvhrEGoRQ5mgsGfE0bqOZ8XK2XXeBm
 iaLnTJMGPBeeYZYnBZbsvy5LGzmdkVeBGIeIVRRn6rThyR07NYCvsEFz45gjsKeZ2Bkj
 o4lugiLA8YrpApdDLVqLFCRiKBGZdA5GfEbTNBBfWD5RCeZpbsXRmfOGWLcKFaaYGuHd
 eZJt204BfE0Oq2LttEoAG4mwcsf9o7t07UjvbR5CojT3NKm9PGwiumswpbX1+yVruZA5
 s306fPIqVPEJ+a2ddkkDk4ACI1LsLY1ZVmIFe9Ccdqp9KBjJ7/MCO9tBT7mTjFCMOdgA
 6ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711703; x=1742316503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG+HNgzuMmF0TqQ+6X7W3kmuCHH34omNFQg817X6hLs=;
 b=tzNC2G+bdnefa7Oy0BdEVScfM/k+j3gXm/NYUsr9fKJvwOYm/tb1BAyb5eZoIEN8eT
 NS0FCjfQzgFvQdqlGQdK7QCCruTTsQn3suQrIvqprRn294kh8BIx0M0LWi0Jf+9RsDp4
 BD0eCNSpZA+9yGHzhZ819DpCJmrBxgo/DMW9Y7x/Lb2B3P7kumFLu835wMc4yIy82SfV
 n3XXOwzh7GF4lT/+NpKWjCVKZ7SFRYigiIKAVejCR0hBDimfZ8UOpBey/XkI9wwiMZv4
 4ptkdydkp8lklB/LarqR6Tkqvt4rcfi/GSDaQDOUWRfjRxJMK10l4bu521+EiKG5AeOy
 QPaA==
X-Gm-Message-State: AOJu0Yz4fzLTEAOiVLtktMow7IeR+mP5488IQOT+xMQ2Sm1simsZ3Yun
 Tpf6aEb9vEVpSdL+h3Rbbgymg8k2BBUP8fCzcG1JbkIlxwK3R6BMKTgdgyMJFCM=
X-Gm-Gg: ASbGncsMmv845J/8emilFXPYrx+DhVqx9b/vnRnNfeg9uQAcqN85tjKSNFDSsGJI1H/
 5KahH2BgKp535jn1qelrs9s4KULWRQOv95KsfR9QgNrjCj0XO62NxY+ICNnlIe03j/mQoa503de
 x+6r9dfX6ntCOa1IuW7KGMXDXSvvFelLF8fJAdnMw1tTSiYMdCoi9X/OigyVZRBm15DPASY3Vz2
 OBkeJMxil4sevtD6XDFO9px6Td4ptOxyVi7CQYhjH22C/TXqd6fziFs2VX4tsDbFdW0ZbIjz/rY
 sq+sVLVufJ2KSsHOHCFv0xmk+bymKGFFu9YMl5rAwxbIzC+fmpsscqc43FV+9SY5bA==
X-Google-Smtp-Source: AGHT+IGIs1MPFRuH9RCF60w/AZsBVJVMzvr/4BtN5ksmk//vdVcyXcTa+pAPKKPEYXQ4M+I2fgXEwA==
X-Received: by 2002:aa7:8583:0:b0:736:ab48:ea35 with SMTP id
 d2e1a72fcca58-736ab48ec80mr18276654b3a.1.1741711702914; 
 Tue, 11 Mar 2025 09:48:22 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:22 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 14/16] py/tests: test_efi_selftest: Add test for counting EFI
 netdevices
Date: Tue, 11 Mar 2025 13:47:56 -0300
Message-ID: <20250311164758.421900-15-adriano.cordova@canonical.com>
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
 test/py/tests/test_efi_selftest.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
index 310d8ed294a..af9992a6f7f 100644
--- a/test/py/tests/test_efi_selftest.py
+++ b/test/py/tests/test_efi_selftest.py
@@ -195,3 +195,24 @@ def test_efi_selftest_tcg2(u_boot_console):
     if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):
         raise Exception('Failures occurred during the EFI selftest')
     u_boot_console.restart_uboot()
+
+@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
+@pytest.mark.buildconfigspec('cmd_dm')
+def test_efi_selftest_count_netdevices(u_boot_console):
+    """Test the EFI net device driver
+
+    u_boot_console -- U-Boot console
+
+    This function counts the number of ETH_UCLASS probed udevices
+    calls the EFI net device selftest to check that the EFI driver
+    sees the same.
+    """
+    u_boot_console.restart_uboot()
+    response = u_boot_console.run_command('dm tree')
+    lines = response.splitlines()[2:]
+    ethernet_count = sum(1 for line in lines if line.strip().startswith('ethernet') and '[ + ]' in line)
+
+    u_boot_console.run_command(cmd='setenv efi_selftest netdevices')
+    u_boot_console.run_command('bootefi selftest', wait_for_prompt=False)
+    if u_boot_console.p.expect([f'Detected {ethernet_count} active EFI net devices']):
+        raise Exception('Failures occurred during the EFI selftest')
-- 
2.48.1

