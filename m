Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB77AC4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22806876ED;
	Thu,  2 Nov 2023 23:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TkiQrQrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4BC6876E3; Thu,  2 Nov 2023 23:46:33 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4ED987650
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so2469969a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965190; x=1699569990; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=77IDeVh6a4aYEFX/0A2ilMGL6a3UjHiYgtpll3Sz+Wo=;
 b=TkiQrQrEMRS02IXKEUJ5tkNJzZZ2qQ6sRpBi5KNLL/7js+4DW/6ZkUsuIFBmDVUm/7
 5oGItcf3uEvpkX7YsokHKtWIz7i5kSzg22LRz67XHYx0lpKua7qrF1OlToUtcqyZjC5c
 GfdSFs++6ou6T6J8aEUenu9rDIwBlDtlpuft4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965190; x=1699569990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77IDeVh6a4aYEFX/0A2ilMGL6a3UjHiYgtpll3Sz+Wo=;
 b=eb3LzELYTh/BuMNEn708Za+NWPI8kS2gX0INCz1JlwxrF04T7z64zZkTGq2hVHdF8c
 fJNBpy39cB3j8z5PpiTZlAcPwd6hGLqoV7eR0pXQxdwsFNGLku/UN6KXiOVoWQyIk/9h
 CQryNDyLwGgBTXFTJS7kDk5/SKdhLAq4sjDWYt66W08Cn/Eh89+BIe9z3+TfqXRou6f+
 LDdq+uDzGcPCIV5LeB5dXmCwK0hZOBmXIzqBUvAF2kZxTH4S7+gUC9WgRvFMUQ1/VBSo
 v4QO8dyPnYirtMfA91OGgdU/6guBwu7SarKEmxV3kfo8Rj3H99w9rlHgXglnHTCUoDpH
 tDew==
X-Gm-Message-State: AOJu0YyTWh282xsmTyyLwGm7j0o4PkEQIrwy7bMn+r32nqdKhxXPvsaC
 lrVMtq0+aglp+Bo8fHXoW7eEdWFd6BC0j0dzQ05+hw==
X-Google-Smtp-Source: AGHT+IH5Y1wk+OtB/xQa5OjdhpqITDJGKsETuF+bdmvJCwPYGfNI6qtVah16PwoxztKqDZqA8wGuAjAA/U/rZo78+Ek=
X-Received: by 2002:aa7:c1cb:0:b0:540:3a46:cdcd with SMTP id
 d11-20020aa7c1cb000000b005403a46cdcdmr15621328edp.29.1698965190240; Thu, 02
 Nov 2023 15:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231031131208.435268-1-devarsht@ti.com>
 <20231031131208.435268-5-devarsht@ti.com>
In-Reply-To: <20231031131208.435268-5-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Nov 2023 22:46:09 +0000
Message-ID: <CAPnjgZ0u9K5NR0apoTHFRKHxksT2O7_GDaOhdbm4sagvvgiBNQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] video: Skip framebuffer reservation if already
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

On Tue, 31 Oct 2023 at 13:12, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Skip framebufer reservation if it was already reserved
> from previous stage and whose information was passed
> using a bloblist.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> V2:
> - Add debug prints
> - Fix commenting style
> ---
>  drivers/video/video-uclass.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index f743ed74c8..335a1a1828 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -123,6 +123,18 @@ int video_reserve(ulong *addrp)
>         struct udevice *dev;
>         ulong size;
>
> +       if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
> +               /* Skip allocation if already received a bloblist which

comment style

/*
 * Skip ...

> +                * filled below fields
> +                */
> +               if (gd->fb_base && gd->video_top && gd->video_bottom) {
> +                       debug("Found pre-reserved video memory from %lx to %lx\n",
> +                             gd->video_bottom, gd->video_top);
> +                       debug("Skipping video frame buffer allocation\n");
> +                       return 0;
> +               }
> +       }
> +
>         gd->video_top = *addrp;
>         for (uclass_find_first_device(UCLASS_VIDEO, &dev);
>              dev;
> --
> 2.34.1
>

Regards,
Simon
