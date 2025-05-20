Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F828C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC7182C96;
	Tue, 20 May 2025 16:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xR4gbuDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D1D82CA0; Tue, 20 May 2025 16:30:16 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F120582C2F
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a375d758a0so1432303f8f.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747751413; x=1748356213; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=pYzkuSjqvBpjHV5Z50U1a/nSS0xZOP65HykrDB02EAE=;
 b=xR4gbuDl+8o6CYeNEnmPVANSVDVI1A9TzPg5NjpUvJ0gVIPGmgpRj0LArzf3MPY8uM
 ezsBdIXQcf2BtBCqe0CZ1pPlfFHYmYtzqSYXsGbVcbI7VZDHPvjhwZOCO2DWCdyxoqWO
 3EU+xQNZ1PHkKOmL0qrZga/rIi1lECofTFr99g4pKOuRtK7BW38kESNqlL/zAQ1fUutB
 mpLrNLikn6dqxtnPGWbao+h6qz6nYYhqEh4VvojP6y5y8Ge8NDmSf9EEQcokY9KJftOB
 LgGDc2TsiayFeE1AOlZGg8xikZf8eRyS51oCgVwFyGvZ9jldyfTcVdhtpOTYygPpvIrC
 ebgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747751413; x=1748356213;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pYzkuSjqvBpjHV5Z50U1a/nSS0xZOP65HykrDB02EAE=;
 b=lhqOB47VQpzASuWGXu4x6rQmYr0zOKNj91okngOW5j8/FVDEi/+W+/XzoODTkbkUGa
 DrdumWOe7YzTZiI9FX2kiteECrpNmwWV7xv9uNFhsbK1+Gm/AvvQ4vBST0c33av01AeF
 3mM4YxJSUiUP6Ij5JBuGqLxtkuSKpzm/6llu7gg6DqSxWcJXzH/mNKGl4cnqDsoV6rDU
 vWtieT7o25z9UwsrPEp7iY7e/m6DZJlrTvxHJ6NRXDOmc4GDB3T/6pKsPX3HNV18oGD1
 V+sNxv/J5/+c7UFmcHZjaHo4cBLoHSHvbomcPoY+M5F9Ees12WJpeTpIF8TzNLs8z9wJ
 jHjQ==
X-Gm-Message-State: AOJu0YytH4vPJivP/DutQkNDnv0IMTrjWaTBnpgYEi4iyYERAv5hXSvm
 5nXbDPkpzl1A04pkAnS3bxXXVdBj90I6OWNnSq3vNVqP5Q5gpFsDlLMAxaNocbL8Fx4=
X-Gm-Gg: ASbGnctvUd6/7kFli8xL8zFz3wGI4gtFBz0Zj1xaIhpGJDNjk1e1SgBD6lLS9hqIVAn
 +PaByh7vmOCKR7CsPE8AnQDRvvAPIbIYSpeYJgdPvr6TzsMMCm/ZIGxPhbNrxVoxkj9c+ZP2N9t
 dX/EVQdPWMMkCBVCIY/bNLyMVDpkGrkzTtVIVEyQCTAnnIiK19Wp3a1o8KXsUl/pTRS5Vqiklaq
 8eCjdI4B2tfcqpH56R6zFyD7zRtKUtAXe7F8Qt9pKZu4psTxHNJ+0IhfwD+6VBfJBmzo1MFjmFU
 BT6MtZWS+oOVHApOfok9SHerN3rVc42rQwEN9PYHQNzDkBJhTtNSMce2CTEm0mBzYgcBS63Eizc
 k3nduttbp8s4YYDsQQXzoxZwSWYSh
X-Google-Smtp-Source: AGHT+IGni0AsMWj2m7Zj7UpROvEKZqWYZT+LPevYRcs1mCSyEJ6EaPJiFdPVAzYQz8duPvg9SupX5Q==
X-Received: by 2002:a5d:5f8d:0:b0:3a1:f5c6:2bd with SMTP id
 ffacd0b85a97d-3a35c835163mr15947149f8f.31.1747751413345; 
 Tue, 20 May 2025 07:30:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:fb2e:6266:4e39:ce68?
 ([2a01:e0a:3d9:2080:fb2e:6266:4e39:ce68])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d310sm16745140f8f.17.2025.05.20.07.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 07:30:12 -0700 (PDT)
Message-ID: <374d268e-ee55-4a95-90e7-d28e8f9b58db@linaro.org>
Date: Tue, 20 May 2025 16:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/4] usb: gadget: Introduce usb gadget vendor/product
 default id for ARCH_QCOM
To: gchan9527@gmail.com, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
 <20250520-sc7180-android-boot-v1-4-3075a84ea094@gmail.com>
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
In-Reply-To: <20250520-sc7180-android-boot-v1-4-3075a84ea094@gmail.com>
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

On 20/05/2025 16:25, George Chan via B4 Relay wrote:
> From: George Chan <gchan9527@gmail.com>
> 
> Currently vendor/product id are both 0, and that might not as we want.
> Set to some arbitary known value that we can make it work more smoothly.
> 
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
>   drivers/usb/gadget/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 46a83141481..2a56e360b5f 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -60,6 +60,7 @@ config USB_GADGET_VENDOR_NUM
>   	default 0x0955 if ARCH_TEGRA
>   	default 0x1f3a if ARCH_SUNXI
>   	default 0x2207 if ARCH_ROCKCHIP
> +	default 0x18d1 if ARCH_QCOM
>   	default 0x0
>   	help
>   	  Vendor ID of the USB device emulated, reported to the host device.
> @@ -86,6 +87,7 @@ config USB_GADGET_PRODUCT_NUM
>   	default 0x350a if ROCKCHIP_RK3568
>   	default 0x350b if ROCKCHIP_RK3588
>   	default 0x350c if ROCKCHIP_RK3528
> +	default 0x4ee0 if ARCH_QCOM
>   	default 0x0
>   	help
>   	  Product ID of the USB device emulated, reported to the host device.
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
