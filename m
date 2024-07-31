Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CC6C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A086288A61;
	Wed, 31 Jul 2024 16:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kHAWIEgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B40888A34; Wed, 31 Jul 2024 16:39:49 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2577D88955
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d59e491fefso2545379eaf.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436786; x=1723041586; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rkF8StgUpjFvug8BYr3W/yV1eE3WlHQ/ccHH0Ok2+DY=;
 b=kHAWIEgZTQE9DpcE9h3f8pj/llcrh7c/NsW8o88ygcn6pxvvFL4e6Fs6pU4IClUuwq
 ooQTHBJnD16aOQBT8wkR7IsrhqpBi26cvn3zNwP+AkOhyZCuVD2mm7Kbv91KcAN5vgWO
 MfgPonSVsfe8hJjubMC+nWS9RkjU0OrZWGzbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436786; x=1723041586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rkF8StgUpjFvug8BYr3W/yV1eE3WlHQ/ccHH0Ok2+DY=;
 b=fpV/wK3LYTDHr5ArHh5CyHtNx7no5VAoLB1GO0f3QcjgPS4uM6zuChXTAXqtsKHeHK
 9Lbo79xU5DqgspzApOiXMoUZB5ZCCDoS/T2RyCi+nSc0xdGgluNnZQyQzQ+/Uvlf7n97
 0PRMA1t1+0e4pLSFpzCFjWsHUdHQoPCyhpJTmH/XjeVb4+Glx2PFJ7P+r0jRuirmP+BE
 MAs5mlMwaYLdNyXHYchxwN1WUE4sw6zDSk0636E7Inz1q7I7YNesMtXSGe2qgiPkig0B
 LlT95PCkoLnAnPu62fc0GG01FPK8L84LdhALRLZmw3Bsnb5Qob3tjj8w3tOsOmjCL9MD
 O4Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdOM29yS9O/oZhDTw9EVRhGvqfs54S1Pjni3Vis7TJMc1aMRO7ETgEvdaqkXlTQgAlUnf3jkejt03G9ZLIk5A3j783UQ==
X-Gm-Message-State: AOJu0YxB76yDA0A71fIUudD/DfyhS2Oyf3uLaalcff7hL8VG0pynse15
 BYukNYexUTdztrwTOtWZ9mSbIQdc0IgNo3SF2GldVPq3j9OF7MuFfFVbgyluJSaOXbR94twk+RM
 X90gBKmPBRMdnR2DrlS9qpqlsk7Wh4tZefu8Y
X-Google-Smtp-Source: AGHT+IEfnPaTqsHcu/3clt5Xj1FA0fgfEi9Fb5QAsRYcXZ1lofRyoJEv2xAALBjfFlJeK9mo8JsCs4WmtCrIg4IBqhg=
X-Received: by 2002:a05:6359:590:b0:1a5:2f55:c46e with SMTP id
 e5c5f4694b2df-1adc0677b35mr775539155d.9.1722436785783; Wed, 31 Jul 2024
 07:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-7-sjg@chromium.org>
 <e4e7e085-aacc-4c2e-99dc-924a1ef22c46@gmx.de>
In-Reply-To: <e4e7e085-aacc-4c2e-99dc-924a1ef22c46@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:39:35 -0600
Message-ID: <CAFLszThmhaok8yt2dv5LosGRWug7GcjL5tGnhRCM2Y=W=cebag@mail.gmail.com>
Subject: Re: [PATCH 6/6] efi: Show the location of the bounce buffer
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
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

On Thu, 25 Jul 2024 at 10:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.07.24 15:56, Simon Glass wrote:
> > The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
> > clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
> > lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> >
> > This feature uses EFI page allocation to create a 64MB buffer 'in space'
> > without any knowledge of where boards intend to load their images. This
> > may result in image corruption or other problems.
>
> This is what Sughosh's LMB series in addressing.

Not really...it will still be 'in space' so will be annoying for some
boards. This series is separate from Sughosh's.

>
> With CONFIG_SYS_MALLOC_LEN=0x202000 for lx2160ardb_tfa_stmm we cannot
> move the buffer to malloc(). I don't understand why
> CONFIG_SYS_MALLOC_LEN is so small.

Because it is designed for small allocations, e.g. the equivalent of
EFI's pool. We have never used malloc() to load images, not for
allocating bounce buffers.

>
> >
> > For example, if the feature is enabled on qemu_arm64 it puts the EFI
> > bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> > 1088MB. The kernel is probably smaller than 27MB but the buffer does
> > overlap the ramdisk.
> >
> > The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> > version being dropped. For now, show the address of the EFI bounce
> > buffer so people have a better chance to detect the problem.
> >
> > Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
> > that the feature may be removed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   lib/efi_loader/efi_bootbin.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index 07c8fca68cc..53e5e429d2e 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -211,6 +211,14 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >               return -1;
> >       }
> >
> > +#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > +     /*
> > +      * Add a warning about this buffer, since it may conflict with other
> > +      * things
> > +      */
> > +     printf("EFI bounce buffer at %p\n", efi_bounce_buffer);
> > +#endif
>
> Does this sound like a warning to you?
>
> There is nothing that a user can reasonably do when seeing this message
> while the board is booting via one of the boot methods. So we should not
> write it.

We could add a 'warning:' prefix, perhaps? At the moment there is no
clue that the bounce buffer may overwrite an image. What do you
suggest?

> > +
> >       ret = efi_install_fdt(fdt);
> >       if (ret != EFI_SUCCESS)
> >               return ret;
>

Regards,
Simon
