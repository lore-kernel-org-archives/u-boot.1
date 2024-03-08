Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B04C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 18:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95EDC87B30;
	Fri,  8 Mar 2024 19:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="As++e2hH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3008287D60; Fri,  8 Mar 2024 19:09:02 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6E08723E
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 19:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2206232d806so562072fac.2
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 10:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709921338; x=1710526138; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6/U7rgkAIzecWasapkeyiG76U5BZ9rpOTeRXS5KUKI=;
 b=As++e2hHS8c3MaUlyO6X9lzGZjxDwka55RvHsu9IZF2dYhoDpK34B4r2zY1LZca6pe
 wFzdl4KmLbUjwCdf6Bcu+O74RbvdArQah7B/wmn+uKVjAVEYj0EXAAh9X1dGbKjLeY0y
 54xTpq6CwQN70PDu19e8GADKjl2iVElvpZHJQm3IlGILCxqmZDbLB9y/eTYs0gSAUygD
 PNpMnT+CIvSZcI+GSydxFRvUUcEvzoaZ8rgqV8mq8VSRO3zFDPal/QUKj+quXPI1KuFN
 t2hvDlnIJ41z1f5nAPyDP3/IO9/rLJIaDvmgVpUHptjhFUcDGPjOI3vGybDxf1fWsMxp
 91RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921338; x=1710526138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6/U7rgkAIzecWasapkeyiG76U5BZ9rpOTeRXS5KUKI=;
 b=uoEHHbpPWssDR7lEsS0Vx/F5waIpTXK4Dx/6IGv5pzlcN5qtvZjQgO9S1Zq/Tc0u7x
 0fz1zcC3e33MtCts48cbAIYgqYgvuTSrQYek1+XIi09WZpUW8ISUvfUT8vYixCu2ozL1
 bmcevh1YqRpcI/CFLWMj3YPP5JRwFxd3sffbiC50bhRDA/0U+SEDJrhZ+ZyoulpW7q71
 /UTroWlHkc9sI/GcGlgH9LQ0zeZ5ZUkcLavwZXAfXeb/JcIH98K4DFSDutQ9HPJ10G++
 IAGRRQ2yCZQN1tHPjOOfQk96h27bAtlLJgh9WWWM5bRe1DqTgQxKeYv6IJu8x2Ngi1v6
 tzKw==
X-Gm-Message-State: AOJu0YzGndzhqjrlNwK2044CCzHj673QCCS1wh82aFPeFEpp6/yD4o5a
 5EH6bw/kt5T8X2Rrbhso/nst53WgmlksynlttL0MO53EYqTcM2cyDa8alGISyNwyY80Mq/XCcII
 DJqvxsWQyTWY0SHtcQEcVqjcy4VvUxff5sRaZRg==
X-Google-Smtp-Source: AGHT+IHXMNBbcqAJfeQFPSishcu6+hISk8BzL53ERFIhFNCbf2S+W2xdv3WmX4ev0ebnqmFjJ/NJOHTHpr38hJmaJnM=
X-Received: by 2002:a05:6870:a456:b0:21f:c7fa:78f5 with SMTP id
 n22-20020a056870a45600b0021fc7fa78f5mr2970120oal.7.1709921338249; Fri, 08 Mar
 2024 10:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
 <20240304174454.1484507-7-igor.opaniuk@gmail.com>
In-Reply-To: <20240304174454.1484507-7-igor.opaniuk@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 8 Mar 2024 12:08:47 -0600
Message-ID: <CAPLW+4nTwh7e3UMPOZ4nTSqBrADxsHjQAshVhP+Za9WNauaVXg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] tee: remove common.h inclusion
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

On Mon, Mar 4, 2024 at 11:46=E2=80=AFAM Igor Opaniuk <igor.opaniuk@gmail.co=
m> wrote:
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

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>
> Changes in v2:
> - Fixed chimp_optee.c:37:9: error: implicit declaration of function 'mems=
et'
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
> diff --git a/drivers/tee/broadcom/chimp_optee.c b/drivers/tee/broadcom/ch=
imp_optee.c
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
> diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplican=
t.c
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
