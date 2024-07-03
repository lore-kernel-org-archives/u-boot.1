Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D555C3271F
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 16:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA29882B6;
	Wed,  3 Jul 2024 18:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dp4rrNWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C0E88871D; Wed,  3 Jul 2024 18:47:37 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4FEF88261
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 18:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b53bb4bebaso3046558eaf.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720025253; x=1720630053; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9xV9ciEa3rEF1dPuWTFW01yXjyLjcJEG2DipwfPDLU=;
 b=dp4rrNWtPrB/s+2ALh4XVOCl5POLRfV/3E1FUc/OZJqE9bbbi6njpC/3zY8RJYtlEU
 7Rme35l+nDHqFZAa8gTgvuJi4OXqNHj8JrRIfS7yAGWM8Raufnj5uxboZhtonbUquLVP
 +d0l9zpeLTa1eQPzgOsvbfTocS76AjKcWGchQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720025253; x=1720630053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9xV9ciEa3rEF1dPuWTFW01yXjyLjcJEG2DipwfPDLU=;
 b=CHH+EwRUJJzGFSw2CjuaFw79JXDECbDdH5SqcPDS0R2xf9n9z35OPDjl3KhzUbH0bZ
 A95+m4TsI0LWhPZw19UFHMCKE0k2/+DGcAoGcsDDvN7ObGyU3Mjb/nJHo7l/lTf1RAx9
 VqY4d/Kc8sU9GtlQD8nlY522jouQnKSNkxZM9Dqlh0m0t7O84F7xw48cQNQWRvi5fihU
 TCMGEUmsnbliU7CrC0xkP+eO8wHzfFMUf9Mh8yqY7guxNYkIbjy1HrOzgFZaJUcrHQtR
 GwJfNWgQvwrrgFwt4ynaYZLblRxlTrTw+aUD/EYNetvSkG3UJNYZibuOTh/7GjcWrlyr
 mklA==
X-Gm-Message-State: AOJu0Yw3TFTUmfm3ydyN+LFrBbmsV3j1XvtYzM9Lj5oX4mfhw1pgsBgJ
 59vxjWMW4vVEh5Z0DnCQkfdBgJtMxZ01e/LMMn9KI/s3UXFMtn1as/VCgRtQUq0=
X-Google-Smtp-Source: AGHT+IEWeTyOGU8XaovpFuq6Tnn1jyIvABaU5l0FvrFXKfp6qbveZSThSzJz7FoT3Viue0yJeyAz1Q==
X-Received: by 2002:a4a:a785:0:b0:5c4:7933:951b with SMTP id
 006d021491bc7-5c479339607mr1964025eaf.1.1720025253646; 
 Wed, 03 Jul 2024 09:47:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c46ae49decsm367003eaf.24.2024.07.03.09.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 09:47:32 -0700 (PDT)
Date: Wed, 3 Jul 2024 10:47:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, m.othacehe@gmail.com,
 joe.hershberger@ni.com, w.egorov@phytec.de, t.remmet@phytec.de,
 d-gole@ti.com, festevam@gmail.com, mkorpershoek@baylibre.com,
 sjg@chromium.org
Subject: Re: [PATCH 0/9] Generalize PHYTEC Overlay Handling
Message-ID: <20240703164730.GA38804@bill-the-cat>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="91Fgd2q3Mzp0qUQs"
Content-Disposition: inline
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
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


--91Fgd2q3Mzp0qUQs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 10:41:53PM -0700, Daniel Schultz wrote:

> The overlays are specified in the bootenv.txt file that is loaded into
> the environment. Then these overlays get loaded and applied via a script.
> These scripts for loading and applying devicetree overlays are identical
> for many phytec boards.
> Create a common overlays.env that can be included.
> Add support for devicetree overlays to phycore-imx8mp and include the
> overlays.env for phycore-imx93.
> Rename existing environment variables according to bootstd doc.
> Move MMC boot logic into a common k3_mmc.env file and include the new
> overlays.env file as well.

Looks good, thanks for doing this!

--=20
Tom

--91Fgd2q3Mzp0qUQs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaFgKIACgkQFHw5/5Y0
tyyydwv/SddcDvSJj6SPL6IA5MhbdAVPoSGOXdnjUzTuTcF1AxUy/BC98LfqGUIC
Cv7V81JAelFtJv2exxhe0KyzFgsvBDQcdIqQF8glh17ljmHuyYeI9xYLxFMw3076
UEMARG9ULs4yNOj1JKwnFh/fTh6kSmE7yxZs82fTEH9I3cbZFCQIcV0BbH/00F7D
yaFN8NWzkpQNXcgyfoJDheNYSHbAzViPcALwcOdTy0em8PVFfLiQ4RqYP2mVs9qt
ULiPQnaYVO4KQ8Xn3t7G5I+KrHyPTZgqeJu74B8C5hysWgLcC590lK5MrwrQqAmm
3W7GvJTFokviZDBfe76FDIw8CRc1Po3RoRyUd9Um3XRx5cnsU9MwT51AXznbx8e1
vf6KV5yn/X20klHvaLsIXOU76qRqbwttgGz9ZXVlyOkt9aL8uML4XaV2DNFrHOst
5MqyfYnJChbdi5rJMtLcH4ocTJKheqD+eMpLOPohhxfvnG0Pnhs5bmQxMk/bCXkL
BsCftWsx
=5rP1
-----END PGP SIGNATURE-----

--91Fgd2q3Mzp0qUQs--
