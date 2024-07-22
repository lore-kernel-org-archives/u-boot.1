Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A06AC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 06:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8051688137;
	Mon, 22 Jul 2024 08:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wXEh+F2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D7B88246; Mon, 22 Jul 2024 08:51:19 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287628800C
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 08:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc587361b6so28893365ad.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721631075; x=1722235875; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=btQaOPHtmuAudZ573Bafy7rDU35o0g26Hj8gTwoaHCU=;
 b=wXEh+F2CKSvefIKTilGoMdx4QY6YvbtUZcOA4xr+/pqjXGj2JZbPssI32zRFZw0QHu
 rDDgSzNOE+rM+yZxgTIfvIx3Z12K1brQ3gFcahCwCHBjJ1ad8SnpJ2vuk9ham3lXK5Me
 5O/Zl12ndqhfoLVoJj/H+AHpzI5AWW2nHCeCZDShbEVEiK94Hx3kxW3YAmLexE8J3a6c
 A5/7BSoshoMxPWqKamA3wefFpSlcz6bjEq5JmrncjkAiUSCKT097q6Z2LOZXIHvdvLlY
 9W2feBjnpCdzpXIGGrnwla2tQmVdR9AOOper2NZYNvYpPnSo4M3L4+8Z6sQbNL1cLlR0
 LSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721631075; x=1722235875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=btQaOPHtmuAudZ573Bafy7rDU35o0g26Hj8gTwoaHCU=;
 b=InNSE0u0jW527ZgByH8QMfqL5U+qrVxO+QV5GisQryltaohpVTPyfU6HSnD6Ib7V/M
 wGBLFUnjCdCfx2kSm3eX695w4LniHiqyYw88mfKnP50X6qk4Aca6fj16/q9QzauPmvxo
 e1CHRqLoXkFEO5HTP89uCQwSxy+W2Z1y1lAEkTA4dtzjvlU6CiqATH0v3gGBA+zZS/tO
 nOIb/rBJ0BQASmI9QO/dTwaFjANeT6vxV+fBZdZAGe9Q68DDFFDtjzS9NKzKfWIpRLq1
 SKM6HDkbqUeWPudHzYYjfsOZETsVm4zjxR4E1VwkYHxMYjS6Qer2io2/DrKg0siBuP1M
 x0QQ==
X-Gm-Message-State: AOJu0Yx+K7xzWaqOl9FUq5tCDkYBFyItudLksc0SYOdbsC0btBEGEPuG
 6JiTvBJz4Anqt+JuJzHd4QVKMvXMrOb4pGa5z0VxxFWtItCVskqMQP92BQibfkawFy8MAVjxuQJ
 1V/JHf+1BjY/3EzWVHTiYdI2+cylsrYOST8qO4g==
X-Google-Smtp-Source: AGHT+IENdrWgkRqF3E0rjPJcc9uyJMrXCEqDKuzQBaeIn6SO5KKHqOtIU2w9l0PwXRIaVaoVPMmy/iOnAuUw/e1/6/Q=
X-Received: by 2002:a17:90a:ba97:b0:2c9:9658:d704 with SMTP id
 98e67ed59e1d1-2cd2751d66bmr1993121a91.40.1721631074523; Sun, 21 Jul 2024
 23:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <682c714d8b39b3ef0a12ec3d824475d630b17e11.1721138209.git.michal.simek@amd.com>
In-Reply-To: <682c714d8b39b3ef0a12ec3d824475d630b17e11.1721138209.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jul 2024 09:50:38 +0300
Message-ID: <CAC_iWjJiJ=AZcbXRgCe2mQdNr_5CfDmKwtp06CT-ezwhj1QK3A@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Fix typo in EFI_RT_VOLATILE_STORE description
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 16 Jul 2024 at 16:57, Michal Simek <michal.simek@amd.com> wrote:
>
> Fix typo in EFI_RT_VOLATILE_STORE description.
>
> Fixes: c28d32f946f0 ("efi_loader: conditionally enable SetvariableRT")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  lib/efi_loader/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index ee71f417147a..41bab4f1ad27 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -67,7 +67,7 @@ config EFI_RT_VOLATILE_STORE
>         depends on EFI_VARIABLE_FILE_STORE
>         help
>           When EFI variables are stored on file we don't allow SetVariableRT,
> -         since the OS doesn't know how to write that file. At he same time
> +         since the OS doesn't know how to write that file. At the same time
>           we copy runtime variables in DRAM and support GetVariableRT
>
>           Enable this option to allow SetVariableRT on the RAM backend of
> --
> 2.43.0
>

I don't think we n eed fixes tags for typos. In any case

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
