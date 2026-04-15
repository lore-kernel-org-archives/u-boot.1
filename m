Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCD7F4213B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D4983C2B;
	Wed, 15 Apr 2026 20:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="N2eCxU6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A49483EEF; Wed, 15 Apr 2026 20:57:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDA783B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776279459; x=1776884259; i=xypron.glpk@gmx.de;
 bh=oFCA+a4pYyrej7sDh/nQDsnAwb6aE/ui2KOSVp/NUVc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=N2eCxU6fBJ0uAZ6kxGr774RrHlqFdwjD03R8unQ/WKj7K9blvmPtvGDpgt11pO4Y
 K9lNdoH+hFQX6NwOfBa5U3V27XWzTFe1MyigKBIfHGlNBFaW+DD1uzK/nyUWeD6YG
 rOgOQvuMBxLolDkUmN0PBG2R17GuUMPGT0PWsR1kl0+EMo97HL6hmVUHyUWtFM6NC
 fC5t2x1YPGfG2K32R4vprCPLYSZlR+IH146jAkTlNScqEvf7oKJHfyNFr11l7vNRq
 gfwQd9WgzqRlcMgfe2ndf7bLyJlUYIiwX9S2yPla0v49dgiJqtub1UPcmiELhDshb
 1ZVyXdJcbcTZFhGweA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1vjp971CIc-00ciFJ; Wed, 15
 Apr 2026 20:57:39 +0200
Date: Wed, 15 Apr 2026 20:57:36 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ferass El Hafidi <funderscore@postmarketos.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 3/3] doc: usage: convert autoboot README to rST
User-Agent: Thunderbird for Android
In-Reply-To: <20260415-ui-cosmetics-v3-3-aa8308a47e33@postmarketos.org>
References: <20260415-ui-cosmetics-v3-0-aa8308a47e33@postmarketos.org>
 <20260415-ui-cosmetics-v3-3-aa8308a47e33@postmarketos.org>
Message-ID: <61DCA2CF-A66E-47C5-8921-9747FAC8C75B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/e8YSFMxbuDPUkLpFeVf3nVpw4j9xeUY2MWbXBxMhWGkBmQEe0d
 whTGA4Jl7yMjROfilrQJy/a9ZCcfNlTwNo4/AoYFBkTiGCiGaXC0NgcCOxkTbp/ebrxP9Gd
 jRMBExY3akExDpOXFrdghTzzPEF8MpRBAVDsl6JJba5uGyy8Lcs0CI3RTCdGvs5GSjb4Yk6
 pbY3+/fyGLf2BBmWMjCWw==
UI-OutboundReport: notjunk:1;M01:P0:tWLLjP36ub0=;DxSwrxjb4FdTdqttWVhQVMoVdFH
 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
 Ag7JUA==
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

