Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36E8CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 13:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6523846B0;
	Wed, 17 Jun 2026 15:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a/t20BDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD5A84833; Wed, 17 Jun 2026 15:53:52 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D94A8460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 15:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5aa88b4f792so1247098e87.1
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781704429; x=1782309229; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lNn2n5oqBjLK0y/vK1WDhEZuJxMfZMxwqD1Vj39HzAg=;
 b=a/t20BDpq9JIqjktmDn9gwyYch8TaxOPqj9HfS7naTHLojoY8zH0S7Nn1hGp0xVdlb
 1J51b6j4Qf9F+oHDvgqQniIQNoogCpr0aEZWY2Tvm4TLn8iNArT1S2/QJ4j9CYQWZdiD
 W344znESVgXzZQVmCHjqTWFDU9fujsdVuahi74gTe5hx2pKAnWDx4JJVD4wsuBVfNi6C
 K+sENtTdV0DxN15BObfwBnOIchjkRvJOEK6WutXPxwOVm+l2/+mpbJVTAIZcYbIa6if4
 whRk4/i1HlLW3B3wLwh/t+CF3aygJVs0gUuOxqRw7h3TV/7DxkjiVYHtXRlcJu0bPIJF
 hrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781704429; x=1782309229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNn2n5oqBjLK0y/vK1WDhEZuJxMfZMxwqD1Vj39HzAg=;
 b=SkGaaOmqGOJ8oxNInx6W2/eVNx7eS+SUJQHotaIlLtMIyBC+GWg3xSBoWNHM70cmSp
 UKOTgKV7g1DIlePaEudfepN+KJbOAABcr5jUQK29V7hd0hFGb7dAgVOoH0eFwn6DCoYq
 iR9yBJ+kuExv+3imTuh1Pprd7sLTXK//bP0ug007vknpLpDJf2hN+XWc09UKhqA5zlzs
 k9YFbysPxd6tYcV7bWYhtkm75M7D58NI8NL4LTlFeUCCLMOexEZ0kfN3mzv5MA9wajxs
 ze4z0RWOD+ls8E4kpDXkcjuq57LJL61HUtU835fCk+Hai7JdFdod1sQlBGrAefFZby3E
 pgsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e78iNwc5M02yyVsnODzDfPhj/oo0VS2LdQGY15ZUD/aZyD8kc0jNbXIOwVm/BNasq1RmcJ5s=@lists.denx.de
X-Gm-Message-State: AOJu0YzPirqO6G8m6uKPFLyKkMVRCQntV8hXGpW2S8i0bwxoIL6KXeXr
 I7QCAW9gZIss6l2jYG591XrLoRG4aRG4vRRpFRBVVZkf6TGeVvyP6K6XqRCbLh0/iHM=
X-Gm-Gg: AfdE7cnyYdUW8NhZOAtfoqSeKrCdycGdXS50hJ0WrBl1F9+lY3Xh2W5J9ck3m/gX4GN
 jES8xQ+M8hGDd9+BsVuytipzdUWHxpWp0cjpC7MI3RTW4FaDx917GGcBBwWdtwfbPHG3vXiaBoN
 HuBwbf1hAGBXED+0KWeVaiGbqyWUXuBRvHjwgbQeTP6RByThw8n3bdsXLwMjBJs6hfYi95uyl2v
 PHFFOXF/raw/ePfBCC4TeSyYkwd/v+mNGCivMj5ZoMoEOXB4bjW2iola5sJ4N8FN3Q4tK4G9CnB
 +uONrOVhx05hVowoHsLu5cmIspNni1OPBfFIis3V51IUL8b7YlAOsPb/ht8KjLecIqXTqr1yA11
 rdUU2lJQYrXr6kplyVMxMX8DcmkTHcIhZ9JNFt1GDDYF8buSKf1qFz0qulxRnRcb4nAd06nYDxw
 VqbvbBTdg11vD4Rwpaod2saiVsMVv0YGXQjunbzR1L4rmu0cgb9URO
X-Received: by 2002:a05:6512:613:10b0:5aa:62df:cd0f with SMTP id
 2adb3069b0e04-5ad47ff5379mr705137e87.2.1781704429340; 
 Wed, 17 Jun 2026 06:53:49 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161f2fsm4542941e87.11.2026.06.17.06.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 06:53:48 -0700 (PDT)
Message-ID: <c2b23c8a-4526-4daa-a563-c4ee4966d504@linaro.org>
Date: Wed, 17 Jun 2026 15:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drivers: misc: pm8916_pon: support setting reboot
 type
Content-Language: en-US
To: me@samcday.com, u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen
 <justin@tidylabs.net>, Jamie Gibbons <jamie.gibbons@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-4-170c9cbe5099@samcday.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260606-pm8916-pon-v1-4-170c9cbe5099@samcday.com>
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

Hi Sam,

