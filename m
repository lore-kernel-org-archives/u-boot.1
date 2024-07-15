Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11731C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 21:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531F087D74;
	Mon, 15 Jul 2024 23:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="D5Qvup5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E0887919; Mon, 15 Jul 2024 23:58:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C6D88677
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 23:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721080686; x=1721685486; i=xypron.glpk@gmx.de;
 bh=el4wbZi6La9Htv4b8QNIyoZ2JQ1bzu+ki5zzv7iweB4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=D5Qvup5dG2BnHf0K/slEbDgnlUehW0JETQXy6TmSg7MAPALyamBoiW0ME3XWVbq2
 +wm4hZ6yd/VtY4+A5GQiY4HXGWTalNUTt4jRqCV/nzzK0D09LGwE6/GQ16IQYz/ff
 oVoIm1nLqT6Sfr1C2Az+QMXQORG76ckomZSYlJ4kFhiQzAVanTXp0A6smxG1bI3tB
 8jkfxgDEuRvewVGPKzToHAIk5uw+MPyUsKtecUH1gXrdRsdrfCyAJY9/UH0mRaMZ3
 4Csx9r/UE0P0v8U9eSxTJXdUrUaSLVTHtnoCxLAX9fbOBMlwaawKpDFWqguvGuL0k
 M0X5eI6h7ORKX53xGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1rwsmF47ZK-00fC99; Mon, 15
 Jul 2024 23:58:06 +0200
Message-ID: <22edf937-af4d-4cf5-a251-095c1615cb4a@gmx.de>
Date: Mon, 15 Jul 2024 23:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] doc: Move bootstd into its own directory
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Dahl <ada@thorsis.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 E Shattow <lucent@gmail.com>, Jaewon Jung <jaewon8868@gmail.com>,
 Janne Grunau <j@jannau.net>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240715101354.97895-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CURdatxLlgJRFq6DruisyOk4idinvbughauIs4rCl5Sf4vp2hrw
 XmPYQd4IFTnTvfPi7tyr499FsKDScv5Cky6P2U9IWDkKNtIHxSiB0SmsRbPRR8yrL0PdrYV
 a9/Cwx/VQv6FhHamtj522elNtSfsMi8a5bzwIztvxCVE6rX9rqFvBSEAsQF3p5c6oUZDbM8
 7+FDuJgTfEm2Pze1eKzjg==
UI-OutboundReport: notjunk:1;M01:P0:7iuIhORVeYk=;JwiSkNNoHk96O8Z0kO/pLMG90uR
 QI9KgqmkqF9S8Ee6bzTetgStxcRFGoFdNp1m0D+CgqlpTaNdoA+IwYs1U+6T6Nkl99pSoJvqR
 /3DCrdaDt9ORO/HMvotqfarRtqDGWIrvBPdHwSjlLGZ4EFiztIULbZHZ6BgV7xgsnDxeq1RXD
 UDRn3MOZsPTAvaTQA5Es/UPsHIhc8MYr//uGDKrlUhlmljH/JCVwIBSXlxi2mKWSrGDCtXYsM
 ojFc/ySbWWJCO60n5PxBGqg0yk0TUbe7kC1s++xXhgThchDcAHb/kUtdQ9R/GYPAiI79a0C6Z
 TZ4FMBC9attoDs+jtN6Y3SPfyloHrp0VFWra8mP8NooRTI6tszNj+TLhJsISo4wn+Ittgdk/W
 pJm6G0mV+27jkGLTYCCb0PI1KYWpBU15ZOxfYjqRSzTMItAdlCmwg+zAGnL0VnkzN/l0qnPgZ
 n/lX8wMxEVTmMyUuIcPwVCaXM+/T0UnLfj+l5bWfTxuDS4/QIYns3oT1joCGBw0CcGY7w5eKT
 NyvElmdi2jOYwjL9TbniExjazu53q5HU84CX2evVqlJK8tAT6j08gMA1g+y+S/yiKH/Rb6kRp
 IihBX4IYE/bQ7whesRyWehv6W73gk4dOEKT1SESQVk/MIrYaMeO+rqFMOKNu2B71RakQTxolD
 JMYjzlD3VL5VuLVvBeoMwJcTZoIhCivyw6mAxr2USgH9tVuRNTxHAmRPcee9G785x7mn2+QJ3
 lBIUZ6yomKoJkc9c/BYr1kfnSxvliuQ65f9gkQYUtTp6F7cPq5eZ7sVBO0MM5IIX94kcPjCdk
 7uZtZ5CtnjN5cDG7Wg2g3KtA==
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