Am 15=2E April 2026 16:32:33 MESZ schrieb Ferass El Hafidi <funderscore@pos=
tmarketos=2Eorg>:
>Convert the plain text autoboot documentation into rST, so it is visible
>in the public docs=2E Also decouple CONFIG_AUTOBOOT_PROMPT from
>CONFIG_AUTOBOOT_KEYED in the documentation to reflect previous commits=2E
>
>Signed-off-by: Ferass El Hafidi <funderscore@postmarketos=2Eorg>
>---
> doc/README=2Eautoboot    | 162 -----------------------------------------=
--------
> doc/usage/autoboot=2Erst | 149 +++++++++++++++++++++++++++++++++++++++++=
++++
> doc/usage/index=2Erst    |   1 +
> 3 files changed, 150 insertions(+), 162 deletions(-)
>
>diff --git a/doc/README=2Eautoboot b/doc/README=2Eautoboot
>deleted file mode 100644
>index 5e9a5e1cf7f=2E=2E00000000000
>--- a/doc/README=2Eautoboot
>+++ /dev/null
>@@ -1,162 +0,0 @@
>-SPDX-License-Identifier: GPL-2=2E0+
>-/*
>- * (C) Copyright 2001
>- * Dave Ellis, SIXNET, dge@sixnetio=2Ecom
>- *
>- */
>-
>-Using autoboot configuration options
>-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>-
>-The basic autoboot configuration options are documented in the main
>-U-Boot README=2E See it for details=2E They are:
>-
>-  bootdelay
>-  bootcmd
>-  CONFIG_BOOTDELAY
>-  CONFIG_BOOTCOMMAND
>-
>-Some additional options that make autoboot safer in a production
>-product are documented here=2E
>-
>-Why use them?
>--------------
>-
>-The basic autoboot feature allows a system to automatically boot to
>-the real application (such as Linux) without a user having to enter
>-any commands=2E If any key is pressed before the boot delay time
>-expires, U-Boot stops the autoboot process, gives a U-Boot prompt
>-and waits forever for a command=2E That's a good thing if you pressed a
>-key because you wanted to get the prompt=2E
>-
>-It's not so good if the key press was a stray character on the
>-console serial port, say because a user who knows nothing about
>-U-Boot pressed a key before the system had time to boot=2E It's even
>-worse on an embedded product that doesn't have a console during
>-normal use=2E The modem plugged into that console port sends a
>-character at the wrong time and the system hangs, with no clue as to
>-why it isn't working=2E
>-
>-You might want the system to autoboot to recover after an external
>-configuration program stops autoboot=2E If the configuration program
>-dies or loses its connection (modems can disconnect at the worst
>-time) U-Boot will patiently wait forever for it to finish=2E
>-
>-These additional configuration options can help provide a system that
>-boots when it should, but still allows access to U-Boot=2E
>-
>-What they do
>-------------
>-
>-  CONFIG_BOOT_RETRY_TIME
>-  CONFIG_BOOT_RETRY_MIN
>-
>-  "bootretry" environment variable
>-
>-	These options determine what happens after autoboot is
>-	stopped and U-Boot is waiting for commands=2E
>-
>-	CONFIG_BOOT_RETRY_TIME must be defined to enable the boot
>-	retry feature=2E If the environment variable "bootretry" is
>-	found then its value is used, otherwise the retry timeout is
>-	CONFIG_BOOT_RETRY_TIME=2E CONFIG_BOOT_RETRY_MIN is optional and
>-	defaults to CONFIG_BOOT_RETRY_TIME=2E All times are in seconds=2E
>-
>-	If the retry timeout is negative, the U-Boot command prompt
>-	never times out=2E Otherwise it is forced to be at least
>-	CONFIG_BOOT_RETRY_MIN seconds=2E If no valid U-Boot command is
>-	entered before the specified time the boot delay sequence is
>-	restarted=2E Each command that U-Boot executes restarts the
>-	timeout=2E
>-
>-	If CONFIG_BOOT_RETRY_TIME < 0 the feature is there, but
>-	doesn't do anything unless the environment variable
>-	"bootretry" is >=3D 0=2E
>-
>-  CONFIG_AUTOBOOT_KEYED
>-  CONFIG_AUTOBOOT_KEYED_CTRLC
>-  CONFIG_AUTOBOOT_PROMPT
>-  CONFIG_AUTOBOOT_DELAY_STR
>-  CONFIG_AUTOBOOT_STOP_STR
>-
>-  "bootdelaykey"  environment variable
>-  "bootstopkey"	  environment variable
>-
>-	These options give more control over stopping autoboot=2E When
>-	they are used a specific character or string is required to
>-	stop or delay autoboot=2E
>-
>-	Define CONFIG_AUTOBOOT_KEYED (no value required) to enable
>-	this group of options=2E	CONFIG_AUTOBOOT_DELAY_STR,
>-	CONFIG_AUTOBOOT_STOP_STR or both should be specified (or
>-	specified by the corresponding environment variable),
>-	otherwise there is no way to stop autoboot=2E
>-
>-	CONFIG_AUTOBOOT_PROMPT is displayed before the boot delay
>-	selected by CONFIG_BOOTDELAY starts=2E If it is not defined
>-	there is no output indicating that autoboot is in progress=2E
>-
>-	Note that CONFIG_AUTOBOOT_PROMPT is used as the (only)
>-	argument to a printf() call, so it may contain '%' format
>-	specifications, provided that it also includes, sepearated by
>-	commas exactly like in a printf statement, the required
>-	arguments=2E It is the responsibility of the user to select only
>-	such arguments that are valid in the given context=2E A
>-	reasonable prompt could be defined as
>-
>-		#define CONFIG_AUTOBOOT_PROMPT \
>-			"autoboot in %d seconds\n",bootdelay
>-
>-	If CONFIG_AUTOBOOT_DELAY_STR or "bootdelaykey" is specified
>-	and this string is received from console input before
>-	autoboot starts booting, U-Boot gives a command prompt=2E The
>-	U-Boot prompt will time out if CONFIG_BOOT_RETRY_TIME is
>-	used, otherwise it never times out=2E
>-
>-	If CONFIG_AUTOBOOT_STOP_STR or "bootstopkey" is specified and
>-	this string is received from console input before autoboot
>-	starts booting, U-Boot gives a command prompt=2E The U-Boot
>-	prompt never times out, even if CONFIG_BOOT_RETRY_TIME is
>-	used=2E
>-
>-	The string recognition is not very sophisticated=2E If a
>-	partial match is detected, the first non-matching character
>-	is checked to see if starts a new match=2E There is no check
>-	for a shorter partial match, so it's best if the first
>-	character of a key string does not appear in the rest of the
>-	string=2E
>-
>-	The CONFIG_AUTOBOOT_KEYED_CTRLC #define allows for the boot
>-	sequence to be interrupted by ctrl-c, in addition to the
>-	"bootdelaykey" and "bootstopkey"=2E Setting this variable
>-	provides an escape sequence from the limited "password"
>-	strings=2E
>-
>-  CONFIG_AUTOBOOT_ENCRYPTION
>-
>-  "bootstopkeysha256"	environment variable
>-
>-	- Hash value of the input which unlocks the device and
>-	  stops autoboot=2E
>-
>-	This option allows a string to be entered into U-Boot to stop the
>-	autoboot=2E The string itself is hashed and compared against the hash
>-	in the environment variable 'bootstopkeysha256'=2E If it matches then
>-	boot stops and a command-line prompt is presented=2E
>-
>-	This provides a way to ship a secure production device which can also
>-	be accessed at the U-Boot command line=2E
>-
>-  CONFIG_RESET_TO_RETRY
>-
>-	(Only effective when CONFIG_BOOT_RETRY_TIME is also set)
>-	After the countdown timed out, the board will be reset to restart
>-	again=2E
>-
>-  CONFIG_AUTOBOOT_USE_MENUKEY
>-  CONFIG_AUTOBOOT_MENUKEY
>-
>-	If this key is pressed to stop autoboot, then the commands in the
>-	environment variable 'menucmd' will be executed before boot starts=2E
>-	For example, 33 means "!" in ASCII, so pressing ! at boot would take
>-	this action=2E
>diff --git a/doc/usage/autoboot=2Erst b/doc/usage/autoboot=2Erst
>new file mode 100644
>index 00000000000=2E=2E3b6f040008b
>--- /dev/null
>+++ b/doc/usage/autoboot=2Erst
>@@ -0,0 +1,149 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0+
>+=2E=2E
>+=2E=2E (C) Copyright 2001
>+=2E=2E Dave Ellis, SIXNET, dge@sixnetio=2Ecom
>+
>+Using autoboot configuration options
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+The basic autoboot configuration options are documented in the main
>+U-Boot README=2E See it for details=2E

