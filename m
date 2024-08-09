Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05195C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 18:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC8B688C3D;
	Fri,  9 Aug 2024 20:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l0eiSXbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8673C880E6; Fri,  9 Aug 2024 20:36:49 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC0D88C29
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 20:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b7a8cada97so13745416d6.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723228606; x=1723833406; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gIU+vpN/qlaoJfk6mkzTu7lKbfnaiX/puXBztyBsWyo=;
 b=l0eiSXbR4GwikNSMUjzfZEds7U/A3/SeXMzGh3HyD1ky8u8Tkm2ewox9YJtl8aAx80
 7IYpHjLQIjv623lvodZaAw6hsrW7l11RKK89/e/zeAu8e5jDASAIyXg2aKi6E+UUqnVV
 3LKEMzhEY5H6jqi0fnBPE4kphq73IPipgcL/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723228606; x=1723833406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIU+vpN/qlaoJfk6mkzTu7lKbfnaiX/puXBztyBsWyo=;
 b=mNFPDntW4EmNT0qyR/np0UNHx0J5zxg3y2/bUBzIBWXIFKBIz7ypF5knakEKYAaKrG
 5/lCHdd8KMUHMiCfF3EtgOQEcWcDdqNKS/5Gdcz8nuNJ9wP06eyU9QQYEPjLPpZ5bLXz
 XHzgykJYJljc5fL/pkTPeAw5bPdChThyplArANOhppWbCWkp+59hw9KEZv40b6/4eBWH
 TPIMttLiZNFgovbLLq9iBO+zaxSZmNRJlyB7FV5D/O0HuaHB+WbdfVTpxX7v3Sxbuc+l
 D4kTW7nbFtGxMKIqBnY5kVvZWeqgD30+o4FOsSWLsZ3ZgoL3KaOpA1CC/MYbW2i/q9AH
 A0vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRrKJLBrfhgTFz7HfbCsGsh0oSvADCzC1Q2zH57M2VQoSo9opXe7Yo8Mkor9X76raBJcsRe23IpsqHwgdnn15HBnsHKQ==
X-Gm-Message-State: AOJu0Yz3qrZ562e4oWdVPSpl0lXiFJkWgWtPKcprhi8IJvopzf0ijDZU
 QLaGQX5UNrLdzA4Mugj74hb6yjGgvbnKqWLHr8cL2qjBz+MQKnYKZgmtOXa2LQub7h/UM8TKPDx
 utyUE2OSrp2c0AMXXIffKJtQi6oevrGomt5ny
X-Google-Smtp-Source: AGHT+IGkjj3wgqso8HhJ/b/kKysmWkPN7Mv9HiEZvzCygOUonOxPKiigTyWfd89UXSwWniUvJZgjvfQw0Mv9S26FqTY=
X-Received: by 2002:a05:6214:3d11:b0:6b2:da7e:5cb7 with SMTP id
 6a1803df08f44-6bd78cf78c3mr33893696d6.5.1723228606197; Fri, 09 Aug 2024
 11:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-4-sjg@chromium.org>
 <4594d522-bb63-45ee-b660-0130ae55d341@gmx.de>
In-Reply-To: <4594d522-bb63-45ee-b660-0130ae55d341@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 12:36:35 -0600
Message-ID: <CAFLszTgmRMCK9E==O-sz51ONfaGENnoStXPY4LL5HS0F-=cDfA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] efi: Show the location of the bounce buffer
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

On Fri, 9 Aug 2024 at 11:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 01.08.24 19:36, Simon Glass wrote:
> > The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
> > clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
> > lx2162aqds_tfa_SECURE_BOOT and the like) use it.
> >
> > This feature uses EFI page allocation to create a 64MB buffer 'in space'
> > without any knowledge of where boards intend to load their images. This
> > may result in image corruption or other problems.
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
>
> EFI_BLOCK_IO_PROTOCOL.ReadBlocks() and
> EFI_BLOCK_IO_PROTOCOL.WriteBlocks() are expected to block until all
> bytes are transferred.
>
> The complete file transfer is chunked according to the size of the EFI
> bounce buffer.
>
> Taking care of alignment issues would best handled by the block uclass.
>
> When CONFIG_BOUNCE_BUFFER=y, bounce_buffer_start_extalign() uses
> memalign() which limits the bounce buffer to available malloc() memory
> (typically < 2 MiB).
>
> I cannot see how blk_read() with CONFIG_BOUNCE_BUFFER=y will work if
> blkcnt * desc->blksz is greater than the available malloc memory.

Yes, it uses malloc(). The maximum read length on MMC, for example,
seems to default to 32MB, although it is only 128KB on a few
platforms.

I am thinking we should be allocating space in the bloblist to hold
all these sorts of things...it can be as large as needed and we can
allocate space for it during relocation.

>
> Shouldn't the block uclass support chunking?

It only supports readling whole blocks, if that is what you mean. Are
you suggesting changing the blk API, or something else?

Regards,
Simon



>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Drop patch 'Show more information in efi index'
> > - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> > - Add the word 'warning', use log_warning() and show the end address
> > - Reorder patches a little
> >
> >   lib/efi_loader/efi_bootbin.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index 5bb0fdcf75d..9779dc09b5e 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -211,6 +211,15 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >               return -1;
> >       }
> >
> > +#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> > +     /*
> > +      * Add a warning about this buffer, since it may conflict with other
> > +      * things
> > +      */
> > +     log_warning("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buffer,
> > +                 efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
> > +#endif
> > +
> >       ret = efi_install_fdt(fdt);
> >       if (ret != EFI_SUCCESS)
> >               return ret;
>
