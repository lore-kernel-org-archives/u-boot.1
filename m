Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D776D1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E866E89156;
	Mon, 14 Oct 2024 17:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UdSa/ch4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D2E8916D; Mon, 14 Oct 2024 17:50:55 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 261E088A47
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbd57cc35bso40968536d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921050; x=1729525850; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T2mIMAoA0SAlckcJa5ynbA8sAq2ftCdOjAsG/VgKzFM=;
 b=UdSa/ch43AAOx7d3vIH/FdopaLT97o8iU5nFXYtU2LVOFJaQHGCqjD3ugWBX0D0NgG
 xKufmXwHYSXWTN+kL3WJohNlv6QqNo8d+a8jnm3eF6HGYp6RYjJrNypoSrGyok65+eOS
 RE9lFmu13CrHbj7Lg8jt3/ZRA/XXXBl9KC/6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921050; x=1729525850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2mIMAoA0SAlckcJa5ynbA8sAq2ftCdOjAsG/VgKzFM=;
 b=QgNLAHe/eZwxZ7FcoUhfY0Q01lXOkVrdafxA/g8CCp7V7ptZoMCk6G51fIxisB9ikA
 OU551QZM2CT1+MlGKpDbEc5+c/JjAtgUeJO3HroNF7rnx6tUt86nfclTmwRPJse5Yxj0
 Yj1CqNvj8kWFi4jeIVeiZGNc6sjpywkyOdM6dYikoLiRDuKr8HtwN5sjf4qbXYzEmEbj
 BZupHz3fJSrHRrbW0E8vOo6LS53tcVzAakP+OtlRmvfJAWUXLUk1rEbTwE1RJ/2Jw7S3
 rnplLp5IZvQ7duC3aQcctXTUEbUKGFcIUswbpLBN/Z5Ai37myfXpXVquyssg8DvtojZA
 mk5A==
X-Gm-Message-State: AOJu0YxqdqBxyboNNbHDKr6B1WdQ61G8JqbJZqryT5m4AhPJGVeGFJou
 B8McemKF6s2cklGOW25Qb6vT+K0mvkE+kTYZ8E6n6Jzo9M8nq2Tp6g8pp6LxfSoJDb83xnE/c7v
 OUkIDbS60hesFFGXQ5ZvzGHluwADwLPTYQQCz
X-Google-Smtp-Source: AGHT+IG5cKQvN2oKR6wNZZtSNw9SiqelmMuSC3U1M8/uTUpLr9rLMJFX8svlhg4kHF635+ywTwdf11cvyKTHCLJS+Ss=
X-Received: by 2002:a05:6214:2aa2:b0:6b5:1d2f:1d3 with SMTP id
 6a1803df08f44-6cbe51208camr246747056d6.0.1728921049947; Mon, 14 Oct 2024
 08:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-5-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-5-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:38 -0600
Message-ID: <CAFLszTgLtmApvQL-JVd54b_ZeMQ8sxBwR_TVfz1PwZbu=VJjWQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] lib: Kconfig: add a config symbol for getting
 lmb memory map updates
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh,

On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a Kconfig symbol to enable getting updates on any memory map
> changes that might be done by the LMB module. This notification
> mechanism can then be used to have a synchronous view of allocated and
> free memory.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: None
>
>  lib/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1dd4f27159..61452f7ac9 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -75,6 +75,23 @@ config LIB_UUID
>         bool
>         select SHA1
>
> +config MEM_MAP_UPDATE_NOTIFY
> +       bool "Get notified of any changes to the LMB memory map"
> +       default y if EFI_LOADER
> +       help
> +         Enable this option to get notification on any changes to the
> +         memory that is allocated or freed by the LMB module. This will
> +         allow different modules that allocate memory or maintain a memory
> +         map to have a synchronous view of available and allocated memory.
> +
> +config SPL_MEM_MAP_UPDATE_NOTIFY
> +       bool "Get notified of any changes to the LMB memory map in SPL"
> +       help
> +         Enable this option to get notification on any changes to the
> +         memory that is allocated or freed by the LMB module. This will
> +         allow different modules that allocate memory or maintain a memory
> +         map to have a synchronous view of available and allocated memory.
> +
>  config RANDOM_UUID
>         bool "GPT Random UUID generation"
>         select LIB_UUID
> --
> 2.34.1
>

We should find a way to avoid this complexity. I have proposed a few
including my latest series at [1]. Please take a look.

Regards,
SImon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=427729