On 7/15/24 12:13, Simon Glass wrote:
> Before adding more files, move the bootstd docs into a new directory,
> with an index.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   MAINTAINERS                                       |  2 +-
>   doc/board/starfive/milk-v_mars_cm.rst             |  2 +-
>   doc/develop/board_best_practices.rst              |  2 +-
>   doc/develop/bootstd/index.rst                     |  9 +++++++++
>   doc/develop/{bootstd.rst =3D> bootstd/overview.rst} | 14 +++++++------=
-
>   doc/develop/index.rst                             |  2 +-
>   doc/usage/cmd/bootdev.rst                         |  2 +-
>   doc/usage/cmd/bootflow.rst                        |  2 +-
>   doc/usage/cmd/bootmeth.rst                        |  2 +-
>   doc/usage/environment.rst                         |  2 +-
>   10 files changed, 24 insertions(+), 15 deletions(-)
>   create mode 100644 doc/develop/bootstd/index.rst
>   rename doc/develop/{bootstd.rst =3D> bootstd/overview.rst} (99%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bee9284cca..86b830aa997 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -927,7 +927,7 @@ F:	boot/bootmeth*.c
>   F:	boot/bootstd.c
>   F:	cmd/bootdev.c
>   F:	cmd/bootflow.c
> -F:	doc/develop/bootstd.rst
> +F:	doc/develop/bootstd/
>   F:	doc/usage/bootdev.rst
>   F:	doc/usage/bootflow.rst
>   F:	doc/usage/bootmeth.rst
> diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/=
milk-v_mars_cm.rst
> index b31de6043bb..52d4e5e9098 100644
> --- a/doc/board/starfive/milk-v_mars_cm.rst
> +++ b/doc/board/starfive/milk-v_mars_cm.rst
> @@ -89,7 +89,7 @@ provide a default value.
>
>   The variable *$fdtfile* is used in the boot process to automatically l=
oad
>   a device-tree provided by the operating system. For details of the boo=
t
> -process refer to the :doc:`U-Boot Standard Boot <../../../develop/boots=
td>`
> +process refer to the :doc:`/develop/bootstd/index`
>   description.
>
>   Boot source selection
> diff --git a/doc/develop/board_best_practices.rst b/doc/develop/board_be=
st_practices.rst
> index f44401eab7d..09632c80ce7 100644
> --- a/doc/develop/board_best_practices.rst
> +++ b/doc/develop/board_best_practices.rst
> @@ -7,7 +7,7 @@ In addition to the regular best practices such as using =
:doc:`checkpatch` and
>   following the :doc:`docstyle` and the :doc:`codingstyle` there are som=
e things
>   which are specific to creating a new board port.
>
> -* Implement :doc:`bootstd` to ensure that most operating systems will b=
e
> +* Implement :doc:`bootstd/index` to ensure that most operating systems =
will be
>     supported by the platform.
>
>   * The platform defconfig file must be generated via `make savedefconfi=
g`.
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.r=
st
> new file mode 100644
> index 00000000000..f4f87c7787c
> --- /dev/null
> +++ b/doc/develop/bootstd/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Standard Boot
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   overview
> diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd/overview.rst
> similarity index 99%
> rename from doc/develop/bootstd.rst
> rename to doc/develop/bootstd/overview.rst
> index 34631089ae0..761f61a573b 100644
> --- a/doc/develop/bootstd.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -1,7 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0+:
>
> -U-Boot Standard Boot
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Standard Boot Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>



The text is not optimized for readability, e.g.

"- bootdev  - a device which can hold or access a distro (e.g. MMC,
Ethernet)"

Please, consistently replace the non-words in the boot standard
documentation:

%s/bootdev/boot device/
%s/bootmeth/boot method/
%s/bootflow/boot flow/

"distro" isn't a dictionary word either. Do you mean operating system?
That term would still not catch what a boot device is:

The boot device is the device that holds the next boot stage.

This could for instance be GRUB which in turn will offer a menu allowing
to select one of multiple operating systems.

Or that next boot stage could be an operating system kernel together
with its initial ram disk and a device-tree.

Best regards

Heinrich



