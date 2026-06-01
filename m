Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA6ACD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 16:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68006848A1;
	Mon,  1 Jun 2026 18:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J+Sa8MFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8AF848A2; Mon,  1 Jun 2026 18:15:20 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C58A8489D
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 18:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e6b574c125so1280701a34.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780330516; x=1780935316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qT/4zOg0qKn8aF/3RZQ1FBRAmee7kghnY08+pTkDvHQ=;
 b=J+Sa8MFb0MX/PMFTaMcqE9LLC2vbBfaVkm/K8oI4NMfAlYBVwgY/ThQOBWLbnEqeyN
 9/ecNQ1VCri7AhCMPDzQJRIr/QgO8m+KD3JtSLvSq7ClzppeeLtckRoNlpkNqIlv3UKi
 GBETTt8HLz1d31NcVQa0Ypx1N8crMbFy15vWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780330516; x=1780935316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qT/4zOg0qKn8aF/3RZQ1FBRAmee7kghnY08+pTkDvHQ=;
 b=srAZkBKoS9t2gz/Tlx2gNhsDBQUb7rxXsh6YAVaEFsHqNdIvukhiwtsYwo8KL9JVeE
 rvRZB8MfqOCftPW1BnH9JZU9pU5IzV3pf0M6W3MdtqLvK1QGWCTdlsNU3AeWw1HzqrF5
 h95RCwOBDUHA0mytxxwXgZ5asUlNWfkgt5zek8/p81FZ3POTmEIY+gBjSCWNRsLMohu6
 Ua51nIIca4AaT/7Qt0Ze0uS5GNIx13sUNSvo511IjWfpJmGXl/xrFR75CkkfokkcIOe0
 Dtm0XXDxgwdaiIA5IZSpaQvxJ1FRqqUtb7yXas9TarJH+ytrzfJo2BwJLz5Qfok8G9/n
 PW5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kdInLS49ZfzcnVkj5+UfqvHGR3des0frdBprORuToxGnxkQ3o5CHzM9TTGBWruaONDepy5fo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1zEQajvV8MwPxYYtTb5hplUWeyeSSt94DcCObG0MQhFS9aVIB
 1kWS/uBMTjB/Z5oxSFSYgZY2dXDjNSxZkl41JzDxJ+ANE/ErIk9SXd30Q53nQAvOILs=
X-Gm-Gg: Acq92OEtO9deAGDHj3sFia41PnTb7isLbaInoF6+K7qUgqH3tXrK4pNluGJ3qAlJu3G
 lJtieaYPooLJx1uzQzuzxYvYA7zCSV0/x6XkI8pVJ1WqYpzcx2YvSiNnGAYoh27Q4vbp8o0LqbV
 EVJ1HmsrA5uI5ZRXcpXYCWS+vAmmYjv/DBh+q3mec9hFWjaXY62rXqxrf+2tUJ8xF+Sh9bVrLg2
 Dirm6Qt5H+D7o2m0QuNKnpv8jVEyi4SqCvNnOQ034IEErjwyN4vSpFhN8v/dk58iHULwl69jCiE
 plkJwHAxcywifC6nDM4884JQO0ozO6vAwiZVd59GlFe3I+uq81/z5BbTvpychwVYKfVGsHY+MYY
 2RUswlZUl7LeS0II4ZVF3Qu/30NljwZBrVaBckzKijKS7dNRscNa5iDBAMuHdnjagS7FLH+enxy
 FcEG4y+X7v5CtLDGe3zLgHGPQnshC+fBwx2K71n89NP0lS1hgmXeaq+3pIYhrDGytWKm7g12wDU
 B1BelGpBwLh/faasL91iqbg49mwyKaImq6cnT0p8PhB41bP0BLMQLuOwtQrXA==
X-Received: by 2002:a05:6830:638b:b0:7df:5fc:3fd8 with SMTP id
 46e09a7af769-7e6a1d33cfemr7824310a34.1.1780330515733; 
 Mon, 01 Jun 2026 09:15:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695bef47fsm7859934a34.12.2026.06.01.09.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:15:15 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:15:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] fdt: fix condition for devicetree from bloblist
Message-ID: <20260601161513.GK627328@bill-the-cat>
References: <20260601082632.238595-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YXdPd17OxpR1+Aft"
Content-Disposition: inline
In-Reply-To: <20260601082632.238595-1-alexander.stein@ew.tq-group.com>
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


--YXdPd17OxpR1+Aft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026 at 10:26:30AM +0200, Alexander Stein wrote:

> On boards without TPL, but SPL enabled, xpl_prev_phase() will return never
> return PHASE_TPL. This the condition is always true. This is a problem
> for system which use an SDRAM bloblist location and initialize the SDRAM
> in SPL. Adjust the condition to take this config into account.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> There is also another possibility for the check. I'm not sure which one
> is better or preferred.
>=20
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1829,7 +1829,7 @@ int fdtdec_setup(void)
>          * not whether this phase creates one.
>          */
>         if (CONFIG_IS_ENABLED(BLOBLIST) &&
> -           (xpl_prev_phase() !=3D PHASE_TPL ||
> +           (xpl_prev_phase() !=3D PHASE_TPL &&
>              IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
>                 ret =3D bloblist_maybe_init();
>                 if (!ret) {
>=20
>  lib/fdtdec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index c67b6e8c133..3f31f9c2aeb 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1829,8 +1829,8 @@ int fdtdec_setup(void)
>  	 * not whether this phase creates one.
>  	 */
>  	if (CONFIG_IS_ENABLED(BLOBLIST) &&
> -	    (xpl_prev_phase() !=3D PHASE_TPL ||
> -	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> +	    !xpl_is_first_phase() &&
> +	    (IS_ENABLED(CONFIG_TPL_BLOBLIST) || IS_ENABLED(CONFIG_SPL_BLOBLIST)=
)) {
>  		ret =3D bloblist_maybe_init();
>  		if (!ret) {
>  			gd->fdt_blob =3D bloblist_find(BLOBLISTT_CONTROL_FDT, 0);

Can you please test the series at
https://patchwork.ozlabs.org/project/uboot/cover/20260519162225.770071-1-tr=
ini@konsulko.com/
and see if your problem is fixed there too? Thanks.

--=20
Tom

--YXdPd17OxpR1+Aft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCah2wDQAKCRAr4qD1Cr/k
CsuWAPwKMKAbI7qdOLCfOCzNDcM8f64hBmzIffXzXpvPPepDxgEAuCSjiSJqVGNj
ZH18q5IovnANh7O0Chy8nMVArFUrNA8=
=x4tG
-----END PGP SIGNATURE-----

--YXdPd17OxpR1+Aft--
