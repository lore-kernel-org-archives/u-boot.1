Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5876FED9E1
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8030D8437E;
	Tue, 17 Mar 2026 15:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mXaLtuvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15B128437E; Tue, 17 Mar 2026 15:55:53 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B55B8436C
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so68470385e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773759350; x=1774364150; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jcVsJbw8HLn0D7ygpVLgl6LlRnzfbGpKgvpSDbAadxA=;
 b=mXaLtuvYNtM8rCnmpqZuMooS+SewCfA2mC5Jptcft2KYuCfiAA/2XhYoCQt7Y2AT4s
 pjy9jj0evVFppsq6Z56medwkFwjG7oqYUHpNope/N7MMz9wIS/Yh6pD5rjw/s2rSYadZ
 JKtx2iJISAtIMc/8nxarpWwnWgfkeAAC1ZPrsc1me9QB6MYXdPSsHGCRSb3IHDmicx3E
 TDM6xku5WbIWw7AySTzQbonMWVq5FrgkF+NXPSR7iVlOsJtMRZreN+5rZqhY16vQbFDu
 tXdsnv2bT23im8e4JtMRvoZ9ZEe7QbNqvZesZo6vLlpblFGDM0wu0VElv4ZZeTzA8IdK
 pong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759350; x=1774364150;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcVsJbw8HLn0D7ygpVLgl6LlRnzfbGpKgvpSDbAadxA=;
 b=ERQ0It9QhJ2tXdp7PDZqVPonLwx2ZK8Jt3SZV3bZC421h5WRFxDwvppGEuACxoMr7+
 9zFndmElzE29A4ng5BAh+3/zf2nqZmXgT8Rt4EmAORAX/vuZlNgBgqfbuwfdhY/RGGZx
 NTNsvGYpoJ0dWjicv+EmE9Nn3XNw/p6ybCwXj/uJj52k8km4an+dDyVw60mU11mVQXdV
 +NWhheh4jfX0ziHpCa5iLht8IUqG/+ALt83VtCfO4EKhw6C/+a1NnS6zZ2k7zGXr8CAE
 xRX0iEOX96Vry3z7rYarTZU27vBetWFu+HjAj9bI/WWxK7b6OkLiN6ztRKRlqD+UlB9D
 VP7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1NPqoiwh8j131AUuFI6QmC/HxK5fQdAJjn671BEG5P2ztogUg0AdYQE7rOC90SgxOnGSQlfM=@lists.denx.de
X-Gm-Message-State: AOJu0YyWZpKb7Sz6+sQnWrH9f3cyh9/44Rxsmd8qqju93V6+vP0Xn7ib
 qMaTMNepczbCfTsK6jji07guVZb01M4fXlS2aa9I59pn38dIpfYnB0Y7eEYmqBIr0ys=
X-Gm-Gg: ATEYQzwiHZsBTEaMur7BzbpKYKwz6mD2namQehXRDIMWrs88WJ6chSW7kCMkz5ghXXx
 HnO0fgzdrnR+6m/5kRSHb8hJIKzjwvyuZ2GqI6pFe43KdJ8JJy1eWYTrffc0xYa133Bui4/yR25
 aUfRzEKgP+34a4ismYDiy6Ml9nk9Hu9ZmzzKySPzWZZ0DFHcCxwdKIjFwCzKr9a5xN3H4ZeANr8
 XcO8RO3qHhEe9R8RgY2+Jkp9U7GEE10YuDGMnkpCExPSGeRYjkJtvQoARyo7X846T/EnTyF2Vil
 XpSxsZVquDFFPRelHeJ1tO6JRp/jarXdXVwlg6T4nTZXUYN52FFddzXIHHA+pvx6GF86bzZ/WX3
 FlIbUdc+n05Ni2HnJKUkl5uiKGqpHN/w8mpqqJrQAhCqlJP+Zp2GALWfnml/kO6rIRXq8YDJtZG
 aJl3rMhHRZLMW/I/znCvMK9roFIRgkJXODS6mgK68PD97z3XcqiRTbh91CfTu5TTcFBXDXYoSzu
 2sg5TDD+V2XgxsYbQ==
X-Received: by 2002:a05:600c:a46:b0:485:3b50:fe54 with SMTP id
 5b1f17b1804b1-485566d6ff2mr299184785e9.11.1773759350401; 
 Tue, 17 Mar 2026 07:55:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c778:639f:c042:aa01?
 ([2a01:e0a:106d:1080:c778:639f:c042:aa01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c6700fsm114947585e9.22.2026.03.17.07.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:55:50 -0700 (PDT)
Message-ID: <12285daa-b242-4fe5-983e-8d451c4e9e2a@linaro.org>
Date: Tue, 17 Mar 2026 15:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 08/11] drivers: ufs: ufs-mediatek: fix phy handling
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
 <20260317-mt8195-add-ufs-support-v1-8-7d731ec438ae@baylibre.com>
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
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-8-7d731ec438ae@baylibre.com>
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
> Currently mphy is declared as a pointer inside ufs_mtk_host struct, but
> it is never initialized.
> 
> Fix this by using a struct phy directly in ufs_mtk_host struct instead
> of a struct phy*. Update all call to mphy accordingly.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/ufs/ufs-mediatek.c | 18 +++++++-----------
>   drivers/ufs/ufs-mediatek.h |  2 +-
>   2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
> index e860d765eea..5d882904c84 100644
> --- a/drivers/ufs/ufs-mediatek.c
> +++ b/drivers/ufs/ufs-mediatek.c
> @@ -182,19 +182,15 @@ static int ufs_mtk_bind_mphy(struct ufs_hba *hba)
>   	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
>   	int err = 0;
>   
> -	err = generic_phy_get_by_index(hba->dev, 0, host->mphy);
> +	err = generic_phy_get_by_index(hba->dev, 0, &host->mphy);
>   
> -	if (IS_ERR(host->mphy)) {
> -		err = PTR_ERR(host->mphy);
> -		if (err != -ENODEV) {
> -			dev_info(hba->dev, "%s: Could NOT get a valid PHY %d\n", __func__,
> -				 err);
> -		}
> +	if (err) {
> +		if (err == -ENOENT)
> +			return 0; /* no PHY, nothing to do */
> +		dev_err(hba->dev, "Failed to get PHY: %d.\n", err);
> +		return err;
>   	}
>   
> -	if (err)
> -		host->mphy = NULL;
> -
>   	return err;
>   }
>   
> @@ -323,7 +319,7 @@ static int ufs_mtk_init(struct ufs_hba *hba)
>   
>   	// TODO: Clocking
>   
> -	err = generic_phy_power_on(priv->mphy);
> +	err = generic_phy_power_on(&priv->mphy);
>   	if (err) {
>   		dev_err(hba->dev, "%s: phy init failed, err = %d\n",
>   			__func__, err);
> diff --git a/drivers/ufs/ufs-mediatek.h b/drivers/ufs/ufs-mediatek.h
> index 11a83d34c5b..0ffd0483eff 100644
> --- a/drivers/ufs/ufs-mediatek.h
> +++ b/drivers/ufs/ufs-mediatek.h
> @@ -154,7 +154,7 @@ struct ufs_mtk_mcq_intr_info {
>   };
>   
>   struct ufs_mtk_host {
> -	struct phy *mphy;
> +	struct phy mphy;
>   	struct reset_ctl *unipro_reset;
>   	struct reset_ctl *crypto_reset;
>   	struct reset_ctl *hci_reset;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
