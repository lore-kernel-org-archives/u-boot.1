Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51704CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 07:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9961384659;
	Fri, 22 May 2026 09:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XxRcZMfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E84846D0; Fri, 22 May 2026 09:50:52 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B628432A
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c7492a2ceso6237963d50.3
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 00:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779436248; cv=none;
 d=google.com; s=arc-20240605;
 b=lhxfV29ANCH39xsL444XxiAgswAIS352W1rIg90IlSzGhbYGx0upvBg20wLrjMkNuf
 Wbbuz3zb5zRn0GzrbLMFDTohuA1cUnM3lrihE29KfIll+eGvjUDj76YQDrikwiBfBqls
 UT9Kc+6xnRDpVv7eaerrTA6yiqU7zFUsoN+TNgRj2CCRNOQkkoCrdKH0kGt9efcaYf96
 HCskGXcMi6pS7LAUpqkeUfGVPjA43BRiQwg2V4eskjufgi8TO/gqpzBP0XgcM2d54muY
 YvBWwB1J1WN889hhyTyN9U3cZwcYU7BinSzxf6gFvCfBYviFg6Xw4gm0E3Cx067VSXFq
 s8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r1U4o7aU78RE8E5ihHDHGmQxbkmZ86G9bzPCxLJ71fA=;
 fh=jw+5q+wO/u0R7yXNifEIPUFbLIbPfsnkHxXpacK8Ifs=;
 b=cWkKGm9khXLhJQCE10mYTm959wBG3CjWS+snHZMyZJF6OIuedUaFAILwgaYIH6cAxr
 0dasbzqwflOnZzrmWfQ6HG6svCFWrJMA7UoHy/se1JsbVGYrQOYf4hsNJJij/ZgbvEZF
 MQt6kMWlHsZo/JjIjsYmRYNPYmRkCXI4ojRgIUAE3Ph6kXK4CKH9ey3iCGJv1BH0urvW
 OKGPeFawdEITPbEXtRqqeeL0aOk2+25XTu2WJL2YQSjs0xSenOEQCnrYUK3ly2PthAYF
 00PZgzWiYqhAlo8qmny70Cd31tn7TbYVOj4lEl6vgRYQ0lAd32Sa669OhcUjkrZlqbeY
 r6lg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779436248; x=1780041048; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r1U4o7aU78RE8E5ihHDHGmQxbkmZ86G9bzPCxLJ71fA=;
 b=XxRcZMfni9Zu8n0Sp/eh0o0nb+uQMZRgsyNnEah2x+4E4EDuSe97g2mTQ/dZuzUKs3
 zVhQiV8ls0uNhHdkrGa/VdZPo382M3Qw0+m9ndS2MjWl3EFqLH6s/tPdJGmm8pCDgFgg
 M7rCH36a2FM0Ocjnvq6JV+SNzpt5ujOITpPLSIMpRhjVkNDjs1205hh+JNe5+psi61it
 BCH4Oxe/rPIAv7Pafm1BhUeNWsuiMhwmIWkoW26ahWq5MCua+uCLiWUmwZ5nSLi0djK5
 zJGegrLU75yrysg6nmUcLHZ2PPgT8UF/Uf7I4ak14DDSt/DD7l3UmL8SVsn3zYxvjeG0
 TuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779436248; x=1780041048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1U4o7aU78RE8E5ihHDHGmQxbkmZ86G9bzPCxLJ71fA=;
 b=Ycndzo8Q8mNPvjcrCsCGXedJb8oZ7afqotlJ/MERlQSTKFN6RIxqySTiuZPRrB3Icq
 oG0rJ/BMLt7Pw4kf2A8KvgcUBTkxybl70XD7UZyTuy6/CAhZt7L0OkT5Pm9YMxfmaX8o
 5WncVBmJj/FG6ShLPS+JQ72CaNT1lo3twxUPSk/RNUdgJKQYDr6c02e6EFfP/tYEzmIq
 iEsulNJWZzwtcIPmx6IOBJbbpoP11O24mznKy5rRuSOFlHOKw34T+Uq4POWHZnwwVhaE
 Kv9Yod1eA2sTSoV/Gux8J9JZZHh2Gpmeg1zRwlkMSlBVesEV+ayKwUKnQAwaLTHjxo8y
 qpWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8f6MbFT7I2lhVtcBrvFaGVoTLyT/K2GxXz6z8+tExRVB9Vt22GIOe5VeQO0ZyF9ZlwYbXz6QQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzilZyBvdJvC0qvHGm1Cm78jCEQHeuFPtTtSOzFXi5vkRx3+P4x
 CZXw3MiD6a1m16yBl8aOOxQIIge6L9o7bvU5voNy37D47ZmwyOFCKBRnwOZVlG4xFlYt/MNEIz2
 yRaUsq2OkFtxlbDDSRL/ZiQvbgtf5Xag2z7S+5o3NBA==
