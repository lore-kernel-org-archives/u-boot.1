Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA984C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 17:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D790833EC;
	Thu, 17 Jul 2025 19:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arm-com.20230601.gappssmtp.com header.i=@arm-com.20230601.gappssmtp.com header.b="q71CZu4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF878343B; Thu, 17 Jul 2025 19:03:31 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1F28334F
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 19:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sudeepholla.maillist@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-32ce1b2188dso10562911fa.3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm-com.20230601.gappssmtp.com; s=20230601; t=1752771804; x=1753376604;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53zaHCU50ARkDr69gnHrkuV8Qx3lpG+WxlWGEiT3/vA=;
 b=q71CZu4lf1tyuzNHoJqaTZhmV5scfrMdQv9urYG5xuDoTJaOTb36W/0q1cjM/2Eyo1
 1l4+G/t4SObYp0POxPoZ0UQxnEf5qhTu4zTiKvMIB05eEvYN4zCmG5uFrCDgApCURMng
 avWku0LD6VPqp8oWAK4lSYibq8lEQTXBVXg/4oVckxo77RHTYIdUaPo0Td09UPUOQnDY
 ryO+59P+UC6JYoz3Y20yIGJSVwp28iMWFrgPpFQ+h+Qv+QjMnnuZirLd78cY5mapk2dR
 xZ+pF5ly0iXWVt8HMfunqIs+BuStEQKrqEjAswoYY1mU9FmKvsetPZ1J5m5hWhcgRuw9
 VVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752771804; x=1753376604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53zaHCU50ARkDr69gnHrkuV8Qx3lpG+WxlWGEiT3/vA=;
 b=TyXoO/cwMVzUrHiZYE462wMYDH9VKZzaOENriOmCv8pyNRgngeCAoXNRtYge9TB1cR
 qO7r82JWMjKMEcLxYKNDAFOM7CTIRgZ4M3zqE8olD/AXy7sq5OZKD20zqO44D3cPMaEq
 CWammM7Z6of/uO0oSl8CizDAPE6gQweUwwzulv5t7B8qqcHU2Jj/np2IcPXKeZlBl9OT
 HSrcVhernV/OMWuv+D8c7iyD66MRAh7BjT53tskDsQA5OBEfoFZ2qBkw0wxUCjv2zQUb
 fR0VHhZfNklgfw9MEEr8OOGRzFSDduSETKz611ildIgfDXkG+BJr7DcPSQHcfXhRi7sv
 WTGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDTOiu9AX3Wtw0fbGpAtRtLAs7EuC4VPTF+dRu8bMc6q2TVEy1TsxHmNW4bO87QcBWIZsgWuE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxt+b/SaU8bdvixCd5c5qkwZuQs2FeZlViHSRHJV2QN5JnPzKa6
 fCDN7jTDI08j4YoeACmYA9NlZ2VGR2M1FCB4M1itEbIJH30JupZW9Aqw6arf7EH4XwNQkNz4yxE
 4WvLbiMIgAXI4oQoFTIE3c3MRlaSKVPU=
X-Gm-Gg: ASbGncs3kjv+BtV3I6fUzOy2DCC7Yl0m+ZDZ22rbIH+cnPCQ6slsOYrLRPcnNFvCEnk
 dpRQNWewkgghIm67NY9V1+z92p3VkgH8BkQItDmmUnq8zfjlPudZsPhAo2/sFQAcVVVVAB+iCrW
 DG01u1vCV3fWjyqUbTboXSI7irfFVWrY1wcgTlTIVEWeTe4TKuUOr/Kfw04NBkXdMmr2ZRr+R34
 AbM/JaF
X-Google-Smtp-Source: AGHT+IGqRof23DS4nAmsMqVoTYJxolEu8jVCEjvVOeSpCYNs3/SYVAMZvyDeczPD4b3PSPDi2jOk4bl1ax/jY7iH4p0=
X-Received: by 2002:a2e:80d4:0:b0:32f:219d:760d with SMTP id
 38308e7fff4ca-3309a578108mr8110361fa.20.1752771802160; Thu, 17 Jul 2025
 10:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20250627185723.342553-2-ilias.apalodimas@linaro.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 17 Jul 2025 18:03:09 +0100
X-Gm-Features: Ac12FXwNUxnxVMx_Fv06N8r7Kpn_-ePTPPKvuZIc8FQVoR7-Fbc5ZHDJsDNEUho
Message-ID: <CAPKp9uZPPOdQi_vFKEjTA4NE3oy0WPth-ugc21wKR7GPu4OD1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sughosh.ganu@linaro.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marek Vasut <marex@denx.de>, 
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Prasad Kummari <prasad.kummari@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de, 
 Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

