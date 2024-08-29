Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21739C83F27
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F43288C4A;
	Thu, 29 Aug 2024 16:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TWydSbwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88AC488C6C; Thu, 29 Aug 2024 16:05:35 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A2588C20
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7141feed424so583901b3a.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940332; x=1725545132; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X+kDsSKUnffva1VvQLa+bcngsnfIC9Iu5jD4c1+c+14=;
 b=TWydSbwU5mFVkORoMbuv601GVqVdF3lmzS6Lvxnsj/ch3Daf2+ieFLSjbs4e3GZ29R
 pcGNfcos9BUIq7h4X+v0ogf3olHetDcUucoaD3MtgndxRDod9fbhOWVe45Fp7M8iZ7uc
 YctOOJ5eK3wMjscXBRi/ESV3puKegRWBkLp2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940332; x=1725545132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X+kDsSKUnffva1VvQLa+bcngsnfIC9Iu5jD4c1+c+14=;
 b=sWm/YfuJK7delT0PBmszFIYciOoGSjoM+MJshp6MzM4+C9Ywf6TBXa9aV2j8eq7pN5
 OQv2UXUv+mVQnNdSMua5VU8AoSXORnXJnGxCcGj49DM3ypegIbDAKhs3hVYuhxpFMmGp
 QQEJSVPcqoHrVe4nwSiLsde1iQ+DmxjBIxxkRIjfT4G49+SqxNT9Dc/11DP4+37RgUfg
 JfXR+o1f24tBBNuecmboNFjseKNV9OrBRnEODQBL1RGoE4u2Ud2E+VHjSvtSW4s6u6ia
 U9aFnWK3r1aZG1Gixa4ire5k2G764mICqDYwtDWiSr3CgM+bMTYN+Av5Bf+jUYpnW29l
 eTFQ==
X-Gm-Message-State: AOJu0YwoIPLWIIATB9sx+D4v216hmufDF84xfZQU6CJmmmyGeMulbBWO
 ZQ6CNZWjHrQ13ac7KDgMmmELvFwrf6IKB+kf5DvbWj37+D/DqkEl2MwnJ9H4ieosATd0RQU87VR
 tqkqq3PHyuQLJ0qmxZJKaNG84sClqiorLDtNw
X-Google-Smtp-Source: AGHT+IEvUo/AN5cqHyO8ZDUhW68Jw5z1gm7bqw4xeZvYGwn5fMRWy/xuKJoy5Xw3G3WwnZgy2bVJpJruLUFDs4bRA2E=
X-Received: by 2002:a05:6a00:1824:b0:705:b0c0:d7d7 with SMTP id
 d2e1a72fcca58-715dfbb070amr4064912b3a.7.1724940331624; Thu, 29 Aug 2024
 07:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <3112cb1127580bf714f50a199b4ec9e998322202.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <3112cb1127580bf714f50a199b4ec9e998322202.1724846454.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:04:55 -0600
Message-ID: <CAFLszTgbXoKd_fx+nM-xpadwEjXVv94suhCXiXq4w+KOPMYbwg@mail.gmail.com>
Subject: Re: [PATCH 08/13] net: ftgmac100: depend on NET
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>, Robert Marko <robert.marko@sartura.hr>, 
 Gabor Juhos <j4g8y7@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

On Wed, 28 Aug 2024 at 06:12, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> FTGMAC100 enables drivers/net/ftgmac100.c which uses
> PHY_INTERFACE_MODE_NCSI, which is defined only when PHY_NCSI is enabled.
> Therefore FTGMAC100 depends on PHY_NCSI. However adding such a
> dependency causes a "recursive dependency detected!" message, so
> add a dependency on NET instead (PHY_NCSI depends on NET).
> All in all, either the stack is NET and FTGMAC100 can be enabled,
> or it is NET_LWIP (or NO_NET) and it cannot.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/net/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 69ae7c0750..3382e533f4 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -461,6 +461,7 @@ config FTMAC100
>  config FTGMAC100
>         bool "Ftgmac100 Ethernet Support"
>         select PHYLIB
> +       depends on NET
>         help
>           This driver supports the Faraday's FTGMAC100 Gigabit SoC
>           Ethernet controller that can be found on Aspeed SoCs (which
> --
> 2.40.1
>
