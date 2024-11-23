Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93494E66887
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0E8890B9;
	Sat, 23 Nov 2024 22:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YiMcd9yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F51389152; Sat, 23 Nov 2024 22:29:31 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1148905E
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6B882408D8; 
 Sat, 23 Nov 2024 21:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732397368;
 bh=sti9Xh42HkmvYfoSpxP/bDIsVzDV1sEBYJVDMAAUGDU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YiMcd9yfjnGJKpwdjLmXoxDYG6MR6GK3aCWC++3oUbKOblkGnaX8qx9+KnzqrH0KS
 qwgMNIKt3Eqt2DOaV27oMdJFdyVOBAHXpmeHjCn26Yi6o+Q07jfSpYlYCfNkcIKfeC
 Gx1wkFS7kcH7lZ1o48TJX5WuKcEj4ryCKuLTPN5MWPMS1A3IRUBP2uoRCONlWlXtA5
 MF5bV484HoHSy8OMTrHex25mI1joUyWJsbYw+FVmQ8BeFozsinz0o+SqdU8PPYkilE
 63+sTG6dkB9iAcMVsvtaQW0DPcZihBJ4em/NGir2VanV4pYb5C0ZlywkzCHMzo5lVt
 OxvNalHj/pC0A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Love Kumar <love.kumar@amd.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] test: add command to 'Lab failure' timeout message
Date: Sat, 23 Nov 2024 22:29:21 +0100
Message-ID: <20241123212922.304316-1-heinrich.schuchardt@canonical.com>
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

When a timeout occurs while executing a command a 'Lab failure' message is
written and testing is stopped. The user is left in the dark about the
failure cause.

    ! _pytest.outcomes.Exit: Lab failure: Marking connection bad - no other tests will run !

Add the word 'Timeout' and the executed command to the message.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/u_boot_console_base.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index fa9cd57b04b..070ad28ecc9 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -342,8 +342,8 @@ class ConsoleBase(object):
             # indentation.
             return self.p.before.strip('\r\n')
         except Timeout as exc:
-            handle_exception(self.config, self, self.log, exc, 'Lab failure',
-                             True)
+            handle_exception(self.config, self, self.log, exc,
+                             f"Lab failure: Timeout executing '{cmd}'", True)
             raise
         except BootFail as exc:
             handle_exception(self.config, self, self.log, exc, 'Boot fail',
-- 
2.45.2

