Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265D4C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E05E87253;
	Tue, 21 Nov 2023 21:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oKkgJ81f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDBA3871CD; Tue, 21 Nov 2023 21:31:14 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E6587545
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507a62d4788so8508441e87.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700598672; x=1701203472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SJUUYI0pxLy9lxzu1tQXDNkgbGIFabQfT+xBbymbfyU=;
 b=oKkgJ81fg7wwnENLO3YZrqX5073m1rXHJj6V8tIgGjdktm86va7eadBozJ9rU2U376
 8vgutP/2VaHW9vLofipwC4EodzCITEw6csmikoscxzQU9IfnKZ30rWj4jTSFjJBuPjiW
 urZRuCFOzt9yJ3fYNeI97Ow/fpcTGJr634crw28zrFtgZf85brD0f2szu046km22SAdm
 LKKt8VyveOHCUTno0KfR07EA91bl5edj2WkmR4QyREOBAiY9QehcuPZmPS5k1HySYPfU
 0KNbO5vB3+DWwieRhSfJZRqmY/GILYQTvXYAO+BDmKyzsYPKAUmIWvMATobE8QDi3o4/
 KeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700598672; x=1701203472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SJUUYI0pxLy9lxzu1tQXDNkgbGIFabQfT+xBbymbfyU=;
 b=az6FB7o2STWmTQLwvJJ+GkLlGRuTQn6KKu0c8OzABISVOiOmqFuZbYP71PZ/jfUAqx
 etQPYOMTg84LKrb0tS27oJfIvibRuX3+PUh2VWKAWnDyv2Wjn/j6f3Qn6U7UcfZS0NZg
 l5yeGzzJxZp5JEcwsFN3eqqArxq2RirnGBCagyLoiEXR0m0wA7BYCHEg79mwuK95mWhY
 khTE7SFJ0Cv9VZCv6stmDfyTyRpMfX2aiXL8+2rBZ4gvirIGTRCufP5LeTHGAcyqA2Ob
 QaHJQ3DN4I6Y4cV/aIMi1KkhHfD2UMqgJ4I6N6vi/0Y32hUPywOAXD1oXIk/MmE4YfFH
 ZNcw==
X-Gm-Message-State: AOJu0Yw6kzsNPKHQbVHBlb2XUZI2AKg6sO0cXhUqmSttqhFQoYVME4WX
 CR4xwziXcTAUIAHUTcH+NTeXMZNq5YC0LRy1peDa/g==
X-Google-Smtp-Source: AGHT+IGGiQRrRfExIxYhQoNDu4cjKNQkIR5KCVv5EdV8gAIRDoqPRFk0Ea8Ke+MXB2UX0nHog/9tUu1DEYcSLENZu9w=
X-Received: by 2002:a05:6512:360e:b0:507:f0f2:57bd with SMTP id
 f14-20020a056512360e00b00507f0f257bdmr180700lfs.66.1700598672134; Tue, 21 Nov
 2023 12:31:12 -0800 (PST)
MIME-Version: 1.0
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-3-sjg@chromium.org>
In-Reply-To: <20231112205516.183410-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Nov 2023 22:30:36 +0200
Message-ID: <CAC_iWjLayn+6dBCANQwzU6+GevHw4FBwdRrMz5Qwc+gLPGVggA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi: Correct display of table GUIDs
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Sun, 12 Nov 2023 at 22:55, Simon Glass <sjg@chromium.org> wrote:
>
> The printf() %pU option decodes GUIDs so it is not necessary to do this
> first. Drop the incorrect code.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  cmd/efi_common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/cmd/efi_common.c b/cmd/efi_common.c
> index f4056096cd3f..1aa2351fcdfd 100644
> --- a/cmd/efi_common.c
> +++ b/cmd/efi_common.c
> @@ -17,10 +17,8 @@ void efi_show_tables(struct efi_system_table *systab)
>
>         for (i = 0; i < systab->nr_tables; i++) {
>                 struct efi_configuration_table *tab = &systab->tables[i];
> -               char guid_str[37];
>
> -               uuid_bin_to_str(tab->guid.b, guid_str, 1);
> -               printf("%p  %pUl  %s\n", tab->table, guid_str,
> +               printf("%p  %pUl  %s\n", tab->table, tab->guid.b,
>                        uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
>         }
>  }
> --
> 2.42.0.869.gea05f2083d-goog
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
