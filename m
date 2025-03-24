Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3E3C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 14:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D50480548;
	Mon, 24 Mar 2025 15:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tS0bmmWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A664805C3; Mon, 24 Mar 2025 15:51:27 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F6A801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 15:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso3898757f8f.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742827884; x=1743432684; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=7ODRbwag9XIZye79H3dGt+Xy6g2JKhNBQbqpJ0Yvjeo=;
 b=tS0bmmWtvWYlPlFQqxYtsR1LV4CUq4BeV3zrulc0Gg/85FlEScJnAv1UpSZOrTxH7w
 sZXwSqrlS50jeOfdTlN+Da9Njv5ZzXCXs89HrwIbBPi6LR57IJGTL/cT1fpncw2BYZKe
 7b1F/K6ewAQ9oHgpOciUZPnXeQmRWpzgG9kFYkODVZTh6I64qulyMmuvoumKzXmCeQi4
 7vO8Fk/ZfS708/puZjLWoDxeR6jGWuWB0BuZ9WhmdTk8F4Y1j6YC/gA+jzrvssVtVX80
 cJ/oSRJKz2LiVqrqVXk/b7DfTh4SNe0cnZVZAalBFtP8Cg6oAT2ZhD2hJRyVEmm6+GrF
 zaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742827884; x=1743432684;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7ODRbwag9XIZye79H3dGt+Xy6g2JKhNBQbqpJ0Yvjeo=;
 b=cBoNq0KwpLMzOo6u5l76CuDqbAa+3GNSmg5rO2nV2vZ0yorNOxEApz2QZhzjktUEo9
 tJxKq3xFQwjreP3CZWwF6yrji3ItyXG6XrW/t0OcvNGuqE+fiCZU7z808xLy/P3sIJa/
 F+ReZXlKdYXhSCdNjmUKyRS/9eiSkSu1PQoV+H4pHMLAiflSqHTji7WLUlXJ6Wx14td8
 1gHMKyCppcA0hTOZxNThVcZgv3CVFf3j8peUtepzYhOKblhgx6DAGLtI76iEb30mWjC0
 ZhhNTYYS+hwfQde+qi0DvgM10dQMit2dJY/uZwYZ7ACsTVFep2xJerMuPazvgDUseahS
 +FQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm01vgYAp7iSS/AzcEl0uxdKy115XW2NXU/PlBUUcJzkt7JJ4SERO4Wo7m/aZ2hrWziQEfLsU=@lists.denx.de
X-Gm-Message-State: AOJu0YyGYrveID66yICSoVj12XDPsjtJNW3BOTOxdCprOxgrOkv8fC+F
 vlZZh/gQib9u3QxO2WqosngiZ2mMsoV97Es71W2qak9e7bS5F/GMU/Ze86aghKU=
X-Gm-Gg: ASbGncvUQhmRdceSVLeqhszAQm2+V4i4G2g6BiGg/uirFtmy1EIehP2y37srONJd/nJ
 lmxRGJE+i+vwT/8XApgtdlo7NBCCzCCwRZnou9/GDqEh9uHG/b36UZKpKSnD22eY7CCuIShazkW
 2g5EEQu5kvR0zZhuaHs87O+k5Vc+JZp6hfVt8R+2/PQGQAhoAv8H6W3SXOjGsYy0xccOomokjyR
 mSJQgg+LNL1zC70B0am6vX10vdyyqQ+dEK8RNOfoYl492eMS/IjnIAmsTbEOSyEP4Sy8vx4saV2
 yGxx8+aa1dsQjcUpLagkB3A5o6aD2WKXtlgFIL2o0lpvA9DOsFHxLoOerbLK7xWqZU5WvOCK6rZ
 abRr8k7GMu9grIStL
X-Google-Smtp-Source: AGHT+IEJFpyLuviJRNaAlh8rDlp5XAfRat+MSK6GL+pnfzqrPwub4PedF+pAPfQsM8tRrApY0F4AKQ==
X-Received: by 2002:a5d:6485:0:b0:391:4231:414 with SMTP id
 ffacd0b85a97d-3997f9397e6mr13776885f8f.40.1742827884320; 
 Mon, 24 Mar 2025 07:51:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f?
 ([2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957c3sm11445701f8f.18.2025.03.24.07.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 07:51:23 -0700 (PDT)
Message-ID: <a4d1d382-5bcc-4efd-b8cf-376ae3945b26@linaro.org>
Date: Mon, 24 Mar 2025 15:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix excepts/expects typo
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
References: <20250324143956.91791-1-marex@denx.de>
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
In-Reply-To: <20250324143956.91791-1-marex@denx.de>
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

On 24/03/2025 15:39, Marek Vasut wrote:
> Fix the excepts typo to expects , no functional change.
> 
> Fixes: 0916053ebc56 ("usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/usb/dwc3/gadget.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 477ecd02098..2b01113d54c 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1635,7 +1635,7 @@ usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
>   		/*
>   		 * Special workaround for NXP UUU tool in SPL.
>   		 *
> -		 * The tool excepts the interrupt-in endpoint to be ep1in,
> +		 * The tool expects the interrupt-in endpoint to be ep1in,
>   		 * otherwise it crashes. This is a result of the previous
>   		 * hard-coded EP setup in drivers/usb/gadget/epautoconf.c
>   		 * which did special-case EP allocation for SPL builds,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
