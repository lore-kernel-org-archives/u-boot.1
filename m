Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D92CC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 08:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E2187DE5;
	Mon, 18 Mar 2024 09:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DwMRkD5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FE887ED0; Mon, 18 Mar 2024 09:48:47 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23258879AF
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-341730bfc46so426109f8f.3
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710751724; x=1711356524; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=eEBdKE3NzvC0kwk+i/Y79ouKhcbA2X9Ja7XXif1QIhw=;
 b=DwMRkD5DbCTe5GG4QNe/2RSuHovejRy1J4FMtH3xmNUPcT8UcGyTUCbltCazj3OkE3
 GfzR5GAmbsxbMZSO1jEfPiToYdlOZqbmjjstyVEMwNasjlY63Xnw3/BeTKXWJwqd7nKg
 ymQuZ0pbKF8Pnq5oB4sc2+r7J+rQBXUc42riYCNShgedVSsqgwCD0v6H5jQUoFKI+ezQ
 0dDcuYNdnQqQsmOVwMF+80fZ7Z5hy7pOgNhDG5MySY0Y4sAkBQpIWffx0cWSIjugEcEG
 CKaK6OM2noprx66BLwN5wlnnghFYj4CpBI7GpR88gG0DMMtzMhK43v3PV/soY/QcQvD8
 VeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710751724; x=1711356524;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eEBdKE3NzvC0kwk+i/Y79ouKhcbA2X9Ja7XXif1QIhw=;
 b=vIXUYMky8sRYfSxcEGXVemlUcgtR2o+dNwEIw2rT4wyAO/IpxLSDIvW/jU9TKN3L1I
 C/cYKXfhwKyIvvQW0gZBB0xQeNCBr+NYWPcVDUrS2ish0uhPyfUMmRmZEzFacX0BN3Yg
 6WDVRhQsC08/Mmz7gWWxekPqy/WQ3aIXchL6kCRwCNSW2rCMDp59ZMeJOQSMDz5pYMJI
 EdhxVrjdkKLFU9BXPTg0V4cPkNB5V/SkD3L2mEpK4x4qYXGn9dGxILAr6Dwv1iQfnVpY
 z+1QkyasYnYBhmpUtPdXCCB8TvUvLTEkeiwhvSDBNpWXzkbsom2xgbGx6c/h3KkinZ/l
 obzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy6mKi8cIzCLXlF92MYOxJSClFcvZgjVI58FkWWJqAihAHMVMPyQOzhFUWktmeJyv0rtOk9FBa+xUBvXY+IRg91vj6Zw==
X-Gm-Message-State: AOJu0Yx9AULdVyEQuumqDAOZWE38jlymFoKNsLlZAlz2wTgsnzvvimRO
 cVrzBXRm3jdKcegjNwsQgh+hCbQ2WXwyp+hLA4OIJO3uU5evGUh+doV/nddP9to=
X-Google-Smtp-Source: AGHT+IGPS1yALqMQSZsyXitJFqsMi/lSZDfDkyDCACkvtq79oROfAjIoTHzVeWzm/24ykp/RQycofA==
X-Received: by 2002:adf:ff87:0:b0:33e:363b:a7dd with SMTP id
 j7-20020adfff87000000b0033e363ba7ddmr8559992wrr.20.1710751724424; 
 Mon, 18 Mar 2024 01:48:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc?
 ([2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a056000108d00b0033d202abf01sm9236451wrw.28.2024.03.18.01.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 01:48:44 -0700 (PDT)
Message-ID: <7cf7abf8-9c38-4481-afc3-7a822f9ddb9f@linaro.org>
Date: Mon, 18 Mar 2024 09:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] ARM: board: meson: update efuse MAC reading code
Content-Language: en-US, fr
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com,
 u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
References: <20240316135430.826898-1-christianshewitt@gmail.com>
 <20240316135430.826898-3-christianshewitt@gmail.com>
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
In-Reply-To: <20240316135430.826898-3-christianshewitt@gmail.com>
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
On 16/03/2024 14:54, Christian Hewitt wrote:
> Current code used for reading the factory programmed MAC from efuse on
> p200 boards does not appear to work resulting in a random MAC being
> generated. Update the p200 board data reusing the function from the VIM3
> source.

I'm pretty sure this code works on the Odroid-C2, but hardkernel had a custom
way to store the mac address so perhaps you should move this code to an odroid-c2
board file first ?

Or try both methods ? if first method doesn't give a valid mac address
try the ASCII format.

Neil

> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   board/amlogic/p200/p200.c | 35 +++++++++++++++++++++--------------
>   1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/board/amlogic/p200/p200.c b/board/amlogic/p200/p200.c
> index 7c432f9d281..fb07eefa532 100644
> --- a/board/amlogic/p200/p200.c
> +++ b/board/amlogic/p200/p200.c
> @@ -14,29 +14,36 @@
>   #include <asm/arch/eth.h>
>   #include <asm/arch/mem.h>
>   
> -#define EFUSE_SN_OFFSET		20
> -#define EFUSE_SN_SIZE		16
> -#define EFUSE_MAC_OFFSET	52
> -#define EFUSE_MAC_SIZE		6
> +#define EFUSE_MAC_OFFSET	0
> +#define EFUSE_MAC_SIZE		12
> +#define MAC_ADDR_LEN		6
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[EFUSE_MAC_SIZE];
> -	char serial[EFUSE_SN_SIZE];
> +	u8 mac_addr[MAC_ADDR_LEN];
> +	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
>   	ssize_t len;
>   
>   	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>   		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
> -					  mac_addr, EFUSE_MAC_SIZE);
> -		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
> +					  efuse_mac_addr, EFUSE_MAC_SIZE);
> +		if (len != EFUSE_MAC_SIZE)
> +			return 0;
> +
> +		/* MAC is stored in ASCII format, 1bytes = 2characters */
> +		for (int i = 0; i < 6; i++) {
> +			tmp[0] = efuse_mac_addr[i * 2];
> +			tmp[1] = efuse_mac_addr[i * 2 + 1];
> +			tmp[2] = '\0';
> +			mac_addr[i] = simple_strtoul(tmp, NULL, 16);
> +		}
> +
> +		if (is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
> -	}
> +		else
> +			meson_generate_serial_ethaddr();
>   
> -	if (!env_get("serial#")) {
> -		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
> -			EFUSE_SN_SIZE);
> -		if (len == EFUSE_SN_SIZE)
> -			env_set("serial#", serial);
> +		eth_env_get_enetaddr("ethaddr", mac_addr);
>   	}
>   
>   	return 0;

