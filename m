Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEAAF433CC
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 23:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31741841C2;
	Thu, 16 Apr 2026 01:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="W3FT07wo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66CC7841C8; Thu, 16 Apr 2026 01:18:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F18408419C
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 01:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776295068; x=1776899868; i=xypron.glpk@gmx.de;
 bh=+oCBpqN0F/Q52aMj+fQ5X/dM4gyYhp21sZIVG7/7G5I=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=W3FT07woE+4PxlvGOXw6NUP31lkGwogxmgsuBmBez/jHcLtGKtrnsZx1ve4KnGNW
 Zm7kJsLHibtMk40IWrVPOXt8qUcbUoQVhkIixNeydMADQktryvzsZETkyLrY5HzWX
 mYKMOAcHbt1lwuSKXUh75FLsBFUCg1cGQdxhczk9+SbmCp/lLCdbWftTVIzGWt7hp
 OeupQ6nbyqTeRXYZ9VZWgnCbIfn1EjQ5fsTfl56AIxMDtwena4Xwdc89rOr8MO/lJ
 h4aUAl9TZAizhQhbZBysNtZIb2sYS44pgARnG4KOvuaeEnoRdj01I/JXIDHxRqoJC
 5MGvNfWm8HL0AaLflA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsnF-1vzBXV1F8f-00YkjL; Thu, 16
 Apr 2026 01:17:48 +0200
Date: Thu, 16 Apr 2026 01:17:44 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ferass El Hafidi <funderscore@postmarketos.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, 
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 3/3] doc: usage: convert autoboot README to rST
User-Agent: Thunderbird for Android
In-Reply-To: <tdjxih.1juw2c1se87sl@postmarketos.org>
References: <20260415-ui-cosmetics-v3-0-aa8308a47e33@postmarketos.org>
 <20260415-ui-cosmetics-v3-3-aa8308a47e33@postmarketos.org>
 <61DCA2CF-A66E-47C5-8921-9747FAC8C75B@gmx.de>
 <tdjxih.1juw2c1se87sl@postmarketos.org>
Message-ID: <2D15A5D4-D938-4DDD-801A-84F7B0230E55@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jtfk8cqJDbRzkRKmZLstXaoxeDAO4WYdGow+FL/X+ffKwescKYH
 hSEtEKljuVyKvLfDCi9NFsQ5wgnZ45BuIV83p0+fmaVBFbrt2/xSlbjE8UO+wdoQgfDhOhT
 sV1alJik3j6hOdIujHhftFlDndUiqH5VHCyzKObDe2qvHf+1SWBBwltGyexxYOHDrVYxdTL
 DwRur+l/L5ZohxGwtXklg==
UI-OutboundReport: notjunk:1;M01:P0:Xl0IMIP6TqA=;IrHc0ZCIH3GhEBh3JsGMUXKWlO2
 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
 glgjzg==
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

Am 15=2E April 2026 22:10:43 MESZ schrieb Ferass El Hafidi <funderscore@pos=
tmarketos=2Eorg>:
>Hi,
>
>On Wed, 15 Apr 2026 18:57, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede> w=
rote:
>> Am 15=2E April 2026 16:32:33 MESZ schrieb Ferass El Hafidi <funderscore=
@postmarketos=2Eorg>:
>>> Convert the plain text autoboot documentation into rST, so it is visib=
le
>>> in the public docs=2E Also decouple CONFIG_AUTOBOOT_PROMPT from
>>> CONFIG_AUTOBOOT_KEYED in the documentation to reflect previous commits=
=2E
>>>=20
>>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos=2Eorg>
>>> ---
>>> doc/README=2Eautoboot    | 162 ---------------------------------------=
----------
>>> doc/usage/autoboot=2Erst | 149 +++++++++++++++++++++++++++++++++++++++=
++++++
>>> doc/usage/index=2Erst    |   1 +
>>> 3 files changed, 150 insertions(+), 162 deletions(-)
>>>=20
>>> diff --git a/doc/README=2Eautoboot b/doc/README=2Eautoboot
>>> deleted file mode 100644
>>> index 5e9a5e1cf7f=2E=2E00000000000
>>> --- a/doc/README=2Eautoboot
>>> +++ /dev/null
>>> @@ -1,162 +0,0 @@
>>> -SPDX-License-Identifier: GPL-2=2E0+
>>> -/*
>>> - * (C) Copyright 2001
>>> - * Dave Ellis, SIXNET, dge@sixnetio=2Ecom
>>> - *
>>> - */
>>> -
>>> -Using autoboot configuration options
>>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -
>>> -The basic autoboot configuration options are documented in the main
>>> -U-Boot README=2E See it for details=2E They are:
>>> -
>>> -  bootdelay
>>> -  bootcmd
>>> -  CONFIG_BOOTDELAY
>>> -  CONFIG_BOOTCOMMAND
>>> -
>>> -Some additional options that make autoboot safer in a production
>>> -product are documented here=2E
>>> -
>>> -Why use them?
>>> --------------
>>> -
>>> -The basic autoboot feature allows a system to automatically boot to
>>> -the real application (such as Linux) without a user having to enter
>>> -any commands=2E If any key is pressed before the boot delay time
>>> -expires, U-Boot stops the autoboot process, gives a U-Boot prompt
>>> -and waits forever for a command=2E That's a good thing if you pressed=
 a
