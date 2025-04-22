Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CA9C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 17:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA79819D2;
	Tue, 22 Apr 2025 19:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TE75Yh+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E138144A; Tue, 22 Apr 2025 14:50:52 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634F381273
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so4082943f8f.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745326249; x=1745931049; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ywvl/zpWHA2GuZ+A8kveVJK7mf7P6xnYWVsR/bwoR7Q=;
 b=TE75Yh+YSRFuPynPFqsyVw5MBE1gTSz+oZxuBhPVGU+KGjGxA1iRNmtQSb9CB8uJdJ
 CET6mlTi4/iREOEOyyQJYIVTCeX2lbz6XY4hLnAM1PYIObVtCP3RAsPuxmYHIq9X/3Ai
 onZAOIwXLFmWXt3yBh3mXGKMFxkPoF3C5tsk1jFZ1iGzC2mSZ825c3qWZSn6x5hLTGSx
 1Sgz4M3uOAmd/fKt621lUk2xdlsk2YATQpvs0uQA1GaNu9XTDKVJUPnTCNvJprUm5Rpu
 RXferXW+YHdAa9+iFLcsP4xOt0lfKxVb+iRcww0tADe8+ejiiWCldsgj99o2Akq754z1
 SFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745326249; x=1745931049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ywvl/zpWHA2GuZ+A8kveVJK7mf7P6xnYWVsR/bwoR7Q=;
 b=RXCrktmUAQefa3Ky7+HN1VtuZnTE9fa3Tldoz3FRDOTMV2JRfB6w+BuebGTM18ANBw
 KPI+OGs1gSroQOkGiLFHrTMkSd3od8uwISeJtoUqMqx8qR/0f7bGNWzUG/G0pAvuGzH0
 VyOgesBZEtrPBfO/YNg9VF6qhk5yvxy32hAh6J2r+ImyF+90AymlDAHY1zIqdlacBklc
 JSyYdW/m3iC+OvYM4yjntnlrRIzJQrDhHY/q3oD75NcpPIu2Or3HWzNI1wPJeWImsROJ
 C0XG3gVe7s/rmxPnef5QAQ5rY4auwc5cOb75oUcBM1p4roBLWK5zMMwbn/ajpQFEALL1
 1M9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8vDWIQmqkRE/MfBXI2PUWG9gWzinTFSIIwa0hl1ZpHefj89VKrw557lKf2dXae97nEpYW5EE=@lists.denx.de
X-Gm-Message-State: AOJu0YzbHZK2AohotLUfYsZGuNK/yg7FdofQuzNRe1mssoqi1tlLg+iN
 dl0S5nuXF5onC/D22yTgY2ekCdWtJ1uBPmURb8f34EOOJox6HWGqc3HSxfySiMM=
X-Gm-Gg: ASbGnctRhoprdWIYR2ljdkaZaeelAXPj05a4qscnAIx/cr5fisO/S6WBXuTen1GAiKd
 O7t5FnZCfuEShKNjOmQKQxC3bcaZFlPOmgBv8tbn7YM2HPHllHeCZGjo88SERL+2scvzLzJ3yHv
 8lbb+axmn1Mt6Ka39Qc6LVfDt95tlFaLrJx/mx7WdnC+blFpFSJSIzXxGT7SZH1/lSa1M8g39qF
 wyMFEe9InBIQIcQekr/dbdf/yKKzkcJWIT97Yjbci/le4BmKrZtKzGrgYxy7zibwYxyh1GtLHOU
 7UbxWqNy7AwptdM2hWJRK7ffDX3H+A9P9EKHpFMj0T6nHM8tGstP1/cq6NCYpmEg8v+Y750=
