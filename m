Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28478C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3FF80657;
	Sat, 18 Jan 2025 05:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fj5JXMqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DBD8070C; Sat, 18 Jan 2025 05:35:16 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B4A8036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso517454766b.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 20:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737174913; x=1737779713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L1Eqabw6437JHFHJ6kYdeldHcQ4XEdsUJfUWc3v/l0Q=;
 b=Fj5JXMqqXD+4UXwYW3H2+AI5wcySP9dh6C0Oe0St+yJtowr7Wgi4Zm9oVsDkMxrqFW
 mN1vaBMNZgqvd7RGu8DKH0B/gSEFALk709285+7MiW/oqC3ZjWO6/8BPHAlfKJmAsAlS
 Fix+TBzZlSGrcCC4XyCaxbUSCKYmQ3Ua34ZEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737174913; x=1737779713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L1Eqabw6437JHFHJ6kYdeldHcQ4XEdsUJfUWc3v/l0Q=;
 b=lWjXNatiD9V8saNvI/Lr86E029jlRABfAIUKpykmsGEw7IfFKRwlo7biG8ZY4A1N2f
 R+fK1MgdkubexWw8jkyWLjGgEt8omglNu4K4Veqzo8msWrtKFHe6v0MbbShSG7QNnDRZ
 pNKtjfrxc5s7Kgj7cc6/ji6s96INC0SCQhMROQ6+AuW//4vLtVL8omgeVqe2NwL66l6T
 sY7wLNWS1+QgSRcGXQI33KI4vx0hnVL+h3yTwo3fJuEWvQ2EhcI5HD69/yfkZjwxw+lW
 u7jTBybAFhq9preqDPq6+G9R9ndjUnO1fgRLFlAjMSbWI5j7JvcZPYttfD+MdIffwwbb
 bbGQ==
X-Gm-Message-State: AOJu0YylfpyLiEdVxai5dJ1pEqyNA03tED/+MpbtNWWIY0SuYWbs1KX8
 Km9AACv6ONoWG/3uh3VxYtmQnWTGRjMe4EvEtL1ldzYlCCm9khyQ/nX1Zfs8wPv/oNj/6ruYWT/
 FoF4H5wsnCrEhYONjh/faiFlq9WpvIo4qxOhoCsZ5Ei1zTZQ=
X-Gm-Gg: ASbGnct2OcuKrKAGOcr1do0a8c5jVCyMJzMXVeldbM00CeG4tCIiaVY0TpAiZK6OOvZ
 OxM0M3cjDLBUIcRCJJi6QCknVJQ218n+IAedGTFQ1hhHRu2WTaYw9lJC71jRIpaInqa884exfRN
 xGOPT5AMJZ
X-Google-Smtp-Source: AGHT+IG/dlmqHpWJu2hxVQo/gYyODfTuRS3ad7FjJrDLIjjTHVEzg0oi0JPlF8U6PeuWyOob3jOVfixZg/VzRGMBBso=
X-Received: by 2002:a17:907:7b9c:b0:aae:ce4c:ca40 with SMTP id
 a640c23a62f3a-ab38b2e737cmr508957566b.32.1737174912808; Fri, 17 Jan 2025
 20:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <20250106144755.3054780-5-sjg@chromium.org>
 <CAC_iWjK2Arj5EkA8AsQh_BFGQoby5tNwf=GVpwSBaW8nBnQ_Yg@mail.gmail.com>
In-Reply-To: <CAC_iWjK2Arj5EkA8AsQh_BFGQoby5tNwf=GVpwSBaW8nBnQ_Yg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jan 2025 20:35:01 -0800
X-Gm-Features: AbW1kvYBGpVABBlXJPLPs8Yuvr0w_a0DLjVSdskXzYpyt-cFoKt5IGPGJDmRzRQ
Message-ID: <CAFLszTgDWbt9cM43XGPU4Ew9HxmPf1peEEP5Bw+cxHwV_EWjqw@mail.gmail.com>
Subject: Re: [PATCH 4/8] efi_loader: Correct bounce-buffer setup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Fri, 17 Jan 2025 at 03:34, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:
>
> Hi Simon,
>
> Is this patch for -master of your tree?

Yes, but I haven't applied it yet. The updated bootflow_efi() test ([1]
which this is part of) is throwing up problems with how testing is done. We
cannot today reinit EFI so only get to run one test which does an EFI boot.
I'd like to improve that at some point.

The address/pointer tidy-up was rejected as well, I think by you, but
perhaps Heinrich?

>
> On Mon, 6 Jan 2025 at 16:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > This should set the bounce buffer to a pointer, not an address. Fix it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  lib/efi_loader/efi_memory.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 2e197e94edd..9374f77d3b7 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -837,11 +837,11 @@ int efi_memory_init(void)
> >         uint64_t efi_bounce_buffer_addr = 0xffffffff;
> >
> >         if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
EFI_BOOT_SERVICES_DATA,
> > -                              (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
> > +                              SZ_64M >> EFI_PAGE_SHIFT,
> >                                &efi_bounce_buffer_addr) != EFI_SUCCESS)
> >                 return -1;
> >
> > -       efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
> > +       efi_bounce_buffer = map_sysmem(efi_bounce_buffer_addr, SZ_64M);
>
> map_sysmem does *exactly* the same thing so you need to adjust your
> commit message.
>
> Does this solve any sandbox crashes?

No, sandbox doesn't test this feature yet, but the new code is more
correct. Whenever you see an address, use map_sysmem() to turn it into a
pointer.

>
> /Ilias
> >  #endif
> >
> >         return 0;
> > --
> > 2.34.1
> >

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=439021
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=436241
