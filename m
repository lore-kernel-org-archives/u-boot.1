Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1EDC624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5088D80F16;
	Wed,  2 Sep 2026 08:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b0ovrEv8-3Q9; Wed,  2 Sep 2026 08:49:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788338984;
	bh=UQWfISKDqGZYkLWMGUWZcbigW0bWH3Vhuf2k4g3Vkis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TWGtDZuKEheZnvhU10bl51h9+er1bnjlUeFdjXjLJepfThPBX3G/p3AZbrJNPjtu2
	 o51d0jCM4NUjSYqRugEN9eoiW8lEL+Qe5Uulrpn9enhmpX/G2inaE0VtUdbvZO1pCO
	 2qdPy6c6zJkUHCOnuDS/AH/ICFqeofGyq++nAPQRzcet5MVHISGd8MIZGohMTgiyhJ
	 0re0jjQiy1dZdBjOQkTLEKg7aDAkt/9el/9hMBZf/NxEu47Vc4n4RFVG0O5UauFePy
	 8wzSeBzP+0grex3G+uVMS+KI9wa96FsV0qpj8GVvzt8CTIqfe1eNov1q4oFyKwnSFT
	 NcePthM4toxwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FE9480F04;
	Wed,  2 Sep 2026 08:49:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FF11363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B50D54031F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OTaTqKWIwt2J for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:48:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RJbNzk30
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4094740310
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:48:49 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso119446366b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 01:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788338927; cv=none;
 d=google.com; s=arc-20260327;
 b=Y7Is7X5HC4UNlhPc+8DMe5kk6Qq7Gf5wZMBJ6tX55zi1FDEfCDLwED2KCq+6sngLfz
 2sknXz6Zo4pKngMGa4kKzoHBjnl9I+v3wNZDQ7XcK/vHgRArw+7NhZUok0nXaZIXETwH
 XKCdZDILGNhh4pVjT5WOujvgb3TZvIUAcyO3NMrE0QpdyOXt3xB7T34ywgB1TJx2quIW
 v+h+3N8Zahkeqj04IX4L/Say8cTDa8TBMMp3oDjo0DShsxJ/yXPDsfmSOGNrlFW2eIRs
 x+xkeFN67vm4/wV9qzP62yFI6qMEi06uWuP1BA9OREUR9TkeK7kdeEI+DIVpLBpIxkq8
 QSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UQWfISKDqGZYkLWMGUWZcbigW0bWH3Vhuf2k4g3Vkis=;
 fh=nvz5BjPpejySTRFk3vtnaym1a4bpZ1Kpbr7VlbzlQ/I=;
 b=YHB4bZJwBpCXvG6W1leYa9FtMQ9tg+3XHEU/U3/xLfkLtUNEJxpow1R3zJFJsbiV/t
 swIvrp3txix6frwWHzR1gmOPg8H33/6PDSzLGsc7Tjh6YPTlY1pLBV0OPmd8pmtentlP
 TZT2bts+Gm3r11r9sjErCvOF1pOIfK3jVRRa+EEvW3P9iwyCvpNxPK0ea1kbJALEPEK2
 GrODze7toZ70morztZiyJ9Nx5mqgXU5swaUrPf38fOiSD6Y6Xu1RrJwsKD4m2YZEVWpf
 b6WSPpS1ITL6s086HFhyk/E/hppJxhIAHNI2pJrHYea2l0ZE0th6Gg5QH/2puVfbHqfY
 oldQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788338927; x=1788943727;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UQWfISKDqGZYkLWMGUWZcbigW0bWH3Vhuf2k4g3Vkis=;
 b=RJbNzk30nynifEtoqKgZuwN9oQ06neF35gcXQiFCQjI0L8MAIIovzpiCjJ+7kNc5OM
 QdReSUxtn/z1B8Wt4NEEVZTxVoOAkyxtOWMHWL58t9MRAdTgGTggbh403VQ7lUrpuoi6
 2ERxVSTsP/Kr0IvINyoD2EEqEQ8AJxRFJPRhkyK0WlPCjfcA/x90ohtqt4dFevkmoccp
 5Zba0gk/3X14kmbWEWxuXfSnFC3BaIkcGii4mOvGpSG5I3FFoX8y1itWZUgfoIFJvjRZ
 Tq+eKxRgFgp/5MUK7GHYXRalCSv5I71THXowWuyNjIhaFDUx0s3KYeLlzp22TsPc4tHO
 7Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788338927; x=1788943727;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UQWfISKDqGZYkLWMGUWZcbigW0bWH3Vhuf2k4g3Vkis=;
 b=Ov9zVOAIECU0u28yik5ocJrwYtZKSy1NH+C9O1rn4mWHPNxm8/0WQ+FXMsbRCHVsDD
 ml1Jq95UKI0+Lwys6JVyF1iURjrU7CsoS5O+I8y7WsLMpx5YFaDr27JiiFmjRGgKfri7
 jhisy3L5mxJYPEvCykGRQ9IZwGHgY+c7XVBfEcwD58qq1lf8NC2/ami/Dsq3tX9DoGAb
 a5sGu4l9/LnJg/Ol8p9Y8s1YLHSdpN1B9zhQ4Fh6Awj3bboGMKTh9XfksmlgNwNKxdP0
 B8btX6fnZGJCiGwVEZW35WIu/Z9hQk5DvR35TKezYprfVphGF/vx0g1XLcJN6trkhF8f
 dAdw==
