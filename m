Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B60CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 23:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36325877E6;
	Mon, 23 Oct 2023 01:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tDcNXQUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1177877E6; Mon, 23 Oct 2023 01:53:20 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AE02877E1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 01:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a90d6ab962so16972797b3.2
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 16:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698018797; x=1698623597; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4+K14uvznusPqhvORs7GGMCwdcrAlwxxwM1NlUltR+4=;
 b=tDcNXQUb7Zf/K2zIIVHCaFnRDWnY4snxDnez5pVKYojURkw5aMd/dReCBfVRV001ZS
 Op6v0QflkyPgQl/+r8nKTWlQmHUMXyb5mHhuMBmT/lkObLOcAL4uxAzd0evKOELF4sF0
 Y5jfQMKRlnZa+mHR77e0fb7hUGZyGVMH5xOXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698018797; x=1698623597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+K14uvznusPqhvORs7GGMCwdcrAlwxxwM1NlUltR+4=;
 b=d1sifqtKNp+i99P6R3qSkOVl6QY+0C/OsuBMnh7KapcWMKND7hH0sS/Lm1ppgl3TzQ
 d7Jg643IblYq2LtjT8w/IsRBACMAGhqu66a0AIn8fA3731ZksEZOYRKDuBwGDEVc1Xuj
 qkl5mBoxJHy2XGxPNAN/LVE4iRgiROLRTumO2NsEr9EOmvxES8hjVnED9/p0qADtsIEA
 5mVb5wucDBaFwB2u8zp9XpMC7msydhSjuv5EMSUyfUT/nvndJmaiiGR1yFgpUl9rxeMT
 aze/RVdgM0c4JZA/qAzcNOoPrSSqKwoXoWsVuAMW0sFIFJQ+RdnjbnqNtAe4TeOeRa6Q
 t+Lw==
X-Gm-Message-State: AOJu0YzcHN7JhIEZqpT5M2e9hjJpbso6l/RjU9R7Tx74GOgdl5FbHErE
 a6IRh8G8K/JgnWIFD8AEEO6YKQ==
X-Google-Smtp-Source: AGHT+IHCh9XK4VMkqxgEkcm2q0Cy7kQana4ZEE7Zoef3YU7qRxNP8J/DnnavC21tE4aptJaRRRtUSA==
X-Received: by 2002:a05:690c:d8f:b0:5a8:2cfc:e3eb with SMTP id
 da15-20020a05690c0d8f00b005a82cfce3ebmr10039055ywb.40.1698018796995; 
 Sun, 22 Oct 2023 16:53:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a0deb04000000b0059f5d686479sm2686674ywe.16.2023.10.22.16.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:53:15 -0700 (PDT)
Date: Sun, 22 Oct 2023 19:53:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231022235313.GF496310@bill-the-cat>
References: <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
 <20231022142922.GA496310@bill-the-cat>
 <20231022145857.GB496310@bill-the-cat>
 <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
 <3b87bf3f-a909-4020-8d67-ace84c7ca90c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hQRRftxPAoDNRwX1"
Content-Disposition: inline
In-Reply-To: <3b87bf3f-a909-4020-8d67-ace84c7ca90c@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--hQRRftxPAoDNRwX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:55:34AM +0200, Heinrich Schuchardt wrote:
> On 10/22/23 23:55, Simon Glass wrote:
> > Hi,
> >=20
> > On Sun, 22 Oct 2023 at 07:59, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > On Sun, Oct 22, 2023 at 10:29:22AM -0400, Tom Rini wrote:
> > > > On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt wrote:
> > > > > On 10/21/23 20:26, Tom Rini wrote:
> > > > > > On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> > > > > > > <takahiro.akashi@linaro.org> wrote:
> > > > > > > >=20
> > > > > > > > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> > > > > > > > > Hi Heinrich,
> > > > > > > > >=20
> > > > > > > > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron=
=2Eglpk@gmx.de> wrote:
> > > > > > > > > >=20
> > > > > > > > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > > > > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass=
 wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > > Since efi_device_path.c calls eth_get_dev() and ass=
