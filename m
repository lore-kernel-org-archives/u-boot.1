Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E0FC021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB8C80FB9;
	Tue, 25 Feb 2025 22:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oWiSbKWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA9C80FC8; Tue, 25 Feb 2025 22:27:31 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144BA80FB9
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so1046986066b.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740518848; x=1741123648; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yo63yAxtVDkSJnTej4VhQbZfBmlCuQJhX4f3833RQ8=;
 b=oWiSbKWDXaDRtqFIzyy5JZdLZcgfM2Dt2xfyeTOveI1nyHFr2HtDtyecu6Uk0ftaIz
 hZszixz56ohnjhABWL4z5GKLF68xxTcgtRB3TIE2fN4iIh7mqXjoJtZGOhzAdQ1vhshA
 +qb+kcgpcHLx1ORg0EHJJpNXGtXIk+E5rA3Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740518848; x=1741123648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yo63yAxtVDkSJnTej4VhQbZfBmlCuQJhX4f3833RQ8=;
 b=JYAN6XP/nTd5ZqUzzgpmoDKQvntHF3sVlb6dxV0tUh4aSCp0AB/Jro9kcVCiC/ZeV4
 DMF2kBMt/UzaTTpSx3Vy5g52Tj28/nsLSHIKH7JMQhJY68VRRZ64MvQf/xl+K5x6xcAN
 2aeZsWdJiuDiFw6faeQsd8eoOGK98BBYPELTPv9Or/fj9sfEm/p7al6efQ2j/zzSYg2f
 DMmoj9o1475r6loS8Hb0lvEKK4OwAdZa//tGOzxK94AnKHSq4RGASzpPo6U7s3bbp3Je
 Hc0eK5Ib2NIYzkgCXhidc0H6xcHh7Y83WW1BBWJ0a1ZWwp5C1xJH4holoAP12exefTH1
 b2jg==
X-Gm-Message-State: AOJu0Yz5m3KxXKUrcHd7OQ3gT6bHm8f++nY9MvdHO839asFt9uC8V/UP
 xshprgmlb8CtSucUf3SPG+ssqn1vq5D53+HKY7zBDzZp093JltgxbVR8yEalfNUq5ADdcHVVNu6
 lSYex+yL1V4Q74+hwswnRFP/GCXCn1rd8PTwq
X-Gm-Gg: ASbGnctHx95HctrGn381E0HtFTSzviw75kj9jl2UUtxCF6yr0Yl2i7XCkYw/y7I1NRR
 c/QSvhSRgGrH0Pd2//pxhV2T9GWpijvznH3NtU4bKeWcCOaCagqec9FzH/6DCq/9exD3VnttB4G
 coB/Oz8U3m
X-Google-Smtp-Source: AGHT+IEwet2eoEUt+EjD9c+fH0NqGImTDq9xsNT8gkEgMu8GSnlj2dFslWJXn9iC6f3HwdohGwhUrKkPUBmfloZS1vo=
X-Received: by 2002:a17:907:868a:b0:ab7:d179:2496 with SMTP id
 a640c23a62f3a-abed0c77de1mr558808066b.6.1740518848401; Tue, 25 Feb 2025
 13:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20250212091820.213895-1-m-shah@ti.com>
 <20250212091820.213895-2-m-shah@ti.com>
 <CAFLszTjCT7ubR=k0Gd5AAt+m9cH7qgQzT1S8z5LCVHSrgAnCow@mail.gmail.com>
 <dd69f417-c6ef-4595-8d60-56f9dc6e2b8c@ti.com>
In-Reply-To: <dd69f417-c6ef-4595-8d60-56f9dc6e2b8c@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 14:27:15 -0700
X-Gm-Features: AQ5f1JoVJxlV2JmkoGJgbFrraRKGYUbkBgP44lNqzNBpLrrE5CBMS4Sc86CkfWg
Message-ID: <CAFLszTjS3SoyGzaFsdbjTxP7rUfc71roNzvtgixPaJ6G2YZ7ww@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 1/2 v1] arch: arm: Kconfig: Add config
 to use subnode's bootph property for binding drivers
To: Moteen Shah <m-shah@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, m-chawdhry@ti.com, 
 n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
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

Hi Moteen,

