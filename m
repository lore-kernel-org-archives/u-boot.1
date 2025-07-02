Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8F0C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A1581FEE;
	Wed,  2 Jul 2025 08:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="owpPjmdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003158003E; Wed,  2 Jul 2025 08:16:40 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914FD8003E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8600c87293so4849528276.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 23:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751436997; x=1752041797; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uJbTdrKVQVKTpTq/l69l2kCPMgUNj68LzaKLUiD0ngg=;
 b=owpPjmdc+oscbaqXz5xwqKQmNUFfJegL2gXmPJYSkVD4F7WnAGzqpYUJ2wcutljUVV
 Vt7Jhg7NocrdQMH9yz15fLQ5wPBKKc07QhdE7EF42t7GnSlfK4AzS9m/hifWaQmoASu5
 WilpDRZsEjzp8izYw3qR/1NUbspUzqbfhUhdqIw4tIwgSwkaOuRtbvf9/6gqaalKwfc+
 uHj9F2+wJ9Jw2y//DBw0beh/gmwBGeAxHZduL1c+kQxBvs8sw6L8wTcJ95jxPy52HsJJ
 39ozBGrIOv0/m02gnqxrrdoDpE2oKacRGmmPkZRWxtrPxx8BPMXNyP3cy0ZXjm7+tvjh
 PSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751436997; x=1752041797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uJbTdrKVQVKTpTq/l69l2kCPMgUNj68LzaKLUiD0ngg=;
 b=iocmPPqXTjz/16+sw60bliBTRTYzgzo+xPIAgDprYI9jcdC85/qNECC68XvzNolU1s
 qBpkxjXheppFsRC6shUgGm05/hHl6HpUMQ0k4pmrmwWtWIzsV0/TbRQsJbA7JtRxlemo
 xbtU36YXIDlD5+VNfuchvFDI+IM5ESTAdzbsXc6XHhnG+8IRvmYoqn4znrXxWJuQWHNN
 oJTBcwvAKciGLAJdyEoNfQtScQ5dMcEan10+CPsvL0bIzXD1YfeoRKXbjR7YxLS7FZMk
 OKIs91C0AJQoL3swuMdAJ+9dQ+IdDG9pQxuFCKY015So0Q6/2K5svu2BRLIuxjpeGhyx
 r3bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9iS3DxYjrljbxRgvkgsadUZoGZmSw3VSa+3GS2M0loShlZbtYuUcNRvGnUcJwDYLOjokjoQA=@lists.denx.de
X-Gm-Message-State: AOJu0YzzTuzWskCB+eyE7bcuGJW2rGO07Z/uOkZJ6BnRIymqP18az/Cv
 2JdFqtZith8kydTJvC5duu+lYI5F0DretiQ/OtvhzVGwBKmu86m84VxPEwcoV7uGzBEiphTQNDT
 xFBZrDoV2jSF6D4eWZiO8RNj7TEr7tzAMhCsJBGMKqQ==
X-Gm-Gg: ASbGnct5Xs9yVtPCxdW5L7eQkNK/W4OyGjVfaNkvojrwHK3CpSCzzdSkrwkYVF/gNyV
 p8zeJogD0FaijC7VTLM9rLREtHNEwzNVIqLKAixbAo4aoPPrxKcPIXuv9R/t6g8ccXLsIUJAbhY
 MZORQEpMe6SbtVUXSAW32ig9MnzizR8SI6qARsj9llVIWJ
X-Google-Smtp-Source: AGHT+IFUMs/wzkKxSGHW+gNCCW9dM7LR3C33sJ7LDtOnIPuL6Hhh+vXtFP1fQh7zB5YHs+RQ8wGhGYUf2quekIBBE8I=
X-Received: by 2002:a05:690c:386:b0:710:e4c4:a92f with SMTP id
 00721157ae682-7164d305daemr18669597b3.5.1751436997393; Tue, 01 Jul 2025
 23:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
 <20250701-efiloader_fix-v1-1-f3c6e0b0ae43@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v1-1-f3c6e0b0ae43@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Jul 2025 09:16:01 +0300
X-Gm-Features: Ac12FXwrgRcXJAFc7dhWuXerXEudL_oOFJaGrr5utQCFG2lUIckC-9VXEpXSQeM
Message-ID: <CAC_iWj+417OyufQGaf6J8KcD+z5kQB77=N30ToU-MWw1mL-Ldg@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: Prevent dereferencing NULL pointer
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, 1 Jul 2025 at 16:38, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> Taking the first goto error: in file_open could either result in an
> attempt to dereference fh when NULL or else free fh->path which has
> not been assigned to and so will be unknown. Avoid both of these
> problems by passing path to free instead of fh->path.
>
> This issue found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/efi_loader/efi_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 7d81da8f2d8..19b43c4a625 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -248,7 +248,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
>         return &fh->base;
>
>  error:
> -       free(fh->path);
> +       free(path);
>         free(fh);
>         return NULL;
>  }
>
> --
> 2.39.5
>
