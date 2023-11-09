Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DABC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 10:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD2587120;
	Thu,  9 Nov 2023 11:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UJnQa6nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7ACC8715A; Thu,  9 Nov 2023 11:22:12 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852ED870BE
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 11:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6ce2ea3a944so403528a34.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 02:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699525329; x=1700130129; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZKajVpYIXEh6uoSwlwmu/gcDZre9X8mA08SjA7of0Q=;
 b=UJnQa6nfRpqkKUjreEPzq03tP37mffVPNdFfF2n04ySc5D8/Fv1Ibvnmg2PuEm4UxN
 R+8yF4ZIw7SY510jXeQ5DSjw6sqNV4nkS6gNEyd1O+xR4gnPIVJ9jMYloQg6Ch0zc8R6
 14Uhaibx4o7eaznz0c48pp9iR6gvOpQrXGy2zuHzciIifBtXjGQv93DvlhoHnHpu40L0
 HRJR756E5spaPabBoEwbFed9xhfeE5uRGptaSUO9av8qWwLFuzb7bOz/7LQmpyKRN34I
 vQMWXQpbhI7bh7Mq7Cz9mn7rsh8l8UkrVx/StsKrf+Ki4BXdJciQyNw+iLE3qzz4gm6O
 CrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699525329; x=1700130129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ZKajVpYIXEh6uoSwlwmu/gcDZre9X8mA08SjA7of0Q=;
 b=U5wHa3Bo3C3zCt7iWNqQC0dGn7ETP9lTp2yGjhBHZ5gjkd7MLc9Qypq1SWEgjYSSTr
 7xgJy6d9j9W2IvcNxw6vjUij2ZsYVEbk9czbfM04VqQuPSUrUb+Al6jrS7GdbPfcmcv5
 pJ8fB0MtG8ncAM9sV004dlMojb3UG/tgaCnPa1QA+q8kGES8LSbWZal1bOurB+CbajIE
 iCezLysvUSxOn3McoOXcSd1d5dIiElUJnG8YhQ58p+ZAd+ujbaDk4wIc3BNxqP2BPrSr
 2VOMHjiZztzu2qspfyRLyawNj72BHUu8sWtaCk9FleM5/9DXNRhfapkO2kKZKedDW/OW
 vg7A==
X-Gm-Message-State: AOJu0YwRcTTNgZlvZjYPDWokI70E/ftyx3xJVVUQ8p9D4KQSZHDdoH2a
 UJhK30BC+YY2cywWjVTvWN5JIWsiFyhMkmd46Tg=
X-Google-Smtp-Source: AGHT+IEDALGoPsa4FvdRd0gdxj0MM1Ndp/aJYt/7GLKiDip1mP7SzygR9UZN4Sqxel8lsVBW1/VkIL6U7fFucsQMtMc=
X-Received: by 2002:a9d:64c8:0:b0:6ce:424c:f3e7 with SMTP id
 n8-20020a9d64c8000000b006ce424cf3e7mr4074623otl.7.1699525328950; Thu, 09 Nov
 2023 02:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20231020184253.21915-1-semen.protsenko@linaro.org>
In-Reply-To: <20231020184253.21915-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Thu, 9 Nov 2023 19:21:57 +0900
Message-ID: <CALrBrZ0XeoOe0KgjSDNwKdCQH8Zj4rYyKA4z_Fnane8QwxOz8w@mail.gmail.com>
Subject: Re: [PATCH] board: samsung: Remove incorrect SYS_CONFIG_NAME in
 axy17lte Kconfig
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi!


2023=EB=85=84 10=EC=9B=94 21=EC=9D=BC (=ED=86=A0) 09:10, Sam Protsenko <sem=
en.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> The global SYS_CONFIG_NAME in axy17lte Kconfig overrides SYS_CONFIG_NAME
> for all boards specified after this line in
> arch/arm/mach-exynos/Kconfig:
>
>     source "board/samsung/axy17lte/Kconfig"
>
> Right now it's the last 'source' line there, so the issue is not
> reproducible. But once some board is moved or added after this line the
> next build error will happen:
>
>       GEN     include/autoconf.mk.dep
>     In file included from ./include/common.h:16:
>     include/config.h:3:10: fatal error: configs/exynos78x0-common.h.h:
>                            No such file or directory
>         3 | #include <configs/exynos78x0-common.h.h>
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>
> That's happening because axy17lte Kconfig defines SYS_CONFIG_NAME option
> in global namespace (not guarded with any "if TARGET_..."), so it
> basically rewrites the correct SYS_CONFIG_NAME defined in the
> hypothetical boards which might appear after axy17lte in mach-exynos
> Kconfig.
>
> Another side of the issue is that SYS_CONFIG_NAME is defined
> incorrectly in axy17lte Kconfig:
>
>     config SYS_CONFIG_NAME
>         default "exynos78x0-common.h"
>
> The .h extension should not have been specified there. It's leading to
> the build error, as the generated include file has double '.h' extension.
>
> Fix the issue by simply removing the SYS_CONFIG_NAME definition in
> axy17lte Kconfig, as all related defconfigs already declare internal
> values for SYS_CONFIG_NAME:
>
>   - a5y17lte_defconfig
>   - a7y17lte_defconfig
>   - a3y17lte_defconfig
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: 3e2095e960b4 ("board: samsung: add support for Galaxy A series of
> 2017 (a5y17lte)")
> ---
>  board/samsung/axy17lte/Kconfig | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/board/samsung/axy17lte/Kconfig
> b/board/samsung/axy17lte/Kconfig
> index a018547ff5d4..209394a8a5a8 100644
> --- a/board/samsung/axy17lte/Kconfig
> +++ b/board/samsung/axy17lte/Kconfig
> @@ -1,11 +1,3 @@
> -config SYS_CONFIG_NAME
> -       string "Board configuration name"
> -       default "exynos78x0-common.h"
> -       help
> -         This option contains information about board configuration name=
.
> -         Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h
> header
> -         will be used for board configuration.
> -
>  if TARGET_A5Y17LTE
>  config SYS_BOARD
>         default "axy17lte"
> --
> 2.39.2
>

This patch makes a build error since axy17lte.h was not exist.
Am I miss something?

And.. actually I can't catch what you exactly fix with this patch.

Thanks.
Minkyu Kang.
