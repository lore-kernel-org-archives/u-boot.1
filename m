Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2DBCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68781848FD;
	Wed,  6 May 2026 16:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CoNcof7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852958498E; Wed,  6 May 2026 16:37:21 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B6C847E1
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso49139235e9.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778078239; x=1778683039; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=EFyiiEho6aZ5PKVVo92pqXLaeRAKb8IjlJU7LGx+LcA=;
 b=CoNcof7SiraAQijGDZdrCivRIfg/Kn04aiX4kD601x9JcxFK7MgHf4TT+5CH8Q40XV
 1SErkDNJAkgpfZi5RYJKMdcC7HShzGFDQp72k7DTj2S6ufwXVAJZSfOM4oGp5094Aw7Q
 yEvJJ7wpJhIQjAOrMSsuEbXCAa3QMezJcG/+j1r7e+abHFtjd5lbYvZm0N3i5rEO/uhS
 5q0ndNSPWUCLqKt45LmvU7Awx7Vr1aPYucecPHt2hmFBO2VSjP5KSMQgdWPFrCABhYFb
 Ft2ncisv/lEijMQUlXd+aUVPp7VtAU9ZjPhHQkPmwUSlOV6gdN9z17pnlOpr01HnNdlC
 oOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778078239; x=1778683039;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFyiiEho6aZ5PKVVo92pqXLaeRAKb8IjlJU7LGx+LcA=;
 b=AIxgbSoCUO+ZBj2a6MvENj+pJvq46qJJKnKoNYyV9958eMsF1v2C8p4x1YSHP9onm/
 vBHfd6NGCGDfAKFDKiAFMnSe/QBc6vhImnjPqp5M7IJq+y06+ezyw5oO7C9ZctUtTr4j
 a2foA31yNHjgNqRhaD+sJ7YzYNpBnYyC03mwe4zilKAr1aWOS261qHwcpDTy70Xb/T7o
 nsp39oMLjKRy5qFr+KwfJ2UyhBf2Mjd7K6cjHzSJSIJSR71QEu8FbpCVpLXDExnytXw8
 CCueAm+0nCP6MO3NoRGyIu1GmTALz1SyeUMR5pNkeI2jFFcU1K3ffzGMndpIae2htLp0
 InMw==
X-Gm-Message-State: AOJu0YywAtDIspsKtFlfZHbjU8wU8sO4ptuJzb40nj3SkR3O3crf5YfR
 zNopATGyuYAEtRFkk7lugU3e6Q2MMO5Tl/5B7sSSjJbv6WHHk5D50jr0+rdXSkDIDqMooBZHwwf
 x4ZOP
X-Gm-Gg: AeBDiet8TtTth9WUrBCIqKOyFni+lWiaFA2+L2mmY61fs+An3JkFcCnX3IS8YKwRiRJ
 PqVzGlA5h7xtDY1/6eQQ29LQry/Ie77aGFcV8b9mSqLlb3Oyh54QBYwC29dVYO475qdeuKMOtr4
 ng1pNqmT7NwiV6+zoY5E3TitrtTcLnmvho6TlqpMzmnf0B5C9Sdd6BNQiMduz2xhzkh9D6MON5Z
 zX4dA0+qQ3xU7KnJ3i9vB2R7N02ks5Nx2pZKK6+Thr+9fwuqo4rFZljnhx/uJ+b3keNkuIsA8ju
 Dfj/37ty54Hq3Aqr+BYrE2vqc2S3pmDz3FDxVSB/0g6+62nvtrr7cM970SKlEPUhtd4WD8U69DA
 mf5IiiKiqDUyNplJDYfJhZD9FDPrRPRHPY4MvHqICmG9RA7ol6eqtjjEfgKSHvVLKP+j3RzL+xY
 SXmThLowyWc2S8EzjhzID6PcVfM1/+2zL0ya6vkk6xWouwjj9vmFERuE5EVhlFr0xlYDrra5mi
X-Received: by 2002:a05:600c:c4a3:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48e51f258damr60700355e9.9.1778078238155; 
 Wed, 06 May 2026 07:37:18 -0700 (PDT)
