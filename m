Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B8DC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 20:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422AE87243;
	Fri,  3 Nov 2023 21:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="raT5Hxw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B29871DE; Fri,  3 Nov 2023 21:04:08 +0100 (CET)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09586874D0
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 21:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7bae0c07086so359862241.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699041843; x=1699646643; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f19IyuiOB/v6jmqNnsuurlFXj68QdOTjd0yIrTFAN3Q=;
 b=raT5Hxw+Ywzpf1hcJGoFVI0UFWYVbEOtxmp4xdZWRiOHNoknVAypM58OCH0Hi9hIhO
 1rj6D6joiJRcZYH/zfbX0QPRLh8cHGLeoXEe8I+h61o9BnrJS5+TbRpf62qYDCvESW8V
 TTHafj93N8pQeJ7YsSelHwhpV6C+GwxMzXaaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699041843; x=1699646643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f19IyuiOB/v6jmqNnsuurlFXj68QdOTjd0yIrTFAN3Q=;
 b=RGl1Qd7xPsKDr/gQ1hMcFxy6eyb/VK+Uodz+eIaXc2Rhk4LybCyMSNResRCOH2Sq1n
 cXOIOs1FOoCOXaWQ2m4fiYmqtHFzHmmOc5V+olEDIA6EuVvs9piIibk5KhNo5fwy1Jp5
 XiA5tcUXeiJ4QFmJpDMDNzD/9way3Ty+cbuuUYkF4Wu03LH3cQvwUmbqwrqkL+bss5Cr
 x2BzyY49yvJpaLP+279xqSPqp+ce3IACuF6yfufvjkPD1uAWFwj5q8LhlKEqeB2NZ1R0
 G2QgmK5JVAo3ThRR4Kr1xRkDk3E49bIFkCQOvMqDxmnYAZ75/RgSSByn9FykcRpFZRRo
 4L1w==
X-Gm-Message-State: AOJu0Yz6EaPgMEZ/DHJgh9I0vjsE9K7YOdZi4vtTCPfAFYRHovtl4AjG
 p/7mqIIyPdu5CO9eqjG6ninkeQ==
X-Google-Smtp-Source: AGHT+IFj6nt7RskTX6uB0To+moZVkFEVhstux306aM3flOHrMvg4FPFH7f96ZSPRaPK5yXvmux+IUA==
X-Received: by 2002:a1f:b2d1:0:b0:4ac:8a3:e8b9 with SMTP id
 b200-20020a1fb2d1000000b004ac08a3e8b9mr1430612vkf.0.1699041842129; 
 Fri, 03 Nov 2023 13:04:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 y15-20020a0ceacf000000b0065b229ecb8dsm1048005qvp.3.2023.11.03.13.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 13:04:01 -0700 (PDT)
Date: Fri, 3 Nov 2023 16:03:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>,
 heinrich.schuchardt@canonical.com, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, dianders@google.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231103200358.GT496310@bill-the-cat>
References: <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
 <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
 <20231020162410.GK3119521@bill-the-cat>
 <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
 <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
 <CAPnjgZ3_WSS+Z2xsRTvf-7ChPN42OVLgLf8ZvGv=2FVrNuHkhA@mail.gmail.com>
 <87h6mhqri9.fsf@bloch.sibelius.xs4all.nl>
 <20231023163455.GL496310@bill-the-cat>
 <87fs21qnex.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ3Yqf3-9wjVTYh5eR_=rFuf-2eWUvZmfv=U1xDCVEWSXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vaJv9lHi/58y1iO0"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3Yqf3-9wjVTYh5eR_=rFuf-2eWUvZmfv=U1xDCVEWSXQ@mail.gmail.com>
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


--vaJv9lHi/58y1iO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 01:17:18PM -0600, Simon Glass wrote:
> Hi,
>=20
> On Mon, 23 Oct 2023 at 11:06, Mark Kettenis <mark.kettenis@xs4all.nl> wro=
te:
> >
> > > Date: Mon, 23 Oct 2023 12:34:55 -0400
> > > From: Tom Rini <trini@konsulko.com>
> > >
> > > On Mon, Oct 23, 2023 at 05:37:34PM +0200, Mark Kettenis wrote:
> > > > > From: Simon Glass <sjg@google.com>
> > > > > Date: Mon, 23 Oct 2023 00:08:40 -0700
> > > > >
> > > > > > > fdt_node_check_compatible() does most of the work...then you =
need to
> > > > > > > check which FDT has the most specific match (i.e. latest in t=
he string
> > > > > > > list). That handles things like board revisions, variants, et=
c.
> > > > > > >
> > > > > > > My concern is about adding a feature when there is already a =
defined
> > > > > > > spec and mechanism for this to work. What happens when we loa=
d the
> > > > > > > file and the compatible is wrong?
> > > > > > >
> > > > > > > At best, I see the filename as a hint.
> > > > > > >
> > > > > > > [Perhaps this is the wrong time to ask, but why are kernels +=
DT not
> > > > > > > shipped in FIT on ARM?]
> > > > > >
> > > > > > FIT is U-Boot specific. For Linux distributions it is easier to=
 use a
