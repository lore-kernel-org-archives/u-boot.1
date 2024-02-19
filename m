Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA3C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E714B8765B;
	Mon, 19 Feb 2024 10:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sz6ewUtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9F387F4E; Mon, 19 Feb 2024 10:54:02 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197EE8765B
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso1929562f8f.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708336407; x=1708941207; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=H3kWVPlAs4u0rPquVylN8xwJUTU9io8GnB8LE3BoR+A=;
 b=sz6ewUtcDRWLf6GbaQ81zUqMZzwJkWPuB9C0VAYttzJG8T9QakL717J8Nbwrc5Msvc
 FZwpYJu+0FJUbTAn9UvrLdsHG7WMDD0+Hd9L0TV6cKKQcGJ89JgIgKkTT4kb+BEZcFQw
 Uiy2vtz6RBMhEExKN51dbBjJh94cHnLCMD4VJDecC8p4tbtoubT2TO2h38OtseA4eOdM
 Wnf0cg3LI6P8InOGHXoyZZ5sA0VZXA08v0VvvFfreR1Zd5oYPyckQVe/2V61kFdSn3ty
 0VqhyV345oRoEaj2MdCXJagyXs81Qvw9eyljamFv2S8d9ZBVO4mkAun6RsyXeAG9LvnZ
 6Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708336407; x=1708941207;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H3kWVPlAs4u0rPquVylN8xwJUTU9io8GnB8LE3BoR+A=;
 b=tcFPpIDOU/xWLlpEPaushbEAcDMLxjVO+sdhLIsbqISgBrl7VLsN3xYc/SbFyYYvv/
 cSVhqhOqKO4P7sMA9PFSxcf74OP8wedojASLIJv2fiMxx9o7OtFFJphv3ClZFmktSj+m
 9nc4ZKUFLMkWGsi4uzFYF24QYPHtSkEf3I+UFHlunMu6IYsTzTXdRMF78/75OZQMDe0F
 PGXOf+Rx7iQeejYwXlEI0XFkO4JqROVGECziXHA6OrvbjcRweZYZtjmIxUmBgyNR5atz
 q6Gj/vjEGx7XWlybDLiVUl+BlgFJBFzzwWGRbAbIbq+yhYhYzJEqHgMHO0DBLx9+Vr0u
 FGzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEdP7ckKLelBoRW4iXydb31JslPRe4SkDQqORne0Jkicpbafu7mddMH6SYCvvW+wwS5cEvloAlKN92Z8zwnulCIxA8eA==
X-Gm-Message-State: AOJu0Yz/VQ+WrC8eiBRFb7msROGX3HagBc0FLe5xL70NwyHi0dvV+YH1
 /9t5TBIcAL89Slsy/cmg598TG7Ao76nWqvbasnq/x71NAlThJDgOUw94aqWje4E=
X-Google-Smtp-Source: AGHT+IGqIP+W4MPjkJAymlyFAw6t/oifgW26uUctsxSVCeHph9cpbOdaBTD471OPac2y19adaX4Oqw==
X-Received: by 2002:adf:e952:0:b0:33c:e36d:42d2 with SMTP id
 m18-20020adfe952000000b0033ce36d42d2mr7101200wrn.27.1708336407192; 
 Mon, 19 Feb 2024 01:53:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f?
 ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
 by smtp.gmail.com with ESMTPSA id
 o11-20020adfcf0b000000b0033b4dae972asm9859744wrj.37.2024.02.19.01.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 01:53:26 -0800 (PST)
Message-ID: <c4c92ea2-8399-483d-8295-628aab98f12d@linaro.org>
Date: Mon, 19 Feb 2024 10:53:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 26/39] doc: board/qualcomm: link to APQ8016 TRM
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-26-ed06355c634a@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20240215-b4-qcom-common-target-v4-26-ed06355c634a@linaro.org>
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

On 15/02/2024 21:52, Caleb Connolly wrote:
> The MSM8916/APQ8016 Technical Reference Manual is publicly available and
> contains a lot of useful register maps for many core parts of the SoC.
> Include an archive.org link to it in the dragonboard410c documentation.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   doc/board/qualcomm/dragonboard410c.rst | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/doc/board/qualcomm/dragonboard410c.rst b/doc/board/qualcomm/dragonboard410c.rst
> index d0de9dbcbc9a..34629241110c 100644
> --- a/doc/board/qualcomm/dragonboard410c.rst
> +++ b/doc/board/qualcomm/dragonboard410c.rst
> @@ -14,6 +14,8 @@ through LK. This is no longer the case, now U-Boot can replace LK entirely.
>   
>   .. _96Boards product page: https://www.96boards.org/product/dragonboard410c/
>   
> +.. _MSM8916/SD410/APQ8016 Technical Reference Manual: https://web.archive.org/web/20210525022203/https://developer.qualcomm.com/qfile/35259/lm80-p0436-100_d_snapdragon_410e_apq8016e_tech_reference_manual_revd.pdf
> +
>   Installation
>   ------------
>   First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``dragonboard410c``::
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
