Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2D9C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6683A871E6;
	Fri,  3 Nov 2023 20:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ocI5kuxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A6987468; Fri,  3 Nov 2023 20:39:30 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A48871E6
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-543456dbd7bso6847345a12.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699040358; x=1699645158; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7GZtxZE+PQVfGcgLZWqcb+XqrKO7b7/8FeEehSM2yyQ=;
 b=ocI5kuxnfdCKZ2frk9AStAVzLyCmkNfjq+Eeu70ADjpA+cigklHByYNQrhrodSN+WE
 D9g9qkYjaMpVC+AfJoxrzPL8LLlBu1191k4i9eS8jBKVmMrMU3ZkqiAypm3VN9sZPfl+
 TSsoH0tYjM/t1gOfzsZzX9rRyMYZv3jaGpQpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699040358; x=1699645158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GZtxZE+PQVfGcgLZWqcb+XqrKO7b7/8FeEehSM2yyQ=;
 b=Kq4iuWaqZoSd47Fku6n5Akppns8TXlilww6AKnGNF5/r67JQQQLndcyn73DL4Djogs
 soFAlPQQDya0imOPl6MaIfSg5jLPIDjPmkvvRBDN/06z9ZNGgmWlw2AtC+VLsN6wVdgr
 WrRRJYDB0cHzAaKuVhXi29XuING6gF+4pLihTVNRUwOnGPNGlk1qwcr4zH5mmDYB0zb2
 GZ64czLzDmlK0HPQu4b8JSOTAUng3yze4prYadt2Y04X5GFlH2TdqcwFR4abQdIQpryv
 ed+2suSBRD9OxdgWceZRa0PncnCiOYDGwxprPEdJSqe+/6WMmG+hosMEQMhcIvybN06J
 YXsQ==
X-Gm-Message-State: AOJu0Yx1NHWyucFKu50waHnrEmUIRRyQrepaQ476r5bRcJGA+Xhqr+En
 y7cM9ZRHiNEhpRmz8DHxmPDnD8EuZ0s6F1qMFBz7rA==
X-Google-Smtp-Source: AGHT+IG1V46WktF4ZZSxGw9bqE5GC/JqPL+tYtUI3kqFyUbwFGXoxxgYR0kxjQBq/HXom2+R7JhQFZ/OrDc3hY5l4aw=
X-Received: by 2002:a50:d550:0:b0:53e:ad97:82d3 with SMTP id
 f16-20020a50d550000000b0053ead9782d3mr3413312edj.13.1699040358550; Fri, 03
 Nov 2023 12:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
 <734658D7-8081-44DC-8168-6EBDBA8D951D@gmx.de>
 <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
 <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
 <CC91949C-3BBF-452B-906F-93520A314858@gmx.de>
 <CAPnjgZ0sgCtPXa5ZOOpW-zyCnVm_cNU3OyDjzPercdY1=Y1_dQ@mail.gmail.com>
 <20231103192548.GR496310@bill-the-cat>
In-Reply-To: <20231103192548.GR496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Nov 2023 13:38:59 -0600
Message-ID: <CAPnjgZ1QhQ0Kx7S8nof4Hs6cX9b+tKyMOyzg2dod-WvjOkoMTg@mail.gmail.com>
Subject: Re: [PATCH v2] smbios: arm64: Allow table to be written at a fixed
 addr
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
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

Hi Tom,

