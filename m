Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F0AC624CF
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E4BA6074A;
	Tue,  1 Sep 2026 09:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lpm2b9kRkQYD; Tue,  1 Sep 2026 09:17:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254229;
	bh=8tNuwZKnWWPqbNZTW8PkfD3g+VWGSK4omgXUoWY9Jac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IUQjxzzB0Jxg7qK1SpsxP6VQjypGPnzR8IwFyvL05aCqfObC++TmUHZ9+ZySNdhyD
	 EoK4D1z8GyWFuerXFXMpOnMckWhmaXFtyt2s233TOaNJ9Zi0QKl2dkMeHz6SeQWllA
	 kUy+IvIDBRqx6H4JBEbNMFGmFnhuecgW2xrJaiH+zqmRRczDpzdbjeeUy/2RBZq5v6
	 IrRtK+q/c0l6r4WQah4Sxg5lUx3ZawlR4cIsO+m/P5ZMdQGPeZOf9DPymA2gQrnowO
	 aiMrmD6y/FMaprL4w3Aj0zC4U2YCSOej2qHbp1gsq2/3xlhppCbHscpoh33iOBcKZU
	 t/kh67eJ8yGmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30129605CE;
	Tue,  1 Sep 2026 09:17:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E92911DE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E689B605CE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7KEOSeXXVZy for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:17:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OxZb0Ho1
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F74E605B5
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:17:04 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso163311666b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 02:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788254223; cv=none;
 d=google.com; s=arc-20260327;
 b=rHPimNDzqQ3x6+Ar+HcZ84fnm1IWImpVijtyrIzzNOgeK1pkGu7Ts8QuGlz97rcQZf
 Z229Qa2XLX2SaU/J+4/TjoHyeIui3gChMNb+a5efcbzXsKzq+0GXeqQ+MgBLlvE816gH
 m8CB75KKkseClMxN11SsVDEGSiZma60xWicaECXM3vSZiMSfbLWVqbAQylAHQ24Y7W+d
 m34oXURcGq0DPFQWWbMQw7BqYvzaISir1w8ywoZ1lHpUastvFGxKmyZMPphXmaI+zkci
 DFSGXAHJ8qbdZDrC0SZjZtcm0NpTYRi+JNNEd+0yz9psFZfC4t1jL8DffL+nIYOUEX1+
 dAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8tNuwZKnWWPqbNZTW8PkfD3g+VWGSK4omgXUoWY9Jac=;
 fh=Xh8XKhCRKnp7i+GpsJ0v7HW/flo5tOWnzMCufGFucIk=;
 b=lxWEAcIcy+twoDnLyWArQMsyqg64/F0GfKTlzwiLRta/e9ZiAiW49d0Iq1ZcNN72NG
 ggkE1TGHQQoDOob4leEDK9BGOzPUQ0Aucc/+Qe4zqnXGdlslNWflZsOAUGS8l87OqbzI
 po7cCl9P0Wf996h5GGQ4l4MoZb+p7PidtraXCs+MJWJNiKfgDTDS6VDtTpjbh20/bP30
 WthvB/Ck2gX9fyDl+HhEUJOJZiQTxlE4HczaUizfk9AmqqIzScMZE4x+X0JMS91jvFB9
 2ZJzWxrRjmFGfPBniRdJHQ4FYZgkyCpFsCCFs566144EJhNYFWUOUipPqCiXheAJU2rV
 yBlA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788254223; x=1788859023;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8tNuwZKnWWPqbNZTW8PkfD3g+VWGSK4omgXUoWY9Jac=;
 b=OxZb0Ho1o+xHiYAYnkyn45LPqIfoIzEBRMQGUwT+NjvUbZCWxdWfUoqGO7dnFyRbe0
 folm/Si4flnCMo6jAbbZ0pJ2rbtQu10gyOyknUVERJ9APYQBbvIGboAcEJcuUJR+OC9s
 80ETmkbURndVIBpJTS3KOOAi7Ur3UDW00Rpuelqg/g/fupKBg7iBGLrpSi/WVI69+zXX
 UI6nqekMWxp3odyNA87K5a9V+bM26t6ye2gJkI6MkrqQFq6FTSTvhEtBU/gxAhFqw2A/
 jDKRYHnw3/BVfK+UmQprvJcnTRpRMTonpyo8pAPH8Ct3URyNxHYJ9lz0MwFSQtUe71Y+
 Xe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788254223; x=1788859023;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8tNuwZKnWWPqbNZTW8PkfD3g+VWGSK4omgXUoWY9Jac=;
 b=RYtoR57pFsglTWLbC2AEOaaamPMUq3Wgjqb7QCG/LiUa2isNxqmi/B1Us39rxOPBPh
 zsx+e8VnZfVjH9q1x1kEmCyazZJtxL4QxOFqTcv7AzUdR8JzrGPKLZ+/nBhxMuDB8/yj
 VO3ab+0LCnvhSxymwVmihAX8jgDaraGbU8AkyXZc7f9Vn6fAOv4WDi88V4lGRdCvsunz
 TU+7taX+hS0B+G2+1RGr4EWF6bj4ake+AJ7pGxjmXSLW7YfbmuNgTad6glMFFAjtEMYA
 HDeDUAizAdjM/WynuTkVhyTa+nguSWhX9/2peUpNssOp8NrIyl5Miyxe/xr4H+oWkawC
 bm3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqJkRfQNjgpnlGCi4zdOC7/PvBh6B1dZOKmHACVlu91QJx8czozASDxg6/xtzypFmosJsW6cg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mrkis+id3zRGF+Ggi9U2WmpCyGXe9b6gqJCXXbLT29i2pIacBJ
 ZwN0RlBf1oKUNOw6yKrzf2kqDVasF0BzGmzzA36Ijin25MV++LUc18kZevzw5rHdnX7TJg0HgaP
 zXr3SbJp3LtDJ2Pku3hXvPsHaPAjqmttPZG/JcSF0PA==
