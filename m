Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3491DCAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 12:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C5E82A9E;
	Mon, 29 Sep 2025 14:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kb03uZCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F875832AD; Mon, 29 Sep 2025 14:22:08 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA1DD8206E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 14:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6348447d5easo3412580d50.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759148525; x=1759753325; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6YH1H4R3/OiL0XI57zZTSoR6lHsfWoY+Th60Zk6RD1c=;
 b=kb03uZCnE3Isz29Zz1MoH5IJLu+/aqdJObEZjhZQ1AvNu2yegGkomajvWYqMbZxe+/
 MUxFxC5dS5lS12y8wHRURFc1LJUFUEsFdyGLbygss31AjQFXSlbvos/fIpJzWtzp2ccy
 0QkwPXTeqaWKguenOI6Q9YpIQ67vdxJjjnpsLWMie8ySsydVwBsxfMo6Ug7VPA7TZC2u
 LiXI6ci7fIKTN8GHaRcWKTgks0FGFnLL00dvKl5nuJHwNsWvJG2bDt5OOHlKgneD2bv9
 R6HOFLUSaKMgOxJrZPbh2MDEWK9QOPW7iqoeOn5NCA7cB74xfZvF8UteI6jbeHubQMYO
 WzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759148525; x=1759753325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YH1H4R3/OiL0XI57zZTSoR6lHsfWoY+Th60Zk6RD1c=;
 b=ACaXKvB7LeLR9xOjrXI8Tlf+vcv4am41qq8KLAaXM3K+zntvCmLUqva3sls8YgOzE7
 Aquc8uGXBW9Lgm/CeqcQC2yzHvlIW3ysCvG07Tl9ePap3lhIP6tksz0jSxyFrsWWCYwn
 PGh3OrLrTvJXG0Xt1NM7JtExVfZUhzTvmZsoUztMwg9HSdaiHa0f5f+p8z48RyA5qn4p
 dIlG9QXhA5JHMLIGjySGA780B4d2jP6PEN+KuP2BHkSnF15w7nVKUjNX0B47OV5yczMH
 ilrtmKzMlrbCviCUmgPiTPMVRcdYfxvpSrRmEto0uzGQbjw+WoqM2Pog3FyTZZXS7UX6
 kYlw==
X-Gm-Message-State: AOJu0YywRjpl7CBo5Lpe+YfS3mtI0HyhnTrynWXP74l4BF4B+HX008DW
 fpmPEHNSftPv1+57MD4PSCPgafkPV3/cjMvCxz3oq3U7ZiFWdsovEelw7H7VWmGHFhhlvj/A4CJ
 GlGMLI8IF+u2OoIP43c8NIy5U+53U6HTxJBv5FSAut6nSq+ZIegpy
X-Gm-Gg: ASbGnct3pV8FNbxWTULOY7C4po8eiDX9bigK9n5I+uPAsMIh74eGwH2HyOkC+bSy5NX
 +DFffad2Nm4ZIJ8EXOZXIcj6wbGm+SYkb6IqZmwy36RKU5wW9b0CVBd9Ctkia+PQQmHqf3Yi6Q3
 78hyEKIGuP2tWswuH1GlttnIuOe11T5Ino7IPt0wDSZC74w4m4AHkHzIsaH6DeI/PU9ZiDT0STz
 eLRZPh9dJ+4TiRf
X-Google-Smtp-Source: AGHT+IGKDWsYLpgOI5Ac+qRmFHgKEV9fxZxRUVN/G6pdNdu64c9o6Bx16GSD58/0GkhLxe9LvJV1WcmSYgT2SwU214Q=
X-Received: by 2002:a05:690e:1505:b0:633:bbf7:40fd with SMTP id
 956f58d0204a3-6361a82e3d3mr17261749d50.38.1759148524421; Mon, 29 Sep 2025
 05:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250926153144.3680937-1-trini@konsulko.com>
In-Reply-To: <20250926153144.3680937-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 29 Sep 2025 15:21:28 +0300
X-Gm-Features: AS18NWBW2MGkRJ5MH-fIHe2EDM8mCSjQya45X6gaqJwfmDym7VTbR9NMTicpRP0
Message-ID: <CAC_iWj+PjZGFxR-B2xekuwZM8zHEEoDSPEbZz1iNOMAEYfKR3g@mail.gmail.com>
Subject: Re: [PATCH] tee: Rework Makefile logic
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jens Wiklander <jens.wiklander@linaro.org>
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

On Fri, 26 Sept 2025 at 18:31, Tom Rini <trini@konsulko.com> wrote:
>
> The intention of how this Makefile was written was to allow for sandbox
> to build and test drivers still while otherwise requiring OPTEE to be
> enabled. This however didn't work quite right in practice as sandbox
> could enable some drivers which would then fail to link. Rework things
> such that sandbox will also traverse the optee directory when
> SANDBOX_TEE is enabled, but only build one of the optee-specific files
> when OPTEE is enabled.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  drivers/tee/Makefile       | 4 +---
>  drivers/tee/optee/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
> index ff844195ae12..5bc5df0d3805 100644
> --- a/drivers/tee/Makefile
> +++ b/drivers/tee/Makefile
> @@ -1,8 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
>  obj-y += tee-uclass.o
> -obj-$(CONFIG_SANDBOX) += sandbox.o
> -obj-$(CONFIG_OPTEE_TA_RPC_TEST) += optee/supplicant.o
> -obj-$(CONFIG_OPTEE_TA_RPC_TEST) += optee/i2c.o
> +obj-$(CONFIG_SANDBOX_TEE) += sandbox.o optee/
>  obj-$(CONFIG_OPTEE) += optee/
>  obj-y += broadcom/
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index 068c6e7aa1bf..36ac085ef420 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
> -obj-y += core.o
> +obj-$(CONFIG_OPTEE) += core.o
>  obj-y += supplicant.o
>  obj-$(CONFIG_DM_I2C) += i2c.o
>  obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
