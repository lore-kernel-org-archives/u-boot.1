Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B117CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE5584825;
	Tue, 26 May 2026 09:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iRWQW2gu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B91C484837; Tue, 26 May 2026 09:01:05 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC4FF846C0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4903974854dso40253205e9.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779778863; x=1780383663; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Ur9pX7DQkNF86vlxeqC2vZvgcK5VrhD3k3EnAuYDJv0=;
 b=iRWQW2gukhgOa4oSP28+B2of7e+2AkRcQpuQBTfcXXQl+LK21ADpEZyCAlTqLAJl/4
 2Brp4qwWTm/VKgGkI2Lscsmz9jV2XYU1DNV+snnicxSKl2WCXIM3TuQVFyVZrUDHo4YL
 zSFT4rgV2n9c6dSTb20Fkz6maaBRqg73PLALa0VqXGi1lPJ9ReoMafrBIPfDhvRW4eGv
 lys+QOQcc2IekYQOdyQQuDZcxxuR5OQKkMErL6g0FWYc9bA9m5yc3RkCbmb8mJ47FR8c
 t5lgq4QhQ29ewXtdgatfjYannY1lLnzr3xw3BdnF85JqZqUt512hQgsuegNgOkj1hkDg
 7jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779778863; x=1780383663;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ur9pX7DQkNF86vlxeqC2vZvgcK5VrhD3k3EnAuYDJv0=;
 b=JSn03PD5YgvlRAOVhRlOMCpyomtv14kwXMftoY9f7xp51AGPY+C83XD5tZywDK+dV3
 SnkM8KnTYr9In25csl+3v9eYa8wQRKo2jnEOA9EIvmoIbPuVOcw9Be++iqnnmpVytU37
 IwH+MR+hliZ952jt866cawfCWskx20DFtInw0cSyxzNkStMwREN6PPCEtamDUnMcYapW
 xYMM3gIcESaSE31b3sGSLfUaYK9ApbCekDF1CJlpVzq7F+u22pP0urcHodNMWPGPma+9
 B8Srcu3rUQIfVqKf3W8QZYiL/9SJnerPcd0FEfVdmVJU6ihxIrxEwMz7ursypnSLhYmJ
 wuiQ==
X-Gm-Message-State: AOJu0YzNo21ciUahVs/etQcl//G2bxB+XLz9frMAGYT87mOLSTknZqCN
 8NvCyMD7PRg18KNsBjM422Cx7ZBwxv68jfFmhBWYyzceYI05tL76eHtD7mzwZgjLjN8=
X-Gm-Gg: Acq92OE0eH6SyXo2mAWJrEzNkIm+Tv0inFRgp5B0Sm5yNkuZRCYPaEeL9FbcFmW9G3R
 6vt0V9E6/AHOOiZh0sDVOM644gPlmgXZ1uRcxbnzffPgDuwn87DiYyU0prlK30aSEUy6yGCTf20
 PTvJKbazbi/aLwZag80cL0qOV37zlP1u2ANkXi1WhiUGzmaDPMdFdZlQKlQzz5lSKESgrCleqa6
 Ts4yCDtNhuI3GPJsySFKntL6U8UmAEFD0j3Y+AQ9xU6OZ1GW6/fCN8ZCmJpy4tbYkUcIFKC5vKM
 175gv0Z9S7XVitkmN8rBSxrMrYVLPh+c97r3Vkh1T4u9B1ZwCVFUMbRQzoMTX0Nste7MfAKh5gt
 UfcuvgY/uocOqy/JMYchxpuuxhkx9zbfLnCH4p/rPUMg6vh2CLKyhArRa0EwJQ7C4nLPtjw1e0k
 JtopOJEdjhkVsxToFzIBFVS+4Siq1wa5rovGKvA6sPQvrPz3eNZk85cFjXMXUuo3p9jCFe1M/7V
 wuuB+Dv0iIZ9oJMYw==
X-Received: by 2002:a05:600c:5298:b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-490428dd523mr286029715e9.25.1779778861574; 
 Tue, 26 May 2026 00:01:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49049093822sm124025225e9.0.2026.05.26.00.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:01:00 -0700 (PDT)
Message-ID: <9e37c710-9a2c-4a9e-a45a-227d8b8b85a4@linaro.org>
Date: Tue, 26 May 2026 09:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pci: mpc85xx: Simplfy code with dev_remap_addr()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
 <20260526-devfdt-pci-v1-2-ed7f31d73938@nxp.com>
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
In-Reply-To: <20260526-devfdt-pci-v1-2-ed7f31d73938@nxp.com>
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
> devfdt_get_addr_ptr() + map_physmem() could be simplifed with
> devfdt_remap_addr(). But to avoid direct dependency on devfdt_* helpers,
> use dev_remap_addr().
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/pci/pci_mpc85xx.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci_mpc85xx.c b/drivers/pci/pci_mpc85xx.c
> index c07feba7976..96550a9ff8f 100644
> --- a/drivers/pci/pci_mpc85xx.c
> +++ b/drivers/pci/pci_mpc85xx.c
> @@ -170,13 +170,14 @@ static int mpc85xx_pci_dm_remove(struct udevice *dev)
>   static int mpc85xx_pci_of_to_plat(struct udevice *dev)
>   {
>   	struct mpc85xx_pci_priv *priv = dev_get_priv(dev);
> -	fdt_addr_t addr;
> +	void __iomem *addr;
>   
> -	addr = devfdt_get_addr_index(dev, 0);
> -	if (addr == FDT_ADDR_T_NONE)
> +	addr = dev_remap_addr_index(dev, 0);
> +	if (!addr)
>   		return -EINVAL;
> -	priv->cfg_addr = (void __iomem *)map_physmem(addr, 0, MAP_NOCACHE);
> -	priv->cfg_data = (void __iomem *)((ulong)priv->cfg_addr + 4);
> +
> +	priv->cfg_addr = addr;
> +	priv->cfg_data = priv->cfg_addr + 4;
>   
>   	return 0;
>   }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
