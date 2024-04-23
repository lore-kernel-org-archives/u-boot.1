Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823A2C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B1088495;
	Tue, 23 Apr 2024 13:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ew+Il+HG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72E0388530; Tue, 23 Apr 2024 13:59:06 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AAD988442
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-571c22d9de4so7408916a12.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713873542; x=1714478342; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HJRAK/2HQ8NKFiST9MXl4ZaNcGIwg261MA8COCK6xMA=;
 b=ew+Il+HGxKlG/FbPN/9o/Qrf2SXo10HzippQefQdPvLOktoDvckN+pq0TM6JRjIy0l
 aIhoGITBgCQoZefDu9s9HWXZ+AJEZd16VocktLpcV0wSNonfy2QikAh2csAPm7Q1X68t
 CAL4ist9B8SexxLzt9PH0ofK1/b6cQK0rcnJgrUID/0YXmbl/563Tv5AekyhhlKGzauI
 58bECxGcs+o0rwPqCihFtV2KGcZBKwquBISbVbsF2KIMCB7q3rlkGePAqcKtfMIZd5PD
 uW39ZlmNwDL/ctH7nb7DRH99Qm7A/G1fHOWSV9y/tCV0cUiTkPdD3ksW8GKncjBctsaE
 oXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713873542; x=1714478342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HJRAK/2HQ8NKFiST9MXl4ZaNcGIwg261MA8COCK6xMA=;
 b=gZQDqVA6bWFLaxtohy9itGM2juE7ULO6pLbiVtsC7dYXnR0DevElaSxPV3PWW2dixx
 ucY1g/EI9fuquEaGU4urMn8faoaDCEHRVl/vHqzcWUf3g9OBZwCwMsPwrHzFi92U2wuJ
 IJ4SA/cVBY+fD6zjIdftkrY4VLc0EaJQe/d9LcvQOJ/c3/ujNSuQwP9z61+YDyT69bpi
 +Gr8hu25QmRYGFtxwkpoudR01lj3PKQgPbId0DkkrsACWwhnskAKerPbnbUngJNIbpFh
 dHrHExqjWDLMBAbILFm1VvCssWS26F8UuVizALW3CI62nJOGbYzRJO44/OGLJ8v1C931
 LLpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh0q+mygmX9478tlq5EiZimVZwWKOJIpAUbgL9QoAIvGkrro7si2x+d8kHep0cquUhVwedU14lPBvYybky6Poclc3qbg==
X-Gm-Message-State: AOJu0YxGzf722gLHXISBoK+DajVnBf2LFeEsKe+VMpp5niIbODTuXqco
 hj98c0TmsaDzf0xILt+BkHz/bD/jFj5bi5syffy5vDSNVs1ssTlEXfGGgtpIYJJbV/OaUC7ydnT
 EkzQ=
X-Google-Smtp-Source: AGHT+IEFKrAS0zBCoa6xVTyL68kaGPqLZopr+146z0LKi2KZIDUeELkWUvH7ZDoAZl4GIBHCpVpNhA==
X-Received: by 2002:a50:8e5c:0:b0:56f:e71b:74e3 with SMTP id
 28-20020a508e5c000000b0056fe71b74e3mr8401116edx.39.1713873541810; 
 Tue, 23 Apr 2024 04:59:01 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::1795? ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a056402175500b0056e7ba0497dsm6593200edx.28.2024.04.23.04.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 04:59:01 -0700 (PDT)
Message-ID: <99a5b32b-7be8-4a8b-a522-cc75dd92055d@linaro.org>
Date: Tue, 23 Apr 2024 13:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Add SE HMBSC board support
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org, stephan@gerhold.net
References: <20240412095438.410570-1-sumit.garg@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240412095438.410570-1-sumit.garg@linaro.org>
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

Applied, thanks.

