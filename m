Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B229C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56483870C1;
	Wed,  1 Nov 2023 19:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RehHEBaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB9686F92; Wed,  1 Nov 2023 19:56:36 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E737487D9A
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cbf8e1f77so275171cf.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698864986; x=1699469786; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2PExnxbJt1KmiDYohnvzb1Zj6swkai8Xx5cf4d3goYU=;
 b=RehHEBaUCDSfwDz+Xw5NT/WfXByKZbELjAKi5T2uxlbEM78RhEzzowLMyUlUXFG6wv
 jsg8QZCE+3GurWy/0t48q7qxJ9sBAYwiY3e+JXpLKwWwZZn6mps0kJkIuqC0dhwWNrju
 oqGihvcagPYhHaM1uEhu4DTVpIFB2fjUMDGb6bDkv0z7STOSQcZ/W8VJusNAwGLbX3AK
 n97JM+3qfYW1KlUxRTx8yimp3VKV9qOTqNvnAe6iLIRafR5ki9WtaUDOFfvXWcgqoAW0
 WaBCVOYqxnRs6UgyjhB6Pe9MPIghOkS1DDkbuRTAwnGxsjBwb8QUYU3w2BhH9U+gRpbR
 L2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698864986; x=1699469786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2PExnxbJt1KmiDYohnvzb1Zj6swkai8Xx5cf4d3goYU=;
 b=hAj4j5tK/zKRwi/2NH7++kdB65K9NuTTpaxIjjn8GFXMfZMmkxkuUzcAxBCaYNV6sk
 phEpW6XrWsYxx1qLCtDVCvLK3n9shw10NDAQSlh0vFAizIg32ZyGDW8Begs3tbisGjUq
 kxMLkfM4KIZU7TgIrN7odatqriP9CHZau6nX60LWDvCCdvfmFE4E1rIB50dvdn65cIzJ
 HbfroXFQB9YdHFYDe68eqOPtaEbbLw69xfyD0HJaZPj+xG8mXktFDEEUldR69ldcROeM
 yTCZ98erIo0YKrwudebHrzABbUV8kkwOKezyT1/gqERNvb59XAsWbuBNqi3c+vB5Pur4
 9eeQ==
X-Gm-Message-State: AOJu0YyANPbm7geQPsj22M38bXVApFyaL151k8ex1Z5g+RhrAoZz4zlL
 PrvkZ3gRZm+QIKMMyKX005E=
X-Google-Smtp-Source: AGHT+IGaELWcUolQ2c4PCkgaI+NA0stVd9NujZWANZpi8GdEVQ7f1paJIeY4bO6hq8CuPjiHzO0KTw==
X-Received: by 2002:a05:622a:1007:b0:40d:b839:b5ac with SMTP id
 d7-20020a05622a100700b0040db839b5acmr16181813qte.15.1698864986647; 
 Wed, 01 Nov 2023 11:56:26 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 fv14-20020a05622a4a0e00b00419b094537esm1648443qtb.59.2023.11.01.11.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:56:26 -0700 (PDT)
Message-ID: <72e8f58d-28bc-81eb-d299-eb9579984a7d@gmail.com>
Date: Wed, 1 Nov 2023 14:56:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/7] clk/qcom: move from mach-snapdragon
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
 <20231024-b4-qcom-clk-v2-1-6572bc2be690@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231024-b4-qcom-clk-v2-1-6572bc2be690@linaro.org>
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

On 10/30/23 18:23, Caleb Connolly wrote:
> Clock drivers don't belong here, move them to the right place and
> declutter mach-snapdragon a bit.
> 
> To de-couple these drivers from specific "target" platforms, add
> additional config options to enable each clock driver gated behind a
> common CLK_QCOM option and enable them by default for the respective
> targets. This will make future work easier as we move towards a generic
> Qualcomm target.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/Kconfig                   |  4 ++
>   arch/arm/mach-snapdragon/Makefile                  |  5 ---
>   drivers/clk/Kconfig                                |  1 +
>   drivers/clk/Makefile                               |  1 +
>   drivers/clk/qcom/Kconfig                           | 44 ++++++++++++++++++++++
>   drivers/clk/qcom/Makefile                          |  9 +++++
>   .../clk/qcom}/clock-apq8016.c                      |  2 +-
>   .../clk/qcom}/clock-apq8096.c                      |  3 +-
>   .../clk/qcom/clock-qcom.c                          |  2 +-
>   .../clk/qcom/clock-qcom.h                          |  0
>   .../clk/qcom}/clock-qcs404.c                       |  2 +-
>   .../clk/qcom}/clock-sdm845.c                       |  2 +-
>   12 files changed, 65 insertions(+), 10 deletions(-)

Please update MAINTAINERS as well.

--Sean
