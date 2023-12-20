Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89669C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD62871A7;
	Wed, 20 Dec 2023 05:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WQ680DWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A1F8749F; Wed, 20 Dec 2023 05:45:59 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005A4870B7
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54bf9a54fe3so6502504a12.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047556; x=1703652356; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M9nbNxn+kxMu9rQDI3RCWd+bAsZFHodZtwJ/+q6OqAY=;
 b=WQ680DWKYjKkCn9guGl+fgaNxdg+Xq0BMrkI3JLTRqvNsLKFu8ViclnY+orW5H8j+s
 mDrUxjSMudoeOkzVwK1ntTdEDnxp/YltJxAEtAYAjVS9QXv7WuQXUJ2N97f+7T2FWiIr
 //1skJ7kwgtdzISfuWyj1b1q1fmn/RDGlGyh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047556; x=1703652356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M9nbNxn+kxMu9rQDI3RCWd+bAsZFHodZtwJ/+q6OqAY=;
 b=BDGeHud9oZX3/Wv+UYHEB6Va5tucc6AAY1SY4itFyU/5VSbwNMULepyqcwGxCieS5G
 +kPQ7Roo/OsDeBctPctX2fzq5QrLdQT3PHB4ysPRTBC6cQw6H/4rnqdhC4VvU5ZYrsno
 b52dFyAffVyyNL7ebkICzald3a1ojU6S4nNGxEwgYrMCxUcjPtQNIaGTn2vxYltfUP8I
 l7Iw0GZ1RZVS6TB4XRMyPsUA2Y/dL3leoQBwfqorhbgu7sL1xGnndaaushIt7uSojf+F
 31l9yDIAqgscykdXc52UnTtPGRY5Oo8Q1FFpvdFmFalxMB1egs0rHkucIG4vx3J2fyYn
 8tmw==
X-Gm-Message-State: AOJu0YzYTcw2Q79Hdqb29VUPCqp3Dt6E8wD0L2SpHYSXhOf4LM8262GS
 VNadq2ckh7J6notBYK3ilmNm4Nn6J24p08w5Q0RKpA==
X-Google-Smtp-Source: AGHT+IEs6mg17PQwgaon8clJqh7g7smpovaOQx/gQgpi4qVOfnFjL97PZD1Bgg4QfB2Sc9xHCu/774XKNDP2mX9YtOY=
X-Received: by 2002:a50:c05b:0:b0:553:ac86:3a4c with SMTP id
 u27-20020a50c05b000000b00553ac863a4cmr721598edd.51.1703047556255; Tue, 19 Dec
 2023 20:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-2-iivanov@suse.de>
In-Reply-To: <20231218210341.30073-2-iivanov@suse.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:45:44 -0700
Message-ID: <CAPnjgZ2n2o1mu2PtkgwEB1dFeaeRx+uNSkSrSogU76vnLGfKRA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] rpi5: add initial memory map for bcm2712
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, wahrenst@gmx.net,
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
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

Hi Ivan,

On Mon, 18 Dec 2023 at 14:04, Ivan T. Ivanov <iivanov@suse.de> wrote:
>
> From: Dmitry Malkin <dmitry@bedrocksystems.com>
>
> includes:
> * 1GB of RAM (from 4GB or 8GB total)
> * VPU memory interface
> * AXI ranges (main peripherals)
>
> Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
>  arch/arm/mach-bcm283x/init.c | 38 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 7265faf6ce..af23b9711a 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -19,7 +19,7 @@
>  #ifdef CONFIG_ARM64
>  #include <asm/armv8/mmu.h>
>
> -#define MEM_MAP_MAX_ENTRIES (4)
> +#define MEM_MAP_MAX_ENTRIES (5)
>
>  static struct mm_region bcm283x_mem_map[MEM_MAP_MAX_ENTRIES] = {
>         {
> @@ -68,6 +68,41 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
>         }
>  };
>
> +static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {

Would it be possible to read these from the devicetree?

> +       {
> +               .virt = 0x00000000UL,
> +               .phys = 0x00000000UL,
> +               .size = 0x3f800000UL,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +                        PTE_BLOCK_INNER_SHARE
> +       }, {

Regards,
Simon
