Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6A9D13594
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 07:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAF289123;
	Tue, 29 Oct 2024 08:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YX68hO9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADA8890D1; Tue, 29 Oct 2024 08:19:44 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8138912E
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9428152c0so5876044a12.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730186381; x=1730791181; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ghv8AwghZ+Ykqw0XrZH5QtQ/1IPSuX1Kg6qMYqSx1Go=;
 b=YX68hO9XcTJcnszIokI/3SKHDdZCdp6w4+8Gxxr4bjcO1355oei5CTvMMBmgJbdRtD
 5+buirQrfIgnU0ZN2CjJdjQ03eHFY3PS8Ez2QBVKJxEzepqrtcpE3Zem0jBJolmm4NBk
 fCDaQ25UfHMsBlGY1AFYaFU3D0yXs9C+vNoRFBPlThQpoz1aFTO3Zf+ZzYt1EVBNEzOg
 0IrVaJ7gAakG42JgkAw2NXHIxLqoPlvJdwVT/bM9oXK5qSEESEjZnNXD/M35Wx/h8a77
 m/EOM2lae11QL3wY26tMGcRYNMrPsRNgIvlwccpoIgVLbRU3PaaN4juanRwXm4tnVLR6
 lZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730186381; x=1730791181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ghv8AwghZ+Ykqw0XrZH5QtQ/1IPSuX1Kg6qMYqSx1Go=;
 b=KpFU43A79OuwAEm8gPi9pl2hxxA5rYQEHxGXajrKDGCOm8ZSZ+su47yyJ78t6OpzOq
 JCrhNtGFhd1PmtIo2g+dQnXnykHfu23BgmY4A3YeXd8HzCeOtByTlZIp2Kc5QGiM2S5t
 qUGTiSkHHh5dc1Yy9p+gByksNDoWyhz6m+BUA86RHqHZKa2hf8ugb6zl0XBPfCegocpy
 R172jvnS5J25EDTv3hy6pe/4DBk4saJIiZ5DpYLqCgET6dxRCZHn06Fw5D/eGo8ui22T
 N2NLjHCH/AltEEhv7AnPwnYPX7c33uyizwIyoclH+yn7VkTzryBue4Ma1AfiDcQdCI8V
 20Yg==
X-Gm-Message-State: AOJu0Yw651TRKp4kphXBm+PdL47kplntZie2zIvXCrXjU4gcovjC1Z4e
 WR8mjxjiJQKBzVPeofsBcVL5jV+h0MFk5YeLMzuDg6oZXJl7a7FMPCQOMTXdM67QbKJFSR8Y/91
 k0+QI5al85iZ40J/6SlK8Io9XPWIhg+q5IH4X9QUV1KBOeLN8
X-Google-Smtp-Source: AGHT+IFIf9Lfbw8dUps27tvVepUxRFfKOoHGIjgRBznFQpATfEVSQT2MDLXBqtq3husklRnnRm/vNmUYS71HSRM8Mag=
X-Received: by 2002:a05:6402:254c:b0:5cb:c081:92a1 with SMTP id
 4fb4d7f45d1cf-5cbc081a857mr10080399a12.16.1730186381193; Tue, 29 Oct 2024
 00:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241029033915.423211-1-sughosh.ganu@linaro.org>
In-Reply-To: <20241029033915.423211-1-sughosh.ganu@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 29 Oct 2024 12:49:29 +0530
Message-ID: <CADg8p95bWp_5SBiSuWr=K=xf1orYdZgfGYoaqwkFEz16kDZqXg@mail.gmail.com>
Subject: Re: [RFC PATCH] apple: dart: add logic to allocate dva addresses
To: u-boot@lists.denx.de
Cc: Janne Grunau <janne@jannau.net>, Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 29 Oct 2024 at 09:09, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The Apple IOMMU driver uses LMB API's to allocate virtual addresses
> for IO devices. These virtual addresses fall in the first 4GB address
> range. Currently, the driver obtains these virtual addresses through
> the LMB API's. This no longer works with the global LMB map. Add a
> function apple_dart_dvaalloc() which mimics what was being done by the
> LMB allocation function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>
> Note: I have only build tested this on the m1 defconfig.

NAK. To be discarded.

>
>  drivers/iommu/apple_dart.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> index 611ac7cd6de..8e2acf50a06 100644
> --- a/drivers/iommu/apple_dart.c
> +++ b/drivers/iommu/apple_dart.c
> @@ -6,7 +6,6 @@
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <iommu.h>
> -#include <lmb.h>
>  #include <memalign.h>
>  #include <asm/io.h>
>
> @@ -75,6 +74,7 @@ struct apple_dart_priv {
>
>         dma_addr_t dvabase;
>         dma_addr_t dvaend;
> +       dma_addr_t dvaalloc;
>
>         int nsid;
>         int nttbr;
> @@ -109,6 +109,21 @@ static void apple_dart_t8110_flush_tlb(struct apple_dart_priv *priv)
>                 continue;
>  }
>
> +static dma_addr_t apple_dart_dvaalloc(struct udevice *dev, phys_size_t size)
> +{
> +       dma_addr_t dva;
> +       struct apple_dart_priv *priv = dev_get_priv(dev);
> +
> +       dva = priv->dvaalloc - size;
> +       dva &= ~(DART_PAGE_SIZE - 1);
> +
> +       assert(dva > priv->dvabase);
> +
> +       priv->dvaalloc = dva;
> +
> +       return priv->dvaalloc;
> +}
> +
>  static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
>  {
>         struct apple_dart_priv *priv = dev_get_priv(dev);
> @@ -123,7 +138,7 @@ static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
>         off = (phys_addr_t)addr - paddr;
>         psize = ALIGN(size + off, DART_PAGE_SIZE);
>
> -       dva = lmb_alloc(psize, DART_PAGE_SIZE);
> +       dva = apple_dart_dvaalloc(dev, psize);
>
>         idx = dva / DART_PAGE_SIZE;
>         for (i = 0; i < psize / DART_PAGE_SIZE; i++) {
> @@ -158,8 +173,6 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
>         flush_dcache_range((unsigned long)&priv->l2[idx],
>                            (unsigned long)&priv->l2[idx + i]);
>         priv->flush_tlb(priv);
> -
> -       lmb_free(dva, psize);
>  }
>
>  static struct iommu_ops apple_dart_ops = {
> @@ -211,8 +224,7 @@ static int apple_dart_probe(struct udevice *dev)
>
>         priv->dvabase = DART_PAGE_SIZE;
>         priv->dvaend = SZ_4G - DART_PAGE_SIZE;
> -
> -       lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);
> +       priv->dvaalloc = priv->dvaend;
>
>         /* Disable translations. */
>         for (sid = 0; sid < priv->nsid; sid++)
> --
> 2.34.1
>
