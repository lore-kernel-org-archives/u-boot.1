Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CBBC624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBBEE80F58;
	Wed,  2 Sep 2026 14:26:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-4NGb9xneuG; Wed,  2 Sep 2026 14:26:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788359177;
	bh=j1/PDguSX/l8NauF6176GSBZSE+tpPAmKP0+vBY0t5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y8QmHcm2t7lBCZ3ayXpjJUIZ+Q61poSVzt9lJ/PR0LJBb8D69lVVZPulTztPyySOh
	 QH7dUll5P9kOJ++rrE1V5D4HpXCY+kILAuHAlMq8tNlA7UfS6XyYR+KDx2gBAdBTLE
	 XSQNlXSPSsOv2aCZx6uUtaKxmAzOcB/wq3H6fhNufajm65X2aPQJqYaoNEpfjEBW/q
	 sq7Xc29Osq4rf8XWqTN7WW72RDHBy1C/5fXA3pV+VY5lo2QKp/qVxr48Sq0bTZYhAU
	 XS0F2qkFSmQ6ITyfzcJl6TuZ2XuHq+K7vU0RpNcu7v95LpOwNZ0XlBn8j4hShfXriH
	 C1JyYaLttVvlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F88680F1C;
	Wed,  2 Sep 2026 14:26:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00C3E230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D500A606C4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q6PmM2Qg2BcG for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:26:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SFmxZU/W
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E0D2606B4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:26:14 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7f48c750afcso707311a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788359173; x=1788963973;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j1/PDguSX/l8NauF6176GSBZSE+tpPAmKP0+vBY0t5Y=;
 b=SFmxZU/WKlajTJoVHrNobtW3q0BFXJ0rTdWfyt7GKybyp3o4p+t/PuKO8xUEk72NPI
 yOM2VW2Pd3k/+jwBY0U9nW7iL7cydVAQqJuFyUp+lR4Yywg4f1QyoCqCQTUTDsayZEX5
 sZ8NmXBqrcwmx0o1tNLie+OgK6Ak8xRKX/zUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788359173; x=1788963973;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j1/PDguSX/l8NauF6176GSBZSE+tpPAmKP0+vBY0t5Y=;
 b=oA2eyJBeAllqJmFjZFOYT7LZ9HiU/oab5r+xRznU7JR7CzTdkemgo0CUclN6sROIHf
 l5VCz/C+Auad6UENhTl5TBCa+es7lbx1eGcvgVIShnJ2IYrIirdJXZ3bzxBDojGWyD+O
 4syIg9utLMbbQvaXJEzJivZ6mLk3bLl5J72F9eedWQY/jCBk1G/CrVQgmKdiXvVvJl+s
 7R7OQzCBEZn/o74sErcCInWIU8xiQXTYKP0n9taD5gg4cNXmPbacAo2lvV9WLMadZrRf
 HvCKbrXEVsWOrgn9U1c1mbkQntbkTy5rDCABppmT3TqkzQGxXrQ9GZf4Gs8RD90rK2Ad
 /6jQ==
X-Gm-Message-State: AFuF++kBoZT96+zwoaw5Gi1CmSmpuEtOp08sUCDhgDXcHnIpF9DrSAhO
 ORTVWg/Xyda12jbf2lhSItniidr89yVGd8mvPVWuLVouV7PRkG/53wmH79Y0urN/0G8=
X-Gm-Gg: AR+sD11CpcbcAR6Fw9RWMs2OrIo4Ie1682N9ZNUEydBiWjDjEQyfOs1dF0kRvW92X5e
 b3CTfnrfqq4IRr4XNaLqZZwvl/kclWpfqpBGwDMlBYAMZBD4px5HXHsrluyTLmj15w8uGUWyluj
 POj2Q9mYF9EoTFbtY4ZoVjbwclKjSzABKVKgrrIHRww2DSxiHOzVEBmvroeA3o579Zf3gWodU4u
 +TWEb15gHIg/ihhpa/o9jw7ZLkkmJkGBk0RzNEWQGP1ODTF5pzkoNdp1op5RT5m+SLEdXFXC4sf
 lDYzSfm+MW9EcjSTdglK5fHZHZTcVYP+MqArti6bUBzM/CMBCCZmmUN1eNvV39AIUOOPnugszUg
 0SW2ENp3rVuknYOM1E2+/+1khx7wvYgw4hSXKpKfNhw4IaXmXDsjwCKzu2G4hrucmuK8+R2n1Mk
 K0QDEtodqX0UylSdwhYoZ0avPGveZiFgdZxgbNgyOZZN/V2Gn4tI5qkr7Dbtbamq22alV96VOYu
 /R5FjzmXDtYxDmOhG0pvGA1usdcIV2KOAnsPn1axDL35nPWHyPKnluup3GF9Bq/YN9NK+Ost+jr
 1ZSNheNGDA==
X-Received: by 2002:a05:6820:2d0b:b0:6b1:4e36:fb80 with SMTP id
 006d021491bc7-6b47fd3531bmr4195954eaf.15.1788359173480; 
 Wed, 02 Sep 2026 07:26:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b40c833ad9sm2472138eaf.7.2026.09.02.07.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:26:12 -0700 (PDT)
Date: Wed, 2 Sep 2026 08:26:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, dlechner@baylibre.com
Subject: Re: [PATCH 2/2] video: fix build with CONFIG_VIDEO &&
 !CONFIG_VIDEO_LOGO
