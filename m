Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B061C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 16:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37EE380DEC;
	Tue,  1 Sep 2026 16:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7NeLb5WIQ2J; Tue,  1 Sep 2026 16:42:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788280973;
	bh=jsci2EbFkP8+ggnSDteD4AbeCOsaWIP9xKiQhzQNSNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P0QHM/4RBLdHR837Xx+ATso2QwhA8tbvWiVM/gPoykAEm3pMEsLTinLB2RVrimbgq
	 szDj2xtTlnnDwUb5BzLbdtVCj6t7OmtD6/bq8YoHWicZ8oyS6q41k7F0tawd/nQolv
	 WSjJxP430Lt9gu+SCbxIEaZmXprdjpFmNV0Fzq15z42ucfbMy19fXCvKBscwS+Ne1N
	 RLtPTxL2b0KPsitaDBhz9zThnUYJ8tNYAa9FmD4fxf+yTTfyf1b2uZQi5s/G1u6tD5
	 9leqmH/6uHsgv18b91bCgzXrMvERe5kDnQ5ioA7qj9wffh6oV9lYncpZ9xmVbehUn7
	 pUWl4GPj7mdAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3AFB80CC8;
	Tue,  1 Sep 2026 16:42:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C3A092FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2737606E5
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CassWhTcgUGh for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 16:42:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=A+97lWB6
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E866560633
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:42:49 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f3ece23165so885865a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788280968; x=1788885768;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jsci2EbFkP8+ggnSDteD4AbeCOsaWIP9xKiQhzQNSNg=;
 b=A+97lWB6dnJNeW4JxDhA9N4CPotxSZhu0BVAB1YkdCQInOZ0GPswEiqlOAZWc0oReG
 kQarYvXlmRRDHqUJHWMEqZakunJxcF+eVBQbp3tqO4kOCqrx+g4Yhy4KI19Gc5CYrKPZ
 8iDSUYls/dU24c+mMZ6oYWjTbRNiA08rPG+o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280968; x=1788885768;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jsci2EbFkP8+ggnSDteD4AbeCOsaWIP9xKiQhzQNSNg=;
 b=XL6m/0veeNIP1vC1egebC/EDpJcjmAqVi8px9G2KQljfpDOg1ixpdsMmjzvWgrd2g2
 qkJY0zv0lL7GXSxxE5db2le3K1qpD1+jFezrglevfxD/I9Z6UpHBdEkpUxSH8R8W9cSZ
 1m5ozXcie2roIJvIBoHa2lXTIjYxarEnu85OoCs7RjK+Dw5R/7vZtxzcQrdChwnRZrFw
 WVS/iwPpzEm9DnsqwyPMha5S5GkzV6DR8SQ3Wbu5vrLyvE42FMJot8yrt5lzN+e5By01
 y/jNWniyMJ9iNBH5LdPu8iFW6hz8lvPyBqYiCyxiztBYieYwJhutZ+FV0iPwRdYkItWc
 4aFQ==
X-Gm-Message-State: AFuF++kQ240qQlrcsUN+q8w071WStnvjWMGwEB+DJrKPJdepwK5pRVsj
 S7cWjGnyDa4b52vhUqQVC6DgYhSQ5yagms/inyPhjuoeLXxJ63hOcjBl4PiZ6hER4LU=
X-Gm-Gg: AR+sD12Y8BNg2slfduxCd2JB8IN3XWX4fvzwISOuxjEwlql8FKX9qFwlKFg+lbTFwjv
 uA7Jrm4xPhONRD6Cx0/UjPGX16zFdkvAHyuFNAUb3vV/np0Hjikktnm8eB5yA4XkxYqAeaxGp70
 DbCYxXeSLfr0iCx9j6HxfsXt5S7e6o9ldmBGmeLJIiUu8UtpYNkBmhnWLB3f9xgBJus9UhcAKvB
 7mOd/RwCWTQ00Igz9h3pQ0xXCpP5LRx75mFpUk8lFTyZyaLCqbK2L5yHjtmmAU8i6rmMsf31Puz
 8uRWd4OLtV2QaMuDvKUHbVTYwwxEzcTTYYjraxbuHKpeFDKe9Sn62NQHHK4rfGOq/vXbgJbYxyF
 ItfLDD3bxgCHkc1udAu6L7XfaIxO00A+ZOeakLdUUZsDcVog2cJmqlxd/Bv832z4dvF0PpDFirg
 PZ5GvMMXshB3nWKLvzJcWWacYoLy4uvC6RAcMZLnUBuTuvdv5lF/NXrzjy78L8xlJD76CreEEaQ
 LrfOpociEzNoE77pD8LGC4L89WS5cnc+oGtL5AFH1m4fimBB5AacLDDEsqWJj2n7GKqVWHUc3ur
 En+oWwP30g==
X-Received: by 2002:a05:6808:1b14:b0:4a0:cf55:3cf0 with SMTP id
 5614622812f47-4b398194062mr32106383b6e.9.1788280968465; 
 Tue, 01 Sep 2026 09:42:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a19edce7sm10900825b6e.16.2026.09.01.09.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:42:47 -0700 (PDT)
