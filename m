Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D248C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 13:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C3E783F58;
	Mon,  4 Aug 2025 15:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WJWfpVVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F97D83F6C; Mon,  4 Aug 2025 15:44:12 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AF483F56
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 15:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-459d4d7c745so13366385e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754315048; x=1754919848; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=veJGBWsqwO80MJrIqlcYXdjOna4N8df51Hx7RC1htSs=;
 b=WJWfpVVxBnxhGNkh3NJfqSiopqDD2c3/KTAI+RoKFTur6/E2TRn8DHsOojQYWqlep+
 0zXs+OH299WZO8zyqWos8kIJW5IFWnny5gJKS4cp3x+RnZNFUR7qTnWaDRbesD35zswF
 I6f/9GoDqRkOwUUSIWAYFBnvzHjbYwJ0ZzdkArBTQwa2bd5+QKqF7Md3O1bmCQrhWsA5
 YD6ZI1DvESOjQOAEMVJQ74WB7SElxsno6+YUN/TVivNP1su2X6xJhlzO5nUqHs53c4NN
 ciSORttJueHndbty2Jlg67+L5YtPXjOlcCksFbXXUpaU/n9KX9hUI1blupRkeKHj6Dhw
 aVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754315048; x=1754919848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=veJGBWsqwO80MJrIqlcYXdjOna4N8df51Hx7RC1htSs=;
 b=d7RdweCtulOvOmmVcTfn9qbvrupiFFkhUoYWJAg7cMWBqN2niYDlBhTMEcvLHIKoS3
 2G5dM8rXq0Ra/sRxAP3ILPQFUr+t8LGf8fEOk1WG4nu33/h1wwc9C1vtwQiHcgnWQZIv
 L5qBxPKFtIfqdBixUKwZP+yAN+WmE6OZNDm+q8CwkJzlcDle1l+1A/iBe4TAW7d2eSqp
 KxoUcNsp13xeFhEYvYccK0iVIWQBi4S0wb2+Y2H9k+SeEC/MwgWoNi0lyiGOoTYi2rDx
 HBRpt4ciwO7oBMM//DbGuuvngN5jiPLhrifOqjbMh8gBvSOLmT3c48JgnxKO2w8AZXvf
 Wz4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5PzJuzWvMJctPebs6m7fhmqrwTef/C/eZsfgEkcl5YAY2lMZJ1LL6C3EE5Oz5V/1rlzGd3II=@lists.denx.de
X-Gm-Message-State: AOJu0YxVGTvY4Oto62vDAsUYD4WBhjK6gUL64lEQ3FUcJrdT8j0yeKBt
 WFEssoEncWDtAPwSOeatZ/ogo7wvQOod2GitVAt2pWAJSagTgcRNZ/496fBI4As0r2k=
X-Gm-Gg: ASbGnctuCoK7HHGq0HZCzNid6TPnqxv+YUlObOonQals4gEhb/LJpyRAmwOMEWGBL+a
 9+Jwuqov1dDcb9x1SRgV3YIW7bWD7LSzO1Wy1pjVMbPS7VDpg8eLguV5qLxKhQu9s6RhwYCLv5t
 E26s/3buuwGUD7PWsGyF4okI00CyyFcAyYUQALfUIu1kUE5emsrbYKpIPcTDn12+lAvuIG26wwP
 8CewjM9SO/TBZzrbkUBeH44nyqcp9WoYgehVg3zaTIpsPiuT3I2BdQqDQmR2a2bg2ifc8h8Yw1Y
 xO66OmO3LN4G2Ulj2QxJVaVMPz3hfx/KyEQTc2ShhlCtZtv8c4yvpmRRzpA5wzBKS2Y+4PUvnwv
 cj3vF9hXjtwPg5CRROm0/QiZz7Z7UWHzjMOilJl5djs2LI3MpU5DCkjNtxguvL6Rvb78=
X-Google-Smtp-Source: AGHT+IHfb120UFunClnyDtmt75zAWlNDVvtGKeh/PN/jJ45SA0oFVPgBVtiwa3T1ceC9aD+WGeCWgQ==
X-Received: by 2002:a05:600c:3b0c:b0:458:9f0e:ad1f with SMTP id
 5b1f17b1804b1-458b6b47b0dmr65283305e9.27.1754315047839; 
 Mon, 04 Aug 2025 06:44:07 -0700 (PDT)
Received: from [192.168.1.159] (p4fc3de8e.dip0.t-ipconnect.de.
 [79.195.222.142]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee57c18sm168673695e9.28.2025.08.04.06.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 06:44:07 -0700 (PDT)
Message-ID: <6d53bada-4dda-4f6a-b1cd-2b6dd6acea27@linaro.org>
Date: Mon, 4 Aug 2025 15:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] doc: board: qualcomm: document Pixel 3 / 3 XL
 support
To: David Heidelberg <david@ixit.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250802001359.2122103-1-david@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250802001359.2122103-1-david@ixit.cz>
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

Hi David,

Thanks for respinning these and adding the docs, some suggestions inline 
(sorry for the nitpicks).

On 8/2/25 02:13, David Heidelberg wrote:
> U-Boot does work on Qualcomm 845-based Pixel 3 and 3 XL.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   doc/board/qualcomm/board.rst | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
> index 642c5095261..12ff15f49fc 100644
> --- a/doc/board/qualcomm/board.rst
> +++ b/doc/board/qualcomm/board.rst
> @@ -38,6 +38,31 @@ with appended dtb, so let's mimic linux to satisfy stock bootloader.
>   Boards
>   ------
>   
> +blueline

Pixel 3 (blueline) and Pixel 3XL (crosshatch) would be a better title I 
think (starqlte is not the best example imo). These two can be combined 
into one section.

> +^^^^^^^^
> +The blueline is a Google Pixel 3 phone,
> +based on the Qualcomm SDM845 SoC.

The Pixel 3/3XL are based on the Snapdragon 845 SoC. They are supported 
by the generic qcom_defconfig with the google-pixel3.config config 
fragment::

	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig 
google-pixel3.config qcom-phone.config
	make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc) 
DEVICE_TREE=qcom/sdm845-google-blueline

If building for crosshatch use 
``DEVICE_TREE=qcom/sdm845-google-crosshatch`` instead.

Kind regards,
// Casey (she/they)

> +
> +This device is supported by the common qcom_defconfig in combination
> +with google-pixel3.config config fragment.
> +
> +The DTB is called "sdm845-google-blueline.dtb"
> +
> +More information can be found on the `Google Pixel 3 page`_.
> +
> +crosshatch
> +^^^^^^^^^^
> +The crosshatch is a Google Pixel 3 XL phone,
> +based on the Qualcomm SDM845 SoC.
> +
> +This device is supported by the common qcom_defconfig in combination
> +with google-pixel3.config config fragment.
> +
> +The DTB is called "sdm845-google-crosshatch.dtb"
> +
> +More information can be found on the `Google Pixel 3 page`_.
> +
> +
>   starqlte
>   ^^^^^^^^
>   
> @@ -131,5 +156,6 @@ Other devices with boot image version 2 can be built like this example::
>   	fastboot flash boot boot.img
>   	fastboot erase dtbo
>   
> +.. _Google Pixel 3 page: https://en.wikipedia.org/wiki/Pixel_3
>   .. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
>   .. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/

