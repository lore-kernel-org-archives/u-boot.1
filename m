Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA5BC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 816F1877FD;
	Tue,  9 Jan 2024 15:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dkQvEQA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2F3877FD; Tue,  9 Jan 2024 15:33:58 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21B2877D9
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bbd6e3795eso2724213b6e.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704810833; x=1705415633; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KndaEanNVFQPZ7Lw6pt5cv26Ibm+dtDXNTXdZgR28WQ=;
 b=dkQvEQA7yl7wdEX0/xmWwG4UgxUFMOhDZFFthmnvPNPX7lOTlTOBDrqFCGbkAfgyM1
 W1pfsJc9QlsvQEV9gbxVOVrVD4GJZ8kgw/VXpg2hb+R4A7fU/BKMkdJIAdE6m/tstIkY
 L5w7UN6d1+WonmiMTlJF4+dMqt6Z/oOQV32vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704810833; x=1705415633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KndaEanNVFQPZ7Lw6pt5cv26Ibm+dtDXNTXdZgR28WQ=;
 b=baE1M55akIc72OrpwlJqBlgg+17qG1CPToaVyWzWJvsM3V4cjQOdHZ/Yabbfi9qp9A
 yx5boAqWe0axul3V6S49TXI8iy6lRnUKG7Qyr6hLYm2BECMVHFPdYDl9pylsfhSgrG8Y
 jG32NsNfrWFsd2FlBLmQOxGfZtd4APP0Wz7KNwxzqo45qMvoFPFWtlHH6vjO8J/rX95q
 1ne3JhNeLHL0OSz7QSmwDHR51tjQTpdm8ASZRffj4VoXAWZ9t+AMvjfCvcG9FwLUlHJA
 WwcCWlRx9kDM/8VnGaHkSEjI73icbrZdAmRPZgr+GF7kZKaFHIRR9w7iZkU8vC4GLoBz
 QS5A==
X-Gm-Message-State: AOJu0YySMt7/SvCg29dHDmJwUgunZnnpMeX1JARym7gFWX/DUapXoZL4
 8XPTv55dSoYtLFco4D4iJTGidJpv5INESg==
X-Google-Smtp-Source: AGHT+IGuTLpONWsP7VKq5UjGPl/Es4KMJFkKp6ldUZWiWuDm0uOjRn5jMKDhiVkKUbu7uGjUSn0xCg==
X-Received: by 2002:a05:6808:318a:b0:3ba:8e3:f4f4 with SMTP id
 cd10-20020a056808318a00b003ba08e3f4f4mr7530220oib.107.1704810832929; 
 Tue, 09 Jan 2024 06:33:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 eh14-20020a056214186e00b0068112217ecasm833392qvb.117.2024.01.09.06.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 06:33:52 -0800 (PST)
Date: Tue, 9 Jan 2024 09:33:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@fb.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20240109143349.GR1610741@bill-the-cat>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231213121353.GA31326@willie-the-truck>
 <CAFLszTjfmSx1YMqzb2TsQf7sP4KrcQB=X7DY_HxRQp0J5HAppQ@mail.gmail.com>
 <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0FoRISOaCA+A7e3o"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
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


