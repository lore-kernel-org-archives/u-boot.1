Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2AEE8FDA3
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 14:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A8D839A8;
	Fri, 26 Dec 2025 15:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V1RCfPo5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF62839A5; Fri, 26 Dec 2025 15:53:54 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1853839F1
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 15:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-450ac3ed719so5190057b6e.0
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 06:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766760830; x=1767365630; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XHVxpppHgzGrUyjUKX4O4o9Nr5TH7aLKPPP5HFG3qR0=;
 b=V1RCfPo5dPC5vHtAiedMEWLRPs9fj6gSuSTrrEe30uFUVWXJbK2EPt8MdiOHY1XZ9z
 vWWujbPr9NP+YxmCqPuJa31lQqRIM5BED9R5U5eLoNJCbWzN5lnPiPj53SB0d3+q84/C
 aVWr9/WBenD2IzfOb1GN9FD01KV1akwhXwBDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766760830; x=1767365630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHVxpppHgzGrUyjUKX4O4o9Nr5TH7aLKPPP5HFG3qR0=;
 b=OpjlWK+vRhUTaphArruPLgXR1gQTxyBHp9CaqLKZ5YfvVRts/ElZlldCJdoIeDYIz/
 S+tT6IFlV8IZL1ZFFuGv0tQGlZ4raw9TCB3V8rbrIWgUoqL3L3weeXM6Wqnkfn6VB3iS
 vnE7TS+y/MdtjeV6VIauNFpLg9fv2HZDBW9wPsFdwFUNL85T2FIdhcmwa1Wdg40FMZ7F
 ltS+52Bjxwak3QE9O/yyHcIVft3xuvjOJ9Ke678cgJYLxsmnVqPgRUivyhQqGY1XiP26
 gRv3/tFL2+Dv6F1ChR3sm8b9OviSPDTc+FTWyyw3wSyUDbq62JpiymF2tESEFgEvKUtO
 sZ5A==
X-Gm-Message-State: AOJu0YzIN4lvD4Z095ZJztSXpHZjgx3rhyJQo9EXt0fMnxElFa7hJhCD
 4bK9ArS50H5JF9DrfHTvurCr2d+/bieZTChEGWFtEwTC5sLjT6gFkknJOHsuElNpd4Y=
X-Gm-Gg: AY/fxX4BOZ63Z1UdcP3xHEPOeW9azvmWP30AY8Hb+g2XnaZ1s5vwB6ZJqNWArHBPHvc
 F4cxil5fPXfpQbXh7FRHwLAwEIkczZYYmIsVEiPltbm8/qAm3+3stH3UZrgTkIOksRw8J3ulOwL
 9Q3sXkGQIq/vI02qSIFHtOpEJbJj1GAuVGnmpgkBewwipRjUddh0h6k95/BMxjnv5cPVbaSbJN7
 XCJSQk8x/E1LldDJMB+TLY2+Tmk3NpoqJoX54lgtAL0t+/1GZOzOfp3ksCsD/2qA1S+jDBtnXot
 IsKTa4XbjdVyhiCizrLlOJfF4mjy3fi2J4RngQ/pdWXg+GWLaVC5RXI6ZhfnQdSf7QGdhrkIe4T
 EocnROt6xErybSo3wiZotuCtyDLmmvEAVc/aoPsrcugTrFOxZQUW+/o6+0P/OpbLOd/Ky4RR8YL
 Zr+evkWGJFpKeaxfODcDqRCEpVKHqHn1uJmvtK3BWK7a8hojB7lf9QzquCT8Tj
X-Google-Smtp-Source: AGHT+IHqxWLPYjC3Z3aolhlGYsGgFwP1CXYd08K94Dv2S/8YRAeBFzT6aiwDDIxTdDWRh7XPDAZHXg==
X-Received: by 2002:a05:6808:218c:b0:44f:dec0:b995 with SMTP id
 5614622812f47-457b229e1b5mr9239636b6e.61.1766760830489; 
 Fri, 26 Dec 2025 06:53:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b39f22e2sm11073893b6e.0.2025.12.26.06.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 06:53:49 -0800 (PST)
Date: Fri, 26 Dec 2025 08:53:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
Message-ID: <20251226145347.GB710860@bill-the-cat>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
 <CAFLszTjyO9d+QzwC=9t-cJ1Kx9oNcNSD3f7T+11zWwD-PJeYag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pohn8XGkJlIl2b1c"
Content-Disposition: inline
In-Reply-To: <CAFLszTjyO9d+QzwC=9t-cJ1Kx9oNcNSD3f7T+11zWwD-PJeYag@mail.gmail.com>
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


--Pohn8XGkJlIl2b1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 09:23:59AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 19 Dec 2025 at 13:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > The devm alloc functions that we have may follow the Linux kernel model
> > where allocations are (almost always) automatically free()'d. However,
> > quite often we don't enable, in full U-Boot, the corresponding automatic
> > free. This in turn leads to memory leaks. Rather than manually tracking
> > allocations and implementing frees, rework things so that we follow
> > expectations now and enable the DEVRES functionality to manage frees.
> >
> > This turns DEVRES from a prompted symbol to a symbol that must be
> > select'd, and we now remove our non-managed alloc/free functions from
> > outside of xPL builds.
>=20
> Most of the time boards don't enable DM_DEVICE_REMOVE to save code
> size.

I'm not talking about DM_DEVICE_REMOVE anywhere in this series.

> We certainly don't unbind devices. A memory leak implies some
> sort of problem, but if we are booting the OS, all the memory is
> 'freed' by that process.
>=20
> What problem are you solving here? It is missing from your commit.

The problem being solved is stated in the commit message.

--=20
Tom

--Pohn8XGkJlIl2b1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU6hdAAKCRAr4qD1Cr/k
CvS9AQCAwkRI5OJbmuNByXDu1O3Aci5waRSz0+ZCTJjFKIc6aAD9EzPFxKBE1beZ
9HVwsIreOACHGpshZuRSVI3EMDsv+wY=
=D5Ci
-----END PGP SIGNATURE-----

--Pohn8XGkJlIl2b1c--
