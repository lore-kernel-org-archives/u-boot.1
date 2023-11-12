Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C077C4167B
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 363A686CF2;
	Sun, 12 Nov 2023 21:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a89A2oGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5854186D1D; Sun, 12 Nov 2023 21:02:08 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8EA86BF7
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5ac376d311aso41655577b3.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819325; x=1700424125; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aJ9afwsZJdjgyBea+KorE9ivUuef/PIoFTlL6tfGqpE=;
 b=a89A2oGLQAF7clM//nqLUAlPlTrbHv7YmXQSSmIhxIe+CxIg6cRIwtpsTC7MclcXN7
 opAt8+AaJZJjARwXgtmHucewyWHJ+hh0/+Hh7GiZWemb5O5tFtFycDEWo4A2/Qr+wODU
 eMP2xWroc6PMkvp2nDANxaHvQBmUac7LLAYO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819325; x=1700424125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aJ9afwsZJdjgyBea+KorE9ivUuef/PIoFTlL6tfGqpE=;
 b=ejIZU+D5Wc4T4OAPkz29HjDL4OqQQ8hr3BaH3nfiEqpwCSRDsi3f3gFnGjHFyhARA1
 L0RJQxlB2PZg6nT2lBM0BOW+180ae5OIrJ4+WzCtl2QjhlID452lDhFUcsXAJ+R/hxn0
 HQygR2zlk4oKmD6mLBrNZRw7TuKCTRv35ModpxR7R1Gow0ehJj6eZMIDLNx6xzqdmU91
 8ZpGSwRMZ1JD86a8pIgP8p1NZ8paH1SOKMk9eCpW22o4j4NWxAsl7v2u3y03eQLtwbai
 4IKq5Y7KbMqgaLx2zqRx894VcP9BnMCSpSsKz7DK3NiGmsChbqld0sCRQdDrELG0LVEA
 4Ssg==
X-Gm-Message-State: AOJu0Yxz9ZGmuKjCxiWhZQBpvShsxKDs/pxcQTSrOgD1k+G6MUaw4v3t
 sz9I0x3xAi/2m96uaqjejrk5dbLXEVrMcaU0Dmxfng==
X-Google-Smtp-Source: AGHT+IHAWVURCynmf8sVFpTT5beSPfNoF+wTl+1mJst/syfT4QWn8JqLT8Q2ffI4LPkAuk+DTXaP22DCMwqDZLB7T5k=
X-Received: by 2002:a25:abc3:0:b0:d9c:a7fa:dbcb with SMTP id
 v61-20020a25abc3000000b00d9ca7fadbcbmr4652020ybi.22.1699819324741; Sun, 12
 Nov 2023 12:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-3-sjg@chromium.org>
 <141b3e06-2383-4fd4-929b-520a6c7c4af9@gmx.de>
In-Reply-To: <141b3e06-2383-4fd4-929b-520a6c7c4af9@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:14 -0700
Message-ID: <CAPnjgZ0H2Lkr2CgvmDit0b7NbeGR0abVj8DNW7W8Hc2JLm7P5g@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi: Collect the ACPI tables in the app
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 12 Nov 2023 at 09:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/12/23 16:58, Simon Glass wrote:
> > Locate these so that they can be displayed using the 'acpi' command.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   lib/efi/efi_app.c | 24 +++++++++++++++++++++---
> >   1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
> > index 2209410f35b5..c5eb816655ea 100644
> > --- a/lib/efi/efi_app.c
> > +++ b/lib/efi/efi_app.c
> > @@ -12,18 +12,21 @@
> >   #include <cpu_func.h>
> >   #include <debug_uart.h>
> >   #include <dm.h>
> > +#include <efi.h>
> > +#include <efi_api.h>
> >   #include <errno.h>
> >   #include <init.h>
> >   #include <malloc.h>
> > +#include <sysreset.h>
> > +#include <uuid.h>
> >   #include <asm/global_data.h>
> >   #include <linux/err.h>
> >   #include <linux/types.h>
> > -#include <efi.h>
> > -#include <efi_api.h>
> > -#include <sysreset.h>
> > +#include <asm/global_data.h>
> >   #include <dm/device-internal.h>
> >   #include <dm/lists.h>
> >   #include <dm/root.h>
> > +#include <mapmem.h>
> >
> >   DECLARE_GLOBAL_DATA_PTR;
> >
> > @@ -320,6 +323,19 @@ int dm_scan_other(bool pre_reloc_only)
> >       return 0;
> >   }
> >
> > +static void scan_tables(struct efi_system_table *sys_table)
> > +{
> > +     efi_guid_t acpi = EFI_ACPI_TABLE_GUID;
> > +     uint i;
> > +
> > +     for (i = 0; i < sys_table->nr_tables; i++) {
> > +             struct efi_configuration_table *tab = &sys_table->tables[i];
> > +
> > +             if (!memcmp(&tab->guid, &acpi, sizeof(efi_guid_t)))
> > +                     gd_set_acpi_start(map_to_sysmem(tab->table));
> > +     }
>
> Should we have a function efi_get_configuration_table(efi_guid_t *guid)
> that we can use to retrieve different configuration tables?
>
> This would allow us to read the device-tree on non-x86 tables.
>
> We may at some point also be interested in reading the
> EFI_RT_PROPERTIES_TABLE to find out which runtime services we are
> allowed to call.
>
> Or would you prefer to all of this into scan_tables()?

I'm not sure...but perhaps the best approach is to use this function
to find all the tables we are interested in?

BTW I started this series with a view to figuring out what is needed
to make the app boot Linux, etc. It is a bit strange since the boot
services need to be 'passed through' U-Boot to the underlying UEFI.

Regards,
Simon
