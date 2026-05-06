Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49258CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C418499D;
	Wed,  6 May 2026 16:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DsbB6xFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97951849AC; Wed,  6 May 2026 16:37:32 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B57847E1
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so6514025e9.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778078250; x=1778683050; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6GWCEtU+U8vrYi3ZVm5m9fam99s6r60RzDodQGX4x3I=;
 b=DsbB6xFMwka4HxRTa+/eMSMyvUZDePORq3hVZMVtADKa+UueS+8+NM72+jduqXCSa/
 wJmUADewZXEVndjMV2GPpxBxnzn9aji26yatIczNqHZs3HoWeQVJz9oDPLZfsMvGevQ5
 7DEDc/236pUpJvbz6p39SERI3OA0r06nIBXe6KlZqkBTtO73ulw7ycvabpFwZ4syLlRn
 aonBwztUKKOQaoMTMG3j8Kq57SHhGs6qYUlX82x3QiYliCH5C2bI7pC2X3xWCW879MSH
 hwMQO3CXhXWVXZWUnRtzzUU6JyazuIajAdawNePJ7TLx7dkxty8KM0c4EA5GwfT4vXYQ
 rMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778078250; x=1778683050;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GWCEtU+U8vrYi3ZVm5m9fam99s6r60RzDodQGX4x3I=;
 b=h54dHNrNg1Esl7mW6KCZmdnKUa62w4oT+6L4DmwWLcAn2qEE8mKEXVLw2CHzbz+YuA
 YsABjRdLOMeKvzxCo6HWBY6aJGAmG8fpGOeZ5KoSR4pHavqxJoMSKX+vTLVccMdhPAFQ
 iy2xa5/IDekadoFAh0aDqACthCBg+ixFJWBz6mq8CQO2bDDAAsGa7zTh/A0eZw36+28r
 VEUTjDBtvN12a4EsmeHZralRDEXd8y+YUGKWzPcWi0GbbE4ON6DWbmSE1Dv94YBvQA1u
 +71/79BgU4qZ3/o78eFmR+30Z3hYn5HmrBkAUa2Zu4MI9lukOj6lmLZ340eOa8pGEtMP
 7giQ==
X-Gm-Message-State: AOJu0Yw2mB8ByDp24uIkJjfdy6ZxztEYWOFVgxs1l8EtgaqZic/pOhx2
 uB7qDB7x+qaJUk7P/17EemlW7743QhFdalBpvrb41mNFoCvKXSD0LdJGDCSd2IzhCJMum3yQgxX
 Pv6J8
X-Gm-Gg: AeBDietNwn3ic8ycD1CNUQz3JIL6KbF9/n4lFpWajLdG8HBUKvzAAp559Tgk0BKgSl/
 K7styKqgo+ABb0Y8DRzECnQJg9eh25un5hvFeDicB9V2I64C72Sl8fwhvGj4m9gWIo5gP8AnEOr
 7kbSDtxdn3rIfmyoqrpNtE0KjprZjKTjO5hXpbTJRlOq0Q8nNQW2+jM6h7/GFpBg/gM5xxKI5vy
 7Tq8p/749BOPHTkx+cIIVtOGVXlqAIwth+8zcpqhOG/WM1sWH585My6druBCtVFF1SDFxUjsCQA
 9FvuwsAgy0vII+WJ27P/lyTrpIvlqZiWsinLq6rodTs5r+LXkUsgwWd0IeXRRNprfCoD9zPuEOU
 uF3wtfxEHnIq3Es7PjlnrCsoZx6+xk6FC7Y+CbnsAPiZWT0ICsn/hVxVnue6hTnU05ORlObEA2m
 lKSB2FTEsckHtYcYGQ7jjcxCiapenr60mdUntjMzpi5XU+eQJTwUDlXPqGEvvglgGFdpazneLau
 hNvQRiiTNvRbuspYg==
X-Received: by 2002:a05:600c:5291:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48e52285af1mr49512695e9.6.1778078249783; 
 Wed, 06 May 2026 07:37:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5798:67fd:c866:b378?
 ([2a01:e0a:106d:1080:5798:67fd:c866:b378])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fad5fsm57125965e9.10.2026.05.06.07.37.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 07:37:29 -0700 (PDT)
