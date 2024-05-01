Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1CDC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 13:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F0B88690;
	Wed,  1 May 2024 15:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RhC2S0pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695E988A48; Wed,  1 May 2024 15:58:49 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537428806C
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso8747964a12.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1714571927; x=1715176727;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tyg5EdJkL386JfqqrFTtWDzhqVP/Tp+OsZ0lXjOTc0U=;
 b=RhC2S0pbEjxV9sHiyKJM7LGwgX5CeQ1qkAAcl5psRNojTKzZuuyoL9d8Fvde/rvnCZ
 Wdd28uEiTCyMDJrBZZV0OMHeY6isH7kEXVcRO89aRFdQQMsOebk1Mor07u+I15gmkfN7
 bXp6ifm8FEV6nRZRZZG7V6AXfqSekQ8ESXVjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714571927; x=1715176727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tyg5EdJkL386JfqqrFTtWDzhqVP/Tp+OsZ0lXjOTc0U=;
 b=EJHTMU1rcUR0sMPuJOPxegyFZJr8EXcPMd8+OXvkCoNnjr4Yf7jX9t0jowMk+77suU
 cAndcMTLsX4vW0/R10nOr7H61f5XWR+nRBeN//zt2QyJuK6HV3lZnb1XnJSMd6dyA/CC
 64cSu2+pYSfAtkz/qZIcO4hSoCl7Lp/dJH0cHPnMQ3eobEZr1eeaJzCgk6M3clkcM8Qa
 1FfB4VpP/9mewfIvi+KZFUvVxQei5ZDuq/CVhhmoYKU0R3DqVL98nGXcXMTnTQCdgJqV
 vksF7EIMZYxctOi5f4swfa/mUtnqErss5P28VZWw8yLoDjwBxscRRTLmXfITvMJ3m9z2
 QTlw==
X-Gm-Message-State: AOJu0Yy8weYVdM7VKZErAAzMoe///pAOrHyxOYMEnUltBI+Ywpjlze1d
 XnH8A7crMhcCo62xvCJINo6sYcSZQZwSA4xD0j0mOR0k9QocGPXpDg3ucGjJ2dnNiXRhHUr/LN1
 UVoz4Yi3M28ckVrjzZYvlUb/CwIbbpyLQFN5QnA==
X-Google-Smtp-Source: AGHT+IHsRg926hyc4RspnH1VLO4IFQOTHLiyUngpxvXKp2W5LMVktSnhqWDnw+msrul90UCzu4LwUwIl4F4w5xvq1RQ=
X-Received: by 2002:a17:906:90c:b0:a58:e789:8ebb with SMTP id
 i12-20020a170906090c00b00a58e7898ebbmr2089211ejd.67.1714571926670; Wed, 01
 May 2024 06:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-30-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-30-trini@konsulko.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 1 May 2024 15:58:35 +0200
Message-ID: <CAOf5uwmsUUUapqJHLViWoMHn=xVa_YADXPa6fXN0Vk47H9tcqQ@mail.gmail.com>
Subject: Re: [PATCH 030/149] board: bsh: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

On Wed, May 1, 2024 at 4:43=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  board/bsh/imx6ulz_smm_m2/imx6ulz_smm_m2.c | 1 -
>  board/bsh/imx6ulz_smm_m2/spl.c            | 1 -
>  board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c   | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/board/bsh/imx6ulz_smm_m2/imx6ulz_smm_m2.c b/board/bsh/imx6ul=
z_smm_m2/imx6ulz_smm_m2.c
> index c82eabbfbea1..c03e390762a9 100644
> --- a/board/bsh/imx6ulz_smm_m2/imx6ulz_smm_m2.c
> +++ b/board/bsh/imx6ulz_smm_m2/imx6ulz_smm_m2.c
> @@ -14,7 +14,6 @@
>  #include <asm/mach-imx/boot_mode.h>
>  #include <asm/global_data.h>
>  #include <asm/gpio.h>
> -#include <common.h>
>  #include <env.h>
>  #include <linux/sizes.h>
>
> diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/sp=
l.c
> index 5b4812e129e3..724841b57456 100644
> --- a/board/bsh/imx6ulz_smm_m2/spl.c
> +++ b/board/bsh/imx6ulz_smm_m2/spl.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <hang.h>
>  #include <init.h>
> diff --git a/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c b/board/bsh/imx8mn_s=
mm_s2/imx8mn_smm_s2.c
> index 0ebf208be82a..c99896873991 100644
> --- a/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
> +++ b/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
> @@ -3,7 +3,6 @@
>   * Copyright 2021 Collabora Ltd.
>   */
>
> -#include <common.h>
>  #include <asm/arch/sys_proto.h>
>  #include <env.h>
>
> --
> 2.34.1
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