Date: Tue, 1 Sep 2026 10:42:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, dlechner@baylibre.com
Subject: Re: [PATCH 2/2] video: fix build with CONFIG_VIDEO &&
 !CONFIG_VIDEO_LOGO
Message-ID: <20260901164245.GE1145425@bill-the-cat>
References: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
 <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/wNlAxwGMVcJgyke"
Content-Disposition: inline
In-Reply-To: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
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


--/wNlAxwGMVcJgyke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 10:52:43AM +0200, Julien Stephan wrote:
> Building with CONFIG_VIDEO enabled but CONFIG_VIDEO_LOGO disabled fails
> at link time:
>=20
>   video-uclass.o: in function `video_get_u_boot_logo':
>   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begin'
>=20
> The __splash_u_boot_logo_begin/_end symbols are provided by
> u_boot_logo.bmp.o, which is only built when CONFIG_VIDEO_LOGO is set:
>=20
>   obj-$(CONFIG_VIDEO_LOGO) +=3D u_boot_logo.bmp.o
>=20
> video_get_u_boot_logo() and show_splash() reference those symbols
> unconditionally, so with the logo disabled the reference is left
> dangling. show_splash() alone would be dead-code eliminated (it is
> static and only reached under a CONFIG_IS_ENABLED(VIDEO_LOGO) guard),
> but video_get_u_boot_logo() is an exported function and is always
> emitted.
>=20
> Guard the splash helpers and their symbol references with
> CONFIG_IS_ENABLED(VIDEO_LOGO), and provide a static inline
> video_get_u_boot_logo() stub returning NULL for the disabled case in
> video.h. Callers already handle a NULL logo pointer (e.g.
> bootflow_menu.c), so no caller changes are needed.
>=20
> Reproduce with any board that enables VIDEO without VIDEO_LOGO or
> enabling SPLASH_SCREEN (it disables automatically VIDEO_LOGO).
>=20
> Fixes: 0d3890188d6b ("video: Add function to obtain the U-Boot logo")
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/video-uclass.c | 7 +++++--
>  include/video.h              | 9 ++++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index de161054d52..4c959a57619 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -579,6 +579,7 @@ int video_get_ysize(struct udevice *dev)
>  	return priv->ysize;
>  }
> =20
> +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
>  #define SPLASH_DECL(_name) \
>  	extern u8 __splash_ ## _name ## _begin[]; \
>  	extern u8 __splash_ ## _name ## _end[]
> @@ -598,6 +599,7 @@ static int show_splash(struct udevice *dev)
> =20
>  	return video_bmp_display(dev, map_to_sysmem(data), -4, 4, true);
>  }
> +#endif
> =20
>  int video_default_font_height(struct udevice *dev)
>  {
> @@ -716,14 +718,15 @@ static int video_post_probe(struct udevice *dev)
>  		return ret;
>  	}
> =20
> -	if (CONFIG_IS_ENABLED(VIDEO_LOGO) &&
> -	    !CONFIG_IS_ENABLED(SPLASH_SCREEN) && !plat->hide_logo) {
> +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
> +	if (!CONFIG_IS_ENABLED(SPLASH_SCREEN) && !plat->hide_logo) {
>  		ret =3D show_splash(dev);
>  		if (ret) {
>  			log_debug("Cannot show splash screen\n");
>  			return ret;
>  		}
>  	}
> +#endif

Is this hunk really needed? I can see getting here as part of debugging
the problem, but before the change it should evaluate to 'if (0 && ...)'
and be link-time eliminated.

> =20
>  	/* register cyclic as soon as the first video device is probed */
>  	if (CONFIG_IS_ENABLED(CYCLIC) && (gd->flags && GD_FLG_RELOC) &&
> diff --git a/include/video.h b/include/video.h
> index 9ea6b676463..8e4c1544e56 100644
> --- a/include/video.h
> +++ b/include/video.h
> @@ -418,9 +418,16 @@ bool video_is_active(void);
>  /**
>   * video_get_u_boot_logo() - Get a pointer to the U-Boot logo
>   *
> - * Returns: Pointer to logo
> + * Returns: Pointer to logo, or NULL if CONFIG_VIDEO_LOGO is disabled
>   */
> +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
>  void *video_get_u_boot_logo(void);
> +#else
> +static inline void *video_get_u_boot_logo(void)
> +{
> +	return NULL;
> +}
> +#endif

This part does make sense.

--=20
Tom

--/wNlAxwGMVcJgyke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapcAgQAKCRAr4qD1Cr/k
Ct7JAQD46Zch0kjGq1NYBoj61urZ/b/XERofkS2NARkJWOhjrgD+Na/tBDtlqWF0
mGCS+OE2BzAKvPWLeghzs9Bhb8/8egI=
=TGAO
-----END PGP SIGNATURE-----

--/wNlAxwGMVcJgyke--
