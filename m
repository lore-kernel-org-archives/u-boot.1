Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224CCC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D98187811;
	Wed, 10 Jan 2024 10:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uEJlgiyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C32A86EF1; Wed, 10 Jan 2024 10:23:17 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863C4878E7
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e72e3d435so3878016e87.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 01:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704878593; x=1705483393; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=7euetkwlhFeeKws1d9k9a9R8iStjGpqif1bor8HHpuc=;
 b=uEJlgiybsq5lQWZo4SbiF4xDqNkTfDcKrHmj1lbXejzkxrV5rcyEAvDyWHw5mZt3C3
 KELoLjU6FXATpAJmMfUj0oWfKlfuN698DjMsZuv6A8Aec2zZAtNdd4y0ddrf8v4OyMnf
 3S4kiamao5mzArplaY/l5TWfd1nPeWeoU7cg/C3+/QSx5hZ7npFvtIW6gUrvqYAgOmgz
 UepR3OffkuHKCGKqAi7HNI6LB+RDKG5bMfa3fw5ZhBkNkMoS7++nZ3PsPl5P2XAoofyD
 wxIKTjE+ZBpi7hPXUF3ovqlWCY5gH1xfZ8pvpz16I0y9ahREBX1/3NeOmIOQ0CzmLCXC
 8MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704878593; x=1705483393;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7euetkwlhFeeKws1d9k9a9R8iStjGpqif1bor8HHpuc=;
 b=jspLMrxR/I+i/MJUzGXm9lDBry2QTCUA3Wqx4XLmtEZ0s8zTQ59ocx7ySviCMyZTAZ
 maWWLjBI9dslUl2EgC+B77zF92IChyWngURGinImRMYlXUAL2cbPIZaolAyjbf91Mx+Y
 i/qwil+53Vz52j1zkgCy2raGfOKyh08a91WGRPZIi65pwHoqtAiDYYw8MtlEd7eLSEwq
 DllPazMcEQixD2Z79M6h6zuF/0NCYyl2SlufBmjl0MDJ58fNQ4rhpJmSKCYNbL0ZPMhP
 CDfEx1uxyLDvK6oEFIEnd/np5cxQy4MXDTUw6xTzgxvoSDnxnxdzbs0sF4WUEGSbv7f3
 m0ww==
X-Gm-Message-State: AOJu0Yw8MuQFsjGeMPfP2tEcAWYEQFNZR/+qM6avymT70x0MT6OPPp4R
 a7g6+Lfln1M1TiESd86XLnpm7A+1raPq5g==
X-Google-Smtp-Source: AGHT+IGJmEVHRrH8uxTwrFG+BAidpfhw68b0Ed23mzjrl4ZSBKZ5lUD4R0bfqfBPQePrvKu2EO2v5g==
X-Received: by 2002:ac2:4da7:0:b0:50e:b64a:f8ff with SMTP id
 h7-20020ac24da7000000b0050eb64af8ffmr142513lfe.150.1704878592691; 
 Wed, 10 Jan 2024 01:23:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5dee:51de:9349:2adf?
 ([2a01:e0a:982:cbb0:5dee:51de:9349:2adf])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a5d5044000000b003371e7113d4sm4411717wrt.24.2024.01.10.01.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 01:23:12 -0800 (PST)
Message-ID: <829ca7ca-0da6-468c-a70c-d0bb35a57fa9@linaro.org>
Date: Wed, 10 Jan 2024 10:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] clk: meson: add Hardware Clock measure driver
Content-Language: en-US, fr
To: u-boot-amlogic@groups.io, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <17A1E40D16C3C77A.26427@groups.io>
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
In-Reply-To: <17A1E40D16C3C77A.26427@groups.io>
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

Hi Sean,

On 18/12/2023 10:47, Neil Armstrong via groups.io wrote:
> Amlogic SoCs embeds an hardware clock measure block, port it
> from Linux and implement it as a UCLK_CLK with only the dump
> op and fail-only xlate.
> 
> Based on the Linux driver introduced in [1].
> 
> [1] commit 2b45ebef39a2 ("soc: amlogic: Add Meson Clock Measure driver").
> 
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Should I take this via the amlogic tree ?

Thanks,
Neil


<snip>

