Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA88FD707A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4307D8435B;
	Tue, 17 Mar 2026 15:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pmTLOujS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C73D84366; Tue, 17 Mar 2026 15:54:04 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0A984207
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso48273045e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773759240; x=1774364040; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+VGfXf8z8ndmz8c7YGi6vIaU9CEQFt5LMM5vHTmGdiM=;
 b=pmTLOujSqv+YEhFPJv8wSbmNGtSD1k6966b7gnzKKq3HmGraJmOoN3hf/mHnjvtOb4
 K717dDJ10zWjM/No+xQSiZzZudk5YLqSc1CmK6EcgbJNkMm3NSQojLXmOr8bvv2Wdiyg
 FfP8ZeJUk3FP3idVUjkuO0RglVus/kb50m/AeR+szEs0//9gnKUurQB5N9qPoUq0XN9l
 F1e29e45XbB6Fwr/VHX4JlcSsEZc9VYh/3qSkBhNP5+w4VA13OKawMCOhQD+xzIAZuxI
 1aIWSk6LVEOo3gbO0/tyVmqmT861nWM74N/hgt6zByd0pLxNbtyZqfXtTgtylI1Twwi4
 5bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759240; x=1774364040;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VGfXf8z8ndmz8c7YGi6vIaU9CEQFt5LMM5vHTmGdiM=;
 b=jYhkP3ZP0IhPmuuDem36lsdDORy3gC9vHTtW7t5ZpILBVW8pCXVUo9RAW9rnTm8NgE
 nI9dmDSeMW+7r0RFFvY9sH+6+qUATyv0An+jejhc3Az58oWmNbpEd2zGDIH+Fb4c8WpY
 GU7JAZls0qthQok2k3abF0+3B0wn2YzUA38OS6cI40PwjPp58UCqPtmPwRp1t3H5eUD6
 BcNNk1r+Pb5KXdcYv9pRKme2oa+n3cCn38FbE+9iY7RxEGUphlo/+u8uQH3tPAQeh/V3
 bD4uykoCWRdQnF2akbRPEiwCMeJyrmpf2tPIZbB5tU/25trMJi7YvvIdxeA2MfDn+jjO
 P/eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZp8HOgx2SIOuQ1aloHoIL4eiY+nf3545oyUH1y/9ropv4t9a/1MTEMPt2hiU8DeIZMu+G6Yc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy21HsiFUI5HjQ/BZhLpTcLbSHHN/ZFWzC0LLT+zflGPOsSfNVp
 hDH5rHvcBEG4VMtFj5Tl8rR6dCxK2SHV+VnO3QfuLErcPH6uYfL9gnda2kP77MiYak0=
X-Gm-Gg: ATEYQzzX4OLiFVi1OQvRJR2O78RWepQk338jHiMox5+3vGl673qgqAEoyCyKrVzkQub
 9LiCnKeR3T3JTzyPYDMh2fH/eaJnSRQuzDoqWglSHza+2j1MofFwXdwEpA0Bn1neNKqAt+YqT+9
 MvK+H7hcgUXIhePg6QefW2imJZUAeHR/wQCnuR3mZRRaO2JAC7cA/4HXvO3o0nVVuNGVM+Jmxc4
 9J6Rdr9FOjguup4tI0bxcypCOuglyx91/VR9BXWGScxvkRylB4Ep6EGDba64HEDwejsBTWED4GR
 DYqCUhTjYppVnXeffugFr6xohnHz/6E9YDlP1PGNTf5lx8q3SGwjSvjVKQv8lsu/90izn4Ndkqy
 6lQI2p4tKDyzybuP44w0YYv6BvUGnbkLhsT+TJd/SyBs9Cp6uOKarPEDNpuhdEZ87Y1Vfn5gDXv
 HwIrAcIxAin6+iyKiEnofY8duLqwpi1fu7q8t/pAZWMM0zSsZYm+GH5ev6QLvlxs+4VXiEpTMXX
 dk3rrQ=
X-Received: by 2002:a05:600c:a4b:b0:485:3692:e8f7 with SMTP id
 5b1f17b1804b1-48556707ddbmr287227325e9.25.1773759240138; 
 Tue, 17 Mar 2026 07:54:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c778:639f:c042:aa01?
 ([2a01:e0a:106d:1080:c778:639f:c042:aa01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856e850634sm126132265e9.0.2026.03.17.07.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:53:59 -0700 (PDT)
Message-ID: <e78e573b-a911-4867-941a-440856ff1ac4@linaro.org>
Date: Tue, 17 Mar 2026 15:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 03/11] drivers: phy: phy-mtk-ufs: cleanup headers
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
 <20260317-mt8195-add-ufs-support-v1-3-7d731ec438ae@baylibre.com>
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
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-3-7d731ec438ae@baylibre.com>
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
> Remove unneeded headers and sort them alphabetically
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/phy/phy-mtk-ufs.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
> index 1eda3df858d..14a90cf2064 100644
> --- a/drivers/phy/phy-mtk-ufs.c
> +++ b/drivers/phy/phy-mtk-ufs.c
> @@ -6,23 +6,15 @@
>    * Copyright (c) 2025, Igor Belwon <igor.belwon@mentallysanemainliners.org>
>    */
>   
> -#include "dm/ofnode.h"
> -#include "dm/read.h"
> -#include <clk.h>
> -#include <dm.h>
> -#include <generic-phy.h>
> -#include <malloc.h>
> -#include <mapmem.h>
> -#include <regmap.h>
> -#include <syscon.h>
>   #include <asm/io.h>
> +#include <clk.h>
> +#include <dm/device.h>
>   #include <dm/device_compat.h>
> -#include <dm/devres.h>
> -#include <linux/bitfield.h>
> +#include <dm/read.h>
> +#include <generic-phy.h>
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
> -
> -#include <dt-bindings/phy/phy.h>
> +#include <mapmem.h>
>   
>   /* mphy register and offsets */
>   #define MP_GLB_DIG_8C               0x008C
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
