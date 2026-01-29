Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEC4D61020
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56DA83F32;
	Thu, 29 Jan 2026 16:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AwLctd58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FCD583F32; Thu, 29 Jan 2026 16:19:27 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B51783D9C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45f194e9a98so386052b6e.3
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769699962; x=1770304762; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LOlFBgUZVMqHUi3wP3dBrlXM0ZBi3gGU3/5MRr9RO2M=;
 b=AwLctd582wG+0dSOrfGoqX7VIdFocGAr2BI/5FnAKaJtQqAedTNahI4acmgty/MF2M
 rV8X43ZuZuNHRDaCu2k2NY0m1IGqLW7yxp8NG91FcafJ2hZ84+pI411xdamF2czTXgz5
 P+fizrnBJ+CCYr431RE2GfizVEVZvUKmEPqnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769699962; x=1770304762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOlFBgUZVMqHUi3wP3dBrlXM0ZBi3gGU3/5MRr9RO2M=;
 b=j4CchROjUXXkNwoQQQU03few4mUudNFEcODbNhmvshcgs0pkYekuiwjywCxPEJ1I6k
 OQWntyXDJ4Gl7BMCI6Fst/LDzE85n3+7iWFUSd135unzhlYzIrexud/QYcQFK+iWwrJX
 tX2JAsH7UeTORu0K63egCUG4503W+0ANDOJMvzKMkyIvxAH7N3P+khBzJ0o3wNE9Rnko
 W6Fs6XfAwDVC8Mt+mDmoZofGOtzWeE+wr9SCMXal2UE0MLYqHg/quioEXhiUYToIOTvW
 8IsU1YyhNt8ZW2R+Rls+7YKFNSWK9kXdwzU1my5vIuD0IcKHfDhQcR1ye0xYzN/6lxTB
 zEcg==
X-Gm-Message-State: AOJu0YwIvW7y5OorkYOFtmhbRxbla2oglLKuzZSbAkUYE+6413FI7Lw8
 je0vW0AVRiIV6POO6NJa/jCDg0/1jFu9yzWr6JrJkmgJXp8+2ZkDOxWs+19k1jWJUig=
X-Gm-Gg: AZuq6aIKfPsEEKbH/Ku0ecsg9nmAQzRCqtsnSVjTCbYHTjNRN/vJJ46p5224q3J2v9C
 gEpIF9lEYoBxZ+Ek+mnfosiC773qtaBae0a7LNHRbdwpTT7+98wqqNLIH1bhg5ya4sL0oVtIH5U
 yukwV3/UHrNu9i91Lj02DU1R9VR/SvfnRVa/TT56tkZbazzVRfLGDdRT7EBbWZviViWok9EaDDD
 XzU9h3kcLNNHWAMByX0SUVGhM+X8x4A1Bgjrt+C3VFsoBtBBVsbs5XR1yAjLZfnSkpbCQ3eUMyo
 dzrMR1AooXUqH/4QrPsd9ylPMuXBOlFchTTGDrv/gI/v8Svlp6uv7fl27s00KOtNlnKqbWxM/OF
 3+27s6zQ91dsTMb96HnClg+9bHqs+gmFpk1ae6INJ2GFFiF16bBR2OfnzujHVuUmvEoZh8QebRr
 uUGg2wbms2P6oSO4vQoIHGyxPq8bDAxe2LJywL1mrtj179K3yWO4sGg9cqOaR5K5FeDGrkiHZ47
 HEhzQd4mj8BQAeDYr8gqV7ij0CpOjolQKH9izE=
X-Received: by 2002:a05:6808:286:b0:45f:210:4dbd with SMTP id
 5614622812f47-45f02104e76mr4016131b6e.16.1769699961879; 
 Thu, 29 Jan 2026 07:19:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08f5ff30sm3235678b6e.16.2026.01.29.07.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 07:19:21 -0800 (PST)
Date: Thu, 29 Jan 2026 09:19:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129151919.GU3416603@bill-the-cat>
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
 <20260128145118.GJ3416603@bill-the-cat>
 <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
 <20260129145416.GR3416603@bill-the-cat>
 <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f1xdxkhJDkzBEAi8"
Content-Disposition: inline
In-Reply-To: <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
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


--f1xdxkhJDkzBEAi8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrote:
> On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrote:
> > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrote:
> > > >
> > > > > Hi Tom,
> > > > >
> > > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
> > > > > All Cyclone V boards are unable to boot, not sure this patch is t=
he fix?
> > > >
> > >
> > > Hi Tom,
> > >
> > > > Yes, those commits were unintentional and have been reverted.
> > >
> > > Had tested the last commit 6a1bdb7e952d5841f42742fefa907cae5dc8d50a
> > > Same situation that the boards are unable to enter the SPL phase.
> > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works properly.
> > > After that things are broken.
> >
> > Please give
> > https://patchwork.ozlabs.org/project/uboot/patch/20260129035512.639362-=
1-marek.vasut+renesas@mailbox.org/
> > a try as I think it might have been working before by alignment luck
> > rather than design.
>=20
> Hi Tom,
>=20
> It is the revert itself that is broken.
> I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
>=20
>=20
> U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026 - 22:56:17 +080=
0)
> Trying to boot from MMC1
>=20
> Which revert is correct.
>=20
> But once dc2d8423b19d30472b02e02b41504226908a4291
> And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
>=20
> Then all these broken I don't understand why even file diff cannot
> show any changes.
>=20
> Do you mean the revert is broken and fixed by alignment?

I mean that arbitrary changes (as part of testing these things, the
"-dirty" in the version string would lead to failing trees now passing)
can make the difference between pass/fail to boot. Did you try Marek's
patch I linked to?

--=20
Tom

--f1xdxkhJDkzBEAi8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXt6bAAKCRAr4qD1Cr/k
CqtQAQD/sgn0pMlsB4Jtayk7Q0+4DqoF2Dayk9m0whEE6b2f1AEA6ZRMT7vY+S0Y
kjUKAt/Hu4c9kgNOZeRNigMF5ZfR9AQ=
=fTx8
-----END PGP SIGNATURE-----

--f1xdxkhJDkzBEAi8--
