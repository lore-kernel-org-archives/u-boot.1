Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA76C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 13:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB43B87C15;
	Thu,  1 Feb 2024 14:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XkeJsRpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E664F875B9; Thu,  1 Feb 2024 14:51:34 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B8087C34
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 14:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e80046264so8541085e9.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 05:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706795491; x=1707400291;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OQB6ZSI2IbayuvGKRbzfqOmF/2PWnFWy/Sy1bznNURU=;
 b=XkeJsRpg8ZGh/BZxWpgVjJOewGARDMDh7BLGHiaKwmkx0VjJneNJr2EcIBm8LgOf/W
 Y9FUU9HCudojsu8cm7h8LVEC4WB1FDyQxUa5UKq3fN0UE6Tlq3e8S/s88gjcuha2xXGC
 TusPqHZpVyYUWPAYO4r/pZbFgl4o4uHxHDRorjKVaUVR7KJ6Xmebbi0CHBTYMebrcTyS
 xYKT2W3hkso0cHd5AVUlGQOUtwlNZN+/5gJ9/HI2dpx/u0G3airDd+TmJ4Eo4WKKPSBV
 PveakXsZQHUTetd4zyOu8l04sEjJDWbSiOrDnw2jHxgh1FL3zhQ6sTUk0vsjEaNnVqL1
 r1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706795491; x=1707400291;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OQB6ZSI2IbayuvGKRbzfqOmF/2PWnFWy/Sy1bznNURU=;
 b=ZPGN2yiQH5MQrsOrlrH+1qpuRU1sP5jPjp03dCEmuxQK1s+l2l3R97bvGuMniz0Inp
 JceIvpedRK0th/3QEGFWTZwIY4fR4uct9MC7J75CoYNTDNnQUhVBWATrNzsaacl13Doz
 i1uiY9K+jQfHLusdlSIb2cj2zQmhlC9keMZFB2ixqRiLzlLRa6oEPWDRSaGpQpSxPWQK
 WQEzsKz3dG7IxRuEmNPkWemF4q3rCwFXd0UUk6e09r50RrA3L0t0ZoeXQ+ZJwONqDDgw
 xAPmj+JlxJeQuhbdpZ/NH6VSjp+pLfKSU56FIq38/JUWt3ax+PeHljOjjzd0qCArXQYg
 W0XA==
X-Gm-Message-State: AOJu0Yzh9ZUlfxv2VEV015P6RxsLJYvldOkpsJbuHMnMbGt8mcXzEzRZ
 Fzy5wxNRdWypgFOJ9W/hIeNg4DStC6uKcXDWyBb+n0BB2v6Ir+o6dcYKUjMul+M=
X-Google-Smtp-Source: AGHT+IGhMVihW9dRxIrs/YUW7da4/MMeVA6Z+ErAxsSU98pof0cWY7nVyqlarU5IiLJo5hZDuBT49g==
X-Received: by 2002:a05:600c:1d1c:b0:40e:c6ae:3c88 with SMTP id
 l28-20020a05600c1d1c00b0040ec6ae3c88mr3757884wms.35.1706795490648; 
 Thu, 01 Feb 2024 05:51:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWV1xNLw0P5ZmSOmvj9LcLk+re1RpCbrHsUc7nhcTqUvkzBXVu3HwwByMpMY8JLxeBU2fOUW/n9bMrwFj/RCqX+x1gDm29IVHpqhqnRCDg6fEnZJafNOR20QYaHHEIRdrK0d6huM3MMxGwzY/Rg4+LC1xLIPGCTU4CKFQd+NqZIa51BdiSuyQ5j3m14+xOGLugFvg==
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 je1-20020a05600c1f8100b0040ef61dfd48sm4584271wmb.11.2024.02.01.05.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 05:51:30 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Caleb
 Connolly <caleb.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] iommu: qcom-smmu: fix debugging
In-Reply-To: <20240131-b4-qcom-usb-v1-5-6438b2a2285e@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-5-6438b2a2285e@linaro.org>
Date: Thu, 01 Feb 2024 14:51:29 +0100
Message-ID: <875xz8mgwu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Caleb,

Thank you for the patch.

On mer., janv. 31, 2024 at 14:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The priv struct was wrong in dump_boot_mappings(). Causing errors when
> compiling with -DDEBUG. Fix this.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/iommu/qcom-hyp-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
> index 8e5cdb581550..f2b39de56f4a 100644
> --- a/drivers/iommu/qcom-hyp-smmu.c
> +++ b/drivers/iommu/qcom-hyp-smmu.c
> @@ -319,7 +319,7 @@ static int qcom_smmu_connect(struct udevice *dev)
>  }
>  
>  #ifdef DEBUG
> -static inline void dump_boot_mappings(struct arm_smmu_priv *priv)
> +static inline void dump_boot_mappings(struct qcom_smmu_priv *priv)
>  {
>  	u32 val;
>  	int i;
>
> -- 
> 2.43.0
