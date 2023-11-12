Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA554C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D4B874F2;
	Sun, 12 Nov 2023 21:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M6zfPX9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9E42874E8; Sun, 12 Nov 2023 21:04:00 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9613E874FD
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5afabb23900so44377697b3.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819434; x=1700424234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=085YUPRziNjzKTxArkO0ZZRNadYyN8igHKmuecob67U=;
 b=M6zfPX9Eis9jEMDAryaka9xMsksVHBddUXSBKBVJkHQcSwsr9Hyt1LEbnqOmyTWq0i
 tAbnFBJb1OdsONq8RDslar/yMtGgE4FTtAuouJICjTIsBcT7IzLS6LoFEkYIpaUkq7qn
 /tnUviOCh6kboNk6BQQQ+2pX8w9QPvhf2cU3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819434; x=1700424234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=085YUPRziNjzKTxArkO0ZZRNadYyN8igHKmuecob67U=;
 b=aa6MSeTN4GSZ9aK9gETbO5nDa/L1TKpVLOsH0ozAoMTURxZeECEhokZ30uI8v7whGR
 SQ0ognWQjt+IePifRFWV7+xeUaXV3QyOLPHVi0yPotkPozZm9YmgLHFFI2xXcInBI0u1
 ttoM2mKPO+EH1P9MyEL2nfF/AiZvr+6XA6vNTxjyDg0Nl8zSrn1obR2cFqsqpGlca2W4
 FgXAWY+2p0608O1+5VqXJTPWUENqUgdriaA5GR4UoZpps7fkkeIEEcx+b+giHdKtYIK0
 4HDNWIGXNXbt0923vBy2pnvyYXxKkRPvuKi1hBw/Cj++zDUsQsJddwm1N359d4BkiKXP
 hyxA==
X-Gm-Message-State: AOJu0Yy+GzvLOW/Sv3EmfFqGXMGPVOKqAY9zqLq1tu39Y0R0+oplw5BG
 msMZ//eSa3tpQh5L9tAvNwZE0p0tuAUysvORZ4T/Pw==
X-Google-Smtp-Source: AGHT+IGdYRkPW3u0GAOeL9u/nTk929HyzBjVUHreu3bNnH/ArOVmuyDpOd3/qrbRZsmlyizHKMQIP/HjzwKxguwOpZw=
X-Received: by 2002:a81:6d16:0:b0:5a7:bff3:6fe4 with SMTP id
 i22-20020a816d16000000b005a7bff36fe4mr5162026ywc.9.1699819434105; Sun, 12 Nov
 2023 12:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20231110152944.647535-1-devarsht@ti.com>
 <20231110152944.647535-6-devarsht@ti.com>
In-Reply-To: <20231110152944.647535-6-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:22 -0700
Message-ID: <CAPnjgZ1TWnMrKDDbNDdg9TB8bhfW5ga2E7Lpy8HdyvsO46FDsw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] video: Fill video handoff in video post probe
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

On Fri, 10 Nov 2023 at 08:29, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Fill video handoff fields in video_post_probe
> as at this point we have full framebuffer-related
> information.
>
> Also fill all the fields available in video hand-off
> struct as those were missing earlier and U-boot

U-Boot

> framework expects them to be filled for some of the
> functionalities.

Can you wrap your commit messages to closer to 72 chars?

>
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2:
> - No change
>
> V3:
> - Fix commit message per review comment
> - Add a note explaining assumption of single framebuffer
> ---
>  drivers/video/video-uclass.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index f619b5ae56..edc3376b46 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -154,16 +154,6 @@ int video_reserve(ulong *addrp)
>         debug("Video frame buffers from %lx to %lx\n", gd->video_bottom,
>               gd->video_top);
>
> -       if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(VIDEO_HANDOFF)) {
> -               struct video_handoff *ho;
> -
> -               ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
> -               if (!ho)
> -                       return log_msg_ret("blf", -ENOENT);
> -               ho->fb = *addrp;
> -               ho->size = size;
> -       }
> -
>         return 0;
>  }
>
> @@ -559,6 +549,25 @@ static int video_post_probe(struct udevice *dev)
>
>         priv->fb_size = priv->line_length * priv->ysize;
>
> +       /*
> +        * Set up video handoff fields for passing video blob to next stage
> +        * NOTE:
> +        * This assumes that reserved video memory only uses a single framebuffer
> +        */
> +       if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST)) {
> +               struct video_handoff *ho;
> +
> +               ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
> +               if (!ho)
> +                       return log_msg_ret("blf", -ENOENT);
> +               ho->fb = gd->video_bottom;
> +               ho->size = gd->video_top - gd->video_bottom;

should be plat->base and plat->size

> +               ho->xsize = priv->xsize;
> +               ho->ysize = priv->ysize;
> +               ho->line_length = priv->line_length;
> +               ho->bpix = priv->bpix;
> +       }
> +
>         if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->copy_base)
>                 priv->copy_fb = map_sysmem(plat->copy_base, plat->size);
>
> --
> 2.34.1
>

Regards,
Simon
