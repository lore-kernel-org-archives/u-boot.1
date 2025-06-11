Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A16C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 08:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10AD282B20;
	Wed, 11 Jun 2025 10:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nVKw/Z7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C18382B63; Wed, 11 Jun 2025 10:56:41 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89355828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so5207871f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749632199; x=1750236999; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3VAKlOd77pWPBFi58AJndjuaNJynzUYCe+tOVXXstD8=;
 b=nVKw/Z7uGqSiQZnoTZbljHeDu1mJH4FDIYdwjMzml6bbaSIi9NvG61MSoyUeTBAprM
 +t5IOwi5wUzdmD22FgQLfKFdQgxrUp3dcPTalyyqVDv69g0Sazxu+8Mr+uH0yGxh3b+t
 Qeq9PeRskShg4V0InxQrlj22E1GLmdk66SsRz1aRDr8vX7RxLz8pxe/4lRMvcctA0SuP
 nEOI85MG/rQAyfLBL/zhNKoY4irSrxRJxMq+0Y8m7x9j0tWBneyICWSaLXkfrpo2lrdB
 5Tt5sbsEzh/AOQBzNyun2onT/T9FWBG/hDIzxfU2qUwK0xBZwEWOzY4QWs+hYI4Gv3/K
 hCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749632199; x=1750236999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3VAKlOd77pWPBFi58AJndjuaNJynzUYCe+tOVXXstD8=;
 b=NW2ovi+9F58k7EjktHJ8wrKvXXtPCaygrY4QkDvaWjDAVR/JK0E4KBpA4Hu7b4IfLb
 JghOX6CrYb3tPwBBShCwcGoZoxSICTvHbQq27Z5uK+ftcgVZB55326BvqN5u78BXd+YI
 AfX5gVaroKG8Ze212JELPRed2vnNM64V3vXlBon9B7/LBRDPhE/Q4eFDlMGwxZdUocOO
 Mhhm8sTdPMGi9/2jYGyb9MOAF1MMoTSO25UWuaYNw9N2QzAMGMyageTqcEPNJr+QVk0r
 OgI/KmsS+ltfOgqfWT7ABR176sf8XrEywAqwkGzAQLNJ6Q2Ubf6NiUe6zKseOm/kkbda
 NFJA==
X-Gm-Message-State: AOJu0YxtF5o6niVMSAnH/60nXIaOpUDYetEdN7bMiN5lAWulBHJ7pyvz
 DXYgQbGLZkyjnX2XL8VbtFZiHDY/OZz1MjSh9Jkm9vdb/LSzPkPyn5fA7ycf1Kn9RXs=
X-Gm-Gg: ASbGnctdwhjXzCiP+ZuMGGesjd9dfBe3Lw5HNU1gBFIIQRdG+bLqXjxHfp8f7O17Tza
 M4Kyuz1bkDHz1itjCGaetQEPqK/acro1RF9LVeKoYidjS9ghrmlMOEcN4+6uiB4OQgr3ZzYgleq
 OaWFzcpz7x2sqIxaYjA8uVs1W4RPpp5qpDY1cdB2ADpIuvYxHnKv04GxKLK3YEQvTQyXjam56a3
 rGCUKRtJn0xMQBzCYr6rCrq30krJMjhsU65ZQHYnpVyaOb3PADfyzU/KWL9xgJ2YTH6x+UzyrXS
 d//c3GrsbO/oqnCU0JyJ4hvYdMWGW1gIfnotY1u5E1jY9WM14F/JXO6xpCWUaczNbVW2KG++lOp
 jlSQipCHs0UOS7Ode2WCIvGpdtWr8qGFWF91KTw==
X-Google-Smtp-Source: AGHT+IH9Klpxo1QtKdGlOfgIVzONzmYMtpKKmi/FzgE0VLXKnjyRIpQjdc5STLcOLY5bcXYTYTPZlw==
X-Received: by 2002:a5d:5f89:0:b0:3a5:5270:c38f with SMTP id
 ffacd0b85a97d-3a5586748d6mr1762796f8f.0.1749632198975; 
 Wed, 11 Jun 2025 01:56:38 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:1a1e:c277:1c68:9459?
 ([2a01:170:117e:fc:1a1e:c277:1c68:9459])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324641c2sm14795196f8f.93.2025.06.11.01.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 01:56:38 -0700 (PDT)
Message-ID: <07517668-b9d7-470a-b385-fae79aef9811@linaro.org>
Date: Wed, 11 Jun 2025 10:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] usb: gadget: Introduce usb gadget vendor/product
 default id for ARCH_QCOM
To: gchan9527@gmail.com, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
 <20250520-sc7180-android-boot-v1-4-3075a84ea094@gmail.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 5/20/25 16:25, George Chan via B4 Relay wrote:
> From: George Chan <gchan9527@gmail.com>
> 
> Currently vendor/product id are both 0, and that might not as we want.
> Set to some arbitary known value that we can make it work more smoothly.
> 
> Signed-off-by: George Chan <gchan9527@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Thanks!

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

-- 
Casey (she/they)

