Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5B7C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 08:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0AF80079;
	Mon, 24 Feb 2025 09:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Phx5C9Wl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F7380207; Mon, 24 Feb 2025 09:10:19 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5AC80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 09:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so35551185e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 00:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740384616; x=1740989416; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=W4UO3hB2fTX91FugvwZBK4DRjDr8eE/ZJsnEJypOWR0=;
 b=Phx5C9WloQCUKo1S9sX8Xx2aFahFiAOVJDAUXrIwIBqVMXmmLpwuJVu8f0DrI3E1WB
 RbVVv2cco0VUXglOBdOXFiMyot/cdhsxJdpJe5T0vQXR5rUirMlAOBNU4NEiVkPLVGAV
 3IjeRxJxjKqj7NYAJm9FwcP+fHgNnICaJwwPPsA3DAomLaIyHFukizEbB43NjRPMpHrK
 FcYf7qqu079PXFW08RqxANPE+VsEztnhCzNjWbdd2lS0xsMTG5gmIKEHMCA5NK3sm0xG
 jv44MRUpxkGSwdcLX4/1WI8Mo6ZzcnJ701UaayZpY1SD+9xBTT/+NagCYW5wxspo8m5r
 ZniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740384616; x=1740989416;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W4UO3hB2fTX91FugvwZBK4DRjDr8eE/ZJsnEJypOWR0=;
 b=Cln4I3wnQZL9WxNygwSDeQtgCmpu1lK5DJ6UOdzzRh7O0umRKEvHbtEB6L/YYzFDH6
 H6B/UfNHxhOviqyqDNRL7z87KXje3iIygqt+5gAZmrUGt2ET7x81TzMtixIszn+H1f2k
 w+JX+wKmlJY7iK7KFhY6qIXr4ZA5w27p1Tlb/+Q1BdYDb2+zzLy2Go6V23Is2dRpKzE9
 sm4j8WDoR4+DmxOlKXGy0rKHMUaewa8ZWupvr5wX41Bum1epTNWf09Do/N0H/QqkmAbX
 zUwfCwdRJyS69ltl0kWP9VsKoTgenF2EtWeMSF1q+vR9uuKGSZnwUXhVcWdXjwBG73T8
 rpXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUckJ0abVgya+NGLgldRGoL6T4sAncI9vThQsiRE4DCSc1fGO0B7eFTDbxhkMuCX9dj5PTaeHw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzo3UzCWs9EhUwqJmDJKKlVYwl3IojJdQo4ofziIUjp7am8Qw1X
 oCbWdZTKOC78iylfxO2cS9s8gtalbrA0Clxmn+Al4H70zS9PoIKP79EgrrJVVdQ=
X-Gm-Gg: ASbGnctv0JG9SBIj8m4xw9BBgevMKAhAr15AW/5Vh34+LbMdVdj06t3wdEk7Ij0SjSg
 mHSvYoLexb7Lagi3p9v8KD4fG/d72wBYcdlQoeaPnCrM3DKQZcmzNIG6szTEOvZJtxzSrA9MVse
 B5xeJVrVZHzJmqxXg1FTo5az33N1qeiI3NXF+nq+iACl842Ta39wxeVlHnWRmOy1QTEIBu5TRVd
 tv+3Qy3BwPRZY31/dJtpp+dCKOCnJaI2MrbEmUyvXVruK6RV649iQCEwq1ZA7tXtCS8d0D7Rs9P
 ltV+SP2XzYVIqs2uId0aA19M0hnDuC95E80gMkVJfkmZYVFL7hHxQwHLAJIvD6RrKmsVA8Hyf6k
 viRI=
X-Google-Smtp-Source: AGHT+IFc4maAar//n1r3tp8O40DO0HcOkQBC5AtNQJHYuNHSk1l6CEvHQVfUqmPfYL2LggulgKRdeQ==
X-Received: by 2002:a05:600c:4686:b0:439:8c6d:7ad9 with SMTP id
 5b1f17b1804b1-439ae225a53mr103011535e9.31.1740384616067; 
 Mon, 24 Feb 2025 00:10:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:825b:5392:ef70:cc0b?
 ([2a01:e0a:982:cbb0:825b:5392:ef70:cc0b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02d540fsm97602165e9.10.2025.02.24.00.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 00:10:14 -0800 (PST)
Message-ID: <29cead2a-1946-4700-b039-79429dc600a3@linaro.org>
Date: Mon, 24 Feb 2025 09:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] amd: versal2: Add the UFS boot mode support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, git@amd.com
References: <20250224030132.1741582-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20250224030132.1741582-1-venkatesh.abbarapu@amd.com>
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

On 24/02/2025 04:01, Venkatesh Yadav Abbarapu wrote:
> Add the UFS boot mode support and update the boot_targets with
> ufs mode. If the UFS device is not accessible from APU and
> running this is detected as a warning, as the device is not
> accessible.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   arch/arm/mach-versal2/include/mach/hardware.h |  1 +
>   board/amd/versal2/board.c                     | 11 +++++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
> index 42e3061a0ae..022c8b3c832 100644
> --- a/arch/arm/mach-versal2/include/mach/hardware.h
> +++ b/arch/arm/mach-versal2/include/mach/hardware.h
> @@ -67,6 +67,7 @@ struct crp_regs {
>   #define USB_MODE	0x00000007
>   #define OSPI_MODE	0x00000008
>   #define SELECTMAP_MODE	0x0000000A
> +#define UFS_MODE	0x0000000B
>   #define SD1_LSHFT_MODE	0x0000000E /* SD1 Level shifter */
>   #define JTAG_MODE	0x00000000
>   #define BOOT_MODE_USE_ALT	0x100
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 5651d516a9e..24c99a28082 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -252,6 +252,17 @@ static int boot_targets_setup(void)
>   		mode = "mmc";
>   		bootseq = dev_seq(dev);
>   		break;
> +	case UFS_MODE:
> +		puts("UFS_MODE\n");
> +		if (uclass_get_device_by_name(UCLASS_UFS,
> +					      "ufs@f10b0000", &dev)) {
> +			debug("UFS driver for UFS device is not present\n");
> +			break;
> +		}

Do you have multiple UFS controllers on the platform ? if no simply use uclass_get_device() with index 0.

Neil


> +		debug("ufs device found at %p\n", dev);
> +
> +		mode = "ufs";
> +		break;
>   	default:
>   		printf("Invalid Boot Mode:0x%x\n", bootmode);
>   		break;

