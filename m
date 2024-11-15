Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF7DD68BCD
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 18:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBACE88E96;
	Fri, 15 Nov 2024 19:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IH/96OT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C458088E96; Fri, 15 Nov 2024 19:45:04 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4216E88CEC
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 19:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b1505ef7e3so121236785a.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 10:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731696301; x=1732301101; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AmRawDcBuGEXerXqlLdXuCG0TY2myvLfhHM4nZRAzu4=;
 b=IH/96OT/RzyrPHTx87alXCVuqhJEDZyq1lw3RaJb7gD08nRWJ9X3hk+cKWy0sAWi/S
 39h25CHUeBHFHUtrM1eM2jsCZeuB1A8cRzRAo8SiolyTPvAEjKEmWLTcOLS+oi9X9ct+
 SrIQDeHFTMmEOU5MJ/WJIgAa70whKAgoFcUHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731696301; x=1732301101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmRawDcBuGEXerXqlLdXuCG0TY2myvLfhHM4nZRAzu4=;
 b=gylx4xlxK2RSQh08f624GdTRkSrG52Grle583gnYJPwguHawf3LKdUmUqgo4EQjM7L
 QQucFualFwVENphVeEc9DLLevQhK69Y4rNrYYEa5Tv7Lj9YVeuv/pjjQ8ERcDKXw4nVA
 d3wghkVAZKsIqs0acNeyVu1lsJRQ+M2TxaPDDbyEFvxZTKMEkVIxiIjsOINl6QmzVDBD
 +dSMzhYQtN1leoeQkZAywBy4LpH8H/j6WI3M02DXtVVAsF5gASOmiG7v7cnt/4cHhu75
 mmLatqZe+nyizHD8+sRPHP/lHzlS4s0m7cA5t1tWDMz3affumPtAve8tp9WV8Cmno76W
 WxJg==
X-Gm-Message-State: AOJu0YxHHPKHaWBvRNQ88Al+n0OqfxNv0vtyWclcbljurF8EvGqF7cMF
 s81wBy8Fp+YKIb/PQWHxL85NROPq40HaamiiIqAjUydlQZ3ROp2I97P1lZvzrjaOiVUEZ/jXLG9
 OqG4=
X-Google-Smtp-Source: AGHT+IFBrgizyCewy7PMvKA5rByBMyAbpEVin1cS0nox9gJ0W8NNfKhVtjECRJWd+/QkD58c5fZz4Q==
X-Received: by 2002:a05:620a:4491:b0:7af:cd33:33b3 with SMTP id
 af79cd13be357-7b36234f3camr456576685a.42.1731696301069; 
 Fri, 15 Nov 2024 10:45:01 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35c9acdbdsm187065185a.62.2024.11.15.10.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 10:45:00 -0800 (PST)
Date: Fri, 15 Nov 2024 12:44:57 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] docker.rst: Reword slightly around "buildx"
Message-ID: <20241115184457.GZ3600562@bill-the-cat>
References: <20241115134807.3068947-2-sjg@chromium.org>
 <20241115162649.2395503-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="akQ2vZ+MSSd3K+23"
Content-Disposition: inline
In-Reply-To: <20241115162649.2395503-1-trini@konsulko.com>
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


--akQ2vZ+MSSd3K+23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 10:26:49AM -0600, Tom Rini wrote:
> Try and be slightly clearer about what "buildx" is, and how to install
> it.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I rephrased this slightly to try and be clearer as if you're using the
> docker.io provided packages you need to just install the plugin.
>=20
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/build/docker.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/build/docker.rst b/doc/build/docker.rst
> index 5896dd5ac4a6..81b394597ffb 100644
> --- a/doc/build/docker.rst
> +++ b/doc/build/docker.rst
> @@ -4,8 +4,8 @@ GitLab CI / U-Boot runner container
>  In order to have a reproducible and portable build environment for CI we=
 use a container for building in.  This means that developers can also repr=
oduce the CI environment, to a large degree at least, locally.  This file i=
s located in the tools/docker directory.
> =20
>  The docker image supports both amd64 and arm64. Ensure that the
> -'docker-buildx' Debian package is installed (or the equivalent on another
> -distribution).
> +`buildx` Docker CLI plugin is installed. This is often available in your
> +distribution via the 'docker-buildx' or 'docker-buildx-plugin' package.
> =20
>  You will need a multi-platform container, otherwise this error is shown::

And as a note to the future, understanding
https://docs.docker.com/build/building/multi-platform/ and a very quick
guide to how to practically add multiple nodes would likely be good. I
feel like most of the SBCs I have on-hand would be quicker than QEMU at
this part, and with actual arm64 builder in CI as well that's likely the
path forward.

--=20
Tom

--akQ2vZ+MSSd3K+23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3lqUACgkQFHw5/5Y0
tyxWggv/c+O0jpWynkRvo6ucnPw7HEMwl3v4gitB0t4QM7nm0gyE+FBnoApIJpou
XXyumnCHQ4buWa6dVFlAw4jdKaX7GdH+dBowVaY1k1FEJisJZIDbGsG9lUquEGsg
0Z/u4QsSDZLMeqn71Hp+ETh4XzrEz/FdIRbOUBV69gRK/bDUAn12BTEtMoM8rwE9
UCdek8Wrssq2kq6lbc5Okzr2Tw5s5uuwiCW+k1gFoUp7n1y1yTfn2s7Jxc2dTBwS
zn4Fyj0WlJd+YzdXh8PNAlqlA6UcjblBw7GN8fiWFTt/NFxUnAVoAs+yGfcc+VIA
sh3bvLLf9UepzxZINiVh3t7BO4sAws9J9ynjXfVWGbeykbxllbTcTinnblJfkgDu
jygtZf2PNAPxV1ISGXeS2qDVaB+iugo8ao/4Zm0EpP2VV/zgu27//rL0Iwv8MFq7
Rr3x+2ip7rYnlSZHfMK3HrrRXAoDn/T4vuoxkXEUmRwN9YAbzPF4A4o5PQr1pDuM
AKy7fN42
=EV4Q
-----END PGP SIGNATURE-----

--akQ2vZ+MSSd3K+23--
