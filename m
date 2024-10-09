Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23A2CF0449
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC2D8901C;
	Wed,  9 Oct 2024 12:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nf7pzAgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6016E88F91; Wed,  9 Oct 2024 12:12:10 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7634B891A9
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b93887decso54193975ad.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728468726; x=1729073526; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LEjQEDBFCkoprxzPl/SWfkqaT/i6C3bmOAXTkLcZvq8=;
 b=nf7pzAgZ9xAnOPSr+//KtKncNWGAFbAaMJsM4rfpW90HQ9iG03v8SP4CwKtjUIFy0T
 uGKI3llB+pg/hJFLrv6eq4qhrHY9SCFeO6jyAhLJaWp7cYkzrLag0z4Tu8uo44ZugyKZ
 UICPfRWgsEMmAwuWMTDvNpYpG+mIgulAKAEOcm6jrjTjYD4sHzm6wRoPAx1JfxUksIfw
 XssJ9AE5hx54NnJuyJUF59xYT/qxedwDLA2W2d3Iu2UV6xJ9QWG3/eyE5a7VDmdFIK5B
 XD4KzFGd6LTDFBnDvbapzeAEPrC5HZLiaBnHVzFpfQnb4v2i6toaA34jYItv06r6zEB2
 P1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728468726; x=1729073526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LEjQEDBFCkoprxzPl/SWfkqaT/i6C3bmOAXTkLcZvq8=;
 b=wcFskRo+jH26ZTDoF/l1TGQt0IrMRAGLTJRCYhRUtZur2rSF/RpQyn7eBg/rfgdauX
 iw4rajRmzkQVyZGk61KOD297gyU1tOu8t69/IayuzjyFGolo6C1M+RVpyw3ZO0CK9w8c
 TA9/GxWEZoPZwPOpkHysIFMwoG1mkqWnV8WQNHuF7V783hRhWdFToZJ1FRHHaqz1UZap
 phYYFLXlOesYUcXV7wiW4AnGFP4dpwW6MPAmH5Ia8T3x9FiVD6c1cZ7PZi2eaxAiPylA
 8gSsjY3kaoqbcJcNmXGmGJ/OyT05EHi/BTNYmGLGeYkily31n6dGXs5omFqicnflK+gW
 O2Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH6lIVSE+ahqMQ6vnelc6JUSN+2Xyxc4Mebl+PN9hhkjQu3LbsZkmkyf5HvDtMndDO1dqqmgk=@lists.denx.de
X-Gm-Message-State: AOJu0YyPrqnSKXQakamnnKArUOMnkgHtE7PJ+dGL7hYvp8ZMvfPmD5kd
 nQOOq7rykZPaQo0QjtFPM/HiD/uDtwI+WM4Jwj/0b7phB4CYsdQxEaDe0edAhPHQoxwXOjDqJVT
 scTo/31osqtfozAZZVmttSUiHaYg0UVsDwZ/hrQ==
X-Google-Smtp-Source: AGHT+IGUyWTDpbqAOC7jRN0BBqy59Rqm7C4mgXareB8a7Jy5+/pHPziAHc5p0n2jPFDz84Utr3nzD+Xx44OMv+oRXTE=
X-Received: by 2002:a17:902:e881:b0:20b:51b0:4b22 with SMTP id
 d9443c01a7336-20c6377c2cfmr30784685ad.47.1728468726020; Wed, 09 Oct 2024
 03:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241008225228.107491-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241008225228.107491-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 13:11:29 +0300
Message-ID: <CAC_iWj+TCfeE1ecf0pkK5--5333D+m4zpVKKX=uJvZxQEqtghw@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/wget: set filesize
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Wed, 9 Oct 2024 at 01:52, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Environment variable filesize is needed for man use cased, e.g.
>

The commit message isnt really clear

> * write file to device
> * calculate hash
>
> Let wget set the variable.

with the commit fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  net/wget.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/wget.c b/net/wget.c
> index f978adc9f0a..635f82efbb3 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -400,6 +400,7 @@ static void wget_handler(uchar *pkt, u16 dport,
>                 efi_set_bootdev("Net", "", image_url,
>                                 map_sysmem(image_load_addr, 0),
>                                 net_boot_file_size);
> +               env_set_hex("filesize", net_boot_file_size);
>                 break;
>         }
>  }
> --
> 2.45.2
>
