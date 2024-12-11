Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EC9E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB43A80296;
	Wed, 11 Dec 2024 16:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L6+ljqt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C4A80306; Wed, 11 Dec 2024 16:08:07 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A132780296
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f00da6232bso33832557b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733929683; x=1734534483; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NYYkAcYQ86I33u+SCjsRvoW9dnP1m7wDdySJFQ5DnMQ=;
 b=L6+ljqt17oz9b3F38eIhN3s0hxt0KCy8tBCRxTPBOGxKFiTv/5xjBYObBOhznL1ZWK
 xS8TXJStC8oDYXsN6JS4OtN8MF9x4EBcA2o0yZck1f57pjEMP3oeKCnA3Ig4rO0mlU3Y
 udLg0hvM9B6iMQc7GpJPeOXeMLdklVJgyAyG3rDFZkHkn1TU9mSc8ZSDssnC3DOQkkcf
 TsEMALgl5mcdwWSVYyQrH0GrIIMQukKaFITz3m7XzV0gECCgzI8b5vKHsizFPfheAHTh
 ykRmUKjjTpRAbKSkWLC2cI7I/8hWZWohjJBOid5mkmI09FZvCfgbNnEmgiQn/IrWsvNK
 dE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733929683; x=1734534483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NYYkAcYQ86I33u+SCjsRvoW9dnP1m7wDdySJFQ5DnMQ=;
 b=SeVwEi5qOjsDitfBe1Mi/0Efiwe55KyABgQqe5C9tkfh6bDInojaGwdYMoAM4MSLLT
 VPkglOWuDOobyjp+XQKZZ57VokDQgsTsCm4z2PPlonVozD78PwRIMpNhmkkzAvKh7Men
 NQz7PfGX3mcqtfWuv4inpmhHeezy3B0A8eBYFHVQwHLjfawCVRCTCRRCPugJXHe2SgPq
 irWDnqtusMVpHzZka8fa3pi2SkzhT9NyzJzvyvli2Xzs1+s3XWrIW1RIRH4RvrypQZMV
 LgiBEJCu04vAwX+MLculXGJeRL0M2CEP20mhxangRwqJIq+1EXCbrGeW9jOCzBQzpMsf
 bGYg==
X-Gm-Message-State: AOJu0YzKdR6FUN4RjZ7EoElH3ZQ+9MYAEyaQK1P+ApV8utxQn1wBJ36m
 3ESMgCQ7FsTiyYfEryte4suEgwYe2k664lVHgvLymEHq+tUxjXEsfjNQGAtoJegwJl332ks3Rak
 cQo53DZ8XQV1q2Ga3wHq+/4sTdPHQOyo7pZCR7w==
X-Gm-Gg: ASbGncsIJyWe9Ao2Vz/mS6CJib4UBD567n260bQDLzfLN94ENy+D8q9UHX6oQTD1/0i
 JU8XhD6xOve9QTvcmNnnkJX3wtAi5eF41X2A=
X-Google-Smtp-Source: AGHT+IFLtN4UH9fNNQkZixHkaA0i1rXehzOmOputYlmDqzllMS2dkulK9TNebZPwcs90GA3PO8TFLIzMOYEVkIDJwrg=
X-Received: by 2002:a05:690c:4d02:b0:6ef:5688:f95e with SMTP id
 00721157ae682-6f148052638mr29995597b3.42.1733929683240; Wed, 11 Dec 2024
 07:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-9-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-9-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 17:07:26 +0200
Message-ID: <CAC_iWjKnvOsKP7sa447yaQB7_G6nvbY=FxDWuFxkW5pt=cXXeQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/23] efi_loader: Use a separate struct for memory
 nodes
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
> At present efi_memory uses struct efi_mem_desc for each node of its
> memory list. This is convenient but is not ideal, since:
>
> - it means that the fields are under a 'desc' sub-structure
> - it includes an unused 'reserved' field

That's interesting. The EFI spec does not define that and I looked as
back as 2.5.
Heinrich, this predates my involvement with EFI, do you remember why
it was added?

