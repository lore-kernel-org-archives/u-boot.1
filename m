Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6631C7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 14:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1036382CBC;
	Fri, 20 Jun 2025 16:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dedfm7/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B3382D17; Fri, 20 Jun 2025 16:01:49 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC11E80C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 16:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2e9071e3706so1108469fac.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750428105; x=1751032905; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K98Xwl+NdwGTuwbxH1us1ih43EkWtRaoBU4+bxz97yQ=;
 b=dedfm7/jhDYKQReyKkCHJsGvgtc1WSRQqPSQC7oyO2KFCE3iGdm2U31UUOiyPcvUft
 C7zJ0ES/97r4t8PAj9l8YeNoTGVF3DjVyu7kz7e+ltbilJx+lj7U+kjKHDOadqO5yerq
 +QflhjMQzYUfiv5M4vMSdSI8EDtxgntFJ0Cew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750428105; x=1751032905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K98Xwl+NdwGTuwbxH1us1ih43EkWtRaoBU4+bxz97yQ=;
 b=a7VfDwwxaHD49HAWzMEgZHeGZvnLOeJtXmCX6w+JUuOpvu0uFJLWQjLk06k9xo8Pa1
 sxMDjcExi8eB0v4U7yySp2lwK0EJByV2DwXr+BBYdJhEQEg7OhDTy0PHxYHDsZaaSpTs
 1GOargzsQl5zNZQw6TerqOFjKoT11m4k7hQwlyEqok+TqARw6+d6m4CbNDKYT/BI7Oad
 sO5DYvnjQ/R8V/PPMFLSSo+9XRBJnv1bG+NweAQIdsVnGCqRkQvJ4mo1+dGgmyoQajCN
 I3Uuj/HQxIutzrvx7JnTUgXyULwYdon8aEfR+irDhvo1L1moNqP6QEHV3LpXgdBHdB4H
 ckuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjt08MRK8UQ6IzyeYEfiJBAG2dR3sP7NvGCokMHUs9152ZZtU3mH2TAJeu/tQW6anxZhOwS24=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz1ZAjUxnqmjJsk/oer7OTwHcFZiniUTyC7oQv4uiF86Es+oOC
 UETuHI0HVseunmvnsIqu3xpmOZU+FL1DuL8SKc+n3MXG2TQBjbRicymIJAssx0z1JEk=
X-Gm-Gg: ASbGncvNwXiBq5jlm/nxDArhZbtIJiQSlW4onVG8ZLikkFj3eyIgyNta5Aw5Iuf/vkk
 BL3niQbLAwu7tH5xxaS9h/NQc+SO/oLJ5/vShRheRaKiq5MgupLSmfDt3vQKtNOrl5KjtEWnN3z
 YME3+QAzCPjtM5xe54g7lsO9VfYAc8EDP51xW8Kk5tmMHU2YW3my9XjjkfdHZ7H5H81XLIBmrcU
 Z4uNEHT6RXKhGqW2g9JsDPV35+L0gj6HAiD8CZs0S1gs5VLHGYJS0z0+KOox3tJrx5aOKbKCjq8
 51ew1IQKYS9hNniN+2vkdV1wFHxnxxPErs07KqOcKORJMJ8vKepsDNYq4rqUNPoHGSKEXS+vWE6
 W1hGhMuKgyvMnmpjT6doIDq0=
X-Google-Smtp-Source: AGHT+IGzxnGjypqgV6sS6Xa5iabh06xouk5w9uKpl3Uqhyv17mHCwCKdvPmRWCbgIucRZCmcN47WKw==
X-Received: by 2002:a05:6870:450c:b0:2bc:883f:3dc8 with SMTP id
 586e51a60fabf-2eeee5e8d86mr2209809fac.34.1750428103518; 
 Fri, 20 Jun 2025 07:01:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee8ee40a87sm398027fac.37.2025.06.20.07.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 07:01:42 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:01:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
Message-ID: <20250620140139.GG216500@bill-the-cat>
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-2-semen.protsenko@linaro.org>
 <CAFLszThSRtSofySbSBa3hHn2u19bCm-jq_S4gXG+pXFjiiJsHA@mail.gmail.com>
 <CAPLW+4=38cBhUXyngbLG-iypxx+ksXp2-3Cjm3Wgd1V+pMmfCg@mail.gmail.com>
 <CAFLszTiZdbMu64_+=LV3gxUf_Jm9Ngxdmg=+XrVhGNHR9FDAnw@mail.gmail.com>
 <CAPLW+4nCr1j4MxR9mjAt3JtocwsxBKgWpah_ARODX+6ENs-xDg@mail.gmail.com>
 <20250619223520.GE216500@bill-the-cat>
 <CAPLW+4npMfxD8ihnBPNxrG6PjagC4RHUzEyvfrEMw8AyK8WVSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t9He3lbfuUm5bLNS"
Content-Disposition: inline
In-Reply-To: <CAPLW+4npMfxD8ihnBPNxrG6PjagC4RHUzEyvfrEMw8AyK8WVSA@mail.gmail.com>
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


--t9He3lbfuUm5bLNS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 09:41:07PM -0500, Sam Protsenko wrote:
> On Thu, Jun 19, 2025 at 5:35=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> [snip]
>=20
> > >
> > > Is it possible to just apply this patch without a test? It's clearly
> > > fixing a memleak. Not that I'm lazy or anything, I came up with a test
> > > like below, but I don't want to send something that is quite hard to
> > > test. If you think this test is really essential, I can send it once
> > > bootstd tests are fixed and can be run in one command without any
> > > extra non-documented work.
> > >
>=20
> [snip]
>=20
> >
> > Yes, we can do this in a follow-up I think. I'll take this series to
> > -next soon.
> >
>=20
> Thanks Tom! It's not very recent though, should I rebase it and re-submit?

It still applies fine, thanks.

--=20
Tom

--t9He3lbfuUm5bLNS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhVacAACgkQFHw5/5Y0
tywQXQv+Pmk2iFf9zSA8EePIRWRdILiqH8aE8lOUmuBxTDe0UpeXyoQzbfM92jes
O1NvZWKabLhCR9qGQNlV0OkP/9GV8BfkzgUJKnECzmxNZdBqBPq3wsfS5vy9f1wp
/BVNYwNpbybJUF+Yd8hXj+1eUWHlvD5B6yurcJc0iKGM+ihS9BKFoDGPNOlgNbmB
EuDeRRqQn43RV2dk0p8i6R9w71KxiNXSIux6ZyE28zLkFtkfdNiQMNhNEugBUg80
yV8iQZa4CqoxOJUTcNqAQJqJT8v+v93J29t1M95Jm/L00f2G11nF/q62zGs9j8WZ
wEgFrvbmSpkCLyl3DzuwGL+/Gw3TwrXPL25aC60qsyWm0+jeaPA0TY2F9bywbuiI
wnVrQlMIp3n2ULkF8N0cpYHy7dK8Fz1AzUjToJg6dJVLMOo5EFiZATWMAqr/nLL8
5pMgG3vvAC55hGG2tDuV842vj+a8yQOVW7LUWaQA3n1xKS/yOf8RBArPcqJqavSJ
WsUqXMTK
=dJoF
-----END PGP SIGNATURE-----

--t9He3lbfuUm5bLNS--
