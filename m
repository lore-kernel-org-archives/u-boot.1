Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9A2CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B59B848FD;
	Wed,  6 May 2026 16:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U/KniSN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 509A68490D; Wed,  6 May 2026 16:34:41 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12123847E1
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d73422431so6128161f8f.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778078078; x=1778682878; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2uYFKBuRFNh/3u/M5mOiGT8BfGUH1UhZPROysbX4AIk=;
 b=U/KniSN3K3uJQmvwwVLR6fAMvsDhpbJ6oP3M48JEIRMXMC6IvFCq+la/dd8wnM4QN6
 n+ks/LFlTh8kMOO5dFNFU5/VbaOmlHMb+S19r0F/S39JRmWKBGnmVgOLXHNQk6mkptQb
 z2U1/04V1KWXc1zkOU7GvpMcgNY7cSErUpuW7Ck7BdpMiNVrWqmk1fVDyNP6nAGCqZsj
 MZwcCr8b0YOgXmC0gTOEns2mwm8tY9P4dy9tEzxobZm63XjDlXWlCEarMeUclwTWMhzC
 BfmVYHFsjfIBCw9BhNJOmvNfGizfk6iNZieLlAA8IKi2RnUhAGUnfKP5rzZu14RDpQbw
 QFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778078078; x=1778682878;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2uYFKBuRFNh/3u/M5mOiGT8BfGUH1UhZPROysbX4AIk=;
 b=poUpFGHmuNDU1LXMXqqCYmhTQ61lLKZYl8cgyGvDygmg0EhLnX+hUWRe/CeHtOwH2b
 DR6Ttt9C6i3lqgbd4jTtQAryTsqDHsn/DhY77NEw/YW/LuEBhuSJfaaQTa7uyJms/s5Q
 5PA/u6IaF88Iej5n1n4zEF5FQw/hrjv5WIaJEnKcaUVrX1lDZ85O9nbQ/FpyeTCP+b3z
 gA0MD5AKokMPye7e3WMSvGLqk47QPJdT0EqoJHnwJDXEGerrju5wT5E055Wk4e9yg2Kw
 aITWNx1LqN2PWi6FBS8X7A+sZCJRooyT1DhSfYzg9zm3+sF7/lh+ns8IFfd3stXygCFe
 R0hA==
X-Gm-Message-State: AOJu0YwAN0TIopCHRH4/ra241TmABjPPuogj59XPot4jaidACROGBfk3
 BRjEplPw15/n7QvfeC0d8DqRrQfpk4yMlaKlLBW92lcNluAlOJsmIXmWlnDYanTKKsdBeL/+tOc
 8kWnl
X-Gm-Gg: AeBDiesFmL2QW4i35ai8VvrTiKbG9OBXlIkpKDAioDpD78Tmm5le1lYO5Trm0z0iP6e
 hNzUOS8qPCPXuivt9ry6oB6+cX8uZIWYCWeZdPoIVamTtZRFbGYS5aTXndiPge5jw0N6cpoJdsX
 vUXRSlXCa+eqdDpuL83lbz/W0+klyn9OABOkCK4aMHvIDy6HQl1x9PVBpEjgwB4FdOPbcEqiZNp
 IIDp0fhJwWGXWKfDjnvTNwtRcJU724Fcm5xUszqBB5G4EXr0eATOVrxQRrvFIIO+efm/6M88/X7
 QHkIOD8cNyvVhFJbg1wrqCyMhPORvQ4Wj35nojzvzV0ayonWBh7thXL/EsrmD34d+IFfM+lh9BW
 a8BphFWHABNK5XlNOECkCnXK1kMG4hnjATHYP5D4kHkkSxtFNUgN9lKEjK4dwye2vBEvLEA9eY6
 p75kSkuSW4WHl4vC8k8IxAobI9IXZiO5mG3vf1ONIua1fT384qAHwFSoO2zg+o5ppkjiNKuovsc
 XyPAFETRjQdQfnWWLKUrvz00No8
X-Received: by 2002:a05:6000:4210:b0:439:b1c3:84c8 with SMTP id
 ffacd0b85a97d-4515cd27a66mr6188228f8f.21.1778078078210; 
 Wed, 06 May 2026 07:34:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a3bb:11a4:ca24:24ed?
 ([2a01:e0a:106d:1080:a3bb:11a4:ca24:24ed])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960973sm12843571f8f.30.2026.05.06.07.34.37
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 07:34:37 -0700 (PDT)
Message-ID: <f46be233-e35e-4a42-8663-342e9913e784@linaro.org>
Date: Wed, 6 May 2026 16:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] pci: brcmstb: Get and use bridge and rescal reset
 properties