(b4 didn't seem to detect this series properly, hence the manual mail).

On 12/04/2024 11:54, Sumit Garg wrote:
> SE HMIBSC board is based on Qcom APQ8016 SoC. One of the major
> difference from db410c is serial port where HMIBSC board uses UART1 as
> the debug console with an RS232 port, patch #2 - #5 adds corresponding
> driver support.
> 
> Patch #6 adds main HMIBSC board specific bits, features:
> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> - 2GiB RAM
> - 64GiB eMMC, SD slot
> - WiFi and Bluetooth
> - 2x Host, 1x Device USB port
> - HDMI
> - Discrete TPM2 chip over SPI
> 
> Features enabled in U-Boot:
> - RAUC updates (refer [2] for more details)
> - Environment protection
> - USB based ethernet adaptors
> 
> Feedback is very much welcome.
> 
> Changes in v4:
> - Rebased on top of qcom-main [4].
> - Split out board DTS patch as #6.
> - Convert to text based environment as hmibsc.env.
> - MMC regression has been reported for qcom-main branch here [5].
> - Collected further review tag.
> 
> Changes in v3:
> - Rebased on top of qcom-next [1].
> - Collected some review tags.
> - Incorporated misc. comments from Caleb and Stephen.
> - Split patch#4 as requested.
> - Linux HMIBSC board DTS has already been reviewed here [3], I have
>    incorporated that for U-Boot too.
> 
> Changes in v2:
> - Rebased on top on qcom-next [1].
> - Added patch#1 as a fix for generic qcom board support.
> - Added patch#4 to enable driving GPIO pins based on pinctrl
>    configuration. This replaces the custom GPIO configuration.
> - Added proper DTS file for HMIBSC board based on Linux DT pattern.
> - Merged board support patches into a single patch#5.
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-next?ref_type=heads
> [2] https://rauc.readthedocs.io/en/latest/
> [3] https://lore.kernel.org/linux-kernel/20240403043416.3800259-4-sumit.garg@linaro.org/
> [4] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-main/?ref_type=heads
> [5] https://lore.kernel.org/all/CAFA6WYO+3VroUdFUVH390taViQX8pMQrOQDTSn0yU6BD5YY53A@mail.gmail.com/
> 
> Sumit Garg (7):
>    qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
>    apq8016: Add support for UART1 clocks and pinmux
>    serial_msm: Enable RS232 flow control
>    pinctrl: qcom: Add support for driving GPIO pins output
>    pinctrl: qcom: apq8016: Add GPIO pinctrl function
>    arm: dts: qcom: Add Schneider HMIBSC board dts
>    board: add support for Schneider HMIBSC board
> 
>   arch/arm/Kconfig                          |   2 +-
>   arch/arm/dts/apq8016-schneider-hmibsc.dts | 491 ++++++++++++++++++++++
>   board/schneider/hmibsc/MAINTAINERS        |   6 +
>   board/schneider/hmibsc/hmibsc.env         |  40 ++
>   configs/hmibsc_defconfig                  |  87 ++++
>   doc/board/index.rst                       |   1 +
>   doc/board/schneider/hmibsc.rst            |  45 ++
>   doc/board/schneider/index.rst             |   9 +
>   drivers/clk/qcom/clock-apq8016.c          |  38 +-
>   drivers/pinctrl/qcom/pinctrl-apq8016.c    |   2 +
>   drivers/pinctrl/qcom/pinctrl-qcom.c       |  25 +-
>   drivers/serial/serial_msm.c               |  24 +-
>   include/configs/hmibsc.h                  |  16 +
>   13 files changed, 760 insertions(+), 26 deletions(-)
>   create mode 100644 arch/arm/dts/apq8016-schneider-hmibsc.dts
>   create mode 100644 board/schneider/hmibsc/MAINTAINERS
>   create mode 100644 board/schneider/hmibsc/hmibsc.env
>   create mode 100644 configs/hmibsc_defconfig
>   create mode 100644 doc/board/schneider/hmibsc.rst
>   create mode 100644 doc/board/schneider/index.rst
>   create mode 100644 include/configs/hmibsc.h
> 

-- 
// Caleb (they/them)
