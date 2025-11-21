Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68C5CFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4D483984;
	Fri, 21 Nov 2025 17:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MUIZn9BL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23DB839A8; Fri, 21 Nov 2025 17:49:02 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7268083966
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 17:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3d56d0cb3dbso1350144fac.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 08:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763743739; x=1764348539; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Di2vqdfFVKgDWPX1oOptiw/eTJQYRgOvEgKx5hNZ23c=;
 b=MUIZn9BLDLwt2kEy1nTgrEurH93gWVd1ibYs0gdHQVggQw058qegdnFZIHVPmGb8bK
 rF9mpwwkCro3C313uESQLkTOCN+tArdck5auNsPMlRHuPemJtSUdnTYNPrekc8IqmBtt
 HyqsdwDU4tmMgSTC0srBtk7zvjIeGZxkjD7NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763743739; x=1764348539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Di2vqdfFVKgDWPX1oOptiw/eTJQYRgOvEgKx5hNZ23c=;
 b=iXKkLCzY7KVhjT+5OePynEZXiYPh+S4dVsgaIScdVbdMduL0FGXTM9bKX0axsnnYFz
 32jCx8yjRbN71PG771gtAM2O0Ldyoz5fjrlKhAUkrWRv8oc1ngnJoaO1897UnypLTXa2
 AHM9AJvSizDVjWuJtlGGpR7ORgeB6nxp2H/90kVFgP1BkRZHkeicpZrGQshxn/i0SoFj
 qsLdOQpvTZGBMRZjTcTxn1f/IqFo1/R6+fW2eZft+s+GTE7xGQx9QOC/78LNtYxT7P24
 +arx6zKElzOZkH49AqoouGzVegTedZVFfXc5IhCnXfygtgbkRy7+DT9No9ZAGjbAHzUN
 PuwA==
X-Gm-Message-State: AOJu0YwRfyxQttH6iNj+9oPjRsPzOVsJGuPerF5cofnVRLOukRLDHJiU
 2Gg+G1d0jCDcd29JgIvhIBDLeVWcD6YgRAx7wL+7BJh555WHwMlwfUaL7xx27jY78nw=
X-Gm-Gg: ASbGnct9V4vr3MChbPTC1+bLGkXVB5K3i7y+87Fkhtmp+SmKTMWRmunMqzC1xjqirss
 4SNfwXi3j/lrU2ogLaXp8bnSwLG/D5I6arDaO5WoZXAPB7vyDAU+6avr+HPeFSmbbFBZlhay60n
 e3YndjjWe/r5po8hmOIiwhZ/SAlA/YoQC76qMdMBhnF9d1vZ5b64s2tfMhq2SdoX3hmAzao3gvV
 DW2GluT5Amnm1NNqsTBCYuMLNpFvaNUpOnxPh+Fsc1bVHqP3finvh7AHDRHNrqjDvgySZpvPiNU
 tEDQ/9z+NkyHfyBQb2cxlQffSKFEug7qvQ43NE5Kx8NMBt/UVdudZbFR5R8uV2rZKNhWbH0cHS9
 RULf9B5qo/T/T1vokGOBzPwuZ89vnFY2DqXuROb9NfckmFq69RkhotJRlnD+BSpmKoVJItEEyN6
 FAkNY2EDuU3cXyh/fqMJatuNCjs1nwf8uxa92xpi7DoA8VZdTN/Q==
X-Google-Smtp-Source: AGHT+IHhcLLJ28Ig6gUzksJySTq80T9r8LsXAh13eOT36T6aPVvhNZDK7BNiui6ll4U6ZtqTvpVxaQ==
X-Received: by 2002:a05:6808:190c:b0:450:b560:dcf5 with SMTP id
 5614622812f47-4511290cec2mr1091137b6e.12.1763743739072; 
 Fri, 21 Nov 2025 08:48:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450fffbeb51sm1777706b6e.18.2025.11.21.08.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 08:48:58 -0800 (PST)
Date: Fri, 21 Nov 2025 10:48:56 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/2] test/py/requirements.txt: add setuptools
Message-ID: <20251121164856.GZ2125796@bill-the-cat>
References: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
 <20251121-a-few-test-py-improvements-v1-1-bacb4148fb0d@baylibre.com>
 <20251121143903.GY2125796@bill-the-cat>
 <d78a79c3-cd28-4270-941c-a500bdff5432@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iQT4FTygJHGJRg12"
Content-Disposition: inline
In-Reply-To: <d78a79c3-cd28-4270-941c-a500bdff5432@baylibre.com>
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


--iQT4FTygJHGJRg12
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 09:56:59AM -0600, David Lechner wrote:
> On 11/21/25 8:39 AM, Tom Rini wrote:
> > On Fri, Nov 21, 2025 at 08:36:14AM -0600, David Lechner wrote:
> >> Add setuptools to test/py/requirements.txt. Otherwise, attempting to r=
un
> >> tests can fail as follows:
> >>
> >>     $ ./test/py/test.py --bd sandbox --build
> >>     +make O=3Du-boot/build-sandbox -s sandbox_defconfig
> >>     +make O=3Du-boot/build-sandbox -s -j32
> >>     Traceback (most recent call last):
> >>       File "u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", li=
ne 23, in <module>
> >>         from setuptools import setup, Extension
> >>     ModuleNotFoundError: No module named 'setuptools'
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  test/py/requirements.txt | 1 +
> >>  1 file changed, 1 insertion(+)
> >=20
> > NAK. It's the build of U-Boot that requires setuptools (specifically
> > scripts/dtc/pylibfdt), not pytest. It was dropped as part of cleaning up
> > the test/py/requirements.txt file before. A top-level project
> > requirements.txt file would help avoid these problems, but we don't yet
> > have agreement on that.
> >=20
>=20
> OK, I think I see how it works now. It looks like most tools have
> a requirements.txt already, but dtc is missing it. Would it make
> sense to add a scripts/dtc/pylibfdt/requirements.txt containing
> setuptools?
>=20
> Then `find . -name *requirements*.txt` would make it easy to find
> everything that might need to be installed for a given target.

Yes, I think that's a reasonable step. I think in the near'ish future we
might be able to instead switch to just installing pylibfdt.

--=20
Tom

--iQT4FTygJHGJRg12
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSCX9AAKCRAr4qD1Cr/k
CgcsAP99TOOV7bZ+6nV115E9FqdxnqiuPxsgpNwYK8uEowcBpQD/XUW4xJp3cxfx
AVU7J5ywTCHKGVRh5bp/MNbcV8X6oAc=
=mv7F
-----END PGP SIGNATURE-----

--iQT4FTygJHGJRg12--
