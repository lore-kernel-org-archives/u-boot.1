Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B87D149F2
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 21:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E185988F68;
	Fri, 25 Oct 2024 23:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VldYf6eu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD02889016; Fri, 25 Oct 2024 23:15:20 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDF188B23
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 23:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 07F823FD23; 
 Fri, 25 Oct 2024 21:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729890918;
 bh=vcjwSasu5W+HFVg+qkE+c/AWcm+YRQ+XSRH9FtQfYAY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=VldYf6eub9u/w3OwDDbYVxeh0HK07MG+5LYRrdRnmXsylpbe78O66qCxHhTZedGDL
 OC7SGVRM2mXIPHbZRSoYjm0+WUa751cxOcjbSsCK6tAauhref6kusb27TQJfkF+VEs
 KioH5ebDmKc5z0FSlgcT5RsjSYE8qHYxYS8NrUZHpT+S8xeMf1hFuRGEI7EsiQoLpG
 4+IWGb4u9305MVYqxHCj4AzdBORAJGkg1lueQ/M1P1ga5i03OchDntEyazEyaucxuA
 6t+rpBsChg8czdlDuRmGJQeJ8oRYuL4DViuo1OWJTe2dNqBVBrT/95Tb3Z0GlfcSTf
 3SFsS5lOuKCHw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] cmd/eficonfig: capitalize 'enter description'
Date: Fri, 25 Oct 2024 23:15:05 +0200
Message-ID: <20241025211505.361296-1-heinrich.schuchardt@canonical.com>
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

To conform with other messages capitalize the first letter:
%s/enter description/Enter description/g

Adjust the unit tests accordingly.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/eficonfig.c                                | 2 +-
 test/py/tests/test_eficonfig/test_eficonfig.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index bea09e4ecc7..029180250f0 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -963,7 +963,7 @@ static efi_status_t eficonfig_boot_add_enter_description(void *data)
 	return handle_user_input(bo->description, EFICONFIG_DESCRIPTION_MAX, 22,
 				 "\n  ** Edit Description **\n"
 				 "\n"
-				 "  enter description: ");
+				 "  Enter description: ");
 }
 
 /**
diff --git a/test/py/tests/test_eficonfig/test_eficonfig.py b/test/py/tests/test_eficonfig/test_eficonfig.py
index 1d8e033f75d..d98de5249df 100644
--- a/test/py/tests/test_eficonfig/test_eficonfig.py
+++ b/test/py/tests/test_eficonfig/test_eficonfig.py
@@ -117,7 +117,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         press_up_down_enter_and_wait(0, 0, True, 'Quit')
 
         # Press the enter key to select 'Description:' entry, then enter Description
-        press_up_down_enter_and_wait(0, 0, True, 'enter description:')
+        press_up_down_enter_and_wait(0, 0, True, 'Enter description:')
         # Send Description user input, press ENTER key to complete
         send_user_input_and_wait('test 1', 'Quit')
 
@@ -166,7 +166,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         press_up_down_enter_and_wait(0, 0, True, 'Quit')
 
         # Press the enter key to select 'Description:' entry, then enter Description
-        press_up_down_enter_and_wait(0, 0, True, 'enter description:')
+        press_up_down_enter_and_wait(0, 0, True, 'Enter description:')
         # Send Description user input, press ENTER key to complete
         send_user_input_and_wait('test 2', 'Quit')
 
@@ -278,7 +278,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
             u_boot_console.p.expect([i])
 
         # Press the enter key to select 'Description:' entry, then enter Description
-        press_up_down_enter_and_wait(0, 0, True, 'enter description:')
+        press_up_down_enter_and_wait(0, 0, True, 'Enter description:')
         # Send Description user input, press ENTER key to complete
         send_user_input_and_wait('test 3', 'Quit')
 
-- 
2.45.2

