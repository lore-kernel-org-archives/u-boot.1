Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A155FCD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 084C18490D;
	Wed,  6 May 2026 16:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bNLgoHa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55AFD8490D; Wed,  6 May 2026 16:29:41 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFE8848FD
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso50444955e9.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778077778; x=1778682578; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3Ye/pMZG2v0ew0/3UMUYdvCfL+GBo2KZ6sIV+OYxkiM=;
 b=bNLgoHa6B9ZzWvJLgx8QqIXdq7AdRsXwWOa9JBuHGA+4/uqRj6umkQKN20QeG3b7PP
 4BvIGszwCBut2TYxOQDpy1C5bZGLiNSjGbvXerd/zwzL7hOmOi8YT7ltlmU+gRG6M2Qs
 sISG6HwsaHfO0U1K3g/maqYn3IRd3/oV4hR/46TdeHbVeiPVee+UiMulxDuswBSHhb4Q
 yxmjxmN8mSwqDHDQ2vPjlDf0J3mdsEKqAui37sTWfrtPb7JttwGjKRVzRMStBAX+59HN
 /ILVljquCUrQYm7O3JhP6HQJv8yAAifJHuW/M8PxO6V3AGjUvkraFFdDR4SbKFJArQWp
 n/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778077778; x=1778682578;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Ye/pMZG2v0ew0/3UMUYdvCfL+GBo2KZ6sIV+OYxkiM=;
 b=lyyhHVbeuji+q8ybs+Huyfkm4/ykZ6wAjybGe1A2cTY7jXmQYw2kluFmMJ+NgSXwIR
 2lnRa42N+76Q9PjIIchRI3Mu07br7GXUgAV/5U+NYeyZZuKJJJghnRCIIgPax/nXo5e4
 MVXE5+AnyF2QJMSW3lrIeCDaGy4Y19Cz1IqOeZ/P5gj4a0E61/WJz5j7dEDoIWfT2Lwy
 nKSppjXlKwWjN+FdWJ6w+Jp2zIzaiDCI4BR6IPrNB9+XoN0umDIzJ9/NQs0nMKfC/Skq
 FxJc0kMNZsMGV9/HOtY8qT90hoxSdMAOrpCB7JFC18P2KYC5C1uQmRJQ+sIjTSnKfoT7
 cKVA==
X-Gm-Message-State: AOJu0Yw76Vwo8BcdAy6IbnBMiv1mOejB8jrsPAbuMr2KJT239IxNgDB+
 EPf0wUSGEJHuOIeHEtoLr1aAofEpJNMcb5YAnuTxlpX7TrXFSS/46WgoI19Vpal6PViM1Kw2vkf
 lU9gM
X-Gm-Gg: AeBDievSoj9eRmb3nLrr6r1jsRduASfgMhpuzDBn/vYY/Efm0CFeRcmWI1mYcmzeO0Q
 126QOh+5PO2dNNkdXuZ5L6C9GOd2rINCOLtZwUgy9IkuqkQ5mPs81MjvXaJDgOSoanraoihAqvx
 h14YRQz0ogC7/82HKaYRbHHy42DfB1ZAt9duxFryXd3/xaZLfKShAjE9STdemdOf7ludY+l1vm3
 uOJplBwoGzAQTB5HZTIvTSpgnCTNJoXGWPRetwEm/5HGv8Tqnl96J+ROdDBSMKV+LRTeh0olVtT
 DRjekRDfI2lfK4ugFhismG5wIYVhH5ViDOZWDKbi8Npvv14RspGlu3zs+0t0h/TaqazeXnsSW9M
 L7/UrC2f4U0rdSyNtQa9qZQu0rIjs3KcUazq8x94LZdDCmuaMAEjY47wCiDj7K+ZWAWLUSJjKME
 yPUtK3EjxIkfVDgqA0eZuAVKL9dbmkyXegRMK0cM+lC4JonJwhSseExIeNogMU74DFoGqWVREbL
 RBAw4mlJDW/G5AbIQ==
