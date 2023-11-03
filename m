Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A8CC4167D
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B409086B18;
	Fri,  3 Nov 2023 20:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BohR9cTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4C186B18; Fri,  3 Nov 2023 20:47:06 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4F786E54
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-66d0169cf43so14335226d6.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699040821; x=1699645621; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iSLad2IN4xegI8UDhyRg83UG7n/go1b74x0lLZK3l74=;
 b=BohR9cTOc0UHM+X+mibJ0EsvItniAQX06NBWaLy+egEPt2Hh/L2K8BNpSFQ9VP2WUc
 fCV6TswF7QD7nI38W5dIiaYD0FP0kA6wklekGxaS3PMOSWrNCRGnPMbH7LCAvnWnnpUb
 CLpsEZcIp+VldEKBPqPnlkHHODN8R72QA2wXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699040821; x=1699645621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSLad2IN4xegI8UDhyRg83UG7n/go1b74x0lLZK3l74=;
 b=IgM90WmRWZKXc9qNkvnnvaipzMzNWGxss0LTP/6Vp07RaA1EuFupnQ8dkpcpapP3l7
 wlSS6qMES3Nkd/jd+HxAvC+0xAGY1UOOaXLzUG63wxaftLMMO1DtBiyb4kWuXtNiroqT
 7aNuE3T4KsuL86iH67A6a2SPOTnGi2yQeDGiql9z2D1nqU96DwimULgbhG4q8WdDstCh
 ozPJ0/JB4Jv0531LSg5YoG7vHBseOX9pWLuc4V90pYzr6szRbSQoPSmDKNTtZtNnugx3
 vi+zbXCDNfmBfvSeHnMxcT+5fKaXWOCSaP+dE6dU9/7r56uZvPBQIWU38UMlVpYX+7cL
 Gwdg==
X-Gm-Message-State: AOJu0Yw8O2QUqqCIty0aKUrOCcKFLMA2XgKo4SIQ0TwerLX04mWr1bmI
 LcDl5baU18iIbv6QBzbPmAlK9A==
X-Google-Smtp-Source: AGHT+IE6oN0/kjO2YxNiFIl7nbB/rgRO1v2b7EdIPK44cICryYnuejJkW2FWBdSa4SdcOQBMus48BQ==
X-Received: by 2002:a05:6214:dc7:b0:66d:2ae0:44cc with SMTP id
 7-20020a0562140dc700b0066d2ae044ccmr32961835qvt.21.1699040820700; 
 Fri, 03 Nov 2023 12:47:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 f7-20020a0cc307000000b0064f4e0b2089sm1033464qvi.33.2023.11.03.12.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 12:47:00 -0700 (PDT)
Date: Fri, 3 Nov 2023 15:46:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/3] drivers: gpio-uclass: support PMIC GPIO children
Message-ID: <20231103194658.GS496310@bill-the-cat>
References: <20231024083801.202365-1-clamor95@gmail.com>
 <20231024083801.202365-2-clamor95@gmail.com>
 <20231103190339.GA2621465@bill-the-cat>
 <4FA8B3C5-B9FF-498D-A369-57AC099785AF@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yLhvnR/A1GkbJ17m"
Content-Disposition: inline
In-Reply-To: <4FA8B3C5-B9FF-498D-A369-57AC099785AF@gmail.com>
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


--yLhvnR/A1GkbJ17m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 09:39:51PM +0200, Svyatoslav Ryhel wrote:
>=20
>=20
> 3 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80. 21:=
03:39 GMT+02:00, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> >On Tue, Oct 24, 2023 at 11:37:59AM +0300, Svyatoslav Ryhel wrote:
> >
> >> UCLASS_PMIC may have GPIO children without exposed fdt node,
> >> in this case if requesting fails, check if uclass is PMIC.
> >> If so, iterate through its children to find correct device.
> >>=20
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> ---
> >>  drivers/gpio/gpio-uclass.c | 19 ++++++++++++++++---
> >>  1 file changed, 16 insertions(+), 3 deletions(-)
> >>=20
> >> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> >> index 7aece85a70..a3fc470a5d 100644
> >> --- a/drivers/gpio/gpio-uclass.c
> >> +++ b/drivers/gpio/gpio-uclass.c
> >> @@ -1143,9 +1143,22 @@ static int gpio_request_tail(int ret, const cha=
r *nodename,
> >>  		ret =3D uclass_get_device_by_ofnode(UCLASS_GPIO, args->node,
> >>  						  &desc->dev);
> >>  		if (ret) {
> >> -			debug("%s: uclass_get_device_by_ofnode failed\n",
> >> -			      __func__);
> >> -			goto err;
> >> +			struct udevice *pmic;
> >> +			ret =3D uclass_get_device_by_ofnode(UCLASS_PMIC, args->node,
> >> +							  &pmic);
> >> +			if (ret) {
> >> +				log_err("PMIC device get failed, err %d\n", ret);
> >> +				goto err;
> >> +			}
> >> +
> >> +			device_foreach_child(desc->dev, pmic) {
> >> +				if (device_get_uclass_id(desc->dev) =3D=3D UCLASS_GPIO)
> >> +					break;
> >> +			}
> >> +
> >> +			/* if loop exits without GPIO device return error */
> >> +			if (device_get_uclass_id(desc->dev) !=3D UCLASS_GPIO)
> >> +				goto err;
> >>  		}
> >>  	}
> >>  	ret =3D gpio_find_and_xlate(desc, args);
> >
> >This needs to check for DM_PMIC or so as it leads to a lot of size
> >increase and one failure to link due to running out of space now.
>=20
> Thanks for checking! I will look into it deeper to reduce the size inflat=
ion, not sure though why it occurs at all.

Note that it's not a huge inflation (it's 128 bytes), but for every
board that includes this file, in SPL, it grows that much, and then
sometimes might also be "and now we pull in funcX" as well.

--=20
Tom

--yLhvnR/A1GkbJ17m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVFTisACgkQFHw5/5Y0
tyzFhwv+NxLCm8V0ZZjlgOObABk7BzeBOdC5P8LFcbP6VXZWwpt3ZH9taavBVOms
pDh8jJuanN3LiFrpz8p4slaFJSDpuHlOYthvOdZvCcUsl2+8isXdfqHo0GRLLbO2
UWMroZI9J1aytv8EGJkMXNyOnjsaHQ39L/KEWQ1NLH4ROhKLjrCcfN0c8UlxkRw7
IxatnjKbguSaVhcSbmyRKN1i9qmjhNzWPWmLf+PdHTyImyojIWy83179W98xWVU1
jMrjXwXrQKBsApL3zh/4j+ZWvWWsyJKu6g3SVxWpHeAGLAPvPwa3i9Ts1X4Sj4CL
eDZCYrC6BuEve74v33ZC5PkBAyzWp9RkgZb04RMGvSECuzpsrDk6Res3FmCVJ2AE
Dp0Th2BDAroAXHb6nT4hlPTalRrYiQ6p4ciT3LTbATmEC8yr2ccX84qslg+S8KrJ
FxZ/cu3/hgMU5E1E6ngxf7YlfkYB73Z1qqsocWHHDg80y7a3zVEIE3+4wEmPmVbo
xb0IY5Xx
=zfof
-----END PGP SIGNATURE-----

--yLhvnR/A1GkbJ17m--
