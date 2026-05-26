Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEF9CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40B2F846C0;
	Tue, 26 May 2026 09:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MmSlwiua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08EF8470E; Tue, 26 May 2026 09:01:55 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDA883FF5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68707d88626so12156109a12.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779778913; x=1780383713; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=LYicqlCwNbsJzMQNtp52exgX4ixUqx3RnE1ulqem+Zk=;
 b=MmSlwiuaRuSpcJSY/ovdu3ESAF7uNV+IfFrDth8JYHNuPAErLzsjyPnygeRVBEP3DV
 K/F9qlhAlooIJywexMLL+wur2JhRhzqp/8R3srPCv372huJnYhnvSBJ+IEjITONstbaW
 m+FoAbO00FZ4bRCObi2eDVWvsBuPTgt95QN5VzaobN1J91Q1/jfF/yR4p20Z5R6iXo7a
 opG2DQvlOIztL2HB1/LVDyZd58Kv2QYg95qXWoA/PI2pyFbciioF32Z6QaKlSs40DcUK
 VC8AURQ6xtjZWEswc3bK3+xmQj+FJ3NqVVRdCkXUapWNzi5E5DChYrlDcZW1oBqlymjl
 to7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779778913; x=1780383713;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYicqlCwNbsJzMQNtp52exgX4ixUqx3RnE1ulqem+Zk=;
 b=dcq9unlLwJuAD7A6iyIGvwh3QzWbyr/FjycPfSh6kVNz7IOoyNGeHgO/PmjwE8Jaf1
 uN6w7svLRuKTryaKD42aXR8gO9ZjKaEb5mcYlSsV3DdKAz+CXP4pA+fmDFrit3TR9TZF
 GS0mEq50ECDLoZyB1WdkPRwY/Wts5bahR2L//7lKzsddlmZTZ5YhrRI+wjBM+s+tyizx
 X2/60wbEX7gNKs5l2xlLRmgQulY5XJhjYDHeXZeuZaoHzroPbvhW7lfAjBvLgUkS7Bkq
 zQFyd3SUVTfw1TdokoLwGiQ+3NCjvTgpBqo1fWmkTo1Qy5PZZUaoy4gmYbt6GzV0Kv3H
 4SGg==
X-Gm-Message-State: AOJu0YznggvqIIiNyv8/diE5w2T0V4ej1MnKTiFpWWIjupJuKalU1Qxe
 mx2hZ78ZteCBQziGXpOfjZc+ea4uNRqhW8tYev1FMFy6svlIsqbSseuAsYd1nmXEyuQ=
X-Gm-Gg: Acq92OE1zM3K5bsidxryGtJnCAlK7YzVsG+6V7Pltc1Sg6x3q3B4oowdyT1uX4Eo6+X
 qpMgqWfz/d6/Ama8G/Jdoz9T3ADNxj/XtPcm/Z4Dvi5PPulAC6ENkgrnJdlwqyG9WEKRlGQGyrp
 ELHR5wTxHna1BA5sIAEHjRPwfv+DyHISvlBPM28GA4KutPoC88TIu05FIipA0j1odoNxosdNQwK
 xc+rIbpCZxiQXsEe2YLNw7TmVLKZhpogoghisfNJNdcJ3LvTgJdpFhXPCJQyn+ZK/XpdUQKMMR6
 G3CJemVAcGZpEBdExBo6oSEKCQd3A5DIl99iYL7Rra7UGoGCM0fdUa+2ofX3qUjszqXbGCeVPX6
 +e648KD+yLZOQ3argpNH2sPWa0uvZlxEvYBqmaLtcgsZlfkbYbTgTRaNzCkg15JFVhsoPU0jc8N
 d1rV3JVefAOho6hB3XH0qnOJIDWZ9IsZJqVKmomgtcGiXuox8brL+o3AcDKvoMdf3MdBjtBHCx6
 Jsl5zc=
X-Received: by 2002:a05:6402:40d4:b0:66b:e8e5:4628 with SMTP id
 4fb4d7f45d1cf-6889cc508b0mr8587295a12.20.1779778912562; 
 Tue, 26 May 2026 00:01:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f58dsm32519273f8f.5.2026.05.26.00.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:01:52 -0700 (PDT)
Message-ID: <135fb709-8272-4606-b017-6f86615ee400@linaro.org>
Date: Tue, 26 May 2026 09:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pci: dw_mvebu: Use dev_read_addr_x APIs
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
 <20260526-devfdt-pci-v1-3-ed7f31d73938@nxp.com>
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
In-Reply-To: <20260526-devfdt-pci-v1-3-ed7f31d73938@nxp.com>
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
> Use dev_read_addr_x APIs which support both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/pci/pcie_dw_mvebu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_mvebu.c b/drivers/pci/pcie_dw_mvebu.c
> index 43b919175c9..5a177478afc 100644
> --- a/drivers/pci/pcie_dw_mvebu.c
> +++ b/drivers/pci/pcie_dw_mvebu.c
> @@ -565,13 +565,12 @@ static int pcie_dw_mvebu_of_to_plat(struct udevice *dev)
>   	struct pcie_dw_mvebu *pcie = dev_get_priv(dev);
>   
>   	/* Get the controller base address */
> -	pcie->ctrl_base = devfdt_get_addr_index_ptr(dev, 0);
> +	pcie->ctrl_base = dev_read_addr_index_ptr(dev, 0);
>   	if (!pcie->ctrl_base)
>   		return -EINVAL;
>   
>   	/* Get the config space base address and size */
> -	pcie->cfg_base = devfdt_get_addr_size_index_ptr(dev, 1,
> -							&pcie->cfg_size);
> +	pcie->cfg_base = dev_read_addr_size_index_ptr(dev, 1, &pcie->cfg_size);
>   	if (!pcie->cfg_base)
>   		return -EINVAL;
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
