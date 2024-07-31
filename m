Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6E6C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A7F88958;
	Wed, 31 Jul 2024 09:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G3mzMSo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09CD388971; Wed, 31 Jul 2024 09:44:58 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F4B8811C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c6661bca43so3340918eaf.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722411894; x=1723016694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6lhzvibcsrKktPJj9NVIZBKx2pFO2qEdwfGFZ6Cr20w=;
 b=G3mzMSo7VzCGEEHG1wW6GIkWhXCSDdMb/wCsY6w/83lEXSFy3YEJErBx2SQCueWPR8
 b8s+9u+MFt0vxdfMxShubLako2kF2juM25Y7DjSYet7GzFDw3tIYNHoDN3kwfGJAVZ0v
 ZOfzVqYAbU3Ie3kvdnwgh69a4lRiuMSShMl88WdtgBK8+jLw96h+Li04QoyJIl0Gz7XC
 jsFU/zkSUqpUPWf7peFnI2giuUsoao7024zTu+ehr4oW1/WS5fCSyYpVSpvk3TExxgE4
 0GXEk+IOMFhmW9HgscNnuNKoOr+PwIGqlHjLgdIDWoZnZZ+bsil9dJDa+8S4OXyAKs/I
 u3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722411894; x=1723016694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lhzvibcsrKktPJj9NVIZBKx2pFO2qEdwfGFZ6Cr20w=;
 b=NhlPwBEn6FvMSBY5ivySnxyiq6KvI6Q8RQOx3xv3UC+dt5i+AlaNWOPtOE31Z35jE5
 +fRF/r36JZMwHlCKgGeg7KhoJuqQEnbde7Husq76zHVOs4cQckDNMSOUSre8Mti+6ht7
 CD6qP46o4wtPI9WjFlAJdZwXXR2vXmKydFyVyttGjrTjfRWga3p59uI6bKXyzCk7S0Y3
 cucXAqejuKykcEtX3l4mxoRlx9HE+pic4/VEiRDC1esg3qsR8zrNjya4bjoxmYt6m0Xp
 fLEuA9N8cFJgdJ9B8MnkomE+hV8XKoqtUOXsU/ZpaPksvO7/q0NckVY44zuJHlQhX/JZ
 3N2g==
X-Gm-Message-State: AOJu0YxUIImpYqtOGKF3JBkiSE9mtGSgVljftdS2N0lqOVkFyKlVunre
 MXxV74+9pBGj5U+bPb1hLuX3u5ulaGC250j/dcE+TtT2k7vQMwBai7tfsassYKqFMwkBDLnqjZq
 8YJ0NH4DfTVZPEEY9g/tDT97Kah/IaUjhW4yzzCbc12uYFw/cp54=
X-Google-Smtp-Source: AGHT+IGgMFSDRNAC2MCikEL6VkwHqIkfhei9VyOLrGhk1fUFwPL0SmWA7e8B92etUihKNXHrYvfsVZjmeHN16YLJF8U=
X-Received: by 2002:a05:6870:aa89:b0:25e:76f:13f8 with SMTP id
 586e51a60fabf-267d4f59947mr17107670fac.45.1722411894361; Wed, 31 Jul 2024
 00:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-4-sughosh.ganu@linaro.org>
In-Reply-To: <20240730111132.1097315-4-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 31 Jul 2024 10:44:17 +0300
Message-ID: <CAC_iWj+uH0A7_-EMJLsw8OYEOi2_+k9Xk=m=BSVpyboEaO12Dg@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi_memory: get the efi_mem_list node directly
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>
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

On Tue, 30 Jul 2024 at 14:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Use the list_for_each_entry() API to get the efi_mem_list node
> directly, instead of making an additional call to list_entry().
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  lib/efi_loader/efi_memory.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 8d4f6e339d..6819c2ec90 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -127,7 +127,7 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
>   */
>  static void efi_mem_sort(void)
>  {
> -       struct list_head *lhandle;
> +       struct efi_mem_list *lmem;
>         struct efi_mem_list *prevmem = NULL;
>         bool merge_again = true;
>
> @@ -136,13 +136,11 @@ static void efi_mem_sort(void)
>         /* Now merge entries that can be merged */
>         while (merge_again) {
>                 merge_again = false;
> -               list_for_each(lhandle, &efi_mem) {
> -                       struct efi_mem_list *lmem;
> +               list_for_each_entry(lmem, &efi_mem, link) {
>                         struct efi_mem_desc *prev;
>                         struct efi_mem_desc *cur;
>                         uint64_t pages;
>
> -                       lmem = list_entry(lhandle, struct efi_mem_list, link);
>                         if (!prevmem) {
>                                 prevmem = lmem;
>                                 continue;
> @@ -269,7 +267,7 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>                                           int memory_type,
>                                           bool overlap_only_ram)
>  {
> -       struct list_head *lhandle;
> +       struct efi_mem_list *lmem;
>         struct efi_mem_list *newlist;
>         bool carve_again;
>         uint64_t carved_pages = 0;
> @@ -309,11 +307,9 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>         /* Add our new map */
>         do {
>                 carve_again = false;
> -               list_for_each(lhandle, &efi_mem) {
> -                       struct efi_mem_list *lmem;
> +               list_for_each_entry(lmem, &efi_mem, link) {
>                         s64 r;
>
> -                       lmem = list_entry(lhandle, struct efi_mem_list, link);
>                         r = efi_mem_carve_out(lmem, &newlist->desc,
>                                               overlap_only_ram);
>                         switch (r) {
> @@ -445,7 +441,7 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
>   */
>  static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
>  {
> -       struct list_head *lhandle;
> +       struct efi_mem_list *lmem;
>
>         /*
>          * Prealign input max address, so we simplify our matching
> @@ -453,9 +449,7 @@ static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
>          */
>         max_addr &= ~EFI_PAGE_MASK;
>
> -       list_for_each(lhandle, &efi_mem) {
> -               struct efi_mem_list *lmem = list_entry(lhandle,
> -                       struct efi_mem_list, link);
> +       list_for_each_entry(lmem, &efi_mem, link) {
>                 struct efi_mem_desc *desc = &lmem->desc;
>                 uint64_t desc_len = desc->num_pages << EFI_PAGE_SHIFT;
>                 uint64_t desc_end = desc->physical_start + desc_len;
> @@ -745,7 +739,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
>  {
>         int map_entries;
>         efi_uintn_t map_size = 0;
> -       struct list_head *lhandle;
> +       struct efi_mem_list *lmem;
>         efi_uintn_t provided_map_size;
>
>         if (!memory_map_size)
> @@ -774,10 +768,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
>         /* Copy list into array */
>         /* Return the list in ascending order */
>         memory_map = &memory_map[map_entries - 1];
> -       list_for_each(lhandle, &efi_mem) {
> -               struct efi_mem_list *lmem;
> -
> -               lmem = list_entry(lhandle, struct efi_mem_list, link);
> +       list_for_each_entry(lmem, &efi_mem, link) {
>                 *memory_map = lmem->desc;
>                 memory_map--;
>         }
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
