Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DC3D5B164
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 08:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D74189123;
	Tue, 29 Oct 2024 09:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rmMMv4SN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F06089070; Tue, 29 Oct 2024 09:47:13 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F5F885F5
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5ebc5b4190eso2940894eaf.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730191630; x=1730796430; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0WUtCGKC6oyZnBXWJVWRsbQn07JGpSzdBpvGcUr9EqU=;
 b=rmMMv4SNxdISz3INHHOvKVuwvyzzWm+nUZK9KkSZ8+WQs3wBwW9Glata4+1Vgot2mP
 xnmlzrjBfGhrKfp6ARzkFhTNh/V7/w2nRITg5dOpDdWu/K+eiO2Rc9X2FwD8Yi8DqKMd
 IpHUPXxWHGjwqBJ0LocXh9bqalDnG2DOg2cKQrO/WpVncjBGx7V9j1Xh/Lvd2K2Ibuf7
 TLJ34Vglx3mnyTfGK26a6Q1dq6RBdgh83LVQXh2tAJEnvySm7hJ4Npq5Scx8yz3jupFC
 oE8zu//l1GS1k4UqJWdGUiucmvAIt/RRpWDJtMbXNDwVmvxAkm0kVQAIWkZBtLNiesfq
 a7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730191630; x=1730796430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0WUtCGKC6oyZnBXWJVWRsbQn07JGpSzdBpvGcUr9EqU=;
 b=ueJYwgmqKv9fSJoUtFQbtnFLBarXNBa+fdP26k9uM5Rkuf9H6bzSkTS2mjzyYcf/dq
 zCIyRW/vs2S2rrrwIgHDV83uLpaULh5UDWZzppAkNTJ9kJi7oJmphOK9zPtCtwKSsVbb
 n9MqsF7sk9G6frcKbo4w1qm8KyXrW+c08Dq5jZfsslxa/pSTHilkuZicb3EfpgVUY9Gw
 p4Zbq9B92/WODn/HGnqPegoAt4kTH1XDXcgCwDZ5qMzo3ttsKKbUmglHU7mi83BX6FpH
 XVxTx3dzcJzXSZtkysDMNlwtNIMZG/+6Kl5OITnnGBc1QeCJ5L88YA/pUcSTYG2I1jTH
 ojYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLD6VDzRLvBanoasuau9XfECo+Gl8WOyaqY5T7M5X39l5alPU9CI1XRESCtDcIauHpQYZObx0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj3u53Ofe7tiGt4DTDIUdzWX5h6k3hClCr8xJpkj4hvfzG6wLC
 qM9e+cYnxlyUyLISpqOW+nuBwlb7+3LY2QMOdts6YftQvinLKZM/xe5onr4Rru8dxHLJXrxtzK4
 70Q6NNPR2OuDfHdHftA7ag0bbShaKUynNumIhPA==
X-Google-Smtp-Source: AGHT+IH+BzjevB2h3EvWOdDenDhHzZahnyjpFJD49AoGxnkJ3H3cw27TDaxHdWOzDrVhsunSUaM9sZmK3Pvg58BzKD8=
X-Received: by 2002:a05:6870:9688:b0:287:3fa2:8978 with SMTP id
 586e51a60fabf-29051be48a0mr9231427fac.27.1730191629777; Tue, 29 Oct 2024
 01:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241024104603.1340301-1-ilias.apalodimas@linaro.org>
 <1334fa3c-95e1-41d7-b0e4-db1452de136d@gmx.de>
In-Reply-To: <1334fa3c-95e1-41d7-b0e4-db1452de136d@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Oct 2024 10:46:33 +0200
Message-ID: <CAC_iWjKmJYNRRicG7Fpy_WN+4gGKQrnTWW_r02efYN0ceTZ7Pg@mail.gmail.com>
Subject: Re: [PATCH] lmb: Correctly unmap and free memory on errors
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Heinrich

On Mon, 28 Oct 2024 at 08:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/24/24 12:46, Ilias Apalodimas wrote:
> > We never free and unmap the memory on errors and we never unmap it when
> > freeing it. This won't cause any problems on actual hardware but it will
> > on sandbox
> >
> > Fixes: commit 22f2c9ed9f53 ("efi: memory: use the lmb API's for allocating and freeing memory")
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/efi_loader/efi_memory.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 9f3f08769977..84be5532a655 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -451,7 +451,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >                               enum efi_memory_type memory_type,
> >                               efi_uintn_t pages, uint64_t *memory)
> >   {
> > -     u64 len;
> > +     u64 efi_addr, len;
> >       uint flags;
> >       efi_status_t ret;
> >       phys_addr_t addr;
> > @@ -499,14 +499,17 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >               return EFI_INVALID_PARAMETER;
> >       }
> >
> > -     addr = (u64)(uintptr_t)map_sysmem(addr, 0);
> > +     efi_addr = (u64)(uintptr_t)map_sysmem(addr, 0);
> >       /* Reserve that map in our memory maps */
> > -     ret = efi_add_memory_map_pg(addr, pages, memory_type, true);
> > -     if (ret != EFI_SUCCESS)
> > +     ret = efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
> > +     if (ret != EFI_SUCCESS) {
> >               /* Map would overlap, bail out */
> > +             lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> > +             unmap_sysmem((void *)(uintptr_t)efi_addr);
> >               return  EFI_OUT_OF_RESOURCES;
> > +     }
> >
> > -     *memory = addr;
> > +     *memory = efi_addr;
> >
> >       return EFI_SUCCESS;
> >   }
> > @@ -548,6 +551,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
> >       if (ret != EFI_SUCCESS)
> >               return EFI_NOT_FOUND;
> >
> > +     unmap_sysmem((void *)(uintptr_t)memory);
> > +
> >       return ret;
> >   }
> >
> > --
> > 2.45.2
> >
>
> AllocatePages() only provides access to EfiConventionalMemory.
>
> We can safely call map_sysmem() with len = 0 and not use unmap_sysmem().

I am not sure I am following you here. We are calling it with len = 0.
But map/unmap_sysmem keep track of internal ref counters for sandbox
and the special tag case. Why shouldn't we call unmap_sysmem()?

Thanks
/Ilias
>
> Best regards
>
> Heinrich
