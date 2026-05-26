Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27981CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2488484F;
	Tue, 26 May 2026 09:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FMozaBna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D3784851; Tue, 26 May 2026 09:08:08 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CFA98469D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so34907905e9.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779779286; x=1780384086; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=WQklImkSdxJjMlSWQKR+Gir6uQePzzfsv55JMtgwUk0=;
 b=FMozaBna+7t+i/pZUqxtGX4pBezI8TNkvPD6pRp27DJOf1CG25pYDpbx4y6Ckm8BX2
 sJ8TeypNEa7nihTEnBmYrJVN5oyB8tW8VbLY7ND52K82/UOJcBwpvCtOgtDyEOo4XLe0
 7NtC99idA/36HzerqPUsoCf6YLVZf5GDSix6wB8guXYDLH4TtPjw/IRwNtSrQGsi5mio
 tnmI+Pun+lXN7TU8WFRyq/35CRtbwBKADg3d69DBaasru1r5SKlSRMCdKgWsMCE4C/9v
 MDAyYfbV9UGzdlKTP45vh9Y8dsJ+LmBKJInxpeP1mT/2tdhZc1UHZAI+JWHHhMlPmH15
 5fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779779286; x=1780384086;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQklImkSdxJjMlSWQKR+Gir6uQePzzfsv55JMtgwUk0=;
 b=skkKqd9O8tLkrtNT52/hIOvkf7tu+uG+t0w3ENNmSjvXxhNfy/CfwSygKh4I01ftc1
 B7Mpk7tHyPzrj3rz18LUB2e8GMcKoUMt3MEbebI8LWb3F1T2eAFWZi+wBYP2C/Qrl4wx
 edk5USFfHpWbRPsQuKYduZ+O7vj8PsRbGNqGVt2MFmi13vipLkDfYA4qfgF0gRmIr2wy
 9n5xpjfC6WwAPtFgn0/pe6AkF5LXEPBmaw3Wl80+uwsRfvZllLUtfotGrRcE3MeYpDrS
 mgkG9clSKCF3u9POrfuYXRjzQNlw7+hN4j/HkDdRs5/ozJ283XQloICs6xvopweNsyXV
 vbrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GQxyrcL4FGdQ6fa0by1tnAPn3XeZJYg94bFpDsbb6XxHb2RHXpyw+f7C0X+Za+Ezlb4+sEMg=@lists.denx.de
X-Gm-Message-State: AOJu0YwMYbdj/r7dAhCSb+6KVbjuO7VG0sIysG9efcvK7AIjIsGXLULj
 +MDGJ60nBCiBkjkihKNu5vlEVf2mf+Wk3bC553tF4otUrvcqELIjN9fGINH77Zbe18U=
X-Gm-Gg: Acq92OFnPtv42cdpuXFZsGnEvVlK9mpY/7tCOtUSTH0NjiONZPffloa1aXWZKdLQo0C
 b/luTq8QwXV5NJuVLNIQJ/NfnJmzor2ugFnlAJouR2ZQUvaPfFYVoBRDHCle8S9/HdQ/i3Mhuzg
 jYz3w/VBoQezlsvMwtbQw/xKULvIb/PGsVW0kclTWaJWIOPE9UZ6Sj1FWGCrUAFVZCcrvPKn+uG
 yapc5c0aipvE6hY26IVdyVZbrpSSalOidlNInq73c/Y/F0PNqnA5ffXONkpMvK3rGElUkIztuQ3
 lL91qgP0vZrAL4ba4nRKNU1zPncVYIlqtLEILj+zij4wGiukgCnl/c2hy06trW0tbPe8AfYwLiD
 +exHKs11Yf39RuNS+bCHKbJWdDBEpRX6EThHQKn5WyJEwsjrcsnGZBpY6NEwHCN8SvVfN3wicpa
 u0DUQnaZaZUi7Szng2bwV3wDMVIeAvLLZjy5qg+SZ/RqGfU4kodbW24LZNe+f2qxWf5r7+1gDh6
 9yrC4SzvYLZfk+FSg==
X-Received: by 2002:a05:600c:6290:b0:490:46df:a852 with SMTP id
 5b1f17b1804b1-49046dfaa16mr292277435e9.10.1779779285472; 
 Tue, 26 May 2026 00:08:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904179826dsm135484185e9.2.2026.05.26.00.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:08:05 -0700 (PDT)
Message-ID: <ed850be4-4883-4919-9419-961626e70223@linaro.org>
Date: Tue, 26 May 2026 09:08:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] pci: brcmstb: Support different variants using a
 cfg struct
To: Torsten Duwe <duwe@lst.de>, Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>, =?UTF-8?B?SmFuIMSMZXJtw6Fr?=
 <sairon@sairon.cz>, Andrea della Porta <andrea.porta@suse.com>,
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Stanimir Varbanov <stanimir.varbanov@suse.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou
 <me@per1cycle.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>, Elaine Zhang
 <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,
 u-boot@lists.denx.de
References: <20260523163239.8EEA768BEB@verein.lst.de>
 <20260523163428.C612768D05@verein.lst.de>
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
In-Reply-To: <20260523163428.C612768D05@verein.lst.de>
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