I can't find the word autoboot there=2E Anyway all autoboot options should=
 be documented in this file=2E

 They are:
>+
>+::
>+
>+        bootdelay
>+        bootcmd
>+        CONFIG_BOOTDELAY
>+        CONFIG_BOOTCOMMAND
>+
>+Some additional options that make autoboot safer in a production
>+product are documented here=2E
>+
>+Why use them?
>+-------------
>+
>+The basic autoboot feature allows a system to automatically boot to
>+the real application (such as Linux) without a user having to enter
>+any commands=2E If any key is pressed before the boot delay time
>+expires, U-Boot stops the autoboot process, gives a U-Boot prompt
>+and waits forever for a command=2E That's a good thing if you pressed a
>+key because you wanted to get the prompt=2E
>+
>+It's not so good if the key press was a stray character on the
>+console serial port, say because a user who knows nothing about
>+U-Boot pressed a key before the system had time to boot=2E It's even
>+worse on an embedded product that doesn't have a console during
>+normal use=2E The modem plugged into that console port sends a
>+character at the wrong time and the system hangs, with no clue as to
>+why it isn't working=2E

There recently was a patch on the mailing list to clear stdin at least for=
 serial input=2E

>+
>+You might want the system to autoboot to recover after an external
>+configuration program stops autoboot=2E If the configuration program
>+dies or loses its connection (modems can disconnect at the worst
>+time) U-Boot will patiently wait forever for it to finish=2E
>+
>+These additional configuration options can help provide a system that
>+boots when it should, but still allows access to U-Boot=2E
>+
>+What they do
>+------------
>+
>+CONFIG_BOOT_RETRY_TIME, CONFIG_BOOT_RETRY_MIN, "bootretry" environment v=
ariable
>+    These options determine what happens after autoboot is
>+    stopped and U-Boot is waiting for commands=2E
>+=20
>+    CONFIG_BOOT_RETRY_TIME must be defined to enable the boot
>+    retry feature=2E If the environment variable "bootretry" is
>+    found then its value is used, otherwise the retry timeout is
>+    CONFIG_BOOT_RETRY_TIME=2E CONFIG_BOOT_RETRY_MIN is optional and
>+    defaults to CONFIG_BOOT_RETRY_TIME=2E All times are in seconds=2E
>+=20
>+    If the retry timeout is negative, the U-Boot command prompt
>+    never times out=2E Otherwise it is forced to be at least
>+    CONFIG_BOOT_RETRY_MIN seconds=2E If no valid U-Boot command is
>+    entered before the specified time the boot delay sequence is
>+    restarted=2E Each command that U-Boot executes restarts the
>+    timeout=2E
>+=20
>+    If CONFIG_BOOT_RETRY_TIME < 0 the feature is there, but
>+    doesn't do anything unless the environment variable
>+    "bootretry" is >=3D 0=2E
>+
>+CONFIG_AUTOBOOT_PROMPT
>+    CONFIG_AUTOBOOT_PROMPT is displayed before the boot delay
>+    selected by CONFIG_BOOTDELAY starts, if CONFIG_AUTOBOOT_KEYED
>+    is defined=2E Else it is displayed during the autoboot countdown=2E
>+
>+    Note that CONFIG_AUTOBOOT_PROMPT is used as first
>+    argument to a printf() call, along with the '%d' boot delay countdow=
n,
>+    so it may contain '%' format specifications, provided that it
>+    also includes, sepearated by commas exactly like in a printf
>+    statement, the required arguments=2E It is the responsibility
>+    of the user to select only such arguments that are valid in
>+    the given context=2E A reasonable prompt could be defined as
>+
>+    ::
>+
>+        #define CONFIG_AUTOBOOT_PROMPT \
>+                "\rBooting in %d seconds"