--0FoRISOaCA+A7e3o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 11:01:42PM +0900, Masahiro Yamada wrote:
> Hi Simon,
>=20
>=20
> On Wed, Jan 3, 2024 at 8:47=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Masahiro,
> >
> > On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > > containing the built kernel and associated devicetree files.
> > > > Compression defaults to gzip which gives a good balance of size and
> > > > performance.
> > > >
> > > > The files compress from about 86MB to 24MB using this approach.
> > > >
> > > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > > and Linuxboot. It permits automatic selection of the correct
> > > > devicetree, matching the compatible string of the running board with
> > > > the closest compatible string in the FIT. There is no need for
> > > > filenames or other workarounds.
> > > >
> > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > FIT_COMPRESSION to select a different algorithm.
> > > >
> > > > The FIT can be examined using 'dumpimage -l'.
> > > >
> > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > requires compression utilities for the algorithm being used. Suppor=
ted
> > > > compression options are the same as the Image.xxx files. For now th=
ere
> > > > is no way to change the compression other than by editing the rule =
for
> > > > $(obj)/image.fit
> > > >
> > > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > > this here, since it must be built separately from the Linux build.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v9:
> > > > - Move the compression control into Makefile.lib
> > > >
> > > > Changes in v8:
> > > > - Drop compatible string in FDT node
> > > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > > - Turn compress part of the make_fit.py comment in to a sentence
> > > > - Add two blank lines before parse_args() and setup_fit()
> > > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > > - Add 'mkimage' details Documentation/process/changes.rst
> > > > - Allow changing the compression used
> > > > - Tweak cover letter since there is only one clean-up patch
> > > >
> > > > Changes in v7:
> > > > - Add Image as a dependency of image.fit
> > > > - Drop kbuild tag
> > > > - Add dependency on dtbs
> > > > - Drop unnecessary path separator for dtbs
> > > > - Rebase to -next
> > > >
> > > > Changes in v5:
> > > > - Drop patch previously applied
> > > > - Correct compression rule which was broken in v4
> > > >
> > > > Changes in v4:
> > > > - Use single quotes for UIMAGE_NAME
> > > >
> > > > Changes in v3:
> > > > - Drop temporary file image.itk
> > > > - Drop patch 'Use double quotes for image name'
> > > > - Drop double quotes in use of UIMAGE_NAME
> > > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > > - Avoid hard-coding "arm64" for the DT architecture
> > > >
> > > > Changes in v2:
> > > > - Drop patch previously applied
> > > > - Add .gitignore file
> > > > - Move fit rule to Makefile.lib using an intermediate file
> > > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > > - Pick up .dtb files separately from the kernel
> > > > - Correct pylint too-many-args warning for write_kernel()
> > > > - Include the kernel image in the file count
> > > > - Add a pointer to the FIT spec and mention of its wide industry us=
age
> > > > - Mention the kernel version in the FIT description
> > > >
> > > >  Documentation/process/changes.rst |   9 +
> > > >  MAINTAINERS                       |   7 +
> > > >  arch/arm64/Makefile               |   7 +-
> > > >  arch/arm64/boot/.gitignore        |   1 +
> > > >  arch/arm64/boot/Makefile          |   6 +-
> > > >  scripts/Makefile.lib              |  16 ++
> > > >  scripts/make_fit.py               | 291 ++++++++++++++++++++++++++=
++++
> > > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > > >  create mode 100755 scripts/make_fit.py
> > >
> > > I'll need Masahiro's Ack on the scripts/ changes before I can take th=
is
> > > one.
> >
> > Any thoughts on this request, please?
> >
> > Regards,
> > Simon
> >
>=20
>=20
>=20
> As I mentioned before, I am concerned with having
> the same "compatible" entries, with different contents,
> as you use the "compatible" string as an ID to selecting
> the target config node, right?
>=20
>=20
>=20
>=20
>=20
> $ fdtdump  arch/arm64/boot/image.fit
>=20
>         ...
>=20
>         conf-10 {
>             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> "tq,am642-tqma6442l", "ti,am642";
>             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier=
 board";
>             fdt =3D "fdt-10";
>             kernel =3D "kernel";
>         };
>=20
>         ...
>=20
>         conf-25 {
>             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> "tq,am642-tqma6442l", "ti,am642";
>             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier=
 board";
>             fdt =3D "fdt-25";
>             kernel =3D "kernel";
>         };

I had asked Rob a while ago about if having the same compatible for two
functionally different machines is a feature, or a bug, and I don't
think either of us fully agreed either way. I'd be leaning towards
saying the above example is a bug in the dts files, it's just not been a
bug people have worried about before due to (sadly) how little the
top-level compatible has been used.

--=20
Tom
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
> Best Regards
> Masahiro Yamada

--=20
Tom

--0FoRISOaCA+A7e3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdWUMACgkQFHw5/5Y0
tywKZQv9E6Suvs8TGK4s6Y2tSOz3YdMeCLMOPVuGXp/0Duv37bRe86JoJEsBtoRg
V/Mh5pUlhEzjemCpKbbacBrtDTnCtME59FjkhnTPM+P4UND7ghA1UVvD5/+0a/m0
PbvZsm3U2H5yJygYGqhYNOQm1SZGj5erfzxalNZtIoVCgUeVuXrBQ3NO6EwVEx81
VgXq1TFRiX+SJ61lSDvWSJX4/T51ED30k9/UAILCkmnDPza84WhiEdGBwc2EksJ9
3P2KCOTM/iyhzJSFXUV1pvO/kvLej0inNejaowQ3YyeG2g855EALltR7MBdIBpe4
hhdFq+1jviO5mN4TtSBXrk1b+HqFL73adbemUduJnnRQXnQnnDmeZtDJFIGKyJxA
hQB2lc7MBHc0KLs/A/yi4tp82IlE/S+DmL+2x1Bf99XNydSER5Jlp/DCkE7rBz7C
vTY/kl3z2krvdS5m82BOY0c9muA/908zhpXr6zkov1yvgEM0V7Oyt61M5DQjZEdb
fmjpGQb0
=GoFt
-----END PGP SIGNATURE-----

--0FoRISOaCA+A7e3o--
