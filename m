Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800F7D3B9A7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489D789CA9;
	Tue, 26 Nov 2024 16:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KcdtIN+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E9989CA4; Tue, 26 Nov 2024 16:39:26 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8515589C90
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa52bb7beceso460848266b.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635564; x=1733240364; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=isVDWiv1KYhV7Ksd5jX2t7aUAYg1nZSTElvo+mbVLvk=;
 b=KcdtIN+VdMcOTM7+/kT4avvZ+GZV11Cht/hrWItxX8bhW88zkeAN59OwOQxgGP1a1v
 1GmfIhy0PFp+xb9ZmjZ9Xhj+8re0oE8HeO4WYI5D/kFoBzd5hwRJ5SPhY3C+hIhwKYn5
 KEq9NYc0jD6mjlClNaMy998twY11lO9yg8uL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635564; x=1733240364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=isVDWiv1KYhV7Ksd5jX2t7aUAYg1nZSTElvo+mbVLvk=;
 b=mtCaoB6eOhr3u2rW0YC1BmnHu097aGB+X/oiRZ41ElMPbsdWH4FVFqkVfMYJ89yA6H
 uFAFh/WG2aj48reluz0/9iNpm8jgIr9qc8A3BWjWra4B4DgSoZgoHSoSfCeJ9t+n/4c7
 QcSMIbaDGc3z02MCr4z8O9e/ZEi/E0amNXU7aSvpYEQjvRG2nbzgnCIlyTDLFyCZTWmE
 8WI73NducqJk9mHU7EeY5Ad+RDGSnDp+EmD2uuTJpeiQEcRUErOSP5QJaEebJGV/C2LU
 DYIPRRQ6+OJUcjZ88exgZN7mKzxGIV2I1noc0Ta6ItW828PsX2KzhxL4z9NRRDwflAwd
 9NXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1imIldJKZ3bt8VSjgapG2IGx4W+fdme438HtdBxopgsvYl2w7yirVXuae2RjWmf9+2aHF0uM=@lists.denx.de
X-Gm-Message-State: AOJu0YxHl0+ST/EkBztc6LyKKrr2dxu9AXTN0/bSu5xVqwxAEc6rkmqt
 utV/n6UZ27/n2lKjpVR6G0r+XG1vHnw5E7fhfj5DMSs2qO4jkTOZH7XD5W+kHuXeVCpp6K+bYMM
 XTys24lDPqCLg4bJWGpjuq5EgN6XVKe8a7aRu
X-Gm-Gg: ASbGnctbIKoFgsAWhUqzBJgWU0mH9fBy7P+Y1TNYWw+6DSbZPPnR5vI3/nv0FqtufeE
 k+zMgLDZpf84eAun107tMQ/VR67iKDMM=
X-Google-Smtp-Source: AGHT+IG7YICfbYvejXoywap85chASNOeM+WTBTIOeC1XFc6NP+680rmTJqR4sOulqV77PBqiHqs1vOyz9uICh9r/N2I=
X-Received: by 2002:a17:906:3155:b0:a9a:230b:fb5e with SMTP id
 a640c23a62f3a-aa509966471mr1421645666b.4.1732635564012; Tue, 26 Nov 2024
 07:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-9-sjg@chromium.org>
 <ba686354-41a7-413f-aaae-77e286277510@gmx.de>
In-Reply-To: <ba686354-41a7-413f-aaae-77e286277510@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:39:12 -0700
Message-ID: <CAFLszThW0x7-Pxbm0LfkKGSUa+R+SuLfhUDPJn+Rm3S9kQQgig@mail.gmail.com>
Subject: Re: [PATCH 08/13] efi_loader: Tidy up use of addresses
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Janne Grunau <j@jannau.net>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

On Tue, 26 Nov 2024 at 03:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.11.24 21:44, Simon Glass wrote:
> > The EFI loader's memory implementation is quite confusing. The EFI spec
> > requires that addresses are used in the calls to allocate_pages(), etc.
> > This is unavoidable.
> >
> > This usage then filters down to various functions within the
> > implementation. This is unfortunate, as there is no clear separation
> > between addresses and pointers. In some parts of the code things become
> > hopelessly confusing, and several bugs have crept in.
> >
> > Adjust the internal functions to always use a ulong for an address or a
> > void * for a pointer.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   include/efi_loader.h              | 13 +++--
> >   lib/efi_loader/efi_bootmgr.c      |  9 ++--
> >   lib/efi_loader/efi_boottime.c     | 37 ++++++++------
> >   lib/efi_loader/efi_helper.c       |  7 +--
> >   lib/efi_loader/efi_image_loader.c |  2 +-
> >   lib/efi_loader/efi_memory.c       | 84 +++++++++++++------------------
> >   lib/efi_loader/efi_var_mem.c      |  6 +--
> >   7 files changed, 76 insertions(+), 82 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index cae94fc4661..c4afcf2b60b 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -791,7 +791,7 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
> >    */
> >   efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >                               enum efi_memory_type mem_type,
> > -                             efi_uintn_t pages, uint64_t *memoryp);
> > +                             efi_uintn_t pages, void **memoryp);
> >
> >   /**
> >    * efi_free_pages() - free memory pages
> > @@ -800,7 +800,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >    * @pages:  number of pages to be freed
> >    * Return:  status code
> >    */
> > -efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages);
> > +efi_status_t efi_free_pages(void *memory, efi_uintn_t pages);
>
> Read the UEFI spec, please.

Again?

>
> FreePages() expects EFI_PHYSICAL_ADDRESS which is defined as
>
> typedef UINT64 EFI_PHYSICAL_ADDRESS;

How does this comment relate to my patch? We should be using pointers
in most cases, as is done with allocate_pool.

[..]

Regards,
Simon
