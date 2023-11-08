Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE068C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6445287733;
	Wed,  8 Nov 2023 05:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OViLNJpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5B48772E; Wed,  8 Nov 2023 05:26:51 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743B4874E9
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5af6c445e9eso77072877b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417608; x=1700022408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zl9sp4w/bQomwTvDMQ23OcWffEuY2KOdb2pxaVRLuqs=;
 b=OViLNJpMRfp2oabprVVlvtf3gLgbvZCFuH8GfxZbz5mJ5EFKLHcYNjmTt4t0ndlbAP
 cxqSNIpoMJLKct4WMxTo4Wh7CGjNoEaU94lfNx2BUQgc8Bgg1If5cvZDcr4SX+cO9tDS
 8jNpSCjcZa9VMFhM1R1aH5hhPemKxewJP5XwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417608; x=1700022408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zl9sp4w/bQomwTvDMQ23OcWffEuY2KOdb2pxaVRLuqs=;
 b=izLBV3LDFFPRfDsr3R8xx1XUFsOuxxVNIppwuvTo32rXzPnF9lZSrVx40CGVy2g8b8
 mlYqI1aGrinn3SSCZCrSwp+7GFk7wk5D4HbScNt12Zj1bNwH9Bs/vj6GS3Fefoffk6oh
 pcwm8lWSfGN9+E4/yG9jlwAZ2K6HX2kWM8lJQOpVsnhzKpbUm1+pZUvAB+CoptzEWNqc
 h7nR/zN+NQG7Ne6LT3Yl/hIu5XWAv2V+pucNDyzUx9v0MRX3Bb/yelLlMM3NWBudLugo
 avUfiVXDAHEbwE1UG2rK/3tuKctVxarO7DKC6UhS2MwrGnxNX8xjLMx4sKFqycs59n0y
 xYiw==
X-Gm-Message-State: AOJu0YygshTs+/WSp8h617yBGoJ9Jlh0JPc3yFO6VHqb7zd3gaAfkUwy
 +L1E0bh8snDIKb6uCSKt+z2N73QDD22D93ggvVBnxA==
X-Google-Smtp-Source: AGHT+IFu5eQ/oWpZAA3ZNqSui2k2aGTm86zzyFl/sCT5nm/mJajz51Sjd7RVwj+JWKXDphc3L2Uy3C0x/2InVxSm7yw=
X-Received: by 2002:a81:a011:0:b0:5a7:bfbf:691d with SMTP id
 x17-20020a81a011000000b005a7bfbf691dmr737713ywg.42.1699417608077; Tue, 07 Nov
 2023 20:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-15-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-15-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:58 -0700
Message-ID: <CAPnjgZ3AquFrnMELwGHAyh7i3yRMKndzyitcLX-5Q0uCc8RPvQ@mail.gmail.com>
Subject: Re: [PATCH v6 14/25] spl: Add generic spl_load function
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> Implementers of SPL_LOAD_IMAGE_METHOD have to correctly determine what
> type of image is being loaded and then call the appropriate image load
> function correctly. This is tricky, because some image load functions
> expect the whole image to already be loaded (CONFIG_SPL_LOAD_FIT_FULL),
> some will load the image automatically using spl_load_info.read()
> (CONFIG_SPL_LOAD_FIT/CONFIG_SPL_LOAD_IMX_CONTAINER), and some just parse
> the header and expect the caller to do the actual loading afterwards
> (legacy/raw images). Load methods often only support a subset of the
> above methods, meaning that not all image types can be used with all
> load methods. Further, the code to invoke these functions is
> duplicated between different load functions.
>
> To address this problem, this commit introduces a "spl_load" function.
> It aims to handle image detection and correct invocation of each of the
> parse/load functions.
>
> Although this function generally results in a size reduction with
> several users, it tends to bloat boards with only a single user.
> This is generally because programmers open-coding the contents of this
> function can make optimizations based on the specific loader. For
> example, NOR flash is memory-mapped, so it never bothers calling
> load->read. The compiler can't really make these optimizations across
> translation units. LTO solves this, but it is only available on some
> arches. To address this, perform "pseudo-LTO" by inlining spl_load when
> there are one or fewer users. At the moment, there are no users, so
> define SPL_LOAD_USERS to be 0.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - Use pseudo-LTO for spl_load
> - Align reads to bl_len
>
> Changes in v5:
> - Load the header in spl_load as well
> - Don't bother trying to DMA-align the buffer, since we can't really fix
>   it.
>
> Changes in v4:
> - Fix format specifiers in debug prints
> - Reword/fix some of the doc comments for spl_load
>
> Changes in v3:
> - Fix using ffs instead of fls
> - Fix using not initializing bl_len when info->filename was NULL
>
> Changes in v2:
> - Use reverse-xmas-tree style for locals in spl_simple_read. This is not
>   complete, since overhead depends on bl_mask.
>
>  common/spl/spl.c   |  10 ++++
>  include/spl_load.h | 135 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 145 insertions(+)
>  create mode 100644 include/spl_load.h
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Definitely a lot of effort on code size!
