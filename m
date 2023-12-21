Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A8CC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA94E8788D;
	Thu, 21 Dec 2023 17:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CGOO29cm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886048786E; Thu, 21 Dec 2023 17:37:59 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC26878D3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso11280875e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176675; x=1703781475; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=fHMwNdNmP7Xr+yedXehcxeTCG/s/SCyBoEgaJriqKt0=;
 b=CGOO29cm7V92Akn9L/NrHWXEW/ltFEFP0zpMD+8HiYNolGmBdeXW5EO5JdEAEZIq+E
 StidG4ewx9kA0qbHQyiGIKmMTpH2gUAv0ueszHbKSCxb5zqmuvYR5CHRKHj7wAjGxHTA
 DXNXbP8BAhOjhloipz7ld4f5PlBRUTYdW8APtBI/J94RS+hocc0hSNtfC+7HzG1zpB7a
 4rXpGHc4Z3VE/7Q48HguoKIMqX32oN8tSxZ2xuUwPdQQtNBhKEK4nTzA/6tsYPSCjuRe
 FHesr1S7rMAMSiaxD+oIcsq/Vves1BBtlYsj/SAzSFq/S4zvcuWVIzHX2+n+wy/M0giK
 WmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176675; x=1703781475;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fHMwNdNmP7Xr+yedXehcxeTCG/s/SCyBoEgaJriqKt0=;
 b=viLZ2Pe51x0t0U3WnN5EN+aA2cGCnZDAJEe7lzUiuJWIL8VQgwBY17N3EhQi8GN8SK
 Lb2R5uM9nVJIxM3T0oe/xv/09Pm4QgPvVobYXkJVubEeMjVB19kEe4OflbvLrGtv0o/f
 rSguT1YXXJR02OegzrwuxT0WAQ/XUPqax6LSQWKKrm9rTp7azGITi5Kq4V75T9Fq66su
 WZ2PiBMrP6DaoQDQh8Zl57pq15FEj43c3RFSdMaDGXVVSwM/UxY+jFaRG2mbAmvCq1ZC
 C2wOfUR1ZlpS6BEBuR/TctZIsD3I4QBFbGL2uh/Pgotme4o611JCD8JxrbB7uFW0g+Ys
 +LhQ==
X-Gm-Message-State: AOJu0YxxAqdg4Xa6goSH2jo2fF3HL/+oB7vWSTF+Yku1ATWuUf9K01mb
 HEsgm52cpgWMyae8BWaX5k5RxUZnb4KyOw==
X-Google-Smtp-Source: AGHT+IHd4pD4UqN31DLTY8Uko/MzybgvmcqGleM4vhnLVQ9XDG9pk9BjVuCxP20aQUVqTt3VfJVlcg==
X-Received: by 2002:a05:600c:a43:b0:40d:3a7e:a4ef with SMTP id
 c3-20020a05600c0a4300b0040d3a7ea4efmr1707wmq.32.1703176675316; 
 Thu, 21 Dec 2023 08:37:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 bd7-20020a05600c1f0700b0040c420eda48sm12216169wmb.22.2023.12.21.08.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:37:54 -0800 (PST)
Message-ID: <919b7f2e-b12c-4091-8c85-99a65c3d7f61@linaro.org>
Date: Thu, 21 Dec 2023 17:37:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 23/32] dts: msm8916: import PMIC dtsi files
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
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-23-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-23-b6dd9704219e@linaro.org>
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

On 19/12/2023 17:04, Caleb Connolly wrote:
> Import the supporting pm8916.dtsi and msm8916-pm8916.dtsi files from
> upstream in preparation for switching boards over.
> 

<snip>
Same as patch 19, with the commit id:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
