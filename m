Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6A6E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F768036B;
	Tue,  7 Jan 2025 14:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qty7apVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F3D8801FD; Tue,  7 Jan 2025 14:58:16 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E804D8007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21670dce0a7so51076065ad.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 05:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736258290; x=1736863090; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eflM3z3ikv8zrzdLM8XYkWyi8teJ86g6IMqz4F5XWGA=;
 b=Qty7apVk/vGb5sFWgdRHBETiarRURunvOBjl1u+IIZ2h90NuiK7VTGFtnsvcC8/hO8
 GGm/7Tj2OJdK3L3ISKpNvQdT3eH4OOIh6SDRukRu8IOXfMsyKjoPXQzpuolpdch877x2
 UUnwGrs9IvY907/nLqMpApKQQN+M9TLCnqGa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736258290; x=1736863090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eflM3z3ikv8zrzdLM8XYkWyi8teJ86g6IMqz4F5XWGA=;
 b=UkEng7d6otfV1sUtNdgJ0M+EhKk7tVEeDI3djFTUuhUhgzEM9rQd8lB8YKxot7/0pC
 bnP+Kmf6gwUSKSlVuYvJMyDiEUt2rb0GTyXz+e7XC/lFK8zZepffpCYD/vp3s+U3jCFs
 5zI/QS4EvDjHIa7wz6tITQn5/PKbfhk5Cmf6ebLvoYM35Xbcjn7qphsCLNYySJx8QmTe
 FUgYCYxeHVJiDx3IomEtcTHOCwFJXhAJ5UScpfb+XBSuMfsgKe4ydO1roSjJm1Z6LJMG
 S0NktJuTjLTvg7ugzRsXmhezM8o2wgLg6kzBkQ6W1S8YoSMIn0dcY8SblMUq2NOCfwS8
 GMLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP6bX+MW3E4Sj3OhcMDifiuNW34y2HZTJGMJpvxtqcMDySbQmG6ufgckFHfyX0idaQc9lAleE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9xUJ31i5+q/g3BLVC5MahXIytXWX1LiCPlrxGbirpnnIvUmnF
 /8CLbmwI0RdLeQu660Zj5gWffRNWGwk+6WbA/kXhTr8dhvPOJgeFqbPfekCYApPKY5ygx4u2yR1
 vERt19Egy3bDTZqt8SvQFfiK710lVbe9J9Uvy
X-Gm-Gg: ASbGncsrXGvpe+2plCnQGmzC6sVyRhglQrYBeYnYHCsuzxO4vCiv95XGiG+37vzqy9p
 UzTxqSiMJmnsQk7QVAAxCUWQ7rDBmv17WQGvBn0Y=
X-Google-Smtp-Source: AGHT+IEhMQe4G5a0WDed83b202LHODCSNGkqqtMzgb2wXHALo/CbYGnpd553XUGlmnBUvYplgrhCkeTz8P4myb85nzk=
X-Received: by 2002:a05:6a00:44ce:b0:725:e444:2505 with SMTP id
 d2e1a72fcca58-72abdd4f4admr88204344b3a.4.1736258290372; Tue, 07 Jan 2025
 05:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
 <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
 <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
In-Reply-To: <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 06:57:50 -0700
X-Gm-Features: AbW1kvbSh4s6k2yQYnMPBFH6gPboNUmuI0XvIe4NXWNUDAoGABzxmGuavXEKzu0
Message-ID: <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.01.25 13:15, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 06.01.25 15:47, Simon Glass wrote:
> >>> This test was hamstrung in code review so this series is an attempt to
> >>> complete the intended functionality:
> >>>
> >>> - Check memory allocations look correct
> >>> - Check that exit-boot-services removes active-DMA devices
> >>> - Check that the bootflow is still present after testapp finishes
> >>>
> >>> The EFI functionality duplicates bootm_announce_and_cleanup() and still
> >>> uses the defunct board_quiesce_devices() so a nice cleanup would be to
> >>> call the bootm function instead, with suitable modifications. That would
> >>> allow bootstage to work too.
> >>>
> >>> This series is based on sjg/master since the EFI logging was rejected so
> >>> far.
> >>
> >> Yes, it was rejected because a solution at the lib/log.c level would be
> >> more generic.
> >
> > As I mentioned, that idea isn't suitable for programmatic use.
>
> What can be done with show_addr("mem", rec->memory); that log_debug()
> does not offer or which you could not do with a new log function in
> lib/log.c that takes variadic arguments?

There are asserts in [1], for example. How do you propose to handle
that? See [2] for my previous explanation, quoted here:

> CONFIG_LOG with a bloblist option would be a great idea, but it's hard
> to programmatically scan text...plus only the external call sites are
> actually logged.

Also see the discussion on the original patch [3]. There was also your
reply at [4], but I think you missed that this is intended for use in
unit tests (i.e. with ut_assert()).

You also requested that this be generalised, rather than being
EFI-loader-specific. I have no objection to that, but don't have a use
case for it yet, so have deferred that to later. It's a fairly simple
change, if/when needed. If the series was not NAKed, I'd be happy to
do it now.

> >
> >>
> >> Tom suggested not to send patches that are for private enjoyment to the
> >> mailing list.
> >
> > My contributions to U-Boot are only ever about private enjoyment :-)
> >
> > Do you have any comments on the patches?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.3054780-6-sjg@chromium.org/
[2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com/
[3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com/
[4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B11F-85958065BCD2@gmx.de/
