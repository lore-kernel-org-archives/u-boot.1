Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A7BC3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 15:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB38B82952;
	Sat, 10 May 2025 17:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j8r6j1u2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD1008295C; Sat, 10 May 2025 17:05:30 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8264C82935
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 17:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3feaedb4085so2308083b6e.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746889527; x=1747494327; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rLDqHxh10Vep5eUq2JlMFUvMJWU8OikEVILWoRjVH68=;
 b=j8r6j1u28tmoqKLvNqi93fToJ5TrD5o2iiW+yODQZIjOT+QIPhpPWvoNseVn5ds12l
 53NHU+bbY4YUkYGBt9vM+uEJBsuoLOibwYHtA/cR38M/QMKS5jSknsV0PdtYLpiUpNJs
 i2SuxSZ9SIZ9vqGCQNn4cMMxV8MQj6IP/2lQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746889527; x=1747494327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLDqHxh10Vep5eUq2JlMFUvMJWU8OikEVILWoRjVH68=;
 b=xEaau6tFCJp4hT4AjCv95hU7VWq8R5Pr6uwJS3Sjs2dJvdTbrXi8YFLpauqdUoXEoS
 FR3Yu1IQ5OEeo780meU1x1uuwJCNLyWPhm7F03H5JlkAY+e4AGZSh64o4pWTZvDGvD+9
 ZhGFb/qQnZP+C7Zfmw3TUDTHb/QEtGkuoZAof3zj34dU90qRJXJLv5xcCisPei385tRt
 Z4rwhOjvrdS2giyuLKTF6n/S5TFCShgETdZoLrmzpHbxSHxPRtS96Ft+QHshz5ZffHdo
 A1dOT3W6VDgkfTtZUbHsTOvZKJs5+SOQUDc61T84TSsATn/KOMXzrzE2oN0QUW1Uveqg
 YP+A==
X-Gm-Message-State: AOJu0YwNDo3baAb0noMPM/w5TJOu3FAc2hOnaBpKa2j0SYVtWUC2ypKM
 iPfKxKNCHuIZdTru39XgfRs0RMMEL9u+EIegbwJ5SiBpiQguqqukQGt2UdsewtQ=
X-Gm-Gg: ASbGncszR7nFec1CZuHv0swoK6+WwuKn06UZX4e1JDYAjxVodYSpNDhAXiuPv3nUSJ4
 hRtWXy/81oRZT1HAY5FYxkAelifn/x4R3/MTpu0bxSPcGxLYgM8I0g9nrcY4LRNwBgQbhYlRBEU
 ON7EftLsTggZW/QzMxI9VUfFFFMSOd4ZY02wSlcFsBvGrJPURk9FLo/vegFf0w64sOmhXead7VE
 OtPXsG5II5BY9FYakk56Lp74SD6IOi4lhELslbW106zdAIevfO/25aObI+LAaVUsGQwZLL+NHLo
 YMGIQqw6UPDDKKgyeXnDv4X7KpoR/kljKQYWjp0qFcKpNNoBc/3+M6bCHwMbPRPCd4qldLGkR5v
 47NpWoof9kkRj
X-Google-Smtp-Source: AGHT+IGLQzXwBhHer8AJMPOit3t4Bw83rwycAMBhkBUbmeC9CdxMAJYBbcXHKECbzYl7Cl7JAVP+zg==
X-Received: by 2002:a05:6808:1190:b0:402:11c2:253e with SMTP id
 5614622812f47-4037fe1a4dcmr5294180b6e.21.1746889527210; 
 Sat, 10 May 2025 08:05:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60842c2a67csm869780eaf.34.2025.05.10.08.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 08:05:26 -0700 (PDT)
Date: Sat, 10 May 2025 09:05:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v2] efi_loader: Disable ANSI output for tests
Message-ID: <20250510150523.GL603748@bill-the-cat>
References: <20250510125457.1571220-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/xJLeHBz2OE1BYUq"
Content-Disposition: inline
In-Reply-To: <20250510125457.1571220-1-sjg@chromium.org>
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


--/xJLeHBz2OE1BYUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 02:54:38PM +0200, Simon Glass wrote:
> We don't want ANSI escape-sequences written in tests since it is a pain
> to check the output with ut_assert_nextline() et al.
>=20
> Provide a way to tests to request that these characters not be sent.
>=20
> Add a proper function comment while we are here, to encourage others.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Use the term 'ANSI escape-sequences'
>=20
>  include/efi_loader.h         | 21 ++++++++++++++++++++-
>  lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
>  2 files changed, 37 insertions(+), 10 deletions(-)

Since we keep coming back to this, here's the email where *why* there
are ANSI escape sequences is explained along with Heinrich's suggestion
of a fix for your concern:
https://lore.kernel.org/all/ba46d2c2-38ac-411a-a48c-429295cf6efb@gmx.de/

I assume that this, rather than repeating and reposting this solution
again is still what Heinrich prefers.

--=20
Tom

--/xJLeHBz2OE1BYUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgfay8ACgkQFHw5/5Y0
tyyVjgv+OgPc10YctePLteKy4/ThZTaNHclcxn5JGVVYtvu/5EkKk8ws/P9zk17k
6waGVb5vcaDlxBJDZJNn7dLDwNX6ucX3+Qy87Eh10YPlRMQnHaw6YIMHHi7oS61l
MuNargCzmF1qpANsZQgnaafm3QxKLxV1mZkhnel873wDeZ/Fg8enSyro90Qqw+Bx
+FoAFYzBQcdB8/3DtCJWYFx5R+XK9mT3j30RpDF+AiomiMsVfZxyS6u+QjIzGrF6
r13kdGlK0luZdHbW6ESrCmzn19UpBH77ePRcNzygPFg0W69pBX4XdkTnDzF61xuG
E3hT0i8PmsdYjdmGPNObiFCRaNPl9FMLHobRzxpfvu2sDe+HrC0M9a5gHzB8iNlK
MAH3NPAyF4OAHilVl5OeokJ6EQ2XjCMHOySqEyuEv6tyxGR95zTjAjywzeXYetn2
o/Y5CQPQKl92g6z7NfGgYx+OON5yn+y0EpbXLGW70CDmnJY3owHaU2jtuRqrdCQd
JTipSvVc
=gXH6
-----END PGP SIGNATURE-----

--/xJLeHBz2OE1BYUq--
