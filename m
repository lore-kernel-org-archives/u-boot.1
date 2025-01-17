Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2993CC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 07:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A5FA806FB;
	Fri, 17 Jan 2025 08:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BjSlObYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991BE80713; Fri, 17 Jan 2025 08:18:18 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08DF88069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e46ac799015so2485301276.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737098295; x=1737703095; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1cb6Dtj2ViXGuVhmsEc5ytFZ3Tej6GEDVAv1ybOivk4=;
 b=BjSlObYDba1Tr0Aa1ydXdeqRP/ekIILlCoxOe5I4k2tRkj8laJOJASS7DJ2XruqJUY
 C2ACv4DZN0Q0KRnV3bQRKXzP3C/FC1pNv2UX7jDw9OgV1VKVSskpQBY800Osy0pDhiZ7
 Ig+CJpg+zR0/ljFz3o2ClWvjmj0/5VeFt/in4nwITAAdLZoiF9XWkVIGV1ElzVGD7z5A
 sJ7nLa1vUjvSfUiFH0og/LXsA+igCVUWYAsJp+tP96D7SCtk2uvEEnFD1hJ/+CjbRaYe
 SVzfoQVLQDXGVsVf6rsyaHFQemqa8n/S4AapNVApx2FecmbJBs1gtZ8wu1U4uugsUKyw
 yXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737098295; x=1737703095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1cb6Dtj2ViXGuVhmsEc5ytFZ3Tej6GEDVAv1ybOivk4=;
 b=EBgUEnoysImSd0XN/g9L+m9x9jMDKvhHDViCcXOFfpAc4v9tydNcTtYx2mGj16ZG74
 Ucl9PhFz7+EkSxDPwDTG0Vu2kVxOl+3DuIbvKpQA8rJDHeDusbNRu6pDBM0ok4VtMTiR
 FveYshMtqyFMG2+Tefsz9Kj8NrcFyxeffD2Fn4gmS3gVJMZlCvTenIfxFkPE38bpZuay
 On4hTGjHSOxg94xsdzp4Ep/+z9tgTROyMH+LWHt9CaiWuteNljsKU4+/giqVrSmt4M1K
 hgWuq89ojiHRAIA6pjav4TdoLsAWlTW5oCctfyh3OsalPCWZpQA/+jmdFDZUNjm8Khy8
 ZAFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQbNQT3Z5n6FWUInImu8SSa9TVKSafwuXPZ2XkWgdGTVG7EWZ2t8y+V8fGURIgI1W4FBkCENE=@lists.denx.de
X-Gm-Message-State: AOJu0YxyRdrxhkPbg/yhv4302g7Dfiv5GBxL363ct+XAIp067HE/moFp
 Ra/FofzKWo6fVjSB+DF4iabfFxl/i8w49pZCh1TqKZDXGVbfl2Qz3Yu2yvvYIA1tqJURVihNKf4
 p+Yqo3Uivm8diUP4Mgpg9K+u7+LD5rLt+i5yv0g==
X-Gm-Gg: ASbGncs8TqXStOjc3lufdcsAHp+tH1b8HGX3EMak2qO8qRj0sAiYeZzONMjOEaJJ3+2
 S6YS/KwnqWY2ytAcEXsZ4I9kev6mt6L/dGeH2TA==
X-Google-Smtp-Source: AGHT+IEIIU/wvDuwSx35KT+5qFpkXcifFweQVB8L1g0GQd3kqBz7pOU2qA9CYFMyyNY/4PHvSGQtq1ujwt11Du3/Ybk=
X-Received: by 2002:a05:690c:6b86:b0:6f5:3944:c726 with SMTP id
 00721157ae682-6f6eb6744f3mr11084357b3.11.1737098294889; Thu, 16 Jan 2025
 23:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20250116230130.3337-1-semen.protsenko@linaro.org>
 <20250116230130.3337-4-semen.protsenko@linaro.org>
In-Reply-To: <20250116230130.3337-4-semen.protsenko@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Jan 2025 09:17:39 +0200
X-Gm-Features: AbW1kvbYpa0rZn-y55TQjf-L6eQIKI6TTGb_kDFHupVr7HB-Mzz4czCFQPvcN90
Message-ID: <CAC_iWjL1BKUz6JzioC9aOckjGFNpTu2aZmqQS--9QkJTQKcUkw@mail.gmail.com>
Subject: Re: [PATCH 3/7] configs: e850-96: Enable more EFI features
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Sam

On Fri, 17 Jan 2025 at 01:01, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> The basic EFI support is already enabled by EFI_LOADER. Follow
> SystemReady IR recommendations [1,2] for U-Boot and enable support for
> more EFI features. That includes:
>
>   - CONFIG_CMD_BOOTEFI_SELFTEST: support for "bootefi selftest" command

I know that's on the Arm docs but not really a hard requirement. The
tests will pass without it.

>   - CONFIG_CMD_NVEDIT_EFI: support for "env -e" to explore EFI vars
>   - CONFIG_CMD_EFIDEBUG: support for "efidebug" command
>
> Also enable RTC support:
>
>   - CONFIG_EFI_SET_TIME
>   - CONFIG_CMD_RTC
>   - CONFIG_DM_RTC
>   - CONFIG_RTC_EMULATION
>
> [1] https://developer.arm.com/documentation/DUI1101/1-1/Configure-U-Boot-for-SystemReady
> [2] https://developer.arm.com/documentation/DUI1101/1-1/Test-SystemReady-IR
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  configs/e850-96_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
> index d287018ec632..1cae252175be 100644
> --- a/configs/e850-96_defconfig
> +++ b/configs/e850-96_defconfig
> @@ -14,16 +14,22 @@ CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos850-e850-96"
>  CONFIG_SYS_LOAD_ADDR=0x80000000
>  CONFIG_ENV_OFFSET_REDUND=0x10000
>  # CONFIG_PSCI_RESET is not set
> +CONFIG_EFI_SET_TIME=y
>  CONFIG_ANDROID_BOOT_IMAGE=y
>  # CONFIG_AUTOBOOT is not set
>  CONFIG_DEFAULT_FDT_FILE="exynos850-e850-96.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_BOOTEFI_SELFTEST=y
>  CONFIG_CMD_ABOOTIMG=y
> +CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_PART=y
> +CONFIG_CMD_EFIDEBUG=y
> +# CONFIG_CMD_DATE is not set
> +CONFIG_CMD_RTC=y
>  CONFIG_CMD_TIME=y
>  CONFIG_CMD_RNG=y
>  CONFIG_PARTITION_TYPE_GUID=y
> @@ -36,6 +42,8 @@ CONFIG_NO_NET=y
>  CONFIG_CLK_EXYNOS850=y
>  CONFIG_SUPPORT_EMMC_BOOT=y
>  CONFIG_MMC_DW=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_EMULATION=y
>  CONFIG_SOC_SAMSUNG=y
>  CONFIG_EXYNOS_PMU=y
>  CONFIG_EXYNOS_USI=y
> --
> 2.39.5
>

Up to you, but I'd remove CONFIG_CMD_BOOTEFI_SELFTEST
in any case
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
