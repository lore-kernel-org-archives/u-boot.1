Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E610DC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A00088356;
	Tue, 18 Jun 2024 17:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fQ90A8wr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C618D88365; Tue, 18 Jun 2024 17:55:11 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3778834B
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c4c7eb425fso4535851a91.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726108; x=1719330908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0EjajZNRbnAqCFIdtvz3Q/piIRZrwRtJoEh2Pd1SUaQ=;
 b=fQ90A8wr5HYTwhtg6ZI2aKEbD3TZyz4JMMPSIKutVAeTfHzZ61Tsx29pnh+qVabcn2
 ob7lbopZ/DsUjHgbGFAhveR0BZyelK71xI6idExAUYkWFLdKmgn60g33JMf49FBPaaIB
 nQD4+XmFw4O+bw1brZNb3CVok7gcpeVUTfJpWQOsZNjvT/N6FXBOOXu9GR6X7XNtXgTF
 f1iXBUKIYawlQnYNb8WtnwgMMSLgnI3ATOG4HxLqzs+You5abs9dMa6MPZy3dq2xdxck
 PVDi1PTuWTWXKXSVbn0E9fmDjgn+gjc+5GyImEZ36Tbli0vo1VvVXMIDKYIWjXpL49FV
 nV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726108; x=1719330908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0EjajZNRbnAqCFIdtvz3Q/piIRZrwRtJoEh2Pd1SUaQ=;
 b=tBrlEct7HplumN9xF5CMAOk7Fr6ZOCD9QU9ssae0IheQJVLkAuA7RTrDxhUcrtGTzL
 0XbVrWKYAxPr4vgEwfwMIXBfeNsi4+rAstnG2Fla0mA/OY8qCqhw0sVVheGkauP/JOMR
 RgpyJVgmW76yM7aQdzq9/2iH1jMfYzVWXmQ/jkJlE+1qGwFogKyL1Oty6Eq11RFrz7Rp
 bsiAph6lrt1z+ygbMrHPajfunnbKkrmc/AUcPxIfWponj8X9zAG456BTpwzfVm9c+dTS
 6SOXtsqOKms4oGh7I73eWzxFXSjnvk864QwqD9ZNBk1yPApI7+BEEKl9nVaRCHYklfIZ
 geqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsx7/uL91wV01eEHnANUH1XbBKspUBqdE/eyM3dxEw7xS5yCKguc2QAbO+p9pxyYOVdvniF3ZdZGUr7PqBUy1vDhbacw==
X-Gm-Message-State: AOJu0YzaWgemif+Pf5fBZlPEAsELsx5GnkVpshgmzjXARLZ+NGjIJ6DK
 myiSimy/EIzVwpZQ4CNgovK5tQhJc+TccGtRrDXj8mP+0ccKs+doS4tADnbUSkpNTYI5R3J3C0X
 RqzeIwBknXYc/ZCUsZEEsEv8gNvMhnt1e/azrtQ==
X-Google-Smtp-Source: AGHT+IH17BcvVp8aps6aDDVv6a8OwzFnJT/u4jkYPaY7D2xjhvL/pGVBYO9gj2PRkZeOmXnFiM+yt+YIdSNkc0Sw8MI=
X-Received: by 2002:a17:90a:be10:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2c7b5b42405mr112617a91.11.1718726107778; Tue, 18 Jun 2024
 08:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240618122348.126196-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240618122348.126196-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Jun 2024 18:54:31 +0300
Message-ID: <CAC_iWjJgFhAaDQU2TucwmG7rpwkT2CUnHg6zKrkaeEJNub4e-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: can't have measured device-tree with
 kaslr-seed
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

On Tue, 18 Jun 2024 at 15:24, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Test that we don't have a /chosen/kaslr-seed property if we measure the
> device-tree.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_selftest/efi_selftest_fdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_fdt.c b/lib/efi_selftest/efi_selftest_fdt.c
> index aa3b13ae3ab..066d9581432 100644
> --- a/lib/efi_selftest/efi_selftest_fdt.c
> +++ b/lib/efi_selftest/efi_selftest_fdt.c
> @@ -227,6 +227,13 @@ static int execute(void)
>                         return EFI_ST_FAILURE;
>                 }
>         }
> +       if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
> +               str = get_property(u"kaslr-seed", u"chosen");
> +               if (str) {
> +                       efi_st_error("kaslr-seed with measured fdt\n");
> +                       return EFI_ST_FAILURE;

When does this run? efi_try_purge_kaslr_seed() tries to remove the
kaslr-seed before measuring a DT. Are we safe enavbling the check
here?

Thanks
/Ilias
> +               }
> +       }
>         if (IS_ENABLED(CONFIG_RISCV)) {
>                 u32 fdt_hartid;
>
> --
> 2.45.1
>
