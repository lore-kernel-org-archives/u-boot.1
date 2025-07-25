Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229EAC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B0F683984;
	Fri, 25 Jul 2025 15:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GUlqxOZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 572E48398C; Fri, 25 Jul 2025 15:20:46 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D8D83981
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so15083145e9.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753449643; x=1754054443; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3g+oCJr+aNks9II8zSapm0U9uAaLBfh7cUPKyhZw9Bw=;
 b=GUlqxOZVpJos5eH8RdWuI6TlcDr44UCv8C8gt6MWK6OhSljkJ+p25WXkaoxOhnwitj
 u+25/st+r81uBiybvNcDbkAifRLYixorWy2HoZZkw1jzXL/Y96TBVmIKY0AAFdZJ22v/
 QWc7H64muYMYGlHnG/gvi1zxpj+Kmbzq2mLCFFPSwbRQLyPhXZy8FtqrzZdK4mK90KMQ
 KZ8xIfSw+Wgwyl/+rUEOcKFEnUZgSoviZ9ICnA9s5ePqeb0Y/oVPLny3XwqkVrdaMS0R
 6ei4m4ed+lyZ3o1kEYc8Ge1LIs4WvtmGFR4ft8OePBOdP8825Yu1Ld/IhcYtET/B1FuJ
 wCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753449643; x=1754054443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3g+oCJr+aNks9II8zSapm0U9uAaLBfh7cUPKyhZw9Bw=;
 b=nGQ+KxCfG0VF2hxMLrtdrLq7ZIPeQzXyXcfMqcXSNxJKIvHLAjylqkN7wMn7liB7aZ
 6XKeQhv2g1GMJq4voxqh/lgepXSGYC77zfO0YlRAB+sf5hbyN+efV+PtBpFomz5tyLTP
 LFtGoXfUbWKn6xZiXpeVIbMNI8vlWG7RSthGt1K+J4bSw9ApRA4Hei8x2RhHkKq0woEN
 SehMFj0QHtCC8H3GEUxHkx5YrziPGhv+Q5vaSENpe1edUlLU4FUhy9s3FTzXQFqabsEi
 5CMRg+D9jWtqcKr9Q1LfddvaHko+REPYlYgbpY4jR4+jrMVMzCihgo8VCZakOm76lQU4
 ELEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ7okRlQKjXWprHE+k92IvFSrtGbzGMN+oGW/Zw3WpXteEFvcArhTtd4qsX65stLesa0al1Mg=@lists.denx.de
X-Gm-Message-State: AOJu0YyYN03kSpSGTCM8drV9lfLdPkPBp6NFpd2AdH1RtA+9uKu0Rgrp
 n9TQGkzLlP7epDXNOeNnsEurhObbqgu0bB8JKtQfDlUGC2PdVNrhyIfBjaTiGSOhC9c=
X-Gm-Gg: ASbGncuC5oLyNoZFt2AXH61n8RwD0lEhMDWQ5Xyefqwy0JTP0BjdpfcJe/BSRURvGGI
 sY6g+zNXkWCF808LuU7AETESNjy1hBJocIkVH3dFUR6OUI/uxR9tuCGJB+M5M8S829D2WJagFel
 V1xIwwLPac3pPkUUH+Jsp0WX27Uyd74+tmcX8h+1OlrDxExoU4ej2LwZ36axTLYgkKSOsoOYVPm
 ZizcT2ltwCj+ZvJuOyvlyQc6E9VOEcFydhOtUnU5WrD+XobWKBQp8nJWBA9jHJEoybWga5kcOJA
 jO7vCStT7XqqnlKFgNZ2gLwjqnXTY6wqKayR3jObUV090I2Ve1ObgvVG8OR5obJYBs2iRXL+UeB
 l35wkHwgGQMJ22qGU4Wt1omecc46FGDK7BgcGcywMPvMB/alxlkx+JdSHj2LIMqA=
X-Google-Smtp-Source: AGHT+IFr/B679Yg+J7MNz6lLglabYi7Qi7hQopmTsd9D49X8EwB00g954IQ2uO66uWxM6j0oygTLFg==
X-Received: by 2002:a05:600c:45c6:b0:450:ceb2:67dd with SMTP id
 5b1f17b1804b1-4587665dc28mr15267495e9.33.1753449643425; 
 Fri, 25 Jul 2025 06:20:43 -0700 (PDT)
Received: from [192.168.1.37] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4d91sm56104895e9.23.2025.07.25.06.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 06:20:42 -0700 (PDT)
Message-ID: <8c21bb95-8eb0-4c27-be0b-e89cefa12fe3@linaro.org>
Date: Fri, 25 Jul 2025 15:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qcom_defconfig: Add VID/PID to represent fastboot
 device
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: neil.armstrong@linaro.org, trini@konsulko.com,
 dmitry.baryshkov@oss.qualcomm.com, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250724111911.67872-1-sumit.garg@kernel.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250724111911.67872-1-sumit.garg@kernel.org>
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



On 24/07/2025 13:19, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Currently fastboot mode is enumerated as VID/PID: 0000:0000 which is
> not appropriate. On Qcom platforms, fastboot mode is rather enumerated
> as VID/PID: 18d1:d00d in ABL or from fastboot.efi app. So lets use the
> same VID/PID pair in U-Boot to represent fastboot mode.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> 
> Changes in v2:
> - Rebased to tip of master since v1 didn't apply cleanly there.
> 
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index b9ba7a677d9..4e24a43b888 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -140,6 +140,8 @@ CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
>  CONFIG_USB_FUNCTION_MASS_STORAGE=y
>  CONFIG_UFS=y
>  CONFIG_QCOM_UFS=y

-- 
// Casey (she/her)

