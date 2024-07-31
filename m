Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0421C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042C888A6D;
	Wed, 31 Jul 2024 16:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O3MQeRKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5373E88A87; Wed, 31 Jul 2024 16:39:50 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C76F88A57
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b797fb1c4aso39558576d6.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436787; x=1723041587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UzVGRdJ5YJRo24WzeG9LwDhkePk5RWO+LWoeoJHppzA=;
 b=O3MQeRKdvPmwHd4qJnD6ojRjsFvMA5Tgf8wyhVPatN2R0x1ar8KMFr8jzeI9no7Sxw
 RP3twOiWtp4fCBA8Em85v/vOywdHDUriDseOOOmEHM1M/L7e9GPEJ6ovoSdfYBKnoSat
 ct7YWzP4U/kg5TwGEnlOxQgoKf2YD8Ngy2Y0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436787; x=1723041587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UzVGRdJ5YJRo24WzeG9LwDhkePk5RWO+LWoeoJHppzA=;
 b=n3k5/8zUhoHTm0wM4oIPLkDTbLijJr/zmzBvDWgvRKheMqmzTo5Iy8uA9zt2KUAg/C
 HQ/2ncJvSZ0JkF2TyNzwqce2/XhMyrq7WdpuhBpYNVTITzAxTgEHdq0aVIfhx2se62B0
 tljCcdjBZsuNOj2NErzkmPEupb3BAFGogI7uNNmrMtnpwwNRXoUO+ycdM4UVqFNHqND0
 2BVboD0uT1VLSvIv8tykhv00ccBBv5bjcitbW3hU3q+ENMAjoryHHvbPs4klylzdDLan
 k8d5DF/BsGg6Z3TZFWPW6SScYAmhITqm2I5IxfpHxJ/wmxo66g4/r62XQ5eoPQjoyPhv
 7x4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMWgVhgNQO3MyreetlYyFv5h+HlXw4ZqkuGRDLV82HfZ9gNB4V6b1hHeT9m1fO8gZUH9vm3wU5FWIFAuspDGJZD3S4Eg==
X-Gm-Message-State: AOJu0YyQRbaqqsiHt/JutUQzTRGYW3TeKEZ8YwQBCWjVMqRhhAZRJF0m
 EJABQWRCqW4zlnsiON1b67dwvxRgh6lLr8mAiC7VIHWCVqLMbPxG4MpM/E8znZ3+OpSwEpx8VR4
 zf+YWWjcxURLGebj4en8YVBzrIjlI4EmlbM/N
X-Google-Smtp-Source: AGHT+IGyzyd7T6knTi4bf0hBRi5sT5/dNRF2Yt1jSOaMiv1M/E92L3eUnkSa7mbNhggkVhGrgaRQzwiFclbSMTdviW8=
X-Received: by 2002:a05:6214:2502:b0:6b2:b4d2:984d with SMTP id
 6a1803df08f44-6bb559b814fmr229186536d6.15.1722436786968; Wed, 31 Jul 2024
 07:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-5-sjg@chromium.org>
 <c8b706c9-43d2-4f9a-872a-b2a2089d8b59@gmx.de>
In-Reply-To: <c8b706c9-43d2-4f9a-872a-b2a2089d8b59@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:39:36 -0600
Message-ID: <CAFLszTh9-Y1BrjUNECRBTPfA5JcfNnXQYO0SG=_OPfKRedST3Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] efi: Avoid pool allocation in
 efi_get_memory_map_alloc()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 25 Jul 2024 at 10:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.07.24 15:56, Simon Glass wrote:
> > This function returns the memory map, allocating memory for it. But it
> > can just use malloc() directly, rather than calling the pool allocator.
> > Update it.
>
> The size of the memory map may exceed CONFIG_SYS_MALLOC_LEN which tends
> to be astonishingly small: 1 MiB or less on many boards.

The memory map is typically <20 entries, isn't it? I can't see that
using too much space. If EFI needs malloc() to be larger than 1MB, we
could enforce that with Kconfig.

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
> >   lib/efi_loader/efi_memory.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 087f4c88cdf..2945f5648c7 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -850,14 +850,13 @@ efi_status_t efi_get_memory_map_alloc(efi_uintn_t *map_size,
> >       ret = efi_get_memory_map(map_size, *memory_map, NULL, NULL, NULL);
> >       if (ret == EFI_BUFFER_TOO_SMALL) {
> >               *map_size += sizeof(struct efi_mem_desc); /* for the map */
> > -             ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, *map_size,
> > -                                     (void **)memory_map);
> > -             if (ret != EFI_SUCCESS)
> > -                     return ret;
> > +             *memory_map = malloc(*map_size);
> > +             if (!*memory_map)
> > +                     return EFI_OUT_OF_RESOURCES;
> >               ret = efi_get_memory_map(map_size, *memory_map,
> >                                        NULL, NULL, NULL);
> >               if (ret != EFI_SUCCESS) {
> > -                     efi_free_pool(*memory_map);
> > +                     free(*memory_map);
> >                       *memory_map = NULL;
> >               }
> >       }
>
