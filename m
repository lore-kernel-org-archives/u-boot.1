Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D33CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 11:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA5383A3A;
	Mon, 10 Nov 2025 12:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b6qgJkLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C307183A7A; Mon, 10 Nov 2025 12:58:25 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B242B83980
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63f9beb27b9so2453822d50.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762775902; x=1763380702; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1oKE50LkNagDsWN2zLh7Kbm/QPS3efBpCLIfLsKKsng=;
 b=b6qgJkLBVVfadsii2snIvQd6QfTg9nLl9Zyywd1SSb/4kpmUmZdtbaHS/awhkqklkA
 1G/MkoEl1BDD5o5SZpQdLwZQD2F0LIiFfP/4HEMynf6fIjBdwbaMwOr4msoF97n8Pkr3
 Y/EYANsxCGCdqEuVeSOofqmHUIH9M8aHeeqsFhsDbe4NvYRdWv9ezqNJtI3PkmyRoDwq
 +HdOGMgGLYcqwNxbIeaTldSVCeRABxe0MNF6AndmK7HtK2B8D7nx1H0Ggx1rE/MTKzPA
 1epiXsETeb5PwMPfLJWlA9f8b26xIKS1QyrOkkP18+LOywwyVldhRywAn+vYxtLv1XQQ
 +lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762775902; x=1763380702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oKE50LkNagDsWN2zLh7Kbm/QPS3efBpCLIfLsKKsng=;
 b=DOuRrnn4Vu2wCyZBHJ820hP9JvMkBS7yApBFbfgNo29DwKRV50xNFNK2VJCu8Mgf/s
 fpemVnUMq50OWQJ8drlidTUB7+Nepz4kpLDHdc8sAfaFTpiCZCKIV6Ri8T/w1oLsq75O
 8qI7692ICuNqbkmZO5cCaaFRI0E46wODiaNFC9ktsTuuEMPbVMaPN6FE+jzuaXq43/jt
 FLDCF/Ic9MFXNsysZZnXc6fmNxHQDWPonzRKWn4BAPcI30gKVtEaGlw+UFM9EAC+A6jf
 RpOEBLDBWnca59EZQ7UZ8FelfX8kg4bFIv8A4vW3i/nv94tJPQsYaLYKdOmA7p+b8RJI
 t+QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6qfIcQuVxNUvrZOGg4shO+VmE4fi+EOnCaVA9IOBnGuXJ0OWM7XO7nXeIPfBw9fVreO4AJXQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwJPQq6GSFHyOXl78aFNingersioW5+e7XM9B4rMrzigH0WNnxX
 xH1Cu3ws2U3SWmwh49JAFT76QmeoWrHKrEaPxxvsG4vzJ2JDSztQaGg5Y+3AREUkd8WzQNXqKkx
 0YzkcyxmTwVl4tZpVG9SxBseXMqAi8I+ud1c8K3nwVeEw3B1dwHJ/OOM=
X-Gm-Gg: ASbGnct+EiRiIEoXtH3XKjVbr2r3ek6V+YR6blHESo+kXUbXSGZ7SdTQw+JxaGvAGP4
 XdAFwBvDEspM5eibNA9RnPWUsTLop/tAXFDWqgrSPZY5j3cgVHpHUfO26Ul5Ah+44YF8fjwhjMt
 /lO0TgIcf9K09EBcsiO1wBUIRb1y4Q0iwbzR32ST0Jj5P87hOeTwy85sxMUB1bfwjtkLfEIWeD4
 jXuVBauzrzdDmu6fsRwFLiOC9yUBL0y7kI+m32BIxDQMsK+atW3FPKQ7T6+eH3h4BRtS1vGjCmS
 wUFKpy8OcZlr1/8mVk+63Dxvn3ANb1IF0Fa4OCCpvg3WDZoV9tI=
X-Google-Smtp-Source: AGHT+IEXjvT1H8MaB2zzZBZjRAlweRuUHDnlt8o0O0dD/8UlDDWEScdDSnq4mcpeud3nWd5kaApemY/ExlNIuocXyC0=
X-Received: by 2002:a05:690e:c4a:b0:640:d4fd:47fc with SMTP id
 956f58d0204a3-640d4fd4956mr6599797d50.63.1762775902602; Mon, 10 Nov 2025
 03:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20251104220055.26609-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104220055.26609-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Nov 2025 13:57:46 +0200
X-Gm-Features: AWmQ_bmV9IXm-EbkyhOjV_Mkey0skPtmjEFcdLMqaWmXUuMFN_k5w65UIqjopyo
Message-ID: <CAC_iWj+0arscGYTgtEpF7Y_h=EFrFt_Yp6ERha5FbMMejs+Ajg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_client: don't include asm/global_data.h twice
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Wed, 5 Nov 2025 at 00:01, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Remove duplicate #include.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/efi_client/efi_app.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/lib/efi_client/efi_app.c b/lib/efi_client/efi_app.c
> index 9b94a93ee4f..da8e3432859 100644
> --- a/lib/efi_client/efi_app.c
> +++ b/lib/efi_client/efi_app.c
> @@ -21,7 +21,6 @@
>  #include <asm/global_data.h>
>  #include <linux/err.h>
>  #include <linux/types.h>
> -#include <asm/global_data.h>
>  #include <dm/device-internal.h>
>  #include <dm/lists.h>
>  #include <dm/root.h>
> --
> 2.51.0
>
