Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29C4C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8605D80EF4;
	Sat, 25 Jan 2025 23:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VfXgTIvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B61080F10; Sat, 25 Jan 2025 23:58:04 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DBF180ECD
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-467a3c85e11so24047251cf.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737845881; x=1738450681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xG6pLucJtntzxF2wkeN0I7HTF6aQUi2yFcQVIXjqypk=;
 b=VfXgTIvOsorp6YYLlkpu8sZWFelpebTCSvIIAvg+0WqE/WlZmELIEFMHAb1gQyGugk
 GnE4T0qrc/5uF72UAstp3TWJm2ZNUxUkT2WgHEriWXjm9Rz4BcaQL90ConQtNK+x3Aiw
 jSzZ/dpMItAgamM9q1f5oUBOsnt1IzZGSHgK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737845881; x=1738450681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xG6pLucJtntzxF2wkeN0I7HTF6aQUi2yFcQVIXjqypk=;
 b=CLUMyD/l2CdxhTgGP0wvWUq6jYrMLggyP3BzdYIUTXDjYdyXS4VNZRspdR1XE9Ogfq
 /mBpo2l9mez64RuLM5qu8KTO7ibNucJjPCUaqd6ytYJDBlpLJCkRcvssu+Fc28dp/fWZ
 jPXuLQanitqn9gwpwdkqhb9lmDmlS5FTB7CATJtDlIpVYhJ4k07URPNkEx0atpa6JOfU
 tAJJ4DQnbHIwLq5c7ukE3BAEuHFyzITOZ/w7+PyzB10Ek6kaGRdbMuljaZXBNmoOOfF1
 y60yWEaNKIBZidRt2QF3/LdrKsUSQjEFo0g59+RQ68oF3FrVDQf7axbiWTYqVQxCX6FX
 uksg==
X-Gm-Message-State: AOJu0Yy9AR72R4qKbokVRhNN18MAoC/C3oqHzLchaZnR4UZvPKFLnm5l
 EarXxhMddZAmj8zvbHfGaUf4cWzEuA9DMhe1YHtpAHAWYM3XEzRQR+b0ioK2SSY=
X-Gm-Gg: ASbGncs8u9r7bCCpy0LeGkUJiU0Mxf8UhDmAJY2crqLitqgVEzqhhFvyad6foBQEj0j
 KGVUT3rIn6ir5pKfWLqNzyKCIkkZwUfuFyHyuHDH1cjf5g4gZItAKuj297JHkUE7MZXhDXA5ZXh
 en0FVXRWrd8bbVMxaKa8skIfvo9P2XitTxKS2nqmI/dZ7GcivoO8YD7RsZ0G0Je+ev1ejL6JzJf
 BE8sVewDgpTPndPFl5NeTOUmFSMOwYtY5VcvoGTzi70fD0lUyPCRMRzKCKoYV83JA5m7UZfy2DY
 jE18
X-Google-Smtp-Source: AGHT+IGwqNKYgxX9VK8VxFTNcTkDed1JSdqBV1w8hnhvCDPSIKQp/vGpC+JBLknpGzUMX3d8QR54oA==
X-Received: by 2002:a05:622a:549:b0:467:86a9:f7d4 with SMTP id
 d75a77b69052e-46e12a55d3dmr572404061cf.16.1737845880829; 
 Sat, 25 Jan 2025 14:58:00 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b690d0sm23943731cf.62.2025.01.25.14.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 14:58:00 -0800 (PST)
Date: Sat, 25 Jan 2025 16:57:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, Richard Weinberger <richard@nod.at>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 2/4] test: Drop u_boot_ prefix on test files
Message-ID: <20250125225756.GK60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-3-sjg@chromium.org>
 <20250125214613.GE60249@bill-the-cat>
 <CAFLszTgYPNxmiO=agM+MUp0da_6q3BBro74bWEnNbqeM-tT=bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tEvMUYK2ormvG5s9"
Content-Disposition: inline
In-Reply-To: <CAFLszTgYPNxmiO=agM+MUp0da_6q3BBro74bWEnNbqeM-tT=bw@mail.gmail.com>
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


--tEvMUYK2ormvG5s9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 03:41:43PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 14:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 02:31:37PM -0700, Simon Glass wrote:
> >
> > > We know this is U-Boot so the prefix serves no purpose other than to
> > > make things longer and harder to read. Drop it and rename the files.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > This is a massive bit of churn and violating namespace best practices
> > when it seems like we really need:
> > [snip]
> > > diff --git a/test/py/tests/fit_util.py b/test/py/tests/fit_util.py
> > > index 16ff8c96c63..7aad4030be3 100644
> > > --- a/test/py/tests/fit_util.py
> > > +++ b/test/py/tests/fit_util.py
> > > @@ -5,7 +5,7 @@
> > >
> > >  import os
> > >
> > > -import u_boot_utils as util
> > > +import utils as util
>=20
> The real namespace is the one in site-packages, where you are supposed
> to put things in their own modules. The Python tools operate in a
> proper namespace, but so far the tests don't. They just use whatever
> directory the file is in. So, for example, we have:
>=20
> from tests import fs_helper
>=20
> where 'tests' is the subdir in test/py
>=20
> One option would be to move the pytests up a directory, with test.py
> in test/ and the other python files in test/u-boot and the tests in
> test/pytests or something like that.
>=20
> Then we would have:
>=20
> from tests import some_file (*)
>=20
> like we do in tools
>=20
> Also, I wouldn't call this 'massive' churn. Most files just have a
> line or two changed, with test.py and test_ut.py getting more.
>=20
> >
> > A lot more of this type of namespace shortening which I believe is the
> > normal Python-way of solving this issue.
>=20
> It doesn't really, since 'util' might conflict with something. When
> you have a set of related Python files, as with do in test/py it is
> better to use a namespace. But even then, I think we would want a
> shorter name.

Yes, I suppose I'd rather see (and without the ubpy rename, one thing at
a time please!) moving files around such that we can then do more normal
"from foo import bar", and also avoid the silly thing of "import utils
at util" ;)

--=20
Tom

--tEvMUYK2ormvG5s9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVbHQACgkQFHw5/5Y0
tyyArwv+J4FdcPX5dfnm+BVslYuFHIV+cBj93dxYqOjBIHn2ELrti3x/7k9sAl0u
8BTrWv/RceBP91kHGC6QfoYVCo/cTqcLSM/W1gp1GEQNQso+TKP8J5KjzvJBtJCd
KOQNOyg1qqRVgZsFNGNFVyP0ZBKfdt+sAg47sesLktznhjySxRRlssd4A3yYpVZA
2i4aqhscE/B2p9CeJuwUbGVduY+AqOxPAf0I49NJiNQrR2hZHSJg7wGJvcxhQVh1
Ju58w69Fh19IlNmVls94Ga6kVIyHZ1iALrDKC0hZ3EYKNvglUa1xpJPNcfuC0bCX
++l9etqhe/QEqfGPUt5HOwQIpC3fmAUYcXJpn5ZVjjj3yCdPYOyCJMqQKmfKARa5
vqZbXnMeEcWXZAYgkZe3UWyRh49tlqbbwCYZsbXlMJXG1TrA88cCs8DEjL7HPD0z
MB4wvHcZ1zZUIpuQjfvkyDrdrWdgEMxIkIGhPt2oa7+6e58HDFwvYgSq3O2XCuEx
lSLfjzKg
=8cgD
-----END PGP SIGNATURE-----

--tEvMUYK2ormvG5s9--
