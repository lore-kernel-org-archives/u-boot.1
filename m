Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310E4CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD7B84862;
	Tue, 26 May 2026 09:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C/dhZDgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C96E84851; Tue, 26 May 2026 09:06:59 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C26984851
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso33348705e9.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779779217; x=1780384017; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2icdtwkn86Cg+i+PqCVhZWx+jul8bskGPpYZq1nhkRY=;
 b=C/dhZDgFLg7S+BWEycqwxjFE5+my1WguoQwwuhHgXWwRFyZCBiJPX0RWUe0ySr3MB0
 U9mA8sHnxZkahTUHhdPTxoCIfYERN6Ql56Hfqp4zpURpzOuDeCmy1GelwB47RYEzyWvu
 nIh9/if6DP0Udq9aFcIf5nR16qmahFQ/Og+zyeP+xgxKccUEO4YWBP0X+S6wphtSUB8w
 zA3wyAVSz6ul9fThHlpd38NRFIeg/PeDQNt7fcGajvUjTRkKfuA1iXzwDSbiEzf5Rvfh
 aPi6lW+NKn26/GLHs1tk61j/BsKj5Uyp2W/G7riiihNo5Wf5240TQ6UxVzp0Iz6W121m
 kgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779779217; x=1780384017;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2icdtwkn86Cg+i+PqCVhZWx+jul8bskGPpYZq1nhkRY=;
 b=BoOm+4sLkFlk+ddy2+LskmCzH6H3LI8RQUWBR/PEfDxk7b0J07juoV9HiRDvd57/kF
 g9MmqSX3rvdZKkeqXzAysYWVwMwbpHOSgTFteyTYm3sxDWw5wa1Q64QJOJajklDYBGs8
 +qSzslxnBHnlXWVH4hJber/skr7PUTS5Pv9vv5ylUwk1s6pZtPQ6MHJ8zTquHogoLGpk
 ItTaW9U4IKaJWhZrtMuaha+KvUp01MlW6m+rzCjD31y7AeQ9hfxhX8VHWdZBdVEh/22z
 AN0LRkraUFahzl77IaXEVmBv01gXpNXBuviKWMnbjIGUCvDGKYi/NeLwlm37LyBci6gl
 FMMw==
X-Gm-Message-State: AOJu0Yx3XroQcgq7NLpCr1GZROgQC1t4zK5FLNU/hDuBfyx8d4/iLccl
 Hb0B/vni4qyglFYBXXT73On1/E3RBwpQTCs9JSfhf0hM0EHHH36whd1YXmIOorTJzbU=
X-Gm-Gg: Acq92OFl+t9pFi8sezxfM3GHZZB8QPyi/YQqxzsG3j+9cqYUD/K7aRXpkTQbR2vUn8g
 93y9plUgs2KFKKS1wcvx2Hspci3/Vq6dUmxatymKpqgmZ5EMcJZIB4+ixGdHzpkN9RO4kmPqP8g
 RFFR9ie1ynCLdMQX/Re4O/+9aPPtYDP/NG1QfRXq6sQbfyFppq/58vApFuTRPHXCbcOUEEacHRF
 zEHzRNBshve3I9AC7oSQ5pNuFFWcPXOue4/l+FiO2MaMeAJ8s7Ic5zkyRVo6xX1hTvHJt8h9cp8
 UPRLHic4efqf3c6TOp7ccP0/jNIVtnrb9MM3pxrJLQSBU2Y3Q8TMWTKFYMVI8tne0pdLm9AArjx
 89IKeK4YBWTk1LHBjro3a0rLCXT25NO+nauqY4rXefu7D+tAACwZCzCsBX4fnG92C0pqdviUFey
 2b/m+dhEVUHicGWVeAIrXtbFV1PUZuYidr+vkkejOxuhR++yZ5RDOEIXUJBhEwO6xbzahB0+WTH
 iu8kg4=
X-Received: by 2002:a05:600c:3b9f:b0:48d:35e:82cb with SMTP id
 5b1f17b1804b1-490428e93d6mr311213635e9.28.1779779216474; 
 Tue, 26 May 2026 00:06:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526ca50sm281034215e9.2.2026.05.26.00.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:06:56 -0700 (PDT)
Message-ID: <fcc1fb36-16e8-4047-b4ce-18bab8d3610e@linaro.org>
Date: Tue, 26 May 2026 09:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] pci: layerscape: ep: Use dev APIs
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
 <20260526-devfdt-pci-v1-5-ed7f31d73938@nxp.com>
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
In-Reply-To: <20260526-devfdt-pci-v1-5-ed7f31d73938@nxp.com>
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

