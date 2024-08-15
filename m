Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1898EC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE9788C02;
	Thu, 15 Aug 2024 22:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jd7UIF75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47F388AFC; Thu, 15 Aug 2024 22:26:39 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C7D488A75
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-26808290f43so1419141fac.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723753595; x=1724358395; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bAHLPN1Mvqhniw9bF53B6D+QpslEDP7qvRe/63igTiM=;
 b=Jd7UIF757hdNeujEPY1QR7R/Apau/z49MG7835mDq8ENZZG75wdWjhMjhh8yKnw+7b
 hNqaCfLRXBx6HlBiCxGMsGMCzHNvc2KUCDkGjmCtrP+vcX+SHkUXmbXq8sxVlW5eCZI/
 yWNrooINz5j9zMrAsYqvPCzOm70qDmKi18+XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753595; x=1724358395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAHLPN1Mvqhniw9bF53B6D+QpslEDP7qvRe/63igTiM=;
 b=Hy8jndQq/LCB3wACoTGQ+p1isYgYN4k1W/qyD7t9S958nnFUSouDf1zFSiBXhhW6qP
 DOIxtSARGQ0c4vuDAbtvL/JXdDiZiKX0+42jzMXjJHIoxj1JIMJLiFqByHMKxPVJwr1s
 kZWboiv+/eRFUaaZhxT2knXZLdRqCIpInesHE5/MIGdvD7+E39QAtlTHLUIzKAhFmc/p
 BsY1oLobW9eA9R1vJqLOe12FWMB66NOxFT6gjoob4lDKuGbQZYvlkW35Z3QKBKGCg5aJ
 Nmdx03ZtmofK5LhQzgr65ZJGtsgj40h5kzDvURG+Ln3/fUOOxjgrQDzHmLAU2yrOcFFG
 K4pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTFs7cbSWBswcQPk/DGrdmvXBh5YEqI5VhcyV/lhUlq6mMXKMH+UgRIwhVBtzHVtNEVSPdoteSuiHp4OXbj64AAJBV5Q==
X-Gm-Message-State: AOJu0YwJ4KeildTNDV9oNHYqvtJinBhd+twMzYLsgF+0Jjh9jrLAhq1L
 Wzx9FRszKWJciOqmYrU+E/J27zlVYUT1AxOiLQLxHx6P6/HFjdYAChkXDyquGTM=
X-Google-Smtp-Source: AGHT+IF7mDLUTK6W6+bROITFmGsgZpakCu40ChKt37L1aFdwYhW6o9nMFT/aiK3MpKz193ATPBwLnA==
X-Received: by 2002:a05:6871:e009:b0:24f:e15a:6536 with SMTP id
 586e51a60fabf-26fff648028mr1451744fac.18.1723753594663; 
 Thu, 15 Aug 2024 13:26:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2700442fe47sm526048fac.8.2024.08.15.13.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:26:33 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:26:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] sandbox: Fix pinmux warnings with non-test devicetrees
Message-ID: <20240815202631.GA3407483@bill-the-cat>
References: <20240810135249.4037082-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zVvbS5G4hy72K06j"
Content-Disposition: inline
In-Reply-To: <20240810135249.4037082-1-seanga2@gmail.com>
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


--zVvbS5G4hy72K06j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 10, 2024 at 09:52:49AM -0400, Sean Anderson wrote:

> The sandbox pinmux driver is used in the non-test devicetree as well as
> the test one. I didn't realize this when I modified the driver for
> tests, and so broke the regular use case (which only resulted in
> warnings). First, making the pinmux and the UART group available in all
> boot phases to avoid ENODEV errors. Then, convert the pin groups and
> functions to the new style, adding onewire group as well.
>=20
> Fixes: 7f0f1806e3a ("test: pinmux: Add test for pin muxing")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  arch/sandbox/dts/sandbox.dtsi                | 14 ++++++++------
>  drivers/pinctrl/pinctrl-sandbox.c            |  4 +++-
>  include/dt-bindings/pinctrl/sandbox-pinmux.h |  1 +
>  3 files changed, 12 insertions(+), 7 deletions(-)

This introduces failure to build on sandbox_spl and sandbox_vpl.

--=20
Tom

--zVvbS5G4hy72K06j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma+ZHMACgkQFHw5/5Y0
tywwQwv+KeS3Vg6LJWLWpwJ+q6WYjZAo8HJEpWzIK/J3kyKZvIsj8koG7otZCMGP
kHonTq6hzEDkNDqvtrR6+7DByUCX9Nmp+NPWtT62PcPd//66UDpFvaWmRbkSZT4u
+nT0g1VhXyPBR47M340+XOVXD+CQ+SrepiMw5dCjOSCxyAYGR+D9nbi4d91RPnHn
7TA9PcIxNxf9SbBlGp96H32dNDBQunyfgfV4SwsVlBlDY4qvIrSKdcj+aslw8Rzy
laGxi+S0GGuMLK6G67i/4o6OG3b7PevK4/Gbrz6nT+bXfvJEi0aMALNf4ZxxdYjg
INy/AkmDg46stYv0pZRB9tHu0vEP+TY+QB2Cuz/czCTEHem7HwiSkKY1hqxS/3mc
E+iDkuhmtHa0dXTZNEIaWd4WGGBqsUb/H9p0ZrfUziFJJhZUMf/Qll2T5gcJtLOX
YLCi5+88Gf/UoU1xnR2Vedmgw/9T1DP6rY6WePNFpeSLzII+bzX9MvOWRIjhbHIr
uDe2HUIo
=iO5k
-----END PGP SIGNATURE-----

--zVvbS5G4hy72K06j--
