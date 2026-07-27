Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7FBC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 20:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41A4D407CA;
	Mon, 27 Jul 2026 20:55:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5iFgTxdRi8u1; Mon, 27 Jul 2026 20:55:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2807B407C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785185722;
	bh=lb0fcPpuihzr1G3zhJvhNlFmUGmsPcjuHn5ibgN4Xik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZMOetxrk9ZPkY7WyDhBO6qHJRsKtfautaK58UCLbAjuhtVOAivxLIeToa43ZCoPMf
	 64/57cBLdWXPrehm7SXoTnHpX84cuBr9udtdKIaGqVBD0w1EgOwEed/44I6S1D2Qtb
	 weQdoGLrxyHzmoED1lyw1xYvzHxRkBGJDM+ZfvV1+kC8SH6m8zEShG4rzmKAnJ/z9w
	 B4hMe6TKtPC+U0kWA33SW4RFfp0AYvXY0VbI8OgqRci9vpscaIZziyWn3gOLo8DOO3
	 Dv0dMw3C6nSaKM47UksPYpj2WnO6kT4znZrtccGItRnfkqMVN9Fg1RCRl29h5+U31M
	 zxj9F0chn3hPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2807B407C4;
	Mon, 27 Jul 2026 20:55:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D4D2024D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6789407BE
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZW-8iPhbCMuY for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 20:55:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8231D406C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8231D406C6
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8231D406C6
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:55:19 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so635045a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785185717; cv=none;
 d=google.com; s=arc-20260327;
 b=AFOm87r1hG9y8GaUY5Sy7f5xUKr3q1azeWxieXG3MqEbZOfXh4EQSiXd56IsHlYSGK
 17kpToHnbaYRNVN/KupfayHM+n1gnS1ahOd9b7qiUJQ5B2J/yvyjI+ew8KHZ6BE10/PT
 O9SAxthK8Pgm8kJAr6K0/MxNBjBY7ZtW9OYrqsbilNTohUUo+z/oxRrdXOLhhWs9srtS
 O5nxsF8lG551t5+VgjC2/ekHhYSOp7lVHHxFNYm2cFWya1U7OTb2kQG1ht0bOmdyCgiL
 fXFqCtfYrtHud5azIB16XVV3iQZlRrhA+pBBwMDTiqMDr3A+czfRDVp6ofQ13oZ8VoQY
 xY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lb0fcPpuihzr1G3zhJvhNlFmUGmsPcjuHn5ibgN4Xik=;
 fh=Hd4x5v2S/v9u9MUnO7K+AwuyyknDFmfu2nym920TzJ8=;
 b=gCHdMTeHxs9SMqFdy/sO8jKvpSPDLlCIacQSy5GpOFruGBbYGojUMPFIz+PLTL/TKE
 1FH1neXHEa0T2RkFhmVxFoepId+KCSvL6rH6ed9DwuW3W1ldVasxmR84sghDt6kyogJt
 jYKUZQPrILci9+g9eErP69AwhUMxkVuy5YVfaU3gCtfQ8ih6hlwHnZxIB7l8+b93NUQH
 c4QaDPHoFOX/gQ/EgwOKm/ccTOjK27v8DjXXIDQF4w3yUbWzkPZUWnW+n1aH6Y0nXLKw
 Ktmho6wyDt0afIJjS0QochcsYejEv5wEcdsk+OcDLJwPYAJ6XrJvVZh7o5R870m+7SIi
 UNQg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785185717; x=1785790517;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lb0fcPpuihzr1G3zhJvhNlFmUGmsPcjuHn5ibgN4Xik=;
 b=Hq8AiTVvmN0NMIctXuYAWMKbez6UnQup6c5ojn1Tob4oZDrQrBlDuA2rKgBnXZI2TG
 dlIxi0qBSzVHvMNni30VC/zPd7V1t80xW7+aCDH1sFq3BHD4My/qqUTgWWfTDQWAODkD
 sp1bCzxvaZmilo0orjWUf+oRGs4N4RDnsfduqN9ti7RpT6VkjzM0rM0MHe99j4OLJA2o
 U46zQxUO0LSx/U15bpfdPL3QsGYVMvFuwHrgYTD3r4kceoDzwEFxfYtblee1YnbbPhK6
 MfDe5wlsSJiOQDamDFWnvE4ksRHzwPCSSqnuZuZOGKUBbWu6v+PWEYFkQyFNqCYwks8j
 PpAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjFLXtITEZrUDlxNCRNHWVAdi7IxBe7haIKjYC2c6fBceQ/LA7zl9JgHEWchEcJqfGnSw3kw8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw+IrGl4d93pVxqV+HBh+IZwa9QTpcLqYGANgehzNKbe/XZX0ba
 3FivlAsZbg/TF3am5mSuZHawzo5XWeUpGXyUjrzwb1/mQFopelB3CMsO93roAr3PqUKl4gc1ZgB
 9qefyLxLfqcR7f7IgWD5kE1UceUyKMbpahwJ+TyUa
