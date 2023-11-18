Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836BAC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB7BF87509;
	Sat, 18 Nov 2023 18:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oW0dCQsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DC3874EA; Sat, 18 Nov 2023 18:12:08 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE3D8700A
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dae7cc31151so2781877276.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327523; x=1700932323; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IbmSJX/4pLtaZ86SxmcnkjYe1RNujwRVeuY55rK1s4c=;
 b=oW0dCQsU/C3UXKeIaDvgUUFYIYzxqgDV5S8s+p4Lvy0lg84RfO56IBqVyneAKR2dE9
 RTdGD894FdhcS/tblX1Y5rWkbqU77tFK0NpVE/F33Oy4NTkNOAzZwwY3NHe9O5MymGw5
 4TNph7sBg4vYHe5F3M4kBeoTnftaqiMT6JTHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327523; x=1700932323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IbmSJX/4pLtaZ86SxmcnkjYe1RNujwRVeuY55rK1s4c=;
 b=lG7WRO56eM0PCy4Dcj/z4wDBneCw8pKjOKewLtdK35uoj47TEH104vWx/VMSm0HzyP
 +bMJNMY3yKiqPVDb4SXLMxajGQp3ggAUurFVWR5G/cUwX9Mgx0rfHTgGoxwgqgRadjE5
 vuU6eb0ZbSKTwtBSrjOpVJeP/liYjW+OgH3mm3II5QtIVhCVnxNOUXIlCJKZma3WQyBV
 +w46HjNiptdU0XNiGUGU+D1U4G3zAa069gTUYlzp6sVy3t9XthoXv5/rIuIYhnbuA5sI
 R4JIx8QKRJEAS4vuMD8pxuX21wwXhsLnb7kKVjy8YAUWV25aAYspDH3MplncdrlunM8C
 MdXg==
X-Gm-Message-State: AOJu0YxMHjtrTXzhX2rgtkTMQIyFbX0beqReClzdzsev85YvRbZ8wYIq
 szUdBmRrME+llFulxJbCFDjrQjr/evLtaOhgjMA11Q==
X-Google-Smtp-Source: AGHT+IHkZso+eYN854wWGAFat6VJo7HyezCEDGmgegxbUq+UgOhQ3J8ixxVIYj5VAOaBDlk3OByzsilRMLWwVzEHcqM=
X-Received: by 2002:a0d:cf46:0:b0:591:15a6:c11f with SMTP id
 r67-20020a0dcf46000000b0059115a6c11fmr2654478ywd.50.1700327523344; Sat, 18
 Nov 2023 09:12:03 -0800 (PST)
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
 <CAPnjgZ1QhQ0Kx7S8nof4Hs6cX9b+tKyMOyzg2dod-WvjOkoMTg@mail.gmail.com>
 <20231103201341.GU496310@bill-the-cat>
In-Reply-To: <20231103201341.GU496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:17 -0700
Message-ID: <CAPnjgZ2LnT=esHGNRf0RNCPaf1BNhzA+QxWcQbjnBfy9B3QUuQ@mail.gmail.com>
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