>>> -key because you wanted to get the prompt=2E
>>> -
>>> -It's not so good if the key press was a stray character on the
>>> -console serial port, say because a user who knows nothing about
>>> -U-Boot pressed a key before the system had time to boot=2E It's even
>>> -worse on an embedded product that doesn't have a console during
>>> -normal use=2E The modem plugged into that console port sends a
>>> -character at the wrong time and the system hangs, with no clue as to
>>> -why it isn't working=2E
>>> -
>>> -You might want the system to autoboot to recover after an external
>>> -configuration program stops autoboot=2E If the configuration program
>>> -dies or loses its connection (modems can disconnect at the worst
>>> -time) U-Boot will patiently wait forever for it to finish=2E
>>> -
>>> -These additional configuration options can help provide a system that
>>> -boots when it should, but still allows access to U-Boot=2E
>>> -
>>> -What they do
>>> -------------
>>> -
>>> -  CONFIG_BOOT_RETRY_TIME
>>> -  CONFIG_BOOT_RETRY_MIN
>>> -
>>> -  "bootretry" environment variable
>>> -
>>> -	These options determine what happens after autoboot is
>>> -	stopped and U-Boot is waiting for commands=2E
>>> -
>>> -	CONFIG_BOOT_RETRY_TIME must be defined to enable the boot
>>> -	retry feature=2E If the environment variable "bootretry" is
>>> -	found then its value is used, otherwise the retry timeout is
>>> -	CONFIG_BOOT_RETRY_TIME=2E CONFIG_BOOT_RETRY_MIN is optional and
>>> -	defaults to CONFIG_BOOT_RETRY_TIME=2E All times are in seconds=2E
>>> -
>>> -	If the retry timeout is negative, the U-Boot command prompt
>>> -	never times out=2E Otherwise it is forced to be at least
>>> -	CONFIG_BOOT_RETRY_MIN seconds=2E If no valid U-Boot command is
>>> -	entered before the specified time the boot delay sequence is
>>> -	restarted=2E Each command that U-Boot executes restarts the
>>> -	timeout=2E
>>> -
>>> -	If CONFIG_BOOT_RETRY_TIME < 0 the feature is there, but
>>> -	doesn't do anything unless the environment variable
>>> -	"bootretry" is >=3D 0=2E
>>> -
>>> -  CONFIG_AUTOBOOT_KEYED
>>> -  CONFIG_AUTOBOOT_KEYED_CTRLC
>>> -  CONFIG_AUTOBOOT_PROMPT
>>> -  CONFIG_AUTOBOOT_DELAY_STR
>>> -  CONFIG_AUTOBOOT_STOP_STR
>>> -
>>> -  "bootdelaykey"  environment variable
>>> -  "bootstopkey"	  environment variable
>>> -
>>> -	These options give more control over stopping autoboot=2E When
>>> -	they are used a specific character or string is required to
>>> -	stop or delay autoboot=2E
>>> -
>>> -	Define CONFIG_AUTOBOOT_KEYED (no value required) to enable
>>> -	this group of options=2E	CONFIG_AUTOBOOT_DELAY_STR,
>>> -	CONFIG_AUTOBOOT_STOP_STR or both should be specified (or
>>> -	specified by the corresponding environment variable),
>>> -	otherwise there is no way to stop autoboot=2E
>>> -
>>> -	CONFIG_AUTOBOOT_PROMPT is displayed before the boot delay
>>> -	selected by CONFIG_BOOTDELAY starts=2E If it is not defined
>>> -	there is no output indicating that autoboot is in progress=2E
>>> -
>>> -	Note that CONFIG_AUTOBOOT_PROMPT is used as the (only)
>>> -	argument to a printf() call, so it may contain '%' format
>>> -	specifications, provided that it also includes, sepearated by
>>> -	commas exactly like in a printf statement, the required
>>> -	arguments=2E It is the responsibility of the user to select only
>>> -	such arguments that are valid in the given context=2E A
>>> -	reasonable prompt could be defined as
>>> -
>>> -		#define CONFIG_AUTOBOOT_PROMPT \
>>> -			"autoboot in %d seconds\n",bootdelay
>>> -
>>> -	If CONFIG_AUTOBOOT_DELAY_STR or "bootdelaykey" is specified
>>> -	and this string is received from console input before
>>> -	autoboot starts booting, U-Boot gives a command prompt=2E The
>>> -	U-Boot prompt will time out if CONFIG_BOOT_RETRY_TIME is
>>> -	used, otherwise it never times out=2E
>>> -
>>> -	If CONFIG_AUTOBOOT_STOP_STR or "bootstopkey" is specified and
>>> -	this string is received from console input before autoboot
>>> -	starts booting, U-Boot gives a command prompt=2E The U-Boot
>>> -	prompt never times out, even if CONFIG_BOOT_RETRY_TIME is
>>> -	used=2E
>>> -
>>> -	The string recognition is not very sophisticated=2E If a
>>> -	partial match is detected, the first non-matching character
>>> -	is checked to see if starts a new match=2E There is no check
>>> -	for a shorter partial match, so it's best if the first
>>> -	character of a key string does not appear in the rest of the
>>> -	string=2E
>>> -
>>> -	The CONFIG_AUTOBOOT_KEYED_CTRLC #define allows for the boot
>>> -	sequence to be interrupted by ctrl-c, in addition to the
>>> -	"bootdelaykey" and "bootstopkey"=2E Setting this variable
>>> -	provides an escape sequence from the limited "password"
>>> -	strings=2E
>>> -
>>> -  CONFIG_AUTOBOOT_ENCRYPTION
>>> -
>>> -  "bootstopkeysha256"	environment variable
>>> -
>>> -	- Hash value of the input which unlocks the device and
>>> -	  stops autoboot=2E
>>> -
>>> -	This option allows a string to be entered into U-Boot to stop the
>>> -	autoboot=2E The string itself is hashed and compared against the has=
h
>>> -	in the environment variable 'bootstopkeysha256'=2E If it matches the=
n
>>> -	boot stops and a command-line prompt is presented=2E
>>> -
>>> -	This provides a way to ship a secure production device which can als=
o
>>> -	be accessed at the U-Boot command line=2E
>>> -
>>> -  CONFIG_RESET_TO_RETRY
>>> -
>>> -	(Only effective when CONFIG_BOOT_RETRY_TIME is also set)
>>> -	After the countdown timed out, the board will be reset to restart
>>> -	again=2E
>>> -
>>> -  CONFIG_AUTOBOOT_USE_MENUKEY
>>> -  CONFIG_AUTOBOOT_MENUKEY
>>> -
>>> -	If this key is pressed to stop autoboot, then the commands in the
>>> -	environment variable 'menucmd' will be executed before boot starts=
=2E
>>> -	For example, 33 means "!" in ASCII, so pressing ! at boot would take
>>> -	this action=2E
>>> diff --git a/doc/usage/autoboot=2Erst b/doc/usage/autoboot=2Erst
>>> new file mode 100644
>>> index 00000000000=2E=2E3b6f040008b
>>> --- /dev/null
>>> +++ b/doc/usage/autoboot=2Erst
>>> @@ -0,0 +1,149 @@
>>> +=2E=2E SPDX-License-Identifier: GPL-2=2E0+
>>> +=2E=2E
>>> +=2E=2E (C) Copyright 2001
>>> +=2E=2E Dave Ellis, SIXNET, dge@sixnetio=2Ecom
>>> +
>>> +Using autoboot configuration options
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +The basic autoboot configuration options are documented in the main
>>> +U-Boot README=2E See it for details=2E
>>=20
>> I can't find the word autoboot there=2E Anyway all autoboot options sho=
uld be documented in this file=2E
>>=20
>
>This was taken from the OG README=2Eautoboot file
>
>> They are:
>>> +
>>> +::
>>> +
>>> +        bootdelay
>>> +        bootcmd
>>> +        CONFIG_BOOTDELAY
>>> +        CONFIG_BOOTCOMMAND
>>> +
>>> +Some additional options that make autoboot safer in a production
>>> +product are documented here=2E
>>> +
>>> +Why use them?
>>> +-------------
>>> +
>>> +The basic autoboot feature allows a system to automatically boot to
>>> +the real application (such as Linux) without a user having to enter
>>> +any commands=2E If any key is pressed before the boot delay time
>>> +expires, U-Boot stops the autoboot process, gives a U-Boot prompt
>>> +and waits forever for a command=2E That's a good thing if you pressed=
 a
