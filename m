Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4119C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 18:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7AF882B97;
	Thu, 12 Jun 2025 20:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mUkTrWwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A1082BD9; Thu, 12 Jun 2025 20:37:10 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F9082B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 20:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4067b7d7e52so345115b6e.2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749753426; x=1750358226; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iK1rKKAykaV5B9B7Aqqb3DQxNDb6ZRK8zkxWJxpi6uo=;
 b=mUkTrWwoggJcdR4xYGL37SGvjK6G9ZcyWIMKilqQ44MTgWsWyWuyNGn/j4vrBCEG16
 HT1PdjBfPh7xDDtnyAcS/LNCaEPQSmNFEkJ2NkNsrsfg7/NSCDfln71q2NDPKAStc1fd
 s5iivkvp+MNvtYYuQdvu8k0lBA9K00D92JxHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749753426; x=1750358226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iK1rKKAykaV5B9B7Aqqb3DQxNDb6ZRK8zkxWJxpi6uo=;
 b=bMUL/t/TuZX5/xk/td3F58/tqRqDXyyUyGM6ROcph9qnGC/KLUU6XpxgDAUI9sBWbY
 Vr+InLvPAw+Q6jmbsnMDe7Nx+SkMuQ071rpy7L8eU6hM4Zu48KWEF7X8Oc3PMs310SWh
 rsGi8IRxFkjrbEvjDDFCbfr9SDV+Rb+svjkGneAwb0Y7boNPQeUbxU3ZQKzstAneSkMf
 +wN1VER/GX6Q+LLquMuxrvB+yG3AmZ2aXxulo+zHwTJdqUMbZQT8Eb79tJ5N8Xe7zR9V
 WnsGqvNQphFQJk2xutvNZ0Gj5/ME9uKFmB9e5mXBkjjkM2Cwmz+NonQvoh5HUP+Fn08+
 bJSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6zQu3lwh/CtuOFJAdTTVko7jrud/AU2mcpswZpMwqwFW1kvbtxfa6SB1sIjWLOBReAXYWRoE=@lists.denx.de
X-Gm-Message-State: AOJu0YxHJJkth1ROEyqL3c67fjQrUP6wsHvdI032pEPH490R5h4ukMdv
 HccJKf+4vjWrh1Nek0worEXdMV7y/EvhnixehKDGIjEX6Vjgf6YdDVd/RlN3Nquk1DA=
X-Gm-Gg: ASbGncvPgY/+MkWySFXgD4fYfZZRmc7uwyki9T9h4JKrnDyjaPsFtvl6gGGNqWqg4LX
 4q2vKwsYBOvABA3WPSf616FQr4AxPzlEWr8+4yT5WT6rDIhHGegZPes6Ht2nFZIkJbjRsY90Ijz
 lheOMUtXvc91OACUJj5cQ1fMezAuj7LiO+M3+oFQXLwuyF49KShq4Q7dAxwr8eY+8jPWOMDUAEW
 aXztOdTvcd4mnqu5UpqCBcmqxWXFxa3UeygN6iG/zCSHd+XwUCmQ5kQFRl46V58TNoqOB0JMkgM
 LTtpfqcoxpMKjcbXzXjMXTV57ZvAslxBMX98CgSCZg4RUqG2/I9rRzMPJmqoz0sEIrYuxkka2fs
 SJqe2OA6nMPHO1jiZez0SsCE=
X-Google-Smtp-Source: AGHT+IFnauO9QGc9AlZz6o+QFYmOJPKaTLWOJPrE6vhJbiL14bS9dS+RTSiMKX2HKf7anxG5Q5X7ew==
X-Received: by 2002:a05:6808:179f:b0:401:ea99:54b with SMTP id
 5614622812f47-40a71e82258mr301372b6e.23.1749753426562; 
 Thu, 12 Jun 2025 11:37:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a68329d14sm401106b6e.50.2025.06.12.11.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 11:37:05 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:37:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 1/3] dts/upstream: write fdtfile path to /chosen/fdtfile
Message-ID: <20250612183702.GV1382132@bill-the-cat>
References: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
 <20250610-b4-fdtfile-from-dt-v1-1-aec4df0fa53e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="44rLWzwNWvLfA7sf"
Content-Disposition: inline
In-Reply-To: <20250610-b4-fdtfile-from-dt-v1-1-aec4df0fa53e@linaro.org>
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


--44rLWzwNWvLfA7sf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 06:23:33PM +0200, Casey Connolly wrote:

> Since we're using the upstream file structure, we know at build time
> the path to each DTB that we build. These same paths are used relative
> to some (maybe version specific) dtb directory on the boot partition
> or ESP.
>=20
> By recording this path at build time and embedding it into the
> devicetree, we can set the fdtfile environment variable with 100%
> certainty that it is correct.
>=20
> Devicetree file names are already treated as stable kernel API upstream,
> since they are used by OS loaders extensively.
>=20
> Embedding the path into the devicetree itself just simplifies the
> process and allows U-Boot or the OS loader to select a devicetree of a
> different version for the specific board that U-Boot is running on.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>

My biggest and really only problem is that you need to work with
https://github.com/devicetree-org/dt-schema and to get the chosen.yaml
updated with fdtfile and then we can go ahead and do whatever that
resulting discussion is.

--=20
Tom

--44rLWzwNWvLfA7sf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhLHkcACgkQFHw5/5Y0
tyz3zQv9ExiZQzwtdN3B3qbDbIMzxHyyY1uV1deGFGX3mn+jEBhCvZ2WIFZ8aYei
brb7csTdA4jfVLFXrAzr3dn7dU+k9cAzFE0+ZDC7uGwVWSpNYBjtQHJFUSmpcu2V
vOK9fpNB1SF7CGlrvDyWPFsMgc+5kIZKDMqdUp8k66eAgsE66Zyw9Ly+nExdH3Mq
jGaaWzXZcngsb9pTJWXhGaG46tWJuJbTPBqyjYZhwl2WTg88+R2VZgDnk7Dy7LI1
yblY91dp5kwCwCbVNECut5B0Nbdfezf77GKjUcldvazTLI9k4kYgouRZKHhB8q2d
Na03MlGTh1pLCc29HCxk5I4prV6t/sK57/yy1BO6L9UiFteU+mKtL6/sH46rsoKU
iiGIXn4iHd7+Amy2bJUB2L1VLixiOJLugz6AaVwXEk6wqxjyJUmshPBLtzx0encU
TZENjdiKH3FVREFSTBa22nelH0txonqyewUSS0TTRIb7loGWUAkIrD2dOVWIxSvW
ggVhpaGs
=RuJh
-----END PGP SIGNATURE-----

--44rLWzwNWvLfA7sf--
