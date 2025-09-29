Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A9ECAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 17:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C778329F;
	Mon, 29 Sep 2025 19:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k0+e/JIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8437C832C8; Mon, 29 Sep 2025 19:58:03 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1270782A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 19:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-43f56048d2cso489044b6e.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759168679; x=1759773479; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gBTpnraflbGvCCoXibXnYLk9du+zuMvMmJzuzzCukdQ=;
 b=k0+e/JIcGoRvBYG0JAxcPh4VsHyyspPTfC7W2U43huCBwd+s0pQrTjRoThMS5wEysU
 4WAdlAl+PX/v39rVXdtgtCbDO6lr8cbhEhwOE7t5UDHNj7GjL0ZgM2ze1Qp5J9LT0lCw
 AIWPkijN4jSx02YUUijAO9KUAowYBRMzQGaD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759168679; x=1759773479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBTpnraflbGvCCoXibXnYLk9du+zuMvMmJzuzzCukdQ=;
 b=nerXnPxDh5ckicRUGBvmrn65NURxpfai14bm4qeog//fQ8jLXknXOBAT7o8HAABEqV
 nf9KAp38PIr9OOQz6eFp66Fn8NBCFVy6GN9l6XHjOnjey2YMHliRiRPHhpX3YQAFVXs3
 BQfbgwxHe9ddxJHkPHLmXth13mvjo5EKWWHggdpwt1MIT8VjgOEZe8TOQ1sqR6DhyGBV
 kvvkg+P7rw/3WVlcm1aaPIbSfz/nFeDiQ8ugZGCuNzmH4gxzOR+Idtax04oByzvwwmFK
 AfPQ7Uos+Qv2DR6ELkBIqCIgb3JeIQARf1mK4DjUTZ9jNoDaz8/3X+9S4Mv5OGeZUQf2
 UJmw==
X-Gm-Message-State: AOJu0YzL8gGGi5OdfsRT0z9t+mXkYIMQ/m4AFAVR4kAn0pAuxnyzUYWP
 SaQPqzdguvNkLsA9Z/YJ2a8fo9OlkIMmHJJgeNcsnl/N/IFbl/eK/HYLdjzmXluI9qdk5BXoCDd
 9XgpIOKc=
X-Gm-Gg: ASbGncvrB84XfYQc+NjiaClDV24O0NN77hXh5tkG0Yn/Y0gXccjW4JWvW7Rxwrh+xUr
 imR2t1tmLHw4gTQjOpJJ2ETTjxlkKIjdtaodSzrZ14pqvGjG+m+3eohKAzR9WdsYfMoPE5zGoN1
 s+Tww6+EhDB1AOvxjbzC6pr1mG0Tz5Dv4Ivl/fL3jj23tyJsVNX9w6o8smsGsAsqFl0BZceC3XI
 eEarjTq+7VzYbBAJrQSh9v7A/YEJBDe5V2gsxcgsKAQhtm6pUi7cQMi12fWcNAK7iVvUmTbGzSw
 vsC2lBXPaN2uCC5IWsGXoMSpXowr82gd9J/KLSYOVsuUxczi1tGHdIIoCFF5/y7lnaimGPhKhDJ
 hff/nhCahClKUy5IwsWjRoaYYNQVX8ILThO2C77Uo7R3J10RyZ0SATxOzTJooPANLjbA=
X-Google-Smtp-Source: AGHT+IH/U5eczz/xYieP9lY3gEXzhyMpqqaZdjhKZpqgUm3WDwKFLmtE2OjcQzKrLWGl4scbwEwliw==
X-Received: by 2002:a05:6808:4492:b0:43f:71b6:79e8 with SMTP id
 5614622812f47-43f71b67c44mr4618471b6e.11.1759168678686; 
 Mon, 29 Sep 2025 10:57:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b1eec7515sm1362451eaf.2.2025.09.29.10.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:57:57 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:57:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com,
 Hendrik Donner <hd@os-cillation.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] scripts/checkpatch.pl: Resync with v6.17
Message-ID: <20250929175755.GL6093@bill-the-cat>
References: <20250929172434.1034898-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="//jUujrtafQZm1F9"
Content-Disposition: inline
In-Reply-To: <20250929172434.1034898-1-kory.maincent@bootlin.com>
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


--//jUujrtafQZm1F9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 07:24:32PM +0200, Kory Maincent wrote:

> This resyncs us with the version found in v6.17 of the Linux kernel with
> the following exceptions:
> - Keep our u-boot specific tests / code area.
> - Keep the location of our checkpatch.rst
> - Change the "use strscpy" test as we don't have that to strlcpy
> - Keep debug/printf in the list for $logFunctions
> - Keep checks to "env" files
>=20
> This also syncs the spdxcheck.py tool and all the associated
> documentation.
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

I forgot to mention:
commit 0fd7ee0306a88bd99d3820167fa45a7ee6fbc1e1
Author: Tom Rini <trini@konsulko.com>
Date:   Wed Feb 26 09:33:45 2025 -0600

    scripts/checkpatch.pl: Upgrade IS_ENABLED_CONFIG to error for U-Boot
   =20
    A problem we have today is that some instances of IS_ENABLED(FOO) have
    crept in to the code. This is in turn because with checkpatch.pl this is
    only a warning and not an error, so they were overlooked. And looking
    deeper, in the Linux kernel this pattern is allowed because
    IS_ENABLED(DEFINED_FLAG) is allowed if discouraged and a quick skim of
    the instances I saw in the current kernel follow this pattern. In U-Boot
    however, this is not allowed, so bump to an error.
   =20
    Signed-off-by: Tom Rini <trini@konsulko.com>

earlier, sorry. But it's easy to not undo this change, so barring other
comments I'll just fix that when applying.

Thanks for doing the resync!

--=20
Tom

--//jUujrtafQZm1F9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNrInwAKCRAr4qD1Cr/k
CuomAP9afpn9fyO3Uwtl7v2ra6WLyM6tYq2cxF4AfPcwffov4gD9EiPH9tGNfGEI
vHg9e1jaqhi+92I21P/oP0Y5RqGlSQ0=
=IHhg
-----END PGP SIGNATURE-----

--//jUujrtafQZm1F9--
