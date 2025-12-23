Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB40AE6FE26
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 23:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0ED8418C;
	Wed, 24 Dec 2025 00:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iirv350T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AB3584199; Wed, 24 Dec 2025 00:32:11 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F6384166
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 00:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3f11ad6e76fso4595608fac.1
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 15:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766532728; x=1767137528; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/FrUkK2VXmAOJlIn9I0WHVwBU+ifYMbUP/lcPnjzFl4=;
 b=iirv350TuKAUoF9elUmBITjuOubvDm1AO94EV7gnAGWAmv1h1zwaQEM5nP2Rv3tv7E
 fkcNxHz78COBeqx/YRsMG9QEFjqkhBZ5f3/hvFJbcDaU2F7GPPiWVcKzSYwMrOoMfP5U
 MYnJANFOqWiWaASKjS4GjxPS/Gg5chJfVB9xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766532728; x=1767137528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FrUkK2VXmAOJlIn9I0WHVwBU+ifYMbUP/lcPnjzFl4=;
 b=wRAGp1po+Tc41AoUiUtGoQqL7y9zu8gTisPKnURhtUANz7Co/kII3kpRIccYq5j2+z
 bJZtDe1cdIqocPu/WHqqw33RLBoQiN9yMRhscQqdPszXYOHzwxQmlg1CuJUYXU8GVgWf
 GGviIf26ebT0hs3jYrcWHd+hy7C/TUx1AMEVkStRV2vf/2bnmh2aOGeKlJCoO6g0nqxh
 IeTExP8i2n2Gn4e8YU1zW6tX1J55Ml5Zr3yXQgBONwaRgx52Rq4bP3fXFj6DZpcjvUvQ
 IPFd+A8oVxj4NPUcci+OuQtbgBSstD3E6rYEtWN4EVTGQAKrycN8Ljcn7uzvdOrQSM1p
 v88Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1YOasFtIbMNy+1kK7fLDMtFEx3Amc6oSN6X9spBjeubDsV3kv+fzZGdtHwjG2CWG3CRRKdRU=@lists.denx.de
X-Gm-Message-State: AOJu0YyFFbO5kGPXW/IzZKcv6/nkdawmdvPSqwwbTeiC6bvgFnzcu6j3
 QpUP/OQYPRfuQYvW5lmpfhPQmMgGzmFRuiw2qNdA6g/r5JS+vcBusJFDyOkBJkpjeDo=
X-Gm-Gg: AY/fxX5JN4ieTSwrxNOZhX/qyYUphLeibyLWgsY+O1pw5bek9lmeTlRlsCeK/mZVsjI
 Z6bOLaPNARijhNHyVXz3HGmnOLfMmUmcQHAGQxeOyoL4wT4d79KDrAJXdxGcWZhO/9pwWQ07sA0
 MlqZNZ499nOe102l6gJBTbfpXDgDctcLnjlCq3A4eLIzWAEsuYCJKUJWxZBN7kne33Oig134FGb
 jVR9aScysYqZZaj5Qe1niaQL8dVCvGDod9M5UyfbxWnXUh3rlfbor6CGvyyC+Flfu9rybPfekiV
 u0w1A/n+1NtFljr9lFG8l5mi7VlOo4h+e3D/hSwMYm+9NHxH4ejRQd82KIuMtc8zkqMqOgEw8Fh
 OmlVZ/Q5l1OZOn9UPZaHPN7OqRYcXRxtd1weYSHJBo4vEDBnZfwJCIdsF+wJUsf4+ZSr2Bvyfca
 xIJ0PhZcgRc7HeeF4ZtLtx673j8lRUfFr3lgA7uxtfu3lRY1Tlgw==
X-Google-Smtp-Source: AGHT+IEH1fAeY/vmnZNLBBHsbTetvxM4KOO6ql19HfL//fBHXvFQCNQ5TcTV5t5+gBD300SUkmKLCQ==
X-Received: by 2002:a05:6820:1501:b0:65c:fa23:2ceb with SMTP id
 006d021491bc7-65d0eaf35b2mr7443241eaf.70.1766532727926; 
 Tue, 23 Dec 2025 15:32:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f4cd66csm9061405eaf.7.2025.12.23.15.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 15:32:07 -0800 (PST)
Date: Tue, 23 Dec 2025 17:32:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] test: env: Add test for environment storage in
 SPI NOR
Message-ID: <20251223233205.GG847766@bill-the-cat>
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <c31bd8b3-2604-4193-abba-6815845e8967@gmx.de>
 <bb3d1ff2-4cc1-48da-a47f-3aef44277791@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0mQJQfFDzUZ79e7F"
Content-Disposition: inline
In-Reply-To: <bb3d1ff2-4cc1-48da-a47f-3aef44277791@mailbox.org>
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


--0mQJQfFDzUZ79e7F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 07:55:45PM +0100, Marek Vasut wrote:
> On 12/23/25 6:32 PM, Heinrich Schuchardt wrote:
> > On 12/23/25 15:31, Marek Vasut wrote:
> > > Add test for environment stored in SPI NOR. The test works in a very
> > > similar way to the current test for environment stored in ext4 FS,
> > > except it generates spi.bin file backing the SPI NOR.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Jerome Forissier <jerome.forissier@linaro.org>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.denx.de
> > > ---
> > > V2: No change
> > > ---
> > > =A0 test/py/tests/test_env.py | 99 ++++++++++++++++++++++++++++++++++=
+++++
> > > =A0 1 file changed, 99 insertions(+)
> > >=20
> > > diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
> > > index 383e26c03b0..48e31f19b3c 100644
> > > --- a/test/py/tests/test_env.py
> > > +++ b/test/py/tests/test_env.py
> > > @@ -457,6 +457,26 @@ def mk_env_ext4(state_test_env):
> > > =A0=A0=A0=A0=A0 utils.run_and_log(c, ['cp',=A0 '-f', persistent, fs_i=
mg])
> > > =A0=A0=A0=A0=A0 return fs_img
> > > +def mk_env_spi_flash(state_test_env):
> >=20
> > Thank you for adding the test.
> >=20
> > Unfortunately pylint doesn't like your code. Please have a look.
>=20
> Is this something we run in CI ? If so, CI builds did pass.
>=20
> If not, how do I trigger this ?

We only run pylint_err not pylint in CI. The "make pylint" target has
been unused for so long that the baseline itself is out of date. I don't
object to trying to improve our python code to match standard practices
better, but this isn't the place to start adding complaints.

All that said, a newline before a new function is just a normal good
practice and so at least the quoted here example should be fixed, just
like if it was in C :)

--=20
Tom

--0mQJQfFDzUZ79e7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUsmcQAKCRAr4qD1Cr/k
Cj4/AQCs6shwMi7DiOPU064/bOk6BkmuvcuTMW7B3j14iiFo3QD+O5CFjU05JdK4
twZ9X4fOMHpsMERccjUWxowsymiF7gM=
=/Cx0
-----END PGP SIGNATURE-----

--0mQJQfFDzUZ79e7F--
