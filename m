Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B88C36000
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436F281ED8;
	Wed, 19 Mar 2025 16:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H0qf1wpO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B3D981ED8; Wed, 19 Mar 2025 16:38:54 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 217DC81ECD
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22435603572so117271995ad.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742398730; x=1743003530; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c79y+ISSlehUFyDYDkzmc9v9P4uVeaeqXbhRupySpeY=;
 b=H0qf1wpOO/rdU8MWIRXdtpR79t+0vz8TqxJkb/TAyL539/CvmEtAEVycMD6anJQbfJ
 nfW1kQidESl5I5kZh1KVW3Sg5AfWCNvu2YUnTxWwrzlZBvNrATD6GU/6ouRDpRWCw4G0
 zJ98N0TX8HVcvNOBvUIITeNEz+ESOj7mTfEhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742398730; x=1743003530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c79y+ISSlehUFyDYDkzmc9v9P4uVeaeqXbhRupySpeY=;
 b=NI56CrCzR7peTpQpLNx1+Nr6+s/K//8yuXyDZNEi8JeQgflGYbc7UhJcAIPal23Dew
 98C0lwGuDJMatYnya8MgptiOuqU1RMLv6AVtJZ66ppCLIZw/MsgsMEKMlCv+VDBkzwVL
 uB3tzodd+iE0C9Vd+g02HbYcQQgD7/RTVuJ4GuGdkp/SLmdUEW0y8HC5EHQJc4y/4wZi
 Wo3OccAbz60smjJC8gMEhbI+0J9KBfBGLAyhqwvvrhe6YxpBKT3xyINtskYQqY1A48pg
 063f014wWPaYmMkQ1Tr+EXIjq+f0WNl3F+6/qYaP4Vnock+p8ykOFUQFczeFNQWfqfPm
 0gzA==
X-Gm-Message-State: AOJu0Ywh+qAkrQQkDzMFhdE8HwopxPI3gcR3VIqOuNNH8TUZCnZtbEi8
 iF4OHxrbYdNt8YSy7LE56anGJoejHGEFXGSK3Ik5JTxDXlLZQCp1dXerapa4Pek=
X-Gm-Gg: ASbGnct9+uyS5o0TQ8NmXqDLe3/D8Z8n67F2SLyjOjeb3G1MwhQe0m22akYlcIRXMlf
 4FFdMXat22/46HI2v6oN79cwcMZ/qVB89QMzmUaysVuUqUl65c+3ZvPXWA421DQv5k3bzszcMqC
 50m7zYuYG8WNn4rZiQUP9BNNVpIhokb8VKaI6q2ef9AtNdACJgliTM9q3A0RbAQZbW04Ps+b5xL
 B1+78p9yBNnk1xVkZqtKzL27QD8JaLrJntkS2T32SpgpdsHFkF/3w2VmkXCZVMzNIEFmQl5ti9v
 oszQ5Y7ZwhBTyPC1aakVgeRZ//hBOxNY+E4HxuMxDb7qdg==
X-Google-Smtp-Source: AGHT+IEaPfwtzpTfO6DojZ/EhWn8PssbyW/UMxoDrzI6m05VodxX6mSKKQFaf/pzlGy3/c4fUY1Nig==
X-Received: by 2002:a17:902:d2cc:b0:223:33cb:335f with SMTP id
 d9443c01a7336-2264980c709mr49270385ad.3.1742398730515; 
 Wed, 19 Mar 2025 08:38:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5cddd6sm1739114a91.41.2025.03.19.08.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 08:38:50 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:38:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/6] test: Add a test for strim()
Message-ID: <20250319153847.GL2640854@bill-the-cat>
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-4-sjg@chromium.org>
 <20250319142438.GF2640854@bill-the-cat>
 <CAFLszTjG-uhXLWE7+fWZtHLfjns7oAEqcxr1Q2NNgVnFaAUH=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RtWH5g73AEanSukq"
Content-Disposition: inline
In-Reply-To: <CAFLszTjG-uhXLWE7+fWZtHLfjns7oAEqcxr1Q2NNgVnFaAUH=A@mail.gmail.com>
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


