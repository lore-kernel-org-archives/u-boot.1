Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF623CD13DA
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 13:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 343CE83642;
	Sat,  2 May 2026 15:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F1zH5nMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE3583693; Sat,  2 May 2026 15:05:07 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 523B180F0E
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 15:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso6240051a12.0
 for <u-boot@lists.denx.de>; Sat, 02 May 2026 06:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777727102; cv=none;
 d=google.com; s=arc-20240605;
 b=KlcLYJ7HfASzkQ2u39gN8okonjNT7q/9d9RYWjXG17hX9PJ4TB0/W9jOSFLSYcp4hQ
 V7xyuLKt4N56ARxUciZY01Jj6CijPdFyKqDzSiqb5jlE/MT0CszDa4lNbCToeDWGyA1Q
 Uezjzn8DeEqiedIUDU8hYZKc3HcQsRmVLZ05TvtlcMZuz0XtnCxKZxHukvRumswlqeXT
 GCH13PYGeM4lNFKyKFWjcxGx9VJvUnFpUsqLYup4nTzsRbuwGbAEoXkV8u1ZpVRxgI0J
 01ANA+Ww09OkHJe4Qvy/50WXU7okaQd8IVr7fBX6f94EF28eYsxmFP6Lbj383xxgkdDJ
 uuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UujfmYHhSq/AW1OHfP3qdMxT54DKPfgzpCIeMFbH4m4=;
 fh=SoIXj8NfUeF9SIhV+2Z4Te8104jwDVuOxiCmqyA3l5Q=;
 b=cUu5I/coZCwdPCkatMspzoJXDikyw/m8crAfsrDYZ6up1nLWRD3unaO75OLvdv5+o9
 ejNoLfWMb7gvvDYYGjaTMyAP/ymCOgXI3AxjXmc2LtpywxtdEe6Mxbv7MFfe3MQr1k5M
 mYiOqC32CerWhyRhns+/lxUXah6Y4Tk1XFTWJ5SmenXa5CqLwcfPZ+GX6qlKQUXcooxj
 7b8Km9NEyFZLJP9qMZGxTJQvanDvrUPfrhNtLE0NQqxut0E5cj5lXZDgq3YfS3WDOtEk
 c2q28zWR0Af52fV4pDrxGfbiAk/6SBHCaQIV0hB8i6DbBEsxCsFB1NrZz7pmzkiVOXMx
 hhCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777727102; x=1778331902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UujfmYHhSq/AW1OHfP3qdMxT54DKPfgzpCIeMFbH4m4=;
 b=F1zH5nMiby/KBEQxZoRkmJBlovQeidgybpaL3ictDiUMykje72b4UNAwEwWSyh5sfP
 ZK30ZwQqL1tVqkYVTtv16CiqZmhgrDRmC8SAKik6GRwavuRukdaKdgbMbRL/t6Q0DJ9k
 hNa6iwOx+EhhQxVgVGSeOysHmt5HuEevt7pfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777727102; x=1778331902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UujfmYHhSq/AW1OHfP3qdMxT54DKPfgzpCIeMFbH4m4=;
 b=dQUITLNrbdtYHY9IvgoKTR1Onkyv4eJEVpwydrdK6NR41HuXyhdkVPLiUi4H4rAtZy
 9g5rkLGXKoB/2Xg0FiJD4SkEuqTUTxky0kqFhA3p9aGkLhvjQMePgyQtsbQCEU5QUqNl
 b0YpUpdLSnoTHXR3TfJK4tdeaBLlnbbIU7tn1UAZquClaDWR5VDsOuvtYNqZXblcbb/f
 Kk0n9qAZjqKyp5bGGLBKQIYr9GRsNiGQxyokTos4e76lcDpWhy6IhmO9BjoBnYLxqJXG
 ZooiyOWYD0Sa6oK9XzFWroQcDCLnqNKEV9i1TcGowXfLetzsuJ4qDkgJD4hiZeorIMPh
 kWcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/z2ZJryyWzkMLMd9eRb9dmbGavf1balMACtjLlDJHUbtmBrzxywBB0EgIFHTEu5Pj7n4dZJnY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy4fW2zJHiyyKu5W6dmNK+tOGKeyPqDrsbmXokeFdErhOv/SwR
 87b7WLoTyqeyn9tN7eDkdP3Xyp6nn+32uSr2xMy3zxEdr+wonquLf4Ky4Uy2H0iY/9935ddk6OU
 9ML764j2uCWjdt8yNIRRzLjejHyyINJeyDZlpMb10
