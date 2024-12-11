Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A57E77182
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330AC8031E;
	Wed, 11 Dec 2024 16:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P4z9DIKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1176980327; Wed, 11 Dec 2024 16:53:48 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D73580303
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21661be2c2dso25762945ad.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733932424; x=1734537224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VlxQ4XhSY+yDlWScgh6PQKhXUIiSUxEAIJsCuauipqM=;
 b=P4z9DIKlIpAwc9lKDT88TzhYP4P0ifi4isehVC7hNdoImSgjnFUZXanx2ZUH/sJ/b6
 Kx/RsCOx8IR4a+u+uekUUTlvg7VR1cLg2tm8VnLtbUwHb5jxOnh8FxiRPZq3h9pvBtq8
 e0ckjvRddS+8QmGHi1QKRkeFjmEAlbZygKEnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932424; x=1734537224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VlxQ4XhSY+yDlWScgh6PQKhXUIiSUxEAIJsCuauipqM=;
 b=D8v3HeiNHgWKQZVjfsk6EebSfkwPFJjU7rfjjWafE8VuVN34MGy8vQDtnVLd6c3DzF
 sTgx/fW3jRK8ZRt947tzjuIhAgvUZg24O+NoISS9rlkka4+vRRXZUW1FVxXTxfiKuYof
 f6H/zofbkDEUA1ktBcqHXL9XSKoXnBmxn1wE6VxF95PORZ9vPwGT+u4nfG6opbHKvkQI
 sJu6GcDwgQOGZYMpa7EHaxvqOIvnVBbJuvYNjomt/azKD3rkjrTpXIPoZM6VAJGggmhi
 lw2I9cLjuaB9z3dDHiviggZ9vNCGDwm8m5zYTTa+w66EXOONof5ChO1ACpQCF/isWwAx
 M9+w==
X-Gm-Message-State: AOJu0YxfCDc+wBLDrXT8rf9zC+RFGHECQgvQV2D8+Bn8wsAtohzdUCtE
 hYE60MD35XSw4PKdACAfzOyvbpoSjaJcNBuwWKhpZyz5mdBqL+jY4yn0i1qJd+XKiMH9OtP48rU
 zM8+YKxapmngU9UM6UKWdUqw7BrzD9Imvnff3
X-Gm-Gg: ASbGncs5qGNm4R514yANO8vAswMnuWeUmyiFuWtmqmvfdV22gF62289OL55TNFFjDkt
 uzdH2JfnFfXKL6e9wD6BapffnKlQAHgniCxkN
X-Google-Smtp-Source: AGHT+IGYsyRjDSQB04SITWywSNUbpo2Dl5KXJMj70ys3QW2e0Xqp+1j1YZR/e9dPONrbjaqPY3GfaVPsYBkbsouGDNw=
X-Received: by 2002:a17:902:e847:b0:20f:aee9:d8b8 with SMTP id
 d9443c01a7336-2177851f98bmr52905885ad.20.1733932423978; Wed, 11 Dec 2024
 07:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-2-sjg@chromium.org>
 <CAC_iWjLhpi5Wmd8569vgRP3O=CSoQUgLAaOYg7LyY_iOHG+U5A@mail.gmail.com>
In-Reply-To: <CAC_iWjLhpi5Wmd8569vgRP3O=CSoQUgLAaOYg7LyY_iOHG+U5A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 08:53:27 -0700
Message-ID: <CAFLszTj2-Bse1wgzBX__5wH0FOdgC=N11faSHBKg8-T5+G2-ZQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/23] efi: Define fields in struct efi_mem_desc
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Matthew Garrett <mgarrett@aurora.tech>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Ilias,

On Wed, 11 Dec 2024 at 07:45, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> [...]
>
> >         u32 reserved;
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 39809eac1bc..ee0cdd36500 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -788,8 +788,10 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
> >  /**
> >   * efi_add_memory_map_pg() - add pages to the memory map
> >   *
> > - * @start:                     start address, must be a multiple of
> > - *                             EFI_PAGE_SIZE
> > + * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
> > + * is actually a pointer provided as an integer. To pass in an address, pass
> > + * in (ulong)map_to_sysmem(addr)
>
> Why is this a pointer? This is the physical address of the hardware.

The distinction between pointer and address is to make it clear
whether you need to map_sysmem() or not. That is the purpose of this
series - to clean up the confusion about translating back and forth.
There definitely is quite a bit of confusion in the EFI_LOADER code.

Generally in U-Boot ulong is used for an address and void * for a
pointer. In the case of EFI_LOADER, the original author may not have
been aware of that. Incidentally, it was also written without sandbox
support (which I added) and tests[1] (which Heinrich added).

If you like we could arrange a call to go over how sandbox works with memory.

Regards,
Simon

[1] https://lore.kernel.org/u-boot/7fbaabab-5d82-4670-eab6-edb9d27f0bb9@suse.de/
