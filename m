Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D619CC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 07:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481BA80EEF;
	Tue, 25 Mar 2025 08:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v2+UIZim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E292780F70; Tue, 25 Mar 2025 08:27:04 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2991808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 08:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-399749152b4so1464966f8f.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 00:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742887622; x=1743492422; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/OUNNlFwssVdaiCkkBDfieeHAjF9lu74p6v3yiBF8Eo=;
 b=v2+UIZimGOLRgKm4gaN/OtXhKqxfnFXzO2Cz7AcjwGiP7OOEPX6jM3zqPWbLjmT8Ax
 6TwnUMC2dmvkFJ0o0Zi+l/A6wC74lmPKGgcHxOKnKJdnkJHJo5GbH379b+skxb1P/agw
 X3dm0LWMLQB64Q+1E8BiEvs3dyf+SRbL8rydpJYHEQt1xdMxeedpExAIKJE3fwR5T1bG
 bYB/pfPIPWiCCcDs1S8BebMQyIdUFAdW2zIn+CcQMuLXTmOiIOfQULhTEPNdSqDgpYCA
 uA5uEqJBSMmrXktIg2Q27sV5BCYAcx6tbEhmPMSmK8imFvZTxT4BDuLJOnjFeJ3y4hFk
 55TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742887622; x=1743492422;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/OUNNlFwssVdaiCkkBDfieeHAjF9lu74p6v3yiBF8Eo=;
 b=U0eGbU1QcodB76Irw9aiuXlojYcf6ss4LVSVYvJyja2vZzhyrvda2i3zQ0YPbos+Gh
 dcP0LYjYSa8pXu5mncH9YwT3fexD6KXXBOKbH4B96jT2P6XL08pdBByNyhVS6zP3CxDI
 jEtiTMkGPzjTUOLWAnmCLbesvSok16+D11TxyJVM/VTsV8+E1T27y8MtHRzw/XUydmgl
 on+AsM7xeFJDyC+IfV/qZf7K5ZTcOzs4JO8mKONSAum2Pv38iPyFzctk+JaMWXr5Teqp
 uYaPVEnzmSretRb9JjTDYEBlkyY6Xn0GQ6nOlPzP6Tmtm8HGbdeRINymFnaZY15fAecM
 7vPQ==
X-Gm-Message-State: AOJu0YxNk4NkP1khhjYIO5TRp+dVUX/+fKvGHwaCDGkdo2kK9AOFwKKY
 HivOvRpdatrpxC1flB8l9dqWD7Ajo/djZdBNh9J39+wjjWENTf1+yQqFlXRXtKs=
X-Gm-Gg: ASbGncvsADxBct4oCF73vVZI+v1J/vZ5EG2pg7o3fS3muV3d8RTyEa8SkBsS+yKA75R
 3XOSYkendV43Lf9zp4HwZTneCSRMA5vCa44BRn589i6bfmuYrqD2PG1YyAb2QArTDHV2ggY6R2r
 suwC5MORABMIGhTpawlhaFRAKAid5Be2sxZ8ZoY7/z37M75ScTxD+uuaM+bLHtshsFuz2edF58R
 PtkgjPQogI/vMb0Av5FQ8GKrZmAzis2+bwMhBjJW5Pt9Tel3CYGdCygGpfwdR5LCL9OcxDvhE+M
 eOGmvcr98tPpprPaqjVXjKA7x1hDvx0WEefbHJW1yE3vBRe/9iBVdD5tifHq7+oKZw/dlT1Smoy
 mt6H69+cqRRIpaimHfBjB1Mgs7nE=
X-Google-Smtp-Source: AGHT+IFgTjdWvji0/6EJALHQfL34qyjGDQTdZfOR+V2VfBpd6WLczgdmUqs1PQmwORuEebMcxbNcrw==
X-Received: by 2002:a05:6000:21c1:b0:391:4873:7940 with SMTP id
 ffacd0b85a97d-3997f93c550mr9832016f8f.54.1742887622018; 
 Tue, 25 Mar 2025 00:27:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a:6952:5850:1802?
 ([2a01:e0a:3d9:2080:7a:6952:5850:1802])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39abdaf0c0bsm8515695f8f.63.2025.03.25.00.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 00:27:01 -0700 (PDT)
Message-ID: <712f5d55-4956-4701-8a0b-1a8776624f9d@linaro.org>
Date: Tue, 25 Mar 2025 08:27:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] clk/qcom: sdm845: add GCC_AGGRE_UFS_PHY_AXI_CLK
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
 <20250324-sdm845-fixes-fastboot-v1-2-d177a10f336d@linaro.org>
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
In-Reply-To: <20250324-sdm845-fixes-fastboot-v1-2-d177a10f336d@linaro.org>
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

On 24/03/2025 19:17, Caleb Connolly wrote:
> Missing for UFS.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-sdm845.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index 7fd875e55d5443f170801172a373e0405041e1d1..5c8702ef2fe00a46a30dbdfddd6e649d20465006 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -113,8 +113,9 @@ static const struct gate_clk sdm845_clks[] = {
>   	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK,		0x750a8, 0x00000001),
>   	GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK,		0x75014, 0x00000001),
>   	GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK,		0x75054, 0x00000001),
>   	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,		0x8c000, 0x00000001),
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x82024, 0x00000001),
>   	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77010, 0x00000001),
>   	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x7700c, 0x00000001),
>   	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x77058, 0x00000001),
>   	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x7708c, 0x00000001),
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
