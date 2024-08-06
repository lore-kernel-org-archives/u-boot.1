Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A854BC52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E9088AF6;
	Tue,  6 Aug 2024 23:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ES6kEHE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF23888B03; Tue,  6 Aug 2024 23:51:10 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7945C88AEA
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so827549a91.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981066; x=1723585866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YFgZvbAcM2SfjPTtYpq7asQ/5dslpFOeOYqAD0n9NgE=;
 b=ES6kEHE9KU/ZBcydnECm++gWTEJ4wNPPnSawNIyqd/7t7gO3doVDoNLYKtUO6bxGKF
 6bbBAB/uNNZLPxRTg3MGQ35XLKgvtmp89HpUB/YBMCPPZvUmTFDQA2FVYxoAttQ7BOfW
 wuMiQ/AkHMVYmTlJ2Z+JxOMP6mk2B97sFn7FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981066; x=1723585866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YFgZvbAcM2SfjPTtYpq7asQ/5dslpFOeOYqAD0n9NgE=;
 b=vbg7dG2XpZU7yg98JqoG6TTIMbyYm5JVxGuI+cKl9Pj7kjPHx/DS3Y5inhi1RxCytq
 qzJPhQMH33zqq0gQfoZkmaBFSqXvTvkJrKe+6k9w4l1Bf+vSs+HKSn7L7rRuf4abCmNL
 pzOjH50kjbpJVSTqGOxUTK9p1KU9ugv+RkzEqDowCTU6I/GS2o172WtjforvfdMkgz/v
 T5CCujUvoAXDf/S/hIFXUBUm3gyP46j1aArZhMtLzjrLIk2s9Z2NVddAdo6M0SUwTqK5
 97r3oGiL/EgV18AzvsCzv3zbEfhRz/01NyfeL6X0mdl9Z5WpIjdQ0V5d4u3+krRX5oTV
 hmyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb1jHCl25pL6h92WnaG0T+x1va3qUUszekYErysKVVlbXQ01LbBsAHZ7E1Ycb/p+XtNGuAyj6vGDuoLMjugDxMGjdK2g==
X-Gm-Message-State: AOJu0YwkD6iTgGXoRFqHF+CGsW6q01ut9s2LiUUdQyKMp7yRzefhXW6d
 cpgcUUvGV5krCPpo82XZp/M+CdBRttgYHMdv5KL0gNME5pN/jLESU+iAQDoKx62E34x4In8ifLW
 z1bcyhsiNFJnq0VAmFTjO8KxhMDjf2OkaF+fV
X-Google-Smtp-Source: AGHT+IGSVcI1rl4+zRYa5SacmACURY//5elWnLhTEbri5P9jVHAg8K4FeRvG+Yy+MoOsuLZDEcZT9Le/H/YFISth5EI=
X-Received: by 2002:a17:90b:1893:b0:2c3:2557:3de8 with SMTP id
 98e67ed59e1d1-2cff95146f8mr16223211a91.33.1722981065950; Tue, 06 Aug 2024
 14:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240802135023.107143-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240802135023.107143-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:45 -0600
Message-ID: <CAFLszTg-_ARgOuxBUdmhczdwUWiS8n45uQrsq9vKSyJFA9Wr2g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Makefile: don't use CFLAGS for environment text file
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Dave Jones <dave.jones@canonical.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>, u-boot@lists.denx.de
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

On Fri, 2 Aug 2024 at 07:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We use KCPPFLAGS to let the user set flags when invoking the C precompiler.
> These should also be used when generating the environment text file.
>
> Reported-by: Dave Jones <dave.jones@canonical.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/Makefile b/Makefile
> index f0e6f07178f..4c469b9ce2b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1839,7 +1839,7 @@ ENV_FILE := $(if $(ENV_SOURCE_FILE),$(ENV_FILE_CFG),$(wildcard $(ENV_FILE_BOARD)
>  quiet_cmd_gen_envp = ENVP    $@
>        cmd_gen_envp = \
>         if [ -s "$(ENV_FILE)" ]; then \
> -               $(CPP) -P $(CFLAGS) -x assembler-with-cpp -undef \
> +               $(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
>                         -D__ASSEMBLY__ \
>                         -D__UBOOT_CONFIG__ \
>                         -I . -I include -I $(srctree)/include \
> --
> 2.45.2
>
