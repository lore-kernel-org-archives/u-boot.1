Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EDFCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C9584198;
	Wed, 13 May 2026 09:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NCT2Vr1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 143FC84255; Wed, 13 May 2026 09:33:07 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A7F783EF9
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so63233965e9.2
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 00:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778657585; x=1779262385; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vNn6zbJ1NbXehc1RhVUlOjbPPNav6jWHjT5iUitPUlk=;
 b=NCT2Vr1z4oxHcknpLqinmZcZjOu9euxkTvwtxPxfQMPrtEOUul4eBbynAzBrhNgbVt
 MfLcUV50WghluS7dFHvyD83fwRszGtz17EBk+pFENmEjATCXY76ljKW2ufeqaTy387co
 k0+9shAd+vA/99LGfDvdXx+9Zl4Uc2YLu9R6wobj1vQRLXy47AMP2b0TI3zZDVu7/tML
 2gPWJmfZmipcm+nUwtYDVDZKLmTsMHLg4HcfMTkRGt0gXJZjBoQEU9C3U83trWQImQ25
 2tui2jj/K9vdZbyQB0Vxf8IMlMo/BepI4S8AuiQW6VQ01nlSYiv5IRcRuQlW2DDAj01n
 Rcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778657585; x=1779262385;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNn6zbJ1NbXehc1RhVUlOjbPPNav6jWHjT5iUitPUlk=;
 b=TtRwQh8GOD6d0JRM6wYm9UPgfKwWoJwiJ6ooGhcytv5/mJQ+5BN95Z91g+Pz36EZP7
 GXo2NeuGrIYrUu9sPUchtuyQDa5RNVF60Cy4qGT2TdcfFI9GuuBbU+Dk/DEsKgsY+zDm
 qrS+3U6RrDPU37YdomeqL1mgw9WnZSVV+LWI5ruazbrBgT4HVWHqF/9mqU33DYnDtdfK
 Fn1fkPb6LR0P0DZl8ijAap/DY7BQ1BXnJ/9F2UFKQLquwSQIT/CLPJJ61l0g1ISbAhIK
 kyXXQ/DLUldHrGC3V5M2xlDmhE1D6JA8xRhRb4u9wP7XgvOyiNy3xWIXikPBvDQKrowB
 AEEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jlSJJRw39QNHddgnIDi7QMU86/aNY1+N1mZE0SNA9IOPNwAP1BlV4ARugopNP+hSprVKW3eY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmjb6ASbDWUzE3FEsWSQl0n9o7EMzmbZ79QwVhnr7lFpYy3JOc
 Q9ItROfaL31kU3Cmfk/rPgBtUL4i1cJuYE5tydUgKbOU6dvRMqc49p1HBFIScr3wp0E=
X-Gm-Gg: Acq92OET/sd0IsYLDaFMhgyLUJUAdMtvs5gQUei1lb6tvFp915eTY90/n89XCK7/c7U
 /99G9fpbKOwFq36idHEwNKRVM1GTtrqhw7a9nm8g4ctyCafMpKrB3ylYpCo4mZhd37KdDtmoruy
 eGG3938phpv72ZHfNcEQ14NerQSfBkUu12C6tx2VtROwe+msSCzxz7NqHhbTPn7nPQs6g1qfXve
 MxSf7WwsC0KqZhUiL0dWUQ8r5a5c29MzASomRFxmxD+0tpObBwl9daeRyZR48rLLjQgeDQ7dkSe
 P17cVH8QRAuOft9w59RjkUerPiNig566mazP+D7iiw1V9ABVmukDwmqgLKxqloINsbK4obpmJHl
 q5FE1I8A1jCW0FAPcq6WLou7VFlP3A/ZuW2wHNMk9lG40Mg6oJd1cd0+2grChnUEs+tzQdnV80I
 RM+YPLM+sxiQdMkV89jfVzpx5mFhfz0daO81MXnNq7mOn1uMvg24rgs9z2Xycv65kPnfqa+dmvk
 3R+
X-Received: by 2002:a05:600c:5397:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-48fc9a0775amr25295815e9.4.1778657584537; 
 Wed, 13 May 2026 00:33:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6ee4:8e37:145:d60b?
 ([2a01:e0a:106d:1080:6ee4:8e37:145:d60b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d625basm49304655e9.9.2026.05.13.00.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 00:33:04 -0700 (PDT)
Message-ID: <6a10b0df-7183-47a0-a3ec-33573b6d14e7@linaro.org>
Date: Wed, 13 May 2026 09:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] clk/qcom: qcm2290: Fix vote_bit of gpll6 clock
To: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
 <20260512-ufs-sm61x5-v1-2-c022cf988e89@gmail.com>
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
In-Reply-To: <20260512-ufs-sm61x5-v1-2-c022cf988e89@gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Please add a commit message

On 5/12/26 16:44, Biswapriyo Nath wrote:
> Fixes: 3ddc67573fab ("clk/qcom: qcm2290: Add SDCC1 apps clock frequency table")
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
> ---
>   drivers/clk/qcom/clock-qcm2290.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
> index 5a599085b500..c38ff1a1e4a5 100644
> --- a/drivers/clk/qcom/clock-qcm2290.c
> +++ b/drivers/clk/qcom/clock-qcm2290.c
> @@ -73,7 +73,7 @@ static const struct pll_vote_clk gpll6_clk = {
>   	.status = 0x6000,
>   	.status_bit = BIT(31),
>   	.ena_vote = 0x79000,
> -	.vote_bit = BIT(7),
> +	.vote_bit = BIT(6),
>   };
>   
>   static const struct gate_clk qcm2290_clks[] = {
> 

