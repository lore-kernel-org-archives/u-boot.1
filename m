Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C959CC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A0C487026;
	Mon,  4 Dec 2023 13:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kOraqevj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB3587078; Mon,  4 Dec 2023 13:05:17 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BE386F1C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c9bd3ec4f6so53243381fa.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691514; x=1702296314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dE5w6oxaIFbQPohWMRdfyXByNo55p69HHR/2JVLAw4I=;
 b=kOraqevjyERUXFwOgbN3nLZlcyiyG8VATfy7Op2wxVBItqHEhvuWSsxxl6jjV5FIs6
 ikIQJ546rr8zSK2JIlU3wNt2Jff1uV8FJ1i3ixUvCZCXgvV0/77eqVIM8pera5ZWV4be
 /CYJ2pFFXKmd2TB4zXtTGK/i2+QtypjVjKZEz2zbb9YjZZPUB748sabalB+aJaslgHPc
 VOhJ46FZPtY0itxOUi03DrScVleN9W9apN6FDAiLFqa35tXLXCNVwidLM0x/Y+poTyXZ
 UzDNW8jO64uF+lQcKA+bpX6ODYgs4OiBvoBs+9v1VdG+sLETEjVLPPmSW1tTHY58zbQW
 53XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691514; x=1702296314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dE5w6oxaIFbQPohWMRdfyXByNo55p69HHR/2JVLAw4I=;
 b=B2oir+9Ocp01bxTz5rvHrIQCcqn1j8vSbMdibKv6pH7D3bHziSjfVzoLYBiGuzrVD0
 4sVtLzbgp7fShzoJze1MVrHBhcovcfUiA6C4UlMP9LVZ255uL2JzxYY/gl+JELVqmb/N
 tOxW3gIi98BQ+J/1+Ck1m164v9rS7r8r5YYg5n2t6Fh6UyvRsS18GiftE5pBgaRlrOrS
 QKMwv0M22GV+KjH+W62NkZ2fdAhWgBv3UpaJWZGLWFHeZ4aAKVi/JrWQsvMuPboQrIjS
 Pq4VCGwn2S9xtO0+30siVF3AXetsFn7VMaoCqKwyQOAhIgl05WVA7I/Uhsn08jqno7yo
 vl4w==
X-Gm-Message-State: AOJu0Ywk2leoqcq4ybKmm6A7W6nW3Xs+O84U1tnod3xxNgDd5PYCspJz
 Ui0GHm8P2Z5JBxgO6Z4RNdL195DzGJEpFd9wJpR1WQ==
X-Google-Smtp-Source: AGHT+IE0TYcAZAimp+MF7IOnwcMjmYwIcE2TeR1Nd8kLm0ju8YsL/ts2YhShYrkhBJOl/hYlpKlY/JvtCeBU3OQu/m4=
X-Received: by 2002:a2e:7e0c:0:b0:2c9:ffdf:f6ef with SMTP id
 z12-20020a2e7e0c000000b002c9ffdff6efmr481992ljc.27.1701691513863; Mon, 04 Dec
 2023 04:05:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ2Os+zLWnwc03AZc69p3FCiUuJ4thncvMy8wrOeEh52_A@mail.gmail.com>
In-Reply-To: <CAPnjgZ2Os+zLWnwc03AZc69p3FCiUuJ4thncvMy8wrOeEh52_A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Dec 2023 14:04:37 +0200
Message-ID: <CAC_iWj+fZMNFkDBOLNYKh1c9oRPrg5WQrFv6nVA9NmtFcAtz2g@mail.gmail.com>
Subject: Re: EFI memory allocation
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
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

Hi Simon

On Sun, 3 Dec 2023 at 19:44, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich, Ilias,
>
> I had a bit of a look at how memory is allocated in EFI.
>
> I see that efi_memory_init() is called quite early in U-Boot. It
> sometimes allocates memory for a bounce buffer, placing it somewhere
> in memory. How do we know that that memory is free and not being used
> by U-Boot?
>
> To answer my own question, it excludes U-Boot's malloc() region from
> the map, so that it cannot overwrite that.
>
> But then, what if we use lmb and start loading images into memory.
> Won't that conflict with EFI?

Yes, Heinrich tried to fix parts of this with commit 06d514d77c37 and
we have a 'todo' in the efi subsystem for a few years now [0]
Michal (+cc'ed) has also pinged me for similar issues in the past.

>
> I also see that efi_allocate_pages() is called to allocate memory in
> the EFI code. But this just grabs memory from 'anywhere'...it doesn't
> respect the U-Boot malloc region.
>
> It seems to me that most of the memory allocation in EFI should be
> done using malloc(). Of course the boot services need to
> efi_allocate_pages(), etc., but I am not sure that the internal tables
> should be skipping malloc()?
>
> What do you think?

I think that LMB, EFI and the whole memory reservations is a bit of a
mess. Tom and I discussed this a bit in the past but I'll start
working on it.
It needs fixing, but without looking at the code first, I can't
provide any useful feedback

[0] https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/2

Thanks
/Ilias
>
> Regards,
> Simon
