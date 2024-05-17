Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC31AC25B79
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 15:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E89088093;
	Fri, 17 May 2024 17:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lwgll+Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6AE87ED0; Fri, 17 May 2024 17:08:09 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C45087F33
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-43de92e228aso4399971cf.1
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715958486; x=1716563286; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1i9+UdJh+ewa0DoG9ozcY1f+KWU3qBe3f1aOV+LkAnc=;
 b=Lwgll+Nh0No2TeYk/QGkn0WhjgWXCKAuFMvZnUKWq3jO0Z6ZeWKoRuSRbG9qWI1ktS
 RcG+ZycgF4pAws4dt97jznHN7Hx6Ra3NdZ0AdoApW8V17n3XUh2J0Wky65eZe6Ep6S9L
 zLnlglcTwScjwvjuaxNMWRyOl3mx4HKAKGAg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715958486; x=1716563286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1i9+UdJh+ewa0DoG9ozcY1f+KWU3qBe3f1aOV+LkAnc=;
 b=blhq5Ke07oRg19wiy9YEX1Ht6eitYNBW/1YYwigqmjU1WJg6bAafvFLoOcrq4aRj/T
 0AtM4kjzzDrHYl9eO3M06KA4nvqvr3RPDdNpHuMSmbGcNi2p2SLvcPonv18w05oXcGcb
 8mvHt2Id7MWXuEfSGqGwfMDbaEOvUfOB76cLCtQyX+qN8rcKNqHaU0JzA1QpfWUPOBXy
 FLSWIYMddu4qgfMPMveblud4JgEkQ7Bo97LdbpAZzSQgai5e4dmqF35Nyj1s2CpudSpa
 Rzn0J4mFJiWvkPGi9DqJr7EAYmBGsUVDeyQbtSRvkXNv5g5dg+/vGa4q0pSMSbNrVMOd
 cuPQ==
X-Gm-Message-State: AOJu0Yxz+skBaNYpWBPyKpD74dBnTn2HYtHaU8mwM46UZklR/9Nx5ChR
 ebc79dy7GxOhMPLZ00cSiGhdjRLZPdDpLw1MPt4HG+/dqlTDMfcnfjrofTJKgDo=
X-Google-Smtp-Source: AGHT+IGRFbOBrhz6wNzBh0kkrTEXB55m9YT9JemkE3QtvuNetpVIjUt82Td4kJmMl9gz0d4GIxKdNw==
X-Received: by 2002:ac8:5d44:0:b0:43c:5d8c:f854 with SMTP id
 d75a77b69052e-43dfdac38a5mr325601811cf.11.1715958486135; 
 Fri, 17 May 2024 08:08:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e1c32e8basm64731761cf.36.2024.05.17.08.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 08:08:05 -0700 (PDT)
Date: Fri, 17 May 2024 09:08:00 -0600
From: Tom Rini <trini@konsulko.com>
To: tingting.meng@intel.com
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: Re: [Agilex7 M-series Platform Enablement v1 01/16] arch: arm: dts:
 Add dts and dtsi for new platform Agilex7 M-series
Message-ID: <20240517150800.GI2568172@bill-the-cat>
References: <20240517052701.12949-1-tingting.meng@intel.com>
 <20240517052701.12949-2-tingting.meng@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yY8Ce8692rO9zNZV"
Content-Disposition: inline
In-Reply-To: <20240517052701.12949-2-tingting.meng@intel.com>
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


--yY8Ce8692rO9zNZV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 01:26:46PM +0800, tingting.meng@intel.com wrote:

> From: Wan Yee Lau <wan.yee.lau@intel.com>
>=20
> Add Agilex7 M-series dtsi and dts for new platform Agilex7 M-series.
>=20
> Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
> Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
> Signed-off-by: Tingting Meng <tingting.meng@intel.com>
> ---
>  ...tsi =3D> socfpga_agilex7m_socdk-u-boot.dtsi} |  37 ++++-
>  ...x_socdk.dts =3D> socfpga_agilex7m_socdk.dts} |  66 +++++++--
>  arch/arm/dts/socfpga_soc64_u-boot.dtsi        | 127 ++++++++++++++++++
>  3 files changed, 213 insertions(+), 17 deletions(-)
>  copy arch/arm/dts/{socfpga_agilex_socdk-u-boot.dtsi =3D> socfpga_agilex7=
m_socdk-u-boot.dtsi} (50%)
>  copy arch/arm/dts/{socfpga_agilex_socdk.dts =3D> socfpga_agilex7m_socdk.=
dts} (63%)
>  create mode 100644 arch/arm/dts/socfpga_soc64_u-boot.dtsi

Why can't we use OF_UPSTREAM on these platforms?

--=20
Tom

--yY8Ce8692rO9zNZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZHcs0ACgkQFHw5/5Y0
tywi4gwAmtBSfToSTPQZHOHOIib1O5HUwTo7w9aFVQqON60grVq4O1vTzIcCblNf
CJ5S9nBM6wvWHN7LVvsH76esy+cRtag3VDK8NRNHJfmghyrZk1I83gsMJPNuMjOJ
xIguW13q1JBmTzyOqW0nUPKvuTrtRrqoqVa6yV+bqzWC7+vHA6fZSez3xP7Zbtc0
6R0qCC5HB0E51vCclI1mpsnZ5QykYs2TzBh5RI5Gc5AG/Xek2Q06olisnYsWNiFh
5FVR5hImswzdrSgypM7KwtTudUdkrwwhvwAgmZwgqJA6EzMBlpDEobehpNC5VIDH
rixj0I6Z/d9X9S0crhVxRbo1ZKNTrhplpEiqS0lCR2Mw21sP6CMZk4g2iDiAx1Gj
7a5MqpKisIK6SmciyTGC8GXxTMBmLab+u1ym7QAQ8JXegZqt+I6vhZjdZsDqoNkT
3lk62xtn0fOayDEWukxxp1RchDJpZNG5lCAVJsNRNwOaOI/kzo3BPTcMf9dsA1Su
DpLYFMDD
=i9Ni
-----END PGP SIGNATURE-----

--yY8Ce8692rO9zNZV--