>>> +key because you wanted to get the prompt=2E
>>> +
>>> +It's not so good if the key press was a stray character on the
>>> +console serial port, say because a user who knows nothing about
>>> +U-Boot pressed a key before the system had time to boot=2E It's even
>>> +worse on an embedded product that doesn't have a console during
>>> +normal use=2E The modem plugged into that console port sends a
>>> +character at the wrong time and the system hangs, with no clue as to
>>> +why it isn't working=2E
>>=20
>> There recently was a patch on the mailing list to clear stdin at least =
for serial input=2E
>>=20
>
>Same for this
>
>>> +
>>> +You might want the system to autoboot to recover after an external
>>> +configuration program stops autoboot=2E If the configuration program
>>> +dies or loses its connection (modems can disconnect at the worst
>>> +time) U-Boot will patiently wait forever for it to finish=2E
>>> +
>>> +These additional configuration options can help provide a system that
>>> +boots when it should, but still allows access to U-Boot=2E
>>> +
>>> +What they do
>>> +------------
>>> +
>>> +CONFIG_BOOT_RETRY_TIME, CONFIG_BOOT_RETRY_MIN, "bootretry" environmen=
t variable
>>> +    These options determine what happens after autoboot is
>>> +    stopped and U-Boot is waiting for commands=2E
>>> + +    CONFIG_BOOT_RETRY_TIME must be defined to enable the boot
>>> +    retry feature=2E If the environment variable "bootretry" is
>>> +    found then its value is used, otherwise the retry timeout is
>>> +    CONFIG_BOOT_RETRY_TIME=2E CONFIG_BOOT_RETRY_MIN is optional and
>>> +    defaults to CONFIG_BOOT_RETRY_TIME=2E All times are in seconds=2E
>>> + +    If the retry timeout is negative, the U-Boot command prompt
>>> +    never times out=2E Otherwise it is forced to be at least
>>> +    CONFIG_BOOT_RETRY_MIN seconds=2E If no valid U-Boot command is
>>> +    entered before the specified time the boot delay sequence is
>>> +    restarted=2E Each command that U-Boot executes restarts the
>>> +    timeout=2E
>>> + +    If CONFIG_BOOT_RETRY_TIME < 0 the feature is there, but
>>> +    doesn't do anything unless the environment variable
>>> +    "bootretry" is >=3D 0=2E
>>> +
>>> +CONFIG_AUTOBOOT_PROMPT
>>> +    CONFIG_AUTOBOOT_PROMPT is displayed before the boot delay
>>> +    selected by CONFIG_BOOTDELAY starts, if CONFIG_AUTOBOOT_KEYED
>>> +    is defined=2E Else it is displayed during the autoboot countdown=
=2E
>>> +
>>> +    Note that CONFIG_AUTOBOOT_PROMPT is used as first
>>> +    argument to a printf() call, along with the '%d' boot delay count=
down,
>>> +    so it may contain '%' format specifications, provided that it
>>> +    also includes, sepearated by commas exactly like in a printf
>>> +    statement, the required arguments=2E It is the responsibility
>>> +    of the user to select only such arguments that are valid in
>>> +    the given context=2E A reasonable prompt could be defined as
>>> +
>>> +    ::
>>> +
>>> +        #define CONFIG_AUTOBOOT_PROMPT \
>>> +                "\rBooting in %d seconds"
>>=20
>> Constants starting with CONFIG_ may only be defined in Kconfig files=2E
>>=20
>
>And this=2E
>
>Do you think it makes sense to rework autoboot documentation with these
>changes or would it be out of scope for this patch series? The only
>changes I did was to convert to rST and move AUTOBOOT_PROMPT docs
>outside of KEYED (as per patch 1/3)=2E

I would suggest to have one patch for the conversion and another patch to =
correct the content=2E

Best regards

Heinrich

>
>--
>Best regards,
>Ferass <funderscore@postmarketos=2Eorg>