Received: from [192.168.1.36] (82-64-67-166.subs.proxad.net. [82.64.67.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53895cb5sm47857995e9.1.2026.05.06.07.37.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 07:37:17 -0700 (PDT)
Message-ID: <fc11057b-edd2-428b-a67d-1cc22bd79492@linaro.org>
Date: Wed, 6 May 2026 16:37:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] pci: brcmstb: Adapt to AXI bridge
To: u-boot@lists.denx.de
References: <20260428163950.9BB2668D09@verein.lst.de>
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
In-Reply-To: <20260428163950.9BB2668D09@verein.lst.de>
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
> Fix-ups for the BCM root complex when it is located behind an AXI
> bridge and clocked with 54MHz.  Some are from kernel commit
> 377bced88c326, some where picked by Oleksii off a now-stale older
> branch. All reworked for the simpler setup code in U-Boot.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
> 
> ---
>   .../mach-bcm283x/include/mach/acpi/bcm2711.h  |  1 +
>   drivers/pci/pcie_brcmstb.c                    | 64 ++++++++++++++++++-
>   2 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> index 6eb5389b858..869482eaffe 100644
> --- a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> +++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> @@ -54,6 +54,7 @@
>   #define  MISC_CTRL_CFG_READ_UR_MODE_MASK          0x2000
>   #define  MISC_CTRL_MAX_BURST_SIZE_MASK            0x300000
>   #define  MISC_CTRL_MAX_BURST_SIZE_128             0x0
> +#define  MISC_CTRL_MAX_BURST_SIZE_128_2712		0x100000
>   #define  MISC_CTRL_SCB0_SIZE_MASK                 0xf8000000
>   
>   #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO          0x400c
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index 05b80a45b50..f0b0f1cc117 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -551,6 +551,30 @@ static void brcm_pcie_set_inbound_windows(struct udevice *dev)
>   	}
>   }
>   
> +static void brcm_pcie_munge_pll(struct brcm_pcie *pcie)
> +{
> +	u32 tmp;
> +	int ret, i;
> +	u8 regs[] =  { 0x16,   0x17,   0x18,   0x19,   0x1b,   0x1c,   0x1e };
> +	u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x5030, 0x0007 };
> +
> +	ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, SET_ADDR_OFFSET,
> +				   0x1600);
> +	for (i = 0; i < ARRAY_SIZE(regs); i++) {
> +		brcm_pcie_mdio_read(pcie->base, MDIO_PORT0, regs[i], &tmp);
> +		debug("PCIE MDIO pre_refclk 0x%02x = 0x%04x\n",
> +		      regs[i], tmp);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(regs); i++) {
> +		brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i], data[i]);
> +		brcm_pcie_mdio_read(pcie->base, MDIO_PORT0, regs[i], &tmp);
> +		debug("PCIE MDIO post_refclk 0x%02x = 0x%04x\n",
> +		      regs[i], tmp);
> +	}
> +
> +	udelay(200);
> +}
> +
>   static int brcm_pcie_probe(struct udevice *dev)
>   {
>   	struct udevice *ctlr = pci_get_controller(dev);
> @@ -592,12 +616,27 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	/* Wait for SerDes to be stable */
>   	udelay(100);
>   
> +	if (pcie->pcie_cfg->type == BCM2712) {
> +		/* Allow a 54MHz (xosc) refclk source */
> +		brcm_pcie_munge_pll(pcie);
> +		/* Fix for L1SS errata */
> +		tmp = readl(base + PCIE_RC_PL_PHY_CTL_15);
> +		tmp &= ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
> +		/* PM clock period is 18.52ns (round down) */
> +		tmp |= 0x12;
> +		writel(tmp, base + PCIE_RC_PL_PHY_CTL_15);
> +	}
> +
> +	tmp = (pcie->pcie_cfg->type == BCM2712) ?
> +			MISC_CTRL_MAX_BURST_SIZE_128_2712 :
> +			MISC_CTRL_MAX_BURST_SIZE_128;
>   	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
>   	clrsetbits_le32(base + PCIE_MISC_MISC_CTRL,
>   			MISC_CTRL_MAX_BURST_SIZE_MASK,
>   			MISC_CTRL_SCB_ACCESS_EN_MASK |
>   			MISC_CTRL_CFG_READ_UR_MODE_MASK |
> -			MISC_CTRL_MAX_BURST_SIZE_128);
> +			MISC_CTRL_PCIE_RCB_MPS_MODE_MASK |
> +			tmp);
>   
>   	tmp = readl(base + PCIE_MISC_MISC_CTRL);
>   	if (pcie->pcie_cfg->type == BCM2712) {
> @@ -617,6 +656,29 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	}
>   	writel(tmp, base + PCIE_MISC_MISC_CTRL);
>   
> +	if (pcie->pcie_cfg->type == BCM2712) {
> +		/* Suppress AXI error responses and return 1s for read failures */
> +		tmp = readl(base + PCIE_MISC_UBUS_CTRL);
> +		u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_ERR_DIS_MASK);
> +		u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_DECERR_DIS_MASK);
> +		writel(tmp, base + PCIE_MISC_UBUS_CTRL);
> +		writel(0xffffffff, base + PCIE_MISC_AXI_READ_ERROR_DATA);
> +
> +		/*
> +		 * Adjust timeouts. The UBUS timeout also affects CRS
> +		 * completion retries, as the request will get terminated if
> +		 * either timeout expires, so both have to be a large value
> +		 * (in clocks of 750MHz).
> +		 * Set UBUS timeout to 250ms, then set RC config retry timeout
> +		 * to be ~240ms.
> +		 *
> +		 * Setting CRSVis=1 will stop the core from blocking on a CRS
> +		 * response, but does require the device to be well-behaved...
> +		 */
> +		writel(0xB2D0000, base + PCIE_MISC_UBUS_TIMEOUT);
> +		writel(0xABA0000, base + PCIE_MISC_RC_CONFIG_RETRY_TIMEOUT);
> +	}
> +
>   	/* Disable the PCIe->GISB memory window (RC_BAR1) */
>   	clrbits_le32(base + PCIE_MISC_RC_BAR1_CONFIG_LO,
>   		     RC_BAR1_CONFIG_LO_SIZE_MASK);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
