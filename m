Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D71C3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2126A8852E;
	Fri, 26 Jul 2024 01:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fd7XpRMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E6C8841E; Fri, 26 Jul 2024 01:32:52 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4748863C
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3dab2bb288aso245581b6e.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950366; x=1722555166; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uPcpToR+tLZ2cj5YEt66blT0uGXZprcOmHe7qroF9M0=;
 b=fd7XpRMjgeC6D4PCVEBZCKSBZbVKMf2U1DI/kKOIVAOG3Zo4tZ7/E/Ip44xwkc4RoX
 6yRLNESx+esKN8GazJI2G+iN5nKV5OpjoiMCqwVjpuMmmNcSAD2VSiqViR1RT691RUg3
 ZubUjJyI0WkLNLyL/xrLsWjQr1JgQlDqj9Fs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950366; x=1722555166;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uPcpToR+tLZ2cj5YEt66blT0uGXZprcOmHe7qroF9M0=;
 b=I97JXhlak69NC+CX6TKTCWuTHlytdmgxvyr6GIx4eWde4d3dIxaayqGlY4CdP0mzy0
 lGsFDvMlwY39eVZC5cegBccbMPtB2muM33/wNWSeGOgeWOI5qBN8uG81CVQWgGs/5RTZ
 juSZj9bp5jINukiE/TFnlybnL0hTUpvYUITMrNtviZNdu+JVXAxt0h89JTRAjXZCSBB3
 /FGR8hzEa4MeKkAG0ONLArfA7qM8XjK0gqREOJzscLL+OTLa4X7rvJcOscSBb90LNayw
 oK0KENky0hHmMvNWjFV/k7Jsb1H2gU2EX1PK23KYxE4p/LLuU+RNBqBW/tQhzHHiZp08
 hjYQ==
X-Gm-Message-State: AOJu0YwLaj4Yj9vjrolBt6bdhucvgQ6gIIdD76R22Ia4FDu88gN9ED0e
 k7um33EfrzTI2cArQeYUzXeUbtfQymMbAx7CpGJJy3OOtYS7qJXN5c/UlWwI+mMqtg5q/2kvbFg
 OMQyQaCh1fYEe9vNdyuZUF9mWD5IhZblao5UV
X-Google-Smtp-Source: AGHT+IHUfOB93IM9K5Gw+OYD+R7DKB2E5Sr9D7rSeApKh1YzjhhbRBLZaBwcS6fcDlbuxCbizCfu7c30kxtEzipysz0=
X-Received: by 2002:a05:6359:4594:b0:1ac:f854:b68 with SMTP id
 e5c5f4694b2df-1acfb99fcadmr464818255d.29.1721950365977; Thu, 25 Jul 2024
 16:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-31-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-31-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:35 -0600
Message-ID: <CAFLszTg-hL9z3o68RigDFCE2=Cj-UVHv0xh0Y9=QuS=ZDq3FGw@mail.gmail.com>
Subject: Re: [PATCH 30/40] sandbox: iommu: remove lmb allocation in the driver
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The sandbox iommu driver uses the LMB module to allocate a particular
> range of memory for the device virtual address(DVA). This used to work
> earlier since the LMB memory map was caller specific and not
> global. But with the change to make the LMB allocations global and
> persistent, adding this memory range has other side effects. On the
> other hand, the sandbox iommu test expects to see this particular
> value of the DVA. Use the DVA address directly, instead of mapping it
> in the LMB memory map, and then have it allocated.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  drivers/iommu/sandbox_iommu.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
> index 505f2c3250..15ecaacbb3 100644
> --- a/drivers/iommu/sandbox_iommu.c
> +++ b/drivers/iommu/sandbox_iommu.c
> @@ -5,10 +5,10 @@
>
>  #include <dm.h>
>  #include <iommu.h>
> -#include <lmb.h>
>  #include <asm/io.h>
>  #include <linux/sizes.h>
>
> +#define DVA_ADDR               0x89abc000

This is a very strange address. You can put this in
arch/sandbox/include/asm/test.h and check it in the test. I suggest
using something like 0x12345678 so it is obviously meaningless.

>  #define IOMMU_PAGE_SIZE                SZ_4K
>
>  static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
> @@ -20,8 +20,7 @@ static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
>         paddr = ALIGN_DOWN(virt_to_phys(addr), IOMMU_PAGE_SIZE);
>         off = virt_to_phys(addr) - paddr;
>         psize = ALIGN(size + off, IOMMU_PAGE_SIZE);
> -
> -       dva = lmb_alloc(psize, IOMMU_PAGE_SIZE, LMB_NONE);
> +       dva = (phys_addr_t)DVA_ADDR;
>
>         return dva + off;
>  }
> @@ -35,8 +34,6 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
>         dva = ALIGN_DOWN(addr, IOMMU_PAGE_SIZE);
>         psize = size + (addr - dva);
>         psize = ALIGN(psize, IOMMU_PAGE_SIZE);
> -
> -       lmb_free(dva, psize, LMB_NONE);
>  }
>
>  static struct iommu_ops sandbox_iommu_ops = {
> @@ -46,8 +43,6 @@ static struct iommu_ops sandbox_iommu_ops = {
>
>  static int sandbox_iommu_probe(struct udevice *dev)
>  {
> -       lmb_add(0x89abc000, SZ_16K, LMB_NONE);
> -
>         return 0;
>  }

If this function is empty, you should remove it.

>
> --
> 2.34.1
>

Regards,
Simon
