Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134DAC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B4D188103;
	Thu,  6 Jun 2024 10:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J7n+ETT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F025E88103; Thu,  6 Jun 2024 10:56:53 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B598808B
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a68e7538cfaso86047066b.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717664211; x=1718269011; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6w7slEh5StRr3Zx1eFNMCw1ME3F//BAc7T9QA+tznOQ=;
 b=J7n+ETT35Z7Oxlqxhj+Lyw7NE8MkDVLIGtlFQJCMM8FLqYf0uljQ65FbHswxll5T3D
 63s+lsWi9euzpXaZEujqgMv2CY3s6oeanyggCR/OMdTxXNSWT36vVne0Ex4Rdy8E2NW8
 qgkVr7ey5g4iZTAg9YRig+xlEybqs7OCKaWie4yg/16MKa9TPK0binqI6hZHXb1wW6EM
 4Pu92JiWdhKg0MinxVwit21+Dv0HsJUxO1qd4kvzZzWw5Kr1y5ZXpdW9jtXu52oY6ncm
 AVUoeVbXVZRsn9nzX4yQq8J8QFdIYSkQyKTYBsk+W+Jc8zFefCe2y5mnyhehkLMLFwR3
 4Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717664211; x=1718269011;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6w7slEh5StRr3Zx1eFNMCw1ME3F//BAc7T9QA+tznOQ=;
 b=KHlNoxp1OCtEN+He/9j9HrSqQpM6ebNzFGlRpv1DKhq7VJTWhZSNLMlAjd3MLbRiqA
 lBjTdtynwXBAlfu12fraUr5n+EmZCyq2W2LEkuyCc8HNI7qhtbQ9avDy0rM02odoDWu4
 i2cIz1+ApGG5e/WCGqEXDQdnHpeiHjGRvRRq2YFkM6wcfntj8O0Hs71gMX40PclJZ+jt
 vKEuFBDu/ou8be6MWvSn0ySwQHVcZGdFI8dADnNlq8rZl2rVY/8fNiOCzWWKluJ5YmXD
 Tv2y7KulU8TPGkxszQa0V5uvCOhyoAVxPyBzNSrhpxxiBPjzFfqueI1tRfTFmP9P0j1k
 bPuA==
X-Gm-Message-State: AOJu0Yw6nescgZftJepxwkxa3hJfcf7Xc4S+q0xwIOEG+rL5PCUlBeKA
 NsP61tDRebdKJnL7lw9cwXUgc+95Ux50a64UgEhtBFMtvRyiKN3g4h4OGU7DLkGg7TRGFuFb4hR
 r
X-Google-Smtp-Source: AGHT+IEPWeralJQFygGG33iRfWoHWKhf2FukIzmhSRFN3c4r+8t7wmJ7LwyTdC68gjnl0BSf/dC0ug==
X-Received: by 2002:a17:906:fc01:b0:a59:9dbf:677b with SMTP id
 a640c23a62f3a-a69a0022d72mr348500266b.48.1717664210955; 
 Thu, 06 Jun 2024 01:56:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2?
 ([2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806ebd31sm66150766b.139.2024.06.06.01.56.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 01:56:50 -0700 (PDT)
Message-ID: <3b02b64e-98bf-4277-a41c-b862dbe32560@linaro.org>
Date: Thu, 6 Jun 2024 10:56:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/7] led: status_led: add new activity LED config and
 functions
To: u-boot@lists.denx.de
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
 <20240605192146.19052-5-ansuelsmth@gmail.com>
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
In-Reply-To: <20240605192146.19052-5-ansuelsmth@gmail.com>
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

On 05/06/2024 21:21, Christian Marangi wrote:
> Add a new activity LED config and additional functions to implement a
> simple software blink feature to signal activity of any kind.
> 
> Usual activity might be a file transfer with TFTP, a flash write...
> 
> Driver will call status_led_activity on each activity and LED will be
> toggled based on the defined FREQ config value.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/led/Kconfig       | 15 +++++++++++++++
>   drivers/misc/status_led.c | 25 ++++++++++++++++++++-----
>   include/status_led.h      |  1 +
>   3 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index 6c4f02d71f2..8eaa74bdd27 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -359,6 +359,21 @@ config LED_STATUS_BOOT
>   
>   endif # LED_STATUS_BOOT_ENABLE
>   
> +config LED_STATUS_ACTIVITY_ENABLE
> +	bool "Enable BOOT LED"
> +	help
> +	  Enable to turn an LED on when the board is doing some
> +	  activity (flash write, file download).
> +
> +if LED_STATUS_ACTIVITY_ENABLE
> +
> +config LED_STATUS_ACTIVITY
> +	int "LED to light when the board is doing some activity"
> +	help
> +	  Valid enabled LED device number.

I would add multiple entries here, like:
LED_STATUS_ACTIVITY_STORAGE
LED_STATUS_ACTIVITY_NETWORK
...

so we can enable either ones and specify different
leds for each applications.

Neil

> +
> +endif # LED_STATUS_ACTIVITY_ENABLE
> +
>   config LED_STATUS_RED_ENABLE
>   	bool "Enable red LED"
>   	help
> diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
> index 93bfb410662..9490e1d7341 100644
> --- a/drivers/misc/status_led.c
> +++ b/drivers/misc/status_led.c
> @@ -82,6 +82,14 @@ void status_led_init(void)
>   	status_led_init_done = 1;
>   }
>   
> +static void status_led_sw_blink(led_dev_t *ld)
> +{
> +	if (++ld->cnt >= ld->period) {
> +		__led_toggle(ld->mask);
> +		ld->cnt -= ld->period;
> +	}
> +}
> +
>   void status_led_tick(ulong timestamp)
>   {
>   	led_dev_t *ld;
> @@ -95,11 +103,7 @@ void status_led_tick(ulong timestamp)
>   		if (ld->state != CONFIG_LED_STATUS_BLINKING)
>   			continue;
>   
> -		if (++ld->cnt >= ld->period) {
> -			__led_toggle (ld->mask);
> -			ld->cnt -= ld->period;
> -		}
> -
> +		status_led_sw_blink(ld);
>   	}
>   }
>   
> @@ -140,3 +144,14 @@ void status_led_toggle(int led)
>   
>   	__led_toggle(ld->mask);
>   }
> +
> +void status_led_activity(int led)
> +{
> +	led_dev_t *ld;
> +
> +	ld = status_get_led_dev(led);
> +	if (!ld)
> +		return;
> +
> +	status_led_sw_blink(ld);
> +}
> diff --git a/include/status_led.h b/include/status_led.h
> index fe0c84fb4b4..037bad159c2 100644
> --- a/include/status_led.h
> +++ b/include/status_led.h
> @@ -39,6 +39,7 @@ void status_led_init(void);
>   void status_led_tick(unsigned long timestamp);
>   void status_led_set(int led, int state);
>   void status_led_toggle(int led);
> +void status_led_activity(int led);
>   
>   /*****  MVS v1  **********************************************************/
>   #if (defined(CONFIG_MVS) && CONFIG_MVS < 2)

