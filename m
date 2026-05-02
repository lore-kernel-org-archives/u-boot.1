Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7860CD3423
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 10:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE99580F0E;
	Sat,  2 May 2026 12:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="heoRqBVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3424A83642; Sat,  2 May 2026 12:58:19 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D9880087
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 12:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d2313816-4615-11f1-89e5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d2313816-4615-11f1-89e5-00505699b430;
 Sat, 02 May 2026 12:58:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=yJaATq4tVpLUb06wCjbktbJn8js6a5nlPwtEKHsr7m8=;
 b=heoRqBVrwoVbXKnkG2WH+P0fOwB+V5noanQKiYztPWRCc3+AyNg0fvKpzTEVKsphbCAE1qFNyqv1M
 snDFzJBiTVj6hmu5IhwpEXTz0EYhicvTf7s53gcRXKdG2GaQQDcZMgKQDjcIUV71KfLiEVn0PHjWy7
 td8MVl6su/bukVAKK/YxSpMhkGGX+7gzbVuVvPNGAJk2aqUb6JjKyqVK58y/gdD75QUjSddeUrar/Q
 uj6OykVNo9nf8OSSzz6RBI8+uhhiA5BgEaKQD3oRI/4BBDDi6M20+7zVtIH9xDJS1VfKVL3NBwILZy
 25vlIExKDEXJ1eRt88Kwzwbpa8VnZ0g==
X-KPN-MID: 33|qUU3ujZNf3HRSWW8VnNmdcFCLMen6RkK6mvc8X2Tscp2XE70xUEVzVGLPdyX4Lk
 4AhMlqMUq6W50badpd+Y283uZ/nD0IGnYfqPbeFDytuk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|+V1QwZPqDbPVgGuuKpd9aGBkKFCs/5ICP4aIXvVd64Z5JaERiJ/f/ofVt+K2znu
 m7i60ltpTzLYHozcMtkPdYw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d1a7b609-4615-11f1-bffa-00505699772e;
 Sat, 02 May 2026 12:58:15 +0200 (CEST)
Date: Sat, 02 May 2026 12:58:15 +0200
Message-Id: <871pfudqns.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, me@ziyao.cc, sjg@chromium.org,
 bmeng.cn@gmail.com, u-boot@lists.denx.de
In-Reply-To: <ea87842c-75ce-4d39-9ae4-0f8b3b913ad0@canonical.com> (message
 from Heinrich Schuchardt on Sat, 2 May 2026 09:28:56 +0200)
Subject: Re: [PATCH 1/1] efi_loader: set correct frame buffer address
References: <20260501150550.228937-1-heinrich.schuchardt@canonical.com>
 <ea87842c-75ce-4d39-9ae4-0f8b3b913ad0@canonical.com>
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

> Date: Sat, 2 May 2026 09:28:56 +0200
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Hi Heinrich,

