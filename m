Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0DBC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C59380E94;
	Wed, 22 Jan 2025 18:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mcex1gWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ACBB80C99; Wed, 22 Jan 2025 18:10:04 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE6FA80977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21644aca3a0so162867325ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565800; x=1738170600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGAd0efUWdPNOkAUyf23XX0Z60/qpa9/AtvevIAStWA=;
 b=mcex1gWPpjbc7vTSoO8zfR/bQ+AniIkLAPZ1p1109FOv87fffjUXZUWcDPf5mWK3UB
 dj+XZf8Lf793PxPeQoI5QbrDoQ62TeFU2lg5vfnH4MngFiETF7eQFDmLAXarvc2Rbm0/
 4OwgubZRkOje4g+FnUGMW8ivqTYEraVAUV6Aa5jR5uWgj8K6ewLWbeyJlYxxAfUfwzEH
 C3szChZwOmAU0ZP2Q0CuyNPPjnyevZUtKflIKeHA2Llo17imC5mP8YScPuvB4NikncrQ
 IthobajEUMO5cH5Cw2IjVX08RhVPBI/qN3N5VhleK6DKunuLmhZ7c1mOEYfVFPBd+5UJ
 kv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565800; x=1738170600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DGAd0efUWdPNOkAUyf23XX0Z60/qpa9/AtvevIAStWA=;
 b=SXTAzpVreNdEAtEZtXg/wWBK6LQET2Wnm8JXcqe0tw/F5XQFgV0RJAfkvd3jrYaBhW
 B9t9rFcnoQhskQv7JLezOoShQ6pKLOG+WTDeYMXnWILdhABFiEVgpFbgUyeyIUwe3tIU
 FDonprBZ9yR8/hVW4jx8XKkifoem8lKnzcxMTRKre8ndlvoDo9TAoUBdzQFlyg9VOisp
 ihwZW9m+Voq41NZlAsc+UPmfZKzF+gnXCC4WYoYBaPJbJ4FftvHcKGWAoqJ4WgkfH461
 aDbveN+rfyYmfFK4tvY/RKJbSPV2JD/B4LKkBXruRGleSAyattIUOYvoexI8Lmccd7dw
 w6fw==
X-Gm-Message-State: AOJu0YyTLz/3OoeotRZL/AqXJ/Dlu0X/5okOTbPe9O4rniUmpAWHuiPD
 q5h8kdrMog1bhS6eysaA8pOjFdFiNuTcwhZmcxjydVhSioiRwRoR/Q+OpPhL
X-Gm-Gg: ASbGnct+qt3zN+VAT1l9zpvTzbcuVCGUrO3WfRpmEYT4cGgwFxLGa4PnLWiiRoE14gx
 wlo+7e2BYlU5euD9/JvynFz3ipEJ0rJYHYPhwEAYyNhfdAF7qXxhudiA2QnPv1GCq5sB+H9Da/p
 okyCKk3YEq6fG1CyPlHiq/nMpiz0xx5hMj46vTsnM+n5LIOZTv29abTv+A3VpmmQGd0DoCjnau8
 OykjB8HnrlA8asfe2BOo56hHdPJ77Kz3Q04JyJpgGz6SU1UEtfl15F4vRCRz4vqEic0uZKGric0
 vw==
X-Google-Smtp-Source: AGHT+IGgCNWZeFkI10ltKfibb4ElJ3UaYGsW+bAPVPOdPPW3SXtcUmipD7OgJI3zCRt2Px4qMA0O7A==
X-Received: by 2002:a17:902:e802:b0:212:615f:c1 with SMTP id
 d9443c01a7336-21c3540a0admr366207915ad.14.1737565800335; 
 Wed, 22 Jan 2025 09:10:00 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:10:00 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 19/21] py/tests: test_efi_selftest: Add test for counting EFI
 netdevices
Date: Wed, 22 Jan 2025 14:08:56 -0300
Message-ID: <20250122170858.961359-20-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122170858.961359-1-adriano.cordova@canonical.com>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
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

check that the number of ethernet udevices matches the number of simple
network protocols

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 test/py/tests/test_efi_selftest.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
index 310d8ed294..af9992a6f7 100644
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
2.43.0