>   Introduction
>   ------------
> @@ -17,7 +17,7 @@ introduces the following concepts:
>   For Linux, the distro (Linux distribution, e.g. Debian, Fedora) is res=
ponsible
>   for creating a bootflow for each kernel combination that it wants to o=
ffer.
>   These bootflows are stored on media so they can be discovered by U-Boo=
t. This
> -feature is typically called `distro boot` (see :doc:`distro`) because i=
t is
> +feature is typically called `distro boot` (see :doc:`../distro`) becaus=
e it is
>   a way for distributions to boot on any hardware.
>
>   Traditionally U-Boot has relied on scripts to implement this feature. =
See
> @@ -32,7 +32,7 @@ way to boot with U-Boot. The feature is extensible to =
different Operating
>   Systems (such as Chromium OS) and devices (beyond just block and netwo=
rk
>   devices). It supports EFI boot and EFI bootmgr too.
>
> -Finally, standard boot supports the operation of :doc:`vbe`.
> +Finally, standard boot supports the operation of :doc:`../vbe`.
>
>   Bootflow
>   --------
> @@ -427,16 +427,16 @@ Three commands are available:
>
>   `bootdev`
>       Allows listing of available bootdevs, selecting a particular one a=
nd
> -    getting information about it. See :doc:`../usage/cmd/bootdev`
> +    getting information about it. See :doc:`/usage/cmd/bootdev`
>
>   `bootflow`
>       Allows scanning one or more bootdevs for bootflows, listing availa=
ble
>       bootflows, selecting one, obtaining information about it and booti=
ng it.
> -    See :doc:`../usage/cmd/bootflow`
> +    See :doc:`/usage/cmd/bootflow`
>
>   `bootmeth`
>       Allow listing of available bootmethds and setting the order in whi=
ch they
> -    are tried. See :doc:`../usage/cmd/bootmeth`
> +    are tried. See :doc:`/usage/cmd/bootmeth`
>
>   .. _BootflowStates:
>
> diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> index f9c4bf839ee..c0107a783fc 100644
> --- a/doc/develop/index.rst
> +++ b/doc/develop/index.rst
> @@ -29,7 +29,7 @@ Implementation
>
>      directories
>      bloblist
> -   bootstd
> +   bootstd/index
>      ci_testing
>      commands
>      config_binding
> diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
> index f759abab354..98a0f43c580 100644
> --- a/doc/usage/cmd/bootdev.rst
> +++ b/doc/usage/cmd/bootdev.rst
> @@ -22,7 +22,7 @@ Description
>   The `bootdev` command is used to manage bootdevs. It can list availabl=
e
>   bootdevs, select one and obtain information about it.
>
> -See :doc:`../../develop/bootstd` for more information about bootdevs in=
 general.
> +See :doc:`/develop/bootstd/index` for more information about bootdevs i=
n general.
>
>
>   bootdev list
> diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
> index 6519e4880a9..5d41fe37a7a 100644
> --- a/doc/usage/cmd/bootflow.rst
> +++ b/doc/usage/cmd/bootflow.rst
> @@ -26,7 +26,7 @@ Description
>   The `bootflow` command is used to manage bootflows. It can scan bootde=
vs to
>   locate bootflows, list them and boot them.
>
> -See :doc:`../../develop/bootstd` for more information.
> +See :doc:`/develop/bootstd/index` for more information.
>
>   Note that `CONFIG_BOOTSTD_FULL` (which enables `CONFIG_CMD_BOOTFLOW_FU=
LL) must
>   be enabled to obtain full functionality with this command. Otherwise, =
it only
> diff --git a/doc/usage/cmd/bootmeth.rst b/doc/usage/cmd/bootmeth.rst
> index bac9fdf85cd..c3d2ec1574b 100644
> --- a/doc/usage/cmd/bootmeth.rst
> +++ b/doc/usage/cmd/bootmeth.rst
> @@ -21,7 +21,7 @@ Description
>   The `bootmeth` command is used to manage bootmeths. It can list them a=
nd change
>   the order in which they are used.
>
> -See :doc:`../../develop/bootstd` for more information.
> +See :doc:`/develop/bootstd/index` for more information.
>
>
>   .. _bootmeth_order:
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index 7d4b448cb30..cc33d3ec0f2 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -100,7 +100,7 @@ to add environment variables.
>
>   Board maintainers are encouraged to migrate to the text-based environm=
ent as it
>   is easier to maintain. The distro-board script still requires the old-=
style
> -environments, so use :doc:`../develop/bootstd` instead.
> +environments, so use :doc:`/develop/bootstd/index` instead.
>
>
>   List of environment variables

