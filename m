Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F07CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 13:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1346846B0;
	Wed, 17 Jun 2026 15:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V90pLM68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D02848C5; Wed, 17 Jun 2026 15:49:56 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66028460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 15:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5ad4b60f6d5so495494e87.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781704193; x=1782308993; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0vFL4LNsB+iUvSHxDWhClg46/I59DCKL2TSF3yGa+oU=;
 b=V90pLM68IyYypv4HjEWZnG1BdeZqcE4QSBLd8+Mz2anf3y8UcjiC/vx8DB6wsM6jpp
 pkR2XJu2k6a/Hrzmuks2ew9SLIrV5oXwsXfHBir7Vpfbl5jYYkSjxCsVsfA79ObXgDuv
 4OtPftNYnWiNcuGekiCaiRWHiAU4hWL+bK8j7esyRXZEFsv+JsGzRCwCud7CZm8B2pFL
 CN0yg0lo2Acw+Y7mRJXSSfGagu3tK2a3H0NwYri89oAOonQNq63SKfoWIXToMbIp2Ufd
 ApXXafEtkMFrmTCgxA9GXdnO9abum7igwlT+OS2Xlq2FvfGNhNXIEgWYtIUE0pZy9r3d
 4WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781704193; x=1782308993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0vFL4LNsB+iUvSHxDWhClg46/I59DCKL2TSF3yGa+oU=;
 b=jXMcdeHooUbM/+DmBKSYEA5EWpeP4Opn5uYgkOrwn+y37Zg/TWU5Y2MLLRSYp5lGYo
 6f7y3G/qkTEKBF639AxzQZg2sMbleJCefyzsOprjOjYs3d6J/JzG5tBfnRWdaoaCrnDN
 fpFJjH1EyzsP73tgbbddL3Uwkr5zavsY2bDdPmTv7KG3d988GWGJ6eUO6gj2jsreFRml
 IRcOrDkPMjP4kJgMaG/5NCkBar3mxM9FYtPZsWI5Ay/mDiS9d3r25fbkDDvhUKlC07wX
 aSSUE5q4+JSXMCiqRL+M5eCPGdQqQ34zEBSJms91cKDXcjUDB97wATqssycKHMctbE1h
 uvYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RMCKRgUg5S3GBsEF8fjTSj1oKr0gkYpVyk352r/AyDx5mwVIQeryhb8AViMDma4yIu1uGNms=@lists.denx.de
X-Gm-Message-State: AOJu0YzS0hNXWdmY9Xd9uARmFWx1tQxpp3iyFrgLoCdzCYF6Zpzs6wAM
 c7ij3Xu5/n2RCJw8DzEOOWCb/7x2XHm+nmxs0tjD7TUf1IXt2evEXu+OjeUGlvJAbZI=
X-Gm-Gg: AfdE7cmXVp/Dgv8NRH2rVROgxsVy7Ahhgfym3za80kB83hD+tbQnvpih7rvhlNOijOb
 Dd9iKYiMzJE0sI1dh7upMA2/c4UtlJZvwXUT52IHft9LvRbHIY1DxiTN7PHdRrg+qksn9UbOPlL
 JrvTU3y0WmTaLZXH4jk2bZ7POWCaJgxIbMGXg7gnR3cyRrOmigz9r5dNNLggkgfuojj1EdVgNdd
 ercqr6kOq6CX2nbcEsfpAaKtkpSIX5A6Qwc71KkL+wADwH1y2fm2BygvVc5fQ+s29wMtRdKrK2N
 wOPwwditUZnbmQhDuvcn4wJ0dWrFATu6VrlzZ9LGbTZNUzkOf0+s9lu4P5d5bps7uuM66u9gfji
 GkfafBeRFJbVTXvqLaF1KyuB44wnStfO8932OqAQYiskBtfzuqVLK7Qe2EMu+ourT5lHONz//9V
 3m/vwpBn29eoFW4MN4sgLzYLnvd22jFKLLQEWtUYWpQemfwl9Rr3sx
X-Received: by 2002:ac2:4f0e:0:b0:5aa:8822:b874 with SMTP id
 2adb3069b0e04-5ad4701492amr1181995e87.46.1781704192785; 
 Wed, 17 Jun 2026 06:49:52 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1aea92sm4430891e87.63.2026.06.17.06.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 06:49:51 -0700 (PDT)
Message-ID: <aed5caae-2c55-4bee-938d-f85ec74c7dc6@linaro.org>
Date: Wed, 17 Jun 2026 15:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] sysreset: qcom-pshold: PM8916 PON reset type support
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
 <20260606-pm8916-pon-v1-5-170c9cbe5099@samcday.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260606-pm8916-pon-v1-5-170c9cbe5099@samcday.com>
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
> Before de-asserting PS_HOLD, PM8916 PMIC can be informed of what kind of
> reset should take place.
> 
> This might seem a little hacky/weird, but it's a byproduct of how the DT
> nodes are structured, and the way u-boot handles sysreset.

ahh yeah this is annoying that there's no DT link between these, this is
probably the best approach.

The way this is implemented right now means a board that doesn't have a
pm8916 will get at least a warning and an error on reset due to the pmic
device being missing.

Could you demote the error here to a dev_dbg() at least for the expected
-ENODEV case, and do the same in the previous patch.

> 
> The qcom,pshold node does not belong to the PMIC hierarchy. If U-Boot's
> sysreset infra was a little more flexible, we might be able to model the
> qcom,pm8916-pon driver as UCLASS_SYSRESET in order to catch the sysreset
> type and set the appropriate bits in the PMIC, before chaining to the
> pshold driver to de-assert PS_HOLD (which actually triggers the reset
> type that was written in the previous step).

I think an approach that could work better here would be to have the
pm8916-pon driver instead get a reference to the qcom,pshold in its
probe function and then have an exported qcom_pshold_register_pmic()
function. This way we keep the reset path simple and avoid the
unnecessary device lookup on platforms that don't have pm8916.

That said, I'm happy to defer something like that to a future
optimisation and get this merged more or less as-is.

Thanks and kind regards,


> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  drivers/sysreset/sysreset_qcom-pshold.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
> index 45290478536..20ddb4ae4ec 100644
> --- a/drivers/sysreset/sysreset_qcom-pshold.c
> +++ b/drivers/sysreset/sysreset_qcom-pshold.c
> @@ -13,6 +13,8 @@
>  #include <sysreset.h>
>  #include <asm/io.h>
>  #include <linux/delay.h>
> +#include <dm/device_compat.h>
> +#include "pm8916_pon.h"
>  
>  struct qcom_pshold_priv {
>  	phys_addr_t base;
> @@ -22,6 +24,13 @@ static int qcom_pshold_request(struct udevice *dev, enum sysreset_t type)
>  {
>  	struct qcom_pshold_priv *priv = dev_get_priv(dev);
>  
> +	if (CONFIG_IS_ENABLED(PM8916_PON)) {
> +		int ret = pm8916_pon_set_reboot_type(type);
> +
> +		if (ret)
> +			dev_err(dev, "Failed to set reboot type: %d\n", ret);
> +	}
> +
>  	writel(0, priv->base);
>  	mdelay(10000);
>  
> 

-- 
// Casey (she/her)

