Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EEACD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC55847B0;
	Tue, 26 May 2026 08:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gp0Bpc8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEF2847AF; Tue, 26 May 2026 08:59:56 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DE683EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4585a116a4aso8456098f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779778794; x=1780383594; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qZ3ljXZvGf5U0THZdk/aSUiUPcUNavZ7CSkbNfa5afg=;
 b=gp0Bpc8caUW0ucC4x9UhMB5iWBm4H8gf67FRXoAa/iG6OTfnX/MJ6hdJvtP5KJSi3o
 Bg0sWwnJaMzWQ/iJRMlKObbP4O6heLqW2jGX/lQ/Ba2Cq0ViICFWN3w3W6f+lwvYR/KU
 yJdtdMqUKu37Dl6ZqCgpuR/7rCt9fbWNhBehS6b9pcks4QfOxvVdjbk3rXgzWzL+Vddv
 MtghrUJUozFd2jJTM/tH4PnbAX1iWU0MP9mo+esgsHaKvC5n3yfRtDO4vElaqaky9D6U
 //Re2l4vmaj/IE94123V9OvNdggujoBcbw/kSOVtaSRonRJg4/pm8BIRosY8vb5HREk3
 Gdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779778794; x=1780383594;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZ3ljXZvGf5U0THZdk/aSUiUPcUNavZ7CSkbNfa5afg=;
 b=AEEbsO5WVd0jMMw2lAh/Ra5JA79zZOSJBZDC6rLgnUr0qXukajxNHrMU+PXL4/BZFd
 ubPAFGkXS36jAJYbv1VZEkDuRJj9DUHSViJBRWUDw7pG1sXIIbiYtJhV+3Sx5y4X+pAo
 9T/TNID+MyKcH8H3w3XfsN0g7mALgr4BEWD8qr/l44+fpDk0Ira7j3nBmn8A1sxIR+Wc
 rm1lJUEVJpWbZwV0h8d2vo+FEU3lFL3V51spTD8Y+LAaco+u20Ul/f7GFjQcJqf9pLn/
 EqnA86FfYEPVaaOtbCgEix/oUxT/msbyZ0zutFMq9PvP3ECT2XAYaqWiirlU8+fUFL0V
 Jqow==
X-Gm-Message-State: AOJu0Yzm1XeR/+gxbS+maLkdKuOmKNm5eLH90Y4vopu52mIsseav5Q+v
 U+2F7OssOwie1+DbPuvFCv2kQoTvRGb9/krkxJcFDHr+wTt8ASDMHuBrOb7E622L6yE=
X-Gm-Gg: Acq92OGwjzCPoGG8pDYBan8xGY9OefRUU8Mkxi8RRHYQ3ZRq6937VzrtRqhWaJL74Zx
 FJjo2hAevsCa6Q172bfe0LiF+8gwkyExJRiOSrxig1/ytwLAtiHXdqaKJa75f4C4rAM2THGB3d9
 mhD+9VmJKTI4SkV135r2gy8BKQ/OIv+VZYBmOsOINvRWeDhD11Cp40TTP/QD72lzQAhieAlVP/V
 wsoKmBdhudwYDY1Ro4t8fMZA3aAfcU7L1KHa/N68ChCnSbw0JmfzqzpiQyidyAWmZxjw63T1Hdc
 a6xjLJHukz5s7GKcu/hW2f1cRxPJ39/eTF39g5qVZYfwHzQvq37nutVhKC9vF3yH/zxHNVW1Vqk
 m1XhrXF+nhdfNkbYh09PmG82Gi1bwnldftfHzrs3VR5xGEmiNXKXJC5FCcJ97gbGnblsmxj3LZD
 5ZkXZVchU2dIrvJvYFuI1IFveq/YotXyqDMrGZ3RXkVeAOOr2KQgNFLZDQ5S2gvNbfgf7RhZfMy
 cuQOMY=
X-Received: by 2002:a05:600c:4f82:b0:490:48e2:5618 with SMTP id
 5b1f17b1804b1-49048e257admr251029075e9.22.1779778794274; 
 Mon, 25 May 2026 23:59:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f6ffsm33305568f8f.1.2026.05.25.23.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 23:59:53 -0700 (PDT)
Message-ID: <a4b110c2-dfd4-4815-bfa4-e62127fea815@linaro.org>
Date: Tue, 26 May 2026 08:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pci: rcar: Use dev_read_addr_index()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
 <20260526-devfdt-pci-v1-1-ed7f31d73938@nxp.com>
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
In-Reply-To: <20260526-devfdt-pci-v1-1-ed7f31d73938@nxp.com>
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
> Use dev_read_addr_index() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> While at here, correct the return value check.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/pci/pci-rcar-gen2.c | 7 ++++---
>   drivers/pci/pci-rcar-gen3.c | 5 +++--
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-rcar-gen2.c b/drivers/pci/pci-rcar-gen2.c
> index 08d5c4fbb8b..53cb0916741 100644
> --- a/drivers/pci/pci-rcar-gen2.c
> +++ b/drivers/pci/pci-rcar-gen2.c
> @@ -10,6 +10,7 @@
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> +#include <fdtdec.h>
>   #include <pci.h>
>   #include <linux/bitops.h>
>   
> @@ -235,9 +236,9 @@ static int rcar_gen2_pci_of_to_plat(struct udevice *dev)
>   {
>   	struct rcar_gen2_pci_priv *priv = dev_get_priv(dev);
>   
> -	priv->cfg_base = devfdt_get_addr_index(dev, 0);
> -	priv->mem_base = devfdt_get_addr_index(dev, 1);
> -	if (!priv->cfg_base || !priv->mem_base)
> +	priv->cfg_base = dev_read_addr_index(dev, 0);
> +	priv->mem_base = dev_read_addr_index(dev, 1);
> +	if (priv->cfg_base == FDT_ADDR_T_NONE || priv->mem_base == FDT_ADDR_T_NONE)
>   		return -EINVAL;
>   
>   	return 0;
> diff --git a/drivers/pci/pci-rcar-gen3.c b/drivers/pci/pci-rcar-gen3.c
> index d4b4037ce19..1925d968c16 100644
> --- a/drivers/pci/pci-rcar-gen3.c
> +++ b/drivers/pci/pci-rcar-gen3.c
> @@ -19,6 +19,7 @@
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> +#include <fdtdec.h>
>   #include <pci.h>
>   #include <wait_bit.h>
>   #include <linux/bitops.h>
> @@ -391,8 +392,8 @@ static int rcar_gen3_pcie_of_to_plat(struct udevice *dev)
>   {
>   	struct rcar_gen3_pcie_priv *priv = dev_get_plat(dev);
>   
> -	priv->regs = devfdt_get_addr_index(dev, 0);
> -	if (!priv->regs)
> +	priv->regs = dev_read_addr_index(dev, 0);
> +	if (priv->regs == FDT_ADDR_T_NONE)
>   		return -EINVAL;
>   
>   	return 0;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
