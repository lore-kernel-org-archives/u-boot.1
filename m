Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C7CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7AC88206;
	Mon, 15 Apr 2024 14:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KeMKnRPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54EDF8813C; Mon, 15 Apr 2024 08:56:35 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A2F874B1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d6c9678cbdso35233201fa.2
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713164192; x=1713768992; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FnKb+HvlP1OzJPo2BGXQXTya5MibbkvTdicvhjh9GfM=;
 b=KeMKnRPdB2Nw4ztcxCt3QNQ6qUpTpDYvMEUzceg95/CeAxdn16QlCFn5xGft7CzUT8
 /Nzv7fV1m+Wj2qRwuUwI4vDWAM5KAZBnqL2SjZn5pS5EWauN8AKrMQ/b2bdwRU88hPA5
 cqVuXXVEg8nN1capsYxC//5qnxdCFGxQSL4t3216unDTSw0W4S1A91ZyBi4BywmAKKco
 s7aV/i5uqFnTtBmItqdUvOhRBRf7jkcIXulo8gzAIxlxGrzCmACl+VWjZah2Ds6uuzZZ
 GZVxCCqzMlF/oTy6OUY2dmdUJwe0DkTovUGD60oJ/RJZP9ZwBZMozCEt1rmWUGsTCpgv
 op7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713164192; x=1713768992;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FnKb+HvlP1OzJPo2BGXQXTya5MibbkvTdicvhjh9GfM=;
 b=IMlRyQgutaEgZFKb2PaU208ZAwzHqJh06anhlm/c8yKqV6DMul8nWt8SjtCn5TK6Ok
 rLBVw4eIJz7I46DDVRkn9YI5qjIRcr+wbtkXSJsN+aDfAUgFyiFXCQ8GXPD/ziXUPyjc
 X8qhTfBYrCGMXtnYcSxeuF7X95f/wJoFh1akw+WKrdXeA86q2Uc4d6noBXtzieGOrx9X
 Ujbb+olrOy89H0PTzH+XyuD3O3kfIRvSsLf6INiK36VUmxhpWZq8fFfo6WOTXCohm0mq
 cBJrC70qQ60yigH5kFSez9yAZGM/G50kDBIiRSAoNh8YoD4TBzggWx47I6gPKwFDxelx
 eDKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdQI7rMoRzcqILT0d5srBkPbEICyepbALFFKwqFtkpoD4RDJDUuFFy0cKJpyTeXr2+jL9oJ0MnR4AwmDHFBoYPi8yIxg==
X-Gm-Message-State: AOJu0YyWYE21YD0ra+sVFojXHBBctBqrLw5aruLNGkuGnnEnPvVHravh
 3DkG2J0CWrH1zQG7BDx7v516L4ipdTosPF19NnRpHu2koumBoSHvwYe5e0ZnWQg=
X-Google-Smtp-Source: AGHT+IF9LoM2HQ8YQbVEL6MAjY5vMzbTOfDzmqwso4mGNH0k6mL3ru4rONMeTrFm7EFwQGl7e18bYQ==
X-Received: by 2002:a2e:84c4:0:b0:2da:8b96:7470 with SMTP id
 q4-20020a2e84c4000000b002da8b967470mr492971ljh.33.1713164191861; 
 Sun, 14 Apr 2024 23:56:31 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
 by smtp.gmail.com with ESMTPSA id
 jh4-20020a05600ca08400b004147db8a91asm17816474wmb.40.2024.04.14.23.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 23:56:31 -0700 (PDT)
Message-ID: <a2e2d0ea-3a4c-4425-a28b-5422cf9f342a@linaro.org>
Date: Mon, 15 Apr 2024 07:56:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 15 Apr 2024 14:14:08 +0200
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



On 4/15/24 05:33, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> This series is equivalent to the one for Linux MTD submitted by
> Pratyush Yadav.
> 
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=217759&state=*

Ah, I see you specified it here. I'd argue it's better to mention it in
the commit message itself, it spares people searching on the ml archive.
> 
> Takahiro Kuwano (4):
>   mtd: ubi: Do not zero out EC and VID on ECC-ed NOR flashes
>   mtd: spi-nor: Allow flashes to specify MTD writesize
>   mtd: spi-nor-core: Rework default_init() to take flash_parameter
>   mtd: spi-nor: Set ECC unit size to MTD writesize in Infineon SEMPER
>     flashes
> 
>  drivers/mtd/spi/spi-nor-core.c | 45 +++++++++++++++++++++++++---------
>  drivers/mtd/ubi/build.c        |  4 +--
>  drivers/mtd/ubi/io.c           |  9 ++++++-
>  include/linux/mtd/spi-nor.h    |  1 +
>  4 files changed, 44 insertions(+), 15 deletions(-)
> 
