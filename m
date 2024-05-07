Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D89C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 07:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FF088735;
	Tue,  7 May 2024 09:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H3KUIsBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497FA8872B; Tue,  7 May 2024 09:40:35 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5434C87B35
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 09:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a59a5f81af4so711588866b.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715067633; x=1715672433; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TGuz0c5KAUQAcAfTZk5tNAW1++3/cM8R38t7+nVmD1M=;
 b=H3KUIsBgnqRNLCmC5pXF1N0Oxjkkn3rxQjzJIi+i5GWz39H+UhmRGbUuIkHcuK01jv
 pksf5Z6vLopGl4y8gl8ZS1ROE4bOjJbSea4cmUGDU9VOmQLTGsTZr50fX/aYKxPAmPOK
 gciLQ+sUqw5KB7gMUNAoxeYWz/liGc17xqxpNGG9Nn0Xky5LPuLQTtT3GNlVxhOTmt/v
 d+vm4a84CCzH21woMRAosEIQ3XCTU8LH75vxWpdqboPCLXNRBTkxorUqLA/1xR8VfHKW
 FTeVbodDeq6BTntoluXzKwEpdDRlKETNYfrZe6kE4FE20NDVLM0/o78C+pbqCH4PG0OP
 C7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715067633; x=1715672433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGuz0c5KAUQAcAfTZk5tNAW1++3/cM8R38t7+nVmD1M=;
 b=Y7LK1BIQnpirY5WTs6l3cusPnvydtcIRfb/6LHWNEGdrKl/Sx8h0T/IGja1jqJR5u8
 HEj0zmGrId7PI1R7JkHxz9WokcnAUNX/f8m0xW/CqbX/vW9d4xcFiND09v278cih9Vvn
 MGB3C/QeCI+ApsuI+d723LqqF+k6OtXS4U+JTR7P43i1OBk3/xfJKxjYV8ReGbD9lrI3
 XwL7cityO+ggp3LxxBRsLj3vHu/T8v0lFjzHpLhNf4J0suFFq8uv9QSQgj5g5QqaNWNr
 Ur7jjQW7nK//BirSjJNoqFo4tysTiEMq46cYpcAc1xcnTbyctgxjcF4L12v5MhDeuzL6
 yZng==
X-Gm-Message-State: AOJu0YzhUTgvkpQRfJv86neinoEDoaD6h2/rK+egwo+6x3pv8StK6jDK
 DFc67JBUPuPnoO2kw9GPSXsWOuN3o8VI9wp1uMNteuKyB6hjxgjekXo+7Rl4IoqDzaJF49zDSIu
 PCo+78cmGgy2igsDqayuGmhULpY/iGjlj75x+oQ==
X-Google-Smtp-Source: AGHT+IGG7YtuTbDGtxz4o2EKW/7geyIXKLWjeTxhI1TykxadTrU9FfhDU4QX7LFiCrv+z8ENNqceenBOP/0m1B/WClM=
X-Received: by 2002:a17:906:7856:b0:a58:fc3b:8c6e with SMTP id
 p22-20020a170906785600b00a58fc3b8c6emr7900293ejm.69.1715067632832; Tue, 07
 May 2024 00:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-32-trini@konsulko.com>
In-Reply-To: <20240502013138.2383421-32-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 May 2024 10:39:56 +0300
Message-ID: <CAC_iWjJqFa8=p1PsCzpRMO9uV3oLNC9MMk3y_LJNYoNfVQDP+w@mail.gmail.com>
Subject: Re: [PATCH 32/81] fwu-mdata: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jassi Brar <jaswinder.singh@linaro.org>, 
 Etienne Carriere <etienne.carriere@linaro.org>
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

On Thu, 2 May 2024 at 04:32, Tom Rini <trini@konsulko.com> wrote:
>
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/fwu-mdata/fwu-mdata-uclass.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/fwu-mdata/fwu-mdata-uclass.c b/drivers/fwu-mdata/fwu-mdata-uclass.c
> index 0a8edaaa418f..bab7a7e80d1d 100644
> --- a/drivers/fwu-mdata/fwu-mdata-uclass.c
> +++ b/drivers/fwu-mdata/fwu-mdata-uclass.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY UCLASS_FWU_MDATA
>
> -#include <common.h>
>  #include <dm.h>
>  #include <efi_loader.h>
>  #include <fwu.h>
> --
> 2.34.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
