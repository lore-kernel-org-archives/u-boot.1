Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF1EE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 16:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5413C80269;
	Wed, 18 Dec 2024 17:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ChyvnGfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869FA80274; Wed, 18 Dec 2024 17:55:04 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8CC080241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 17:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6ff72ba5aso415939885a.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734540900; x=1735145700; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e6GQZCki20JKoOoMxGCNU+6zj3mPzGVs7S3uZDUgVjE=;
 b=ChyvnGfrcfkWCd8AUZEHNe6Vp2YgEfThcBeG8VG/ZtoCy/5s0b9JbnyYCACpmZnweR
 K4Gf0A9EqX9caNnyU08a3/VZDA+DlBXmegU32lWBYWBjE2CZq3xyWCjGU4jxyoG/mhXr
 +r7lJIre0dxVKBjg14jJvoeJUR9D71mFvZmCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734540900; x=1735145700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6GQZCki20JKoOoMxGCNU+6zj3mPzGVs7S3uZDUgVjE=;
 b=xLlm143WwxpmDFuK3RBCi7JTh74Iue3fDUbNsW3pRaIuhSiBu2/+BwDCVqTMRjo1Aj
 rnENJ5yp+MVE51lQkQJ+mxj01Qf1ZAiLIzUsi0vpMjjVlHt0D26btONWeHIQ3Py1gP78
 VRIvex0+wk8AkruV2TXTOwNKtccCqPxw0//Qb4cW8ku+v2JO0zfCms2QHjQ+YzB7L1TH
 dmu8VkQE6v6yqVOmEJzKksweM6SFSG3mWn0LwPh4QbVFf5j2bPeyegek/PwHsxFA3iIS
 W4k4a/J99EsOT7FcPi4O/cbeDXpYF5Ii7tlZu9C4+Sa9chENmbdRTkzUy3ZU1YRppESA
 g0iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrtRU/3gdj/rOuRALPiba3myb9ET8/ovdz5BrvUIDe4vObqp/6AvD+0dFRRn5Qt5F7Gtm3zyM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0AMhLio2NcKxisn67xlDmWY4Zpy4RGAC1jrkxZX/e9tg/8tbl
 hITnd2UyCQSucVJ2Iuu7bQ77uyA6ml4FE0C5ITSw7KjLDCHjLVYL2IQ/+EuaIbc=
X-Gm-Gg: ASbGnctrOLjMwNDe3Od1gQ9y25xYq2yITRtUx0kp8pkvHF8LhDFOYJ+YcLdNNR5I2AS
 yeqjshpnf9Un6PHE28oVm9erX7D1YSST93mHXzwYbifHik8MZCE/5qeiRyVzQHddoZ5ewScZurl
 QKDjYBe0leb8WZjPrRSmVDe4ncMGougHdEsTxGffm9klVgeEpjmPZZC2QqryGvAbenYwcsVZ/d+
 8iPQmvfer9KjJqNMmwdex7xsOCODvkr3kEe6ER6cR8wk53dd25apyz9
X-Google-Smtp-Source: AGHT+IFbQae7e6zZx8JyplpWRdQDYdyOy8q+CESLnjhAkOREpoK+fOnxDVAqRsriJKs0dfHTVEzyeg==
X-Received: by 2002:a05:620a:2699:b0:7b6:d327:cc47 with SMTP id
 af79cd13be357-7b9aa8b4f8fmr4514785a.8.1734540900635; 
 Wed, 18 Dec 2024 08:55:00 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047edf78sm442888585a.55.2024.12.18.08.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:54:59 -0800 (PST)
Date: Wed, 18 Dec 2024 10:54:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
Message-ID: <20241218165455.GH1505244@bill-the-cat>
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
 <20241217142527.GL1505244@bill-the-cat>
 <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
 <20241217195734.GR1505244@bill-the-cat>
 <CAFLszTidPRWQCeQ+fsyn_P420eK6obqtYu7=pHtxDHhxumVoLg@mail.gmail.com>
 <20241217202900.GT1505244@bill-the-cat>
 <CAFLszTiaWSAVc4_zDvPfLO2srSMqko9BzauxHAs5x3MPvY6Rjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YIC49hqfWGJzmHpo"
Content-Disposition: inline
In-Reply-To: <CAFLszTiaWSAVc4_zDvPfLO2srSMqko9BzauxHAs5x3MPvY6Rjw@mail.gmail.com>
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


--YIC49hqfWGJzmHpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 04:44:34PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> [snip]
>=20
> I'm very happy with your leadership. The project is extremely lucky to
> have you doing what you do and we all know it.
>=20
> In my own way I will be able to contribute to the project more
> effectively than I have done for the last year or two. So let's focus
> on working together within the constraints that we each have. I'm
> pretty sure that in a year you will be happy with the result.

I am extremely concerned that in a year you'll have a tree both has some
useful functionality added to it, and that it's built on top of so many
rejected patches as to be little more than a reference point for
bringing it to mainline. It will be even more complicated if anyone else
is *using* your tree. And the challenges you have explaining what you
want and why you want it will further compound the problems.

> No, I have not been paid for U-Boot work for more than 10 years and I
> doubt that will change anytime soon. A little empathy on your part
> could go a long way.

I am trying, and I will continue to try to. But I also have to try and
be mindful of everyone else volunteering on this project too.

This is why I truly believe the most helpful thing you could do for the
health of the U-Boot project is take a step back from coding for a bit
and work on communicating. Every big problem that you come back to has a
number of people saying you don't understand what they say and you not
understanding what they say. I do not think a starting assumption on
your part of "I'm right, everyone will ..." is going to lead us to a
good place in a year.

--=20
Tom

--YIC49hqfWGJzmHpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi/lcACgkQFHw5/5Y0
tywLaQv9HzD5AtRbekT1zjQCKvDVggxoLCYBGPSxsZq1BoI8X/6ScF6zXu62LGBk
UDbs5Cl/Dl14ih8H3RY/DSvMd57zmJUtX5RTskqzNoEKrIlTN8u9wgkbmdkav1QV
oo6gWbDNQGVcl2L3bgM4j9RqCmqKEa1Gym/LCt1ZnjKnE1sHRtXOz/saoD6Rkf8F
f+gIqx6NSePRl9QEiVNRIe52pQH9rdeYDcePj/pMKQ/F+SJnPLI/0qCdxDLlEJXJ
I/LZcIP9qfdXdHGW1OrammMSEygRihKzzQu/1suDfG/ugrrsBrdL1FUkO57b0bP0
ovqH9LAI6PBrfA72MLBsdLi2GZBb9Gq8i04Zei4yOOpDUGoy3R3WTTDRDjsycmJq
slK2Is/g4xLv3urhuFb1Va7vxWq5blZAWvGl/yOoOJnO59Wg15NJsjZRmAVm9+Fo
JR9L6Wl3fkvElmJZQ8QFvZ18dSs6Pm/n0GFboagNz/pjz9R3aH52eIxzBHUY7hQp
pCwFXuzn
=1eUI
-----END PGP SIGNATURE-----

--YIC49hqfWGJzmHpo--
