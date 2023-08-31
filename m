Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDE7C83F2F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7A586546;
	Thu, 31 Aug 2023 21:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mOF1Gb72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5058986546; Thu, 31 Aug 2023 21:03:01 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1438086523
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-bcb6dbc477eso904776276.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508577; x=1694113377; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DfcyhM/vja5jF3i+k2BWxgHepqq25C5y7q/blJecPXA=;
 b=mOF1Gb72CHKWJjaNBDGfXdkxLQIFlbQdF9RfMdGNyFyhRfieu/R3vVZPx898E7L3Hh
 ypMFC8xv8aNKkouCHiU/uwrYH5GjGCgjD2ltCN3oSVBVv0qBCynBAxHJc+dRa6jKMYE2
 MslyB5dbVd4gOze8IhC7UkikhqQ1umnoD1aOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508577; x=1694113377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DfcyhM/vja5jF3i+k2BWxgHepqq25C5y7q/blJecPXA=;
 b=cTUelF2a4SfKwEW7YoZtinfylyIqi7xKreEbdyxVRCaFbi2k7WnTE46VIIugjZjLGW
 eSILIcC8qS41NfidiZ0ZKR5TBg3MogjZT6oAjiDaRqhsZi/z9CUsRgPw5gRJwb5bW9lG
 9i6gvVof4U9qmI5foflgDN1w4g8wtYnORXtEmmcktwvBwTtd22R2XuBBcpjlPQcDe7yi
 VEgbcOAg8lpyAgfjUkZnuQ0cvHDc9E0y8OJxMop23hFCOF8Af9W7Jzrc6Xfkwa+Qzqrt
 sCBmuF75yUNq+55VcFIuYHODylewiEQIwhVRxAdr/QqtTmAagNzWvTi+noF9XFeDJhaG
 jY7Q==
X-Gm-Message-State: AOJu0YxN/+RGOXS7OkbnSKTVh+Y1oG+yT3x+gklen9+kQIrXKrcBSyUn
 eK1y6Pj3hzUZApixbCwgfkBb3hXJhsJ81Yl3gZNPHKN8dM7/a7KqWxU=
X-Google-Smtp-Source: AGHT+IEI7P57zk5xOOi+6qH/qY2R3yDsfyVuF4S8Mbo4dVPjDm/7o2rvC9GQcuwSuqCvv3vt3XcL+/XtmU7dq/NQqVY=
X-Received: by 2002:a5b:c8:0:b0:d7e:6c65:1c1 with SMTP id
 d8-20020a5b00c8000000b00d7e6c6501c1mr439921ybp.42.1693508576630; 
 Thu, 31 Aug 2023 12:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230825192842.1957055-1-sjg@chromium.org>
 <8e64d594-8f05-4b0f-b83f-c7a99c6e781f@gmx.de>
In-Reply-To: <8e64d594-8f05-4b0f-b83f-c7a99c6e781f@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:02:10 -0600
Message-ID: <CAPnjgZ3zrDBxVq+bT3-O5QUdeWunjnChozfrE_z4NfVmxTQVdQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Correct handling of frame buffer
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Fri, 25 Aug 2023 at 16:06, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/25/23 21:28, Simon Glass wrote:
> > The efi_gop driver uses private fields from the video uclass to obtain a
> > pointer to the frame buffer. Use the platform data instead.
> >
> > Check the VIDEO_COPY setting to determine which frame buffer to use. Once
> > the next stage is running (and making use of U-Boot's EFI boot services)
> > U-Boot does not handle copying from priv->fb to the hardware framebuffer,
> > so we must allow EFI to write directly to the hardware framebuffer.
>
> Let's think of a EFI application running:
>
> With your patch GOP API calls will use the hardware buffer. But text
> output by calling OutputString() and messages generated in the U-Boot
> code would write to the copy buffer. This will lead to unexpected output.

I haven't seen an EFI app writing text output and graphics output at
the same time. Probably with good reason!

>
> What triggers copying from the copy buffer to the hardware buffer?
>
> Where is the copy function implemented?

It is in vidconsole_sync_copy() at present, but Alper's series is
going to expand things a bit.

Regards,
Simon


>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   lib/efi_loader/efi_gop.c | 12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> > index 778b693f983..a09db31eb46 100644
> > --- a/lib/efi_loader/efi_gop.c
> > +++ b/lib/efi_loader/efi_gop.c
> > @@ -10,6 +10,7 @@
> >   #include <efi_loader.h>
> >   #include <log.h>
> >   #include <malloc.h>
> > +#include <mapmem.h>
> >   #include <video.h>
> >   #include <asm/global_data.h>
> >
> > @@ -467,10 +468,10 @@ efi_status_t efi_gop_register(void)
> >       struct efi_gop_obj *gopobj;
> >       u32 bpix, format, col, row;
> >       u64 fb_base, fb_size;
> > -     void *fb;
> >       efi_status_t ret;
> >       struct udevice *vdev;
> >       struct video_priv *priv;
> > +     struct video_uc_plat *plat;
> >
> >       /* We only support a single video output device for now */
> >       if (uclass_first_device_err(UCLASS_VIDEO, &vdev)) {
> > @@ -483,9 +484,10 @@ efi_status_t efi_gop_register(void)
> >       format = priv->format;
> >       col = video_get_xsize(vdev);
> >       row = video_get_ysize(vdev);
> > -     fb_base = (uintptr_t)priv->fb;
> > -     fb_size = priv->fb_size;
> > -     fb = priv->fb;
> > +
> > +     plat = dev_get_uclass_plat(vdev);
> > +     fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
> > +     fb_size = plat->size;
>
> This logic and the map_sysmem() conversion would better be placed in
> video-uclass.c or video.h as a function video_get_hw_fb(void *fb_base,
> size_t *fb_size).
> >
> >       switch (bpix) {
> >       case VIDEO_BPP16:
> > @@ -547,7 +549,7 @@ efi_status_t efi_gop_register(void)
> >       }
> >       gopobj->info.pixels_per_scanline = col;
> >       gopobj->bpix = bpix;
> > -     gopobj->fb = fb;
> > +     gopobj->fb = map_sysmem(fb_base, fb_size);
>
> Could you, please, add a description of the side effects of the 'len'
> parameter of map_sysmem() in doc/arch/sandbox/sandbox.rst. It seems to
> be ignored, see
>
> include/mapmem.h:16
> arch/sandbox/include/asm/io.h:40
>
> So maybe just remove it?
>
> Best regards
>
> Heinrich
>
> >
> >       return EFI_SUCCESS;
> >   }
>