X-Received: by 2002:a05:600c:c107:b0:48e:51f8:eb37 with SMTP id
 5b1f17b1804b1-48e51f8eb65mr48033355e9.25.1778077777682; 
 Wed, 06 May 2026 07:29:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a3bb:11a4:ca24:24ed?
 ([2a01:e0a:106d:1080:a3bb:11a4:ca24:24ed])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53147bc2sm29510955e9.6.2026.05.06.07.29.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 07:29:36 -0700 (PDT)
Message-ID: <bcad697e-56f8-4256-8d24-41c5ef644ff8@linaro.org>
Date: Wed, 6 May 2026 16:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] pci: brcmstb: Support different variants using a
 cfg struct
To: u-boot@lists.denx.de
References: <20260428163925.6DF1968D07@verein.lst.de>
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
In-Reply-To: <20260428163925.6DF1968D07@verein.lst.de>
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

Hi,

On 4/28/26 18:39, Torsten Duwe wrote:
> From: Torsten Duwe <duwe@suse.de>
> 
> The Linux kernel driver already had support for multiple hardware
> variants when the bcm2712 was added (see e.g. linux commit
> 10dbedad3c818 which is the last in a longer set of changes). This
> patch brings in this required infrastructure and adds a
> differentiation between 2711 and 2712 register layouts on top.
> It also accounts for the bcm2712 reset logic quirk that the software
> init bit must not remain set, albeit the reset control location is
> only corrected in patch#6 of this series.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
> 
> ---
>   .../mach-bcm283x/include/mach/acpi/bcm2711.h  |   6 +-
>   drivers/pci/pcie_brcmstb.c                    | 122 ++++++++++++++++--
>   2 files changed, 114 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> index a86875b1833..6eb5389b858 100644
> --- a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> +++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> @@ -70,6 +70,7 @@
>   #define PCIE_MISC_RC_BAR2_CONFIG_HI               0x4038
>   #define PCIE_MISC_RC_BAR3_CONFIG_LO               0x403c
>   #define  RC_BAR3_CONFIG_LO_SIZE_MASK                0x1f
> +#define PCIE_MISC_PCIE_CTRL			  0x4064
>   #define PCIE_MISC_PCIE_STATUS                     0x4068
>   #define  STATUS_PCIE_PORT_MASK                      0x80
>   #define  STATUS_PCIE_PORT_SHIFT                        7
> @@ -107,7 +108,10 @@
>   #define PCIE_MSI_INTR2_MASK_SET               0x4510
>   
>   #define PCIE_RGR1_SW_INIT_1                   0x9210
> -#define PCIE_EXT_CFG_INDEX                    0x9000
> +#define  RGR1_SW_INIT_1_PERST_MASK			0x1
> +#define  RGR1_SW_INIT_1_PERSTB_MASK			0x4
> +#define  RGR1_SW_INIT_1_INIT_MASK			0x2
> +
>   /* A small window pointing at the ECAM of the device selected by CFG_INDEX */
>   #define PCIE_EXT_CFG_DATA                     0x8000
>   
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index 47c0802df23..261f8790528 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -49,6 +49,28 @@
>   #define SSC_STATUS_PLL_LOCK_MASK			0x800
>   #define SSC_STATUS_PLL_LOCK_SHIFT			11
>   
> +enum {
> +	RGR1_SW_INIT_1,
> +	EXT_CFG_INDEX,
> +	EXT_CFG_DATA,
> +	PCIE_HARD_DEBUG,
> +};
> +
> +enum brcm_pcie_type {
> +	BCM2711,
> +	BCM2712
> +};
> +
> +struct brcm_pcie;
> +
> +struct brcm_pcie_cfg_data {
> +	const int *offsets;
> +	const enum brcm_pcie_type type;
> +	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
> +	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +	bool (*rc_mode)(struct brcm_pcie *pcie);
> +};
> +
>   /**
>    * struct brcm_pcie - the PCIe controller state
>    * @base: Base address of memory mapped IO registers of the controller
> @@ -61,6 +83,7 @@ struct brcm_pcie {
>   
>   	int			gen;
>   	bool			ssc;
> +	const struct brcm_pcie_cfg_data *pcie_cfg;
>   };
>   
>   /**
> @@ -104,6 +127,36 @@ static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)
>   	return (val & STATUS_PCIE_PORT_MASK) >> STATUS_PCIE_PORT_SHIFT;
>   }
>   
> +static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
> +{
> +	if (val)
> +		setbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
> +			     RGR1_SW_INIT_1_PERST_MASK);
> +	else
> +		clrbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
> +			     RGR1_SW_INIT_1_PERST_MASK);
> +}
> +
> +static void brcm_pcie_perst_set_2712(struct brcm_pcie *pcie, u32 val)
> +{
> +	u32 tmp;
> +
> +	/* Perst bit has moved and assert value is 0 */
> +	tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
> +	u32p_replace_bits(&tmp, !val, RGR1_SW_INIT_1_PERSTB_MASK);
> +	writel(tmp, pcie->base + PCIE_MISC_PCIE_CTRL);
> +}
> +
> +static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
> +{
> +	if (val)
> +		setbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
> +			     RGR1_SW_INIT_1_INIT_MASK);
> +	else
> +		clrbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
> +			     RGR1_SW_INIT_1_INIT_MASK);
> +}
> +
>   /**
>    * brcm_pcie_link_up() - Check whether the PCIe link is up
>    * @pcie: Pointer to the PCIe controller state
> @@ -150,8 +203,8 @@ static int brcm_pcie_config_address(const struct udevice *dev, pci_dev_t bdf,
>   	/* For devices, write to the config space index register */
>   	idx = PCIE_ECAM_OFFSET(pci_bus, pci_dev, pci_func, 0);
>   
> -	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
> -	*paddress = pcie->base + PCIE_EXT_CFG_DATA + offset;
> +	writel(idx, pcie->base + pcie->pcie_cfg->offsets[EXT_CFG_INDEX]);
> +	*paddress = pcie->base + pcie->pcie_cfg->offsets[EXT_CFG_DATA] + offset;
>   
>   	return 0;
>   }
> @@ -365,8 +418,9 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	 * e.g. BCM7278, the fundamental reset should not be asserted here.
>   	 * This will need to be changed when support for other SoCs is added.
>   	 */
> -	setbits_le32(base + PCIE_RGR1_SW_INIT_1,
> -		     PCIE_RGR1_SW_INIT_1_INIT_MASK | PCIE_RGR1_SW_INIT_1_PERST_MASK);
> +	pcie->pcie_cfg->bridge_sw_init_set(pcie, 1);
> +	if (pcie->pcie_cfg->type != BCM2712)
> +		pcie->pcie_cfg->perst_set(pcie, 1);
>   	/*
>   	 * The delay is a safety precaution to preclude the reset signal
>   	 * from looking like a glitch.
> @@ -374,9 +428,9 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	udelay(100);
>   
>   	/* Take the bridge out of reset */
> -	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_INIT_MASK);
> +	pcie->pcie_cfg->bridge_sw_init_set(pcie, 0);
>   
> -	clrbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
> +	clrbits_le32(base + pcie->pcie_cfg->offsets[PCIE_HARD_DEBUG],
>   		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>   
>   	/* Wait for SerDes to be stable */
> @@ -426,8 +480,7 @@ static int brcm_pcie_probe(struct udevice *dev)
>   		brcm_pcie_set_gen(pcie, pcie->gen);
>   
>   	/* Unassert the fundamental reset */
> -	clrbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1,
> -		     PCIE_RGR1_SW_INIT_1_PERST_MASK);
> +	pcie->pcie_cfg->perst_set(pcie, 0);
>   
>   	/*
>   	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
> @@ -446,7 +499,7 @@ static int brcm_pcie_probe(struct udevice *dev)
>   		return -EINVAL;
>   	}
>   
> -	if (!brcm_pcie_rc_mode(pcie)) {
> +	if (!pcie->pcie_cfg->rc_mode(pcie)) {
>   		printf("PCIe misconfigured; is in EP mode\n");
>   		return -EINVAL;
>   	}
> @@ -514,14 +567,25 @@ static int brcm_pcie_remove(struct udevice *dev)
>   	void __iomem *base = pcie->base;
>   
>   	/* Assert fundamental reset */
> -	setbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_PERST_MASK);
> +	setbits_le32(base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
> +		     PCIE_RGR1_SW_INIT_1_PERST_MASK);
>   
>   	/* Turn off SerDes */
> -	setbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
> +	setbits_le32(base + pcie->pcie_cfg->offsets[PCIE_HARD_DEBUG],
>   		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>   
>   	/* Shutdown bridge */
> -	setbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_INIT_MASK);
> +	pcie->pcie_cfg->bridge_sw_init_set(pcie, 1);
> +
> +	/*
> +	 * For the controllers that are utilizing reset for bridge Sw init,
> +	 * such as BCM2712, reset should be deasserted after assertion.
> +	 * Leaving it in asserted state may lead to unexpected hangs in
> +	 * the Linux Kernel driver because it do not perform reset initialization
> +	 * and start accessing device memory.
> +	 */
> +	if (pcie->pcie_cfg->type == BCM2712)
> +		pcie->pcie_cfg->bridge_sw_init_set(pcie, 0);
>   
>   	return 0;
>   }
> @@ -546,6 +610,7 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
>   	else
>   		pcie->gen = max_link_speed;
>   
> +	pcie->pcie_cfg = (const struct brcm_pcie_cfg_data *)dev_get_driver_data(dev);
>   	return 0;
>   }
>   
> @@ -554,8 +619,39 @@ static const struct dm_pci_ops brcm_pcie_ops = {
>   	.write_config	= brcm_pcie_write_config,
>   };
>   
> +static const int pcie_offsets[] = {
> +	[RGR1_SW_INIT_1] = 0x9210,
> +	[EXT_CFG_INDEX]  = 0x9000,
> +	[EXT_CFG_DATA]   = 0x8000,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +};
> +
> +static const struct brcm_pcie_cfg_data bcm2711_cfg = {
> +	.offsets	= pcie_offsets,
> +	.type		= BCM2711,
> +	.perst_set	= brcm_pcie_perst_set_generic,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.rc_mode	= brcm_pcie_rc_mode,
> +};
> +
> +static const int pcie_offsets_bcm2712[] = {
> +	[RGR1_SW_INIT_1] = 0x0,
> +	[EXT_CFG_INDEX] = 0x9000,
> +	[EXT_CFG_DATA] = 0x8000,
> +	[PCIE_HARD_DEBUG] = 0x4304,
> +};

Why adding EXT_CFG_INDEX & EXT_CFG_DATA since they are the same for both
platforms ?

Add them when bcm7425 support is added.

> +
> +static const struct brcm_pcie_cfg_data bcm2712_cfg = {
> +	.offsets	= pcie_offsets_bcm2712,
> +	.type		= BCM2712,
> +	.perst_set	= brcm_pcie_perst_set_2712,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.rc_mode	= brcm_pcie_rc_mode,
> +};

Why do you need those bridge_sw_init_set & rc_mode callbacks id they are the
same for both platforms ?

Linux has bridge_sw_init_set, but add when bcm7278 support is required.

> +
>   static const struct udevice_id brcm_pcie_ids[] = {
> -	{ .compatible = "brcm,bcm2711-pcie" },
> +	{ .compatible = "brcm,bcm2711-pcie", .data = (ulong)&bcm2711_cfg },
> +	{ .compatible = "brcm,bcm2712-pcie", .data = (ulong)&bcm2712_cfg },
>   	{ }
>   };
>   

Thanks,
Neil
