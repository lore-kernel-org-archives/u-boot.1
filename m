Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E54FD708D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D724C8439F;
	Tue, 17 Mar 2026 15:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XczG+LXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4778435B; Tue, 17 Mar 2026 15:54:31 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1E28439F
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48539d21b76so42358515e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773759269; x=1774364069; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CS1mxqTUBWgjjm57FucqS44MzM+Ne4hiaNrx0BmA4uw=;
 b=XczG+LXE0Db2Ai+mrygrkC4dJRXMnc536X4lxMlF7hMQwyGRwjZgxvQVqRB6ELEE4u
 hU3R8bQGO5zeyzzINtJRWqLmauTBx+thQyZBq8n6+KLOzBiYmhl5EbwhkwXoPm3NMopg
 uLQS3SIDWUXuh7SwZdYzdxVZfHH5NPNroHfd/kqTtQjcSpRJg2T2IeKC1kMDz5I5EmqC
 ptxF5Ougsq4ITSbKKkmFhViHQqObMW7f30US6T3eFYX9fRzCz/dN7EnE+Et10MiapDlR
 wSG/aOBrJg5wMF/UKxWVpvimxYGr3tTHP2MKcWomfutWxHbmNa3KrrwQwoOIxYTeSE6M
 Qw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759269; x=1774364069;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CS1mxqTUBWgjjm57FucqS44MzM+Ne4hiaNrx0BmA4uw=;
 b=Eb+FhZOzwna8J4v4+YlSLqzmo0eCu6MNUfWwUixizVIPXCuaF5ajJCXedC7aBnplKL
 20vROhKipg2KBzB1djpkyduwFzqux3S5zkU9U5knY5jKfnd6Wb2FicYHTTFgsByL4VJ0
 SAdwKCS4ldqu5mkudDqr7hZHB0SCsfU9zcpMZnYtDH/FXjfjwdNHOKP4GVbEYHqm3BYQ
 +dHZ2v2W52he82fEOJoFvZxgNJfQYOKVzn6s3o2s7MGBa9M1v/bZDVyxBFlJaPt5Xiq4
 WOWj9Q0CDrWQJTMsr5DylC5IV81Qzzp3YwnZxEJPqIK6EOuHhlSHL7fCWsZtKq0uIwYB
 RLxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaaQMIS/nVqFd1Jlj6oUrAJL3Htd0A+9aHfd4ax5Xl2L1YW6BViQsVbnBXae1Bmi5Opj/b3p8=@lists.denx.de
X-Gm-Message-State: AOJu0YxkOYU2BO7sSINYkdrjVMULu+Nc8mQQ9ZFW/iYRUMnOvIWCk8RS
 I1K8mptxMHVAVp1832YKw5Fsd5VfSqQngTrfk1RCyenXwXD6CfreWsOS4p62m5DMYtU=
X-Gm-Gg: ATEYQzzQui6wHlZTW1ORDp7algAMQO74hAUfcP42+vGcDtkuwlA371XQ2vp1y85P08l
 YhcR3T8QrS6rA0JDeubukf0WpNtv2fo/OVACZ28mmrbQVI/3x1+z7wVO/zq9bpcWerE5aBF394Q
 QBx3ku1UeNWf1yZqT5PZjdBixpvmobhbouXB+nVFjxV5EOx2eeED+AhTSHcJydI46Jagv1ifMG/
 q9IvN0Di9R+F9bP40/UOEob72cEbc0NpoAiusstEkYyEgikFUILvYmwDZ8zJtfSbev/vlxkGks7
 gL+pVoSQI7rP158K3waeoliSgHFGE59Rb3jsQo8pLUdDERVeZGvj02MxX/kfcvAtE+8t2nvXkmc
 LN7Kzy5NHP6n81XyAYTZpprVfzetkHdsRYtYAu3ECNVKKlYbrdh4d8blW1RS5OiQQ1QgD6PAdji
 fPMxfspuWB/M/tjfWXsgEv1/dZNa+f3mPP3RWoNHx6HxMzbyJ0hhseLRajxTimiS6Ddzf+YVP2j
 7MLS30=
X-Received: by 2002:a05:600c:3b14:b0:485:410c:119b with SMTP id
 5b1f17b1804b1-485566d6f93mr308298795e9.13.1773759268700; 
 Tue, 17 Mar 2026 07:54:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c778:639f:c042:aa01?
 ([2a01:e0a:106d:1080:c778:639f:c042:aa01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eab15f4sm74810385e9.14.2026.03.17.07.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:54:28 -0700 (PDT)
Message-ID: <9d9dccc9-9cd9-4520-b279-7a1d8e9b86f4@linaro.org>
Date: Tue, 17 Mar 2026 15:54:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 05/11] drivers: phy: phy-mtk-ufs: use clk_bulk functions
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
 <20260317-mt8195-add-ufs-support-v1-5-7d731ec438ae@baylibre.com>
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
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-5-7d731ec438ae@baylibre.com>
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
> simply the driver by using clk_bulk functions
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/phy/phy-mtk-ufs.c | 34 ++++++++--------------------------
>   1 file changed, 8 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
> index 321151172d9..c7a671ebfad 100644
> --- a/drivers/phy/phy-mtk-ufs.c
> +++ b/drivers/phy/phy-mtk-ufs.c
> @@ -40,8 +40,7 @@ struct mtk_ufs_phy {
>   	struct udevice *dev;
>   	void __iomem *mmio;
>   
> -	struct clk *unipro_clk;
> -	struct clk *mp_clk;
> +	struct clk_bulk clk_bulk;
>   };
>   
>   static void ufs_mtk_phy_set_active(struct mtk_ufs_phy *phy)
> @@ -78,16 +77,9 @@ static int mtk_phy_power_on(struct phy *phy)
>   	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
>   	int ret;
>   
> -	ret = clk_enable(ufs_phy->mp_clk);
> -	if (ret < 0) {
> -		dev_err(phy->dev, "failed to enable mp_clk\n");
> -		return ret;
> -	}
> -
> -	ret = clk_enable(ufs_phy->unipro_clk);
> -	if (ret < 0) {
> -		dev_err(phy->dev, "failed to enable unipro_clk %d\n", ret);
> -		clk_disable(ufs_phy->unipro_clk);
> +	ret = clk_enable_bulk(&ufs_phy->clk_bulk);
> +	if (ret) {
> +		dev_err(phy->dev, "failed to enable clocks (ret=%d)\n", ret);
>   		return ret;
>   	}
>   
> @@ -148,21 +140,11 @@ static int mtk_ufs_phy_probe(struct udevice *dev)
>   	phy->dev = dev;
>   	phy->mmio = map_sysmem(addr, 0);
>   
> -	phy->mp_clk = devm_clk_get(dev, "mp");
> -	if (IS_ERR(phy->mp_clk)) {
> -		ret = PTR_ERR(phy->mp_clk);
> -		dev_err(dev, "Failed to get mp clock (ret=%d)\n", ret);
> -		return ret;
> -	}
> +	ret = clk_get_bulk(dev, &phy->clk_bulk);
> +	if (ret)
> +		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
>   
> -	phy->unipro_clk = devm_clk_get(dev, "unipro");
> -	if (IS_ERR(phy->unipro_clk)) {
> -		ret = PTR_ERR(phy->unipro_clk);
> -		dev_err(dev, "Failed to get unipro clock (ret=%d)\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return ret;
>   }
>   
>   static const struct udevice_id mtk_ufs_phy_id_table[] = {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