Message-ID: <20260902142610.GG1145425@bill-the-cat>
References: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
 <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
 <20260901164245.GE1145425@bill-the-cat>
 <CAEHHSvbPWGishhJ13jDUBWC8TBH0wMqyVS7qBMEZu90ug-ntrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6EgLPVWYFwvhNDKL"
Content-Disposition: inline
In-Reply-To: <CAEHHSvbPWGishhJ13jDUBWC8TBH0wMqyVS7qBMEZu90ug-ntrw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--6EgLPVWYFwvhNDKL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 10:48:38AM +0200, Julien Stephan wrote:
> Le mar. 1 sept. 2026 =E0 18:42, Tom Rini <trini@konsulko.com> a =E9crit :
> >
> > On Tue, Sep 01, 2026 at 10:52:43AM +0200, Julien Stephan wrote:
> > > Building with CONFIG_VIDEO enabled but CONFIG_VIDEO_LOGO disabled fai=
ls
> > > at link time:
> > >
> > >   video-uclass.o: in function `video_get_u_boot_logo':
> > >   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_be=
gin'
> > >
> > > The __splash_u_boot_logo_begin/_end symbols are provided by
> > > u_boot_logo.bmp.o, which is only built when CONFIG_VIDEO_LOGO is set:
> > >
> > >   obj-$(CONFIG_VIDEO_LOGO) +=3D u_boot_logo.bmp.o
> > >
> > > video_get_u_boot_logo() and show_splash() reference those symbols
> > > unconditionally, so with the logo disabled the reference is left
> > > dangling. show_splash() alone would be dead-code eliminated (it is
> > > static and only reached under a CONFIG_IS_ENABLED(VIDEO_LOGO) guard),
> > > but video_get_u_boot_logo() is an exported function and is always
> > > emitted.
> > >
> > > Guard the splash helpers and their symbol references with
> > > CONFIG_IS_ENABLED(VIDEO_LOGO), and provide a static inline
> > > video_get_u_boot_logo() stub returning NULL for the disabled case in
> > > video.h. Callers already handle a NULL logo pointer (e.g.
> > > bootflow_menu.c), so no caller changes are needed.
> > >
> > > Reproduce with any board that enables VIDEO without VIDEO_LOGO or
> > > enabling SPLASH_SCREEN (it disables automatically VIDEO_LOGO).
> > >
> > > Fixes: 0d3890188d6b ("video: Add function to obtain the U-Boot logo")
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > >  drivers/video/video-uclass.c | 7 +++++--
> > >  include/video.h              | 9 ++++++++-
> > >  2 files changed, 13 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclas=
s.c
> > > index de161054d52..4c959a57619 100644
> > > --- a/drivers/video/video-uclass.c
> > > +++ b/drivers/video/video-uclass.c
> > > @@ -579,6 +579,7 @@ int video_get_ysize(struct udevice *dev)
> > >       return priv->ysize;
> > >  }
> > >
> > > +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
> > >  #define SPLASH_DECL(_name) \
> > >       extern u8 __splash_ ## _name ## _begin[]; \
> > >       extern u8 __splash_ ## _name ## _end[]
> > > @@ -598,6 +599,7 @@ static int show_splash(struct udevice *dev)
> > >
> > >       return video_bmp_display(dev, map_to_sysmem(data), -4, 4, true);
> > >  }
> > > +#endif
> > >
> > >  int video_default_font_height(struct udevice *dev)
> > >  {
> > > @@ -716,14 +718,15 @@ static int video_post_probe(struct udevice *dev)
> > >               return ret;
> > >       }
> > >
> > > -     if (CONFIG_IS_ENABLED(VIDEO_LOGO) &&
> > > -         !CONFIG_IS_ENABLED(SPLASH_SCREEN) && !plat->hide_logo) {
> > > +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
> > > +     if (!CONFIG_IS_ENABLED(SPLASH_SCREEN) && !plat->hide_logo) {
> > >               ret =3D show_splash(dev);
> > >               if (ret) {
> > >                       log_debug("Cannot show splash screen\n");
> > >                       return ret;
> > >               }
> > >       }
> > > +#endif
> >
> > Is this hunk really needed? I can see getting here as part of debugging
> > the problem, but before the change it should evaluate to 'if (0 && ...)'
> > and be link-time eliminated.
> >
>=20
> Hi Tom,
>=20
> Yes it is needed since I moved show_splash() inside the #if
> CONFIG_IS_ENABLED(VIDEO_LOGO) guard above.
> I can go back to the runtime check, and keep show_splash() outside of
> the guard, but I'll have to use video_get_u_boot_logo() instead of
> relying on SPLASH_START(u_boot_logo);
>=20
> What do you prefer?

Ah, I see now, that wasn't clear to me from the context. Looking at 1/2
and then 2/2 now, can we just remove show_splash() and call
video_bmp_display directly? That means not guarding SPLASH_START but
again it should optimize away. I do complain about how if
(CONFIG_IS_ENABLED(...)) isn't always great, but I think mixing that and
#if together just reads awkwardly too. So if we can't restructure the
code to keep if (CONFIG_IS_ENABLED(...)) then we should #if the whole
block there. Thanks.

--=20
Tom

--6EgLPVWYFwvhNDKL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapgx9wAKCRAr4qD1Cr/k
CotfAP0XE0rAG4K7jsNpGbQPuQJzDpdT4ws/bXdylZwTKCBxwQD9GdGqv/0vokYk
LAS3he5QQDfs+0axuSvHy7lE2ZBNGQM=
=CIft
-----END PGP SIGNATURE-----

--6EgLPVWYFwvhNDKL--
