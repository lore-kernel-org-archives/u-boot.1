Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7355C3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8030D82E38;
	Mon,  7 Apr 2025 14:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gyO828bC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A305582E40; Mon,  7 Apr 2025 14:37:30 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BAAA82CD5
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so2405488f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744029448; x=1744634248; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2XKGBBcRloiMFbIEgNBVFtEXvOntGbXWvmdtu1W5quA=;
 b=gyO828bClbDHqhnxFGDP4YzG1t/Wt2cUNZz7gF05GMjUacfOiI8jaa36sJHhj6F0XV
 +ajcfwpd+v4n967VbILK0YU+OvaVoJgP6CaIzd1MLknE/7JzuxmkXyk8EKqboGtBL445
 XyB+YW/YnDsbabSNxR61wc5ZApETWapkocHSZ2PYL/d8vESiCN3jQRJ/buvocBtUFsb4
 vWq6C9zHkXds8gRfN3PKQgSfCUtSwMcgkx1q8t2s/pb5JSQ03YqUmc9xElEnFhTe9K3N
 UMVnjLeJ4FnFFBJALtXJrVBc0nEDuPx0PY3VYVCtnZoG6oMGHYrsMdv6pCHm05NIV+Xi
 xE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744029448; x=1744634248;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2XKGBBcRloiMFbIEgNBVFtEXvOntGbXWvmdtu1W5quA=;
 b=wCbpXK9CRUtN+M5dPay6G4j7JThaAHksUpuodJb7B+yO9JxbsBP/8tyxI6Y2V1WkmK
 kHLdWb8KYVytcaVzN3v43oCl+muE3uYo0NDCO7ea9PeSUDp6kuLn8AQupgYGwCghGtXW
 EgfiaHB9N+cfNg+EuBHK9xX9SeEl5KHEH6JeOIXCdmRYPmx3QdW7dfn5WeBc+H4vsmfY
 m+weINS6ldn7OXhNssWljT+T1lC4RHE/ZRlNiO4my2MVqNEM90oCaS65YKkEYnaVKGKD
 nZ4bUK5mJkUc4BRtkRBgT/w+lb83hqr4jrI8KMavnnMqkr/SucBsSrejGzbdLtfB/Qly
 NvJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf/IJhS+fceoYv/FUFvOEVk35brymUeelu6GyEFZFmgHkChbKh+hX2zIyKfHKPvmreq8BJmn4=@lists.denx.de
X-Gm-Message-State: AOJu0YzT7JZijjJngah8UoOuHHml2eJDZzzdNLd8djIN8HQC5xwZVZcT
 BHzdctxNO/eWC1j8SXDIBPxO5o2MkVFYLDnzdk4XVXWXKJ6FEDw5egvl0KN8cQMSRhDH2iuhT80
 O
X-Gm-Gg: ASbGncsSdrmdM75ZFJLkgi6XgR6xy110JnXJyGXncsiBed/N8MGrpbKGYG8IJB9GsAk
 1mXb8NsNo1nafTbX5MyZDUDowo71XRhCK9a46T2zYLLrfxmAUV57fyPLWZOMYCt6YhWTZJFI8qr
 HjpN8veGJilX1TlpLFoq1ePCY2aIHIB4EPtU84YTAivdA/i5jGIhM+1/iuMdUaM4aLluSizqRxE
 LgkBf43B1LQ0H2zgH365efa5sTiabwh5rJohl4+V0ChNDRlPHAgUC/CmvPLxISv39mC3ygYmpNj
 2DC2I4Qz6l2LT51YuyhjgDgRONbTVAtkLjnZDZFY8olHpn3EfBSaFYjqI3bEeQoRkSPW4hmibpU
 YusdE7dD7tWnrm1pSSuAhcg==
X-Google-Smtp-Source: AGHT+IEZvbMRhRRiedFOxMob1xlyzCCiJqhbtpVja1GEFNLA5CSCugTXsnk5E91CqFNAvcdg65K80Q==
X-Received: by 2002:a05:6000:2907:b0:39c:1258:2dc8 with SMTP id
 ffacd0b85a97d-39d6fd0756emr5952687f8f.57.1744029448086; 
 Mon, 07 Apr 2025 05:37:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b6a1esm11994142f8f.45.2025.04.07.05.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 05:37:27 -0700 (PDT)
Message-ID: <0da8570a-1f41-47b8-885d-b9361de0897c@linaro.org>
Date: Mon, 7 Apr 2025 14:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/5] clk: stub: add qcom,glink-smd-rpm
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <20250407120536.236003-4-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20250407120536.236003-4-jorge.ramirez@oss.qualcomm.com>
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

On 07/04/2025 14:05, Jorge Ramirez-Ortiz wrote:
> Add support for the resource power manager clocks over SMD/GLINK to be
> stubbed.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/clk/clk-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 5fbbb07b7f7..09be2946bbc 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -15,6 +15,7 @@ static const struct udevice_id nop_parent_ids[] = {
>   	{ .compatible = "qcom,rpm-proc" },
>   	{ .compatible = "qcom,glink-rpm" },
>   	{ .compatible = "qcom,rpm-sm6115" },
> +	{ .compatible = "qcom,glink-smd-rpm" },

You can delete qcom,rpm-sm6115 if you add qcom,glink-smd-rpm

>   	{ }
>   };
>   

