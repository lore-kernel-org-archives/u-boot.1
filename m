Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32633E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96EC8039A;
	Wed, 11 Dec 2024 16:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SK8wKbPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B98F80384; Wed, 11 Dec 2024 16:54:02 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F02DE80303
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-728f1525565so853546b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733932438; x=1734537238; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dIQGNBA1bgXuX5YXw7gP0nS5ZiqHIGDMe/hAdwEBMJY=;
 b=SK8wKbPyXudGiGyzNG6n3bzXFBjlGJIUCviYIuruWRh9RprBDxqerTXG00OxZoOgHv
 QygG2Yh666bMtspq3LzOPnFHDrIgJ4AJ0UwF9mVS/hXJUbwIzByQm02LnmMqKhhrzV7/
 YlTwQEbWCzjTB6dCPiIDj47FxVhQfv3tzia4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932438; x=1734537238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIQGNBA1bgXuX5YXw7gP0nS5ZiqHIGDMe/hAdwEBMJY=;
 b=YJ/vTfdTMw4lj75qp/6RqAwAfwpwVmwkFZ1GLNTkNJz1h6bKwbwyKONaxdczobv2/R
 KLmjSYAfQGLbXxXzOIEXKyc5iAM0thZZY3nRzVpbtPoCvFk0apxqZo6gPW2XTB3m9Fob
 Y4n+/KC6ixc+6ADTZNhfzY7Xt9HazkpNURmwOWwqaRTvwPjzvX/9vz8tlTb0UNz7FnzY
 NeJ2kspv7J817jgzO+eLR7KUl7RIDHwXqcQGBEuClIiLETg6M4KT+X6SMPo48MDzYmbj
 +7ZE9IP2niqqew9WRtvHmbVPFPnceEvGsiR0iLTCVV7GID7YV0Vmj64sMPKCrQRFoLgh
 XhZA==
X-Gm-Message-State: AOJu0YyXeb6PelXctKzraXeVkMjLKdmJk0MJYcRwaFb8MQqt8kvzIpy8
 y85CfhpJcZd9gGBL1oKv2KVEpY+ZXMfCcITu8gL0QArhc8LtcVrMHbRNCkXlQ4S1DoXmTladaUY
 nUL3XjzWCp5QKzCZIbRRBQUUHO8+0g0imFp51
X-Gm-Gg: ASbGnct/CwqFHRva05dS4+XUaN+sPjyVU9TFYT0KzSZctI9wRiMKDvdDRl0Milq/0r2
 uonYheeIKLWy+XsdKcrk0C8KHJJ47tHohJzds
X-Google-Smtp-Source: AGHT+IFWC9AGO9E548HHnX+XImrjIYjNp7f8uTV8pth4hph1MdOGcqLYBoUcDSKPuOQ1kGbFEs+UVdWczGjTIDqgLgw=
X-Received: by 2002:a05:6a20:3948:b0:1e0:d1f7:9437 with SMTP id
 adf61e73a8af0-1e1c1413762mr4869696637.38.1733932438343; Wed, 11 Dec 2024
 07:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-9-sjg@chromium.org>
 <CAC_iWjKnvOsKP7sa447yaQB7_G6nvbY=FxDWuFxkW5pt=cXXeQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKnvOsKP7sa447yaQB7_G6nvbY=FxDWuFxkW5pt=cXXeQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 08:53:41 -0700
Message-ID: <CAFLszTiHDiGSYD=LxBNj8mA-nYeXc_2B4NU=7c-hKp7iKCPQSA@mail.gmail.com>
Subject: Re: [PATCH v5 08/23] efi_loader: Use a separate struct for memory
 nodes
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Wed, 11 Dec 2024 at 08:08, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > At present efi_memory uses struct efi_mem_desc for each node of its
> > memory list. This is convenient but is not ideal, since:
> >
> > - it means that the fields are under a 'desc' sub-structure
> > - it includes an unused 'reserved' field
>
> That's interesting. The EFI spec does not define that and I looked as
> back as 2.5.
> Heinrich, this predates my involvement with EFI, do you remember why
> it was added?
>
> Because it's defined in
> > - it includes virtual_start which is confusing as it is always the same
> >   as physical_start
> > - we must use u64 to store pointers, since that is how they are returned
> >   by calls to efi_get_memory_map()
>
> I don't understand the 'pointers' again here. It's a physical address.
>

Let's have a call so I can explain this...