X-Gm-Gg: AR+sD13zEAad6rdPjYAjslyJ1566Cv38xaOoqb+2JM+bPdHz588efbA298yoj3Qxaph
 wrIbkpvwDO+DoNjhizWI+MD+Z//gKXLdSeBS2Y7lv5eJjUj+9R2fXDAd2FPwiyB8Kp625VmXVzX
 NqoQBsQ/y4jkVHr8fA/wuNKm6TEwvfl9pOgmC7vrB0O/jy32m5i5hOLyNEOhkNMfw1S5LEm09RG
 CsGVnl2FaWLOjMrc2jRV/xjhXmOeU9SlfqhDJqBYzw7MomUX075Hqf5QFWX
X-Received: by 2002:a05:6402:5c4:b0:69c:5eb6:d913 with SMTP id
 4fb4d7f45d1cf-6a02e9618a1mr100886a12.14.1785185717145; Mon, 27 Jul 2026
 13:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260501150550.228937-1-heinrich.schuchardt@canonical.com>
 <ea87842c-75ce-4d39-9ae4-0f8b3b913ad0@canonical.com>
 <871pfudqns.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTiz7YtBtO3yMgVbRxfOSG3J9A+3oTCYuko9me5ona3ZGg@mail.gmail.com>
 <e62b0956-a7bf-4f92-b794-277aaef52713@canonical.com>
In-Reply-To: <e62b0956-a7bf-4f92-b794-277aaef52713@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 27 Jul 2026 14:55:05 -0600
X-Gm-Features: AUfX_mzzPEs4H6MWU4khK3pcgxEfqRC9mMnRqFJJnBeFCrDZ9FWikdoixir4ItU
Message-ID: <CAFLszThFDRqjHPW2ceebfzE9hx_mkJFYiAmsdJ+=szTpKVy3BA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: set correct frame buffer address
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, peng.fan@nxp.com, 
 patrice.chotard@foss.st.com, me@ziyao.cc, bmeng.cn@gmail.com, 
 u-boot@lists.u-boot-project.org, Mark Kettenis <mark.kettenis@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785185717; x=1785790517;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lb0fcPpuihzr1G3zhJvhNlFmUGmsPcjuHn5ibgN4Xik=;
 b=VCbZWOtZ6BhflOPBwngOeTzoM8pbrF/IHL5i48qVi9vkLrR4sMZOKyBNoIMblbdvte
 n0dHVVoE1VPBOJ0kOxlcFZCRPTtq4c5uqzSwtlPaG3Hrh/Ohx150xi+GUSktZoVtqMOO
 b20fFbrx06eyMyp1Xn8PIB1aQrH+Is9Mda3fk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=VCbZWOtZ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Heinrich,

