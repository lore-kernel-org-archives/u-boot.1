Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF16D11101
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 14:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5191D88EF5;
	Sun,  3 Nov 2024 15:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fToVLpUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF319890E9; Sun,  3 Nov 2024 15:46:52 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507EB8862E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 15:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so41439685e9.2
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 06:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730645210; x=1731250010; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AE+3QafnLhsG9pzcICi/kX8Zsp8yOSrPyUS0UKBHGhc=;
 b=fToVLpUDnzVyrJ7fnSErlDJdQe4IK6mc5BVQPyan3X73wrS+RIPapLCp6Ehh/jFSHE
 DrEXF60jUZEjXlWhjM9hoF2kZ9c01eX0vLHayvBk7HFKYH4g8cKLlYXf7fC0pabl1x1N
 /Z48WfW5vzK47dOkBdZqgyUMJ57pKZ10ZH1eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730645210; x=1731250010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AE+3QafnLhsG9pzcICi/kX8Zsp8yOSrPyUS0UKBHGhc=;
 b=vomyziojrRwEN9u3C7hDnT+YCkae1y6CILZjaRh2qFZNmR3EiJB7gwYlz9wXTJnVF5
 gh4Z2p6lJBpyzJ5YB9eoXt3fOBOjkKCuG7me7yqgvG8CqnRuhMLPcfVFhoK9R1f7yjc5
 lJKK83hqBQh9TY0QEz3OfgFp/YygaI/EzgqL/m+2VhnGCfRNy7NESH+XILxXqJZENBrj
 SPrc31yLQMSJsxCWNBqoszAiQLoYgmHiwmhzUfJ/4FnhHIbHeKpaiT6c1A9KnmyZ5QFb
 HzdgBgkp03MKDPovd3v55r+Euww/Jk4F+6NF7Qve0ai2uQ9WzrIa/xyvzaiDtin6N2T6
 Y++Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwI2sdq4r3wfTjNOXDpWK0OV6Uk8aYVKD8M0dQ9EEh76LgjSFihuFLGZrevNQJjywJxa3+j38=@lists.denx.de
X-Gm-Message-State: AOJu0Yxakbj84hRYmXQNTNYpbRR+URbkDlXBq4quSwBmPOEVr4DVHTih
 ziX3NHcPVBurfJm0tBQHmnv8Q0eju/ltUdpAkF21lnooCkaSBdalHe3EPXEhdovfHRPb7oAY1KZ
 FgexJLRkRu4Sf7K9RYimZfE8CgPS4EuagnOrF
X-Google-Smtp-Source: AGHT+IHsRHqTE7Jejc4OTVQkbOYAtEJbcoSF17bCYK22lbtGTws8BX7detpBmwiKAKqmREr3BkEbox6YcYDLSx7lI8M=
X-Received: by 2002:a5d:64cb:0:b0:37d:51b7:5e08 with SMTP id
 ffacd0b85a97d-381c7a5ce0bmr8705477f8f.18.1730645207618; Sun, 03 Nov 2024
 06:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20241103002828.624931-1-sjg@chromium.org>
 <20241103002828.624931-5-sjg@chromium.org>
 <bf24a9c2-31fc-4768-80d5-b2a4dea5cc35@gmx.de>
In-Reply-To: <bf24a9c2-31fc-4768-80d5-b2a4dea5cc35@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Nov 2024 07:46:35 -0700
Message-ID: <CAFLszTgPC7mSuhyYcguSWsWPGwbMTPy0iArGvyCM3L4GsXcEoQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] efi: Drop the memset() from efi_alloc()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
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

On Sun, 3 Nov 2024 at 01:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/3/24 01:28, Simon Glass wrote:
> >  From my inspection none of the users need the memory to be zeroed. It
> > is somewhat unexpected that it does so, since the name gives no clue to
> > this.
> >
> > Drop the memset() so that it effectively becomes a wrapper around the
> > normal EFI-pool allocator.
> >
> > Another option would be to drop this function and call
> > efi_allocate_pool() directly, but that increase code size a little.
> >
> > Move the function comment to the header file like most other exported
> > functions in U-Boot.
> >
> > Comments were made in v3 that another project uses memset() when
> > allocating memory, but that is not required by the spec. In any case, as
> > above, from inspection, none of the users need the memory to be zeroed,
> > as they fill the entire region with their own data.
>
> As already written in response to v3 of the series I want to be sure
> that code that runs on EDK II does not fail on U-Boot.
>
> EFI_DEVICE_PATH_UTILITIES_PROTOCOL.CreateDeviceNode() in EDK II zeros
> out the returned buffer. We implement this function via efi_alloc().
>
> Here is a code example relying on a zeroed out node:
>
> https://github.com/acidanthera/gfxutil/blob/5284a662181ff4b81dd19d1279aedb68725b827f/edk2misc.c#L215
>
> Please, drop the patch.
>
> I have created issue USWG 0002487
> https://mantis.uefi.org/mantis/view.php?id=2487) asking to indicate in
> the specification if the returned device path node should be zeroed out
> by the firmware.

OK thanks.

But please ignore this patch. The whole series was sent by mistake.

Regards,
Simon
