Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09072E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A5580241;
	Wed, 11 Dec 2024 16:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jPMe3eDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069A48027E; Wed, 11 Dec 2024 16:13:46 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A2580212
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6f150ddc86dso3989967b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733930022; x=1734534822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t5jQV05nx0CVo6foheoe2U4AARSFyE/HRlPpL1ygvic=;
 b=jPMe3eDXqZpcgp4BTtv1EIz7dg7KZMmS0rEOFSkE8bU1wUO9j90jivwQ4LIFVaAhBn
 QmpgImUbWuWV33fXdLtnJhLTn3bSOUv06MsiXl0Lc7B6JxG2zGZlaEgbLAw6swhY7G3r
 MiEOlu/SBtReLaSSPLLrpVduzvuxSLwkHsja4qHHLhlSlD3x8MBIIG7j2/rjVxIP8nwm
 nsQBAWRrVB4gUgYFx1XOzTMTEN6A5f3GnoJaPpJ8uVhPQuCjrrWLI6owJtNzZV8LtR6I
 Daljql80gSNNy9aHiOeFd6uYcyjvATRMmGLrtC+Bgh0+PGB1CTyzMOB4d5X9Lt8M7jpq
 ZbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930022; x=1734534822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t5jQV05nx0CVo6foheoe2U4AARSFyE/HRlPpL1ygvic=;
 b=kS3fXn3jAvcKXU988+Y2dS3bWaH+Q7u7wadYIINku3aHMKzQ8g+CGhqLuSBXahyen4
 Zlql+dMHVPFBKXFIMAik7d8OOORW65Lf75+CqkFy6tHmB9p8QY+zIGHmivrXxuvHgtwb
 qr7e9ZxT65ZgrqkexjV1WBT7Zdq9BGqPPJ0gCnNAx7COturbOaLXCrTVinEEIHsmolz4
 CiiVzZpYmPV9D1PKYFbSK8rN2nsi0h2xcjD6IvRZN0dw9oNolVif4mjabdPcSrBadm2K
 48XltlYSIGf2Rpdv8wDQG74mKoP8CrgEDPrG7YVr34ky+fRrXwkkE0L6paOPReqDaDht
 PXOA==
X-Gm-Message-State: AOJu0YwSSud4RAQC9ET7q6A20RECkR9/YrujFBW/Fsp3XfTj7RTr64fY
 791JrJ2tHlMEKacIJCIrmqNVoOlg2T1K1sgfbLWDzaqNAH8IfiaHMROBfiZwz8GEo/3o781k66T
 eFXZgAvIL+CJtyAaFS9KGHud8KOHsLDQALGCkoAAii8CpHAiI
X-Gm-Gg: ASbGncshRUYhSy08khaam9HmXsgxFAGm2Rk1ZvVEC774s7Ve8nb5L0cicNmVnewZqRi
 UrBRcLXnVJ3so5hnD+B6H5xa6o+g08DF2Qo4=
X-Google-Smtp-Source: AGHT+IHmWL7vrt3Lw2A+dkHhmFRLVmKbKeec9YqgjuHjDrYPgeLi47DGzIHTjRWJAI59VBWPK45+cavfnKHF6rzULjY=
X-Received: by 2002:a05:690c:4d02:b0:6ef:5688:f95e with SMTP id
 00721157ae682-6f148052638mr30293737b3.42.1733930022538; Wed, 11 Dec 2024
 07:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-11-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-11-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 17:13:06 +0200
Message-ID: <CAC_iWj+JjfM5hhFHaukxuiAaM18qP1_1eVmogBTCDCgZkerWJQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/23] efi_loader: Drop reserved from priv_mem_desc
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
> This field is not used. Drop it and set the value to 0 when the
> memory-map is requested.

Looking at the spec the reserved field is wrong. Instead you should
just remove it from struct efi_mem_desc

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_memory.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 8211600f7f6..024361483a0 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -35,7 +35,6 @@ efi_uintn_t efi_memory_map_key;
>   * internal format is converted to the external struct efi_mem_desc format.
>   *
>   * @type (enum efi_memory_type): EFI memory-type
> - * @reserved: unused
>   * @physical_start: Start address of region in physical memory
>   * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
>   *     bytes)
> @@ -43,7 +42,6 @@ efi_uintn_t efi_memory_map_key;
>   */
>  struct priv_mem_desc {
>         u32 type;
> -       u32 reserved;
>         efi_physical_addr_t physical_start;
>         u64 num_pages;
>         u64 attribute;
> @@ -703,7 +701,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
>         memory_map = &memory_map[map_entries - 1];
>         list_for_each_entry(lmem, &efi_mem, link) {
>                 memory_map->type = lmem->desc.type;
> -               memory_map->reserved = lmem->desc.reserved;
> +               memory_map->reserved = 0;
>                 memory_map->physical_start = lmem->desc.physical_start;
>
>                 /* virtual and physical are always the same */
> --
> 2.34.1
>
