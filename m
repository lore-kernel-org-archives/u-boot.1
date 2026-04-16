Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5811CF8D753
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 14:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E14841F2;
	Thu, 16 Apr 2026 16:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="aHDw2hsH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B508420C; Thu, 16 Apr 2026 16:58:07 +0200 (CEST)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [91.218.175.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C305840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776351481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOtCjwnb5nL4pxpt8ORKORTsYzgI3ZH03AVBnwZ7BXI=;
 b=aHDw2hsHLSHnMeo4hDkC5URVeCo8MiDvrKZBkAMyHoT69wgxwsO1L/k6P3gDVdKhLyCo4r
 mirrBmp/Wf9WUbb3GFsQ6eI/jOF4QWTpU00QlpA+TvnIsdgnhtS8Ic28AtwbL41a9P0+P3
 hsO8NyZ2XT8GLr+iMRMdc5jz98AKE4gc2mtgu4QGvOLjoZaBxquLdkXwXcbqbVUxwED+Xl
 1lDDNUUBusHeivrnZuCE7krkeUAfxDUQD6+jSPMrQV5713g3kZjfYfbb0bdjLDCFIYlgnO
 FIO+KlfZ+jk8WY/DIfM7mlGx26/RIpVhvh6IT5szOKkDtwcHYbJJi1nD7fURwg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Thu, 16 Apr 2026 14:57:43 +0000
Subject: [PATCH v4 3/4] doc: usage: convert autoboot README to rST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-ui-cosmetics-v4-3-b843ba661b3f@postmarketos.org>
References: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
In-Reply-To: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13781;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=Nld+PT02Wk6627mufXp47AmnR6LT4Hs7/oSuQXUD1xM=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp4Pj0Srgx+MT6cSdHCtMO2xqBMMHlitJkZYj/p
 HRI20/YzHKJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaeD49AAKCRCEr8vQ14ma
 A3dvEACW9eH8Uwa0PReO0GIcLRuOpBWeVnkQmPX3Vhefz9q3IgH6Vw6yj0RJWWiE4VxbUjGbma+
 /523nFNiBQSMTsCb1BWB6XIHQoui+erOKqxjXzPor37WplwRtwc7KN5HG8xUpw7hehXk04A+WHf
 NtqlKKMHXc/H/BOaC1nbbTkOzKpltLzg246PF+Lb7msiBHnbgreZK5a5mQUieZk97cyh2lVSzl8
 I9bC8eTRJXmsZEzo4qXTY1nP1SNB0D/ZYmgoCnXDFmpxCmXHr765Kcc2CYJlsVsGxn5msRSAH83
 Hd7VbZV4DbdpA+R03oVVm462ioRrj1LO+puC0LpnOaNCVCG8wj0xKO0N8F3ujhiTcr3mdUu7r7/
 HF9hAowYvC7OGU0aPPbD+9xXnGccryxDZlVYKviwCM/9JEfvxJbCBR/eMi9IWbefbW2YGBwMfHb
 Tx1gDDneZGaNZEdHtIKcIiwy+rvZuvw+W5QWANFTnNEAKo+97ZPn/Lbrki1mMdNAJHXlGYBEt4P
 IxG7+0ad9Bdz4W5G/+a+IL9ReOwdoOGV0yGQ8xIAqq+GWC4uumcQayAHblcOfc4plgIVBx9tVGC
 sUAHkN7UaRExYgSbldzmPgcZOWxQPDDAM0VeLKZLBkYDbKdSPLZbSd8NnmKwarypNNCXhprPwT2
 dO+A1U519e9qRvQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Convert the plain text autoboot documentation into rST, so it is visible
in the public docs. Also decouple CONFIG_AUTOBOOT_PROMPT from
CONFIG_AUTOBOOT_KEYED in the documentation to reflect previous commits.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 doc/README.autoboot    | 162 -------------------------------------------------
 doc/usage/autoboot.rst | 149 +++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst    |   1 +
 3 files changed, 150 insertions(+), 162 deletions(-)

