Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED1BC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F4E839DE;
	Thu, 10 Apr 2025 09:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sT359FcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD51839DE; Thu, 10 Apr 2025 09:45:13 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CAD583995
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso3897265e9.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744271111; x=1744875911; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=L/jMWtKjhRvvDO4zA3CtxYZaV/qiqkAN+s17yId8M5E=;
 b=sT359FcCtDzBiMy0mMt7+NtTaD31w1Bn17uJFmpG7yW8F2YqlJ3OH0AZo+l+pZg0yw
 N029L9Hxn/Yhro6W4alaEDEObTSAbK0H1Zc1kCf96uM41bRSQO2wqUSMG/4ugny2xumT
 ZenQ1ZqSAmZbq0nnwdHVJIB+WuGJoTBa6Xvn10cV6pEDkZNJ0Z4Q+8PvPDq93ug4Lz4N
 idu87WIyiFyDzs+K/YqPwCWZPx8zVW0fWVyVPOgHn0ym5Yxfr+hViTmw44GjdqqbbzG3
 MDO8r+TpchdobsWKZ6Kmcqv8vXdsEY7WnZiZDoB2SMl/7VSjDVfvBAJmt5zFEjmjhT6U
 7p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744271111; x=1744875911;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=L/jMWtKjhRvvDO4zA3CtxYZaV/qiqkAN+s17yId8M5E=;
 b=Ip7l65pQ1mUHN+jgW6GSvL6CXwuP2TiW9IDQDkpoqSJo/5D6jSqYxZMXZCzj7M0G2Q
 XOBpahhMWlhFb089+THFyKbGc1GZ+95Q57Vni5t8gp0PM9T6oCsbBwgTeD5ZOECmpAPr
 +VzOzVXFFWM1HxjZk/O45RqLuuZQ5hdWEfVz8Q4ZwfvFahufpz/2td92P8oa2SafAIIu
 4PFrAffV6kKXMWjPI7ryF6lV9YHcVVP4IvmUO4ki70C27NQ0/4QQb8pf39I1vV0WNNoY
 6CPOAYVor9JOX7oaGHhMGg7i56jGYSz+4S6Hz5sUl/eaxaFtTNKy7lzSFJO37KSSowlT
 e5Wg==
X-Gm-Message-State: AOJu0YxZZ6OR/maK+8prc0LGIUvXU3IQ8GacuenrxGBKFxP7S/y4C/e4
 O21stA87h4kOAbEV82zJu0i0sVjbRZZQmUfRr9gTHKGJof3FqTbUxHQrBN7pcPY=
X-Gm-Gg: ASbGncuJ1fac+1H8A8ASbc79lxwwDVb0gO0o7a/UwSOT1KrQ/QIhmjFvvdHolkPvSm7
 ptr5WHmtDC74Iyp8/1IjbkSVpKcw1XiZmpk8MPFFy2na7Zak2o0YxC/boDTgh3UA/oERGyvnbt3
 HeWJNi+9/XKR2CWX+N3dTpFUOc5b1TqdEPse1oiQFgKYnpnBVIWePRvecaGsDHYjSl0O9ecj+JZ
 bvMT63AHbEJTqwLxSossx7ZAWZgfuiBrw+i9kg6huejr2iUiEHhUVdlQmI4qzoGyhXMwVUeVoef
 LAvpw/2sbGryh8nVd5CR/eJ3q3vj6xxZlgLUkM3jQcEMp4Lvez2/1g/cdK3zM84raCd/KUS25bt
 tnaRp8pC9nZ421Gt9hg==
X-Google-Smtp-Source: AGHT+IHTgq5sZ2RGDJY5xhjRZ5364pQzVfA+wsGZZDTx3MO53XunUqxDKD5mmM8UNENACPXYBMVkSw==
X-Received: by 2002:a05:600c:1388:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-43f2d7ae811mr17676715e9.4.1744271110712; 
 Thu, 10 Apr 2025 00:45:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe?
 ([2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20625eeesm45280165e9.11.2025.04.10.00.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 00:45:10 -0700 (PDT)
Message-ID: <12cc1266-b75b-4e7f-839f-316ce1a6e042@linaro.org>
Date: Thu, 10 Apr 2025 09:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/6] mach-snapdragon: of_fixup: skip disabled USB nodes
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-3-76dfea80b07f@linaro.org>
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
In-Reply-To: <20250409-livetree-fixup-v1-3-76dfea80b07f@linaro.org>
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

On 09/04/2025 19:17, Caleb Connolly wrote:
> There's no need to waste time fixing up nodes that aren't used on this
> device. Skip them.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index d4e24059212c552de7fa7555d2ab8a1ea4fc4cb2..b39036e8e0890fdf834a0dfe6966ef3dd365f3d2 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -107,8 +107,10 @@ static void fixup_usb_nodes(void)
>   	struct device_node *glue_np = NULL;
>   	int ret;
>   
>   	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
> +		if (!of_device_is_available(glue_np))
> +			continue;
>   		ret = fixup_qcom_dwc3(glue_np);
>   		if (ret)
>   			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
>   	}
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