X-Gm-Gg: Acq92OFEezpLt99+35Rvk5QYzH9PajJudP5o0NPsN1FAAoDPj7SyDWQAVUk9Aism9ER
 4uaamaoT0eTEpc0l6kic74GeEzTrp8uJp4gXTFIc/jHE8j1hCeyEw4sAww83bnFHkNF3hImENTh
 brcYd8MtgJKk2OytkOvxasBkNF9p8Gr85wiP8W+3XTCdWrilLQ0zL44/MOIGIF+0JsO2C3jlmWd
 mqfKSk2Iveh04Wud0SuZ16LD/hbMszxlXanYdoVDE+1fTZxT/CWLHLOntamH3Ur1gORRCLj/chN
 vWKbA57NEFgZqIeZVYQU9h9jbRcspE0AzvDZ1S1ESgG4ZsEFg1G27+eWVQk2PMVviKVPbbDq2OF
 h0dbAt6B7ggcZojZjP8e5BgaDAIFu5AlzqUDzFjS5FXEUUDhWVAa3Vynaw2O/ACntYfXofuAebD
 yGVUQ2/k7jimW2yzAvY66TKTiEPUJ47R7A3ueTE7rfJyDDv1B7kAOB/PqxTK6DVwSNrbaEkwo1R
 nEZOAnZkmPizmph36CV2DD2yhJqVVb2pJQt45GXMzibvzrQl3T++j54QFcGjL+yLjBVQxtPuatH
 V7lX2LC0TtaT8fWB4PzIHmHmI5wlsZgvRkAv+M59IDjo2rshcnWWWZIeedVkUpiqVdHUJ2Xiggj
 pMf/RgA==
X-Received: by 2002:a05:690e:14c3:b0:65e:5955:2e44 with SMTP id
 956f58d0204a3-65ec98f957dmr2479738d50.47.1779436248411; Fri, 22 May 2026
 00:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260521185025.30857-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 May 2026 10:50:11 +0300
X-Gm-Features: AVHnY4J6s3ojQ6j-hWwIE-CEFnBrpeRI6KIQ-QzVN6E5ieVXquwryPWbuAAptSU
Message-ID: <CAC_iWjL_sY+oRBvaaVH9vB5b7uRdzoQKam+jndQY-gMoRfeetQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: use pointers in efi_acpi_register()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>,
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

Hi Heinrich,

On Thu, 21 May 2026 at 21:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Both efi_add_memory_map() and efi_install_configuration_table() expect
> pointers and not virtual sandbox addresses.

efi_add_memory_map() expects a PA afaict. EFI is identify mapped so
that will make no differece, but we can be a bit explicit on the
commit message

>
> We need to convert the virtual sandbox addresses in efi_acpi_register() to
> pointers in memory before using them.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_acpi.c | 42 ++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 046986a7518..70cb896ac25 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -25,7 +25,7 @@ static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
>   */
>  efi_status_t efi_acpi_register(void)
>  {
> -       ulong addr, start, end;
> +       void *addr, *start, *end;
>         efi_status_t ret;
>
>         /*
> @@ -37,39 +37,49 @@ efi_status_t efi_acpi_register(void)
>          */
>         if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
>                 int size;
> -               void *tab = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
>
> -               if (!tab)
> +               addr = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
> +
> +               if (!addr)
>                         return EFI_NOT_FOUND;
> -               addr = map_to_sysmem(tab);
>
> -               ret = efi_add_memory_map(addr, size,

Why was this wrong? Isn't addr after map_to_sysmem() going to return a
PA in normal hardware and the whatever sandbox has mapped? I think
this will break the sandbox case for both cases.

> +               ret = efi_add_memory_map((uintptr_t)addr, size,
>                                          EFI_ACPI_RECLAIM_MEMORY);
>                 if (ret != EFI_SUCCESS)
>                         return ret;
>         } else {
>                 /* Mark space used for tables */
> -               start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> -               end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> -               ret = efi_add_memory_map(start, end - start,
> +               start = (void *)ALIGN_DOWN(
> +                       (uintptr_t)map_sysmem(gd->arch.table_start, 0),
> +                       (uintptr_t)EFI_PAGE_MASK);
> +               end = (void *)ALIGN((uintptr_t)map_sysmem(gd->arch.table_end,
> +                                                         0),
> +                                   (uintptr_t)EFI_PAGE_MASK);
> +               ret = efi_add_memory_map((uintptr_t)start,
> +                                        (uintptr_t)end - (uintptr_t)start,
>                                          EFI_ACPI_RECLAIM_MEMORY);
>                 if (ret != EFI_SUCCESS)
>                         return ret;
>                 if (gd->arch.table_start_high) {
> -                       start = ALIGN_DOWN(gd->arch.table_start_high,
> -                                          EFI_PAGE_MASK);
> -                       end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> -                       ret = efi_add_memory_map(start, end - start,
> +                       start = (void *)ALIGN_DOWN(
> +                               (uintptr_t)map_sysmem(gd->arch.table_start_high,
> +                                                     0),
> +                               (uintptr_t)EFI_PAGE_MASK);
> +                       end = (void *)ALIGN((uintptr_t)map_sysmem(
> +                                                   gd->arch.table_end_high, 0),
> +                                           EFI_PAGE_MASK);
> +                       ret = efi_add_memory_map((uintptr_t)start

[...]

Thanks
/Ilias
