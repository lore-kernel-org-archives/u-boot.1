Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDF7D29C43
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D750839E2;
	Mon, 19 Jan 2026 17:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S0WbDIdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F7F839E4; Mon, 19 Jan 2026 17:47:39 +0100 (CET)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FCA08003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 17:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-40438a46d7cso2720558fac.2
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 08:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768841256; x=1769446056; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eWy52f+VqFee6bE3+Khwvmdbb9I6nIE4t5kU16KnAnY=;
 b=S0WbDIdkQSmwH/NkNFNH4qTix0ON1ECSNGiVZilsonr7+/O0OBDQUxDQ8YA8SOY5HR
 rqz0Xje7BedHewBOHI2f/JF2icGK9VpksReLoy6diMyARVD2KqR2M3fgMQqhxcGjYTrE
 duPtpA/0YAAM0GPQ2/zSoYtNQYaTQuUYwCnjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768841256; x=1769446056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWy52f+VqFee6bE3+Khwvmdbb9I6nIE4t5kU16KnAnY=;
 b=ODBSnsprYV/7DbIKwfMgOQfxkTUwlwIvXLoK0fnX4ZoD/QW0yv/7DbU2kNZjPVXjME
 AcdRckeIko9Sdx1viN8WDKw+ZP9BzlKpPo4pTUoZC2CHnrkRdnIA796GserFuv3lPdGR
 gH0K9QaGCPrGECy4v8p4mbgE8QApDgeXUgmzalC0h6TMDp8Z2omi5zI6fYJSnCxKcSsn
 9U5BJpH2OQ6KxTA6PuLb33oMan948jnx7+1foE6CotlR9I0kVx9MeQmXNz3AfGc22t8V
 QCljH3KSYYKlfY1+nCGwO2nwbDM8tnqN5EvX68h/piiU394mjRgcGGAiUwEElo6+dEM3
 DiFw==
X-Gm-Message-State: AOJu0YxiiIJpsvEESPFJPIAUBUOhWz0mLuc7kFGwT8q1+bd6p2kufoLe
 EO87UxIfYA5nBBknpkQtxm8YIbly64x/JGmHGtzn0P4VLGm2RcjUSLDTkZbXlalVXa4=
X-Gm-Gg: AY/fxX4mtmMSyhAjbVEskQTt3KYl1XgH2Tc5LfMAGVMQ+W5MubVvc63H6jy/b4BolXv
 kJgxCL8R/cUetr0xJAptCo66fHT5QWH7X4thmYh0QMdBZGtGPHNRbxlADRrQx5LZNTKvXyjn3/p
 F27ZKTEllYEwdT8g6o2F16fEM43w7rOlGsuFu20EHGOTAAEgySU0hK84BHYCNB6UYT7JaXNzfcM
 IiP7XMHhWluS4v8ECj1gk9RqvEnSWSVmeK8NQeyjoRGh1V6YXXkIpmt4CT0e28mUkm32pK9uhLi
 7p40PT82LjMGQ0UXCgfQpUv3//xe6PT9VctHQMj9aSx3hvJmc8exs2pga6Wz7uYunhbgW7owPSL
 KtUcRVrZAHsFzAE15Cx9cv8GMtRwKQHQ8+GJXVbUg7ZbWqDsI2PSr5NJ65RRg29zurpDBO1XNpS
 bPXH4HuibzHZfcjbp0UF0tL5E9r1pFUAtv97YqTF0vxcQ7hRfr0oyOzLJfrl8FI/oIvO6vfhWco
 kGWqJyCgxLck/RZOEYHSqguUeVp0watryEl0so=
X-Received: by 2002:a05:6871:e70e:b0:404:413:9a84 with SMTP id
 586e51a60fabf-4044d08dfe8mr5536946fac.59.1768841251425; 
 Mon, 19 Jan 2026 08:47:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bb51d4csm7060782fac.6.2026.01.19.08.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:47:30 -0800 (PST)
Date: Mon, 19 Jan 2026 10:47:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 3/3] doc: develop: process: Explain when/how
 Custodians may edit patches
Message-ID: <20260119164728.GC3416603@bill-the-cat>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260116182335.4081828-4-trini@konsulko.com>
 <f3bf1986-187c-405d-aafe-9e59ab14b3fc@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PiOnlmjbm1nIusfk"
Content-Disposition: inline
In-Reply-To: <f3bf1986-187c-405d-aafe-9e59ab14b3fc@cherry.de>
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


--PiOnlmjbm1nIusfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 01:27:52PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/16/26 7:16 PM, Tom Rini wrote:
> > As seen with commit d503633a3676 ("Revert "doc: board: starfive: update
> > jh7110 common description""), it has not always been clear what is and
> > isn't allowed by custodians, and what the expectations are. To prevent
> > further unintentional conflicts, document the limited cases where
> > custodians are allowed to modify patches directly, and how to do that.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v2:
> > - New patch.
> > ---
> >   doc/develop/process.rst | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >=20
> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > index 6f5bdd3db957..775a855fd7a0 100644
> > --- a/doc/develop/process.rst
> > +++ b/doc/develop/process.rst
> > @@ -144,6 +144,12 @@ feedback to the submitter of a patch about what is=
 going on:
> >       feels it has been too long since posting their patch and not
> >       received any feedback, it is OK to follow-up and ask.
> > +    * A custodian may make spelling corrections, spacing fixes and oth=
er
> > +      obviously correct trivial changes. They must also in turn amend
>=20
> I guess people will have a different interpretation as to *what* is an
> "obviously correct trivial change", based on the U-Boot git history, are

Yes, but this is intentional, honestly. In my other follow-up to E
Shattow I mentioned there is other general process stuff we need as a
project. Custodians are trusted members of the project and should have
some leeway.

> there some commits that used the [] + SoB form that are fine or shouldn't
> have be made such that we can elaborate a bit more?

Yes, we've made changes before that perhaps really shouldn't have been,
or at least are questionable and should have had more discussion.

> I think providing an example would be nice, e.g. the patch as on the mail=
ing
> list and after being merged with changes (obviously one you think followed
> the rules here). This will make the section longer for sure but it'll be a
> visual cue that this is important.
>=20
> I would suggest to require the custodian to notify as answer to the origi=
nal
> patch if any change was made when merging the patch, even if the changes
> match the allowed list of changes listed above. What do you think?

I worry that we're making too many changes in the wrong direction, based
on the problem that did occur. Which was a real problem. But it was also
something that obviously fell outside of the "trivially correct" rule
above, as it was adding new content.

Maybe, since the kind of spacing and spelling fixes I perform are the
kind checkpatch complains about, and submitters are already supposed to
use checkpatch, I should reword it to something like:

A custodian may make corrections to patches that checkpatch.pl
(reference) notes, or may request the author re-submit after fixing
them, at their discretion.

--=20
Tom

--PiOnlmjbm1nIusfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW5gIAAKCRAr4qD1Cr/k
Cm3SAQDUcFxWFmTcrXCAYIcWIUaIut5FPqKuy0L5f0r/RXT3kgEA9er9rl+wfLrl
StxcLWmMOgUTkgdL94u3b1BIxXgQ9A4=
=0sAP
-----END PGP SIGNATURE-----

--PiOnlmjbm1nIusfk--
