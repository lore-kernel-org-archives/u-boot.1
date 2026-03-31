Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FB5FF60D8
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 06:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7469483DBF;
	Tue, 31 Mar 2026 08:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z7Idy4Pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4066E80212; Tue, 31 Mar 2026 08:58:22 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E0D83DBF
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cf8d550bdso1853464f8f.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774940299; x=1775545099; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Ipg7k+VcSKKfX6yHOD/5tAPWgIkxZD+8Okh4YDMdg0s=;
 b=z7Idy4PiDT+YH8bCPJqaSIWphfDi+gnfXBUcEXV9D+TR3NURnoUUGk+DzPMPrqj2xy
 dugdFgLTtb7iIUz3y1zVNpBh7Dpx+i8Wrt88EvlCp5vU4Kizx4DlxyUVyCa3kZo6EJ8m
 UR96q+Ut5gnWFtYzJtPhuSsqx5J6IDk+tSyZRiL0NEsGUacnlctg2A3xsoxb3yRbjREk
 523JWXbGt33lNwY9ccD2sxzPpqAWUsAna51ImdjCNhvFuQ5BVMA5L4UAhGPhQ+L08HXp
 qye5JX4et6SInHUJR9kNfXX3vlMq3oDoZQuBf/nt1hoOJDrCD4JcPvlWluY4x96ysA2C
 gXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774940299; x=1775545099;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ipg7k+VcSKKfX6yHOD/5tAPWgIkxZD+8Okh4YDMdg0s=;
 b=gEzvcgmPntSAk2VOCS1MhG6x/zuTjZ8KgC5Nj7hrYs4ONcz2ck9BqWDkl83+kTDHha
 wc/ENEkk9QTVPrZ1J9aAT7VqjEI+w+J1nJbwk5Y3sMASuLaSlAPk6waWUWm8kyplrlHZ
 cX6ufqs5d11JKO5ClMM6VLp0B452qomBjk6TRI/oV7Le9yf/afJ3fcbO2eYHotWSytpM
 uuC1d0gI0qqAwdemnLI2b2aNJTky5kXzOEXdXct8M/5ooWEJtjrrKvRfZvARqAC/ZUPe
 NoqU9WkMhM32MWRbeYm9tqj+fRLqi9ha7PBsN4VjMm3pzNdS6IpnKoAv3RGKXm4EIUUp
 KYZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+9gk297QW1/SZwVQvHBHbzjI/ShtODsSMDnA+3ii2sSQsaiUzbYO4FkUAE5Fohj8jc9CIIww=@lists.denx.de
X-Gm-Message-State: AOJu0YyPpeNCa0732dVAD45PE1phZCa3dxtOec65d93GdD8vobhJ3JsJ
 m0gWuhQruOQrNm0zcuC4L/G37FP6ONE0rH5Jhfgp8m2o+R1qKpbGBO74x622wrFhOD4=
X-Gm-Gg: ATEYQzwLX6WSjAXOCM0OK1AeQqhXkS9fCgcMm1e1ilY+d5eyFvYRUvJxqt/cOYBMrUt
 IKsRgOGMRFEU9H1GUA045Oxdy2isb2I9Bhh8pORy9hYf9LN9Vt+xlLfb3HxspDI9Fa5uFfcRgXW
 e4eAkk65TNklEAANtIsu1iViUNojhFd7JRAEZ2XMxiKYxxjvq+o90iyzzggfiHxHnzlNppygEis
 a+UeMwtsKXA547+LDQwXBtQhs/g2aP98uwqAtuBZ+sQA3+mJFZrszw847I3y9enJG2ziKQfx0hh
 g61eGzJFfdT/eYxeVyP6ngb7xqwbAerjKTK/U0mbgEOzmr5dXdpBVN7Y86eIHAfpSjys0vwhtGD
 gdglfphiIcStqm5NDHpgAvySpuFB465OnYeJnOobGE9pFR2z560joBjHzhr5EZMeaddk4oP5El4
 i2RlCS3E2kZWE59XsBQcK+2Wm7HvIGdAP/UDNNN+UKNtvEC0KjnMztSzuozVBH6TCXH0/7lIc5+
 94E
X-Received: by 2002:a05:6000:400d:b0:43d:dd7:364c with SMTP id
 ffacd0b85a97d-43d0dd73b7fmr792346f8f.47.1774940299420; 
 Mon, 30 Mar 2026 23:58:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:48dd:d660:22ab:efd?
 ([2a01:e0a:106d:1080:48dd:d660:22ab:efd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e3602sm25273744f8f.4.2026.03.30.23.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 23:58:19 -0700 (PDT)
Message-ID: <33ab8dea-0505-4b9a-a74a-1b088377b95d@linaro.org>
Date: Tue, 31 Mar 2026 08:58:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/6] ufs: mediatek: clean up zero terminator
To: David Lechner <dlechner@baylibre.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
 <20260330-mtk-genio-720-ufs-v1-2-3bad8362ed70@baylibre.com>
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
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-2-3bad8362ed70@baylibre.com>
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

On 3/30/26 22:42, David Lechner wrote:
> Remove spurious blank line and trailing comma of the zero terminator at
> the end of the devicetree compatible list.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   drivers/ufs/ufs-mediatek.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
> index 2cf65a3185c..268627d5863 100644
> --- a/drivers/ufs/ufs-mediatek.c
> +++ b/drivers/ufs/ufs-mediatek.c
> @@ -397,8 +397,7 @@ static const struct udevice_id ufs_mtk_ids[] = {
>   	{ .compatible = "mediatek,mt6878-ufshci" },
>   	{ .compatible = "mediatek,mt8183-ufshci" },
>   	{ .compatible = "mediatek,mt8195-ufshci" },
> -
> -	{},
> +	{ }
>   };
>   
>   U_BOOT_DRIVER(mediatek_ufshci) = {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
