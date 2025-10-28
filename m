Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A07FCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F7E683946;
	Tue, 28 Oct 2025 17:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YuK0B9Cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF4983771; Tue, 28 Oct 2025 17:19:21 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBDFB80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso33849f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761668359; x=1762273159; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TkmUPIggogctLSrYu94McPwVHunUUc4wMvtFpDDsAOA=;
 b=YuK0B9CxmMqlNNg1Y7Zo6supmSz5LE1JNehu1RIlcVzECSHkojkiH8KOlBmW9Wb3If
 xK7Hder/tHE0ZdsS2Pi2hWs8qydktvWo/GICh8FKiRuF2XOZP/4UDXxbwLWMDesM2Osp
 ZPpT9yLTfyQSjcxzfV51Dy3tIUEeP0GkbsUB61iauKVd4+Q0soRsNgyZ+PovEXBS8Ql/
 Xa326cMGgVR6zteHJnen91C6VlLyeRChZQmw+zpOMJAXFAcS6VCkAPIhpNzirrjDHNb8
 oYFIZddwpVvdbNDsx7HNB27DxrxU9lBMSx6yNqkUKOBTkYwrKLKpuIXsrRAlmLiFDNTY
 8T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761668359; x=1762273159;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TkmUPIggogctLSrYu94McPwVHunUUc4wMvtFpDDsAOA=;
 b=UmfITObZS1+WF2IMg3apNLGC23jWnRWmxVvKlpJViMH28Om42P9KAbOreNR2QX2kX2
 3Jll6VKWv42/f0je5gg0+JJhP1au+26iXevxG9jJvWzFAgIvJs4rHwQqqO+hwRXE+6TE
 HKK6JwRlxVEjWxlkMsPOyH2Igf2DL0vYGU+GxfVaJw5jMPBGe4BU9iBUplA3QE0uKM1c
 /7a3sguqKdXVFVDj5JfOpF7UmZFwk7FXvsMWPPhnj+3KU7Zn+2M6rS52ntwj2LSKg8Sn
 Bj/+y21Y05qAtRsfQbPFq0GcvDeOzhn3I8aHBxtbr44bIiKvJPAQQMxoWwOjIiKkahw5
 C6Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4FwLvQn6n68+NBtHwytvxVhtOBbErQWf+TZshbxo0B67TsyOrfK4uFJzWqjEITsn4GiuQgEQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzxakV9E3m8THv0gQY3WzAO5HliaK2tMm4AR6OkP1VzKUBuYi1G
 UERyILCTweKjQoRblWF4qOpKUIslblOf+QcPb9gZGgvfq4ccKBHfnk/l27eMRpbJ4nQ=
X-Gm-Gg: ASbGncur6DfcZ77C/JMmI49/e88r5wy27KXDfp1Q98AfZilCD0o41+X4SgPJHp7oGxq
 wO8XM2NeHYswwv2wMEquNIiJMXafsVM7YGPM5xMZgNXW2FPRN2uW7aXVbGCWtg0S/IZeGI0a7ip
 NcLAvg+E1KsYAd28+sfH4+K06+ypZKd+tiZ8sAq7KouSWwgoI3ODF7dtc7pwg9z2fXa1kiASLXc
 Ax0J9Sg0xfN9aNaYjjYs/OjjEfawvH99pKxNvMeUyPGHCkdCcosUWtwBppXzkqSWnEIYfq89UHt
 zGzRHuOKrKfFFZ2SyfQgBrJf0+RBZ40kh3HkIKigwhtglJ7qyk9QmBRMg2+DViWnSDKKT13KSCY
 i0FTSgvLFzivNIFTKPfHpnXQ6RBSc4ILHQvIkcxzXwDiBKZG4O71gHVKqOfJOpRC8GFl8YICc/5
 XCKcQjVIOSAegx8Zlv0/ifmbnscv0DwAJai5NrfyDtFCbmIgq5cA==
X-Google-Smtp-Source: AGHT+IEYeHslBRwCq0TfG2KoR44X6E2mGwpvh/IUXoMDMCDFwaV2MxtimM0HnDpo0hNJLbTTtkmyDg==
X-Received: by 2002:a05:6000:2211:b0:426:fb27:974a with SMTP id
 ffacd0b85a97d-429a83e5079mr3441414f8f.27.1761668359071; 
 Tue, 28 Oct 2025 09:19:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7badsm20762904f8f.7.2025.10.28.09.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 09:19:18 -0700 (PDT)
Message-ID: <fbb4dc27-0aa6-4621-a25b-ae6bf13bbfd0@linaro.org>
Date: Tue, 28 Oct 2025 17:19:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/4] MAINTAINERS: Add UFS to MediaTek section
To: Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Minkyu Kang
 <mk7.kang@samsung.com>, Tim Harvey <tharvey@gateworks.com>,
 Roger Quadros <rogerq@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 Sumit Garg <sumit.garg@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht
References: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
 <20251011-mtk-ufs-uboot-v1-4-a05f991ee150@mentallysanemainliners.org>
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
In-Reply-To: <20251011-mtk-ufs-uboot-v1-4-a05f991ee150@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 28 Oct 2025 17:30:22 +0100
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

On 10/11/25 21:10, Igor Belwon wrote:
> Add the UFS driver files to the ARM MediaTek section in MAINTAINERS.
> Add myself as its maintainer.
> 
> Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1db1070d5f8d2fb74836bc8e55ca13fe6b292d93..30b2b602d2f3edeb6dc54f9d65211a372de9b896 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -410,6 +410,7 @@ ARM MEDIATEK
>   M:	Ryder Lee <ryder.lee@mediatek.com>
>   M:	Weijie Gao <weijie.gao@mediatek.com>
>   M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
> +M:	Igor Belwon <igor.belwon@mentallysanemainliners.org>
>   R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
>   S:	Maintained
>   F:	arch/arm/mach-mediatek/
> @@ -433,6 +434,7 @@ F:	drivers/spi/mtk_snfi_spi.c
>   F:	drivers/spi/mtk_spim.c
>   F:	drivers/spi/mtk_snor.c
>   F:	drivers/timer/mtk_timer.c
> +F:	drivers/ufs/ufs-mediatek*
>   F:	drivers/usb/host/xhci-mtk.c
>   F:	drivers/usb/mtu3/
>   F:	drivers/watchdog/mtk_wdt.c
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
