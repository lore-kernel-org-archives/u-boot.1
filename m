Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E158C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF32B88805;
	Fri, 19 Apr 2024 18:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4bq6/Ob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 320D78880B; Fri, 19 Apr 2024 18:52:57 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE0A887F9
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a51a7d4466bso242195166b.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713545575; x=1714150375; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sF2rGu9+qKRDLTHys0Eddm0/2EF7BHhnIydlngGqBoM=;
 b=J4bq6/ObONumQ4uP0gRRo8tPFMrF8/iqpMN192ypO2C7cHzOIKc8pi3oJcRYXGbKBF
 BUDtCA0iSwFtpghrND0H6uzyn3E1JWx6jaC68NX65jZTD7OYxF6osZp4OaK0tF/n8xPs
 9YZ0pEugqLZMqMM+FBvd4+fI8B2PKOjw1oe/CV6sj9YTZ7WZn7GPyh+q//q/Z9dDS2Io
 2rOG0nN9xQwARSgbcb3mNpAZsFDYJCgZz6nIZu24Jed1ofE8LcjH+svu2PPFSjEPre9k
 U8g+WrdO8XqLAOiwQXeFKNY/aZroLDPH/25Bsmin0O8SOlRCKiNA1gQyDHlVk0swNzgH
 ifhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545575; x=1714150375;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sF2rGu9+qKRDLTHys0Eddm0/2EF7BHhnIydlngGqBoM=;
 b=nRDOBWwi7D+/nYBrF7RWLQCitq03wqP7ZBq059FHsCYhQGW4WklVoqQ19keICynyPE
 dCtBE810xZ3Gr58U4jsLYKM/9KqpJN/yeDHImnegoppmHr4oWWlXHrsU59frF/oMoIEV
 WNX4S/KAQLiB/xRXIL1BkDTLDFC3V3/lqHt0jqfR3FUXhIFta8aqZYRuBpZ4vWjuqDwx
 vawN0BSy+DCL07FYELj4IupQLQyK/DE/9jgcRj1PWDvcsxpXvpAhjG4Qy1KeHXYVEIaH
 MXkRrQ8L3iMi6F3pSCsv+GuwJagQq/hZMzP+8js5lAQiMdgzRTs8jmem1OiIK67c6cte
 6Fjg==
X-Gm-Message-State: AOJu0YxtJu1gxhfBGwmpoyxLVTK/m7tnHKTYocPzo7wg35n6k+D3JFcT
 KWt3ym9NbWk+VBsO8gTV3/kWipD8N5C5kCR1zf6Vtq2DmVpjIMuH
X-Google-Smtp-Source: AGHT+IGA6wmA8mJ8YB3OHxWAb19G2TWkH+L0ZbMpWORi2fXcb5YEv1GMhurYIO4+Z8XD4Ey/rVuAdg==
X-Received: by 2002:a17:907:724f:b0:a51:d7c8:300c with SMTP id
 ds15-20020a170907724f00b00a51d7c8300cmr2340442ejc.17.1713545574586; 
 Fri, 19 Apr 2024 09:52:54 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a17090655cd00b00a4739efd7cesm2426292ejp.60.2024.04.19.09.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:52:54 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=2e0dfb19a258c18552198a14cf4b0e6ac5335d94fdd4c19bf9aeb9e89b29;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:52:53 +0200
Message-Id: <D0O97L7HTV7Q.3G6J51KNSL29D@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 15/18] video: tegra20: dsi: add reset support
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-16-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-16-clamor95@gmail.com>
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

