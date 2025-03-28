Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8482CC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D6781951;
	Fri, 28 Mar 2025 17:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ScAuZvDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6092F81E47; Fri, 28 Mar 2025 17:06:04 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED68381E5B
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-601a46ee19fso1253975eaf.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743177959; x=1743782759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PtndSWXnbmvN/It0YxlrXquMplXr9NS4mthuVeFmnD0=;
 b=ScAuZvDLRk7Tx/5h9L5/2/ITTRw3wunp0n3nHPjCrZX3DYSV3O6p+KhKFg2jeryca7
 +j/7+2VUua/bmtfO51RaGBFavHvFMxItam6OQRD4hav2zt5XpQwa+fdkp9juXipacUm6
 eJ1V+6iS2gy+4uff0z/uwyc3Edjl9Fr5iwHyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743177959; x=1743782759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtndSWXnbmvN/It0YxlrXquMplXr9NS4mthuVeFmnD0=;
 b=BvHkBM3htfT2IzCI5+Su2bDiNNt8AGNoKefz4/kdBXdJ1wLzImQraOzrgrq3eNAgZX
 lNEdUiew/2ll9RnVAEnuy4hTnw3n+Ot9+WMszPKdt3DnrMihkZOfFuSX+p05wGZ8iE/n
 5aTlZxuvQJCiqhZJh+kAXeLRhk6Mptjv/H+/9QDcRSnoPSAqZNuOqSZWHIzTFlN+TYao
 Y93IRuHeTmVqWhBGWhipF0rSV1XkGy+R7I3HT+53cPLhHElhYIyZ7OMzbnRbT2+VwQ6b
 Q425ABAO/gJcFOy0LQb/WzrETT9Ity5a61bohe2I+cvLqLIZ9v1FKTOC9knH4tKl6ndz
 IbjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+KNgT8AKKSLQvwDzBqkbFdoUhPJk/wRn7G0pI2g+YCdIo9DDflm9xvukurhY6tF1OMBqZiHM=@lists.denx.de
X-Gm-Message-State: AOJu0YwkjEen8AfIYkv/tP6Pob7x4f+qXQtCbKBYKFUKHcx6+qtZJXEa
 kKZ7aMxf7oXUSsZu0DWUM0rHonMVAAh3C0Ra6KL0AhE1ipPezKUZ6tKBCbdYiEiDu64I8py2i22
 w
X-Gm-Gg: ASbGncv4SSaXBT8BHSufxcEAyyO5YT6g+pZG7b4+FqIiYqT1DA9DEicdLCtExCqK+y3
 llPr+GFEQDq1U5o06uVsLApw8EpYmEniumypXZ8NbQI7TnKJ2LTh127J1UipbRI1KGD1R1C9Cc9
 LokZcLaHnD/yOFybyx1UpXWr6urGnUt8bzIt1pbKQF96qpY8q4/TF2kN8MpiHd3SR+ZY3GWj0C3
 STVLHLyK7YBLl1hRke4UOL3WYMsjfynofcTFx0Qoh7KpI3//X+Z4QBCirkK11L+yXaeAsnvcUao
 27/foR19PlJygvSo031TwSyO6eqzFIaaqCcfMrS/sgAdAmP+jcqk7pFd7+gSOB+f4HXLDgrGJR+
 0M+5ABQ==
X-Google-Smtp-Source: AGHT+IGxdhmo0BY3OGtssuyRP03kJZi68ofrNZPYDK3mKD+BNkGtqM33SWKyjj/9U06Zy2dx1WoZTw==
X-Received: by 2002:a05:6870:440e:b0:29e:3c90:148b with SMTP id
 586e51a60fabf-2c8481d6c95mr5321176fac.26.1743177959523; 
 Fri, 28 Mar 2025 09:05:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828b38csm399162a34.61.2025.03.28.09.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 09:05:59 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:05:57 -0600
From: Tom Rini <trini@konsulko.com>
To: rafael@beims.me
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Rafael Beims <rafael.beims@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] toradex: apalis-imx6: Fix build failure when
 CONFIG_VIDEO_IPUV3 is enabled
Message-ID: <20250328160557.GY93000@bill-the-cat>
References: <20250328102051.2614040-1-rafael@beims.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xxfNr8xRo6jkpj3o"
Content-Disposition: inline
In-Reply-To: <20250328102051.2614040-1-rafael@beims.me>
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


--xxfNr8xRo6jkpj3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:20:40AM +0100, rafael@beims.me wrote:

> From: Rafael Beims <rafael.beims@toradex.com>
>=20
> If CONFIG_VIDEO_IPUV3 is enabled without also having CONFIG_IMX_HDMI
> enabled, the build fails for the Apalis iMX6 board.
>=20
> Fixes: 592f4aed6db7 ("arm: imx: initial support for apalis imx6")
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> ---
>  board/toradex/apalis_imx6/apalis_imx6.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Is there a reason why this requirement isn't enforced at the Kconfig
level? In other words is (CONFIG_VIDEO_IPUV3=3Dy && CONFIG_IMX_HDMI=3Dn) an
otherwise useful and valid configuration?

--=20
Tom

--xxfNr8xRo6jkpj3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmyOUACgkQFHw5/5Y0
tywENAwAqDtMoyoHKz9NgTaXFjHTF/JN/2PaSu3g2aQb6j0p4BYMaIwU0HEcscgt
3Rs7EJknrZ0cWUGn0980J4JUc3G4xb2u5XWuL52A3vgpZPxDeCdsiPuKXBhIJbWu
kMZij8mz2OkCaPkfFzvKUqI9vGAyg7KLX6t76RgNfRMY3Qhc98sZ1ZikS3xZhY1c
XN1sReHUFKak9uGZbIQU/hXuu8XqmwF/RS4ILf/IDhgJswPcjSoOTh+73NwqnvBN
sKhzsuog0Nn19e7czQMbOHssdEPpXIGDgD3payjcaoFumrqBv1CGSw2kV1o/jLfr
1sQI+IdtB4nA49W1zDFEKmA82lxCZLcVu4LqVH6lXvUpv3lq34wK6chbuUXMmXfK
ZNPHwGkUwMdrcbxi+kZyOzf81c+Sn5zFgUGgHdSCetl7N/lX4IYUuvASKHbeUTG4
ATcrYF9VDFGDMltsGcehforyZ26U9DEbuqVp5Akg0hi1cbhcwP1Of5XvTVcFXQW5
Us5AXb9m
=ZMVn
-----END PGP SIGNATURE-----

--xxfNr8xRo6jkpj3o--
