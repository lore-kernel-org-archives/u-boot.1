Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C488CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 14:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F6787765;
	Sun, 22 Oct 2023 16:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BNvXakCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB97087766; Sun, 22 Oct 2023 16:59:05 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474768773E
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 16:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a8ada42c2aso24755707b3.3
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697986740; x=1698591540; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8SE6NN5Ut9v/QOS1/SRFGmTwurXBUbw8Vi1SxU3kH0M=;
 b=BNvXakCG0Fs4vO8JI+FJBMm0W7hgZ+Wo174ZxhOv3l5One0lOAc8ccHDNHzw/97hIj
 jV9cXpYOHUMLXdGXcFbRy2pAkELCLx7C/qV5i5Qi2vyve/iSZnO6Vvim5A99pek6JLNJ
 0OHuCIpTWh/nhvcJSciLWLdf+uYrPZ4mykFq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697986740; x=1698591540;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SE6NN5Ut9v/QOS1/SRFGmTwurXBUbw8Vi1SxU3kH0M=;
 b=HctN4zsmNgxoxUSMHG71EXhDKM+qnUtgQPSwp1Loz1fEfuJAEp/N/THQuimEMo9yx3
 xiVb4MTcda+uTId8XVDXWtbjPafovNJRKwkXFukRFZwgRFE3WI5E9CFF2wXNWblyHt+k
 0PqRoV0ShKlNQmwy/07Bu+nkUdt8C84+gXSOIhAUpyR9r+085SVuXr/IfSfvFKFKN6jK
 +1n69weyxMTlhRq79XXWxFx5w+1BCR8ziXctCeinD4mLuoNJBzSUVHh28Zqr6PpPxZBx
 qB44AJ6bJSkSj98Q61+MsFMpk4u2dF97aAebDgubxazkdkKOQTNk/ELungmQ1Dr5Lty+
 cVdw==
X-Gm-Message-State: AOJu0YylAdhErKzV6tKfH9709gUrvOPu85GemBvgkaDohrPLTTHvdHuW
 OMnY/MllWFBPeyV6tYMjnt0Qzw==
X-Google-Smtp-Source: AGHT+IHP9k6M5E8cL0FFazJeid2SdQSWThO+FIWRlBAycYFyb0CrKzACigOGcgXozKH6R/+WYn+NBQ==
X-Received: by 2002:a81:4f57:0:b0:5a7:b8d4:60e1 with SMTP id
 d84-20020a814f57000000b005a7b8d460e1mr7299636ywb.9.1697986740583; 
 Sun, 22 Oct 2023 07:59:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d02f-b9d9-0a79-793c.res6.spectrum.com.
 [2603:6081:7b00:6400:d02f:b9d9:a79:793c])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a815f44000000b0059ae483b89dsm2354895ywb.50.2023.10.22.07.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 07:58:59 -0700 (PDT)
Date: Sun, 22 Oct 2023 10:58:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231022145857.GB496310@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
 <20231022142922.GA496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IEm7tty7L1QvT3o2"
Content-Disposition: inline
In-Reply-To: <20231022142922.GA496310@bill-the-cat>
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


