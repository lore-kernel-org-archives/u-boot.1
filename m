Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF21C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 16:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8B68720B;
	Sat, 28 Oct 2023 18:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q2tECyc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA288726C; Sat, 28 Oct 2023 18:46:28 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7208871C4
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 18:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77891f362cfso251076785a.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698511583; x=1699116383; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22XGan4HKJtU6FcQC1HdHff0Q2Vo7FU6YgwNH6XLufw=;
 b=Q2tECyc2meCalFyxXcYZTSTZo7gbhvWhFLBWIvOlci7Nukse3rkZKu27o1wk0gqq1C
 1TmMA+y1+qL/PmoSTDgoDd/SEsG/kj/nwdRxpjVP3Jii+1WYG+pUC8f9Rrs8iFJqtvkM
 MTpf5Yjo0h3lzvp+XOs2Q6tvhddpFuSc7GDKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698511583; x=1699116383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22XGan4HKJtU6FcQC1HdHff0Q2Vo7FU6YgwNH6XLufw=;
 b=JClDTAH3DZ9X7UUweczNHn+lJ3+5/Tv4jVGwxj2/U36L9DIhO0F+o4U+vGPSsHoBpQ
 hHBy1UCUH/n6JGCfDRAV+9Dh5iHNFGYjAFiOlcyTJDlO+p8xR251VMiYaDzThtzqlE9p
 zxt6sVtsy/mZuZni1Ry0nZlJX37B5nz6ccSgiHUDiy893jrOWG2WYoMNHz6KwYN+3gQG
 /F9oqrtZl6ifR6XLZ2uPho2RDNulsc6ZZ3+KrZ0uM6IZp8I6X4kOuceNxu3uVTyhOIEd
 v713peqbB8YHOLJhB/5Y5SraKctIxuOLJUmuQM8fYWAumG6tUXkmJU9d1kPqIiuCKh61
 ZIBQ==
X-Gm-Message-State: AOJu0YwcfJX5WtSiPgx53wdXPh4gmFgOg0I9nRbKcHRu5seUmesoudzi
 nfvGxssl+Wn2qT1aVwOoUxH6uoXUv7hwwFezn+hYNA==
X-Google-Smtp-Source: AGHT+IH3Pt+k7jTL8TTDfWmz7Fcz3LXohWw4MApDqxDc7JZby7kT5wcsfygwJ20CX9fAK4x1A6xUCPUDD3JGmwMTf+c=
X-Received: by 2002:a05:620a:471e:b0:775:c2a1:1821 with SMTP id
 bs30-20020a05620a471e00b00775c2a11821mr10997395qkb.26.1698511583333; Sat, 28
 Oct 2023 09:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231026072628.4115527-1-sjg@chromium.org>
 <20231026072628.4115527-4-sjg@chromium.org>
 <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
In-Reply-To: <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Oct 2023 05:46:12 +1300
Message-ID: <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Masahiro,

On Fri, Oct 27, 2023 at 2:25=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Oct 26, 2023 at 4:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Add a script which produces a Flat Image Tree (FIT), a single file
> > containing the built kernel and associated devicetree files.
> > Compression defaults to gzip which gives a good balance of size and
> > performance.
> >
> > The files compress from about 85MB to 24MB using this approach.
> >
> > The FIT can be used by bootloaders which support it, such as U-Boot
> > and Linuxboot. It permits automatic selection of the correct
> > devicetree, matching the compatible string of the running board with
> > the closest compatible string in the FIT. There is no need for
> > filenames or other workarounds.
> >
> > Add a 'make image.fit' build target for arm64, as well.
> >
> > The FIT can be examined using 'dumpimage -l'.
> >
> > This features requires pylibfdt (use 'pip install libfdt'). It also
> > requires compression utilities for the algorithm being used. Supported
> > compression options are the same as the Image.xxx files. For now there
> > is no way to change the compression other than by editing the rule for
> > $(obj)/image.fit
> >
> > While FIT supports a ramdisk / initrd, no attempt is made to support
> > this here, since it must be built separately from the Linux build.
>
>
> Is this useful?
> For arm64, initrd is likely used.

It depends on your kernel configuration, though. I have found it
convenient to enable the drivers necessary to boot.

>
> FIT should be created in unbrellea projects
> such as OpenEmbedded,  Buildroot, etc.