On 5/23/26 18:34, Torsten Duwe wrote:
> From: Torsten Duwe <duwe@suse.de>
> 
> The Linux kernel driver already had support for multiple hardware
> variants when the bcm2712 was added (see e.g. linux commit
> 10dbedad3c818 which is the last in a longer set of changes). This
> patch brings in this required infrastructure and adds a
> differentiation between 2711 and 2712 register layouts on top.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
> ---
>   .../mach-bcm283x/include/mach/acpi/bcm2711.h  |   5 +
>   drivers/pci/pcie_brcmstb.c                    | 104 ++++++++++++++++--
>   2 files changed, 99 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> index a86875b1833..5171c593c72 100644
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
> @@ -108,6 +109,10 @@
>   
>   #define PCIE_RGR1_SW_INIT_1                   0x9210
>   #define PCIE_EXT_CFG_INDEX                    0x9000
> +#define  RGR1_SW_INIT_1_PERST_MASK			0x1
> +#define  RGR1_SW_INIT_1_PERSTB_MASK			0x4
> +#define  RGR1_SW_INIT_1_INIT_MASK			0x2
> +
>   /* A small window pointing at the ECAM of the device selected by CFG_INDEX */
>   #define PCIE_EXT_CFG_DATA                     0x8000
>   
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index 47c0802df23..5cb39dfd136 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -49,6 +49,24 @@
>   #define SSC_STATUS_PLL_LOCK_MASK			0x800
>   #define SSC_STATUS_PLL_LOCK_SHIFT			11
>   
> +enum {
> +	RGR1_SW_INIT_1,
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
> +};
> +
>   /**
>    * struct brcm_pcie - the PCIe controller state
>    * @base: Base address of memory mapped IO registers of the controller
> @@ -61,6 +79,7 @@ struct brcm_pcie {
>   
>   	int			gen;
>   	bool			ssc;
> +	const struct brcm_pcie_cfg_data *pcie_cfg;
>   };
>   
>   /**
> @@ -104,6 +123,36 @@ static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)
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
> +static void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
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
> @@ -365,8 +414,9 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	 * e.g. BCM7278, the fundamental reset should not be asserted here.
>   	 * This will need to be changed when support for other SoCs is added.
>   	 */
> -	setbits_le32(base + PCIE_RGR1_SW_INIT_1,
> -		     PCIE_RGR1_SW_INIT_1_INIT_MASK | PCIE_RGR1_SW_INIT_1_PERST_MASK);
> +	brcm_pcie_bridge_sw_init_set(pcie, 1);
> +	if (pcie->pcie_cfg->type != BCM2712)
> +		pcie->pcie_cfg->perst_set(pcie, 1);
>   	/*
>   	 * The delay is a safety precaution to preclude the reset signal
>   	 * from looking like a glitch.
> @@ -374,9 +424,9 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	udelay(100);
>   
>   	/* Take the bridge out of reset */
> -	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_INIT_MASK);
> +	brcm_pcie_bridge_sw_init_set(pcie, 0);
>   
> -	clrbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
> +	clrbits_le32(base + pcie->pcie_cfg->offsets[PCIE_HARD_DEBUG],
>   		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>   
>   	/* Wait for SerDes to be stable */
> @@ -426,8 +476,7 @@ static int brcm_pcie_probe(struct udevice *dev)
>   		brcm_pcie_set_gen(pcie, pcie->gen);
>   
>   	/* Unassert the fundamental reset */
> -	clrbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1,
> -		     PCIE_RGR1_SW_INIT_1_PERST_MASK);
> +	pcie->pcie_cfg->perst_set(pcie, 0);
>   
>   	/*
>   	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
> @@ -514,14 +563,25 @@ static int brcm_pcie_remove(struct udevice *dev)
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
> +	brcm_pcie_bridge_sw_init_set(pcie, 1);
> +
> +	/*
> +	 * For the controllers that are utilizing reset for bridge Sw init,
> +	 * such as BCM2712, reset should be deasserted after assertion.
> +	 * Leaving it in asserted state may lead to unexpected hangs in
> +	 * the Linux Kernel driver because it do not perform reset initialization
> +	 * and start accessing device memory.
> +	 */
> +	if (pcie->pcie_cfg->type == BCM2712)
> +		brcm_pcie_bridge_sw_init_set(pcie, 0);
>   
>   	return 0;
>   }
> @@ -546,6 +606,7 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
>   	else
>   		pcie->gen = max_link_speed;
>   
> +	pcie->pcie_cfg = (const struct brcm_pcie_cfg_data *)dev_get_driver_data(dev);
>   	return 0;
>   }
>   
> @@ -554,8 +615,31 @@ static const struct dm_pci_ops brcm_pcie_ops = {
>   	.write_config	= brcm_pcie_write_config,
>   };
>   
> +static const int pcie_offsets[] = {
> +	[RGR1_SW_INIT_1] = 0x9210,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +};
> +
> +static const struct brcm_pcie_cfg_data bcm2711_cfg = {
> +	.offsets	= pcie_offsets,
> +	.type		= BCM2711,
> +	.perst_set	= brcm_pcie_perst_set_generic,
> +};
> +
> +static const int pcie_offsets_bcm2712[] = {
> +	[RGR1_SW_INIT_1] = 0x0,
> +	[PCIE_HARD_DEBUG] = 0x4304,
> +};
> +
> +static const struct brcm_pcie_cfg_data bcm2712_cfg = {
> +	.offsets	= pcie_offsets_bcm2712,
> +	.type		= BCM2712,
> +	.perst_set	= brcm_pcie_perst_set_2712,
> +};
> +
>   static const struct udevice_id brcm_pcie_ids[] = {
> -	{ .compatible = "brcm,bcm2711-pcie" },
> +	{ .compatible = "brcm,bcm2711-pcie", .data = (ulong)&bcm2711_cfg },
> +	{ .compatible = "brcm,bcm2712-pcie", .data = (ulong)&bcm2712_cfg },
>   	{ }
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
