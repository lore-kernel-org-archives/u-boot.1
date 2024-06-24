Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC88C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 18:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F85187572;
	Mon, 24 Jun 2024 20:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GhTjn35X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE968751B; Mon, 24 Jun 2024 20:01:56 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9FF883B1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 20:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d51e7557faso1408673b6e.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719252113; x=1719856913; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VFmz6UX+g1PbbOrqjthK7KwU+lYZ82yYJgwx5+W7+pE=;
 b=GhTjn35XHkT/sVJLupRCXA1rqm35f+NM+qIpQUtNM9v/F5U5RRQwMgbq0nCSgC9o5k
 qc5j6xaOmQluSIW1dpeef6zhBKg2FM/2JYkzzERg4JK6ZrIl929Yli5jZVD2sPMjF2d+
 noy4uidkfbMUnhUf8AmSh+TMiibBwLisRyNv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719252113; x=1719856913;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFmz6UX+g1PbbOrqjthK7KwU+lYZ82yYJgwx5+W7+pE=;
 b=aLUNQHmXxMvV0pr7GEQf+LXCPcNq/N5vjWfG26i0jP9ziR4jm0M3vHeThmzY4/eGQA
 iEg8tdOZwqRkSSDrQGXmIUlyMDcSqtuLqQG7uLj7njDuPSSkLAC7AIaxir9XvwMapZG+
 eu/Yt+3QCh6slxDZrrsf0W5TN/U74RB1URYcmn+Bhf+z3PN5ILeNSe7HWGyrVJvWazci
 0jKDinCuslzLZFDe6OmZxmT7org2K/PSx8OTHD9ZH0YpQ2AU1rhxMIs9nCyoSR7KHyTX
 7Lqya1f/VdDg51mnYEmleBBA4//FGgRlA2jCh0yCDykro6PJEawxamNmAD2mSq2T4grU
 xcjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd6Jqq5X3nayiSKk+gskwI9HWQqoMwr/MFigJwtBcIKLip26YlLhJvhDYGJROahV1lajRFXA/gFhAxIuznGdVhujj36w==
X-Gm-Message-State: AOJu0YxwJJeNh0OUknSO9KTMspgV8LGCN6dBJ90RfItrc3qShKoTbJGl
 jq7yIJDCAEEzlqVsl2Of5c6xsq9ZO4XGlGxMZ+cVTHoCSJEJ/XUvimEbz9rypgk=
X-Google-Smtp-Source: AGHT+IFsRUL01vHXRXx/VtRVerqs5bvlA37dAmzqBH8YrlvpWn4vyk1Y1yF/m2ylbKxTlY/TgQdxuA==
X-Received: by 2002:a05:6808:171a:b0:3d2:18c1:bf35 with SMTP id
 5614622812f47-3d541c939a9mr6306812b6e.33.1719252112424; 
 Mon, 24 Jun 2024 11:01:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d5345d417esm1558826b6e.48.2024.06.24.11.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 11:01:52 -0700 (PDT)
Date: Mon, 24 Jun 2024 12:01:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 19/19] CI: Allow running tests on sjg lab
Message-ID: <20240624180149.GF38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-20-sjg@chromium.org>
 <ZnkchlJmYdVCkQV+@toradex.com>
 <CAOf5uwkQDzOpj-XUojvfWD6tU2cOxZkv4OEvOK7eZJZcRHTjfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9lkvbEA0vC5metl8"
Content-Disposition: inline
In-Reply-To: <CAOf5uwkQDzOpj-XUojvfWD6tU2cOxZkv4OEvOK7eZJZcRHTjfg@mail.gmail.com>
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


--9lkvbEA0vC5metl8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 04:56:02PM +0200, Michael Nazzareno Trimarchi wrote:
> Hi Simon
>=20
> On Mon, Jun 24, 2024 at 2:52=E2=80=AFPM Andrejs Cainikovs
> <andrejs.cainikovs@toradex.com> wrote:
> >
> > On Sun, Jun 23, 2024 at 02:32:13PM -0600, Simon Glass wrote:
> > > Add a way to run tests on a real hardware lab. This is in the very ea=
rly
> > > experimental stages. There are only 23 boards and 3 of those are brok=
en!
> > > (bob, ff3399, samus). A fourth fails due to problems with the TPM tes=
ts.
> > >
> > > To try this, assuming you have gitlab access, set SJG_LAB=3D1, e.g.:
> > >
> > >    git push -o ci.variable=3D"SJG_LAB=3D1" dm HEAD:try
> > >
> > > This relies on the two previous series targeted at -next as well as t=
he
> > > bugfix series for -master
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Reviewed-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> >
>=20
> Do you have documentation on how to set it? We would like to do in our
> company too

I _think_ from some talking with Simon before the biggest sticking point
might be changes needed on the labgrid side of things. However, that
might also be most easily remedied if there's a few people showing up in
the GitHub issue(s) showing interest in getting changes made/merged and
to use the overall feature.

--=20
Tom

--9lkvbEA0vC5metl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5tIoACgkQFHw5/5Y0
tyzKZgwAj7dCelVQh2+m+GA6ro0DchCn2jJGRfSCf82s46uGUfr16mhS80KaBo35
8j2V+qH5mZW5BsjrArDK7eDSoaxWOi4ZidJcJLiYO/TJeVs4+H2dPYVJuq2fXfpI
4hv+uLsd1y3TLhCBdkv1Cd2zo3/gUiFo8qne7BRbbNCMSNNAMb4yM61rBhSKrO/z
znUVivvPlPF9yeEG52CrD3Y3qhYZiuSQph7J5SnzHqevvlxEY7Nfk+NArSzlfwMe
fjH7RLbot9vCuFDOCjZnhRLrpOGN2/NNmOyqhcxqB9PUZSczBVJqquIwhWM58lnV
mAJsILvYxg/demDdiaDBwpvtKIzrnLYWHjjo1At9s0ehaN6oGNLDGzhClj2KcCCL
fdbX9r4XClasFArhu9k3JVi0IajLPSTxpTY88CnwgE2NZfGCcStRFDYDMRGqHV06
ECL370JSgcdPyUzWSmwBzqE3j389ZAfmV2M1Pz4ZsZCky2WfrmwYRQoQyVqIbfv0
Q9r6+HA9
=bKM8
-----END PGP SIGNATURE-----

--9lkvbEA0vC5metl8--
