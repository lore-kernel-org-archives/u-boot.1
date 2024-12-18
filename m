Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117E2E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 11:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8258021A;
	Wed, 18 Dec 2024 12:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BUoYAdzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E25880243; Wed, 18 Dec 2024 12:49:48 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C4680214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 12:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6f14626c5d3so50218247b3.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734522585; x=1735127385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BOPJhqNtEyTjPBxSt54J0Y3+t1zVsG5bE/mmiuZ0xMU=;
 b=BUoYAdzu/bZjxU/j+Ng+0pYBv4emHPMkJhBoeh/J8CheEXzMdcib4muqWtPUSK22kw
 kGapgyL3Jj61vT1ICgvQ5V5h5vTdH1gJUPI7V0dMFbkLJTWiZqDRKKf8quqmi0j7gbup
 tWfThgWzxGJy/lcW6Tgi2zABRBlZiztf5TdBUsihUTbTxPZsbcClSHNg1ZgRU4zz3TDA
 /aZQF07rHgbMOphooIOq+FoJpjdVzwG3QwWw2+xVn3JuPxkCsVxMhthis0L7AcAAOv0V
 O0TbX1NQmDv/HFN8w1C2UNL3c2/HTgvBFEqwyk7hjQvyJo9fHp5G8ZC258D/iO0l7gxt
 DulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734522585; x=1735127385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BOPJhqNtEyTjPBxSt54J0Y3+t1zVsG5bE/mmiuZ0xMU=;
 b=pzfp9jjBTJpfqLCLGh3vY2rneYZR1M+RDTTmRUA194C6uZPuroIWXpPVCTy9qB+cOj
 EZ24iK52JWHwp92yo4LhQ/6KWN6yZmCxiJ53MsWNnL8cVy14kpn7U58NB/OC+g7dAXX4
 DPjeJSu+q737yz0YT9PRbbRT+ppnLoTEaWG3dupZv1hNCx748DFZZCO57oJIVZjnbiuH
 xaTAvVRSmNFpaOjj5bq8fLqm+MAN3gWpe7eD69QsG4J0vezthHaObyiMKq/HNee+aiZf
 3qWXMM5iAJ8m1BHt7mIMIGgoVxhGzrg/oyCZdAA1pS+ikTxIuAjUWf1HlfozrgMdmc1L
 iLsQ==
X-Gm-Message-State: AOJu0YxGLUq3DviYOihW8q/8TGYC+F5vJX2ftxGyKlLiMe8G6/kKNQHA
 tNmSzePV7AWX6OYqra6q1DKe+NREWmQdT+lx6iUZ9XZU/bcezNWHqg2oHMFkUOTvUOyv18mR9+y
 GBdWUVNvDgCSaSU5VwnytbuEFKxM2LwrZUcjnpw==
X-Gm-Gg: ASbGnct1MyXQeOFxapFEgbrWdPnymE8LEXiF3qC5I8DzanGQCoeVXoI72ZJOJLTnQ7k
 vBjUU0qY4xNyD5XfVj6xFMtdYnt1OAhgKZSbfIA==
X-Google-Smtp-Source: AGHT+IG9m3m7ARyGX4t8jfG9VptiEOtH8/Aa0IpTMZxcUj8Fb81eeF7SqmliOwf2x2pZgEcRlciRwzf3sT/Nc6BohYo=
X-Received: by 2002:a05:690c:ed2:b0:6e9:e097:718c with SMTP id
 00721157ae682-6f3ccc29cb9mr14682937b3.6.1734522584722; Wed, 18 Dec 2024
 03:49:44 -0800 (PST)
MIME-Version: 1.0
References: <96e9c80aeeed4e9664858bf236476997d17a9914.1734522042.git.michal.simek@amd.com>
In-Reply-To: <96e9c80aeeed4e9664858bf236476997d17a9914.1734522042.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Dec 2024 13:49:09 +0200
Message-ID: <CAC_iWjKXineo=kPm_4pCx3FRf0P8R83K66p+m_+Ptg4-kZaBpQ@mail.gmail.com>
Subject: Re: [PATCH] zynqmp: Remove usb init initialization for Kria
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Love Kumar <love.kumar@amd.com>, 
 John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>, 
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

On Wed, 18 Dec 2024 at 13:41, Michal Simek <michal.simek@amd.com> wrote:
>
> USB hub initialization is done by driver introduced by commit 09f557e106ef
> ("usb: onboard-hub: Add i2c initialization for usb5744 hub") that's why
> there is no need to do initialization via variables.
>
> Reported-by: Love Kumar <love.kumar@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  board/xilinx/zynqmp/zynqmp_kria.env | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index ff3a0924de7d..b0c2ac6f2e86 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -62,14 +62,8 @@ bootmenu_0=eMMC Boot=run som_mmc_boot
>  bootmenu_1=SD Boot=run som_cc_boot
>  bootmenu_delay=5
>
> -usb_hub_init=mw 1000 0056 && sleep 1 && i2c write 1000 2d aa 2 -s
> -
> -# usb hub init
> -kv260_setup=i2c dev 1 && run usb_hub_init
> -# usb hub init
> -kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
> -# usb hub init with enabling PM nodes for ...
> -kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
> +# Enabling PM nodes for uart0 and can0
> +kd240_setup=zynqmp pmufw node 33; zynqmp pmufw node 47
>
>  tpm_setup=tpm autostart;
>  tpm_reset=echo "!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!";
> @@ -79,7 +73,7 @@ tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
>  board_setup=\
>  rtc dev 0; \
>  zynqmp mmio_write 0xFFCA0010 0xfff 0; \
> -if test ${card1_name} = SCK-KV-G; then run kv260_setup; run tpm_kv260; fi;\
> -if test ${card1_name} = SCK-KR-G; then run kr260_setup; run tpm_reset; fi;\
> +if test ${card1_name} = SCK-KV-G; then run tpm_kv260; fi;\
> +if test ${card1_name} = SCK-KR-G; then run tpm_reset; fi;\
>  if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi;\
>  run tpm_setup
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
