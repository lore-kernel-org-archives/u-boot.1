Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E85C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 010D986435;
	Thu, 24 Aug 2023 15:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GY8sRjfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B835A8077D; Thu, 24 Aug 2023 15:33:53 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3872F8653B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so903644966b.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692884031; x=1693488831;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HIhNdQaSvM/W2SsXqgAd0khgKXHhixqYUsjBN6+kgY=;
 b=GY8sRjfmGyXcEQaQctKMqoYrFLc8CaIAdtaEaQbyw/R5XR/QgFnR4Y6u2XbzE7WGt7
 8r6fztVTJlDHFyKdZ04Px0ULoPHQmYG9Ay+lksKEb5Ca8q0cvw71cuKP+Gpxj/+qlydW
 iz/RZ95ZsW0+iwvsz0LUWtJPhL+bIAhobIi6+uFGNxyO5Li2Ts3WrEIX1+D9P9MCXWxB
 TXdmxIzwxbWBJ8EmxbYmis6rHxg+A7aYVCaGyFQsQS8tXBWJfDEQvYaliPrqUFdDzQeo
 AkKjcocJM2BHJbk2ZIM9O2w+WM+L4cXiZm6smtiuIb+Hr837wz6HStTdwK3aKb9Jbk3t
 vX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692884031; x=1693488831;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HIhNdQaSvM/W2SsXqgAd0khgKXHhixqYUsjBN6+kgY=;
 b=a5LDr+4uuRCL36RpKd1ij1o6dEBbDBQ7BNKokt/w4gRvG3osXa0bVM3eqQStreSJlI
 xpF38XWx1e3msd+evRFJczmyOcMx4t4k4gKMVQP0mxRoVQYIgAhxo93cwR5Bo1pTiVXM
 1gYkL6RKqSYtK1gpFtQ8iLC3oyUSjXgHwDJpuHY0c27GoM1pcDbw+ee/J3o7pLVfzify
 IFCHYLHMDAXlefQo9eKBViI8jZfoXxXhStNw+D0HHH+wM3v6e2iL6/FE1Yu3c/IFj25B
 Mq7D0EOZczZRhv3hIxV7LIANbYpBd/OltYWjDi3+cQU+r2i/xY9Urz2KHOxcg6t9wuOq
 iDng==
X-Gm-Message-State: AOJu0YwOhaQQA43eLj/AxJ8ETy1X7coNDG9D+MS43OxPnVCsiNjmHiKA
 7X7k9dXb2uvMMpmdO468qDM=
X-Google-Smtp-Source: AGHT+IHWo6+jrwPhPSw/Kvxk8CMeKSMys0DKPKLtggRhYlRFA4FRwMpiEgnggHc5DDNmaZj65OgvQA==
X-Received: by 2002:a17:906:20c7:b0:9a1:ecb5:732e with SMTP id
 c7-20020a17090620c700b009a1ecb5732emr3672325ejc.71.1692884030498; 
 Thu, 24 Aug 2023 06:33:50 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 qn11-20020a170907210b00b0099b76c3041csm10954882ejb.7.2023.08.24.06.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 06:33:50 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:33:48 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 17/19] ARM: tegra: dt-setup: convert TrustZone remove
 into config
Message-ID: <ZOdcPHTsyKxN9OzS@orome>
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-18-clamor95@gmail.com>
 <ZOXq0SrF9h0Z9uHw@orome>
 <86A72122-840F-46B1-9C25-0B6F5AFB82A1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KFlTdV246go+DvPy"
Content-Disposition: inline
In-Reply-To: <86A72122-840F-46B1-9C25-0B6F5AFB82A1@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--KFlTdV246go+DvPy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:47:11PM +0300, Svyatoslav Ryhel wrote:
>=20
>=20
> 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 14:17:37 GMT+03:00, =
Thierry Reding <thierry.reding@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
> >On Tue, Aug 22, 2023 at 02:22:15PM +0300, Svyatoslav Ryhel wrote:
> >> Remove of TrustZone nodes is required by many product devices
> >> which require repetable calls of same function from device board.
> >> To simplify this, TZ remove is converted into Kconfig option.
> >>=20
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> ---
> >>  arch/arm/mach-tegra/Kconfig    | 14 ++++++++++++++
> >>  arch/arm/mach-tegra/dt-setup.c |  7 +++++++
> >>  2 files changed, 21 insertions(+)
> >
> >I kind of preferred the original because it's very explicit. There's
> >also no big advantage in consolidating this because the code is unlikely
> >to ever require changing (the libfdt API is quite stable and these nodes
> >are all hard-coded anyway). This new variant put non-generic code (it
> >requires a Kconfig option after all) into a generic place, so it seems a
> >bit backwards.
>=20
> So you say that I have to add same function to boards over and over
> for all devices I plan to mainline? Unneeded code duplication in
> action.

There's a balance to be struck between duplication and readability. If
you insert this board-specific code into a generic code path, that
generic code path becomes difficult to read given the extra #ifdef
guards etc. If you're really worried about duplicating code you can move
the two libfdt calls into a separate function and call that function
=66rom each of the boards that need it.

Thierry

--KFlTdV246go+DvPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTnXDwACgkQ3SOs138+
s6EXig//c+sUShJ1JHJK6NeG+eGd7Pek/drMwDaosMUitdV2yWjgmeygPfBfgRcX
+6NNF9DCImGmjIBdWgcsJkgDWokGdkdwyEEI4gg8VeBGDnAdyNnY4+0S/Zp+YTZE
xHBWpPfsS+vlUScz7G7/Zi6YH4hL6rKUyTOKjetXNRQ5ZFoDZS8dSwhT9ghZHNRL
BUrBuNfyJ48oZTvB+eBpjchZpIy1wP10btDceMm6AKxUrdimpdKO5Y5oJJOPxKX9
stmdP26F10jc3NqGPQUz3d3rDQnFRzl9jA6QFgU8tN08YDn7HIQktBPtLbK4TFe3
KSywJczGDIykFnVhkcvRiBMCZtG6sTPHhKTUbWrgVS5AruujTJzsKQJl7slT2mFL
2G5FghQAXINeeCZ5ba1rA08KcwO2jrerrmXyImWZ0YgfDBvsc68C75fLycHsJR9K
dT3sXCFwMXrGXr+Z2l4GCIfVyfDI91E9fb8I9gZCKc08P9ByUPrZHEby4hwucaFj
08J+g76yg3fqwCudPIY7trhXXDtbq1lNkalJbbCJaowe8LxJb6SAMqInaw0KK1Bk
eyX853eKCZ8lC6qB2A1poYuKkb3rXt9HZBVh7hPbwvgCMXKlOFiGp/Gyf4uucJQ6
azZRHzWH4o48qUzX93NSVcPo2oxkFUCnxbaY4ImaqcJaM9X33Wk=
=7ebW
-----END PGP SIGNATURE-----

--KFlTdV246go+DvPy--
