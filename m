Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9021BC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 19:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164BD88633;
	Tue, 16 Jul 2024 21:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZEMJncrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA65D88645; Tue, 16 Jul 2024 21:07:32 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE69088246
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 21:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-706dea920f3so31868a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721156849; x=1721761649; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HeqH+7dDmrMbXjBSUip4gAOVmTXQKQnFikOk2tvAHkc=;
 b=ZEMJncrnR53nu9NMbffusXXoBOxo1SuijzD5t4FawBmrXO50IZRjyDTmPA7MK7zUm/
 ++7ctHjFWsF2euDs2jD1MPDuBiEWhTQo7toR4FkfST5tYUfeWIUnqOv7O5MfCI1mIVu0
 jJogYVbL9Mz5gPs4B3Uv8pFGdW3rAB4yLXW0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721156849; x=1721761649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeqH+7dDmrMbXjBSUip4gAOVmTXQKQnFikOk2tvAHkc=;
 b=pjYA/qirk68M/TQ5cjHA8b8U8CkW97bzuWLaXOMTS7UpCGBTDvpk48NNUazAHqdJ82
 xybGN52FUHSrE3tNYXhMOBSe6FSnPPzXBlUSGEDjm89O5A/HDhjAYrR45fB1Mp4g65ew
 JKSndYAr8bkgP7/EtjKaAy9UmATkfUWXPyM2qw8hBuwvOMK8lhFl2D0vpXbBleYwGK/c
 RENLRnFAW7LHR9M/xzfZ4T2VcVCkY2Yk0aKNgdiUElxM5ngqCNcV8+n4j/DXxHe7z33x
 0cukeOQjaiBSsBvN3qhywol37McWs5eDNeIOrmWFCA82Uufv/fq5Q8PUNwtAh7BVwuJ0
 zt4A==
X-Gm-Message-State: AOJu0Yy20TpiWS0GtMhzYmPjppxbBOzDgERbm9UtUAtt8Dg/Uiza9nqX
 KGb6yZ5kTR1q/S8IIf72RcqJLCIwRkDNsbaorDjDG6/UtEzDoGpCOOptFBo9u18=
X-Google-Smtp-Source: AGHT+IEE0of60ENHwOYAjpeyCdKWyiuXzP5J1WghdGqybD3mh3LhxpZAcRVUHpaE/bHF3QU3PIU3OQ==
X-Received: by 2002:a05:6830:1119:b0:703:66bb:5a1 with SMTP id
 46e09a7af769-708db33af35mr1088526a34.18.1721156849570; 
 Tue, 16 Jul 2024 12:07:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d01834sm1436914a34.51.2024.07.16.12.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 12:07:29 -0700 (PDT)
Date: Tue, 16 Jul 2024 13:07:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, m.othacehe@gmail.com,
 joe.hershberger@ni.com, w.egorov@phytec.de, t.remmet@phytec.de,
 d-gole@ti.com, festevam@gmail.com, mkorpershoek@baylibre.com,
 sjg@chromium.org
Subject: Re: [PATCH 0/9] Generalize PHYTEC Overlay Handling
Message-ID: <20240716190726.GK561963@bill-the-cat>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4DjSbLw9l6urkRwS"
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


--4DjSbLw9l6urkRwS
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

Can you please rebase this to current master? Thanks.

--=20
Tom

--4DjSbLw9l6urkRwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaWxO4ACgkQFHw5/5Y0
tyxvGgv7BHyuQ8lBPRTlcWucBgWSqLEroOrMPOfv07GJ8/ATEk227mc5L+PoPT96
qA4VhzmQ577CVkswI0EWSgYd9y2xs2Uu+O/rwnlIrSO7LXkjrHON9FJw9OcMDkcT
u9jLNuG6p6d3VpNhnhpSdIeAlxkZ1oB33cF3FnDSANxWZFk3DTolL/vUZqt+Wdar
rNQzVWr+qDoOz72q9OlwJmfeOWKPO9/sj07ilQ9k4426mzx44Fxs+t+KlmCSuJdh
6O67VKQinP6J3Cx4wO5l1ac88+XltnH/67biqIWVtByAOgKGMIK+z2EYQhO+bBJL
ib+2B5D0pV0c9+1Vio4DfgxDwAq6Ev3d0GHdeP9U1ZUkhBnKH8CP6yD+wUJR1fpO
tXNUcgN/gHNFVPklCzkrv7E0z1K/pcjUXmIATf2UopkBXJzpUh0WnLD3RdlDI3/4
zjxhkmdplhwyQ1GT88TcQbeYg0zM3L/ZYchTMmr2qgGPmJWcg4sgeGbGNeRSH4ix
egLk0WLu
=S17z
-----END PGP SIGNATURE-----

--4DjSbLw9l6urkRwS--
