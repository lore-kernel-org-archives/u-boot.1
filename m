Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC7C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 12:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E40638215E;
	Wed, 30 Apr 2025 14:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iKOxWwRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C10782B45; Wed, 30 Apr 2025 14:15:03 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E2E82153
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 14:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7053f85f059so66657957b3.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746015300; x=1746620100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bH2H86GHi2QSCvk/4pj8iOTI6G14ddHgbpQzn3XUioU=;
 b=iKOxWwRa2zLlp97As2Eo6FP5x6VVLlHeYamtWJXN5C/fMbyUSaQROikEtSwoCb/+dm
 PK5q8PLs7WKWsXcuIGTfcJYuESG0VzxCevOqqi/1WMcCms8kVZ0iwagGtSzDhNbOavo0
 LSfLj9bK/GK2F03KgbegujzwAfvwna666GvlsmX9wiW3OHZDy8Bc/FryulNHpGv/Yc4T
 TLlFbsGvSzSmphw6Awf1xqREFaFGGG2dkUrC+Cs2kfUsNOyc1i1iDVY1Q6xXEFiJAc4C
 RpoXcfOBjXCaSJaQs0rgG3Yg6gEmrw7AXbYMxp39QHqafSNaGUuC4tTNt2Vmh5UQBLYk
 pWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746015300; x=1746620100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bH2H86GHi2QSCvk/4pj8iOTI6G14ddHgbpQzn3XUioU=;
 b=ue+cXHP86+uGUit9z/LENSw3O/Bub3pNOqpYzSrnwqL0+Cc98Ol1NaXj9TlngbSEn8
 Ph1Cu5jSHy6X46FBHk0+vi93HcZIamOLZsYAwmsyzu2NxIQi/Tl/L6zc+MXCcA1Upc+Z
 TyzH3pPfF0KDtxbogoAmAOTOgVpTVaH6IjcJYbutHzfTA3gXYwbcPozckfwxYm7ASp1q
 3d49MG5vh1ID4g4ROOo8tzkQY7FBsAMXuHYLBXlpIAsApZMCFXaLtr+XKykbAYY15BEE
 J1Xs1B50V3DSji3+zXoclRrWO7a/zZPJBGr2s/V6XT4eSRuXN9HJBUmsoDq0H0AaK9Yj
 tSZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWVquev3R/KrVtX34B/5n4DxeerD+D/v6JFyUJ7PeJqJ39AFDLozsc1QfTVLBGHKXGOP38T7c=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/I5AUpddT4DuQK8yAAUSjM6MdN6rGZp+sfab6yH80siTe+2zY
 Z+vrShB/mqZay1F1kNucRh257atottqhGjQ440Li+5S2v3ozdjjnyKVSIS3grpg19bVwbakQrci
 RN8CFzvVT3LT0Sql18pKKR0qOjHsD4y9xkYVJSQ==
X-Gm-Gg: ASbGncuTzj+hEEmiDxcwF5iyXv8NIcINJvOMI/G9NI2bSnVGa7XQ214xH6aIYWjjkFH
 03i3rXjuJcYDeRROSerJ7whRcsdnoYPEqNzBLarP3fpP8fP5wSaGT/idqmPbTgP4c26fD0UT0rc
 rR+CwvrNGVuPGpHqhqchZg3Ig=
X-Google-Smtp-Source: AGHT+IEdfYLMzpE38KCbb1XBL02OPOscPoUnTuttPZHIF4cwx5dhJWv5nnwvQLu7Ku3mW4e7wjT+9U3donItICnj0DQ=
X-Received: by 2002:a05:690c:4c03:b0:708:3dee:d76e with SMTP id
 00721157ae682-708abdac06emr40973687b3.22.1746015299957; Wed, 30 Apr 2025
 05:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250430105546.327442-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250430105546.327442-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Apr 2025 15:14:23 +0300
X-Gm-Features: ATxdqUE4BdhZXNbaPM7WPpuRNszT6lzTUzRpdysK94wID-UHEEeQrsqAnzLlbFQ
Message-ID: <CAC_iWjJLrz-NQ6xR_UAR3z31nwKuw6nWPs7+=iPOUPQtuvntLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] bootm: pass kernel load address not entry point for
 IH_OS_EFI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, u-boot@lists.denx.de
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

On Wed, 30 Apr 2025 at 13:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The EFI sub-system needs the load address and not the entry point
> to boot the binary passed from the bootm command. The entry point
> is derived from the PE-COFF header of the binary.
>
> Fixes: ecc7fdaa9ef1 ("bootm: Add a bootm command for type IH_OS_EFI")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/bootm_os.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index dc9d3e61fca..a3c7cb5332e 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -498,11 +498,11 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
>         /* We expect to return */
>         images->os.type = IH_TYPE_STANDALONE;
>
> -       image_buf = map_sysmem(images->ep, images->os.image_len);
> +       image_buf = map_sysmem(images->os.image_start, images->os.image_len);
>
>         /* Run EFI image */
>         printf("## Transferring control to EFI (at address %08lx) ...\n",
> -              images->ep);
> +              images->os.image_start);
>         bootstage_mark(BOOTSTAGE_ID_RUN_OS);
>
>         ret = efi_binary_run(image_buf, images->os.image_len,
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
