Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DED1D6ACF1
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7677A83D00;
	Thu, 18 Dec 2025 13:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CqiQWLb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5310383D71; Thu, 18 Dec 2025 12:23:59 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED7183D00
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so5414265e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 03:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766057036; x=1766661836; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3+b6x9ITlZKpK5T09VnjugF+rK1FzUiwJa2xyqP+t5Q=;
 b=CqiQWLb6tZ1w5kewtrRaU4c+8mcs39sW5E15c3C/8kXIQHWLg38NRUr2rAqjgb08Ec
 pTYPOxriPw8am1fSZx1DVkPKAHy1RtP+nYkovbCXO1HE0iyyYo75L38+PL2S4Nv6RWdX
 ZNMposawvGueUZA7STeYbHvwCm4OvxvqfE4QwpZfUomNpCxrcxv2kS3MvNweoPam6H8T
 UOYTz0FgrQwgDXWIfTAu9b6VlRoMFEAcgmZ+NeSZuTnrNiy8r6WPe/fgB+sNwEU19mLK
 ubTLeZCQC8n2hAFetyftueCaYQxC6wrWyaTP+9u5oh7yVTqdzIokLxIqlGyUFUqZvunC
 6QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766057036; x=1766661836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+b6x9ITlZKpK5T09VnjugF+rK1FzUiwJa2xyqP+t5Q=;
 b=S6wRKRKmBL841LLZlLN0w9xGc+cbegzrsNmTmi0XK3bPy0dfmr4x+U21jzH/BAXTEU
 4o/WOB4sjmCGLKkABtO0wCwaAkYVgcOXnsc+mTXmXATDv32VHnk8OTWz7xMRqclrg3f9
 lfGjuJ0hFAXpQfnaMea4RKI+1RHhsMmLTNJGISFFlKLE99iaO9tIVJnKYWw1nifYWKRy
 /Xihu7UluGnl9bLugAQqA3N7kaTPtLWxilRyvNsgXQHjtbrIaJkWC4wajXhzpOM60ANW
 aemiZD6iLL4CLPIluKr8UMyDpBNu4csU8NQTpqKv44DIJSqaHMCZxeZdP1NuM8Y+CGd0
 JFdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXHEllhNOA1m43kCbXVvup5Te1vjY5mRMFnSFqxbHDg0WadznYPRKSOkZR5BEpNsOO4IURrn8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/VA0z/z6PflMnvr278QXbrw87RaVcmnyD0cQX9YV58WLeuGeY
 ngxtdBp3+sNz1qHLG9JiVFl5CXiLBo+PKjQ6gZ98cPHtmkdWeAVvUVHeybaiG1KsQpM=
X-Gm-Gg: AY/fxX5feLnn15Wr6Mn3qx4B5X6pR31jW9ICHYh0zdVamj9gG92kIsWLHvxNUfruc/T
 ZkIdf4878eFvDKuBZl+LUKPaXsmSkUWE+bg7HS+zh9YavmOtBr2oF8RVa6ou6G6q7KcZkP9uIl4
 jkKvqW6jgObeS60bUDkK+ovX808Bt+5J1lpDSPuEtepjpykzcW4JBVeSNb4SqRB83aGWkgY2O4O
 3nww8UMrbXFboRx2x7xGtQcyj1oWQ8X8+mHA5jHltnUY387eFI3oifv56c4kVCEEaodH/SaGkmW
 NqKkNcXR0o7GWWvaz8zFcIKq+CN7eYaGuYV7588wmxT05ifYjkkNdVm6utC/xEU8vT+bcNZcmT8
 pdP0txpMRXEziHMaUa+MCJGwlSGsi5W5VzD8KBNJygH6RbKWyQH0a4FzfmwpbFg1VnG73MwCpZg
 KBzJKjvAY/dUiS8psghBX/LY3/g7nJMGqQwXu0/6ZYlV/lg3PgMKM8i7eSDKu+Rww=
X-Google-Smtp-Source: AGHT+IFjo2TMquSCzEpz+OqOXSxwWxwtRTmZ1iYCzcbZl5rF1c8ZM9oYE2XqRMWDMMIiyO6RiOPuLQ==
X-Received: by 2002:a05:600c:828f:b0:46e:7e22:ff6a with SMTP id
 5b1f17b1804b1-47a8f8d3010mr247560025e9.15.1766057036311; 
 Thu, 18 Dec 2025 03:23:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:e23:4251:1cd1:b5c0?
 ([2a01:e0a:3cb:7bb0:e23:4251:1cd1:b5c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be26a81b6sm39381215e9.0.2025.12.18.03.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 03:23:56 -0800 (PST)
Message-ID: <58e56eda-d51f-44c0-b435-b07c4afa230a@linaro.org>
Date: Thu, 18 Dec 2025 12:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: bdinfo: fix incorrect Kconfig options check for
 print_eth()
To: Quentin Schulz <foss+uboot@0leil.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251218-bdinfo-lwip-v2-1-f6188a2f376a@cherry.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251218-bdinfo-lwip-v2-1-f6188a2f376a@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:14:13 +0100
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


On 12/18/25 11:59, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> CMD_NET_LWIP has never existed so it cannot be right. I'm guessing the
> intent was to allow print_eth() to be called when NET_LWIP is defined
> (NET means "legacy networking stack" as opposed to NET_LWIP which is the
>  newest (and incompatible) stack). There probably was some mix-up
> between CMD_NET and NET options.
> 
> The dependency on CMD_NET seems unnecessary as it seems perfectly fine
> to run bdinfo without CMD_NET (build and run tested). So let's instead
> make the dependency on NET || NET_LWIP.
> 
> Let's sync the unit test as well.
> 
> Fixes: 95744d2527cb ("cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Changes in v2:
> - fixed unit tests for the bdinfo command,
> - Link to v1: https://patch.msgid.link/20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de
> ---
>  cmd/bdinfo.c      | 6 +++---
>  test/cmd/bdinfo.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)


Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
