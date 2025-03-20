Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00D4C35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E9380540;
	Thu, 20 Mar 2025 15:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VCtGyV7d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B008806FC; Thu, 20 Mar 2025 15:15:25 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC8B8003E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225fbdfc17dso12815345ad.3
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742480121; x=1743084921; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3HhWKEMwNyF6DSt48zmLxTnF5wFbeeYu6viqvpUyD4s=;
 b=VCtGyV7dUJBW+JiBf2ue2jdAWP2o3XfM2sdZM2HNQ7LrPQUcx+0ZOV93RVvbQhNJ/c
 uZZhDbmLiG6aDwX69p49BxvXpwkA+CeRi8hQGSygQIZZK3WQ/mEkkUt05cDqAfnpqgin
 yFxNQSOoxrp0M8AfMy7CdleDAxH9Q0BkLdkwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742480121; x=1743084921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HhWKEMwNyF6DSt48zmLxTnF5wFbeeYu6viqvpUyD4s=;
 b=NdaxoYzH8wp23n1KX3LGSdogRvpGv0iZSEnTl1Ko/zyl1F+XqfF4EvACHtGejzds2t
 ++E++cDCzdlKZnujceMjnn7X1Hc/rohlmL6fTrV6BS/OwMmB5+t/ubBsuDMGj26ufvAZ
 U9D9XFT0u7d0BK2t9Ba+fB8E1OeSjFssob8NrIowvsRawDDp4pa7GxzPjvgvnKJYkgYO
 WcmTvbH6hsxEhkEtgmO9uxNQszY+CDtE4Yiedeuy+oinkPMhfWLWzW+MGLAigXsn8uNr
 W0AAk0MZEuCm7cFNN/2JWT2jELmEGS4IpguVNTJrzfe+2sxJrpx20co70rvP9xyJSRot
 /mQA==
X-Gm-Message-State: AOJu0Yz4peW8HpVQZoSY2CHNep9imaFrGmlRVdFnBsUZOg63sA3KlbVW
 ij5mtHCE99H3dEWgQfrcZ8HuvVdSQU8nhgvQu2fOt0+sUyvQoDfgJ2gu8k7fcetc1W2fOZj5vuK
 w
X-Gm-Gg: ASbGncth6zzc+8j94KuuoKMvigPZHd91FhigO1Pi4JznbjAri28QZQRlpxiLoXnSPnw
 yzE9foF/PMMx55EtSI1vaojzg4L6srkw1IAYaRU1UYcWfKhngUzXM+dlkWAqOhHGXxdxyNDAG+z
 lD3qMPMlagXe6LvPpNnZI581yBDGWZjPxjW93596fOecyhUmLXQWi/vZe3OW6/Xy9a+48N1AQmO
 6GoP17oRYFYVU+8yUlgntLrTd4GBSCrTuV7OBdGz0+gtitPihJxeRCSk9WLz3SwLLT3ouKzA4RO
 gYVd1aKVotuaWj5qYnBQScnUEHtojjNJSXSQlFOkjWvj4Q==
X-Google-Smtp-Source: AGHT+IH7uybmUde9pxQSyFmAG/Hp9mV7fE1c+aVRlyqXR59tAP5/5SjwLGhPAEXnc0b7KaytEbIkDA==
X-Received: by 2002:a17:903:1a23:b0:220:c911:3f60 with SMTP id
 d9443c01a7336-22649c94744mr99368825ad.47.1742480121321; 
 Thu, 20 Mar 2025 07:15:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68883fesm135858395ad.6.2025.03.20.07.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:15:20 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:15:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/6] test: Add a test for strim()
Message-ID: <20250320141518.GO2640854@bill-the-cat>
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-4-sjg@chromium.org>
 <20250319142438.GF2640854@bill-the-cat>
 <CAFLszTjG-uhXLWE7+fWZtHLfjns7oAEqcxr1Q2NNgVnFaAUH=A@mail.gmail.com>
 <20250319153847.GL2640854@bill-the-cat>
 <CAFLszTgZV8A9HcmS=3nHdz2M_+eGLdX9qnEnYzJAEJ_QgoWSxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RUZfgY1022C8buq1"
Content-Disposition: inline
In-Reply-To: <CAFLszTgZV8A9HcmS=3nHdz2M_+eGLdX9qnEnYzJAEJ_QgoWSxg@mail.gmail.com>
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


