Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C18E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0AE802E3;
	Wed, 11 Dec 2024 16:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yxh44SXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F8BA802E6; Wed, 11 Dec 2024 16:09:48 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD6A80212
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6ef7640e484so80140187b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733929785; x=1734534585; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KLyCN64lA0osNilokF9V/ut2KgKL7Fhq52UTgnUeYxU=;
 b=yxh44SXc0DuG7yO6PZMYoUrdG4cMqJmzME9zDll67TqqVn6eKW1QJtwAjiT1RXaoOk
 MVTRAxbtv7qxXMQlS1wC0030D6dd47k3psXs6vKfY+Ukk8wXyX747ZfLRAZgttxjnTI8
 mBHEo0R6dYW6FZtEo9D6H0VQjzt5iXDY8aBb81wiqgZvXLnJAmk7zsgEOqZ/OXg5YcCo
 m0I5sckSg+9MC9Tq8kbOtRPd7IR+J4zQlYBF1YyFlIIWJLOVWf8v15cUt66qf0ixKWoB
 jlkqCxF7+D8Y7c4/Fc0ck7URhz4uVypT0kATu/rfgcmZHwcPeSLt2U3lPPvIvn93c4Ae
 iOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733929785; x=1734534585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KLyCN64lA0osNilokF9V/ut2KgKL7Fhq52UTgnUeYxU=;
 b=hl6778lslVzzzyiNanSILq/71MB8l5XfFGUJP6oiUrzUeG6QTT3HI8MO30GSLQmskY
 t5p5UlBmg6aPr0EhorAMeN+fPjJbLaN3p/LQBUXfemuwyb+pnt7IOX64zKMVZj1OtKqP
 Ud4Vh/rCuBzhmZqoIEVrrINwUv56YJJGBlt01sHUz5vsuoq8LJDFuiQGXZpTqg6zQbxy
 Q/lVOyP/Zawat6NvDG7BPoPZpEjtARmKssHtnc6AcZOxLXy342ayai7PX2AMNZP0G7bg
 g9UqYnQLHzUQEeD+6nU8NcjuGk3sOdWS1dBDHHVqhdvyI3tl/9+f92/u1EuvWzmyunM5
 pvjg==
X-Gm-Message-State: AOJu0YyELFcFq0b0rpQvph9kNR1ZidkGetekv4bViMGBfK6IX7Cmye01
 jbSV2bkc8BvI94OgU4DAuE8mVoAGYkz0HaGsuOVuj7L+zGNNTszBcDrxWM//ptOOwbCPOtFR5nt
 r+6VkUJrHbM5Z2E8AO2NlvhXmZMPMzbnkJA/xqQ==
X-Gm-Gg: ASbGncuXwhQ2+xX71VmoTYIf4ccVjJ7l5GV/AGGb9yGcH1fpe/WJbeqsmj2tQnETyRf
 C6u+V2C2pcSAtUzPgpv2pneXPYA3Msq+I1a4=
X-Google-Smtp-Source: AGHT+IE0zh6h+aHJGEuCn5vFtigL/9BYLI/8q4PnMnnIScsY9cgOiq1cCUmDa4jeTp3WKp/PlHzkp7p8Mtt+7khLUUo=
X-Received: by 2002:a05:690c:6ac8:b0:6b3:a6ff:7676 with SMTP id
 00721157ae682-6f147fd1dd9mr33793007b3.3.1733929784767; Wed, 11 Dec 2024
 07:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-10-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-10-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 17:09:09 +0200
Message-ID: <CAC_iWj+g0Jzg3DMP2KgFnabhMe5U_L4mtvUYA+HUBms5_z5+BA@mail.gmail.com>
Subject: Re: [PATCH v5 09/23] efi_loader: Drop virtual_start from priv_mem_desc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> This field is always the same as physical_start, so keeping track of it
> separately is unnecessary and confusing. Drop it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_memory.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index db40aee8353..8211600f7f6 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -37,7 +37,6 @@ efi_uintn_t efi_memory_map_key;
>   * @type (enum efi_memory_type): EFI memory-type
>   * @reserved: unused
>   * @physical_start: Start address of region in physical memory
> - * @virtual_start: Start address of region in physical memory
>   * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
>   *     bytes)
>   * @attribute: Memory attributes (see EFI_MEMORY...)
> @@ -46,7 +45,6 @@ struct priv_mem_desc {
>         u32 type;
>         u32 reserved;
>         efi_physical_addr_t physical_start;
> -       efi_virtual_addr_t virtual_start;
>         u64 num_pages;
>         u64 attribute;
>  };
> @@ -187,7 +185,6 @@ static void efi_mem_sort(void)
>                                 pages = cur->num_pages;
>                                 prev->num_pages += pages;
>                                 prev->physical_start -= pages << EFI_PAGE_SHIFT;
> -                               prev->virtual_start -= pages << EFI_PAGE_SHIFT;
>                                 list_del(&lmem->link);
>                                 free(lmem);
>
> @@ -255,7 +252,6 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>                         free(map);
>                 } else {
>                         map->desc.physical_start = carve_end;
> -                       map->desc.virtual_start = carve_end;
>                         map->desc.num_pages = (map_end - carve_end)
>                                               >> EFI_PAGE_SHIFT;
>                 }
> @@ -276,7 +272,6 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>                 return EFI_CARVE_OUT_OF_RESOURCES;
>         newmap->desc = map->desc;
>         newmap->desc.physical_start = carve_start;
> -       newmap->desc.virtual_start = carve_start;
>         newmap->desc.num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
>         /* Insert before current entry (descending address order) */
>         list_add_tail(&newmap->link, &map->link);
> @@ -313,7 +308,6 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>                 return EFI_OUT_OF_RESOURCES;
>         newlist->desc.type = memory_type;
>         newlist->desc.physical_start = start;
> -       newlist->desc.virtual_start = start;
>         newlist->desc.num_pages = pages;
>
>         switch (memory_type) {
> @@ -711,7 +705,9 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
>                 memory_map->type = lmem->desc.type;
>                 memory_map->reserved = lmem->desc.reserved;
>                 memory_map->physical_start = lmem->desc.physical_start;
> -               memory_map->virtual_start = lmem->desc.virtual_start;
> +
> +               /* virtual and physical are always the same */
> +               memory_map->virtual_start = lmem->desc.physical_start;
>                 memory_map->num_pages = lmem->desc.num_pages;
>                 memory_map->attribute = lmem->desc.attribute;
>                 memory_map--;
> --
> 2.34.1
>
I don't like duplicating efi_mem_desc and have a priv without the
virtual address. I don't understand what you find confusing, but we
have follows the spec (minus that reserved member) and I prefer it

Thanks
/Ilias