Because it's defined in
> - it includes virtual_start which is confusing as it is always the same
>   as physical_start
> - we must use u64 to store pointers, since that is how they are returned
>   by calls to efi_get_memory_map()

I don't understand the 'pointers' again here. It's a physical address.

>
> As a first step to tidying this up, create a new, private struct to hold
> these fields.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch to use a separate stuct for memory nodes
>
>  lib/efi_loader/efi_memory.c | 49 +++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 4bc6d12a1fe..db40aee8353 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -27,9 +27,39 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  efi_uintn_t efi_memory_map_key;
>
> +/**
> + * struct priv_mem_desc - defines an memory region
> + *
> + * Note that this struct is for use inside U-Boot and is not visible to the
> + * EFI application, other than through calls to efi_get_memory_map(), where this
> + * internal format is converted to the external struct efi_mem_desc format.
> + *
> + * @type (enum efi_memory_type): EFI memory-type
> + * @reserved: unused
> + * @physical_start: Start address of region in physical memory
> + * @virtual_start: Start address of region in physical memory
> + * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
> + *     bytes)
> + * @attribute: Memory attributes (see EFI_MEMORY...)
> + */
> +struct priv_mem_desc {
> +       u32 type;
> +       u32 reserved;
> +       efi_physical_addr_t physical_start;
> +       efi_virtual_addr_t virtual_start;
> +       u64 num_pages;
> +       u64 attribute;
> +};

This is not private, it's described by the EFI spec.

> +
> +/**
> + * struct efi_mem_list - defines an EFI memory record
> + *
> + * @link: Link to prev/next node in list
> + * @desc: Memory information about this node
> + */
>  struct efi_mem_list {
>         struct list_head link;
> -       struct efi_mem_desc desc;
> +       struct priv_mem_desc desc;
>  };
>
>  #define EFI_CARVE_NO_OVERLAP           -1
> @@ -116,7 +146,7 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
>   * @desc:      memory descriptor
>   * Return:     end address + 1
>   */
> -static uint64_t desc_get_end(struct efi_mem_desc *desc)
> +static uint64_t desc_get_end(struct priv_mem_desc *desc)
>  {
>         return desc->physical_start + (desc->num_pages << EFI_PAGE_SHIFT);
>  }
> @@ -138,8 +168,8 @@ static void efi_mem_sort(void)
>         while (merge_again) {
>                 merge_again = false;
>                 list_for_each_entry(lmem, &efi_mem, link) {
> -                       struct efi_mem_desc *prev;
> -                       struct efi_mem_desc *cur;
> +                       struct priv_mem_desc *prev;
> +                       struct priv_mem_desc *cur;
>                         uint64_t pages;
>
>                         if (!prevmem) {
> @@ -194,11 +224,11 @@ static void efi_mem_sort(void)
>   * to re-add the already carved out pages to the mapping.
>   */
>  static s64 efi_mem_carve_out(struct efi_mem_list *map,
> -                            struct efi_mem_desc *carve_desc,
> +                            struct priv_mem_desc *carve_desc,
>                              bool overlap_conventional)
>  {
>         struct efi_mem_list *newmap;
> -       struct efi_mem_desc *map_desc = &map->desc;
> +       struct priv_mem_desc *map_desc = &map->desc;
>         uint64_t map_start = map_desc->physical_start;
>         uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
>         uint64_t carve_start = carve_desc->physical_start;
> @@ -678,7 +708,12 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
>         /* Return the list in ascending order */
>         memory_map = &memory_map[map_entries - 1];
>         list_for_each_entry(lmem, &efi_mem, link) {
> -               *memory_map = lmem->desc;

What's wrong with that ?

> +               memory_map->type = lmem->desc.type;
> +               memory_map->reserved = lmem->desc.reserved;
> +               memory_map->physical_start = lmem->desc.physical_start;
> +               memory_map->virtual_start = lmem->desc.virtual_start;
> +               memory_map->num_pages = lmem->desc.num_pages;
> +               memory_map->attribute = lmem->desc.attribute;
>                 memory_map--;
>         }
>
> --
> 2.34.1
>

The only problem I see here is the reserved field. I think this patch
should just remove that

Thanks
/Ilias
