Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B93C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A168B878A1;
	Thu, 21 Dec 2023 17:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l62xTQzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844B6878A5; Thu, 21 Dec 2023 17:35:30 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BAD8878A1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d22d3e751so12874395e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176528; x=1703781328; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4Zi6tPqc449twaAM1hs/xYc0uNLLU7u/InaBgMPK8Dc=;
 b=l62xTQzLkpPCx027K0bx0f3PHZnkCgiLCxCl3pf43lGv00tHXxu+uMEci+XdnbOXKT
 jSZfvX+gbKhEM88oAVhwCV4EhdfY8WXD3Yj+T4UCw2GsqYIT1fb+pgnVv7KqJly3Er1e
 BX6VnR+8bJccdnBmsC5fhxVUVPdDL995S1HNTr+Ni4jUxT6UtRtWCL785xXO8pd8jLpJ
 0UUof7j/H8ghjdlU9DwlG6ho4ytAJgTvMzurhRGvD0VZbmhIffLD3gKbVBmXuwlOa4We
 svKHYhh0/Hv3VTg2+JURnOFhM2t8EZqmRZpS/RkIKtOXUKv+bNBFpShBdbytPBd0sEi5
 ijuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176528; x=1703781328;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4Zi6tPqc449twaAM1hs/xYc0uNLLU7u/InaBgMPK8Dc=;
 b=BdR0Or6fzy7qHQRBvMnraL7b3YbVJjWLM0Gz1MSMxJWy+cxcVv0ygtx93LxpqoFXq2
 mvaatDk42aaJqdH/OJNQd9Ji1fp9b4/uGjX53jh/UA7ArOrm9oNwCAWxj9OhYuym4q45
 tM754Ly+A6uslPZTV47W3A1+nmR5kxwA/8gb6e1+6gRr5nlG11Q9ymUuC5NRu6oB7Poo
 KbRMoPzilpRxqj22jj52hO/0bcm/9LJqflvMGojGWb8KbBQgaczpZjRwqHhD5vGoNvYz
 D1WhnCyPryujfXp1BDbq4L4nC8oWL+2rcjF9M/3yAGMLZU1+FyAH1JqPpb7WBZ/8JqHf
 E2Mw==
X-Gm-Message-State: AOJu0Ywej1S+Rw3gpN5GZ0lFcyVTPNNmSLENX0pwCknCcyZGf47gO/F5
 Wi/qqTH5UU8VqOTBjcE+gQ9L7g==
X-Google-Smtp-Source: AGHT+IE6RKzVi/GCTkzaBeoKm9s2Qd8Sbklm5JaSD82X4mfrlxp3S1M5XkhAEZKHB2Cwl+64rNO9hQ==
X-Received: by 2002:a05:600c:91a:b0:40d:3705:2c02 with SMTP id
 m26-20020a05600c091a00b0040d37052c02mr697875wmp.181.1703176527811; 
 Thu, 21 Dec 2023 08:35:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 bd7-20020a05600c1f0700b0040c420eda48sm12216169wmb.22.2023.12.21.08.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:35:27 -0800 (PST)
Message-ID: <ca885087-fc5d-4e84-8024-4175e2f27aa9@linaro.org>
Date: Thu, 21 Dec 2023 17:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 19/32] dt-bindings: import headers for SDM845
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
 <20231219-b4-qcom-common-target-v2-19-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-19-b6dd9704219e@linaro.org>
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
> Import the DT bindings headers that are used by SDM845 from Linux 6.7-rc3

I think adding the commit you took the bindings from would be also good

> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   include/dt-bindings/clock/qcom,camcc-sdm845.h      | 116 ++++++
>   include/dt-bindings/clock/qcom,dispcc-sdm845.h     |  56 +++
>   include/dt-bindings/clock/qcom,gpucc-sdm845.h      |  24 ++
>   include/dt-bindings/clock/qcom,lpass-sdm845.h      |  15 +
>   include/dt-bindings/clock/qcom,rpmh.h              |  37 ++
>   include/dt-bindings/clock/qcom,videocc-sdm845.h    |  35 ++
>   include/dt-bindings/dma/qcom-gpi.h                 |  11 +
>   include/dt-bindings/firmware/qcom,scm.h            |  18 +
>   include/dt-bindings/iio/qcom,spmi-vadc.h           | 300 +++++++++++++++
>   include/dt-bindings/interconnect/qcom,osm-l3.h     |  15 +
>   include/dt-bindings/interconnect/qcom,sdm845.h     | 150 ++++++++
>   include/dt-bindings/phy/phy-qcom-qmp.h             |  20 +
>   include/dt-bindings/phy/phy-qcom-qusb2.h           |  37 ++
>   include/dt-bindings/pinctrl/qcom,pmic-gpio.h       | 164 ++++++++
>   include/dt-bindings/power/qcom-rpmpd.h             | 412 +++++++++++++++++++++
>   include/dt-bindings/qcom,q6asm.h                   |  26 ++
>   .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 ++
>   include/dt-bindings/reset/qcom,sdm845-aoss.h       |  17 +
>   include/dt-bindings/reset/qcom,sdm845-pdc.h        |  22 ++
>   include/dt-bindings/soc/qcom,apr.h                 |  28 ++
>   include/dt-bindings/soc/qcom,rpmh-rsc.h            |  14 +
>   include/dt-bindings/sound/qcom,q6afe.h             |   9 +
>   include/dt-bindings/sound/qcom,q6asm.h             |  26 ++
>   include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h | 234 ++++++++++++
>   24 files changed, 1822 insertions(+)
> 

With the commit id:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

