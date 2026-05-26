Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC34CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0316883EF9;
	Tue, 26 May 2026 09:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xkononPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6B88404D; Tue, 26 May 2026 09:13:56 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B4C80398
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49041e84237so30932915e9.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779779632; x=1780384432; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Ijv3PEgpO0+MBLX5EVAf7pjnX1IuEMo0J8S2yGrYCU0=;
 b=xkononPjCewU7hCbUyq1weeFhztnbOZjWikbYXXGkhFK1r1bJKiQ9pqH71orpzA3/a
 dZ+A6jF1LP+5sXRY+q9LgM38s2v2+m2O5zmjsmhqMpFT9RwNKHwPRV3M9Jc+ZlYg5VH4
 GGObvZez/w8QJ5YIvbGimYB/mOQQUQykGFO6wJW/+SrURzYKmRnmpwyOjFtcWqWdC/sx
 oNQL7kUAy9HVh4K/xW24kKk9OVioi3j6HfM+5zsgTixYSiEa8fWjHKE7/KSOBw/0mm9k
 4fng9U4Y2p4R+YV0tjj1/qSv3kGuv2qxhVG9UMTUbhHPVIdeeQr2BNsHoBrT9HyEu2gp
 iu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779779632; x=1780384432;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ijv3PEgpO0+MBLX5EVAf7pjnX1IuEMo0J8S2yGrYCU0=;
 b=FdThHSr8uLkBmFr3f3aB/0T9qshAfcMvNtcx14D8BZ16vNMj/RApivnuSGT7O19vxq
 0riNKubbaFSLatMWVR8HHLIFjTOymsMZbV+A3BCzCUw2rEq0U4GNM1KZ9wjy5A3vbM7z
 E8uSlJzVXysSChT5+2wwoqyH92bQxAqk1c47qe0SRgi3m2nagg19rS27b8sjCxzlbVpA
 x/iYbPAhSMwJdj9HwFlKVELKYL6Ok67CetI75L14OJQWeNcn+l2z0yjQkDhjIW6Q3jlG
 hRP+s9kaZfHvsGdX2dL2g1TbDFd/7howc8acjsvQYI3n7npgipqcviAF/YMvLGUWeSNU
 6SMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cBLnmQWT96yUwzKCv31U107N6eFlNa7hbCmz3IU0/zbiDT3mXE1n1cpGIV0/eclMRsYYGI5c=@lists.denx.de
X-Gm-Message-State: AOJu0YzOxuTb6STL+yqr6bWHXpzs2uOviYiR67QsbtMzUHsQI1yYo/yZ
 LkjL2H4KprJ3hMw8QtB8DKElG3boXK2ulvtGWz5co8/lJLwUEuFkCf0rW0wYk2DjvAE=
X-Gm-Gg: Acq92OEaIrAj1pKikZKMhFT3FrZoZdTt2pCDt0PBJScGLJK9mNmPjzvlKv8oVuw+pYX
 FKbMZlm3hg86KudREH/aGnVxA9QpZniBW0QWtaghLQ6H/lbDFWYfJds21/oiLsg1duAjaF4nnLt
 JRRECYDCEKIMUJvMuPfoKi792sm7ni4PioCLyZCJVAtOghd2w87CL5vKmd2jX8tDR1Rku5n/51d
 DvZoMp9oLQdbf5kiLwiA6vGYmKkXRuM/+IpGwnHw+9TQRIn27hsDJzefahA2om9AX0/GBb5nbyF
 q0+UImRwXlc8EdkEaW8cSuL563bJdyvHws5kiF/y4Wjzq/qzfqYWMYOJDrY+1JudTIr8MlfvK+v
 dSEwEMr7WEa1RMuwDYt0cXIHm3OqftzmExgwaCzsBWynNEj8/d85YJ8IdR6bZ6nqqTNzcWNXVkF
 C76By058otLnUb8vFHAszymTmKpGf1zwH27hIg6IckeltTFKbIDfFla/WcL2ALOFyHK7tRe4tw3
 vKabGM=
X-Received: by 2002:a05:600c:c4a4:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-4904225fbdamr259240225e9.2.1779779632000; 
 Tue, 26 May 2026 00:13:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm299397195e9.11.2026.05.26.00.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:13:51 -0700 (PDT)
