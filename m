Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79387CA0EF8
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 21:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C1E781E13;
	Wed, 20 Aug 2025 23:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bORXUxF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C3F882B07; Wed, 20 Aug 2025 23:38:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0E40801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 23:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755725883; x=1756330683; i=xypron.glpk@gmx.de;
 bh=7KwDF4TMCTFzLSrRnFvm0e0duUNGAc5lZxGPw/clVTU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bORXUxF6xtbpAmqNbMoQ7MUOUxs/wV1q2A8sthP4VCcQmr6diNEzF9iKxnK23y0v
 7eysUG1BU+DjxkF91wOF9dlEFky7JenlYqA004Kk9m9vXnBOMeFzxW6oFgjB13B5H
 4IxcB0yW5+k+F7Z2fCHXQDGeEkv9brXK8F0kpZ2BqqwjmhRGPws11kULlN6ioWqEc
 YRpDlw1nFcCaw74HVcwb3v9/P/g9KzKdD3taEnWijf2njEmqu6nSUpUGy5dvkwamd
 aun9/E88W0d5GCTeslNPgiEAr+sohwJ0OHspStQurF5vDS6NhuGqwQkinfk9Ya26i
 z5FGqd7acxsUTuafwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fIW-1uuvJ31F7q-008BTg; Wed, 20
 Aug 2025 23:38:03 +0200
Message-ID: <fe0f464c-5696-4f88-98d6-fe545d268d72@gmx.de>
Date: Wed, 20 Aug 2025 23:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] doc: Fix typos and improve wording in
 tools/buildman/buildman.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-4-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-4-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:llq3GlkoslK7wRH1PGyM44qXlk6iTWTG8K6PNeadflWCaRxxErv
 jdyjS80XpB9fQb+DYYSRnFEzQjl9UkzT+p+8rHMI5hD9pfURBdpftnvUJ8Uwmavq9cCEDxs
 DfVGRaJfzUTCoT1dKvRYcEEkocqGbCYvVcwPnnKlQe2vdsf7X7Gr77rCKHCVkp48BmWO5iJ
 YCdDYL2iBP1oT47NsFOpQ==
UI-OutboundReport: notjunk:1;M01:P0:5N46C6Owms0=;ZmLMncLJxdqJveMaoMh/SWqOMN5
 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
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

On 11.08.25 01:37, Adriano Carvalho wrote:
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>   tools/buildman/buildman.rst | 49 ++++++++++++++++++-------------------
>   1 file changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index 8c45a841024..a9d5543a1a4 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -22,10 +22,10 @@ example Raspberry Pi 2):
>   What is this?
>   -------------
>  =20
> -This tool handles building U-Boot to check that you have not broken it
> -with your patch series. It can build each individual commit and report
> -which boards fail on which commits, and which errors come up. It aims
> -to make full use of multi-processor machines.
> +This tool builds U-Boot to check that you have not broken it with your
> +patch series. It can build each individual commit and report which boar=
ds
> +fail on which commits, and which errors come up. It aims to make full u=
se
> +of multi-processor machines.
>  =20
>   A key feature of buildman is its output summary, which allows warnings=
,
>   errors or image size increases in a particular commit or board to be
> @@ -83,7 +83,7 @@ incremental build (i.e. not using 'make xxx_defconfig'=
 unless you use -C).
>   Eventually the thread reaches the last commit and stops. If a commit c=
auses
>   an error or warning, buildman will try it again after reconfiguring (b=
ut see
>   -Q). Thus some commits may be built twice, with the first result silen=
tly
> -discarded. Lots of errors and warnings will causes lots of reconfigures=
 and your
> +discarded. Lots of errors and warnings will cause lots of reconfigures =
and your
>   build will be very slow. This is because a file that produces just a w=
arning
>   would not normally be rebuilt in an incremental build. Once a thread f=
inishes
>   building all the commits for a board, it starts on the commits for ano=
ther
> @@ -154,7 +154,7 @@ means to build all arm boards except nvidia, freesca=
le and anything ending
>   with 'ball'.
>  =20
>   For building specific boards you can use the --boards (or --bo) option=
, which
> -takes a comma-separated list of board target names and be used multiple=
 times