> >
> > As a first step to tidying this up, create a new, private struct to hold
> > these fields.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Add new patch to use a separate stuct for memory nodes
> >
> >  lib/efi_loader/efi_memory.c | 49 +++++++++++++++++++++++++++++++------
> >  1 file changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 4bc6d12a1fe..db40aee8353 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -27,9 +27,39 @@ DECLARE_GLOBAL_DATA_PTR;
> >
> >  efi_uintn_t efi_memory_map_key;
> >
> > +/**
> > + * struct priv_mem_desc - defines an memory region
> > + *
> > + * Note that this struct is for use inside U-Boot and is not visible to the
> > + * EFI application, other than through calls to efi_get_memory_map(), where this
> > + * internal format is converted to the external struct efi_mem_desc format.
> > + *
> > + * @type (enum efi_memory_type): EFI memory-type
> > + * @reserved: unused
> > + * @physical_start: Start address of region in physical memory
> > + * @virtual_start: Start address of region in physical memory
> > + * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
> > + *     bytes)
> > + * @attribute: Memory attributes (see EFI_MEMORY...)
> > + */
> > +struct priv_mem_desc {
> > +       u32 type;
> > +       u32 reserved;
> > +       efi_physical_addr_t physical_start;
> > +       efi_virtual_addr_t virtual_start;
> > +       u64 num_pages;
> > +       u64 attribute;
> > +};
>
> This is not private, it's described by the EFI spec.

It is private to this module, and future patches change it to be used
only in this file, so I have commented and named it that way.

>
> > +
> > +/**
> > + * struct efi_mem_list - defines an EFI memory record
> > + *
> > + * @link: Link to prev/next node in list
> > + * @desc: Memory information about this node
> > + */
> >  struct efi_mem_list {
> >         struct list_head link;
> > -       struct efi_mem_desc desc;
> > +       struct priv_mem_desc desc;
> >  };
> >
> >  #define EFI_CARVE_NO_OVERLAP           -1
> > @@ -116,7 +146,7 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
> >   * @desc:      memory descriptor
> >   * Return:     end address + 1
> >   */
> > -static uint64_t desc_get_end(struct efi_mem_desc *desc)
> > +static uint64_t desc_get_end(struct priv_mem_desc *desc)
> >  {
> >         return desc->physical_start + (desc->num_pages << EFI_PAGE_SHIFT);
> >  }
> > @@ -138,8 +168,8 @@ static void efi_mem_sort(void)
> >         while (merge_again) {
> >                 merge_again = false;
> >                 list_for_each_entry(lmem, &efi_mem, link) {
> > -                       struct efi_mem_desc *prev;
> > -                       struct efi_mem_desc *cur;
> > +                       struct priv_mem_desc *prev;
> > +                       struct priv_mem_desc *cur;
> >                         uint64_t pages;
> >
> >                         if (!prevmem) {
> > @@ -194,11 +224,11 @@ static void efi_mem_sort(void)
> >   * to re-add the already carved out pages to the mapping.
> >   */
> >  static s64 efi_mem_carve_out(struct efi_mem_list *map,
> > -                            struct efi_mem_desc *carve_desc,
> > +                            struct priv_mem_desc *carve_desc,
> >                              bool overlap_conventional)
> >  {
> >         struct efi_mem_list *newmap;
> > -       struct efi_mem_desc *map_desc = &map->desc;
> > +       struct priv_mem_desc *map_desc = &map->desc;
> >         uint64_t map_start = map_desc->physical_start;
> >         uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
> >         uint64_t carve_start = carve_desc->physical_start;
> > @@ -678,7 +708,12 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
> >         /* Return the list in ascending order */
> >         memory_map = &memory_map[map_entries - 1];
> >         list_for_each_entry(lmem, &efi_mem, link) {
> > -               *memory_map = lmem->desc;
>
> What's wrong with that ?

There are two different structs now

>
> > +               memory_map->type = lmem->desc.type;
> > +               memory_map->reserved = lmem->desc.reserved;
> > +               memory_map->physical_start = lmem->desc.physical_start;
> > +               memory_map->virtual_start = lmem->desc.virtual_start;
> > +               memory_map->num_pages = lmem->desc.num_pages;
> > +               memory_map->attribute = lmem->desc.attribute;
> >                 memory_map--;
> >         }
> >
> > --
> > 2.34.1
> >
>
> The only problem I see here is the reserved field. I think this patch
> should just remove that

OK

Regards,
Simon
