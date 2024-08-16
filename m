Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B988C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 18:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9290188BB0;
	Fri, 16 Aug 2024 20:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f+SursiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BC588BB2; Fri, 16 Aug 2024 20:36:14 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A9D889E9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 20:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2702ed1054fso205378fac.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723833355; x=1724438155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hPpX0Jo1n6fE091qNDK8AtK0owzchVpcc/XFbDtKA8w=;
 b=f+SursiKxio4loM3qNetUulw4NEZRRiFUhqerO1LaOn93nnLEeO6UGOBiLgPs5Y3jz
 9p26B5sAtGTzQVUwck9b6L5T4+HZgNJGltHzoXP3ZIJUYl+epoWbbhvKu4rHk67VqNh1
 yoYj6p5njwKvpzIBBtaiaLyRd6zor3mSPlSyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723833355; x=1724438155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPpX0Jo1n6fE091qNDK8AtK0owzchVpcc/XFbDtKA8w=;
 b=TZUDqHltfMjHot20vqt629H8o+tGu3ZJvz9Vnie9BPjM9guM6iJ7kc9l9jehNSnJQx
 NW9JRWlb651OMpudgNuRipOW7LkCQp/iDlIetT6cSbm9j6QnUqJ9/cgOuAXoWJG+Jw2t
 QilHaB3BAgOLhZaCniKW4i5EUxP4gwWqjwwclaEj4Gxc7Lz5rAx6RxR3/pP3EdG3Mbet
 ON6ARwSTAV9RvSh+tS3uH1Yec+0FVPEb6neVMrSyjLmTUTzCEba4Kt6opV0iEsYbMX34
 oAEoJdNLR2AOR10qGuqjaqW4Gq0LA/toJEHboJPQZqW57CkIPzyur/buB5Z1pp/ha2dF
 /EYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd5kPtwhyc99TiNspsLBeTB2ghXBJeGausbHYypscHKxM6JbqAhQTsOV4YWx1Yf++w/Pc8G4kgGhgslMxRfqCuXnHNYg==
X-Gm-Message-State: AOJu0YwURVjKYvxv1sEsUvnoJCRP3YzyWibkPPnohsOY0ma8VDkU5NxM
 d/rjP7NXSQOsLsuE/aM9xxiucPTB3K0Ufql1ehoHVJsrrF95hMEacIZfzA+0eRU=
X-Google-Smtp-Source: AGHT+IF0Ornecfih2WKW1dhkpx9/8y2YzcE3gujJ0cyVA43Ua997EGs8TyrDjJ3Q0KHP6dViPTYRZA==
X-Received: by 2002:a05:6870:ec88:b0:25e:118e:ce89 with SMTP id
 586e51a60fabf-2701c378ccbmr4567786fac.11.1723833355360; 
 Fri, 16 Aug 2024 11:35:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270049fbf92sm1014206fac.58.2024.08.16.11.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 11:35:54 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:35:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
Message-ID: <20240816183551.GC1626301@bill-the-cat>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
 <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
 <20240816180618.GB1626301@bill-the-cat>
 <CADg8p958YrP9AEALEWe5qUxLkTGguMLcf8jvTw3dDvRwZn7wzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9IAXtwnFScVXl1jz"
Content-Disposition: inline
In-Reply-To: <CADg8p958YrP9AEALEWe5qUxLkTGguMLcf8jvTw3dDvRwZn7wzA@mail.gmail.com>
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


--9IAXtwnFScVXl1jz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:58:46PM +0530, Sughosh Ganu wrote:
> On Fri, 16 Aug 2024 at 11:36 PM, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, Aug 15, 2024 at 09:32:29PM +0100, Simon Glass wrote:
> > > Hi Sughosh,
> > >
> > > On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org>
> > wrote:
> > > >
> > > > Instead of a randomly selected address, use an LMB allocated one for
> > > > reading the file into memory. With the LMB map now being persistent
> > > > and global, the address used for reading the file might be already
> > > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > > address from LMB and then read the file to that address.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1:
> > > > * Don't use the API version with flags parameter.
> > > >
> > > >  test/boot/cedit.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > >
> > > No, this address needs to work fine without using lmb. Same with any
> > > other tests. Tests make use of the sandbox memory space memory
> > > addresses and it makes things easier to code and debug.
> >
> > Can't we just request/free that address from LMB then?
>=20
>=20
> Very good point. Because that is precisely what this patch does :)

Ah, I think the wording is unclear then in the commit message. It needs
to reflect that we're taking a previously intentional address and now
reserving/releasing it with LMB. And perhaps not change from hex to
decimal too.

--=20
Tom

--9IAXtwnFScVXl1jz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma/nAAACgkQFHw5/5Y0
tyyKugv+KS36l4pjCQ11SRNWxmv1MohxML7oLWJbECIuwbCJptQdM+k+7EpQmI/i
nOlULN5Yuft3QxFSy7KvFh93xbPGhnPYYTUbncRH3UnFZh251Gid083G7jDPfzqx
mE7kuBkJyih+0GgiZ85N3oKlTdfUXpruru94y4ak/mmnEMKo+YM2q76i3pnHo2ox
hHkZNQBmlmBuFCQxFiOw2cABS0iLmKWLgM0pjIB0itbcF2aAO7wD33ZtK8TM44rs
1H3IayWyOI3O5nfLgMPLpKczPwmY3AT2/+3HmQSbVr49otkY2rug1WOBDIaXJR4W
pUuyzFWPBGeicZZ7lz5XYzyDrajzG2rOLjg3DJ2dVk371S0kFPv1CtdGhd15/MfO
IMnjuuuBA2tC9+rKR05AeS3LyMFGmywxLXPsM3izxOpY+ugPmEgMSCDT8bQpwCU2
o6URessYl0ALMjBSS5l+acx93Hp3eyiOjTd5PJDgxqVyfJcYaduQvQ83wrogT0Me
nqrLq89G
=qpqD
-----END PGP SIGNATURE-----

--9IAXtwnFScVXl1jz--
