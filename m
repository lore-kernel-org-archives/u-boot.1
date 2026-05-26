Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F244CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DDF8469F;
	Tue, 26 May 2026 09:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lkdPBDFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB8C8469D; Tue, 26 May 2026 09:03:38 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E31B846D1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so107102175e9.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779779015; x=1780383815; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=dId/ig5El0f+Nx/5QJIXDLYGzpkbIrDf4i9I3HCDtpE=;
 b=lkdPBDFMgdeTLxif+pMkGM0birzGznRkI4yFwpGn7Y6/g6be6QW1UPVhGKPmhIatVb
 5bnqO/CUDS8gigAIfoV3TxOxaRDD4PM3OLOgSf9Xm6B8nZe8mppwyaibR5AhvWmiML56
 Iulkpj+DzRApGU/edVDbIrZMEBEV2puiHug1CUwHeKgym93alNMewaNcKXzejGlcehIz
 dNmvnM+kemKFXvtcIY8TEznT3kZD7WhTR3t0Rk8b4WDYgyKBR2hpvz1NiW+GuKBtpTAd
 vX1PpBA9kIEJm94BR8+N1w8zsJWMO41GkSc72iMk+DUvZaatNd9s8BcSx2XzTZ7vuI6g
 FeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779779015; x=1780383815;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dId/ig5El0f+Nx/5QJIXDLYGzpkbIrDf4i9I3HCDtpE=;
 b=DyeCNxaxJGEmvqfJuAHcblyBKFvcXBEFG7jXd3fpnSs/vFJjqIt9kUNtr54OfX9is4
 o6q66QxH/kvNmHWAsqa+NpjoDOctwm2Q5EGyg2eyyPQafmGXxDqXaFKnhoeEKs7DVXYV
 C6sxYiS3pBuhv6w0FvOXPR4V+U81JPK9oMmKdC9FyMekJRYIow1yjlrfWfzI6QCuqLme
 EvI55JUn9Zz7I9l8HEq3s+p38UU4/4jhMl/kLQmF5+1ZQhIlij4R8spVFqa5WletrIQO
 mbdAktqpX8rbKtF+yS0KTDvLTdkrqckbt6Bw/ddK0uag8VgBdJy0GOiYqxY6ldEEMOe2
 zsdA==
X-Gm-Message-State: AOJu0YzUWbUqrwDlBxeQwdYbyVgNCX59smEDnq80W4DZlAtg3N7zADOc
 QHUiLGe9EhkQh/T7nY/IpkOiluSbDcMSZA8N8aO6BS5FQH2NBPcEWJXlG35ewMge5zc=
X-Gm-Gg: Acq92OGabsh8HfJiyK/mFp0BoNSwoWGSVAjGAMdo6R6It45NRjDYenIq95A5/ipIzU+
 cGpQ/Ou1QjsOQSNxAahU0e0wmcAyOn9cfr71QsuwwjanYAKWVena2fF7hfqMC6wYu+Q8HBGOqSO
 ikT11dEQ7RwMIzo4/Vr1/7ARMIJgbuMBV61eufoZKB/iiMQ7oiZrvTW7+Afo92RCs7+mhQwXJrS
 /beMWKpIhxjXqmXH0HcM53z6x+kEyoQMLiqB7JIuwWTD69U7zr1im74bm3QYT4fIneQYtfrbAlf
 LweC43+FPLpliXpebm4ID61J8G70PxTe8ArQmBMBogGRTPELol642WJ8KxP3DLFtsLUtBHE2iQa
 SgZT6H4c8TUgtkq6KwOXT0Ckl9kWfxrP+4wLPkN3JkzQZemxnpLtnyVzZ+fKqHG+NWDKG8zk51e
 bACQXegxP7cAbqFqOxv9jyEiunwUj1DepipxFz7v73TPMpmcAHS/PurCE3MVpkwwcYKI9slY6xx
 bH9yOs=
X-Received: by 2002:a05:600c:530c:b0:490:5527:3be2 with SMTP id
 5b1f17b1804b1-49055273be6mr191906165e9.32.1779779014673; 
 Tue, 26 May 2026 00:03:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904179826dsm135383535e9.2.2026.05.26.00.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:03:34 -0700 (PDT)
Message-ID: <f1e83dd7-5877-4c13-bfe9-37a010e11048@linaro.org>
Date: Tue, 26 May 2026 09:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] pci: imx: Use dev_read_addr_index_ptr()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
 <20260526-devfdt-pci-v1-4-ed7f31d73938@nxp.com>
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
In-Reply-To: <20260526-devfdt-pci-v1-4-ed7f31d73938@nxp.com>
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
> Use dev_read_addr_index_ptr() which support both live device tree and flat
> DT backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/pci/pcie_imx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie_imx.c b/drivers/pci/pcie_imx.c
> index 8d853ecf2c2..c8b8e171e39 100644
> --- a/drivers/pci/pcie_imx.c
> +++ b/drivers/pci/pcie_imx.c
> @@ -774,8 +774,8 @@ static int imx_pcie_of_to_plat(struct udevice *dev)
>   {
>   	struct imx_pcie_priv *priv = dev_get_priv(dev);
>   
> -	priv->dbi_base = devfdt_get_addr_index_ptr(dev, 0);
> -	priv->cfg_base = devfdt_get_addr_index_ptr(dev, 1);
> +	priv->dbi_base = dev_read_addr_index_ptr(dev, 0);
> +	priv->cfg_base = dev_read_addr_index_ptr(dev, 1);
>   	if (!priv->dbi_base || !priv->cfg_base)
>   		return -EINVAL;
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
