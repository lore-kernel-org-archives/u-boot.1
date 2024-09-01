Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B8ACD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2DD88C3E;
	Sun,  1 Sep 2024 22:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RoTFe++c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85EAF88C69; Sun,  1 Sep 2024 22:10:28 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B85D88BF9
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7cd8d2731d1so2241449a12.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221425; x=1725826225; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zWYexLFOJaO8Hh2VvfVAy/5aG39VK1BBJ52K4ryK4II=;
 b=RoTFe++caCUH9Wu9WeHKQ+daKltUv385Cg9fLpx3V/GBf7k7NjETuuMO7jtrNqbyk2
 z0dKVANBqNLGA/fPd62ylN58DR33f2uDRYyOOEU1k8A4z+wLIb0eOwGG17nGohbpdDLm
 SZUgnF3hYVUZLKu0ROYWItDeTu6K4Tre9z49I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221425; x=1725826225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zWYexLFOJaO8Hh2VvfVAy/5aG39VK1BBJ52K4ryK4II=;
 b=np8w8LR6IwLc/thKDRVK+wjhcGSkbV372DgSjZCBo8vZH0Rydl0DPPl8QKcMweVjob
 gylb5rbTBaiYhBHuzYC1DtakoigksQjjpm81woeOhnWLKRr0B095he+0LDnCCUeSt8ow
 kHsOoGHr1MN39tsZozWQq3GdhnBTOxPb6P9OlvVPEO9NPB4KbjFPBlACWng1v9hSJeUa
 tue5ceIDi66Wy6nbgi85Ov9L75CFARGw4QKf3x2fv0xHExo7KCUyZi6DavakApRhcSWi
 lKcV2m2N8hTRltmcL7r9B+ho4AqWLz79pDjAXI/3x3UA8ojzoOTtflIE/yyFxqNMScy7
 WsLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlneyMxkDAL6yYLgbw1EF1wDYlXLtkwnRrlgME/XqEuNqiWAzOjNg2Eq/5fzYfspHKRqF0Vds=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3AXDlBnvt8+6B832/6Z1bHJelE0gzu8Am7XGDw9htF8uFnmYu
 8GBAedssXG4Cg4s/GoQivQynKvJRgwMa6YoUBvPfNjRjqCCZgWS2w6evFKLG9MFr0bIhjqtLJfJ
 bS5hmnsMeU2+uobujKcSI3fjqCB2K0VKp0RCP
X-Google-Smtp-Source: AGHT+IEev+3nc1p+I/nx/JWqrgIhDbMwqndY0bAky5bsyxAybr+YU4iwUXu2H82YHF0x3EOgE0QzCcpq2y4tQpSuLD4=
X-Received: by 2002:a05:6a20:c6ca:b0:1ca:da81:956c with SMTP id
 adf61e73a8af0-1cece4d72e9mr4834682637.5.1725221424797; Sun, 01 Sep 2024
 13:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240812205638.1732159-1-ilias.apalodimas@linaro.org>
 <20240812205638.1732159-3-ilias.apalodimas@linaro.org>
In-Reply-To: <20240812205638.1732159-3-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:10:03 -0600
Message-ID: <CAFLszTh28_iHQVDcCoWRsSwSu4ZtkaNEitFoN2EAvkAjeRZdng@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi_loader: return the correct error in
 efi_bootmgr_release_uridp()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, kojima.masahisa@socionext.com, u-boot@lists.denx.de, 
 akashi.tkhro@gmail.com
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

On Mon, 12 Aug 2024 at 14:57, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> There's currently a chance for this function to overwrite an error if
> one occurred and the subsequent call to
> efi_uninstall_multiple_protocol_interfaces() succedded. Although this
> is an EFI event and we can't do much let's at least set and return
> the correct error
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/efi_bootmgr.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 03cdee15017d..a3aa2b8d1b92 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -388,6 +388,7 @@ err:
>  efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>  {
>         efi_status_t ret = EFI_SUCCESS;
> +       efi_status_t ret2 = EFI_SUCCESS;
>
>         if (!ctx)
>                 return ret;
> @@ -407,17 +408,18 @@ efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>
>         /* cleanup for PE-COFF image */
>         if (ctx->mem_handle) {
> -               ret = efi_uninstall_multiple_protocol_interfaces(
> -                       ctx->mem_handle, &efi_guid_device_path, ctx->loaded_dp,
> -                       NULL);
> -               if (ret != EFI_SUCCESS)
> +               ret2 = efi_uninstall_multiple_protocol_interfaces(ctx->mem_handle,
> +                                                                 &efi_guid_device_path,
> +                                                                 ctx->loaded_dp,
> +                                                                 NULL);
> +               if (ret2 != EFI_SUCCESS)
>                         log_err("Uninstall device_path protocol failed\n");
>         }
>
>         efi_free_pool(ctx->loaded_dp);
>         free(ctx);
>
> -       return ret;
> +       return ret == EFI_SUCCESS ? ret2 : ret;

Reviewed-by: Simon Glass <sjg@chromium.org>

I would love the EFI code to use the same if (true/false) that the
rest of U-Boot uses for errors, e.g.

return ret ? ret : ret2;

Regards,
Simon