X-Gm-Message-State: AFuF++laq4slnrYcamCFKKFLsY53ou7wmn/tWPHEq3ZDINsOZbNBt9kA
 8P1X+YQ0teHo0u65+CTPg4qAucn6YtNBDi4z29uMBM4HRHWU0dKAzUAGvjELLmVO0Jun90DqZfN
 5FZr8x8uVXOSF3dVHTaAMSYPkql3Wb6KCGYcVhRvUSw==
X-Gm-Gg: AYBFou0QmF/88RrivGbXkfXU7tbbYDyzHTsE86JqGAQp4AhfPxzNp6SQLET4DoA9q+X
 uKt4hv+TE38pdbfnEW8rAcqR5sYv3h3WFjDf/MwEwo2nq9/wBXG6ofJa4PIW+sT5EXZgJ4opp2c
 jCeCqvlWK0P1zlmYCltS1bv+g7AETB990hcmxz/bxe87ImAZmjBNgb9rWy+6qTpoMiBfDbPGr9J
 to5RVUPzxXJhS0Dd6hjxNCsMWIw/63k2VCkcHGTPfbroeyRQzpH062zgahsy4baYNNtDHiD0i3Q
 RGcdKG7A1vbCqIbHKNldCdpKcgba2gcVuHas2k3uzfSCx3p5BWTTgvIkHp62sZP3kxe6M36WJgM
 MP62m9F+A9CqHBGbAPT+ZPmB8C/HnZoxX4Ki1/zDTErmwxnL5gSYpNP+oWx4MYahA
X-Received: by 2002:a17:907:948e:b0:c25:c67a:3b68 with SMTP id
 a640c23a62f3a-c25d554a2aamr162692766b.20.1788338927287; Wed, 02 Sep 2026
 01:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
 <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
 <20260901164245.GE1145425@bill-the-cat>
