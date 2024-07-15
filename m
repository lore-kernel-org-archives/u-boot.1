Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E410C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 09:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC2487F9F;
	Mon, 15 Jul 2024 11:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y+n9mvXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B128487EFA; Mon, 15 Jul 2024 11:39:32 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4150D87F9F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 11:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f3f9so4718656a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036370; x=1721641170; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FDMlYzV65zk/XjljYEik1XwrwKrRsQej0gpFhuZ8dac=;
 b=y+n9mvXRXLw90LoB1VeHHhvcps9dkwAbp8ggKL3RiF/wNZ9pfyTU/fYfw70+eUGGmz
 ZIoeQ+xdYa2okOUKj/P83tBZQx2Q6dvORIgHd2J+O96EpQ0f00F2MWQrgeaSuoetZJkj
 2Ix378F+fwP0Fd3geWmRAo4M4gjJW7ya3qzEVKlkiDzWZAwEkWOXiUVfJC1MQv6kKpy4
 1xXaxT9HKF3qH4QBJ8rwn6F9eeKxF47mACpBUrXcZ0DYKwUfONa0Puhlrk/5U6dDFgW2
 KK03VmeGxhZtOPfZyjewMBv+LAaQmE+1lx9UWgwXk/294qwRjsDGX5sCssP4PQYz7kRr
 VeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036370; x=1721641170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDMlYzV65zk/XjljYEik1XwrwKrRsQej0gpFhuZ8dac=;
 b=fMM+pasItsmZ19a1DAUhA7hmQrcLShgGTchixIZVJ+sA+euxsVVgTnpW0JbG9HlwwZ
 WBzUp7cSLsBalLrmA6WdPyqr7f3h/r/WJabQG79tQKHwUS3s/3g+erDdYdT1yUpp/NRI
 7sag0JwcMN4GF1nxjvu2IbBkycQQbI15u3L7J6bLihhvfyh0NwAKiKJPc6UA68CdFKpi
 U+OSref0GS/w/UVhZ3g6NywBFDNsB5vwL2Dvc0GIwsUAsfHsPlfJskGZ4wEU3J1prmPn
 IxScdSsoHJpt6qIUA9pcehBtxF+IltVpuFQfWj2oP3JxNligBJG887R1uffq55flmaXL
 ln4g==
X-Gm-Message-State: AOJu0YwxBN9UrcHYSjSxph6cxoxFJcRTWe71t+NaKHYycIUFt0R7+5fK
 krYkb/5Gx6a/Hym7QJGx0tx6NA2sjj16+7wCrSb1RmEyZKJG8K2d2KuLOahMSp2i5xlOFzo5Lsz
 rU/tOMoW1RNI906eEXtR9edNiR394ycmV4DxBng==
X-Google-Smtp-Source: AGHT+IGzmd4tlSkoATCvr5XflUruCf4becZfOB0SleH1vq6LMIzxOsKSSvqzMSV0LxqSnsFTXAy3BbanuvEY/Us48Bg=
X-Received: by 2002:a05:6402:2105:b0:579:cd46:cbfd with SMTP id
 4fb4d7f45d1cf-594b9ee10fbmr12887421a12.18.1721036369626; Mon, 15 Jul 2024
 02:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-42-sughosh.ganu@linaro.org>
 <CAFLszTiXtfFh3K8Ft1nTzBizSitk_dyK7n0BsRccNNe6TimFoQ@mail.gmail.com>
In-Reply-To: <CAFLszTiXtfFh3K8Ft1nTzBizSitk_dyK7n0BsRccNNe6TimFoQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 15 Jul 2024 15:09:17 +0530
Message-ID: <CADg8p97fwAvebfrANXwWc7At78wU59XXymTFWCvuaFHMGj+9zg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 41/48] efi_memory: add an event handler to update
 memory map
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

hi Simon,

On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > There are events that would be used to notify other interested modules
> > of any changes in available and occupied memory. This would happen
> > when a module allocates or reserves memory, or frees up memory. These
> > changes in memory map should be notified to other interested modules
> > so that the allocated memory does not get overwritten. Add an event
> > handler in the EFI memory module to update the EFI memory map
> > accordingly when such changes happen. As a consequence, any subsequent
> > memory request would honour the updated memory map and only available
> > memory would be allocated from.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Handle the addition of memory to the LMB memory map.
> > * Pass the overlap_only_ram parameter to the efi_add_memory_map_pg()
> >   based on the type of operation.
> >
> >  lib/efi_loader/Kconfig      |  1 +
> >  lib/efi_loader/efi_memory.c | 34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >
>
> This is getting complicated and I don't believe it is needed.
>
> EFI should not be allocating memory 'in free space' until it starts
> up. For the very few (if any) cases where it does, it can do an lmb
> allocation.

EFI memory module is not allocating memory at all now. This patch is
adding an event handler for updating the EFI memory map, whenever the
LMB memory map changes. All the EFI allocations are now being routed
through the LMB API's.

>
> As to the lmb allocations themselves, EFI can simply call look through
> the lmb list and call efi_add_memory_map_pg() for each entry, when it
> is ready to boot. There is no need to do it earlier.

So in this case, I believe that rather than adding code in multiple
places where the EFI memory module would have to get the LMB map and
then update it's own, I think it is easier to update the EFI memory
map as and when the LMB map gets updated. Else, we have a scenario
where the EFI memory map would have to be updated as part of the EFI
memory map dump function, as well as before the EFI boot. Any new code
that would be subsequently introduced that might have a similar
requirement would then be needed to keep this point in mind(to get the
memory map from LMB).

This is not an OS file-system kind of an operation where performance
is critical, nor is this event(LMB memory map update) going to happen
very frequently. So I believe that it would be better to keep the EFI
memory map updated along with the LMB one.

-sughosh

>
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index bdf5732974..2d90bcef2f 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -16,6 +16,7 @@ config EFI_LOADER
> >         select CHARSET
> >         # We need to send DM events, dynamically, in the EFI block driver
> >         select DM_EVENT
> > +       select EVENT
> >         select EVENT_DYNAMIC
> >         select LIB_UUID
> >         select LMB
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 5691b5da03..bd12504f72 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -45,6 +45,10 @@ static LIST_HEAD(efi_mem);
> >  void *efi_bounce_buffer;
> >  #endif
> >
> > +#define MAP_OP_RESERVE         (u8)0x1
> > +#define MAP_OP_FREE            (u8)0x2
> > +#define MAP_OP_ADD             (u8)0x3
> > +
> >  /**
> >   * struct efi_pool_allocation - memory block allocated from pool
> >   *
> > @@ -928,3 +932,33 @@ int efi_memory_init(void)
> >
> >         return 0;
> >  }
> > +
> > +#if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > +{
> > +       u8 op;
> > +       u64 addr;
> > +       u64 pages;
> > +       efi_status_t status;
> > +       struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > +
> > +       addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > +       pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > +       op = lmb_map->op;
> > +       addr &= ~EFI_PAGE_MASK;
> > +
> > +       if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
> > +               log_debug("Invalid map update op received (%d)\n", op);
> > +               return -1;
> > +       }
> > +
> > +       status = efi_add_memory_map_pg(addr, pages,
> > +                                      op == MAP_OP_RESERVE ?
> > +                                      EFI_BOOT_SERVICES_DATA :
> > +                                      EFI_CONVENTIONAL_MEMORY,
> > +                                      op == MAP_OP_RESERVE ? true : false);
> > +
> > +       return status == EFI_SUCCESS ? 0 : -1;
> > +}
> > +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> > +#endif /* MEM_MAP_UPDATE_NOTIFY */
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
