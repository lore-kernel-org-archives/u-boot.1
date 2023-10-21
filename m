Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24707C004C0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 15:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 230F7875B3;
	Sat, 21 Oct 2023 17:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ShFoSlcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EA08761B; Sat, 21 Oct 2023 17:43:27 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E613875B2
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 17:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5079fa1bbf8so2635996e87.0
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697903003; x=1698507803; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XzBDCsGfO+oK1IaMdgve4Ph5pNLTlL5DROLGWnjL2As=;
 b=ShFoSlcM5n1kHh5HrJrHFb4JMmw80XoPSSzfgdlwXvm4lKwastPOCyaPLID3IdS+2s
 HlDXa319yRNaAp9xbfgq5hadIQfCAJXuH1ENVSaUTAaYH7cnwFyNozjPjUt0MWLgMWms
 qbnOfyFcFXFpLeQjORFwAqfk1QxOMNQiCpFG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697903003; x=1698507803;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XzBDCsGfO+oK1IaMdgve4Ph5pNLTlL5DROLGWnjL2As=;
 b=Ew8RHyjo8tqJ7ej9hCKZ/luZaO0ZdW93lN+W9EPISLmEyzp6rsLgUIyVrB/bcdyoqq
 dinXZYC2QpgohgYmNIJEOmOYmyJj6Z2zhEpSmmgrfq162kog3CaurQofW2PVmat/ijtO
 Sl45h+WtsP2t1QpMZBmPc9ZVxwglberIGWeASElT0kmYLH1xXEArNMKVU2QmcyFs8XSR
 voojAE8srJe9LnzNEkG+nJ219EPXfTe/RRQEJos/+gE/h7JKGX15T2jUMns8KwBiOVh5
 1QisIboG0WsFJ1SFzeE48Hyi6wYV/5ZfFuT1btGyzhUrCAPc2uL56/mYMMrh15IC7bhl
 KpCA==
X-Gm-Message-State: AOJu0Yxg8ZJyxYk0wQpPo2lqu/A198GEIfr6M/Nnz/rfzxiBZLLAOk+Z
 yPxFfKc4dUOtJzgDiRXyEr/rCzEXUe2Zk4yC1Xt21g==
X-Google-Smtp-Source: AGHT+IHPevIkkeMGaOMPmNNkcdeGEakXX+UpgRl7tY/NEoDR3I5h/lyhxB2s79iqXdx2UYiI23iDu75gzgWTjl2WZmw=
X-Received: by 2002:ac2:53a5:0:b0:507:a16d:cf55 with SMTP id
 j5-20020ac253a5000000b00507a16dcf55mr2910266lfh.68.1697903002598; Sat, 21 Oct
 2023 08:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
In-Reply-To: <ZTHKKurIp67bx2MJ@octopus>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 21 Oct 2023 08:43:08 -0700
Message-ID: <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 10/17/23 16:09, Tom Rini wrote:
> > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > > >
> > > >> Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> > > >> available, add it as an explicit dependency.
> > > >>
> > > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >> ---
> > > >>
> > > >> (no changes since v2)
> > > >>
> > > >> Changes in v2:
> > > >> - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > >>
> > > >>   lib/efi_loader/Kconfig | 1 +
> > > >>   1 file changed, 1 insertion(+)
> > > >>
> > > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > >> index 13cad6342c36..fca4b3eef270 100644
> > > >> --- a/lib/efi_loader/Kconfig
> > > >> +++ b/lib/efi_loader/Kconfig
> > > >> @@ -11,6 +11,7 @@ config EFI_LOADER
> > > >>      # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > > >>      depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > > >>      depends on BLK
> > > >> +    depends on DM_ETH
> > > >>      depends on !EFI_APP
> > > >>      default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> > > >>      select CHARSET
> > > >
> > > > Does this work for you Heinrich, or do you want to clarify the
> > > > dependencies (and re-organize the code as needed) around networking?
> > > >
> > >
> > > We should be able to boot via EFI on devices without U-Boot network support.
> > >
> > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
> > > eth_get_dev() if there is no network. CONFIG_NETDEVICES=y selects
> > > CONFIG_DM_ETH.
> > >
> > > Why is this not sufficient?
> > > Is there a configuration that does not build?
> >
> > The point of this series is to disable CMDLINE and fix up what breaks.
> >
> > In this case we have some sort of breakage...perhaps Tom has already
> > found it, but otherwise could you take a look?
> >
> > We should be able to disable NET and LTO in sandbox and still build.
> > But this fails at present[1]. You can try it on -master
>
> Obviously, it would be necessary to enclose efi_dp_from_eth()
> with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> Then, we could drop "depends on DM_ETH".

Strange that it only happens on the non-LTO board, though?

>
> Another possible place for completeness is "case UCLASS_ETH" clause
> in dp_size(), but it seems to be harmless.

OK

Regards,
Simon


>
> -Takahiro Akashi
>
>
> > Regards,
> > Simon
> >
> > [1] sjg@sjg1:~/u$ crosfw sandbox -L
> > cmd: make -j4 'CROSS_COMPILE=' --no-print-directory 'HOSTSTRIP=true'
> > 'QEMU_ARCH=' 'KCONFIG_NOSILENTUPDATE=1' 'O=/tmp/b/sandbox' 'NO_LTO=1'
> > -s 'BUILD_ROM=1' all
> > /usr/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from_eth':
> > /home/sjg/c/src/third_party/u-boot/files/lib/efi_loader/efi_device_path.c:985:(.text+0xca4):
> > undefined reference to `eth_get_dev'
> > /usr/bin/ld: /home/sjg/c/src/third_party/u-boot/files/lib/efi_loader/efi_device_path.c:987:(.text+0xca9):
> > undefined reference to `eth_get_dev'
> > /usr/bin/ld: /home/sjg/c/src/third_party/u-boot/files/lib/efi_loader/efi_device_path.c:993:(.text+0xcc9):
> > undefined reference to `eth_get_dev'
> > collect2: error: ld returned 1 exit status
> > make[1]: *** [/home/sjg/c/src/third_party/u-boot/files/Makefile:1765:
> > u-boot] Error 1
> > make: *** [Makefile:177: sub-make] Error 2
> >
> > sjg@sjg1:~/u$ crosfw sandbox
> > sjg@sjg1:~/u$ (passes)
> >
> > 'crosfw xx' is just 'buildman --bo xxx'
> >
> > diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > index a92bb896c63e..4e9996a92342 100644
> > --- a/boot/pxe_utils.c
> > +++ b/boot/pxe_utils.c
> > @@ -48,7 +48,7 @@ int pxe_get_file_size(ulong *sizep)
> >
> >   return 0;
> >  }
> > -
> > +#if 0
> >  /**
> >   * format_mac_pxe() - obtain a MAC address in the PXE format
> >   *
> > @@ -82,7 +82,7 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len)
> >
> >   return 1;
> >  }
> > -
> > +#endif
> >  /**
> >   * get_relfile() - read a file relative to the PXE file
> >   *
> > diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> > index 47417cb0391d..57bb6202dbb5 100644
> > --- a/configs/sandbox_defconfig
> > +++ b/configs/sandbox_defconfig
> > @@ -349,3 +349,4 @@ CONFIG_TEST_FDTDEC=y
> >  CONFIG_UNIT_TEST=y
> >  CONFIG_UT_TIME=y
> >  CONFIG_UT_DM=y
> > +# CONFIG_NET is not set
> >
> > Regards,
> > Simon
