Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB579CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834D0871D3;
	Thu, 19 Oct 2023 15:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rg6zvkrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F650871AC; Thu, 19 Oct 2023 15:56:23 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A1C87184
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507975d34e8so9171930e87.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697723780; x=1698328580; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XpBnz0GguiHWsjztlCURpO2bTY516UyOrVvfk9MkvUk=;
 b=Rg6zvkrw45TAB5gWE9rde0Rv4jkq+0LNtiSLJiAAxmpaA/1FGG7IWOO4u1CEJ6V/sl
 7MtIbKW44BOEq07YLbpmwJwneo+s7tPHJHU0YpU4bDaNXBzsZNNdw9IePIHm5VrCHiKN
 Ms4eS9QHOM1ITp6iu50YPLwWNdsnDCPSbW7Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697723780; x=1698328580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XpBnz0GguiHWsjztlCURpO2bTY516UyOrVvfk9MkvUk=;
 b=PqbuN+WOZrkyn11cyrXGWK0+hqoHOgbnMUVnPujvzFnmqN7csoYDcABrpyzY2XuHG1
 ZPjR2141YNj0mPbqml60SlGBJ0vEjeu5C+79RchVyuOPXF070Yk8nyPLWUtFuOX2N85G
 r0ZelG3E4I2BC9QJQB/WPL4jMr9202/9hLuZneROw8UlU2N7Fp3krQQLfG9yjA4Es2Zi
 bj0/xxJxTX+mPEFY5Sd/VZiMNkGxC36PFjPv+RNV8Bw4yvULLbnMABo1Qe46GhMAqNgN
 XpRfRGEL3zXxTUCZdAcaghL2N8eCE3qyPlRqMfZYCMK+WixkGDXwmnQCwLCka8WK7VRm
 jorw==
X-Gm-Message-State: AOJu0YzQQbAF9ljqPPBbzAQg0nFGFsxoD6SghmS2rmGo176fgVOh/v3i
 EVBLBbWu9OdblnfF1GenKifTZr6CDZjUrbaOfldEGQ==
X-Google-Smtp-Source: AGHT+IEidZ6XpCtk/XdE/keMxbko4ntbW2LHN/FWEV4TnyJaNldK8eGLDIHLO4cXfBeyL2vR0nRlFmZCRlC8aTSfTrE=
X-Received: by 2002:a05:6512:1092:b0:506:93a0:777a with SMTP id
 j18-20020a056512109200b0050693a0777amr2036718lfg.2.1697723779925; Thu, 19 Oct
 2023 06:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231016160611.1353458-1-devarsht@ti.com>
 <20231016160611.1353458-5-devarsht@ti.com>
In-Reply-To: <20231016160611.1353458-5-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Oct 2023 07:56:06 -0600
Message-ID: <CAPnjgZ38--tn3_CHg5KfdbuoYcv90s-9-kq7RtnxQoxRUfcphw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] video: Skip framebuffer reservation if already
 reserved
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Devarsh,

On Mon, 16 Oct 2023 at 10:06, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Skip framebufer reservation if it was already reserved
> from previous stage and whose information was passed
> using a bloblist.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  drivers/video/video-uclass.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index f743ed74c8..bac30187e7 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -123,6 +123,14 @@ int video_reserve(ulong *addrp)
>         struct udevice *dev;
>         ulong size;
>
> +
> +       if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
> +               /* Skip allocation if already received a bloblist which
> +                * filled below fields */

Comment style

/*
 * Skip allocation ...

 */

> +               if (gd->fb_base && gd->video_top && gd->video_bottom)
> +                       return 0;
> +       }
> +
>         gd->video_top = *addrp;
>         for (uclass_find_first_device(UCLASS_VIDEO, &dev);
>              dev;
> --
> 2.34.1
>