I see build break with clang after the commit 5f520875bdf0 ("kbuild:
Bump the build system to 5.1"):

Build command:
$make -j`nproc` ARCH=3Darm64 O=3D$BUILD_DIR
CROSS_COMPILE=3Daarch64-none-linux-gnu- HOSTCC=3Dclang
vexpress_aemv8a_semi_defconfig
$make -j`nproc` ARCH=3Darm   O=3D$BUILD_DIR
CROSS_COMPILE=3Daarch64-none-linux-gnu- HOSTCC=3Dclang CC=3Dclang all

Error:
clang: error: unsupported option '-mno-thumb' for target
'aarch64-none-linux-gnu'
clang: error: unsupported option '-mno-movt' for target 'aarch64-none-linux=
-gnu'
clang: error: unsupported option '-mno-thumb' for target
'aarch64-none-linux-gnu'
clang: error: unsupported option '-mno-movt' for target 'aarch64-none-linux=
-gnu'

On Fri, Jun 27, 2025 at 7:58=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Our last sync with the kernel was 5.1. Even that was a partial one
> as some patches from 4.x kernels were already missing making the
> transition to a modern kbuild infeasible.
>
> We are so out of sync now, that tracking the patches and backporting
> them one by one makes little sense and it's going to take ages.
>
> This is an attempt to sync up Makefile[.lib/.kbuild].
> Unfortunately due to sheer amount of patches this is not easy to review,
> but that's what we decided during a community call.
>
> One of the biggest changes is get rid of partial linking entirely and
> build .a archives isntead of .o.
> We diaviate from the kernel on that. Instead of calling a custom script
> to create the archive symbol table, we call ar with rcTP (isntead of
> rcSTP) since we want a resulting archive that's sauble with the linker.
>
> The only affected platforms are PPC ones. Unfortunately I don't have any
> of them around to test, but the objdump of the resulting files --
> arch/powerpc/lib/built-in.[oa] looks identical.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
> Changes since v1:
> - Bring back -std=3Dgnu11 which was accidentally dropped
> - Don't simplify our 'silent' rules since they mame macOS builds always s=
ilent
>  Makefile                        | 858 ++++++++++++++++++++------------
>  board/congatec/common/Makefile  |   4 +-
>  board/cssi/cmpc885/u-boot.lds   |   4 +-
>  board/cssi/mcr3000/u-boot.lds   |   4 +-
>  board/freescale/common/Makefile |   4 +-
>  board/menlo/mx8menlo/Makefile   |   4 +-
>  board/phytec/common/Makefile    |   4 +-
>  board/samsung/origen/Makefile   |   4 +-
>  board/samsung/smdkv310/Makefile |   4 +-
>  board/toradex/common/Makefile   |   4 +-
>  doc/api/linker_lists.rst        |   8 +-
>  doc/develop/crash_dumps.rst     |   8 +-
>  scripts/Makefile.build          | 284 ++++++++---
>  scripts/Makefile.gcc-plugins    |  59 +++
>  scripts/Makefile.kcov           |   9 +
>  scripts/Makefile.lib            | 114 +++--
>  scripts/Makefile.xpl            |   2 +-
>  tools/buildman/builderthread.py |   2 +-
>  18 files changed, 913 insertions(+), 467 deletions(-)
>  create mode 100644 scripts/Makefile.gcc-plugins
>  create mode 100644 scripts/Makefile.kcov
>
> diff --git a/Makefile b/Makefile
> index e60bbb01a004..db8d89587290 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -12,6 +12,10 @@ NAME =3D
>  # Comments in this file are targeted only to the developer, do not
>  # expect to learn how to build the kernel reading this file.
>
> +# That's our default target when none is given on the command line
> +PHONY :=3D _all
> +_all:
> +
>  # Determine target architecture for the sandbox
>  include include/host_arch.h
>  ifeq ("", "$(CROSS_COMPILE)")
> @@ -41,7 +45,7 @@ undefine MK_ARCH
>  # Most importantly: sub-Makefiles should only ever modify files in
>  # their own directory. If in some directory we have a dependency on
>  # a file in another dir (which doesn't happen often, but it's often
> -# unavoidable when linking the built-in.o targets which finally
> +# unavoidable when linking the built-in.a targets which finally
>  # turn into vmlinux), we will call a sub make in that other dir, and
>  # after that we are sure that everything which is in that other dir
>  # is now up to date.
> @@ -109,7 +113,6 @@ endif
>
>  # If the user is running make -s (silent mode), suppress echoing of
>  # commands
> -
>  ifneq ($(filter 4.%,$(MAKE_VERSION)),) # make-4
>  ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
>    quiet=3Dsilent_
> @@ -137,8 +140,8 @@ export quiet Q KBUILD_VERBOSE
>  # The O=3D assignment takes precedence over the KBUILD_OUTPUT environmen=
t
>  # variable.
>
> -# KBUILD_SRC is set on invocation of make in OBJ directory
> -# KBUILD_SRC is not intended to be used by the regular user (for now)
> +# KBUILD_SRC is not intended to be used by the regular user (for now),
> +# it is set on invocation of make with KBUILD_OUTPUT or O=3D specified.
>
>  # OK, Make called in directory where kernel src resides
>  # Do we want to locate output files in a separate directory?
> @@ -146,19 +149,15 @@ ifeq ("$(origin O)", "command line")
>    KBUILD_OUTPUT :=3D $(O)
>  endif
>
> -# That's our default target when none is given on the command line
> -PHONY :=3D _all
> -_all:
> -
> -# Cancel implicit rules on top Makefile
> -$(CURDIR)/Makefile Makefile: ;
> +ifneq ($(words $(subst :, ,$(CURDIR))), 1)
> +  $(error main directory cannot contain spaces nor colons)
> +endif
>
>  ifneq ($(KBUILD_OUTPUT),)
> -# Invoke a second make in the output directory, passing relevant variabl=
es
>  # check that the output directory actually exists
>  saved-output :=3D $(KBUILD_OUTPUT)
>  KBUILD_OUTPUT :=3D $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTP=
UT) \
> -                                                               && /bin/p=
wd)
> +                                                               && pwd)
>  $(if $(KBUILD_OUTPUT),, \
>       $(error failed to create output directory "$(saved-output)"))
>
> @@ -169,6 +168,7 @@ $(if $(KBUILD_OUTPUT),, \
>  # 'sub-make' below.
>  MAKEFLAGS +=3D --include-dir=3D$(CURDIR)
>
> +need-sub-make :=3D 1
>  else
>
>  # Do not print "Entering directory ..." at all for in-tree build.
> @@ -176,19 +176,34 @@ MAKEFLAGS +=3D --no-print-directory
>
>  endif # ifneq ($(KBUILD_OUTPUT),)
>
> +ifneq ($(filter 3.%,$(MAKE_VERSION)),)
> +# 'MAKEFLAGS +=3D -rR' does not immediately become effective for GNU Mak=
e 3.x
> +# We need to invoke sub-make to avoid implicit rules in the top Makefile=
.
> +need-sub-make :=3D 1
> +# Cancel implicit rules for this Makefile.
> +$(lastword $(MAKEFILE_LIST)): ;
> +endif
> +
>  export sub_make_done :=3D 1
> +
> +ifeq ($(need-sub-make),1)
> +
>  PHONY +=3D $(MAKECMDGOALS) sub-make
>
>  $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: su=
b-make
>         @:
>
> -sub-make: FORCE
> +# Invoke a second make in the output directory, passing relevant variabl=
es
> +sub-make:
>         $(Q)$(MAKE) \
>         $(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=3D$(CURDIR))=
 \
>         -f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
>
> -else # sub_make_done
> +endif # need-sub-make
> +endif # sub_make_done
> +
>  # We process the rest of the Makefile if this is the final invocation of=
 make
> +ifeq ($(need-sub-make),)
>
>  # Do not print "Entering directory ...",
>  # but we want to display it when entering to the output directory
> @@ -202,8 +217,8 @@ MAKEFLAGS +=3D --no-print-directory
>  # Use 'make C=3D2' to enable checking of *all* source files, regardless
>  # of whether they are re-compiled or not.
>  #
> -# See the file "doc/sparse.txt" for more details, including
> -# where to get the "sparse" utility.
> +# See the file "Documentation/dev-tools/sparse.rst" for more details,
> +# including where to get the "sparse" utility.
>
>  ifeq ("$(origin C)", "command line")
>    KBUILD_CHECKSRC =3D $(C)
> @@ -216,6 +231,10 @@ endif
>  # Old syntax make ... SUBDIRS=3D$PWD is still supported
>  # Setting the environment variable KBUILD_EXTMOD take precedence
>  ifdef SUBDIRS
> +  $(warning =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D)
> +  $(warning 'SUBDIRS' will be removed after Linux 5.3)
> +  $(warning Please use 'M=3D' or 'KBUILD_EXTMOD' instead)
> +  $(warning =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D)
>    KBUILD_EXTMOD ?=3D $(SUBDIRS)
>  endif
>
> @@ -223,18 +242,6 @@ ifeq ("$(origin M)", "command line")
>    KBUILD_EXTMOD :=3D $(M)
>  endif
>
> -# If building an external module we do not care about the all: rule
> -# but instead _all depend on modules
> -PHONY +=3D all
> -ifeq ($(KBUILD_EXTMOD),)
> -_all: all
> -else
> -_all: modules
> -PHONY +=3D prepare
> -prepare:
> -       $(cmd_crmodverdir)
> -endif
> -
>  ifeq ($(KBUILD_SRC),)
>          # building in the source tree
>          srctree :=3D .
> @@ -246,132 +253,177 @@ else
>                  srctree :=3D $(KBUILD_SRC)
>          endif
>  endif
> +
> +export KBUILD_CHECKSRC KBUILD_EXTMOD KBUILD_SRC
> +
>  objtree                :=3D .
>  src            :=3D $(srctree)
>  obj            :=3D $(objtree)
>
> -VPATH          :=3D $(srctree)$(if $(KBUILD_EXTMOD),:$(KBUILD_EXTMOD))
> +VPATH          :=3D $(srctree)
>
>  export srctree objtree VPATH
>
> -# Make sure CDPATH settings don't interfere
> -unexport CDPATH
> +# To make sure we do not include .config for any of the *config targets
> +# catch them early, and hand them over to scripts/kconfig/Makefile
> +# It is allowed to specify more targets when calling make, including
> +# mixing *config targets and build targets.
> +# For example 'make oldconfig all'.
> +# Detect when mixed targets is specified, and make a second invocation
> +# of make so .config is not included in this case either (for *config).
>
> -########################################################################=
#
> +version_h :=3D include/generated/version_autogenerated.h
> +timestamp_h :=3D include/generated/timestamp_autogenerated.h
> +defaultenv_h :=3D include/generated/defaultenv_autogenerated.h
> +dt_h :=3D include/generated/dt.h
> +env_h :=3D include/generated/environment.h
>
> -HOSTARCH :=3D $(shell uname -m | \
> -       sed -e s/i.86/x86/ \
> -           -e s/sun4u/sparc64/ \
> -           -e s/arm.*/arm/ \
> -           -e s/sa110/arm/ \
> -           -e s/ppc64/powerpc/ \
> -           -e s/ppc/powerpc/ \
> -           -e s/macppc/powerpc/\
> -           -e s/sh.*/sh/)
> +clean-targets :=3D %clean mrproper cleandocs
> +no-dot-config-targets :=3D $(clean-targets) \
> +                        clobber distclean \
> +                        help %docs check% coccicheck \
> +                        ubootversion backup tests check pcheck qcheck tc=
heck \
> +                        pylint pylint_err _pip pip pip_test pip_release
> +no-sync-config-targets :=3D $(no-dot-config-targets) install %install \
> +                          kernelrelease
>
> -HOSTOS :=3D $(shell uname -s | tr '[:upper:]' '[:lower:]' | \
> -           sed -e 's/\(cygwin\).*/cygwin/')
> +config-targets  :=3D 0
> +mixed-targets   :=3D 0
> +dot-config      :=3D 1
> +may-sync-config :=3D 1
>
> -export HOSTARCH HOSTOS
> +ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
> +       ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
> +               dot-config :=3D 0
> +       endif
> +endif
>
> -########################################################################=
#
> +ifneq ($(filter $(no-sync-config-targets), $(MAKECMDGOALS)),)
> +       ifeq ($(filter-out $(no-sync-config-targets), $(MAKECMDGOALS)),)
> +               may-sync-config :=3D 0
> +       endif
> +endif
>
> -# set default to nothing for native builds
> -ifeq ($(HOSTARCH),$(ARCH))
> -CROSS_COMPILE ?=3D
> +ifneq ($(KBUILD_EXTMOD),)
> +       may-sync-config :=3D 0
>  endif
>
> -KCONFIG_CONFIG ?=3D .config
> -export KCONFIG_CONFIG
> +ifeq ($(KBUILD_EXTMOD),)
> +        ifneq ($(filter config %config,$(MAKECMDGOALS)),)
> +                config-targets :=3D 1
> +                ifneq ($(words $(MAKECMDGOALS)),1)
> +                        mixed-targets :=3D 1
> +                endif
> +        endif
> +endif
>
> -# SHELL used by kbuild
> -CONFIG_SHELL :=3D $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
> -         else if [ -x /bin/bash ]; then echo /bin/bash; \
> -         else echo sh; fi ; fi)
> +# For "make -j clean all", "make -j mrproper defconfig all", etc.
> +ifneq ($(filter $(clean-targets),$(MAKECMDGOALS)),)
> +        ifneq ($(filter-out $(clean-targets),$(MAKECMDGOALS)),)
> +                mixed-targets :=3D 1
> +        endif
> +endif
>
> -HOST_LFS_CFLAGS :=3D $(shell getconf LFS_CFLAGS 2>/dev/null)
> -HOST_LFS_LDFLAGS :=3D $(shell getconf LFS_LDFLAGS 2>/dev/null)
> -HOST_LFS_LIBS :=3D $(shell getconf LFS_LIBS 2>/dev/null)
> +# install and modules_install need also be processed one by one
> +ifneq ($(filter install,$(MAKECMDGOALS)),)
> +        ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
> +               mixed-targets :=3D 1
> +        endif
> +endif
>
> -HOSTCC       =3D cc
> -HOSTCXX      =3D c++
> -KBUILD_HOSTCFLAGS   :=3D -Wall -Wstrict-prototypes -O2 -fomit-frame-poin=
ter \
> -               $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
> -KBUILD_HOSTCXXFLAGS :=3D -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> -KBUILD_HOSTLDFLAGS  :=3D $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
> -KBUILD_HOSTLDLIBS   :=3D $(HOST_LFS_LIBS) $(HOSTLDLIBS)
> +ifeq ($(mixed-targets),1)
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +# We're called with mixed targets (*config and build targets).
> +# Handle them one by one.
>
> -# With the move to GCC 6, we have implicitly upgraded our language
> -# standard to GNU11 (see https://gcc.gnu.org/gcc-5/porting_to.html).
> -# Some Linux distributions (including RHEL7, SLES13, Debian 8) still
> -# have older compilers as their default, so we make it explicit for
> -# these that our host tools are GNU11 (i.e. C11 w/ GNU extensions).
> -CSTD_FLAG :=3D -std=3Dgnu11
> -KBUILD_HOSTCFLAGS +=3D $(CSTD_FLAG)
> +PHONY +=3D $(MAKECMDGOALS) __build_one_by_one
>
> -ifeq ($(HOSTOS),cygwin)
> -KBUILD_HOSTCFLAGS      +=3D -ansi
> -endif
> +$(filter-out __build_one_by_one, $(MAKECMDGOALS)): __build_one_by_one
> +       @:
>
> -# Mac OS X / Darwin's C preprocessor is Apple specific.  It
> -# generates numerous errors and warnings.  We want to bypass it
> -# and use GNU C's cpp. To do this we pass the -traditional-cpp
> -# option to the compiler.  Note that the -traditional-cpp flag
> -# DOES NOT have the same semantics as GNU C's flag, all it does
> -# is invoke the GNU preprocessor in stock ANSI/ISO C fashion.
> -#
> -# Apple's linker is similar, thanks to the new 2 stage linking
> -# multiple symbol definitions are treated as errors, hence the
> -# -multiply_defined suppress option to turn off this error.
> -#
> -ifeq ($(HOSTOS),darwin)
> -# get major and minor product version (e.g. '10' and '6' for Snow Leopar=
d)
> -DARWIN_MAJOR_VERSION   :=3D $(shell sw_vers -productVersion | cut -f 1 -=
d '.')
> -DARWIN_MINOR_VERSION   :=3D $(shell sw_vers -productVersion | cut -f 2 -=
d '.')
> +__build_one_by_one:
> +       $(Q)set -e; \
> +       for i in $(MAKECMDGOALS); do \
> +               $(MAKE) -f $(srctree)/Makefile $$i; \
> +       done
>
> -os_x_before    =3D $(shell if [ $(DARWIN_MAJOR_VERSION) -le $(1) -a \
> -       $(DARWIN_MINOR_VERSION) -le $(2) ] ; then echo "$(3)"; else echo =
"$(4)"; fi ;)
> +else
>
> -os_x_after =3D $(shell if [ $(DARWIN_MAJOR_VERSION) -ge $(1) -a \
> -       $(DARWIN_MINOR_VERSION) -ge $(2) ] ; then echo "$(3)"; else echo =
"$(4)"; fi ;)
> +include scripts/Kbuild.include
>
> -# Snow Leopards build environment has no longer restrictions as describe=
d above
> -HOSTCC       =3D $(call os_x_before, 10, 5, "cc", "gcc")
> -KBUILD_HOSTCFLAGS  +=3D $(call os_x_before, 10, 4, "-traditional-cpp")
> -KBUILD_HOSTLDFLAGS +=3D $(call os_x_before, 10, 5, "-multiply_defined su=
ppress")
> +# Read UBOOTRELEASE from include/config/uboot.release (if it exists)
> +UBOOTRELEASE =3D $(shell cat include/config/uboot.release 2> /dev/null)
> +UBOOTVERSION =3D $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLE=
VEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> +export VERSION PATCHLEVEL SUBLEVEL UBOOTRELEASE UBOOTVERSION
>
> -# macOS Mojave (10.14.X)
> -# Undefined symbols for architecture x86_64: "_PyArg_ParseTuple"
> -KBUILD_HOSTLDFLAGS +=3D $(call os_x_after, 10, 14, "-lpython -dynamclib"=
, "")
> -endif
> +# Modified for U-Boot
> +-include scripts/subarch.include
>
> -# Decide whether to build built-in, modular, or both.
> -# Normally, just do built-in.
> +# Cross compiling and selecting different set of gcc/bin-utils
> +# ----------------------------------------------------------------------=
-----
> +#
> +# When performing cross compilation for other architectures ARCH shall b=
e set
> +# to the target architecture. (See arch/* for the possibilities).
> +# ARCH can be set during invocation of make:
> +# make ARCH=3Dia64
> +# Another way is to have ARCH set in the environment.
> +# The default ARCH is the host where make is executed.
>
> -KBUILD_MODULES :=3D
> -KBUILD_BUILTIN :=3D 1
> +# CROSS_COMPILE specify the prefix used for all executables used
> +# during compilation. Only gcc and related bin-utils executables
> +# are prefixed with $(CROSS_COMPILE).
> +# CROSS_COMPILE can be set on the command line
> +# make CROSS_COMPILE=3Dia64-linux-
> +# Alternatively CROSS_COMPILE can be set in the environment.
> +# Default value for CROSS_COMPILE is not to prefix executables
> +# Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
> +ARCH           ?=3D $(SUBARCH)
>
> -# If we have only "make modules", don't compile built-in objects.
> -# When we're building modules with modversions, we need to consider
> -# the built-in objects during the descend as well, in order to
> -# make sure the checksums are up to date before we record them.
> +# Architecture as present in compile.h
> +UTS_MACHINE    :=3D $(ARCH)
> +SRCARCH        :=3D $(ARCH)
>
> -ifeq ($(MAKECMDGOALS),modules)
> -  KBUILD_BUILTIN :=3D $(if $(CONFIG_MODVERSIONS),1)
> +# Additional ARCH settings for x86
> +ifeq ($(ARCH),i386)
> +        SRCARCH :=3D x86
> +endif
> +ifeq ($(ARCH),x86_64)
> +        SRCARCH :=3D x86
>  endif
>
> -# If we have "make <whatever> modules", compile modules
> -# in addition to whatever we do anyway.
> -# Just "make" or "make all" shall build modules as well
> +# Additional ARCH settings for sparc
> +ifeq ($(ARCH),sparc32)
> +       SRCARCH :=3D sparc
> +endif
> +ifeq ($(ARCH),sparc64)
> +       SRCARCH :=3D sparc
> +endif
>
> -# U-Boot does not need modules
> -#ifneq ($(filter all _all modules,$(MAKECMDGOALS)),)
> -#  KBUILD_MODULES :=3D 1
> -#endif
> +# Additional ARCH settings for sh
> +ifeq ($(ARCH),sh64)
> +       SRCARCH :=3D sh
> +endif
>
> -#ifeq ($(MAKECMDGOALS),)
> -#  KBUILD_MODULES :=3D 1
> -#endif
> +KCONFIG_CONFIG ?=3D .config
> +export KCONFIG_CONFIG
> +
> +# SHELL used by kbuild
> +CONFIG_SHELL :=3D $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
> +         else if [ -x /bin/bash ]; then echo /bin/bash; \
> +         else echo sh; fi ; fi)
> +
> +HOST_LFS_CFLAGS :=3D $(shell getconf LFS_CFLAGS 2>/dev/null)
> +HOST_LFS_LDFLAGS :=3D $(shell getconf LFS_LDFLAGS 2>/dev/null)
> +HOST_LFS_LIBS :=3D $(shell getconf LFS_LIBS 2>/dev/null)
> +
> +HOSTCC       =3D gcc
> +HOSTCXX      =3D g++
> +KBUILD_HOSTCFLAGS   :=3D -Wall -Wstrict-prototypes -O2 \
> +               -fomit-frame-pointer -std=3Dgnu11 $(HOST_LFS_CFLAGS) \
> +               $(HOSTCFLAGS) #-Wmissing-prototypes Enable it and fix war=
nings
> +KBUILD_HOSTCXXFLAGS :=3D -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> +KBUILD_HOSTLDFLAGS  :=3D $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
> +KBUILD_HOSTLDLIBS   :=3D $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>
>  # Check ths size of a binary:
>  # Args:
> @@ -393,19 +445,9 @@ export size_check
>  export KBUILD_MODULES KBUILD_BUILTIN
>  export KBUILD_CHECKSRC KBUILD_SRC KBUILD_EXTMOD
>
> -# We need some generic definitions (do not try to remake the file).
> -scripts/Kbuild.include: ;
> -include scripts/Kbuild.include
> -
>  # Make variables (CC, etc...)
> -
>  AS             =3D $(CROSS_COMPILE)as
> -# Always use GNU ld
> -ifneq ($(shell $(CROSS_COMPILE)ld.bfd -v 2> /dev/null),)
> -LD             =3D $(CROSS_COMPILE)ld.bfd
> -else
>  LD             =3D $(CROSS_COMPILE)ld
> -endif
>  CC             =3D $(CROSS_COMPILE)gcc
>  CPP            =3D $(CC) -E
>  AR             =3D $(CROSS_COMPILE)ar
> @@ -418,10 +460,12 @@ READELF           =3D $(CROSS_COMPILE)readelf
>  LEX            =3D flex
>  YACC           =3D bison
>  AWK            =3D awk
> +INSTALLKERNEL  :=3D installkernel
> +DEPMOD         =3D /sbin/depmod
>  PERL           =3D perl
> -PYTHON         ?=3D python
> +PYTHON         =3D python
>  PYTHON2                =3D python2
> -PYTHON3                ?=3D python3
> +PYTHON3                =3D python3
>
>  # The devicetree compiler and pylibfdt are automatically built unless DT=
C is
>  # provided. If DTC is provided, it is assumed the pylibfdt is available =
too.
> @@ -432,51 +476,79 @@ DTC_MIN_VERSION   :=3D 010406
>  CHECK          =3D sparse
>
>  CHECKFLAGS     :=3D -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
> -                 -Wbitwise -Wno-return-void -Wno-unknown-attribute \
> -                 -D__CHECK_ENDIAN__ $(CF)
> +                 -Wbitwise -Wno-return-void -Wno-unknown-attribute -D__C=
HECK_ENDIAN__ $(CF)
> +NOSTDINC_FLAGS :=3D
> +CFLAGS_MODULE   =3D
> +AFLAGS_MODULE   =3D
> +LDFLAGS_MODULE  =3D
> +CFLAGS_KERNEL  =3D
> +AFLAGS_KERNEL  =3D
> +LDFLAGS_vmlinux =3D
> +
> +# Use USERINCLUDE when you must reference the UAPI directories only.
> +USERINCLUDE    :=3D \
> +               -I$(srctree)/arch/$(SRCARCH)/include/uapi \
> +               -I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
> +               -I$(srctree)/include/uapi \
> +               -I$(objtree)/include/generated/uapi \
> +                -include $(srctree)/include/linux/kconfig.h
>
> -KBUILD_CPPFLAGS :=3D -D__KERNEL__ -D__UBOOT__
> -
> -KBUILD_CFLAGS   :=3D -Wall -Werror=3Dstrict-prototypes -Wno-trigraphs \
> -                  -Wno-format-security \
> -                  -fno-builtin -ffreestanding $(CSTD_FLAG) \
> -                  -fno-PIE \
> -                  -Werror=3Dimplicit-function-declaration -Werror=3Dimpl=
icit-int
> -KBUILD_CFLAGS  +=3D -fshort-wchar -fno-strict-aliasing
> -KBUILD_AFLAGS   :=3D -D__ASSEMBLY__ -fno-PIE
> -KBUILD_LDFLAGS  :=3D
> -
> -ifeq ($(cc-name),clang)
> -ifneq ($(CROSS_COMPILE),)
> -CLANG_TARGET   :=3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> -LDPPFLAGS      +=3D $(CLANG_TARGET)
> -GCC_TOOLCHAIN_DIR :=3D $(dir $(shell which $(CROSS_COMPILE)elfedit))
> -CLANG_PREFIX   :=3D --prefix=3D$(GCC_TOOLCHAIN_DIR)
> -GCC_TOOLCHAIN  :=3D $(realpath $(GCC_TOOLCHAIN_DIR)/..)
> -endif
> -ifneq ($(GCC_TOOLCHAIN),)
> -CLANG_GCC_TC   :=3D --gcc-toolchain=3D$(GCC_TOOLCHAIN)
> -endif
> -KBUILD_CFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_AFLAGS +=3D $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_CFLAGS +=3D $(call cc-option, -no-integrated-as)
> -KBUILD_AFLAGS +=3D $(call cc-option, -no-integrated-as)
> -endif
> -
> -# Read UBOOTRELEASE from include/config/uboot.release (if it exists)
> -UBOOTRELEASE =3D $(shell cat include/config/uboot.release 2> /dev/null)
> -UBOOTVERSION =3D $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLE=
VEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> +# Use UBOOTINCLUDE when you must reference the include/ directory.
> +# Needed to be compatible with the O=3D option
> +UBOOTINCLUDE    :=3D \
> +       -Iinclude \
> +       $(if $(KBUILD_SRC), -I$(srctree)/include) \
> +       $(if $(CONFIG_$(XPL_)MBEDTLS_LIB), \
> +               "-DMBEDTLS_CONFIG_FILE=3D\"mbedtls_def_config.h\"" \
> +               -I$(srctree)/lib/mbedtls \
> +               -I$(srctree)/lib/mbedtls/port \
> +               -I$(srctree)/lib/mbedtls/external/mbedtls \
> +               -I$(srctree)/lib/mbedtls/external/mbedtls/include) \
> +       $(if $(CONFIG_$(PHASE_)SYS_THUMB_BUILD), \
> +               $(if $(CONFIG_HAS_THUMB2), \
> +                       $(if $(CONFIG_CPU_V7M), \
> +                               -I$(srctree)/arch/arm/thumb1/include), \
> +                       -I$(srctree)/arch/arm/thumb1/include)) \
> +       -I$(srctree)/arch/$(ARCH)/include \
> +       -include $(srctree)/include/linux/kconfig.h \
> +       -I$(srctree)/dts/upstream/include \
> +       $(if $(CONFIG_NET_LWIP), -I$(srctree)/lib/lwip/lwip/src/include \
> +               -I$(srctree)/lib/lwip/u-boot)
>
> -export VERSION PATCHLEVEL SUBLEVEL UBOOTRELEASE UBOOTVERSION
> -export ARCH CPU BOARD VENDOR SOC CPUDIR BOARDDIR
> -export CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
> -export CPP AR NM LDR STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOS=
TLDLIBS
> -export MAKE LEX YACC AWK PERL PYTHON PYTHON2 PYTHON3
> -export HOSTCXX KBUILD_HOSTCXXFLAGS CHECK CHECKFLAGS DTC DTC_FLAGS
>
> -export KBUILD_CPPFLAGS NOSTDINC_FLAGS UBOOTINCLUDE OBJCOPYFLAGS KBUILD_L=
DFLAGS
> -export KBUILD_CFLAGS KBUILD_AFLAGS
> +KBUILD_AFLAGS   :=3D -D__ASSEMBLY__ -fno-PIE
> +KBUILD_CFLAGS   :=3D -Wall -Werror=3Dstrict-prototypes -Wno-trigraphs \
> +                  -fno-strict-aliasing -fno-common -fshort-wchar -fno-PI=
E \
> +                  -Werror=3Dimplicit-function-declaration -Werror=3Dimpl=
icit-int \
> +                  -Wno-format-security -std=3Dgnu11 #-Wundef Enable it a=
nd fix warnings
> +UBOOT_CFLAGS   :=3D -ffreestanding -fno-builtin
> +KBUILD_CFLAGS  +=3D $(UBOOT_CFLAGS)
>
> +KBUILD_CPPFLAGS :=3D -D__KERNEL__ -D__UBOOT__
> +KBUILD_AFLAGS_KERNEL :=3D
> +KBUILD_CFLAGS_KERNEL :=3D
> +KBUILD_AFLAGS_MODULE  :=3D -DMODULE
> +KBUILD_CFLAGS_MODULE  :=3D -DMODULE
> +KBUILD_LDFLAGS_MODULE :=3D -T $(srctree)/scripts/module-common.lds
> +KBUILD_LDFLAGS :=3D
> +GCC_PLUGINS_CFLAGS :=3D
> +
> +export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE =
AS LD CC
> +export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDL=
IBS
> +export MAKE LEX YACC AWK INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_M=
ACHINE
> +export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
> +
> +export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_L=
DFLAGS
> +export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> +export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
> +export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
> +export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
> +export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
> +export KBUILD_ARFLAGS
> +
> +export LDR
> +export CPU BOARD VENDOR SOC CPUDIR BOARDDIR
> +export UBOOTINCLUDE
>  export CC_VERSION_TEXT :=3D $(shell $(CC) --version | head -n 1)
>
>  # When compiling out-of-tree modules, put MODVERDIR in the module
> @@ -504,15 +576,12 @@ endif
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  # Rules shared between *config targets and build targets
>
> -# Basic helpers built in scripts/
> +# Basic helpers built in scripts/basic/
>  PHONY +=3D scripts_basic
>  scripts_basic:
>         $(Q)$(MAKE) $(build)=3Dscripts/basic
>         $(Q)rm -f .tmp_quiet_recordmcount
>
> -# To avoid any implicit rule to kick in, define an empty command.
> -scripts/basic/%: scripts_basic ;
> -
>  PHONY +=3D outputmakefile
>  # outputmakefile generates a Makefile in the output directory, if using =
a
>  # separate output directory. This allows convenient use of make in the
> @@ -524,71 +593,51 @@ ifneq ($(KBUILD_SRC),)
>         $(Q)ln -fsn $(srctree) source
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
>         $(Q)test -e .gitignore || \
> -               { echo "# this is build directory, ignore it"; echo "*"; =
} > .gitignore
> +       { echo "# this is build directory, ignore it"; echo "*"; } > .git=
ignore
>  endif
>
> -# To make sure we do not include .config for any of the *config targets
> -# catch them early, and hand them over to scripts/kconfig/Makefile
> -# It is allowed to specify more targets when calling make, including
> -# mixing *config targets and build targets.
> -# For example 'make oldconfig all'.
> -# Detect when mixed targets is specified, and make a second invocation
> -# of make so .config is not included in this case either (for *config).
> -
> -version_h :=3D include/generated/version_autogenerated.h
> -timestamp_h :=3D include/generated/timestamp_autogenerated.h
> -defaultenv_h :=3D include/generated/defaultenv_autogenerated.h
> -dt_h :=3D include/generated/dt.h
> -env_h :=3D include/generated/environment.h
> -
> -no-dot-config-targets :=3D clean clobber mrproper distclean \
> -                        help %docs check% coccicheck \
> -                        ubootversion backup tests check pcheck qcheck tc=
heck \
> -                        pylint pylint_err _pip pip pip_test pip_release
> -
> -config-targets :=3D 0
> -mixed-targets  :=3D 0
> -dot-config     :=3D 1
> -
> -ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
> -       ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
> -               dot-config :=3D 0
> -       endif
> +ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> +ifneq ($(CROSS_COMPILE),)
> +CLANG_FLAGS    :=3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> +GCC_TOOLCHAIN_DIR :=3D $(dir $(shell which $(CROSS_COMPILE)elfedit))
> +CLANG_FLAGS    +=3D --prefix=3D$(GCC_TOOLCHAIN_DIR)
> +GCC_TOOLCHAIN  :=3D $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>  endif
> -
> -ifeq ($(KBUILD_EXTMOD),)
> -        ifneq ($(filter config %config,$(MAKECMDGOALS)),)
> -                config-targets :=3D 1
> -                ifneq ($(words $(MAKECMDGOALS)),1)
> -                        mixed-targets :=3D 1
> -                endif
> -        endif
> +ifneq ($(GCC_TOOLCHAIN),)
> +CLANG_FLAGS    +=3D --gcc-toolchain=3D$(GCC_TOOLCHAIN)
> +endif
> +CLANG_FLAGS    +=3D -no-integrated-as
> +KBUILD_CFLAGS  +=3D $(CLANG_FLAGS)
> +KBUILD_AFLAGS  +=3D $(CLANG_FLAGS)
> +export CLANG_FLAGS
>  endif
>
> -ifeq ($(mixed-targets),1)
> -# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> -# We're called with mixed targets (*config and build targets).
> -# Handle them one by one.
> -
> -PHONY +=3D $(MAKECMDGOALS) __build_one_by_one
> -
> -$(filter-out __build_one_by_one, $(MAKECMDGOALS)): __build_one_by_one
> -       @:
> +RETPOLINE_CFLAGS_GCC :=3D -mindirect-branch=3Dthunk-extern -mindirect-br=
anch-register
> +RETPOLINE_VDSO_CFLAGS_GCC :=3D -mindirect-branch=3Dthunk-inline -mindire=
ct-branch-register
> +RETPOLINE_CFLAGS_CLANG :=3D -mretpoline-external-thunk
> +RETPOLINE_VDSO_CFLAGS_CLANG :=3D -mretpoline
> +RETPOLINE_CFLAGS :=3D $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc=
-option,$(RETPOLINE_CFLAGS_CLANG)))
> +RETPOLINE_VDSO_CFLAGS :=3D $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC)=
,$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
> +export RETPOLINE_CFLAGS
> +export RETPOLINE_VDSO_CFLAGS
>
> -__build_one_by_one:
> -       $(Q)set -e; \
> -       for i in $(MAKECMDGOALS); do \
> -               $(MAKE) -f $(srctree)/Makefile $$i; \
> -       done
> +# The expansion should be delayed until arch/$(SRCARCH)/Makefile is incl=
uded.
> +# Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
> +# CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
> +# and from include/config/auto.conf.cmd to detect the compiler upgrade.
> +CC_VERSION_TEXT =3D $(shell $(CC) --version | head -n 1)
>
> -else
>  ifeq ($(config-targets),1)
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  # *config targets only - make sure prerequisites are updated, and descen=
d
>  # in scripts/kconfig to make the *config target
>
> -KBUILD_DEFCONFIG :=3D sandbox_defconfig
> -export KBUILD_DEFCONFIG KBUILD_KCONFIG
> +# Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
> +# KBUILD_DEFCONFIG may point out an alternative default configuration
> +# used for 'make defconfig'
> +# Modified for U-Boot
> +-include arch/$(SRCARCH)/Makefile
> +export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT
>
>  config: scripts_basic outputmakefile FORCE
>         $(Q)$(MAKE) $(build)=3Dscripts/kconfig $@
> @@ -601,29 +650,104 @@ else
>  # Build targets only - this includes vmlinux, arch specific targets, cle=
an
>  # targets and others. In general all targets except *config targets.
>
> -# Additional helpers built in scripts/
> -# Carefully list dependencies so we do not try to build scripts twice
> -# in parallel
> -PHONY +=3D scripts
> -scripts: scripts_basic scripts_dtc include/config/auto.conf
> -       $(Q)$(MAKE) $(build)=3D$(@)
> +# If building an external module we do not care about the all: rule
> +# but instead _all depend on modules
> +PHONY +=3D all
> +ifeq ($(KBUILD_EXTMOD),)
> +_all: all
> +else
> +_all: modules
> +endif
> +
> +# Decide whether to build built-in, modular, or both.
> +# Normally, just do built-in.
> +
> +KBUILD_MODULES :=3D
> +KBUILD_BUILTIN :=3D 1
> +
> +# If we have only "make modules", don't compile built-in objects.
> +# When we're building modules with modversions, we need to consider
> +# the built-in objects during the descend as well, in order to
> +# make sure the checksums are up to date before we record them.
> +
> +ifeq ($(MAKECMDGOALS),modules)
> +  KBUILD_BUILTIN :=3D $(if $(CONFIG_MODVERSIONS),1)
> +endif
> +
> +# If we have "make <whatever> modules", compile modules
> +# in addition to whatever we do anyway.
> +# Just "make" or "make all" shall build modules as well
> +
> +ifneq ($(filter all _all modules,$(MAKECMDGOALS)),)
> +  KBUILD_MODULES :=3D 1
> +endif
> +
> +ifeq ($(MAKECMDGOALS),)
> +  KBUILD_MODULES :=3D 1
> +endif
> +
> +export KBUILD_MODULES KBUILD_BUILTIN
> +
> +ifeq ($(KBUILD_EXTMOD),)
> +# Objects we will link into vmlinux / subdirs we need to visit
> +init-y         :=3D init/
> +drivers-y      :=3D drivers/ sound/
> +net-y          :=3D net/
> +libs-y         :=3D lib/
> +core-y         :=3D usr/
> +virt-y         :=3D virt/
> +endif # KBUILD_EXTMOD
>
>  ifeq ($(dot-config),1)
> -# Read in config
> +# Modified for U-Boot
>  -include include/config/auto.conf
> +endif
> +
> +# The all: target is the default when no target is given on the
> +# command line.
> +# This allow a user to issue only 'make' to build a kernel including mod=
ules
> +# Defaults to vmlinux, but the arch makefile usually adds further target=
s
> +all: u-boot
>
> -# Read in dependencies to all Kconfig* files, make sure to run
> -# oldconfig if changes are detected.
> +CFLAGS_GCOV    :=3D -fprofile-arcs -ftest-coverage \
> +       $(call cc-option,-fno-tree-loop-im) \
> +       $(call cc-disable-warning,maybe-uninitialized,)
> +export CFLAGS_GCOV
> +
> +# The arch Makefiles can override CC_FLAGS_FTRACE. We may also append it=
 later.
