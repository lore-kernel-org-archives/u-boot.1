Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A10C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF5F878F7;
	Thu, 21 Dec 2023 17:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CUy/VZok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BDA9878F5; Thu, 21 Dec 2023 17:38:42 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F4E878DF
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3367903b4dcso980362f8f.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176718; x=1703781518; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=JCgYIqY5GbrIZvHOSU81pArlTXas9lKeAAg0DrpcZwc=;
 b=CUy/VZokU32g0E4oSg4P6vjUqOEXAIBLkkCW+oszS68I87bxXhppP2Ri+yiFFvHA4o
 NMBDvSz0MlO6GKRPOg1TAFDbbiD3rMAJ9RiUsuHAWB14m9i8gx6rikPILfIalvmJPqYe
 1uPlSjMove5ZDAizIw7NarijrqNbZLHyxnQD63f6zeL9oTbACEE8bKbpMLIep13y3lZm
 XZqtDbbyhPML8yT1pZ0R09/idLWrSCk4+8tcHurxGPqh2phJFYhd1PJ+hlEEtbvbcnpQ
 6uMYWX0Yx5U969rUp/AyeYhL5SFa3s6NrPDAD5U0zKj4TmFvI4VW85NDwmONMX08Rva2
 w89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176718; x=1703781518;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JCgYIqY5GbrIZvHOSU81pArlTXas9lKeAAg0DrpcZwc=;
 b=pWK/dYE05JxqL2Hk+hw08E8XnlRVgbjGzVqTdNR5RXnkqzHE0zFMW1OGLOITLdj72W
 AJsv84IZhBmNd3bFncYM79tkr7xTNASP1Sh3YIkoICTWtlUEjk1z2YT0INbQemKOOlLy
 ZV2nz1amQIOABT4uduMzzXVGMtg5f3NSAAZASqMoRS+An5yV/5eO7+vMUF3EhH0aUigq
 qVpvIVjbAQK0NTFaIx9lA2hHaRnG+A8I5h4ggGb1VyrfL5XhZNwoeYZ3gdX3lPXJPV7Z
 0vtCAEbZkTbFOpdNuW6vo5AmJwdjgrJgWgZKzuVwZv34J63ukhKAOItyItrzoRcqiL8G
 ArOg==
X-Gm-Message-State: AOJu0YxwBGSxuTAsOAabAMIWoHIdPysjsLDxXiy6EcKZ+CAqp3OT1w07
 OVd8ZyPGfiofwY8neRE1o9hx83IRIB/f6g==
X-Google-Smtp-Source: AGHT+IEehTu9mO8JPsQlXH/7lIG+QY78l1COE9r1VjT6rr8b/4aV5m48cHXat1wMP7nrfcNXUtYwwg==
X-Received: by 2002:adf:ec8a:0:b0:336:5fd5:6bd1 with SMTP id
 z10-20020adfec8a000000b003365fd56bd1mr43595wrn.62.1703176717878; 
 Thu, 21 Dec 2023 08:38:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 d17-20020adfe2d1000000b0033673ddd81csm2372633wrj.112.2023.12.21.08.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:38:37 -0800 (PST)
Message-ID: <218af11e-3dcd-42f2-b757-dbc25c32da50@linaro.org>
Date: Thu, 21 Dec 2023 17:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 26/32] dts: msm8996: import PMIC dtsi files
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
 <20231219-b4-qcom-common-target-v2-26-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-26-b6dd9704219e@linaro.org>
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
> Import PM8994 and PMI8994 DTSI files in preparation for switching
> MSM8996 boards to upstream DTS.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/pm8994.dtsi  | 152 ++++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/dts/pmi8994.dtsi |  65 ++++++++++++++++++++
>   2 files changed, 217 insertions(+)
> 

<snip>
Same as patch 19, with the commit id:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
