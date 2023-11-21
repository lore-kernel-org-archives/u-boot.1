Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304F8C5AD4C
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C93B875FE;
	Tue, 21 Nov 2023 03:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h2ULy5pH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5BD87584; Tue, 21 Nov 2023 03:17:32 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64AD1875E4
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59b5484fbe6so53170367b3.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533043; x=1701137843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XDFrQ/BzDXpGTyiqtUKUsjnjlUMR2jMBHdUatkbpR5U=;
 b=h2ULy5pH29arRlwaYHouloULXXVrrM1ROWfyy4GrfGBxVAn1l2GfWdsMFNTWCEbx9c
 NYrggy2jyBZGFG3drDii+dKvzsAIlLsLmegx1ac1yPUzWvacccwoPxkpiSgUhbWgDzbA
 VPxHlYEnqs4Vqgd0zWPnfux77r5CBEadCi7ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533043; x=1701137843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XDFrQ/BzDXpGTyiqtUKUsjnjlUMR2jMBHdUatkbpR5U=;
 b=G2qen1UpRofq2z6rlKFDAkl5tRjegT6pzpiqi7dxRqyuNIsvPN6D5QHneKUxPa8IEu
 sA7IqySFibr95cqhTdnRy+M6/wlyepJHR/D3RQKhMFtN4Stm9e8WoZrH5Q+CEYRDYXPF
 IyaB7szJU7yZAOodVPdDHGH9Nz17ZwXlsgoLbEOAxjDL1G8kfikSfDhBfe98xRnIaGP4
 vERLsb7tVQnIwC9V0ryOE/yD4Qa7X87l5GdbTQMcINLDmCEuDhOMJtAgND9OzKF6GX9+
 E9bwqP+mjQYFNEmity86Z3z0vagZCnvpKsGbNHpGqIvhWq8S2K5c2OaEk5Lg7jO8Ca4r
 9s3w==
X-Gm-Message-State: AOJu0YxrJ8qNHR7qdqK+1CLkO8QZE9iPB5+I1Gq9Cn4CDVl/Qe9YJfw9
 lcd7S7c0/o91W564sxeaWrRRI5vje+HtAmAJKCg+7s9CmYvClp3/VwQ=
X-Google-Smtp-Source: AGHT+IHtFyQ6pnaJB1Moq7zmtwTqf2U/53i5Jw9T7zgcHmb59LXlNbx+q9s30VyLxGLh1elvkiyzqJtPCZwaKQH/Wls=
X-Received: by 2002:a0d:d343:0:b0:5c8:708f:1ea with SMTP id
 v64-20020a0dd343000000b005c8708f01eamr10103473ywd.32.1700533042966; Mon, 20
 Nov 2023 18:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20231121011035.54128-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121011035.54128-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:29 -0700
Message-ID: <CAPnjgZ1js1YR64-WLirX2yTPHc+ftuU17kVNj-+9j9zxDJkMzg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix efi_show_tables()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, 20 Nov 2023 at 18:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Since commit 041840eeeb12 ("efi: Split out table-listing code into a new
> file") the `efi tables` command prints random numbers instead of GUIDs.
> %pUl expects a pointer to a GUID not to a string.
>
> Set maintainer for file cmd/efi_comon.c.
>
> Fixes: 041840eeeb12 ("efi: Split out table-listing code into a new file")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  MAINTAINERS      | 1 +
>  cmd/efi_common.c | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c1cb2dc4d..40786023ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -993,6 +993,7 @@ S:  Maintained
>  T:     git https://source.denx.de/u-boot/custodians/u-boot-efi.git
>  F:     arch/arm/lib/*_efi.*
>  F:     cmd/bootefi.c
> +F:     cmd/efi_common.c
>  F:     cmd/eficonfig.c
>  F:     cmd/efidebug.c
>  F:     cmd/nvedit_efi.c
> diff --git a/cmd/efi_common.c b/cmd/efi_common.c
> index f4056096cd..f6e3494892 100644
> --- a/cmd/efi_common.c
> +++ b/cmd/efi_common.c
> @@ -17,10 +17,10 @@ void efi_show_tables(struct efi_system_table *systab)
>
>         for (i = 0; i < systab->nr_tables; i++) {
>                 struct efi_configuration_table *tab = &systab->tables[i];
> -               char guid_str[37];
> +               const char *guid_str;
>
> -               uuid_bin_to_str(tab->guid.b, guid_str, 1);
> -               printf("%p  %pUl  %s\n", tab->table, guid_str,
> -                      uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
> +               guid_str = uuid_guid_get_str(tab->guid.b);
> +               printf("%p  %pUl  %s\n", tab->table, tab->guid.b,
> +                      guid_str ? : "(unknown)");
>         }
>  }
> --
> 2.40.1
>

Isn't that resolved by [1] ?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20231112205516.183410-3-sjg@chromium.org/
