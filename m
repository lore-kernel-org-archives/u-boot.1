Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA86AFED9E0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268B684201;
	Tue, 17 Mar 2026 15:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kNJaJv/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B397842C2; Tue, 17 Mar 2026 15:56:06 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A1C980517
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486b96760easo7591655e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773759363; x=1774364163; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=9pxyqB5Xwk25miDQt1UMfSixZ9fqGl3G7D/IIKEmYOw=;
 b=kNJaJv/NZgY26uigEfWVNm3Vjkz2Xpepo4uzyqMGYzyMRs+PVPqGKZcKPKwNnF05SH
 FGfrXZ4gHL7vAOby4hrB2rehEVvoh0FGqRlLskzkxkOkFSMGdgakBMLRcuXnCnzZLnHU
 Yc7Qdx3BeIdA+KRVVb+AcbbPskC2VNXj0vlJdyxZSR0+A3LDYyyNeAMTtVDvPoDsrN34
 ZOJtqCzfd60caFV8f/zKvEtWzPw3oKo/jQDKuxuQRmtg2X9s1Z1dNtvdNfAusIbT5mAI
 EKM2wdgwr7IYTgMTcE1wUHLORdVTeIsSwzR1orGzAgUlIfol5qd6XjSFWIPJWb5ANrnk
 HVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759363; x=1774364163;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pxyqB5Xwk25miDQt1UMfSixZ9fqGl3G7D/IIKEmYOw=;
 b=PDPQ+AbkZy/3lp9hCHd91DceNaVZ5im8r31AKJ3bt8H1jsYY6Y5gXxCmoFudh1uPi9
 H0UMCLljEHbuiDXK17fkmvIs9Oy+/f56wXgL9/4Cq8/5GO1BbyboIp1tSV1S+XfCCRYP
 2t7rQRO4EWPLMbxriOOwBOB6rjb1d0NqDhfrf7fZrqhy9/bZRrThKECIRJHuz/TLy/sp
 4xNc0YH0T/JtDFof9oQ4ump2AVxHiF0kgxJquu8VRckj/j71/lTV1wtt3D7oo3Fwgpl0
 tQUH3sA2OnKgMCNi/0z86Fybc6URwQgS8B41Zx7A3UloZ0tLKioJt3eggSr8jK/qwloG
 LYDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvtLzY3X1Z/n/nqqNHgdDDnAJMn07xPnmIM+64xKoPRVq8RC1o2OwwInessOamZrZKFg8VQN8=@lists.denx.de
X-Gm-Message-State: AOJu0YyX9mmbj14FfEFLL9Uh9DzM+hqd9Zm29lsViSWLYdqoIVWgprDk
 ZyyQZZOa7rXUPqpti17T3bmksOvN6M0j9MhSN7OCIuRDYeRdylb9LC8Jl9VFRtfMP+k=
X-Gm-Gg: ATEYQzxohV64qgIeyFGMZAKMazRIAY+obdbY7AZfKSarRtMy2O2+cX+v6w50TuydBPv
 iV5uh7HZI9ToyPQzWFIDEGhaUEX4b6wQScAzd2VU063C9hHMBEQwW5knvmhYPGLg7sWaZLtmFAM
 nrEw58LUU/vNS/Y3Sna8s+wSGZigK+ltfKNZ1F+WSgsKuLC1n9v8L48tk5iQR8DKG+nyELRMr/S
 ZmDjgCXCUT/GpPX8NbGcm8gGs5ZIvBh/Oxc1YxrsyALKHeQzv1hXehzG+y9Ey4h99SiYa80YeH4
 1QhRpHG6k3mh6H89gynBJwA06RA5Vt5crC3HhPIZ68Xrj8UG0QgI9vdpWfFEWfDJJgQrg2476K6
 9BImv7JzO98iYhqtQJphhPUMMOe4mpBAwVAdtNJHv+bT0xJ280dHm/S8eZz3b5oeCzvIsjDyF4i
 +puJrBwSuiVaQECLCMsuTRwjkRngcIG84S300QnjUz3kDsh8alo3VP0MugI/Dp5JNhOujBMhg1l
 RWRroA=
X-Received: by 2002:a05:600d:8489:20b0:485:3812:36dc with SMTP id
 5b1f17b1804b1-485566d9068mr218532965e9.9.1773759363340; 
 Tue, 17 Mar 2026 07:56:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c778:639f:c042:aa01?
 ([2a01:e0a:106d:1080:c778:639f:c042:aa01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485564051f7sm203140485e9.2.2026.03.17.07.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:56:02 -0700 (PDT)
Message-ID: <e4e5784c-d5dd-4372-8418-2a04416770a8@linaro.org>
Date: Tue, 17 Mar 2026 15:56:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 09/11] drivers: ufs: ufs-mediatek: implement clocking
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
 <20260317-mt8195-add-ufs-support-v1-9-7d731ec438ae@baylibre.com>
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
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-9-7d731ec438ae@baylibre.com>
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
> Implement clocking.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/ufs/ufs-mediatek.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
> index 5d882904c84..31916f72c86 100644
> --- a/drivers/ufs/ufs-mediatek.c
> +++ b/drivers/ufs/ufs-mediatek.c
> @@ -177,6 +177,18 @@ static int ufs_mtk_link_startup_notify(struct ufs_hba *hba,
>   	return ret;
>   }
>   
> +static int ufs_mtk_get_clk(struct ufs_hba *hba)
> +{
> +	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
> +	int err;
> +
> +	err = clk_get_bulk(hba->dev, &host->clks);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
>   static int ufs_mtk_bind_mphy(struct ufs_hba *hba)
>   {
>   	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
> @@ -317,7 +329,11 @@ static int ufs_mtk_init(struct ufs_hba *hba)
>   
>   	ufs_mtk_init_reset(hba);
>   
> -	// TODO: Clocking
> +	err = ufs_mtk_get_clk(hba);
> +	if (err) {
> +		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
> +		return err;
> +	}
>   
>   	err = generic_phy_power_on(&priv->mphy);
>   	if (err) {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
