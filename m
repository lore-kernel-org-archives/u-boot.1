Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4F4C7EE2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE4C588A2D;
	Thu, 29 Aug 2024 09:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YKH1s50t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81815889FF; Thu, 29 Aug 2024 09:32:39 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6419288A2D
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7cd967d8234so214937a12.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724916756; x=1725521556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MS4eYXZRRMGkyK7ryKHQJwpaKnpshAkO0gLrGDMEAUQ=;
 b=YKH1s50t5zKsVz2doV9dfcFiqumNojA8vCz+4HsTpH0vE3SOGTPuf/Lkax5ETpfA2H
 zHT1qNK7iUOp6q95/doDCVot4aZ4KLqkTRKOHlfpghrLkCCcWdC8t4uCrArCEV9gNd5e
 I2udBnG/V38h1mTpVjZ8CXE3ZDjli9kBbKTezTuqH8okg8IouPmX4iXggFJhFcQqIy28
 vIEm97oscz8kvx3e0RCXhBbUBaH0kEUxFYga/dBnJcLzbs2qpQnll0MiF1Ak1FvwuD3p
 lFRXJfR/R8qTnDbFa5C39Lp9pPRYsu1ztI2Kv8Biojgvi120YMwlhwDy27CxVGkZQW1w
 ZBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724916756; x=1725521556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MS4eYXZRRMGkyK7ryKHQJwpaKnpshAkO0gLrGDMEAUQ=;
 b=R1gnzs40OyiSFPKpuKS8JbFSdrWuvlhuCiDlxQnKRi8NWgNYS1UBQdrl+qpJeKzp25
 LCsKNKDXwFKDiLBHMA2VGUoPinRtfTHEQLw3MZc7QJXqYPSXGdPYU2HNN/6aNu6XY6gA
 WuvLX4WhxOrz0OSBUaQszzEG6iZZTUHRlO5/49si3ut4+W4kLX5B1ox2amImz+f5JbWk
 8L9KavxPx4gxGKgp+4zLoCABr+18jHoN2N9cBPlwcvAvKKkMb3PEWRQ/0gfsd3z4fyeD
 DidXroeHJhgZ5Gjq5yUAgZ3pCzgj0kljrP3yE/xekL4r6YwDatppy/k5KZwKL8icpaUz
 38oQ==
X-Gm-Message-State: AOJu0YxmnCIeQEAiPg+6u+1gxI+6MLGaluwPt++kEVo0Ki0J54d1Y2Xz
 1fbG14XkehZb4Y7ALnHRbkXv85yposYkTcuPkwadXVCSL2NsOFthXFP0+g9pQF116tHJeO9D9UC
 GznqhRe/kYXpedI5e3NCspXDGHBcv5R+J4pQiCw==
X-Google-Smtp-Source: AGHT+IEZlMrcc0bPcaN9zn0f+yEk+L0rVPT5K8Z+phq5CzmpATElajB5vU9Fs1US5adeaH9cc/YJchheqXfvdWmup1g=
X-Received: by 2002:a17:90b:4a0b:b0:2d3:b357:7857 with SMTP id
 98e67ed59e1d1-2d8561a38ecmr1781596a91.16.1724916755687; Thu, 29 Aug 2024
 00:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <fbbe33f617e25f80b5d541edd13ed8bd8035b6e4.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <fbbe33f617e25f80b5d541edd13ed8bd8035b6e4.1724846454.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Aug 2024 10:31:59 +0300
Message-ID: <CAC_iWjJbMia+ZkGV1Q6Np7XQcdyf98eve4CVBs1tXeZz21LDLg@mail.gmail.com>
Subject: Re: [PATCH 04/13] arm: omap2: add missing #include <netdev.h>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
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

On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> emac.c implements cpu_eth_init() so it needs to pull the corresponding
> header file.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-omap2/omap3/emac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-omap2/omap3/emac.c b/arch/arm/mach-omap2/omap3/emac.c
> index 7348e92cab..1e30a06361 100644
> --- a/arch/arm/mach-omap2/omap3/emac.c
> +++ b/arch/arm/mach-omap2/omap3/emac.c
> @@ -9,6 +9,7 @@
>  #include <net.h>
>  #include <asm/io.h>
>  #include <asm/arch/am35x_def.h>
> +#include <netdev.h>
>
>  /*
>   * Initializes on-chip ethernet controllers.
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