--RtWH5g73AEanSukq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:04:16PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Mar 2025 at 15:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 12:59:05PM +0100, Simon Glass wrote:
> >
> > > This function trims whitespace from the start and end of a string. Ad=
d a
> > > test for it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  test/lib/string.c | 31 +++++++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> >
> > This got me to ask "What even is using strim and where did it come
> > from?". To which the answer is:
> > - A few places, but it's probably reasonable.
> > - Linux, pre-2011.
> >
> > I say the latter because we're missing a bug fix to the strim function
> > that's been there since 2011:
> >
> > commit 66f6958e69d8055277356d3cc2e7a1d734db1755
> > Author: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > Date:   Mon Oct 31 17:12:37 2011 -0700
> >
> >     lib/string.c: fix strim() semantics for strings that have only blan=
ks
> >
> >     Commit 84c95c9acf0 ("string: on strstrip(), first remove leading sp=
aces
> >     before running over str") improved  the performance of the strim()
> >     function.
> >
> >     Unfortunately this changed the semantics of strim() and broke my co=
de.
> >     Before the patch it was possible to use strim() without using the r=
eturn
> >     value for removing trailing spaces from strings that had either only
> >     blanks or only trailing blanks.
> >
> >     Now this does not work any longer for strings that *only* have blan=
ks.
> >
> >     Before patch: "   " -> ""    (empty string)
> >     After patch:  "   " -> "   " (no change)
> >
> >     I think we should remove your patch to restore the old behavior.
> >
> >     The description (lib/string.c):
> >
> >      * Note that the first trailing whitespace is replaced with a %NUL-=
terminator
> >
> >     =3D> The first trailing whitespace of a string that only has whites=
pace
> >        characters is the first whitespace
> >
> >     The patch restores the old strim() semantics.
> >
> >     Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> >     Cc: Andre Goddard Rosa <andre.goddard@gmail.com>
> >     Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >     Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> >
> > --
> > Tom
>=20
> Here is the comment for the function, of note given Linux's disdain
> for commenting code:
>=20
> /**
>  * strim - Removes leading and trailing whitespace from @s.
>  * @s: The string to be stripped.
>  *
>  * Note that the first trailing whitespace is replaced with a %NUL-termin=
ator
>  * in the given string @s. Returns a pointer to the first non-whitespace
>  * character in @s.
>  */
>=20
> Given that comment, I don't see a bug here. But of course we could add
> a test for it and adjust the function too. PLMK.

Did your test add a testcase for the situation described above?

--=20
Tom

--RtWH5g73AEanSukq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfa5QcACgkQFHw5/5Y0
tyz9Vwv9GQJZIzsCrV2h6OaZSVr1bNGJAQqKpvqPQ3Rn7HVtqxwXlqAB09dmRT2d
Y5DwyMGDtwrVoLpUArOngLIGnSGVAB/nBAsvQXNDkuh3N+PsZM3RLjlC93Sov2mS
dg9ElywYvXGKcVbt1n2/HSrva/ZrRThYsI5OXWlVxMf8MpxQguvbxv4cDKI5RxX8
CJ/sU53ynE8i6c3vexWunHXTl/NiETcmlE20LyduCuCGqXkzOQo1Y53AFAhUhKtO
bAimdVxHqbOVjyNk0SH7pcVZqDX+c2eyJtzkfWTVmIzlRZX3a2PJ7gm9YLP4jmNp
NmphhEz4gpsEQwdcIKzQ+C9zF2WRvQxr0QTUqFyRNRGaxZgZZk9zNN/AVHFHEqA8
Hq24/DccG9q5d5Nl71T1JjhqSGQP21TAXU4J2Jjr1KC9gonjNkyuE/0iulUUuP8q
twm5zfDwjueuJLqp0Jxzmdn4JTjSEvTOwKfIZERsucCqkI2eU0RI/lPrYKbTqh07
g7372KEj
=eCB/
-----END PGP SIGNATURE-----

--RtWH5g73AEanSukq--
