Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D15CD7494E
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 01:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B951B891BB;
	Wed, 30 Oct 2024 02:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RHllANpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 978DD891CF; Wed, 30 Oct 2024 02:15:04 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A31889198
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 02:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b15416303aso460579085a.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 18:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730250900; x=1730855700; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ulHz24/NK4m36gG0VE3cZg+Trsarv4qpvgkX2qMv/CU=;
 b=RHllANpmA7MIcOyznKz/B7gGvFNiaTwBtoKlejkU4Zn/NBhQsVDlUkQkejdTqO9E34
 s9QZ/losNi00ODW6PyXndl4sMnSRAMGhy15ngUjmVpzSs70ubwhu70Yf0cnA5uftGcTA
 OoQCtbAIFYCRM/gnt76Reqr7rHnmFR+ncjkAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730250900; x=1730855700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulHz24/NK4m36gG0VE3cZg+Trsarv4qpvgkX2qMv/CU=;
 b=PUwnvo1c8CXBOkyBpTIlm58nAnIA0UyhN5YTUirs0VVtc1vLxbQujuAplkXNCjQkkM
 9EiL+kPxCj3NOXWZNutPNQW+0jjy8iiS5Yqo1Su6pyR150qUg7EC8fNeDTIWd1hrgbYD
 hsxKqIO11HzwNuWbnmbwGwF9cI57/SUc6KVYB5w6rKdMZrF/GQsvj15eFNHigzp92uc5
 oKUNI08Hm85bJOze77biW7g0RQE87x5GfxxI0Z/N8qOvZZrdzbPIyDndO3dwTWGl1W6A
 NzfLa9GG7zWqHumc1PaBWQggEJ8mUxlXaxMthm+17lX7ck5+oidYWj0mCxdHBqR9gwRV
 4HBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW7R6vNPPYMRixSHlWpFxck+NV5wieLXrEcmUPIirHi0EY4pR+ENPE0ZRHQbsnBU3cVOrtzho=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1Yb7mOKqU1B5ATt1ZgaroA2wijZHH4XlPOTajBzdgrR3utcxo
 DEIzeuKAIc372fSU//h8Q8fRf3dA8toD52UVlWV+CiREkUoduS9cSbGOgPwa8p0=
X-Google-Smtp-Source: AGHT+IHC1Ta8Vzjl7QCoMPXMgivlB5DIojJ0TKPaiODqGvBPev4WCVh2VuFiDWtuSLHbeFvapSblpw==
X-Received: by 2002:a05:620a:1a07:b0:7b1:43e2:712b with SMTP id
 af79cd13be357-7b193ed83a2mr1892280385a.11.1730250900444; 
 Tue, 29 Oct 2024 18:15:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d326206sm469506485a.93.2024.10.29.18.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 18:14:59 -0700 (PDT)
Date: Tue, 29 Oct 2024 19:14:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Simon Glass <sjg@chromium.org>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] lib: uuid: fix 32-bit support
Message-ID: <20241030011455.GJ2558755@bill-the-cat>
References: <20241030003317.2901772-2-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lrQAIYGK0OZ44HCI"
Content-Disposition: inline
In-Reply-To: <20241030003317.2901772-2-caleb.connolly@linaro.org>
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


--lrQAIYGK0OZ44HCI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 01:32:55AM +0100, Caleb Connolly wrote:
> In 22c48a92cdce (lib: uuid: supporting building as part of host tools),
> some instances of simple_strtoull() were accidentally replaced with
> strtoul() instead (spot the difference!).
>=20
> To keep compatibility with building as part of host tools, re-implement
> this via a new hextoull macro to handle both cases.
>=20
> Fixes: 22c48a92cdce (lib: uuid: supporting building as part of host tools)
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reported-by: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
> ---
> I've build-tested this but don't have the hardware set up to easily test.
> ---
>  lib/uuid.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Close, but not quite:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
____________________ test_ut[ut_lib_lib_test_dynamic_uuid] ________________=
_____
test/py/tests/test_ut.py:592: in test_ut
    assert output.endswith('Failures: 0')
E   assert False
E    +  where False =3D <built-in method endswith of str object at 0x7fd53c=
a39e30>('Failures: 0')
E    +    where <built-in method endswith of str object at 0x7fd53ca39e30> =
=3D 'Test: lib_test_dynamic_uuid: uuid.c\r\ntest/lib/uuid.c:114, lib_test_d=
ynamic_uuid_case(): expected_uuid =3D uuid_str: E...-8e063312964b", got "92=
a09169-9f8a-5f94-8635-0d9c2e830a92"\r\nTest lib_test_dynamic_uuid failed 1 =
times\r\nFailures: 1'.endswith
----------------------------- Captured stdout call ------------------------=
-----
U-Boot> ut lib lib_test_dynamic_uuid
Test: lib_test_dynamic_uuid: uuid.c
test/lib/uuid.c:114, lib_test_dynamic_uuid_case(): expected_uuid =3D uuid_s=
tr: Expected "985f2937-7c2e-5e9a-8a5e-8e063312964b", got "92a09169-9f8a-5f9=
4-8635-0d9c2e830a92"
Test lib_test_dynamic_uuid failed 1 times
Failures: 1
U-Boot>

--=20
Tom

--lrQAIYGK0OZ44HCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchiIsACgkQFHw5/5Y0
tyxa6wv/YROaQtf5UijuYix4sLOjXTLyV/m4EGNFec8lpl9GhuasNCT2oRJasqY3
qvdA5mdZMKCZ0DCVUyeqnrO00Ar2VzP6AemLat46dfcG9gpYxoPeM8/nAYXHaYeO
98CP5W/xzbUlwOBhrH0Nhnme37CgjW9m7UG2WnwhNBiXDQM3HBQH7s2p+EII8O7a
VH5qwdlNX5w6+qlnVmEY1zx3067wxDIQzD2EhbakbMvbGAwBfr/YJq7xKvjoFFCx
jS0eJmVAPATPxDPtxBewiqwJQH4cq8A+dLnjw9R/RPlO2d2Dm9zJFOj6XK1wUmZZ
hC5ZmvqsX4KoIHHwKtikcemt5Ize55DKPmy3e0xgW2+3BJmnRpivGXdOBYxcAXml
q4neF87FuniRWVyaix92UNLeQGBQAiKleU93STeMMSKa893O5xdWDOSQMLJKPrMX
URfxmhtkAdSkV6lCA6JfR0Cn940L7/9b+6KJo7vz7zXsxCUOwVxBVS9rvWhXc2ha
GxIxmAHx
=UjXb
-----END PGP SIGNATURE-----

--lrQAIYGK0OZ44HCI--
