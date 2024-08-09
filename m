Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FA6C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 16:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C028870D;
	Fri,  9 Aug 2024 18:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FhttAgJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F0088B9E; Fri,  9 Aug 2024 18:11:12 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDEB88876E
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 18:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b78c980981so12365806d6.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723219869; x=1723824669; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u+e+iDBk6mkjcRsHF47ORntCLHLj+ujTarT5qvKt43I=;
 b=FhttAgJ26TVYh+Obf2f1ajLjyiLJ64kpC3q2NwvSZz22hVW0R8yjuz9+2rMizR4GOI
 JMHZBwsiw745tKOE3atm02QkTFS9TGUB7rY738VCO5Ue5h4E8m9JiTaAvhTMSYU4TYfI
 W5kNadN1XxjimduPRDSXh9s4ejZpKhr+aE+y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723219869; x=1723824669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+e+iDBk6mkjcRsHF47ORntCLHLj+ujTarT5qvKt43I=;
 b=jhbnIQRlU8M9dVG/ts7Ms1XhqfmyE2PN6Bpj/6FFu8H93E0wycW0iXydvi4bjvJkSg
 ZkY8MBLPG6spi6dzbbDzOXq8POBMXReRz2yIa4kGfg0YtKciYgbaDqHv1mgbVPPM/l5A
 PHSc9lw5+FYtd2RWbXjI9K9zgbfOTFMgKx6TrQXmOjAeCeoM3/yVncRr/2fPB9Md5Eiy
 nO29LcYLhwfvEeW5hYKyLs7atPkgFXyN4DphyB4HqR/YZOZTHKrLhepGF06VqVSj8Wvp
 Skze/KA0ILgJv124I5TJsvFEfvUvgInvLiqYyH7Xl01Wm7WDDwhs2BEnGBKNJVkI5fAl
 PfAA==
X-Gm-Message-State: AOJu0YyKQHUd/GmoZXc/lnihE+ANmYQT3KAq7WECZZjdBNY6s0KcmAKQ
 MCPVerAL+i/VqprwhIGrm/rMK6F/ak1n1a0plNP8E7Put7TotAlcsc1Us3pSIM9nL7pZyN4NPXo
 UGYNOtWjnkVFc7i78m1AG/CVOBCmZxfTUu/zxlQYCEUjuIzo=
X-Google-Smtp-Source: AGHT+IGP/HzBIsp8YHSufDXrLILO8cv1plXNXJZrkyDTWevV/oCIenB5RqRXK01iJWBufG9zMIPJdwzXYn/AH+wmAwU=
X-Received: by 2002:a05:6214:3291:b0:6bb:99d4:e3f7 with SMTP id
 6a1803df08f44-6bd78d5563bmr22724296d6.29.1723219868723; Fri, 09 Aug 2024
 09:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
In-Reply-To: <20240801173637.1071068-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 10:10:58 -0600
Message-ID: <CAFLszTguiXRLhCApXTX__KoD3a==cyKRVMXyu8NFtYbk1N2k-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] efi: Start tidying up memory management
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi,

On Thu, 1 Aug 2024 at 11:36, Simon Glass <sjg@chromium.org> wrote:
>
> We have been discussing the state of EFI memory management for some
> years so I thought it might be best to send a short series showing some
> of the issues we have talked about.
>
> This one just deals with memory allocation. It updates EFI to use
> U-Boot memory allocation for the pool where possible. Most functions use
> that anyway and it is much more efficient. It also avoids allocating
> things 'in space' in conflict with the loaded images.
>
> For v2 I have dropped patches which are not germane to the main idea.
>
> Note that this series is independent from Sugosh's lmb series[1],
> although I believe it will point the way to simplifying some of the
> later patches in that series.
>
> Overall, some issues which should be resolved in future are:
> - allocation inconsistency, e.g. efi_add_protocol() uses malloc() but
>   efi_dp_dup() does not (this series makes a start)
> - change efi_bl_init() to register events later, when the devices are
>   actually used
> - rather than efi_set_bootdev(), provide a bootstd way to take note of
>   the device images came from and allow EFI to query that when needed
> - EFI_LOADER_BOUNCE_BUFFER - can use U-Boot bounce buffers?
>
> Minor questions on my mind:
> - is unaligned access useful? Is there a performance penalty?
> - API confusion about whether something is an address or a pointer
>
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=416441
>
> Changes in v2:
> - Drop patch 'Show more information in efi index'
> - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> - Add the word 'warning', use log_warning() and show the end address
> - Reorder patches a little
>
> Simon Glass (3):
>   efi: Allow use of malloc() for the EFI pool
>   efi: Convert device_path allocation to use malloc()
>   efi: Show the location of the bounce buffer
>
>  common/dlmalloc.c                        |   7 ++
>  include/efi_loader.h                     |  18 ++++
>  include/malloc.h                         |   7 ++
>  lib/efi_loader/efi_bootbin.c             |  11 +++
>  lib/efi_loader/efi_device_path.c         |  43 +++++----
>  lib/efi_loader/efi_device_path_to_text.c |   2 +-
>  lib/efi_loader/efi_memory.c              | 110 +++++++++++++++++------
>  7 files changed, 148 insertions(+), 50 deletions(-)
>
> --
> 2.34.1
>

Are there any comments on this series, please?

Regards,
Simon
