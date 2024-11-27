Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAF9D6ACCD
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFFA5897D8;
	Wed, 27 Nov 2024 14:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aq+5Z/0I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90677897D5; Wed, 27 Nov 2024 14:07:14 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FCE2897D8
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa503cced42so827152866b.3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712832; x=1733317632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xp78pQj5fd/8L2sh+tqPi8cjdrPUWm2j4vRXcNBl/ng=;
 b=aq+5Z/0IDpC9jCx8taRSa+Kjv3yCNb9jtQx8k94fHZGXNY8YW4ewf3C8hrzow85U6w
 z6ww4NE5xRBYwGsQclJx+pYmGcuzbm/hsUwPfoEUJMoz6IzZylRDj7S6ItPC9nffhSfo
 b+pUVBVYW+0fxLOQALct5m2ZWO2/ih+S4c4Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712832; x=1733317632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xp78pQj5fd/8L2sh+tqPi8cjdrPUWm2j4vRXcNBl/ng=;
 b=Ruz60yjBDOXtZhntdK9ll/z2XekjycCOrFz110XdI0pOZvj9DZQV/6OG2ltf2pLWZU
 latCKIwbh+Uxk6VGeemZj+XKaqiXl4Agmcytug/Fh8la+ILJEJrOnY5RJyBMhyBWgieQ
 ExGjwPm77EpuTlyKT/OQuqS99fJGDS5kvGFAkoMjogGK05nlyk5Dj/AU3K9v5Ys/BPJ2
 r5/Q9N/1mDcCE7nuCKqV8Yid4xiv9HEJX45+nJ0OqDClftb5JEB1VTjT6F1T0bzI8Obh
 PntDoNmD5xObYHmeok57d52MfhgUpRK9LxyosZcPOT1udkGtNgaqDJdDvLtNtngcJ2ry
 +f9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8QCNDJlSMxDXtujidb8HFrC9n5Fuym+lyvt4oNExCXRksQVKoYy/lsPebZmdkENhhu+Qef+g=@lists.denx.de
X-Gm-Message-State: AOJu0YwbeH+bsNqqycGZrj6HMUqMKIwz9h/By2Tm04KTQizEptN7LCSc
 1a/AgNBgrnzZTM18Xpg3B+dgMB/8lKJ+3OfFRD/pe38wZ4n3TXt8y+aKaet33aTlqreizGdQN4a
 uFqOZiYuvPrv+0p9kIhcXPokbwOziq+RDsGUi
X-Gm-Gg: ASbGncsDxf4UN+UK6F5rW+LHOoC8kcgQlnONxwf1425PG4E6gzwiQ+bTM+xtMOtqRmC
 aiJh9Te0Pzf3yi60YTvtfBmEwDAkVJA4=
X-Google-Smtp-Source: AGHT+IHsbRwc2GCzVVu1b9V01G2hp7iEDQWGHC2KuMfqbPwVYZcn9uG9E41SGqMaJpUUtGQLkxtdKn4OE7B0sLZeqsQ=
X-Received: by 2002:a17:906:315b:b0:aa5:427e:6af4 with SMTP id
 a640c23a62f3a-aa58104104cmr217702466b.47.1732712831467; Wed, 27 Nov 2024
 05:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-3-sjg@chromium.org>
 <74286a06-89dc-43ec-a669-f4dd0a97fee6@gmx.de>
 <CAFLszTgi_dsw917cQytCOAZ7sFsLnyz3XXmeeNVo3MNqS9VkuA@mail.gmail.com>
In-Reply-To: <CAFLszTgi_dsw917cQytCOAZ7sFsLnyz3XXmeeNVo3MNqS9VkuA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:06:59 -0700
Message-ID: <CAFLszTg3P-emV=WyPg89vnjSBXjWiKRwsK9LdT-ZMLeVhnHaSg@mail.gmail.com>
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

Hi again Heinrich,

On Tue, 26 Nov 2024 at 08:38, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Tue, 26 Nov 2024 at 02:27, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 25.11.24 21:44, Simon Glass wrote:
> > > This function should return pointers, not addresses. Add the conversion.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >   lib/efi_loader/efi_memory.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index e493934c713..8b01821a993 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -748,6 +748,11 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
> > >       memory_map = &memory_map[map_entries - 1];
> > >       list_for_each_entry(lmem, &efi_mem, link) {
> > >               *memory_map = lmem->desc;
> > > +             /* Convert to pointers, which is what the caller expects */
> > > +             memory_map->physical_start =
> > > +                     (ulong)map_sysmem(lmem->desc.physical_start, 0);
> > > +             memory_map->virtual_start =
> > > +                     (ulong)map_sysmem(lmem->desc.virtual_start, 0);
> > >               memory_map--;
> > >       }
> > >
> >
> > NAK.
> >
> > physical_start and virtual_addr are not sandbox virtual addresses.
> >
> > The sandbox virtual address space is irrelevant for UEFI. They should be
> > restricted to the CLI.
>
> Well, you can't have it both ways. Either this is a pointer expressed
> as a u64, or it is an address.
>
> My understanding is that it is a pointer expressed as a u64. The use
> of u64 is a confusing part of the spec, but it is because they want to
> specify the size as 64-bit, whereas a void * would not have a fixed
> size. But you can't run a 32-bit image on a 64-bit machine anyway, so
> this decision is a mystery to me.

Anyway, I have this around the wrong way, so can drop this patch once
I update patch 1 to document what is actually going on...

Regards,
Simon
