Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E86CF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 16:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA6E88F66;
	Sun, 13 Oct 2024 18:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MhQYrwA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B57C88F4D; Sun, 13 Oct 2024 18:15:21 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C0988EFD
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 18:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbe3e99680so17477046d6.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728836118; x=1729440918; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7x4gRiDteVD32utIIHla43n+B1GdkIk55vSK6O0f2N0=;
 b=MhQYrwA8hsP269BhqXk4Yf6n6jR5/12AWnP3as34yFpROs34GSvqoujVDDEDsUOuhq
 LsvbvnuvpYriMkn4xgchbls4yBzMMvQpj1MrG5aRSsuUMhuqP2pqOhX2HZYb4ksqpnfi
 AXezYumkhYD1nsgNGgVFLfrujR+Rzexts5fZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728836118; x=1729440918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7x4gRiDteVD32utIIHla43n+B1GdkIk55vSK6O0f2N0=;
 b=c/i1MtcBZgrJSluWGesKBoue/Bfqeedzv+/fS1jRPCN5LGnR3Hjr6OkvGR0Z/CYapl
 P0ASH7hsI+ywANbrvzD8jg1TLAOBI7ZdEuT+WAq6FkizUiBMGPEOHCZJqA/TwH2hphtd
 8BH8E0Z7TzVbJChDK3XGJxvYjj2X/9ugeRfu2SxFi+ImXea4NGCCpXrgbrlw5KjzfsFo
 B0d3v7tZfCiq/WIEumbIoboi2r2zqVNHH5FGERfmwSbbvmPxNN0yps0vxZV/aOHbzYEM
 bkl831sQTqhjgdP3u3yMwjlrLlpsM7nsKmS/l4vcYk6+QF38fOLHKjGWwQ9karDdYKGb
 sCOQ==
X-Gm-Message-State: AOJu0Yz314nOxgI1ACel45Xrt6A3Nzf3mSELsnlW8P9mSLVCzEYzeAYj
 k5XcUNb7sQ1mRonBNYAHtUPd+ATJ9nu/TWCguLZHwz3FzKTu5/AqnNc07xq9yZsGyWUyOiJA3G0
 OhZCfZw==
X-Google-Smtp-Source: AGHT+IHmykGOapWXtH4H+G7ZMwjbtZCaz34QtwwbKXeWUk6D3iHPwkLjtfhjp+v3M5LP6gQ6olqbgw==
X-Received: by 2002:a05:6214:4686:b0:6cb:ef34:9c00 with SMTP id
 6a1803df08f44-6cbeffa5549mr159180306d6.12.1728836117950; 
 Sun, 13 Oct 2024 09:15:17 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85dbba9sm35892446d6.62.2024.10.13.09.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 09:15:16 -0700 (PDT)
Date: Sun, 13 Oct 2024 10:15:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] qconfig: Add an way to select defconfigs without stdin
Message-ID: <20241013161513.GL14210@bill-the-cat>
References: <20241012232231.5638-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z3wS0KDIE2cXyGBj"
Content-Disposition: inline
In-Reply-To: <20241012232231.5638-1-sjg@chromium.org>
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


--z3wS0KDIE2cXyGBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

:n Sat, Oct 12, 2024 at 05:22:29PM -0600, Simon Glass wrote:

> Sometimes it is useful to process just one or two defconfigs and it is
> convenient to do this just by listing them in the arguments. Add a -D
> option for this.
>=20
> Update the docs to avoid mentioning boards which have been removed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Much handier than giving a file descriptor via <(shell cmd).

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--z3wS0KDIE2cXyGBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcL8g4ACgkQFHw5/5Y0
tyx41wv5Ad0K3jn6qxOH3i3j0UDlhRfWncUF1eoQ4MNUsgxcXjiBrEyZvyzJP0jl
7uG8Wk8h8Tm5Gc9MSuoR0wdTbZ5ROjIwrAUrngUDyz+OpJhtDFQFTgxXZDQ+DprV
Ca1HMj/M4EeRZqzBN7Fl2M2zeBOKKBM5GVz5oJf+W0Ud8BMmBIGGp6IqPMWFAOoc
avwkg1uwkyUOC4LFxJlGM47EEhRLwuaujnIhBA+4v1d5IVTcg5g5DtS3MiOm5edQ
Vr5sP0m7CdrtSFIyJt1XcBigoyWPNIrs5V+WA7FyuQ03S33N8FwiuO29cO5Us8k2
nkfA1evb5rOOUI3MYfA7Orv6iXqcuTJW364JrkEpdj58KKJB+5RVmHTZSZ3Dc7S2
XPCmpqjizhBvFONtFmdwMH5Ab2AnlrBKIzQYKxTOcdpVxKs4wN9anm9DNZJDFElW
uo2mu2tdpAuNFdopUVT4d9thRetu835yCmexwmoBozbrrq9Zc7dXOJM/EhQzfz8b
X9syHRR6
=Y8Pi
-----END PGP SIGNATURE-----

--z3wS0KDIE2cXyGBj--