> +ifdef CONFIG_FUNCTION_TRACER
> +  CC_FLAGS_FTRACE :=3D -pg
> +endif
> +
> +# The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
> +# values of the respective KBUILD_* variables
> +ARCH_CPPFLAGS :=3D
> +ARCH_AFLAGS :=3D
> +ARCH_CFLAGS :=3D
> +# Modified for U-Boot
> +-include arch/$(SRCARCH)/Makefile
> +
> +ifeq ($(dot-config),1)
> +ifeq ($(may-sync-config),1)
> +# Read in dependencies to all Kconfig* files, make sure to run syncconfi=
g if
> +# changes are detected. This should be included after arch/$(SRCARCH)/Ma=
kefile
> +# because some architectures define CROSS_COMPILE there.
>  -include include/config/auto.conf.cmd
>
> -# To avoid any implicit rule to kick in, define an empty command
> -$(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
> +$(KCONFIG_CONFIG):
> +       @echo >&2 '***'
> +       @echo >&2 '*** Configuration file "$@" not found!'
> +       @echo >&2 '***'
> +       @echo >&2 '*** Please run some configurator (e.g. "make oldconfig=
" or'
> +       @echo >&2 '*** "make menuconfig" or "make xconfig").'
> +       @echo >&2 '***'
> +       @/bin/false
>
>  # If .config is newer than include/config/auto.conf, someone tinkered
>  # with it and forgot to run make oldconfig.
>  # if auto.conf.cmd is missing then we are probably in a cleaned tree so
>  # we execute the config step to be sure to catch updated Kconfig files
> -include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
> +include/config/%.conf: $(KCONFIG_CONFIG) #include/config/auto.conf.cmd
>         $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
>         @# If the following part fails, include/config/auto.conf should b=
e
>         @# deleted so "make silentoldconfig" will be re-run on the next b=
uild.
> @@ -698,10 +822,30 @@ ifndef LDSCRIPT
>  endif
>
>  else
> -# Dummy target needed, because used as prerequisite
> -include/config/auto.conf: ;
> +# External modules and some install targets need include/generated/autoc=
onf.h
> +# and include/config/auto.conf but do not care if they are up-to-date.
> +# Use auto.conf to trigger the test
> +PHONY +=3D include/config/auto.conf
> +
> +include/config/auto.conf:
> +       $(Q)test -e include/generated/autoconf.h -a -e $@ || (          \
> +       echo >&2;                                                       \
> +       echo >&2 "  ERROR: Kernel configuration is invalid.";           \
> +       echo >&2 "         include/generated/autoconf.h or $@ are missing=
.";\
> +       echo >&2 "         Run 'make oldconfig && make prepare' on kernel=
 src to fix it.";      \
> +       echo >&2 ;                                                      \
> +       /bin/false)
> +
> +endif # may-sync-config
>  endif # $(dot-config)
>
> +KBUILD_CFLAGS  +=3D $(call cc-option,-fno-delete-null-pointer-checks,)
> +KBUILD_CFLAGS  +=3D $(call cc-disable-warning,frame-address,)
> +KBUILD_CFLAGS  +=3D $(call cc-disable-warning, format-truncation)
> +KBUILD_CFLAGS  +=3D $(call cc-disable-warning, format-overflow)
> +KBUILD_CFLAGS  +=3D $(call cc-disable-warning, int-in-bool-context)
> +KBUILD_CFLAGS  +=3D $(call cc-disable-warning, address-of-packed-member)
> +
>  ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
>  KBUILD_HOSTCFLAGS   :=3D -Wall -Wstrict-prototypes -Og -g -fomit-frame-p=
ointer \
>                 $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
> @@ -721,19 +865,19 @@ endif
>
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS  +=3D -Os
> +else
> +KBUILD_CFLAGS   +=3D -O2
>  endif
>
> -ifdef CONFIG_CC_OPTIMIZE_FOR_SPEED
> -KBUILD_CFLAGS  +=3D -O2
> +ifdef CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED
> +KBUILD_CFLAGS   +=3D -Wno-maybe-uninitialized
>  endif
>
> -ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
> -KBUILD_CFLAGS  +=3D -Og
> -# Avoid false positives -Wmaybe-uninitialized
> -# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D78394
> -KBUILD_CFLAGS  +=3D -Wno-maybe-uninitialized
> -endif
> +# Tell gcc to never replace conditional load with a non-conditional one
> +KBUILD_CFLAGS  +=3D $(call cc-option,--param=3Dallow-store-data-races=3D=
0)
>
> +include scripts/Makefile.kcov
> +include scripts/Makefile.gcc-plugins
>  LTO_CFLAGS :=3D
>  LTO_FINAL_LDFLAGS :=3D
>  export LTO_CFLAGS LTO_FINAL_LDFLAGS
> @@ -768,12 +912,6 @@ KBUILD_CFLAGS +=3D $(call cc-option,-fno-stack-prote=
ctor)
>  endif
>  KBUILD_CFLAGS +=3D $(call cc-option,-fno-delete-null-pointer-checks)
>
> -# disable pointer signed / unsigned warnings in gcc 4.0
> -KBUILD_CFLAGS +=3D -Wno-pointer-sign
> -
> -# disable stringop warnings in gcc 8+
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-truncation)
> -
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, zero-length-bounds)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, array-bounds)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-overflow)
> @@ -813,6 +951,11 @@ KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautol=
ogical-compare)
>  KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)
>  KBUILD_CFLAGS +=3D $(call cc-option, -fcatch-undefined-behavior)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, deprecated-non-prototype)
> +else
> +
> +# These warnings generated too much noise in a regular build.
> +# Use make W=3D1 to enable them (see scripts/Makefile.extrawarn)
> +KBUILD_CFLAGS +=3D -Wno-unused-but-set-variable
>  endif
>
>  # These warnings generated too much noise in a regular build.
> @@ -864,6 +1007,7 @@ cpp_flags :=3D $(KBUILD_CPPFLAGS) $(PLATFORM_CPPFLAG=
S) $(UBOOTINCLUDE) \
>                                                         $(NOSTDINC_FLAGS)
>  c_flags :=3D $(KBUILD_CFLAGS) $(cpp_flags)
>
> +
>  ########################################################################=
#
>  # U-Boot objects....order is important (i.e. start must be first)
>
> @@ -912,7 +1056,15 @@ u-boot-dirs       :=3D $(patsubst %/,%,$(filter %/,=
 $(libs-y))) tools examples
