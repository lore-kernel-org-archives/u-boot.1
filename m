Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFBBFCB60B
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 15:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D2B83F00;
	Fri,  6 Mar 2026 16:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S3hPVWNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F347F83F1F; Fri,  6 Mar 2026 16:11:03 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2518C839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 16:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-677a11d11e0so3663260eaf.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772809860; x=1773414660; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RKyGVtcN3qEF27cHwrDqH7S/HELtFgELcwXwzdBJyME=;
 b=S3hPVWNYlbqVJW68Y5w9KLEbPxQtUSLKef7gmiq5YtWOs6kxgzbWIoQ4/r6qUEzNDE
 MLZhRXkc5UjV2LDY72K01hTnEOkuzJEPHd2E8yhlXbjMOIFShD0ruBA598ZEV4J1tcQb
 7v3HjufDNhLWe+ZR5T7eDRQ5MUK0t0bB5tV+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809860; x=1773414660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKyGVtcN3qEF27cHwrDqH7S/HELtFgELcwXwzdBJyME=;
 b=EsjvcAPAKRWGpFzhnl+imLCSW/5cWd9t2nxijOexUkDXbgTkhHY3K92Xno1sCch0ng
 RVZ83HaI39mJVqglhHdc0JpH5x593Uakd4is4nRu+h6xQKaMT/Nt7pqVOhYeK2l0Nhrv
 V0P3AQf6WLqqTR5GY/9ODNVanz9sKi3+nbFh0KwxFYM9FRSD2Bjscw9N3St2Zn/+JH+e
 qRhSCsaVr832Ff8RtnyXpXSxFE7kmh5Yw9m6ozhxuHJSqwxcO1iFnKIbveWNcVwOgyd7
 GBKKyAstJuvC1X1eE7e/xauGzyCw/obrB4RZYAWmi7lGqK8Uq0A8NDfqsllyJ2hJDpxk
 IcaA==
X-Gm-Message-State: AOJu0YwlabPXvn5YgwzKQqjo11QUXYvKACurbGcbrYkbAPk1q0pb4F8x
 eS6jI3IImJPco/rQXgPiV26LYppdUSm3lhpgVA1hz9xGhvxVB+dxlqtqiNB4NnGMsrw=
X-Gm-Gg: ATEYQzzNUdR2WgJxa63u0QUo/DowRDXANPgsogZVGWbXcDCVI5m6zsa0Cy5S11WRq2x
 AEjM0evoq5mTdHLenKtftw9sixskWfdJ4l6FIuVsdYiCfVSkZv4lMVzE78Iaoz5nsKsbrLpvltL
 HngtmQ+PWbSRMyS5on0vHQUZY6rhk5zmfBIPIZV+/nuAUNQ0+PL1I9MlD8AcwVXVtZSwPZ/ERI/
 bQDdT0bG4OhCP0mKO/gV5151tgvr7mG/wxQhnh+cuYn32U9m4k6HCvSiF1sNWeo1Mos1AuYrbvr
 hyd+Xn3yxzw/Z7rJitwlqxOo8VyvmQNOFqvZ4TKH69IxquAxJ4EBtJ6i8llLVhB2Lp3jpXz067N
 XzhJQMy+MDIiJ68fnfvEHfQ+ClrTKp0zU9sJZsRnM8ET4+ya823I5Un8gzX2KSqZ9hkNFjeEV0A
 QpEIeXliIv/o+VjNiVWAxksOmqEJKNGXg0OeY9/6aXg7iJnMQ3AV1SdW1EJ3GiTej0W3miF2PkV
 C8/EtpA2UThxLlstxdtjCvWwMU8xZkO0i2DMjfSyRHqlV/KsI0=
X-Received: by 2002:a05:6820:f034:b0:676:f174:9d07 with SMTP id
 006d021491bc7-67b9bca106fmr1561693eaf.19.1772809859780; 
 Fri, 06 Mar 2026 07:10:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67b9d460813sm956272eaf.7.2026.03.06.07.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:10:59 -0800 (PST)
Date: Fri, 6 Mar 2026 09:10:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Ludwig <ludwig.nussel@siemens.com>,
 Simon Glass <simon.glass@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH] boot: Add fit_config_get_hash_list() to build signed
 node list
Message-ID: <20260306151056.GK1388590@bill-the-cat>
References: <20260304135202.1535134-1-sjg@chromium.org>
 <20260305193802.GH1388590@bill-the-cat>
 <CAFLszTjC8m8XMSq0k7Etk3pH7KPdQJFO2DDifp0jhNC+zy4Vpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IRAtRpIubh7PApio"
Content-Disposition: inline
In-Reply-To: <CAFLszTjC8m8XMSq0k7Etk3pH7KPdQJFO2DDifp0jhNC+zy4Vpg@mail.gmail.com>
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


--IRAtRpIubh7PApio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 06:22:15PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 5 Mar 2026 at 12:38, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 04, 2026 at 06:51:48AM -0700, Simon Glass wrote:
> >
> > > From: Simon Glass <simon.glass@canonical.com>
> > >
> > > The hashed-nodes property in a FIT signature node lists which FDT pat=
hs
> > > are included in the signature hash. It is intended as a hint so should
> > > not be used for verification.
> > >
> > > Add a function to build the node list from scratch by iterating the
> > > configuration's image references. Skip properties known not to be ima=
ge
> > > references. For each image, collect the path plus all hash and cipher
> > > subnodes.
> > >
> > > Use the new function in fit_config_check_sig() instead of reading
> > > 'hashed-nodes'.
> > >
> > > Update the docs to cover this. The FIT spec can be updated separately.
> > >
> > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> >
> > This breaks:
> > FAILED test/py/tests/test_vboot.py::test_vboot[sha1-basic-sha1--None-Fa=
lse-True-False-False] - AssertionError
> > unfortunately.
>=20
> Yes, as the messages change. I'll send a v2.

Thanks.

> What do you think about the 'No images in config' message? I doubt it
> would happen in practice so we could perhaps drop it.

I think it's best to inform the user whenever possible, so might as well
keep it.

--=20
Tom

--IRAtRpIubh7PApio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaarufAAKCRAr4qD1Cr/k
CnLWAP4h0LqxCbgViNxsCx93fOMpqqej9S7PU7no8PmeCSF3iwD/elDXrtN6nHb+
4BJOx5BCFPx4BJveOKQH91yRShiqngs=
=sccD
-----END PGP SIGNATURE-----

--IRAtRpIubh7PApio--
