Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DC5C369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 07:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8872581FAB;
	Mon,  5 May 2025 09:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HFna+STe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6126081F7E; Mon,  5 May 2025 09:23:32 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFE38091A
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 09:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso2415266f8f.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 00:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746429810; x=1747034610; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3QNaMx6S/oSDcIRt8smnHsXYN+ier6klr7hcBmCK29w=;
 b=HFna+STe3jCYhJOLoyzmxjwLhtf4sozyYihpVMG4DDiYQh2PcjAIU5rG9yHLgE67h0
 sZvs0omrH/GrVnPXkEry2zAy6p5Xew1KXEt52JGpB5DxBIiGXmp2Mm2ZwDCbzl8hopL9
 e9vnqFEgd/b0cU4iYHhdYlELRlemyJoaJyJcI3uJenz7iRy6pMkLvYVZuJULPgDwKjtz
 9GcIhBk5YFGTdB0UF09Pgoi9kvhlbj8nPqMLGFzGFobNKUL1tHc5y10gzYMbF6Yv9vqx
 1QlndLrmlos4NOGCA9jQKzX25HQuVB4+pWt2XyF3Cp5VcVrWh+uyqno7xv4EVVkexyMT
 yxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746429810; x=1747034610;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3QNaMx6S/oSDcIRt8smnHsXYN+ier6klr7hcBmCK29w=;
 b=K5RregFqCoJ7JTw6OrPRvxP6zhDNgNprMy/7PI3CzNKJhfdSUyTBoxn0zCvlWieqWH
 A4QeNitHep3tfDFuRuVTH+U+1XY+Xuy25xo2AhZ6rRC4M5UTSArznyACJJzjLlk1u5Q1
 56DXw5I7BJ0ZX2/MwxycyVduRqF65eVGqc/tDT366NHzbL3bqaGb4Nqq64I80yd8wct6
 ySy/8MNqdDH+BphgPELIj4vr0TrXlmiwWYgveGpECLRN+VWq1giziFvRnsOBb0PRHTvg
 GANEXHeyj3/K1ywJeqDIVuQcW3FeVR004W3p0fK0REHd/Q1+1+LkmxqfeOA698d6brSr
 zDOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSlWq0B6HPUc398k3eF9VK/wLj/1XorfCqnqO2zbRBPJ9X25GBv8oy4PFpg1RZtnB/9jXyQew=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6+bBj3D17XB5ay3tLKr2Osj2dmohFqqfTebp9bKMCQxzKXkEJ
 22o9PoLSl+gqLJj/KZ1GQm5fFxvDSluAC+/ibDZsz8z+PUCoxaD1R8jZ3mfIOcI=
X-Gm-Gg: ASbGncvJmDIU2L138b1Q2NRENbvs22Hh1rpcFhS7Vd7NpRr+CSN8VAggRRH+am5B5tG
 7drjsBUe/1xQNLqwr2m+G2w2dUpnRO3PP+LjH2aiVnho1iz/kgrYo5AE/elWBE2fuCIuWiJ40rS
 WFLeuF8Aez/mSRvr10nPyvE3wBkUp6zKaADO2DrHRh2vj1wBqrJcI3dJQPDRXkl6rRjnKBXGsSJ
 0t3Kkrj3LA+qulI5ki6qv98gCf6HR4iV9HOpcfi+J8sdNgS1g+FAyPWjj59SbjSkUHDGg3KQQWa
 2ne4IzdJv80fJ8DnngaHzLcA3mVKKKGm9q3sDdPv4lPN0KmRdVAzMmzuWaOhgOL/p90cv/gg8HH
 J/RpnxwmzWbfW8tRFZ7JFzHMmmYNo
X-Google-Smtp-Source: AGHT+IFj6mNps27EkBkijX/N8dy1Wr7/N3nnmtD7BwBO2f/vXqS8OvgLTfwX2NPeGwaSK2RUsItDKg==
X-Received: by 2002:a05:6000:1a86:b0:39c:142d:c0a with SMTP id
 ffacd0b85a97d-3a099ad61c5mr8066700f8f.19.1746429809698; 
 Mon, 05 May 2025 00:23:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3?
 ([2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3ccdsm9579980f8f.38.2025.05.05.00.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:23:29 -0700 (PDT)
Message-ID: <2891ce47-45b1-45be-8209-d136e348a74c@linaro.org>
Date: Mon, 5 May 2025 09:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] mach-snapdragon: Update fdtfile logic to work for RB1 and
 RB2
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 loic.minier@oss.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250423051132.292329-1-sumit.garg@kernel.org>
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
In-Reply-To: <20250423051132.292329-1-sumit.garg@kernel.org>
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

Hi,

On 23/04/2025 07:11, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> RB1 and RB2 have three root compatibles where the last one can't be used
> to decode fdtfile name (qcm* vs qrb*). So rather just rely on the first
> compatible to retrieve the SoC name.

OK, so "soc" would be qcm2290 instead of qrb2210, what's the problem since
you have "board" with "qrb2210-rb1" ?

What is the difference between qcm2290 & qrb2210 that affects U-boot ?

Same for qrb4210 vs sm4250.

If you have a custom board code, you can still match on the root compatible.

Neil

> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>   arch/arm/mach-snapdragon/board.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index deae4d32378..dc8220e89b4 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -437,16 +437,24 @@ static void configure_env(void)
>   
>   	/* The Qualcomm reference boards (RBx, HDK, etc)  */
>   	if (!strncmp("qcom", buf, strlen("qcom"))) {
> +		char *soc;
> +
>   		/*
>   		 * They all have the first compatible as "qcom,<soc>-<board>"
>   		 * (e.g. "qcom,qrb5165-rb5"). We extract just the part after
>   		 * the dash.
>   		 */
> -		if (!strsep(&tmp, "-")) {
> +		if (!strsep(&tmp, ",")) {
> +			log_warning("compatible '%s' has no ','\n", buf);
> +			return;
> +		}
> +		soc = strsep(&tmp, "-");
> +		if (!soc) {
>   			log_warning("compatible '%s' has no '-'\n", buf);
>   			return;
>   		}
> -		/* tmp is now "rb5" */
> +
> +		env_set("soc", soc);
>   		env_set("board", tmp);
>   	} else {
>   		if (!strsep(&tmp, ",")) {