X-Gm-Gg: AeBDieuwcvIZ3R6KK6pcq+CqPtn55zXc67907qG7VuH7Ci5qwcWMXJIBaQ0kMf3MHP1
 WPExzNiBdgtFzH9rZuqUfa+0xWEQrxr7365YSyc/8i6k66UiP748lPRWOGhs9Tg1zdWXUCPdQ/X
 SF/iJA8bG0HYLwrUAw/3Pa4CikqAVwfonBes1rI44+RpEY1Qh78pJFirfAS2ZH6Mvkyocck8UVL
 dilquznZ6tp6P3V1dxTpxl6rqaUJTgZE3WGefbDlb3vQGQ23Y6y8/jra275kgb1RGYidJB/2ax+
 qs8vRqfsha0Z8DYY
X-Received: by 2002:a17:907:3f1e:b0:ba6:79c0:c743 with SMTP id
 a640c23a62f3a-bbfe08823famr140023266b.11.1777727101730; Sat, 02 May 2026
 06:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260501150550.228937-1-heinrich.schuchardt@canonical.com>
 <ea87842c-75ce-4d39-9ae4-0f8b3b913ad0@canonical.com>
 <871pfudqns.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <871pfudqns.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 May 2026 07:04:49 -0600
X-Gm-Features: AVHnY4Lbe_XQ6QQr8jiJpX_T94cKcG3YBC6DFz7eoyUFxgJt-6xrWTpf3s7pru4
Message-ID: <CAFLszTiz7YtBtO3yMgVbRxfOSG3J9A+3oTCYuko9me5ona3ZGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: set correct frame buffer address
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 ilias.apalodimas@linaro.org, 
 trini@konsulko.com, peng.fan@nxp.com, patrice.chotard@foss.st.com, 
 me@ziyao.cc, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Heinrich, Mark,

