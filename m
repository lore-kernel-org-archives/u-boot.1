Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A6BC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D338380C68;
	Wed, 22 Jan 2025 18:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/ElRtyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B9E680C68; Wed, 22 Jan 2025 18:10:08 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5B480977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2161eb94cceso90665385ad.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565803; x=1738170603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXSJMzfXyuVcLkVCUyAuuHg6LTADZ+V1HllC5JNpAAk=;
 b=T/ElRtylY6djNUlkvvDcP5Dh3v3q/wkIxcz6WDmLCaVyH1qz6D+q6/dLi/edwp2Txj
 L6oTmL7efs7IWuhrajA13rER+uUDNTICDIX6+NGDHDqs7rXKtWrUAChx33lIKSo4zDxU
 lxP30aYHXpvSgeBT9uuSEcIzdRrctWLl3p9oz9qV7TmSALO5qcaBLs2eAmg3/v6XSXgJ
 Wmo4Nc/goNuIzYhb1AEEtKnUo6Gh+4bxaWLBGMYyiQrHqNhY4ygOYqzLPHagJr+eTv7l
 Yawc73rIzWb9w8tiPwyi6+ymmZzKBGHqygJn+pRJOc3qvNvRS+8s0E+oJj63kNCnv3Lc
 VF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565803; x=1738170603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXSJMzfXyuVcLkVCUyAuuHg6LTADZ+V1HllC5JNpAAk=;
 b=FP3rnQgdeunVwU+fZy9Xs5iWYqX5hMx8/rxm6efA1ACk7pbG2/kcpkZgJdEKuyBcZ/
 USn6QVH8jo0wSAxXmtg5KGYatfEsHYcR3Jf9byiqMAJRk6YxLxkl5Qq9FP4Y/IKckUa3
 hQrNThwPquQ4remLAS/+UdZMzBhzNnA1CsP1nJYl2ecG0n36rctFNTw4FQwpimdetn+1
 4PMX/QInRZ15nXqhYB+V++Nz95hLI1VTpf/ZET1x0n3evr/6UZHt0/8XEU/CqOConW7Y
 6pFQeY2wOFarlIp3MgmRKKCoKX6Gg4FnEaVbhMYLXMtVzR0K13PsoreoL8QFUcVBNqLn
 zKYg==
X-Gm-Message-State: AOJu0YynGYvn3dzAp07ClVyc6ZqThRucZIUgTlHXowN5uhtQCDX3hjNj
 2vlsKHglB72roosSPWXQUAkm7n/sIlZC/lQSC5+c/Qh126VB8ax/pmU9CjhH
X-Gm-Gg: ASbGncsMdGKpL1cUsOJpnaM0ltxk4JBNgQPIXfNWZ1JKeSimqPCZwWCxMkVCwZX1cWa
 YS0eBvdZZUE0s1rLuSTiO9LHPrNrs+6I90OnnsFtkpmf+/PVUqEl/Nvtzkwjj9ieyJ7PvP2Ybif
 SzV7dSpFrrpe3EiFYgQ/VtE4Zq6KLjM+BAB+Nv72xyeEn20T21oQqxsgVvaY9mHywZnlzSsVjf8
 LrpjHR4jtad3WuunhjMBwztg4J8COmQ4YqPnxcnixpQFIQB1JPYNMsgfb898Tz8EeBhxHGQDm9E
 IQ==
X-Google-Smtp-Source: AGHT+IHgAp+UEyLucwf2mxG0RXL2tIEtmLcWOzS5E4Na2F/DoFsqNw1T/++3JPTVX3V2flap9Z0DqA==
X-Received: by 2002:a17:903:41c3:b0:216:57a6:2887 with SMTP id
 d9443c01a7336-21c355444d1mr350523725ad.21.1737565802910; 
 Wed, 22 Jan 2025 09:10:02 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:10:02 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 20/21] py/tests: test_efi_selftest: Add test for removing EFI
 netdevices
Date: Wed, 22 Jan 2025 14:08:57 -0300
Message-ID: <20250122170858.961359-21-adriano.cordova@canonical.com>
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

unbind ethernet udevices and count them to check that were properly removed
also from the EFI network stack

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 test/py/tests/test_efi_selftest.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
index af9992a6f7..2b7944d198 100644
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
2.43.0

