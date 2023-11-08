Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28189C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436048772B;
	Wed,  8 Nov 2023 05:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g395yNcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34A587723; Wed,  8 Nov 2023 05:26:53 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD5987722
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5b383b4184fso78064857b3.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417608; x=1700022408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bJoR2HFzTxXWYDpoXYTI4EQWNTv/B4xnx/3VK0Xa5NY=;
 b=g395yNcE2pv2ivpNbAeklofy23k6joZxnuDc1tBfyMbwpM7t5to2IM1wfWdUVTt9Z5
 DDpdES/rT/SyLES6VSVhGuA8whfzyyxWvzaMqDeiGp7SilOR7FhFTLNBWVwYDkw9I6TG
 NcBRZRAz11BvZzRb7eXx8BsbH1xB1QtZY5Gfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417608; x=1700022408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bJoR2HFzTxXWYDpoXYTI4EQWNTv/B4xnx/3VK0Xa5NY=;
 b=cemyET0LmvWUgaRcHBVb1e07qTYzjSKSZ8ekCnPn6+SUs1F1dOHQGnWFMbgb0mLO7R
 FM4aLzvdauFUyNRf138INYLiftu6Jcm53CoD/eqSzypqZGqHsr0G2osVLWiX7bTj8R+m
 E60m0LwwPTs54ClHpPoUyzbcCnIgjBPpTngZAjFoOxZWE2gFUWVpwg04IA5Z9g/wwER3
 k/fbyxRCz+0Z6mzVp52FFPYKxS9c3heLza05hSnvkKCn6RbetB2K3s4QeBWkBhsmEviH
 FcOmemyk7Oaqg1TZ1uWVLm2yve0cfrFV01fWZlJTjDuN2ymyVONF95IKqq/mO2ODWGPO
 gH7w==
X-Gm-Message-State: AOJu0Yzvyiy6cXuEhVMvtvDsGaeIyD8Nl2Nte5EG8DEwG0ppoSbT8Y1b
 sWsORHBJDHVkI9RjV8SUrwsVNSRXR4Mb6+FUzIuNMg==
X-Google-Smtp-Source: AGHT+IHdtKvZBxdaB1ZbX7Ajdb7SOOIKqEMfmIFk1mlcLDDjnxmQSu27JzQn6XvJHHrL9BQ2R12xsZkC7R56SEUkbHg=
X-Received: by 2002:a0d:dd88:0:b0:589:b3c6:95ff with SMTP id
 g130-20020a0ddd88000000b00589b3c695ffmr646643ywe.36.1699417608081; Tue, 07
 Nov 2023 20:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-21-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-21-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:07 -0700
Message-ID: <CAPnjgZ1_vLRpHRjS9B2W=FxLAG=9g373A++hYtjdtBuCqcyhgw@mail.gmail.com>
Subject: Re: [PATCH v6 20/25] spl: Convert nor to spl_load
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
> This converts the nor load method to use spl_load. As a result it also
> adds support for LOAD_FIT_FULL. Since this is the last caller of
> spl_load_legacy_img, it has been removed.
>
> We can't load FITs with external data with SPL_LOAD_FIT_FULL, so disable the
> test in that case. No boards enable SPL_NOR_SUPPORT and SPL_LOAD_FIT_FULL, so
> this is not a regression.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - Fix LZMA support
> - Fix load address
> - Explicitly initialize load_info members
>
> Changes in v5:
> - Rework to load header in spl_load
>
>  common/spl/spl_legacy.c   | 61 ---------------------------------------
>  common/spl/spl_nor.c      | 40 +++++--------------------
>  include/spl_load.h        |  1 +
>  test/image/spl_load_nor.c |  2 ++
>  4 files changed, 10 insertions(+), 94 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