On Sat, 2 May 2026 at 04:58, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > Date: Sat, 2 May 2026 09:28:56 +0200
> > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Hi Heinrich,
>
> > On 5/1/26 17:05, Heinrich Schuchardt wrote:
> > > If we use video copy, bit image transfers need to write to the in memory
> > > copy of the physical frame buffer. Damage control will sync the changes
> > > to the physical frame buffer.
> > >
> > > Cyclic video copy will catch all changes done by EFI applications directly
> > > accessing the frame buffer copy.
> > >
> > > gopobj->mode.fb_base must be a valid pointer to memory and not a virtual
> > > sandbox address.
> > >
> > > With this change the block image transfer test works again on the sandbox.
> > >
> > >      setenv efi_selftest block image transfer
> > >      bootefi selftest
> > >
> > > Fixes: a75cf70d23ac ("efi: Correct handling of frame buffer")
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   lib/efi_loader/efi_gop.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> > > index 9403e09691e..ae44d140289 100644
> > > --- a/lib/efi_loader/efi_gop.c
> > > +++ b/lib/efi_loader/efi_gop.c
> > > @@ -471,7 +471,7 @@ efi_status_t efi_gop_register(void)
> > >   {
> > >     struct efi_gop_obj *gopobj;
> > >     u32 bpix, format, col, row;
> > > -   u64 fb_base, fb_size;
> > > +   u64 fb_size;
> > >     efi_status_t ret;
> > >     struct udevice *vdev;
> > >     struct video_priv *priv;
> > > @@ -490,7 +490,6 @@ efi_status_t efi_gop_register(void)
> > >     row = video_get_ysize(vdev);
> > >
> > >     plat = dev_get_uclass_plat(vdev);
> > > -   fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
> > >     fb_size = plat->size;
> > >
> > >     switch (bpix) {
> > > @@ -528,7 +527,7 @@ efi_status_t efi_gop_register(void)
> > >     gopobj->mode.info = &gopobj->info;
> > >     gopobj->mode.info_size = sizeof(gopobj->info);
> > >
> > > -   gopobj->mode.fb_base = fb_base;
> > > +   gopobj->mode.fb_base = (uintptr_t)priv->fb;

Don't you want to use copy_fb (if VIDEO_COPY is enabled) so you get
the hardware address?

> >
> > I discussed the value of FrameBufferBase with Simon.
> >
> > The code before the patch is incorrect, as on the sandbox it does not
> > provide a pointer value but a sandbox virtual address. EFI applications
> > may use the pointer for directly writing to the frame buffer. This would
> > lead to a crash on the sandbox.
>
> I still think this means that EFI on sandbox is fundamentally broken.
> The identity virtual-to-physical mapping assumption is just too deeply
> engrained in the ecosystem since that is the documented handoff state
> for most architectures.

The ACPI tables have the same issue (needing to pass a pointer within
sandbox's emulated RAM buffer) and we use nomap_sysmem() to handle
that.

In what way is it broken?

>
> > For the case of CONFIG_VIDEO_COPY=y it is problematic to pass the memory
> > buffer address here, as Linux has an EFI framebuffer driver and would
> > write to the buffer instead of the physical framebuffer. But our memory
> > buffer is neither reserved memory not is it copied to the physical
> > framebuffer after ExitBootServices.
>
> Right.
>
> > If we pass the physical framebuffer address here, then an EFI
> > application might write to it and the cyclic video sync would overwrite
> > the changed pixels.
> >
> > Setting PixelBltOnly in field Mode.PixelFormat forbids EFI applications
> > to directly write to the framebuffer.
>
> That means the framebuffer becomes unusable as soon as the EFI
> application calls ExitBootServices() since an EFI application can't
> call Blt() after that
>
> > So if plat->copy_base is set we should pass PixelBltOnly as PixelFormat
> > and copy_base as FrameBufferBase.
>
> If PixelFormat is PixelBtlOnly, FrameBufferBase is meaningless and
> probably should be set to 0 instead.
>
> Anyway, as far as I can tell there aren't a lot of OSes that support
> PixelBltOnly.  OpenBSD certainly doesn't.  And as far as my reading of
> Linux's efistub code is correct, it doesn't support it either.  And neither does u-boot's own efi_video driver.
>
> I've always seen PixelBltOnly as a way to support weird hardware that
> didn't support a linear framebuffer with a sane pixel format.  Not as
> a way to support a shadow framebuffer like CONFIG_VIDEO_COPY
> implements.  Note that CONFIG_VIDEO_COPY itself assumes a linear
> framebuffer with a sane pixel format as it just does a straight copy
> of the pixels.
>
> Instead of using PixelBltOnly, can we just disable the shadow
> framebuffer as soon as we hand over control to an EFI application?  Or
> maybe at the point where the EFI application uses the GOP protocol?

This seems like a good idea to me - the latter would be best since it
won't impact apps which only use console output. The impact would be
that U-Boot will need to read from the hardware framebuffer with
write-combining enabled (slow on x86) but at least it is correct.

>
>
> > We the aforementioned change we will need to change function
> > gop_get_bpp() to not rely on PixelFormat. Instead we need to pass
> > priv->format in a private field of the graphics protocol.
> >
> >
> > >     gopobj->mode.fb_size = fb_size;
> > >
> > >     gopobj->info.version = 0;
> > > @@ -553,7 +552,7 @@ efi_status_t efi_gop_register(void)
> > >     }
> > >     gopobj->info.pixels_per_scanline = col;
> > >     gopobj->bpix = bpix;
> > > -   gopobj->fb = map_sysmem(fb_base, fb_size);
> > > +   gopobj->fb = priv->fb;
> >
> > priv->fb is also the value used by the TrueType drivers.
> >
> > Best regards
> >
> > Heinrich
> >
> > >     gopobj->vdev = vdev;
> > >
> > >     return EFI_SUCCESS;

It would be worth testing this on a real x86 laptop to make sure it
can still boot Ubuntu, etc.

Regards,
Simon
