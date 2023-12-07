Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FBAC4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 09:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F02D86F64;
	Thu,  7 Dec 2023 10:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OcYx4E2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A128B86F64; Thu,  7 Dec 2023 10:27:25 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D60286F40
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 10:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c9f8faf57bso6013911fa.3
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 01:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701941243; x=1702546043; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=anMyX5qoGAKhV0CDbmjKV4iqEKR6F13IMg9kfUrwWLU=;
 b=OcYx4E2PfaqAWoyBb2+DJFtjziIsEGoEd6B1s8BFtyXOjM19bJGOADLNqd72O0JsPL
 1K2a5orAICvwrW+IOvWhTYTdgHt72Mu3qt4UXAttoo58X3A2DEwdfS43/TBBf3i8GxcP
 dsV9uHqPdBdWqG8u9PeJkjzbA7+ntmXaatljeuWXeuyxa0asQzfY/GbmvEXNo+sfGeri
 z8shLTe5iBnRWlOLf4BjYGYDNN4Kcra5wIVSepUBYj2sF/ZANXnV/fm9jgi3m8+McyM7
 gg0uIMtVyj4MA41hz6ZQJXCgqwv0BENLmTzzW+Ag06GByull5tBPxmDsAogTCKg1PgdM
 M+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701941243; x=1702546043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=anMyX5qoGAKhV0CDbmjKV4iqEKR6F13IMg9kfUrwWLU=;
 b=rxUzZR4U5TR/yjfSvBtHhW3xq/IILkyw7rgqkGDp3w3vSGVOLyqPMnKGxuLKRpgl85
 uEW13U3MKTRL0aZ3BDmiA3uSSJx/CVm6Q0Qa6W8v5SmVJ9q7uS9FAN29wnJKYJu53rJ7
 0xom8HcCPxvFphi9+mK0MNwR47DL2KRy6Dyl/uZn5+5su/VfhLwLnvz9CO1xZaz3Lt1T
 3hK2FGLdt53XFOqNj0RWsGmY6XM04yiIC37Wz3v0hvKwBh1Fn7WpUbXe4FHwq6ecEHNZ
 J+cjAzS99gziEfM2eR6PMNSuFwBrwVZ6AE/QN+oO5yjLo2TXSvDf5lTm/ms1D8YQVsoM
 ijRA==
X-Gm-Message-State: AOJu0YybIAvxRhqEL1puA9D4KcBXNVJUFX7x5isv/uWJEVQAyl473O9L
 QJRDpmJW3Ml8ATW+GV38OFF2SQhAKdn3lnf6JXu+JQ==
X-Google-Smtp-Source: AGHT+IH77TjTg2/aRuIf9SUxghSqQTO+5kqqSfR+cpDe1sD5RaJsU9/WvOHPJN3NchoDNpDJ0zKvneTcHK5MiF8DH00=
X-Received: by 2002:a2e:6808:0:b0:2c9:f6e6:fe3e with SMTP id
 c8-20020a2e6808000000b002c9f6e6fe3emr1273020lja.49.1701941242835; Thu, 07 Dec
 2023 01:27:22 -0800 (PST)
MIME-Version: 1.0
References: <20231207092012.17914-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20231207092012.17914-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Dec 2023 11:26:46 +0200
Message-ID: <CAC_iWjLSjrcA_cAMk1Wv2QcBnW8KN3PRKQCm88CPjmPNyXWhSw@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Fix a memory leak in the efi manager bootflow
To: sjg@chromium.org
Cc: heinrich.schuchardt@canonical.com, Mark Kettenis <kettenis@openbsd.org>, 
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

The patch is needed, but I forgot to include malloc.h, I'll send a v2 later

Thanks
/Ilias

On Thu, 7 Dec 2023 at 11:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> efi_get_var() allocates memory which has to be freed after the value of
> the variable is consumed. Free the memory properly
>
> Fixes: f2bfa0cb1794 ("bootstd: Make efi_mgr bootmeth work for non-sandbox setups")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  boot/bootmeth_efi_mgr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> index e6c42d41fb80..530ad09cce83 100644
> --- a/boot/bootmeth_efi_mgr.c
> +++ b/boot/bootmeth_efi_mgr.c
> @@ -65,6 +65,7 @@ static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>         bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
>                                 &size);
>         if (bootorder) {
> +               free(bootorder);
>                 bflow->state = BOOTFLOWST_READY;
>                 return 0;
>         }
> --
> 2.40.1
>
