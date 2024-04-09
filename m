Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669F9C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82A3879A0;
	Tue,  9 Apr 2024 17:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KqeIgqeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31CB787E86; Tue,  9 Apr 2024 17:13:10 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECCED87519
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so60783851fa.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712675587; x=1713280387; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=PpY0MEaK901iCvwiALdyhnoHZwaDrhOBkVgv3cqdgdg=;
 b=KqeIgqeIFEk1r/CeT/KmrParVsJyM1ACLZTze8vGF2w5n1RaQkhKhuOE76Q8OurVUj
 5NcsAhUdhrY+X+BWlxPQynnq0ff5ar1bEwuUCFU/KA2zltWDE0t6gyXiUXxdmP7eM9PD
 MebCGW0RXqTt8tEREur9C6/2xUyKBSpLhBwmY1djVoe6zGU0wlduxv0VYzDzrdSKUeoq
 +pcUhh1eqjJDqSsNAftQM09+MWsjSqR8Rg4l76z83i/YJqRRGc1nVjR664vF//blXN3c
 wOP9xZH4csGUgoUJIccJUlljlnGRQgcFvHZMu8nqKhl5RYGttJF6Bsi/+4wPEwiJY1vx
 9xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712675587; x=1713280387;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PpY0MEaK901iCvwiALdyhnoHZwaDrhOBkVgv3cqdgdg=;
 b=RCWmMv9hMcCrgZ0wGSMdz0DdV9pjDRXJmVWyeqgiizYBI+wxf3YM6X3uyyHVfoyiPk
 Q1ffDs3ieHs+6LHLfuE43mFlhviv/oKVTRca+xFk/VvsUkVpcbl2otMHexL83NmMHRQ8
 bMyh4kSBLbFsN3/O5nJPuy2IkGIREVcD7xKteKXlNwkjhReA9BFN4gLhiOFZqTfF89xJ
 GDJwgm2TF01qpCwVWbhpMXoRrnAneC9e5aMLn6yvJ3eQQOcOpvL5ckuXQPjiz+IplTSZ
 8knierq0ITsjnLp2ArXknwSQjD7rd577kh23iGYmpYfxceE7tY1i9oc1/IPUouEErafW
 nGfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJbvEkX5owM/vUzZQBcZAnSjtmkmqZccaznUQV8NY9uSQpwfMaODIJc46SLFM/O3s47en2ajUnZEbNKZof8H59gsLzGA==
X-Gm-Message-State: AOJu0YyizzJ1T72j+mkTA66m2h/QwQSlN4bWJNLExNn9dj/mCXkTIxxG
 OdkLJb0lkkSrrYu7fpzPxlcQFlhHOSwthMGYWBhrSSywTMB3/qkl28zQNIpg8jg=
X-Google-Smtp-Source: AGHT+IFQ9beifkNh+nxwXG1D8uPKUp0BTmlx2lSVJ/SoFbD1Wcjser71Bpj5rLMsQW7YjTV12npRaA==
X-Received: by 2002:a2e:a223:0:b0:2d6:c0eb:41cb with SMTP id
 i3-20020a2ea223000000b002d6c0eb41cbmr97323ljm.3.1712675586846; 
 Tue, 09 Apr 2024 08:13:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f55f:39:b3eb:53ba?
 ([2a01:e0a:982:cbb0:f55f:39:b3eb:53ba])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a05600c294a00b00416a97a0ae5sm980135wmd.0.2024.04.09.08.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 08:13:06 -0700 (PDT)
Message-ID: <4f5901e2-ff22-40f3-bf44-73a7b1497e9b@linaro.org>
Date: Tue, 9 Apr 2024 17:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add Qualcomm mailing list
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
References: <20240409150252.561029-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20240409150252.561029-1-caleb.connolly@linaro.org>
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

On 09/04/2024 17:02, Caleb Connolly wrote:
> Add the newly created u-boot-qcom mailing list to keep track of Qualcomm
> patches.
> 
> Additionally, link to the U-Boot Snapdragon custodian tree.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: u-boot@lists.denx.de
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0462ade4ac60..c0d2b5138fca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -602,9 +602,11 @@ F:	arch/arm/dts/am335x-sancloud*
>   ARM SNAPDRAGON
>   M:	Caleb Connolly <caleb.connolly@linaro.org>
>   M:	Neil Armstrong <neil.armstrong@linaro.org>
>   R:	Sumit Garg <sumit.garg@linaro.org>
> +L:	u-boot-qcom@groups.io
>   S:	Maintained
> +T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
>   F:	arch/arm/dts/msm8*.dtsi
>   F:	arch/arm/dts/pm8???.dtsi
>   F:	arch/arm/dts/pms405.dtsi
>   F:	arch/arm/dts/sdm845.dtsi

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
