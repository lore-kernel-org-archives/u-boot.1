Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41678CDD1DC
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 20:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B3B28911B;
	Fri, 27 Sep 2024 22:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rFskVflQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91AEE89142; Fri, 27 Sep 2024 22:40:56 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DAF28911B
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 22:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb2824ddc2so19156196d6.1
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727469653; x=1728074453; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3dfQuxpvKY7VdxMCUZQYkYO7BLf9no3w1svRCLXuQB4=;
 b=rFskVflQBpoO8GOYIVdDM+B4DjeJm2MTm0pMeT74O+fIj3bt/WM8FuyY8PTXFhS1nS
 5czhmLiS/xjqbJOJ7mY+41Vfb0GSAtrQn+Pq+NpXfh6sjrhrHnXNUL2w+3nu9Vn/92Oo
 xBIb5pugEJLlSxMGH8qSDoTn++/+WZOL+svJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727469653; x=1728074453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dfQuxpvKY7VdxMCUZQYkYO7BLf9no3w1svRCLXuQB4=;
 b=Wxh7TgAPsgJE+HszI3LXIMXRk6pR58GRNiiny1Z7/oLwWZqISYTjo9zGUKmC5AQ5yx
 K2fio9xp3gRtA+lQH96JyCjvcjqs5PRVPFUfsljcT6cOj3JN38xN2t+3TWoFjG7rbteY
 DOAlon7K3jyQyX06mnSz9DkX6uzUkunnqwHQUO/NPjMjcimgeQgY5tEqXRjswOi9l2H+
 WpdTu0v9o/dq5/HiIlx6R4869mdVaP9bcmqqvlsug7zP7S7UkyTMAbz8MOQ8M4S7xyjY
 UyHaBaOExIR+GUz33rOBuCmg9TOUi5O7xR7J4xgxtYj7ahtsxYyltpPn3pnRQVEozbkN
 uk/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnjLbtn3ZmVyuSOC8bUDsbYAItpMKyi4SJSAENLnpgeOUgxcdkpN1XVv0/+yJRYrqy3/+F8g8=@lists.denx.de
X-Gm-Message-State: AOJu0YwLg4DJ9kQEta0LXuYoz8gVtW05u/Y2Y2t94aCsvoQaVCnFRVVb
 rBlRqDCK7dM0NESkjCDsZNxjzT3CBZEZ7Q7JPYTkVoMFnxrI1lX44/ybUnfeW68=
X-Google-Smtp-Source: AGHT+IE7YIlHpJTMGVh9TDAOONGoDefZ/asj5gzB5mu6wknd0PllFV7CGU5IorjkOOgbOngKI9xUtw==
X-Received: by 2002:a05:6214:2d41:b0:6cb:10ee:de84 with SMTP id
 6a1803df08f44-6cb3b5c12d2mr45919006d6.4.1727469652809; 
 Fri, 27 Sep 2024 13:40:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66ca18sm12450646d6.103.2024.09.27.13.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2024 13:40:50 -0700 (PDT)
Date: Fri, 27 Sep 2024 14:40:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 ian.ray@gehealthcare.com, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] binman: add fast authentication method for i.MX8M signing
Message-ID: <20240927204046.GW4252@bill-the-cat>
References: <20240927124237.47-1-brian.ruley@gehealthcare.com>
 <CAFLszTjHkmT0JcgcZ6Yn69q27Pe7YhvwuXc0bC0N+agmpPtCfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kYc487uz/O5FmdKf"
Content-Disposition: inline
In-Reply-To: <CAFLszTjHkmT0JcgcZ6Yn69q27Pe7YhvwuXc0bC0N+agmpPtCfg@mail.gmail.com>
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


--kYc487uz/O5FmdKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 10:50:29AM -0600, Simon Glass wrote:
> Hi,
>=20
> On Fri, 27 Sept 2024 at 06:42, Brian Ruley <brian.ruley@gehealthcare.com>=
 wrote:
> >
> > Using the PKI tree with SRKs as intermediate CA isn't necessary or even
> > desirable in some situations (boot time, for example). Add the possbili=
ty
> > to use the "fast authentication" method where the image and CSF are both
> > signed using the SRK [1, p.63].
> >
> > [1] https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-pro=
cessors/202591/1/CST_UG.pdf
> >
> > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> > Cc: Marek Vasut <marex@denx.de>
> >
> >  tools/binman/etype/nxp_imx8mcst.py | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
>=20
> Please can you coordinate with Marek as we need to sort out the test
> coverage for this etype, before adding more functionality. I did a
> starting point, now in -next, which should help.

Well, when someone has both time and understanding of the tools and the
frameworks, we can expand the automatic tests while still having
functional testing as people use the feature.

--=20
Tom

--kYc487uz/O5FmdKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb3GEMACgkQFHw5/5Y0
tyw2uQv/SKGKEN5wpJzRrxdGf4UZVfZ58Busrr0DpQkkuHbBdOORv1T8xjYSY4Oa
hL6obPm16IUYMAIeNb3+og13GOWvo3oR7xFWpmaTAVTYLxH2wkMa1yi6HDNGwD8o
aPEEgWduEcuXXXV9unh2maEUEK1KPyg5mFolfb6427CvG7hrt7RW5V5fb8rF1VTa
sv21aO/JeQk2LPgrHvtqywJ3o0GDLR42rG1APjhKi6WWEBlvzL6lcM854/pIORZp
BH8Qu1TpsFXKqux2JsF25jMP/O6SwDTdYq0+EmYyDc4PAqdgjN5aCwHrqQWZk10a
5+NmxQFiZD6IiOdFu6umb4yhqcflzsOBZMeEbpt7+dedz9GpQYxPEXabgl5yZIim
1kyvzKxAEWafEutj+HM5FvswHQriwIzPfVG0EWoExT9Yk4Uc7ikmh2Y6fTwWaGC+
bcXMtjzf6oQctzUgZCucutxK3zOwk8acoZR9g9mmJEyJeWZOoVsFnDVBqZPGRx5a
QDSeeX94
=AUQZ
-----END PGP SIGNATURE-----

--kYc487uz/O5FmdKf--
