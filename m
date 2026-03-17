Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B33FD708D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F4F48437E;
	Tue, 17 Mar 2026 15:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V5ycglaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B13FB8437E; Tue, 17 Mar 2026 15:54:14 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B0484372
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43b44c0bcdbso2075322f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773759252; x=1774364052; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=d/Obwa66iX/nVC+KJOT9ZJ69icweINEqmuK/SyyG0rs=;
 b=V5ycglaSIP95xdbrV2XqjurZdBnshWw8akQWDW7Gv7qsk8qB1z061zcgHYskXLGv2a
 NdfdPuqfHPUY+5jygCFyzGgHJi5J/ZthEO/eNAeZ4dazimwtbrkBC56PEhNRIoevy3hr
 avFvPV/QSPHPsmTktTJ8E9ULXqqBE3jBKoo8mv6AmNrmDhrQe1SBM5WT3C8K0dJm/YOB
 ZvfYfDtNm4zLPK4iNDmOjhcKreWMxEqGsgaQ5qsn7CW68WvERiratRN/Pzd1hmMkvaKs
 4BdpITvH/eic38kaj8i/OXzPz4zHIrBgFR3LmifQWz/mqdEfNotAtjEzkJ3VUdAI2Ccx
 S5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759252; x=1774364052;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/Obwa66iX/nVC+KJOT9ZJ69icweINEqmuK/SyyG0rs=;
 b=NWt7T5+7gRcuWbJlchVcpIaqsxH3TlLOrlQnKyveirlJb4IjsU+8fhru3x9bxjZzcx
 sGJ5iiRKGDLzidLzhWXYo/AdMMXxO5EOTwLhsm8dZCtRTMF7SSr6RtqHGIUWlq0r7eib
 b4y8oDOG35FJRethvAlBUEQMup1bXfqTkPjYCyT39TUXr0Q+83+WFMrEQdkr1lFueg/A
 DrHXWr/KuCUkqQCUDBz9dLQprEovJxai9v+zPSbtXizYpXv9ygdiDSf5FisG6oE1ojst
 6YEPrKKr7o+XvLGSeR+b56uES4r8Xs1ATZ5VXKjj1mLqxOfrJ0YriVe5Xq7E3XXkh6nD
 LFXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2pNC7iXJp2dxZqc5YzOGw1HRK05o1m+mUb1MaENDchnzlgjp290vqZhuBnfmx/j+aIDM43TI=@lists.denx.de
X-Gm-Message-State: AOJu0YzhDRnDYabMrXZ5ZtJJAZ59XFFAutf0u6IWGm3XGlyWjaHehgCS
 j1/cLKw0iZu3LPWCaLlTWfrvSGij0GK9c+RocGFtsJ6sOowzSJqe9VQlTjf8Oj780fo=
X-Gm-Gg: ATEYQzwauo5ZjewFDDL2XmbdqlSB1INOSrK0zQ6u4PbvwqwVtdKa2iwp5Q2agkvukkE
 cAP6SjwvvAFH1QnkdUJ5VyJeeg198EUdk299ZRD1oYucA5KKPJ6rN4vCB0RBEEpmmXPZw5CSJfj
 F3OE1yxsn7GU9o070qTcbaqtad4MBgbB6v1crE2Waqg6n/Wo3uAzeMbGtXwUin85UwUdMQeFhex
 XZqNUvavmU7RmRQNuYgu952iFpd+aU6Ob2W9i4pse7abjJlQL4xf6dDAC3uBFN7bUcV3jv9OqN3
 cqqB6bNyc6GGQkyvuwMLYJXGEPQVJCcZ/yFl40MMO3JqR03A594AMWzK4qSFjHE9/MZC2kyGbB+
 A+vlDsVxqP0wVTTXV7GAwikBgI98Wb3iKgWP0YAnH0EVmpKRf8j/wf1sFE1ypwNdJLgJYAH7nSo
 AAWIKv41jTUCVUktOpSyzyJXiagFWDQOqy5cgcaJA5py+gqLSSF/0oojkOkuJ6/rKWBepYvNzcZ
 HhUbA8=
X-Received: by 2002:a05:6000:2283:b0:439:bd70:6114 with SMTP id
 ffacd0b85a97d-43a04db4e31mr31670758f8f.38.1773759251640; 
 Tue, 17 Mar 2026 07:54:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c778:639f:c042:aa01?
 ([2a01:e0a:106d:1080:c778:639f:c042:aa01])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852aa8sm48400f8f.15.2026.03.17.07.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:54:11 -0700 (PDT)
Message-ID: <83f0c95e-40bb-4542-8954-37dd990c4479@linaro.org>
Date: Tue, 17 Mar 2026 15:54:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 04/11] drivers: phy: phy-mtk-ufs: use tab to indent defines
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
 <20260317-mt8195-add-ufs-support-v1-4-7d731ec438ae@baylibre.com>
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
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-4-7d731ec438ae@baylibre.com>
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
> Use tabs instead of spaces to indent defines
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/phy/phy-mtk-ufs.c | 38 ++++++++++++++++++--------------------
>   1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
> index 14a90cf2064..321151172d9 100644
> --- a/drivers/phy/phy-mtk-ufs.c
> +++ b/drivers/phy/phy-mtk-ufs.c
> @@ -17,26 +17,24 @@
>   #include <mapmem.h>
>   
>   /* mphy register and offsets */
> -#define MP_GLB_DIG_8C               0x008C
> -#define FRC_PLL_ISO_EN              BIT(8)
> -#define PLL_ISO_EN                  BIT(9)
> -#define FRC_FRC_PWR_ON              BIT(10)
> -#define PLL_PWR_ON                  BIT(11)
> -
> -#define MP_LN_DIG_RX_9C             0xA09C
> -#define FSM_DIFZ_FRC                BIT(18)
> -
> -#define MP_LN_DIG_RX_AC             0xA0AC
> -#define FRC_RX_SQ_EN                BIT(0)
> -#define RX_SQ_EN                    BIT(1)
> -
> -#define MP_LN_RX_44                 0xB044
> -#define FRC_CDR_PWR_ON              BIT(17)
> -#define CDR_PWR_ON                  BIT(18)
> -#define FRC_CDR_ISO_EN              BIT(19)
> -#define CDR_ISO_EN                  BIT(20)
> -
> -#define UFSPHY_CLKS_CNT    2
> +#define MP_GLB_DIG_8C		0x008C
> +#define FRC_PLL_ISO_EN		BIT(8)
> +#define PLL_ISO_EN		BIT(9)
> +#define FRC_FRC_PWR_ON		BIT(10)
> +#define PLL_PWR_ON		BIT(11)
> +
> +#define MP_LN_DIG_RX_9C		0xA09C
> +#define FSM_DIFZ_FRC		BIT(18)
> +
> +#define MP_LN_DIG_RX_AC		0xA0AC
> +#define FRC_RX_SQ_EN		BIT(0)
> +#define RX_SQ_EN		BIT(1)
> +
> +#define MP_LN_RX_44		0xB044
> +#define FRC_CDR_PWR_ON		BIT(17)
> +#define CDR_PWR_ON		BIT(18)
> +#define FRC_CDR_ISO_EN		BIT(19)
> +#define CDR_ISO_EN		BIT(20)
>   
>   struct mtk_ufs_phy {
>   	struct udevice *dev;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
