Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94AFD70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EFB189D0F;
	Thu, 28 Nov 2024 20:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N2Z43d7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F38C89D0C; Thu, 28 Nov 2024 20:11:11 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE0889D06
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa51b8c5f4dso145342566b.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821068; x=1733425868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GVoKMjVjmIaVw3w4vSPpSM/NrBaUAN5qLitHy6qB+Sg=;
 b=N2Z43d7rrAaNbkEJXQXu329MuOkT+3mCptqJEaOOMIrpRSpFFLeFUdlaitQ1XLe5Au
 4p0LlXfXK5z49w/h6MvhtnX7lUIkykCMRNIKZTXRoBwn9mlbdch+5tsdTvfakCy4LC9L
 KbWXiHrQtgrvUULP1PPBo2ggelAvNtIgk6RvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821068; x=1733425868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GVoKMjVjmIaVw3w4vSPpSM/NrBaUAN5qLitHy6qB+Sg=;
 b=W2e37nJkmWHcBxD/kSArsAFg6PMvU7ZCEBNIXY9FlCwMU0a2rEMFtois2bBVLxN+2d
 JNthCvKweMeQQ4XKfnkudbbXOIstUJ6d9xRS2nS0QvSFQog5lLR9u4D+7YBOrvTliFpZ
 37C8rlmYUPg4hHdlJ6+0n4thDJ7+HlUV0yrn0dLnY+lZWePzkVa24WJbQUPKxGaJEtX0
 NJvoX5WEv5G9ob5uoQLGaCeRy4fdGvi/FaqFqXCdUpDihIIiLvsatPCSDAY2mpa1dRsk
 3oDNAIXWvO2KrxrmeNFiheaNoYVTNnKDFRsaUtZFyRlUEbV8cEJ/YrDD35TioQ1xWLQL
 a0MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy/bGY/sImj2BQNWR/u5w/WQnm9R8RQxVYSvjykyfOUL26yxtHpESbNABgBP2vKHBq7Vc1Aao=@lists.denx.de
X-Gm-Message-State: AOJu0YyAuEeNUaMqpntH1Aas0qcAA2G3lP/9bVc9UsYZfxzVlbCpj08V
 2DNMa805pF0KhgFAXiJjbxxhQfjRSeHHrMl4Gl5orQtB2IlQ8ZmXpQKpW+m4THQX1NCQFObCn7w
 L+SvKVZfZ4ovIv5XdJuW3iaDKOQyB6TAALIJ8
X-Gm-Gg: ASbGncuw7rC9oNUMwsOA1M3QESjiAzlgGznKz6J3e8WIaQpn9eAe6MgKrubPtJOR9Ni
 ejpXfQG3/6cUxKvqjq9nH+AiUHeY6Sk8=
X-Google-Smtp-Source: AGHT+IEXp2d8mQdbpe7jGQEFqxYOako6v9QdABTLLBSfyAEDBOwwdXKCgsQd4oZw5U91wn5AL6t010+fABk2xt985PQ=
X-Received: by 2002:a17:906:32cf:b0:aa5:14a8:f6d9 with SMTP id
 a640c23a62f3a-aa580f01a5dmr569395966b.14.1732821067751; Thu, 28 Nov 2024
 11:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-2-sjg@chromium.org>
 <e1dfadd0-8c26-4daa-b775-4e176ee1a2b6@gmx.de>
In-Reply-To: <e1dfadd0-8c26-4daa-b775-4e176ee1a2b6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 12:10:54 -0700
Message-ID: <CAFLszThkcadwfiX78U=hbKoGPOCtuUseSDh4QdqdsAOTq9B9Uw@mail.gmail.com>
Subject: Re: [PATCH v2 01/28] efi: Define fields in struct efi_mem_desc
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
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

On Thu, 28 Nov 2024 at 10:04, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.11.24 16:47, Simon Glass wrote:
> > There is quite a bit of confusion in the EFI code as to whether a field
> > contains an address or a pointer. As a first step towards resolving
> > this, document the memory-descriptor struct, indicating that it holds
> > pointers, not addresses.
> >
> > Dro the same for efi_add_memory_map() as it is widely used, as well as
> > efi_add_memory_map_pg() which is only used by lmb
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Fix missing @
> > - Note that this holds pointers, not addresses
> >
> >   include/efi.h               | 15 +++++++++++++++
> >   include/efi_loader.h        |  6 ++++--
> >   lib/efi_loader/efi_memory.c |  4 +++-
> >   3 files changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/efi.h b/include/efi.h
> > index c559fda3004..3fce281233c 100644
> > --- a/include/efi.h
> > +++ b/include/efi.h
> > @@ -273,6 +273,21 @@ enum efi_memory_type {
> >   #define EFI_PAGE_SIZE               (1ULL << EFI_PAGE_SHIFT)
> >   #define EFI_PAGE_MASK               (EFI_PAGE_SIZE - 1)
> >
> > +/**
> > + * struct efi_mem_desc - defines an EFI memory record
>
> Please, add here that this structure implements the
> EFI_MEMORY_DESCRIPTOR type of the UEFI specification.
>
> > + *
> > + * Note that this struct is for use outside U-Boot, so the two 'start' fields
> > + * are pointers, not addresses. Use map_to_sysmem() to convert to an address, so
> > + * that sandbox operates correctly.
> > + *
> > + * @type (enum efi_memory_type): EFI memory-type
> > + * @reserved: unused
> > + * @physical_start: Start address of region in physical memory
> > + * @virtual_start: Start address of region in physical memory
>
> %s/virtual memory/
>
> where both addresses will always be the same before
> SetVirtualMemoryMap() as the UEFI specification requires identity mapping.
>
> > + * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
> > + *   bytes)
> > + * @attribute: Memory attributes (see EFI_MEMORY_...)
> > + */
> >   struct efi_mem_desc {
> >       u32 type;
> >       u32 reserved;
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 39809eac1bc..ee0cdd36500 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -788,8 +788,10 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
> >   /**
> >    * efi_add_memory_map_pg() - add pages to the memory map
> >    *
> > - * @start:                   start address, must be a multiple of
> > - *                           EFI_PAGE_SIZE
> > + * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
> > + * is actually a pointer provided as an integer. To pass in an address, pass
>
> %s/an address/a sandbox virtual address/
>
> > + * in (ulong)map_to_sysmem(addr)
> > + *
> >    * @pages:                  number of pages to add
> >    * @memory_type:            type of memory added
> >    * @overlap_conventional:   region may only overlap free(conventional)
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index e493934c713..f1154f73e05 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -384,7 +384,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >   /**
> >    * efi_add_memory_map() - add memory area to the memory map
> >    *
> > - * @start:           start address of the memory area
> > + * @start:           start address of the memory area. Note that this is
> > + *                   actually a pointer provided as an integer. To pass in
> > + *                   an address, pass in (ulong)map_to_sysmem(addr)
>
> %s/an address/a sandbox virtual address/

Sorry, no I don't want to introduce that terminology.
>
> >    * @size:           length in bytes of the memory area
> >    * @memory_type:    type of memory added
> >    *
>

Regards,
Simon
