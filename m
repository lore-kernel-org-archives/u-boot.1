Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8668C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F4D82F65;
	Mon,  7 Apr 2025 20:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kiEDwyK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0FE82F85; Mon,  7 Apr 2025 20:06:34 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD84682D06
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so2686496f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049191; x=1744653991; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=IeRYEjPkJP8DwQtsm8j/tW76UCQhSCyTR64QZKEOOvE=;
 b=kiEDwyK37JeAdmnrqt8o5d7CNaC7/ixsVPbzn7TSZfjH3SAXXBYM2aJy+X8At1M/hL
 cntu3VCAh7zE3Wc/1PqG3s+NXHb80z63YxWwf7lmXC9dmioHPz9QVpPJwEFiLS1jMrtP
 8XAnOYu730xvt76jBreN1he2S99az1pVBS7PHM2Y4A+n9UQa0VBt7pgjfPanxRRQlLwL
 vdJgzosb781Ee/bVBWKL9HTX6byXwyYrPffKGaRK8VmgcImhA30dum405Nq98AFg481B
 8KRHC45+oqZhVTZGMMq+NaRVK7FEIX9GgNzP/Vh9e2iPqfTgyp+HomTFDeIZw0FTPuxe
 ifMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049191; x=1744653991;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IeRYEjPkJP8DwQtsm8j/tW76UCQhSCyTR64QZKEOOvE=;
 b=YBhmx6PXlkCqEIQoVrw01S5hJVa6y3Uum5XPgZiwdCTpab1magR0HZGCEWZcVbPZXN
 wyoQXG3svOS6YfdPZQOuXvQiogmtTpnuISCaUR35tRo0nZ6ll6PQxg8z7W0ANecx5AtA
 7KbuoHAmq3N84yxfaJYsiAVA07WuL2yUWZ8CcZn86oDb67xvs4ft1c5qqbevN3bdTDn6
 MadaUrkSEpyaaN+Uwl6GoBbaD+qvnbmyi5mYNOuFpeqMrZwuHgPako5PH48YFGW0SvQo
 XaXIHDP8AO5UIKz5LHHenav4XaAv1zgG2xNulb08Jo+oQ5yhysRLEVQxIeHGgRBNG1d3
 kUFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtFU6P0RHRpaJIdRZWKo/6cMU8Bp9QjS66XgGXwYPGDEp9bFvHbrl/QeeVRKzEKtIYK8gkhXo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxxa95gTZ/YyS8N54oI3lCDCijzvIuIr0XDY/syEFWXGyaELokx
 vduJ7d0IVBhP/z11i9kIzllyWznrTe9LWzRWPqzwi0EsUkoPuof40IcoISC5ebE=
X-Gm-Gg: ASbGncsHhdI5Uadcu+Ysm3MFXkJwTGov7T0RMXkR6jBXD6IXPUd2AVQyV8Q++FTWSAB
 oXv9npYQRK9XdQUhRLzlZIUCL+jagMOHJGGhFi9EvSApfiAxSLmV25TNpjD4cwOW+AvIjlmUuto
 dwX/H/pEvTd24NSmcCOcecix9kCo7i86566f5MQ1vtEEbPkb5woEwIYZnk14/WC2P1nde0pXrnF
 Esyum9OKHiXt7NQ4gjBCHk2AxHffs2Q3I8SCpytqH+o1fXCIy/1KpRrPVojEMYOhwp6Y40x3u3z
 zcb4tNBGeqWii+EE1ioOOLaEx0yI909JPv/uTQoLXAh7pu+dIljZiescmHu02RdknWT7svMI7wv
 fwbpV1FLJ2Jah/xQ6C0yQ6g==
X-Google-Smtp-Source: AGHT+IFus1YioROeicydd1F3oElbloMwilydEvS8O+3V6O01QXoE2IEGjdfOvUibT/Y1PDz0W45diA==
X-Received: by 2002:a5d:5f43:0:b0:391:22e2:cd21 with SMTP id
 ffacd0b85a97d-39d6fce11f5mr7988379f8f.36.1744049191223; 
 Mon, 07 Apr 2025 11:06:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec163156bsm4752825e9.7.2025.04.07.11.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:06:30 -0700 (PDT)
Message-ID: <44812c75-2cc8-4172-96b2-5b1186f03a5c@linaro.org>
Date: Mon, 7 Apr 2025 20:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 02/13] board: dragonboard410c: Fix RAM size
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-2-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-2-524aefbc8bb4@linaro.org>
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

On 07/04/2025 18:59, Stephan Gerhold wrote:
> DB410c has exactly 1 GiB of RAM. Some of it is reserved, but this is
> described separately in the DT.
> 
> This was fixed before in commit 1d667227ea51 ("board: dragonboard410c: Fix
> PHYS_SDRAM_1_SIZE"), but was reintroduced when DB410c was converted to use
> the upstream device tree.
> 
> Note that there are variants of apq8016-sbc with 2 GiB RAM (e.g. the
> Geniatech DB4). They need the WIP SMEM memory map parsing [1] to use the
> full amount of RAM.
> 
> [1]: https://lore.kernel.org/u-boot/20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org/T/
> 
> Fixes: ed8fbd2889fc ("dts: msm8916: replace with upstream DTS")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm/dts/apq8016-sbc-u-boot.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/apq8016-sbc-u-boot.dtsi b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
> index 585d54d29623823145e6b43eda89c05f31fc4403..c8a46ed14483f6939e7a666b2b279c803476ac63 100644
> --- a/arch/arm/dts/apq8016-sbc-u-boot.dtsi
> +++ b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
> @@ -6,7 +6,7 @@
>   / {
>   	/* When running as a first-stage bootloader this isn't filled in automatically */
>   	memory@80000000 {
> -		reg = <0 0x80000000 0 0x3da00000>;
> +		reg = <0 0x80000000 0 0x40000000>;
>   	};
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