--2e0dfb19a258c18552198a14cf4b0e6ac5335d94fdd4c19bf9aeb9e89b29
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> Implement reset use to discard any changes which could have been
> applied to DSI before and can interfere with current configuration.
>
> Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dsi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/te=
gra-dsi.c
> index 25a629535e..fc9ca1310a 100644
> --- a/drivers/video/tegra20/tegra-dsi.c
> +++ b/drivers/video/tegra20/tegra-dsi.c
> @@ -12,6 +12,7 @@
>  #include <mipi_dsi.h>
>  #include <backlight.h>
>  #include <panel.h>
> +#include <reset.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/time.h>
> @@ -863,6 +864,7 @@ static int tegra_dsi_bridge_probe(struct udevice *dev=
)
>  	struct tegra_dsi_priv *priv =3D dev_get_priv(dev);
>  	struct mipi_dsi_device *device =3D &priv->device;
>  	struct mipi_dsi_panel_plat *mipi_plat;
> +	struct reset_ctl reset_ctl;
>  	int ret;
> =20
>  	priv->version =3D dev_get_driver_data(dev);
> @@ -876,6 +878,13 @@ static int tegra_dsi_bridge_probe(struct udevice *de=
v)
>  	priv->video_fifo_depth =3D 480;
>  	priv->host_fifo_depth =3D 64;
> =20
> +	ret =3D reset_get_by_name(dev, "dsi", &reset_ctl);
> +	if (ret) {
> +		log_debug("%s: reset_get_by_name() failed: %d\n",
> +			  __func__, ret);
> +		return ret;
> +	}
> +
>  	ret =3D uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
>  					   "avdd-dsi-csi-supply", &priv->avdd);
>  	if (ret)
> @@ -914,12 +923,17 @@ static int tegra_dsi_bridge_probe(struct udevice *d=
ev)
> =20
>  	tegra_dsi_get_format(device->format, &priv->format);
> =20
> +	reset_assert(&reset_ctl);
> +
>  	ret =3D regulator_set_enable_if_allowed(priv->avdd, true);
>  	if (ret && ret !=3D -ENOSYS)
>  		return ret;
> =20
>  	tegra_dsi_init_clocks(dev);
> =20
> +	mdelay(2);
> +	reset_deassert(&reset_ctl);
> +
>  	return 0;
>  }

Looks like tegra_dsi_init_clocks() already does the mdelay() and
reset_deassert()? Or perhaps I'm again looking at things in the wrong
order?

Thierry

--2e0dfb19a258c18552198a14cf4b0e6ac5335d94fdd4c19bf9aeb9e89b29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYioWYACgkQ3SOs138+
s6E8URAAv2W8F5kMiuAbfy4Eu8dC5Wmn13mH7md8WD1R5U8eZj60Oq1qSIwfRW/a
edAxVYLUQzTPDQPHZVojUurDZZlmeWc3eiualBYjRjKpNbJKXAcKOvaiI0pXEFrc
tgWQRTj9kAWi8n7ITC63V0oC29Z0XNzMo3H4srMdfZPfUUzRjC/t1DFfkjg20rhl
rgL31nPOmRrUIko2VAh+8hgXPUyXR4o3zRHi1U0etR/OTN1+SdoFNRO+EyK7IC4E
Ruin/DabE4rQmrzozNig/VRCDwvOR+62tLOod8R3aLVG7hD06A+wxV62mKoA9X2/
f32fow10/p0w0J6hyZudTe/50TiC8eRkHGQdZP65z9bKwu5asvr5h/f42ZU2gzDb
QCwVMSkeE1JD/NmWnQUVODN/QYfbpQ86M4JjoleTgv1P1x6PPCAIHGyUeEt43N9p
IaH396+itfLGFusOOrtdhf+YmzCvv/nG0wNBcsnJafqx1/xATjNKn5XlGPKrb1Ih
janWd0IfxZ+nB1je2ouqLb91QUz7vBgNPnnahr1qB6x/miUPYHYnA2Gy4RBxyYr1
DCJxtoBCZcKJ9QxSKPoaoxHKWHU7LHrcegRBzsJ9tdVoVt9ngJvjoJcHaP/vaEgh
43UWzfMySVMfwtmbMopYBNsHlfQgvS7DgGfa/KX8JgHkJdBwbP4=
=2Quj
-----END PGP SIGNATURE-----

--2e0dfb19a258c18552198a14cf4b0e6ac5335d94fdd4c19bf9aeb9e89b29--