>
>  u-boot-alldirs :=3D $(sort $(u-boot-dirs) $(patsubst %/,%,$(filter %/, $=
(libs-))))
>
> -libs-y         :=3D $(patsubst %/, %/built-in.o, $(libs-y))
> +libs-y         :=3D $(patsubst %/, %/built-in.a, $(libs-y))
> +# Not needed in U-Boot
> +#init-y                :=3D $(patsubst %/, %/built-in.a, $(init-y))
> +#core-y                :=3D $(patsubst %/, %/built-in.a, $(core-y))
> +drivers-y      :=3D $(patsubst %/, %/built-in.a, $(drivers-y))
> +#net-y         :=3D $(patsubst %/, %/built-in.a, $(net-y))
> +libs-y1        :=3D $(patsubst %/, %/lib.a, $(libs-y))
> +libs-y2        :=3D $(patsubst %/, %/built-in.a, $(filter-out %.a, $(lib=
s-y)))
> +#virt-y                :=3D $(patsubst %/, %/built-in.a, $(virt-y))
>
>  u-boot-init :=3D $(head-y)
>  u-boot-main :=3D $(libs-y)
> @@ -1031,6 +1183,37 @@ INPUTS-$(CONFIG_ARCH_MEDIATEK) +=3D u-boot-mtk.bin
>  endif
>  endif
>
> +ifdef CONFIG_FUNCTION_TRACER
> +ifdef CONFIG_FTRACE_MCOUNT_RECORD
> +  # gcc 5 supports generating the mcount tables directly
> +  ifeq ($(call cc-option-yn,-mrecord-mcount),y)
> +    CC_FLAGS_FTRACE    +=3D -mrecord-mcount
> +    export CC_USING_RECORD_MCOUNT :=3D 1
> +  endif
> +  ifdef CONFIG_HAVE_NOP_MCOUNT
> +    ifeq ($(call cc-option-yn, -mnop-mcount),y)
> +      CC_FLAGS_FTRACE  +=3D -mnop-mcount
> +      CC_FLAGS_USING   +=3D -DCC_USING_NOP_MCOUNT
> +    endif
> +  endif
> +endif
> +ifdef CONFIG_HAVE_FENTRY
> +  ifeq ($(call cc-option-yn, -mfentry),y)
> +    CC_FLAGS_FTRACE    +=3D -mfentry
> +    CC_FLAGS_USING     +=3D -DCC_USING_FENTRY
> +  endif
> +endif
> +export CC_FLAGS_FTRACE
> +KBUILD_CFLAGS  +=3D $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
> +KBUILD_AFLAGS  +=3D $(CC_FLAGS_USING)
> +ifdef CONFIG_DYNAMIC_FTRACE
> +       ifdef CONFIG_HAVE_C_RECORDMCOUNT
> +               BUILD_C_RECORDMCOUNT :=3D y
> +               export BUILD_C_RECORDMCOUNT
> +       endif
> +endif
> +endif
> +
>  # Add optional build target if defined in board/cpu/soc headers
>  ifneq ($(CONFIG_BUILD_TARGET),)
>  INPUTS-y +=3D $(CONFIG_BUILD_TARGET:"%"=3D%)
> @@ -1076,6 +1259,15 @@ quiet_cmd_objcopy =3D OBJCOPY $@
>  cmd_objcopy =3D $(OBJCOPY) --gap-fill=3D0xff $(OBJCOPYFLAGS) \
>         $(OBJCOPYFLAGS_$(@F)) $< $@
>
> +# disable pointer signed / unsigned warnings in gcc 4.0
> +KBUILD_CFLAGS +=3D -Wno-pointer-sign
> +
> +# disable stringop warnings in gcc 8+
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-truncation)
> +
> +# disable invalid "can't wrap" optimizations for signed / pointers
> +KBUILD_CFLAGS  +=3D $(call cc-option,-fno-strict-overflow)
> +
>  # Provide a version which does not do this, for use by EFI and hex/srec
>  quiet_cmd_zobjcopy =3D OBJCOPY $@
>  cmd_zobjcopy =3D $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
> @@ -1927,7 +2119,7 @@ $(sort $(u-boot-init) $(u-boot-main)): $(u-boot-dir=
s) ;
>
>  PHONY +=3D $(u-boot-dirs)
>  $(u-boot-dirs): prepare
> -       $(Q)$(MAKE) $(build)=3D$@
> +       $(Q)$(MAKE) $(build)=3D$@ need-builtin=3D1
>
>  tools: prepare
>  # The "tools" are needed early
> @@ -1946,7 +2138,12 @@ endef
>  # Store (new) UBOOTRELEASE string in include/config/uboot.release
>  include/config/uboot.release: include/config/auto.conf FORCE
>         $(call filechk,uboot.release)
> -
> +# Additional helpers built in scripts/
> +# Carefully list dependencies so we do not try to build scripts twice
> +# in parallel
> +PHONY +=3D scripts
> +scripts: scripts_basic scripts_dtc
> +       $(Q)$(MAKE) $(build)=3D$(@)
>
>  # Things we need to do before we recursively start building the kernel
>  # or the modules are listed in "prepare".
> @@ -1954,7 +2151,6 @@ include/config/uboot.release: include/config/auto.c=
onf FORCE
>  # archprepare is used in arch Makefiles and when processed asm symlink,
>  # version.h and scripts_basic is processed / created.
>
> -# Listed in dependency order
>  PHONY +=3D prepare archprepare prepare1 prepare3
>
>  # prepare3 is used to check if we are building in a separate output dire=
ctory,
> @@ -1982,14 +2178,35 @@ prepare1: $(defaultenv_h)
>
>  envtools: $(defaultenv_h)
>  endif
> -
>  archprepare: prepare1 scripts
>
> -prepare0: archprepare FORCE
> +prepare0: archprepare
>         $(Q)$(MAKE) $(build)=3D.
>
>  # All the preparing..
> -prepare: prepare0
> +prepare: prepare0 prepare-objtool
> +
> +# Support for using generic headers in asm-generic
> +asm-generic :=3D -f $(srctree)/scripts/Makefile.asm-generic obj
> +
> +PHONY +=3D asm-generic uapi-asm-generic
> +asm-generic: uapi-asm-generic
> +       $(Q)$(MAKE) $(asm-generic)=3Darch/$(SRCARCH)/include/generated/as=
m \
> +       generic=3Dinclude/asm-generic
> +uapi-asm-generic:
> +       $(Q)$(MAKE) $(asm-generic)=3Darch/$(SRCARCH)/include/generated/ua=
pi/asm \
> +       generic=3Dinclude/uapi/asm-generic
> +
> +PHONY +=3D prepare-objtool
> +prepare-objtool: $(objtool_target)
> +ifeq ($(SKIP_STACK_VALIDATION),1)
> +ifdef CONFIG_UNWINDER_ORC
> +       @echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_OR=
C=3Dy, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&=
2
> +       @false
> +else
> +       @echo "warning: Cannot use CONFIG_STACK_VALIDATION=3Dy, please in=
stall libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
> +endif
> +endif
>
>  # Generate some files
>  # ----------------------------------------------------------------------=
-----
> @@ -2072,13 +2289,20 @@ ifneq ($(dtstree),)
>  %.dtb: prepare3 scripts_dtc
>         $(Q)$(MAKE) $(build)=3D$(dtstree) $(dtstree)/$@
>
> -PHONY +=3D dtbs dtbs_install
> -dtbs: prepare3 scripts_dtc
> +PHONY +=3D dtbs dtbs_install dt_binding_check
> +dtbs dtbs_check: prepare3 scripts_dtc
>         $(Q)$(MAKE) $(build)=3D$(dtstree)
>
> +dtbs_check: export CHECK_DTBS=3D1
> +dtbs_check: dt_binding_check
> +
>  dtbs_install:
>         $(Q)$(MAKE) $(dtbinst)=3D$(dtstree)
>
> +ifdef CONFIG_OF_EARLY_FLATTREE
> +all: dtbs
> +endif
> +
>  endif
>
>  # Check dtc and pylibfdt, if DTC is provided, else build them
> @@ -2180,8 +2404,6 @@ SYSTEM_MAP =3D \
>  System.map:    u-boot
>                 @$(call SYSTEM_MAP,$<) > $@
>
> -########################################################################=
#
> -
>  # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
>  # R_AARCH64_RELATIVE (64-bit).
>  checkarmreloc: u-boot
> @@ -2255,9 +2477,7 @@ MRPROPER_FILES +=3D .config .config.old include/aut=
oconf.mk* include/config.h \
>  #
>  clean: rm-dirs  :=3D $(CLEAN_DIRS)
>  clean: rm-files :=3D $(CLEAN_FILES)
> -
>  clean-dirs     :=3D $(foreach f,$(u-boot-alldirs),$(if $(wildcard $(srct=
ree)/$f/Makefile),$f))
> -
>  clean-dirs      :=3D $(addprefix _clean_, $(clean-dirs))
>
>  PHONY +=3D $(clean-dirs) clean archclean
> @@ -2465,11 +2685,25 @@ checkstack:
>         $(OBJDUMP) -d u-boot $$(find . -name u-boot-spl) | \
>         $(PERL) $(src)/scripts/checkstack.pl $(ARCH)
>
> +ubootversion:
> +       @echo $(UBOOTVERSION)
> +
>  ubootrelease:
>         @$(filechk_uboot.release)
>
> -ubootversion:
> -       @echo $(UBOOTVERSION)
> +# Clear a bunch of variables before executing the submake
> +
> +ifeq ($(quiet),silent_)
> +tools_silent=3Ds
> +endif
> +
> +tools/: FORCE
> +       $(Q)mkdir -p $(objtree)/tools
> +       $(Q)$(MAKE) LDFLAGS=3D MAKEFLAGS=3D"$(tools_silent) $(filter --j%=
 -j,$(MAKEFLAGS))" O=3D$(abspath $(objtree)) subdir=3Dtools -C $(src)/tools=