On Thu, 13 Feb 2025 at 22:05, Moteen Shah <m-shah@ti.com> wrote:
>
>
> On 13/02/25 19:31, Simon Glass wrote:
> > Hi Moteen, On Wed, 12 Feb 2025 at 02:=E2=80=8A18, Moteen Shah
> > <m-shah@=E2=80=8Ati.=E2=80=8Acom> wrote: > > Add a new config when set =
will traverse
> > through all the subnodes of > a given node scanning for bootph-all
> > property and propagate it to > all of
> > ZjQcmQRYFpfptBannerStart
> > This message was sent from outside of Texas Instruments.
> > Do not click links or open attachments unless you recognize the source
> > of this email and know the content is safe.
> > Report Suspicious
> > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!tDdkczlA_gRXoUgIv=
DspkOY_N58UTgTbK8UGS8zfYNsuu6kFHonhYC9p6QDyxO6fEM-jwDoJbz7g9IYZuow6CShwWbGJ=
RkE39jUS3OLaz9G1-q9eGLvRc6M$>
> >
> > ZjQcmQRYFpfptBannerEnd
> > Hi Moteen,
> >
> > On Wed, 12 Feb 2025 at 02:18, Moteen Shah <m-shah@ti.com> wrote:
> > >
> > > Add a new config when set will traverse through all the subnodes of
> > > a given node scanning for bootph-all property and propagate it to
> > > all of its parent node up the hierarchy.
> > >
> > > Signed-off-by: Moteen Shah <m-shah@ti.com>
> > > ---
> > >  arch/arm/Kconfig | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 314916527c9..51fc952b0db 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -805,6 +805,7 @@ config ARCH_K3
> > >         select FIT
> > >         select REGEX
> > >         select FIT_SIGNATURE if ARM64
> > > +       imply BIND_FROM_CHILD_BOOTPH
> > >         imply TI_SECURE_DEVICE
> > >
> > >  config ARCH_OMAP2PLUS
> > > @@ -2232,6 +2233,16 @@ config SYS_KWD_CONFIG
> > >           Path within the source directory to the kwbimage.cfg file t=
o use
> > >           when packaging the U-Boot image for use.
> > >
> > > +
> > > +config BIND_FROM_CHILD_BOOTPH
> >
> > How about DM_F_STRICT_BOOTPH ?  or DM_F_CHILD_BOOTPH ?
>
> Yes, this should be more descriptive, will include this in v2.
>
> >
> > It indicates that it relates to driver model before relocation.
> >
> > This behaviour is actually required by the schema. I agree it should
> > be optional, but only due to its performance issues.
> >
> > A Binman solution would not have any performance issues.
>
> Will explore on this more, if you have some more pointers on this,
> then do let me know.

As you requested on the call today:

PrepareImagesAndDtbs() fiddles with the dtb so you can add some code there.

My suggestion is to insert something after this chunk:

    # Get the device tree ready by compiling it and copying the compiled
    # output into a file in our output directly. Then scan it for use
    # in binman.
    dtb_fname =3D fdt_util.EnsureCompiled(dtb_fname)
    fname =3D tools.get_output_filename('u-boot.dtb.out')

here you can read in the file and modify it, e.g.:

dtb =3D fdt.FdtScan(dtb_fname)
add_bootph_nodes(dtb)
dtb.Sync(True)
tools.write_file(fname, dtb.GetContents())

    tools.write_file(fname, tools.read_file(dtb_fname))   # delete this lin=
e
    dtb =3D fdt.FdtScan(fname)

It might need some tweaking. It will need some sort of test, see
ftest.py for that. As an example, testCompressSectionSize() reads back
the dtb to check it., so you can follow that You need to create a .dts
file in tools/binman/test, containing nodes other than 'binman'.

>
>
> Regards,
> Moteen
>
> >
> > > +       bool "Bind drivers from bootph* in subnode"
> > > +       depends on ARCH_K3
> > > +       help
> > > +        This config must be set to bind drivers in pre reloc stage w=
hose
> > > +        compatible parent nodes are implicitly declared to be bound =
to
> > > +        their respective drivers by having bootph* property in one o=
f
> > > +        their subnodes.
> > > +
> > >  source "arch/arm/mach-apple/Kconfig"
> > >
> > >  source "arch/arm/mach-aspeed/Kconfig"
> > > --
> > > 2.34.1
> > >
> >
> > Regards,
> > Simon

Regards,
Simon