On Tue, 21 Jul 2026 at 02:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/2/26 15:04, Simon Glass wrote:
> > Hi Heinrich, Mark,
> >
> > On Sat, 2 May 2026 at 04:58, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >>
> >>> Date: Sat, 2 May 2026 09:28:56 +0200
> >>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>
> >> Hi Heinrich,
> >>
> >>> On 5/1/26 17:05, Heinrich Schuchardt wrote:
> >>>> If we use video copy, bit image transfers need to write to the in memory
> >>>> copy of the physical frame buffer. Damage control will sync the changes
> >>>> to the physical frame buffer.
> >>>>
> >>>> Cyclic video copy will catch all changes done by EFI applications directly
> >>>> accessing the frame buffer copy.
> >>>>
> >>>> gopobj->mode.fb_base must be a valid pointer to memory and not a virtual
> >>>> sandbox address.
> >>>>
> >>>> With this change the block image transfer test works again on the sandbox.
> >>>>
> >>>>       setenv efi_selftest block image transfer
> >>>>       bootefi selftest
> >>>>
> >>>> Fixes: a75cf70d23ac ("efi: Correct handling of frame buffer")
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>> ---
> >>>>    lib/efi_loader/efi_gop.c | 7 +++----
> >>>>    1 file changed, 3 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> >>>> index 9403e09691e..ae44d140289 100644
> >>>> --- a/lib/efi_loader/efi_gop.c
> >>>> +++ b/lib/efi_loader/efi_gop.c
> >>>> @@ -471,7 +471,7 @@ efi_status_t efi_gop_register(void)
> >>>>    {
> >>>>      struct efi_gop_obj *gopobj;
> >>>>      u32 bpix, format, col, row;
> >>>> -   u64 fb_base, fb_size;
> >>>> +   u64 fb_size;
> >>>>      efi_status_t ret;
> >>>>      struct udevice *vdev;
> >>>>      struct video_priv *priv;
> >>>> @@ -490,7 +490,6 @@ efi_status_t efi_gop_register(void)
> >>>>      row = video_get_ysize(vdev);
> >>>>
> >>>>      plat = dev_get_uclass_plat(vdev);
> >>>> -   fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
> >>>>      fb_size = plat->size;
> >>>>
> >>>>      switch (bpix) {
> >>>> @@ -528,7 +527,7 @@ efi_status_t efi_gop_register(void)
> >>>>      gopobj->mode.info = &gopobj->info;
> >>>>      gopobj->mode.info_size = sizeof(gopobj->info);
> >>>>
> >>>> -   gopobj->mode.fb_base = fb_base;
> >>>> +   gopobj->mode.fb_base = (uintptr_t)priv->fb;
> >
> > Don't you want to use copy_fb (if VIDEO_COPY is enabled) so you get
> > the hardware address?
> >
> >>>
> >>> I discussed the value of FrameBufferBase with Simon.
> >>>
> >>> The code before the patch is incorrect, as on the sandbox it does not
> >>> provide a pointer value but a sandbox virtual address. EFI applications
> >>> may use the pointer for directly writing to the frame buffer. This would
> >>> lead to a crash on the sandbox.
> >>
> >> I still think this means that EFI on sandbox is fundamentally broken.
> >> The identity virtual-to-physical mapping assumption is just too deeply
> >> engrained in the ecosystem since that is the documented handoff state
> >> for most architectures.
> >
> > The ACPI tables have the same issue (needing to pass a pointer within
> > sandbox's emulated RAM buffer) and we use nomap_sysmem() to handle
> > that.
> >
> > In what way is it broken?
> >
> >>
> >>> For the case of CONFIG_VIDEO_COPY=y it is problematic to pass the memory
> >>> buffer address here, as Linux has an EFI framebuffer driver and would
> >>> write to the buffer instead of the physical framebuffer. But our memory
> >>> buffer is neither reserved memory not is it copied to the physical
> >>> framebuffer after ExitBootServices.
> >>
> >> Right.
> >>
> >>> If we pass the physical framebuffer address here, then an EFI
> >>> application might write to it and the cyclic video sync would overwrite
> >>> the changed pixels.
> >>>
> >>> Setting PixelBltOnly in field Mode.PixelFormat forbids EFI applications
> >>> to directly write to the framebuffer.
> >>
> >> That means the framebuffer becomes unusable as soon as the EFI
> >> application calls ExitBootServices() since an EFI application can't
> >> call Blt() after that
> >>
> >>> So if plat->copy_base is set we should pass PixelBltOnly as PixelFormat
> >>> and copy_base as FrameBufferBase.
> >>
> >> If PixelFormat is PixelBtlOnly, FrameBufferBase is meaningless and
> >> probably should be set to 0 instead.
> >>
> >> Anyway, as far as I can tell there aren't a lot of OSes that support
> >> PixelBltOnly.  OpenBSD certainly doesn't.  And as far as my reading of
> >> Linux's efistub code is correct, it doesn't support it either.  And neither does u-boot's own efi_video driver.
> >>
> >> I've always seen PixelBltOnly as a way to support weird hardware that
> >> didn't support a linear framebuffer with a sane pixel format.  Not as
> >> a way to support a shadow framebuffer like CONFIG_VIDEO_COPY
> >> implements.  Note that CONFIG_VIDEO_COPY itself assumes a linear
> >> framebuffer with a sane pixel format as it just does a straight copy
> >> of the pixels.
> >>
> >> Instead of using PixelBltOnly, can we just disable the shadow
> >> framebuffer as soon as we hand over control to an EFI application?  Or
> >> maybe at the point where the EFI application uses the GOP protocol?
> >
> > This seems like a good idea to me - the latter would be best since it
> > won't impact apps which only use console output. The impact would be
> > that U-Boot will need to read from the hardware framebuffer with
> > write-combining enabled (slow on x86) but at least it is correct.
> >
> >>
> >>
> >>> We the aforementioned change we will need to change function
> >>> gop_get_bpp() to not rely on PixelFormat. Instead we need to pass
> >>> priv->format in a private field of the graphics protocol.
> >>>
> >>>
> >>>>      gopobj->mode.fb_size = fb_size;
> >>>>
> >>>>      gopobj->info.version = 0;
> >>>> @@ -553,7 +552,7 @@ efi_status_t efi_gop_register(void)
> >>>>      }
> >>>>      gopobj->info.pixels_per_scanline = col;
> >>>>      gopobj->bpix = bpix;
> >>>> -   gopobj->fb = map_sysmem(fb_base, fb_size);
> >>>> +   gopobj->fb = priv->fb;
> >>>
> >>> priv->fb is also the value used by the TrueType drivers.
> >>>
> >>> Best regards
> >>>
> >>> Heinrich
> >>>
> >>>>      gopobj->vdev = vdev;
> >>>>
> >>>>      return EFI_SUCCESS;
> >
> > It would be worth testing this on a real x86 laptop to make sure it
> > can still boot Ubuntu, etc.
>
> (resending as the the first mail had the old u-boot list mail address).
>
> Do you have a real x86 laptop using U-Boot?

Yes...but I haven't got around to trying this patch. I also have an
x86 QEMU test so if this breaks something I will spot it eventually.
It looks right to me.

Regards,
Simon
