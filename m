Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBE4C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 09:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84CCC82139;
	Fri, 31 Jan 2025 10:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IJZZx2Sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6848213D; Fri, 31 Jan 2025 10:47:02 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2661880F70
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 10:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so2616246a12.3
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 01:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738316819; x=1738921619; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ucFfMNgqRDLg6/uPoqIk2s37n+lE+snFypeGlN5XDEg=;
 b=IJZZx2SlBksZnyKn6QQv7Iu0896bV2h7195lwIUymgEC3CEUcbOgeTbQiY9uYZ0/CZ
 kB3jvKqm3iJJ5LjCmjzqg1JWTW1t7RIh12U1l/CuoIEDFT2HRcwsgnzUxsKe3N0Su1S3
 x6eO5v4uV9YHFH4JkXWHUur1PPg3iLPN+e5uT8KJlnsKnbBF/gx26I04K2n7r8RjEy2b
 Gzjvu4a36GQB/NLB63EdRkGYpUiDBd8C2yNAIdGkZVTwI6KmfVWYuKGe2JqAOJuJdIIp
 fiTEQ8iL+LyJKy3ZLmi+KgoCOW6uNO0k+ovnhBzx5YXO49lS8NNwyRsG15OP5eUb1OXD
 jj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738316819; x=1738921619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ucFfMNgqRDLg6/uPoqIk2s37n+lE+snFypeGlN5XDEg=;
 b=o4yk0Zt5/jKr0WULiKQXlKVbNsHe+3P/rSYlB7Wv9DUdYSuvQqZY+mHNF+7pUdbP6A
 a4F9n1fkTsaF3ffeO0rrzv22/IUbRd05dVkpMbMl78iYbqUFL1XQsxoBFImVyswovUge
 +Ad0PgU9GK5y+hXx6dQx4UFoGpB7XaL/qiGNDbQDpg8gE153SkJKVCMBDsqe9Pbhlvnd
 BiIiIuJwUKd4ENxdc5m9spf0VlQYu0My5nNR0XXLBHr+6Djm8xj/xcQW8EG/dul4/H5/
 aVTEIyh2UHu/6fkVHm0tSALrHwXUrxXg+hldcXDHV6I7Mh8oF7CDIvM9Yx+VPGgJ94kg
 mU3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyK9Xa+qh0fLOOVYDZ82h8WZVeF2NV63XIq2vw1SRgD0SAFk0hzh1GEsIDzp/Owa36EkUmwus=@lists.denx.de
X-Gm-Message-State: AOJu0YwNCc1dq05isAWHiI/qalW+fIUDj9UcTyBclfBU1BA/p62hfbdW
 HY27Ghc0fANPjoDKlfYedPbiUdv2sFsMVS6OtnpLYK1Rvon6RJPmsJ2RJ0/cjb0=
X-Gm-Gg: ASbGncsruUYoUkgP0RD+IoRapLeEEY6cF8GgCI+lXhiJOV9xDm0MXLOFvNeuyeOGzrL
 GfZSZ1Oq0kd/SbDOiy72YERdESezdq9U+DIT4vM5INTTjU3x2gej1KB5rWYPu6Un1VWUrknm8P4
 jjc+pzlZaWL5EMIoT0REdIT7o6iFP9YNqcuu9UQhuG5kg81IYg3Aqit/iaLBpa6vLWccVW16YDk
 ATX824vaECy/9KJO/hXTyrnP3/HDHI6xwh6UN20LH/OrUerPLrhjqipK9658rtsTtOQROQwNjAQ
 zao/WBonONr9LvAgZhxK+ps=
X-Google-Smtp-Source: AGHT+IEh7MyrAhIom6hq1nVTzoyJDeGhRkE6qtcWPtmrsRA9TDMBK0k1dcjcJC515qkx9cYobieEXQ==
X-Received: by 2002:a05:6402:3514:b0:5dc:f48:f01e with SMTP id
 4fb4d7f45d1cf-5dc5f01e783mr10264343a12.30.1738316819420; 
 Fri, 31 Jan 2025 01:46:59 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723d0043sm2530799a12.12.2025.01.31.01.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 01:46:59 -0800 (PST)
Message-ID: <7eca2634-a29f-4440-84e1-bd3eb9f38a02@linaro.org>
Date: Fri, 31 Jan 2025 11:46:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] pinctrl: at91: Bind GPIO driver to the pinctrl DT
 node
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 pbrobinson@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250130035157.226995-1-manikandan.m@microchip.com>
 <20250130035157.226995-6-manikandan.m@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250130035157.226995-6-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
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



On 1/30/25 05:51, Manikandan Muralidharan wrote:
> In Linux DT,the pinctrl node acts as parent nodes with all other
> gpio banks as child nodes and a single driver in Linux handles both
> pinctrl settings and gpio requests.Current U-Boot DT maintains both
> pinctrl and gpio nodes as separate nodes and offers two different class
> of U-Boot drivers: UCLASS_PINCTRL which handles pin functions and
> UCLASS_GPIO which handles gpio requests. In order to align the DT
> of U-Boot with the DT of Linux, a hook is been added in the pinctrl
> driver to bind the gpio driver with the pinctrl driver so that
> when adding gpio nodes as subnodes to pinctrl node (as per the Linux ABI),
> the corresponding APIs will be redirected and handled by valid
> drivers attached to the pinctrl driver.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-at91.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 5038cb535e3..2b871143fc0 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -9,6 +9,8 @@
>  #include <dm.h>
>  #include <log.h>
>  #include <asm/global_data.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
>  #include <dm/pinctrl.h>
>  #include <asm/hardware.h>
>  #include <linux/bitops.h>
> @@ -492,6 +494,18 @@ const struct pinctrl_ops at91_pinctrl_ops  = {
>  	.set_state = at91_pinctrl_set_state,
>  };
>  
> +static int at91_pinctrl_bind(struct udevice *dev)
> +{

Can you add a small comment to explain why this bind is required and its
purpose please ?

> +	ofnode gpio_node;
> +	struct udevice *gpio;
> +
> +	ofnode_for_each_subnode(gpio_node, dev_ofnode(dev)) {
> +		lists_bind_fdt(dev, gpio_node, &gpio, NULL, false);
> +	}
> +
> +	return 0;
> +}
> +
>  static int at91_pinctrl_probe(struct udevice *dev)
>  {
>  	struct at91_pinctrl_priv *priv = dev_get_priv(dev);
> @@ -524,6 +538,7 @@ U_BOOT_DRIVER(atmel_sama5d3_pinctrl) = {
>  	.id = UCLASS_PINCTRL,
>  	.of_match = at91_pinctrl_match,
>  	.probe = at91_pinctrl_probe,
> +	.bind = at91_pinctrl_bind,
>  	.priv_auto	= sizeof(struct at91_pinctrl_priv),
>  	.ops = &at91_pinctrl_ops,
>  };