--RUZfgY1022C8buq1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 03:43:30AM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Mar 2025 at 16:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 03:04:16PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 19 Mar 2025 at 15:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Mar 19, 2025 at 12:59:05PM +0100, Simon Glass wrote:
> > > >
> > > > > This function trims whitespace from the start and end of a string=
=2E Add a
> > > > > test for it.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  test/lib/string.c | 31 +++++++++++++++++++++++++++++++
> > > > >  1 file changed, 31 insertions(+)
> > > >
> > > > This got me to ask "What even is using strim and where did it come
> > > > from?". To which the answer is:
> > > > - A few places, but it's probably reasonable.
> > > > - Linux, pre-2011.
> > > >
> > > > I say the latter because we're missing a bug fix to the strim funct=
ion
> > > > that's been there since 2011:
> > > >
> > > > commit 66f6958e69d8055277356d3cc2e7a1d734db1755
> > > > Author: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > > Date:   Mon Oct 31 17:12:37 2011 -0700
> > > >
> > > >     lib/string.c: fix strim() semantics for strings that have only =
blanks
> > > >
> > > >     Commit 84c95c9acf0 ("string: on strstrip(), first remove leadin=
g spaces
> > > >     before running over str") improved  the performance of the stri=
m()
> > > >     function.
> > > >
> > > >     Unfortunately this changed the semantics of strim() and broke m=
y code.
> > > >     Before the patch it was possible to use strim() without using t=
he return
> > > >     value for removing trailing spaces from strings that had either=
 only
> > > >     blanks or only trailing blanks.
> > > >
> > > >     Now this does not work any longer for strings that *only* have =
blanks.
> > > >
> > > >     Before patch: "   " -> ""    (empty string)
> > > >     After patch:  "   " -> "   " (no change)
> > > >
> > > >     I think we should remove your patch to restore the old behavior.
> > > >
> > > >     The description (lib/string.c):
> > > >
> > > >      * Note that the first trailing whitespace is replaced with a %=
NUL-terminator
> > > >
> > > >     =3D> The first trailing whitespace of a string that only has wh=
itespace
> > > >        characters is the first whitespace
> > > >
> > > >     The patch restores the old strim() semantics.
> > > >
> > > >     Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > >     Cc: Andre Goddard Rosa <andre.goddard@gmail.com>
> > > >     Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > >     Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > >
> > > > --
> > > > Tom
> > >
> > > Here is the comment for the function, of note given Linux's disdain
> > > for commenting code:
> > >
> > > /**
> > >  * strim - Removes leading and trailing whitespace from @s.
> > >  * @s: The string to be stripped.
> > >  *
> > >  * Note that the first trailing whitespace is replaced with a %NUL-te=
rminator
> > >  * in the given string @s. Returns a pointer to the first non-whitesp=
ace
> > >  * character in @s.
> > >  */
> > >
> > > Given that comment, I don't see a bug here. But of course we could add
> > > a test for it and adjust the function too. PLMK.
> >
> > Did your test add a testcase for the situation described above?
>=20
> No. I didn't know about that case. The function comment does not
> suggest that it handles a whitespace-only string in that way. In fact,
> even the Linux commit which changes the behaviour doesn't update the
> comment to mention that behaviour.
>=20
> Anyway, let me know what you'd like to do.

Well, being a function we borrow from the linux kernel, we should follow
how it works and backport the trivial change to match how it behaves,
then add tests in 2/2.

--=20
Tom

--RUZfgY1022C8buq1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfcIvEACgkQFHw5/5Y0
tyydTQv7BwIACDycV3RHyTFXUghbsfJjuucvMqL7F8AJ5pbrI+yygvzA40/PXum2
YWGMqgGez8w15np9UvD72ETkXtMVNYrpgRyCDZ7lJiiGhWFiQroHO/0vyDpKC3yB
BU/fkKxreqbPYWg7LmiwU1mdG837MBp5AYJZBD83zTMjuIRLRhoqE6Urr8MrNJZP
BjRlupzVT7zxR88byIDgwwXV4rakJkvxvY7AqYWmn2JsSW2hBT9wD+vf/nF8+5uJ
ba9lAMYjHwjUZbaLVDlj3UxqMSDkJNEFNIxC0bhGQpaBXFBKZJUK4L5PT8RPVghW
hQy7muT62h1GVjTRxh2YyGdVHEI751SGLR9sJa3Y2r1MMdl81yG0mTk9RWdKgrk9
xSrqTf2JnIk/eDXqXMm1ivdVC7UQcA3VZ0YOwurjSambqkJQayzj1tkrL3cNZmbS
tWK2gEvyhE5k56bSj7zS4FQ1wB5ma/vok6AuYQN8qLxmIzzhnGbKFzeQQ1UxoLGo
CeZuftW3
=pi0d
-----END PGP SIGNATURE-----

--RUZfgY1022C8buq1--