> On 5/1/26 17:05, Heinrich Schuchardt wrote:
> > If we use video copy, bit image transfers need to write to the in memory
> > copy of the physical frame buffer. Damage control will sync the changes
> > to the physical frame buffer.
> > 
> > Cyclic video copy will catch all changes done by EFI applications directly
> > accessing the frame buffer copy.
> > 
> > gopobj->mode.fb_base must be a valid pointer to memory and not a virtual
> > sandbox address.
> > 
> > With this change the block image transfer test works again on the sandbox.
> > 
> >      setenv efi_selftest block image transfer
> >      bootefi selftest
> > 
> > Fixes: a75cf70d23ac ("efi: Correct handling of frame buffer")
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >   lib/efi_loader/efi_gop.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> > index 9403e09691e..ae44d140289 100644
> > --- a/lib/efi_loader/efi_gop.c
> > +++ b/lib/efi_loader/efi_gop.c
> > @@ -471,7 +471,7 @@ efi_status_t efi_gop_register(void)
> >   {
> >   	struct efi_gop_obj *gopobj;
> >   	u32 bpix, format, col, row;
> > -	u64 fb_base, fb_size;
> > +	u64 fb_size;
> >   	efi_status_t ret;
> >   	struct udevice *vdev;
> >   	struct video_priv *priv;
> > @@ -490,7 +490,6 @@ efi_status_t efi_gop_register(void)
> >   	row = video_get_ysize(vdev);
> >   
> >   	plat = dev_get_uclass_plat(vdev);
> > -	fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
> >   	fb_size = plat->size;
> >   
> >   	switch (bpix) {
> > @@ -528,7 +527,7 @@ efi_status_t efi_gop_register(void)
> >   	gopobj->mode.info = &gopobj->info;
> >   	gopobj->mode.info_size = sizeof(gopobj->info);
> >   
> > -	gopobj->mode.fb_base = fb_base;
> > +	gopobj->mode.fb_base = (uintptr_t)priv->fb;
> 
> I discussed the value of FrameBufferBase with Simon.
> 
> The code before the patch is incorrect, as on the sandbox it does not 
> provide a pointer value but a sandbox virtual address. EFI applications 
> may use the pointer for directly writing to the frame buffer. This would 
> lead to a crash on the sandbox.

I still think this means that EFI on sandbox is fundamentally broken.
The identity virtual-to-physical mapping assumption is just too deeply
engrained in the ecosystem since that is the documented handoff state
for most architectures.

> For the case of CONFIG_VIDEO_COPY=y it is problematic to pass the memory 
> buffer address here, as Linux has an EFI framebuffer driver and would 
> write to the buffer instead of the physical framebuffer. But our memory 
> buffer is neither reserved memory not is it copied to the physical 
> framebuffer after ExitBootServices.

Right.

> If we pass the physical framebuffer address here, then an EFI 
> application might write to it and the cyclic video sync would overwrite 
> the changed pixels.
> 
> Setting PixelBltOnly in field Mode.PixelFormat forbids EFI applications 
> to directly write to the framebuffer.

That means the framebuffer becomes unusable as soon as the EFI
application calls ExitBootServices() since an EFI application can't
call Blt() after that

> So if plat->copy_base is set we should pass PixelBltOnly as PixelFormat 
> and copy_base as FrameBufferBase.

If PixelFormat is PixelBtlOnly, FrameBufferBase is meaningless and
probably should be set to 0 instead.

Anyway, as far as I can tell there aren't a lot of OSes that support
PixelBltOnly.  OpenBSD certainly doesn't.  And as far as my reading of
Linux's efistub code is correct, it doesn't support it either.  And neither does u-boot's own efi_video driver.

I've always seen PixelBltOnly as a way to support weird hardware that
didn't support a linear framebuffer with a sane pixel format.  Not as
a way to support a shadow framebuffer like CONFIG_VIDEO_COPY
implements.  Note that CONFIG_VIDEO_COPY itself assumes a linear
framebuffer with a sane pixel format as it just does a straight copy
of the pixels.

Instead of using PixelBltOnly, can we just disable the shadow
framebuffer as soon as we hand over control to an EFI application?  Or
maybe at the point where the EFI application uses the GOP protocol?


> We the aforementioned change we will need to change function 
> gop_get_bpp() to not rely on PixelFormat. Instead we need to pass 
> priv->format in a private field of the graphics protocol.
> 
> 
> >   	gopobj->mode.fb_size = fb_size;
> >   
> >   	gopobj->info.version = 0;
> > @@ -553,7 +552,7 @@ efi_status_t efi_gop_register(void)
> >   	}
> >   	gopobj->info.pixels_per_scanline = col;
> >   	gopobj->bpix = bpix;
> > -	gopobj->fb = map_sysmem(fb_base, fb_size);
> > +	gopobj->fb = priv->fb;
> 
> priv->fb is also the value used by the TrueType drivers.
> 
> Best regards
> 
> Heinrich
> 
> >   	gopobj->vdev = vdev;
> >   
> >   	return EFI_SUCCESS;
> 
> 