/
> +
> +tools/%: FORCE
> +       $(Q)mkdir -p $(objtree)/tools
> +       $(Q)$(MAKE) LDFLAGS=3D MAKEFLAGS=3D"$(tools_silent) $(filter --j%=
 -j,$(MAKEFLAGS))" O=3D$(abspath $(objtree)) subdir=3Dtools -C $(src)/tools=
/ $*
>
>  # Single targets
>  # ----------------------------------------------------------------------=
-----
> @@ -2481,41 +2715,32 @@ ubootversion:
>  #  target-dir =3D> where to store outputfile
>  #  build-dir  =3D> directory in kernel source tree to use
>
> -ifeq ($(KBUILD_EXTMOD),)
> -        build-dir  =3D $(patsubst %/,%,$(dir $@))
> -        target-dir =3D $(dir $@)
> -else
> -        zap-slash=3D$(filter-out .,$(patsubst %/,%,$(dir $@)))
> -        build-dir  =3D $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
> -        target-dir =3D $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
> -endif
> -
> -%.s: %.c prepare FORCE
> -       $(Q)$(MAKE) $(build)=3D$(build-dir) $(target-dir)$(notdir $@)
> -%.i: %.c prepare FORCE
> -       $(Q)$(MAKE) $(build)=3D$(build-dir) $(target-dir)$(notdir $@)
> -%.o: %.c prepare FORCE
> -       $(Q)$(MAKE) $(build)=3D$(build-dir) $(target-dir)$(notdir $@)
> -%.lst: %.c prepare FORCE
> -       $(Q)$(MAKE) $(build)=3D$(build-dir) $(target-dir)$(notdir $@)
> -%.s: %.S prepare FORCE
> -       $(Q)$(MAKE) $(build)=3D$(build-dir) $(target-dir)$(notdir $@)
> -%.o: %.S prepare FORCE
> -       $(Q)$(MAKE) $(build)=3D$(build-dir) $(target-dir)$(notdir $@)
> -%.symtypes: %.c prepare FORCE
> -       $(Q)$(MAKE) $(build)=3D$(build-dir) $(target-dir)$(notdir $@)
> +build-target =3D $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD)/)$@
> +build-dir =3D $(patsubst %/,%,$(dir $(build-target)))
> +
> +%.i: prepare FORCE
> +       $(Q)$(MAKE) $(build)=3D$(build-dir) $(build-target)
> +%.ll: prepare FORCE
> +       $(Q)$(MAKE) $(build)=3D$(build-dir) $(build-target)
> +%.lst: prepare FORCE
> +       $(Q)$(MAKE) $(build)=3D$(build-dir) $(build-target)
> +%.o: prepare FORCE
> +       $(Q)$(MAKE) $(build)=3D$(build-dir) $(build-target)
> +%.s: prepare FORCE
> +       $(Q)$(MAKE) $(build)=3D$(build-dir) $(build-target)
> +%.symtypes: prepare FORCE
> +       $(Q)$(MAKE) $(build)=3D$(build-dir) $(build-target)
> +%.ko: %.o
> +       $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
>
>  # Modules
> -/: prepare FORCE
> -       $(Q)$(MAKE) KBUILD_MODULES=3D$(if $(CONFIG_MODULES),1) \
> -       $(build)=3D$(build-dir)
> +PHONY +=3D /
> +/: ./
> +
> +# Make sure the latest headers are built for Documentation
> +Documentation/ samples/: headers_install
>  %/: prepare FORCE
> -       $(Q)$(MAKE) KBUILD_MODULES=3D$(if $(CONFIG_MODULES),1) \
> -       $(build)=3D$(build-dir)
> -%.ko: prepare FORCE
> -       $(Q)$(MAKE) KBUILD_MODULES=3D$(if $(CONFIG_MODULES),1)   \
> -       $(build)=3D$(build-dir) $(@:.ko=3D.o)
> -       $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> +       $(Q)$(MAKE) KBUILD_MODULES=3D1 $(build)=3D$(build-dir)
>
>  quiet_cmd_genenv =3D GENENV  $@
>  cmd_genenv =3D \
> @@ -2544,15 +2769,24 @@ quiet_cmd_rmdirs =3D $(if $(wildcard $(rm-dirs)),=
CLEAN   $(wildcard $(rm-dirs)))
>  quiet_cmd_rmfiles =3D $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(=
rm-files)))
>        cmd_rmfiles =3D rm -f $(rm-files)
>
> +# Run depmod only if we have System.map and depmod is executable
> +quiet_cmd_depmod =3D DEPMOD  $(KERNELRELEASE)
> +      cmd_depmod =3D $(CONFIG_SHELL) $(srctree)/scripts/depmod.sh $(DEPM=
OD) \
> +                   $(KERNELRELEASE)
> +
> +# Create temporary dir for module support files
> +# clean it up only when building all modules
> +cmd_crmodverdir =3D $(Q)mkdir -p $(MODVERDIR) \
> +                  $(if $(KBUILD_MODULES),; rm -f $(MODVERDIR)/*)
> +
>  # read saved command lines for existing targets
>  existing-targets :=3D $(wildcard $(sort $(targets)))
> -cmd_files :=3D $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)=
).cmd)
> -$(cmd_files): ;        # Do not try to update included dependency files
> --include $(cmd_files)
>
> -endif    #ifeq ($(config-targets),1)
> -endif    #ifeq ($(mixed-targets),1)
> -endif   # sub_make_done
> +-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
> +
> +endif   # ifeq ($(config-targets),1)
> +endif   # ifeq ($(mixed-targets),1)
> +endif   # need-sub-make
>
>  PHONY +=3D FORCE
>  FORCE:
> diff --git a/board/congatec/common/Makefile b/board/congatec/common/Makef=
ile
> index f8170d9c6535..7f1c8994d278 100644
> --- a/board/congatec/common/Makefile
> +++ b/board/congatec/common/Makefile
> @@ -16,8 +16,8 @@ endif
>  endif
>
>  ifdef MINIMAL
> -# necessary to create built-in.o
> -obj- :=3D __dummy__.o
> +# necessary to create built-in.a
> +obj- :=3D __dummy__.a
>  else
>
>  obj-y                          +=3D mmc.o
> diff --git a/board/cssi/cmpc885/u-boot.lds b/board/cssi/cmpc885/u-boot.ld=
s
> index 53f616fcfe12..167606357e00 100644
> --- a/board/cssi/cmpc885/u-boot.lds
> +++ b/board/cssi/cmpc885/u-boot.lds
> @@ -18,8 +18,8 @@ SECTIONS
>         {
>                 arch/powerpc/cpu/mpc8xx/start.o (.text)
>                 arch/powerpc/cpu/mpc8xx/traps.o (.text*)
> -               arch/powerpc/lib/built-in.o             (.text*)
> -               drivers/net/built-in.o          (.text*)
> +               arch/powerpc/lib/built-in.a             (.text*)
> +               drivers/net/built-in.a          (.text*)
>
>                 . =3D DEFINED(env_offset) ? env_offset : .;
>                 env/embedded.o                  (.text.environment)
> diff --git a/board/cssi/mcr3000/u-boot.lds b/board/cssi/mcr3000/u-boot.ld=
s
> index 24b535e724aa..66afdebc0f77 100644
> --- a/board/cssi/mcr3000/u-boot.lds
> +++ b/board/cssi/mcr3000/u-boot.lds
> @@ -18,8 +18,8 @@ SECTIONS
>         {
>                 arch/powerpc/cpu/mpc8xx/start.o (.text)
>                 arch/powerpc/cpu/mpc8xx/traps.o (.text*)
> -               arch/powerpc/lib/built-in.o             (.text*)
> -               drivers/net/built-in.o          (.text*)
> +               arch/powerpc/lib/built-in.a             (.text*)
> +               drivers/net/built-in.a          (.text*)
>
>                 . =3D DEFINED(env_offset) ? env_offset : .;
>                 env/embedded.o                  (.text.environment)
> diff --git a/board/freescale/common/Makefile b/board/freescale/common/Mak=
efile
> index b04e19e94282..ed102ae7bf73 100644
> --- a/board/freescale/common/Makefile
> +++ b/board/freescale/common/Makefile
> @@ -14,8 +14,8 @@ endif
>  endif
>
>  ifdef MINIMAL
> -# necessary to create built-in.o
> -obj- :=3D __dummy__.o
> +# necessary to create built-in.a
> +obj- :=3D __dummy__.a
>  else
>  # include i2c_common.o once if either VID or FSL_USE_PCA9547_MUX
>  I2C_COMMON=3D
> diff --git a/board/menlo/mx8menlo/Makefile b/board/menlo/mx8menlo/Makefil=
e
> index 62939395ba12..c71fa9edfd96 100644
> --- a/board/menlo/mx8menlo/Makefile
> +++ b/board/menlo/mx8menlo/Makefile
> @@ -16,8 +16,8 @@ endif
>
>  # Common for all Toradex modules
>  ifeq ($(CONFIG_XPL_BUILD),y)
> -# Necessary to create built-in.o
> -obj- :=3D __dummy__.o
> +# Necessary to create built-in.a
> +obj- :=3D __dummy__.a
>  else
>  obj-$(CONFIG_TDX_CFG_BLOCK) +=3D ../../toradex/common/tdx-cfg-block.o
>  obj-y +=3D ../../toradex/common/tdx-common.o
> diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
> index 8126f7356e13..948f9dab626e 100644
> --- a/board/phytec/common/Makefile
> +++ b/board/phytec/common/Makefile
> @@ -3,8 +3,8 @@
>  # Author: Teresa Remmet <t.remmet@phytec.de>
>
>  ifdef CONFIG_XPL_BUILD
> -# necessary to create built-in.o
> -obj- :=3D __dummy__.o
> +# necessary to create built-in.a
> +obj- :=3D __dummy__.a
>  endif
>
>  obj-y +=3D phytec_som_detection.o phytec_som_detection_blocks.o
> diff --git a/board/samsung/origen/Makefile b/board/samsung/origen/Makefil=
e
> index 940f689a601a..30c637e322a3 100644
> --- a/board/samsung/origen/Makefile
> +++ b/board/samsung/origen/Makefile
> @@ -3,8 +3,8 @@
>  # Copyright (C) 2011 Samsung Electronics
>
>  ifdef CONFIG_XPL_BUILD
> -# necessary to create built-in.o
> -obj- :=3D __dummy__.o
> +# necessary to create built-in.a
> +obj- :=3D __dummy__.a
>
>  hostprogs-y :=3D tools/mkorigenspl
>  always :=3D $(hostprogs-y)
> diff --git a/board/samsung/smdkv310/Makefile b/board/samsung/smdkv310/Mak=
efile
> index b7f9d5a254c4..360300a78510 100644
> --- a/board/samsung/smdkv310/Makefile
> +++ b/board/samsung/smdkv310/Makefile
> @@ -3,8 +3,8 @@
>  # Copyright (C) 2011 Samsung Electronics
>
>  ifdef CONFIG_XPL_BUILD
> -# necessary to create built-in.o
> -obj- :=3D __dummy__.o
> +# necessary to create built-in.a
> +obj- :=3D __dummy__.a
>
>  hostprogs-y :=3D tools/mksmdkv310spl
>  always :=3D $(hostprogs-y)
> diff --git a/board/toradex/common/Makefile b/board/toradex/common/Makefil=
e
> index 7e3905445a5c..24496a7c9977 100644
> --- a/board/toradex/common/Makefile
> +++ b/board/toradex/common/Makefile
> @@ -3,8 +3,8 @@
>
>  # Common for all Toradex modules
>  ifeq ($(CONFIG_XPL_BUILD),y)
> -# Necessary to create built-in.o
> -obj- :=3D __dummy__.o
> +# Necessary to create built-in.a
> +obj- :=3D __dummy__.a
>  else
>  obj-$(CONFIG_TDX_CFG_BLOCK) +=3D tdx-cfg-block.o
>  obj-y +=3D tdx-common.o
> diff --git a/doc/api/linker_lists.rst b/doc/api/linker_lists.rst
> index 3cd447f187df..9e6849d5e750 100644
> --- a/doc/api/linker_lists.rst
> +++ b/doc/api/linker_lists.rst
> @@ -130,17 +130,17 @@ the compiler cannot update the alignment of the lin=
ker_list item.
>  In the first case, an 8-byte 'fill' region is added::
>
>     __u_boot_list_2_driver_2_testbus_drv
> -               0x0000000000270018       0x80 test/built-in.o
> +               0x0000000000270018       0x80 test/built-in.a
>                 0x0000000000270018                _u_boot_list_2_driver_2=
_testbus_drv
>     __u_boot_list_2_driver_2_testfdt1_drv
> -               0x0000000000270098       0x80 test/built-in.o
> +               0x0000000000270098       0x80 test/built-in.a
>                 0x0000000000270098                _u_boot_list_2_driver_2=
_testfdt1_drv
>     *fill*         0x0000000000270118        0x8
>     __u_boot_list_2_driver_2_testfdt_drv
> -               0x0000000000270120       0x80 test/built-in.o
> +               0x0000000000270120       0x80 test/built-in.a
>                 0x0000000000270120                _u_boot_list_2_driver_2=
_testfdt_drv
>     __u_boot_list_2_driver_2_testprobe_drv
> -               0x00000000002701a0       0x80 test/built-in.o
> +               0x00000000002701a0       0x80 test/built-in.a
>                 0x00000000002701a0                _u_boot_list_2_driver_2=
_testprobe_drv
>
>  With this, the linker_list no-longer works since items after testfdt1_dr=
v
> diff --git a/doc/develop/crash_dumps.rst b/doc/develop/crash_dumps.rst
> index 4237b073bc9a..c84b85b3364d 100644
> --- a/doc/develop/crash_dumps.rst
> +++ b/doc/develop/crash_dumps.rst
> @@ -89,15 +89,15 @@ File u-boot.map contains the memory layout of the U-B=
oot binary. Here we find
>  these lines::
>
>     .text.do_undefined
> -                  0x00000000000101fc        0xc cmd/built-in.o
> +                  0x00000000000101fc        0xc cmd/built-in.a
>     .text.exception_complete
> -                  0x0000000000010208       0x90 cmd/built-in.o
> +                  0x0000000000010208       0x90 cmd/built-in.a
>     ...
>     .text.cmd_process
> -                  0x00000000000213b8      0x164 common/built-in.o
> +                  0x00000000000213b8      0x164 common/built-in.a
>                    0x00000000000213b8                cmd_process
>     .text.cmd_process_error
> -                  0x000000000002151c       0x40 common/built-in.o
> +                  0x000000000002151c       0x40 common/built-in.a
>                    0x000000000002151c                cmd_process_error
>
>  So the error occurred at the start of function do\_undefined() and this
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index aa48d2494332..998679f00a0d 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -76,10 +76,12 @@ endif
>
>  ifneq ($(strip $(lib-y) $(lib-m) $(lib-)),)
>  lib-target :=3D $(obj)/lib.a
> +# Modified for U-Boot
> +# real-obj-y +=3D $(obj)/lib-ksyms.o
>  endif
>
> -ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
> -builtin-target :=3D $(obj)/built-in.o
> +ifneq ($(strip $(real-obj-y) $(need-builtin)),)
> +builtin-target :=3D $(obj)/built-in.a
>  endif
>
>  ifdef CONFIG_MODULES
> @@ -102,7 +104,11 @@ else ifeq ($(KBUILD_CHECKSRC),2)
>          cmd_force_checksrc =3D $(CHECK) $(CHECKFLAGS) $(c_flags) $<
>  endif
>
> -# Do section mismatch analysis for each module/built-in.o
> +ifneq ($(KBUILD_ENABLE_EXTRA_GCC_CHECKS),)
> +  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none $<
> +endif
> +
> +# Do section mismatch analysis for each module/built-in.a
>  ifdef CONFIG_DEBUG_SECTION_MISMATCH
>    cmd_secanalysis =3D ; scripts/mod/modpost $@
>  endif
> @@ -111,101 +117,94 @@ endif
>  # ----------------------------------------------------------------------=
-----
>
>  # Default is built-in, unless we know otherwise
> +$(foreach x, i ll lst o s symtypes, $(patsubst %.o,%.$(x),$(real-obj-m))=
): \
> +       part-of-module :=3D y
> +
>  modkern_cflags =3D                                          \
>         $(if $(part-of-module),                           \
>                 $(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE), \
>                 $(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
>  quiet_modtag =3D $(if $(part-of-module),[M],   )
>
> -$(real-objs-m)        : part-of-module :=3D y
> -$(real-objs-m:.o=3D.i)  : part-of-module :=3D y
> -$(real-objs-m:.o=3D.s)  : part-of-module :=3D y
> -$(real-objs-m:.o=3D.lst): part-of-module :=3D y
> -
> -# Default for not multi-part modules
> -modname =3D $(basetarget)
> -
> -$(multi-objs-m)         : modname =3D $(modname-multi)
> -$(multi-objs-m:.o=3D.i)   : modname =3D $(modname-multi)
> -$(multi-objs-m:.o=3D.s)   : modname =3D $(modname-multi)
> -$(multi-objs-m:.o=3D.lst) : modname =3D $(modname-multi)
> -$(multi-objs-y)         : modname =3D $(modname-multi)
> -$(multi-objs-y:.o=3D.i)   : modname =3D $(modname-multi)
> -$(multi-objs-y:.o=3D.s)   : modname =3D $(modname-multi)
> -$(multi-objs-y:.o=3D.lst) : modname =3D $(modname-multi)
> -
>  quiet_cmd_cc_s_c =3D CC $(quiet_modtag)  $@
> -cmd_cc_s_c       =3D $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o=
 $@ $<
> +      cmd_cc_s_c =3D $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) $(D=
ISABLE_LTO) -fverbose-asm -S -o $@ $<
>
>  $(obj)/%.s: $(src)/%.c FORCE
>         $(call if_changed_dep,cc_s_c)
>
> -quiet_cmd_cc_i_c =3D CPP $(quiet_modtag) $@
> -cmd_cc_i_c       =3D $(CPP) $(c_flags)   -o $@ $<
> +quiet_cmd_cpp_i_c =3D CPP $(quiet_modtag) $@
> +cmd_cpp_i_c       =3D $(CPP) $(c_flags) -o $@ $<
>
>  $(obj)/%.i: $(src)/%.c FORCE
> -       $(call if_changed_dep,cc_i_c)
> +       $(call if_changed_dep,cpp_i_c)
>
> -cmd_gensymtypes =3D                                                     =
      \
> +# These mirror gensymtypes_S and co below, keep them in synch.
> +cmd_gensymtypes_c =3D                                                   =
      \
>      $(CPP) -D__GENKSYMS__ $(c_flags) $< |                               =
    \
> -    scripts/genksyms/genksyms $(if $(1), -T $(2))                       =
   \
> +    scripts/genksyms/genksyms $(if $(1), -T $(2))                       =
    \
> +     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                         =
    \
>       $(if $(KBUILD_PRESERVE),-p)                                        =
    \
>       -r $(firstword $(wildcard $(2:.symtypes=3D.symref) /dev/null))
>
>  quiet_cmd_cc_symtypes_c =3D SYM $(quiet_modtag) $@
>  cmd_cc_symtypes_c =3D                                                   =
      \
> -    $(call cmd_gensymtypes,true,$@) >/dev/null;                         =
    \
> +    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                       =
    \
>      test -s $@ || rm -f $@
>
>  $(obj)/%.symtypes : $(src)/%.c FORCE
>         $(call cmd,cc_symtypes_c)
>
> +# LLVM assembly
> +# Generate .ll files from .c
> +quiet_cmd_cc_ll_c =3D CC $(quiet_modtag)  $@
> +      cmd_cc_ll_c =3D $(CC) $(c_flags) -emit-llvm -S -o $@ $<
> +
> +$(obj)/%.ll: $(src)/%.c FORCE
> +       $(call if_changed_dep,cc_ll_c)
> +
>  # C (.c) files
>  # The C file is compiled and updated dependency information is generated=
.
>  # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
>
>  quiet_cmd_cc_o_c =3D CC $(quiet_modtag)  $@
> -cmd_cc_o_c =3D $(CC) $(c_flags) -c -o $@ $<
> +      cmd_cc_o_c =3D $(CC) $(c_flags) -c -o $@ $<
>
>  ifdef CONFIG_MODVERSIONS
>  # When module versioning is enabled the following steps are executed:
>  # o compile a <file>.o from <file>.c
>  # o if <file>.o doesn't contain a __ksymtab version, i.e. does
> -#   not export symbols, it's done
> +#   not export symbols, it's done.
>  # o otherwise, we calculate symbol versions using the good old
>  #   genksyms on the preprocessed source and postprocess them in a way
>  #   that they are usable as a linker script
>  # o generate .tmp_<file>.o from <file>.o using the linker to
>  #   replace the unresolved symbols __crc_exported_symbol with
>  #   the actual value of the checksum generated by genksyms
> -
>  # o remove .tmp_<file>.o to <file>.o
> -cmd_modversions =3D                                                     =
         \
> +
> +cmd_modversions_c =3D                                                   =
         \
>         if $(OBJDUMP) -h $@ | grep -q __ksymtab; then                    =
       \
> -               $(call cmd_gensymtypes,$(KBUILD_SYMTYPES),$(@:.o=3D.symty=
pes))    \
> +               $(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=3D.sym=
types))  \
>                     > $(@D)/.tmp_$(@F:.o=3D.ver);                        =
         \
>                                                                          =
       \
> -               $(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@        =
       \
> +               $(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@        =
       \
>                         -T $(@D)/.tmp_$(@F:.o=3D.ver);                   =
         \
>                 mv -f $(@D)/.tmp_$(@F) $@;                               =
       \
>                 rm -f $(@D)/.tmp_$(@F:.o=3D.ver);                        =
         \
> -       fi;
> +       fi
>  endif
>
>  ifdef CONFIG_FTRACE_MCOUNT_RECORD
> -# gcc 5 supports generating the mcount tables directly
> -ifneq ($(call cc-option,-mrecord-mcount,y),y)
> -KBUILD_CFLAGS +=3D -mrecord-mcount
> -else
> -# else do it all manually
> +ifndef CC_USING_RECORD_MCOUNT
> +# compiler will not generate __mcount_loc use recordmcount or recordmcou=
nt.pl
>  ifdef BUILD_C_RECORDMCOUNT
>  ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
>    RECORDMCOUNT_FLAGS =3D -w
>  endif
>  # Due to recursion, we must skip empty.o.
>  # The empty.o file is created in the make process in order to determine
> -#  the target endianness and word size. It is made before all other C
> -#  files, including recordmcount.
> +# the target endianness and word size. It is made before all other C
> +# files, including recordmcount.
>  sub_cmd_record_mcount =3D                                        \
>         if [ $(@) !=3D "scripts/mod/empty.o" ]; then      \
>                 $(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) "$(=
@)";   \
> @@ -213,17 +212,59 @@ sub_cmd_record_mcount =3D                          =
         \
>  recordmcount_source :=3D $(srctree)/scripts/recordmcount.c \
>                     $(srctree)/scripts/recordmcount.h
>  else
> -sub_cmd_record_mcount =3D perl $(srctree)/scripts/recordmcount.pl "$(ARC=
H)"      \
> +sub_cmd_record_mcount =3D perl $(srctree)/scripts/recordmcount.pl "$(ARC=
H)" \
>         "$(if $(CONFIG_SYS_BIG_ENDIAN),big,little)" \
>         "$(if $(CONFIG_64BIT),64,32)" \
>         "$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLA=
GS)" \
>         "$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
>         "$(if $(part-of-module),1,0)" "$(@)";
>  recordmcount_source :=3D $(srctree)/scripts/recordmcount.pl
> +endif # BUILD_C_RECORDMCOUNT
> +cmd_record_mcount =3D $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c=
_flags)),        \
> +       $(sub_cmd_record_mcount))
> +endif # CC_USING_RECORD_MCOUNT
> +endif # CONFIG_FTRACE_MCOUNT_RECORD
> +
> +ifdef CONFIG_STACK_VALIDATION
> +ifneq ($(SKIP_STACK_VALIDATION),1)
> +
> +__objtool_obj :=3D $(objtree)/tools/objtool/objtool
> +
> +objtool_args =3D $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
> +
> +objtool_args +=3D $(if $(part-of-module), --module,)
> +
> +ifndef CONFIG_FRAME_POINTER
> +objtool_args +=3D --no-fp
>  endif
> -cmd_record_mcount =3D $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c=
_flags)),        \
> -       $(sub_cmd_record_mcount))
> -endif # -record-mcount
> +ifdef CONFIG_GCOV_KERNEL
> +objtool_args +=3D --no-unreachable
> +endif
> +ifdef CONFIG_RETPOLINE
> +  objtool_args +=3D --retpoline
> +endif
> +
> +# 'OBJECT_FILES_NON_STANDARD :=3D y': skip objtool checking for a direct=
ory
> +# 'OBJECT_FILES_NON_STANDARD_foo.o :=3D 'y': skip objtool checking for a=
 file
> +# 'OBJECT_FILES_NON_STANDARD_foo.o :=3D 'n': override directory skip for=
 a file
> +cmd_objtool =3D $(if $(patsubst y%,, \
> +       $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_ST=
ANDARD)n), \
> +       $(__objtool_obj) $(objtool_args) $@)
> +objtool_obj =3D $(if $(patsubst y%,, \
> +       $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_ST=
ANDARD)n), \
> +       $(__objtool_obj))
> +
> +endif # SKIP_STACK_VALIDATION
> +endif # CONFIG_STACK_VALIDATION
> +
> +# Rebuild all objects when objtool changes, or is enabled/disabled.
> +objtool_dep =3D $(objtool_obj)                                   \
> +             $(wildcard include/config/orc/unwinder.h          \
> +                        include/config/stack/validation.h)
> +
> +ifdef CONFIG_TRIM_UNUSED_KSYMS
> +cmd_gen_ksymdeps =3D \
> +       $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-ta=
rget).cmd
>  endif
>
>  define rule_cc_o_c
> @@ -243,17 +284,25 @@ define rule_as_o_S
>         $(call cmd,modversions_S)
>  endef
>
> +# List module undefined symbols (or empty line if not enabled)
> +ifdef CONFIG_TRIM_UNUSED_KSYMS
> +cmd_undef_syms =3D $(NM) $@ | sed -n 's/^  *U //p' | xargs echo
> +else
> +cmd_undef_syms =3D echo
> +endif
> +
>  # Built-in and composite module parts
> -$(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
> +$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
>         $(call cmd,force_checksrc)
>         $(call if_changed_rule,cc_o_c)
>
>  # Single-part modules are special since we need to mark them in $(MODVER=
DIR)
>
> -$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
> +$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtoo=
l_dep) FORCE
>         $(call cmd,force_checksrc)
>         $(call if_changed_rule,cc_o_c)
> -       @{ echo $(@:.o=3D.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=3D.mod)
> +       @{ echo $(@:.o=3D.ko); echo $@; \
> +          $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=3D.mod)
>
>  quiet_cmd_cc_lst_c =3D MKLST   $@
>        cmd_cc_lst_c =3D $(CC) $(c_flags) -g -c -o $*.o $< && \
> @@ -268,29 +317,83 @@ $(obj)/%.lst: $(src)/%.c FORCE
>
>  modkern_aflags :=3D $(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL)
>
> -$(real-objs-m)      : modkern_aflags :=3D $(KBUILD_AFLAGS_MODULE) $(AFLA=
GS_MODULE)
> -$(real-objs-m:.o=3D.s): modkern_aflags :=3D $(KBUILD_AFLAGS_MODULE) $(AF=
LAGS_MODULE)
> +$(real-obj-m)      : modkern_aflags :=3D $(KBUILD_AFLAGS_MODULE) $(AFLAG=
S_MODULE)
> +$(real-obj-m:.o=3D.s): modkern_aflags :=3D $(KBUILD_AFLAGS_MODULE) $(AFL=
AGS_MODULE)
> +
> +# .S file exports must have their C prototypes defined in asm/asm-protot=
ypes.h
> +# or a file that it includes, in order to get versioned symbols. We buil=
d a
> +# dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines =
from
> +# the .S file (with trailing ';'), and run genksyms on that, to extract =
vers.
> +#
> +# This is convoluted. The .S file must first be preprocessed to run guar=
ds and
> +# expand names, then the resulting exports must be constructed into plai=
n
> +# EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets prepro=
cessed
> +# to make the genksyms input.
> +#
> +# These mirror gensymtypes_c and co above, keep them in synch.
> +cmd_gensymtypes_S =3D                                                   =
      \
> +   { echo "\#include <linux/kernel.h>" ;                                =
    \
> +     echo "\#include <asm/asm-prototypes.h>" ;                          =
    \
> +    $(CPP) $(a_flags) $< |                                              =
    \
> +     grep "\<___EXPORT_SYMBOL\>" |                                      =
    \
> +     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,=
.*/EXPORT_SYMBOL(\1);/' ; } | \
> +    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                            =
    \
> +    scripts/genksyms/genksyms $(if $(1), -T $(2))                       =
    \
> +     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                         =
    \
> +     $(if $(KBUILD_PRESERVE),-p)                                        =
    \
> +     -r $(firstword $(wildcard $(2:.symtypes=3D.symref) /dev/null))
> +
> +quiet_cmd_cc_symtypes_S =3D SYM $(quiet_modtag) $@
> +cmd_cc_symtypes_S =3D                                                   =
      \
> +    $(call cmd_gensymtypes_S,true,$@) >/dev/null;                       =
    \
> +    test -s $@ || rm -f $@
>
> -quiet_cmd_as_s_S =3D CPP $(quiet_modtag) $@
> -cmd_as_s_S       =3D $(CPP) $(a_flags)   -o $@ $<
> +$(obj)/%.symtypes : $(src)/%.S FORCE
> +       $(call cmd,cc_symtypes_S)
> +
> +
> +quiet_cmd_cpp_s_S =3D CPP $(quiet_modtag) $@
> +cmd_cpp_s_S       =3D $(CPP) $(a_flags) -o $@ $<
>
>  $(obj)/%.s: $(src)/%.S FORCE
> -       $(call if_changed_dep,as_s_S)
> +       $(call if_changed_dep,cpp_s_S)
>
>  quiet_cmd_as_o_S =3D AS $(quiet_modtag)  $@
> -cmd_as_o_S       =3D $(CC) $(a_flags) -c -o $@ $<
> +      cmd_as_o_S =3D $(CC) $(a_flags) -c -o $@ $<
> +
> +ifdef CONFIG_MODVERSIONS
> +
> +ASM_PROTOTYPES :=3D $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/as=
m-prototypes.h)
>
> -$(obj)/%.o: $(src)/%.S FORCE
> -       $(call if_changed_dep,as_o_S)
> +ifneq ($(ASM_PROTOTYPES),)
>
> -targets +=3D $(real-objs-y) $(real-objs-m) $(lib-y)
> +# versioning matches the C process described above, with difference that
> +# we parse asm-prototypes.h C header to get function definitions.
> +
> +cmd_modversions_S =3D                                                   =
         \
