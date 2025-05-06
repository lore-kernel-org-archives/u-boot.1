Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2DBC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 11:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B45581F66;
	Tue,  6 May 2025 13:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ureurnUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19655820F6; Tue,  6 May 2025 13:05:58 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80218800D7
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 13:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D48403F29E
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746529554;
 bh=3MrHvmrd+LHExBNWOBLDQBkOPmra7dcHQdnAEiCTPC4=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=ureurnUAh5pWNjiE7WG3SqX7r237xhjG0W/a+tKFXl9lrZEDMQzHcP6qxCybxAevp
 bjyb3jaNjw/6ZQzXP69Fye7AbKS6aaPI0C/916V7AiwhCpDU61i8VRZWzrksYksUP/
 to+jwOuiTREqpVdTvPthpd3TloD0wRhLEvqSNNlDl1pDJz/VJfgS6MH1A9RPLOERrm
 Ix5teEkcWnFjIGaQuxej2Ki+iEb9ZV6Cbc1cjFztRRA2KmLDGeIAjm3uaNwl/HzcGa
 5hQBiytLnW1nAZjmboNgRJ14nZyusMua5mnLOOXEYnOQr2xnJem6idqPoJesXK2JHi
 eB1cxDNl0zAVg==
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3086107d023so4940833a91.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 04:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746529553; x=1747134353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3MrHvmrd+LHExBNWOBLDQBkOPmra7dcHQdnAEiCTPC4=;
 b=G1bMBxFz9t1JykGh63KUpUcQH3q+aa8CsDy1/hxJeGi1JN8n/G6ZZT3V9RnCc9WASp
 rHJ/vQEYUAwJJIGcEgYeooTW7nvHXIrHMw1QUqc7sMzizQ57Li5jsRYy/9lwNoB9fsQP
 IPSzz62OF5CMEiBAIsLmx3CHVYy2FR9cfZxLGGtAG4PoCW4vvIPtG5nEFevx7pFyJEQu
 uzaBybmbXICcIj7SKkHN8JMxrm6mi6GbEBF6Dv8AFK0rEEU7xFI+sNgdLczY5lYx3yAy
 KeKCiy6c/bc9O+Pmla2Juq+L6FnqM8jWJ3ztjUpKS0jby+iUu9TgXI8/PinsIIDq4ohx
 w60Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGUauCjP6lQvhl9ctdiSZdtsK5Zm68gr2Q0tG55MQQMvShzxxAVdILYnUgZzMWn/InSsPgKjk=@lists.denx.de
X-Gm-Message-State: AOJu0YxIsR2/NyDMqVFMDU7P258k9qI9Xp6pPqLPV5QgHKkkzZVg2SWi
 eAxY2zxDRpazSVQ23pksiASxk0ShqmcaXHHemoWsnt261TGiZfYlpUWusDEOCfW3Zkve/PYN9CY
 na5t/ZIj/gDi+oie5pbCj+O19ffKDgeEQ4nb4MLfP7BiG3w1NtJjP0Gamr8lyXR++Wx5H7BBZTt
 FHQh7JFrP03CDFiW5xCk6NjppMwedf6XM+Vs+FLm1sgQ==
X-Gm-Gg: ASbGncsim3onulynx2u49ondjdf/rqA6rr5yyxpOpkEO/5GnUy2y7kDGe7fgRqyiDIe
 D2M7FSu5B5eMTQOalHF7qlTiqsaWdsRWLEtR8VnwjQI/c2SNtA84nSp7sZGj6A6Xryh7P/g==
X-Received: by 2002:a17:90b:5408:b0:30a:2162:c76a with SMTP id
 98e67ed59e1d1-30a7f32cbf2mr3347420a91.25.1746529553176; 
 Tue, 06 May 2025 04:05:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4Gie2Pc6jw46yFBhrU2UJhlsoEJhG9yK23sUOBN7IzHv1YBQ3qv1xMz+dZPvVBz39gAQ7dhPVSCdsSr4mLRg=
X-Received: by 2002:a17:90b:5408:b0:30a:2162:c76a with SMTP id
 98e67ed59e1d1-30a7f32cbf2mr3347373a91.25.1746529552663; Tue, 06 May 2025
 04:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250506092401.646595-1-sughosh.ganu@linaro.org>
 <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
 <CADg8p94crfzYzhR+jFFFRR=Xp6wY3cADXSQmKxXvVgvn9GHBkA@mail.gmail.com>