umes that Ethernet is
> > > > > > > > > > > > available, add it as an explicit dependency.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >=20
> > > > > > > > > > > > (no changes since v2)
> > > > > > > > > > > >=20
> > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > - Add new patch to update EFI_LOADER to depend on D=
M_ETH
> > > > > > > > > > > >=20
> > > > > > > > > > > >     lib/efi_loader/Kconfig | 1 +
> > > > > > > > > > > >     1 file changed, 1 insertion(+)
> > > > > > > > > > > >=20
> > > > > > > > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loade=
r/Kconfig
> > > > > > > > > > > > index 13cad6342c36..fca4b3eef270 100644
> > > > > > > > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > > > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > > > > > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > > > > > > > > >        # We need EFI_STUB_32BIT to be set on x86_32=
 with EFI_STUB
> > > > > > > > > > > >        depends on !EFI_STUB || !X86 || X86_64 || EF=
I_STUB_32BIT
> > > > > > > > > > > >        depends on BLK
> > > > > > > > > > > > +    depends on DM_ETH
> > > > > > > > > > > >        depends on !EFI_APP
> > > > > > > > > > > >        default y if !ARM || SYS_CPU =3D armv7 || SY=
S_CPU =3D armv8
> > > > > > > > > > > >        select CHARSET
> > > > > > > > > > >=20
> > > > > > > > > > > Does this work for you Heinrich, or do you want to cl=
arify the
> > > > > > > > > > > dependencies (and re-organize the code as needed) aro=
und networking?
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > We should be able to boot via EFI on devices without U-=
Boot network support.
> > > > > > > > > >=20
> > > > > > > > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid i=
nvoking
> > > > > > > > > > eth_get_dev() if there is no network. CONFIG_NETDEVICES=
=3Dy selects
> > > > > > > > > > CONFIG_DM_ETH.
> > > > > > > > > >=20
> > > > > > > > > > Why is this not sufficient?
> > > > > > > > > > Is there a configuration that does not build?
> > > > > > > > >=20
> > > > > > > > > The point of this series is to disable CMDLINE and fix up=
 what breaks.
> > > > > > > > >=20
> > > > > > > > > In this case we have some sort of breakage...perhaps Tom =
has already
> > > > > > > > > found it, but otherwise could you take a look?
> > > > > > > > >=20
> > > > > > > > > We should be able to disable NET and LTO in sandbox and s=
till build.
> > > > > > > > > But this fails at present[1]. You can try it on -master
> > > > > > > >=20
> > > > > > > > Obviously, it would be necessary to enclose efi_dp_from_eth=
()
> > > > > > > > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > > > > > > > Then, we could drop "depends on DM_ETH".
> > > > > > >=20
> > > > > > > Strange that it only happens on the non-LTO board, though?
> > > > > >=20
> > > > > > There's two issues. The first of which is that I think you need=
 to
