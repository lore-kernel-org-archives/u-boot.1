Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AFAC02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A581980C69;
	Thu,  6 Feb 2025 18:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aL30yihY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47BC80C69; Thu,  6 Feb 2025 18:08:15 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8394D80C72
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f200014f1so17277525ad.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738861691; x=1739466491; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6qwY39v/T8VA1qjTTyYAf2m70UufAOh6iBwSro2zb9c=;
 b=aL30yihYxXIpoNwvYC0x4PcMjLUceZmo4LEB4lgbIx9D6aCag/j8G6ISlF1tiTOGwp
 9TQlDv56DevpHX+Tj3oSlA3vvV7CFWUKHUbHFy2t7mABnMA/4+QMlg/B57PP1KaN48w4
 q7SEeXqg55Y8w/YlPMEQkkatDgIr/QhnDg3sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738861691; x=1739466491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qwY39v/T8VA1qjTTyYAf2m70UufAOh6iBwSro2zb9c=;
 b=YWNCvyo1qojIuFQSzrfnAnwvDBE4L73HpnsHmnq4UdI24u/1vakuy2g+OUtDK1Zkta
 NSnj1Uojru271NFjv1qUavFtv7ONxwtQdItvOhcZ9FnU80zmo9vco8BlOVYh6YUveYIc
 M5rrjDlG9ZB5XPCgVzgpeVF1jHHbWe/ZCSn1tBL7sEKg1+cIKcH/xYQqRYJJP5GecZGq
 UmiorNMuSEzMdee4O4rHzS37S1zFhzQF/Op0kYGyyGBE2itNoyo4lQRnwcmqNAkdvEMP
 DQRysPlDgrrCcK64K0FWGnMo3BOq+EsnWXBe4wCrdPMgCgWQjAnxSHvcyh8VHIRZsKME
 9Rbw==
X-Gm-Message-State: AOJu0YxMZ9v3UkoA2VnGMO+WQBsMsoaRPlI0rB8NYjLf8BpzGF5/mFYv
 KvJ6uBtsOnOpjZqDVvu6ZgoUGIHKG5Xc+nTc2PsYatEzKq3GUdyBjaqddRanr9c=
X-Gm-Gg: ASbGncspVIvyv8wuWJoJhv0Ts80t8oSPC2rOEvXxoF+yX6Th2Qjb/0SnCNo2t+lmluN
 ZZHckY7zmLgWF4yUilyroEpfhA07a+EzMh13qoTfQhh5mtglor0WUPe1tPV3IFmRipmVHwQT4Rj
 nTxMafnNbDsUen0lKcVt0yrJLiSKTrh8O98Tzsxi0hrv3e4k46IGcypKo73Pp1xQERasCDO2yPq
 YJKpNP+SnyZ6yy3SqcHZiiC+DiUMCJWn3Pjn61E33hABU0DKzPiETwPQ1Ng3aFSrgm2fM2i2bYy
 OgrQZas7E4TCg9E=
X-Google-Smtp-Source: AGHT+IExvaSLimw8N7RcQ/Z/Yi1Ui9+q7qos0RG8Nr4V1qAtYqLZIy9OtrY3HLpN0qQKeISa6FlZaA==
X-Received: by 2002:a05:6a00:e84:b0:725:ef4b:de28 with SMTP id
 d2e1a72fcca58-730351d9275mr11003685b3a.17.1738861691046; 
 Thu, 06 Feb 2025 09:08:11 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73059a416c9sm260578b3a.102.2025.02.06.09.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:08:10 -0800 (PST)
Date: Thu, 6 Feb 2025 11:08:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 31/32] efi: arm: Simplify the crt0 file and update link
 script
Message-ID: <20250206170807.GI1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-32-sjg@chromium.org>
 <20250203201036.GT1233568@bill-the-cat>
 <CAFLszTizPJX0pQs9UG7trXXfUbU9CnMzjWOQPMPLx_aeiaqsDg@mail.gmail.com>
 <20250204021411.GE1233568@bill-the-cat>
 <CAFLszTiEZnqckUuRW1OvtEv2D_6cL0hQyf9SVMvZNd6EcMFFnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5cakCpExIYvks0/a"
Content-Disposition: inline
In-Reply-To: <CAFLszTiEZnqckUuRW1OvtEv2D_6cL0hQyf9SVMvZNd6EcMFFnw@mail.gmail.com>
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


--5cakCpExIYvks0/a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:33:30AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Feb 2025 at 19:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 05:38:16PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 3 Feb 2025 at 13:10, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 10:42:24AM -0700, Simon Glass wrote:
> > > > > We don't need to manually add the PE header, since binutils has s=
upport
> > > > > for this now. Remove it to simplify the file.
> > > > >
> > > > > Set the link-target to efi-app-aarch64 so that binutils knows wha=
t to
> > > > > do. Add rules to pick up the arm64 files.
> > > > >
> > > > > Make some updates to the link-script for arm64, so this all works:
> > > > >
> > > > > - Pass  .hash .eh_frame and .reloc sections through to objcopy
> > > > > - Put RELA pieces into a single section
> > > > > - Put linker lists into .data
> > > > > - Embed the dtb
> > > > >
> > > > > Note that it does not seem to be possible to use this approach wi=
th arm,
> > > > > so this is left alone.
> > >
> > > Thanks for looking at all this stuff.
> >
> > You're welcome.
> >
> > > > Did you mean x86 in this last comment? I'm not sure about the rest,
> > > > either way, so I'll leave it to others to comment on that.
> > >
> > > No, I mean 32-bit ARM. For reasons I don't understand, it seems the
> > > toolchain doesn't support PE on 32-bit ARM.
> >
> > Ah, OK. Were other parts of this series really laying the groundwork for
> > EFI_APP with 32bit arm?
>=20
> Not intentionally, since I was trying to get the series as small as
> possible and still actually get something that boots.
>=20
> I'm not sure that anyone will want a 32-bit ARM EFI-app. I would much
> rather that we had it for completeness, but it seems that the binutils
> people were not that interested in it. What do you think?

I would ignore arm32 entirely and make things depend on ARM64 rather
than ARM within the series here.

--=20
Tom

--5cakCpExIYvks0/a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmek7HcACgkQFHw5/5Y0
tyyqmgv/TwOrxSzbLTFom2czVhDuQ1/63kk17eg0rCPonmaO8bSQgo+Qyd6pWQR+
EoXcAkKxhWXzWYdG7NWFABug0OxRjLBhb6TMGJkfue2pcjUiVcxT2e9st79ghu5H
bfHSYZ5OpbzmwbnQg4Jk3as3gBDI1UwdN6ylnbggAWdBhUdQfLZwHOX4dZS9PfQM
dLp3fOpL+hOFqb/YzAk84QuTk/hDvUcK1Z9rw1USSqXdiRVT8wDXvwlUwkDscaOk
pRUCaRMzNT6HzOZJH06PXuIK6cjgeSQfDXpbsHuO2KMGxdYQw0GvhPuh9rYopzK8
VQiMXHQjTkDMv66TDh7enEU3WdlN0OP+4Aqw/9PmMQZLaHzeV4WszZXK67ZlWMg9
23EptIe4yPBbz4wJkY0qR78eE8/Ny4j7zgPb8mEtEa5/m2Qn1XC3kgXXdfSo1R0D
3ZAQE/PX1fOkJKlctOp0pdweDZBtVqeWwHbxy8CJFN0/hqwv1Rc6bUHxPp1bVoKy
Skfwih82
=nFjC
-----END PGP SIGNATURE-----

--5cakCpExIYvks0/a--
