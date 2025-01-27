Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5268C0218D
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 00:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 494D780F98;
	Mon, 27 Jan 2025 01:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q/57/eC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B8FE80F9E; Mon, 27 Jan 2025 01:52:38 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA2C80ECD
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 01:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6f19a6c04so373565685a.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737939155; x=1738543955; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FyDpSI9yal/5Reu8CCscJwzs6E+GiEwbw7GKSO945sc=;
 b=Q/57/eC5KjI1dAhwolF7hbO07jPePyrsKKhYkhc5QSnn9UWeFfUvBkgvQv0pW41Zow
 EaaMacM2MJLGhOvQYBa3MFtYlclIJmNp8lFyVRD0K41Janlk9WmA61GkRG+ecNEXhSxG
 TF1Jw8FOF1rAmLucAn+vv/PDetIxjCTwJo0YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737939155; x=1738543955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyDpSI9yal/5Reu8CCscJwzs6E+GiEwbw7GKSO945sc=;
 b=MjRhSarCrS3969gFDz8jdcH80XCuNTnXIOFvUWm0Ghp1MGq0kV63ycaflWYQjYprtx
 nt560jENccKfubXczGiPfUXRLdptJsZJGIwEa6zweHLs/IEplHY+UtaNDdLMgA5K2jow
 r7yngMJdcOUhr2WDoHPOar6JBh6VQ5v9l1WrQ5CnEiaw/lFbtvfyXMCtqzKtP0Qrb0Vn
 ZZiFSQkrXX+f2yNvH8XLzwAoAXQvm4cjwZTgttDImYgECttcsX1j4RDAhAOL2d9Ro5/g
 Gqg9hThRUAuZCdfkmQaK+XP+sBVSLO2plbumfuKBkM6bTekBYEdX+HKTpdk0taKmWllW
 uAEg==
X-Gm-Message-State: AOJu0YzPr/ahWj/O57E61YkgFidkwD8COMFvgyGBm7gJpHmOkebRTp7h
 SRQyCxKHYdPlf4lyLdekH+iVJptHjL3fQcGF+fg0H/7DlZ5ih3mzEdT9QyCtgLs=
X-Gm-Gg: ASbGncsw5P3M6m49mn+wNrCQCK4sFG3T95N65k7kVKLPuWFLoIxgv8TxHdDn0aPheXd
 Su7K2Ln9lSyi1bRab986kOPg1UB/DyUPQcZNixlGZQuRb2vHU4X/6huxz+5cwDA7CMJm8shsQ6p
 ra7SRvxCBeUUE5ddobPoelyrh7mvszspsdMYC4uaZaK0LMOMA0E5q/uY05PEnslqfHjlTZONBlC
 VD2s/hWGer8q+fKdRXfDzhe3DTrXAaM1oo8FGzy5BeKytrfDFbyx/Qwqe3r6aXzLWWVC27jdZlj
 YJbx
X-Google-Smtp-Source: AGHT+IGfCqu0YSHCarNuOc08MJ+wvJ67yX29Uce85NWgimc+NiV0TFkoKofZy7E/scbaa/1F8xLaLw==
X-Received: by 2002:a05:620a:841f:b0:7bf:699f:c80a with SMTP id
 af79cd13be357-7bf699fc879mr966865885a.36.1737939155021; 
 Sun, 26 Jan 2025 16:52:35 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae8a6a1sm336997385a.28.2025.01.26.16.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 16:52:34 -0800 (PST)
Date: Sun, 26 Jan 2025 18:52:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] test/py: Add a report show test durations
Message-ID: <20250127005230.GC1233568@bill-the-cat>
References: <20250127003934.594726-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5xHSZUKrBhOcggkb"
Content-Disposition: inline
In-Reply-To: <20250127003934.594726-1-sjg@chromium.org>
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


--5xHSZUKrBhOcggkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 05:39:22PM -0700, Simon Glass wrote:

> Execution time varies widely with the existing tests. Provides a way to
> produce a summary of the time taken for each test, along with a
> histogram.
>=20
> This is enabled with the --timing flag.
>=20
> Enable it for sandbox in CI.
>=20
> Example:
>=20
>    Duration : Number of tests
>    =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>        <1ms :  1
>        <8ms :  1
>       <20ms : # 20
>       <30ms : ######## 127
>       <50ms : ######################################## 582
>       <75ms : ####### 102
>      <100ms : ## 39
>      <200ms : ##### 86
>      <300ms : # 29
>      <500ms : ## 42
>      <750ms : # 16
>       <1.0s : # 15
>       <2.0s : # 23
>       <3.0s :  13
>       <5.0s :  9
>       <7.5s :  1
>      <10.0s :  6
>      <20.0s :  12
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Only show the report if the --timing flag is provided
> - Use --timing flag to show the report in CI for just the sandbox tests
>=20
>  .azure-pipelines.yml       |  3 +-
>  .gitlab-ci.yml             |  3 +-
>  doc/develop/py_testing.rst | 33 +++++++++++++++
>  test/py/conftest.py        | 87 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 124 insertions(+), 2 deletions(-)
>=20
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index df3f82074af..1a5d15a8cdc 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -295,7 +295,7 @@ stages:
>            export PATH=3D/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
>            export PYTHONPATH=3D/tmp/uboot-test-hooks/py/travis-ci
>            # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \=
$var" if not
> -          ./test/py/test.py -ra -o cache_dir=3D"\$UBOOT_TRAVIS_BUILD_DIR=
"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_TEST_SPEC:+"-=
k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-d=
ir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=3D\$(System.DefaultWorkingDirector=
y)/results.xml
> +          ./test/py/test.py -ra -o cache_dir=3D"\$UBOOT_TRAVIS_BUILD_DIR=
"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_TIMING} \${TEST_=
PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD=
_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=3D\$(System.Defaul=
tWorkingDirectory)/results.xml

Lets add a variable to pass further arguments to pytest directly and
then use that to pass --timing. That would let us do --capture=3Dtee-sys
when needed to really debug a pytest failure in CI, in CI. Just thought
of that, sorry.

--=20
Tom

--5xHSZUKrBhOcggkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeW2MsACgkQFHw5/5Y0
tyw2MQwAq0G4abw19pZerWwBrZmY93WI8za3Gq+ooRjmmI94RSzypLtzb4ixdtGo
KetNbNTwkkDINl6F1YUA8stkb/d6uobSaXfMBK60YYzRResGy8HP8Fty3ecCmDzf
Vxiu3Q04s3e2/S30+6z0qRNx1M4zrfCgQTWHcYZNbOOgzaJ78hN0pTPkVn0sMzZC
4nz4peqBGAlQptI6ZXlAO1ldxFmt/JguFt+O7o5VLTBSrRrIU6QB/pdEHed+7KAR
fHGgBpU0H4OZ9qfJLXrzvabfC6EY3DH5UM+qgNssOquNFvitPJ8JnLg6A1u0mfOd
PS8zSCgYY7sASWI6FwMb0bS6QRUBpmy2XrjjQRyNAuI86lkxj1Bipz/2llhVpQEh
SdVHIN1XczMVTNOAe6q+w8IQpyBZ+UeCILJisHxV1//lMxCjl3/Xex20VkR6Z04b
pLH5Lza7RhY09QHhinonwCA3XzGt6nFsmYBvVL6L6BIuVyAr8WFnSDU6zn1g7gmq
Y3uPg+Zz
=5Vwk
-----END PGP SIGNATURE-----

--5xHSZUKrBhOcggkb--