> > > > > > re-check your error exactly? With my series, and LTO also disab=
led the
> > > > > > problem is a call to efi_get_image_parameters() as that's defin=
ed in
> > > > > > cmd/bootefi.c, but also only used with cmdline invocations. So =
we can
> > > > > > fix that CMDLINE=3Dn && LTO=3Dn case with a IS_ENABLED(CONFIG_C=
MDLINE)
> > > > > > around that, and then discard efi_dp_from_name() entirely.
> > > > > >=20
> > > > > > The second issue is that with LTO we more completely find the c=
ases
> > > > > > where if x() calls y() and y() is undefined but nothing calls x=
() we can
> > > > > > just discard x() and not care that y() is undefined.
> > > > > >=20
> > > > >=20
> > > > > I will send a patch for function efi_dp_from_eth().
> > > >=20
> > > > There's no problem with efi_dp_from_eth as far as I can tell.
> > > >=20
> > > > > @Simon
> > > > >=20
> > > > > One thing that I don't understand is why we don't let the linker
> > > > > eliminate the unused functions on the sandbox.
> > > > >=20
> > > > > On other architectures we put each function into a separate text =
section
> > > > > and let the linker eliminate the unused text sections:
> > > > >=20
> > > > > arch/riscv/config.mk:29:
> > > > > PLATFORM_RELFLAGS       +=3D -fno-common -ffunction-sections -fda=
ta-sections
> > > > > LDFLAGS_u-boot          +=3D --gc-sections -static -pie
> > > > >=20
> > > > > Shouldn't we keep the sandbox close to what other architectures d=
o?
> > > >=20
> > > > Oh my, I didn't realize that sandbox was missing the garbage collec=
tion
> > > > stuff.  Yes, that needs to be fixed first, then we can see what's n=
ext
> > > > to change, as there are some issues (my series first fixed CMDLINE=
=3Dn on
> > > > qemu_arm64).
> > >=20
> > > My super quick pass at enabling
> > > function-sections/data-sections/gc-sections shows there's nothing
> > > further needed for CMDLINE=3Dn and LTO=3Dn on sandbox, not even the p=
art I
> > > was looking at before.
> >=20
> > I am not sure about the original reason, but sandbox probably
> > pre-dates wholesale enabling of gc-sections (I haven't looked). There
> > is also the issue of whether the host toolchain supports it. Sandbox
> > is supposed to run on a variety of OS types.
> >=20
> > I am also not sure of the point ot it...since it is normally pretty
> > easy to use Kconfig to control features.
> >=20
> > At least for me 'u-boot -D' doesn't work with Heinrich's patch. Do we
> > really need to make this change? It will rapidly devolve to the point
> > that coming back would be extremely painful.
>=20
> It just shows where the code is not clean.
>=20
> Linker generated lists referenced by the corresponding macros are
> compiled in (as shows up in u-boot.map). But you have decided not to use
> those macros to access the sandbox command line options. Now they are
> removed as unreferenced garbage.
>=20
> Can't we use the linker generated list macros instead of duplicating code?
>=20
> * define SANDBOX_CMDLINE_OPT via ll_entry_declare().
> * replace ll_entry_count() instead of __u_boot_sandbox_option_count()
> * use ll_start(), ll_end() for iterating

Oh, it comes down to something like this?  I don't recall if we had
__used the first time we put this on sandbox, but we do now and we use
it for cases where LTO thinks it knows best.  We should be able to do
that too for sandbox.

--=20
Tom

--hQRRftxPAoDNRwX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU1tekACgkQFHw5/5Y0
tyyfMQwAqS6dDRc/zPsbroKllGitrNz3CCQQG5DaIxdvel8C6NN27tvJs+aD8rkg
CjMpwcULMYlv5MB4io849OgpkkfvFfReqfZ3AQOjoRid2G+LFQz7le+c0d6IQpAA
Eym3YqzpZ5LKOOzZQg5EIgs8pdRy5oBh+Au3ALLvZ0THtkxoHfxs9D9c30R2fKqQ
4xEsnxjc4OvcvqQ5mojqtTSthVyy9ECNwxrvBow2w0PLrz/nNak8BsrWGywJB5LC
fHpgxhuJSL3PSPHCYzp/CIw3e+vx1d0HhSZ2i755o1HKWzrvvtZTm002lz9BeQ/j
Ha803unzhDYMLyp0VybbmOmzUegyEfoEfkLg/5Z6DyDl52ipgp7Y6qGHvIM+283I
qU1bsD7AS0332tWPBoXoQEOm08AlcnRW3TjrvVwUHKTdiXGgL/8spcxxVFNnP6Yx
xOCTwrNJMUAVJl+Sn0Mz9K8idy5p7KuxcKj5WnvKdugqeJgyeufuNAdxevnFzvZ4
98j3iTeT
=V34u
-----END PGP SIGNATURE-----

--hQRRftxPAoDNRwX1--
