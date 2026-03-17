Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2F4FD708D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7453E8437E;
	Tue, 17 Mar 2026 15:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xCAttwXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 909328439F; Tue, 17 Mar 2026 15:55:03 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6146884372
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43b4fd681c2so454023f8f.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773759300; x=1774364100; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6AA/Nb/0NytBajp5jCH6X84dj4l+Oriisp4KRB8CviI=;
 b=xCAttwXKSxlhS9woh4938CtG5d+ACkCeIefYnj5KTjTnLaQ5NPX51d+MlEX9aCWP/M
 LKFq7m1rvJJtejzog/jdxVOSvdw6B+9TJImxzpVa4PZmNnTxHIdua7k2aD9qIClxI/Zm
 /NVL4W9DB7x8twVVkYTXx4uf4akpxN8p8bD0Za3CjcEyroW+iuhugTpdL1lznLNdbe8H
 UE9aTAaiHtc+51RYQvGebLivfAFxfCjiWfRrt+ylxejgZOffTpydHRt5I5PtKGs1hlj3
 mCRA9EpLrynKtfL3ANvlbGCkpNblsGVEMnTl0lqt4fuxy58LuIjVf5MVBAN7FV/w6AtU
 bUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759300; x=1774364100;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AA/Nb/0NytBajp5jCH6X84dj4l+Oriisp4KRB8CviI=;
 b=avZdOqhiJBt6htBVedooKrT5eqXDVMsa4zJMLlC1MPZbnfZdsMhvz3rYCGLORb2c6Q
 w/JncSIWKbHgtNkEzYGIvtcTsvM+M/vkGabmjFOAUzdGEekrsFv1KmgLkBaN/ClI6ehi
 iNjm+dWQ15hdn0hFlXc6yuLagMX5jyv74yxg0e2woL0vwxxBJCxUH6pekqrI/NdGQTVE
 iJsLIcbZy+aluXP3tXXSFFAKTw9/Du4JEj8SUxI/brBXXybiHCWMr/H3bXekvJdHl/7/
 c67U3RGAJcCCh1tUNOXLpDwIQ6CuRsVa9ElmBBI2+3UlPjpDNxbAJXCrWmx14cvgjtXO
 OpyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1A6a6oIZrE2j713UQlN4fUEszNhs1UDpJoW4KS/2yaOJB62Q43+8oSAOI0HRv9c602XyzaWc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp8raLUfjlYtGzCD32kPyvLzUQ+ksQNX7DQ9t+Ype1v4wNMwhB
 74GsLCXk+XifxtPLI92uRZTJVkoItJg/KCAvH2WacvohvAsVDZabRLnYzE1fZ5okhQI=
X-Gm-Gg: ATEYQzyjKdJH96HBM509bSbLmPIk8w7qyUEiMtIWRG6TmPGeiBOjZgCbij1mo1xj+q4
 hmQXNRTIH61SgXzloEKIkoAsiixbZEt+saavBJKRT5f1I0lftMoVK1zNwtSPWhmLVgM5f/31x0G
 f/iuD4Ed45jqnagwKkDNaCr/pXibsjbaOgRM4ee76oF4tICaanBg4Hoy5vouJrRUVVICKhzgnGS
 9EFgDxexXs1cl/4EOFCAjlTQ8jnXc3wGtNgVtiQtKpsOTP0pbqIvimq/61VpOyhRzh6EtupdkYg
 pJGPpOgUKNnCe7v2knkwTiuGjPkK/3P9qg1NGUSQ+A0i1BRMiQQE11lDYrs0jyNNpkH4xqjKfsD
 aGjk56EBE4WsWe2r8Is3x29O4wRRA+SnS74tMKsV/DmlZ1RQx+yHBpyd6bNe3GHCzN71pHsViSB
 HC69J0Ev+B9P/iXvxcKwVvJ6lIZQDg4usJHUBNGT6PHSG2CCi5vYg1/B4o811qjJchgLujUdNni
 jdw2mMN1Y2a2sVQ7g==
X-Received: by 2002:a05:6000:2404:b0:439:ab3d:1c2e with SMTP id
 ffacd0b85a97d-43a04d7b3c1mr31014668f8f.10.1773759299657; 
 Tue, 17 Mar 2026 07:54:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c778:639f:c042:aa01?
 ([2a01:e0a:106d:1080:c778:639f:c042:aa01])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518922absm15332f8f.18.2026.03.17.07.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:54:59 -0700 (PDT)
Message-ID: <6259622c-8f04-47bf-8042-d4543c01f78c@linaro.org>
Date: Tue, 17 Mar 2026 15:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 06/11] drivers: phy: phy-mtk-ufs: disable clk in power_off
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
 <20260317-mt8195-add-ufs-support-v1-6-7d731ec438ae@baylibre.com>
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
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-6-7d731ec438ae@baylibre.com>
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

On 3/17/26 15:24, Julien Stephan wrote:
> Disable clocks in power_off(). Also define ufs_mtk_phy_set_inactive()
> helper function to keep consistency with power_on() and
> ufs_mtk_phy_set_active().
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/phy/phy-mtk-ufs.c | 40 +++++++++++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
> index c7a671ebfad..0522e1ab683 100644
> --- a/drivers/phy/phy-mtk-ufs.c
> +++ b/drivers/phy/phy-mtk-ufs.c
> @@ -88,34 +88,44 @@ static int mtk_phy_power_on(struct phy *phy)
>   	return 0;
>   }
>   
> -static int mtk_phy_power_off(struct phy *phy)
> +static void ufs_mtk_phy_set_inactive(struct mtk_ufs_phy *phy)
>   {
> -	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
> -
>   	/* Set PHY to Deep Hibernate mode */
> -	setbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
> +	setbits_le32(phy->mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
>   
>   	/* force DA_MP_RX0_SQ_EN */
> -	setbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
> -	clrbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
> +	setbits_le32(phy->mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
> +	clrbits_le32(phy->mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
>   
>   	/* force DA_MP_CDR_ISO_EN */
> -	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
> -	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, CDR_ISO_EN);
> +	setbits_le32(phy->mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
> +	setbits_le32(phy->mmio + MP_LN_RX_44, CDR_ISO_EN);
>   
>   	/* force DA_MP_CDR_PWR_ON */
> -	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
> -	clrbits_le32(ufs_phy->mmio + MP_LN_RX_44, CDR_PWR_ON);
> +	setbits_le32(phy->mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
> +	clrbits_le32(phy->mmio + MP_LN_RX_44, CDR_PWR_ON);
>   
>   	/* force DA_MP_PLL_ISO_EN */
> -	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
> -	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
> +	setbits_le32(phy->mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
> +	setbits_le32(phy->mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
>   
>   	/* force DA_MP_PLL_PWR_ON */
> -	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
> -	clrbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
> +	setbits_le32(phy->mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
> +	clrbits_le32(phy->mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
> +}
>   
> -	return 0;
> +static int mtk_phy_power_off(struct phy *phy)
> +{
> +	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
> +	int ret;
> +
> +	ufs_mtk_phy_set_inactive(ufs_phy);
> +
> +	ret = clk_disable_bulk(&ufs_phy->clk_bulk);
> +	if (ret)
> +		dev_err(phy->dev, "failed to disable clocks (ret=%d)\n", ret);
> +
> +	return ret;
>   }
>   
>   static const struct phy_ops mtk_ufs_phy_ops = {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