On 5/26/26 10:09, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the Layerscape PCIe endpoint driver to use device and ofnode-based
> APIs instead of legacy FDT interfaces.
> 
> Replace devfdt_get_addr_index_ptr(), fdt_get_named_resource(),
> fdtdec_get_bool(), and fdtdec_get_int() with their modern counterparts such
> as dev_read_addr_index_ptr(), dev_read_resource_byname(),
> dev_read_bool(), and dev_read_s32_default().
> 
> Also remove the dependency on gd->fdt_blob and global data access.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/pci/pcie_layerscape.h    |  3 ++-
>   drivers/pci/pcie_layerscape_ep.c | 24 +++++++-----------------
>   2 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pcie_layerscape.h b/drivers/pci/pcie_layerscape.h
> index d5f4930e181..e6d47241e71 100644
> --- a/drivers/pci/pcie_layerscape.h
> +++ b/drivers/pci/pcie_layerscape.h
> @@ -10,6 +10,7 @@
>   
>   #include <fdtdec.h>
>   #include <pci.h>
> +#include <linux/ioport.h>
>   #include <linux/sizes.h>
>   #include <linux/types.h>
>   #include <asm/arch-fsl-layerscape/svr.h>
> @@ -164,7 +165,7 @@ struct ls_pcie_rc {
>   };
>   
>   struct ls_pcie_ep {
> -	struct fdt_resource addr_res;
> +	struct resource addr_res;
>   	struct ls_pcie *pcie;
>   	struct udevice *bus;
>   	void __iomem *addr;
> diff --git a/drivers/pci/pcie_layerscape_ep.c b/drivers/pci/pcie_layerscape_ep.c
> index 3520488b345..b7809857565 100644
> --- a/drivers/pci/pcie_layerscape_ep.c
> +++ b/drivers/pci/pcie_layerscape_ep.c
> @@ -7,7 +7,6 @@
>   #include <config.h>
>   #include <asm/arch/fsl_serdes.h>
>   #include <dm.h>
> -#include <asm/global_data.h>
>   #include <dm/devres.h>
>   #include <errno.h>
>   #include <pci_ep.h>
> @@ -16,8 +15,6 @@
>   #include <linux/log2.h>
>   #include "pcie_layerscape.h"
>   
> -DECLARE_GLOBAL_DATA_PTR;
> -
>   static void ls_pcie_ep_enable_cfg(struct ls_pcie_ep *pcie_ep)
>   {
>   	struct ls_pcie *pcie = pcie_ep->pcie;
> @@ -250,17 +247,15 @@ static int ls_pcie_ep_probe(struct udevice *dev)
>   
>   	pcie_ep->pcie = pcie;
>   
> -	pcie->dbi = devfdt_get_addr_index_ptr(dev, 0);
> +	pcie->dbi = dev_read_addr_index_ptr(dev, 0);
>   	if (!pcie->dbi)
>   		return -EINVAL;
>   
> -	pcie->ctrl = devfdt_get_addr_index_ptr(dev, 1);
> +	pcie->ctrl = dev_read_addr_index_ptr(dev, 1);
>   	if (!pcie->ctrl)
>   		return -EINVAL;
>   
> -	ret = fdt_get_named_resource(gd->fdt_blob, dev_of_offset(dev),
> -				     "reg", "reg-names",
> -				     "addr_space", &pcie_ep->addr_res);
> +	ret = dev_read_resource_byname(dev, "addr_space", &pcie_ep->addr_res);
>   	if (ret) {
>   		printf("%s: resource \"addr_space\" not found\n", dev->name);
>   		return ret;
> @@ -273,8 +268,7 @@ static int ls_pcie_ep_probe(struct udevice *dev)
>   	if (!is_serdes_configured(PCIE_SRDS_PRTCL(pcie->idx)))
>   		return 0;
>   
> -	pcie->big_endian = fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
> -					   "big-endian");
> +	pcie->big_endian = dev_read_bool(dev, "big-endian");
>   
>   	svr = SVR_SOC_VER(get_svr());
>   
> @@ -294,13 +288,9 @@ static int ls_pcie_ep_probe(struct udevice *dev)
>   	if (pcie->mode != PCI_HEADER_TYPE_NORMAL)
>   		return 0;
>   
> -	pcie_ep->max_functions = fdtdec_get_int(gd->fdt_blob,
> -						dev_of_offset(dev),
> -						"max-functions", 1);
> -	pcie_ep->num_ib_wins = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
> -					      "num-ib-windows", 8);
> -	pcie_ep->num_ob_wins = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
> -					      "num-ob-windows", 8);
> +	pcie_ep->max_functions = dev_read_s32_default(dev, "max-functions", 1);
> +	pcie_ep->num_ib_wins = dev_read_s32_default(dev, "num-ib-windows", 8);
> +	pcie_ep->num_ob_wins = dev_read_s32_default(dev, "num-ob-windows", 8);
>   
>   	printf("PCIe%u: %s %s", PCIE_SRDS_PRTCL(pcie->idx), dev->name,
>   	       "Endpoint");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