X-Gm-Gg: AR+sD13H6gDYHb1j2HJK+fe2biHwJlRHpth4xxmPK1K2UTL4Hy5MDSNsh0iMrKq+IO2
 BCdzb458aDR8KKM7N3r5KYGWPE8sP3r82PcEF5hp6QwwR4xcr1joGZV3ihpk9QnHlzMWNYgAxZ7
 g8C0UcmVQA8obGl6jQURO8YQu+Bx/1LdmWIQYIqNEQNHOSqtFbMh4FaDQ+FwmSKrEBIDRgyYZ+C
 hENoeHJLqBqvefC/ZhBtqfhC52mbtZO69F/uwNNVgFSmu08aUrQPIGFUbSOBBa036e4kWSylLr9
 INs0HwyoSVHwVnXU5+iQSAi5Vf6YvEIXBLQMlS4JbExP9aLPSJWAgjRw3hCFKm+eUaE5iV8sNbC
 KuB968ZqTMoCr0Teb81erivIbQSVwXABIgRCLQ4lLNFPmN4p66L6/w08D9jtXcmUE
X-Received: by 2002:a17:907:3d4b:b0:c25:35cd:fdb2 with SMTP id
 a640c23a62f3a-c25b919fe1bmr314159266b.7.1788254223010; Tue, 01 Sep 2026
 02:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
 <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
In-Reply-To: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 1 Sep 2026 11:16:55 +0200
X-Gm-Features: AcwNN1WqRJFdK6SlcO7p0TFyul7U9GGJA6RN3Vy3I0PbbeFRXPyiLx43P9gZnKk
Message-ID: <CAEHHSvbS5exgrT3NdwCstRjqvEZiFHQwxHbxsDcd=P04oPhADg@mail.gmail.com>
Subject: Re: [PATCH 2/2] video: fix build with CONFIG_VIDEO &&
 !CONFIG_VIDEO_LOGO
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

I messed up the u-boot list, removing the old one, adding the new one.
Sorry for the noise

Le mar. 1 sept. 2026 =C3=A0 10:52, Julien Stephan <jstephan@baylibre.com> a=
 =C3=A9crit :
>
> Building with CONFIG_VIDEO enabled but CONFIG_VIDEO_LOGO disabled fails
> at link time:
>
>   video-uclass.o: in function `video_get_u_boot_logo':
>   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begin'
>
> The __splash_u_boot_logo_begin/_end symbols are provided by
> u_boot_logo.bmp.o, which is only built when CONFIG_VIDEO_LOGO is set:
>
>   obj-$(CONFIG_VIDEO_LOGO) +=3D u_boot_logo.bmp.o
>
> video_get_u_boot_logo() and show_splash() reference those symbols
> unconditionally, so with the logo disabled the reference is left
> dangling. show_splash() alone would be dead-code eliminated (it is
> static and only reached under a CONFIG_IS_ENABLED(VIDEO_LOGO) guard),
> but video_get_u_boot_logo() is an exported function and is always
> emitted.
>
> Guard the splash helpers and their symbol references with
> CONFIG_IS_ENABLED(VIDEO_LOGO), and provide a static inline
> video_get_u_boot_logo() stub returning NULL for the disabled case in
> video.h. Callers already handle a NULL logo pointer (e.g.
> bootflow_menu.c), so no caller changes are needed.
>
> Reproduce with any board that enables VIDEO without VIDEO_LOGO or
> enabling SPLASH_SCREEN (it disables automatically VIDEO_LOGO).
>
> Fixes: 0d3890188d6b ("video: Add function to obtain the U-Boot logo")
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/video-uclass.c | 7 +++++--
>  include/video.h              | 9 ++++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index de161054d52..4c959a57619 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -579,6 +579,7 @@ int video_get_ysize(struct udevice *dev)
>         return priv->ysize;
>  }
>
> +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
>  #define SPLASH_DECL(_name) \
>         extern u8 __splash_ ## _name ## _begin[]; \
>         extern u8 __splash_ ## _name ## _end[]
> @@ -598,6 +599,7 @@ static int show_splash(struct udevice *dev)
>
>         return video_bmp_display(dev, map_to_sysmem(data), -4, 4, true);
>  }
> +#endif
>
>  int video_default_font_height(struct udevice *dev)
>  {
> @@ -716,14 +718,15 @@ static int video_post_probe(struct udevice *dev)
>                 return ret;
>         }
>
> -       if (CONFIG_IS_ENABLED(VIDEO_LOGO) &&
> -           !CONFIG_IS_ENABLED(SPLASH_SCREEN) && !plat->hide_logo) {
> +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
> +       if (!CONFIG_IS_ENABLED(SPLASH_SCREEN) && !plat->hide_logo) {
>                 ret =3D show_splash(dev);
>                 if (ret) {
>                         log_debug("Cannot show splash screen\n");
>                         return ret;
>                 }
>         }
> +#endif
>
>         /* register cyclic as soon as the first video device is probed */
>         if (CONFIG_IS_ENABLED(CYCLIC) && (gd->flags && GD_FLG_RELOC) &&
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
> +       return NULL;
> +}
> +#endif
>
>  /*
>   * bmp_display() - Display BMP (bitmap) data located in memory
>
> --
> 2.55.0
>
