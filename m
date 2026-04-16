Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FBFF8D757
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 15:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4E184105;
	Thu, 16 Apr 2026 17:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KbSHelow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D88BB841D5; Thu, 16 Apr 2026 17:27:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C11840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776353222; x=1776958022; i=xypron.glpk@gmx.de;
 bh=NIkpYWShFThZxSmhSE9kLxkIY2folaxSLRxP6hfXGZM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KbSHelowv8hgJV52ZG85HCz3iTy3WxN1xAe6z9T3dax5hJo3MBydITyXFwjHvtqI
 Ecvhn6rsz24kXsIyDCUwOmTLropI27rWOwT7eCaMh5hqYD9z5XG26CWFb+sdKDipY
 g0rFXFf3Q/qkr97//RP7KIQIiJpLBwFNwtVvkZ55LSCVgUvns84RKqC/knh+rV0y/
 436vYDJiovzVB2EdHLlH8krDRXDhSJ+oDjwjB8kKwz/u0tIhOgU+Wlqa4DfJ7246X
 TZdtZUYZfpLqH7WyDH2nwFocTWk/OqWLL3SQODekFctGYKWauuaL2mMmbMVTlQlF2
 JVEH/vIhTAeiYGUbnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1wBgTc2IOo-007nT1; Thu, 16
 Apr 2026 17:27:02 +0200
Message-ID: <6c1276a4-5eac-4028-86ba-b21deb34dff0@gmx.de>
Date: Thu, 16 Apr 2026 17:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] doc: usage: convert autoboot README to rST
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
References: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
 <20260416-ui-cosmetics-v4-3-b843ba661b3f@postmarketos.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260416-ui-cosmetics-v4-3-b843ba661b3f@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SrH0+zVLv9hXMr89uDMnxPpQ4oGzsdYCvhlGpUGbS97uV3UhANn
 1HfwB47SsC9sqHwZdPGh+NErA0vFaJ4sYEhcBDgXT0mj20Z+lkqKIif5t3kVU0czDQ7gTJc
 ctSvtn0UlcVJpT7AQWrpS3Pgg666ptwIdgd4BuRhB3DZOshqbo1t2Oj6fav01cB41AcC8YZ
 oaCfl8IgI4G8R1Tc5Nsyw==
UI-OutboundReport: notjunk:1;M01:P0:3xZDiActEXI=;VLbRa8K5D0bwujR8Wham/U28pU0
 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
 x7h7bQ==
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

On 4/16/26 16:57, Ferass El Hafidi wrote:
> Convert the plain text autoboot documentation into rST, so it is visible
> in the public docs. Also decouple CONFIG_AUTOBOOT_PROMPT from
> CONFIG_AUTOBOOT_KEYED in the documentation to reflect previous commits.
>=20
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>

Please, remove trailing whitespace:

Applying: doc: usage: convert autoboot README to rST
.git/rebase-apply/patch:234: trailing whitespace.
.git/rebase-apply/patch:240: trailing whitespace.
.git/rebase-apply/patch:247: trailing whitespace.

Best regards

Heinrich

