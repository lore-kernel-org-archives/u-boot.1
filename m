Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4D6C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA34887239;
	Fri,  3 Nov 2023 20:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dc0wTJmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA4A8725C; Fri,  3 Nov 2023 20:03:51 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEBB8708D
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ce2ea3a944so1397967a34.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699038222; x=1699643022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kRN13URGgWvtRy/GnKCOA+CNoJYpCv01YBg0tJpX5Yw=;
 b=dc0wTJmK4jcOPxxDqmCAt0H2Vqe5FfgzfcVYGGVj5bBdazGRojTgavxvmeljgoQvUp
 Wk6er4T14quYb2tUvL73kNlvcQebB+GBU4KcTR/72i41Rqg1wuQFVQBh05vGi8h63Q/q
 F4ggA28vHJ5CQ8eadwUIWlPBL+uvpPkS79QAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699038222; x=1699643022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRN13URGgWvtRy/GnKCOA+CNoJYpCv01YBg0tJpX5Yw=;
 b=WHwJUmBeuH6oSaexGpxxNfXEufbIfqgRNGi7telcEJLprWlH6Q4W304PhmaFlQQDI1
 5mVmL+xzim0Kq3npgqST0Z2TERWZqyf1tc5Vwr+6RP1a/IVQk88q9HOM62x4OZL2N9Os
 WuiqQNxkmNjAcsHeMksnBfmDHxsjf1eQfehC5Vcg0dyzkyuGz101yHLLcYmgLCZ89OE6
 dIWKgZAPfZ766Do0ABdJLWJ6HPCQnkMRJqabohXeAUmFPRqALZDMKL2F/gPff0fjNiXD
 3VwbVCGHEDnZHPDX8zaoaHUHO7kspbEe+B+dGy89vfJ3QFACJCBbBroeznH1gUtqPC6+
 CIqg==
X-Gm-Message-State: AOJu0YzXx7icN0K0hPQe5g9uubg/AJzITnjggGzaCZQiYUxSRI2ucVSz
 IQkTVfDO3QoSJP79nLNCLmTk2A==
X-Google-Smtp-Source: AGHT+IGRI9P3QhkomJUtZP6Zv6V33VSf7NlhNG3YVC9tEui0ghYPZ5MVWqeOehJogpDQo06W34k8/A==
X-Received: by 2002:a9d:748d:0:b0:6c4:c151:8ebe with SMTP id
 t13-20020a9d748d000000b006c4c1518ebemr23414186otk.22.1699038222637; 
 Fri, 03 Nov 2023 12:03:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 g4-20020ac81244000000b004197d6d97c4sm941912qtj.24.2023.11.03.12.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 12:03:42 -0700 (PDT)
Date: Fri, 3 Nov 2023 15:03:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/3] drivers: gpio-uclass: support PMIC GPIO children
Message-ID: <20231103190339.GA2621465@bill-the-cat>
References: <20231024083801.202365-1-clamor95@gmail.com>
 <20231024083801.202365-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ncC+qMQ/LQXeJfGC"
Content-Disposition: inline
In-Reply-To: <20231024083801.202365-2-clamor95@gmail.com>
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


--ncC+qMQ/LQXeJfGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 11:37:59AM +0300, Svyatoslav Ryhel wrote:

> UCLASS_PMIC may have GPIO children without exposed fdt node,
> in this case if requesting fails, check if uclass is PMIC.
> If so, iterate through its children to find correct device.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpio/gpio-uclass.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> index 7aece85a70..a3fc470a5d 100644
> --- a/drivers/gpio/gpio-uclass.c
> +++ b/drivers/gpio/gpio-uclass.c
> @@ -1143,9 +1143,22 @@ static int gpio_request_tail(int ret, const char *=
nodename,
>  		ret =3D uclass_get_device_by_ofnode(UCLASS_GPIO, args->node,
>  						  &desc->dev);
>  		if (ret) {
> -			debug("%s: uclass_get_device_by_ofnode failed\n",
> -			      __func__);
> -			goto err;
> +			struct udevice *pmic;
> +			ret =3D uclass_get_device_by_ofnode(UCLASS_PMIC, args->node,
> +							  &pmic);
> +			if (ret) {
> +				log_err("PMIC device get failed, err %d\n", ret);
> +				goto err;
> +			}
> +
> +			device_foreach_child(desc->dev, pmic) {
> +				if (device_get_uclass_id(desc->dev) =3D=3D UCLASS_GPIO)
> +					break;
> +			}
> +
> +			/* if loop exits without GPIO device return error */
> +			if (device_get_uclass_id(desc->dev) !=3D UCLASS_GPIO)
> +				goto err;
>  		}
>  	}
>  	ret =3D gpio_find_and_xlate(desc, args);

This needs to check for DM_PMIC or so as it leads to a lot of size
increase and one failure to link due to running out of space now.

--=20
Tom

--ncC+qMQ/LQXeJfGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVFRAUACgkQFHw5/5Y0
tyzTJwwAhdZo2lc9/oTKJTOR8BaNcTN+tg7W2ZKNjJGWlM5s1jua/gU0bWJubGVs
3iT9epuoSLxPSmw6daPvSSDk+LQ818Xai0qcbxkfKmVsPVwyZ3LQCAnmJhbJy8wQ
NCJWWwI7CvOuMq1Ysxpbbz3lk5nAgYUykfoyssSTbt1lELQWvMPilMwIm8Pcjtx3
8vVZuv/4tmspRLWmWsgSulqu8+Op/4zKuN8T0iWMiJdgYZH7f0P4dowBWoKrYAla
rAYq6BV20z4P5zTtvTeDXh3D06nFUy2ZCIS0ErQ1xzpYPNdMkzws2Tl6CR+QTuHx
ahm968oB5qhGVxN63Od1G53OC0IL/AUqQDvNTGVrHIfs2HpuMsSmIfAO7yiuclkM
GDywzynZfIt5uWnPKRHV+pLwty3rE2jHqkARMzo9h/c5zutklk+/Si5H4Gfd9brs
mn4ML8EBG+tV/XKCyRKV4JgNlqFm9UhPlV5s8wbSuS8SwI19jW3urB1h3zxbmPsF
B9VvZnAE
=OENg
-----END PGP SIGNATURE-----

--ncC+qMQ/LQXeJfGC--
