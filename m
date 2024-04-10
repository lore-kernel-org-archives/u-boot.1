Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4057ACD1297
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 09:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F94881B0;
	Wed, 10 Apr 2024 11:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QBlzjDXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5AF881B3; Wed, 10 Apr 2024 11:23:10 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1223C87666
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 11:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-516d16db927so6841457e87.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740987; x=1713345787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H2Xla7E3P92MssG6wCIe4mwhe8X6MVRuzK7R+XCcLws=;
 b=QBlzjDXiaRKRi75Q3InEaIIdOZTkQJFr6x4vq87CGysw3T9My5fF78cX11sTKrreGP
 JGoCaDa0CI5qP51jQLI8PHwkE6SqwTtOMHi10XBXt/E9xy3WdqepV5QC0KMeiUCUDF7y
 ttUa9qN7Fp5x6ftjxKOELnxQ4CIEwaRQO4e5nOtzlMpwakc+K1uuZotDjikv0ApTbMoz
 rNzmAkD/m+s3CrZ/43yft5lnQLs7yVD98ZW47HZZw5wyckv5Foum9sEBrE0MLrLSh5Dl
 ufaU1g8Y1bexuTE0Uu3fvcecvNKZ9mVTfIPUGmcoSP3tJ0lDL9rKzD5SGJcfXBuFIoGw
 b0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740987; x=1713345787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H2Xla7E3P92MssG6wCIe4mwhe8X6MVRuzK7R+XCcLws=;
 b=GSZZElVoNi1+YgnadMd1GVqneFWcWv7zCVQZ6pEe8M6GOulxwkGFd8SvzNQzP+X8Fp
 uKdOLNnX4B2DlMqFpgLx/MhPokIVLfi5xOFpmuAgsiTZmHuHHkuNUHmdyQOV2POK7Ltv
 QCN7p6myDVUWnUeT2DKR+d06aWIthXAVn64owm1BNGhSQKR71lj4eIAM2pz/0RUzqi8H
 5+D24vIK6O7IixFoP5ZXp3CiH0RLSkClh55wUbOI2CIiPuZd6W8ZT8sw3xELIRgQIjXz
 ujCJX5WI5thqLoquYF0TaOnwzLlzgFTDXYsszDgBVVs3I1ofgegxqTVxz35gMsKtO5Hq
 85Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe+5RMPewRy9TwravShoqldldWQKpZcMQD1fxjRj/bMPfkr1CUX7rsxdb17dGhoLrDLwvhuZ/bDvXFrl3eNz43AnHxXg==
X-Gm-Message-State: AOJu0YxULoK0aIluK43bxhBTRnhIuA7nBPfEtBGpnMkk4FOP/GysbRba
 H/xJ5jmDuuVb8kiUOmyKDWQjWRsb5KgaQ0jEERnWG14Y+aoawV00kor4l+KzkytlScu+cOY5uQ1
 JOxhxc5iukE0PSe3lXWPghLlu2qCyBj3XqxCpGaQ14tDEdavr5cZo7w==
X-Google-Smtp-Source: AGHT+IG65YuFfBDgiutC0JYMbrjBVUp8g7SU4Y3569udzyAxrGjjjHtLJg3IEgRya1HuDRhVf3aVhRpezR8UiII1+OI=
X-Received: by 2002:a19:ad0b:0:b0:517:5ee6:4f5a with SMTP id
 t11-20020a19ad0b000000b005175ee64f5amr1046239lfc.66.1712740987338; Wed, 10
 Apr 2024 02:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240409204824.70582-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240409204824.70582-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 10 Apr 2024 11:22:31 +0200
Message-ID: <CAC_iWjLnCRQFNX=ybS9zV6SAsJ0Vrn0dHA_Zc_wGesV-idrz9Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: 'EFI using ACPI tables at' should be
 debug message
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
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

Hi Heinrich

On Tue, 9 Apr 2024 at 22:48, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The message "EFI using ACPI tables at %lx\n" is only of interest when
> debugging. Make it a debug message.
>
> Fixes: 085f8db6b98d ("efi: Use the installed ACPI tables")

It doesn't fix anything broken, so can you get rid of this during the merge?

Other than that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 67bbd2a01c0..67bd7f8ca24 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -41,7 +41,7 @@ efi_status_t efi_acpi_register(void)
>         }
>
>         addr = gd_acpi_start();
> -       printf("EFI using ACPI tables at %lx\n", addr);
> +       log_debug("EFI using ACPI tables at %lx\n", addr);
>
>         /* And expose them to our EFI payload */
>         return efi_install_configuration_table(&acpi_guid,
> --
> 2.43.0
>
