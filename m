Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0469AC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E3D83B03;
	Thu, 10 Apr 2025 10:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bz5YW5SC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CBD583AE9; Thu, 10 Apr 2025 10:56:51 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 234BF83AEF
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso2586865e9.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744275408; x=1744880208; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=mi4NZutOJVhbVIO8zZ+WMV2RQj152K6jx/1YmB9Htao=;
 b=Bz5YW5SCcW5JSLOIXphzHRDxdvkVyOHXLZ9b7fyCuic1RazvyOcwmQkbe3B0JMH5T3
 9BZbbEiwzuNRYdDlb0aaPs9i8I/hV9k5jTty/EtokA45qSxrF4h3dHC9KTuju2bxiwZq
 mDizTjm8BX0Vx6Ol90Bms/8zuwyfE0gbh7VoAiUGDowxsa2H6X1X2Jy/jGkSCn6qtHW8
 nvrquYWZwFDGd66LRjJmVVoNefxhbkb+pDlDarAdcduM2JyhyymTpW72U8GivtjKx13k
 RV1JEf34VKLIpRIHc8qnilY1Q9XlC24d9d8eMaKKOBVHGGcQ5dNcdQPX99g5YwaYLUar
 R3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744275408; x=1744880208;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mi4NZutOJVhbVIO8zZ+WMV2RQj152K6jx/1YmB9Htao=;
 b=qTdWyZjiJBxOTUtPTR++7Zo0H2ysoFKfoq6L/MhEYIAEI+x0z+WEXSpchw7Uyz3jqm
 ZUp5eeXuJ3SLlqr/NnZvSYfAMn70BPttRMsJzDTc3oB8OXKJk1kcTO4ztGZWINhEW5/O
 FC7VsKCu/yyXAcvBWie+AecrfBuiCXel/eZwiyv9H9H9AO+1T7UtRgEzSyEBaxIrE4ta
 E5vIZmqCiAhwfkdsytRsXu/SF4bmQBcGwsAfZcrJr/0oABkuMcLAcaUxpPEcD6OPYHLr
 PJwVTb24lIKvgD7yCrhnC1CcMxdM3bmoXi+Udq3rvmkgVqDMexjwskHwuL6XhDv9Lpr0
 mq/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFmNS01DpwgkjZ/UXIVxY47zph3BTiw1FfTn4fibEVNFhjA9LBS4iFU91lFc01N+iwyvclKeI=@lists.denx.de
X-Gm-Message-State: AOJu0YwRfE2UdUgXcmHsUc0Iedtj4+UhgxOUJtL8AoI2CM43p7oqLamg
 O4TwfYxokBS3+feV7EzsSngC5Cj+FH/SNdgl3DVPxMdv66F/RTLtN4bUXUu+owg=
X-Gm-Gg: ASbGncs5f3zOvy5sNp5MxO6+QdhIxiSdJEUvH8nD+kt49mibA/q9eAG4UzMvPLi4oWT
 m0NDMXyfqpTRniNXYyzjk4Qg5s2a5vCKLyOhO4ZTTeIBDVKqe4Xhf1Cmq99mcJeFhnWItii4rQj
 57isru5ONMqNK36NVT2IHcqVPN13Gy5J/itusCiFX3+03vBltbcFDHcnkODy8TlkWxkNZpsW/Cz
 v+YOn6FunwdQh7HT2m7QWYUoC18qszQmQZ+pZxsuyBsL0rmGRHEbeXlgD5oB2DNxlf7nL7QigKj
 5NLgv+pheprJjwV5wzHWx4LatDGLdKt4G3L9TmHWB8n5se3KxqNr+QAOvYNxteF75i5zcQxN3Fp
 fq478J9qnU1kjkSka3g==
X-Google-Smtp-Source: AGHT+IHr7K0X/Ft0H0FA7TO+t4lZtlFQ+J+ZUiaIf6lD+6WMP5kfpGLY7sAbzR6fw/2T8JQE88TUzA==
X-Received: by 2002:a05:600c:28e:b0:43c:fc04:6d48 with SMTP id
 5b1f17b1804b1-43f327bfe64mr8310165e9.0.1744275408562; 
 Thu, 10 Apr 2025 01:56:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe?
 ([2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ec97csm48971635e9.6.2025.04.10.01.56.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 01:56:48 -0700 (PDT)
Message-ID: <952b09b6-aff4-43fb-be0b-d229d6e9cda6@linaro.org>
Date: Thu, 10 Apr 2025 10:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] phy: phy-qcom-qusb2: Fix USB PHY power on sequence
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: caleb.connolly@linaro.org, trini@konsulko.com,
 alexeymin@postmarketos.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250410080027.208674-1-sumit.garg@kernel.org>
 <20250410080027.208674-3-sumit.garg@kernel.org>
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
In-Reply-To: <20250410080027.208674-3-sumit.garg@kernel.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/04/2025 10:00, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Recent addition of support for SDM660 inadvertently broke USB PHY power
> on sequence on RB1/RB2 and others with following error:
> 
> starting USB...
> Bus usb@4e00000: QUSB2PHY pll lock failed: status reg = 0
> qcom-qusb2-phy phy@1613000: PHY: Failed to power on phy@1613000: -16.
> Can't power on PHY0
> probe failed, error -16
> No USB controllers found
> 
> The root cause was the addition of flag se_clk_scheme_default which was
> configured correctly for SDM660 but incorrect for all other supported
> SoC. Fix that by properly assignment as per upstream Linux driver.
> 
> Fixes: 475497dc3c15 ("phy: Add SDM660 support to Qualcomm QUSB2 phy")
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>   drivers/phy/qcom/phy-qcom-qusb2.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
> index cabd05bf5a6..d98f6108e69 100644
> --- a/drivers/phy/qcom/phy-qcom-qusb2.c
> +++ b/drivers/phy/qcom/phy-qcom-qusb2.c
> @@ -230,6 +230,7 @@ static const struct qusb2_phy_cfg sm6115_phy_cfg = {
>   	.regs = sm6115_regs_layout,
>   
>   	.has_pll_test = true,
> +	.se_clk_scheme_default = true,
>   	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
>   	.mask_core_ready = PLL_LOCKED,
>   	.autoresume_en = BIT(3),
> @@ -256,6 +257,7 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
>   			 POWER_DOWN),
>   	.mask_core_ready = CORE_READY_STATUS,
>   	.has_pll_override = true,
> +	.se_clk_scheme_default = true,
>   	.autoresume_en = BIT(0),
>   	.update_tune1_with_efuse = true,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
