Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B1EC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 15:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B20805E7;
	Wed,  5 Feb 2025 16:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vD0mMzcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3CC806C9; Wed,  5 Feb 2025 16:36:00 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A5D880104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 16:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f9d5e0e365so2488986a91.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 07:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738769756; x=1739374556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=52x4CsDBcJtbjo+PJrnV5SmnLW1WWpe1Ggrpeszb874=;
 b=vD0mMzcqrsPcJvVsbkALBxtRrrhzX6To5L1l9QjrHCK8+MUpukvPNe3mF0MiIoekPr
 LCgTuCZKHu3K2473uqcWMWzLY92leC6N8hCjR6TLfFK/brOaN2OkcYP5STiVgYYizXku
 yYm3NVogAqKEGjKt9m2hsuZgoO/OIerZbvBjfpsYWDI0fUE9r+QodG2lVdLPSUdoZ8Ev
 Yr0tE1DhLhtUDudpeCnaKCW1Dns5Ow6hXQbBn/eFJXJ7NbimwUmOc+LEv4QyIwSJOJKg
 EhDDqq/u5b8kAgmparV0I/7Pc62MRdjuLJD8NDsy6jMzMqQCd9i16ysw1Zf+C7WveZMA
 LVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738769756; x=1739374556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=52x4CsDBcJtbjo+PJrnV5SmnLW1WWpe1Ggrpeszb874=;
 b=ND5mZZxzrbTSgqN1gK4Nn2de0wXf93E/2B2nM61/MCLEtrBWAVLvwYAUVSc6j25RO0
 rkFfi7Jrn1T9UAwkZ+fOZrzDfZUxwRerw+trGGLO1w7N1vsEgr7Vigw1W38+34XkJEpf
 XJIcKbcM9p6ddl10BIBSVT08qun239IMAqLtzAT+G5pgFMzguYakKMBmxuzh7HJArZv5
 Z8/BH4RaUQJxK0UTU4/SEsipaeWEcGF/A5ljpuFjjm3lLl37yxCVALTYyX06ooFvfkpD
 23WnaXr6Z7W2kYzcsi0vCxR9zLxs/lfwyakr2almTprZZML2r8PDbD3vFZwWXmdQDiyq
 oT6g==
X-Gm-Message-State: AOJu0YxfTba0lPMh2UG05YjmrjpS+DxHoWf079N9/7MFnSJ06LLXEUIB
 61MstB312AnA69hHGlDGXZq7/enmOnb24XmQ963z7dKpxYE6xPmoqmUBGIPZgkoGsu53JVryOD1
 eR8WJnaNRCkFHtLoQsO2R4QiEW18ibSThh91LFA==
X-Gm-Gg: ASbGncvb0KCH2wCXqC1fZWx0IvncDfjYkXosc0yJKzgKplulAT7NNSvBa9ihKd0KN2s
 JicdTYaGCKCXLU4q/ABtW1J3gTwXvwxxy4cnw5We6jdHLh5l+QtvVLuOc6+gPa98u0AsVw1kCt0
 OeZPkEbMFLL3Ekn6EZQoDMwespiWVo
X-Google-Smtp-Source: AGHT+IGBYyHn/5wkysFs70LMNaqhc7lGehmt0lzyNxBiXJOP+7A2N7Zo6ffSXdyPHXWn7B9yWlpuvp3p8R78t5EK4Lk=
X-Received: by 2002:a17:90b:3696:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-2f9e074d16amr4723463a91.6.1738769756636; Wed, 05 Feb 2025
 07:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-30-sjg@chromium.org>
In-Reply-To: <20250205015606.2686149-30-sjg@chromium.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 5 Feb 2025 10:35:43 -0500
X-Gm-Features: AWEUYZmnMqjEXiswcUld-lxy8q214OAOhAIG8pIsXSbgwaM9eA1CxReZjJRZ450
Message-ID: <CAEfUkUKqhf0Y9v9U9bTw0A3_odkDVpbfXLKM08qtrcdARyOsbA@mail.gmail.com>
Subject: Re: [PATCH 29/29] bloblist: Allow relocation at the end of the SPL
 phase
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
>
> Where the bloblist is located in internal memory and TF-A's BL31 blob
> removes access to this memory, the best option seems to be to relocate
> the bloblist just before running TF-A.
>
> Add an option to select this behaviour and provide a relocation address.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  common/Kconfig    | 20 ++++++++++++++++++++
>  common/bloblist.c | 15 ++++++++++++++-
>  common/spl/spl.c  |  9 +++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/common/Kconfig b/common/Kconfig
> index 0e8c44f3f74..962e7fd76eb 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1125,6 +1125,26 @@ config SPL_BLOBLIST_ALLOC
>
>  endchoice
>
> +config SPL_BLOBLIST_RELOC
> +       bool "Relocate the bloblist before existing SPL"
> +       depends on BLOBLIST_FIXED
> +       help
> +         Some platforms locate the bloblist in SRAM in SPL. In some cases,
> +         the TF-A BL31 blob removes access to SRAM, e.g. with Rockchip RK3399.
> +
> +         Enable this option to make U-Boot copy the bloblist from SRAM to SDRAM
> +         before leaving SPL.
> +
> +config SPL_BLOBLIST_RELOC_ADDR
> +       hex "Relocate the bloblist before existing SPL"
> +       depends on SPL_BLOBLIST_RELOC
> +       default BLOBLIST_ADDR
> +       help
> +         Sets the address to which the bloblist is relocated at the end of SPL.
> +         U-Boot proper uses this address when it starts up. Note that U-Boot
> +         always relocates the bloblist again as part of its own relocation
> +         process.
> +
>  endif # SPL_BLOBLIST
>

I think the relocation you mentioned is a board-specific behaviour and
should not be part of common/Kconfig if only a few boards use them.

Regards,
Raymond

>  if TPL_BLOBLIST
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 7eda94ecdf9..60c23d604b6 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -503,9 +503,22 @@ int bloblist_init(void)
>         expected = fixed && !xpl_is_first_phase();
>         if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
>                 expected = false;
> -       if (fixed)
> +       if (fixed) {
>                 addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
>                                       CONFIG_BLOBLIST_ADDR);
> +
> +               if (xpl_phase() == PHASE_BOARD_F &&
> +                   IS_ENABLED(CONFIG_SPL_BLOBLIST_RELOC)) {
> +                       ulong addr = IF_ENABLED_INT(CONFIG_SPL_BLOBLIST_RELOC,
> +                                           CONFIG_SPL_BLOBLIST_RELOC_ADDR);
> +
> +                       log_debug("Using bloblist at %lx\n", addr);
> +                       bloblist_reloc(map_sysmem(addr, 0),
> +                                      bloblist_get_total_size());
> +               }
> +               log_debug("bloblist addr=%lx\n", addr);
> +       }
> +
>         size = CONFIG_BLOBLIST_SIZE;
>         if (expected) {
>                 ret = bloblist_check(addr, size);
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index e7157df1ff9..84543691cde 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -841,6 +841,15 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>                                ret);
>         }
>
> +       if (xpl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST_RELOC)) {
> +               ulong addr = CONFIG_IF_ENABLED_INT(BLOBLIST_RELOC,
> +                                                  BLOBLIST_RELOC_ADDR);
> +
> +               log_debug("Relocating bloblist %p to %lx\n", gd_bloblist(),
> +                         addr);
> +               bloblist_reloc(map_sysmem(addr, 0), bloblist_get_total_size());
> +       }
> +
>         spl_board_prepare_for_boot();
>
>         if (CONFIG_IS_ENABLED(RELOC_LOADER)) {
> --
> 2.43.0
>
