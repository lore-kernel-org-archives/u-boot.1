Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDDDD711BC
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E3389234;
	Wed, 20 Nov 2024 17:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="oBeKVKLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A4089241; Wed, 20 Nov 2024 17:02:02 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id 14FD58920B
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732118515;
 bh=sI8BWmc4F97Xh4OWyCJ8/pqOcdfc+TW7xIGytjfJVEo=;
 h=From:To:CC:Subject:Date:From;
 b=oBeKVKLyhby5a4wLrhKYrKvDRAGOswunW+iZF+FzN8/bROMULhDqDO+hu0H82SomX
 /XNthTcdjLRMjIwSiwuXaLTRvPzdrWhHETY220ruzFxeAznoxc6ajAqWzyMA1+B0Fh
 14C/iAdC93KwQpQKaFY/vfspTYWEvDuVAgjdTTYM22EK0khb+WurTyy7zDwzydxO2m
 Lvxkr1rw8ARVFvtjqhZq6maH2HzZoso5kP5m+OAjzC/MDimdy5CwsMKD/6RK2G+fRq
 fCTxBJaveLK0RO2VJ0IkiWeKjKqtSOVFTEOLvfLA3c8h5PIMHEJ8IGQMn37qKMXR8W
 hVtJxoVeQevcQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V2] env: Switch the callback static list to Kconfig
Date: Wed, 20 Nov 2024 17:01:35 +0100
Message-ID: <20241120160135.28262-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Switch the callback static list from the board configuration variable
CFG_ENV_CALLBACK_LIST_STATIC to Kconfig CONFIG_ENV_CALLBACK_LIST_STATIC.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
V2: - Fix typo in commit message
---
 doc/develop/environment.rst |  4 ++--
 env/Kconfig                 | 13 +++++++++++++
 include/env_callback.h      |  7 +------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/doc/develop/environment.rst b/doc/develop/environment.rst
index e1783462bb..e46cd39d60 100644
--- a/doc/develop/environment.rst
+++ b/doc/develop/environment.rst
@@ -18,8 +18,8 @@ The callbacks are named and associated with a function using the
 U_BOOT_ENV_CALLBACK macro in your board or driver code.
 
 These callbacks are associated with variables in one of two ways.  The
-static list can be added to by defining CFG_ENV_CALLBACK_LIST_STATIC
-in the board configuration to a string that defines a list of
+static list can be added to by defining CONFIG_ENV_CALLBACK_LIST_STATIC
+in the board defconfig via menuconfig to a string that defines a list of
 associations.  The list must be in the following format::
 
     entry = variable_name[:callback_name]
diff --git a/env/Kconfig b/env/Kconfig
index 031cf58186..aaf0b1fe9a 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -21,6 +21,19 @@ config ENV_SOURCE_FILE
 	  environment is assumed to come from the ad-hoc
 	  CFG_EXTRA_ENV_SETTINGS #define
 
+config ENV_CALLBACK_LIST_STATIC
+	string "Static callbacks list"
+	default ""
+	help
+	  The environment callbacks are associated with variables in a
+	  static list. Define this list in the following format:
+
+	  entry = variable_name[:callback_name]
+	  list = entry[,list]
+
+	  If the callback name is not specified, then the callback is deleted.
+	  Spaces are also allowed anywhere in the list.
+
 config SAVEENV
 	def_bool y if CMD_SAVEENV
 
diff --git a/include/env_callback.h b/include/env_callback.h
index bc8ff1923e..47a31f6cf5 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -14,11 +14,6 @@
 
 #define ENV_CALLBACK_VAR ".callbacks"
 
-/* Board configs can define additional static callback bindings */
-#ifndef CFG_ENV_CALLBACK_LIST_STATIC
-#define CFG_ENV_CALLBACK_LIST_STATIC
-#endif
-
 #ifdef CONFIG_SILENT_CONSOLE
 #define SILENT_CALLBACK "silent:silent,"
 #else
@@ -90,7 +85,7 @@
 	SILENT_CALLBACK \
 	"stdin:console,stdout:console,stderr:console," \
 	"serial#:serialno," \
-	CFG_ENV_CALLBACK_LIST_STATIC
+	CONFIG_ENV_CALLBACK_LIST_STATIC
 
 #ifndef CONFIG_XPL_BUILD
 void env_callback_init(struct env_entry *var_entry);
-- 
2.30.2

