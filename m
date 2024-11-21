Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007B3D6ED21
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 12:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F133789733;
	Thu, 21 Nov 2024 13:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h5lpuMUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C782C896DD; Thu, 21 Nov 2024 13:44:59 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 995F689735
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 13:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3823eb7ba72so552926f8f.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 04:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732193097; x=1732797897; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XAP4DrigMVMiMfcoIhqeE7cQoBqFQTLG+/qbeiuhYU8=;
 b=h5lpuMUrlLXmEk2M8wH+9vRGrBj+ad1fAd2KfWoxcZQ17mx4ub3f3wJ4TZdhX1tABv
 TPrO5DzG9BqW8mk2fcjXukMHr5Hm7qbeYsssPsZ8eKnJoxN5kAIy0M/Z9nBkbVapsCfq
 XAfzLPQIMYCv2WZjGalp9HeNdxzBnHixoiI0VnG1SPZuckmLeTBVtq5KXEU+rtFQRsVV
 lMhwuMKaPIGP8Gcxh4ZDHezPrtbSC23aUL/IpUTy5JSjahCbnSF3oRzqBDcn06w8sisL
 iaOd+RgP/li8BWVrth8379BrvyzzBKnoMyIsH+fIj/mExximhY6wAuI465x68ITD88Uc
 91FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732193097; x=1732797897;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XAP4DrigMVMiMfcoIhqeE7cQoBqFQTLG+/qbeiuhYU8=;
 b=i1ObFjBX1zISYdSBySQ2bXId2Bk1fYKS187N5JNjDUHI8xQaDPY1nPS2zVKFzfdMYT
 Vx5Qj6D5yw2Jka5/P5Yo0xG6j7BTKHyHP4H13Ko1zrhdJZou8tyy5hcvJNmKot8GlhYE
 WgR0NwzzoQjrhSz8Ni2Rkui5YUDpCMPIpYmtIkKbAZIborJ872x9p/gQ8mKHbSTCgznv
 GaJORfGn6dumNzn7srDCPWjeHrVFbXqOpmaeFXEfrX5zV+++p/MDIQ7XwR0nnGhI0sFh
 8OrGsodIyO/jQnA2NmikXosRo+VF7VC6UuGlyeISP3M9P3OEIaJHg8fXa5akzIqqwf9k
 KgPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJr7H1PZ7iFLRvkvesXO3zo+9oEO7WkAg3Pp+oDdYa7zDEQ2x1v/6q5HmPXolTaG7cIO7axtE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9mbZR2qajhGVIAf7MRhtq5IQW0lLiWb9DO6LQ919fGVp/U1G5
 LKRoRGqbbRva3FYimKtXLzdvXlVxRSwWRPx/Yw6MuggEU8cIOFtRVdb6uv0urfg=
X-Gm-Gg: ASbGncsB50/6HzMW+9ibjd+e3NNvvcF2oDQbCXvhKxcewXyFq5tIyr4shfUjXxW02Dn
 ad/y+PfU3XSkxf54PTETkpU42UF99ug1j4vwM6JRA/l/LHGSf9n5+pOwAK4GXyM0XVtto+GAN8d
 l07EC9Mme28B5W9BXEgMWy8vHOh9RHgLOpcj0iEQ10VRf0tjTyWNWw30hf2Rdd0utQlyxOxiFbc
 J4LD7QgBoSyqtqCMPrFjWrdJk7hXBwau/mPjv256dCxKJ8unLjxoPwBOLdqSJvY97ES45UjWhHW
 CMoiquAubSMNmLUSUPq900pGNcI=
X-Google-Smtp-Source: AGHT+IHjhyNon97T4fDqcrLPgyqVDtt5aTAztdazQDltKAJBtKwTQARBmPrGfXx7Zu9EFUfN/dJC5Q==
X-Received: by 2002:a5d:47a1:0:b0:382:511c:b994 with SMTP id
 ffacd0b85a97d-38254adec9emr4858302f8f.12.1732193097084; 
 Thu, 21 Nov 2024 04:44:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a1a9:424e:b7e9:e093?
 ([2a01:e0a:982:cbb0:a1a9:424e:b7e9:e093])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463ab1fsm53706915e9.29.2024.11.21.04.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 04:44:56 -0800 (PST)
Message-ID: <f2e90ccc-424e-4ab7-93d9-7ca4aaa5a600@linaro.org>
Date: Thu, 21 Nov 2024 13:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/4] fastboot: blk: add block device flashing configuration
To: Dmitrii Merkurev <dimorinny@google.com>, u-boot@lists.denx.de
Cc: rammuthiah@google.com, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ying-Chun Liu <paul.liu@linaro.org>
References: <20240306185921.1854109-1-dimorinny@google.com>
 <20240306185921.1854109-2-dimorinny@google.com>
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
In-Reply-To: <20240306185921.1854109-2-dimorinny@google.com>
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

Hi Dmitrii,

So you plan to send a new version of this patchset ?

It would be very useful to enable fastboot onr UFS/SCSI based devices.

Thanks,
Neil

On 06/03/2024 19:59, Dmitrii Merkurev wrote:
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> ---
>   drivers/fastboot/Kconfig | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 5e5855a76c..460c5e98d7 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -87,7 +87,7 @@ config FASTBOOT_USB_DEV
>   config FASTBOOT_FLASH
>   	bool "Enable FASTBOOT FLASH command"
>   	default y if ARCH_SUNXI || ARCH_ROCKCHIP
> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
>   	select IMAGE_SPARSE
>   	help
>   	  The fastboot protocol includes a "flash" command for writing
> @@ -109,12 +109,16 @@ choice
>   
>   config FASTBOOT_FLASH_MMC
>   	bool "FASTBOOT on MMC"
> -	depends on MMC
> +	depends on MMC && BLK
>   
>   config FASTBOOT_FLASH_NAND
>   	bool "FASTBOOT on NAND"
>   	depends on MTD_RAW_NAND && CMD_MTDPARTS
>   
> +config FASTBOOT_FLASH_BLOCK
> +	bool "FASTBOOT on block device"
> +	depends on BLK
> +
>   endchoice
>   
>   config FASTBOOT_FLASH_MMC_DEV
> @@ -189,6 +193,18 @@ config FASTBOOT_MMC_USER_NAME
>   	  defined here.
>   	  The default target name for erasing EMMC_USER is "mmc0".
>   
> +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
> +	string "Define FASTBOOT block interface name"
> +	depends on FASTBOOT_FLASH_BLOCK
> +	help
> +	  "Fastboot block interface name (mmc, virtio, etc)"
> +
> +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
> +	int "Define FASTBOOT block device id"
> +	depends on FASTBOOT_FLASH_BLOCK
> +	help
> +	  "Fastboot block device id"
> +
>   config FASTBOOT_GPT_NAME
>   	string "Target name for updating GPT"
>   	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION

