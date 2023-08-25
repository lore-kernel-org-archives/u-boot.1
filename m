Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BEDC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26DD86B40;
	Fri, 25 Aug 2023 20:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DUSY1fzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6770286B5B; Fri, 25 Aug 2023 20:06:23 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6507186ACC
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so1747776a12.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692986780; x=1693591580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vvxwbF3NImOeLgO34N6QbHfI7/8xNpjTFLgOYaPpHWo=;
 b=DUSY1fzMEcpG1TTIKelJ8FecG2TWoNcHNe8pHT4d1W9SYAsh96UsqHhJWY2qgnYhhX
 C5f2MKGN25JCLq0eEg0XcIY7J0uJHEzj06t7/p1i9duFv/Td7YoBH1EjQ8owu1CSMYW+
 X6uypOpXzBrKGQXxFevqB6ktAVBtol1b6KiN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986780; x=1693591580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvxwbF3NImOeLgO34N6QbHfI7/8xNpjTFLgOYaPpHWo=;
 b=Uxk/zpQ3NFp6Ow+9PHL+Gmuad4VCCfZfA5RCPkmX3H3te7XqOzr5v0NSRCnV4k54CP
 QcJfb5OBVY6UWTaQrWYLOdcPt+3GZMz9ll3hp0ztz3V9HsYltYxKoiiTtRQAAT17IGZ7
 L/fh45+YbcYviYjYzg+ignmjMQJkOaoyCjDdU9fu9ZnTXFCmlrG9H3OkXj3OYXDl7ogh
 szyGWiabKBOuy/s+hCZ5UOR6vKrf8BI/QfQaNz6uoc2UMd2p+7AjtcezbsaqIuzsR2ti
 px2B7JpuV7VsZ6it9mNoEhYJeT89kJJO/TqBJGlDD+Rirt7w8rWMCUaxf60mVRoulgjn
 429g==
X-Gm-Message-State: AOJu0YwN2dxnd5HwWbqeytG1EhP8V5IOoygLijTj+mKAiOnSYqGGBVic
 ru0sXeCnRQMaQOrbisX6FjZII6JaTXKzM3LFQ3kdvw==
X-Google-Smtp-Source: AGHT+IEUAdeMWqupa3nK4qO+kbeL6v9Qn6suH3Z2AA82uM+MNZLnInWyCsR8OU4AK82TCpl9ltKddcYeDdxMd8QiUps=
X-Received: by 2002:a05:6402:b0e:b0:52a:40cf:4dff with SMTP id
 bm14-20020a0564020b0e00b0052a40cf4dffmr4635732edb.9.1692986779727; Fri, 25
 Aug 2023 11:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
 <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 12:06:06 -0600
Message-ID: <CAPnjgZ09Y+tCq8X+Hx1PpM7c2ya9KXqLy9EsrigqcdAqkgYPfg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] TO BE FOLDED: x86: tangier: Add FADT to the chain
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
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

Hi Andy,

On Fri, 25 Aug 2023 at 07:52, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The Simon's patch missed the FADT to be added to the chain, hence all
> the issues on Intel Tangier.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/cpu/tangier/acpi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
> index 01b30553818c..ffaa56ab6f87 100644
> --- a/arch/x86/cpu/tangier/acpi.c
> +++ b/arch/x86/cpu/tangier/acpi.c
> @@ -52,6 +52,8 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
>
>         header->checksum = table_compute_checksum(fadt, header->length);
>
> +       acpi_add_table(ctx, fadt);
> +
>         acpi_inc(ctx, sizeof(struct acpi_fadt));
>
>         return 0;
> --
> 2.40.0.1.gaa8946217a0b
>

Thank you! I really don't know how I missed that, after starting at it
all for an hour...

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