To: u-boot@lists.denx.de
References: <20260428163936.7987968D09@verein.lst.de>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260428163936.7987968D09@verein.lst.de>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/28/26 18:39, Torsten Duwe wrote:
> From: Torsten Duwe <duwe@suse.de>
> 
> Check whether the device tree has nodes for the two reset controls and use
> them if so.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
> 
> ---
>   drivers/pci/pcie_brcmstb.c | 51 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index 261f8790528..1f97cda5cc7 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -21,6 +21,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/log2.h>
>   #include <linux/iopoll.h>
> +#include <reset.h>
>   
>   /* PCIe parameters */
>   #define BRCM_NUM_PCIE_OUT_WINS				4
> @@ -83,6 +84,8 @@ struct brcm_pcie {
>   
>   	int			gen;
>   	bool			ssc;
> +	struct reset_ctl	rescal;
> +	struct reset_ctl	bridge_reset;
>   	const struct brcm_pcie_cfg_data *pcie_cfg;
>   };
>   
> @@ -147,6 +150,34 @@ static void brcm_pcie_perst_set_2712(struct brcm_pcie *pcie, u32 val)
>   	writel(tmp, pcie->base + PCIE_MISC_PCIE_CTRL);
>   }
>   
> +static void brcm_pcie_get_resets_dt(struct udevice *dev)
> +{
> +	struct brcm_pcie *pcie = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = reset_get_by_name(dev, "rescal", &pcie->rescal);
> +	if (ret) {
> +		printf("Unable to get rescal reset\n");
> +		return;

Why don't you return the return value ?

> +	}
> +
> +	ret = reset_get_by_name(dev, "bridge", &pcie->bridge_reset);
> +	if (ret) {
> +		printf("Unable to get bridge reset\n");
> +		return;
> +	}
> +}
> +
> +static void brcm_pcie_do_reset(struct udevice *dev)
> +{
> +	struct brcm_pcie *pcie = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = reset_deassert(&pcie->rescal);
> +	if (ret)
> +		printf("failed to deassert 'rescal'\n");

Ditto

> +}
> +
>   static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>   {
>   	if (val)
> @@ -157,6 +188,14 @@ static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val
>   			     RGR1_SW_INIT_1_INIT_MASK);
>   }
>   
> +static void brcm_pcie_bridge_sw_init_set_2712(struct brcm_pcie *pcie, u32 val)
> +{
> +	if (val)
> +		reset_assert(&pcie->bridge_reset);
> +	else
> +		reset_deassert(&pcie->bridge_reset);

Ditto

> +}
> +
>   /**
>    * brcm_pcie_link_up() - Check whether the PCIe link is up
>    * @pcie: Pointer to the PCIe controller state
> @@ -413,6 +452,12 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	u16 nlw, cls, lnksta;
>   	u32 tmp;
>   
> +	/*
> +	 * Ensure rescal reset for BCM2712 is really disabled.
> +	 */
> +	if (pcie->pcie_cfg->type == BCM2712)
> +		brcm_pcie_do_reset(dev);

Ditto

> +
>   	/*
>   	 * Reset the bridge, assert the fundamental reset. Note for some SoCs,
>   	 * e.g. BCM7278, the fundamental reset should not be asserted here.
> @@ -611,6 +656,10 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
>   		pcie->gen = max_link_speed;
>   
>   	pcie->pcie_cfg = (const struct brcm_pcie_cfg_data *)dev_get_driver_data(dev);
> +
> +	if (pcie->pcie_cfg->type == BCM2712)
> +		brcm_pcie_get_resets_dt(dev);

Ditto

> +
>   	return 0;
>   }
>   
> @@ -645,7 +694,7 @@ static const struct brcm_pcie_cfg_data bcm2712_cfg = {
>   	.offsets	= pcie_offsets_bcm2712,
>   	.type		= BCM2712,
>   	.perst_set	= brcm_pcie_perst_set_2712,
> -	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_2712,

Can't you mimic linux and check for the reset in brcm_pcie_bridge_sw_init_set_generic ?

>   	.rc_mode	= brcm_pcie_rc_mode,
>   };
>   

Thanks,
Neil
