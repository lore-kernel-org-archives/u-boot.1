Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD56ACA0EF8
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D3E781E13;
	Wed, 20 Aug 2025 23:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aa9OMace";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8DB081FEE; Wed, 20 Aug 2025 23:21:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB01801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 23:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755724907; x=1756329707; i=xypron.glpk@gmx.de;
 bh=9TLmkbWxqMNsTWjB3CKvcNRzBUdLWG3QIOTm9cYizx4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aa9OMaceWiFkC1ogvOdmHUOZbXI0QI+c5v/JJ0wQ4nsxc7/jnJcOnQTfKRYC4w/F
 OCYZmUjTa3pkESnUK/gg/UC+r/QfdyRcMbHfq/ARgzTjJsiff1NBrYUY0jAEBEJP7
 ewGd1BMc539M6lwnWhfF4r20SU/Gwk/wpsW/L8uZvEf9P4gE5c9O1YfqJSccRAciZ
 6ZYeVnKJ9/RHf48Oj7Cw6RCOjIZr5nyc/vwLzGeJi1A8s85bDktpsHjZ5rCYLv5DQ
 RKpAWLG46rMju8mLrBnWwoMg5E7gPymgxquob+F4HSF3FR9UGNTiDddbKoqCMG+ha
 QJ21bMQAja7Cc/rDxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1ubYnR3obj-00zLzi; Wed, 20
 Aug 2025 23:21:46 +0200
Message-ID: <b1425bd1-2082-44cf-b8d3-9db0ca9c7d5d@gmx.de>
Date: Wed, 20 Aug 2025 23:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] doc: Quote all long form options using double ticks
 in tools/buildman/buildman.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-5-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-5-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AQ91Ds5OYxAZ18Z2GH4cl5qJ5/nayB6WvWtEvjLNz2JBoqRp9d7
 GeoxQB6TVbrSnJ4g3bItTyBmshZCmiMgDj4NQfWNeE+sbUcxWNun43P4Bf2s13Rl8nsa1gQ
 TsPUDpDGktuasd0b3AptiSZWdjXtEwt30XsD7F0/OCEs23RXjfYCVezsDDA76F3NOefabK9
 xVZT9UhF60w7hwu1M541w==
UI-OutboundReport: notjunk:1;M01:P0:OEdqnviFtus=;kFSg59M2VoC8ZCUAk358y69xxAy
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

The Unicode character commonly referred to as a "tick" or "check mark"=20
is U+2713 (=E2=9C=93).

Unicode calls the character U+0060 grave accent. Sphinx documentation=20
refers to it as backtick.

Otherwise the change looks ok.

Best regards

Heinrich

On 11.08.25 01:37, Adriano Carvalho wrote:
> Otherwise, the two dashes are rendered as just one.
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>   tools/buildman/buildman.rst | 50 ++++++++++++++++++-------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index a9d5543a1a4..48938044520 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -100,8 +100,8 @@ threads do not affect the state of your git reposito=
ry. Any checkouts done
>   by the thread affect only the working directory for that thread.
>  =20
>   Buildman automatically selects the correct tool chain for each board. =
You
> -must supply suitable tool chains (see --fetch-arch), but buildman takes=
 care
> -of selecting the right one.
> +must supply suitable tool chains (see ``--fetch-arch``), but buildman t=
akes
> +care of selecting the right one.
>  =20
>   Buildman generally builds a branch (with the -b flag), and in this cas=
e
>   builds the upstream commit as well, for comparison. So even if you hav=
e one
> @@ -153,9 +153,9 @@ You can also use -x to specifically exclude some boa=
rds. For example:
>   means to build all arm boards except nvidia, freescale and anything en=
ding
>   with 'ball'.
>  =20
> -For building specific boards you can use the --boards (or --bo) option,=
 which
> -takes a comma-separated list of board target names and can be used mult=
iple times
> -on the command line:
> +For building specific boards you can use the ``--boards`` (or ``--bo``)=
 option,
