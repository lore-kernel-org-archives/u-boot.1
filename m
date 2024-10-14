Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6F5D18138
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 776EA88D9C;
	Mon, 14 Oct 2024 20:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X0UtuMeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33A188E8E; Mon, 14 Oct 2024 20:23:23 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A6F388CA1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7afc5e480dbso340687785a.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728930200; x=1729535000; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5qLkejdPu9c4tBz29DQ5xQNQ4KVsFVF/gKYeL6xmEa0=;
 b=X0UtuMeXYUREBig93lr8zOYEJAdFgbB2g7/sYgJXmxsFklEJZrqtcpFn+d4yRnWtX/
 EP31V1RLlERc2BbN6DbXEHAF8B79hRssNZX/Bu2sXbp9uV09QbVUQy5MDTV+K3sLHfjv
 kCawQWEtcKsCUhGt6DDAzilIDaOqHWKj8OvMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728930200; x=1729535000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qLkejdPu9c4tBz29DQ5xQNQ4KVsFVF/gKYeL6xmEa0=;
 b=oj/QE2kdz4NJY4MeRFSjmFrrOJKrLAbHycUFpkzQdDIM+vsFRxSHwSpc+gMfkUzG5S
 mrANEE+GTXM168pxBK3PEYN7yP5nSoLUITZj5bQx6BvbJahbywHG+GEyaQ6pL/srZEz5
 1cuBYFi8ChsKJCRbjPluD6f6gZbnEkOL0oNZXxSJ3FgzJaw38ux9CXydL1SWoYYdmCX6
 l18uqlHN4cFm7lEvfZiasaSTOA270hUFF7Dg/2Ft8HIYfG/LW4CV2bnfXVZ+SvVpYTSB
 +9b8Nv7yjTW6wtA8PoosL3RC8K1CuUNcIcogcWSv/xx5NrnewtGETf1Wgu2Vds/xnDPc
 wNjA==
X-Gm-Message-State: AOJu0YxsXzqxzulk0sBdbugR1in96piPjTRUfiDdlALMHBeng7wEL4dJ
 k9NzgzQ7pOVy5bAFhDSGiLaMvoPiSazCWJ1Bjd6+4aEIbXb/VC047h/ovqqeZkg=
X-Google-Smtp-Source: AGHT+IEqaCVDnCGk79quOgXEELzALR2IYoLneK1SAcAEsbBf4Hjumo1e/LFMM1ECiwn1dJgYcfxUkQ==
X-Received: by 2002:a05:6214:419d:b0:6cb:9c55:4215 with SMTP id
 6a1803df08f44-6cbf00ef18cmr171300186d6.33.1728930200142; 
 Mon, 14 Oct 2024 11:23:20 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85b7d53sm48194386d6.55.2024.10.14.11.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:23:19 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:23:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: Pull request for u-boot-nand-20241012
Message-ID: <20241014182317.GP53053@bill-the-cat>
References: <CAOf5uw=NJEiiX4qOWqZ6CpAjdwvyBsmonEn5egSAHC8-N6FxKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3a/mA/Wi1sYCztNn"
Content-Disposition: inline
In-Reply-To: <CAOf5uw=NJEiiX4qOWqZ6CpAjdwvyBsmonEn5egSAHC8-N6FxKQ@mail.gmail.com>
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


--3a/mA/Wi1sYCztNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 09:17:25AM +0200, Michael Nazzareno Trimarchi wrote:

> The following changes since commit 47e544f576699ca4630e20448db6a051789606=
97:
>=20
>   Merge patch series "Tidy up use of 'SPL' and CONFIG_SPL_BUILD"
> (2024-10-11 12:23:25 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-nand-flash.git
> u-boot-nand-20241012
>=20
> for you to fetch changes up to 25e46f8281075d3b3a8d393264ff1cd33f8815b3:
>=20
> This merge request add support for BCMBCA raw nand driver for bcm96846 bo=
ard
> that switch using OF_UPSTREAM and allow use onfi ecc params when they
> are available
> in the atmel nand controller
>=20
> The patches pass the pipeline CI:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/22=
638
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3a/mA/Wi1sYCztNn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNYYkACgkQFHw5/5Y0
tyxdBwv+LnB6606+tvjlvLorakVrKFk+wOtCxK+PIHISL9jE6Zp7yvueqS9aVKoa
Yaom5v6nSRub0TKi04IL1y3Z8NV4+5hebJ10Q9ZO2fXanXP/+xn46kTOoKt5DW8O
7/wrj5GUgFV80cphv1x7c1+K8EKsm4DyYYvm77Mr3AOOwvdX6boU1WEUagFfUKdk
Ss54Z9v9e0lwtgX54MS8bax/av7hIFB/6ZDzoFBcir96m0QpubPkptb6Ec85TfBM
hlL0FqjGSxVAjjBAPq/JpwPEitmiDEUBdLyX2eDyibg5sIZ6JGaBimituELgQ+ln
rCIEZoJdZ4XAcLEgmf1cOC6E//fLBIpL32/LZmqk6MWLgQZgNUA8Rh308hf6Z3g7
eJt3h24RwP0QA0GNXvJUPJpcDaONfOIbjIgzHKFtEWJqgWwEaVP762cQllap+MHl
/+c4k428TWmvbVcyMOC36BD7xjyppK1Lkz4q46MDapTWZe/9+GOuU68IFc2hMS1Y
hWo49YOt
=ZNTf
-----END PGP SIGNATURE-----

--3a/mA/Wi1sYCztNn--
