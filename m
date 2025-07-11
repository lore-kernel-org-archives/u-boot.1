Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EFCC8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 07:28:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 146D3806D8;
	Fri, 11 Jul 2025 09:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="MQif49CD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A4882998; Fri, 11 Jul 2025 09:28:07 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5A2805D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 09:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 42A5522F39;
 Fri, 11 Jul 2025 09:28:05 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cSdFQB_NnDS0; Fri, 11 Jul 2025 09:28:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752218883; bh=auW9nEdScqkCbgEN/QOnPzmhkSvTNXh4vMzqJhp4gkA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MQif49CDgL5Jq3jvoXcPCYNvt6MAGkLXkGmUvl7EV9ZSLEAJRDK6Dbsh5tCi68Nik
 bIYwAzp3/XOSbz2Lq/BR2OeBXDf7NZnpNSu8zXdzzqno0Z347nbo8ag1rkM54ec7Ei
 eKlUJpoRKawMiXGnB7mk7+hDr1VkswMb4CsFV6Xld22DgqND3Hm0HGotgIdG015CKi
 X9iiLwmMKijcJiIKT1rolvfV9o4RN8VY6bzXrCMIlWSlNR0m7LkFuo0R3Y65f7aFMh
 5czpwnmi8I7giGZe0ZPd4f7rrpKKxJ+lgzwqD7oKCTL/U8Es+/gdD7gOhdc1fAwyxv
 vvOmc9uIu7C1A==
Date: Fri, 11 Jul 2025 07:27:57 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] kbuild: Avoid including architecture-specific Makefile
 twice
Message-ID: <aHC8_Reg1Bx44XCS@pie.lan>
References: <20250709161418.21287-2-ziyao@disroot.org>
 <CAC_iWjKovoQA0K57pwT9Mfzo_Y4NMvUZO5jfDcQAztTMn4LcMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjKovoQA0K57pwT9Mfzo_Y4NMvUZO5jfDcQAztTMn4LcMw@mail.gmail.com>
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

On Fri, Jul 11, 2025 at 08:11:03AM +0300, Ilias Apalodimas wrote:
> Hi Yao,
> 
> 
> On Wed, 9 Jul 2025 at 19:15, Yao Zi <ziyao@disroot.org> wrote:
> >
> > Stranges errors are observed when building U-Boot master for almost any
> > RISC-V board, the messages are in two types, one is about duplicated
> > symbols,
> >
> >         u-boot/arch/riscv/cpu//mtrap.S:32: multiple definition of `trap_entry';
> >         arch/riscv/cpu/mtrap.o: u-boot/arch/riscv/cpu//mtrap.S:32: first defined here
> >
> > and the other is fixdep's complaint about missing dependency files,
> >
> >         fixdep: error opening file: arch/riscv/cpu/.mtrap.o.d: No such file or directory
> >         fixdep: error opening file: arch/riscv/cpu//.start.o.d: No such file or directory
> >
> > where the latter could only be reproduced when building parallelly.
> >
> > Both the two types of errors are about files in arch/riscv/cpu, and
> > there's a suspicious slash character in the reported path. Looking
> > through RISC-V-specific Makefiles, there's only one place that may
> > expand to such a path,
> >
> >         libs-y += arch/riscv/cpu/$(CPU)/
> >
> > The right hand expands to "arch/riscv/cpu//" if $(CPU) isn't defined at
> > the time of including. With some debug statement added to
> > arch/riscv/Makefile, the output proves that arch/riscv/Makefile is
> > included twice, once with $(CPU) undefined and once defined correctly
> > according to CONFIG_SYS_CPU.
> >
> > Futher bisecting shows an extra include statement against
> > arch/$(SRCARCH)/Makefile is added in earlier bump of Kbuild system. But
> > the statement is evaluated before config.mk is included and definition
> > of $(CPU), causing objects in arch/riscv/cpu/ are built and linked twice
> > (once as "arch/riscv/cpu/*", and once as "arch/riscv/cpu//*"), resulting
> > in the error.
> >
> > Let's simply remove the extra include to fix these nasty errors. Note
> > though this therotically affects all architectures, ones except RISC-V
> > may not reproduce similar errors since there are no source files
> > directly under arch/*/cpu, thus the extra include doesn't hurt.
> 
> There's another unconditional include under ifeq ($(config-targets),1).
> Should we remove that as well?

I don't think it really matters. This include is only for config targets
that don't actually run the build, but only descent into scripts/kconfig
and generate a configuration. The include of arch/$(SRCARCH)/Makefile
seems only for getting an appropriate name of defconfig
(KBUILD_DEFCONFIG), as explained by the comment. It seems even okay to
remove the include, as U-Boot has no architecture defining its own
KBUILD_DEFCONFIG.

> The patch it self seems correct, but can you try removing the
> pre-existing include instead and add the config.mk inclusion?
> Something like
> diff --git a/Makefile b/Makefile
> index db8d89587290..e6ad9be262ef 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -636,6 +636,7 @@ ifeq ($(config-targets),1)
>  # KBUILD_DEFCONFIG may point out an alternative default configuration
>  # used for 'make defconfig'
>  # Modified for U-Boot
> +include config.mk
>  -include arch/$(SRCARCH)/Makefile
>  export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT
> 
> @@ -725,6 +726,7 @@ ARCH_CPPFLAGS :=
>  ARCH_AFLAGS :=
>  ARCH_CFLAGS :=
>  # Modified for U-Boot
> +include config.mk

I don't think config.mk could be included without making sure
include/autoconf.mk is update to date, just as pointed out by the
comment at line 768

	> We want to include arch/$(ARCH)/config.mk only when
	> include/config/auto.conf is up-to-date. When we switch to a
	> different board configuration, old CONFIG macros are still
	> remaining in include/config/auto.conf. Without the following
	> gimmick, wrong config.mk would be included leading nasty
	> warnings/errors.

And this change does cause errors if I use a defconfig, build U-Boot,
then switch to another defconfig and build again, for example,

	$ make ARCH=arm CROSS_COMPILE=arm-none-eabi- mx6sabresd_defconfig
	$ make ARCH=arm CROSS_COMPILE=arm-none-eabi-
	$ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-musl- \
		sifive_unleashed_defconfig
	$ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-musl-

results in errors like

	drivers/gpio/sifive-gpio.c:9:10: fatal error: asm/arch/gpio.h: No such file or directory
	    9 | #include <asm/arch/gpio.h>
	      |          ^~~~~~~~~~~~~~~~~
	compilation terminated.

and ls -l arch/riscv/include/asm/arch shows the symlink points to a
non-existing directory,

	$ ls -l arch/riscv/include/asm/arch
	lrwxrwxrwx    1 ziyao    ziyao            8 Jul 11 07:11 arch/riscv/include/asm/arch -> arch-mx6

it's really likely that the old auto.conf is evaluated, since arch-mx6
isn't a RISC-V thing.

>  -include arch/$(SRCARCH)/Makefile
> 
>  ifeq ($(dot-config),1)
> @@ -773,10 +775,6 @@ ifneq ($(wildcard $(KCONFIG_CONFIG)),)
>  ifneq ($(wildcard include/config/auto.conf),)
>  autoconf_is_old := $(shell find . -path ./$(KCONFIG_CONFIG) -newer \
>                                                 include/config/auto.conf)
> -ifeq ($(autoconf_is_old),)
> -include config.mk
> -include arch/$(ARCH)/Makefile
> -endif
>  endif
>  endif
> 
> I prefer keeping the makefile closer to the kernel so we can sync it
> up easier in the future
> 
> Thanks for looking at this
> /Ilias
> >

Regards,
Yao Zi