> +which takes a comma-separated list of board target names and can be use=
d
> +multiple times on the command line:
>  =20
>   .. code-block:: bash
>  =20
> @@ -492,7 +492,7 @@ branch with a valid upstream):
>      ./tools/buildman/buildman -b <branch> -n
>  =20
>   If it can't detect the upstream branch, try checking out the branch, a=
nd
> -doing something like 'git branch --set-upstream-to upstream/master'
> +doing something like ``git branch --set-upstream-to upstream/master``
>   or something similar. Buildman will try to guess a suitable upstream b=
ranch
>   if it can't find one (you will see a message like "Guessing upstream a=
s ...").
>   You can also use the -c option to manually specify the number of commi=
ts to
> @@ -731,17 +731,17 @@ Note that the 'text' region and 'rodata' are split=
 out. You should add the
>   two together to get the total read-only size (reported as the first co=
lumn
>   in the output from binutil's 'size' utility).
>  =20
> -A useful option is --step which lets you skip some commits. For example
> ---step 2 will show the image sizes for only every 2nd commit (so it wil=
l
> +A useful option is ``--step`` which lets you skip some commits. For exa=
mple
> +``--step 2`` will show the image sizes for only every 2nd commit (so it=
 will
>   compare the image sizes of the 1st, 3rd, 5th... commits). You can also=
 use
> ---step 0 which will compare only the first and last commits. This is us=
eful
> +``--step 0`` which will compare only the first and last commits. This i=
s useful
>   for an overview of how your entire series affects code size. It will b=
uild
>   only the upstream commit and your final branch commit.
>  =20
>   You can also use -d to see a detailed size breakdown for each board. T=
his
>   list is sorted in order from largest growth to largest reduction.
>  =20
> -It is even possible to go a little further with the -B option (--bloat)=
. This
> +It is even possible to go a little further with the -B option (``--bloa=
t``). This
>   shows where U-Boot has bloated, breaking the size change down to the f=
unction
>   level. Example output is below::
>  =20
> @@ -924,7 +924,7 @@ a set of (tag, value) pairs.
>       This lists the available toolchains. The tag here doesn't matter, =
but
>       make sure it is unique. The value is the path to the toolchain. Bu=
ildman
>       will look in that path for a file ending in 'gcc'. It will then ex=
ecute
> -    it to check that it is a C compiler, passing only the --version fla=
g to
> +    it to check that it is a C compiler, passing only the ``--version``=
 flag to
>       it. If the return code is 0, buildman assumes that it is a valid C
>       compiler. It uses the first part of the name as the architecture a=
nd
>       strips off the last part when setting the CROSS_COMPILE environmen=
t
> @@ -1005,7 +1005,7 @@ By default, buildman doesn't execute 'make mrprope=
r' prior to building the
>   first commit for each board. This reduces the amount of work 'make' do=
es, and
>   hence speeds up the build. To force use of 'make mrproper', use -the -=
m flag.
>   This flag will slow down any buildman invocation, since it increases t=
he amount
> -of work done on any build. An alternative is to use the --fallback-mrpr=
oper
> +of work done on any build. An alternative is to use the ``--fallback-mr=
proper``
>   flag, which retries the build with 'make mrproper' only after a build =
failure.
>  =20
>   One possible application of buildman is as part of a continual edit, b=
uild,
> @@ -1040,7 +1040,7 @@ of the source tree, thus allowing rapid tested evo=
lution of the code::
>  =20
>       ./tools/buildman/buildman -Pr tegra
>  =20
> -Note also the `--dtc-skip` option which uses the system device-tree com=
piler to
> +Note also the ``--dtc-skip`` option which uses the system device-tree c=
ompiler to
>   avoid needing to build it for each board. This can save 10-20% of buil=
d time.
>   An alternative is to set DTC=3D/path/to/dtc when running buildman.
>  =20
> @@ -1076,7 +1076,7 @@ same as 'am335x_evm_usbspl'.
>  =20
>   The -K option uses the u-boot.cfg, spl/u-boot-spl.cfg and tpl/u-boot-t=
pl.cfg
>   files which are produced by a build. If all you want is to check the
> -configuration you can in fact avoid doing a full build, using --config-=
only.
> +configuration you can in fact avoid doing a full build, using ``--confi=
g-only``.
>   This tells buildman to configure U-Boot and create the .cfg files, but=
 not
>   actually build the source. This is 5-10 times faster than doing a full=
 build.
>  =20
> @@ -1090,7 +1090,7 @@ equivalent::
>   The former would appear in a header filer and the latter in a defconfi=
g
>   file. To achieve this, buildman considers 'y' to be '1' in configurati=
on
>   variables. This avoids lots of useless output when converting a CONFIG
> -option to Kconfig. To disable this behaviour, use --squash-config-y.
> +option to Kconfig. To disable this behaviour, use ``--squash-config-y``=
.
>  =20
>  =20
>   Checking the environment
> @@ -1165,7 +1165,7 @@ Link-time optimisation (LTO) is designed to reduce=
 code size by globally
>   optimising the U-Boot build. Unfortunately this can dramatically slow =
down
>   builds. This is particularly noticeable when running a lot of builds.
>  =20
> -Use the -L (--no-lto) flag to disable LTO.
> +Use the -L (``--no-lto``) flag to disable LTO.
>  =20
>   .. code-block:: bash
>  =20
> @@ -1195,7 +1195,7 @@ each error line. Also, buildman prints information=
 about what it is about to do,
>   along with a summary at the end.
>  =20
>   When using buildman from an IDE, it is helpful to drop this behaviour.=
 Use the
> --I/--ide option for that. You might find -W helpful also so that warnin=
gs do
> +``-I/--ide`` option for that. You might also find -W helpful so that wa=
rnings do
>   not cause the build to fail:
>  =20
>   .. code-block:: bash
> @@ -1287,7 +1287,7 @@ You can use -f to work around that.
>   Other options
>   -------------
>  =20
> -Buildman has various other command-line options. Try --help to see them=
.
> +Buildman has various other command-line options. Try ``--help`` to see =
them.
>  =20
>   To find out what toolchain prefix buildman will use for a build, use t=
he -A
>   option.
> @@ -1325,11 +1325,11 @@ figure out the root cause of the build failure.
>  =20
>   For situations where buildman is invoked from multiple running process=
es, it is
>   sometimes useful to have buildman wait until the others have finished.=
 Use the
> ---process-limit option for this: --process-limit 1 will allow only one =
buildman
> -to process jobs at a time.
> +``--process-limit`` option for this: ``--process-limit 1`` will allow o=
nly one
> +buildman to process jobs at a time.
>  =20
>   To build a particular target, rather than the default U-Boot target, u=
se the
> -`--target` option. This is unlikely to be useful unless you are buildin=
g a
> +``--target`` option. This is unlikely to be useful unless you are build=
ing a
>   single board.
>  =20
>   Buildman normally builds out-of-tree, meaning that the source director=
y is not
> @@ -1358,7 +1358,7 @@ Using boards.cfg
>  =20
>   This file is no-longer needed by buildman but it is still generated in=
 the
>   working directory. This helps avoid a delay on every build, since scan=
ning all
> -the Kconfig files takes a few seconds. Use the `-R <filename>` flag to =
force
> +the Kconfig files takes a few seconds. Use the ``-R <filename>`` flag t=
o force
>   regeneration of the file - in that case buildman exits after writing t=
he file
>   with exit code 2 if there was an error in the maintainer files. To use=
 the
>   default filename, use a hyphen, i.e. `-R -`.
> @@ -1371,7 +1371,7 @@ Checking maintainers
>   --------------------
>  =20
>   Sometimes a board is added without a corresponding entry in a MAINTAIN=
ERS file.
> -Use the `--maintainer-check` option to check this::
> +Use the ``--maintainer-check`` option to check this::
>  =20
>      $ buildman --maintainer-check
>      WARNING: board/mikrotik/crs3xx-98dx3236/MAINTAINERS: missing defcon=
fig ending at line 7
> @@ -1379,8 +1379,8 @@ Use the `--maintainer-check` option to check this:=
:
>  =20
>   Buildman returns with an exit code of 2 if there are any warnings.
>  =20
> -An experimental `--full-check option` also checks for boards which don'=
t have a
> -CONFIG_TARGET_xxx where xxx corresponds to their defconfig filename. Th=
is is
> +An experimental ``--full-check option`` also checks for boards which do=
n't have
> +a CONFIG_TARGET_xxx where xxx corresponds to their defconfig filename. =
This is
>   not strictly necessary, but may be useful information.
>  =20
>  =20