In-Reply-To: <20260901164245.GE1145425@bill-the-cat>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 2 Sep 2026 10:48:38 +0200
X-Gm-Features: AcwNN1WOs0xdxWMvc6ywT_MMrISyJvv0I2C9dcnVwICZH8fJT1pnVKUUKrZ03ig
Message-ID: <CAEHHSvbPWGishhJ13jDUBWC8TBH0wMqyVS7qBMEZu90ug-ntrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] video: fix build with CONFIG_VIDEO &&
 !CONFIG_VIDEO_LOGO
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le mar. 1 sept. 2026 =C3=A0 18:42, Tom Rini <trini@konsulko.com> a =C3=A9cr=
it :
>
> On Tue, Sep 01, 2026 at 10:52:43AM +0200, Julien Stephan wrote:
> > Building with CONFIG_VIDEO enabled but CONFIG_VIDEO_LOGO disabled fails
> > at link time:
> >
> >   video-uclass.o: in function `video_get_u_boot_logo':
> >   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begi=
n'
> >
> > The __splash_u_boot_logo_begin/_end symbols are provided by
> > u_boot_logo.bmp.o, which is only built when CONFIG_VIDEO_LOGO is set:
> >
> >   obj-$(CONFIG_VIDEO_LOGO) +=3D u_boot_logo.bmp.o
> >
> > video_get_u_boot_logo() and show_splash() reference those symbols
> > unconditionally, so with the logo disabled the reference is left
> > dangling. show_splash() alone would be dead-code eliminated (it is
> > static and only reached under a CONFIG_IS_ENABLED(VIDEO_LOGO) guard),
> > but video_get_u_boot_logo() is an exported function and is always
> > emitted.
> >
> > Guard the splash helpers and their symbol references with
> > CONFIG_IS_ENABLED(VIDEO_LOGO), and provide a static inline
> > video_get_u_boot_logo() stub returning NULL for the disabled case in
> > video.h. Callers already handle a NULL logo pointer (e.g.
> > bootflow_menu.c), so no caller changes are needed.
> >
> > Reproduce with any board that enables VIDEO without VIDEO_LOGO or
> > enabling SPLASH_SCREEN (it disables automatically VIDEO_LOGO).
> >
> > Fixes: 0d3890188d6b ("video: Add function to obtain the U-Boot logo")
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  drivers/video/video-uclass.c | 7 +++++--
> >  include/video.h              | 9 ++++++++-
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.=
c
> > index de161054d52..4c959a57619 100644
> > --- a/drivers/video/video-uclass.c
> > +++ b/drivers/video/video-uclass.c
> > @@ -579,6 +579,7 @@ int video_get_ysize(struct udevice *dev)
> >       return priv->ysize;
> >  }
> >
> > +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
> >  #define SPLASH_DECL(_name) \
> >       extern u8 __splash_ ## _name ## _begin[]; \
> >       extern u8 __splash_ ## _name ## _end[]
> > @@ -598,6 +599,7 @@ static int show_splash(struct udevice *dev)
> >
> >       return video_bmp_display(dev, map_to_sysmem(data), -4, 4, true);
> >  }
> > +#endif
> >
> >  int video_default_font_height(struct udevice *dev)
> >  {
> > @@ -716,14 +718,15 @@ static int video_post_probe(struct udevice *dev)
> >               return ret;
> >       }
> >
> > -     if (CONFIG_IS_ENABLED(VIDEO_LOGO) &&
> > -         !CONFIG_IS_ENABLED(SPLASH_SCREEN) && !plat->hide_logo) {
> > +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
> > +     if (!CONFIG_IS_ENABLED(SPLASH_SCREEN) && !plat->hide_logo) {
> >               ret =3D show_splash(dev);
> >               if (ret) {
> >                       log_debug("Cannot show splash screen\n");
> >                       return ret;
> >               }
> >       }
> > +#endif
>
> Is this hunk really needed? I can see getting here as part of debugging
> the problem, but before the change it should evaluate to 'if (0 && ...)'
> and be link-time eliminated.
>

Hi Tom,

Yes it is needed since I moved show_splash() inside the #if
CONFIG_IS_ENABLED(VIDEO_LOGO) guard above.
I can go back to the runtime check, and keep show_splash() outside of
the guard, but I'll have to use video_get_u_boot_logo() instead of
relying on SPLASH_START(u_boot_logo);

What do you prefer?

Cheers
Julien
> >
> >       /* register cyclic as soon as the first video device is probed */
> >       if (CONFIG_IS_ENABLED(CYCLIC) && (gd->flags && GD_FLG_RELOC) &&
> > diff --git a/include/video.h b/include/video.h
> > index 9ea6b676463..8e4c1544e56 100644
> > --- a/include/video.h
> > +++ b/include/video.h
> > @@ -418,9 +418,16 @@ bool video_is_active(void);
> >  /**
> >   * video_get_u_boot_logo() - Get a pointer to the U-Boot logo
> >   *
> > - * Returns: Pointer to logo
> > + * Returns: Pointer to logo, or NULL if CONFIG_VIDEO_LOGO is disabled
> >   */
> > +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
> >  void *video_get_u_boot_logo(void);
> > +#else
> > +static inline void *video_get_u_boot_logo(void)
> > +{
> > +     return NULL;
> > +}
> > +#endif
>
> This part does make sense.
>
> --
> Tom