Constants starting with CONFIG_ may only be defined in Kconfig files=2E

Best regards

Heinrich

>+
>+CONFIG_RESET_TO_RETRY
>+    (Only effective when CONFIG_BOOT_RETRY_TIME is also set)
>+    After the countdown timed out, the board will be reset to restart
>+    again=2E
>+
>+CONFIG_AUTOBOOT_USE_MENUKEY, CONFIG_AUTOBOOT_MENUKEY
>+    If this key is pressed to stop autoboot, then the commands in the
>+    environment variable 'menucmd' will be executed before boot starts=
=2E
>+    For example, 33 means "!" in ASCII, so pressing ! at boot would take
>+    this action=2E
>+
>+
>+Controlling autoboot
>+~~~~~~~~~~~~~~~~~~~~
>+
>+The following options give more control over stopping autoboot=2E When
>+they are used a specific character or string is required to stop or
>+delay autoboot=2E
>+Define CONFIG_AUTOBOOT_KEYED (no value required) to enable this group
>+of options=2E
>+
>+CONFIG_AUTOBOOT_DELAY_STR, CONFIG_AUTOBOOT_STOP_STR or both
>+should be specified (or specified by the corresponding environment varia=
ble),
>+otherwise there is no way to stop autoboot=2E
>+
>+CONFIG_AUTOBOOT_DELAY_STR, "bootdelaykey" environment variable
>+    If specified and this string is received from console input
>+    before autoboot starts booting, U-Boot gives a command prompt=2E
>+    The U-Boot prompt will time out if CONFIG_BOOT_RETRY_TIME is
>+    used, otherwise it never times out=2E It should be specified
>+    otherwise there is no way to stop autoboot=2E
>+
>+CONFIG_AUTOBOOT_STOP_STR, "bootstopkey" environment variable
>+    If specified and this string is received from console input
>+    before autoboot starts booting, U-Boot gives a command prompt=2E
>+    The U-Boot prompt never times out, even if CONFIG_BOOT_RETRY_TIME
>+    is used=2E
>+
>+The string recognition is not very sophisticated=2E If a
>+partial match is detected, the first non-matching character
>+is checked to see if starts a new match=2E There is no check
>+for a shorter partial match, so it's best if the first
>+character of a key string does not appear in the rest of the
>+string=2E
>+
>+CONFIG_AUTOBOOT_KEYED_CTRLC
>+    The CONFIG_AUTOBOOT_KEYED_CTRLC #define allows for the boot
>+    sequence to be interrupted by ctrl-c, in addition to the
>+    "bootdelaykey" and "bootstopkey"=2E Setting this variable
>+    provides an escape sequence from the limited "password"
>+    strings=2E
>+
>+CONFIG_AUTOBOOT_ENCRYPTION, "bootstopkeysha256" environment variable
>+    This option allows a string to be entered into U-Boot to stop the
>+    autoboot=2E The string itself is hashed and compared against the has=
h
>+    in the environment variable 'bootstopkeysha256'=2E If it matches the=
n
>+    boot stops and a command-line prompt is presented=2E
>+
>+    This provides a way to ship a secure production device which can als=
o
>+    be accessed at the U-Boot command line=2E
>diff --git a/doc/usage/index=2Erst b/doc/usage/index=2Erst
>index 6f477b842ca=2E=2E35b9f4612f4 100644
>--- a/doc/usage/index=2Erst
>+++ b/doc/usage/index=2Erst
>@@ -4,6 +4,7 @@ Use U-Boot
> =2E=2E toctree::
>    :maxdepth: 1
>=20
>+   autoboot
>    spl_boot
>    blkmap
>    dfu
>

