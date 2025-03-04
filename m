Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCDEC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 14:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD338006D;
	Tue,  4 Mar 2025 15:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NOiCEWje";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0EA9800C1; Tue,  4 Mar 2025 15:42:55 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A057780017
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 15:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6fd6f7a8c84so23243967b3.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741099372; x=1741704172; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=12m8R5MwwPINgd7XjiY+8hu7esdkwx3w/lWQW0Z16wE=;
 b=NOiCEWjekxa/d73q95KeDZX09neRdshPs/7C/99Po0GrHcK55Dtgy1gNln+mND1YFL
 jw2QbTbwx4ZoRkufd7M1U8/scmEY/CASeYwh4b6j2HO84TjkwA1TY7AviTaO0mzRzEox
 hNmqNknWgfbb8R3LNis/Vmbt7prG91nxebjbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741099372; x=1741704172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12m8R5MwwPINgd7XjiY+8hu7esdkwx3w/lWQW0Z16wE=;
 b=ZfrmxTFPZxwT6OxOh3Ro870XNPygA6J/BaHJHW7CshDIHByBssv1aM0TEFsR6SwD7o
 f3+cWz+h+R7/3gkXtXZDjlQYzVDkLCLuIHw8aAnswCK9hktQJ4AlIFqzCERN9UMqz8w/
 rFGn+i0NK7mrsp84M7MFuYzJgzzeLRuvKxdnTtvqLKNO47ifIJ6nfncTR6JiLQ2dH1le
 jUjh+tIV29w1qEpqKfbBoqdvalEwXMWOe4Rw2SbbaWOrS1NV7BVIUByi/SXX1iAQRk6S
 EKZxfzYHBl7DIz0aFSNcCf3FmlufceLt+auqndjvOOSRft+HNuEC0GW1i80LEqTWXmaW
 h/IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa03BHp2hUjwVkRnX13H2sXs6KginPJc0j2UjBWeT4UqEX0Jjf94oaGx7OpIZwab/sXxSWBc4=@lists.denx.de
X-Gm-Message-State: AOJu0YzwKHYT8mbTHcLlP2/5Im4+cmx2JKw/YVtB4NNRhWDvfGB7iePV
 Wj3cgXTzm9kPX+ule8bKNzOvuPM8jjLxQima0WNJrxE0ZnER3hbG8jhWGMsP9GJzQ5Vage2Vn1v
 E
X-Gm-Gg: ASbGncupPnFlLG7KAHUcCOQQtjzSqHzg0NbONZcLfFGFY3cj2BhTKlOPJPwe5a/sEep
 XTA4BQ0Y6YPN1mfUMHYx00Oe5bIpEvibeBACRT6QIw86PQ91FTtbXQnkTMBoCsmTmBehedeFHD5
 e18+pn8au0obYdG0k9e1GyAGdHh5F9CUqrGNkZk+ePI11bRQj+611SPR+o1NfHoptqAIcsOGx73
 RUgZM6JsNFWiM6V9SUZ0YFJWnBu1pExKiCYkIKizdjBhxrsbExQF4nM6pU2vukO0Jbk9IgtjazJ
 gMP/9RudlUv9W9OHofWacq9QHgeTZMdTf6J66Q2l8JY=
X-Google-Smtp-Source: AGHT+IGK2QkWVrweL+WcaHiyaNBs6I3IWoBRMbE9Sv1iX0wbmrAMOEj/WF2103yqU1jfOCkYzvzChw==
X-Received: by 2002:a05:690c:4d86:b0:6f9:a75f:f220 with SMTP id
 00721157ae682-6fd4a0bd485mr221568397b3.25.1741099372406; 
 Tue, 04 Mar 2025 06:42:52 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca43145sm24932297b3.33.2025.03.04.06.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 06:42:51 -0800 (PST)
Date: Tue, 4 Mar 2025 08:42:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH] scripts/setlocalversion: Reinstate .scmversion support
Message-ID: <20250304144249.GY2640854@bill-the-cat>
References: <20250302183128.326418-1-marex@denx.de> <87tt895etl.fsf@prevas.dk>
 <4ef833aa-49b3-4af8-b77b-4b3f3f6b184e@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ozxuoqs1Kt9amFMn"
Content-Disposition: inline
In-Reply-To: <4ef833aa-49b3-4af8-b77b-4b3f3f6b184e@denx.de>
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


