Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BB7C369CB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 06:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A9D80FDE;
	Tue, 29 Apr 2025 08:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ufi8QY6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCB681E0F; Tue, 29 Apr 2025 08:26:02 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49B88091A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 08:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6ff4faf858cso39400117b3.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745907959; x=1746512759; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ocWzuE26U+KlK3ggpr5Bz18OGE5NBXNOneVJW9UR5rY=;
 b=ufi8QY6xNnkwdCpfxS2dCfOkNuys33EFKKi7zQErCHd0/0tSYznOOCkbFpe7fMqrYF
 Di40Hk/E/5DAxyLBieklx1iYOrjC8wxH/h/rsEVtf5IpC8QhROcCjSvL4XVaqRkqc0Ha
 Cn1TPWvN4eR+/gw5+WoXjcXhPADjn3sXF/7Uo3uUeubk4K/Xv3LmOeUWCKotUOEwhJHS
 WrNUBXvQmnTo6LcuCLJM4W3JjMMCZEXToL+EUQVx56BGZgJQ29vzd84p7+IB4f2au56m
 h8ao5+38VzjvoWs6dh6CaGd3vMHvjdvTQlE/em17Cz6+n/hdHxzy0+f1RbENYD053m0C
 +pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907959; x=1746512759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ocWzuE26U+KlK3ggpr5Bz18OGE5NBXNOneVJW9UR5rY=;
 b=QBW+fVgDzd40yc/jy4XM230vK9roevDwJikNzh9RPQrCnIZWk+fJBkMPPWnfhoiskH
 b6fVsSrAsoGA9WYJinA5fmGk5Xu0P7d9h57w7J7jFK94NbGfgqBFcUeRz+DeoSenpHXO
 IUeq0KvSbjwzX+qET309OxbIDgzN/eO1r6KJBij6UxaNsXJ+oeqRqcLnUIpkNhA5ds39
 l6oIu/A5PPx/mo4DCsJJhfbiIH58cGpRA+YzmAxzE/1sQbM/WX8CCzhMT1D4yKr34moF
 p+wNvBpFLG0mEsGfNntVkPeOiHmkEClr47ZJ/un0p4tQoZ/qajKL1T8r4VoHUla8FMV/
 X/qQ==
X-Gm-Message-State: AOJu0YwZB1Hfc6WMaHZQDBdtCCu3OGX2QqXLOGhdS+fmo1nmoeYVa004
 zoK7VbbZtzMPx4mnO8bD/L34ncjrAovmkvdnBF1zQcQAyjw7Ttt+gWuD8ufTFQcGuF6izx8xwg8
 +yF/lhClGJ4tyxEozPPylYKTWs3NNkNpSJDrzhw==
X-Gm-Gg: ASbGncvFKqMOUvTE3DW9JSXmbmJn40lppJVxGCsXLsXwfUaPzNSI6uHG6lF9bdygUZq
 Vlb2MEQFKeyTqZMVypReaRVgYKCHUoN2clEnkeeL5eVBBDLfaIAvWLlSt/i4r1LvmVgRC1TJMan
 uXcDJtF6hoshCsdeAgrmA0/7o=
X-Google-Smtp-Source: AGHT+IErUH7jseD7SKIrtWQL1jWLMiseDw2vIFO6ZGn2WFoIhyCtxyFm/jWHYo0ljDYnBC2L7aB6noFFDAmEPuy7DWs=
X-Received: by 2002:a05:690c:6510:b0:6fd:3d37:99ce with SMTP id
 00721157ae682-708996868b6mr36777137b3.17.1745907958737; Mon, 28 Apr 2025
 23:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250428145341.2091400-1-adriano.cordova@canonical.com>
 <20250428145341.2091400-3-adriano.cordova@canonical.com>
In-Reply-To: <20250428145341.2091400-3-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Apr 2025 09:25:23 +0300
X-Gm-Features: ATxdqUGHESQYCNwFR6qQ2_XwZrT-H_pOo2VSdZWalkOe9Cmu24-_1zEMUNm1N2E
Message-ID: <CAC_iWjKDqCWaOQcjOF5j_NvhxByKJhciv0LWxXLsBXyXdTLcMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi_loader: fix typo initd_sz to initrd_sz
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, o451686892@gmail.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
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

On Mon, 28 Apr 2025 at 17:53, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  lib/efi_loader/efi_bootbin.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 6a189c31ffa..94ba7c5589b 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -215,7 +215,7 @@ out:
>   * Return:     status code
>   */
>  static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
> -                                     void *initrd, size_t initd_sz,
> +                                     void *initrd, size_t initrd_sz,
>                                       struct efi_device_path *dp_dev,
>                                       struct efi_device_path *dp_img)
>  {
> @@ -233,7 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> -       ret = efi_install_initrd(initrd, initd_sz);
> +       ret = efi_install_initrd(initrd, initrd_sz);
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> --
> 2.48.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
