Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F880C30653
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 23:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A655B8857D;
	Fri, 28 Jun 2024 01:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G2+IJCbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E820488590; Fri, 28 Jun 2024 01:57:51 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CB388852A
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 01:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-424720e73e1so129775e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719532669; x=1720137469; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DASNFM+eN9WjYKPY6CGipCRmltWOFvl83p+sO8yItMY=;
 b=G2+IJCbiaaeM25pkxgtfcUGWKaO9Jwlns5D55Ou2dI1R1k26kBxFdw54wl0ZkBU5U/
 6NvNwX/+wYiftZUz5C13AFn6TmHKKTBn1efeH1k0+5HsHCj7nGSSNSJIgHeHw5/Md79B
 KmgFh/4nC3BCu0NwNII/ak/iWFJ0OK+Nt9iOEL3Bd9EdjUPQPeKp2lU9Jc1aGdtkUQJ2
 bwl9vHzSryq006QlvmYWxGlI21e9SyR941Zu4fqIjZ2DeB2GrxeuxMLmy6T5ejesqLtp
 SLU3NGFNbWjG5qHdetqlwFxJW3tK2QayVQqLXkcd60zVA9F+jydR7Vo76NejydIlXR7w
 dsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719532669; x=1720137469;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DASNFM+eN9WjYKPY6CGipCRmltWOFvl83p+sO8yItMY=;
 b=NCXX3f9NedADqhmIxoxEJegdKXSTkJgN+upYjmJlOJVd5E20H1Sj5SciDXcOH2kX/k
 JiSjNR9o/AsnEJJrMVH+2z8j/KZvcHMSM9qJq9XuJcbATt/8uWnRw/dSqmlnKK4MFGSb
 oO1H+Tej8tJnm0k0MDdQjVN6bLQm9QzyPpiY2vtmJCOyJYT6Q8GqqFQiEvpaHauuI+uE
 0UGc8XRvAdIbykoF6T2NN/P0HAtPrPnOEQe0LdcspTXlhqZYZw/k0xmItJbe0cdDHS7I
 QgAlf83ELh1tkBMIwTU3fJtTNKpvUDwzdscu9MIlLV+RCmCOFeOYZzvfqEO/uBOJb+yK
 EMXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6egAvxlHZyFAc80N7shxmj1PSJ+FHAsb9RYVbPO/sLcnoN/g20QLsD52JjRS65Lep5mz8zq10bE8HBar1ApPhBPO41w==
X-Gm-Message-State: AOJu0YyWRYvr1MMh1LdHX6PZQ9IXJHVHqB/gJoQUawJgey+xepivry2V
 zaNgvhlKjVMcZiVP0so8zKiZ+YvQji9gaFyYMAKjvcbE1eY6mup7+U06VXpb36I=
X-Google-Smtp-Source: AGHT+IE8pLImIwT5Ozs6KfBN2Jb6ENDy+UwPcseMH+aiWBYOOeQBLW9wvUj3EzwahcF2PMgFvNlFyA==
X-Received: by 2002:a05:6000:d88:b0:362:80dd:39ec with SMTP id
 ffacd0b85a97d-366e95759f2mr8972740f8f.42.1719532668459; 
 Thu, 27 Jun 2024 16:57:48 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab065147sm21487366b.120.2024.06.27.16.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 16:57:47 -0700 (PDT)
Message-ID: <bf26fb61-6ef0-47bc-9e84-7f365a8b4925@linaro.org>
Date: Fri, 28 Jun 2024 01:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dm: mmc: fix driver rebinding in the case of dtb
 reloading
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
References: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
 <20240627113546.100333-3-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240627113546.100333-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Mikhail,

On 27/06/2024 13:35, Mikhail Kshevetskiy wrote:
> Rebinding of the mmc driver causes reregistration of block device.
> Thus second mmc device appears and the first becomes broken.
> 
> Fix an issue by using already registered block device instead of
> registering a new one.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   drivers/mmc/mmc-uclass.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 24170c59ecc..403d20dad53 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -420,11 +420,17 @@ int mmc_bind(struct udevice *dev, struct mmc *mmc, const struct mmc_config *cfg)
>   	/* Use the fixed index with aliases node's index */
>   	debug("%s: alias devnum=%d\n", __func__, dev_seq(dev));
>   
> -	ret = blk_create_devicef(dev, "mmc_blk", "blk", UCLASS_MMC,
> -				 dev_seq(dev), DEFAULT_BLKSZ, 0, &bdev);
> -	if (ret) {
> -		debug("Cannot create block device\n");
> -		return ret;
> +#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
> +	device_find_first_child_by_uclass(dev, UCLASS_BLK, &bdev);
> +	if (!bdev)

What about boards with multiple block devices (e.g. ufs + sdcard or mmc 
+ sdcard)?
> +#endif
> +	{
> +		ret = blk_create_devicef(dev, "mmc_blk", "blk", UCLASS_MMC,
> +					 dev_seq(dev), DEFAULT_BLKSZ, 0, &bdev);
> +		if (ret) {
> +			debug("Cannot create block device\n");
> +			return ret;
> +		}
>   	}
>   	bdesc = dev_get_uclass_plat(bdev);
>   	mmc->cfg = cfg;

-- 
// Caleb (they/them)
