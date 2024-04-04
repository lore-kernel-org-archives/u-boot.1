Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F19CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF04883E4;
	Thu,  4 Apr 2024 10:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FXcf6+/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6AE883E4; Thu,  4 Apr 2024 10:29:38 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8F8883CB
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d82713f473so11775491fa.3
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712219375; x=1712824175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p90NoqWRyrMrvGZI/XcteNKG4cYdR0KyDaOTlme0K6I=;
 b=FXcf6+/sayfcvn4z4boU9yaSs9+0J0dEJl298yau+OL5pz+3HggrVWLIOXT46oczbv
 Fltxr61KDoJMCSDCDeyR/sLiH0TH+sO3i9xHErv3hUVJPCe5ljkx5uoLbMtfeVHx+DxR
 3pp6D08yUtGmD2qKXrrU66UhpNVTQN4+cqNXghUv9dctyW+lI7RL4UmxtEzAoHfwn3Bm
 ECq2cnf3ftkPEOOrZpG7LjG+KsLESdm5tjMYSmtZ5KoSd67TquzPjaZ9wRCeWxMB6Yo6
 ZmTnEVYmYKnpaMCe9HcE2VSC5U7WrsthRluFIHojH2JocXBMgOrS+7Kn7UKjrEB8pZB2
 TSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712219375; x=1712824175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p90NoqWRyrMrvGZI/XcteNKG4cYdR0KyDaOTlme0K6I=;
 b=Mp+AN8FLD6rbMERh4jqOqhHhYccrKX9Oxoy/8FTguKvc7Z/xp4OLS4SO23MFU/XTND
 z935shRnP3Kb1QBZG2d8PScaudHfkORECunZJ1mW117vKaMtHHc5jJozkqPz8UFS6m+V
 6SDw45IHa+8LqmZv8ySoEGiXfxwS02FRzFt+l6gq/SJDISQpY7dmAz3Hg4FC6DWsHcCh
 HMwq4RXEwhGzw7PTvUKd+HHS82ca5van+oGkjpCjXFrEnZht/ZZE03NghZd3eUOguh7z
 ihMXsD16G9nJ1EjDa34p7Lcs+v+sIxVicGpIApG8U+gcNPldAJ3FVPo4XRH7XM3h8hWB
 i+5Q==
X-Gm-Message-State: AOJu0Yyje71AcgfjMLutp80Wj0tIZUIHzDcKImcZmvNJTnCNNi5kUywv
 FSWXA0XOoxRRb7YNcviOli2htrJDK8ueMoi1WPgvBO/F3FKHXl4zukIrB956jvY0QMWwwqPojVh
 +Fz75ycaGdbyHnzJweIa54zsFjzJVxvrrY5s17w==
X-Google-Smtp-Source: AGHT+IGnypnrRo9hh7MD0B1uHeKhq21pxH321FQvuZRuW8PgRfzrYhXLbjWOhbwuTpz1Abw7PrvkqLk/AXrCdW2P6bc=
X-Received: by 2002:a05:651c:1417:b0:2d3:8c1f:c0ff with SMTP id
 u23-20020a05651c141700b002d38c1fc0ffmr1403976lje.16.1712219375245; Thu, 04
 Apr 2024 01:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
 <20240404081352.3224643-6-igor.opaniuk@gmail.com>
In-Reply-To: <20240404081352.3224643-6-igor.opaniuk@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 11:28:59 +0300
Message-ID: <CAC_iWjJqodimqXhUFyiR5GhUJW+EsT-THB24Q98qOLGceRza0Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] tee: remove common.h inclusion
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

I've already reviewed this one. [0]
I'll add my tag

[0] https://lore.kernel.org/u-boot/CAC_iWjLZcKEo6-0P_gkz5UOe7VanuNv1+=i3xcUTKVo5B1tpQg@mail.gmail.com/
Cheers
/Ilias
On Thu, 4 Apr 2024 at 11:14, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> The usage of the common.h include file is deprecated [1], and has already
> been removed from several files.
> Get rid of all inclusions in the "drivers/tee" directory, and replace it
> with required include files directly where needed.
>
> [1] doc/develop/codingstyle.rst
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Added calls for closing tee session after every read/write operation
> - Added calls for closing tee session after every read/write operation
>
> Changes in v2:
> - Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
> - Applied R-b and T-b tags
> - Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
>
>  drivers/tee/broadcom/chimp_optee.c | 3 ++-
>  drivers/tee/optee/core.c           | 1 -
>  drivers/tee/optee/i2c.c            | 1 -
>  drivers/tee/optee/rpmb.c           | 1 -
>  drivers/tee/optee/supplicant.c     | 2 +-
>  drivers/tee/sandbox.c              | 2 +-
>  drivers/tee/tee-uclass.c           | 1 -
>  7 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tee/broadcom/chimp_optee.c b/drivers/tee/broadcom/chimp_optee.c
> index 37f9b094f76..bd146ef2899 100644
> --- a/drivers/tee/broadcom/chimp_optee.c
> +++ b/drivers/tee/broadcom/chimp_optee.c
> @@ -3,9 +3,10 @@
>   * Copyright 2020 Broadcom.
>   */
>
> -#include <common.h>
>  #include <tee.h>
>  #include <broadcom/chimp.h>
> +#include <linux/errno.h>
> +#include <string.h>
>
>  #ifdef CONFIG_CHIMP_OPTEE
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 47f845cffe3..5fc0505c788 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2018-2020 Linaro Limited
>   */
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>
> diff --git a/drivers/tee/optee/i2c.c b/drivers/tee/optee/i2c.c
> index ef4e10f9912..e3fb99897c5 100644
> --- a/drivers/tee/optee/i2c.c
> +++ b/drivers/tee/optee/i2c.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2020 Foundries.io Ltd
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <i2c.h>
>  #include <tee.h>
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> index 5bc13757ea8..bacced6af6c 100644
> --- a/drivers/tee/optee/rpmb.c
> +++ b/drivers/tee/optee/rpmb.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2018 Linaro Limited
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <tee.h>
> diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
> index f9dd874b594..8a426f53ba8 100644
> --- a/drivers/tee/optee/supplicant.c
> +++ b/drivers/tee/optee/supplicant.c
> @@ -3,10 +3,10 @@
>   * Copyright (c) 2018, Linaro Limited
>   */
>
> -#include <common.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <tee.h>
> +#include <linux/errno.h>
>  #include <linux/types.h>
>
>  #include "optee_msg.h"
> diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
> index ec66401878c..8ad7c09efdd 100644
> --- a/drivers/tee/sandbox.c
> +++ b/drivers/tee/sandbox.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (C) 2018 Linaro Limited
>   */
> -#include <common.h>
> +
>  #include <dm.h>
>  #include <sandboxtee.h>
>  #include <tee.h>
> diff --git a/drivers/tee/tee-uclass.c b/drivers/tee/tee-uclass.c
> index 52412a4098e..0194d732193 100644
> --- a/drivers/tee/tee-uclass.c
> +++ b/drivers/tee/tee-uclass.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY UCLASS_TEE
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <log.h>
> --
> 2.34.1
>
