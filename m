Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B029C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 07:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B4F88AF5;
	Wed,  1 May 2024 09:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FiF7qjva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A0F88AF9; Wed,  1 May 2024 09:06:31 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1329988AEF
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 09:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-47d8b5bebb1so403920137.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 00:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714547188; x=1715151988; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j/TslGLNkygg6ei1Ovj8xBUNLxuJFvBs5i7FlDzSbik=;
 b=FiF7qjvaJKMKkKydwg9M4RfEGuRlZba+1zYjXEFbKKaWTuthcJ7+Z0r+Sk3R4NKclf
 WemVRfnOwUShiWTHzZqKG3W5DpQg6vw318TnEzyPpb5ASDv9UamksUCdM4F6qAqTwQ4s
 2wliRay7h7XyV/8emfNpdYhJ7JfZuvPLzb/YInRP0yg+ohbAi6lIe2Y1s+UK3CQS5FrZ
 8WbKRM2u8WUTaFZ+CxHgSlp/tOJcAWWFNQqi0oJIK3p4a3Azsgttfd8Yn7BctdupvWs7
 jzFxrwqbSpFAt4AKTRn5lfwMldcFz8JNtX4UfJTuJ67KZqmvWMov6G7jd4zQPTT34qKw
 1AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714547188; x=1715151988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j/TslGLNkygg6ei1Ovj8xBUNLxuJFvBs5i7FlDzSbik=;
 b=ZN1rgMuFeiYGoHBAmeQ9clxpz/0GiomUnHhULKMrjNjaghXy0d4+Q/7gEHN1ApbEpN
 j60SeRHZEPB1WeHhQ8nq0CDl09jll+FaHBaLpJQmPmFAXRDmCbn6XsB8igHe5XJB0AXA
 9Rrqyh7VO+p3vwa6fwvHI28SotJkSLqKBx8rdzExrZ+BiZyGLviRTzTMXBbBMmHTQeD1
 DL/o3EGBBxRoBP3R8a25xM0U/9sn8u1DclrxXYS35eZzqlAXYxkBFCVpqq2CIEvZ5+gs
 Qr8BkUe44pRN7mS7RwPl4p0oAOqFgB2XA4hFmbVmAw/WXyHHDsNkkZf3Enjjlaqs977V
 VByw==
X-Gm-Message-State: AOJu0Yy51QlfpJcduBIlTlhC2K4iEXJvXnGLOCXO9O6b9LMJVc27CPEu
 55OtSmmnio30TstNmyf6rIz9stSNdhjBMaH/NghT5SO5RsvaqhxXParyqmeQT5XKTx/QyGTVCtr
 x8U7zWNCabK4Jl1TTlJZhO0N/DLCEl66h1J0dMA==
X-Google-Smtp-Source: AGHT+IHFlmlr/XfRsi/oYZmr63WiLkh+SA+Secb7TZwoZnvZnBq3GFBNBh9qXCE7dOX6bQ/q1LUuGHct8/v5CfAhKiQ=
X-Received: by 2002:a67:b148:0:b0:47b:7420:a2cd with SMTP id
 z8-20020a67b148000000b0047b7420a2cdmr2214835vsl.4.1714547187855; Wed, 01 May
 2024 00:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-108-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-108-trini@konsulko.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 1 May 2024 12:36:16 +0530
Message-ID: <CAFA6WYPv61D_gmgobVe1+Y51wM6LGEJxrQrg06yvR-n-Fw9HNg@mail.gmail.com>
Subject: Re: [PATCH 108/149] board: qualcomm: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ramon Fried <rfried.dev@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
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

On Wed, 1 May 2024 at 08:15, Tom Rini <trini@konsulko.com> wrote:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> ---
>  board/qualcomm/dragonboard410c/dragonboard410c.c | 1 -
>  board/qualcomm/dragonboard820c/dragonboard820c.c | 1 -
>  2 files changed, 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index fbbfc0e65e24..bd2e213b3bca 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -6,7 +6,6 @@
>   */
>
>  #include <button.h>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <dm/pinctrl.h>
> diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
> index ac7de711c588..d3333a59db01 100644
> --- a/board/qualcomm/dragonboard820c/dragonboard820c.c
> +++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
> @@ -13,7 +13,6 @@
>  #include <asm/global_data.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/psci.h>
> -#include <common.h>
>  #include <dm.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> --
> 2.34.1
>
