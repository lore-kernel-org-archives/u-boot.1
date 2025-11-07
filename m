Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C5ECCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 13:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 264F483D4A;
	Fri,  7 Nov 2025 14:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ATpJLZAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B4183D5D; Fri,  7 Nov 2025 14:55:57 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2037A83D0C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 14:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c6d3676455so202708a34.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762523754; x=1763128554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1PdTZ3X9SnaQykIUlY9mf060EI/daA21EPW2TfYmaV4=;
 b=ATpJLZABIYNotI/tt/koi5XZQH79HeNCt1iF6K6sUXFFHz0Rf/z1XIfw6zjbDDi6+8
 SA5SGnwcWbTwhRUtg6w4dDpkdGoBoJrnrjx1rC+u6TzSMGzGAAiTgiBIVl4RqrnMuaTz
 KQcGwdHFWoBel0/1O8GjdEVThdz3W4TMJufO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762523754; x=1763128554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PdTZ3X9SnaQykIUlY9mf060EI/daA21EPW2TfYmaV4=;
 b=pZTCQ+jbT/s+WqhoH1J25Vfp8Soz4+FhILKW1bMzmnMGvwr1IuuHepPO73Wpr7VzJ6
 rAH/NE6dZND7JGdfYtEhNU54urH1Wk+ycuN3ovt5mp55QnmQOXr+flBEqOGpWTkjITtK
 X+dBkg5NeO5KiVENlQCsH4G1XHVIWjEWvK5olJqaJY+95udTutbHahy7twTNhdUwYLpJ
 W7gxlWeJdKaqN4rjR+v+qU6WLVwnrepNxJ1EX/W4+vI2ECqzD5A1JEoDN6zbeTuDc/iR
 CQQeM2lY7+ZBHYQkBT+gEJ8kiVeeZ/RSW1S0Ya3NZk+ZhdeyCwvjIjlYBw9QSLvdgayJ
 dngg==
X-Gm-Message-State: AOJu0YzYet1Seqckz7LsnK2UOfoHwE/Ql3TWe3yXHEiQtxkSZ5BxnZxA
 858WmlN2JKxVqb9xsCA3miS2KDC22ak8MlOfOlvSxq9CSTpwsVeMvKw1yHZI5aH4gtI=
X-Gm-Gg: ASbGnct0Gr+I2PWBA7BC8OxJTQglHyDQKBrWEjmXyssQPaEYGYGHP5Y2wGm8XMOnxbO
 L7z5kOybxo3j7dCS4dayS4NtF1I4pkwLCONIKl0a17IgUfBqylpiy7DN8y6bXu4ulL9To+9ZazD
 2/EddIRBkR1D6vGlw6nY8FtBHl+xJsjVo86+IuLSwBVFGMrIf8xwE0gixvo7KZuUpkiDyxCE0ZS
 67hgXmo2y3g7QJ5T8kHEqNRVGWBvZKIW2ctwGbDOomBjS9qDzVhUkrgUfPKeKEXZbQaqSUSRhI3
 j1rGdBisAVPfRd13GSKcvM2hrkELnfNXmlElSelttkZIEyHEHxVAECHzEqwBXxTFqj6nYU/BGgp
 UJ93sJ6/SLlA/15PXfX5vO8LVLP7Fnko1fNC8XqbeV/TDKT9YmOIfjCPqbYalOTl52YL80891am
 ObsnnDU7aKZp5NJtuQCS43uKmK358/HKW89l8wsqM=
X-Google-Smtp-Source: AGHT+IHHesDmjDhZj8gpy1cSp0Nm2xxA9Y+htoEsvWKb3iOVaXojuAia+dt3wjZwHoFMxLmx/bMiQw==
X-Received: by 2002:a05:6830:44a9:b0:7c5:3045:6c6f with SMTP id
 46e09a7af769-7c6efee93d1mr2843599a34.20.1762523753706; 
 Fri, 07 Nov 2025 05:55:53 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f112fdd6sm1471362a34.25.2025.11.07.05.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 05:55:53 -0800 (PST)
Date: Fri, 7 Nov 2025 07:55:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Gitlab CI: Rework our tag usage again
Message-ID: <20251107135551.GA6688@bill-the-cat>
References: <20251030043558.2620797-1-trini@konsulko.com>
 <176246627096.3129497.682434390557357881.b4-ty@konsulko.com>
 <CAFLszTiCY5z6ZFag87rtM+UpGmYUywhgkH0Oi9WqysB6J4mr1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5zdZSBWS7jZP6kWq"
Content-Disposition: inline
In-Reply-To: <CAFLszTiCY5z6ZFag87rtM+UpGmYUywhgkH0Oi9WqysB6J4mr1g@mail.gmail.com>
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


--5zdZSBWS7jZP6kWq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 11:01:17AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Nov 2025 at 22:58, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, 29 Oct 2025 22:35:58 -0600, Tom Rini wrote:
> >
> > > Now that we've had jobs running on both amd64 and arm64 hosts for a
> > > while, we have enough data to look at usage and findings. For the wor=
ld
> > > build job, make use of the new DEFAULT_FAST_TAG and only build it onc=
e,
> > > on either amd64 or arm64 as we don't run in to host specific results
> > > there. For sandbox, continue to build on both arm64 and amd64 hosts as
> > > we can find host specific breakage that way. Remove the mistaken
> > > restriction on sandbox64_lwip.
> > >
> > > [...]
> >
> > Applied to u-boot/master, thanks!
> >
> > [1/1] Gitlab CI: Rework our tag usage again
> >       commit: ddc916334a7a7e180b532dbb2cf1b778466d2b9b
> > --
> > Tom
> >
> >
>=20
> Good to see this! I would again like to suggest breaking the world
> build into parts.

I would like to ask you to stop suggesting things about CI until you're
willing to honestly address and review the feedback I have given you
about your suggestions and why they don't work for many of our use
cases.

--=20
Tom

--5zdZSBWS7jZP6kWq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQ36YwAKCRAr4qD1Cr/k
ClI/AP48Ei0ZEriD/SmOLrqEfRUp/zFR9P+9VNGQ9VytpAaYBgD/USFhMldOAF28
49WAaKIGOVTSvCCsgIbTvPCFFZ71cQk=
=L1/N
-----END PGP SIGNATURE-----

--5zdZSBWS7jZP6kWq--
