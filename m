Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00DDD1D47D
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 16:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC3484158;
	Thu,  8 Jan 2026 17:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eHqQVPjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6347884158; Thu,  8 Jan 2026 17:15:14 +0100 (CET)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A7884150
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 17:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so481855866b.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 08:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767888911; x=1768493711; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IiQ2M263m7QTXKwLN4tDC8aWCnEeeTKjVpkEGAomMY8=;
 b=eHqQVPjFYtnoXxFqfMA3sReVeSsdYZK+ZYoI2rx7INBLFXnVWY6XZYAJOVWXMemAYV
 B0Yq0qOohG51IYG/5HFTCFz+r/QlGHHID1FyiVieM3HidXM3DpTJtwBpSJ9puhd+Xyxc
 k4NTtyb8tFvtLKB8U2EXWhqU6YFFKlSYZ/bdXJKNGe2gDX0F9uvOgBBF+M+dU8Fe6WBy
 LmjbRIkoFi0F1ZNZgBE+b/181rhggBZFaFDtt8cm22JCc+BYH6tC2Pu7ZG/jVBRzblbE
 Qda1XI0t4gIwltxiPZSg8+rMP8ILyvg5hWu2ZcigiMXhVRrcNAco8GBW1aKVtF5fIDjr
 ycpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888911; x=1768493711;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IiQ2M263m7QTXKwLN4tDC8aWCnEeeTKjVpkEGAomMY8=;
 b=Rvt0RDrvZXxllEeHDtOkFyeqWfl+mIUr/e4+VndH1P6LwwOgOsuQSEi2btaSFYrfoA
 8o13oE7VBzSlQgnHInyEyFCykZy+n2yGINghjEiOIUi8g1l8M9m+vNwj2pBzWUtK4Bow
 nLBKn9m13LLZLctclTuqQCmOzMhHfk5K5C3ZMTiiHg2C+D2BNbk6tGRUJfLp9ittQZvp
 n5BTaAS3UoONBAW2NWUdt+OO1iEi2j5do92ub38YAhC122XUNE7MnmGY8cFApRi14ZvY
 o25uLfq4nMbOjxzwM1BAaAE+TZU/a1ZB/zIEfNBBIhnVYzR/ljjmrl//Tzaibo+Qz8Zf
 7SFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Eek2iS+yCdch+pDL3qWic2aVHEYmSHv53i6KcbXMTmHKVNCBWFdcDklZd1rITQCHP1PRmh8=@lists.denx.de
X-Gm-Message-State: AOJu0YxR4nz0ns9qlEKJ0XHOc6BTnGzbcxKQ7IFIi7flpjAtV+88sNO1
 04LLVVfilLzSoVd+0T20YhYz3VtUkqS3Yc3c6icdN3cVTwmjQv1h0s8BF18O2nSALa0=
X-Gm-Gg: AY/fxX4pXDB64pMTqWNaFYlSv4dntbXJtTc9PIcBvtM49FyrVZRehXe1n+SFFcTWG2n
 FdEbljkta0K4KWLHK7zmAuOw+G0GOSgzcg2tNEK7aIlCHCcVX5Sf99KUYcglW8gRCmTHNZf6V+M
 RtlHbWZoIqljNuyngQysI2vK6Z0OGhjKB3WCIXPii5GX+3WZKqsg8JBhKsGQfqigAeTFI7RhJDN
 VBtorG1GiPa0wjCy4zaTMYcOFaEKI9Jn4++/sJUHQ6ym2ZvoG/5ThGElnHsh3ZHupjn43L7QXF5
 hOh8KCXYWkFJmRUUvfAsjJOw0eq/h8pgX2I+PTxH2ai35sZPU4dYeZpoFek33705iQpo4k/3ZqU
 UP/ky3JqZZr240bPIHV06F9uJ/ktd0yKtrKZ3lTmQwSK8+YGk6CLcAEdapEMNebgRhPHhqry/Wu
 X4qsQ9o5R6QNtyPlFmWzCVk4+LaeVSEUlPNiOyvkbeVQt+poVA8mU=
X-Google-Smtp-Source: AGHT+IGr8gtZPpqzuM+ssayJZ4ogdjVB7iKZX7c1OP3fHg8b3u0L+y9v0plDphOgMi5NRBEGal340A==
X-Received: by 2002:a17:907:3e13:b0:b79:c460:39a4 with SMTP id
 a640c23a62f3a-b84453acb55mr663991266b.56.1767888911090; 
 Thu, 08 Jan 2026 08:15:11 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4d3229sm828256366b.37.2026.01.08.08.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 08:15:10 -0800 (PST)
Message-ID: <51f32da3-e87d-4e8f-b221-0adb9af4bf93@linaro.org>
Date: Thu, 8 Jan 2026 17:15:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] doc: board: qualcomm: document Pixel 3 / 3 XL
 support
To: david@ixit.cz, Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Petr Vorel <petr.vorel@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>,
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org
References: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
 <20260107-pixel-config-v3-1-02a25e3fdcfa@ixit.cz>
From: Casey Connolly <casey.connolly@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107-pixel-config-v3-1-02a25e3fdcfa@ixit.cz>
Content-Type: text/plain; charset=UTF-8
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



On 07/01/2026 21:28, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> U-Boot does work on Qualcomm 845-based Pixel 3 and 3 XL.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  doc/board/qualcomm/board.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
> index 642c5095261..e5dbc9816b9 100644
> --- a/doc/board/qualcomm/board.rst
> +++ b/doc/board/qualcomm/board.rst
> @@ -38,6 +38,25 @@ with appended dtb, so let's mimic linux to satisfy stock bootloader.
>  Boards
>  ------
>  
> +Pixel 3 (blueline) and Pixel 3 XL (crosshatch)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +blueline refers to the Google Pixel 3, and crosshatch to the Pixel 3 XL, both
> +powered by the Qualcomm SDM845 SoC.
> +
> +These devices use the common qcom_defconfig with the google-pixel.config
> +fragment for configuration.
> +
> +Use the following commands::
> +
> +	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig google-pixel.config qcom-phone.config
> +
> +The DTB is called:
> +
> + - "sdm845-google-blueline.dtb" (Pixel 3)
> + - "sdm845-google-crosshatch.dtb" (Pixel 3 XL)
> +
> +More information can be found on the `Google Pixel 3 page`_.
> +
>  starqlte
>  ^^^^^^^^
>  
> @@ -131,5 +150,6 @@ Other devices with boot image version 2 can be built like this example::
>  	fastboot flash boot boot.img
>  	fastboot erase dtbo
>  
> +.. _Google Pixel 3 page: https://en.wikipedia.org/wiki/Pixel_3
>  .. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
>  .. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
> 

-- 
// Casey (she/her)

