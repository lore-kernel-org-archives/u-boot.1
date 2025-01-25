Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9308C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 21:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3657680C91;
	Sat, 25 Jan 2025 22:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n/mPvlvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883F880EC0; Sat, 25 Jan 2025 22:46:23 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AC580836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 22:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b9bc648736so347886285a.1
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737841580; x=1738446380; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ff9vtxJssfhiNO8ZJoORqOpx+spxAhsUHyDi25hzMxE=;
 b=n/mPvlvOXup1+tOI1TjwmtPwbLJxWyAoMbmpWbv8qYc6aiL/O5QvWHX9wPmVLwWFHX
 k6E+5Zii8uSEXRMmAwBoWf0/6QtUztAsvVfmnok3gE0juIPSJ14Tc+8YTJxwvNgQST84
 Vw9wy7u+v9TJpA6yzOpucqvMw1tvYdVy/YsUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737841580; x=1738446380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ff9vtxJssfhiNO8ZJoORqOpx+spxAhsUHyDi25hzMxE=;
 b=hsLItah+TND0bHCKKWcO2zR12El4zlOS8kwRLalIPeeHnRJxv41ITqHvU15rdK4d1b
 KSh8c8NHvbTilIoglUOi9CFveXtWxQZYKjuBoHM1Xel1d51xxPP4cEE8ngKVbW2QCbnT
 0sHp0Pa/WFM4jzDp12OVDFXJyQi1B9RiHfrLWILVyg8Bl3fH+B3aUAhOy7EBfviIs0AH
 gy0iLFCdbP97bGST2184amhsBhaDxTuThUpRwjBsFGZpYYlJngOpQ6rxaMEVzd20mQQC
 n95evF+am3bfvIq36TzFE85Gnsoo9cPlSec1JSOnPOiYNmCJE3YIKur7Mx0crYsvHhq2
 uXHQ==
X-Gm-Message-State: AOJu0YxzcRHXPp1C4ag7DiQetAy56pVu4NsAxqBEgbaK4Cp5vO5N889v
 /i/aR0uEsFZD536t4dxCiYOrcdu0a3vZKxEs1Dsypg1fWzMuYkUwbc3mPHYDxzs=
X-Gm-Gg: ASbGncsw2AEmJLnqLczijO4ud5MU+18GraPCrWJI33q2FnjUWRU6M3pN1upFkpJDaeO
 jnVX15LfHYOygt6LzwUvwOCGP7jr+wen2OgsxSTip6MY1Gqh019WcI3PRfuDrdnOGojV067gJC6
 cCogr/MTY0Q4jJ+hAlkrS2pVrc8y3Q/AE4U608jN3fhuKWJ7Fcr+qJloLhP6VZ3jukGm8azA8A3
 DV2yIpg8XRQQbiGVNmdlpD4fNoR1kOuyEZFkHcGs8BMD5se1Vx3mT0fKkWuO79yObZlB1NJG6/X
 Ndrd
X-Google-Smtp-Source: AGHT+IFNpfe9/qS3UTNUEL/FRWDQ5ACIN2jBS7zboDQFzTkYYTrpRyOMVtoSG7irzOLYJbEpMS3onQ==
X-Received: by 2002:a05:6214:ca9:b0:6d8:ad28:adbf with SMTP id
 6a1803df08f44-6e1b21a0c5fmr520886856d6.20.1737841580083; 
 Sat, 25 Jan 2025 13:46:20 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e205ac44d8sm20898206d6.122.2025.01.25.13.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 13:46:18 -0800 (PST)
Date: Sat, 25 Jan 2025 15:46:13 -0600
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
Message-ID: <20250125214613.GE60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d5Hcx3HAMxqlCZ81"
Content-Disposition: inline
In-Reply-To: <20250125213150.1608395-3-sjg@chromium.org>
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


--d5Hcx3HAMxqlCZ81
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 02:31:37PM -0700, Simon Glass wrote:

> We know this is U-Boot so the prefix serves no purpose other than to
> make things longer and harder to read. Drop it and rename the files.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This is a massive bit of churn and violating namespace best practices
when it seems like we really need:
[snip]
> diff --git a/test/py/tests/fit_util.py b/test/py/tests/fit_util.py
> index 16ff8c96c63..7aad4030be3 100644
> --- a/test/py/tests/fit_util.py
> +++ b/test/py/tests/fit_util.py
> @@ -5,7 +5,7 @@
> =20
>  import os
> =20
> -import u_boot_utils as util
> +import utils as util

A lot more of this type of namespace shortening which I believe is the
normal Python-way of solving this issue.

--=20
Tom

--d5Hcx3HAMxqlCZ81
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVW6UACgkQFHw5/5Y0
tyzGbQv+LH6Nv6ss6UrLyyyRW2+RCcu+AmiDihS0Co5yoSru0/bfprJPZUjIl49+
fToujq+wa3Vd/+a2JyYgyvLu9VYnJDZ7qXKOK1v0eqEqIDJ95LKEd2udkAVnr862
L+VmCsVt/eif6DXB/n6THZMc610JLhFbM9lboxnkjodBWmLck85h6joVvtRSpooV
+32n9qA5meUMbVGNoqOLtP3TYMc3pP0elPQ1+mh5VOLoSYrku6y3q+cKOJCJRz3o
YS+0gB9GhF/sCuiiAA7YMRg6YqUW7S3T+pKzx8hItj8lcYap+VJm2+cy4r1cKHDy
T3lnNvhBOPSnUYjIJN/s2ODhKlkkWQrKSeBh1hIPPV7D0RXKJ0Y2uPa1eoyrpYZq
vh/w+9b14sW0ZzLQ2rbYyevuE4OmZrwa/QevfDXh1gyccQ7Et6ns6rq4jrFi5yvV
fIO3xwdxuUpJdk8oVOEoTx5xlWcOHknyBjvo3oi76m4uLz/V/CM50K9ttcgSvTKk
0Allr7SN
=dkm9
-----END PGP SIGNATURE-----

--d5Hcx3HAMxqlCZ81--
