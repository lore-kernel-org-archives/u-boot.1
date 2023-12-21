Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDBFC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D1A878C8;
	Thu, 21 Dec 2023 17:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iRvNa1nW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF4F8786E; Thu, 21 Dec 2023 17:38:25 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18416878DD
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c6ea99429so10970145e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176701; x=1703781501; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=R4CbUGSBQs/k8U6Al8nDH8wG+CSkosn5zpdrDB/D1XQ=;
 b=iRvNa1nWMUpZnYwQwHnUnodt21RAS51ZamwZVcESPLLmuedcc9jRLRKeptzVDoXIA8
 mSQzoqEpQo5qqKdU2oQ44w6rBg1SXmEk5IaBRpm5qxxhImE0dJW2tcoKu/T7HyYUIEJN
 PXZ09zErEo/rU++opSStJkJAhHQ5LzrPH6+g6hLoWt0HHSrRcetILm5wqyT6HIgJ8iBX
 CD+UO0leyj59aJhM2JTd9vkllOaLb27+ZlA8ZoJVdBIPevBylEANBNf4Tj1hOqQ843kd
 AQIYuIV4KAd/tfMImnsKjE8kxIz2wyY3lP+z+CHqDIqDuf5s4ehLYoT7llEHjE1v21fj
 Nc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176701; x=1703781501;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=R4CbUGSBQs/k8U6Al8nDH8wG+CSkosn5zpdrDB/D1XQ=;
 b=xOlNjOPC+W56DFsaEKsafW8JckY9uR2VBPlm6Qw4A/GEyziU7k2DJm7ULuMJ2G4lRQ
 jnNJP+SoZDOfxfdqghMjxZYxyBnDsD+zIu9SQyzxVg9w4uVWge5ks2z36uvQx95ElG41
 C1Eby6TFAAAykUPYfcXNiOuM9Ta4ts5AnQTS+FU0vPvXMAV1ETweklJ3TEa7Dicv9y1k
 1uo8lF50xbkhN7RnMNU34W0e61aHTF0wy5RYxdmvx6aLO3Cm0sOEaB0dpDjz98dlmnrp
 GUq+xOi4eIWiqLMElQjNxWAdUVp3UGPxxTFtzll4dpGm8zL98wNqnfe/8SvAFDzZREEM
 bKaQ==
X-Gm-Message-State: AOJu0YzyrZy2AiM+padllJ593ON9jWqrt3I3F1fOgzNw91hkGL08PCPm
 1+MegX/DeHKqAmjRWqg45w3mf0Up7HJ8bQ==
X-Google-Smtp-Source: AGHT+IFnKvCsGUOq4dDt0v3HNYJKGwptTnmfqr9vaSo6qm65zKYpkJvWZDZdBJRUwwlHu/8KGUVBww==
X-Received: by 2002:a05:600c:3201:b0:40b:5e1e:fb9c with SMTP id
 r1-20020a05600c320100b0040b5e1efb9cmr901wmp.81.1703176701326; 
 Thu, 21 Dec 2023 08:38:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 bd7-20020a05600c1f0700b0040c420eda48sm12216169wmb.22.2023.12.21.08.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:38:20 -0800 (PST)
Message-ID: <93ff6cfe-9c16-4237-a63c-f2d7f6502664@linaro.org>
Date: Thu, 21 Dec 2023 17:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 25/32] dt-bindings: import headers for MSM8996
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
 <20231219-b4-qcom-common-target-v2-25-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-25-b6dd9704219e@linaro.org>
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
> Import dt-binding headers for MSM8996/APQ8096 from Linux.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   include/dt-bindings/clock/qcom,gcc-msm8996.h       | 360 +++++++++++++++++++++
>   include/dt-bindings/clock/qcom,mmcc-msm8996.h      | 295 +++++++++++++++++
>   .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |  12 +
>   include/dt-bindings/interconnect/qcom,msm8996.h    | 163 ++++++++++
>   include/dt-bindings/sound/qcom,wcd9335.h           |  15 +
>   5 files changed, 845 insertions(+)
> 

<snip>
Same as patch 19, with the commit id:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