> +       if $(OBJDUMP) -h $@ | grep -q __ksymtab; then                    =
       \
> +               $(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=3D.sym=
types))  \
> +                   > $(@D)/.tmp_$(@F:.o=3D.ver);                        =
         \
> +                                                                        =
       \
> +               $(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@        =
       \
> +                       -T $(@D)/.tmp_$(@F:.o=3D.ver);                   =
         \
> +               mv -f $(@D)/.tmp_$(@F) $@;                               =
       \
> +               rm -f $(@D)/.tmp_$(@F:.o=3D.ver);                        =
         \
> +       fi
> +endif
> +endif
> +
> +$(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
> +       $(call if_changed_rule,as_o_S)
> +
> +targets +=3D $(filter-out $(subdir-obj-y), $(real-obj-y)) $(real-obj-m) =
$(lib-y)
>  targets +=3D $(extra-y) $(MAKECMDGOALS) $(always)
>  targets +=3D $(real-dtb-y) $(lib-y) $(always-y)
>
>  # Linker scripts preprocessor (.lds.S -> .lds)
>  # ----------------------------------------------------------------------=
-----
>  quiet_cmd_cpp_lds_S =3D LDS     $@
> -      cmd_cpp_lds_S =3D $(CPP) $(cpp_flags) -P -C -U$(ARCH) \
> +      cmd_cpp_lds_S =3D $(CPP) $(cpp_flags) -P -U$(ARCH) \
>                              -D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
>
>  $(obj)/%.lds: $(src)/%.lds.S FORCE
> @@ -312,17 +415,17 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(ob=
jtree)/tools/asn1_compiler
>  $(sort $(subdir-obj-y)): $(subdir-ym) ;
>
>  #
> -# Rule to compile a set of .o files into one .o file
> +# Rule to compile a set of .o files into one .a file (without symbol tab=
le)
>  #
>  ifdef builtin-target
> -quiet_cmd_link_o_target =3D AR      $@
> -# If the list of objects to link is empty, just create an empty built-in=
.o
> -cmd_link_o_target =3D $(if $(strip $(obj-y)),\
> -                     rm -f $@; $(AR) cDPrsT $@ $(filter $(obj-y), $^), \
> -                     rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@)
>
> -$(builtin-target): $(obj-y) FORCE
> -       $(call if_changed,link_o_target)
> +quiet_cmd_ar_builtin =3D AR      $@
> +# Modified for U-Boot, we create thin archives directly, instead of usin=
g the kernel script
> +# Check f49821ee32b76 and 6358d6e8b98 in kernel
> +      cmd_ar_builtin =3D rm -f $@; $(AR) rcTP$(KBUILD_ARFLAGS) $@ $(real=
-prereqs)
> +
> +$(builtin-target): $(real-obj-y) FORCE
> +       $(call if_changed,ar_builtin)
>
>  targets +=3D $(builtin-target)
>  endif # builtin-target
> @@ -341,7 +444,7 @@ $(modorder-target): $(subdir-ym) FORCE
>         $(Q)(cat /dev/null; $(modorder-cmds)) > $@
>
>  #
> -# Rule to compile a set of .o files into one .a file
> +# Rule to compile a set of .o files into one .a file (with symbol table)
>  #
>  ifdef lib-target
>
> @@ -349,25 +452,40 @@ $(lib-target): $(lib-y) FORCE
>         $(call if_changed,ar)
>
>  targets +=3D $(lib-target)
> -endif
>
> -quiet_cmd_link_multi-y =3D AR      $@
> -cmd_link_multi-y =3D rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(filter=
 %.o,$^)
> +dummy-object =3D $(obj)/.lib_exports.o
> +ksyms-lds =3D $(dot-target).lds
> +
> +quiet_cmd_export_list =3D EXPORTS $@
> +cmd_export_list =3D $(OBJDUMP) -h $< | \
> +       sed -ne '/___ksymtab/s/.*+\([^ ]*\).*/EXTERN(\1)/p' >$(ksyms-lds)=
;\
> +       rm -f $(dummy-object);\
> +       echo | $(CC) $(a_flags) -c -o $(dummy-object) -x assembler -;\
> +       $(LD) $(ld_flags) -r -o $@ -T $(ksyms-lds) $(dummy-object);\
> +       rm $(dummy-object) $(ksyms-lds)
> +
> +$(obj)/lib-ksyms.o: $(lib-target) FORCE
> +       $(call if_changed,export_list)
>
> -quiet_cmd_link_multi-m =3D AR [M]  $@
> -cmd_link_multi-m =3D $(cmd_link_multi-y)
> +targets +=3D $(obj)/lib-ksyms.o
>
> -$(multi-used-y): FORCE
> -       $(call if_changed,link_multi-y)
> -$(call multi_depend, $(multi-used-y), .o, -objs -y)
> +endif
> +
> +# NOTE:
> +# Do not replace $(filter %.o,^) with $(real-prereqs). When a single obj=
ect
> +# module is turned into a multi object module, $^ will contain header fi=
le
> +# dependencies recorded in the .*.cmd file.
> +quiet_cmd_link_multi-m =3D LD [M]  $@
> +cmd_link_multi-m =3D $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_s=
ecanalysis)
>
>  $(multi-used-m): FORCE
>         $(call if_changed,link_multi-m)
> -       @{ echo $(@:.o=3D.ko); echo $(filter %.o,$^); } > $(MODVERDIR)/$(=
@F:.o=3D.mod)
> -$(call multi_depend, $(multi-used-m), .o, -objs -y)
> -
> -targets +=3D $(multi-used-y) $(multi-used-m)
> +       @{ echo $(@:.o=3D.ko); echo $(filter %.o,$^); \
> +          $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=3D.mod)
> +$(call multi_depend, $(multi-used-m), .o, -objs -y -m)
>
> +targets +=3D $(multi-used-m)
> +targets :=3D $(filter-out $(PHONY), $(targets))
>
>  # Add intermediate targets:
>  # When building objects with specific suffix patterns, add intermediate
> @@ -375,9 +493,13 @@ targets +=3D $(multi-used-y) $(multi-used-m)
>  intermediate_targets =3D $(foreach sfx, $(2), \
>                                 $(patsubst %$(strip $(1)),%$(sfx), \
>                                         $(filter %$(strip $(1)), $(target=
s))))
> +# %.asn1.o <- %.asn1.[ch] <- %.asn1
> +# %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
>  # %.lex.o <- %.lex.c <- %.l
>  # %.tab.o <- %.tab.[ch] <- %.y
> -targets +=3D $(call intermediate_targets, .lex.o, .lex.c) \
> +targets +=3D $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
> +          $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
> +          $(call intermediate_targets, .lex.o, .lex.c) \
>            $(call intermediate_targets, .tab.o, .tab.c .tab.h)
>
>  # Descending
> @@ -385,7 +507,7 @@ targets +=3D $(call intermediate_targets, .lex.o, .le=
x.c) \
>
>  PHONY +=3D $(subdir-ym)
>  $(subdir-ym):
> -       $(Q)$(MAKE) $(build)=3D$@
> +       $(Q)$(MAKE) $(build)=3D$@ need-builtin=3D$(if $(findstring $@,$(s=
ubdir-obj-y)),1)
>
>  # Add FORCE to the prequisites of a target to force it to be always rebu=
ilt.
>  # ----------------------------------------------------------------------=
-----
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> new file mode 100644
> index 000000000000..5f7df50cfe7a
> --- /dev/null
> +++ b/scripts/Makefile.gcc-plugins
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +gcc-plugin-$(CONFIG_GCC_PLUGIN_CYC_COMPLEXITY) +=3D cyc_complexity_plugi=
n.so
> +
> +gcc-plugin-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY) +=3D latent_entropy_plugi=
n.so
> +gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)          \
> +               +=3D -DLATENT_ENTROPY_PLUGIN
> +ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
> +    DISABLE_LATENT_ENTROPY_PLUGIN +=3D -fplugin-arg-latent_entropy_plugi=
n-disable
> +endif
> +export DISABLE_LATENT_ENTROPY_PLUGIN
> +
> +gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)         +=3D sancov_plugin.so
> +
> +gcc-plugin-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)     +=3D structleak_plugin.so
> +gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE)      \
> +               +=3D -fplugin-arg-structleak_plugin-verbose
> +gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF)                \
> +               +=3D -fplugin-arg-structleak_plugin-byref
> +gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)    \
> +               +=3D -fplugin-arg-structleak_plugin-byref-all
> +gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)              \
> +               +=3D -DSTRUCTLEAK_PLUGIN
> +
> +gcc-plugin-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)     +=3D randomize_layout_plu=
gin.so
> +gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)              \
> +               +=3D -DRANDSTRUCT_PLUGIN
> +gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE)  \
> +               +=3D -fplugin-arg-randomize_layout_plugin-performance-mod=
e
> +
> +gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)      +=3D stackleak_plugin.so
> +gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)               \
> +               +=3D -DSTACKLEAK_PLUGIN
> +gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)               \
> +               +=3D -fplugin-arg-stackleak_plugin-track-min-size=3D$(CON=
FIG_STACKLEAK_TRACK_MIN_SIZE)
> +ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +    DISABLE_STACKLEAK_PLUGIN +=3D -fplugin-arg-stackleak_plugin-disable
> +endif
> +export DISABLE_STACKLEAK_PLUGIN
> +
> +gcc-plugin-$(CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK) +=3D arm_ssp_per_task_p=
lugin.so
> +ifdef CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK
> +    DISABLE_ARM_SSP_PER_TASK_PLUGIN +=3D -fplugin-arg-arm_ssp_per_task_p=
lugin-disable
> +endif
> +export DISABLE_ARM_SSP_PER_TASK_PLUGIN
> +
> +# All the plugin CFLAGS are collected here in case a build target needs =
to
> +# filter them out of the KBUILD_CFLAGS.
> +GCC_PLUGINS_CFLAGS :=3D $(strip $(addprefix -fplugin=3D$(objtree)/script=
s/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
> +# The sancov_plugin.so is included via CFLAGS_KCOV, so it is removed her=
e.
> +GCC_PLUGINS_CFLAGS :=3D $(filter-out %/sancov_plugin.so, $(GCC_PLUGINS_C=
FLAGS))
> +export GCC_PLUGINS_CFLAGS
> +
> +# Add the flags to the build!
> +KBUILD_CFLAGS +=3D $(GCC_PLUGINS_CFLAGS)
> +
> +# All enabled GCC plugins are collected here for building below.
> +GCC_PLUGIN :=3D $(gcc-plugin-y)
> +export GCC_PLUGIN
> diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
> new file mode 100644
> index 000000000000..3d61c4bfcbee
> --- /dev/null
> +++ b/scripts/Makefile.kcov
> @@ -0,0 +1,9 @@
> +ifdef CONFIG_KCOV
> +
> +kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)    +=3D -fsanitize-coverage=
=3Dtrace-pc
> +kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)   +=3D -fsanitize-coverage=
=3Dtrace-cmp
> +kcov-flags-$(CONFIG_GCC_PLUGIN_SANCOV)         +=3D -fplugin=3D$(objtree=
)/scripts/gcc-plugins/sancov_plugin.so
> +
> +export CFLAGS_KCOV :=3D $(kcov-flags-y)
> +
> +endif
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 19a5be574956..5db2fbc418a1 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -5,46 +5,40 @@ ccflags-y  +=3D $(EXTRA_CFLAGS)
>  cppflags-y +=3D $(EXTRA_CPPFLAGS)
>  ldflags-y  +=3D $(EXTRA_LDFLAGS)
>
> -#
> -# flags that take effect in sub directories
> -export KBUILD_SUBDIR_ASFLAGS :=3D $(KBUILD_SUBDIR_ASFLAGS) $(subdir-asfl=
ags-y)
> -export KBUILD_SUBDIR_CCFLAGS :=3D $(KBUILD_SUBDIR_CCFLAGS) $(subdir-ccfl=
ags-y)
> +# flags that take effect in current and sub directories
> +KBUILD_AFLAGS +=3D $(subdir-asflags-y)
> +KBUILD_CFLAGS +=3D $(subdir-ccflags-y)
>
>  # Figure out what we need to build from the various variables
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
>  # When an object is listed to be built compiled-in and modular,
>  # only build the compiled-in version
> -
>  obj-m :=3D $(filter-out $(obj-y),$(obj-m))
>
>  # Libraries are always collected in one lib file.
>  # Filter out objects already built-in
> -
>  lib-y :=3D $(filter-out $(obj-y), $(sort $(lib-y) $(lib-m)))
>
> +# Determine modorder.
> +# Unfortunately, we don't have information about ordering between -y
> +# and -m subdirs.  Just put -y's first.
> +modorder       :=3D $(patsubst %/,%/modules.order, $(filter %/, $(obj-y)=
) $(obj-m:.o=3D.ko))
>
>  # Handle objects in subdirs
>  # ----------------------------------------------------------------------=
-----
> -# o if we encounter foo/ in $(obj-y), replace it by foo/built-in.o
> +# o if we encounter foo/ in $(obj-y), replace it by foo/built-in.a
>  #   and add the directory to the list of dirs to descend into: $(subdir-=
y)
>  # o if we encounter foo/ in $(obj-m), remove it from $(obj-m)
>  #   and add the directory to the list of dirs to descend into: $(subdir-=
m)
> -
> -# Determine modorder.
> -# Unfortunately, we don't have information about ordering between -y
> -# and -m subdirs.  Just put -y's first.
> -modorder       :=3D $(patsubst %/,%/modules.order, $(filter %/, $(obj-y)=
) $(obj-m:.o=3D.ko))
> -
>  __subdir-y     :=3D $(patsubst %/,%,$(filter %/, $(obj-y)))
>  subdir-y       +=3D $(__subdir-y)
>  __subdir-m     :=3D $(patsubst %/,%,$(filter %/, $(obj-m)))
>  subdir-m       +=3D $(__subdir-m)
> -obj-y          :=3D $(patsubst %/, %/built-in.o, $(obj-y))
> +obj-y          :=3D $(patsubst %/, %/built-in.a, $(obj-y))
>  obj-m          :=3D $(filter-out %/, $(obj-m))
>
>  # Subdirectories we need to descend into
> -
>  subdir-ym      :=3D $(sort $(subdir-y) $(subdir-m))
>
>  # Expand $(foo-objs) $(foo-y) etc. by replacing their individuals
> @@ -54,9 +48,9 @@ multi-search =3D $(sort $(foreach m, $1, $(if $(call su=
ffix-search, $m, $2, $3 -),
>  # List primitive targets that are compiled from source files
>  real-search =3D $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -=
), $(call suffix-search, $m, $2, $3), $m))
>
> -# if $(foo-objs) exists, foo.o is a composite object
> +# if $(foo-objs), $(foo-y), or $(foo-m) exists, foo.o is a composite obj=
ect
>  multi-used-y :=3D $(sort $(foreach m,$(obj-y), $(if $(strip $($(m:.o=3D-=
objs)) $($(m:.o=3D-y))), $(m))))
> -multi-used-m :=3D $(sort $(foreach m,$(obj-m), $(if $(strip $($(m:.o=3D-=
objs)) $($(m:.o=3D-y))), $(m))))
> +multi-used-m :=3D $(sort $(foreach m,$(obj-m), $(if $(strip $($(m:.o=3D-=
objs)) $($(m:.o=3D-y)) $($(m:.o=3D-m))), $(m))))
>  multi-used   :=3D $(multi-used-y) $(multi-used-m)
>  single-used-m :=3D $(sort $(filter-out $(multi-used-m),$(obj-m)))
>
> @@ -74,11 +68,22 @@ base-dtb-y :=3D $(foreach m, $(multi-dtb-y), $(firstw=
ord $(call suffix-search, $m,
>
>  # $(subdir-obj-y) is the list of objects in $(obj-y) which uses dir/ to
>  # tell kbuild to descend
> -subdir-obj-y :=3D $(filter %/built-in.o, $(obj-y))
> +subdir-obj-y :=3D $(filter %/built-in.a, $(obj-y))
>
> -# Replace multi-part objects by their individual parts, look at local di=
r only
> -real-objs-y :=3D $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $=
(if $(strip $($(m:.o=3D-objs)) $($(m:.o=3D-y))),$($(m:.o=3D-objs)) $($(m:.o=
=3D-y)),$(m))) $(extra-y)
> -real-objs-m :=3D $(foreach m, $(obj-m), $(if $(strip $($(m:.o=3D-objs)) =
$($(m:.o=3D-y))),$($(m:.o=3D-objs)) $($(m:.o=3D-y)),$(m)))
> +# Replace multi-part objects by their individual parts,
> +# including built-in.a from subdirectories
> +real-obj-y :=3D $(foreach m, $(obj-y), $(if $(strip $($(m:.o=3D-objs)) $=
($(m:.o=3D-y))),$($(m:.o=3D-objs)) $($(m:.o=3D-y)),$(m)))
> +real-obj-m :=3D $(foreach m, $(obj-m), $(if $(strip $($(m:.o=3D-objs)) $=
($(m:.o=3D-y)) $($(m:.o=3D-m))),$($(m:.o=3D-objs)) $($(m:.o=3D-y)) $($(m:.o=
=3D-m)),$(m)))
> +
> +# DTB
> +# If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
> +extra-y                                +=3D $(dtb-y)
> +extra-$(CONFIG_OF_ALL_DTBS)    +=3D $(dtb-)
> +
> +ifneq ($(CHECK_DTBS),)
> +extra-y +=3D $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
> +extra-$(CONFIG_OF_ALL_DTBS) +=3D $(patsubst %.dtb,%.dt.yaml, $(dtb-))
> +endif
>
>  # Add subdir path
>
> @@ -91,8 +96,8 @@ obj-y         :=3D $(addprefix $(obj)/,$(obj-y))
>  obj-m          :=3D $(addprefix $(obj)/,$(obj-m))
>  lib-y          :=3D $(addprefix $(obj)/,$(lib-y))
>  subdir-obj-y   :=3D $(addprefix $(obj)/,$(subdir-obj-y))
> -real-objs-y    :=3D $(addprefix $(obj)/,$(real-objs-y))
> -real-objs-m    :=3D $(addprefix $(obj)/,$(real-objs-m))
> +real-obj-y     :=3D $(addprefix $(obj)/,$(real-obj-y))
> +real-obj-m     :=3D $(addprefix $(obj)/,$(real-obj-m))
>  single-used-m  :=3D $(addprefix $(obj)/,$(single-used-m))
>  multi-used-y   :=3D $(addprefix $(obj)/,$(multi-used-y))
>  multi-used-m   :=3D $(addprefix $(obj)/,$(multi-used-m))
> @@ -102,22 +107,25 @@ multi-dtb-y       :=3D $(addprefix $(obj)/,$(multi-=
dtb-y))
>  real-dtb-y      :=3D $(addprefix $(obj)/,$(real-dtb-y))
>  subdir-ym      :=3D $(addprefix $(obj)/,$(subdir-ym))
>
> +# Finds the multi-part object the current object will be linked into.
> +# If the object belongs to two or more multi-part objects, all of them a=
re
> +# concatenated with a colon separator.
> +modname-multi =3D $(subst $(space),:,$(sort $(foreach m,$(multi-used),\
> +               $(if $(filter $*.o, $($(m:.o=3D-objs)) $($(m:.o=3D-y)) $(=
$(m:.o=3D-m))),$(m:.o=3D)))))
> +
> +modname =3D $(if $(modname-multi),$(modname-multi),$(basetarget))
> +
>  # These flags are needed for modversions and compiling, so we define the=
m here
> -# already
> -# $(modname_flags) #defines KBUILD_MODNAME as the name of the module it =
will
> +# $(modname_flags) defines KBUILD_MODNAME as the name of the module it w=
ill
>  # end up in (or would, if it gets compiled in)
> -# Note: Files that end up in two or more modules are compiled without th=
e
> -#       KBUILD_MODNAME definition. The reason is that any made-up name w=
ould
> -#       differ in different configs.
>  name-fix =3D $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote=
)$(squote)
>  basename_flags =3D -DKBUILD_BASENAME=3D$(call name-fix,$(basetarget))
> -modname_flags  =3D $(if $(filter 1,$(words $(modname))),\
> -                 -DKBUILD_MODNAME=3D$(call name-fix,$(modname)))
> +modname_flags  =3D -DKBUILD_MODNAME=3D$(call name-fix,$(modname))
>
> -orig_c_flags   =3D $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(KBUILD_SUBDIR_C=
CFLAGS) \
> +orig_c_flags   =3D $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) \
>                   $(ccflags-y) $(CFLAGS_$(basetarget).o)
>  _c_flags       =3D $(filter-out $(CFLAGS_REMOVE_$(basetarget).o), $(orig=
_c_flags))
> -orig_a_flags   =3D $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(KBUILD_SUBDIR_A=
SFLAGS) \
> +orig_a_flags   =3D $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) \
>                   $(asflags-y) $(AFLAGS_$(basetarget).o)
>  _a_flags       =3D $(filter-out $(AFLAGS_REMOVE_$(basetarget).o), $(orig=
_a_flags))
>  _cpp_flags     =3D $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(@F))
> @@ -140,7 +148,19 @@ endif
>  ifeq ($(CONFIG_KASAN),y)
>  _c_flags +=3D $(if $(patsubst n%,, \
>                 $(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
> -               $(CFLAGS_KASAN))
> +               $(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
> +endif
> +
> +ifeq ($(CONFIG_UBSAN),y)
> +_c_flags +=3D $(if $(patsubst n%,, \
> +               $(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)$(CONFI=
G_UBSAN_SANITIZE_ALL)), \
> +               $(CFLAGS_UBSAN))
> +endif
> +
> +ifeq ($(CONFIG_KCOV),y)
> +_c_flags +=3D $(if $(patsubst n%,, \
> +       $(KCOV_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)$(CONFIG_KCOV=
_INSTRUMENT_ALL)), \
> +       $(CFLAGS_KCOV))
>  endif
>
>  __c_flags      =3D $(_c_flags)
> @@ -161,7 +181,6 @@ __a_flags   =3D $(call flags,_a_flags)
>  __cpp_flags     =3D $(call flags,_cpp_flags)
>  endif
>  endif
> -
>  # Modified for U-Boot: LINUXINCLUDE -> UBOOTINCLUDE
>  c_flags        =3D -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE) =
    \
>                  $(__c_flags) $(modkern_cflags)                          =
 \
> @@ -222,7 +241,6 @@ dtc_cpp_flags  =3D -Wp,-MD,$(depfile).pre.tmp -nostdi=
nc                    \
>  # Finds the multi-part object the current object will be linked into
>  modname-multi =3D $(sort $(foreach m,$(multi-used),\
>                 $(if $(filter $(subst $(obj)/,,$*.o), $($(m:.o=3D-objs)) =
$($(m:.o=3D-y))),$(m:.o=3D))))
> -
>  # Useful for describing the dependency of composite objects
>  # Usage:
>  #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to=
_add)
> @@ -278,12 +296,13 @@ $(obj)/%: $(src)/%_shipped
>  # ----------------------------------------------------------------------=
-----
>
>  quiet_cmd_ld =3D LD      $@
> -cmd_ld =3D $(LD) $(ld_flags) $(filter-out FORCE,$^) -o $@
> +      cmd_ld =3D $(LD) $(ld_flags) $(real-prereqs) -o $@
>
>  # Archive
>  # ----------------------------------------------------------------------=
-----
> +
>  quiet_cmd_ar =3D AR      $@
> -cmd_ar =3D rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> +      cmd_ar =3D rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereq=
s)
>
>  # Objcopy
>  # ----------------------------------------------------------------------=
-----
> @@ -295,10 +314,11 @@ cmd_objcopy =3D $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOP=
YFLAGS_$(@F)) $< $@
>  # ----------------------------------------------------------------------=
-----
>
>  quiet_cmd_gzip =3D GZIP    $@
> -cmd_gzip =3D cat $(filter-out FORCE,$^) | gzip -n -f -9 > $@
> +      cmd_gzip =3D cat $(real-prereqs) | gzip -n -f -9 > $@
>
>  # DTC
>  # ----------------------------------------------------------------------=
-----
> +DTC ?=3D $(objtree)/scripts/dtc/dtc
>
>  # Disable noisy checks by default
>  ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
> @@ -309,7 +329,6 @@ DTC_FLAGS +=3D -Wno-unit_address_vs_reg \
>         -Wno-graph_child_address \
>         -Wno-simple_bus_reg \
>         -Wno-unique_unit_address \
> -       -Wno-simple_bus_reg \
>         -Wno-pci_device_reg
>
>  # U-Boot specific disables
> @@ -567,20 +586,20 @@ printf "%08x\n" $$dec_size |                       =
                       \
