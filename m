Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BC1D637DB
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB72C895BE;
	Thu, 14 Nov 2024 04:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SIKpeFww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60269895BE; Thu, 14 Nov 2024 04:22:56 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE6989574
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5ee645cf74fso46361eaf.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731554573; x=1732159373; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rAqHSQuLZxDwmJ7411tZc1U/S5kS7Z0Ic40jw+6lTcs=;
 b=SIKpeFwwUZR9xpoYmhdZgH1Kl//6sWzNVn/n0s9owA9+ZcmwhoAVL+rEpSqUs3rwt8
 WssokO60o2NC/rgIRTAPHQHes42a2pSfZ/hX94e4xoUHi5TgcuX4qiote7171BjhIcXg
 iOuR02qZbOv9BrECBh2lPZDYI1w8WObUzm69Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731554573; x=1732159373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAqHSQuLZxDwmJ7411tZc1U/S5kS7Z0Ic40jw+6lTcs=;
 b=t8/7J5gnTWpBEfi44m0ntsHwjarA8J4rkru8S6pm1vdVJ893r3bA0GMA+Ngr25skPy
 7vr1o2bQ/Ln52QpBGutpTj0fZLLrPzVBSJc250i5pMtqzkuQtpjx/h27o/IF1ldNPM+s
 AT88NJjMOm9uDQwmQMJhdALTqXB2smEmeWIB6oH9iCn6BjT6+Gi3rEH789DjAFh7puDg
 HTI+Kg90YYwo2GI3q8CTdpubNHk0qnuVPhvyogNvvlb5ZtxnZ6YIL8lz9JRqQYcu1Qwu
 bONM44OyhFuyaTGo/w2ESWyklmowsoCjgGWkYZGONHnPIR227TYaHwSbIHzKNjO9YueC
 EJGQ==
X-Gm-Message-State: AOJu0YyeB7IpB2Qn0IxfMaTtZ+0MhlUrkn0JwUpfVNaCvdHDTt+bidG+
 079XPtNISUh/SINF5uM6WP4b0rrZAip7gUxkzvOA/bAApFdyRVOoF7ocEKDziio=
X-Google-Smtp-Source: AGHT+IEMPdLTXoWy3Ld0+TGH17bH5VM5hNvkgQXJEVPwZuk+Ap7pOcJMypQtPg/svEfHHhwVTrtMaw==
X-Received: by 2002:a05:6820:2d04:b0:5eb:c72e:e29b with SMTP id
 006d021491bc7-5ee922804b0mr4935847eaf.7.1731554572967; 
 Wed, 13 Nov 2024 19:22:52 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5eea00d6539sm92177eaf.5.2024.11.13.19.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 19:22:52 -0800 (PST)
Date: Wed, 13 Nov 2024 21:22:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v4 9/9] WIP: CI: Update for arm64
Message-ID: <20241114032249.GC3600562@bill-the-cat>
References: <20241113185340.1661198-1-sjg@chromium.org>
 <20241113185340.1661198-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oYU9+IIo21awvHFq"
Content-Disposition: inline
In-Reply-To: <20241113185340.1661198-10-sjg@chromium.org>
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


--oYU9+IIo21awvHFq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:53:40AM -0700, Simon Glass wrote:

> Do not apply.
>=20
> Switch over to the new multiarch image so we can try a run.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e152060b046..3275d9ffa45 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -11,7 +11,7 @@ default:
> =20
>  # Grab our configured image.  The source for this is found
>  # in the u-boot tree at tools/docker/Dockerfile
> -image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240808-21A=
ug2024
> +image: ${MIRROR_DOCKER}/sjg20/u-boot-gitlab-ci-runner-multiarch:jammy-20=
240808-13Nov2024
> =20
>  # We run some tests in different order, to catch some failures quicker.
>  stages:

Please just drop this patch in the next iteration, it makes it slightly
harder to automatically apply (I have to tell it to apply 1-8 and then
mark 9 as RFC in patchwork).

--=20
Tom

--oYU9+IIo21awvHFq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc1bQkACgkQFHw5/5Y0
tyyOMwv9GiMtpfG3CMmroRx8jF7DuwijDArgH9UaWBXM4BVDEBFYR3/dbnU47++C
DZMchElGUVq0jFLZ3/3BxKHEZ/bFRGj/oKpppMVm79SKxq7Ba4lzonI6VZwnovmn
dEfyb7ndMOs1sqhjhP8fRUBcICeA67q7Jt0Cj2F2bUZnsBZP/Bc5t45tTKdHSNCM
0un3kLniSEMLJp11N3Nqt1NfQIg+lwME2WuJ7kbcZDQsIF4S4j3IzbNdAmIRGpxI
NLXMHhoNp/Q+5f6LVr71YSXyMkMqbpcCB9gXheHd5+9YgP4IusMRIGZi9ixTOuoY
VCokNJPbzLzpklMO/tWYIEVM04fuJeXe+TS6sIgfDVGtKNMXJhwIftgx0wVh9Jpl
Xtwm4k2go/V8OsaJ3TJblXS1eOYosnLrqc+f6PSbPv2947TIjSA03M59Gx1vFs9K
ofanlkzD1OqiBjscQfdlh0AOrzbia7IOEwHXFYAs8cmKmAAuj4sq3Jvejv5Qzwat
2GodPyp5
=x+Tw
-----END PGP SIGNATURE-----

--oYU9+IIo21awvHFq--
