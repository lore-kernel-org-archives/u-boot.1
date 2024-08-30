Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A8ECA0FE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 11:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14D288B55;
	Fri, 30 Aug 2024 13:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iq9DVPiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B94988B9E; Fri, 30 Aug 2024 13:59:22 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2907388A5B
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 13:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso2911395a12.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725019159; x=1725623959; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gMHBYITiSxSrzi+sRdT8SspiSxI5lj/n+61dVmAbjcc=;
 b=iq9DVPiEofOyzU73IlwX4W8O/3PefH1rvPaVlfwjEXe5Qij8HD2m2HuOtJEBoVZLQp
 f4igAcClsElttKnIKRR2L6gsOq9qerrbpne5oBRvmPcz3yis34tejbGGh/BmJAnO3+nP
 kzUePSjynWGxr/ehWe0Yg6j/yfoJ4HU7Ek5L5MO7LaWhufeQO5UrZq9fF1TYFjdo4g5X
 Eg27FNGwLsxgKM36EOYIJtaz3s+IjzR82Y+dVwV5c4vi4BXby3NlmYPYNmUoubfy4qt9
 SeqLioPB94UdF+hicDNmAnwWa9kY3OMNaKmJdyDYRF2tdTJP9JURjcehCS9hh/inDYjw
 hPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725019159; x=1725623959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMHBYITiSxSrzi+sRdT8SspiSxI5lj/n+61dVmAbjcc=;
 b=phPnG8vf0UNMi9TqLSVdyDKxZBr/jhDYTn4BIAR+DqMPAXgr8woW5wPUOIMDqScMV3
 KpSnomYp/QhpX4vZ3I9yY/NEOvNJ4hGyLC35m9VC9wArsfJyqyGxyK4UMu4T9EJnh0BK
 FBQsCceyyVBnRLmh85P1LGUSqvyCvjaVh9zsD7cMpkDeznunCgJPZ0YJU0OQcOGRjNKk
 1AaoPYZkTlpLF2tFrJAZ5Frrb6qnLVhsFNuBArwS1aRSShAg27V3v0HC7NBl9UosPO/x
 GJ8zm4ouA/GKQexFkMmiB3SEBwlFhVf8Rd6K7gMEAE+XUBIIH/ts1997a8QnDtRGj3TK
 HbQA==
X-Gm-Message-State: AOJu0YzhRa6B7cJfTAoVroTMj6b90T9vZsSbfeouiwCrzPb2ZTmeDAhf
 17WXsyySI7YnGiTGk+M28nx1OQJ7SlCDwZDecMGKMLHlZfrLnF87D6Js9og7FdTQEyJ5O34Z39N
 PvoQSU+nC5tK9rXVm5DoSKXfVMrS4oxxF
X-Google-Smtp-Source: AGHT+IHbQIN6HYjnR2WuBXUqZD9KERzjKw1x7MOlW9nLWkEg40rlhxuzEtrdt0ol9879iZ/qDm/wiXLwVk3An3LjZnA=
X-Received: by 2002:a05:6402:5290:b0:5bf:1974:2ba5 with SMTP id
 4fb4d7f45d1cf-5c2201d25ecmr5768444a12.19.1725019159029; Fri, 30 Aug 2024
 04:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725012294.git.jerome.forissier@linaro.org>
 <7d3aba410bc30a42540d0a18d668bf1895337b2c.1725012294.git.jerome.forissier@linaro.org>
In-Reply-To: <7d3aba410bc30a42540d0a18d668bf1895337b2c.1725012294.git.jerome.forissier@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 30 Aug 2024 12:59:07 +0100
Message-ID: <CALeDE9NB-3HjiKUCmU1ZnpR46KwS7rC7GWLHFyQ6TXHTh-ucVQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] net: fm: call dtsec_init_phy() only when it is
 defined
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Fri, 30 Aug 2024 at 11:17, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> dtsec_init_phy() is defined only with MII so add the proper conditional
> in the caller code.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/net/fm/eth.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
> index 19f3f0fef0..22025b6a27 100644
> --- a/drivers/net/fm/eth.c
> +++ b/drivers/net/fm/eth.c
> @@ -26,7 +26,8 @@
>
>  #include "fm.h"
>
> -#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
> +#if ((defined(CONFIG_MII) || defined(CONFIG_CMD_MII)) && \
> +     !defined(CONFIG_BITBANGMII))
>
>  #define TBIANA_SETTINGS (TBIANA_ASYMMETRIC_PAUSE | TBIANA_SYMMETRIC_PAUSE | \
>                          TBIANA_FULL_DUPLEX)
> @@ -701,8 +702,11 @@ static int init_phy(struct fm_eth *fm_eth)
>                 supported |= SUPPORTED_2500baseX_Full;
>  #endif
>
> -       if (fm_eth->type == FM_ETH_1G_E)
> -               dtsec_init_phy(fm_eth);
> +       if ((IS_ENABLED(CONFIG_MII) || IS_ENABLED(CONFIG_CMD_MII)) &&
> +           !IS_ENABLED(CONFIG_BITBANGMII)) {
> +               if (fm_eth->type == FM_ETH_1G_E)
> +                       dtsec_init_phy(fm_eth);
> +       }
>
>  #ifdef CONFIG_PHYLIB
>  #ifdef CONFIG_DM_MDIO
> --
> 2.40.1
>
