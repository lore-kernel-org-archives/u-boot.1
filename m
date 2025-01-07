Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF421E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 251E1801FD;
	Tue,  7 Jan 2025 13:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hffomTaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14182801C3; Tue,  7 Jan 2025 13:15:20 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79F49801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so1946104366b.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 04:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736252115; x=1736856915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xz8ewH5aZV6gU1sZopVWzC+Hg6uWqAvZsAOkD60wNCU=;
 b=hffomTaCQNh2YHY/DynNbJ8HJ7tFxastrk4kgaVzkezix+LDCnOXKPEVLqkCo3ZfIG
 k7klSR2wRkcEBbUSNgz0KmvwzjBZQEGUjaxtgbOOEAPeMoOiQA7aRsgMo1tmSOX5HLMP
 wLS+vgSrV6cNUVRJEESG5Lqipr0+l3V9kxhSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736252115; x=1736856915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xz8ewH5aZV6gU1sZopVWzC+Hg6uWqAvZsAOkD60wNCU=;
 b=pHVRN6ofoTqa3zhf1Ar/ez2IfVGAVoR/wctCmfQWn/GuxneJb9LxONWFer0yd4U3eA
 iMCWQGRnVSajNTKGzSW0ktReYe14kGsyIgWTeY1cANnXVvemJugxF6xn2mPuQfrxzdWt
 ZxbWHb/cU9QDBfkBO6iFmRzegniSunkSfie8B/tTFfJszemaIBceepRdxr1g0YTZ5G9h
 YA0GE75YDYAx3J8gfb6pJb2ckISjmYD5SugwtQuh0+Io1FA3x8o8ZhmQfen7bVRIxdPT
 thzaNygcjbG64Ganf1aK+sf9dvYUxfEeXFcYsFvwRW9x5iCOPBCdNJZbWz9KpnLgQXlg
 h/Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1GI9TVzEvI4wN4urR+CeowNewoaXT+MdK3ISvrXhY7ILkBggBvYcUKbSPuG8iRCzO68nuIiE=@lists.denx.de
X-Gm-Message-State: AOJu0YyI2tPSyFUMZ4UsVhl5PChReYCR0kv2ExQ4NJpyd8hBOoR5WaoN
 B+VJQ/HmHLclVJxC9HFbcUTXRvMiSLlw1Rd5bJPaLlZud8H58bqkMqN+lmSXeHCg68EXeBRoQQq
 MZga4uRxGYSdmh95TcTNLcmnI7UxCaCwZzQmu
X-Gm-Gg: ASbGncuAHTBdmsioHLRLWQI+wEZ2ULuMAZ3bjPNN2DriMeb3eYHvpxhbRP0wZ14CT2l
 pLTZFQJWdVwWYOaZLnVaZdbhonQHUCv+Vs4CJqg8=
X-Google-Smtp-Source: AGHT+IHWaxXVWgyVK4q/50cI8olCpuEoA0ui3oK7ycOnyhbAs86aM8YBD+CW8l+b0pfXq4jAPz0PVGnfC5cN6D6Ehuc=
X-Received: by 2002:a17:907:60d6:b0:aab:daf9:972 with SMTP id
 a640c23a62f3a-aac334c0ba9mr6102498966b.28.1736252114812; Tue, 07 Jan 2025
 04:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
In-Reply-To: <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 05:15:03 -0700
X-Gm-Features: AbW1kvZziKYIrtdT8fzQl_L1tEgxsV-9Gz0X_g0VgqEPArEYeaLpQLcQXmN_FeU
Message-ID: <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
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

On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 06.01.25 15:47, Simon Glass wrote:
> > This test was hamstrung in code review so this series is an attempt to
> > complete the intended functionality:
> >
> > - Check memory allocations look correct
> > - Check that exit-boot-services removes active-DMA devices
> > - Check that the bootflow is still present after testapp finishes
> >
> > The EFI functionality duplicates bootm_announce_and_cleanup() and still
> > uses the defunct board_quiesce_devices() so a nice cleanup would be to
> > call the bootm function instead, with suitable modifications. That would
> > allow bootstage to work too.
> >
> > This series is based on sjg/master since the EFI logging was rejected so
> > far.
>
> Yes, it was rejected because a solution at the lib/log.c level would be
> more generic.

As I mentioned, that idea isn't suitable for programmatic use.

>
> Tom suggested not to send patches that are for private enjoyment to the
> mailing list.

My contributions to U-Boot are only ever about private enjoyment :-)

Do you have any comments on the patches?

Regards,
Simon