On Fri, 3 Nov 2023 at 13:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 03, 2023 at 12:14:46PM -0600, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Fri, 3 Nov 2023 at 11:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > >
> > >
> > > Am 3. November 2023 19:12:40 OEZ schrieb Simon Glass <sjg@chromium.org>:
> > > >Hi,
> > > >
> > > >On Sat, 28 Oct 2023 at 12:41, Simon Glass <sjg@chromium.org> wrote:
> > > >>
> > > >> [unfortunately I am not receiving email from the list at present]
> > > >>
> > > >> Hi Heinrich,
> > > >>
> > > >> On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >> >
> > > >> > On 10/25/23 04:49, Simon Glass wrote:
> > > >> > > Hi Heinrich,
> > > >> > >
> > > >> > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >> > >>
> > > >> > >>
> > > >> > >>
> > > >> > >> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > >> > >>> U-Boot typically sets up its malloc() pool near the top of memory. On
> > > >> > >>> ARM64 systems this can result in an SMBIOS table above 4GB which is
> > > >> > >>> not supported by SMBIOSv2.
> > > >> > >>>
> > > >> > >>> Work around this problem by providing a new option to choose an address
> > > >> > >>> below 4GB (but as high as possible), if needed.
> > > >> > >>
> > > >> > >> You must not overwrite memory controlled by the EFI subsystem without calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only a fallback for outdated tools.
> > > >> > >
> > > >> > > That is not my intention and I don't believe this code does that. EFI
> > > >> > > is not running at this point, is it?
> > > >> >
> > > >> > The function install_smbios_table() only exists if CONFIG_EFI_LOADER=y.
> > > >>
> > > >> That is because ARM devices don't normally need it, right? Anyway,
> > > >> that option isn't related to this patch. If ARM devices started using
> > > >> SMBIOS and had another way to pass it to Linux (other than EFI) then
> > > >> we would want to install it.
> > > >>
> > > >> >
> > > >> > We have:
> > > >> > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
> > > >> > This is invoked after efi_memory_init().
> > > >> >
> > > >> > The EFI specification requires that the memory area occupied by the
> > > >> > SMBIOS table uses one of a specific set of memory types where
> > > >> > EfiRuntimeServicesData is recommended. So you must call
> > > >> >
> > > >> > u64 addr = UINT_MAX;
> > > >> > ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> > > >> > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
> > > >> >
> > > >> > to allocate the memory. If the return code is not EFI_SUCCESS, no memory
> > > >> > below 4 GiB is available.
> > > >>
> > > >> The root problem here is that x86 and ARM used to work differently.
> > > >> When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
> > > >> table as part of the 'bootefi' command. On x86, the tables were
> > > >> written on startup, so you can examine them within U-Boot. Clearly the
> > > >> x86 approach is correct. For one thing, a previous-stage bootloader
> > > >> may set up the tables, so it simply isn't valid to write them in that
> > > >> case. So we need to separate writing the tables from telling EFI about
> > > >> them.
> > > >>
> > > >> So I have fixed that, so ARM now writes the tables at the start. But
> > > >> using an EFI allocation function is clearly not right. This is generic
> > > >> code, nothing to do with EFI, really. In fact, the SMBIOS writing
> > > >> should move out of efi_loader. The install_smbios_table() function
> > > >> should be somewhere in lib, i suppose, with just efi_smbios_register()
> > > >> sitting in lib/efi_loader
> > > >>
> > > >> Also, why is efi_memory_init() called early in init? Is there anything
> > > >> that needs that in the init sequence? Could we move it to the end, or
> > > >> perhaps skip it completely until the 'bootefi' command is used?
> > > >>
> > > >> Another point I should make is that it should be fine for U-Boot to
> > > >> put something in memory and then call efi_add_memory_map() to tell EFI
> > > >> about it. What problems does that cause? It isn't as if EFI allocates
> > > >> things in the 'conventional' memory (is that the name for memory below
> > > >> 4GB?) This is how efi_acpi_register() works.
> > > >>
> > > >> (Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
> > > >> drivers/video/rockchip_rk_vop.c and other such files)
> > > >>
> > > >> >
> > > >> > >
> > > >> > > The bit I am confused about is that we don't support SMBIOS3 in
> > > >> > > U-Boot. I am trying to fix an introduced bug...
> > > >> >
> > > >> > I would not know why we should not use SMBIOS 3.
> > > >>
> > > >> Neither do I. Perhaps there are compatibility concerns? If it is OK to
> > > >> do that then we could go back to my previous series [1]. What do you
> > > >> think?
> > > >
> > > >Tom responded but I missed it. In part it says:
> > > >
> > > >"So, can we please start by just doing the minimal changes to get the
> > > >SMBIOS table done correctly for memory above 4G, via EFI, and then start
> > > >the next steps?"
> > > >
> > > >I am OK to do an EFI hack for ARM so long as we agree that after the
> > > >release we will revert it and generate the table using generic memory
> > > >allocation, not dependent on EFI. Does that sound reasonable?
> > > >
> > > >I don't seem to have received any response from Heinrich to the
> > > >various points I made above. I cannot see any response on patchwork
> > > >either.
> > > >
> > > >Regards,
> > > >Simon
> > >
> > > All memory below the stack is controlled by the EFI subsystem. I notified you of the function you need to call. I can't see what information you are lacking.
> >
> > That is fine when EFI is used, but what about when it is not? That is
> > the piece I don't yet understand.
>
> We also don't have the use case for when EFI is not used defined and
> understood, so it can wait until then?

There is/was an argument going on where (for ARM) the SMBIOS table
requires ACPI and EFI. So I am nervous about anything like that. EFI
has become a huge impediment to booting with open source components.
If there has been an agreement on how ARM can boot without EFI (but
still provide SMBIOS), please can someone link to it?

The fact is that U-Boot makes lots of allocations while it runs. None
of them go through the EFI allocator, so far as I know. Certainly they
shouldn't. Then at the end, EFI just adds allocations for them
retrospectively. What change that?

EFI is not in control of memory allocation in U-Boot. In fact, the
efi_memory_init() call should probably be dropped, just done when
bootefi starts. It seems to be creating a lot of confusion.

My patch here does work, so far as I can tell. It adds an allocation
correctly, in the same manner as is done with ACPI - see
efi_acpi_register(). Given all the uncertainty I think we should
consider taking this patch as it is for now. I see it is marked as
'changes requested' in patchwork so I have changed it to 'New', hoping
that it will get another look.

Regards,
Simon