Message-ID: <0d1c9e66-62c5-491f-9fba-97f262a1153d@linaro.org>
Date: Wed, 6 May 2026 16:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] pci: brcmstb: rework iBAR handling
To: u-boot@lists.denx.de
References: <20260428163946.42D4368D12@verein.lst.de>
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
In-Reply-To: <20260428163946.42D4368D12@verein.lst.de>
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
> Rework the setup of inbound PCIe windows: use the convenience functions
> from Linux kernel commit ae6476c6de187 to calculate the BAR offsets and
> factor out the setup code into a separate function.
> 
> The Linux kernel first allocates and populates an array of inbound_win[]
> and sets the BARs from it later, while U-Boot does it all on the fly,
> in one go, so the code is not 1:1 comparable.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
> 
> ---
>   drivers/pci/pcie_brcmstb.c | 150 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 131 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index 8a25fb04563..05b80a45b50 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -50,6 +50,29 @@
>   #define SSC_STATUS_PLL_LOCK_MASK			0x800
>   #define SSC_STATUS_PLL_LOCK_SHIFT			11
>   
> +#define PCIE_RC_PL_PHY_CTL_15				0x184c
> +#define PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK		0x400000
> +#define PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
> +
> +#define PCIE_MISC_UBUS_CTRL				0x40a4
> +#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_ERR_DIS_MASK	BIT(13)
> +#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_DECERR_DIS_MASK	BIT(19)
> +#define PCIE_MISC_AXI_READ_ERROR_DATA			0x4170
> +#define PCIE_MISC_UBUS_TIMEOUT				0x40A8
> +#define PCIE_MISC_RC_CONFIG_RETRY_TIMEOUT		0x405c
> +#define PCIE_MISC_RC_BAR4_CONFIG_LO			0x40d4
> +#define PCIE_MISC_RC_BAR4_CONFIG_HI			0x40d8
> +#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK		0xff
> +#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_HI		0x4110
> +#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE		0x1
> +#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK		0xfffff000
> +#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO		0x410c
> +
> +#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP		0x40ac
> +#define PCIE_MISC_UBUS_BAR2_CONFIG_REMAP		0x40b4
> +#define  PCIE_MISC_UBUS_BAR2_CONFIG_REMAP_ACCESS_ENABLE_MASK	BIT(0)
> +#define  MISC_CTRL_PCIE_RCB_MPS_MODE_MASK		0x400
> +
>   enum {
>   	RGR1_SW_INIT_1,
>   	EXT_CFG_INDEX,
> @@ -437,17 +460,105 @@ static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
>   	writel(tmp, base + PCIE_MEM_WIN0_LIMIT_HI(win));
>   }
>   
> +static u32 brcm_bar_reg_offset(int bar)
> +{
> +	if (bar <= 3)
> +		return PCIE_MISC_RC_BAR1_CONFIG_LO + 8 * (bar - 1);
> +	else
> +		return PCIE_MISC_RC_BAR4_CONFIG_LO + 8 * (bar - 4);
> +}
> +
> +static u32 brcm_ubus_reg_offset(int bar)
> +{
> +	if (bar <= 3)
> +		return PCIE_MISC_UBUS_BAR1_CONFIG_REMAP + 8 * (bar - 1);
> +	else
> +		return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO + 8 * (bar - 4);
> +}
> +
> +/*
> + * Round size up to the next power of two, as required by
> + * brcm_pcie_encode_ibar_size().  If size is already a power of two
> + * fls64(size - 1) still gives the correct result because the hardware
> + * encodes the exponent, not the raw value.
> + */
> +static u64 brcm_ibar_round_size(u64 size)
> +{
> +	return 1ULL << fls64(size - 1);
> +}
> +
> +static void brcm_pcie_set_inbound_windows(struct udevice *dev)
> +{
> +	struct brcm_pcie *pcie = dev_get_priv(dev);
> +	void __iomem *base = pcie->base;
> +	bool is_2712 = (pcie->pcie_cfg->type == BCM2712);
> +	int i, ibar_no, ret;
> +	u32 tmp;
> +
> +	ibar_no = 0;
> +	/* pre-2712 chips leave the first entry empty */
> +	if (pcie->pcie_cfg->type != BCM2712)
> +		ibar_no++;
> +
> +	/* program inbound windows from OF property "dma-regions" */
> +	for (i = 0; i < 7; i++, ibar_no++) {
> +		u64 bar_cpu, bar_size, bar_pci;
> +		struct pci_region region;
> +		int ubus_bar_offset, rc_bar_offset;
> +
> +		ret = pci_get_dma_regions(dev, &region, i);
> +		if (ret)	/* no region #i? Then we're done. */
> +			break;
> +		ubus_bar_offset = brcm_ubus_reg_offset(ibar_no + 1);
> +		rc_bar_offset = brcm_bar_reg_offset(ibar_no + 1);
> +
> +		bar_pci = region.bus_start;
> +		bar_cpu = region.phys_start;
> +		bar_size = region.size;
> +
> +		if (is_2712) {
> +			/* BCM2712: BAR holds raw PCI address; UBUS remap
> +			 * registers supply the CPU-side translation. */
> +			tmp = lower_32_bits(bar_pci);
> +			u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(bar_size),
> +					  RC_BAR2_CONFIG_LO_SIZE_MASK);
> +			writel(tmp, base + rc_bar_offset);
> +			writel(upper_32_bits(bar_pci), base + rc_bar_offset + 4);
> +
> +			tmp = lower_32_bits(bar_cpu) &
> +					PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK;
> +			tmp |= PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE;
> +			writel(tmp, base + ubus_bar_offset);
> +
> +			tmp = upper_32_bits(bar_cpu) &
> +				PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK;
> +			writel(tmp, base + ubus_bar_offset + 4);
> +		} else {
> +			/* Pre-BCM2712 (e.g. BCM2711 / RPi4): the BAR config
> +			 * register holds the offset (bus_start - phys_start),
> +			 * not the raw PCI address.  The size must be rounded
> +			 * up to the next power of two before encoding. */
> +			u64 bar_offset = bar_pci - bar_cpu;
> +			u64 bar_size_po2 = brcm_ibar_round_size(bar_size);
> +
> +			tmp = lower_32_bits(bar_offset);
> +			u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(bar_size_po2),
> +					  RC_BAR2_CONFIG_LO_SIZE_MASK);
> +			writel(tmp, base + rc_bar_offset);
> +			writel(upper_32_bits(bar_offset), base + rc_bar_offset + 4);
> +			/* UBUS remap registers are not used on pre-2712 hardware. */
> +		}
> +	}
> +}
> +
>   static int brcm_pcie_probe(struct udevice *dev)
>   {
>   	struct udevice *ctlr = pci_get_controller(dev);
>   	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
>   	struct brcm_pcie *pcie = dev_get_priv(dev);
>   	void __iomem *base = pcie->base;
> -	struct pci_region region;
>   	bool ssc_good = false;
>   	int num_out_wins = 0;
> -	u64 rc_bar2_offset, rc_bar2_size;
> -	unsigned int scb_size_val;
>   	int i, ret;
>   	u16 nlw, cls, lnksta;
>   	u32 tmp;
> @@ -488,23 +599,22 @@ static int brcm_pcie_probe(struct udevice *dev)
>   			MISC_CTRL_CFG_READ_UR_MODE_MASK |
>   			MISC_CTRL_MAX_BURST_SIZE_128);
>   
> -	pci_get_dma_regions(dev, &region, 0);
> -	rc_bar2_offset = region.bus_start - region.phys_start;
> -	rc_bar2_size = 1ULL << fls64(region.size - 1);
> -
> -	tmp = lower_32_bits(rc_bar2_offset);
> -	u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(rc_bar2_size),
> -			  RC_BAR2_CONFIG_LO_SIZE_MASK);
> -	writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
> -	writel(upper_32_bits(rc_bar2_offset),
> -	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> -
> -	scb_size_val = rc_bar2_size ?
> -		       ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
> -
>   	tmp = readl(base + PCIE_MISC_MISC_CTRL);
> -	u32p_replace_bits(&tmp, scb_size_val,
> -			  MISC_CTRL_SCB0_SIZE_MASK);
> +	if (pcie->pcie_cfg->type == BCM2712) {
> +		/* BCM2712: fixed 32GB SCB0 window */
> +		u32p_replace_bits(&tmp, 20, MISC_CTRL_SCB0_SIZE_MASK);
> +	} else {
> +		/* Pre-BCM2712: size SCB0 to match the actual DMA region.
> +		 * rc_bar2_size must be a power of two; ilog2(size) - 15
> +		 * gives the hardware encoding (e.g. 1GB -> 15). */
> +		struct pci_region region;
> +		u64 rc_bar2_size;
> +
> +		pci_get_dma_regions(dev, &region, 0);
> +		rc_bar2_size = brcm_ibar_round_size(region.size);
> +		u32p_replace_bits(&tmp, rc_bar2_size ? ilog2(rc_bar2_size) - 15 : 0xf,
> +				  MISC_CTRL_SCB0_SIZE_MASK);
> +	}
>   	writel(tmp, base + PCIE_MISC_MISC_CTRL);
>   
>   	/* Disable the PCIe->GISB memory window (RC_BAR1) */
> @@ -521,6 +631,8 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	/* Clear any interrupts we find on boot */
>   	writel(0xffffffff, base + PCIE_MSI_INTR2_CLR);
>   
> +	brcm_pcie_set_inbound_windows(dev);
> +
>   	if (pcie->gen)
>   		brcm_pcie_set_gen(pcie, pcie->gen);
>   

Looks fine

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
