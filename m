Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7625ACA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 11:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3AB680077;
	Mon, 18 Aug 2025 13:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D/z1RgMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFBE80107; Mon, 18 Aug 2025 13:40:48 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE8B8004F
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 13:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6188b70abdfso5657548a12.2
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755517246; x=1756122046; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tdtrlp97BihOWQ2aX/ufSbOFWdIru33QWkEX75c/tSw=;
 b=D/z1RgMtV6KLNAVFLLysVeC96WhYHmcclmSmWSlgiNE6e+HAA50rdg06tKEzQ7SvjI
 htMZXEk1UF1F9kqT7+hhAGD8ETCA4YzOza1pOVcjbU6oAXTONE82WZ2Tl0xRgD74Sf/d
 A1RkKdgvl3LNY5/c2vwwKUs8yaiQ8954UBaT94dzM8IkiEooD9p3VgQ15m2b1yf6QCXK
 e5KYKOiFvfMXPpq+P9i78rY29j7p0T7v4967M+UP6jwMc5Mi4vN98AC1EKHaOu1y0GPz
 SQA6cq4vu/Vq4vr70KQaqHtb4XdqDJ4c42pPWS0hJ0QyAafRbBkA3a9oTdpb42ZMUAvm
 Z/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755517246; x=1756122046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tdtrlp97BihOWQ2aX/ufSbOFWdIru33QWkEX75c/tSw=;
 b=M5MVmYN0MJgUCrq6Ec83jVm9YXtlIRpYeLYOxuC0gbLwYsInGt+3C69NEijSeNv/M7
 RklwtsMEsWWYLdbmOwe2c9FvcvoXmb8glNv1RCQSNh1wH+0uK7DOln9Lz6f/sdaJmDTh
 B7Ca0X+TfNUPmgOq+7K5Ngobz6pURAFHoGQ3ygTyVU8jeOaBydqDH1jGms/VRx7ptMnp
 rd56QB+cqDtR78DfxtWCBUVqhpo5LIqLaOO1Yg0DehC7KfH1hV3dq/LVxkcXlL90bvSH
 wLpM/fSOioMU8C0KcZk0aNajj7jW/xlk5yt3A++oKtybLle7eHhNs0u2pWy4wNVscHEe
 fiAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYqY24hxPCgQDCjhOnDIDnVhGBf79lIxVvTMXzw90t857YycZH1Yta46xglxGtB63nsSI1q0I=@lists.denx.de
X-Gm-Message-State: AOJu0YxcqKAOE86NbZ9gylt/blZVuoo8G4jpjb8B4zu5f5znJT7TEnsI
 rLjeBR4Dh8E5PHGECrQnfXVfzfZQEXW+Iks85AzKzmP9RJtPGPzXbxTpyJjGTqbQeW7yXo3iCjN
 yhVZLjCLet/8kxjW+IsAslHWMdSnbhhc=
X-Gm-Gg: ASbGnctfk2daDdAUotKE0bCh6VWhaCWp9u/HzvoXZkKLr9l0kR1WLItpZq/HwNkL4VQ
 uZv30iiLei/7OKOosa2hhcvgn82PMo/Bo2/0TT+pfbKq2lnM9tpe8382hlPQg4jt4m/0PXCXdHj
 MTbbz4xV0RzNiJ7jLO+AsMHOYHbgm2ERMWE+bRGwufiRo3SMeT3EP1uvP6uiVw5QbljYqW4kHv2
 SDE/A==
X-Google-Smtp-Source: AGHT+IEVxX8VDJMDK/uMjAak493V9+vaAF050YvOSSuBTb7AYLWXwQpuZePcy7iC7gg2omvTuTHae8s5GThby7mF7Ng=
X-Received: by 2002:a05:6402:2708:b0:618:adff:66e5 with SMTP id
 4fb4d7f45d1cf-618b054dbd5mr9202668a12.17.1755517243951; Mon, 18 Aug 2025
 04:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250806-net_xilinx_axi-v2-1-6311cf59451d@linaro.org>
In-Reply-To: <20250806-net_xilinx_axi-v2-1-6311cf59451d@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 18 Aug 2025 17:10:29 +0530
X-Gm-Features: Ac12FXzjJFbHTZknpyvRpWyiWhfFtiBWahDCa2BOEh0BtRcz37G3U9AHdUAEWM8
Message-ID: <CANAwSgRvnJcZ71eNRCf+9G2NJjq8CxzV43h6w-cGEsmHLGGz+A@mail.gmail.com>
Subject: Re: [PATCH v2] net: axi_emac: Fix timeout test
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Andrew,

On Mon, 18 Aug 2025 at 14:54, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> The timeout test in axi_dma_init is not correct due to the
> post-decrement used on the timeout variable which will mean timeout is
> not 0 if the timeout occurs. Make the timeout variable an int instead of
> a u32 and then test for timeout being -1.
>
> This issue was found by Smatch.
>
You can use read_poll_timeout instead of a while loop timeout?

Thanks
-Anand

> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v2:
> - Refactor the code so it returns on success from the while loop
> - Link to v1: https://lore.kernel.org/r/20250806-net_xilinx_axi-v1-1-00be06069c76@linaro.org
> ---
>  drivers/net/xilinx_axi_emac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index c8038ddef1b..22e119370c8 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -558,7 +558,7 @@ static int axiemac_write_hwaddr(struct udevice *dev)
>  /* Reset DMA engine */
>  static void axi_dma_init(struct axidma_priv *priv)
>  {
> -       u32 timeout = 500;
> +       int timeout = 500;
>
>         /* Reset the engine so the hardware starts from a known state */
>         writel(XAXIDMA_CR_RESET_MASK, &priv->dmatx->control);
> @@ -571,11 +571,11 @@ static void axi_dma_init(struct axidma_priv *priv)
>                 if (!((readl(&priv->dmatx->control) |
>                                 readl(&priv->dmarx->control))
>                                                 & XAXIDMA_CR_RESET_MASK)) {
> -                       break;
> +                       return;
>                 }
>         }
> -       if (!timeout)
> -               printf("%s: Timeout\n", __func__);
> +
> +       printf("%s: Timeout\n", __func__);
>  }
>
>  static int axiemac_start(struct udevice *dev)
>
> ---
> base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
> change-id: 20250806-net_xilinx_axi-9ca9a791d611
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>
