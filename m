Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E62FD7091
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A7AF843D1;
	Tue, 17 Mar 2026 15:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cYngSDbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 947C1843E0; Tue, 17 Mar 2026 15:55:18 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983F9843B7
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so41457285e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773759316; x=1774364116; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=IpnZl3UdfXiHjtTW/98tESO2LVfBuE/SBgPrHVdhbYo=;
 b=cYngSDbf7oXoLEvBDYCQq9L+qtrMD5X5bPmwbhtpnAjZC+Jao7mSTPtd+3bZhC765T
 pJGzWgdLtpn+gKkQ1SGkupwIFtXB8F3AjWC2lutf8JVA7EVwQEJuMrRNlOLtjuHlZbUn
 P69/0h1i5+Eb4zjBk6FLdg+JAfC2fpH5CnYG0EI8taZe7HHd9Nux+hSSJv/C5swiDePk
 NR+duVlzbMN9Pglva9CiERIly6KCrUjIa4iIS810nfZoNStgXDmLYL7DFcgdoRmQnVrL
 5UoPulnnVPUY3KfvsQP5ON19HxaVAFiQj1E9lNFpmQ6EgVJCxGknpc+67X7o/A7V/EsQ
 z1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759316; x=1774364116;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IpnZl3UdfXiHjtTW/98tESO2LVfBuE/SBgPrHVdhbYo=;
 b=Ho30qJ29N3y6oN5feZJpOzkohZOHNfChs2vbZCgKPqJJ4bA3wb2Tsb3XM8TQDtqi9b
 sTaOiAx1GV6FGK+iRYTx+n3QQwE6n99DjLVVXjGBVh8AV5xxu2jfByqmJRIbGU9UkZe+
 pKrqsj0S1M24fXfSBOBB8LKU2vjZaeDQ2IfQZKFfl7nm5aTZd6EmjmjJRQwJz1JKmOHB
 8I3GHD87d0RVJKtMh79B9UowWQI4ENuOuCQQZ4OjT2CxMUkBgaqUgWNlIwMdQvdEi3j6
 wQLT+zu1Q/Xu2l/zfLX3Vx8f+EEfycJEXcpJk0F7hRZqgUq5e0AEW55aGKNOtUX+gTmu
 if6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOxSPe+++ztfEEj3hJBdUAjJr3ndG4J5iq/b95EgowVKvTCsmjBkWSnTeMR6brTGzGwuNvPkY=@lists.denx.de
X-Gm-Message-State: AOJu0YyhDY66EaHCqeQOt80ilZ5jdSZzYhxZPaKl9ltsQPjm6f6Jygn5
 s9g6QO3Vpx2ziwWQC+LHM3giWGv52kFZ396kNHYyIaomdR51VkVoiHrndsXaxst6ic4=
X-Gm-Gg: ATEYQzw9Mx7abUCTr8prUzKHb/uPTt+QEhsQHx7wbBiUGETVpE+LXIOVt15YK3N+sWd
 ZYpUZI38wblY65yMLmFdr0pnSdJjCviwumXkx9mTOq3bSuCpdkDuVLG0g/R5mwhw6yObBU2prFK
 89hcfuEB0WR/5ErJd9dteAj0F84+H2NnyTtjoFhRrsaGoQktbGzj8tckvig9OClwbu1tyIsw5Di
 sGRGtbxs9JrF/UflYWUDMr7Xoy5DYVHqvBStXw+F0IudWZonmgv8P4hRpQMDMSV3kvFZ6HSgMuk
 MKcy2kqpwHivAvsVENqnm19/dKEVvYqUFpeCa5q3rywcu+oPcvEpMOcj0nGKElsmIaODs4NPNIa
 xjuypndapMWu+djnpLGzhAX+VVNty5hw0dOPzXHtZinuBG0d4a2Y+gCh/gBiGJBvglyP12vqf0W
 1yuDv5pfatHIbP/lwE8vk6w5ZBuj4QCy9Dm9hMg1PQaz92DItvBj4ao3c37DI3JpWJ+AYi/wux8
 fYU86w=
X-Received: by 2002:a05:600c:6812:b0:485:4394:b0e with SMTP id
 5b1f17b1804b1-485566d2ce4mr282594085e9.12.1773759315904; 
 Tue, 17 Mar 2026 07:55:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c778:639f:c042:aa01?
 ([2a01:e0a:106d:1080:c778:639f:c042:aa01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485563953dbsm225793495e9.0.2026.03.17.07.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:55:15 -0700 (PDT)
Message-ID: <9c3e6302-1312-44a4-8eb1-9e1f39b2091f@linaro.org>
Date: Tue, 17 Mar 2026 15:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 07/11] drivers: phy: phy-mtk-ufs: do not alloc priv with
 priv_auto
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
 <20260317-mt8195-add-ufs-support-v1-7-7d731ec438ae@baylibre.com>
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
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-7-7d731ec438ae@baylibre.com>
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
> When priv_auto is specified, we should not manually alloc memory for
> priv data.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/phy/phy-mtk-ufs.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
> index 0522e1ab683..c4c214dcde0 100644
> --- a/drivers/phy/phy-mtk-ufs.c
> +++ b/drivers/phy/phy-mtk-ufs.c
> @@ -139,10 +139,6 @@ static int mtk_ufs_phy_probe(struct udevice *dev)
>   	fdt_addr_t addr;
>   	int ret;
>   
> -	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> -	if (!phy)
> -		return -ENOMEM;
> -
>   	addr = dev_read_addr(dev);
>   	if (addr == FDT_ADDR_T_NONE)
>   		return -ENOMEM;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
