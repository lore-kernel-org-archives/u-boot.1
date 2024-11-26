Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D389DD3B9A7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D24F895D0;
	Tue, 26 Nov 2024 16:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Trph1k7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A272289C8C; Tue, 26 Nov 2024 16:38:40 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71FA88D13
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cfadf851e2so7460189a12.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635518; x=1733240318; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HVM2Jt0Ft6J3lmf7dkP8WaIJaIUgWCn11At8NskVvSk=;
 b=Trph1k7/G7ab/B4fSrd4w2+j392pEiYwAiAEviANq5IUdf3bQW6NYv0+puqm0bm1Ky
 eEg2fzfPDxKkvMmyDqzNNybH7cUzRj8HKVlpZR9c0LiflEwfwTuK3ogRsvFDzMfECoPs
 r0sFeJ82G3IBiuBUPQrRl/ODWnO6Pejsu7oZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635518; x=1733240318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HVM2Jt0Ft6J3lmf7dkP8WaIJaIUgWCn11At8NskVvSk=;
 b=X4OdOmxr6EPVpba63meYqboSqEX2MKOR1w94la9QAuQfCcUZ2a5oFDTYVq6HlMKwQn
 vfvMp3hhvkc/ZYGAdHi03odt18NzMbUzPsN3mLkadt8VkrP99D6F1K33UB0CLUmu9DII
 WBA2Vx/gQklR0KOFEXXd5NefhnGLzvdN9PwcISYGBSqWKadWzag+JdOnR9DIBAgIHrOA
 mzZRJZarvzLTOwykaJ9KYbyl4HKAca5AmW+mGZJmeOu9fmOTH1Lb5tBKrA1cFF9PLMJh
 D78nGp0LLmGQcTFP2q9/FQiHPCYObLzhy+xfPOkigqtVYF1f2NzpP2PF9I84dtnTK54/
 Y6sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgTHNILcLehLgNiAqPxXA5CVTvFHs6CpldAe/AUjaw+uMXzEQONhyp+Yx7CUV5TlVQBNwq3D4=@lists.denx.de
X-Gm-Message-State: AOJu0YzXQvAimiSkupWtMkEPqo/GUeLa5EGM1uXm2RC8c7hnoP7qclEt
 +Y32Z5eqcrXNq8tdFUAUC7MfVBZDfb4EHTwf45wLG4KodwxdGuwRn0Irsi1O5akIwXBrPxrF3Hi
 QltLy4n+apdfbAQWN72rsCgTlwrkMIOBeh2q2fqpFhcvQbIQ=
X-Gm-Gg: ASbGncvclCoGFC69dgnHVcPvFRXD4hm1DbKC3vVayV2y0buPb4cAS1QdnDxt1ohJ5i9
 8G03vAPMZfJR3KUKj0ymVW46J7aqL4c8=
X-Google-Smtp-Source: AGHT+IFZvXQ01id8p+ZNyl+0FfMn1VqR9MPkPErPSY+Ny9MotUziTViwraOeHTTAnqW7lpXqU/v4wTDitMNx4WLu31w=
X-Received: by 2002:a17:906:da8d:b0:a9a:dac:2ab9 with SMTP id
 a640c23a62f3a-aa509d3fbf1mr1508409066b.42.1732635518207; Tue, 26 Nov 2024
 07:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-3-sjg@chromium.org>
 <74286a06-89dc-43ec-a669-f4dd0a97fee6@gmx.de>
In-Reply-To: <74286a06-89dc-43ec-a669-f4dd0a97fee6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:38:26 -0700
Message-ID: <CAFLszTgi_dsw917cQytCOAZ7sFsLnyz3XXmeeNVo3MNqS9VkuA@mail.gmail.com>
Subject: Re: [PATCH 02/13] efi_loader: Convert efi_get_memory_map() to return
 pointers
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

On Tue, 26 Nov 2024 at 02:27, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.11.24 21:44, Simon Glass wrote:
> > This function should return pointers, not addresses. Add the conversion.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   lib/efi_loader/efi_memory.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index e493934c713..8b01821a993 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -748,6 +748,11 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
> >       memory_map = &memory_map[map_entries - 1];
> >       list_for_each_entry(lmem, &efi_mem, link) {
> >               *memory_map = lmem->desc;
> > +             /* Convert to pointers, which is what the caller expects */
> > +             memory_map->physical_start =
> > +                     (ulong)map_sysmem(lmem->desc.physical_start, 0);
> > +             memory_map->virtual_start =
> > +                     (ulong)map_sysmem(lmem->desc.virtual_start, 0);
> >               memory_map--;
> >       }
> >
>
> NAK.
>
> physical_start and virtual_addr are not sandbox virtual addresses.
>
> The sandbox virtual address space is irrelevant for UEFI. They should be
> restricted to the CLI.

Well, you can't have it both ways. Either this is a pointer expressed
as a u64, or it is an address.

My understanding is that it is a pointer expressed as a u64. The use
of u64 is a confusing part of the spec, but it is because they want to
specify the size as 64-bit, whereas a void * would not have a fixed
size. But you can't run a 32-bit image on a 64-bit machine anyway, so
this decision is a mystery to me.

Regards,
Simon
