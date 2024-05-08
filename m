Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F65C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 12:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C6F88844B;
	Wed,  8 May 2024 14:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ulTRrr8H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B69488551; Wed,  8 May 2024 14:32:57 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A19F8843F
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 14:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59cdd185b9so139333366b.1
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715171575; x=1715776375; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nwCexTCNNJWuQSjICm549YM3OkqS/kntZbWtLHkfEvE=;
 b=ulTRrr8Hv6vzKqEEk2Nm5Q4cmtUo3G5nH/aqII2GoRR1gip2duvGcJc6SHcrQgQTEM
 8Ht42qU7+x2Cxx7K/9SAnq63qV/FCIbbsAbWkbG5crHuDTKx0FtJlts7qKIW+Ghr8tsV
 h7tD2f0fUKiMSYyu6UzEfRwVO0hynF3PUUtLE9+0SGF/mQelM3SWj04Qq8VHppX7aXl/
 YWqJSY6pPgG1CHacmUtYk+LAbro7+z5ChbIm8UoiLKx6Ki5EtfSgzWa6xHM+0aj/iK1A
 Of9IwQfi1eXt58zHu6n/bnvkrkLPZB3+K//LtchVCni6wXROEOSSJjW1ZnEFIlcMi7xx
 Vjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171575; x=1715776375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nwCexTCNNJWuQSjICm549YM3OkqS/kntZbWtLHkfEvE=;
 b=HTtxzYW+ML2XvpJmWu/ptAjlaONcuhHQcdRn2VYl9UvhUUr0piKl6qRCiOusFdPDQT
 pUNklrNofIiUSOr3BkoEv0N31enqS30KqAVydH5unduRNnL/jOkzhlfE7JPYr0+g6gIf
 4wUWWOs9lrXleU0ORjI9s1VBw8QpyAwiOHyyxjYR2Jd7YXuk4SFbeJYADHmxFahRg2Rn
 RTS1R4o3j7C9sGyT7kf4PrexMOw9HfMbGuwmeKNjp5OpBrBcFlSrhLVRfMyQpQtFDqAB
 SyDYdDx6y4SKOwh+xGWHCaVqxQzYlhE3k/W3zAnmnua0Lgv0vDvo5fd22TaJXse1s2fi
 cjLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmAD9WK0DYx03TOviYcEb6Ja46Ya8o0km0HHIg3p+FmzF577jja0qa+S2/QFU3vzSE42ujDl7xkx7uUFJZWog8wjTG+A==
X-Gm-Message-State: AOJu0YwToGNs/NYvh0K6FoQqXdeD9iOD8xGHfppTDbilam4QhaBTRmmg
 Bg57r0Gc64uMrNzAHEASVVjEVPb/XkcMrPnTfmnVweYjOck7VrMfXGx8GYoO2Zc=
X-Google-Smtp-Source: AGHT+IFlB0vOjEfCx5kRt8SJ/37Z+wS0tL7za9Ud6HNJBkgHoefMj7HoleyK0lppCUSm8mbiQS4N/w==
X-Received: by 2002:a17:906:4ed6:b0:a59:af85:17ed with SMTP id
 a640c23a62f3a-a59fa94ba04mr206395566b.28.1715171575015; 
 Wed, 08 May 2024 05:32:55 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 hg12-20020a1709072ccc00b00a59b6eed3c4sm4714792ejc.45.2024.05.08.05.32.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:32:54 -0700 (PDT)
Message-ID: <5c7d9e63-5587-4746-aa1b-090c8a60703b@linaro.org>
Date: Wed, 8 May 2024 14:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom_defconfig: enable msm8916 and msm8996
To: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240507-qcom-defconfig-msm8916-v1-1-6d6914bfc00f@samcday.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240507-qcom-defconfig-msm8916-v1-1-6d6914bfc00f@samcday.com>
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

Hi Sam,

On 07/05/2024 20:46, Sam Day wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Enable the clock/pinctrl drivers for these two SoCs. Previously left out
> due to only being used on the db410c and db820c respectively which both
> have their own board code. We can still boot these with most features
> working without that board code.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> I nabbed this commit from one of Caleb's work trees. Along with the
> carveout patch I just sent, this gets U-Boot to successfully boot when
> chained from lk2nd on msm8916 devices supported by that bootloader.

Thanks, it's nice to have this in, even if USB doesn't work.
> 
> A similar plea on this patch as with the "mach-snapdragon: do carveouts
> for qcs404 only" patch: if we could scrape these changes into the
> 2024.07 release that would be positively sublime.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   configs/qcom_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 80ad3b32e1..c438aeef8e 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -37,6 +37,8 @@ CONFIG_OF_LIVE=y
>   CONFIG_OF_BOARD_SETUP=y
>   CONFIG_BUTTON_QCOM_PMIC=y
>   CONFIG_CLK=y
> +CONFIG_CLK_QCOM_APQ8016=y
> +CONFIG_CLK_QCOM_APQ8096=y
>   CONFIG_CLK_QCOM_QCM2290=y
>   CONFIG_CLK_QCOM_QCS404=y
>   CONFIG_CLK_QCOM_SDM845=y
> @@ -73,6 +75,8 @@ CONFIG_PHY_QCOM_QUSB2=y
>   CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
>   CONFIG_PHY_QCOM_SNPS_EUSB2=y
>   CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_QCOM_APQ8016=y
> +CONFIG_PINCTRL_QCOM_APQ8096=y
>   CONFIG_PINCTRL_QCOM_QCM2290=y
>   CONFIG_PINCTRL_QCOM_QCS404=y
>   CONFIG_PINCTRL_QCOM_SDM845=y
> 
> ---
> base-commit: 1c40dda60f5f7e83a6d6f541cf5a57eb7e8ec43c
> change-id: 20240507-qcom-defconfig-msm8916-61c8437a0b2e
> 
> Best regards,

-- 
// Caleb (they/them)