>  )
>
>  quiet_cmd_bzip2 =3D BZIP2   $@
> -cmd_bzip2 =3D { cat $(real-prereqs) | bzip2 -9 && $(size_append); } > $@
> +      cmd_bzip2 =3D { cat $(real-prereqs) | bzip2 -9 && $(size_append); =
} > $@
>
>  # Lzma
>  # ----------------------------------------------------------------------=
-----
>
>  quiet_cmd_lzma =3D LZMA    $@
> -cmd_lzma =3D { cat $(real-prereqs) | lzma -9 && $(size_append); } > $@
> +      cmd_lzma =3D { cat $(real-prereqs) | lzma -9 && $(size_append); } =
> $@
>
>  quiet_cmd_lzo =3D LZO     $@
> -cmd_lzo =3D { cat $(real-prereqs) | lzop -9 && $(size_append); } > $@
> +      cmd_lzo =3D { cat $(real-prereqs) | lzop -9 && $(size_append); } >=
 $@
>
>  quiet_cmd_lz4 =3D LZ4     $@
> -cmd_lz4 =3D { cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
> -       $(size_append); } > $@
> +      cmd_lz4 =3D { cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
> +                  $(size_append); } > $@
>
>  # U-Boot mkimage
>  # ----------------------------------------------------------------------=
-----
> @@ -702,12 +721,15 @@ quiet_cmd_fdt_rm_props =3D FDTGREP $@
>  # ----------------------------------------------------------------------=
-----
>
>  # Default sed regexp - multiline due to syntax constraints
> +#
> +# Use [:space:] because LLVM's integrated assembler inserts <tab> around
> +# the .ascii directive whereas GCC keeps the <space> as-is.
>  define sed-offsets
> -       "s:[[:space:]]*\.ascii[[:space:]]*\"\(.*\)\":\1:; \
> +       's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; \
>         /^->/{s:->#\(.*\):/* \1 */:; \
>         s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:;=
 \
