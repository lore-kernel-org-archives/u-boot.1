Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DFDC54E5D
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 09:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AC8487C2D;
	Sat, 16 Mar 2024 10:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S97cyoom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 587F187D02; Sat, 16 Mar 2024 10:57:47 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5555087BF1
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 10:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D4E0544855; 
 Sat, 16 Mar 2024 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710583065;
 bh=otf4whz0JtpiQMybOq5MPX85nzsL98j01eXiPznTSwo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=S97cyoomstfqEK1s+4qJ6uj2yqNs6fTpLB2n2+CdM/A4ICW+Q8NrA9irmcvHB2L/I
 /EVwaANsH0xZGAJfJJ+gJTfyNNRM2WXK8TxpjW5CQ558z8EeRjDQij/S4P1St1tzf8
 QfRhkCruBJTsDxdVymGAgwbDCLY+ureKz2KjnuKN1kRPuVPhTvoBVw8eojlwGFJwH7
 G/TJMdEAfMwoFOdXPoxlgJYe1SJGLNO+WURQksU2xxkXCeHZQ/WhFQJOahOLcE3MQI
 0JrJazMFrVPeZYgjYnuMFNz+I0S6/EDOzOszYz/17OdEvwQH6q9KNrFovevhB2F7Q/
 d82G2gpMLM3rg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] doc: man-page for if
Date: Sat, 16 Mar 2024 10:57:41 +0100
Message-ID: <20240316095741.58258-1-heinrich.schuchardt@canonical.com>
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

Provide a man-page for the if command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/if.rst | 72 ++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst  |  1 +
 2 files changed, 73 insertions(+)
 create mode 100644 doc/usage/cmd/if.rst

diff --git a/doc/usage/cmd/if.rst b/doc/usage/cmd/if.rst
new file mode 100644
index 00000000000..6b3dbe7b0a0
--- /dev/null
+++ b/doc/usage/cmd/if.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. index::
+   single: if (command)
+
+if command
+==========
+
+Synopsis
+--------
+
+::
+
+    if <test statement>
+    then
+        <statements>
+    fi
+
+    if <test statement>
+    then
+        <statements>
+    else
+        <statements>
+    fi
+
+Description
+-----------
+
+The if command is used to conditionally execute statements.
+
+test statement
+    Any command. The test statement set the $? variable. If the value of
+    $? becomes 0 (true) the statements after the **then** statement will
+    be executed. Otherwise the statements after the **else** statement.
+
+Example
+-------
+
+The examples shows how the value of a numeric variable can be tested with
+**itest**.
+
+::
+
+    => a=1; if itest $a == 0; then echo true; else echo false; fi
+    false
+    => a=0; if itest $a == 0; then echo true; else echo false; fi
+    true
+
+In the following example we try to load an EFI binary via TFTP. If loading
+succeeds, the binary is executed.
+
+::
+
+    if tftp $kernel_addr_r shellriscv64.efi; then bootefi $kernel_addr_r; fi
+
+Return value
+------------
+
+The value of $? is the return value of the last executed statement.
+
+::
+
+    => if true; then true; else true; fi; echo $?
+    0
+    => if false; then true; else true; fi; echo $?
+    0
+    => if false; then false; else false; fi; echo $?
+    1
+    => if true; then false; else false; fi; echo $?
+    1
+    => if false; then true; fi; echo $?
+    1
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 0d174eefaa5..66d73e70cc4 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -71,6 +71,7 @@ Shell commands
    cmd/gpt
    cmd/history
    cmd/host
+   cmd/if
    cmd/imxtract
    cmd/load
    cmd/loadb
-- 
2.43.0