On Fri, 3 Nov 2023 at 14:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 03, 2023 at 01:38:59PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 3 Nov 2023 at 13:26, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Nov 03, 2023 at 12:14:46PM -0600, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Fri, 3 Nov 2023 at 11:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > >
> > > > >
> > > > > Am 3. November 2023 19:12:40 OEZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > >Hi,
> > > > > >
> > > > > >On Sat, 28 Oct 2023 at 12:41, Simon Glass <sjg@chromium.org> wrote:
> > > > > >>
> > > > > >> [unfortunately I am not receiving email from the list at present]
> > > > > >>
> > > > > >> Hi Heinrich,
> > > > > >>
> > > > > >> On Wed, 25 Oct 2023 at 21:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > >> >
> > > > > >> > On 10/25/23 04:49, Simon Glass wrote:
> > > > > >> > > Hi Heinrich,
> > > > > >> > >
> > > > > >> > > On Tue, 24 Oct 2023 at 18:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > >> > >>
> > > > > >> > >>
> > > > > >> > >>
> > > > > >> > >> Am 25. Oktober 2023 01:31:19 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > >> > >>> U-Boot typically sets up its malloc() pool near the top of memory. On
> > > > > >> > >>> ARM64 systems this can result in an SMBIOS table above 4GB which is
> > > > > >> > >>> not supported by SMBIOSv2.
> > > > > >> > >>>
> > > > > >> > >>> Work around this problem by providing a new option to choose an address
> > > > > >> > >>> below 4GB (but as high as possible), if needed.
> > > > > >> > >>
> > > > > >> > >> You must not overwrite memory controlled by the EFI subsystem without calling its allocator.  We should provide SMBIOS 3. SMBIOS 2 is only a fallback for outdated tools.
> > > > > >> > >
> > > > > >> > > That is not my intention and I don't believe this code does that. EFI
> > > > > >> > > is not running at this point, is it?
> > > > > >> >
> > > > > >> > The function install_smbios_table() only exists if CONFIG_EFI_LOADER=y.
> > > > > >>
> > > > > >> That is because ARM devices don't normally need it, right? Anyway,
> > > > > >> that option isn't related to this patch. If ARM devices started using
> > > > > >> SMBIOS and had another way to pass it to Linux (other than EFI) then
> > > > > >> we would want to install it.
> > > > > >>
> > > > > >> >
> > > > > >> > We have:
> > > > > >> > EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
> > > > > >> > This is invoked after efi_memory_init().
> > > > > >> >
> > > > > >> > The EFI specification requires that the memory area occupied by the
> > > > > >> > SMBIOS table uses one of a specific set of memory types where
> > > > > >> > EfiRuntimeServicesData is recommended. So you must call
> > > > > >> >
> > > > > >> > u64 addr = UINT_MAX;
> > > > > >> > ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> > > > > >> > EFI_RUNTIME_SERVICES_DATA, efi_size_in_pages(size), *addr);
> > > > > >> >
> > > > > >> > to allocate the memory. If the return code is not EFI_SUCCESS, no memory
> > > > > >> > below 4 GiB is available.
> > > > > >>
> > > > > >> The root problem here is that x86 and ARM used to work differently.
> > > > > >> When the ARM SMBIOS stuff was done, it worked by writing the SMBIOS
> > > > > >> table as part of the 'bootefi' command. On x86, the tables were
> > > > > >> written on startup, so you can examine them within U-Boot. Clearly the
> > > > > >> x86 approach is correct. For one thing, a previous-stage bootloader
> > > > > >> may set up the tables, so it simply isn't valid to write them in that
> > > > > >> case. So we need to separate writing the tables from telling EFI about
> > > > > >> them.
> > > > > >>
> > > > > >> So I have fixed that, so ARM now writes the tables at the start. But
> > > > > >> using an EFI allocation function is clearly not right. This is generic
> > > > > >> code, nothing to do with EFI, really. In fact, the SMBIOS writing
> > > > > >> should move out of efi_loader. The install_smbios_table() function
> > > > > >> should be somewhere in lib, i suppose, with just efi_smbios_register()
> > > > > >> sitting in lib/efi_loader
> > > > > >>
> > > > > >> Also, why is efi_memory_init() called early in init? Is there anything
> > > > > >> that needs that in the init sequence? Could we move it to the end, or
> > > > > >> perhaps skip it completely until the 'bootefi' command is used?
> > > > > >>
> > > > > >> Another point I should make is that it should be fine for U-Boot to
> > > > > >> put something in memory and then call efi_add_memory_map() to tell EFI
> > > > > >> about it. What problems does that cause? It isn't as if EFI allocates
> > > > > >> things in the 'conventional' memory (is that the name for memory below
> > > > > >> 4GB?) This is how efi_acpi_register() works.
> > > > > >>
> > > > > >> (Aside: it is bizarre to me that CONFIG_EFI_LOADER appears in
> > > > > >> drivers/video/rockchip_rk_vop.c and other such files)
> > > > > >>
> > > > > >> >
> > > > > >> > >
> > > > > >> > > The bit I am confused about is that we don't support SMBIOS3 in
> > > > > >> > > U-Boot. I am trying to fix an introduced bug...
> > > > > >> >
> > > > > >> > I would not know why we should not use SMBIOS 3.
> > > > > >>
> > > > > >> Neither do I. Perhaps there are compatibility concerns? If it is OK to
> > > > > >> do that then we could go back to my previous series [1]. What do you
> > > > > >> think?
> > > > > >
> > > > > >Tom responded but I missed it. In part it says:
> > > > > >
> > > > > >"So, can we please start by just doing the minimal changes to get the
> > > > > >SMBIOS table done correctly for memory above 4G, via EFI, and then start
> > > > > >the next steps?"
> > > > > >
> > > > > >I am OK to do an EFI hack for ARM so long as we agree that after the
> > > > > >release we will revert it and generate the table using generic memory
> > > > > >allocation, not dependent on EFI. Does that sound reasonable?
> > > > > >
> > > > > >I don't seem to have received any response from Heinrich to the
> > > > > >various points I made above. I cannot see any response on patchwork
> > > > > >either.
> > > > > >
> > > > > >Regards,
> > > > > >Simon
> > > > >
> > > > > All memory below the stack is controlled by the EFI subsystem. I notified you of the function you need to call. I can't see what information you are lacking.
> > > >
> > > > That is fine when EFI is used, but what about when it is not? That is
> > > > the piece I don't yet understand.
> > >
> > > We also don't have the use case for when EFI is not used defined and
> > > understood, so it can wait until then?
> >
> > There is/was an argument going on where (for ARM) the SMBIOS table
> > requires ACPI and EFI. So I am nervous about anything like that. EFI
> > has become a huge impediment to booting with open source components.
> > If there has been an agreement on how ARM can boot without EFI (but
> > still provide SMBIOS), please can someone link to it?
>
> I think you're missing things right now.  Are you sure you need ACPI for
> SMBIOS on 64bit ARM platforms to be seen and used? That's not what was
> hearing just yesterday but I don't have something I can double check
> that on real quick. What is unclear is that ARM and SMBIOS without EFI
> is something that's usable today as I suspect that nothing says where
> the SMBIOS table will be found, as there's not some legacy case like x86
> of a known hard-coded location.

