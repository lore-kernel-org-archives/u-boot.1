Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5026EC3ABD9
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 08:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AC381DD6;
	Wed, 14 May 2025 10:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ma2LoLk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB2F82162; Wed, 14 May 2025 10:34:01 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4BD8129F
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 10:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a0b637db6eso3918006f8f.0
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 01:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747211639; x=1747816439; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=An/4J6mq0/Lsq8RImj+jbRgbQIeBi+q745AJ8J21LhY=;
 b=Ma2LoLk+TnGMl7IvztBiUTihsWuxvvYrisACtPRZiVfkdBZj2cya7NEWHVh58lP3aw
 8FDYFypc0OzR/+0Ac0jxb3wBghjJqrdgJiHXvsplHtry3xmaP9E8b53kuGZU15rmHhtd
 rhWy+xFjHsancDc5PfzT0jqz98UPmArGhGpOLedpDwEZJRvK65a3agx7ZR2Prlo4GroZ
 LsYj61F2+k/+z9LrvRZhSEur+MI2jw10rF3GUJSfgWl1frWmTtEmJTKBIHj9x9Sxm3Dl
 tZth4d0ZYNpSinCaN7b/lEsZ5fMemkdrnd8NGOzSA20J8iTzcTU6AYXyXdvTCGScemq2
 SJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747211639; x=1747816439;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=An/4J6mq0/Lsq8RImj+jbRgbQIeBi+q745AJ8J21LhY=;
 b=Ai2ZrAgXB+bEAXGPRvyR5tjWQ/dLc2IP7T5Pv+cCdgsgSAPOjFnsjy5N3tbb/Tm3TZ
 mxal8uhhnQ79/k3BMf+hE6AhIpm+dBGr5rIkonNumk/znqO+nrCwn0eGwMOlL/iDLzak
 i+AHt+laNIClZfYRSOm8NmROcXVpeeMhcgJFOqJZNOjTRNrcU22CH3vDqvXUMXlxQnOQ
 B3ZDnlkMM6vqPR3d3zrHmEGnZsSlO1nQUl7rEGG8oKpYMnHFKEaXeqjYDxy1kAWmKaGu
 0ntkzN0QVcAgxS2DzezV+04m3NAmmYgn02slvQ91FwEMx01WK8lUN4osGECuBbFD3Zkz
 gcNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq2PSQSheEI2/Ytr/kn/BZ9wSH1XNI0jOrZEFGJWd5ZqOoDgJ5p7PJ3yBlwMAA8jBJ5mi6DY0=@lists.denx.de
X-Gm-Message-State: AOJu0YxPq6Tv0sNuVZbBwTejKM0t6GmoXBQdOCrJuDioiSde9cWYEkdU
 N0FL0g344yVHydSGRhOytDlXyU/3/hkLYTNU7ps+QhrMwoN964lYqhxmeT589sY=
X-Gm-Gg: ASbGncumckHOwpzq7hkXx6486er9Kb221pNQXp1ih54G10GVVdqQZochieTMDblWsLE
 lSm4ZmPgB2UPak7ipQHKVZ8Z5SifSa5mf6164jaH0vlkPjiWoPTqEkEbzqwhxo68bc2jstVhQ2n
 eL5YlTCbbYWiGZMEkHPX6SaHzr6mPB48vpGU8Y3VJlmdGrx5pp0PWUNwswikgEbuoHFat7PqNYE
 bWBzzrPNqpTn5gukQocGCtGnJbI36ZdCJ87jgITwu9/+6r2SkXR3EFvkQaHGdPTaQa7j3gcrdxE
 y8ajgQKrL73sTQCUYNbG4vw5Q6DYLWwwsgxsr3ymNBa1KKxctxx2nFPdZWLAaoLwsS6oJ/UO7af
 //XZ3XH+XerAet9F6n547LI4=
X-Google-Smtp-Source: AGHT+IFpXFar7j2HRJg+sVXIjbMOWJ0E9no4YgFqPKQGNWYbuQMNhJ4501DNtGrR+mwZY+SLDOqohw==
X-Received: by 2002:a05:6000:184c:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-3a3496c36camr1962746f8f.29.1747211638753; 
 Wed, 14 May 2025 01:33:58 -0700 (PDT)
Received: from [10.61.1.139] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3951adcsm19876405e9.19.2025.05.14.01.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 01:33:58 -0700 (PDT)
Message-ID: <0721265f-5466-457a-8e78-a91389db6dd0@linaro.org>
Date: Wed, 14 May 2025 10:33:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/6] phy: qcom: Enable QMP UFS PHY driver for QCS8300
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
 <20250514044212.1422714-5-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20250514044212.1422714-5-balaji.selvanathan@oss.qualcomm.com>
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

On 14/05/2025 06:42, Balaji Selvanathan wrote:
> Enable QMP phy for QCS8300, referenced from Linux.
> 
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> v2:
> - No changes to this patch in v2
> ---
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index 449b9767778..18cc665647f 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -1469,6 +1469,7 @@ static const struct udevice_id qmp_ufs_ids[] = {
>   	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
> +	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
>   	{ .compatible = "qcom,sc7280-qmp-ufs-phy", .data = (ulong)&sc7280_ufsphy_cfg, },

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
