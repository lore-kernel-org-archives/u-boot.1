Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BC8EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 09:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7304B8704B;
	Mon, 21 Aug 2023 11:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KidaQkqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F14038704B; Mon, 21 Aug 2023 11:26:06 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FD0587044
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4ffa94a7a47so3320137e87.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 02:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692609963; x=1693214763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GDO6stohmPSfYYp6X6AjxFdXEOkZFlgE/dxaqSUoIgw=;
 b=KidaQkqrSnDMAspTvaqYFiZqedJQtZBs2pGzMVa7mvwL/7F6kBbMFR/BCI1nkWchfD
 iwaobIrRLaisnJGptymjN4Oq7dstWCscDzzQCIXf4ZGmrowTrQLNiV1AEHQRY6U5Bx3X
 h5XPMJ9BgDQWjHqXSIq2zb4qiL1vKqoUQP+6qEZhgeoKV8V4G5/m8Vky7cLLoIeXotP3
 3AYp3SBMjSCzMxKDmr6F/81BEOZslF/Z7/2Kj0jsDz8654Xl9EIDT07nRiIvarSkANrx
 5FSeP3ksS0KT0d5nm2px6lrqD6IQiNS37DuDgXIiyIfNovGa82x6DqwKkpC2Ah/869cH
 eJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692609963; x=1693214763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GDO6stohmPSfYYp6X6AjxFdXEOkZFlgE/dxaqSUoIgw=;
 b=lnGHgvUNAJdqwP2OHIr9VBhE3h8z7DgWjKXx9TdLhj/Wqwy1NcWu+W0BbeEMmwRJIB
 F8Ddx1gDPojIvgNoo3eosDaFJzV02WGSvVW6Tk2hI/MsSznWf5UXt8TRGGLba7MVr2JB
 F0MjJxtWOsJDSDcV5XONRHNesMWJM4QPXlYHYcY5f5pkdc7vYqgdzxneiXhcAccwTdDu
 jijWh7xVR55YG4AzmVtEYBuxoZRHzCvRK32q4PDWJn1C0LDXnLGM6Cd2rUXLJXTNr3ev
 RzD4Jm3wyLlPKrda3BR4lGsy3VWD9K0k8zD4v1jId8m3zm/RoOWzYPhW+u5/ZOJ3oL5J
 XMiQ==
X-Gm-Message-State: AOJu0YyTXj7K4mAx3onxEWJStyQKyCY6+Q63wRkzCdAEed7lyZBvVsBn
 9RI56jhrAObXRbpzRFJL25Xhlmut4aQA3xGCARCnLA==
X-Google-Smtp-Source: AGHT+IGsYYRgvQsMi1dwJa0zEHgCPZbmCqGERTiuIXM11NHhaq8f81+maUtbIThF+H16cn/fYck+5Gg2WPBbsNdoMQ0=
X-Received: by 2002:a05:6512:3b2a:b0:4f9:72a5:2b76 with SMTP id
 f42-20020a0565123b2a00b004f972a52b76mr4096060lfv.65.1692609963562; Mon, 21
 Aug 2023 02:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230814060131.13309-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230814060131.13309-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Aug 2023 12:25:27 +0300
Message-ID: <CAC_iWjJxHt6taYYOA3c1o-0xMfLXUaVmBfwXDRGUiCSuN9Orqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix efi_add_known_memory()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Mon, 14 Aug 2023 at 09:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In efi_add_known_memory() we currently call board_get_usable_ram_top() with
> an incorrect value 0 of parameter total_size. This leads to an incorrect
> value for ram_top depending on the code in board_get_usable_ram_top().
>
> Use the value of gd->ram_top instead which is set before relocation by
> calling board_get_usable_ram_top().
>
> Fixes: 7b78d6438a2b ("efi_loader: Reserve unaccessible memory")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index ebf4a2d5fa..f752703b43 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -877,7 +877,7 @@ efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
>   */
>  __weak void efi_add_known_memory(void)
>  {
> -       u64 ram_top = board_get_usable_ram_top(0) & ~EFI_PAGE_MASK;
> +       u64 ram_top = gd->ram_top & ~EFI_PAGE_MASK;
>         int i;
>
>         /*
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