> +takes a comma-separated list of board target names and can be used mult=
iple times
>   on the command line:
>  =20
>   .. code-block:: bash
> @@ -212,7 +212,7 @@ Setting up
>      The toolchain-alias section indicates that the i386 toolchain shoul=
d be used
>      to build x86 commits.
>  =20
> -   Note that you can also specific exactly toolchain prefixes if you li=
ke::
> +   Note that you can also specify toolchain prefixes if you like::
>  =20
>         [toolchain-prefix]
>         arm: /opt/arm-eabi-4.6/bin/arm-eabi-
> @@ -243,9 +243,9 @@ Setting up
>  =20
>      This tells buildman to use a compiler wrapper in front of CROSS_COM=
PILE. In
>      this example, ccache. It doesn't affect the toolchain scan. The wra=
pper is
> -   added when CROSS_COMPILE environtal variable is set. The name in thi=
s
> -   section is ignored. If more than one line is provided, only the last=
 one
> -   is taken.
> +   added when the CROSS_COMPILE environment variable is set. The tag na=
me in
> +   this section is not important. If more than one line is provided, on=
ly the
> +   last one is used.
>  =20
>   #. Make sure you have the required Python pre-requisites
>  =20
> @@ -484,7 +484,7 @@ Setting up
>   How to run it
>   -------------
>  =20
> -First do a dry run using the -n flag: (replace <branch> with a real, lo=
cal
> +First do a dry run using the -n flag (replace <branch> with a real, loc=
al
>   branch with a valid upstream):
>  =20
>   .. code-block:: bash
> @@ -898,7 +898,7 @@ The .buildman settings file
>  =20
>   The .buildman file provides information about the available toolchains=
 and
>   also allows build flags to be passed to 'make'. It consists of several
> -sections, with the section name in square brackets. Within each section=
 are
> +sections, with the section name in square brackets. Within each section=
 there are
>   a set of (tag, value) pairs.
>  =20
>   '[global]' section
> @@ -939,8 +939,7 @@ a set of (tag, value) pairs.
>   '[toolchain-prefix]' section
>       This can be used to provide the full toolchain-prefix for one or m=
ore
>       architectures. The full CROSS_COMPILE prefix must be provided. The=
se
> -    typically have a higher priority than matches in the '[toolchain]',=
 due to
> -    this prefix.
> +    typically have a higher priority than matches in the '[toolchain]'.
>  =20
>       The tilde character ``~`` is supported in paths, to represent the =
home
>       directory.
> @@ -1062,7 +1061,7 @@ For example::
>       + u-boot.cfg: CONFIG_SPL_ENV_SUPPORT=3D1 CONFIG_SPL_NET=3D1
>       + u-boot-spl.cfg: CONFIG_SPL_MMC=3D1 CONFIG_SPL_NAND_SUPPORT=3D1
>       + all: CONFIG_SPL_ENV_SUPPORT=3D1 CONFIG_SPL_MMC=3D1 CONFIG_SPL_NA=
ND_SUPPORT=3D1 CONFIG_SPL_NET=3D1
> -    am335x_evm_usbspl :
> +    am335x_evm_usbspl:
>       + u-boot.cfg: CONFIG_SPL_ENV_SUPPORT=3D1 CONFIG_SPL_NET=3D1
>       + u-boot-spl.cfg: CONFIG_SPL_MMC=3D1 CONFIG_SPL_NAND_SUPPORT=3D1
>       + all: CONFIG_SPL_ENV_SUPPORT=3D1 CONFIG_SPL_MMC=3D1 CONFIG_SPL_NA=
ND_SUPPORT=3D1 CONFIG_SPL_NET=3D1
> @@ -1073,15 +1072,15 @@ This shows that commit 44 enabled three new opti=
ons for the board
>   am335x_evm_usbspl which were not enabled in commit 43. There is also a
>   summary for 'arm' showing all the changes detected for that architectu=
re.
>   In this case there is only one board with changes, so 'arm' output is =
the
> -same as 'am335x_evm_usbspl'/
> +same as 'am335x_evm_usbspl'.
>  =20
>   The -K option uses the u-boot.cfg, spl/u-boot-spl.cfg and tpl/u-boot-t=
pl.cfg
>   files which are produced by a build. If all you want is to check the
>   configuration you can in fact avoid doing a full build, using --config=
-only.
> -This tells buildman to configuration U-Boot and create the .cfg files, =
but not
> +This tells buildman to configure U-Boot and create the .cfg files, but =
not
>   actually build the source. This is 5-10 times faster than doing a full=
 build.
>  =20
> -By default buildman considers the follow two configuration methods
> +By default buildman considers the following two configuration methods
>   equivalent::
>  =20
>      #define CONFIG_SOME_OPTION
> @@ -1089,7 +1088,7 @@ equivalent::
>      CONFIG_SOME_OPTION=3Dy
>  =20
>   The former would appear in a header filer and the latter in a defconfi=
g
> -file. The achieve this, buildman considers 'y' to be '1' in configurati=
on
> +file. To achieve this, buildman considers 'y' to be '1' in configuratio=
n
>   variables. This avoids lots of useless output when converting a CONFIG
>   option to Kconfig. To disable this behaviour, use --squash-config-y.
>  =20
> @@ -1176,7 +1175,7 @@ Use the -L (--no-lto) flag to disable LTO.
>   Doing a simple build
>   --------------------
>  =20
> -In some cases you just want to build a single board and get the full ou=
tput, use
> +In some cases you just want to build a single board and get the full ou=
tput. Use
>   the -w option, for example:

Keep it simple:

   In case you want to build as single board and get the full output, use
   the -w option, for example:


>  =20
>   .. code-block:: bash
> @@ -1262,7 +1261,7 @@ Some options have values, in which case you can ch=
ange them:
>       buildman -a 'BOOTCOMMAND=3D"echo hello"' CONFIG_SYS_LOAD_ADDR=3D0x=
1000
>  =20
>   Note that you must put quotes around string options and the whole thin=
g must be

%s/thing/argument/

> -in single quotes, to make sure the shell leave it alone.
> +in single quotes, to make sure the shell leaves it alone.

%s/, to make sure the shell leaves it alone./to ensure that the shell=20
recognizes it as a single argument./

>  =20
>   If you try to set an option that does not exist, or that cannot be cha=
nged for
>   some other reason (e.g. it is 'selected' by another option), then buil=
dman
> @@ -1281,8 +1280,8 @@ shows an error::
>  =20
>   One major caveat with this feature with branches (-b) is that buildman=
 does not
>   name the output directories differently when you change the configurat=
ion, so
> -doing the same build again with different configuration will not trigge=
r a
> -rebuild. You can use -f to work around that.
> +doing the same build with a different configuration will not trigger a =
rebuild.
> +You can use -f to work around that.

"Doing a build does not trigger a rebuild." - This sentence is not=20
comprehensible.

Do you mean

"Re-launching buildman with an updated configuration will not trigger a=20
rebuild."


>  =20
>  =20
>   Other options
> @@ -1344,7 +1343,7 @@ directory.
>   Build summary
>   -------------
>  =20
> -When buildman finishes it shows a summary, something like this::
> +When buildman finishes it shows a summary. Something like this::

When Buildman finishes, it displays a summary, similar to the following::

>  =20
>       Completed: 5 total built, duration 0:00:21, rate 0.24
>  =20
> @@ -1378,7 +1377,7 @@ Use the `--maintainer-check` option to check this:=
:
>      WARNING: board/mikrotik/crs3xx-98dx3236/MAINTAINERS: missing defcon=
fig ending at line 7
>      WARNING: no maintainers for 'clearfog_spi'
>  =20
> -Buildman returns with an exit code of 2 if there area any warnings.
> +Buildman returns with an exit code of 2 if there are any warnings.
>  =20
>   An experimental `--full-check option` also checks for boards which don=
't have a

These should be double backticks.

Best regards

Heinrich


>   CONFIG_TARGET_xxx where xxx corresponds to their defconfig filename. T=
his is

