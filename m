Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE21D0E6ED
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 14:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631D58404D;
	Tue, 25 Nov 2025 15:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aevl7NE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA028408D; Tue, 25 Nov 2025 15:16:29 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9534828A2
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 15:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-450b2715b6cso2639202b6e.0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764080186; x=1764684986; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1W+rYoWW+2N3vE958bKxG/QcSh8LfXvA+IRQl6vSbBo=;
 b=aevl7NE64MmHF2KX8ilFA04khLgfXati5UWQ/3IuEzxYWfanjn388IFlYjLeT9s1qp
 AeN/+6Ydcu7fC5NorK2wByGcDy7HG4ZNLSeWR18rrxCJq8xKvrqaLK5bTN/Yny7Um0Kg
 c9dOyvslZAszvtT/vX3IExqZMCADJFtdZZdkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764080186; x=1764684986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1W+rYoWW+2N3vE958bKxG/QcSh8LfXvA+IRQl6vSbBo=;
 b=ltui2g7JeoiFmDQVpzOChO2e7YGKg7nzJeYiSO46GtMxCe3wMRa2+rv+iTLZoLmNPJ
 oAIkRykcr1J+pl8hKNSAyVED2nyxWTIzwdCrFImb5GZsmeLk60UwpuyMCB+9bf/az6Vv
 jq95GqAwYU8nkcVKnqqrlQl6dE9zl3iByyS9cIx+pP3gGKRNAd1Kv4dVw7Cfs1dHXFmc
 NNGkA/a+n1FeT3V/EGXJoYAQ8YQ3jK3dbx3HtJbyvtMXdCt+EMQBvpMMm4KY50jcRo8F
 KXOam+fm0ZUZ8VAsbEgnNC39UFSn0LOt0WXoR4gnSqzNf1gqdzgn+yZ6MKWBTP4bBLL/
 x/HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGWUEbVefP2yw8/kjqInpNv01UHW4P7eNyjfzRHmIZM/zOiVbF7dVNmFRG1drDwuzDcDxIJEQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwNfgrRjJLJWxNrUoPdoxGsZchV8ISW5rQs8dODaUXFkKW2DH11
 e0y+B9p8myfB4p0uEM1sBfpAXcExYYvgU/0ZJjvdV+7kEc6Rz2wtAPD0wJbCeKgN5j0=
X-Gm-Gg: ASbGncv5VqzIBDGwBFiwgA3166MGEWAbss30GM4HNgNPUPvx6FjlEFTQdjqEutLJ3gQ
 /LjCkZcocffhcef1U874hpdZVs/uwgESD8Ze096jWGDEH/m704POtpR9m5KRj7i6DRcWIyuPIK7
 6xgfFqftgTbtxWza/VhBSZZvWxfYscTdX8hibyO/yOha3PbvLPVbXc9gJo/ozZ3Zpro8Axq6Goq
 Z7bgCIdvLNx1MjCBHDOx7F9kOdYAD3x9E7934/1ofO+xVmX4hg6akHAvsMma8IRGsk76osfw6y3
 0B9s7lkYiIdDQiHKg13JAK/5UsOtKOCpw3UCJ7cCLkopWqk5SjBDagSRnWwzczmCwcL9iJNWcnl
 JIhD+QGPpLi6Fr8sK3fVY/C+/xseegN9FXuHKuTI5q0BtqfO/1G9pC0NZQ85xerrdHXZJfGyRW+
 qPlW7sRA/V1TPL27u/V5ari7yBXPSUQYF/kzc02QAQj0E9zlub1Q==
X-Google-Smtp-Source: AGHT+IEoqa14ndq2K94Np64Ypelr4OrVSotrmoN8LMyNLFSAHl5jmplWWDy9M1+HYm0yh4Ukyxqrfg==
X-Received: by 2002:a05:6808:2225:b0:450:5aa0:3681 with SMTP id
 5614622812f47-4514e5fa49bmr1313742b6e.4.1764080186380; 
 Tue, 25 Nov 2025 06:16:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450fffbeb51sm4648270b6e.18.2025.11.25.06.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:16:25 -0800 (PST)
Date: Tue, 25 Nov 2025 08:16:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Carlos =?iso-8859-1?Q?L=F3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
Subject: Re: [PATCH v2 1/2] test/py: fit: Deduplicate the test
Message-ID: <20251125141622.GP2125796@bill-the-cat>
References: <20251124194201.83326-1-marek.vasut@mailbox.org>
 <cc5f03cd-6caa-4129-a4d9-b502e9c61990@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nCDb1dur/Pbrs5tF"
Content-Disposition: inline
In-Reply-To: <cc5f03cd-6caa-4129-a4d9-b502e9c61990@cherry.de>
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


--nCDb1dur/Pbrs5tF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 11:50:19AM +0100, Quentin Schulz wrote:
> Hi Marek,
>=20
> On 11/24/25 8:40 PM, Marek Vasut wrote:
> [...]
> > ---
> >   test/py/tests/test_fit_auto_signed.py | 98 +++++++++++----------------
> >   1 file changed, 39 insertions(+), 59 deletions(-)
> >=20
> > diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test=
_fit_auto_signed.py
> > index 0b5dbd5401c..3895e7d9369 100644
> > --- a/test/py/tests/test_fit_auto_signed.py
> > +++ b/test/py/tests/test_fit_auto_signed.py
> > @@ -138,6 +138,29 @@ class SignedFitHelper(object):
> >   @pytest.mark.buildconfigspec('fit_signature')
> >   @pytest.mark.requiredtool('fdtget')
> >   def test_fit_auto_signed(ubman):
> > +    def generate_and_check_fit_image(cmd, crc=3DFalse, simgs=3DFalse, =
scfgs=3DFalse, bl31present=3DFalse, key_name=3D"", sign_algo=3D"", verifier=
=3D""):
>=20
> I would have grouped variables for the same "theme" together, e.g. simgs,
> scfgs with key_name, sign_algo and verifier for example. But that's fine =
as
> is.
>=20
> > +        """Generate fitImage and test for expected entries.
> > +
> > +        Generate a fitImage and test whether suitable entries are part=
 of
> > +        the generated fitImage. Test whether checksums and signatures =
are
> > +        part of the generated fitImage.
>=20
> Would be nice to have documentation on what the parameters represent and
> what this returns/raises. Not a blocker though, I see we already don't do=
 it
> for other functions.

Enhancing documentation within the tests is usually done when someone
has time to add it to doc/develop/pytest/ and so yes, doing it later /
follow-up is fine. And I still need to experiment on what's needed so
that readthedocs generates the output correctly, and not just local
builds get it correct.

--=20
Tom

--nCDb1dur/Pbrs5tF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSW6NgAKCRAr4qD1Cr/k
Ct70AP9aV4ZNxJ8KdZFGmZaHF5m2C8PUayqeApL87xOK4pw1WQEAysaUM1WgA7vJ
n3RI9EEki78exO3xk0F5UvhO/N2rfw0=
=tOLI
-----END PGP SIGNATURE-----

--nCDb1dur/Pbrs5tF--
