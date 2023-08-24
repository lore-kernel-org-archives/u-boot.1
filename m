Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C54EC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2957386751;
	Thu, 24 Aug 2023 17:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oXSjSTx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B62E86751; Thu, 24 Aug 2023 17:14:46 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F88C867A8
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-58ca499456dso41477b3.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692890082; x=1693494882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T9fo36XkZSsH70LsFdPPgpzXlMT6rEQf97b8qYxKuYA=;
 b=oXSjSTx1HqHFmAYsPCxQbBVlaA9o6+NvVSIVUPDIE/b/BP/gjvGB1d9eJxCVbhGj+O
 30hoCreu2tuQiBjEkpmkgCpPSqP4DdYIgMmAj7GM8FK9kT9msoAzITSFIiXq6iO3ox89
 xDFSs1G7uv6kKzHLccdzSyrV2PTap164uvu6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692890082; x=1693494882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9fo36XkZSsH70LsFdPPgpzXlMT6rEQf97b8qYxKuYA=;
 b=l3TNk2chz1+eOimPPEUq0IcUUA0p8yNxkTl4SV1m1xKkVUJmfGoScFx+P0v+g91U0s
 goTkcMYRAc+J3X+2c1Mtdd1DWuKYXfNEWJ/y0ZpsW2360yGvi3K1So07cB7Z+zgYLFwB
 k/NTN5TGA7jZy+5r4yK5Pv33wfbhxXRkM73Whdb0tOwvQsaLHz5hLOqRZaFeLAzTXeQh
 Mjr6yUZ6CzN1z4NvpwvrUnPyS3qCOPXscB0Kt4KcT86tnjAwBXdC16LHD4wPk3Gx+J4u
 QxcfbRThuH3/Qw2foxwvweIDTUude9gjsIIm5fMx2+fOKqr67eHw/1omeM8BPzZKZX9n
 70+g==
X-Gm-Message-State: AOJu0YwmcFdjQnM9zGrXzzS6QUqYQ8BIYqmbEEB3ZFzwHJdloTQekpIj
 9ywSD1T3OUjzgKv+Hjai5vYPnw==
X-Google-Smtp-Source: AGHT+IGu/XF3HL7KWKBXM0bJa7zHIhWvWHkppIyrnGrMFh+G96jPxeuSc2AcNNd24r9krVHEXC1uEg==
X-Received: by 2002:a81:9915:0:b0:592:9236:9460 with SMTP id
 q21-20020a819915000000b0059292369460mr692129ywg.31.1692890082201; 
 Thu, 24 Aug 2023 08:14:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a81df0a000000b00577044eb00esm3888251ywn.21.2023.08.24.08.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:14:41 -0700 (PDT)
Date: Thu, 24 Aug 2023 11:14:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V5 08/17] include: env: ti: ti_common: Add a generic
 findfdt
Message-ID: <20230824151439.GY3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-9-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XbVJrw2r8dId7pX0"
Content-Disposition: inline
In-Reply-To: <20230824031101.3460411-9-nm@ti.com>
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


--XbVJrw2r8dId7pX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:10:52PM -0500, Nishanth Menon wrote:
> ti_mmc bootmethod uses a findfdt routine that is expected to be
> implemented by all platforms.
>=20
> Define a default findfdt based on configured DEFAULT_DEVICE_TREE option
> for u-boot. This saves duplication across multiple boards and handles
> architecture folder location changes centrally.
>=20
> TI ARMV7 platforms will need to override default_device_tree_subarch
> in the env file to point to the appropriate platform. Note: default
> "omap" is used to cater to "most common" default.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> New patch (part of bootstd transition)
>=20
>  include/env/ti/ti_common.env | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> index e87a41a6590b..322f849a5560 100644
> --- a/include/env/ti/ti_common.env
> +++ b/include/env/ti/ti_common.env
> @@ -32,3 +32,15 @@ bootcmd_ti_mmc=3D
>  	else;
>  		run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; ru=
n run_kern;
>  	fi;
> +default_device_tree=3DCONFIG_DEFAULT_DEVICE_TREE
> +default_device_tree_arch=3Dti
> +#ifdef CONFIG_ARM64
> +findfdt=3D
> +	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
> +	setenv fdtfile ${name_fdt}
> +#else
> +default_device_tree_subarch=3Domap
> +findfdt=3D
> +	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subar=
ch}/${default_device_tree}.dtb;
> +	setenv fdtfile ${name_fdt}
> +#endif

How does this override work in practice?  I fear that it's relying on
the (not exactly documented) mechanic of "last one set generally work".
So perhaps we don't want this in ti_common.env but instead
include/env/ti/default_findfdt.env and then #include that, and then
platforms that need different just don't #include this.

--=20
Tom

--XbVJrw2r8dId7pX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnc98ACgkQFHw5/5Y0
tyzCHwv9FHVj8lhzN5cZui88DyGDwo/Od3SXO5a4aWeiIveDSH1gxs78x3+3U/dK
WE7LiD5VBjFHqwq0dPg3MqSQJ7NyKI2gZz/C5BeUyI+xEC16/SknZqH3J3nJSIAG
Q7Fqhy83uHKrHqyAxzJYoAxJZSO/tj31r6IhV8lQlUYWouCHGfTzF9Dx/rPr/Hdb
HsvmsZ1Xpv0+1RA1vFQTHfqshvPigJMmk+McpclR2synED9tLA6CvAhSRQFEFcDB
a5K0lsBRVYQRlqcLmFpiuh5Lqy8GQfXxvAn4EBCvoZ9NQujR9Ui5WHfVvm1bd25R
GkubrNz96mSKnlNVHodvFQh/zqktF2Zxy/tlRtOWO2pJDnKtsHht/T6A5pfJVMdy
HeMsmoLz5gtqR0/c1ZDGMojnB2oRcU1Kl/jGBapM2oIi2GmSwpG0SP/yx/qR2fJl
P2wuas+LWRuC/xnLboc0Jqya7bTfbO7q4XNG8JK/Gi9jOlUy0AyWgNosYt02yhSE
cU9hMVEy
=ZAXM
-----END PGP SIGNATURE-----

--XbVJrw2r8dId7pX0--