X-Google-Smtp-Source: AGHT+IHw5gUpTnhA4UmmRIPPMchLjRCIKE1zO75fw++UPpG4sMbAG0MKU4bwMwR+DpleBZbgnL9RIQ==
X-Received: by 2002:a05:6000:470c:b0:39c:1257:cc26 with SMTP id
 ffacd0b85a97d-39efbb0a9dcmr11658774f8f.57.1745326249477; 
 Tue, 22 Apr 2025 05:50:49 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A78.versanet.de. [94.134.58.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43cb43sm15361478f8f.53.2025.04.22.05.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 05:50:48 -0700 (PDT)
Message-ID: <9eb12f16-2af5-49eb-bd09-c809c0debf59@linaro.org>
Date: Tue, 22 Apr 2025 14:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] watchdog: qcom: improve driver with more
 functionality
To: Paul Sajna <hello@paulsajna.com>, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com>
 <20250421-b4-qcom-wdt-v2-2-b2250efa0f39@paulsajna.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250421-b4-qcom-wdt-v2-2-b2250efa0f39@paulsajna.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Apr 2025 19:29:01 +0200
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

Hi Paul,

Please squash this patch into the first one, otherwise this looks good. 
Did you test start/stop/reset?

Kind regards,

On 4/22/25 01:20, Paul Sajna wrote:
> - add the ability to start the watchdog
> - add the ability to reset the watchdog
> - remove the automatic disable in the probe function
> - use log macros for errors
> 
> Signed-off-by: Paul Sajna <hello@paulsajna.com>
> ---
>   drivers/watchdog/qcom-wdt.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index a7ce31ef811c717fd16700aa7d984a000763a93e..88e5fc7906825ac258393495682a75a5010473b0 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -4,12 +4,14 @@
>    * Copyright (c) Linaro Ltd. 2024
>    *
>    * Authors:
> - *   Caleb Connolly <caleb.connolly@linaro.org>
> + *   Casey Connolly <casey.connolly@linaro.org>
> + *   Paul Sajna <hello@paulsajna.com>
>    *
>    * Derived from linux/drivers/watchdog/qcom-wdt.c
>    */
>   
>   #include <dm.h>
> +#include <dm/device_compat.h>
>   #include <wdt.h>
>   
>   #include <asm/io.h>
> @@ -50,7 +52,16 @@ static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
>   
>   int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   {
> -	/* unimplemented */
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +
> +	writel(0, wdt_addr(wdt, WDT_EN));
> +	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(1, wdt_addr(wdt, WDT_EN));
> +	writel(1, wdt_addr(wdt, WDT_EN));
> +	if (readl(wdt_addr(wdt, WDT_EN)) != 1) {
> +		dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
> +		return -EIO;
> +	}
>   	return 0;
>   }
>   
> @@ -60,29 +71,36 @@ int qcom_wdt_stop(struct udevice *dev)
>   
>   	writel(0, wdt_addr(wdt, WDT_EN));
>   	if (readl(wdt_addr(wdt, WDT_EN))) {
> -		printf("Failed to disable Qualcomm watchdog!\n");
> +		dev_err(dev, "Failed to disable Qualcomm watchdog!\n");
>   		return -EIO;
>   	}
>   
>   	return 0;
>   }
>   
> +int qcom_wdt_reset(struct udevice *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_priv(dev);
> +
> +	writel(1, wdt_addr(wdt, WDT_RST));
> +	return 0;
> +}
> +
>   static int qcom_wdt_probe(struct udevice *dev)
>   {
>   	struct qcom_wdt *wdt = dev_get_priv(dev);
>   	struct qcom_wdt_match_data *data = (void *)dev_get_driver_data(dev);
> -	int ret;
>   
>   	wdt->base = dev_read_addr_ptr(dev);
>   	wdt->layout = data->offset;
>   
> -	ret = qcom_wdt_stop(dev);
> -
> -	return ret;
> +	return 0;
>   }
>   
>   static const struct wdt_ops qcom_wdt_ops = {
> +	.start = qcom_wdt_start,
>   	.stop = qcom_wdt_stop,
> +	.reset = qcom_wdt_reset,
>   };
>   
>   static const struct udevice_id qcom_wdt_ids[] = {
> 

-- 
Casey (she/they)

