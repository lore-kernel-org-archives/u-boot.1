Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69141C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA00982E5A;
	Mon, 26 May 2025 16:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="arXBLPQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D87A82E67; Mon, 26 May 2025 16:01:44 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D32BE82D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7080dd5fe92so16611557b3.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748268100; x=1748872900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g6Xm71xL+6mBPeIMbYM32oYBx9CL2Yuc5Yfs5bE5ZaA=;
 b=arXBLPQkImhT44mwEXvwtFGQq0RNW5IxODLIx+ME3gfCIZ71VT7hrBJHrevzFs7IGU
 kxt9hjREzUJ46cOmLW+o02aEqjt/6/NMcQRL127gLNHQuepz2JCYu5thNzYJftNwcVUK
 4JPpnvDYITEGj9vXNDJ2zxaZG7MK39OHF3WZkkX1RQpvxOFBMipBsraLJxU5s1DBykLF
 cRxjoF197VN6o3QMn99zUA01/WBE1F3gDzAx/HT5LxoeDhvvo1rBD1HKqiGtjcPXG6j3
 qF/7eRZ2FJXrErgvzK+2sYmsvrznpXqSZnVScDzVd4WmsEvqRT5QO5euDXZJxnyJMQWa
 ffhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748268100; x=1748872900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g6Xm71xL+6mBPeIMbYM32oYBx9CL2Yuc5Yfs5bE5ZaA=;
 b=YhvwhGtK+4AnTfUSwygOrPO6b2Y45Ei8g+XHSIjIkgkGoHEmbgJc00OMp8PcqjSn9+
 tOmW+TQDaWsce9ZwJF3auQm5DtEdQ2aUilpjz5mqZdQ/5q77WQdHFFET9iqeIsYVjcot
 ktQyiR7am0DXWrfa2jAJgeHjYq90P1T9SaVfaNFNjgPnFlUgtgE2trn6KMJxsuo43C2y
 mYjqj+wmso1OiVcGsjbdGEmmBUh5L5YSHRlVjuhB3JwIKVw6AcZI3byzIMA92qshIIHN
 hYyDjPt4l0f+s6amwbHwRBTZYXZLCxmBbLs3yUzhpbLIaaY5xehPydk4f3Bdy5jEilz8
 rryw==
X-Gm-Message-State: AOJu0YxmuKA1KfVypRIXIFd7z4L4ZLJh9MiNcmHfBfcCoR4PkzXL3C6z
 QV+iosBsDgrEh2II6E3+T36CG+xQSxEWTNzchbHSEnyAY4Q+gnE916kNFiGBxBED51m6rv1mnSF
 wW1HOm27hYZCd8qHlF5GmB9KFv/KMGkttjL/Ex56hMw==
X-Gm-Gg: ASbGncth6YRLqsqrNrIn2Iym7RzkIRyLvenssaiNEBc4lBcVpvEz29laP6Ds+1OZXbY
 02UcxC0szkNB0G4v+b5b2Sgn0bXSK1XPPmiD32ADjVfx/nC2mASExmzpgBa08yY+0LC4RNmcb5i
 lXXVRATHETouWjeWuViDarZ7Hdvk4oy7Xb9TvHa0sUlGYG
X-Google-Smtp-Source: AGHT+IGM0X1jpt56ybEzCvne6cR0tmgUITiThe8HdU82qZ+CWxudJzSTWk+dFrxy80XivZHJtKIqJ2CmQoFaXbMV9YQ=
X-Received: by 2002:a05:690c:7405:b0:70c:965b:4700 with SMTP id
 00721157ae682-70e2db1597amr100230727b3.31.1748268100599; Mon, 26 May 2025
 07:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250522011749.3498970-1-paulliu@debian.org>
 <20250522011749.3498970-2-paulliu@debian.org>
In-Reply-To: <20250522011749.3498970-2-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 May 2025 17:01:04 +0300
X-Gm-Features: AX0GCFuBJtGe6PJ3yYRXl2GwHoBg7UKFIXvR45Bp4ZoFWTBDrXkwBWqZl7CUoR4
Message-ID: <CAC_iWjKvrK2bxWTnWiuynQhFMCAaExDeJQbCHhg9bHLfK2jT6Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Paul,

[...]


>         bool
>
> +config EFI_DEBUG_SUPPORT_TABLE
> +       bool "EFI Debug Support Table"
> +       help
> +         Select this option if you want to setup the EFI Debug Support
> +         Table which is used by the debug agent or an external debugger to
> +         determine loaded image information in a quiescent manner.
> +
>  menu "UEFI services"
>
>  config EFI_GET_TIME
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index dbebb37dc04..5a4349f8679 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -4001,6 +4001,8 @@ struct efi_system_table __efi_runtime_data systab = {
>         .tables = NULL,
>  };
>
> +struct efi_system_table_pointer __efi_runtime_data * systab_pointer = NULL;
> +
>  /**
>   * efi_initialize_system_table() - Initialize system table
>   *
> @@ -4035,3 +4037,47 @@ efi_status_t efi_initialize_system_table(void)
>
>         return ret;
>  }
> +
> +/**
> + * efi_initialize_system_table() - Initialize system table pointer
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_initialize_system_table_pointer(void)
> +{
> +       efi_status_t ret;
> +       const int size_4MB = 0x00400000;
> +       int pages = efi_size_in_pages(sizeof(struct efi_system_table_pointer));
> +       int alignment_mask = size_4MB - 1;
> +       int real_pages = pages + efi_size_in_pages(size_4MB);
> +       u64 addr;
> +       u64 aligned_addr;
> +       u32 crc32_value;
> +
> +       /* Allocate configuration table array */
> +       ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +                                EFI_RUNTIME_SERVICES_DATA,
> +                                real_pages,
> +                                &addr);
> +
> +       if (ret != EFI_SUCCESS) {
> +               log_err("Installing EFI system table pointer failed\n");
> +               return ret;
> +       }
> +
> +       /* alignment to 4MB boundary */
> +       aligned_addr = (addr + alignment_mask) & ~alignment_mask;

efi_alloc_aligned_pages() does that for you.
But I have similar questions to Heinrich here. Why do you need 4MB?


> +
> +       systab_pointer = (struct efi_system_table_pointer *)aligned_addr;
> +       memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
> +
> +       systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
> +       systab_pointer->efi_system_table_base = (efi_physical_addr_t)&systab;
> +       systab_pointer->crc32 = 0;

You are assigning this at the end regardless, so I guess you can skip it here.

> +       crc32_value = crc32(0,
> +                           (const unsigned char *)systab_pointer,
> +                           sizeof(struct efi_system_table_pointer));
> +       systab_pointer->crc32 = crc32_value;
> +
> +       return ret;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 48f91da5df7..a6b37d994f6 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
>         if (ret != EFI_SUCCESS)
>                 goto out;
>
> +       /* Initialize system table pointer */
> +       if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
> +               ret = efi_initialize_system_table_pointer();
> +               if (ret != EFI_SUCCESS) {
> +                       goto out;
> +               }
> +       }
> +
>         if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>                 ret = efi_ecpt_register();
>                 if (ret != EFI_SUCCESS)
> --
> 2.39.5
>

Thanks
/Ilias
