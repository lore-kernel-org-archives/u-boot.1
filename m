Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A55AE6ADD9
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D329893C7;
	Sat, 23 Nov 2024 03:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZRP8PCTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF44893D0; Sat, 23 Nov 2024 03:42:07 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08B2891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d40bdbb59dso19404986d6.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329724; x=1732934524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bez6hLakK7+eb3iuOAhGYfniyMGXzpT3Ft1Cyw+26EU=;
 b=ZRP8PCTijY/7RqFNpyUfDmvwAX3FV42kwcjrTzYVLZfaODvuXuSHfSASPPLeV9EnB/
 2xmr2mchNGmmHt9lY1OdhJuIYGqojIGsSv8Z2ZzI2wwFcI6vibPF0PupJT9V/pSWChg7
 K4Vhf6gDzNQwKH73xL9PzUMzUL6xso5IIiX7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329724; x=1732934524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bez6hLakK7+eb3iuOAhGYfniyMGXzpT3Ft1Cyw+26EU=;
 b=Qsi7SouKOC0lYg5dnT454KJYyCr5NiicwK4xnodf2RXBx25mVCrW2D5L+MNuER+iot
 TAlfieNXqM9uM5T2gQDOXD0Z1HEs7aBM7G+/3j8+eNRcBzmw2C5t51H7/sMfA15ppWQP
 IQOyp3NNTSfH+45O6HVZSwKHCznrTBgMmuvW1sWI8ExW3RTbimm+E056oLKvtuVY336q
 xS0k6k8rB6BXTl2H9ZezSK9yPMmz7TM/R2ztXITsBOr9w6wCOo6W7NCqmUUTxT1/7DHZ
 sOTp1KTzlsHSSrTqEH33etTh0psfTbRgFpgOuARh2byhFu/PHlkGZQjZ8nWDBi1jRZuv
 gdLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwWH4A4tpFm0hmjefZyB1D6tgMDxx499Pc8dt+kGhd8+AWupUrWhrBcDrmi0w7xoT4yf35UXY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3pOn36L+tZsrdWcYtV11Nwe7duiMO/D5z7KggMd57xCwzVThU
 WEkj0vQTM6XUInv8UbRDSA1EieQ1wieFE15LkO5EkFC8Nwy3vYrXXSl4MV+eJjM=
X-Gm-Gg: ASbGnctiQx1m8ZX+GGqGyT5NBdKhp9ym+/X8+WLGclWTD3QCRxcRMTGVdQfKeupTZ0J
 4Kpeo8/ABdCMjYlWAsXPT6ygq4XsqKePjDpJ1hIhfWA8oyDmPMEsj6+fK+2ZRbAQu9z5vt3+FtM
 WrRJTmKEtHPzpaVdkY3mcMplZ85ZxwSr6mn18apy4QYHuwArITgFqqJDgP6HihXJ9UCX4pNr9w7
 Hymkfj3V/3SLm0NYQNhbFUtrflzfXoW/ZYRam7u2o3HjllDrQ==
X-Google-Smtp-Source: AGHT+IFTxAXPrUFNyTodMwgFFGTZaAsolJLs1f5PJd8C6M7W/kfSF9Oeqyf5LCiVH53+YC+9wNsLEg==
X-Received: by 2002:a05:6214:27ef:b0:6d4:36ff:435a with SMTP id
 6a1803df08f44-6d451034a5cmr68119946d6.23.1732329724376; 
 Fri, 22 Nov 2024 18:42:04 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b4a59esm17006736d6.105.2024.11.22.18.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:42:03 -0800 (PST)
Date: Fri, 22 Nov 2024 20:42:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] net: lwip: provide entropy to MBed TLS in one go
Message-ID: <20241123024201.GR3600562@bill-the-cat>
References: <20241114142917.481564-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UR7VmO6/3m8QERvp"
Content-Disposition: inline
In-Reply-To: <20241114142917.481564-1-ilias.apalodimas@linaro.org>
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


--UR7VmO6/3m8QERvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 04:29:15PM +0200, Ilias Apalodimas wrote:

> We currently provide entropy to mbedTLS using 8b chunks.
> Take into account the 'len' parameter passed by MBed TLS to the entropy
> gathering function instead. Note that the current code works because len
> is always 128 (defined at compile time), therefore mbedtls_hardware_poll()
> is called repeatedly and the buffer is filled correctly. But passing 'len'
> to dm_rng_read() is both better and simpler.
>=20
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--UR7VmO6/3m8QERvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQPkACgkQFHw5/5Y0
tyxmHwv/aasWaBYaEZBRPSiKj/cbeoA3yYzi6nj9VjarN9JJesKv0nGYAEagboCH
ty0uFT2ic6aTV5K67N0pUk2eDxDnNUQzZg0PU2N9iHCrvNRad9TbQROX9c1QtpkG
xDfwnQfriq0Fuy4ke/w5dZK7JzZQdcDxwDUK+LzcKztnJxoP2CW84UuFtAJfqqs6
vwLGwc8NHfmETEA2KYBHF9nAspcCa6HxN0W/ae7GtF0r0tmKLpKlRoEUQjv2nGCc
grEgur995Fzwhfps9f2IYUDsmKwh+gH3JIG3vZr6IVzNru3XIezdr71VHTYB9L/G
hHxz3ZwGQ7CZ4gEt8Jej22dek8EZdPJiZIf4yu3AcJHGbDELEgFC2pWGEYqbEWMv
z8P327/Nz+EM0WZBevPKHDhCjomwUUvNTZgMIJPm6UQ2OLC2xoVFKbT64EoRruW4
6KyweO/NPmA7UxGbroFyB7fKDgbzOY197c+9WL4HN8x2QvtBB8WOhfyCLyoxiYKF
+hwN5JqG
=Cpog
-----END PGP SIGNATURE-----

--UR7VmO6/3m8QERvp--