> ---
>   doc/README.autoboot    | 162 -----------------------------------------=
=2D-------
>   doc/usage/autoboot.rst | 149 +++++++++++++++++++++++++++++++++++++++++=
++++
>   doc/usage/index.rst    |   1 +
>   3 files changed, 150 insertions(+), 162 deletions(-)
>=20
> diff --git a/doc/README.autoboot b/doc/README.autoboot
> deleted file mode 100644
> index 5e9a5e1cf7f..00000000000
> --- a/doc/README.autoboot
> +++ /dev/null
> @@ -1,162 +0,0 @@
> -SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2001
> - * Dave Ellis, SIXNET, dge@sixnetio.com
> - *
> - */
> -
> -Using autoboot configuration options
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The basic autoboot configuration options are documented in the main
> -U-Boot README. See it for details. They are:
> -
> -  bootdelay
> -  bootcmd
> -  CONFIG_BOOTDELAY
> -  CONFIG_BOOTCOMMAND
> -
> -Some additional options that make autoboot safer in a production
> -product are documented here.
> -
> -Why use them?
> --------------
> -
> -The basic autoboot feature allows a system to automatically boot to
> -the real application (such as Linux) without a user having to enter
> -any commands. If any key is pressed before the boot delay time
> -expires, U-Boot stops the autoboot process, gives a U-Boot prompt
> -and waits forever for a command. That's a good thing if you pressed a
> -key because you wanted to get the prompt.
> -
> -It's not so good if the key press was a stray character on the
> -console serial port, say because a user who knows nothing about
> -U-Boot pressed a key before the system had time to boot. It's even
> -worse on an embedded product that doesn't have a console during
> -normal use. The modem plugged into that console port sends a
> -character at the wrong time and the system hangs, with no clue as to
> -why it isn't working.
> -
> -You might want the system to autoboot to recover after an external
> -configuration program stops autoboot. If the configuration program
> -dies or loses its connection (modems can disconnect at the worst
> -time) U-Boot will patiently wait forever for it to finish.
> -
> -These additional configuration options can help provide a system that
> -boots when it should, but still allows access to U-Boot.
> -
> -What they do
> -------------
> -
> -  CONFIG_BOOT_RETRY_TIME
> -  CONFIG_BOOT_RETRY_MIN
> -
> -  "bootretry" environment variable
> -
> -	These options determine what happens after autoboot is
> -	stopped and U-Boot is waiting for commands.
> -
> -	CONFIG_BOOT_RETRY_TIME must be defined to enable the boot
> -	retry feature. If the environment variable "bootretry" is
> -	found then its value is used, otherwise the retry timeout is
> -	CONFIG_BOOT_RETRY_TIME. CONFIG_BOOT_RETRY_MIN is optional and
> -	defaults to CONFIG_BOOT_RETRY_TIME. All times are in seconds.
> -
> -	If the retry timeout is negative, the U-Boot command prompt
> -	never times out. Otherwise it is forced to be at least
> -	CONFIG_BOOT_RETRY_MIN seconds. If no valid U-Boot command is
> -	entered before the specified time the boot delay sequence is
> -	restarted. Each command that U-Boot executes restarts the
> -	timeout.
> -
> -	If CONFIG_BOOT_RETRY_TIME < 0 the feature is there, but
> -	doesn't do anything unless the environment variable
> -	"bootretry" is >=3D 0.
> -
> -  CONFIG_AUTOBOOT_KEYED
> -  CONFIG_AUTOBOOT_KEYED_CTRLC
> -  CONFIG_AUTOBOOT_PROMPT
> -  CONFIG_AUTOBOOT_DELAY_STR
> -  CONFIG_AUTOBOOT_STOP_STR
> -
> -  "bootdelaykey"  environment variable
> -  "bootstopkey"	  environment variable
> -
> -	These options give more control over stopping autoboot. When
> -	they are used a specific character or string is required to
> -	stop or delay autoboot.
> -
> -	Define CONFIG_AUTOBOOT_KEYED (no value required) to enable
> -	this group of options.	CONFIG_AUTOBOOT_DELAY_STR,
> -	CONFIG_AUTOBOOT_STOP_STR or both should be specified (or
> -	specified by the corresponding environment variable),
> -	otherwise there is no way to stop autoboot.
> -
> -	CONFIG_AUTOBOOT_PROMPT is displayed before the boot delay
> -	selected by CONFIG_BOOTDELAY starts. If it is not defined
> -	there is no output indicating that autoboot is in progress.
> -
> -	Note that CONFIG_AUTOBOOT_PROMPT is used as the (only)
> -	argument to a printf() call, so it may contain '%' format
> -	specifications, provided that it also includes, sepearated by
> -	commas exactly like in a printf statement, the required
> -	arguments. It is the responsibility of the user to select only
> -	such arguments that are valid in the given context. A
> -	reasonable prompt could be defined as
> -
> -		#define CONFIG_AUTOBOOT_PROMPT \
> -			"autoboot in %d seconds\n",bootdelay
> -
> -	If CONFIG_AUTOBOOT_DELAY_STR or "bootdelaykey" is specified
> -	and this string is received from console input before
> -	autoboot starts booting, U-Boot gives a command prompt. The
> -	U-Boot prompt will time out if CONFIG_BOOT_RETRY_TIME is
> -	used, otherwise it never times out.
> -
> -	If CONFIG_AUTOBOOT_STOP_STR or "bootstopkey" is specified and
> -	this string is received from console input before autoboot
> -	starts booting, U-Boot gives a command prompt. The U-Boot
> -	prompt never times out, even if CONFIG_BOOT_RETRY_TIME is
> -	used.
> -
> -	The string recognition is not very sophisticated. If a
> -	partial match is detected, the first non-matching character
> -	is checked to see if starts a new match. There is no check
> -	for a shorter partial match, so it's best if the first
> -	character of a key string does not appear in the rest of the
> -	string.
> -
> -	The CONFIG_AUTOBOOT_KEYED_CTRLC #define allows for the boot
> -	sequence to be interrupted by ctrl-c, in addition to the
> -	"bootdelaykey" and "bootstopkey". Setting this variable
> -	provides an escape sequence from the limited "password"
> -	strings.
> -
> -  CONFIG_AUTOBOOT_ENCRYPTION
> -
> -  "bootstopkeysha256"	environment variable
> -
> -	- Hash value of the input which unlocks the device and
> -	  stops autoboot.
> -
> -	This option allows a string to be entered into U-Boot to stop the
> -	autoboot. The string itself is hashed and compared against the hash
> -	in the environment variable 'bootstopkeysha256'. If it matches then
> -	boot stops and a command-line prompt is presented.
> -
> -	This provides a way to ship a secure production device which can also
> -	be accessed at the U-Boot command line.
> -
> -  CONFIG_RESET_TO_RETRY
> -
> -	(Only effective when CONFIG_BOOT_RETRY_TIME is also set)
> -	After the countdown timed out, the board will be reset to restart
> -	again.
> -
> -  CONFIG_AUTOBOOT_USE_MENUKEY
> -  CONFIG_AUTOBOOT_MENUKEY
> -
> -	If this key is pressed to stop autoboot, then the commands in the
> -	environment variable 'menucmd' will be executed before boot starts.
> -	For example, 33 means "!" in ASCII, so pressing ! at boot would take
> -	this action.
> diff --git a/doc/usage/autoboot.rst b/doc/usage/autoboot.rst
> new file mode 100644
> index 00000000000..3b6f040008b
> --- /dev/null
> +++ b/doc/usage/autoboot.rst
> @@ -0,0 +1,149 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +..
> +.. (C) Copyright 2001
> +.. Dave Ellis, SIXNET, dge@sixnetio.com
> +
> +Using autoboot configuration options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The basic autoboot configuration options are documented in the main
> +U-Boot README. See it for details. They are:
> +
> +::
> +
> +        bootdelay
> +        bootcmd
> +        CONFIG_BOOTDELAY
> +        CONFIG_BOOTCOMMAND
> +
> +Some additional options that make autoboot safer in a production
> +product are documented here.
> +
> +Why use them?
> +-------------
> +
> +The basic autoboot feature allows a system to automatically boot to
> +the real application (such as Linux) without a user having to enter
> +any commands. If any key is pressed before the boot delay time
> +expires, U-Boot stops the autoboot process, gives a U-Boot prompt
> +and waits forever for a command. That's a good thing if you pressed a
> +key because you wanted to get the prompt.
> +
> +It's not so good if the key press was a stray character on the
> +console serial port, say because a user who knows nothing about
> +U-Boot pressed a key before the system had time to boot. It's even
> +worse on an embedded product that doesn't have a console during
> +normal use. The modem plugged into that console port sends a
> +character at the wrong time and the system hangs, with no clue as to
> +why it isn't working.
> +
> +You might want the system to autoboot to recover after an external
> +configuration program stops autoboot. If the configuration program
> +dies or loses its connection (modems can disconnect at the worst
> +time) U-Boot will patiently wait forever for it to finish.
> +
> +These additional configuration options can help provide a system that
> +boots when it should, but still allows access to U-Boot.
> +
> +What they do
> +------------
> +
> +CONFIG_BOOT_RETRY_TIME, CONFIG_BOOT_RETRY_MIN, "bootretry" environment =
variable
> +    These options determine what happens after autoboot is
> +    stopped and U-Boot is waiting for commands.
> +
> +    CONFIG_BOOT_RETRY_TIME must be defined to enable the boot
> +    retry feature. If the environment variable "bootretry" is
> +    found then its value is used, otherwise the retry timeout is
> +    CONFIG_BOOT_RETRY_TIME. CONFIG_BOOT_RETRY_MIN is optional and
> +    defaults to CONFIG_BOOT_RETRY_TIME. All times are in seconds.
> +
> +    If the retry timeout is negative, the U-Boot command prompt
> +    never times out. Otherwise it is forced to be at least
> +    CONFIG_BOOT_RETRY_MIN seconds. If no valid U-Boot command is
> +    entered before the specified time the boot delay sequence is
> +    restarted. Each command that U-Boot executes restarts the
> +    timeout.
> +
> +    If CONFIG_BOOT_RETRY_TIME < 0 the feature is there, but
> +    doesn't do anything unless the environment variable
> +    "bootretry" is >=3D 0.
> +
> +CONFIG_AUTOBOOT_PROMPT
> +    CONFIG_AUTOBOOT_PROMPT is displayed before the boot delay
> +    selected by CONFIG_BOOTDELAY starts, if CONFIG_AUTOBOOT_KEYED
> +    is defined. Else it is displayed during the autoboot countdown.
> +
> +    Note that CONFIG_AUTOBOOT_PROMPT is used as first
> +    argument to a printf() call, along with the '%d' boot delay countdo=
wn,
> +    so it may contain '%' format specifications, provided that it
> +    also includes, sepearated by commas exactly like in a printf
> +    statement, the required arguments. It is the responsibility
> +    of the user to select only such arguments that are valid in
> +    the given context. A reasonable prompt could be defined as
> +
> +    ::
> +
> +        #define CONFIG_AUTOBOOT_PROMPT \
> +                "\rBooting in %d seconds"
> +
> +CONFIG_RESET_TO_RETRY
> +    (Only effective when CONFIG_BOOT_RETRY_TIME is also set)
> +    After the countdown timed out, the board will be reset to restart
> +    again.
> +
> +CONFIG_AUTOBOOT_USE_MENUKEY, CONFIG_AUTOBOOT_MENUKEY
> +    If this key is pressed to stop autoboot, then the commands in the
> +    environment variable 'menucmd' will be executed before boot starts.
> +    For example, 33 means "!" in ASCII, so pressing ! at boot would tak=
e
> +    this action.
> +
> +
> +Controlling autoboot
> +~~~~~~~~~~~~~~~~~~~~
> +
> +The following options give more control over stopping autoboot. When
> +they are used a specific character or string is required to stop or
> +delay autoboot.
> +Define CONFIG_AUTOBOOT_KEYED (no value required) to enable this group
> +of options.
> +
> +CONFIG_AUTOBOOT_DELAY_STR, CONFIG_AUTOBOOT_STOP_STR or both
> +should be specified (or specified by the corresponding environment vari=
able),
> +otherwise there is no way to stop autoboot.
> +
> +CONFIG_AUTOBOOT_DELAY_STR, "bootdelaykey" environment variable
> +    If specified and this string is received from console input
> +    before autoboot starts booting, U-Boot gives a command prompt.
> +    The U-Boot prompt will time out if CONFIG_BOOT_RETRY_TIME is
> +    used, otherwise it never times out. It should be specified
> +    otherwise there is no way to stop autoboot.
> +
> +CONFIG_AUTOBOOT_STOP_STR, "bootstopkey" environment variable
> +    If specified and this string is received from console input
> +    before autoboot starts booting, U-Boot gives a command prompt.
> +    The U-Boot prompt never times out, even if CONFIG_BOOT_RETRY_TIME
> +    is used.
> +
> +The string recognition is not very sophisticated. If a
> +partial match is detected, the first non-matching character
> +is checked to see if starts a new match. There is no check
> +for a shorter partial match, so it's best if the first
> +character of a key string does not appear in the rest of the
> +string.
> +
> +CONFIG_AUTOBOOT_KEYED_CTRLC
> +    The CONFIG_AUTOBOOT_KEYED_CTRLC #define allows for the boot
> +    sequence to be interrupted by ctrl-c, in addition to the
> +    "bootdelaykey" and "bootstopkey". Setting this variable
> +    provides an escape sequence from the limited "password"
> +    strings.
> +
> +CONFIG_AUTOBOOT_ENCRYPTION, "bootstopkeysha256" environment variable
> +    This option allows a string to be entered into U-Boot to stop the
> +    autoboot. The string itself is hashed and compared against the hash
> +    in the environment variable 'bootstopkeysha256'. If it matches then
> +    boot stops and a command-line prompt is presented.
> +
> +    This provides a way to ship a secure production device which can al=
so
> +    be accessed at the U-Boot command line.
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 6f477b842ca..35b9f4612f4 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -4,6 +4,7 @@ Use U-Boot
>   .. toctree::
>      :maxdepth: 1
>  =20
> +   autoboot
>      spl_boot
>      blkmap
>      dfu
>=20