Sure, but that is a separate issue, isn't it? We already support
various boot targets in arm64 but not one that includes the DTs, so
far as I can see. The old arm 'uImage' target is pretty out-of-date
now.

>
>
>
>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  MAINTAINERS              |   7 +
> >  arch/arm64/Makefile      |   3 +-
> >  arch/arm64/boot/Makefile |   8 +-
> >  scripts/Makefile.lib     |  16 ++-
> >  scripts/make_fit.py      | 285 +++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 315 insertions(+), 4 deletions(-)
> >  create mode 100755 scripts/make_fit.py
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2d13bbd69adb..d6955ebc3c24 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1575,6 +1575,13 @@ F:       Documentation/process/maintainer-soc*.r=
st
> >  F:     arch/arm/boot/dts/Makefile
> >  F:     arch/arm64/boot/dts/Makefile
> >
> > +ARM64 FIT SUPPORT
> > +M:     Simon Glass <sjg@chromium.org>
> > +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> > +S:     Maintained
> > +F:     arch/arm64/boot/Makefile
> > +F:     scripts/make_fit.py
> > +
> >  ARM ARCHITECTED TIMER DRIVER
> >  M:     Mark Rutland <mark.rutland@arm.com>
> >  M:     Marc Zyngier <maz@kernel.org>
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 7b77b63e978f..d8290dcab6b6 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/fir=
mware/efi/libstub/lib.a
> >  # Default target when executing plain make
> >  boot           :=3D arch/arm64/boot
> >
> > -BOOT_TARGETS   :=3D Image.gz vmlinuz.efi
> > +BOOT_TARGETS   :=3D Image.gz vmlinuz.efi image.fit
> >
> >  PHONY +=3D $(BOOT_TARGETS)
> >
> > @@ -215,6 +215,7 @@ virtconfig:
> >  define archhelp
> >    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/=
Image.gz)'
> >    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boo=
t/Image)'
> > +$(if $(CONFIG_EFI_ZBOOT),,echo  '  image.fit     - Flat Image Tree (ar=
ch/$(ARCH)/boot/image.fit)')
> >    echo  '  install       - Install uncompressed kernel'
> >    echo  '  zinstall      - Install compressed kernel'
> >    echo  '                  Install using (your) ~/bin/installkernel or=
'
> > diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> > index 1761f5972443..a6e5b20b22bd 100644
> > --- a/arch/arm64/boot/Makefile
> > +++ b/arch/arm64/boot/Makefile
> > @@ -16,7 +16,8 @@
> >
> >  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .co=
mment -S
> >
> > -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo I=
mage.zst
> > +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
> > +       Image.zst image.fit
> >
> >  $(obj)/Image: vmlinux FORCE
> >         $(call if_changed,objcopy)
> > @@ -39,6 +40,11 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
> >  $(obj)/Image.zst: $(obj)/Image FORCE
> >         $(call if_changed,zstd)
> >
> > +ifndef CONFIG_EFI_ZBOOT
> > +$(obj)/image.fit: $(obj)/Image $(obj)/dts FORCE
>
>
>
> This is wrong.
>
> $(obj)/dts is a directory.
>
> There is no point for comparing timestamps
> between $(obj)/image.fit and $(obj)/dts.
>
> Updates of *.dtb do not result in the
> update of the $(obj)/dts timestamp.
>
>
> if_changed never works correctly.

Yes I am aware that this doesn't actually deal with changes. I'll see
if I can figure out another way.

>
>
>
>
>
>
>
>
> > +       $(call if_changed,fit,gzip)
> > +endif
> > +
> >  EFI_ZBOOT_PAYLOAD      :=3D Image
> >  EFI_ZBOOT_BFD_TARGET   :=3D elf64-littleaarch64
> >  EFI_ZBOOT_MACH_TYPE    :=3D ARM64
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 68d0134bdbf9..4e4364ad641a 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -487,14 +487,26 @@ UIMAGE_OPTS-y ?=3D
> >  UIMAGE_TYPE ?=3D kernel
> >  UIMAGE_LOADADDR ?=3D arch_must_set_this
> >  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> > -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> > +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
>
>
> Unneeded noise change.

I'll move that to a separate patch. We don't want the single quotes in the =
name.

Regards,
Simon