--IEm7tty7L1QvT3o2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 10:29:22AM -0400, Tom Rini wrote:
> On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt wrote:
> > On 10/21/23 20:26, Tom Rini wrote:
> > > On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
> > > > Hi,
> > > >=20
> > > > On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> > > > <takahiro.akashi@linaro.org> wrote:
> > > > >=20
> > > > > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> > > > > > Hi Heinrich,
> > > > > >=20
> > > > > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> > > > > > >=20
> > > > > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > > > > > > >=20
> > > > > > > > > Since efi_device_path.c calls eth_get_dev() and assumes t=
hat Ethernet is
> > > > > > > > > available, add it as an explicit dependency.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >=20
> > > > > > > > > (no changes since v2)
> > > > > > > > >=20
> > > > > > > > > Changes in v2:
> > > > > > > > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > > > > > > >=20
> > > > > > > > >    lib/efi_loader/Kconfig | 1 +
> > > > > > > > >    1 file changed, 1 insertion(+)
> > > > > > > > >=20
> > > > > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kcon=
fig
> > > > > > > > > index 13cad6342c36..fca4b3eef270 100644
> > > > > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > > > > > >       # We need EFI_STUB_32BIT to be set on x86_32 with E=
FI_STUB
> > > > > > > > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_=
32BIT
> > > > > > > > >       depends on BLK
> > > > > > > > > +    depends on DM_ETH
> > > > > > > > >       depends on !EFI_APP
> > > > > > > > >       default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =
=3D armv8
> > > > > > > > >       select CHARSET
> > > > > > > >=20
> > > > > > > > Does this work for you Heinrich, or do you want to clarify =
the
> > > > > > > > dependencies (and re-organize the code as needed) around ne=
tworking?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > We should be able to boot via EFI on devices without U-Boot n=
etwork support.
> > > > > > >=20
> > > > > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
> > > > > > > eth_get_dev() if there is no network. CONFIG_NETDEVICES=3Dy s=
elects
> > > > > > > CONFIG_DM_ETH.
> > > > > > >=20
> > > > > > > Why is this not sufficient?
> > > > > > > Is there a configuration that does not build?
> > > > > >=20
> > > > > > The point of this series is to disable CMDLINE and fix up what =
breaks.
> > > > > >=20
> > > > > > In this case we have some sort of breakage...perhaps Tom has al=
ready
> > > > > > found it, but otherwise could you take a look?
> > > > > >=20
> > > > > > We should be able to disable NET and LTO in sandbox and still b=
uild.
> > > > > > But this fails at present[1]. You can try it on -master
> > > > >=20
> > > > > Obviously, it would be necessary to enclose efi_dp_from_eth()
> > > > > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > > > > Then, we could drop "depends on DM_ETH".
> > > >=20
> > > > Strange that it only happens on the non-LTO board, though?
> > >=20
> > > There's two issues. The first of which is that I think you need to
> > > re-check your error exactly? With my series, and LTO also disabled the
> > > problem is a call to efi_get_image_parameters() as that's defined in
> > > cmd/bootefi.c, but also only used with cmdline invocations. So we can
> > > fix that CMDLINE=3Dn && LTO=3Dn case with a IS_ENABLED(CONFIG_CMDLINE)
> > > around that, and then discard efi_dp_from_name() entirely.
> > >=20
> > > The second issue is that with LTO we more completely find the cases
> > > where if x() calls y() and y() is undefined but nothing calls x() we =
can
> > > just discard x() and not care that y() is undefined.
> > >=20
> >=20
> > I will send a patch for function efi_dp_from_eth().
>=20
> There's no problem with efi_dp_from_eth as far as I can tell.
>=20
> > @Simon
> >=20
> > One thing that I don't understand is why we don't let the linker
> > eliminate the unused functions on the sandbox.
> >=20
> > On other architectures we put each function into a separate text section
> > and let the linker eliminate the unused text sections:
> >=20
> > arch/riscv/config.mk:29:
> > PLATFORM_RELFLAGS       +=3D -fno-common -ffunction-sections -fdata-sec=
tions
> > LDFLAGS_u-boot          +=3D --gc-sections -static -pie
> >=20
> > Shouldn't we keep the sandbox close to what other architectures do?
>=20
> Oh my, I didn't realize that sandbox was missing the garbage collection
> stuff.  Yes, that needs to be fixed first, then we can see what's next
> to change, as there are some issues (my series first fixed CMDLINE=3Dn on
> qemu_arm64).

My super quick pass at enabling
function-sections/data-sections/gc-sections shows there's nothing
further needed for CMDLINE=3Dn and LTO=3Dn on sandbox, not even the part I
was looking at before.

--=20
Tom

--IEm7tty7L1QvT3o2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU1OKsACgkQFHw5/5Y0
tyyfSAwArnHH52zQiqWGaxSiPqfd0cgvD6r4xz/V4CvKmWZ80DsGwsDy8/bO0sCJ
7XegNGOYHNp+TBvmFfVesBerudWVFIaT9YDP5qNVaoTv5aHkic6ADAs55aFf6Hu3
SLK2N4yuzg8rObo1cOdO1ebi2SdrN95XpbQm4z+3177Isi3lW9dYfwBPHUXDLlne
jmWJZbKmM1ddmmIqm5V0QNYrEycCxBQzgaHK25Zp2TzdOF5A/wqn15Ou+wyo7AXk
r3GClJGIlZZy3EL6A2Y0LUU5Vd3xwRh7EXBeiVIlNmFO77g8vmzNo33OfY1ilbfW
b3pR6KnpK+IjoWV3ReZOhP/9jl+L5uwW+dfvLeumdn+WWV5qQuTioUfsI97/sjDX
fb8S1+0VWHLOTn6rZVYxI+dST4kcagjc5fRdHKK643dCUB+Zi7k528pD5y8BAVaG
Ph/GMQb5aqtUD7V+ui5G3b91swMRrfBCVo7zNziyjAKDINSgFwebX8NeKYcLrKKB
11LLQzdP
=oA5h
-----END PGP SIGNATURE-----

--IEm7tty7L1QvT3o2--