--Ozxuoqs1Kt9amFMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 03:28:17PM +0100, Marek Vasut wrote:
> On 3/4/25 10:24 AM, Rasmus Villemoes wrote:
> > On Sun, Mar 02 2025, Marek Vasut <marex@denx.de> wrote:
> >=20
> > > The .scmversion is used by oe-core to append U-Boot version string.
> > >=20
> > > LOCALVERSION is not fully compatible replacement as it adds trailing
> > > "-dirty" string at the end of version string in case the U-Boot git
> > > tree contains uncommitted changes. This behavior itself is correct.
> > > However, OE builds do clone U-Boot sources from git and may apply
> > > additional patches on top, which are not tracked in U-Boot git tree,
> > > but rather in the OE metalayer git tree, which leads to the addition
> > > of "-dirty" string as well.
> > >=20
> >=20
> > ... which is then _also_ correct, no?
>=20
> No
>=20
> > It means that U-Boot is built from
> > v2024.10-321-gabcd1234 plus some entirely unknown additional patches,
>=20
> This is not true, the patches are known and tracked in the OE layers.
>=20
> They are not uncommited ad-hoc local changes.
>=20
> > which can be anything from fixing a typo in a printf string to
> > completely overhauling everything.
> >=20
> > > The .scmversion used by oe-core used to replace the version string
> > > suffix fully, including the "-dirty" string. Reinstate support for
> > > the .scmversion to let OE core do exactly that as it used to do it.
> >=20
> > No, please don't. Let's not let this script deviate from upstream linux
> > again, and let's instead try to fix the bug in oe-core
>=20
> There is no bug in oe-core.
>=20
> U-Boot commit Fixes: 5c02350fa03d ("scripts/setlocalversion: sync with li=
nux
> v6.9") introduced breaking change, the removal of .scmversion support . T=
his
> patch fixes it. It is as simple as that.
>=20
> > that (ab)uses
> > this legacy .scmversion file. The fundamental bug is that oe-core
> > creates these .scmversion files unconditionally, even if they end up
> > empty, making CONFIG_LOCALVERSION_AUTO completely useless. I have long
> > since worked around those bugs in my own u-boot and linux recipes, but
> > I'd much rather be able to eventually drop those workarounds.
> >=20
> > Why doesn't doing what kernel.bbclass has done,
> >=20
> > export LOCALVERSION =3D "${UBOOT_LOCALVERSION}"
> U-Boot and Linux builds in OE-core work differently.
>=20
> Linux uses SCC to apply patches onto a git tree (i.e. it behaves like "git
> am *patch") and therefore the "-dirty" suffix is not added.
>=20
> U-Boot recipe uses plain bitbake do_patch to apply patches, and therefore
> the build tree is effectively dirty and the "-dirty" suffix is added. The
> .scmversion overrides the dirty suffix.

Yes, but that's Rasmus' point isn't it?
0592671fbba8c96df043d537d1f6415492de886e (v2025.01 hash) in oe-core
isn't the same as in mainline because there's patches on top and it's
non-obvious.

--=20
Tom

--Ozxuoqs1Kt9amFMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHEWkACgkQFHw5/5Y0
tywyCQwApClAT9ZG15QJsi+4uul9Xqq11PF0HXfHUjmnCNiprcSKmZ6DJX374r1N
wTeMn5IcmOhwl4eT2X1d9h8IrbEDbcwQ/xOhX7OsY6ovs97lz2F/mMRVMNaW0wmi
745tJeOfsru7u4sX1nUJ5MFwWCFXuvpZJhWeTFAiyrugaGhKLXpibj2Zw8rg3Kjl
Q4xU3yD9AQioORUBwi3iNuHs5yxEGyTblWIeblGorlEJ0FwLgq1mEM06xDJrDk40
70D1W/51YtfEIDuoSNZQ57fwzIEd6a+JNs3/OXFCqS/nTLZEWv/IRVJeRkBEBcg0
DhLgzYLyqPWKvqxpvFu2enYvoHwYzIQ7BkDu7fWhnIKeghFBpQANLU1uYP7u6Jli
1rXRwmPaUsQL5JGX3tYhGkSmN+/gocm9AIX8sdkRjsEVUXNkIn3Yvmt56UOMGrOh
APGl7fFdobA0JEvi9eyIpXasY1daXyxHLft95EDbI0cS74T9/cobI6ivshauxobQ
ZMVePOti
=i2Vk
-----END PGP SIGNATURE-----

--Ozxuoqs1Kt9amFMn--
