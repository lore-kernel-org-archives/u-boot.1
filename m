Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BA0CF318A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 22:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9219488CFC;
	Wed,  2 Oct 2024 00:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sDLBq9oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D9988D4A; Wed,  2 Oct 2024 00:53:51 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788FE88A24
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 00:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-109-215.46.114.pool.telefonica.de
 [46.114.109.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B65813F1E6; 
 Tue,  1 Oct 2024 22:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1727823228;
 bh=nIeUHyopSqUZTMIM0yO5vfPL6msVqQDeJBqxnQtoKuM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=sDLBq9oc0+be0gYA2BfCfYw0Aa/hvsu6QGjrwXvGMYC3S7sueSam3tMMQikCg36xd
 o+9rFFM0OxiLreTgfo43DxKPRqT5slyRvWGs9P71VQwMcxpHX+dQYgQWVQR4Bd/DRf
 GtGMKdJkemishjLywqP3Du+JjBdXL8MGrjIbBWSe6o4l337bFJ3CIJlUocHM4aN95a
 gp1MfAaXtG+dLc2vpQgmV8dDElLoW9LxTbhY/DwkePUtuozrPsBi6Qk+ktoWWgSv2V
 ERmAEJaHm4n8rGy00DOqlmV2qlAb+She2NSCdw3pLa+EcLS1pzC0TqSYmTwguNQdqd
 25K36VVotD0kQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: don't call restart_uboot in EFI watchdog test
Date: Wed,  2 Oct 2024 00:53:35 +0200
Message-ID: <20241001225335.45680-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Calling u_boot_console.restart_uboot() in
test_efi_selftest_watchdog_reboot() may lead to incorrect results.

While the watchdog triggered reboot is running thee test environment may
need some time before triggering a reboot itself. This may lead to
duplicate output of the U-Boot greeter which is recorded as an error.

Reported-by: Tom Rini <trini@konsulko.com>
Fixes: df172e117d1d ("test/py: test reboot by EFI watchdog")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_efi_selftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
index 43f24245582..310d8ed294a 100644
--- a/test/py/tests/test_efi_selftest.py
+++ b/test/py/tests/test_efi_selftest.py
@@ -58,7 +58,7 @@ def test_efi_selftest_watchdog_reboot(u_boot_console):
     u_boot_console.run_command(cmd='bootefi selftest', wait_for_prompt=False)
     if u_boot_console.p.expect(['resetting', 'U-Boot']):
         raise Exception('Reset failed in \'watchdog reboot\' test')
-    u_boot_console.restart_uboot()
+    u_boot_console.run_command(cmd='', send_nl=False, wait_for_reboot=True)
 
 @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
 def test_efi_selftest_text_input(u_boot_console):
-- 
2.45.2