> > > > > > firmware agnostic method of booting.
> > > > >
> > > > > I'd like to suggest that distros use both. Then U-Boot can work a=
s it
> > > > > was designed and we can avoid these work-arounds.
> > > > >
> > > > > FIT is actually implemented in various other bootloaders. In fact
> > > > > perhaps grub is the only one that doesn't? I can't think of any
> > > > > others.
> > > >
> > > > Simon, please stop pushing this.  OpenBSD's bootloader does not
> > > > support FIT and we have no interest in supporting it.  Our users
> > > > expect to be able to just copy a new kernel in place and use it and
> > > > our OS upgrade procedure depends on this as well.  And this is
> > > > incompatble with FIT.  I've explained this about a dozen times to y=
ou
> > > > now.
> > >
> > > In the context of this thread, genuinely, how will OpenBSD (and the r=
est
> > > of the BSD families) operate? I agree U-Boot doesn't want to have to
> > > know all of the UFSes, so that means the SCT will be populated either=
 by
> > > the DT passed to U-Boot, or the DT we were built with. Is it that sin=
ce
> > > the next stage is an EFI app, it will check that variable and use that
> > > hint?
> >
> > Yes, that is exactly what I want to do.  Hopefully the DT that is
> > passed to U-Boot or that U-Boot was built with will be good enough in
> > most cases.  But when it isn't users can use the OpenBSD bootloader
> > (which is an EFI app) to load an updated DT.
> >
> > I can't speak for the other BSDs, but I think both FreeBSD and NetBSD
> > have a very similar boot mechanism.
>=20
> I've been thinking about this patch a bit more, and I have grave misgivin=
gs.
>=20
> I predict that if we take this, it will become an ABI from U-Boot and
> we will not be able to drop it.

To be clear, if the GUID in question (and that isn't quoted in this
part of the thread) is accepted and used as suggested, it's not an ABI
for U-Boot, it's an ABI for everyone, including the rest of device tree.

> Here is what I suggest instead: provide a protocol for U-Boot to
> provide the DT over EFI. Provide any information needed by U-Boot,
> such as the directory containing the files.
>=20
> We already have the ability to put a DT in the system table. We
> already have a way to package DT into a FIT and allow U-Boot to select
> the correct one.
>=20
> With something like this it will be impossible for U-Boot to boot a
> distro without using grub, etc. since it won't know what DT to use.

The existing system DT is the DT that should be used, as the long term
goal, not a loaded from storage DT. Until that point however, it's
already required to know what and where to load a device tree from, and
it not being at all uniform is where some of the current pain comes
=66rom.

> This information would be held in a script somewhere which no one can
> figure out without executing it.
>=20
> I think we need to carefully think about the design of this.

Yes, we do need to be careful and intentional here.

--=20
Tom

--vaJv9lHi/58y1iO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVFUigACgkQFHw5/5Y0
tyy+pwv/QawvnBiCALdOX6AW3EM0xS2pjkV/nv2VEs0pBu7Zi4c7hkVXUj/soKPk
xIbk3G2OZe0gcvKp7c7EhLluQJhgj1jau4mMhPDjLrNa31GAGwnPWloo+aPSP5DO
8mBdBNLihNm3OmIcws1n45ERBYewo7PvyeOvP1kOW01iFQyQWqcWUyEm8lP7NHaz
ehaSh2yeu1cJWGgUl1aq2Hd/Y46opU1/FykKMsX/fciW8Rq6PQukbrWbMTU+zKZ4
+FIrbZWo+xN11squnwyiwaDjWoqOVErRTkRzuqPyJaS4/7yA7hbsVrXk1EDCut0M
8zeESqz4s1lRK7pQnvxbXB5O3gjyHUqh17irLzNUhuGhU7it674zU7kUWD7WpDSA
xgUasqoYhse2lP+BPstvfjnTgqYX+CmARFgsj5ZYNcE6atRwGuK3xyrbTjznWEDw
Cis+hrD9+2RBk/7Q/owyqkODXFEbK0U0/h33wc843qLjsYGRWfsGa/+cAnppbzu2
NkP2uR5e
=Ifcw
-----END PGP SIGNATURE-----

--vaJv9lHi/58y1iO0--
