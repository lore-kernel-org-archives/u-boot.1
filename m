Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ED1FF60D5
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 06:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F988352B;
	Tue, 31 Mar 2026 08:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nmuc7PrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAEB83A41; Tue, 31 Mar 2026 08:58:16 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF5E80212
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43cfa33a983so1334142f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 23:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774940294; x=1775545094; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=J51ZuW6VLp/rgZjfWPPdQF/CEDKRf5Hm4N9ke/DEi1g=;
 b=Nmuc7PrVXPAdNLWbjlvYmnLYLZhC94/+A4IDtlHwcrb0vA/t0ncoIxGNHB6lIC9nqV
 qY5d0vsGtVWC49s0Cy07pp1ko6VflzHCt8N0ao9x+e0HMkC9sZDvzBsxQIzvwmqC7J9q
 9dJE3jzWsyJwvRXtvHedlWJP2nRDSd1Tua36G9leZNNzqnS9c5I6owxn8hbCyl4+9ly6
 kL1sIjesw1PWkKSM1oJ2EpSXeM16CSZIskycHQdAzuL/xznmRirOh+Fe3rRlumLeWbqx
 dB2iJY2g4uL9IFgSRfuunos/UH6gHM7Ib3P+JpoesCcBD+TVW4RYA9wSlCjt0xNklfLE
 Qk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774940294; x=1775545094;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J51ZuW6VLp/rgZjfWPPdQF/CEDKRf5Hm4N9ke/DEi1g=;
 b=mstFQ1JRrw/L0HGE253ZVTDl87+UEEbh2XKJED+LbFfgHuA6fuMyTKFCwvWvaQ6Svt
 GvC1baGX+ytjtjcC/0YzOsdYyFCHIuEE1OLBUmCrVbFhMZgBoLaRW/sfraOwr9S3fpVI
 X5hI4zkG6AQ5Zeb2y2MRzLOxN4VNI5yeotkKRkKVnMxhq+Bt3a0mUF9mlCVhgEMFb3FM
 dDoYlPRT5Jwu9vFJwKHblt2ojHctrl47N/TjKdBoEIhJHxRpyQI0LGcjDku5XDgbtMxv
 WRhGiSCH6W55MR5tyVYaDe3OI2Mv9Iv5oAcVVQD3hknRIuZXIfBsnWuDkkbKBoDtsyPq
 233w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCkHtYCfq7w8Hzf8/W9JwOOjBhcOYTat/wGyj5dgsHJKLrJw4kHf/IFpqn6Ot78xZK8o+GfFQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzb7rdUIjScRRRIlbJ9P+5bmECZBmXreRCW9RwyU3+wx4s+LLnt
 em2E/YGBBluDHV2dXzxabuSdhYIEptMwPgxeb+tz9iEimHkYKdilKVbPcPVv/KeIOv8=
X-Gm-Gg: ATEYQzwZPjGZqYGOk0JZ+doXHIDhfXErpwW0J/h6+ANaP6sXkTlCFLo4XXsnTI7XWPK
 P1ggGlvaA/b8bOrdjddJqLmii8eByn2hNrCfidZtxAlDtKB04RQOUUWGqtUXDHwZ0V4x7RksTDX
 SblkNLD3rOBQICZFgWvR+lCwOCLydG8FcUe9rv+lTGyoTFkdvC1UGDk1r6bNd+Rhal+qhPqvR/V
 myHBSw41j/XR/COjlwcJL9ZRxSE7nboxkeBq0fV/t9j+5pV2x+QadiemI81YnAjI1UvElJh8v8p
 HaOyqlEW1ChMmL5o2lmnP2L+8O9TobiZR+WLcC4GgEMwz/KHIGkVHa31Q/XeoNlAObH2iZq+npZ
 K9MzyYMK++jyEGk6H0Z2ZwbDXqRy18QB3d0MBWSJDuI7Dd5dwkf9/qRbAg9c+KrsqRX0+s6MnBb
 P3Fy6gp1N1/N26JLMVbhC/0dRzYK27fE4dgfLaXXuxiNoEtGEN5ogfKSK2D9tPtWl59cCv7vAi3
 v1u
X-Received: by 2002:a05:6000:238a:b0:43b:9386:966b with SMTP id
 ffacd0b85a97d-43b9ea467f9mr27071792f8f.33.1774940293729; 
 Mon, 30 Mar 2026 23:58:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:48dd:d660:22ab:efd?
 ([2a01:e0a:106d:1080:48dd:d660:22ab:efd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e3602sm25273744f8f.4.2026.03.30.23.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 23:58:13 -0700 (PDT)
Message-ID: <9fd1d6da-db05-40ac-872d-6748759dccc5@linaro.org>
Date: Tue, 31 Mar 2026 08:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] ufs: ufs-mediatek: add mt8183-ufshci compatible
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
 <20260330-mtk-genio-720-ufs-v1-1-3bad8362ed70@baylibre.com>
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
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-1-3bad8362ed70@baylibre.com>
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
> Add a new compatible match for mediatek,mt8183-ufshci.
> 
> This compatible is already defined in upstream devicetree bindings.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   drivers/ufs/ufs-mediatek.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
> index 252c5fc4318..2cf65a3185c 100644
> --- a/drivers/ufs/ufs-mediatek.c
> +++ b/drivers/ufs/ufs-mediatek.c
> @@ -395,6 +395,7 @@ static int ufs_mtk_probe(struct udevice *dev)
>   
>   static const struct udevice_id ufs_mtk_ids[] = {
>   	{ .compatible = "mediatek,mt6878-ufshci" },
> +	{ .compatible = "mediatek,mt8183-ufshci" },
>   	{ .compatible = "mediatek,mt8195-ufshci" },
>   
>   	{},
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
