Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511D9D2C122
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D2A18919A;
	Tue,  5 Nov 2024 16:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cuorJhng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D6B0891B2; Tue,  5 Nov 2024 16:13:12 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2110B88F77
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so8389529a12.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819589; x=1731424389; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sK7vgpJI0KK9cVJYOgduJx5nvuAmCipysoyL8Rww5/8=;
 b=cuorJhngk4AkBOAaeAhw4Nwbwg8Jlj/sjw//e/6eaFRru7vuOw1AbualBRl/eVxM4A
 MyDUpbHQVn7LwbnKdMT2puRps2Fn4fxu5DvUKZ0BXkxUzTkqxYLAssD55eYlsSG68q5G
 kslCITqbZcnxBtu3Nr1/Jhq3v21gCqLvO5Ycs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819589; x=1731424389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sK7vgpJI0KK9cVJYOgduJx5nvuAmCipysoyL8Rww5/8=;
 b=eVdVyQzEGWoK8nr1/zHPuR5mc6JzzYa5Rp6gsMiFm7OfT98Q3/r0H3qqOIXWaECtpO
 vmHzhXnzkX9O0VRSQip2tkEdEixXuZX3xK4/ggmq1vIoiHPn2Ep6897lbMUyT31maHsf
 A/01ToriD13l7UhJjN2W8b1DEgM5CFm4pYiKqQEXoXT82BH/2a+oqJHF3aENjNTsuOwt
 bw2DCwchGEumLiRPPyisdJKCtMwC5TwZIJMmE6aaSXAYuNVG9ME20FHtIn6Hcmb0YUoF
 6f+n5bP1fRXueZ562xrfFBcTpjRhKjdPSH2e4JxbgD8MvUH0NCekmd3nvLJ5V5UlZpLQ
 aVrA==
X-Gm-Message-State: AOJu0YxXlrH1u0MuWPIocT3cOhX+v2vitUl5Qhz9n4PAGAe69TdLt0M0
 9LJnDmVDmsytxLwx68RphDRJR4E/7Q+gyOf8P5E/L/EhZv3AmimKMNzVS4Wn+kQF3zvXnD/Jw0w
 I081wICWkCydcVHzz1BgIjpajvB8zi+ZjFpYJ
X-Google-Smtp-Source: AGHT+IEw4+7mDNf2HadfNh3bnsIDCIj+PGDFkUybIwZvlIUTBU9zqeG0wasAjcv4NE7wBwv5F5NVve5gBwHfomJfbzw=
X-Received: by 2002:a17:907:9728:b0:a9a:4597:a7f3 with SMTP id
 a640c23a62f3a-a9e3a7f435bmr2441484666b.62.1730819589481; Tue, 05 Nov 2024
 07:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-2-sjg@chromium.org>
 <183A3E20-0AA1-4E07-A376-5BE270080357@gmx.de>
In-Reply-To: <183A3E20-0AA1-4E07-A376-5BE270080357@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:12:57 -0700
Message-ID: <CAFLszTig+U0f9eHOOzkRUfcv2BcjWSG+xk10Oe+JWw_5FvGH1g@mail.gmail.com>
Subject: Re: [PATCH 1/9] sandbox: efi_loader: Correct use of addresses as
 pointers
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Mon, 4 Nov 2024 at 13:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 4. November 2024 14:39:45 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >The cache-flush function is incorrect which causes a crash in the
> >remoteproc tests with arm64.
> >
> >Fix both problems by using map_sysmem() to convert an address to a
> >pointer and map_to_sysmem() to convert a pointer to an address.
> >
> >Also update the image-loader's cache-flushing logic.
> >
> >As discussed some time ago, it would be good to update the way
> >EFI_LOADER uses addresses and pointers, particularly around memory
> >allocation. Ideally we would use addresses internally, with pointers
> >only exposed via the external API, even where pointers are in fact
> >u64 values.
>
> No, we should get rid of sandbox virtual addresses where possible, e.g. in LMB.
>
> They are are only relevant for the sandbox's command line interface and device-tree.
>
> This will minimize the number of conversions, which only satisfy the needs of the sandbox and have no relevance on real systems including QEMU.
>
> Do not wag the dog with the tail.

For now I'll just remove that comment from this commit. We use ulong
in U-Boot for addresses. Everything works fine and we only get in
trouble when we use a ulong as a pointer. Let's discuss this in more
detail at some point.

>
> Best regards
>
> Heinrich
>
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
> >---
> >
> > arch/sandbox/cpu/cache.c              |  8 +++++++-
> > drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> > lib/efi_loader/efi_image_loader.c     |  3 ++-
> > 3 files changed, 20 insertions(+), 9 deletions(-)
> >

Regards,
Simon