On 06/06/2026 10:47, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> This is to be used in conjunction with PSHOLD sysreset driver.
> 
> This code manages the RST_CTL register block, which PM8916 uses to
> decide what action to take when PS_HOLD is de-asserted.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  drivers/misc/pm8916_pon.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/pm8916_pon.h      | 18 +++++++++++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/misc/pm8916_pon.c b/drivers/misc/pm8916_pon.c
> index d65a7cab459..4cd8921a08a 100644
> --- a/drivers/misc/pm8916_pon.c
> +++ b/drivers/misc/pm8916_pon.c
> @@ -10,16 +10,98 @@
>  #include <dm/lists.h>
>  #include <dm/device_compat.h>
>  #include <power/pmic.h>
> +#include <linux/delay.h>
> +#include <sysreset.h>
>  #include "button/qcom-pmic.h"
> +#include "pm8916_pon.h"
>  
>  #define PON_REV2 0x01
>  
> +#define PON_PS_HOLD_RST_CTL 0x5a
> +#define PON_PS_HOLD_RST_CTL2 0x5b
> +
> +#define PON_PS_HOLD_ENABLE BIT(7)
> +
> +#define PON_PS_HOLD_TYPE_MASK GENMASK(3, 0)
> +#define PON_PS_HOLD_TYPE_WARM_RESET 1
> +#define PON_PS_HOLD_TYPE_SHUTDOWN 4
> +#define PON_PS_HOLD_TYPE_HARD_RESET 7
> +
>  struct pm8916_pon_priv {
>  	struct udevice *pmic;
>  	phys_addr_t base;
>  	u32 revision;
>  };
>  
> +int pm8916_pon_set_reboot_type(enum sysreset_t reset_type)
> +{
> +	struct udevice *dev;
> +	struct pm8916_pon_priv *priv;
> +	int ret;
> +	uint pmic_reset_type;
> +	uint enable_reg;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(pm8916_pon), &dev);
> +	if (ret) {
> +		pr_warn("couldn't find pm8916_pon device: %d\n", ret);

As mentioned, if ret is -ENODEV then we ought to return 0 here (maybe
with a debug print) since that's an expected scenario.

> +		return ret;
> +	}
> +	if (!dev) {
> +		dev_warn(dev, "couldn't find pm8916_pon device\n");

Don't call dev_warn() with a NULL dev.

Is there a case where ret = 0 and dev is null? Or can this be dropped

Thanks and regards,
> +		return -ENODEV;
> +	}
> +
> +	priv = dev_get_priv(dev);
> +
> +	/* PMICs with revision 0 have the enable bit in same register as ctrl */
> +	if (priv->revision == 0)
> +		enable_reg = PON_PS_HOLD_RST_CTL;
> +	else
> +		enable_reg = PON_PS_HOLD_RST_CTL2;
> +
> +	switch (reset_type) {
> +	case SYSRESET_POWER_OFF:
> +		pmic_reset_type = PON_PS_HOLD_TYPE_SHUTDOWN;
> +		break;
> +	case SYSRESET_COLD:
> +	case SYSRESET_POWER:
> +		pmic_reset_type = PON_PS_HOLD_TYPE_HARD_RESET;
> +		break;
> +	default:
> +		pmic_reset_type = PON_PS_HOLD_TYPE_WARM_RESET;
> +	}
> +
> +	dev_dbg(dev, "Setting PON reboot type: %x\n", pmic_reset_type);
> +
> +	ret = pmic_clrsetbits(priv->pmic, priv->base + enable_reg,
> +			      PON_PS_HOLD_ENABLE, 0);
> +	if (ret) {
> +		dev_warn(dev, "clear PON_PS_HOLD_ENABLE failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Delay needed for disable to kick in. */
> +	/* Kernel uses usleep_range(100, 1000), lk2nd waits 300usec */
> +	udelay(300);
> +
> +	ret = pmic_clrsetbits(priv->pmic, priv->base + PON_PS_HOLD_RST_CTL,
> +			      PON_PS_HOLD_TYPE_MASK, pmic_reset_type);
> +	if (ret) {
> +		dev_warn(dev, "RST_CTL set failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pmic_clrsetbits(priv->pmic, priv->base + enable_reg, 0,
> +			      PON_PS_HOLD_ENABLE);
> +	if (ret) {
> +		dev_warn(dev, "PON_PS_HOLD_ENABLE failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int pm8916_pon_probe(struct udevice *dev)
>  {
>  	int ret;
> diff --git a/include/pm8916_pon.h b/include/pm8916_pon.h
> new file mode 100644
> index 00000000000..cc553d43713
> --- /dev/null
> +++ b/include/pm8916_pon.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __PM8916_PON_H__
> +#define __PM8916_PON_H__
> +
> +#include <linux/errno.h>
> +#include <sysreset.h>
> +
> +#if CONFIG_IS_ENABLED(PM8916_PON)
> +int pm8916_pon_set_reboot_type(enum sysreset_t reset_type);
> +#else
> +static inline int pm8916_pon_set_reboot_type(enum sysreset_t reset_type)
> +{
> +	return -ENOSYS;
> +}
> +#endif
> +
> +#endif /* __PM8916_PON_H__ */
> 

-- 
// Casey (she/her)