In-Reply-To: <CADg8p94crfzYzhR+jFFFRR=Xp6wY3cADXSQmKxXvVgvn9GHBkA@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Tue, 6 May 2025 13:05:41 +0200
X-Gm-Features: ATxdqUFimIJPR7bvOAPo_bu0PIQ7PcmuRuh1tUNn4y215oYI_Og53xlboxfKw4A
Message-ID: <CAM=mAO=8gP3J9Kt5ox-Gpd43s8ozZ+t42O4dBNnYV32hMS_pMg@mail.gmail.com>
Subject: Re: [PATCH] riscv: set the width of the physical address/size data
 type based on arch
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Sughosh Ganu <sughosh.ganu@linaro.org> schrieb am Di., 6. Mai 2025, 12:50:

> On Tue, 6 May 2025 at 15:19, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 5/6/25 11:24, Sughosh Ganu wrote:
> > > U-Boot has support for both the 32-bit and 64-bit RiscV platforms. Set
> > > the width of the phys_{addr,size}_t data types based on the register
> > > size of the architecture.
> > >
> > > Currently, even the 32-bit RiscV platforms have a 64-bit
> > > phys_{addr,size}_t data types. This causes issues on the 32-bit
> > > platforms, where the upper 32-bits of the variables of these types
> > > can have junk data, and that can cause all kinds of side-effects.
> >
> > How could it be that the upper 32-bit have junk data?
> >
> > When we convert from a shorter variable the compiler should fill the
> > upper bits with zero.
>
> That does not seem to be happening. The efi_fit test fails on the
> qemu-riscv32 platform, when attempting to boot the OS from the FIT
> image.
>
> These are the values of the base address that I see in the
> _lmb_alloc_addr() function.
>
> _lmb_alloc_addr: 755, rgn => -1, base => 0x1a1c0e00802000bc, size => 0x50b1
>

As you are running on QEMU you should be able to track down where the value
is actually assigned with gdb. This could for instance be a buffer overrun.

If we don't correct the root cause, it will hit us again.

Best regards

Heinrich


> The actual value that gets passed is 0x802000bc. The upper 32-bits do
> not get zeroed out. Which causes the _lmb_alloc_addr() to return an
> error. You can check my branch [1], where I have put a temporary
> commit to print the values that cause the issue.
>
> -sughosh
>
> [1] -
> https://source.denx.de/u-boot/contributors/sng/u-boot/-/commits/lmb_apis_cleanup_bisectable_v2
>
> >
> > >
> > > This was discovered on the qemu Riscv 32-bit platform  when the return
> > > value of an LMB API was checked, and some LMB allocation that ought
> > > not to have failed, was failing. The upper 32-bits of the address
> > > variable contained garbage, resulting in failures.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >
> > > Note:
> > > Although the LMB API cleanup series depends on this patch, I am
> > > sending it separately so that it gets noticed by the RiscV
> > > maintainers. Sometimes a patch may not get the required attention when
> > > sent as part of another seemingly unrelated series.
> > >
> > >
> > >   arch/riscv/include/asm/types.h | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/types.h
> b/arch/riscv/include/asm/types.h
> > > index 49f7a5d6b3a..45d806c83eb 100644
> > > --- a/arch/riscv/include/asm/types.h
> > > +++ b/arch/riscv/include/asm/types.h
> > > @@ -35,8 +35,13 @@ typedef u64 dma_addr_t;
> > >   typedef u32 dma_addr_t;
> > >   #endif
> > >
> > > -typedef unsigned long long phys_addr_t;
> > > -typedef unsigned long long phys_size_t;
> > > +#ifdef CONFIG_PHYS_64BIT
> > > +typedef u64 phys_addr_t;
> > > +typedef u64 phys_size_t;
> > > +#else
> > > +typedef u32 phys_addr_t;
> > > +typedef u32 phys_size_t;
> >
> > This matches what has been done for ARM.
> >
> > 86c915628d58 ("riscv: Change phys_addr_t and phys_size_t to 64-bit")
> > changed the definition to 64bit phys addr_t to support the 34bit
> > physical addresses (similar to LPAE on arm32).
> >
> > I don't think that we need 34bit support currently. But I would prefer
> > if we could find the root cause why the upper 32bit gets messed up as
> > this might point to a generic problem.
> >
> > Best regards
> >
> > Heinrich
> >
> > > +#endif
> > >
> > >   #endif /* __KERNEL__ */
> > >
> >
>
