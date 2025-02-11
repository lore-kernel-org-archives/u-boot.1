Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD89C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5643480B9C;
	Tue, 11 Feb 2025 14:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="axuFLgMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB0C9807E1; Tue, 11 Feb 2025 14:59:53 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D3580C69
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so125434255ad.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739282389; x=1739887189; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cLRWuPu8NTn12wlAUZrccuUIKMeSx9BuHQQhRZL7SKI=;
 b=axuFLgMRQlba9oZbheLi11yN4TANDOGcwfj03AUygpXxtbNMUj4bVJyeOH6ArNpAi0
 bil3mAO4w3ow+lnYotw5JB6jUiqKzsUHwK3cWA7XJzZ5kee6Exm+SSWENICn4XhTgXMv
 7EuLAC4ReAHNHuH3jbboEpzTd0WOQFaLK3KTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739282389; x=1739887189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLRWuPu8NTn12wlAUZrccuUIKMeSx9BuHQQhRZL7SKI=;
 b=pLGBy5xFaYvuMmcW/tSobv+bFXRfsMOVV3n4suZ1a0DHneSwbWMRv9sBdE9KntL1hX
 M6Do855O5iosZpc893HtyIIQy0KL/yrYXQGSZ25u5r2j8rbixjg160dfYOZ09YuRqIGv
 NG9hSXGqxYOXM7QgD2oJ6PYrgaYQMI6rmUbrvjcLvO83x7TLTYL0v7aEtsSDTNS3Goa9
 PgRhPnfiv6on+OEfWdr+EvN2u+0RzbwDm9wCixoniaw0RcIfTajkB3tIfcYQdyyFSK4J
 jOZ6+7VylbxTCFoJaVzT9WtNQrr0NpqbtertGjpLwNmnl36HILmdcNhbCgwtlEwdxwe5
 LPcw==
X-Gm-Message-State: AOJu0Yww7+c8gP9edXQ//Oy3VAPlg1voKzHf3mbyzioqKChFhVuYGegq
 pNYi/6xddyVmJYq4tvwl10cutwSahN6Urt+slacOhmKJzViTZ6gWD+MyEO3tIvI=
X-Gm-Gg: ASbGncsO92Nx1dl0pjBxraJCOW+V8yNargcejaUc30ukBMhYwfkhB2+XM131fDv7TSV
 mNsOty7aIxH2ZwDvm5qSiA8KShhbh63Op+rttGeO7u4ct21kotITkr9F3a/3CbE+J2zAugDpFTW
 toAYu8TsXOCf+WMfil7f1Ly1vkd3p/XgT8k/H5UGyGip2cfsnonu4mTQtPH3bnkJBNO24erViS1
 YyIB4HtFLPfk/FvEEDoyPr30V1djJHGPnUozj475oE49wOet+UnS8ADV0emFQOV+dWvMSKA7AnE
 gkITEU07CxtJmJA=
X-Google-Smtp-Source: AGHT+IH+LqCHA8EIDiBiVUqGJDyVimj4i88UXJ1gwQpoqsecAy6z3X7iKt0BbOqm4DXSoxFBEu1QwQ==
X-Received: by 2002:a17:902:f60a:b0:215:94eb:adb6 with SMTP id
 d9443c01a7336-21f4e73b2c6mr313450825ad.40.1739282387875; 
 Tue, 11 Feb 2025 05:59:47 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687dddasm97002105ad.203.2025.02.11.05.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 05:59:47 -0800 (PST)
Date: Tue, 11 Feb 2025 07:59:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250211135944.GZ1233568@bill-the-cat>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5WBTR1vGnU2Ogm/D"
Content-Disposition: inline
In-Reply-To: <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
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


--5WBTR1vGnU2Ogm/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
> >
> > > The logic of this has become too confusing.
> > >
> > > The primary issue with the patch is that U-Boot needs to set up a
> > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > phases can then use that bloblist.
> > >
> > > But the first phase of U-Boot cannot assume that one exists.
> > >
> > > Reverting this commit seems like a better starting point for getting
> > > things working for all use-cases.
> > >
> > > Note: The work to tidy this up is apparently underway. For this serie=
s,
> > > a revert is the easiest path.
> > >
> > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > >
> > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-vFryq1Gn=
7QZ5hKU8Wjo8igw@mail.gmail.com/
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  common/bloblist.c  | 64 ++++++++++++++------------------------------=
--
> > >  include/bloblist.h | 10 --------
> > >  2 files changed, 19 insertions(+), 55 deletions(-)
> >
> > We aren't reverting this change so if you plan to move this series out =
of
> > your downstream fork you should start from that and stop posting it,
> > that just leads to confusion.
>=20
> Who is 'we', and start from what?

We, being the community, in here, the community mainline U-Boot project
tree.

> My goal with this series is to have something that actually boots on a
> real board, so the bloblist changes are needed for that, particularly
> as the 'vbe' board in the lab tests this on the hardware. I
> deliberately put these two patches at the end of the series so you can
> ignore them if you'd like.
>=20
> But for now, as I understand it, there are no users of standard
> passage in tree, so actually it would be fine to apply them.

And you can ignore all the feedback you like for your downstream fork,
sure.

Part of the feedback in this series already was "Yes, we can clean this
up a bit more if bloblist will do its own thing instead".

--=20
Tom

--5WBTR1vGnU2Ogm/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerV9AACgkQFHw5/5Y0
tyz5iAwApJKteNUHRuhO9JZUxI0l2qunSIqXo2Ke/W+2kQckK3A9hFGlYoKl2wnu
sknKBmvClMMBRML0wcsPLst7mGYSY6EGRwerwrSxWKKf19z/tNRNj2Nr/JjW3JXS
Dpn2WD7zXEWnK2XwPJoz8rFhZe7xaQ+d3RV8EzJShTwxxVfm92Q6S4E4RIPJjVPy
NNpkQ7/ABLDBGcCxHt6zds1rHE2rCExCyZdA0/JX4E5mX3nGtI35I0YdjH5w5lRR
ixsMUZBbHzD/Aps1BIuzEE1f+qjhPlN9KQaHj9FnYOdPBPSTlL1XMkkIDTP7GT7q
TbwjUV01MY1noqGlw6q4Vm6C+u1CQYBtFkn0BojL8FhG+orwlqrmSkUo+5Gt3aGG
GFiNF26mZ9GMgScdbuijuA8QfKXZwud3mco0GBedQlRZnge9CusZYQ4vZwxA3OE1
gZP48x63wygGxrjOtTDp3HJGroPN45eYTxgVM8d4z1qqUnGj7rVq+Pd9+JimNWgw
JYj2VeVO
=hvGW
-----END PGP SIGNATURE-----

--5WBTR1vGnU2Ogm/D--