>         s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
> -       s:->::; p;}"
> +       s:->::; p;}'
>  endef
>
>  # Use filechk to avoid rebuilds when a header changes, but the resulting=
 file
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index 43f27874f9fe..03a2f151d916 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -135,7 +135,7 @@ head-y              :=3D $(addprefix $(obj)/,$(head-y=
))
>  libs-y         :=3D $(addprefix $(obj)/,$(libs-y))
>  u-boot-spl-dirs        :=3D $(patsubst %/,%,$(filter %/, $(libs-y)))
>
> -libs-y :=3D $(patsubst %/, %/built-in.o, $(libs-y))
> +libs-y :=3D $(patsubst %/, %/built-in.a, $(libs-y))
>
>  # Add GCC lib
>  ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
> diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthre=
ad.py
> index b4cb66397bb7..d1f73964d822 100644
> --- a/tools/buildman/builderthread.py
> +++ b/tools/buildman/builderthread.py
> @@ -627,7 +627,7 @@ class BuilderThread(threading.Thread):
>              # Extract the environment from U-Boot and dump it out
>              cmd =3D [f'{self.toolchain.cross}objcopy', '-O', 'binary',
>                     '-j', '.rodata.default_environment',
> -                   'env/built-in.o', 'uboot.env']
> +                   'env/built-in.a', 'uboot.env']
>              command.run_one(*cmd, capture=3DTrue, capture_stderr=3DTrue,
>                              cwd=3Dresult.out_dir, raise_on_error=3DFalse=
, env=3Denv)
>              if not work_in_output:
> --
> 2.49.0
>