Message-ID: <d9bcb2b8-c5cd-4c4a-9e88-d58c79d37dc4@linaro.org>
Date: Tue, 26 May 2026 09:13:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] pci: brcmstb: Get and use bridge and rescal reset
 properties
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
 <20260523163435.E58D768D12@verein.lst.de>
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
In-Reply-To: <20260523163435.E58D768D12@verein.lst.de>
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
> Check whether the device tree has nodes for the two reset controls and use
> them if so.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
> ---
>   drivers/pci/pcie_brcmstb.c | 70 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index 5cb39dfd136..4d253440de9 100644
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
> @@ -79,6 +80,8 @@ struct brcm_pcie {
>   
>   	int			gen;
>   	bool			ssc;
> +	struct reset_ctl	rescal;
> +	struct reset_ctl	bridge_reset;
>   	const struct brcm_pcie_cfg_data *pcie_cfg;
>   };
>   
> @@ -143,14 +146,57 @@ static void brcm_pcie_perst_set_2712(struct brcm_pcie *pcie, u32 val)
>   	writel(tmp, pcie->base + PCIE_MISC_PCIE_CTRL);
>   }
>   
> -static void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
> +static int brcm_pcie_get_resets_dt(struct udevice *dev)
>   {
> +	struct brcm_pcie *pcie = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = reset_get_by_name(dev, "rescal", &pcie->rescal);
> +	if (ret) {
> +		printf("Unable to get rescal reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_get_by_name(dev, "bridge", &pcie->bridge_reset);
> +	if (ret) {
> +		printf("Unable to get bridge reset\n");
> +	}

Drop the {}

> +	return ret;
> +}
> +
> +static int brcm_pcie_do_reset(struct udevice *dev)
> +{
> +	struct brcm_pcie *pcie = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = reset_deassert(&pcie->rescal);
> +	if (ret)
> +		printf("failed to deassert 'rescal'\n");
> +	return ret;
> +}
> +
> +static int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
> +{
> +	int ret = 0;
> +
> +	if (pcie->bridge_reset.dev)

You could use reset_valid() instead

> +	{
> +		if (val)
> +			ret = reset_assert(&pcie->bridge_reset);
> +		else
> +			ret = reset_deassert(&pcie->bridge_reset);
> +		if (ret)
> +			log_err("failed to %sassert bridge reset, err=%d\n",
> +				val ? "" : "de", ret);
> +		return ret;
> +	}


Add an empty line here

>   	if (val)
>   		setbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
>   			     RGR1_SW_INIT_1_INIT_MASK);
>   	else
>   		clrbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
>   			     RGR1_SW_INIT_1_INIT_MASK);
> +	return ret;

Just return 0 instead

>   }
>   
>   /**
> @@ -405,16 +451,25 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	int num_out_wins = 0;
>   	u64 rc_bar2_offset, rc_bar2_size;
>   	unsigned int scb_size_val;
> -	int i, ret;
> +	int i, ret = 0;
>   	u16 nlw, cls, lnksta;
>   	u32 tmp;
>   
> +	/*
> +	 * Ensure rescal reset for BCM2712 is really disabled.
> +	 */
> +	if (pcie->pcie_cfg->type == BCM2712)
> +		ret = brcm_pcie_do_reset(dev);
> +	if (ret)
> +		return ret;
>   	/*
>   	 * Reset the bridge, assert the fundamental reset. Note for some SoCs,
>   	 * e.g. BCM7278, the fundamental reset should not be asserted here.
>   	 * This will need to be changed when support for other SoCs is added.
>   	 */
> -	brcm_pcie_bridge_sw_init_set(pcie, 1);
> +	ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
> +	if (ret)
> +		return ret;
>   	if (pcie->pcie_cfg->type != BCM2712)
>   		pcie->pcie_cfg->perst_set(pcie, 1);
>   	/*
> @@ -424,8 +479,9 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	udelay(100);
>   
>   	/* Take the bridge out of reset */
> -	brcm_pcie_bridge_sw_init_set(pcie, 0);
> -
> +	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
> +	if (ret)
> +		return ret;
>   	clrbits_le32(base + pcie->pcie_cfg->offsets[PCIE_HARD_DEBUG],
>   		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>   
> @@ -607,6 +663,10 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
>   		pcie->gen = max_link_speed;
>   
>   	pcie->pcie_cfg = (const struct brcm_pcie_cfg_data *)dev_get_driver_data(dev);
> +
> +	if (pcie->pcie_cfg->type == BCM2712)
> +		return brcm_pcie_get_resets_dt(dev);
> +
>   	return 0;
>   }
>   

With those changes:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
