Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D10CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 15:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5C483734;
	Mon, 13 Oct 2025 17:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D/Ly82Vb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33738381D; Mon, 13 Oct 2025 17:55:52 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FC682BA7
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 17:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6500448067dso2410344eaf.3
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760370949; x=1760975749; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K0FeejrPTIOqlT5FEyst2N1ZzZD5C+GH1ElFuyxRfZU=;
 b=D/Ly82VbrtjXEOzu1PZymr3Ikb/AbskeEe0iz9B1RRGmAEugt+qZB+6CyNK8nq7H0g
 7A0tjmYPQnOpMXGSuw3084ZUDoFsRCP8epgXa05o0NvaYVIOSZdE/pHt13Hq/3IAkR7+
 CWWKveHI/YXIulPds4SRl4tZZWfglQGyieAig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760370949; x=1760975749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0FeejrPTIOqlT5FEyst2N1ZzZD5C+GH1ElFuyxRfZU=;
 b=KADKVkng7PSncZUz+gzGyKgRLeOVuipjt/UHxQo8NZfe5G5TIwmgBCZDOVXxamefaG
 MChdCa6G2RxHuKw8jdLO3IFVQV4WCECfJ7AnNyxgL1HKpBZx/qgb+BEJ8lZV5SvMXFo0
 f6PnJ1+g4uTR/ocnkq+Hp2R1yZWTgAL3vU0WVlecRmUatVFxx/cguyHIDjcahozpaltP
 KU1fGaCRCUPf0TSVbvia5yT2ukalTQwn5a/sQf1dRyJDO+YyBxmEyok23Bsr0Uyw9JB0
 6Loq1/fsRlIKiyaoovWF2qGLu8POq426ONa0gzeUBo057mUX+4zKSnBzBWk8xLi8EnxZ
 h9zw==
X-Gm-Message-State: AOJu0YxhLpwN/q2UpOnvxrEi6HouWrc84GCl1rmHKwYAjsPIKgeotHqt
 +53bscx2umEG7f73p9ii7CZqbZ3QjwTb0ki29HUyGTJppFisOGgtMUHTYkrJe5ACgSM=
X-Gm-Gg: ASbGncssEJVF4Rc/J2dce4sAXPvk+Z3GAJEVVJsjTwlOM0SZ4dLTqBkBOUsSi80X68p
 ++CVJ1xSmLeUkvcv9SrLc1GjWnBK0ScTibsszjk1OOSDZCMv8P5IqcxJzTX79ZKWkae03nJwvis
 GZk0s6XNahmKK5rCFsZTTFP6EUYQKfav51T8qvwFzZ1XTwgTe1z841E0Sczq9KTo4bFcDIHhpMv
 +OOe/6PrcsBPS7ljcBJM54R9WxFcIGNUo1ZvY9HzNhWaBc2WN+4gooBc//zgNGYgLF3zgBqYUgT
 pNRrN5YS/xPWjsBDOXom8kUVqSZe2YWvh0yZMspQSjLNdiJyitmS7tv5q2dUmgxHShHxBDc/LEs
 ozlDyL0nMVz7imNTd8CjBp7gOidbZTmk991zUxXU17FlDAAJy4fOTXqUUySjDNZJX/OimcQMmMP
 2mJEl6PjzNQM9oorGc8L/TH3e4hQ==
X-Google-Smtp-Source: AGHT+IGrcCu+wK7pPghmsjxCtUaTA/lYrKgnZIZ5f66iNTjmnUYrVNM8NxTgmMEGOHDPaeEk+c87ww==
X-Received: by 2002:a05:6820:5053:b0:64d:2b5e:ad11 with SMTP id
 006d021491bc7-64fffe25dffmr8464114eaf.8.1760370949577; 
 Mon, 13 Oct 2025 08:55:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6501812f4aesm2705062eaf.1.2025.10.13.08.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 08:55:48 -0700 (PDT)
Date: Mon, 13 Oct 2025 09:55:46 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Udit Kumar <u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>,
 Judith Mendez <jm@ti.com>, Ryan Eatmon <reatmon@ti.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 06/11] arm: dts: imx8m: Add remoteproc node
Message-ID: <20251013155546.GJ6113@bill-the-cat>
References: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
 <20251013-imx-rproc-v1-6-fb43a3fafcd0@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5f4SvGdaKPbGqn2N"
Content-Disposition: inline
In-Reply-To: <20251013-imx-rproc-v1-6-fb43a3fafcd0@nxp.com>
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


--5f4SvGdaKPbGqn2N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:49:25AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add CM7/4 nodes for i.MX8MQ/M/N/P.
>=20
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imx8mm-u-boot.dtsi | 4 ++++
>  arch/arm/dts/imx8mn-u-boot.dtsi | 4 ++++
>  arch/arm/dts/imx8mp-u-boot.dtsi | 4 ++++
>  arch/arm/dts/imx8mq-u-boot.dtsi | 4 ++++
>  4 files changed, 16 insertions(+)

Why is this in the u-boot.dtsi? We have
dts/upstream/Bindings/remoteproc/fsl,imx-rproc.yaml and so your updates
here should be compatible with that, yes?

--=20
Tom

--5f4SvGdaKPbGqn2N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO0g+QAKCRAr4qD1Cr/k
Csj+AP9VQGMX9cTAjJpR5z15mdtHeuxCCXPtupmLmvDYpwL5qQD7BG9dxl1XMngn
4Y1nHHlY7NpPNHvVYBQR+FkK9sJ5ngk=
=weZd
-----END PGP SIGNATURE-----

--5f4SvGdaKPbGqn2N--
