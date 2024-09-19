Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3158FCF3959
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851A588A30;
	Thu, 19 Sep 2024 17:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VslD3DZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5577589235; Thu, 19 Sep 2024 17:30:40 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8E9889CD
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2d8815ef6d2so902709a91.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726759836; x=1727364636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=luumcGxGEpDNwOxf3uWDjONA9Sa8mP1gf40OQ/nwU1c=;
 b=VslD3DZ/urvXp1VNRc8Z/aIC+q66UTTN+LONwwNIBbMrTcP37Dn9tXl2abPtUBjUpK
 Ch5K0QvH2W83TC3Q/C84edi9z8fqkCFBqzdzRPbc8RDFHTWkhnna1aTcdG9jrsD4dhYJ
 AF60+H6L793OBqiy3hyo55pyo8Dwq+KoNFbiphn9w4RMBxaKVubtcIW4X97r3tKNFkHc
 N991dgncMeDiCxX/k1LL2h+qJNcShyFAnxGlnl8nq1hdFcr1H2zW8uTbR+K73Q1IDJGS
 gi46PieqOjFPFyTaSJYVN7W2wXOUWnBGKx7bsY8D0cTd7katoJSQQdRit3hJALkQm5+7
 S0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726759836; x=1727364636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=luumcGxGEpDNwOxf3uWDjONA9Sa8mP1gf40OQ/nwU1c=;
 b=DHvFRofleOExnwe6qxUH08pzYdRSrGU5oX41DWukM3DCPo/v3RxFAe9Ih8pQbukdu9
 3UnVj2jSHhn6rvUgcCpn7xFuvD4CyoKtyRR5cFajQ6in1eg4J7jjE11KRvgZx0BZCMJ6
 Mu9DNNYqVDpYE9sWRr/jw5TLWu9jC9Xdm3FMFMNarV+tdqU0O1n9R43hjIREJEa2+buG
 DXBa1S1Js/0caEaan+ygHEKmclRZ27crin0x10ViQJcEFBwRgFTAyGJUN+2W66M+Whb6
 nUxADBk0WF2b3Fc4OglWx7QKfuZz4xXmHIwD9OFNmiazy3ruZYxJWARL+wa7fifTZaIH
 auQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPDFV896rMWQGBpzKrkB4JEx4+NsAcn+z/nUugZoJ4vmDR8c7GZrxdJtHL7G1uTcp4/JaP3VE=@lists.denx.de
X-Gm-Message-State: AOJu0YxrMY3t1pIyEaBjzbi7FvpHgceg5flBHVWgOO9lEBPzHIYmSg2+
 k9k9u79qPHhejD2XFior+fd4+14JK/9sIh8V+2mKuKF/NXizKMbM8MA5ulDS+HWg82SmhONvBbc
 PQT4b7f5826jnT3yAnxhLZ8ntk1hDhtkE5ZyHmrg39iqvhegd
X-Google-Smtp-Source: AGHT+IGEudYJJJymRaZfANJhL652xvIGwfKPGobYMLB2medOInjbZGpGBD/8y0pvwXhnlasqMlinShmoPkeYG74IwWI=
X-Received: by 2002:a17:90a:3981:b0:2d8:5b9f:75ab with SMTP id
 98e67ed59e1d1-2dba00681cbmr35678549a91.29.1726759836282; Thu, 19 Sep 2024
 08:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
 <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
 <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
 <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
In-Reply-To: <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 18:30:00 +0300
Message-ID: <CAC_iWjLW3O=zj5GQrRtMbPbcF9g=qHxeJvPj435PBxNyyMosAQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 19 Sept 2024 at 18:19, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
>
> [...]
>
> > > > > +
> > > > > +               if (!addr)
> > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > +       } else {
> > > > > +               pages = efi_size_in_pages(TABLE_SIZE);
> > > > > +
> > > > > +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > > > > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > > > > +                                        pages, &new_acpi_addr);
> > > > > +               if (ret != EFI_SUCCESS)
> > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > +
> > > > > +               addr = (void *)(uintptr_t)new_acpi_addr;
> > > > > +       }
> > > > > +
> > > >
> > > > The tables should be written regardless of whether EFI_LOADER is enabled.
> > >
> > > *Why*? How do you expect to hand them over to the OS?
> >
> > Why - because boards which need ACPI tables to boot should generate
> > them;
>
> Noone argued that.
>
> > also this happens when U-Boot starts up, in last_stage_init()
> > How - it isn't possible, but eventually I suppose it will be, once we
> > have a use case for booting with ACPI but without EFI
>
> Are you aware of such an OS? If not, we can accept the patches when we
> have a reason.
> I remember patches being hard NAK'ed on using DTs to pass the ACPI
> table address in the past.
>
> >
> > >
> > > >
> > > > Can we drop this else clause? We should always use the bloblist.
> > >
> > > Both Heinrich and I said the exact opposite. Unless there's a
> > > perfectly good reason why we should keep them in bloblist memory, I'd
> > > like us to do that
> >
> > The main reason is that we should not be putting things in memory
> > between the start of RAM and the bottom of the U-Boot area. That
> > region of memory is supposed to be for loading images. Most boards
> > hard-code the image-load addresses in environment variables. But even
> > if they didn't, we should not be using that memory for U-Boot data.
>
> EFI allows you to request a specific address to use. We can choose one
> that fits the requirements
>
> >
> > Another reason is that the bloblist is designed for this, for keeping
> > tables in a small, contiguous area of memory, so that when passed to
> > Linux they are not spread all over the place.
>
> Linux does not and will not read tables from a bloblist though

Also it's ACPI_RECLAIM memory. The OS doesn't really care if it's
scattered or not. It is up to the OS to reuse it.

/Ilias
>
> Thanks
> /Ilias
>
>
>
> >
> > Regards,
> > Simon
> >
> >
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > We should use efi_add_memory_map() to add to the memory map.
> > > >
> > > > > +       table_addr = virt_to_phys(addr);
> > > > > +
> > > > > +       gd->arch.table_start_high = table_addr;
> > > > > +
> > > > > +       table_end = write_acpi_tables(table_addr);
> > > > > +       if (!table_end) {
> > > > > +               log_err("Can't create ACPI configuration table\n");
> > > > > +               return -EINTR;
> > > > > +       }
> > > > > +
> > > > > +       log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, table_end);
> > > > > +       if (table_end - table_addr > TABLE_SIZE) {
> > > > > +               log_err("Out of space for configuration tables: need %llx, have %x\n",
> > > > > +                       table_end - table_addr, TABLE_SIZE);
> > > > > +               return log_msg_ret("acpi", -ENOSPC);
> > > > > +       }
> > > > > +       gd->arch.table_end_high = table_end;
> > > > > +
> > > > > +       log_debug("- done writing tables\n");
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
> > > > > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> > > > > index e282c67335..459bfa26bb 100644
> > > > > --- a/test/py/tests/test_event_dump.py
> > > > > +++ b/test/py/tests/test_event_dump.py
> > > > > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> > > > >  --------------------  ------------------------------  ------------------------------
> > > > >  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
> > > > >  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> > > > > +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader/efi_acpi.c:.*
> > > > >  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
> > > > >  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
> > > > >  EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> > > > > --
> > > > > 2.46.0
> > > > >
> > > >
> > > > REgards,
> > > > Simon
