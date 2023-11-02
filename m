Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DB6C0018A
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A4787656;
	Thu,  2 Nov 2023 23:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RUqb7Eb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3146687656; Thu,  2 Nov 2023 23:46:41 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82BE87718
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so1457006276.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965195; x=1699569995; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3mzbgpTE5g6ugqJMInnuc7Py74FdnObe59KxnblnK20=;
 b=RUqb7Eb+WJ444RNnniVnmi4Zx/4/wpgjh9000poGWoYv7s+l/wGzvT0RNiCsQowCPT
 qiv1FxAl0Sc8rb+vWCzoe5Qlc3Aogbl9kWZ4MgqC0YaBCVidt3acxRSZyog6ZBb/QuJs
 ZEFiGZn8hS4Wx9im5ZCG3BNe20aNUadwhXZ3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965195; x=1699569995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mzbgpTE5g6ugqJMInnuc7Py74FdnObe59KxnblnK20=;
 b=Ljjin07CO+Td9jz5uYOeXxweaQlDDirs4MRS1ondKTL19sF6ljQ/tm0q5cflw5xq0t
 jfEHRBPXBnbOe/QoKhU/CFZI8fqY6fOBDqP6TMa4Oh2iDVvuzHSX4MJYJ8OQif2dMwhf
 J1VBYmvQpkMrzgluRQS6Va9KehoNkLqmFfBXbnw4fc9Jv5WisW+cFBsckmKBRDPh2DY2
 8lg+EehuT6emHtmSl62OUAPRUjE3wh2+Ms1auDk7D5Raef5I8LVL4keM9A0g0/8jYB1j
 oO1qiTEho03bLJWUIIvTLQDLp5+YWlN4SlvpEGr6IDN+Ilxq0NupCBqmJ62tobGfSoYc
 A4dQ==
X-Gm-Message-State: AOJu0Yy8LvSulaYUDDVSmIj0wdyXFqpvolgKACe7mTdDtZ/KJv/0vqxU
 4qMgPPA2ygolYgx1IMOlWsrjBzW0pc5uYuehTRQQdg==
X-Google-Smtp-Source: AGHT+IH08D780U6eoJT/hGqGfrQja+W+cx2bG5/ZVGLWxZl5v43bZFxoX9Z4IQvERzOQZaJmqEBIM+DeFypDvJCWfRg=
X-Received: by 2002:a25:aa42:0:b0:da0:c746:3861 with SMTP id
 s60-20020a25aa42000000b00da0c7463861mr18567133ybi.35.1698965195172; Thu, 02
 Nov 2023 15:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231031131208.435268-1-devarsht@ti.com>
 <20231031131208.435268-6-devarsht@ti.com>
In-Reply-To: <20231031131208.435268-6-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Nov 2023 22:46:10 +0000
Message-ID: <CAPnjgZ3MOddtx9=OvbXXVhbg8iHDt3kyp7Ju2JLs-UnPJNGHZQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] video: Fill video handoff in video post probe
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

On Tue, 31 Oct 2023 at 13:12, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Fill video handoff fields in video_post_probe
> as at this point we have full framebuffer related

framebuffer-related

> information.
>
> Also fill all the fields available in video hand-off
> struct as those were missing earlier and u-boot

U-Boot

> framework expects them to be filled for some of the
> functionalities.
>
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2: No change
> ---
>  drivers/video/video-uclass.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index 335a1a1828..635b70f668 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -153,16 +153,6 @@ int video_reserve(ulong *addrp)
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

You also need to fill out the other fields in there:

struct video_handoff {
   u64 fb;
   u32 size;
   u16 xsize;
   u16 ysize;
   u32 line_length;
   u8 bpix;
};


> -       }
> -
>         return 0;
>  }
>
> @@ -558,6 +548,21 @@ static int video_post_probe(struct udevice *dev)
>
>         priv->fb_size = priv->line_length * priv->ysize;
>
> +       /* Set up video handoff fields for passing video blob to next stage */
> +       if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST)) {
> +               struct video_handoff *ho;
> +
> +               ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
> +               if (!ho)
> +                       return log_msg_ret("blf", -ENOENT);
> +               ho->fb = gd->video_bottom;

This is a bit odd, since it assumes there is a single video
framebuffer. I suppose that is normally the case, but please add a
comment saying that only one is supported.

> +               ho->size = gd->video_top - gd->video_bottom;
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

Please can you add some documentation to doc/develop/spl.rst or similar?

Regards,
Simon