diff --git a/doc/README.autoboot b/doc/README.autoboot
deleted file mode 100644
index 5e9a5e1cf7f..00000000000
--- a/doc/README.autoboot
+++ /dev/null
@@ -1,162 +0,0 @@
-SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2001
- * Dave Ellis, SIXNET, dge@sixnetio.com
- *
- */
-
-Using autoboot configuration options
-====================================
-
-The basic autoboot configuration options are documented in the main
-U-Boot README. See it for details. They are:
-
-  bootdelay
-  bootcmd
-  CONFIG_BOOTDELAY
-  CONFIG_BOOTCOMMAND
-
-Some additional options that make autoboot safer in a production
-product are documented here.
-
-Why use them?
--------------
-
-The basic autoboot feature allows a system to automatically boot to
-the real application (such as Linux) without a user having to enter
-any commands. If any key is pressed before the boot delay time
-expires, U-Boot stops the autoboot process, gives a U-Boot prompt
-and waits forever for a command. That's a good thing if you pressed a
-key because you wanted to get the prompt.
-
-It's not so good if the key press was a stray character on the
-console serial port, say because a user who knows nothing about
-U-Boot pressed a key before the system had time to boot. It's even
-worse on an embedded product that doesn't have a console during
-normal use. The modem plugged into that console port sends a
-character at the wrong time and the system hangs, with no clue as to
-why it isn't working.
-
-You might want the system to autoboot to recover after an external
-configuration program stops autoboot. If the configuration program
-dies or loses its connection (modems can disconnect at the worst
-time) U-Boot will patiently wait forever for it to finish.
-
-These additional configuration options can help provide a system that
-boots when it should, but still allows access to U-Boot.
-
-What they do
-------------
-
-  CONFIG_BOOT_RETRY_TIME
-  CONFIG_BOOT_RETRY_MIN
-
-  "bootretry" environment variable
-
-	These options determine what happens after autoboot is
-	stopped and U-Boot is waiting for commands.
-
-	CONFIG_BOOT_RETRY_TIME must be defined to enable the boot
-	retry feature. If the environment variable "bootretry" is
-	found then its value is used, otherwise the retry timeout is
-	CONFIG_BOOT_RETRY_TIME. CONFIG_BOOT_RETRY_MIN is optional and
-	defaults to CONFIG_BOOT_RETRY_TIME. All times are in seconds.
-
-	If the retry timeout is negative, the U-Boot command prompt
-	never times out. Otherwise it is forced to be at least
-	CONFIG_BOOT_RETRY_MIN seconds. If no valid U-Boot command is
-	entered before the specified time the boot delay sequence is
-	restarted. Each command that U-Boot executes restarts the
-	timeout.
-
-	If CONFIG_BOOT_RETRY_TIME < 0 the feature is there, but
-	doesn't do anything unless the environment variable
-	"bootretry" is >= 0.
-
-  CONFIG_AUTOBOOT_KEYED
-  CONFIG_AUTOBOOT_KEYED_CTRLC
-  CONFIG_AUTOBOOT_PROMPT
-  CONFIG_AUTOBOOT_DELAY_STR
-  CONFIG_AUTOBOOT_STOP_STR
-
-  "bootdelaykey"  environment variable
-  "bootstopkey"	  environment variable
-
-	These options give more control over stopping autoboot. When
-	they are used a specific character or string is required to
-	stop or delay autoboot.
-
-	Define CONFIG_AUTOBOOT_KEYED (no value required) to enable
-	this group of options.	CONFIG_AUTOBOOT_DELAY_STR,
-	CONFIG_AUTOBOOT_STOP_STR or both should be specified (or
-	specified by the corresponding environment variable),
-	otherwise there is no way to stop autoboot.
-
-	CONFIG_AUTOBOOT_PROMPT is displayed before the boot delay
-	selected by CONFIG_BOOTDELAY starts. If it is not defined
-	there is no output indicating that autoboot is in progress.
-
-	Note that CONFIG_AUTOBOOT_PROMPT is used as the (only)
-	argument to a printf() call, so it may contain '%' format
-	specifications, provided that it also includes, sepearated by
-	commas exactly like in a printf statement, the required
-	arguments. It is the responsibility of the user to select only
-	such arguments that are valid in the given context. A
-	reasonable prompt could be defined as
-
-		#define CONFIG_AUTOBOOT_PROMPT \
-			"autoboot in %d seconds\n",bootdelay
-
-	If CONFIG_AUTOBOOT_DELAY_STR or "bootdelaykey" is specified
-	and this string is received from console input before
-	autoboot starts booting, U-Boot gives a command prompt. The
-	U-Boot prompt will time out if CONFIG_BOOT_RETRY_TIME is
-	used, otherwise it never times out.
-
-	If CONFIG_AUTOBOOT_STOP_STR or "bootstopkey" is specified and
-	this string is received from console input before autoboot
-	starts booting, U-Boot gives a command prompt. The U-Boot
-	prompt never times out, even if CONFIG_BOOT_RETRY_TIME is
-	used.
-
-	The string recognition is not very sophisticated. If a
-	partial match is detected, the first non-matching character
-	is checked to see if starts a new match. There is no check
-	for a shorter partial match, so it's best if the first
-	character of a key string does not appear in the rest of the
-	string.
-
-	The CONFIG_AUTOBOOT_KEYED_CTRLC #define allows for the boot
-	sequence to be interrupted by ctrl-c, in addition to the
-	"bootdelaykey" and "bootstopkey". Setting this variable
-	provides an escape sequence from the limited "password"
-	strings.
-
-  CONFIG_AUTOBOOT_ENCRYPTION
-
-  "bootstopkeysha256"	environment variable
-
-	- Hash value of the input which unlocks the device and
-	  stops autoboot.
-
-	This option allows a string to be entered into U-Boot to stop the
-	autoboot. The string itself is hashed and compared against the hash
-	in the environment variable 'bootstopkeysha256'. If it matches then
-	boot stops and a command-line prompt is presented.
-
-	This provides a way to ship a secure production device which can also
-	be accessed at the U-Boot command line.
-
-  CONFIG_RESET_TO_RETRY
-
-	(Only effective when CONFIG_BOOT_RETRY_TIME is also set)
-	After the countdown timed out, the board will be reset to restart
-	again.
-
-  CONFIG_AUTOBOOT_USE_MENUKEY
-  CONFIG_AUTOBOOT_MENUKEY
-
-	If this key is pressed to stop autoboot, then the commands in the
-	environment variable 'menucmd' will be executed before boot starts.
-	For example, 33 means "!" in ASCII, so pressing ! at boot would take
-	this action.
diff --git a/doc/usage/autoboot.rst b/doc/usage/autoboot.rst
new file mode 100644
index 00000000000..3b6f040008b
--- /dev/null
+++ b/doc/usage/autoboot.rst
@@ -0,0 +1,149 @@
+.. SPDX-License-Identifier: GPL-2.0+
+..
+.. (C) Copyright 2001
+.. Dave Ellis, SIXNET, dge@sixnetio.com
+
+Using autoboot configuration options
+====================================
+
+The basic autoboot configuration options are documented in the main
+U-Boot README. See it for details. They are:
+
+::
+
+        bootdelay
+        bootcmd
+        CONFIG_BOOTDELAY
+        CONFIG_BOOTCOMMAND
+
+Some additional options that make autoboot safer in a production
+product are documented here.
+
+Why use them?
+-------------
+
+The basic autoboot feature allows a system to automatically boot to
+the real application (such as Linux) without a user having to enter
+any commands. If any key is pressed before the boot delay time
+expires, U-Boot stops the autoboot process, gives a U-Boot prompt
+and waits forever for a command. That's a good thing if you pressed a
+key because you wanted to get the prompt.
+
+It's not so good if the key press was a stray character on the
+console serial port, say because a user who knows nothing about
+U-Boot pressed a key before the system had time to boot. It's even
+worse on an embedded product that doesn't have a console during
+normal use. The modem plugged into that console port sends a
+character at the wrong time and the system hangs, with no clue as to
+why it isn't working.
+
+You might want the system to autoboot to recover after an external
+configuration program stops autoboot. If the configuration program
+dies or loses its connection (modems can disconnect at the worst
+time) U-Boot will patiently wait forever for it to finish.
+
+These additional configuration options can help provide a system that
+boots when it should, but still allows access to U-Boot.
+
+What they do
+------------
+
+CONFIG_BOOT_RETRY_TIME, CONFIG_BOOT_RETRY_MIN, "bootretry" environment variable
+    These options determine what happens after autoboot is
+    stopped and U-Boot is waiting for commands.
+ 
+    CONFIG_BOOT_RETRY_TIME must be defined to enable the boot
+    retry feature. If the environment variable "bootretry" is
+    found then its value is used, otherwise the retry timeout is
+    CONFIG_BOOT_RETRY_TIME. CONFIG_BOOT_RETRY_MIN is optional and
+    defaults to CONFIG_BOOT_RETRY_TIME. All times are in seconds.
+ 
+    If the retry timeout is negative, the U-Boot command prompt
+    never times out. Otherwise it is forced to be at least
+    CONFIG_BOOT_RETRY_MIN seconds. If no valid U-Boot command is
+    entered before the specified time the boot delay sequence is
+    restarted. Each command that U-Boot executes restarts the
+    timeout.
+ 
+    If CONFIG_BOOT_RETRY_TIME < 0 the feature is there, but
+    doesn't do anything unless the environment variable
+    "bootretry" is >= 0.
+
+CONFIG_AUTOBOOT_PROMPT
+    CONFIG_AUTOBOOT_PROMPT is displayed before the boot delay
+    selected by CONFIG_BOOTDELAY starts, if CONFIG_AUTOBOOT_KEYED
+    is defined. Else it is displayed during the autoboot countdown.
+
+    Note that CONFIG_AUTOBOOT_PROMPT is used as first
+    argument to a printf() call, along with the '%d' boot delay countdown,
+    so it may contain '%' format specifications, provided that it
+    also includes, sepearated by commas exactly like in a printf
+    statement, the required arguments. It is the responsibility
+    of the user to select only such arguments that are valid in
+    the given context. A reasonable prompt could be defined as
+
+    ::
+
+        #define CONFIG_AUTOBOOT_PROMPT \
+                "\rBooting in %d seconds"
+
+CONFIG_RESET_TO_RETRY
+    (Only effective when CONFIG_BOOT_RETRY_TIME is also set)
+    After the countdown timed out, the board will be reset to restart
+    again.
+
+CONFIG_AUTOBOOT_USE_MENUKEY, CONFIG_AUTOBOOT_MENUKEY
+    If this key is pressed to stop autoboot, then the commands in the
+    environment variable 'menucmd' will be executed before boot starts.
+    For example, 33 means "!" in ASCII, so pressing ! at boot would take
+    this action.
+
+
+Controlling autoboot
+~~~~~~~~~~~~~~~~~~~~
+
+The following options give more control over stopping autoboot. When
+they are used a specific character or string is required to stop or
+delay autoboot.
+Define CONFIG_AUTOBOOT_KEYED (no value required) to enable this group
+of options.
+
+CONFIG_AUTOBOOT_DELAY_STR, CONFIG_AUTOBOOT_STOP_STR or both
+should be specified (or specified by the corresponding environment variable),
+otherwise there is no way to stop autoboot.
+
+CONFIG_AUTOBOOT_DELAY_STR, "bootdelaykey" environment variable
+    If specified and this string is received from console input
+    before autoboot starts booting, U-Boot gives a command prompt.
+    The U-Boot prompt will time out if CONFIG_BOOT_RETRY_TIME is
+    used, otherwise it never times out. It should be specified
+    otherwise there is no way to stop autoboot.
+
+CONFIG_AUTOBOOT_STOP_STR, "bootstopkey" environment variable
+    If specified and this string is received from console input
+    before autoboot starts booting, U-Boot gives a command prompt.
+    The U-Boot prompt never times out, even if CONFIG_BOOT_RETRY_TIME
+    is used.
+
+The string recognition is not very sophisticated. If a
+partial match is detected, the first non-matching character
+is checked to see if starts a new match. There is no check
+for a shorter partial match, so it's best if the first
+character of a key string does not appear in the rest of the
+string.
+
+CONFIG_AUTOBOOT_KEYED_CTRLC
+    The CONFIG_AUTOBOOT_KEYED_CTRLC #define allows for the boot
+    sequence to be interrupted by ctrl-c, in addition to the
+    "bootdelaykey" and "bootstopkey". Setting this variable
+    provides an escape sequence from the limited "password"
+    strings.
+
+CONFIG_AUTOBOOT_ENCRYPTION, "bootstopkeysha256" environment variable
+    This option allows a string to be entered into U-Boot to stop the
+    autoboot. The string itself is hashed and compared against the hash
+    in the environment variable 'bootstopkeysha256'. If it matches then
+    boot stops and a command-line prompt is presented.
+
+    This provides a way to ship a secure production device which can also
+    be accessed at the U-Boot command line.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 6f477b842ca..35b9f4612f4 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -4,6 +4,7 @@ Use U-Boot
 .. toctree::
    :maxdepth: 1
 
+   autoboot
    spl_boot
    blkmap
    dfu

-- 
2.53.0