OK, I'm not sure about that. But we cannot tie SMBIOS to EFI...it is a
table that is produced on startup, just like any other.

BTW at some point we should refactor table generation to use a context
struct, a bit like how ACPI is implemented.

>
> > The fact is that U-Boot makes lots of allocations while it runs. None
> > of them go through the EFI allocator, so far as I know. Certainly they
> > shouldn't. Then at the end, EFI just adds allocations for them
> > retrospectively. What change that?
>
> It depends on what allocations you're talking about? If you want to
> allocate something that will be preserved and untouched and passed along
> to the kernel then yes, you're either doing what EFI does or you're
> doing whatever else we do for special cases like initrd/dtb. Saying "and
> smbios too" means that yes, it's either EFI (because that will in turn
> do what needs to be done so the OS knows it exists and where it exists)
> or it's a special case EFI isn't involved and however the OS knows to
> not trample it is how it's not trampled.

As I said above, I know there is an argument going on in the kernel
about how to pass this info without SMBIOS. I don't want to get into
that.

It is simple to me...we need to allocate memory for an SMBIOS table
before U-Boot reaches the cmdline. EFI may or may not be used to
boot...we cannot know that until we actually boot. At that point we
can 'carve out' the memory for the table in EFI's allocations, just
like we do for ACPI and FDT and everything else in
add_u_boot_and_runtime() etc.

>
> > EFI is not in control of memory allocation in U-Boot. In fact, the
> > efi_memory_init() call should probably be dropped, just done when
> > bootefi starts. It seems to be creating a lot of confusion.
> >
> > My patch here does work, so far as I can tell. It adds an allocation
> > correctly, in the same manner as is done with ACPI - see
> > efi_acpi_register(). Given all the uncertainty I think we should
> > consider taking this patch as it is for now. I see it is marked as
> > 'changes requested' in patchwork so I have changed it to 'New', hoping
> > that it will get another look.
>
> The problem will then be that the table isn't preserved and used on ARM
> with EFI? What cases have you tested here with all of this.

This is the bug report of trying to boot into U-Boot on arm64 with
more than 3GB of memory.

I feel that too many discussions are muddied by EFI. Yes, the
implementation in U-Boot needs rework to integrate it better. But I am
a bit tired of 'what about the special case for EFI' comments.

Again, this patch fixes a bug and works fine with EFI booting and
without. If the upstream kernel people do something with [1] then it
will still work; we'll just need to add something to the FDT fixup.

Regards,
Simon

[1] https://lore.kernel.org/lkml/ZKgLKvBoWKSxzm6r@sunil-laptop/
