Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9DBCDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 07:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA46805F5;
	Wed, 18 Oct 2023 09:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RIUZaj7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD82B80310; Wed, 18 Oct 2023 09:42:43 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0EC4805F5
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32d569e73acso5664994f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697614960; x=1698219760; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=PRTgNSOsXG0F9aLy2A/XE7NkoPOUWrEtgTPGGPgARJc=;
 b=RIUZaj7VVDf0f2S//PrsdPFiA08gcSlk0SJSHkit5caftedagwiL3iikRRe5Ev/fiI
 ix05VMWmi4fvlKew8atYfGGzHg2MhbIO8luc6AQ6u/e4zeflH/gS+ByqS9FWWfUDLZUb
 N1ci3vFOtwYoO/wZnoSwGf2UgneHbjPRN3dW5oen7teaB4r0Iu5owzJJkOMJ1Cu5lzqx
 crlNWGmkNpD7g+9ICkUtkgvMiNSuJdfBsVPoWZd0aF0BOmax7LJIEN++wXKraOnpt87o
 Q2jsLs/Y9Asm+mYFr9AswtdhXBtzutH/+gLrmc8tghIdW/GkpyPNgak0nR7+fl4GLPog
 uxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697614960; x=1698219760;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PRTgNSOsXG0F9aLy2A/XE7NkoPOUWrEtgTPGGPgARJc=;
 b=S9FVKOkTFxZjr6OMAJSm9rXM8p93LyLS5mrawjjrBhmAkKNovuC7rgheKZ9IekPNHM
 SZYiBIhJRGG6jTZX5lBOHBN8OojMVsGcq0hXJ99Lbcpnkv5Pne/0EVr3w/TySC6A7oKQ
 ebQS5pyMydLPSIE2ChaHBiNtUgL+0l64XwhWTnL46Kef/50tXlGDhH6fe5FZTPxGI2ld
 /MQbeNmlo0kNylNwtVXiPmX7aofJop86RyDlHydU3YCJj5VaAPCHcTKWNjxcgPflC0hY
 Z3rFuk7zJSIp8frQjUjAeRlHGO6U9brvU6ZbBYH+IkPEwNEPEBVEgYIhtKOXtS7SGfCP
 Lw4Q==
X-Gm-Message-State: AOJu0Yw45/N7JJ9iJM6XeihvszBnT2Txyhv8fnXAfTtlweIgFWWJvOEM
 x04ptee3z0zvscV3H3YsVo7Q3A==
X-Google-Smtp-Source: AGHT+IFiMpUuxGLmnXBwvD/drZlOEpAchJMyhKaL9bfQNVx829Dm25kk6dI8KZmZfEjwb96fX66SSg==
X-Received: by 2002:adf:ec0f:0:b0:317:67bf:3376 with SMTP id
 x15-20020adfec0f000000b0031767bf3376mr3658884wrn.57.1697614960106; 
 Wed, 18 Oct 2023 00:42:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d8f:701:423:3d05?
 ([2a01:e0a:982:cbb0:5d8f:701:423:3d05])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a056000128400b0031c5e9c2ed7sm1457010wrx.92.2023.10.18.00.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 00:42:39 -0700 (PDT)
Message-ID: <d4fa0c3a-a6a1-4c06-8f9e-f59086201069@linaro.org>
Date: Wed, 18 Oct 2023 09:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/8] clk: amlogic: Move driver and ops structs
Content-Language: en-US, fr
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
 <20231017165649.1492-5-ivprusov@sberdevices.ru>
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
In-Reply-To: <20231017165649.1492-5-ivprusov@sberdevices.ru>
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

On 17/10/2023 18:56, Igor Prusov wrote:
> Move driver and ops structs to avoid forward declaration after switching
> to dump in clk_ops.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   drivers/clk/meson/a1.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 1075ba7333..e3fa9db7d0 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -601,14 +601,6 @@ static int meson_clk_set_parent(struct clk *clk, struct clk *parent_clk)
>   	return meson_mux_set_parent_by_id(clk, parent_clk->id);
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> -	.get_rate	= meson_clk_get_rate,
> -	.set_rate	= meson_clk_set_rate,
> -	.set_parent	= meson_clk_set_parent,
> -};
> -
>   static int meson_clk_probe(struct udevice *dev)
>   {
>   	struct meson_clk *priv = dev_get_priv(dev);
> @@ -638,15 +630,6 @@ static const struct udevice_id meson_clk_ids[] = {
>   	{ }
>   };
>   
> -U_BOOT_DRIVER(meson_clk) = {
> -	.name		= "meson-clk-a1",
> -	.id		= UCLASS_CLK,
> -	.of_match	= meson_clk_ids,
> -	.priv_auto	= sizeof(struct meson_clk),
> -	.ops		= &meson_clk_ops,
> -	.probe		= meson_clk_probe,
> -};
> -
>   static const char *meson_clk_get_name(struct clk *clk, int id)
>   {
>   	const struct meson_clk_info *info;
> @@ -727,3 +710,20 @@ int soc_clk_dump(void)
>   
>   	return 0;
>   }
> +
> +static struct clk_ops meson_clk_ops = {
> +	.disable	= meson_clk_disable,
> +	.enable		= meson_clk_enable,
> +	.get_rate	= meson_clk_get_rate,
> +	.set_rate	= meson_clk_set_rate,
> +	.set_parent	= meson_clk_set_parent,
> +};
> +
> +U_BOOT_DRIVER(meson_clk) = {
> +	.name		= "meson-clk-a1",
> +	.id		= UCLASS_CLK,
> +	.of_match	= meson_clk_ids,
> +	.priv_auto	= sizeof(struct meson_clk),
> +	.ops		= &meson_clk_ops,
> +	.probe		= meson_clk_probe,
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
