Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F0ECFA773
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F06836CE;
	Fri, 21 Nov 2025 11:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="APAdRZJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD94183700; Fri, 21 Nov 2025 11:48:01 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB4980433
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42bb288c219so1737639f8f.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 02:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763722079; x=1764326879; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=UP26dRtPjwey3byvujvptDklnUzeCReUTj3Xt02c09M=;
 b=APAdRZJ73GmLXbWR52IRJBpWI9JSf3mJF66dVXnR8u8oz+AA7zwSEnViltlszEysb3
 cSxFdpeJc96ui5wE+7N/7vqiVbmQDk5yrubKvnHo6Yox4zuFYdiZazBgRCEFsx9SGROi
 BAOQOvz4A0+LavD8+OmWhry59QRPypu/fs984Ew1IXpAhInOjGSLbWXs1g1QAVC4uW38
 gzTBcnBGE5WM/Iz1XXY77HH7Wk9ohqxzXwN4/ztV5m93EZD4OoVP+Zg4aBwu9qeRLHiV
 g2biWuz3WnD1FDR7K+gslGjDSCuTRYm2GV3vfxojKttb6gBf5JsyN00XUG2h2CzO0D2u
 eudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763722079; x=1764326879;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UP26dRtPjwey3byvujvptDklnUzeCReUTj3Xt02c09M=;
 b=lLZpO7wRSqmm2aZhosRmaMuA2UdMKT1Q2yEOyMGwKAxlCX2GgbZLK3USIHmZix6hdO
 WC0WN69ez5T/BUOm2aTgU/AaYo73Ktd/+gmz1FnebwzCE7CBIc0t8taiAJzWOFgfORfd
 yETCsR2PRcRLiuUw3plSOBcIO7ASITT/OUZpsLCQZk8t8k5J4mKeDmZE3Rs+WZXU2xR9
 PQVviyaq8Lev5H97ksJXIM9kHEbcSFXsbcXr21kaJKxtXePhrqx5FSlPZWmkgzEZaVxV
 pQ5pUrWOoZ4ijmriaHSvYU5I2wXNpVNo+6/iZVaSbUp9ot9K4JVkr69ZvA09j+NzosgH
 4GjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk6N4pA465GxmkcCCo8N+Mxn09OkGEAM0+gs2jC3TGH//nA7K99MZ8k+O6c3wchz3XUw+X68s=@lists.denx.de
X-Gm-Message-State: AOJu0YwWFTbguZ2KNSbnioFIBV/KVf8ZwvhZ3RxIoi+3RdafnQ9tAtGN
 e8aUw3YIkUu8NSNnnYhhb/WFFW7RkhmFYRkkTypDPFmILTwr7ycU8epgFYuVBjlL/lg=
X-Gm-Gg: ASbGnct5IXavdFmS+XSZ9+y7Dmsp0KWQ2qy20z1mPWD6yFu6lwGfZWWM88+gWOrNy5t
 /k2x8cln/BkyPdiZr0hGp+wVAL8BCrvaspxNSXzow503UKWtku3OBkQauA2U/9d9Nt3tdo8Gfm6
 eo4ty0F2MKIDcRV1HEmWyTNwMqEZT1Aq4VzYkOvjTClLpFCPKIl898/NoTsiz5/m2dnfaSGpgoE
 K+/UDlHbZxo1jOIF7RQCpKOttmHt5RAIXEgir8ThSkOYekYJVmT9HQ+peptotanrdh2wQbFUdYI
 XOXFKhtmd7KfTvVzey0mVEkhwQsFl5wrflmvq3URLU5Xh9IFfL2reW3C0Lt+lKgFKMZdjC/rlxA
 PDLilpFnU7alecwKR3+Zp0SkY/jhhq5TCIKQghJtGGNpJo2lMe4A/bQhABz8XIwy28hkybxEqzc
 l++Z9i1bi+7C4aDybMwmwjBScrfRMo8rc+iO/5Pz9MTcdQuZ3h/Ym+E5HTNP+Is/Y=
X-Google-Smtp-Source: AGHT+IH2V/dCL2KdnY2cxuOUDbs9M2ypO4u+xCp6fsD/FhAHbJ4Aip+yAeJNEFnvJlfnIAh+CWsYyQ==
X-Received: by 2002:a05:6000:228a:b0:42b:3e60:18ba with SMTP id
 ffacd0b85a97d-42cc1ac9ca3mr1898464f8f.8.1763722079077; 
 Fri, 21 Nov 2025 02:47:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:159f:1839:bb92:1eca?
 ([2a01:e0a:3d9:2080:159f:1839:bb92:1eca])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fba201sm10324759f8f.32.2025.11.21.02.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 02:47:58 -0800 (PST)
Message-ID: <5a888e41-10c6-4061-97ee-9cadb25e6a40@linaro.org>
Date: Fri, 21 Nov 2025 11:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/6] drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
 <20251119152530.4175628-2-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20251119152530.4175628-2-balaji.selvanathan@oss.qualcomm.com>
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

On 11/19/25 16:25, Balaji Selvanathan wrote:
> Add support for GCC_USB3_PRIM_PHY_PIPE_CLK which is required by
> the USB3 PHY on SC7280/QCM6490 platforms.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/clock-sc7280.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 55a233df394..a2af73cd976 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -111,6 +111,7 @@ static const struct gate_clk sc7280_clks[] = {
>   	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
>   	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
>   	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, 1),
>   	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
>   	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
>   	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
